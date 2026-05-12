# Progress Log

<!--
  Accumulated learnings that survive context resets.
  Every Builder agent reads this before starting. Every Builder appends when finishing.

  v2 changes:
  - Promotion rules are explicit (see below)
  - Quality scores tracked per feature
  - Stabilization indicators logged in drift reports
-->

## Architecture Decisions
<!-- Populated during bootstrap/onboard. Constraints that shape all features. -->

## Open Questions
<!-- Deferred decisions. Features touching these areas should flag them. -->

## Cross-Cutting Patterns
<!--
  PROMOTION RULE: When a LEARNING appears in 2+ feature entries, promote here.
  Read FIRST by every Builder agent (~1,000 tokens max).
  Patterns persist across releases -- institutional memory.
  Review each release: remove patterns that are no longer relevant.
-->

## Active Gotchas
<!--
  PROMOTION RULE: When a GOTCHA is still relevant after the feature that created it,
  promote here. Read FIRST by every Builder agent.
  REMOVAL RULE: Review each release. Remove gotchas fixed by debt paydown.
-->

## Drift Reports
<!--
  Alignment checks from Drift Detector. Preserved for audit.
  Includes quality scores, stabilization indicators, rework patterns.
-->

## Contract Changes
<!-- Log of contract additions, deprecations, and breaking changes across releases. -->

---

## Release: v1.0.0

### Feature: [feature-slug] (DONE | BLOCKED)
- What was built / attempted
- Key decisions and why
- Quality score: N/10
- LEARNING: [reusable insight for future agents]
- GOTCHA: [trap to avoid -- be specific]
- TECH_DEBT: [shortcut taken and why, if any]
- REWORK: [if modified recently-shipped code, note what and why]

---

## Archived
<!--
  Compressed entries from releases older than current-1.
  Keep patterns/gotchas promoted to top sections.
  Quality score trends preserved in drift reports.
-->
