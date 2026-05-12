# Example 02 — Shipped product (PM mode walkthrough)

A worked example of running PM mode through 2 release cycles on a shipped product: **Mantle**, an open-source observability tool with ~150 features and 4 quarters of release history.

The example shows what HARVEST → SHAPE → BUILD → SHIP looks like in practice — including the 10% Delete Rule firing, a drift check catching identity drift, and a stabilization trigger auto-firing in cycle 2.

## The setup

Lead developer Sam has shipped Mantle v0.4 a week ago. They've been running cycles informally. They want to formalize. They run `/forge:init`.

```
$ /forge:init
✓ Detected: Go project, existing tests passing.
✓ Scaffolded: PM-mode templates (IDENTITY.md, features.json, releases.json,
                progress.md, architecture.md, contracts.md)
✓ Pre-filled IDENTITY.md WHO/JOB/NEVER from package.json + README [DRAFT]
✓ Pre-populated features.json with 12 features detected from CHANGELOG.md
✓ contract_mode: "lightweight"  (you have an OpenAPI spec; full mode optional)
   → Edit IDENTITY.md to confirm, then run /forge:harvest
```

## cycle 1 (v0.5) — first formal cycle

### IDENTITY.md (after Sam edits)

```markdown
## Primary Persona

WHO: SRE / platform engineer at a 50–500-engineer company, on-call for 1+
     production service, currently uses Datadog or Honeycomb for one
     domain and cobbled-together Prometheus + Grafana for the rest.

JOB: When I'm investigating a multi-service incident, I want to query
     traces, metrics, and logs through one query layer with shared labels
     — so I'm not Slack-switching between three tools at 3am.

NEVER: SaaS-only. Per-MAU pricing. Hide raw OpenTelemetry data behind a
       proprietary schema.

## Architecture Constraints
- OpenTelemetry semantic conventions only (never proprietary schemas)
- All storage backends pluggable via the Engine interface
- Query layer must work without internet (air-gapped deployments)
```

### /forge:harvest

Sam shares signals from the last 3 weeks. The orchestrator structures them and auto-mines git log + issues:

```
## HARVEST — current_cycle (v0.5) signals

| ID | Type | Strength | thesis_impact | Title |
|---|---|---|---|---|
| SIG-031 | user_pain | HIGH | confirms | "Slack-switching at 3am" — 8 GH issues mention this exact pain pattern |
| SIG-032 | feature_request | HIGH | confirms | OpenTelemetry log correlation in query layer |
| SIG-033 | competitive | MEDIUM | confirms | Honeycomb shipped multi-tenant pricing teardown last week |
| SIG-034 | usage_pattern | MEDIUM | challenges | 60% of installs never enable trace export → are tracers actually wanted? |
| SIG-035 | tech_debt | HIGH | null | Engine interface inconsistencies between Pg and ClickHouse backends |
| SIG-036 | rework | LOW | null | The query parser was rewritten in v0.4; v0.3-style queries broken |
```

