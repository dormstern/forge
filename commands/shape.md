---
description: PM mode — propose a release plan with thesis, feature candidates (signal_id + requested_by), debt paydown (~15%), kill list (≥10% via the 10% Delete Rule), autonomy tiers (T1/T2/T3), Devil's Advocate findings, and stabilization check. The hero command — produces the screenshottable release plan card.
---

# /forge:shape — Release shaping (PM mode) — HERO COMMAND

> **Execution mode: direct.** This command has explicit steps below — execute them in order. Do not enter plan mode, do not write a plan file, do not call ExitPlanMode. The framework already did the planning; you just run the steps.


You propose a release plan. **This is the magic moment of Forge.** The output of `/forge:shape` is what the user screenshots and shares.

## Pre-conditions

- HARVEST is complete: `releases.json.current_cycle.signals` has entries.
- `IDENTITY.md`, `architecture.md`, and `features.json` all exist and are current.

## Behavior

1. **Read state.** `releases.json` (signals + last 2 releases), `IDENTITY.md`, `architecture.md`, `features.json`. Do not skip any.

2. **Propose a release plan** with these sections:

   - **Thesis** (1 sentence): what this release is about.
   - **Identity evolution** (only if signals warrant): trigger + rationale + risk. The user owns IDENTITY.md changes — propose, don't write.
   - **Feature candidates**: each with `signal_id`, `requested_by`, `intent` (1–2 sentences), `autonomy` (T1/T2/T3), and `depends_on`.
   - **Debt paydown** (~15% of scope): pull from `features.json` `tech_debt` items.
   - **Kill list** (≥10% of scope — the 10% Delete Rule): features with `post_mvp_status: "evaluate"`, low-usage signals, or stale work. **If nothing qualifies, state it explicitly with evidence — don't skip.**
   - **Contract implications** (if `contract_mode != "none"`): per-API breaking change risk.
   - **Appetite**: what's explicitly NOT in this release.
   - **Stabilization check**: auto-fire if rework_rate > 15% OR blocked_features ≥ 3 OR avg_resets > 2 OR avg_quality_score < 6.0 across last 5. If any trigger, recommend a stabilization release (all debt + rework, zero new features).

3. **Auto-dispatch devils-advocate** against the proposed plan. Surface the top 2–3 attacks inline in the shape output. The user can run `/forge:falsify` for harder attacks.

4. **Render the hero card** in monospace with Unicode borders. ✓/⚠/✗ markers. Columns: feature name, autonomy tier, signal id. Sections: features, debt paydown, kill list, DA findings.

5. **PAUSE — Present to user.** Wait for approval, modifications, or a kill of the cycle. Do not start build until the user explicitly says to.

6. **On approval:** persist the plan into `releases.json.current_cycle.approved_plan`. If the user updated IDENTITY.md, append an Evolution Log entry.

## The hero card format

```
═════════════════════════════════════════════════════
  CYCLE — Release Plan v{version}
  Thesis: "{one sentence}"
═════════════════════════════════════════════════════

  FEATURES (N)                    AUTONOMY    SIGNAL
  ───────────────────────────────────────────────────
  ✓ {feature-id}                   T1|T2|T3   SIG-NNN
  ⚠ {feature-id}                   T2|T3      SIG-NNN

  DEBT PAYDOWN (~15%)
  ───────────────────────────────────────────────────
  ✓ {debt-id}

  KILL LIST (10% Delete Rule fired ✗)
  ───────────────────────────────────────────────────
  ✗ {feature-id}                   {reason, ≤6 words}

  DEVIL'S ADVOCATE
  ───────────────────────────────────────────────────
  ⚠ {Attack name}: {one-line finding}
  ✓ {Attack name}: clean

  Run `/forge:build` to start. `/forge:falsify` to attack the plan harder.
═════════════════════════════════════════════════════
```

## Constraints

- Never skip the kill list. The 10% Delete Rule is the soul of this command.
- Auto-fire the stabilization check. Don't make it optional.
- The DA pass is mandatory — always show ≥3 attacks even if 2 are clean.
- The hero card must render cleanly in plain terminal, GitHub markdown, X, and Slack.

## Reference

- Skill: [skills/pm-mode/SKILL.md](../skills/pm-mode/SKILL.md), [skills/ten-percent-delete/SKILL.md](../skills/ten-percent-delete/SKILL.md), [skills/autonomy-tiers/SKILL.md](../skills/autonomy-tiers/SKILL.md), [skills/stabilization/SKILL.md](../skills/stabilization/SKILL.md)
- Agents: [agents/feature-breakdown.md](../agents/feature-breakdown.md), [agents/devils-advocate.md](../agents/devils-advocate.md)
