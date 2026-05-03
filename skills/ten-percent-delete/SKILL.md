---
name: ten-percent-delete
description: Use during PM mode SHAPE. Every release plan must propose killing ≥10% of in-flight scope as deletion candidates. Surfaces features with post_mvp_status="evaluate", low-usage signals, stale work, no-owner items. If nothing qualifies, state that explicitly with evidence — don't skip. The most-violated rule in the framework, and the one that produces the sharpest screenshots.
---

# The 10% Delete Rule

**Every SHAPE proposes killing at least 10% of the release scope.** Not optional. Not "if convenient." Not "if I can find anything."

## Why

Products accumulate features the way attics accumulate boxes. The longer you ship, the more drag your product carries — features nobody uses but everyone has to maintain, code paths nobody owns, edge cases that exist for one user from 2024.

The rule forces every release to interrogate product shape. If you can't find 10% to kill, **you're not looking hard enough or you've never been honest with the data.**

## What qualifies for the kill list

In order of how easy they are to spot:

1. **Features with `post_mvp_status: "evaluate"` and no growth in usage signals across 2 releases.** They've earned a verdict.
2. **Features with no `requested_by` owner.** Anonymous features are deletion candidates by default.
3. **Tech debt that's never going to be paid because the feature it underpins isn't valuable.** Kill the feature; the debt vanishes.
4. **Edge-case branches in code paths that haven't fired in production for 90 days.** If your audit log has 0 events for that path, it's dead code, not a feature.
5. **Settings/toggles nobody changes.** A toggle nobody flips is a hidden cost — cognitive load on every PR review.
6. **Features that contradict NEVER.** They shouldn't exist. Use the kill list to remove them.
7. **Features that lost the bake-off.** If you A/B tested and lost, kill the loser. Don't keep both.

## What doesn't qualify

- Features users like that you don't like.
- Features that *might* be useful "someday."
- Features blocked on external dependencies (those go in `progress.md` Open Questions, not kill list).
- Features that are technically working but feel ugly. (Ugly ≠ deletable.)

## How `/forge:shape` enforces it

When [/forge:shape](../../commands/shape.md) runs, the orchestrator:

1. Scans `features.json` for `post_mvp_status: "evaluate"` items, low-signal items, no-owner items, contract-violation items.
2. Cross-references against `releases.json` signals (low engagement / negative signals → stronger kill candidate).
3. Renders the kill list in the SHAPE hero card with reasons (≤6 words each).
4. Computes the kill ratio (kill list / total in-flight scope).
5. **If <10%, refuses to proceed** until the user either expands the list or explicitly states "no candidates qualify and here's the evidence."

The hero card has a dedicated `KILL LIST (10% Delete Rule fired ✗)` section every release. The ✗ is the screenshot — it's the moment people share.

## How removals get built

Items on the kill list become `type: "removal"` features in the next BUILD wave. They get tests:
- "removed feature is gone" (404, redirect, error — but not a crash)
- "adjacent features unaffected" (regression check)

Removals are typically T2 autonomy (checkpoint before commit) — humans like to confirm what's about to disappear.

## Common pushback (and the response)

> "But users like X."

Cite usage data, not anecdotes. If you can't, your "users like X" is a hallucination.

> "We promised X to a customer."

Look at the feature's `requested_by` and check whether that customer is still using it. If yes, talk to them about whether they actually want maintenance burden vs an alternative.

> "X is small, removal is more work than it's worth."

Maintenance is the work. Removal is the one-time cost that ends recurring cost. Run the math.

> "We can't predict what we'll need next quarter."

Right — which is why you keep the things you definitely need now and remove the rest. You can rebuild later if you're wrong. You probably won't.

## The unglamorous truth

The 10% Delete Rule is the most-violated rule in the framework. Operators skip it the third time their `/forge:shape` produces an empty kill list. **That's the failure mode.** The fix is to lower your bar for what qualifies — kill the toggle nobody flips. Kill the feature one customer asked for last year. Kill the experimental flag from the bake-off.

If you're not killing something every release, you're not running the framework. You're running a feature factory.
