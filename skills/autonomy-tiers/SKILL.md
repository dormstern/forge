---
name: autonomy-tiers
description: Use when assigning T1/T2/T3 to a feature in PM mode SHAPE, or when the user asks "should this be auto-commit or checkpoint". T1 = fully autonomous (auto-commit). T2 = checkpoint before commit. T3 = checkpoint before tests AND commit. The decision tree maps risk to tier — clear intent + no contract impact → T1; touches API or hot path → T2; identity-adjacent or contract-breaking → T3.
---

# Autonomy Tiers (T1 / T2 / T3)

Autonomy tiers control where humans checkpoint during BUILD. Every feature gets a tier in SHAPE. The tier shapes the build's pause behavior.

## The three tiers

| Tier | Test phase | Build phase | Commit phase |
|---|---|---|---|
| **T1** | Auto | Auto | Auto-commit |
| **T2** | Auto | Auto | **Checkpoint before commit** |
| **T3** | **Checkpoint** | **Checkpoint** | **Checkpoint before commit** |

Where "checkpoint" means: the agent stops and surfaces what it's about to do; the human approves before it proceeds.

## Decision tree

For every feature in SHAPE, ask in order:

1. **Does this feature touch IDENTITY.md (WHO/JOB/NEVER) or Architecture Constraints?** → T3
2. **Could this feature break a published contract (API/schema/event)?** → T3
3. **Does this feature touch a hot path or modify recently-shipped code?** → T2
4. **Does this feature have unclear intent or weak test coverage in the affected module?** → T2
5. **Otherwise** → T1

## What T1 looks like in practice

You start `/forge:build`, the orchestrator dispatches test-writer + builder, the loop runs to green, autonomous commit. You see a `--- CONTEXT BOUNDARY -- starting feature: {id} ---` line, then later a "feature done, quality_score 9" summary. No interruption.

T1 is for: utility refactors, simple CRUD additions, adding optional fields, internal tooling, debt with clear scope.

## What T2 looks like

The build runs autonomously through tests + implementation, but **stops before commit.** The agent shows you the diff and says: "All tests pass. Approve to commit?" You inspect, then `y` or fix-then-commit.

T2 is the default for most features. It's the cheapest way to keep humans in the loop without bottlenecking on every change.

## What T3 looks like

The build pauses before *writing* tests and *running* the build. You're approving the test plan before code exists, then the implementation diff before commit. Two checkpoints per feature.

T3 is for: identity changes (rare), contract-breaking changes, hot-path modifications, security-sensitive code, anything where "looks right" isn't enough.

## Tier-by-feature-type defaults

| Feature type | Default tier | Reason |
|---|---|---|
| `feature` (clear intent, no contract impact) | T1 | Cheap to auto |
| `feature` (touches API/schema/hot path) | T2 | Catch contract drift before commit |
| `debt` | T1 | Behavior-preserving by definition |
| `removal` | T2 | Humans want to verify what's disappearing |
| `infrastructure` | T1 | Foundations rarely have ambiguity |
| Anything that modifies IDENTITY.md | T3 | Identity changes are rare and expensive |
| Anything explicitly flagged BREAKING_CHANGE | T3 | Migration path needs human approval |

## Why three tiers and not two

Two tiers (autonomous vs checkpoint) collapses two different risks into one signal:

- "Did the agent understand the intent?" — caught at the *test* checkpoint
- "Is the implementation safe to commit?" — caught at the *commit* checkpoint

T2 is the right default because most features have clear intent (skip the test checkpoint) but benefit from a final diff review (keep the commit checkpoint). T3 is for the rare features where you want both.

## Operator UX in Claude Code

When a T2/T3 feature reaches its checkpoint, the orchestrator pauses and prints the decision context. In Claude Code, you respond with:

- "approve" / "y" → continue
- "reject" / "n" → roll back, mark blocked
- Free-form feedback → the orchestrator routes it to the relevant agent (test-writer or builder) for revision

## Common mistakes

- **Defaulting everything to T1 because the agent seems competent.** You'll regret it the first time the agent ships a BREAKING_CHANGE you didn't catch in CI.
- **Defaulting everything to T3 because you're nervous.** The whole point of the tiers is to keep humans out of the loop where they don't add value. Over-checkpointing means humans become the bottleneck.
- **Tiering by personal preference, not feature risk.** T1/T2/T3 isn't about how confident *you* are — it's about whether the *feature* is risky. A simple debt item should be T1 even if you'd personally enjoy the checkpoint.
