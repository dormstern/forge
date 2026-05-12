# Example 01 — Pre-PMF SaaS (Founder mode walkthrough)

A worked example of running Founder mode through 3 cycles on a fictional pre-PMF product: **InboundIQ**, an "AI inbox triage assistant for senior ICs at engineering companies."

The example shows what `THESIS.md`, `hypotheses.json`, `evidence.json`, the SCOUT report, the Devil's Advocate output, and the synthesizer's confidence updates *actually look like* in practice.

## The setup

Founder Daisy has been running InboundIQ as a side project for 6 weeks. She's done 4 informal interviews and has a working prototype. She wants to validate before quitting her job. She runs `/forge:init --founder`.

```
$ /forge:init --founder
✓ Detected: empty project, no existing state files.
✓ Scaffolded: Founder-mode templates (THESIS.md, hypotheses.json, evidence.json, cycles.json, interviews.md, landscape.md, progress.md)
✓ Pre-filled THESIS.md Purpose section [DRAFT — confirm or rewrite]
   → Edit THESIS.md, then run /forge:scout to start cycle 1.
```

## cycle 1 — finding out the original hypothesis is wrong

### THESIS.md (cycle 1, before SCOUT)

```markdown
## Purpose — Confidence: 1/5
Belief: Senior ICs at engineering companies waste 4+ hours/week triaging
inboxes that have grown beyond what humans can handle.

## Problem — Confidence: 1/5
WHO: Senior software engineers at companies of 100–500 engineers, getting
50+ inbound emails / DMs / mentions per day.
JOB: When my inbox crosses 30 unread items, I want an AI to triage by
priority and surface the 5 things that need my attention today.
```

### After /forge:scout (cycle 1)

The market-scout returns 24 signals. Highlights:

- **Pain (HIGH):** r/cscareerquestions thread "I cannot keep up with my inbox" — 380 upvotes, 145 comments. *Verbatim:* "I genuinely got better at coding when I gave up on inbox zero."
- **Contradictory (MANDATORY):** HN thread "AI email triage products keep failing" — top comment 412 upvotes. *Verbatim:* "The problem isn't volume. The problem is that I don't trust the AI to decide what's important."
- **Competitor:** Superhuman, SaneBox, Shortwave. All B2C-leaning. None positioned as IC-specific.
- **Trend:** Discussion volume up 80% over the past 6 months on r/programming + HN.

The scout flags **3 hypotheses** based on ≥2 signals each:

```json
[
  {"id": "H-001", "statement": "Senior ICs spend ≥3 hrs/week on inbox triage", "priority": "P1"},
  {"id": "H-002", "statement": "ICs distrust AI-priority decisions even when accurate", "priority": "P1"},
  {"id": "H-003", "statement": "ICs would pay $20–50/mo for IC-specific triage", "priority": "P2"}
]
```

### After /forge:interrogate (cycle 1)

Daisy conducts 4 interviews. The interview-architect's transcript analysis flags:

- **3 / 4 interviewees showed past behavior** of building manual filters / Gmail rules → H-001 supported (weight 3 × 3).
- **All 4 interviewees expressed distrust of "AI deciding for me"** when asked about priority. *Verbatim from one:* "If the AI marks something low-priority and I miss it, that's on me but the consequences land on the relationship." → H-002 STRONGLY confirmed.
- **0 / 4 committed to paying.** Daisy attempts commitment escalation; all decline. → H-003 weakened.

### Devil's Advocate report (cycle 1, DA-Lite)

```
## DA Report — cycle 1

### Hypothesis attacks
H-001: SURVIVES (4 weight-3 evidence, contradicting addressed)
H-002: SURVIVES + STRENGTHENED (the "distrust" finding is the wedge)
H-003: KILLED — 0/4 commitments. Pricing thesis is currently speculation.

### Pre-mortem (5 scenarios)
- Pricing: ICs won't expense $20/mo themselves; need company-paid → existential
- Market timing: every email tool is adding AI; window is 12 months → existential
- Distribution: ICs don't browse SaaS; how do you reach them? → existential
- ...

### Bottom Line
PIVOT recommended: the wedge isn't "AI triage" (commodity), it's
"trust-preserving triage" — surface priorities WITHOUT auto-archiving.
Investigate this in cycle 2.
```

