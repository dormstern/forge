---
description: Run a full cycle end-to-end. Auto-routes to Founder mode (SCOUT → INTERROGATE → SYNTHESIZE → TEST) or PM mode (HARVEST → SHAPE → BUILD → SHIP) based on which state files exist in the project.
---

# /forge:cycle — Full cycle, auto-routed

> **Execution mode: direct.** This command has explicit steps below — execute them in order. Do not enter plan mode, do not write a plan file, do not call ExitPlanMode. The framework already did the planning; you just run the steps.


You orchestrate a complete cycle from start to finish, pausing at every human checkpoint defined by the framework.

## Mode detection

- If `THESIS.md` exists at the project root → **Founder mode**: run `/forge:scout`, then `/forge:interrogate`, then `/forge:synthesize`, then `/forge:graduate` (12-criteria check). Pause at each phase boundary.
- If `IDENTITY.md` exists → **PM mode**: run `/forge:harvest`, then `/forge:shape`, then `/forge:build`, then `/forge:ship`. Pause at each phase boundary.
- If both exist → ask the user which mode to run.
- If neither exists → tell the user to run `/forge:init` first.

## Pausing rules

After every phase, **PAUSE and present a short summary**. Do not advance until the user confirms. The framework's discipline depends on this — it's not optional.

Phase summaries should be ≤200 words and end with: "Run `/<next-command>` to advance, or send feedback first."

## State file rules

- Re-read the relevant state files between phases. Do not carry context forward across phase boundaries.
- Persist updates to state files as you go (don't batch).
- Announce phase transitions explicitly: `--- PHASE: <name> ---`

## Reference

- Founder cycle methodology: see [skills/founder-mode/SKILL.md](../skills/founder-mode/SKILL.md)
- PM cycle methodology: see [skills/pm-mode/SKILL.md](../skills/pm-mode/SKILL.md)
