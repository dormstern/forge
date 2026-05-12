---
name: pm-mode
description: Use when shipping a product (post-PMF). Runs HARVEST → SHAPE → BUILD → SHIP cycles indefinitely. Each cycle harvests signals, proposes a release plan with kill-list (10% Delete Rule) and Devil's Advocate, runs the Ralph Loop with autonomy tiers (T1/T2/T3), audits drift every 5 features, ships, measures, recommends stabilization if quality slips.
---

# PM mode

You ship a living product through repeating release cycles. Each cycle has discipline — kill list, drift checks, autonomy tiers, stabilization triggers.

**Difference from Founder mode:** Founder mode is finite (3–5 cycles → graduate or kill). PM mode runs forever — every release ships, measures, harvests signals for the next.

## The cycle

```
HARVEST → SHAPE → BUILD → SHIP, then loop.
```

### HARVEST (15–30 min)
Collect raw signals from feedback, analytics, tickets, competitive observations. Auto-mine git log + open issues + recent PRs. Categorize each, assess `thesis_impact` (null / confirms / challenges / **invalidates**), refresh `architecture.md` incrementally.

**Pause:** review signal summary. Invalidations get prominent flagging.

### SHAPE (30–60 min) — the hero phase
Propose a release plan:
- **Thesis** (1 sentence)
- **Identity evolution** — only if signals warrant. Trigger + rationale + risk.
- **Features** — each with `signal_id`, `requested_by`, `intent`, `autonomy` (T1/T2/T3)
- **Debt paydown (~15%)**
- **Kill list (≥10%)** — the [10% Delete Rule](../ten-percent-delete/SKILL.md). Mandatory.
- **Contract implications** (if `contract_mode != "none"`)
- **Appetite** — what's NOT included
- **Stabilization check** — auto-fire on rework>15% / blocked≥3 / resets>2 / quality<6

[Devil's Advocate](../../agents/devils-advocate.md) auto-runs against the plan. Surfaces 2–3 attacks inline. The output is the [hero card](../../commands/shape.md) — screenshottable monospace render with ✓/⚠/✗ markers.

**Pause:** human approves, modifies, or kills the cycle.

### BUILD (async, hours)
[Feature breakdown](../../agents/feature-breakdown.md) decomposes the plan into a wave (additive — don't re-implement what's done). Then the [Ralph Loop](../../agents/orchestrator.md):

```
SELECT next feature → TEST (3–7 acceptance tests) → BUILD (fresh context, max 3 resets) → EVALUATE
```

[Autonomy tiers](../autonomy-tiers/SKILL.md) determine where humans checkpoint:

| Tier | Test | Build | Commit |
|---|---|---|---|
| T1 | Auto | Auto | Auto-commit |
| T2 | Auto | Auto | Checkpoint before commit |
| T3 | Checkpoint | Checkpoint | Checkpoint before commit |

Every 5 completed features → [drift check](../drift-protection/SKILL.md). DISCUSS / PIVOT / CONTRACT_HALT pauses the cycle.

**Pause** is per-feature for T2/T3 and per-5-features for drift checks.

### SHIP (15–30 min)
Contract validation (halt on unapproved BREAKING_CHANGE), architecture refresh, log release in `releases.json` with full metrics, [stabilization-trigger check](../stabilization/SKILL.md) for next cycle.

**Pause:** present release report. The next `/forge:harvest` starts the next cycle.

## State files (6)

| File | What |
|---|---|
| `IDENTITY.md` | WHO/JOB/NEVER + Architecture Constraints + Evolution Log |
| `features.json` | Cumulative feature backlog with `signal_id`, `requested_by`, `autonomy`, `quality_score`, `build_resets`, `rework_of` |
| `releases.json` | Release history + `current_cycle` (signals, phase, approved_plan) + `contract_mode` |
| `progress.md` | Cross-Cutting Patterns, Active Gotchas, Architecture Decisions, Recent Drift Reports, per-release feature learnings |
| `architecture.md` | Module hierarchy, hot paths, blind spots, API surface, integration points |
| `contracts.md` | Per-API/schema/event commitments, deprecation timelines (opt-in via `contract_mode`) |

## Quality score per feature

```
30%  Tests passed first build  (10 if first try, –2 per reset)
20%  No REWORK flag            (10 clean, 0 if rework)
20%  No BREAKING_CHANGE        (10 clean, 5 if flagged + approved)
15%  Contract compliance       (10 compliant, 0 violated)
15%  No TECH_DEBT flag         (10 clean, 5 if flagged)
```

Avg quality_score < 6.0 across last 5 features → recommend stabilization.

## Token efficiency

PM mode is a token-saving harness vs unguided agentic coding:

- **Fresh context per feature** — never carry context across boundaries
- **`architecture.md` as a 500-token map** vs forcing the agent to re-explore 50KLOC
- **State files re-read between phases (~3–5k tokens)** vs carrying full context forward
- **Drift checks catch rework before re-implementation** — the most expensive class of wasted tokens
- **All agents default to Opus 4.7 (1M context).** Users can downgrade specific high-volume agents (builder, test-writer, market-scout) to Sonnet by editing their frontmatter.

Target ceiling: ~60k tokens per feature build. Unguided agentic coding routinely runs 100k+.

## When to switch to Founder mode

If you start receiving signals with `thesis_impact: "invalidates"` and the drift detector starts recommending PIVOT — your IDENTITY.md may be wrong. Drop into Founder mode for one cycle, validate the new thesis, then return.
