---
description: Standalone drift check. Audits the last 5 completed features against IDENTITY.md (WHO/JOB/NEVER), contracts.md, architecture.md, and rework patterns. Returns CONTINUE / DISCUSS / PIVOT / CONTRACT_HALT recommendation.
---

# /forge:drift — Drift check

> **Execution mode: direct.** This command has explicit steps below — execute them in order. Do not enter plan mode, do not write a plan file, do not call ExitPlanMode. The framework already did the planning; you just run the steps.


You dispatch the **drift-detector** agent to audit recent features against the project's identity, contracts, and architecture.

## When this fires

- **Auto:** every 5 completed features during `/forge:build` (the framework's discipline).
- **Manual:** any time the user wants a check — after a major refactor, before a release, after an identity update.

## Behavior

1. **Read state.** `IDENTITY.md`, `features.json` (last 5 with `status="done"`), `contracts.md` (if exists), `architecture.md`, `progress.md` (Recent Drift Reports section if it exists).

2. **Dispatch drift-detector** with the 6-check audit:
   - Does each feature serve WHO?
   - Does each feature make JOB easier?
   - Does any feature violate NEVER?
   - Does each respect Architecture Constraints?
   - Does each respect contracts (if `contract_mode != "none"`)?
   - Is any feature rework of recently-shipped code?

3. **Receive the report.** For each of the last 5 features: per-check verdict (YES / NO / DRIFT). Plus stabilization indicators (quality trend, rework pattern, reset count, architecture degradation).

4. **Assign a severity badge to each feature row** based on the audit results:
   - **`✓ healthy`** — passes all 6 dimensions, quality_score ≥ 8, no REWORK flag
   - **`⚠ watch`** — 1–2 minor concerns (one ✗ on a non-critical dimension, or quality_score 6–7)
   - **`✗ drift`** — serious drift (✗ on WHO, JOB, or NEVER; or quality_score < 6; or REWORK flagged; or contract violation)

5. **For each ✗ drift finding, include a one-sentence rationale.** Not just "honeycomb-comparison ✗ on WHO" — say "honeycomb-comparison ✗ — doesn't serve WHO directly. It's a sales asset, not a product feature. Log as `type: infrastructure` not `type: feature` next time."

6. **Bottom-line recommendation** with a confidence score (0–100):
   - **CONTINUE** → all healthy, no action needed
   - **DISCUSS** → some watches but no kills; flag for next `/forge:shape` or surface now
   - **PIVOT** → significant drift; pause the cycle; identity may need to evolve
   - **CONTRACT_HALT** → contract violation present; block the release until resolved

7. **Surface stabilization indicators prominently** with a one-line interpretation:
   - `Stabilization indicators: avg quality 8.2, 0 REWORK, avg resets 0.4 → ✓ OK (no stabilization release needed)`
   - `Stabilization indicators: rework rate 18% (>15% threshold) → ✗ STABILIZATION RECOMMENDED — next release should be debt-only`

8. **Persist the report** to `progress.md` under "Recent Drift Reports" with date and recommendation.

9. **PAUSE — Present the report to the user.** If recommendation is anything other than CONTINUE, do not advance until the user decides.

## Reference

- Agent: [agents/drift-detector.md](../agents/drift-detector.md)
- Skill: [skills/drift-protection/SKILL.md](../skills/drift-protection/SKILL.md)
