# Research Progress

<!--
Updated by: Orchestrator (primary), all agents (append learnings)
Updated when: Every cycle during SYNTHESIZE and TEST phases
Rules:
- Agents read TOP-DOWN: Dead Ends + Patterns + Gotchas FIRST
- Dead Ends are at the TOP — agents read first to avoid re-exploring invalidated paths
- Append-only for learnings (never delete — compress to archive)
- Patterns promoted from individual observations after 2+ occurrences
- When this file exceeds ~5,000 tokens: compress older cycle entries
- Dead Ends NEVER compress — they remain in full detail permanently

CONTEXT ENGINEERING:
- ALL agents read Dead Ends + Cross-Cutting Patterns + Active Gotchas FIRST (~1,300 tokens)
- Only load Recent Forge Entries for the current phase
- Archive section: only read if explicitly relevant
-->

---

## Dead Ends

<!-- READ FIRST — All agents read this section before anything else (~500 tokens max)
Hypotheses that were invalidated and WHY. Each entry saves future cycles from re-exploring.
These NEVER get compressed or archived. They stay in full detail permanently.

### DE-001: [Hypothesis that was invalidated]
**Forge:** [N]
**Evidence:** [E-NNN, E-NNN — what proved this wrong]
**Why it failed:** [Specific reasoning]
**Lesson:** [What we learned from this dead end]
**Promoted to Gotcha?:** [Yes — see Active Gotchas / No]
-->

---

## Cross-Cutting Patterns

<!-- READ FIRST — All agents read this section (~500 tokens max)
Promoted from Patterns section after 2+ occurrences across cycles.
Keep concise — one line per pattern.

Format:
- [PATTERN]: [One-sentence description] — [Implication for thesis]
-->

---

## Active Gotchas

<!-- READ FIRST — All agents read this section (~300 tokens max)
Promoted from Dead Ends and Methodology Notes after recurring mistakes.
Review every 5 cycles — remove resolved, keep active.

Format:
- [GOTCHA]: [What to watch for] — [What to do instead]
-->

---

## Recent Forge Entries

<!--
Last 3 cycles in full detail. Older entries compressed to Archive section.

### cycle [N] — YYYY-MM-DD

**Phase outcomes:**
- SCOUT: [Key signals found, hypotheses generated]
- INTERROGATE: [Key interview findings, DA highlights]
- SYNTHESIZE: [Confidence changes, gaps identified]
- TEST: [Decision: CONTINUE/PIVOT/KILL/GRADUATE]

**Models used:** SCOUT=[model], INTERROGATE=[model], DA=[model], SYNTHESIZE=[model], TEST=[model]

**Learnings captured:**
- [Learning from this cycle]

**Dead ends identified:**
- DE-NNN: [What was invalidated and why] — ALSO ADD TO Dead Ends section above

**Open questions generated:**
- OQ-NNN: [Question] -> [Target section, priority]
-->

---

## Patterns

<!--
Recurring themes across interviews and community signals.
Promote to Cross-Cutting Patterns after 2+ occurrences.

### PAT-001: [Pattern name]
**Occurrences:** [Interview N, Interview N, Signal S-NNN, ...]
**Description:** [What the pattern is]
**Implication:** [What this means for the thesis]
**Promoted?:** [Yes — see Cross-Cutting Patterns / Not yet]
-->

---

## Open Questions

<!--
Questions that emerged but haven't been answered yet. Drive next-cycle priorities.

| ID | Question | Priority | Source | Target |
|----|----------|----------|--------|--------|
| OQ-001 | [Question] | [High/Medium/Low] | [cycle N / Interview N] | [Which thesis section] |
-->

---

## Methodology Notes

<!--
What worked and didn't work in the research process itself.

### What Worked
- [Approach] — [Why it worked]

### What Didn't Work
- [Approach] — [Why it didn't work, what to do instead]

### Interview Sourcing
- [Channel] — [Hit rate, quality of interviewees]
-->

---

## Pivot History

<!--
If the thesis pivoted, document the trigger and impact.

### Pivot [N] — cycle [N], YYYY-MM-DD
**From:** [Previous thesis direction]
**To:** [New thesis direction]
**Trigger:** [What evidence or insight caused the pivot]
**Impact:** [Which sections reset, which were preserved]
-->

---

## Archive

<!--
Compressed older cycle entries. One line per cycle.
Move entries here when Recent Forge Entries exceeds 3 cycles.

Format:
- cycle [N] (YYYY-MM-DD): [Decision]. Key: [one-sentence summary]. Confidence: [snapshot].
-->

---

## Last Updated

<!-- cycle [N] — YYYY-MM-DD -->
