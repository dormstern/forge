# forge

> **Stop shipping features your AI agent invented.**

Forge wraps Claude Code with the product discipline AI coding tools forgot to ship: a Devil's Advocate that attacks every plan before code is written, a mandatory 10% scope kill every release, and drift audits every 5 features. So Claude ships the right features — not all the features.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![checks](https://img.shields.io/badge/checks-117%20passing-brightgreen)](#)
[![CI](https://github.com/dormstern/forge/actions/workflows/validate.yml/badge.svg)](https://github.com/dormstern/forge/actions/workflows/validate.yml)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-plugin-7a4ddb)](https://claude.com/claude-code)

## Try it in 30 seconds (zero setup)

```bash
claude plugin marketplace add dormstern/forge
claude plugin install forge@forge
```

In Claude Code:

```
/forge:try
```

Watch the Devil's Advocate kill a built-in fake startup pitch ("ReceiptScan AI") across 8 attack vectors. Three KILLs, four WOUNDs, one SURVIVE — each with a confidence score and a 48-hour cheap test you can actually run.

![/forge:try demo](docs/demos/try-demo.gif)

Then run it on **your** plan: `/forge:falsify [paste anything — a PRD, an investor pitch, a release plan, a thesis]`.

## Two ways to use Forge

### 🚀 As a release-cycle harness (the main thing)

For devs and PMs **shipping products with Claude Code** who are tired of agents producing features that nobody asked for. `/forge:init` scaffolds 6 state files into your repo (`IDENTITY.md`, `features.json`, `releases.json`, `progress.md`, `architecture.md`, `contracts.md`). Every release runs HARVEST → SHAPE → BUILD → SHIP. Three filters fire automatically: Devil's Advocate before every plan, mandatory 10% scope kill, drift checks every 5 features. Built on the Ralph Loop.

### ⚡ As a Devil's Advocate on tap (try-before-you-commit)

Standalone. No state files, no setup. Paste any plan, pitch, PRD, or thesis into `/forge:falsify`. Get a kill report with 8 attack vectors, confidence scores, and 48-hour cheap tests. Use it on your investor email, your PRD, your roadmap — without committing to the full cycle. Ship it in CI as a PR-comment bot if you want.

*(Plus a [Founder mode](#founder-mode--pre-pmf-validation) for pre-PMF validation — community mining + Mom-Test interviews + 12-criteria graduation gate. See "Going deeper" below.)*

## The hero commands

### `/forge:shape` — propose a release plan with kill list + Devil's Advocate findings
![/forge:shape demo](docs/demos/shape-demo.gif)

### `/forge:falsify` — Devil's Advocate against any plan, pitch, or PRD
![/forge:falsify demo](docs/demos/falsify-demo.gif)

### `/forge:drift` — audit the last 5 features against your IDENTITY
![/forge:drift demo](docs/demos/drift-demo.gif)

## What you actually get

- **Claude that knows your product.** When you `/forge:init`, six state files (Markdown + JSON) live in your repo. Claude reads them on every session — no re-priming context across cycles, no forgotten decisions.
- **Three filters before code is written.** Devil's Advocate attacks every plan, the 10% Delete Rule kills scope, drift checks audit every five features. None are optional. Forge refuses to advance past empty kill lists or skipped DA reports.
- **A repeatable cycle, not a one-shot.** Every release runs HARVEST → SHAPE → BUILD → SHIP. Quality is measured per feature; stabilization triggers fire automatically when quality slips.
- **`/forge:falsify` standalone** for the moments you don't need the full harness. Paste any plan, get a kill report. No state files needed. Ever.

## Who this is for

- **Devs shipping products with Claude Code** tired of agents producing features that nobody asked for → `/forge:init` (PM mode is the default for repos with `package.json`)
- **PMs and founders running on Claude Code** who want release-cycle discipline without leaving the terminal → `/forge:init --pm`
- **Anyone who wants to attack a single plan, pitch, or PRD** without committing to a methodology → `/forge:falsify` (no setup)
- **Pre-PMF founders** validating a thesis before writing code → `/forge:init --founder`

If you're vibe-coding a weekend project for fun, this is too much process. If you're shipping something you care about, this is the harness.

## Going deeper — when you're ready to commit

After `/forge:try` lands, the rest of Forge is the discipline harness. Five concepts, ordered as they apply:

### 1. Identity — the spine

`IDENTITY.md` sits at your repo root and answers three questions:

- **WHO** — the specific person you build for. Not "developers." *"A founding engineer at a 5–30-person Series-A SaaS who's just become responsible for a SOC-2 audit they've never run."*
- **JOB** — what the WHO is hiring your product to do, in JTBD form: *"When a Sev-2 fires across three services, I want correlated traces+logs+metrics in one timeline, so I'm not Slack-switching at 3am."* Falsifiable. Specific.
- **NEVER** — categories of work that are explicitly out of scope. *"Never a separate dashboard product. Never on-prem. Never paid plugins."* Saying NO is a strategy.

Identity is a *signal*, not a prison. An **Evolution Log** appends every identity change with a triggering signal and rationale. Pivots are normal; unaudited drift is fatal.

### 2. The cycle — your release loop

**PM mode** (post-PMF, shipping):

- **HARVEST** — collect signals (user feedback, git log, issues, errors, competitive moves) and tag each one
- **SHAPE** — propose a release plan. The three filters fire here.
- **BUILD** — Ralph Loop ships features one at a time, fresh context per feature, max 3 resets. Drift checks fire every 5 features.
- **SHIP** — log the release, calculate quality scores, check stabilization triggers, recommend the next cycle's posture

**Founder mode** (pre-PMF, validating):

- **SCOUT → INTERROGATE → SYNTHESIZE → GRADUATE** — community mining → Mom-Test interviews + DA → confidence-scored thesis → 12-criteria handoff into PM mode

### 3. The three filters

| Filter | What it does | What it catches |
|---|---|---|
| **Devil's Advocate** | Attacks every plan with 8 vectors before code exists. Each finding gets a confidence score (0–100) — KILL ≥80, WOUND 60–79, SURVIVE <60. Threshold-filtered by default. | Cope Moat, False Champion, Timeline Cope, Cherry-Picking, Weak Wedge, TAM Mirage, Replicability gaps, Distribution gaps |
| **10% Delete Rule** | Every release plan must propose killing ≥10% of in-flight scope. Refuses to advance with an empty kill list. | Stale features, no-owner work, low-usage toggles, things that violate your NEVER list, lost-bake-off remnants |
| **Drift Checks** | Auto-audit every 5 completed features. Each row gets a tier badge (✓ healthy / ⚠ watch / ✗ drift) plus a one-sentence rationale. | Off-strategy features, NEVER violations, contract breaks, architecture decay, rework patterns |

### 4. State files — Claude's memory of your product

**PM mode** (6 files at your repo root):

| File | What's in it |
|---|---|
| `IDENTITY.md` | WHO / JOB / NEVER + Evolution Log |
| `features.json` | Every feature: name, `signal_id` (why we built it), `requested_by`, status, autonomy tier, `quality_score` |
| `releases.json` | Release history + current-cycle signals + approved plan + metrics |
| `progress.md` | Cross-cutting patterns + active gotchas + key learnings, promoted from feature builds |
| `architecture.md` | Living codebase map (~500 tokens, refreshed every cycle) — the file Claude reads instead of re-exploring 50KLOC |
| `contracts.md` | API / schema contracts. Opt-in via `contract_mode` in `releases.json`. |

**Founder mode** swaps for: `THESIS-minimal.md` (60-line v0 with 7 questions; expand to `THESIS-full.md` later), plus `hypotheses.json`, `evidence.json`, `cycles.json`, `interviews.md`, `landscape.md`, `progress.md`.

Commit them or `.gitignore` them — they're yours. The SessionStart hook surfaces them every session.

### 5. Autonomy tiers — your contract with the agent

Per feature, you decide how much rope the builder gets:

- **T1** — auto-commit. Debt items, simple CRUD, tooling.
- **T2** — checkpoint before commit. Most features.
- **T3** — checkpoint before tests AND before commit. Identity-adjacent or contract-breaking.

**Stabilization triggers** fire when quality slips (rework > 15%, blocked ≥ 3, builder resets > 2, avg quality < 6) and auto-recommend a debt-only release. The framework refuses to advance through quality decline silently.

---

## Setting up your project — first cycle

### 1. Pick a mode

```bash
/forge:init             # Validating an idea (Recommended for empty folders)
/forge:init --pm        # Shipping a product (you already have users)
/forge:init --full      # Founder mode with the FULL THESIS template (skip the minimal v0)
```

`/forge:init` asks a plain-English welcome question, scaffolds the right state files into your project root, and pre-fills `IDENTITY.md` (or `THESIS-minimal.md`) from your `package.json` + `README.md`. Mark every pre-fill `[DRAFT — confirm or rewrite]` and edit before you proceed.

Confused which mode? Run `/forge:help` for an in-Claude orientation screen.

### 2. Run a cycle

```bash
# PM mode (post-PMF)
/forge:harvest        # collect signals from feedback, git log, issues
/forge:shape          # propose a release plan with kill-list + Devil's Advocate
/forge:build          # Ralph Loop — autonomy tiers, drift checks every 5 features
/forge:ship           # log release, measure quality, check stabilization triggers

# Founder mode (pre-PMF)
/forge:scout          # parallel community mining — Reddit, G2, HN, ProductHunt
/forge:interrogate    # Mom-Test interview protocol + mandatory Devil's Advocate
/forge:synthesize     # 1–5 confidence rubric with hard caps on weak evidence
/forge:graduate       # 12-criteria check; hand THESIS.md → IDENTITY.md
```

## What `/forge:shape` outputs (annotated)

```
═════════════════════════════════════════════════════
  FORGE — Release Plan v0.5
  Thesis: "Make multi-source incident investigation actually one-tool."
═════════════════════════════════════════════════════                      ← one-sentence release thesis

  FEATURES (5)                            AUTONOMY    SIGNAL                ← AUTONOMY: T1/T2/T3 from §5
  ───────────────────────────────────────────────────────                   ← SIGNAL: signal_id from harvest
  ✓ otel-log-correlation-in-query          T2          SIG-032
  ✓ unified-trace-metric-log-syntax        T2          SIG-031
  ⚠ trace-onboarding-wizard                T3          SIG-034              ← T3 because identity-adjacent
  ✓ engine-interface-consistency-debt      T1          SIG-035

  KILL LIST (10% Delete Rule fired ✗)                                      ← required, ≥10% of scope
  ───────────────────────────────────────────────────────
  ✗ legacy-prom-remote-write-shim          stale, no signal in 6 mo
  ✗ web-ui-dashboard-builder               low usage, evaluate=fail
  ✗ slack-bot-integration                  one customer, no growth

  DEVIL'S ADVOCATE                                                          ← 8 vectors, confidence-scored
  ───────────────────────────────────────────────────────
  ⚠ Cope Moat (conf 78): "OpenTelemetry-native" — Honeycomb is too. Differentiate?
  ⚠ Timeline Cope (conf 71): trace-wizard is 2 weeks of work disguised as 1
  ✓ Cherry-Picking (conf 89): clean — SIG-034 (challenging) included

  Run /forge:build to start. /forge:falsify to attack the plan harder.
═════════════════════════════════════════════════════
```

What didn't survive is in the kill list. What's still on fire is in the DA findings. **Forward the screenshot to whoever wants you to ship a feature you want to kill.**

## What `/forge:drift` catches (annotated)

```
## Drift Report — 2026-04-15

| Feature                    | WHO | JOB | NEVER | Arch | Contracts | Rework | Q  | Tier        |
|----------------------------|-----|-----|-------|------|-----------|--------|----|-------------|
| otel-log-correlation       | ✓   | ✓   | ✓     | ✓    | ✓         | ✗      | 9  | ✓ healthy   |
| unified-query-syntax       | ✓   | ✓   | ✓     | ✓    | ✓         | ✗      | 8  | ✓ healthy   |
| trace-onboarding-wizard    | ✓   | ✓   | ✓     | ✓    | ✓         | ✗      | 7  | ⚠ watch     |
| honeycomb-comparison       | ✗   | ✓   | ✓     | ✓    | ✓         | ✗      | 8  | ✗ drift     |  ← serves WHO? NO
| engine-interface-debt      | ✓   | ✓   | ✓     | ✓    | ✓         | ✗      | 9  | ✓ healthy   |

Stabilization indicators: avg quality 8.2, 0 REWORK, avg resets 0.4 → ✓ OK
Recommendation: DISCUSS (conf 84) — honeycomb-comparison doesn't serve WHO directly.
It's a sales asset, not a product feature. Worth doing — but log it as
type: "infrastructure" not type: "feature" next time.
```

## What Forge enforces

| Rule | How |
|---|---|
| 10% Delete Rule | Every `/forge:shape` proposes killing ≥10% of scope. Refuses to advance with an empty kill list. |
| Mandatory Devil's Advocate | Auto in every `/forge:shape`. Mandatory after every `/forge:interrogate`. Standalone via `/forge:falsify`. |
| Confidence threshold | DA findings below confidence 60 are filtered out by default (use `--all` to see them). |
| Drift checks every 5 features | Auto-fire during `/forge:build`. Cannot be silenced. |
| Stabilization triggers | Auto-fire on rework > 15% / blocked ≥ 3 / resets > 2 / quality < 6. Next release recommended debt-only. |
| 12-criteria graduation | Founder mode. ALL twelve. 11/12 = NOT READY. No partial. |
| Per-feature fresh context | Builder never carries context across feature boundaries. ~60k token ceiling. |

## What Forge does NOT enforce

| Layer | Why |
|---|---|
| What features are "right" | Forge interrogates plans; you decide what to ship. The framework is a sparring partner, not a referee. |
| Customer-discovery quality | The Mom-Test protocol is in the box. Following it during interviews is on you. |
| Identity correctness | Forge catches drift from your *stated* WHO/JOB/NEVER. If those are wrong, drift reinforces the wrong product. |
| Test correctness | The Test Writer follows your spec. Hollow spec → hollow tests. |

**The honest version:** Forge is a *harness*, not an oracle. It enforces discipline you've already decided you want.

## Token economy

Forge is a token-saving harness vs unguided agentic coding:

- **Bounded context per feature** — ~60k ceiling, never carries forward
- **`architecture.md` as a 500-token codebase map** instead of forcing the agent to re-explore 50KLOC
- **State files re-read between phases** (~3–5k tokens) instead of carrying full context forward
- **Drift checks catch rework before re-implementation** — the most expensive class of wasted tokens
- **Opus 4.7 (1M context) by default for every agent** — strategy and execution share the same model so quality stays consistent

Target: 60k tokens per feature build. Unguided agentic coding routinely runs 100k+.

### Where Sonnet earns its keep

Opus everywhere is the safe default. But **3 of the 9 agents are high-volume** and account for ~70–80% of token spend. Downgrading these to Sonnet cuts a typical 5-feature PM cycle from ~$25–50 → ~$5–10:

| Downgrade these to Sonnet | Why it's safe |
|---|---|
| **builder** | Code generation is well within Sonnet's range — and you already gate it with Opus-grade tests. |
| **test-writer** | Tight, repeatable patterns. Sonnet handles structured test generation reliably. |
| **market-scout** | Pulling Reddit / G2 / HN threads is text aggregation against a 7-signal taxonomy. |

Keep on Opus: orchestrator, devils-advocate, drift-detector, thesis-synthesizer, feature-breakdown, interview-architect.

Downgrade by editing `~/.claude/plugins/marketplaces/forge/plugins/forge/agents/<name>.md`, change `model: opus` → `model: sonnet`. Reverts on plugin update.

## Built on the Ralph Loop

The **Ralph Loop** is the agentic-coding pattern Forge inherits: pick a feature, write tests, build until green, evaluate, repeat — *with fresh context per feature so the agent can't context-rot itself across long runs*. The Loop is HOW TO BUILD.

Forge keeps the Loop and adds what's upstream: **market scouting, product thinking, mandatory falsification, drift discipline.** Forge decides WHAT to build — and what to kill.

## Case studies

- **[segspec](docs/case-studies/segspec.md)** — Static-analysis CLI in 5 awesome-lists, built in 8 weeks of part-time work. *The velocity case.*
- **[A delegation governance product](docs/case-studies/delegation-product.md)** — Multi-tenant SaaS through 4 release cycles, 2 identity evolutions, 1 stabilization save. Sanitized. *The depth case.*

<details>
<summary>5 worked examples with state-file snippets</summary>

- [01 — Pre-PMF SaaS, Founder-mode walkthrough](examples/01-pre-pmf-saas/README.md)
- [02 — Shipped product, PM mode (with stabilization)](examples/02-shipped-product/README.md)
- [03 — segspec, cycle zero](examples/03-segspec-cycle-zero/README.md)
- [04 — Delegation product, cycle zero (sanitized)](examples/04-delegation-product-cycle-zero/README.md)
- [05 — Falsifying an acqui-hire pitch](examples/05-acqui-hire-pitch-falsified/README.md)

</details>

## CLI cheat sheet

```bash
# Both modes
★ /forge:try              30-second magic-moment demo. Zero setup. Start here.
/forge:falsify            standalone DA against any plan, pitch, or PRD
/forge:init [--pm|--full] scaffold state files
/forge:cycle              run a full cycle, auto-routed by mode
/forge:status             one-screen state snapshot with contextual interpretation
/forge:help               orientation — start here if confused

# PM mode (Shipping)
/forge:harvest            collect signals + refresh architecture
/forge:shape              release plan + DA + 10% Delete Rule  ← hero command
/forge:build              Ralph Loop — autonomy tiers, drift checks
/forge:ship               log release, measure, check stabilization
/forge:drift              standalone drift audit on last 5 features

# Founder mode (Validating)
/forge:scout              community mining, 7-signal framework
/forge:interrogate        Mom-Test interviews + mandatory DA
/forge:synthesize         thesis synthesis with 1–5 confidence rubric
/forge:graduate           12-criteria check, hand off to PM mode
```

14 commands, 9 specialized agents, 10 contextual skills, 13 state-file templates.

## Self-falsification

We ran `/forge:falsify` on this README before shipping it. [Read the kill report.](docs/SELF-FALSIFICATION.md)

A framework that recommends adversarial falsification but doesn't run it on its own pitch is hypocritical.

## Empowered by Claude Code

Forge runs on [Claude Code](https://claude.com/claude-code) — Anthropic's terminal-native AI coding environment. Claude Code handles the model routing, tool orchestration, and plugin lifecycle. Forge handles the discipline.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development setup, the validator script, and how to submit changes. [Open an issue](https://github.com/dormstern/forge/issues) for bugs, requests, or to shape what comes next.

## License

[MIT](LICENSE)
