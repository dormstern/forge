---
name: drift-protection
description: Use during PM mode BUILD or whenever the user asks "is this still on-strategy". Auto-fires every 5 completed features. Audits the last 5 against IDENTITY.md (WHO/JOB/NEVER), Architecture Constraints, contracts (if applicable), and rework patterns. Returns CONTINUE / DISCUSS / PIVOT / CONTRACT_HALT and flags STABILIZE if quality is degrading.
---

# Drift Protection

Drift checks are the single most-distinctive primitive in PM mode. They're the reason the framework can run forever without slowly building the wrong product.

## Cadence

- **Auto:** every 5 completed features during `/forge:build`. The orchestrator dispatches the [drift-detector](../../agents/drift-detector.md) agent automatically.
- **Manual:** `/forge:drift` any time — after a refactor, before a release, after an identity update.

## The 6 checks (per feature, last 5 done)

| # | Check | What's being audited |
|---|---|---|
| 1 | Serves WHO? | Does this improve life for the IDENTITY.md persona? |
| 2 | Serves JOB? | Does this make the JOB easier or remove a step? |
| 3 | Violates NEVER? | Does any aspect of this do something the NEVER list forbids? |
| 4 | Respects Architecture Constraints? | Right module, existing patterns, no unnecessary cross-module coupling? |
| 5 | Respects contracts? | (if `contract_mode != "none"`) API shape preserved, schema additive, events versioned? |
| 6 | Is this rework? | Did it modify recently-shipped code? Pattern across multiple features? |

Each check is a verdict: **YES / NO / DRIFT.**

## Verdict ladder

| Verdict | Meaning |
|---|---|
| **CLEAR** | All 6 checks YES across all 5 features |
| **DRIFT** | One feature violates WHO/JOB/NEVER/architecture |
| **CONTRACT_VIOLATION** | Breaks a published contract without an approved migration path |
| **ARCHITECTURE_DEGRADATION** | Adds complexity to hot paths or crosses module boundaries unnecessarily |
| **REWORK_PATTERN** | 2+ rework flags across last 5 features |

## Recommendation matrix

| Recommendation | Trigger |
|---|---|
| **CONTINUE** | All clear, no stabilization indicators |
| **DISCUSS** | One DRIFT, surface to user, no halt |
| **PIVOT** | Pattern of DRIFT — identity may need to evolve |
| **CONTRACT_HALT** | CONTRACT_VIOLATION — halt the release until resolved |
| **STABILIZE** | Stabilization indicators firing — next SHAPE should be a stabilization release |

## Stabilization indicators

Separate from drift verdicts. Flag STABILIZE if any:

- Avg `quality_score` of last 5 features < 6.0
- 2+ REWORK flags in last 5 features
- Avg `build_resets` > 2.0
- 2+ ARCHITECTURE_DEGRADATION findings in last 5 features

## What CONTRACT_HALT means

Hardest blocker in the framework. Stronger than DRIFT. **The release stops.** No new features ship until either:
- The breaking change is rolled back, OR
- The breaking change is explicitly approved with a migration path documented in `contracts.md`.

This is why `contract_mode: "full"` is opt-in — it's expensive but it's also why you can ship 50 releases without breaking your customers.

## What PIVOT means

The drift report is telling you: your IDENTITY.md doesn't match the product you're actually building. Two valid responses:

1. **Update IDENTITY.md** — your understanding of WHO/JOB/NEVER has evolved (good — this is identity-as-signal). Append an Evolution Log entry with the trigger evidence.
2. **Roll back the drifting features** — your IDENTITY.md is correct; you accidentally built off-strategy. Kill the drift in the next SHAPE.

Don't do both. Don't do neither.

## How drift reports get persisted

Every report appends to `progress.md` under "Recent Drift Reports":

```markdown
### YYYY-MM-DD — {recommendation}
- Per-feature audit table
- Stabilization indicators
- Findings
- Rationale
```

Past reports are read on every future drift check. The framework learns from its own audit history.

## Common drift patterns

These are the patterns that show up repeatedly across products. Watch for them:

- **Feature creep into adjacent personas.** WHO is "SOC analyst" but the last 3 features serve "CISO directly." Either evolve WHO to dual-persona, or kill the CISO features.
- **NEVER violations on the way to a sale.** A buyer asks for X, X violates NEVER, you ship X anyway. The drift report catches it. The right move is to lose the deal or evolve the NEVER deliberately.
- **Architecture-creep through "small" features.** Each one looks fine in isolation; together they've created a 4-module entanglement that isn't in `architecture.md`. The drift detector flags ARCHITECTURE_DEGRADATION.
- **Slow rework drift.** No single feature is rework, but you've modified the executor 3 times in 5 features. REWORK_PATTERN fires. Something upstream is unclear — usually a missing contract or a feature spec that didn't survive contact with reality.

## Why every-5-features

Per-feature drift checks are noise — too sensitive, lots of false positives. Per-release drift checks are too coarse — drift gets baked in by the time you check. Every 5 is the empirically-right cadence: enough features to see a pattern, few enough to catch drift before it ships.
