---
name: founder-mode
description: Use when validating a startup hypothesis pre-PMF. Runs SCOUT → INTERROGATE → SYNTHESIZE → TEST cycles 3–5 times across 2–4 weeks until 12 graduation criteria are met. Mandatory Devil's Advocate after every INTERROGATE. Confidence scoring on 1–5 rubric with hard caps. Falsification-driven, not validation-driven.
---

# Founder mode

You validate a hypothesis before you build. Mom Test interviews, community mining, mandatory Devil's Advocate, evidence-weighted confidence scoring.

**Difference from PM mode:** PM mode optimizes velocity *after* you know WHO and WHY. Founder mode discovers them through structured falsification. The 12 graduation criteria are the gate.

## The cycle

Run 3–5 cycles, each 2–4 weeks. Pause for human review at every phase boundary.

### SCOUT (30–60 min agent + human)
Dispatch [market-scout](../../agents/market-scout.md). Parallel scans across Reddit, G2, Hacker News, ProductHunt, Crunchbase using the [7-signal framework](../community-mining/SKILL.md). Output: SCOUT report with verbatim quotes, source URLs, contradictory signals (mandatory), new hypotheses.

**Human pause:** prioritize hypotheses, flag domain-specific gaps the agent missed.

### INTERROGATE (2–4 hrs human + agent)
Dispatch [interview-architect](../../agents/interview-architect.md) twice — once pre-interview to generate the protocol (10–15 questions traced to hypotheses), once post-interview to analyze transcripts (JTBD four forces, [evidence weighting](../evidence-weighting/SKILL.md), false-positive flags).

Then **dispatch [devils-advocate](../../agents/devils-advocate.md) — mandatory.** DA-Lite cycles 1–2, DA-Full cycles 3+, DA-Final pre-graduation.

**Human pause:** review interviews + DA report. Decide which DA attacks are valid.

### SYNTHESIZE (30–60 min agent)
Dispatch [thesis-synthesizer](../../agents/thesis-synthesizer.md). Updates `THESIS.md` with confidence scores (1–5 with hard caps), audits claims, appends Evolution Log entry, identifies weakest section.

**Human pause:** accept or challenge confidence scores. Conservative scoring is the default.

### TEST (15–30 min)
Evaluate the 12 graduation criteria. Recommend CONTINUE / PIVOT / KILL / GRADUATE.

**Human pause:** decide.

## The 12 graduation criteria

ALL twelve must be met. 11/12 = NOT READY.

```
[ ] Problem confidence ≥ 4
[ ] Pricing confidence ≥ 4
[ ] Purpose confidence ≥ 3
[ ] Market confidence ≥ 3
[ ] Wedge confidence ≥ 3
[ ] Competition confidence ≥ 3
[ ] Defensibility confidence ≥ 3
[ ] No invalidated P1 hypotheses
[ ] DA: no existential risks
[ ] ≥12 interviews across ≥3 segments (no segment > 40%)
[ ] ≥3 real commitments obtained
[ ] Confidence trajectory: stable or increasing over last 2 cycles
```

## State files (7)

| File | What |
|---|---|
| `THESIS.md` | 7 sections (Purpose, Problem, Market, Wedge, Competition, Defensibility, Pricing) + Confidence Summary + Evolution Log |
| `hypotheses.json` | Active falsifiable claims, each with `falsification_criteria` (REQUIRED) |
| `evidence.json` | Tagged evidence: source, type, weight (1/2/3), direction, hypothesis IDs |
| `cycles.json` | Forge history, phase records, confidence snapshots, DA summaries |
| `interviews.md` | Structured summaries: JTBD forces, weighted evidence, commitment signals, false-positive flags |
| `landscape.md` | Competitor map (every competitor has "Why they might win"), Five Forces, community signals |
| `progress.md` | **Dead Ends (read first by every agent)**, Cross-Cutting Patterns, Active Gotchas |

## What's different about Founder mode

- **Falsification-driven, not validation-driven.** You're trying to kill the thesis, not save it. Surviving 5 attacks means the hypothesis is actually strong.
- **Behavioral evidence > stated intent.** Weight 3 (past actions) > Weight 2 (mixed) > Weight 1 ("I would..."). Hard cap of 3 confidence on stated-intent-only evidence.
- **Contradictory evidence is mandatory.** No SCOUT pass is complete without it. Cherry-picking is the most-detected failure mode.
- **DA after every INTERROGATE.** Non-negotiable. The framework's discipline.
- **Conservative scoring by default.** When in doubt, lower the score.

## Graduation handoff

When all 12 criteria are met, [/forge:graduate](../../commands/graduate.md) hands off:
- Draft `IDENTITY.md` (WHO/JOB/NEVER from THESIS.md)
- Initial signals (validated hypotheses → PM `releases.json` current_cycle.signals with `thesis_impact: "confirms"`)
- Feature priority seeds (high-confidence/high-pain hypotheses → `features.json`)
- Graduation Brief (top risks, open questions, pricing signals, moat evidence)

After handoff: switch to [pm-mode](../pm-mode/SKILL.md).

## What it doesn't do

- It doesn't tell you to ship. The human decides.
- It doesn't generate a product. It generates a *validated thesis*.
- It doesn't do customer interviews — *you* do those. The agent generates the protocol and analyzes the transcripts.
