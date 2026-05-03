---
name: identity-anchor
description: Use when defining or evolving WHO / JOB / NEVER for a product, or when interpreting drift in PM mode. Identity is the spine that drift checks audit against. Evolution Log is append-only and tracks every identity change with trigger evidence and rationale. Identity-as-signal, not identity-as-requirement.
---

# Identity Anchor

The Identity Anchor is the single most-load-bearing artifact in the framework. Every agent reads it before every task. It's the spine that drift checks audit against.

## The three fields

### WHO
A specific person in real context — **not a persona segment, not a demographic.**

❌ "Mid-market CISOs"
✓ "SOC analyst at a 50–200-person enterprise, handling 100+ alerts/day, reports to CISO who is non-technical"

The test: could you name three real people who match? If not, WHO is too abstract.

### JOB
JTBD form: **"When [trigger situation], I want to [action], so that [outcome]."**

❌ "Help users be more productive"
✓ "When a Sev-2 alert fires across three services, I want correlated traces+logs+metrics in a single timeline, so that I'm not Slack-switching between tools at 3am while the page is still firing"

The test: does it survive the JTBD four-forces analysis (Push / Pull / Anxiety / Habit)?

### NEVER
Off-limits categories. **Specific, not generic.**

❌ "Too complex"
✓ "Generic ticketing system" / "Read-write access to user credentials" / "Per-seat billing"

The test: would compromising on this make you indistinguishable from a competitor? If yes, it's a NEVER. If no, it's just a preference.

The founder-NEVER question (use during graduation):
> "Review your Competition section. What is the one thing that, if you compromised on it, would make you identical to the competitors you identified? That is your NEVER."

## The Evolution Log (append-only)

Every change to WHO / JOB / NEVER must append a new entry. **Never silently rewrite.** The log is the audit trail of how identity drifted *deliberately* in response to evidence.

```markdown
### v{N} — YYYY-MM-DD
**Change:** {what specifically changed in WHO / JOB / NEVER}
**Trigger:** {Signal IDs from releases.json or evidence IDs from evidence.json}
**Rationale:** {why this change reflects reality}
**Risk:** {what could go wrong; what we'd watch for}
**Approved by:** {Product Lead name + date}
```

## Identity-as-signal vs identity-as-requirement

A working IDENTITY.md is a **signal** — when reality contradicts it, you change one or the other. It's not a contract you defend forever.

**Drift check** (every 5 features in PM mode) audits each feature against:
- Does it serve WHO?
- Does it make JOB easier?
- Does it violate NEVER?

If 2+ features fail across last 5 → DRIFT. If a pattern → consider PIVOT (identity needs to evolve).

## When identity should evolve

- A signal arrives with `thesis_impact: "invalidates"` and the evidence is strong (≥2 weight-3 sources)
- The drift detector recommends PIVOT after a pattern of DRIFT
- An interview reveals a different WHO is actually buying / using
- A competitor's move forces a NEVER refinement

## When identity should NOT evolve

- A single signal with `thesis_impact: "challenges"` from one source — that's a signal, not a verdict.
- Pricing pressure from one buyer who isn't your WHO.
- A feature request that contradicts NEVER — that's the NEVER doing its job.
- Quality decline (avg quality_score < 6.0) — that's a stabilization issue, not an identity issue.

## Architecture Constraints (optional, in IDENTITY.md)

Hard technology decisions that shape every feature. Up to 5 bullets. Examples:
- "Audit log is append-only — every action ships as an immutable event"
- "Credentials are session-mediated, never stored — provider tokens only"
- "Multi-tenant from day 1 — no shared schema across tenants"

These are NEVERs at the implementation layer. Drift detector audits against them too.

## How agents use identity

- Every feature build starts with the agent reading WHO/JOB/NEVER (~50 tokens — cheap).
- The `feature-breakdown` agent rejects features that don't trace to a signal that serves WHO.
- The `drift-detector` agent audits every feature against all three fields.
- The `devils-advocate` agent attacks the NEVER itself: "Is this a real moat or a stated preference?"

## Tip: pre-fill on /forge:init

`/forge:init` reads your project's `package.json` description and `README.md` first paragraph and proposes a draft WHO/JOB/NEVER. Mark every pre-fill `[DRAFT — confirm or rewrite]` so you remember to interrogate it. **A pre-filled identity is the worst identity** — it's confident-looking but unvalidated.
