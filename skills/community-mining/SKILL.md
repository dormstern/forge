---
name: community-mining
description: Use during Founder mode SCOUT to extract structured signals from public communities. The 7-signal framework (pain, frequency, severity, willingness-to-pay, competitor, trend, contradictory) applied across Reddit, G2, Hacker News, ProductHunt, Crunchbase. Verbatim quotes only. Contradictory signals mandatory. Bottom-up TAM only.
---

# Community Mining

Community mining is structured listening. You scan public communities for evidence of pain, willingness-to-pay, competitor moves, and trend direction — then merge them into hypotheses backed by ≥2 independent signals.

## The 7-signal framework

Every community pass extracts these seven signal types:

| Signal | What to look for | Weight if found |
|---|---|---|
| **Pain** | Complaints, workarounds described, time/money wasted, "every time I have to..." | High |
| **Frequency** | Recurring posts, temporal patterns ("every Monday"), repeated complaints across users | Medium |
| **Severity** | Emotional intensity ("I'm losing my mind"), quantified business impact ("cost us $40K") | High |
| **Willingness-to-Pay** | "I'd pay for...", current vendor spend mentioned, budget discussions | Critical |
| **Competitor** | Tools mentioned, switching stories, comparison threads, churn reasons | High |
| **Trend** | Growing/declining discussion volume, new entrants, shifting sentiment over months | Medium |
| **Contradictory** | "Not a problem", "Already solved", pushback, "you're overthinking this" | **Mandatory** |

## Communities to scan

Scan ≥3 per cycle. Read **comments**, not just headlines — signals live in replies.

### General

- **Reddit** — 3–5 relevant subreddits + keyword search. Read top 30 comments per thread, not just top 3.
- **G2 Reviews** — 1-star and 3-star reviews of incumbent tools. Skip 5-star (signal-poor for *what's missing*).
- **Hacker News** — keyword search, Ask HN + Show HN, read full comment threads.
- **ProductHunt** — competitor launch comments + adjacent products.
- **Crunchbase** — funding trends as investor-conviction proxy.
- **Twitter/X** — keyword + advanced search; favor threads over tweets.

### B2B Enterprise add-ons

- Gartner Peer Insights, TrustRadius, LinkedIn Groups, PeerSpot.

### Cybersecurity add-ons

- r/cybersecurity, r/netsec, Dark Reading, SecurityWeek, CyberScoop, CISO Series podcast notes, RSA/Black Hat session content, SANS Reading Room, PeerSpot.

## Parallel execution

Community scans are embarrassingly parallel — independent WebFetch calls per source. Run them simultaneously. After all complete:

1. **Merge and deduplicate signals** (multi-source signals weighted higher).
2. **Preserve ALL contradictory signals.** Never drop them as outliers.
3. **Resolve conflicting competitor data** using the most recent source.

## Signal extraction format

Per signal:

```markdown
| Signal ID | Type | Source | URL | Date | Verbatim Quote | Hypothesis |
| SIG-NNN | Pain | r/devops | https://… | YYYY-MM-DD | "exact quote, no paraphrasing" | H-NNN |
```

**Verbatim or nothing.** Paraphrasing introduces interpretation. The quote IS the evidence.

## Contradictory signals are mandatory

Every SCOUT pass must surface contradictory signals. If your scan returned zero pushback on the hypothesis, **your scan was incomplete.** People disagree about everything on the internet — if no one's disagreeing about your hypothesis, you're searching wrong.

The market-scout agent will refuse to produce a SCOUT report without contradictory signals.

## Bottom-up TAM only

Compute as `(target buyer count in segment) × (deal size you can credibly extract)`. No analyst reports. No top-down BCG numbers.

Example: "12,000 SOC managers at companies of 500-5,000 employees in North America × $25K/year average ACV = $300M TAM". Each multiplier is checkable. The "300M" is bottom-up.

Top-down ("the cybersecurity market is $200B") tells you nothing about your reachable revenue.

## Per-competitor analysis

Every competitor mentioned 2+ times in scans gets:

```markdown
### [Name]
Category: Direct | Indirect | Adjacent
Founded / Funding / Target customer
Features / Pricing / Positioning
Strengths (evidence-based, with sources)
Weaknesses (evidence-based, with sources)
Why they might win  ← REQUIRED
Counter-positioning assessment
Community sentiment (verbatim quotes with URLs)
```

The "Why they might win" is the load-bearing field. Every competitor must have one. If you can't articulate why a competitor might win, you don't understand the landscape.

## Hypothesis generation rules

1. New hypotheses require **≥2 independent signals** from different sources.
2. Every hypothesis has `falsification_criteria` — specifically what evidence would disprove it. **REQUIRED.**
3. Hypotheses are categorized: problem | pricing | market | wedge | competition | defensibility | buying_process.
4. Priority: P1 (existential) | P2 (important) | P3 (nice to validate).

## Common mistakes

- **Reading top-level posts only.** Discussions are in the replies.
- **Filtering for confirmation.** "I searched for [problem] and found 100 people complaining about it" — you searched for the answer you wanted.
- **Treating one Reddit thread as a source type.** Reddit + G2 + HN are still one source type collectively (community mining). Triangulate against interviews.
- **Skipping contradictory signals.** They're not noise. They're the most important data in the scan.
- **Top-down TAM.** "$200B market" is meaningless. Bottom-up or skip.
- **Paraphrasing quotes.** Verbatim or nothing.

## How the market-scout agent enforces this

The [market-scout](../../agents/market-scout.md) agent will refuse to:

- Generate a hypothesis from <2 independent signals
- Use top-down TAM
- Skip the contradictory section in the SCOUT report
- Paraphrase community quotes
- Mark a competitor without "Why they might win"

When the agent surfaces a SCOUT report, you can trust the structure. The judgment about which signals matter is yours.
