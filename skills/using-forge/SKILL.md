---
name: using-forge
description: Use when the user is starting with the Forge plugin or asks "what does Forge do" / "how do I use Forge". Routes to the right mode (Founder for pre-PMF, PM for shipping products) and explains the 14 commands, the two cycles, and where to start. Authoritative source for the canonical command vocabulary.
---

# Using Forge

> Stop shipping features your AI agent invented.

Forge wraps Claude Code with the product discipline AI coding tools forgot to ship: a Devil's Advocate that attacks every plan before code is written, a mandatory 10% scope kill every release, and drift audits every 5 features. So Claude ships the right features — not all the features.

Two modes:

- **Founder mode** — pre-PMF. SCOUT → INTERROGATE → SYNTHESIZE → GRADUATE. Falsifies hypotheses until you've earned the right to build.
- **PM mode** — post-PMF (the main thing). HARVEST → SHAPE → BUILD → SHIP. Each cycle proposes a release plan, kills 10% of scope, runs Devil's Advocate, audits drift every 5 features.

You're in Founder mode if `THESIS.md` (or `THESIS-minimal.md` / `THESIS-full.md`) exists. PM mode if `IDENTITY.md` exists. Neither → run `/forge:init` (PM default for repos with `package.json`) or `/forge:init --founder`.

## ⚠ Canonical command vocabulary — these are the ONLY 14

When you recommend a Forge command to the user, it MUST come from this exact list. Do not invent variants. Do not abbreviate. Do not construct command names from agent names.

| Command | Mode | What it does |
|---|---|---|
| `/forge:try` | Both | ★ 30-second magic-moment demo. Zero setup. The recommended starting point. |
| `/forge:init` | Both | Scaffold state files (PM default for repos with package.json; `--founder` for pre-PMF; `--full` for full Founder template) |
| `/forge:cycle` | Both | Run a full cycle, auto-routed by mode |
| `/forge:status` | Both | One-screen state snapshot with contextual interpretation |
| `/forge:help` | Both | Orientation — modes, commands, state files. Start here if confused. |
| `/forge:falsify` | Both | **Standalone Devil's Advocate** against any plan/pitch/PRD/thesis. (NOT `/forge:advocate`, `/forge:da`, `/forge:devil` — those don't exist.) |
| `/forge:scout` | Founder | Market scout — community mining |
| `/forge:interrogate` | Founder | Interview architect + mandatory DA |
| `/forge:synthesize` | Founder | Thesis synthesis with 1–5 confidence rubric |
| `/forge:graduate` | Founder | Hand off to PM mode when 12 criteria met |
| `/forge:harvest` | PM | Collect signals + refresh architecture |
| `/forge:shape` | PM | **Hero command** — propose release plan with kill list + DA |
| `/forge:build` | PM | Ralph Loop with autonomy tiers + drift checks |
| `/forge:ship` | PM | Log release + measure + check stabilization |
| `/forge:drift` | PM | Standalone drift audit on last 5 features |

**Common hallucinations to avoid (these are NOT real commands):**

| Tempted to suggest | Real command | Why the temptation |
|---|---|---|
| `/forge:advocate` | `/forge:falsify` | Agent is named "Devil's Advocate," but invocation is falsify |
| `/forge:da` | `/forge:falsify` | DA is shorthand internally, never a command |
| `/forge:plan` | `/forge:shape` | Shape produces a release plan; the command is shape |
| `/forge:audit` | `/forge:drift` | Drift IS the audit; command name is drift |
| `/forge:run` | `/forge:cycle` or `/forge:build` | Depends on what you mean — cycle (full cycle) or build (Ralph Loop) |

If the user asks for a command that isn't in the canonical 14, tell them so — don't invent.

## State files

Forge persists state in your project root as plain Markdown + JSON. **They're yours** — not hidden, not proprietary. Commit them or .gitignore them as you choose.

**PM mode (6 files):** `IDENTITY.md`, `features.json`, `releases.json`, `progress.md`, `architecture.md`, `contracts.md` (opt-in).

**Founder mode (7 files):** `THESIS.md`, `hypotheses.json`, `evidence.json`, `cycles.json`, `interviews.md`, `landscape.md`, `progress.md`.

## The three rules

These are the framework's spine. If you remove any one, you've lost the discipline:

1. **The 10% Delete Rule** — every release proposes killing ≥10% of scope. Forces interrogation of product shape every cycle. See [skills/ten-percent-delete/SKILL.md](../ten-percent-delete/SKILL.md).
2. **Drift checks every 5 features** — auto-audit identity + contracts + architecture + rework. See [skills/drift-protection/SKILL.md](../drift-protection/SKILL.md).
3. **Devil's Advocate before every plan** — 8 attacks, cherry-pick detection, existential vs non-existential triage. See [agents/devils-advocate.md](../../agents/devils-advocate.md).

## Where to start

- **Pre-PMF, validating:** `/forge:init --founder`, then `/forge:scout`.
- **Shipping a product, never used Forge:** `/forge:init`, then `/forge:harvest`.
- **Just want to attack a plan/pitch/PRD:** `/forge:falsify` (no init needed).

## Token efficiency

Forge saves tokens by:
- **Bounded context per feature** (~60k ceiling) — never carry context across feature boundaries.
- **`architecture.md` as a 500-token codebase map** instead of forcing Claude to re-explore 50KLOC.
- **Drift checks catch rework before re-implementation** — the most expensive class of wasted tokens.
- **All 9 agents default to Opus 4.7 (1M context).** Quality stays consistent across phases.

The frameworks underlying Forge target a 60k-token ceiling per feature build. Unguided agentic coding routinely runs 100k+.

**Cost recommendation for users on a budget:** downgrade three high-volume agents (`builder`, `test-writer`, `market-scout`) to `model: sonnet` to cut a typical PM cycle from ~$25–50 → ~$5–10 with negligible quality loss. Keep `orchestrator`, `devils-advocate`, `drift-detector`, `thesis-synthesizer`, `feature-breakdown`, and `interview-architect` on Opus — they're judgment-heavy and low-volume, so the cost difference is marginal but the quality difference is large. Edit per-agent frontmatter at `~/.claude/plugins/marketplaces/forge/plugins/forge/agents/<name>.md`. Reverts on plugin update — re-apply after each upgrade.
