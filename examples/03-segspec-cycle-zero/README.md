# Example 03 — segspec, cycle zero

A real example. [segspec](https://github.com/dormstern/segspec) is a Go CLI that extracts network dependencies from app configs and emits Kubernetes NetworkPolicies. It was built by the author of Forge using the same framework, before Forge existed as a public plugin.

This example reconstructs cycle zero — the first PM cycle that turned a single weekend prototype into a shipped tool that's now in 5 awesome-lists.

## State at start of cycle 1

Sole developer. Weekend prototype works. ~600 lines of Go. No tests. The CLI prints dependency tables for Spring Boot apps. No NetworkPolicy generation yet. README is one paragraph.

`/forge:init`:

```
✓ Detected: Go project, no tests, no CHANGELOG
✓ Scaffolded: PM-mode templates
✓ contract_mode: "none" (no public API yet — single CLI binary)
```

## IDENTITY.md (cycle 1)

```markdown
## Primary Persona

WHO: Platform / security engineer at a company adopting zero-trust
     networking on Kubernetes. Owns the migration from "default open"
     to "default deny" but can't write 50 NetworkPolicies by hand
     across 70 services without making mistakes.

JOB: When I'm rolling out NetworkPolicies, I want to extract every
     network dependency from existing app configs (Spring, Docker
     Compose, K8s manifests, Helm) — with each dependency traced to
     the config line that justified it — so I can generate policies
     I can defend in code review.

NEVER: Become an "AI guesses your dependencies" product (deterministic
       static analysis only). Require runtime instrumentation. Vendor
       lock-in via proprietary schemas.

## Architecture Constraints
- Static analysis only — no runtime, no agents, no observation period
- Every dependency must trace to a verifiable source line
- Single static Go binary (no dependencies, no install ceremony)
- Output formats are interoperable (YAML, JSON) — no proprietary schema
```

The NEVER list ended up being load-bearing — every drift check used it to reject features that started leaning toward "AI heuristics" or "agent-based collection."

## /forge:harvest (cycle 1)

```
SIG-001 (user_pain, HIGH, confirms): r/kubernetes thread "I've spent 3
weeks writing NetworkPolicies by hand." 200+ upvotes. *Verbatim:* "There
should be a tool that just reads my Helm charts and outputs the policy."

SIG-002 (competitive, MEDIUM, null): tools like Calico's policy-recommender
exist but require runtime data collection (~7 day observation period).

SIG-003 (feature_request, HIGH, confirms): Sentry's self-hosted has 70+
services and is a known proxy for "real-world complexity." If a tool
works there, it'll work everywhere. Make this the demo.
```

## /forge:shape — release plan (v0.1)

```
═════════════════════════════════════════════════════
  CYCLE — Release Plan v0.1 — "First useful version"
  Thesis: "Static analysis + provenance, run on Sentry self-hosted."
═════════════════════════════════════════════════════

  FEATURES (4)                            AUTONOMY    SIGNAL
  ───────────────────────────────────────────────────────
  ✓ docker-compose-parser                  T1          SIG-001
  ✓ kubernetes-manifest-parser             T1          SIG-001
  ✓ networkpolicy-yaml-renderer            T2          SIG-001
  ⚠ evidence-format (per-line provenance)  T2          SIG-001 (the wedge)

  DEBT PAYDOWN (~15%)
  ───────────────────────────────────────────────────────
  ✓ tests-for-spring-parser-v0             (zero tests existed)

  KILL LIST (10% Delete Rule fired ✗)
  ───────────────────────────────────────────────────────
  ✗ ai-suggestion-mode                     violates NEVER
  ✗ runtime-collection-helper              violates NEVER

  DEVIL'S ADVOCATE
  ───────────────────────────────────────────────────────
  ⚠ Cope Moat: "static analysis" — what stops Calico shipping this?
       Counter: provenance is the wedge. Calico's recommender tells you
       WHAT to allow; segspec tells you WHY.
  ⚠ Timeline Cope: parsing Helm correctly is 2 weeks, not 3 days.
       Defer Helm to v0.2.
  ✓ Cherry-Picking: clean — SIG-002 (competitor) included
```

Helm got deferred. Provenance ("evidence format") was promoted to the wedge.

## /forge:build (v0.1)

The Ralph Loop ran for 6 days. Highlights:

- **docker-compose-parser** — T1, done in 1 build, quality 9.
- **kubernetes-manifest-parser** — T1, done in 2 builds (one reset for `services[].metadata.namespace` edge case), quality 8.
- **networkpolicy-yaml-renderer** — T2, done with checkpoint review on the YAML output schema, quality 9.
- **evidence-format** — T2, this was the load-bearing feature. The format ended up as a `<details>`-collapsible markdown table with per-dependency source lines. quality 9.

The drift detector ran after feature 4 and was CLEAR.

## /forge:ship (v0.1)

```
## Release Report: v0.1 — "First useful version"

Features shipped: 4    Quality avg: 8.75    Rework: 0    Blocked: 0

Identity changes: none
Breaking changes: none (no prior version)

Top learnings:
1. Provenance is the wedge. Without it, segspec is just another parser.
2. Sentry's self-hosted as the demo target was correct — 411 deps in 11ms
   became the README hook.
3. Two NEVER violations on the kill list (ai-suggestion + runtime-collection)
   surfaced early. The framework caught them; would have shipped both
   without it.

Open questions:
- How to handle Helm? (deferred from v0.1)
- What's the diff/CI story? (signals from cycle 1 hint at it)
```

## What happened next

Forges 2 and 3 added Helm parsing, the diff command, and CI integration patterns. v0.3 made it into 5 awesome-lists and a Show HN.

The framework's contribution wasn't speed — it was **discipline**: the NEVER list rejected features that would have made segspec generic; the 10% Delete Rule killed two of them before they shipped; provenance was promoted to the wedge during SHAPE because of a Devil's Advocate flag.

A v0 prototype became a shipped tool with traction in 8 weeks of part-time work.

---

**cycle artifacts in this directory** (representative snapshots — for the actual repo state, see [github.com/dormstern/segspec](https://github.com/dormstern/segspec)):

- `IDENTITY.md` — the WHO/JOB/NEVER above
- `features.json` — 4 features from v0.1 + 12 cumulative across v0.2/v0.3
- `releases.json` — release history, signals, contract_mode: "none"
- `progress.md` — Cross-Cutting Patterns ("provenance is the wedge"), Active Gotchas (Helm chart-of-charts edge case)
- `architecture.md` — module structure, hot paths
