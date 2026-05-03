# Example 05 — Falsifying an acqui-hire pitch

A worked example of `/forge:falsify` against a high-stakes artifact: an acqui-hire pitch for a small (1–3 person) AI tools startup talking to a major platform company.

The pitch is fictional but composite — built from patterns the author has seen across multiple founder-meets-acquirer conversations. The Devil's Advocate output is what `/forge:falsify` actually produces against this kind of input.

## The pitch (input to `/forge:falsify`)

```
SUBJECT: [Startup] — joining [BigCo Security Group]

[Startup] has built an AI-native browser automation platform that lets
enterprises deploy autonomous agents inside SaaS applications with
governance, audit, and revocation. We've validated the problem with
12 design partners across 3 segments and have signed pilot agreements
worth $400K ARR.

We see a strategic fit with [BigCo]'s security platform: our governance
primitives (policy engine, audit trail, two-phase action reservation)
plug into your existing identity and access management surface.
Together, we can ship "RBAC for AI agents" — what every enterprise
deploying agents will need by 2027.

The team:
- [Founder] — 10 years in enterprise security, ex-[CompanyA], ex-[CompanyB]
- [Co-founder] — engineering lead, ex-[CompanyC]

We're looking for an acqui-hire structure that retains the team and
the IP, with a 24-month earn-out tied to enterprise rollout milestones.

Asking $X.
```

## /forge:falsify output

Run as a `DA-Plan` against this artifact. The agent dispatches with the standard 8 attack vectors plus enterprise-specific ones.

```
═════════════════════════════════════════════════════
  DEVIL'S ADVOCATE — Kill Report
  Target: "[Startup] — joining [BigCo Security Group]"
  Attacks: 9   Killed: 3   Wounded: 4   Survived: 2
═════════════════════════════════════════════════════

✗ KILL — Cope Moat
  "Two-phase action reservation" and "policy engine" are features, not
  moats. A funded incumbent ships these in 6–8 weeks. The actual
  defensibility — if any — is the ADAPTER PATTERN that lets your
  governance primitive cover SaaS surfaces the incumbent doesn't have.
  Lead with adapter coverage, not policy primitives.
  Cheap test (≤48h): list 3 named SaaS surfaces you cover that BigCo
  doesn't reach today. If the list is empty, the moat doesn't exist.

✗ KILL — False Champion
  "Strategic fit with BigCo Security Group" — name the specific exec
  who would champion this internally. If you can't, you don't have a
  champion. You have a contact. The pitch reads like cold outreach
  with hope dressed as conviction.
  Cheap test: forward this email to your warmest contact at BigCo and
  ask "who should this go to?" If they don't have a name, you don't
  either.

✗ KILL — Timeline Cope
  "Plug into your existing IAM surface" — this is 6 months of
  integration engineering, not a kit-bash. BigCo's IAM has 4 product
  lines, 12 teams, and a roadmap committee. "Plug in" implies a week.
  Reality is a quarter to scope, two quarters to ship.
  Cheap test: ask any BigCo PM what their last "small" IAM
  integration with an external partner took. The answer is 6+ months.

⚠ WOUND — TAM Mirage
  "RBAC for AI agents" is a real category but the TAM you're implying
  is the full IAM market. The actual reachable wedge is "RBAC for AI
  agents in SaaS your existing IAM doesn't cover." That's a 5–10%
  slice. Acquirers price the wedge, not the dream.
  Cheap test: redo the TAM section bottom-up — 3 specific SaaS surfaces
  × N enterprises adopting agents in those surfaces × ACV. Numbers.

⚠ WOUND — Weak Wedge
  Your pilot agreements ($400K ARR) prove pain is real but don't prove
  durable demand. 12 DPs with paid pilots ≠ a wedge. The wedge is
  whether DPs renew at higher price after the pilot ends. You're 6
  months too early to claim a wedge.
  Cheap test: include renewal commitments in the pitch, not pilot
  signatures. If they don't exist, name the date you'll know.

⚠ WOUND — Replicability
  BigCo's PSIRT or CASB team could build your policy engine in a
  weekend internally. The reason they haven't is they didn't think
  agents-in-SaaS was their problem yet. Your timing is the moat. Don't
  describe it as technical defensibility — describe it as positional.
  Cheap test: rewrite the strategic-fit paragraph to lead with
  "we've built the adapter coverage you'd otherwise have to build
  yourself, faster than your roadmap can absorb."

⚠ WOUND — Distribution
  You have product. Where's the channel? Acquirers want signal that
  you've found a repeatable distribution. 12 DPs in 3 segments is
  founder-led sales, not distribution. Show one channel that closes
  without the founder on the call.

✓ SURVIVE — Cherry-Picking
  Pitch is honest about pilot status (not claiming production
  revenue). Includes the team's prior employers as verifiable
  context. Doesn't overclaim AI-magic. Clean.

✓ SURVIVE — CISO Tenure Risk (B2B vector)
  Founder has 10 years in enterprise security and prior-company
  history. The team is credible to a CISO buyer. The risk is that
  CISO turnover hits a champion mid-deal — but that's an industry
  fact, not a pitch flaw.

═════════════════════════════════════════════════════
  Existential risks (must address before sending):
  1. False Champion — name the BigCo exec, or this email is a cold
     contact dressed as a warm one.
  2. Timeline Cope — rewrite the integration timeline honestly.
     Acquirers detect timeline cope in seconds.
  3. Cope Moat — replace the policy/two-phase/audit list with the
     adapter coverage list. THAT's the moat.

  Non-existential (worth fixing):
  - TAM Mirage, Weak Wedge, Distribution

  Bottom line: REWRITE before sending. The current draft will be
  filed in the "interesting but not urgent" pile.

  Run the 3 KILL cheap tests in the next 48 hours.
═════════════════════════════════════════════════════
```

## What this output enables

The founder can now do three concrete things in the next 48 hours:

1. **Name the BigCo exec** by forwarding the draft to their warmest contact and asking who it should actually go to.
2. **Rewrite the integration timeline** with honest scope — the acquirer's PM team will validate it within 5 minutes of getting the email.
3. **Replace the moat language** with adapter coverage — concrete SaaS surfaces, not features.

If they can't do (1) — name a champion — they don't send the email at all. They go find one first.

The kill report is the artifact you forward to your most honest advisor with the question "did I miss anything?" The pre-mortem is the section you re-read after the meeting to explain *why* it went the way it did.

## Why falsifying a pitch is different from falsifying a plan

A release plan failing means you ship the wrong thing for one cycle. A pitch failing means you burn the only credible introduction to a single acquirer for the next 12 months. **The asymmetry is the entire reason `/forge:falsify` exists.** You'd rather kill the draft on your laptop than send it.
