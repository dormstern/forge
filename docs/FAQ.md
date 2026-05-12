# FAQ

Real questions, real answers. Voice matches the rest of Forge — declarative, dry, anti-fluff.

## Setup

### Will `/forge:init` overwrite my state files?

No. `/forge:init` is intentionally idempotent — it refuses to overwrite any file that already exists. Re-run it as many times as you want; it'll skip every existing file and tell you so. Safe to run on an active project that's been through multiple cycles.

### How does Forge know which mode (Founder vs PM) I'm in?

By which state file exists at your project root, not a flag stored anywhere:

- `THESIS.md` (or `THESIS-minimal.md` / `THESIS-full.md`) → **Founder mode**
- `IDENTITY.md` → **PM mode**
- Both → Forge asks
- Neither → Forge prompts you to run `/forge:init`

The SessionStart hook checks for these files every time you open Claude Code in your project, which is why you'll often see Forge route you to `/forge:status` instead of `/forge:init` — the bootstrap is a no-op once any anchor file exists.

### Can I switch modes mid-product?

Yes. Founder → PM happens via `/forge:graduate` (12-criteria check). PM → Founder is rarer but legal — drop into Founder for one cycle when a signal arrives with `thesis_impact: "invalidates"`, then graduate back. The mode is just a function of which files exist.

### What if I have both `IDENTITY.md` and `THESIS.md`?

Forge asks which mode to run, every cycle. Useful if you're validating one part of a shipping product. Annoying if you forgot to delete an old state file — in which case, just delete the one you don't want.

### Can I run `/forge:init` in the wrong directory?

Yes, but it won't break anything. `/forge:init` only writes 6–7 small Markdown / JSON files into the current directory. Delete them if you scaffolded in the wrong place.

### Are state files supposed to be committed to git?

Your call. Both work:
- **Commit them** → Claude (and your team) see the same product memory across machines and branches. Drift reports become reviewable in PRs. Default for most users.
- **`.gitignore` them** → if they contain unreleased thinking you want to keep private (early-stage Founder mode, sensitive customer signals, etc.).

They're plain text — not encrypted, not proprietary, no Forge-internal opcodes. You can read them in any editor.

## Cycle mechanics

### Can I skip the 10% Delete Rule "just this once"?

No. `/forge:shape` refuses to advance with an empty kill list. If literally nothing should be killed, write a one-line "kill list: nothing — explanation: X" and Forge will accept it. The forcing function is **interrogation**, not deletion-for-its-own-sake. Empty kill lists are a smell, not an option.

### What if my plan survives 0/8 Devil's Advocate attacks?

Probably fine — but verify with `/forge:falsify --all` (which surfaces low-confidence findings too) before celebrating. A 0/8 result with `--all` showing genuine survives is rare enough to be a positive signal. A 0/8 result without `--all` could mean the plan is too vague to attack — see the Falsifiability Index at the bottom of the kill report.

### What happens when drift checks fire mid-`/forge:build`?

The cycle pauses. The drift report renders with severity badges (✓ healthy / ⚠ watch / ✗ drift) plus a recommendation (CONTINUE / DISCUSS / PIVOT / CONTRACT_HALT). For anything but CONTINUE, Forge waits for you to decide before resuming. CONTRACT_HALT is the only one that actually blocks — the others surface for review.

### Can I edit a release plan after `/forge:shape`?

Yes. The plan lives in `releases.json`'s `current_cycle.approved_plan`. Edit the file directly and re-run `/forge:status` to see the updated plan. Forge reads the file every command, doesn't cache.

### What if I disagree with a drift recommendation?

Override it. The drift report is a *recommendation*, not a gate (except for CONTRACT_HALT). The Evolution Log in IDENTITY.md is where you record "drift detector flagged X but I'm shipping anyway because Y" — append-only audit trail of overrides.

### What if `/forge:build` fails on a feature?

