# Example 04 — Delegation governance product, cycle zero (sanitized)

A real example, sanitized. The author of Forge shipped a delegation governance product through 4 release cycles using this framework. Customer names, specific buyer interactions, and live competitive intelligence are removed; the *cycle dynamics* are real.

This example contrasts with [example 03](../03-segspec-cycle-zero/README.md): segspec is a one-shot CLI tool; this product is a multi-tenant SaaS with API contracts, multiple personas, and 4+ months of accumulated state. **Both run the same framework.**

## State at start of cycle 1

Working prototype: Next.js app, Postgres backend, browser automation adapter, policy engine, audit log. ~3,500 lines across 8 modules. Tests exist (60% coverage). A v0.1 deployed to a public URL. A handful of design partners.

The team is one founder + one part-time engineer.

`/forge:init`:

```
✓ Detected: Next.js + Prisma + Postgres
✓ Scaffolded: PM-mode templates
✓ contract_mode: "lightweight"  (REST APIs in /app/api/, OpenAPI doc in repo)
✓ Pre-filled IDENTITY.md from package.json + README — confirm:
```

## IDENTITY.md (cycle 1)

```markdown
## Primary Persona

WHO: An organization (typically 50–500 employees) deploying AI agents
     into SaaS applications they already use, where the org owns the
     account but the agent acts on its behalf.

JOB: When I deploy AI agents to act inside my SaaS accounts, I want
     policy-controlled access that scopes what they can do, audits
     what they did, and revokes instantly — so I stay in control
     without being in the loop.

NEVER:
1. Store credentials on our infrastructure (sessions are mediated)
2. Give delegates access beyond what was explicitly defined
3. Make the owner spend ongoing time managing delegation

## Architecture Constraints
- Browser session adapter pattern (provider is pluggable)
- Two-phase action reservation in serializable transactions
- Audit log is append-only, immutable, signed
- Token-based grants (JWT), never password sharing
```

The 3 NEVERs ended up shaping every drift check across the next 4 cycles.

## cycle 1 — first release

### /forge:harvest

8 signals across user pain, competitive moves, and tech debt. Highlights:

- HIGH user_pain: design partner's compliance team requires per-action audit (not session-level). *thesis_impact: confirms.*
- HIGH feature_request: per-action approval queue for high-risk actions.
- MEDIUM competitive: a major enterprise security vendor announces a related product.
- MEDIUM tech_debt: executor module has scattered try/catch blocks; needs centralization.

### /forge:shape (v0.1)

The hero card surfaced 5 features, ~15% debt paydown, and **3 kill-list items** — including "ghost-writer-posting" (a feature one customer requested but had no broader signal) and an integration spike that violated NEVER #2 by extending the agent's allowed actions.

The Devil's Advocate flagged Cope Moat: *"adapter pattern" isn't a moat, it's a feature. The wedge is policy-engine + audit-trail, not the adapter.* The team accepted this and rewrote the v0.1 thesis to lead with policy, not adapter.

### /forge:build (v0.1)

5 features built across 8 days. Quality scores 8–9 across all. One drift check at feature 5: CLEAR.

### /forge:ship (v0.1)

```
Features shipped: 5    Quality avg: 8.6    Rework: 0    Blocked: 0
Identity changes: none
Breaking changes: 0
Stabilization: ALL CLEAR
```

## cycle 2 — first identity evolution

A senior advisor (ex-CTO at a related enterprise security company) reframed the narrative: *"You're solving agent governance. The human-delegation use case is the credibility anchor, not the lead."*

This triggered an Identity evolution in cycle 2's SHAPE. The proposal:

```
PROPOSED IDENTITY EVOLUTION (v1.2)

WHO: NOW LEADS WITH "organizations deploying AI agents in SaaS apps."
     Human delegation is secondary persona, not primary.

Trigger: SIG-024 (advisor reframe), SIG-025 (4 competitive events in 2 weeks
all in the agent-governance space, not human delegation), SIG-026 (industry
analyst publicly articulating the agent-governance gap).

Rationale: The downstream signals all confirm — buyers see this as
agent-governance infrastructure, not delegation tooling. Continuing to
lead with human delegation cedes the agent-governance frame to competitors
who are happy to take it.

Risk: Loses credibility with the original design partners who came in for
human delegation. Mitigation: keep human delegation as secondary persona,
don't remove it.
```

The Product Lead approved. The Evolution Log was appended:

```
### v1.2 — 2026-02-XX
**Change:** WHO leads with organizations deploying AI agents.
**Trigger:** SIG-024, SIG-025, SIG-026
**Rationale:** All downstream signals confirm agent-governance frame.
**Risk:** Loses credibility with original DPs; mitigated by keeping
         human delegation as secondary persona.
**Approved by:** [Product Lead], 2026-02-XX
```

**Crucially: no code changed.** The identity evolution was a storytelling shift. The same code, same architecture, same product — different lead narrative. This is identity-as-signal in action.

## cycle 3 — stabilization

cycle 3 ran into 7 architecture-debt items. The drift detector fired STABILIZE: avg quality_score had dropped to 5.4, with 2 REWORK flags and a CONTRACT_HALT around an executor change that would have broken the adapter API.

The team paused all new feature work. v1.2.1 was a stabilization release: 7 debt items, 0 new features. Quality recovered to 8–9 by the end. The next normal release (v1.3) shipped 3 weeks later at the highest avg quality of any release.

## cycle 4 — drift detector catches narrative drift

cycle 4 added an "approval queue for high-risk actions" feature (T2). After 5 features, the drift detector flagged DISCUSS:

> *"Feature `approval-queue-mcp-actions` shipped in cycle 4 serves WHO and JOB but introduces a UX surface (manual approval UI) that risks violating NEVER #3: 'Make the owner spend ongoing time managing delegation.' If approval becomes the default rather than the exception, this feature has drifted."*

The team accepted the finding. They added a pattern to `progress.md`:

> *"Approval queue must be the exception, not the default. Default policy must be auto-approve for low-risk; queue is the audit trail's escalation path."*

This pattern then constrained every UI decision in cycles 5+.

---

**What this example shows:**

1. **Identity-as-signal works.** The cycle 2 evolution didn't change code; it changed positioning. The framework treated it as a deliberate event with a logged reason — not a slip-and-slide.
2. **Stabilization triggers save quarters.** cycle 3 would have shipped accumulated debt as broken features. The framework caught it 5 features in.
3. **NEVER lists do real work.** The cycle 4 drift finding wouldn't have surfaced without the explicit NEVER #3 — the framework checks every feature against it.
4. **Both segspec and a SaaS run the same cycle.** segspec's cycle was contract_mode="none" + simple state. This product was contract_mode="lightweight" + multi-persona. Same orchestrator, same Ralph Loop, same drift cadence.

**cycle artifacts in this directory** (sanitized):
- `IDENTITY.md` — the WHO/JOB/NEVER above
- `features.json` — 28 features across 4 cycles, sanitized
- `releases.json` — 4 releases + cycle 4 in-progress, signals sanitized
- `progress.md` — Cross-Cutting Patterns + Active Gotchas (sanitized)
- `architecture.md` — module structure (modules abstracted)
