---
description: PM mode — Ralph Loop. Select feature (wave-aware, deps met, debt-first), write 3–7 acceptance tests, build until green (max 3 resets, fresh context), commit per autonomy tier, calculate quality_score, append learnings. Drift check every 5 features.
---

# /forge:build — Ralph Loop (PM mode)

> **Execution mode: direct.** This command has explicit steps below — execute them in order. Do not enter plan mode, do not write a plan file, do not call ExitPlanMode. The framework already did the planning; you just run the steps.


You execute the SHAPE-approved plan, feature by feature. **Fresh context per feature — never carry context across feature boundaries.**

## Pre-conditions

- `releases.json.current_cycle.approved_plan` exists. If not, instruct the user to run `/forge:shape` first.
- Optional: `/forge:build <feature-id>` to build a specific feature. Default is wave-aware selection.

## Behavior

### Startup Protocol

1. Run the project's full test suite. Must be green. If not, fix the green-on-master invariant before building anything new.
2. Verify `architecture.md` is current (post-last-build).
3. Confirm clean working tree.
4. Read `progress.md` top sections (Cross-Cutting Patterns, Active Gotchas) for ~1k tokens of context.

### Ralph Loop (per feature)

1. **SELECT** the next feature: current wave first, all hard `depends_on` met, debt before dependent new features, removal features last in wave.
2. Mark `status="building"` in `features.json`. Print: `--- CONTEXT BOUNDARY -- starting feature: {id} ---`
3. **Dispatch test-writer** to produce 3–7 acceptance tests. For API features (if `contract_mode = "full"`), contract-compliance tests come first.
4. **Dispatch builder** with fresh context: only the test file, the relevant `architecture.md` section (~500 tokens), and `progress.md` top sections. Max 3 resets.
5. **EVALUATE:**
   - If tests pass: commit per autonomy tier (T1 auto, T2 checkpoint before commit, T3 checkpoint before tests AND before commit). Set `status="done"`. Calculate `quality_score` (rubric below). Append learnings to `progress.md`.
   - If failed after 3 resets: set `status="blocked"`, log the blocker, append learnings, continue with the next feature.
6. **Drift check every 5 features.** Dispatch drift-detector. If recommendation is DISCUSS / PIVOT / CONTRACT_HALT, **PAUSE and notify the user.** Do not advance.

### Quality score (per feature, 0–10)

- Tests passed on first build: 30% (10 if first try, –2 per reset)
- No REWORK flag: 20% (10 clean, 0 if rework)
- No BREAKING_CHANGE: 20% (10 clean, 5 if flagged + approved)
- Contract compliance: 15% (10 compliant, 0 violated)
- No TECH_DEBT flag: 15% (10 clean, 5 if flagged)

### Builder flag rules

The builder must flag any of:
- **REWORK** — modifying recently-shipped code
- **BREAKING_CHANGE** — contract violation
- **TECH_DEBT** — shortcut taken for shipping speed

## Pattern promotion

When a learning appears in 2+ feature entries → promote to `progress.md` "Cross-Cutting Patterns".
When a gotcha appears 2+ times → promote to "Active Gotchas".

## Reference

- Agents: [agents/feature-breakdown.md](../agents/feature-breakdown.md), [agents/test-writer.md](../agents/test-writer.md), [agents/builder.md](../agents/builder.md), [agents/drift-detector.md](../agents/drift-detector.md)
- Skills: [skills/autonomy-tiers/SKILL.md](../skills/autonomy-tiers/SKILL.md), [skills/drift-protection/SKILL.md](../skills/drift-protection/SKILL.md)
