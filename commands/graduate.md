---
description: Founder mode — check graduation against 12 criteria. If ready, hand off THESIS.md to PM-mode IDENTITY.md (WHO/JOB/NEVER), seed initial features and signals, write the Graduation Brief.
---

# /forge:graduate — Founder → PM handoff

> **Execution mode: direct.** This command has explicit steps below — execute them in order. Do not enter plan mode, do not write a plan file, do not call ExitPlanMode. The framework already did the planning; you just run the steps.


You evaluate readiness to leave Founder mode and start shipping.

## Behavior

### Step 1 — Check the 12 graduation criteria

ALL twelve must be met. 11/12 = NOT READY. No partial graduation.

```
[ ] Problem confidence ≥ 4
[ ] Pricing confidence ≥ 4
[ ] Purpose confidence ≥ 3
[ ] Market confidence ≥ 3
[ ] Wedge confidence ≥ 3
[ ] Competition confidence ≥ 3
[ ] Defensibility confidence ≥ 3
[ ] No invalidated P1 hypotheses
[ ] Devil's Advocate: no existential risks (incl. moat stress test)
[ ] ≥12 interviews across ≥3 segments (no segment > 40%)
[ ] ≥3 real commitments obtained
[ ] Confidence trajectory: stable or increasing over last 2 cycles
```

If any are unmet, tell the user which and stop. Recommend the smallest possible next cycle to close the gap.

### Step 2 — Generate the four handoff artifacts

If all 12 are met:

1. **Draft `IDENTITY.md`** with explicit reasoning:
   - **WHO** ← from `THESIS.md` Problem section (specific persona)
   - **JOB** ← in JTBD form: "When [trigger], I want [action], so that [outcome]."
   - **NEVER** ← derived from Competition + Wedge + Defensibility. Run the founder-NEVER question:
     > "Review your Competition section. What is the one thing that, if you compromised on it, would make you identical to the competitors you identified? That is your NEVER."

2. **Initial signals.** Convert validated hypotheses → seed entries in PM-mode `releases.json` `current_cycle.signals` (each with `thesis_impact: "confirms"`).

3. **Feature priority seeds.** Highest-confidence, highest-pain hypotheses → first features in `features.json`. Pre-fill `signal_id` and `requested_by` (the interview ID + segment).

4. **Graduation Brief.** A short markdown doc (`GRADUATION_BRIEF.md`) covering:
   - Top 3 risks (from DA findings)
   - Open questions (from `progress.md`)
   - Pricing signals (specific WTP data)
   - Competitive moat (the NEVER's evidence)
   - DA findings that should seed future drift checks

### Step 3 — Confirm with user

PAUSE. Show the four artifacts. The user reviews, edits, and commits before switching modes.

After confirmation: PM-mode templates are scaffolded (or augmented if some already exist). Founder-mode state files stay in place as historical record.

## After graduation

- Run `/forge:init` (PM mode) if `IDENTITY.md` doesn't exist yet.
- Run `/forge:harvest` to start the first PM cycle.

## Reference

- Skill: [skills/identity-anchor/SKILL.md](../skills/identity-anchor/SKILL.md)
- Agent: [agents/thesis-synthesizer.md](../agents/thesis-synthesizer.md) drafts the IDENTITY.md
