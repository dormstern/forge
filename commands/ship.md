---
description: PM mode — close the release. Validate contracts, refresh architecture.md, log release in releases.json with metrics + quality scores, check stabilization triggers for next cycle, present release report.
---

# /forge:ship — Ship & measure (PM mode)

> **Execution mode: direct.** This command has explicit steps below — execute them in order. Do not enter plan mode, do not write a plan file, do not call ExitPlanMode. The framework already did the planning; you just run the steps.


You close out the current release cycle and prep the next one's signals.

## Pre-conditions

- All approved-plan features are `status="done"` or `status="blocked"`. If any are still `status="building"`, refuse and tell the user.

## Behavior

1. **Contract validation** (if `contract_mode != "none"`).
   - Review every Builder-flagged `BREAKING_CHANGE` from this release.
   - Unapproved breaking changes halt the release. Tell the user explicitly.
   - Approved ones get logged in `contracts.md` with migration path.

2. **Architecture auto-refresh.**
   - Update `architecture.md` with new modules, hot path changes, new endpoints, new dependencies.
   - This is incremental — only touch what changed.

3. **Log the release in `releases.json`.** Append to `releases[]`:
   ```
   {
     "version": "X.Y.Z",
     "name": "...",
     "thesis": "...",
     "shipped_features": [feature-ids],
     "metrics": {
       "features_shipped": N,
       "rework_rate": 0.0–1.0,
       "blocked_features": N,
       "avg_resets": float,
       "avg_quality_score": float
     },
     "identity_changes": [evolution log entries this cycle],
     "breaking_changes": [contract changes],
     "key_learnings": [from progress.md],
     "open_questions": [for next cycle]
   }
   ```

4. **Stabilization trigger check for next cycle.**
   - Rework rate > 15%? Blocked features ≥ 3? Avg resets > 2? Avg quality_score < 6.0?
   - If any trigger fires, surface it prominently. The next `/forge:shape` will recommend a stabilization release.

5. **PAUSE — Present the release report.**
   - Headline: version, thesis, features shipped, avg quality.
   - Quality trend (vs last 2 releases).
   - Identity changes (if any).
   - Breaking changes (if any).
   - Top 3 learnings.
   - Open questions for next cycle.
   - Stabilization recommendation (if triggered).

## After shipping

- The user runs `/forge:harvest` to start the next cycle.
- `current_cycle` in `releases.json` is reset to `phase: "HARVEST"`.

## Reference

- Skills: [skills/pm-mode/SKILL.md](../skills/pm-mode/SKILL.md), [skills/stabilization/SKILL.md](../skills/stabilization/SKILL.md)
