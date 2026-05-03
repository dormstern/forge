# Architecture Map

<!--
  Living codebase map maintained by the Orchestrator.
  Updated during HARVEST (pre-build scan) and SHIP & MEASURE (post-build).

  Purpose: Give agents structural context before they build.
  Budget: Keep under ~2,000 tokens. Summarize aggressively.

  v2: Orchestrator handles this directly (no separate Codebase Mapper agent).
  Incremental updates only -- never full regen except during ONBOARD.
-->

Last updated: YYYY-MM-DD (post v{X.Y})

## Modules

### [module-name]/
- **Purpose**: [What this module does]
- **Key files**: [2-4 most important files]
- **Size**: [~line count]
- **Dependencies**: [What it imports/uses]
- **Dependents**: [What depends on it]
- **Hot path**: YES / NO
- **Test coverage**: [%]

## API Surface

| Endpoint | Method | Auth | Response Shape |
|----------|--------|------|---------------|
| | | | |

## Data Models

### [ModelName]
| Field | Type | Notes |
|-------|------|-------|
| | | |

## Hot Paths

<!--
  Most-changed files with highest complexity.
  20% of files cause 80% of issues -- identify them here.
  Builder agents should be most careful in these areas.
-->

| File | Changes (last release) | Complexity | Notes |
|------|----------------------|-----------|-------|
| | | | |

## Integration Points

| External Service | Connection Method | Contract Location |
|-----------------|------------------|------------------|
| | | |

## Test Coverage Gaps

<!-- Modules with low/no coverage -- blind spots for future changes -->

| Module | Coverage | Gap Description |
|--------|----------|----------------|
| | | |
