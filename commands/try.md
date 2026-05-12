---
description: Run the Devil's Advocate against a built-in fake plan — the 30-second magic moment for first-time Forge users. Zero setup required, no state files needed. Triggers on "try forge", "demo forge", "show me what this does", "see Forge in action", or just after install when the user wants to see what the plugin does without committing to setup.
---

# /forge:try — The 30-second magic moment

> **Execution mode: direct.** This command has explicit steps below — execute them in order. Do not enter plan mode, do not write a plan file, do not call ExitPlanMode. The framework already did the planning; you just run the steps.

You give a brand-new user the Forge experience in 30 seconds with zero setup. No state files. No methodology. No mode choice. Just paste-able output that sells itself.

## Behavior

### Step 1 — Print the pre-flight (1-2 lines)

Before showing the kill report, print:

```
⚡ Running the Devil's Advocate against a built-in fake startup pitch.
   This is a demo — to attack your own plan, run /forge:falsify [paste plan].
```

This sets expectation (it's a demo, not real analysis) and previews the next command.

### Step 2 — Print the kill report

Read the fixture at `${CLAUDE_PLUGIN_ROOT}/docs/demos/fixtures/try.txt` and print it verbatim. Do NOT modify it, do NOT add commentary, do NOT summarize. The fixture is the entire output of this command — it represents what `/forge:falsify` would produce on a real plan, just pre-rendered for demo speed.

### Step 3 — Print the friendly handoff (3 lines)

After the kill report, print:

```
✓ That was a demo on a fake plan.

  Run /forge:falsify [your plan] to attack your own work
  Or /forge:init when you're ready to set up Forge for your project
```

Keep it tight. Don't lecture. Don't pitch the methodology. Let the kill report do the selling.

## Constraints

- **Total runtime: ≤5 seconds.** This is a magic-moment demo. If it's slow, the moment dies.
- Never modify the fixture content at runtime.
- Never dispatch the `devils-advocate` agent. This is a static demo, not a real DA run. The point is instant value with zero setup.
- Never ask the user any questions. The whole point is zero friction.
- If `${CLAUDE_PLUGIN_ROOT}/docs/demos/fixtures/try.txt` doesn't exist, fall back to printing: "Forge installed but demo fixture missing — please reinstall via `claude plugin install forge@forge --force`. To attack your own plan, run /forge:falsify."

## Why this command exists

First-time Forge users currently have to read the README, run `/forge:init`, fill state files, then `/forge:harvest`, then `/forge:shape` before they see anything that earns their trust. That's a 10-15 minute path to first value, which kills installs.

`/forge:try` collapses that to <30 seconds: install → run `/forge:try` → see a screenshottable kill report → decide whether to commit to setup. It's the "magic moment" pattern that wins on Product Hunt (Cursor, v0, Lingo all do versions of this).

The fixture itself is the marketing — a developer who runs `/forge:try` and sees the receipt-OCR plan get killed across 8 vectors immediately understands what Forge is for. No methodology lecture required.