The Ralph Loop allows up to 3 resets per feature. If all 3 fail, the feature is marked `status: "blocked"` in features.json with a `blocked_reason`. Forge moves on; you can address blockers in the next cycle's HARVEST. Quality scores don't penalize blocks — they penalize *rework*.

## Cost & performance

### How much does a typical PM-mode cycle cost?

With all 9 agents on Opus 4.7 (1M context): roughly **$25–50 for a 5-feature release**.

With builder + test-writer + market-scout downgraded to Sonnet (the recommended cost optimization): **$5–10 for the same 5-feature release**.

Token savings vs unguided agentic coding: ~40% from bounded-context-per-feature alone, plus the cost of avoided rework (which is the most expensive class of wasted tokens).

### Why Opus by default and not Sonnet?

Quality consistency across phases. Strategic decisions (drift, falsification, synthesis) need Opus; high-volume execution (build, test-writer, scout) is fine on Sonnet. The default optimizes for fewer surprises, not lowest cost. See "Where Sonnet earns its keep" in the README for the per-agent downgrade table.

### Can I run `/forge:build` async / overnight?

Yes. The Ralph Loop is fresh-context-per-feature with checkpoints between features. Start `/forge:build` and let it run — T1 features auto-commit, T2/T3 pause for your review when you come back. Drift checks fire every 5 features and pause for review.

## Plugin mechanics

### Does Forge work with Cursor / Codex?

Not yet. v0.1 ships as a Claude Code plugin only. The *methodology* (state files + cycle phases + the three filters) is portable; the *auto-triggering plugin format* isn't. Cursor and Codex variants are unblocked but not committed to a date.

### Can I customize agent prompts?

Yes. After install, agent files live at `~/.claude/plugins/marketplaces/forge/plugins/forge/agents/<name>.md`. Edit any one. Changes revert on plugin update — re-apply after `claude plugin install forge@forge`.

### Will state files break if Forge updates?

No. State-file schemas are the contract. Forge versions are backwards-compatible at the state-file layer; the framework can change internally but your `IDENTITY.md` / `features.json` / `releases.json` will keep working.

### Can I use Forge in a monorepo?

Yes. Run `/forge:init` at the root if you want one cycle for the monorepo, or per-package if you want independent cycles. State files stay where you put them; agents read from the project root by default.

### Is this just a wrapper for "play devil's advocate" prompt?

No. Devil's Advocate is one of 9 specialized agents, with 8 codified attack vectors, confidence-scored output (0–100, threshold-filtered at 60 by default), and an evidence-weight rubric (behavioral = 3, mixed = 2, stated-intent = 1). Plus the cycle harness, drift discipline, state-file persistence, autonomy tiers, stabilization triggers, and the 10% Delete Rule — none of which a "play devil's advocate" prompt provides.

The Devil's Advocate prompt-as-a-service is a 5-line prompt anyone can write. Forge is the harness around it that makes it part of a release-cycle discipline.

### How do I update Forge?

```bash
claude plugin install forge@forge
```

Re-installing pulls the latest `marketplace.json` from `dormstern/forge` (the default-branch HEAD). State files in your project are untouched.

### Is Forge open source? Can I fork it?

Yes. MIT license. Fork it, rewrite the agent prompts, ship your own variant. The state-file schemas are the load-bearing contract — keep those compatible if you want users to be able to switch between forks without losing memory.

## Distribution

### Why isn't Forge in the Anthropic-official marketplace yet?

Submission was filed via [clau.de/plugin-directory-submission](https://clau.de/plugin-directory-submission). Approval is async (1–7 days). Until then, install via the self-hosted marketplace pointer at `dormstern/forge` (works identically — Anthropic's review is a curation step, not a functional gate).

### Where do I report bugs or request features?

[github.com/dormstern/forge/issues](https://github.com/dormstern/forge/issues). Bug reports with a reproducer + Claude Code version are most useful.
