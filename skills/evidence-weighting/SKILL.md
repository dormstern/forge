---
name: evidence-weighting
description: Use during Founder mode INTERROGATE / SYNTHESIZE, or whenever evaluating evidence quality. Weight 3 = behavioral (past actions, artifacts shown). Weight 2 = mixed. Weight 1 = stated intent ("I would use"). Confidence scoring caps: single source type → max 3, all stated intent → max 3, ≥4 requires ≥50% behavioral + ≥3 source types, 5 requires behavioral + commitments. Conservative scoring is the default.
---

# Evidence Weighting & Confidence Scoring

Evidence is the currency of Founder mode. Confidence scores are denominated in evidence — and the rubric is brutal because most founders inflate confidence on stated intent and call it validated.

## The three evidence weights

| Weight | What qualifies |
|---|---|
| **3** — Behavioral | Past actions. Artifacts shown. Commitments made. Money spent. Workarounds built. Tools currently used. The interviewee *did* something. |
| **2** — Mixed | Some past behavior, partially vague. "We've thought about this several times" → maybe behavioral, maybe imagined. "I tried [X] last year" but no detail on outcome. |
| **1** — Stated intent | "I would use it." "Sounds useful." "I'd pay for that." "We're planning to do this." Pure speculation about future behavior. |

**The hardest rule:** future intent is NEVER weight 3. Even if the interviewee is enthusiastic. Even if they "really mean it." Past behavior > stated intent. Always.

## What weight 3 actually looks like

- "I built a Python script three months ago to do this manually. Want to see it?" (artifact + past action)
- "We pay [Vendor] $40K/year for this. The contract is in renewal in March." (money spent + commitment)
- "I switched from [Tool A] to [Tool B] in January because [Tool A] couldn't handle [problem]. Here's the migration log." (past action + reason + artifact)
- "I've been emailing this to my team every Monday for the last 8 months." (workaround + frequency)

## What weight 1 actually looks like

- "I would absolutely use that."
- "That sounds like something I'd pay for."
- "We need a tool exactly like this."
- "Yes, this is a major problem in our industry."
- "Everyone I know would use this."

If you're nodding along when you read those, you're seeing why this rule exists. They feel persuasive in the moment. They mean nothing.

## Confidence scoring rubric (1–5)

| Score | Label | Evidence required |
|---|---|---|
| 1 | Speculation | None — gut feel only |
| 2 | Weak Signal | 1–3 data points, single source type |
| 3 | Moderate Evidence | 4–7 data points, multiple source types, contradictions addressed |
| 4 | Strong Evidence | 8–12 data points, diverse sources, contradictions explained or refuted |
| 5 | Validated | 13+ data points, behavioral evidence, commitments obtained |

## Hard caps (non-negotiable)

These caps override the count-based rubric. Even if you have 50 data points:

- **Single source type → cap at 3.** 50 Reddit comments is still one source type. Diversify.
- **Two source types → cap at 4.** Reddit + interviews still isn't enough.
- **Unaddressed contradictions → cap at 3.** If contradictory evidence exists in `evidence.json` and you haven't explained it, you don't get above 3.
- **All stated intent (no behavioral) → cap at 3.** Even with 50 stated-intent quotes, you're at 3 max.
- **≥4 requires ≥50% behavioral evidence AND ≥3 source types.** Both, not either.
- **5 requires behavioral evidence AND commitments.** "I love this idea" doesn't count. "Here's $5K for a POC" does.

## Source-type diversity

Source types include:
- Customer interviews (one segment counts as one source type)
- Community mining (Reddit, G2, HN — collectively one source type unless explicitly diversified)
- Sales calls / outbound conversations
- Behavioral data from existing products
- Competitor analysis
- Expert opinions (low weight regardless)
- Industry analyst reports (lowest weight)

Three source types means you're triangulating. One source type is an echo chamber.

## Conservative scoring is the default

When in doubt, score lower. Reasons:

- **Asymmetric error cost.** Underestimating confidence costs you a few extra interviews. Overestimating costs you a wrong product.
- **Confirmation bias is invisible.** You can't tell when you're cherry-picking; the synthesizer can.
- **Behavioral evidence is rare.** Most evidence is stated intent. Calibrate accordingly.

The synthesizer agent is *literally instructed* to choose the lower score when ambiguous. Trust it.

## Trajectory matters more than snapshot

A confidence score of 3 that climbed from 2 last cycle is more valuable than a confidence score of 4 that's been flat for 3 cycles. **Stagnation across 2+ cycles → methodology review. Decline across 2+ cycles → consider PIVOT or KILL.**

The synthesizer tracks trajectory automatically and alerts on stagnation/decline.

## Common mistakes

1. **Counting one customer's 12 quotes as 12 evidence points.** It's one customer. Count once or weight at most 2.
2. **Treating an enthusiastic interview as weight 3 because the *interviewer* felt good.** Weight is about what the *interviewee did*, not about how the conversation felt.
3. **Removing contradicting evidence from `evidence.json` because it's "outlier."** Never. Contradicting evidence is *more* valuable than supporting evidence — it's where you'll learn.
4. **Inflating Pricing confidence because one buyer said "we'd pay $X."** Stated intent on pricing is the most-inflated number in early-stage thinking. Cap at 3 unless you have actual purchase orders.
5. **Skipping Van Westendorp because "we know our pricing."** You don't. Run it.

## How the synthesizer enforces this

The [thesis-synthesizer](../../agents/thesis-synthesizer.md) refuses to advance unsupported claims and applies the hard caps automatically. It also:

- Counts behavioral vs stated-intent evidence per section
- Counts source-type diversity per section
- Flags UNSUPPORTED / WEAK / CONTESTED claims
- Logs every confidence change with evidence IDs in the Evolution Log
- Refuses to increase a score without new evidence

Conservative scoring is enforced by the agent, not just by guidance.
