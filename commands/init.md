---
description: Scaffold Forge state files into the user's project for the first time. Welcomes new users with a plain-English mode question (no methodology jargon), copies templates non-destructively, pre-fills IDENTITY/THESIS where possible, and routes to the next command. Defaults to Founder mode for empty directories, PM mode otherwise.
---

# /forge:init — First-run setup

> **Execution mode: direct.** This command has explicit steps below — execute them in order. Do not enter plan mode, do not write a plan file, do not call ExitPlanMode. The framework already did the planning; you just run the steps.


You are setting up Forge in the user's project for the first time. **This is the user's first impression of Forge.** Clarity, warmth, and idiot-proof framing beat technical accuracy. Save methodology terminology for after the mode is picked.

## Behavior

### Step 1 — Detect the situation

- **`--founder` flag passed** OR user said "pre-PMF" / "validating" / "early stage" → Founder mode, skip to Step 3.
- **`--pm` flag passed** OR user said "shipping" / "post-PMF" / "have users" → PM mode, skip to Step 3.
- **No flag, directory has `package.json` and `README.md`** → Default to PM mode (the user already has a product). Skip to Step 3.
- **No flag, directory is empty (no package.json, no README, no source)** → Run Step 2 (the welcome question).

### Step 2 — First-run welcome question (CRITICAL — no jargon)

Use `AskUserQuestion` with this EXACT framing:

**Header (chip label, max 12 chars):** `Forge setup`

**Question:** *"Welcome to Forge. Two ways to use it — which describes you?"*

**Options (3 options, no "Other" — system adds it):**

1. **Label:** `Validating an idea (Recommended)`
   **Description:** *"You have an idea but aren't sure yet who'd pay for it or why they'd choose you. Forge will help you find real users, attack your assumptions, and decide what's worth building. Next: `/forge:scout`."*

2. **Label:** `Shipping a product`
   **Description:** *"You already have users — paying or design partners. You want discipline around what to build next, what to kill, and how to catch features drifting off-strategy. Next: `/forge:harvest`."*

3. **Label:** `Both`
   **Description:** *"Scaffold both sets so you can poke around. Useful if you'll start by validating and graduate to shipping in the same repo."*

The "Recommended" badge goes on **Validating** when the directory is empty (empty folder + brand-new install = almost always a new idea). If the directory has source code but no Forge state files, "Recommended" goes on **Shipping**.

### IDIOT-PROOF RULES — what NOT to say in the question or options

These terms confuse first-time users and have no place in the welcome question. Save them for after mode is picked:

| Don't say | Say instead |
|---|---|
| "PMF" / "pre-PMF" / "post-PMF" | "users" or "paying customers" |
| "Founder mode" / "PM mode" (in option labels) | "Validating" / "Shipping" |
| "WHO / JOB / NEVER" | (don't expose schema in the question — it's introduced inside IDENTITY.md after scaffold) |
| "thesis" / "hypotheses" / "Purpose paragraph" | "idea" / "assumptions" |
| "SCOUT → INTERROGATE → SYNTHESIZE → GRADUATE" / phase flowcharts | just say the next command, e.g. `/forge:scout` |
| State filenames beyond the next command | scaffolded files speak for themselves |

After the user picks, internal methodology terms come back — inside the scaffolded files (which include `[DRAFT — confirm or rewrite]` markers with inline explanations).

### Step 3 — Scaffold templates

Map mode → template directory:

- **Founder mode (Validating):** scaffold from `${CLAUDE_PLUGIN_ROOT}/templates/founder/*`. By default, write `THESIS-minimal.md` (60-line v0 form, 7 questions). If the user passed `--full` or said "I have lots of evidence already" / "I've done this before," write `THESIS-full.md` instead (the 278-line full template with B2B Buyer Map, Porter's Five Forces, Helmer's 7 Powers). Either way, also write: `hypotheses.json`, `evidence.json`, `cycles.json`, `interviews.md`, `landscape.md`, `progress.md`.
- **PM mode (Shipping):** scaffold from `${CLAUDE_PLUGIN_ROOT}/templates/pm/*` → `IDENTITY.md`, `features.json`, `releases.json`, `progress.md`, `architecture.md`, `contracts.md`.
- **Both:** scaffold both sets (Founder gets the minimal THESIS by default unless `--full`). If both have `progress.md`, write the PM version (the Founder one is a subset).

For each template:
- Check if the file already exists in the project root.
- If yes, **skip and tell the user**. Never overwrite without explicit confirmation.
- If no, copy via plain file ops (Read template → Write to project root).

**Tip in your welcome banner:** if you scaffolded `THESIS-minimal.md`, mention "Run `/forge:init --full` later to expand into the full template once you have evidence."

### Step 4 — Pre-fill IDENTITY.md / THESIS.md (best-effort)

If `package.json` or `README.md` exists in the project:
- Read them.
- Draft a candidate `WHO`, `JOB`, `NEVER` (PM mode) or `Problem`, `Audience`, `Wedge` (Founder mode).
- Insert into the scaffolded file with **`[DRAFT — confirm or rewrite]`** markers on every field so the user knows to edit.

If neither file exists, leave the templates as-is (they have inline `[DRAFT — fill in]` placeholders).

### Step 5 — Welcome banner (the friendly handoff)

After scaffolding, print a banner with this shape:

```
✓ Forge is set up.

  Mode:     [Validating | Shipping | Both]
  Created:  [N] files in your project root
  Skipped:  [N] (already existed)

  You are here:
    [one-sentence orientation, e.g. "Empty IDENTITY.md ready for you to fill in WHO/JOB/NEVER —
    these are the three questions that anchor everything Forge will do."]

  Next steps:
    1. Open [IDENTITY.md | THESIS.md] and fill in the [DRAFT] markers.
    2. Run /forge:[harvest | scout] when ready — Forge will read your state files
       and start the cycle.
    3. Run /forge:help anytime for a one-screen orientation.
```

Keep the banner under 15 lines. Tone: welcoming, not bureaucratic. The user just installed a tool — they should feel like they're in good hands, not in a manual.

## Constraints

- Never overwrite existing state files.
- Never write into nested directories. Never touch `.git/`, `node_modules/`, etc.
- Total runtime target: ≤10 seconds, including the welcome question.
- If the user picks "Other" with custom text, parse intent and confirm before proceeding ("Sounds like you want X — should I scaffold Founder mode?").

## State file references

Templates live in `${CLAUDE_PLUGIN_ROOT}/templates/pm/` and `${CLAUDE_PLUGIN_ROOT}/templates/founder/`.
