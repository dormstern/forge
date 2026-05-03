---
description: Founder mode — generate interview protocol, analyze transcripts, and run a mandatory Devil's Advocate falsification pass. Outputs interview summaries with JTBD forces, evidence-weighted entries, and an existential-risk audit.
---

# /forge:interrogate — Interview architect + Devil's Advocate (Founder mode)

> **Execution mode: direct.** This command has explicit steps below — execute them in order. Do not enter plan mode, do not write a plan file, do not call ExitPlanMode. The framework already did the planning; you just run the steps.


You orchestrate two agents in sequence: **interview-architect** generates and analyzes interviews; **devils-advocate** then attacks every active hypothesis.

## Behavior

### Pre-interview

1. Read `hypotheses.json`, `interviews.md` (prior summaries), and the latest SCOUT report.
2. Dispatch **interview-architect** to generate a 10–15 question protocol, every question traced to a hypothesis. Mom Test rules apply: past behavior over future intent, specifics over generics, listen 80%.

### Post-interview (after the user has conducted ≥1 interview)

3. The user pastes raw transcripts.
4. Dispatch **interview-architect** to analyze each transcript, producing the structured summary (JTBD four forces, evidence-weighted entries with weight ∈ {1, 2, 3}, false-positive flags, commitment signals, overall assessment).
5. Append summaries to `interviews.md`. Append every cited evidence entry to `evidence.json` with `weight`, `direction`, `hypothesis_ids`.

### Mandatory Devil's Advocate

6. **Always dispatch the devils-advocate agent after every INTERROGATE pass.** This is non-negotiable per the framework. Use `DA-Lite` for cycles 1–2, `DA-Full` for cycles 3+, `DA-Final` pre-graduation.
7. The DA report attacks every active hypothesis, runs a pre-mortem (≥5 scenarios), audits evidence for cherry-picking and source-diversity skew, and triages findings into existential vs non-existential risks.

8. **PAUSE — Present interview summaries and the DA report side by side.** The user decides which DA attacks are valid.

## Constraints

- NEVER mark stated intent as weight 3 — behavioral evidence only.
- NEVER soften DA attacks to be polite. The whole point is brutal falsification.
- DA never recommends confidence increases — only attacks.

## Reference

- Agents: [agents/interview-architect.md](../agents/interview-architect.md), [agents/devils-advocate.md](../agents/devils-advocate.md)
- Methods: [skills/evidence-weighting/SKILL.md](../skills/evidence-weighting/SKILL.md)
