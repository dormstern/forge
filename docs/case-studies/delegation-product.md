# Case study — a delegation governance product (sanitized)

The author of Forge shipped a delegation governance product through 4 release cycles using the same framework that became this plugin. Customer names, specific buyer interactions, and live competitive intelligence are removed; the cycle dynamics are real.

**The depth case.** Multi-tenant SaaS, multiple personas, 4+ months of accumulated state, real contract surfaces, real drift events.

## The shape of the product

- Next.js + Postgres + browser automation adapter
- 4 production releases shipped (v0.1 → v1.4)
- ~3,500 → ~9,000 LOC across 4 cycles, 8 modules
- contract_mode: "lightweight" — REST APIs documented in OpenAPI, breaking-change flags enforced
- Multi-persona: org-owning organization (primary) + delegate (secondary)
- Multi-tenant from day 1

## What Forge contributed across 4 cycles

### cycle 1 — Devil's Advocate caught the moat narrative

Initial v0.1 thesis led with the *adapter pattern* as the moat. Devil's Advocate flagged Cope Moat: adapter pattern is a feature, not a moat. The wedge was the policy engine + audit trail; the adapter was the credibility anchor.

The team rewrote the v0.1 release thesis to lead with policy. Subsequent positioning across every external conversation flowed from this reframe — caught at SHAPE time in cycle 1, before any of those conversations happened.

### cycle 2 — identity evolution as signal

A senior advisor (verifiable industry credibility) reframed the narrative: *"You're solving agent governance. Human delegation is the credibility anchor, not the lead."*

This is exactly the kind of feedback that, in most products, either:
- Gets ignored ("we know what we're building"), losing the signal, OR
- Causes panic-rebuilding ("the whole thesis is wrong"), wasting cycles.

The framework's response was structured: an Identity Evolution proposal in the next SHAPE, with explicit trigger evidence (3 signal IDs), rationale, and risk. The Product Lead approved, IDENTITY.md was updated, the Evolution Log got a new entry — and **no code changed.** The same product, different lead narrative.

That single evolution drove every subsequent positioning decision: the deck reframe, the demo flow, the buyer-interview script. All from a 30-minute SHAPE conversation.

### cycle 3 — stabilization triggers save the cycle

By feature 5 of cycle 3, drift indicators were firing:
- avg quality_score: 5.4
- 2 REWORK flags (a query path that was rewritten in cycle 2 was being modified again)
- 1 CONTRACT_HALT — an executor change would have broken the adapter API contract

The framework recommended STABILIZE. The team paused all new feature work. v1.2.1 was a stabilization release: 7 debt items, 1 CONTRACT_HALT resolution, 0 new features.

Quality recovered to 8–9 by end of cycle 3. v1.3 (the next normal release) shipped at the highest avg quality of any release in the project's history — 8.6 across 5 features, 0 rework, 0 blocked.

The cycle 3 stabilization was the load-bearing intervention. Without it, v1.3 would have shipped on top of accumulated debt, the rework rate would have compounded, and the project would have entered the "perpetual refactoring" doom loop that kills most products' velocity over time.

### cycle 4 — drift detector catches narrative drift mid-build

cycle 4 added an "approval queue for high-risk actions" feature (T2). 5 features in, drift detector flagged DISCUSS:

> *"Feature serves WHO and JOB but introduces a UX surface (manual approval) that risks violating NEVER #3 ('Make the owner spend ongoing time managing delegation'). If approval becomes the default rather than the exception, this feature has drifted."*

This was caught **before the feature shipped to production.** The team accepted the finding and added a pattern to `progress.md`:

> *"Approval queue must be the exception, not the default. Default policy must be auto-approve for low-risk; queue is the audit trail's escalation path."*

This pattern then constrained every UI decision in cycle 5 onwards. One drift report, one persistent rule, no narrative drift.

## What the cumulative state looks like

After 4 cycles:

- `IDENTITY.md`: 1 primary persona, 1 secondary, 3 NEVERs, 4 architecture constraints, **2 evolution log entries** (cycles 2 and 4 each evolved identity in response to specific signals).
- `features.json`: 28 cumulative features across 4 cycles. Avg quality 8.2. 2 features marked `rework_of`, both from cycle 3 pre-stabilization.
- `releases.json`: 4 releases logged with full metrics + thesis + identity changes. **38 signals** harvested across cycles, with `thesis_impact` distribution: 22 confirms, 12 null, 4 challenges, 0 invalidates.
- `progress.md`: 6 Cross-Cutting Patterns, 4 Active Gotchas, 4 Drift Reports — every one of which is now load-bearing for cycle 5+.
- `architecture.md`: 8 modules mapped, hot paths identified, 2 modules flagged for refactoring in cycle 5.
- `contracts.md`: 12 endpoints documented, 2 deprecation entries, 1 approved breaking-change with migration path.

## The transferable lesson

A SaaS product with multi-persona, multi-tenant, real API contracts, and 4 months of state is the *opposite* of what most "lean startup" frameworks contemplate. The framework didn't try to make this product "lean" — it made it **disciplined**:

- The NEVER list rejected drift before it shipped.
- The 10% Delete Rule killed features that had earned removal in every cycle.
- Stabilization triggers prevented the perpetual-refactoring death spiral.
- Drift checks every 5 features caught narrative drift in real time, not in a quarterly retro.
- Identity Evolution Log captured *why* the product changed — turning advisor feedback into a structured artifact, not a panic rebuild.

Across 4 cycles, the framework's contribution wasn't speed (some cycles ran longer than the team planned). The contribution was that **none of the 4 cycles produced a release the team regretted shipping.** That's not a small thing.

## See also

- [Example 04 — Delegation product, cycle zero](../../examples/04-delegation-product-cycle-zero/README.md) — sanitized walkthrough with state-file snippets
