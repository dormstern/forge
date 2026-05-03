# Self-falsification — running `/forge:falsify` on Forge's own README

The framework recommends running Devil's Advocate against your own pitch before you ship it. This document is the kill report on Forge's launch README — performed during Day 6 verification, before the public launch.

The point of publishing this is twofold: (1) demonstrate the dogfood, and (2) show readers what `/forge:falsify` actually catches when run against a real artifact, not a contrived example.

---

## The target

Forge's [README.md](../README.md) and [thread-template.md](thread-template.md), as of v0.1.0, plus the implied positioning of "drift-protected agentic shipping for Claude Code."

## Devil's Advocate kill report

```
═════════════════════════════════════════════════════
  DEVIL'S ADVOCATE — Kill Report
  Target: "Forge v0.1 launch README + thread"
  Attacks: 8   Killed: 1   Wounded: 4   Survived: 3
═════════════════════════════════════════════════════

✗ KILL — Cope Moat
  "Drift-protected agentic shipping" is a positioning, not a moat. The
  underlying primitives (state files, autonomy tiers, drift checks)
  are reproducible by any motivated competitor in 4–6 weeks. The
  framework's defensibility, if any, is (a) the operating discipline
  the user develops over multiple cycles and (b) the cumulative state
  files that capture institutional learning. Neither is a network
  effect. Neither survives a well-funded clone.

  Cheap test (≤48h): show the framework to one Cline / Continue /
  Aider committer and ask "could you ship this in 4 weeks?"
  If the answer is yes — and it almost certainly is — you're
  competing on first-mover + community + content quality, not on a
  moat.

  How to address: don't *claim* moat in the README. Lead with
  "drift-protected agentic shipping" as positioning. Frame
  defensibility as "operating discipline + first-mover community,"
  which is honest about what v0.1 actually offers.

⚠ WOUND — Timeline Cope
  README implies cycles are 1–4 weeks. Realistic for a single
  developer on segspec-shaped projects; aspirational for multi-person
  teams on enterprise-shaped products. The delegation product case
  study admits some cycles ran longer; the README doesn't surface
  this. New users will calibrate to the README, hit week 6 of cycle 1,
  and quietly stop using the plugin.

  Cheap test: ask 3 people who try Forge in week 1 — "how long do
  you expect cycle 1 to take?" If the median answer is <14 days,
  they're going to be disappointed.

  How to address: README should explicitly say "cycle 1 takes 1–4
  weeks for solo on focused scope; longer for teams." Underpromise.

⚠ WOUND — Weak Wedge
  "Don't vibe-code your way to PMF" is a great hook, but the wedge
  *delivered* in v0.1 is methodology + state-file management +
  Devil's Advocate. The first two are commodity (any framework can
  copy them); the third is the actual wedge. Lead with DA harder
  in the hook tweet — the kill report is the screenshot, not the
  release plan.

  How to address: maybe. Trade-off: leading with DA narrows the
  audience to "people who are about to ship a plan." Leading with
  the release plan widens to "people running cycles." The current
  positioning is the wider one. Acceptable if v0.1 launches with
  the DA front-and-center in the demo GIF.

⚠ WOUND — Distribution
  "/plugin install dormstern/forge" assumes the user is in Claude
  Code. Distribution beyond Claude Code's plugin marketplace is
  unaddressed. The Codex / Cursor variants are mentioned as Day-14
  plans but not shipped on Day 0. Half the engineering audience
  uses Cursor or Codex; they bounce.

  Cheap test: post the launch tweet and check the first 50 replies
  for "is there a Cursor version?" If >5 ask, distribution is
  bottlenecked.

  How to address: ship the Codex variant on Day 7, not Day 14.
  Add a note in README: "Codex / Cursor support coming in v0.2."

⚠ WOUND — Cherry-Picking (the framework attacking itself)
  Both case studies (segspec + delegation product) are projects by
  the framework's author. There is zero independent third-party
  validation of the framework's value as of v0.1. The framework is
  asking the reader to trust that "this works on real products"
  while showing only artifacts the author can't be neutral about.

  Cheap test: solicit 3 unaffiliated users to run cycle 1 on their
  own projects and document outcomes within 2 weeks of launch.

  How to address: include independent case studies in v0.2.
  Acceptable for v0.1 to ship with author-only proof, since the
  alternative (delaying launch until 3rd-party proof exists) cedes
  the launch window.

✓ SURVIVE — False Champion
  No claim of acquirer interest, no "Anthropic recommended this,"
  no name-dropping. Pitch leans on the framework's own discipline
  rather than borrowing other entities' credibility. Clean.

✓ SURVIVE — TAM Mirage
  README does not claim TAM. Doesn't promise viral growth, doesn't
  claim X% of Claude Code users will adopt it. Soft positioning is
  honest. Clean.

✓ SURVIVE — Replicability (already KILL'd as Cope Moat above —
  noting here for completeness)

═════════════════════════════════════════════════════
  Existential risks (must address before launch):
  1. Cope Moat — remove moat-language from v0.1 positioning;
     reframe as "operating discipline" + "first-mover community."
     Defensibility, if any, accrues from accumulated state files
     and operating practice, not from v0.1 primitives.

  Non-existential (worth addressing in launch + week 1):
  - Timeline Cope — add realistic cycle-duration disclaimer to README
  - Weak Wedge — consider promoting DA as the lead in hook tweet
  - Distribution — ship Codex variant on Day 7 not Day 14
  - Cherry-Picking — recruit 3 independent case studies in week 2

  Bottom line: SHIP, with these adjustments:
  1. Remove moat language from README; replace with "operating
     discipline" + "ecosystem positioning."
  2. Add explicit cycle-duration realism note in README FAQ.
  3. Move Codex variant from Day 14 to Day 7 launch checklist.
  4. Recruit 3 unaffiliated users in week 2 for case-study proof.

═════════════════════════════════════════════════════
```

## What got fixed in response

Per the framework's own discipline (a kill report you ignore is worse than no kill report):

- [x] **Cope Moat fix** — README's positioning audited; "moat" not used. Confirmed clean. (This kill is preventative.)
- [x] **Timeline Cope fix** — FAQ added: "cycle 1 typically takes 1–4 weeks for a solo developer on focused scope; teams on enterprise-shaped products often run longer. Don't compare to the README's optimistic numbers — calibrate after your own cycle 1."
- [ ] **Distribution fix** — Codex / Cursor variants targeted for v0.2.
- [ ] **Cherry-Picking fix** — recruit unaffiliated users for independent case studies.

The Cope Moat language audit is the one existential item; complete. Distribution and Cherry-Picking are tracked for v0.2.

## Why publish this

A framework that recommends adversarial falsification of *other people's* pitches but doesn't run it on its own README is hypocritical. Publishing the kill report is the dogfood — and the kill report itself is more credibly a "magic moment" demo than any contrived example would be.

If you're reading this and you're a potential user: yes, the framework's author thinks the framework's own positioning has weaknesses. The framework caught them. Forge isn't selling perfection; it's selling structured honest interrogation.
