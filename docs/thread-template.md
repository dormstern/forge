# Launch thread template (X / Twitter)

Pre-written 10-tweet thread. Fork it, swap [bracketed] placeholders, post.

**Hook tweet (1/10) — pin the hero GIF here:**

```
Vibe-coded plans go in. Only what survives ships.

Forge — three filters every release runs through:
1. Devil's Advocate attacks every plan before code exists
2. 10% of scope dies every release. Mandatory.
3. Drift checks every five features.

Then the Ralph Loop ships what survived. Open source.

[hero gif: /forge:shape output with kill-list + DA]
```

---

**2/10 — the 10% Delete Rule**

```
The single most-violated rule in product management:

Every release proposes killing ≥10% of scope.

Not optional. Forge refuses to advance with an empty kill list.

If you can't name 10% you should kill, you've never been honest with
the data. Run /forge:shape on a real project. The first kill list will
tell you something true.
```

---

**3/10 — drift**

```
Most agentic-coding tools tell you what to ship faster.

Forge is built around what to STOP shipping.

Drift checks every 5 features. Auto-audits whether each shipped feature
still serves your stated WHO / JOB / NEVER. Catches identity drift
before it compounds — which is the failure mode nobody catches in code
review.
```

---

**4/10 — Devil's Advocate**

```
The Devil's Advocate runs before every plan.

8 attack vectors:
- Cherry-Picking
- False Champion
- Cope Moat
- TAM Mirage
- Weak Wedge
- Timeline Cope
- Replicability
- Distribution

If your plan survives 5, you've earned the right to build.
Run /forge:falsify on any plan, pitch, or PRD — standalone, no setup.
```

---

**5/10 — autonomy tiers**

```
Three tiers for AI-built features:

T1 = auto-commit (debt, simple CRUD, tooling)
T2 = checkpoint before commit (most features)
T3 = checkpoint before tests AND commit (identity-adjacent, contract-breaking)

Stop fighting your agent. Start contracting with it.
```

---

**6/10 — token-efficient by construction**

```
Forge's harness is built to keep agentic builds inside the cache window:

- 60k context ceiling per feature (fresh context, never carries forward)
- architecture.md as a ~500-token codebase map vs re-exploring 50KLOC
- Drift checks catch rework before re-implementation
- All agents default to Opus 4.7 (1M context) — quality consistent across phases; downgradable per-agent if you want to optimize for tokens

You don't ship faster by typing faster. You ship faster by not throwing
the work away.
```

---

**7/10 — the 60-second demo**

```
60 seconds to first kill report:

$ claude plugin marketplace add dormstern/forge
$ claude plugin install forge@forge
$ /forge:init
$ /forge:harvest        # reads git log + signals
$ /forge:shape          # renders the kill card with DA findings

That last command is the screenshot. Try it on a repo you already know
the answer for. See if Forge agrees.
```

---

**8/10 — case studies**

```
Two products run on the same release-cycle discipline before it became a
public plugin:

@dormstern/segspec — Go CLI, 5 awesome-lists, 8 weeks part-time work
A delegation governance product (sanitized) — 4 release cycles,
2 identity evolutions, 1 stabilization save before launch

Same /forge:shape format, different scale. Read the case studies in the repo.
```

---

**9/10 — Founder mode**

```
Pre-PMF? You don't need shipping discipline yet — you need falsification
discipline. Forge has a second mode for that:

/forge:scout (community mining, 7 signal types, parallel scans)
/forge:interrogate (Mom Test interviews + mandatory DA)
/forge:synthesize (1-5 confidence with hard caps on weak evidence)
/forge:graduate (12-criteria handoff into PM mode when you're ready)

Behavioral evidence > stated intent. Always.
```

---

**10/10 — install + dare**

```
github.com/dormstern/forge
MIT, open source. Built on the Ralph Loop.

claude plugin marketplace add dormstern/forge
claude plugin install forge@forge

Two modes, 13 commands, 9 agents, 10 skills, 13 state-file templates.
Ships complete day one.

The dare: run /forge:falsify on a plan you're attached to. If it kills any of
your assumptions, screenshot it and reply. I want to see what survives.
```

---

## Notes for Dor (delete before posting)

- Hook tweet pins the GIF, gets the most leverage — record it crisp.
- Tweet 4 (the 8 attack vectors) is the most-quoted standalone unit. Make sure it reads without context — viewers should forward this one alone.
- Tweet 6 — the token-efficiency claim is *structural*, not quantified. The "40% savings" claim from the prior version was unverified; this version stays directionally honest without a falsifiable number.
- Tweet 8 — segspec is named, the delegation product is sanitized. Don't accidentally name it.
- Tweet 10 — "the dare" is the engagement hook. Lots of people will run /forge:falsify just to dunk on themselves. That's the magic moment.

## Twitter alt-text for the hero GIF

> "Forge's /forge:shape command renders a release plan: feature list with autonomy tiers, kill-list with reasons, and Devil's Advocate findings. ✗ KILL items in red, ⚠ WOUND in amber, ✓ SURVIVE in green."

## LinkedIn variant (if you want one)

```
After a decade shipping products — the last few with AI agents — I've
learned the agents aren't the bottleneck. The discipline around them is.

I built a Claude Code plugin that bottles release-cycle discipline into
13 commands. Founder-mode validation through PM-mode shipping.

Three filters every release runs through:
- Devil's Advocate attacks every plan before code exists
- 10% of scope dies every release (mandatory)
- Drift checks every five features

Then the Ralph Loop ships what survived.

Open source, MIT: github.com/dormstern/forge

If you ship products and use Claude Code: install, then /forge:init, then
/forge:shape on your current project. The first kill list will tell you
something honest about what you're actually building.
```
