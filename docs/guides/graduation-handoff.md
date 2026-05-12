# Graduation handoff — Founder → PM

When the 12 graduation criteria are met, `/forge:graduate` hands off the validated thesis to PM mode. This guide covers what gets generated and how to decide when to actually graduate.

## The 12 criteria

ALL twelve must be met. 11/12 = NOT READY. No partial graduation.

```
[ ] Problem confidence ≥ 4
[ ] Pricing confidence ≥ 4
[ ] Purpose confidence ≥ 3
[ ] Market confidence ≥ 3
[ ] Wedge confidence ≥ 3
[ ] Competition confidence ≥ 3
[ ] Defensibility confidence ≥ 3
[ ] No invalidated P1 hypotheses
[ ] DA: no existential risks (incl. moat stress test)
[ ] ≥ 12 interviews across ≥ 3 segments (no segment > 40%)
[ ] ≥ 3 real commitments obtained (time, money, or reputation)
[ ] Confidence trajectory: stable or increasing over last 2 cycles
```

## What "real commitment" means

Time: signed up for a beta with a calendar invite.
Money: paid pilot, deposit, contract signed (not "would be willing to").
Reputation: introduced you to a colleague (skin in the game).

NOT a commitment: "sounds interesting", "happy to try it", "let me know when it's ready", LinkedIn connection request.

## What `/forge:graduate` produces

Four artifacts:

### 1. Draft `IDENTITY.md`

The thesis-synthesizer drafts:

- **WHO** ← THESIS Problem section, specific persona
- **JOB** ← in JTBD form: *"When [trigger], I want [action], so that [outcome]"*
- **NEVER** ← from Competition + Wedge + Defensibility, surfaced via the founder-NEVER question:
  > "Review your Competition section. What is the one thing that, if you compromised on it, would make you identical to the competitors you identified? That is your NEVER."
- **Architecture Constraints** ← optional, derived from technical decisions in THESIS.md Defensibility section.

You review and finalize.

### 2. Initial signals (seeded into `releases.json`)

Validated hypotheses become signal entries in PM-mode `releases.json` `current_cycle.signals` with `thesis_impact: "confirms"`. Each carries the original evidence IDs from `evidence.json`.

This is the link between Founder mode's evidence base and PM mode's release-cycle signal stream — the framework doesn't lose context.

### 3. Feature priority seeds (`features.json`)

High-confidence + high-pain hypotheses become first-cycle feature candidates. Each pre-filled with `signal_id` and `requested_by` (the interview ID + segment).

These aren't auto-approved features — they're priority *seeds*. Your first PM `/forge:shape` will decide what actually ships.

### 4. Graduation Brief

A short markdown doc (`GRADUATION_BRIEF.md`) covering:

- **Top 3 risks** (from DA findings — these inform future drift checks)
- **Open questions** (from `progress.md` — things you'll continue investigating)
- **Pricing signals** (specific WTP data — Van Westendorp output, paid pilot ACV, willingness ranges)
- **Competitive moat** (the NEVER's evidence — which competitors you're explicitly diverging from and why)
- **DA findings** that should seed future drift checks

The brief becomes the first entry in PM mode's `progress.md` under "Architecture Decisions" + "Open Questions."

## When NOT to graduate (even if 12/12 met)

Two valid reasons to delay:

1. **Trajectory is stable but flat.** If your confidence scores haven't moved in 2 cycles, you may have hit a methodology ceiling — same questions, same answers. Run one more cycle with a *new investigation focus* (the synthesizer's "weakest section" report tells you where).

2. **Commitments are thin.** 3 commitments from 3 acquaintances ≠ 3 commitments from 3 strangers. Distinguish "people who'd commit anyway" from "people who chose to commit because of *this* specifically."

## When to graduate even if 11/12

You don't. The framework is explicit: 11/12 = NOT READY.

The temptation is real — you've done the work, you're tired, you want to ship. The cost of premature graduation is months of building the wrong product.

If you're 11/12, identify the missing criterion, design the smallest possible cycle to close that gap (often 1 week, 3–4 interviews), and graduate then.

## After graduation

Don't immediately abandon Founder-mode files. Keep them as the historical record. They're what your `progress.md` references when the drift detector asks "did we already invalidate this hypothesis?" 

Specifically, `evidence.json` and `interviews.md` from Founder mode become the source of truth for "why did we make this decision back then?" — useful both for drift checks and for future investor conversations.

## When to drop back into Founder mode

Rare but valid:

- A signal arrives in PM mode with `thesis_impact: "invalidates"` and the evidence is strong (≥2 weight-3 sources from independent segments).
- The drift detector recommends PIVOT after a pattern of DRIFT.
- A major market or competitive event invalidates a Defensibility assumption.

In any of these cases, you can pause PM mode, drop into a single Founder cycle to validate the new thesis, and re-graduate.

This is rare because it's *expensive* — you stop shipping to validate. But "ship through invalidation" is the more expensive path. The framework gives you the option deliberately.

## See also

- [examples/01-pre-pmf-saas/README.md](../../examples/01-pre-pmf-saas/README.md) — full Founder-mode walkthrough including a graduation event
- [skills/identity-anchor/SKILL.md](../../skills/identity-anchor/SKILL.md) — WHO/JOB/NEVER deeper dive
- [skills/founder-mode/SKILL.md](../../skills/founder-mode/SKILL.md) — full Founder cycle reference
