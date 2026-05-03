---
description: Show current Forge phase and a one-screen state snapshot. Mode (Founder / PM), current phase, recent feature quality, signals harvested, stabilization triggers, drift report status.
---

# /forge:status — Current phase + state snapshot

> **Execution mode: direct.** This command has explicit steps below — execute them in order. Do not enter plan mode, do not write a plan file, do not call ExitPlanMode. The framework already did the planning; you just run the steps.


You produce a one-screen summary of where the user is in their cycle.

## Behavior

1. **Detect mode.** `THESIS.md` exists → Founder. `IDENTITY.md` exists → PM. Both → ask. Neither → tell the user to run `/forge:init`.

2. **Render a status card.** Compact, one screen, monospace alignment.

### PM-mode status card

Render the card with **one interpretive sentence** above each section that turns the numbers into plain English:

```
═════════════════════════════════════════════════════
  CYCLE STATUS — PM mode
═════════════════════════════════════════════════════

  Your product (Identity v{N}):
  WHO:   {one-line WHO from IDENTITY.md}
  JOB:   {one-line JOB}
  NEVER: {one-line NEVER}

  You're in cycle v{next-version}, phase {HARVEST|SHAPE|BUILD|SHIP}.
  Signals harvested this cycle: {N} ({HIGH}H / {MED}M / {LOW}L). {invalidate-count interpretation: "1 invalidates your current thesis — review before /forge:shape" or "none invalidate the thesis"}.
  Release plan: {features-count} features queued, {debt} debt items, {kill} killed by the 10% Delete Rule.
  Build progress: {done}/{total} features done, {blocked} blocked. {blocked > 0 ? "Blocked features hit 3 resets — likely scope or test issues; investigate features.json." : "No blockers."} Avg quality {score}/10.

  Last 3 releases (avg quality {avg}/10 — {avg ≥ 8 ? "trending healthy" : avg ≥ 6 ? "watch for stabilization" : "stabilization needed"}):
  v{X-2}  {score}/10
  v{X-1}  {score}/10
  v{X}    {score}/10  ← shipped {date}

  Stabilization triggers: {fired-list or "none firing — keep building"}.
  Recent drift ({date}): {recommendation interpretation: "DISCUSS — surface honeycomb-comparison at next /forge:shape" or "CONTINUE — no action"}

  ⚡ Next: /{harvest|shape|build|ship|drift} — {one-sentence why this is the next step}.
═════════════════════════════════════════════════════
```

### Founder-mode status card

```
═════════════════════════════════════════════════════
  CYCLE STATUS — Founder mode
═════════════════════════════════════════════════════

  Your thesis (cycle {N}, phase {SCOUT|INTERROGATE|SYNTHESIZE|GRADUATE}):
  Purpose       {1–5}  {trend ↑↓→}
  Problem       {1–5}  {trend}    ← graduation needs ≥4
  Market        {1–5}  {trend}
  Wedge         {1–5}  {trend}
  Competition   {1–5}  {trend}
  Defensibility {1–5}  {trend}
  Pricing       {1–5}  {trend}    ← graduation needs ≥4

  {avg-confidence interpretation: "Average confidence 3.4/5 — building evidence well" or "Average 2.1/5 — still in the dark on {weakest-section}, prioritize there"}.

  Hypotheses: {N} active, {N} confirmed, {N} weakened, {N} invalidated.
  Interviews: {N} this cycle, {N} cumulative across {N} segments. {graduation-bar: "Graduation needs ≥12 across ≥3 segments — you're at {met}/12 in {S}/3."}
  Commitments obtained: {N}. {commitments-interpretation: "≥3 needed for graduation — you have {N}."}
  Last DA: {date} — {N} existential risks, {N} non-existential. {if existential > 0: "Address existential risks before next graduation attempt."}

  Graduation: {met}/12 criteria met. Missing: {top-3-missing}.

  ⚡ Next: /{scout|interrogate|synthesize|graduate} — {one-sentence why}.
═════════════════════════════════════════════════════
```

## Constraints

- Read all state files but never modify.
- Render in ≤5 seconds.
- If a state file is missing, surface the gap and don't fail.
