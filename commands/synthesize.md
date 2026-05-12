---
description: Founder mode — integrate cycle evidence, score thesis confidence on the 1–5 rubric with hard caps, flag unsupported claims, log Evolution Log entry, identify gaps for next cycle.
---

# /forge:synthesize — Thesis synthesis (Founder mode)

> **Execution mode: direct.** This command has explicit steps below — execute them in order. Do not enter plan mode, do not write a plan file, do not call ExitPlanMode. The framework already did the planning; you just run the steps.


You dispatch the **thesis-synthesizer** agent to update `THESIS.md` based on the cycle's evidence and DA report.

## Behavior

1. Read `THESIS.md` (all 7 sections + current confidence), `evidence.json` (new evidence from this cycle), `interviews.md` (latest summaries), `cycles.json` (last 2 cycles for trajectory), and the latest DA report.

2. **Dispatch thesis-synthesizer** to:
   - Map new evidence to thesis sections (with evidence IDs)
   - Audit claims (UNSUPPORTED / WEAK / CONTESTED)
   - Score confidence per section using the 1–5 rubric with **hard caps**:
     - Single source type → cap 3
     - Two source types → cap 4
     - Unaddressed contradictions → cap 3
     - All stated intent (no behavioral) → cap 3
     - ≥4 requires ≥50% behavioral evidence AND ≥3 source types
     - 5 requires behavioral evidence AND commitments
   - Append an Evolution Log entry (changes, trigger evidence, confidence delta)
   - Identify the weakest section and propose specific next-cycle tests

3. Update `THESIS.md` with new scores. Update `cycles.json` with this cycle's `confidence_snapshot` and `confidence_delta`.

4. **PAUSE — Present the synthesis report.** The user reviews and accepts or challenges the scores. Conservative scoring is the default; argue *up* only if the user provides specific evidence.

## Constraints

- Confidence cannot increase without new evidence.
- Contradicting evidence is never removed — only addressed.
- Stagnation across 2+ cycles → flag for methodology review.
- Trajectory down 2+ cycles → consider PIVOT or KILL recommendation.

## Reference

- Agent: [agents/thesis-synthesizer.md](../agents/thesis-synthesizer.md)
- Rubric: [skills/evidence-weighting/SKILL.md](../skills/evidence-weighting/SKILL.md)
