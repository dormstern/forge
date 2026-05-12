# [⚡ EDIT BELOW — replace every [bracketed] section with your own answer. Delete the [EXAMPLE] sections after.]

# Identity Anchor

The spine of your product. Every Forge agent reads this before every task. Three questions — answer them concretely. Vague answers produce vague drift checks.

## WHO

The specific person you build for. Not a segment. Not "developers." A real role in a real context.

[YOUR ANSWER HERE]

[EXAMPLE: A founding engineer at a 5–30-person Series-A SaaS who's just become responsible for a SOC-2 audit they've never run.]

## JOB

What WHO is hiring your product to do, in JTBD form: *When [trigger], I want to [action], so that [outcome].* Falsifiable. Specific.

[YOUR ANSWER HERE]

[EXAMPLE: When a Sev-2 fires across three services, I want correlated traces+logs+metrics in one timeline, so I'm not Slack-switching between five tools at 3am.]

## NEVER

Categories of work that are explicitly out of scope. The list a competitor would happily build that you refuse to. Saying NO is a strategy.

[YOUR ANSWER HERE]

[EXAMPLE: Never a separate dashboard product. Never on-prem. Never paid plugins.]

## Architecture Constraints (optional — max 5 bullets)

Hard technology decisions that shape every feature. Examples: external partnerships ("Auth0 manages authentication"), scope boundaries ("we build policy + UI, not credential vaulting"), stack mandates ("Next.js + PostgreSQL").

-
-

## Evolution Log

Append-only record of identity changes. Never edit WHO / JOB / NEVER above without adding an entry here. Pivots are normal — unaudited drift is fatal.

### v1.0 (YYYY-MM-DD) — Genesis
- Initial identity.

<!--
### v1.1 (YYYY-MM-DD) — [short description]
- **Trigger**: [signal reference, e.g., "SIG-001: 40% of users are team leads"]
- **Changed**: [what in WHO / JOB / NEVER was modified]
- **Rationale**: [why, in 1–2 sentences]
- **Approved by**: Product Lead
-->
