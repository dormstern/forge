# PM Quickstart

Run your first Forge in PM mode on a shipped product. ~15 minutes setup, then 1–4 weeks per cycle depending on scope.

## Are you in the right mode?

You're in PM mode if all of these are true:

- You've shipped a v0 (or further) of your product, AND
- You can name a specific WHO who's actively using it, AND
- You know roughly why people pay (or would pay) for it.

If any of those are wrong, [Founder mode](founder-quickstart.md) is the right starting point.

## 15-minute setup

```sh
$ cd your-project
$ claude plugin marketplace add dormstern/forge
$ claude plugin install forge@forge
$ /forge:init
```

`/forge:init` scaffolds 6 state files into your project root:

| File | What it holds |
|---|---|
| `IDENTITY.md` | WHO/JOB/NEVER + Architecture Constraints + Evolution Log |
| `features.json` | Cumulative feature backlog |
| `releases.json` | Release history + current_cycle (signals, phase, plan) |
| `progress.md` | Patterns, gotchas, drift reports, learnings |
| `architecture.md` | Module hierarchy, hot paths, blind spots |
| `contracts.md` | API/schema/event commitments (opt-in via `contract_mode`) |

**The pre-fill is a draft.** `/forge:init` reads your `package.json` description and `README.md` first paragraph and proposes a draft WHO/JOB/NEVER. Edit it. **A pre-filled identity is the worst identity** — confident-looking but unvalidated.

The hardest field is NEVER. Use the founder-NEVER question:

> "Review your competition. What is the one thing that, if you compromised on it, would make you identical to those competitors? That is your NEVER."

## Your first cycle

### Day 1 — `/forge:harvest`

```
$ /forge:harvest
```

The orchestrator asks you for raw signals: feedback, analytics, tickets, competitive moves, internal observations from the last cycle. It also auto-mines your git log + open issues + recent PR descriptions.

Each signal gets categorized (user_pain / feature_request / usage_pattern / production_health / tech_debt / competitive / rework), assessed for `thesis_impact` (null / confirms / challenges / **invalidates**), and structured into `releases.json`.

**Pause:** review the signal summary. Invalidations get prominent flagging — they're the signals that might require an identity evolution.

### Day 1 — `/forge:shape` (the hero command)

```
$ /forge:shape
```

The orchestrator proposes a release plan with:

- **Thesis** (1 sentence)
- **Identity evolution** — only if signals warrant. Trigger + rationale + risk.
- **Feature candidates** — each with `signal_id`, `requested_by`, `intent`, autonomy tier (T1/T2/T3)
- **Debt paydown (~15%)**
- **Kill list (≥10%)** — the 10% Delete Rule. **Mandatory.**
- **Contract implications** (if `contract_mode != "none"`)
- **Appetite** — what's NOT included
- **Stabilization check** — auto-fires on rework>15%, blocked≥3, resets>2, quality<6

The Devil's Advocate runs automatically against the plan. Top 2–3 attacks surface inline.

The output is the [hero card](../../README.md) — screenshottable, monospace, ✓/⚠/✗ markers.

**Pause:** approve, modify, or kill the cycle. Run `/forge:falsify` if you want harder DA attacks before approving.

### Days 2–N — `/forge:build`

```
$ /forge:build
```

The Ralph Loop runs:

```
SELECT next feature → TEST (3–7 acceptance tests) → BUILD (fresh context, max 3 resets) → EVALUATE
```

Autonomy tiers determine pause behavior:

- **T1** — auto-commit. You see the build run, then a "feature done" summary.
- **T2** — checkpoint before commit. Most features.
- **T3** — checkpoint before tests AND commit. Identity-adjacent / contract-breaking.

Every 5 features, the drift detector fires automatically. CONTINUE / DISCUSS / PIVOT / CONTRACT_HALT recommendation. The framework pauses on anything other than CONTINUE.

### Last day — `/forge:ship`

```
$ /forge:ship
```

Contract validation, architecture refresh, release log, stabilization-trigger check for next cycle.

**Pause:** read the release report. The next `/forge:harvest` starts the next cycle.

## What `contract_mode` to start with

| Mode | When |
|---|---|
| `"none"` | CLI tool, single binary, no public API. |
| `"lightweight"` | You have a REST API or schema, you want breaking-change flags but no full deprecation registry. **Most products start here.** |
| `"full"` | You have public APIs with paying customers depending on stability. Migration paths required for breaking changes. |

You can upgrade `contract_mode` between cycles. Don't downgrade.

## cycle cadence

Most teams settle into 2–4 week cycles. Some land at weekly. Anything longer than 6 weeks suggests scope is too big — split.

Stabilization releases run faster — typically half the duration of a normal release.

## What NOT to do in cycle 1

- Don't skip the kill list. If you can't find 10% to kill, lower your bar — kill the toggle nobody flips, the experiment from the bake-off, the feature one customer asked for last year.
- Don't approve every feature in SHAPE without inspecting. The Devil's Advocate findings are worth 30 seconds of your attention each.
- Don't ignore stabilization triggers. The framework recommends; you can override; but the cost of overriding is usually a quarter of accumulated debt.
- Don't auto-commit (T1) features that touch IDENTITY.md or contracts. Bump them to T2 or T3.
- Don't skip drift checks. They auto-fire every 5 features for a reason.

## Reading order on your first day

1. [skills/pm-mode/SKILL.md](../../skills/pm-mode/SKILL.md) — full cycle walkthrough
2. [skills/identity-anchor/SKILL.md](../../skills/identity-anchor/SKILL.md) — WHO/JOB/NEVER + Evolution Log
3. [skills/ten-percent-delete/SKILL.md](../../skills/ten-percent-delete/SKILL.md) — the 10% rule
4. [skills/autonomy-tiers/SKILL.md](../../skills/autonomy-tiers/SKILL.md) — T1/T2/T3 decision tree
5. [skills/drift-protection/SKILL.md](../../skills/drift-protection/SKILL.md) — the 6-check audit
6. [skills/stabilization/SKILL.md](../../skills/stabilization/SKILL.md) — the 4 auto-triggers
7. [examples/02-shipped-product/README.md](../../examples/02-shipped-product/README.md) — a worked example
