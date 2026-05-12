---
description: One-screen orientation to Forge — modes, commands, state files, the three filters. Run this first if you're confused about where to start, what /init does, or which command applies to your situation. Also use to remind yourself of the command index without leaving Claude Code.
---

# /forge:help — Orientation

> **Execution mode: direct.** This command has explicit steps below — execute them in order. Do not enter plan mode, do not write a plan file, do not call ExitPlanMode. The framework already did the planning; you just run the steps.


You are introducing Forge to a user who has the plugin installed but isn't sure how to use it. Print the orientation block below, exactly as written. Do NOT add commentary, do NOT modify the structure, do NOT skip sections. Use the user's actual project context (existence of `IDENTITY.md` / `THESIS.md`) to set the **Where you are now** section, but everything else is verbatim.

---

```
═══════════════════════════════════════════════════════
  FORGE — Vibe-coded plans go in. Only what survives ships.
═══════════════════════════════════════════════════════

  THREE FILTERS EVERY RELEASE RUNS THROUGH:
  1. Question every plan — Devil's Advocate before code exists
  2. Delete 10% of scope — mandatory, every release
  3. Audit every five features — drift checks vs IDENTITY

  Then the Ralph Loop ships what survived.

  TWO MODES (auto-routed by which state file exists in your project):

  ┌──────────────────────┬──────────────────────────────────┐
  │ FOUNDER mode         │ PM mode                          │
  │ Pre-PMF validation   │ Shipping a product               │
  │ THESIS.md present    │ IDENTITY.md present              │
  │                      │                                  │
  │ /forge:scout         │ /forge:harvest                   │
  │ /forge:interrogate   │ /forge:shape   ← hero command    │
  │ /forge:synthesize    │ /forge:build                     │
  │ /forge:graduate      │ /forge:ship                      │
  └──────────────────────┴──────────────────────────────────┘

  WORKS IN BOTH MODES:

  ★ /forge:try       30-second magic-moment demo. Zero setup. Start here.
  /forge:falsify     Devil's Advocate against any plan / pitch / PRD
  /forge:init        Scaffold state files (Validating by default)
  /forge:init --pm   Scaffold for shipping a product instead
  /forge:cycle       Run a full cycle, auto-routed
  /forge:drift       Standalone drift audit on last 5 features
  /forge:status      One-screen state snapshot
  /forge:help        This screen

  STATE FILES LIVE IN YOUR REPO. Plain Markdown + JSON:

  PM mode (6 files):
    IDENTITY.md, features.json, releases.json,
    progress.md, architecture.md, contracts.md

  Founder mode (7 files):
    THESIS.md, hypotheses.json, evidence.json,
    cycles.json, interviews.md, landscape.md, progress.md

  Commit them or .gitignore them — they're yours. Claude reads
  them on every session via the SessionStart hook.
═══════════════════════════════════════════════════════
```

---

After printing the block, append a single contextual `Where you are now:` section:

- **If `IDENTITY.md` exists in the project root:** "PM mode detected. Run `/forge:status` to see your current cycle, or `/forge:harvest` to start a new one."
- **If `THESIS.md` exists:** "Founder mode detected. Run `/forge:status` to see hypothesis trajectory, or `/forge:interrogate` to keep validating."
- **If both exist:** "Both modes detected. Tell me which to run — or rename one of the state files to disable that mode."
- **If neither exists:** "No state files yet. Run `/forge:init` (PM, default) or `/forge:init --founder` (pre-PMF) to scaffold."

End with one line: "Read more: github.com/dormstern/forge"

Do NOT execute any other command. Do NOT make recommendations beyond the contextual one-liner above.
