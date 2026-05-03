---
description: Founder mode — run market scout. Parallel community mining across Reddit, G2, Hacker News, ProductHunt, Crunchbase using the 7-signal framework. Updates landscape.md, hypotheses.json, evidence.json.
---

# /forge:scout — Market scout (Founder mode)

> **Execution mode: direct.** This command has explicit steps below — execute them in order. Do not enter plan mode, do not write a plan file, do not call ExitPlanMode. The framework already did the planning; you just run the steps.


You dispatch the **market-scout** agent to discover signals across communities.

## Pre-conditions

- `THESIS.md` and `hypotheses.json` exist in the project. If not, instruct the user to run `/forge:init --founder` first.

## Behavior

1. Read `THESIS.md` (current sections + confidence scores), `hypotheses.json` (active hypotheses), `landscape.md` (last cycle's competitors), `evidence.json` (existing evidence), and `progress.md` (Dead Ends + Cross-Cutting Patterns).

2. **Dispatch the market-scout agent** with the active hypotheses and a list of 5–7 communities to scan in parallel. The agent uses the 7-signal framework (pain, frequency, severity, willingness-to-pay, competitor, trend, contradictory) and returns a structured SCOUT Report.

3. **Append signals to `landscape.md` and `evidence.json`.** Every signal must include source URL, date, verbatim quote, and signal type. Contradictory signals are mandatory — if there are none, the scout pass was incomplete.

4. **PAUSE — Present the SCOUT Report to the user.** Highlight: HIGH-strength signals, contradictory evidence, new competitors, hypotheses that should be created or weakened.

## Constraints

- Never paraphrase community quotes — verbatim only.
- Use bottom-up TAM only. No analyst reports.
- New hypotheses require ≥2 independent signals.
- If the user has only stated-intent evidence (weight 1), flag the gap.

## Reference

- Agent: [agents/market-scout.md](../agents/market-scout.md)
- Method: [skills/community-mining/SKILL.md](../skills/community-mining/SKILL.md)
