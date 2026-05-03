# Show HN draft

Submit at: https://news.ycombinator.com/submit

## Title (80 char max)

```
Show HN: Forge – Vibe-coded plans go in. Only what survives ships.
```

Alternates if the first feels too edgy:

```
Show HN: Forge – A Claude Code plugin that runs every release plan past a Devil's Advocate
Show HN: Forge – Drift-protected agentic shipping for Claude Code
```

## URL

```
https://github.com/dormstern/forge
```

## Text (the comment that posts as the first reply)

```
Hi HN,

I've been building products with Claude Code for the past year and kept
hitting the same failure mode: agents would happily ship 9 features when
the right answer was to ship 3 and kill 2 others. Vibe coding produces
features. It doesn't produce the *right* features.

Forge is the harness I built to fix that. It's a Claude Code plugin
that runs three filters before every release:

1. **Devil's Advocate** — attacks every plan with 8 vectors (Cherry-
   Picking, False Champion, Cope Moat, TAM Mirage, Weak Wedge, Timeline
   Cope, Replicability, Distribution). If the plan survives 5, you've
   earned the right to build it.

2. **The 10% Delete Rule** — mandatory. Every release proposes killing
   ≥10% of scope. Refuses to advance with an empty kill list.

3. **Drift checks every 5 features** — auto-audits whether each shipped
   feature still serves your stated WHO/JOB/NEVER. Catches identity drift
   before it compounds.

Then the Ralph Loop ships what survived.

It also has a Founder mode for pre-PMF work — community-mining scout,
Mom-Test interview architect, evidence weighting (behavioral > stated
intent), 12-criteria graduation gate.

State files live in your repo as plain Markdown + JSON. Nothing hosted,
nothing proprietary. Two modes, 13 slash commands, 9 specialized agents,
10 contextual skills, 13 state-file templates, MIT.

Two products were built on this discipline before it became a plugin:
github.com/dormstern/segspec (named) and a delegation governance product
(sanitized in the repo's case study).

I dogfooded the framework on its own README — the kill report is in
docs/SELF-FALSIFICATION.md. It found one existential issue (Cope Moat
language) which is now fixed, and three wounds I addressed inline.

Repo: https://github.com/dormstern/forge

Curious for feedback, especially: which attack vector should I add to
v0.2's Devil's Advocate? The current 8 cover the failure modes I've
hit, but I know there are more.
```

## Posting checklist

- [ ] All three demo GIFs render in the README on github.com (verify on a fresh browser, not your local cache)
- [ ] CI badge is green (`gh run list --repo dormstern/forge --limit 1`)
- [ ] Self-falsification doc still publicly visible
- [ ] Repo description on GitHub matches the README hook
- [ ] Star the repo from your own account so the count isn't 0 at submission

## Timing

- Post Tuesday or Wednesday morning US-eastern (peak HN window)
- Don't post Friday or weekend
- Stay near the front page for 60 minutes after posting to respond to early comments