SIG-034 is challenging the thesis (people install but don't trace). Sam acknowledges; flags for SHAPE.

### /forge:shape — the hero card

```
═════════════════════════════════════════════════════
  CYCLE — Release Plan v0.5
  Thesis: "Make multi-source incident investigation actually one-tool."
═════════════════════════════════════════════════════

  FEATURES (5)                            AUTONOMY    SIGNAL
  ───────────────────────────────────────────────────────
  ✓ otel-log-correlation-in-query          T2          SIG-032
  ✓ unified-trace-metric-log-query-syntax  T2          SIG-031
  ⚠ trace-onboarding-wizard                T2          SIG-034
  ✓ honeycomb-pricing-teardown-comparison  T1          SIG-033
  ✓ engine-interface-consistency-debt      T1          SIG-035

  DEBT PAYDOWN (~15%)
  ───────────────────────────────────────────────────────
  ✓ engine-interface-consistency-debt
  ✓ query-parser-v03-back-compat            (rework cleanup)

  KILL LIST (10% Delete Rule fired ✗)
  ───────────────────────────────────────────────────────
  ✗ legacy-prom-remote-write-shim          stale, no signal in 6 mo
  ✗ web-ui-dashboard-builder               post_mvp_status=evaluate, low usage
  ✗ slack-bot-integration                  one customer, no growth

  DEVIL'S ADVOCATE
  ───────────────────────────────────────────────────────
  ⚠ Cope Moat: "OpenTelemetry-native" — Honeycomb is too. Differentiate?
  ⚠ Timeline Cope: trace-onboarding-wizard is 2 weeks of work disguised as 1
  ✓ Cherry-Picking: clean — SIG-034 (challenging) included

  Run `/forge:build` to start. `/forge:falsify` to attack the plan harder.
═════════════════════════════════════════════════════
```

Sam approves with one modification: bumps `trace-onboarding-wizard` to T3 because of the timeline-cope flag.

### /forge:build — Ralph Loop

Sam runs `/forge:build`. Over the next 4 days the agent ships features sequentially. Highlights:

- **Feature 1 (engine-interface-consistency-debt, T1):** done in 1 build, quality_score 9.
- **Feature 3 (trace-onboarding-wizard, T3):** 2 resets, then SHAPE was right — splits into 2 sub-features, one ships, one moves to next cycle. quality_score 7.
- **After 5 features:** drift check fires automatically.

### Drift check (after 5 features in v0.5)

```
## Drift Report — 2026-04-15

| Feature | WHO? | JOB? | NEVER? | Architecture? | Contracts? | Rework? | Q | Verdict |
| otel-log-correlation     | Y | Y | Y | Y | Y | N | 9 | CLEAR |
| unified-query-syntax      | Y | Y | Y | Y | Y | N | 8 | CLEAR |
| trace-onboarding-wizard   | Y | Y | Y | Y | Y | N | 7 | CLEAR |
| honeycomb-comparison      | N | Y | Y | Y | Y | N | 8 | DRIFT (marketing piece, doesn't serve WHO) |
| engine-interface-debt     | Y | Y | Y | Y | Y | N | 9 | CLEAR |

Stabilization indicators: avg quality 8.2, 0 REWORK, avg resets 0.4 → OK
Recommendation: DISCUSS — `honeycomb-comparison` doesn't serve WHO directly.

Rationale: it's a sales asset, not a product feature. Worth doing, but
log it as `type: "infrastructure"` not `type: "feature"` next time.
```

Sam acknowledges. Continues the cycle.

### /forge:ship (v0.5)

```
## Release Report: v0.5 — "Multi-source incidents"

Features shipped: 4    blocked: 0    rework: 0
Avg quality_score: 8.2
Identity changes: none
Breaking changes: 1 — query syntax extended (additive, no migration needed)

Stabilization triggers: ALL CLEAR
Top 3 learnings:
1. OTel log correlation is the most-requested missing piece — SIG-032 is reproducible
2. The trace onboarding gap (SIG-034) is real — 60% non-adoption confirmed
3. Drift detector caught a "feature" that was actually marketing — useful classification

Open questions for next cycle:
- Why don't users enable tracing? (SIG-034 deserves dedicated investigation)
- Honeycomb's pricing teardown — does Mantle have a positioning answer?
```

## cycle 2 (v0.6) — stabilization triggers fire

In cycle 2, Sam tries to ship 7 features in 3 weeks. By feature 6, quality is degrading:

- 2 REWORK flags (the v0.5 query syntax broke a use case)
- 1 BLOCKED feature (a backend storage migration ran into Postgres deadlocks)
- avg quality_score: 5.8

The drift detector fires **STABILIZE** mid-cycle. The orchestrator pauses BUILD and surfaces the recommendation.

Sam runs `/forge:shape` to formalize the stabilization release.

```
═════════════════════════════════════════════════════
  STABILIZATION RECOMMENDED
  Triggers fired: avg_quality=5.8, REWORK rate=29%
  Last 5 features: 2 REWORK flags
═════════════════════════════════════════════════════

  Thesis: "Pay down v0.5 + v0.6 rework before adding new surface."

  FEATURES (0 new)
  DEBT PAYDOWN (100%)
  ───────────────────────────────────────────────────────
  ✓ query-syntax-back-compat-fix             T2          REWORK from v0.5
  ✓ pg-storage-deadlock-fix                  T3          BLOCKED in v0.6
  ✓ engine-interface-test-coverage           T1          1 reset → uncertainty
  ✓ trace-export-error-messages              T1          SIG-034 partial fix

  KILL LIST (10% required → 25% proposed)
  ───────────────────────────────────────────────────────
  ✗ webhook-export                           never used, kept "in case"
  ✗ json-output-mode-v1                      v2 supersedes; v1 has no users
```

The stabilization release ships in 8 days. v0.7 (the next normal release) ships at avg quality 8.4 — recovered.

---

**The lesson:** stabilization isn't a punishment. It's a circuit breaker. The next normal release after stabilization usually has the highest velocity of any release in the cycle.

Sam's `progress.md` now has Active Gotchas like:
- "Postgres serializable transactions deadlock under specific concurrent load (see v0.6 blocker)"
- "Query syntax v2 needs full back-compat tests before extending"

These will save weeks across the next 4 releases.
