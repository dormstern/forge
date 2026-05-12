# Your first 30 minutes with Forge

A walkthrough of cycle zero — installing the plugin, scaffolding state files, and getting through the first `/forge:shape` so you have something to screenshot.

## Minute 1 — install

```sh
$ claude plugin marketplace add dormstern/forge
$ claude plugin install forge@forge
[plugin enabled — 13 commands, 9 agents, 10 skills loaded]
```

Restart Claude Code if it doesn't pick up the new commands. You should now see `/forge:cycle`, `/forge:init`, `/forge:harvest`, `/forge:shape`, and 9 others in tab-completion.

## Minutes 2–3 — pick a project

If you're on a shipped product → cd into it, run `/forge:init`. PM mode.

If you're pre-PMF → cd into an empty directory or a working prototype, run `/forge:init --founder`. Founder mode.

```sh
$ cd your-project
$ /forge:init
✓ Detected: Next.js project, no existing state files
✓ Scaffolded: PM-mode templates (6 files)
✓ Pre-filled IDENTITY.md from package.json [DRAFT — confirm or rewrite]
✓ contract_mode: "lightweight"  (REST APIs detected in /app/api/)
   → Edit IDENTITY.md to confirm, then run /forge:harvest
```

## Minutes 4–14 — write IDENTITY.md (or THESIS.md)

This is the most important 10 minutes you'll spend on Forge.

Open `IDENTITY.md`. Three fields:

- **WHO** — a specific person, not a persona segment. *"SOC analyst at a 50–200-person enterprise, handling 100+ alerts/day"*, not *"mid-market security teams."*
- **JOB** — JTBD form. *"When [trigger], I want to [action], so that [outcome]."*
- **NEVER** — specific categories that are off-limits. The founder-NEVER test: would compromising make you identical to a competitor? If yes, it's a NEVER.

The pre-fill from `/forge:init` is *always* a draft. Don't accept it as-is.

**Don't worry about getting it perfect.** Identity evolves through cycles via the Evolution Log. What matters is being honest about your current best guess.

For Founder mode, the equivalent is `THESIS.md` — 7 sections (Purpose / Problem / Market / Wedge / Competition / Defensibility / Pricing). Same rule — be honest, don't worry about perfection.

## Minute 15 — `/forge:harvest` (PM) or `/forge:scout` (Founder)

```
$ /forge:harvest
```

PM mode: drop in 4–10 raw signals from the last few weeks. Anything: customer feedback, analytics anomalies, tickets, competitive moves, internal observations. The orchestrator structures them.

Founder mode (`/forge:scout` instead): the market-scout agent runs parallel community scans. You don't need to provide signals — it finds them.

You'll get a structured signal summary back. Skim it. Do any signals have `thesis_impact: "invalidates"`? If yes, those are the load-bearing entries.

## Minutes 16–25 — `/forge:shape` (PM only)

```
$ /forge:shape
```

This is the hero command. The orchestrator reads `IDENTITY.md` + `releases.json` (signals) + `architecture.md` + `features.json`, proposes a release plan, dispatches the Devil's Advocate, and renders the hero card.

You'll see something like:

```
═════════════════════════════════════════════════════
  CYCLE — Release Plan v0.X
  Thesis: "..."
═════════════════════════════════════════════════════

  FEATURES (N)              AUTONOMY    SIGNAL
  ───────────────────────────────────────────────
  ✓ feature-1               T1          SIG-NNN
  ⚠ feature-2               T2          SIG-NNN
  ...

  KILL LIST (10% Delete Rule fired ✗)
  ───────────────────────────────────────────────
  ✗ ...

  DEVIL'S ADVOCATE
  ───────────────────────────────────────────────
  ⚠ Cope Moat: ...
  ⚠ Timeline Cope: ...
  ✓ Cherry-Picking: clean

  Run /forge:build to start. /forge:falsify to attack the plan harder.
═════════════════════════════════════════════════════
```

**This is the screenshot.** Take it. Paste it in your team Slack. Or post it on Twitter if you want to brag.

## Minutes 26–30 — decide

You have three options now:

1. **`/forge:falsify`** — run an even harder DA pass against the plan. Recommended if any of the DA findings made you uncomfortable but not convinced.
2. **`/forge:build`** — start the Ralph Loop. The framework will dispatch test-writer + builder per feature, with autonomy-tier-aware checkpoints.
3. **Edit the plan** — open `releases.json`, modify `current_cycle.approved_plan`, re-run `/forge:shape` for a refreshed render.

If this is your first cycle, the kill list and DA findings are usually the most-surprising parts. Spend a few minutes on them before deciding to build.

## What you've now persisted

After 30 minutes:

- `IDENTITY.md` (or `THESIS.md`) with your honest current-best-guess identity (or thesis)
- `releases.json` (or `cycles.json`) with cycle 1 in progress, signals harvested, plan proposed
- A clear next command to run
- A screenshot you can share

The framework's value isn't in cycle 1 — it's in the cumulative state across cycles 2, 5, 20. But cycle 1 is what convinces you to keep going.

## What to do tomorrow

- If you're on PM mode and you ran `/forge:build` — let the Ralph Loop work for a few hours. Check in on T2/T3 checkpoints.
- If you're on Founder mode — schedule 4–8 customer interviews this week. Run `/forge:interrogate` to generate the protocol.
- If you ran `/forge:falsify` and it killed something important — go talk to a customer or run a 48-hour cheap test. The DA cited specific tests for each kill.

## When to come back

- You've shipped a feature → run `/forge:drift` after 5 features to check identity alignment.
- A signal arrives that surprises you → run `/forge:harvest` and look at `thesis_impact`.
- You're about to send an investor email → run `/forge:falsify` against the email first.
- You've had 4+ interviews in a Founder cycle → run `/forge:interrogate` to analyze them.
- You've lost a deal → harvest the signals; check whether NEVER was violated; consider an Identity evolution proposal in next `/forge:shape`.
