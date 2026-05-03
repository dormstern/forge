# Contracts

<!--
  API/schema/event contract registry. OPT-IN.

  This file only exists if contract_mode != "none" in releases.json.

  Three modes (set in releases.json):
  ============================================================

  MODE: "none"
  - This file does not exist.
  - Builder does not check for breaking changes.
  - Drift Detector skips contract checks.
  - For: Internal tools, prototypes, no published APIs.

  MODE: "lightweight"
  - This file exists but only tracks breaking changes.
  - Builder flags BREAKING_CHANGE when modifying external surfaces.
  - Drift Detector checks for unflagged breaking changes.
  - No full registry needed -- just the Breaking Changes Log below.
  - For: Products with APIs used by a few known consumers.

  MODE: "full"
  - Complete contract registry: every endpoint, schema, event.
  - Builder reads this before every API/schema feature.
  - Test Writer includes contract-compliance tests.
  - Drift Detector audits cumulative impact.
  - Deprecation timeline enforced (min 1 release before removal).
  - For: Platform products, public APIs, many consumers.

  ============================================================

  Rules (all modes):
  - Contracts are append-only. Published contracts can be deprecated, never silently removed.
  - Every BREAKING change needs a migration path.
  - Builder agents check this before modifying API surfaces or schemas.
-->

## Current Mode

<!-- Set this to match contract_mode in releases.json -->
**Contract Mode:** lightweight | full

---

## Formal Specs (if they exist)

<!-- Reference, don't duplicate. Examples:
- API: `openapi.yaml` (source of truth for REST endpoints)
- Schema: `prisma/schema.prisma` (source of truth for data models)
- Events: `events/schema.json`
-->

---

## Implicit Contracts (full mode only)

<!-- Only needed in "full" mode. Capture contracts NOT covered by formal specs.

### [Endpoint or Schema]
- **Published**: v{X.Y.Z}
- **Status**: ACTIVE / DEPRECATED (removal: v{X.Y.Z})
- **Shape**: [Brief description]
- **Guarantees**: [What will not change without deprecation]
-->

---

## Breaking Changes Log (lightweight and full modes)

<!-- All modes that use this file track breaking changes here. -->

| Version | Change | Migration Path | Approved By | Date |
|---------|--------|---------------|-------------|------|
| | | | | |

---

## Deprecation Log (full mode only)

| Item | Deprecated In | Removal Planned | Migration Path | Status |
|------|--------------|-----------------|---------------|--------|
| | | | | |
