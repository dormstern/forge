---
description: Standalone Devil's Advocate. Paste any plan, pitch, PRD, or thesis and the agent runs 8 attack vectors (cherry-picking, false champion, cope moat, TAM mirage, weak wedge, timeline cope, replicability, distribution) plus pre-mortem and returns a kill report.
---

# /forge:falsify — Standalone Devil's Advocate

> **Execution mode: direct.** This command has explicit steps below — execute them in order. Do not enter plan mode, do not write a plan file, do not call ExitPlanMode. The framework already did the planning; you just run the steps.


You dispatch the **devils-advocate** agent against any user-supplied artifact: a release plan, a startup pitch, a PRD, a thesis section, an investor email — anything with claims that can be killed.

## Behavior

1. **Receive the artifact.** The user pastes text, points to a file, or says "falsify the current shape." If they don't provide one, ask: "What should I attack?" with three categories: a plan, a pitch, or a hypothesis.

2. **Print a pre-flight line** before dispatching the agent (so the user knows what's happening + what success looks like):

   ```
   ⚡ Falsifying your plan across 8 attack vectors. This is uncomfortable on purpose —
      each ⚠ is a real risk, each ✗ is a kill. Aim to survive 5/8.
   ```

3. **Dispatch devils-advocate** with the full attack framework:
   - Cherry-Picking: "Show me the evidence you ignored."
   - False Champion: "Your champion has no budget. Or worse, no problem."
   - Cope Moat: "Your moat is a feature, a UX preference, or a launch advantage."
   - TAM Mirage: "Your TAM is one bad SQL query. The real wedge is 1/100th."
   - Weak Wedge: "Your wedge could be a feature inside three incumbents within 90 days."
   - Timeline Cope: "What looks like 3 days is 3 weeks. What looks like 3 weeks is a quarter."
   - Replicability: "A funded competitor clones this in 12 months."
   - Distribution: "You have product. Where's the channel?"
   Plus a pre-mortem (≥5 scenarios) and an evidence-skew audit.

4. **Render the kill report** in the screenshottable format (monospace, Unicode borders, ✓/⚠/✗ markers, **confidence score per finding**, **Falsifiability Index at the bottom**). One-line verdict per attack, plus a 48-hour cheap test for each KILL or WOUND.

5. **Persist the report** if state files exist:
   - Founder mode → append to `progress.md` under "Recent DA Findings"
   - PM mode → append to `progress.md` and `releases.json` current_cycle if shaping is in progress

6. **Threshold filtering by default.** Only show findings with `confidence ≥ 60`. If user passes `--all`, include findings below 60 as well.

7. **Do NOT** soften attacks. The framework's value is uncomfortable falsification.

## When to use

- Before committing to a release plan (auto-fired by `/forge:shape`)
- Before pitching an investor or buyer
- After receiving a strong "yes" from a customer (false-positive check)
- When confidence has been climbing for 2+ cycles (something's being missed)

## Reference

- Agent: [agents/devils-advocate.md](../agents/devils-advocate.md)
