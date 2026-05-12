---
description: PM mode — collect signals from feedback, analytics, tickets, competitive observations, and the codebase. Categorize each, assess thesis_impact, flag invalidations, refresh architecture.md incrementally.
---

# /forge:harvest — Signal harvest + architecture refresh (PM mode)

> **Execution mode: direct.** This command has explicit steps below — execute them in order. Do not enter plan mode, do not write a plan file, do not call ExitPlanMode. The framework already did the planning; you just run the steps.


You start a new release cycle by collecting raw signals and updating the codebase map.

## Behavior

1. **Read state.** `releases.json` (signals from last 2 releases for context), `features.json` (`tech_debt` items), `IDENTITY.md` (WHO/JOB/NEVER), `architecture.md`.

2. **Collect raw signals** from the user. Ask once:
   > "Drop me your raw signals — feedback, analytics, tickets, customer quotes, competitive moves, internal observations, anything from the last cycle. I'll structure them."

   Also auto-mine the project: recent commits (last 30), open issues (`gh issue list`), recent PR descriptions, README changes. These count as signals if they reveal pain or direction shifts.

3. **Structure each signal** into the `releases.json` `current_cycle.signals` array:
   - `id`: SIG-NNN
   - `category`: user_pain | feature_request | usage_pattern | production_health | tech_debt | competitive | rework
   - `title`, `source`, `quote` (verbatim), `date`
   - `impact`: 1-line estimate
   - `strength`: HIGH | MEDIUM | LOW
   - `thesis_impact`: null | confirms | challenges | invalidates
   - `requested_by`

4. **Flag invalidations prominently.** If any `thesis_impact = "invalidates"`, surface it at the top of the report. The user must decide whether to pivot the cycle.

5. **Refresh architecture.md incrementally.** Re-scan only changed modules (use `git diff` since last release tag). Don't regenerate from scratch.

6. **PAUSE — Present the signal summary.** Group by strength, then by category. Highlight invalidations and the top 3 highest-strength signals.

## Constraints

- Every signal must have `signal_id`, `source`, and `requested_by`. No phantom signals.
- Quote verbatim. Don't paraphrase.
- Phase announcement: print `--- PHASE: HARVEST ---` at start.

## Reference

- Skill: [skills/pm-mode/SKILL.md](../skills/pm-mode/SKILL.md)
- State: `releases.json`, `architecture.md`
