# Awesome-list PR drafts

Four target lists, ordered by relevance and likelihood of acceptance. Don't submit all four at once — space them out 1–2 days apart so each PR gets attention on its own merit.

## 1. awesome-claude-code

**Repo:** https://github.com/hesreallyhim/awesome-claude-code
**Likelihood:** highest — Forge is exactly in scope (Claude Code plugin, MIT, useful)

**PR title:**

```
Add Forge — drift-protected agentic shipping plugin
```

**PR description / addition entry:**

Add to the **Plugins** section:

```markdown
- [Forge](https://github.com/dormstern/forge) — Vibe-coded plans go in,
  only what survives ships. Three filters every release runs through:
  Devil's Advocate before every plan, mandatory 10% Delete Rule, drift
  checks every five features. Then the Ralph Loop ships what survived.
  Two modes (Founder validation, PM shipping), 13 slash commands.
```

**PR body:**

```
This adds Forge to the Plugins section. Forge is a Claude Code plugin
for drift-protected agentic shipping — it runs every release plan past
a Devil's Advocate, enforces a 10% Delete Rule, and audits drift every
5 features before letting the Ralph Loop ship what's left.

Why I think it fits:
- It's a complete plugin (13 commands, 9 agents, 10 skills, 13 state-
  file templates), not a single skill
- MIT licensed, all source visible
- Has working demo GIFs in the README
- Two real products built on the discipline before it became a plugin
  (segspec — public, and a sanitized case study in the repo)
- The plugin dogfooded its own Devil's Advocate against its own README
  (docs/SELF-FALSIFICATION.md) before launch

I'm the author. Happy to adjust the description if you'd prefer
something more concise or a different framing.
```

---

## 2. awesome-ai-coding-tools

**Repo:** https://github.com/steven2358/awesome-generative-ai (or similar — search for the most-active aggregator)
**Likelihood:** medium — depends on whether they accept harness/methodology tools or strictly model wrappers

**PR title:**

```
Add Forge — release-cycle harness for agentic coding
```

**Entry:**

```markdown
- [Forge](https://github.com/dormstern/forge) — Release-cycle harness
  that wraps agentic coding loops with falsification, deletion, and
  drift discipline. Claude Code plugin, MIT.
```

---

## 3. awesome-claude-skills

**Repo:** https://github.com/awesome-claude-skills (or similar — there are several)
**Likelihood:** medium — Forge includes 10 contextual skills

**PR title:**

```
Add Forge plugin — 10 contextual skills for agentic shipping discipline
```

**Entry:**

```markdown
- [Forge plugin](https://github.com/dormstern/forge) — Plugin bundle of
  10 contextual skills for product management discipline:
  identity-anchor, ten-percent-delete, drift-protection, autonomy-tiers,
  stabilization, evidence-weighting, community-mining, founder-mode,
  pm-mode, using-forge.
```

---

## 4. awesome-product-management

**Repo:** https://github.com/dend/awesome-product-management (or similar)
**Likelihood:** lower — PM-list maintainers tend to skew non-technical and may not accept code tools

**PR title:**

```
Add Forge — agentic-coding harness for PM discipline
```

**Entry:**

```markdown
- [Forge](https://github.com/dormstern/forge) — Open-source release-
  cycle framework: Devil's Advocate before every plan, mandatory 10%
  scope kill, drift audits every 5 features. CLI plugin (Claude Code)
  but the underlying methodology applies to any product team.
```

**Note for Dor:** This one might land cleaner if you write a Substack/Medium piece on the *methodology* (the 10% Delete Rule, drift checks, evidence weighting) and submit *that* article instead of the tool. PM communities consume essays, not code.

---

## Submission cadence

- Day of launch: HN + tweet 1
- Day +1: awesome-claude-code PR
- Day +2: awesome-ai-coding-tools PR
- Day +3: awesome-claude-skills PR
- Day +4: methodology essay → awesome-product-management PR (if essay ready)

This staggers attention so each surface gets its own news cycle.
