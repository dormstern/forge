---
name: stabilization
description: Use during PM mode SHAPE or SHIP. Auto-detects when a release should be a stabilization release (all debt + rework, zero new features) — fires when rework_rate > 15%, blocked features ≥ 3, avg builder resets > 2, or avg quality_score < 6.0 across last 5 features. Caught early, stabilization saves a quarter; missed, it costs an eternal "we should refactor" backlog.
---

# Stabilization Triggers

Stabilization is the framework's circuit breaker. When build quality slips below the threshold, you stop adding new features and pay down the rework + debt that's accumulated. **One bad release is fine. Two without intervention is a pattern. Three without stabilization is a maintenance crisis.**

## The four triggers

Each is computed at SHAPE time across the last release (or last 5 features if mid-cycle):

| Trigger | Threshold | Why it matters |
|---|---|---|
| **Rework rate** | > 15% | Code shipped recently is being modified — the spec was wrong |
| **Blocked features** | ≥ 3 | Architecture is unclear or features are oversized |
| **Avg builder resets** | > 2.0 per feature | Tests are too tight or domain is unclear |
| **Avg quality_score** | < 6.0 across last 5 | Systemic quality degradation |

If **ANY** trigger fires, the orchestrator recommends a stabilization release in SHAPE.

## What a stabilization release looks like

```
- Thesis: "Pay down the rework + debt accumulated in v{X}."
- Features: 0 new
- Debt items: every TECH_DEBT flag from the last 2 releases
- Rework: every REWORK flag, with proper fixes
- Removals: anything from the kill list that hasn't shipped
- Identity: no changes
- Drift: full audit at the end
```

Stabilization releases are short — typically half the duration of a normal release. They're not glamorous. Nobody tweets about a stabilization release. **They're load-bearing.**

## Why each trigger matters

### Rework rate > 15%

If 3 of 20 features in the last release modified code that just shipped, you're shipping the wrong thing. Possible causes:
- Specs were unclear → test-writer wrote tests that allowed wrong behavior to pass
- Architecture was misunderstood → builder placed code in the wrong module
- IDENTITY drifted → the feature didn't actually serve WHO/JOB
- Contracts were violated → the breaking change is rippling

Stabilization gives you space to find the upstream cause without shipping more rework.

### Blocked features ≥ 3

Three blockages in one release is the pattern. Possible causes:
- Features are too big (split them next time)
- Architecture has gaps the agent can't navigate
- Tests are testing the wrong thing
- Dependencies are unstable

Stabilization either fixes the blockers or kills the features.

### Avg builder resets > 2.0

Two resets per feature on average means the builder is hitting walls every time. Possible causes:
- Tests are over-specified (testing implementation, not behavior)
- The feature spec is internally inconsistent
- Architecture is hostile to the feature's natural shape

Stabilization is the right time to refactor the test scaffolding.

### Avg quality_score < 6.0

Quality is degrading. Each feature is shipping with REWORK / BREAKING_CHANGE / TECH_DEBT flags. The product is accumulating drag.

Stabilization is the only honest path. New features will multiply the drag.

## How the orchestrator surfaces it

When SHAPE detects a trigger, the [shape command](../../commands/shape.md) prepends a banner:

```
═════════════════════════════════════════════════════
  STABILIZATION RECOMMENDED
  Triggers fired: rework_rate=18%, avg_quality=5.4
  Last 5 features: avg quality 5.4, 2 REWORK flags
═════════════════════════════════════════════════════
```

The proposed release plan is then a stabilization plan: zero new features, all debt + rework + removals.

## When to override the recommendation

Rarely. The triggers are calibrated against real shipping data — they're not paranoid. But two valid overrides:

1. **The rework was deliberate.** You shipped a v0.5 of a feature knowing you'd iterate. The quality_score reflects intentional debt. In that case, mark the rework features with `rework_intent: "iteration"` and the orchestrator excludes them from the rate calculation.

2. **The blocked features have already been killed.** If 3 blocked features became 3 kill-list items in this SHAPE, the underlying problem is resolved. Continue with new features.

Anything else — override at your peril. The framework is asking you to slow down for a reason.

## What stabilization buys you

- Quality_score recovers to ≥ 7 within 1–2 stabilization releases (empirically)
- Rework rate drops to < 5%
- Builder resets average ~ 1
- Blocked features → 0

The next "normal" release after stabilization typically has the highest velocity of any release in the cycle. Stabilization is an investment, not a tax.

## Why this is rare

Most teams don't have stabilization triggers because they don't have quality_scores. They feel the drag, complain about it in retros, and then ship more features hoping the next sprint will be different. Stabilization triggers exist to make the decision *automatic* — when the metric crosses the threshold, the framework recommends. The human can override. The cost of "skipping the trigger because we're in a hurry" is what kills most products' velocity over time.
