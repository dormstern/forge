# Founder Quickstart

Run your first Forge in Founder mode. ~30 minutes setup, then 2–4 weeks per cycle.

## Are you in the right mode?

You're in Founder mode if any of these are true:

- You haven't shipped a product yet, OR
- You've shipped but you're not sure WHO is buying or WHY, OR
- You're considering quitting your job for this idea, OR
- Your last 3 customer-discovery conversations confused you more than they helped.

If you're shipping a known-product to a known-WHO, switch to [PM mode](pm-quickstart.md) instead.

## 30-minute setup

```sh
$ cd your-project
$ claude plugin marketplace add dormstern/forge
$ claude plugin install forge@forge
$ /forge:init --founder
```

`/forge:init --founder` scaffolds 7 state files into your project root:

| File | What it holds |
|---|---|
| `THESIS.md` | 7 sections (Purpose, Problem, Market, Wedge, Competition, Defensibility, Pricing) — each with confidence 1/5 |
| `hypotheses.json` | Empty — populated by `/forge:scout` |
| `evidence.json` | Empty — populated by `/forge:scout` and `/forge:interrogate` |
| `cycles.json` | cycle 1 in progress, phase: SCOUT |
| `interviews.md` | Empty — populated by `/forge:interrogate` |
| `landscape.md` | Empty — populated by `/forge:scout` |
| `progress.md` | Empty — fills with patterns + dead ends as you go |

**Edit `THESIS.md` first.** The pre-fill is a draft. Spend 15 minutes writing your honest current best-guess for the 7 sections. Don't worry about confidence yet — every section starts at 1/5.

## Your first cycle (2–4 weeks)

### Week 1 — `/forge:scout`

```
$ /forge:scout
```

The market-scout agent scans Reddit, G2, Hacker News, ProductHunt, Crunchbase. Extracts 7 signal types: pain, frequency, severity, willingness-to-pay, competitor, trend, contradictory.

You get a SCOUT report with verbatim community quotes, source URLs, contradictory signals (mandatory), and 3–5 new hypotheses backed by ≥2 signals each.

**Your job:** read the contradictory signals carefully. They're more valuable than supporting evidence. Then pick 5–8 interviewees to test the highest-priority hypotheses.

### Week 2–3 — `/forge:interrogate`

```
$ /forge:interrogate          # generates the protocol
[ you conduct 4–8 interviews ]
$ /forge:interrogate          # paste transcripts; agent analyzes
```

The interview-architect generates 10–15 Mom Test + JTBD questions, each traced to a hypothesis. After your interviews, paste the transcripts back. The agent extracts JTBD four-forces (Push/Pull/Anxiety/Habit), tags evidence by weight (behavioral=3, mixed=2, stated-intent=1), and flags false positives.

Then **the Devil's Advocate runs automatically** — DA-Lite for cycles 1–2, DA-Full for cycles 3+.

**Your job:** read the DA report. Decide which attacks are valid. The framework will refuse to advance until you do.

### Week 3 — `/forge:synthesize`

```
$ /forge:synthesize
```

The thesis-synthesizer integrates new evidence, scores per-section confidence on the 1–5 rubric (with hard caps — single source type → cap 3), audits unsupported / weak / contested claims, appends an Evolution Log entry to `THESIS.md`, identifies the weakest section.

**Your job:** accept or challenge the scores. **Conservative scoring is the default.** Argue *up* only if you have specific evidence.

### End of cycle — decide

```
$ /forge:graduate         # checks 12 criteria
```

If 12/12 met → handoff to PM mode. If not → recommend the smallest possible next cycle to close the gap.

11/12 = NOT READY. No partial graduation.

## What you'll learn in cycle 1

Most founders learn one of three things from cycle 1:

1. **The thesis is right.** Confidence scores climb across the board. Continue to cycle 2.
2. **The thesis is wrong but the problem is real.** PIVOT — keep the WHO/Problem, change the wedge or the pricing.
3. **The thesis is wrong and the problem isn't real.** KILL. This is a valid outcome. Document thoroughly in `progress.md` Dead Ends so future-you doesn't re-explore.

Outcome 2 is the most common. Outcome 3 is less common but more valuable when it happens — you've saved yourself months of building the wrong thing.

## What NOT to do in cycle 1

- Don't build product. The framework is explicit: validate before you build.
- Don't run more than 8 interviews per cycle. You'll over-fit on noise.
- Don't skip the Devil's Advocate. The framework will refuse to advance, but you might be tempted to override.
- Don't inflate confidence scores. The synthesizer is calibrated for conservative scoring; trust it.
- Don't remove contradictory evidence. It's the most-valuable data in `evidence.json`.

## When you should switch modes mid-validation

Rarely. But if your THESIS Problem confidence hits 4 in cycle 1 *and* you have 3 paid pilots committed, you may be ready to ship a v0 in parallel with cycle 2.

Don't graduate prematurely — finish at least 2 cycles. But you can run a tiny PM cycle alongside cycle 2 for the first 2-3 features that test demand. Keep `THESIS.md` as the source of truth; `IDENTITY.md` is a sub-set of it.

## Reading order on your first day

1. [skills/founder-mode/SKILL.md](../../skills/founder-mode/SKILL.md) — full cycle walkthrough
2. [skills/evidence-weighting/SKILL.md](../../skills/evidence-weighting/SKILL.md) — the 1–5 rubric and hard caps
3. [skills/community-mining/SKILL.md](../../skills/community-mining/SKILL.md) — the 7-signal framework
4. [agents/devils-advocate.md](../../agents/devils-advocate.md) — the 8 attack vectors
5. [examples/01-pre-pmf-saas/README.md](../../examples/01-pre-pmf-saas/README.md) — a worked example