### /forge:synthesize (cycle 1)

The thesis-synthesizer updates THESIS.md with confidence scores:

```markdown
## Purpose — Confidence: 2/5  (was 1)
[Same content — needed evidence, got 4 weight-3 sources]

## Problem — Confidence: 3/5  (was 1)
WHO: Refined to "senior ICs (L5+) at companies of 100–500 engineers,
who get on-call rotation alerts mixed with team DMs"
JOB: When my inbox crosses 30 unread items in tools where the consequences
of missing one are reputational (DMs, on-call, manager 1:1s), I want
priority surfaced WITHOUT auto-archiving — so I keep responsibility but
remove the bottleneck.

[Note: JOB explicitly addresses the H-002 "distrust" finding]

## Pricing — Confidence: 1/5  (was 1)
Cap at 1 — 0 commitments obtained. Investigate company-paid models.
```

Daisy decides to CONTINUE.

## cycle 2 — finding the buyer

After cycle 2 (skipping the detail), Daisy has interviewed 5 more ICs and 3 engineering managers. Highlights:

- **Engineering managers said:** "I'd pay for this for my team if it reduced 1:1 prep time" (weight 3, behavioral evidence: one already pays for Lattice for similar reasons).
- **3 commitments obtained** — 2 EMs willing to pilot if Daisy ships in 4 weeks; 1 EM willing to pay $10/seat/mo for a 5-person team trial.
- **Pricing model shifted** from individual ($20/mo) to team ($10/seat/mo). Revised Pricing confidence: 3/5.

## cycle 3 — graduation

Daisy adds 6 more interviews (mix of EMs and ICs across 3 segments). cycle 3 results:

```
Confidence Summary (post-cycle 3):
  Purpose:       4/5  (12 supporting evidence, ≥3 source types)
  Problem:       4/5  (15 evidence, behavioral majority, contradictions addressed)
  Market:        3/5  (bottom-up TAM: 80K eng managers in NA × $1.2K ACV = $96M)
  Wedge:         3/5  (trust-preserving — verified contrast with Superhuman/SaneBox)
  Competition:   3/5  (5 direct, 8 indirect, all "why they might win" filled)
  Defensibility: 3/5  (data moat from team-context training)
  Pricing:       4/5  (4 commitments at $10/seat/mo, Van Westendorp run)

Interviews: 15 across 4 segments (max 33% in one segment)
Commitments: 4 (1 paid pilot, 2 free pilots, 1 intro-to-other-EM)
Trajectory: confidence increasing across all sections over 2 cycles
```

`/forge:graduate` runs:

```
✓ All 12 graduation criteria met.

Drafted IDENTITY.md:
  WHO: Engineering manager at a 100–500-engineer company, managing 5–8
       senior ICs, spends ≥4 hrs/week in 1:1s, currently pays for Lattice
       for retention/perf, looking for ways to reduce prep load.
  JOB: When I'm preparing 1:1s, I want a triaged view of my reports'
       blocked-on-me threads, surfaced WITHOUT auto-archiving — so prep
       takes 10 minutes, not an hour, and I don't miss anything important.
  NEVER: Auto-decide what someone sees / doesn't see. Charge per-message.
         Become a generic email triage tool.

Seeded 3 features: 1:1-prep-view, blocked-on-me-detection, weekly-team-pulse
Seeded 5 signals into PM-mode releases.json

Run /forge:init (PM mode) and then /forge:harvest to start the first PM cycle.
```

---

**Time invested in Founder mode:** 3 cycles, ~6 weeks part-time. Daisy now has a thesis with confidence ≥3 in every section, ≥4 in Problem and Pricing, and 4 commitments. She quits her job in week 7.

The full state files for this example would live in this directory in a real install. They're intentionally sketched here, not committed — the point is showing the *journey through artifacts*, not the artifacts in isolation.
