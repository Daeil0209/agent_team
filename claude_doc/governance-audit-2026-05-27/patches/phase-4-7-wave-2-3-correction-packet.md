---
PACKET-TYPE: developer-correction-packet
ENGAGEMENT: governance-audit-2026-05-27
PATCH-WAVE: phase-4-7-wave-2-3-correction
ROUTED-FROM: team-lead
ROUTED-TO: developer-2
UPSTREAM-DECISION-BASIS: validator HOLD verdict on Wave 2+3 (task 23) — F-1 verdict-blocking + F-2 non-blocking
---

# Developer Correction Packet — Phase 4-7 Wave 2+3 Validator HOLD Correction

## REQUEST-FIT-BASIS
Validator task 23 HOLD verdict on Phase 4-7 Wave 2+3 patches identified 2 findings requiring correction. Correction packet routes corrections back to developer-2 lane before re-validation.

## TARGET-INTENT-BASIS
§1-§8 + 8-keyword INVARIANT preservation; Same-Category Coverage Defeater discipline (per essence-discipline review-verification Step 5 addition); cross-reference integrity.

## WORK-SURFACE

### F-1 (VERDICT-BLOCKING) — truth-rules.md citer inventory incomplete + marker body stale
- **Missed citer**: `.claude/skills/task-execution/references/runtime-dispatch-law.md:115` — currently contains `per truth-rules.md` clause; was missed in Wave 2 Batch B1 + Wave 3 Batch F citer inventory.
- **Correction options** (developer-2 lane decision per same-category coverage discipline):
  - (a) drop the `per truth-rules.md` clause (the rule is self-contained per validator's analysis)
  - (b) relocate citation to canonical owner (`message-classes.md` for assignment-grade SendMessage rules) per Batch F-1 pattern at agent-team-lead/SKILL.md
- **Marker body refresh**: `.claude/skills/task-execution/references/truth-rules.md` marker body says "2 of the 3 prior" — update to reflect actual post-correction citer count (likely "3 of the 4 prior" with reporting-prohibition-law.md:65 still DEFERRED).

### F-2 (NON-BLOCKING, recommended in same dispatch) — 4 sibling workflow files SOURCE-RULES frontmatter stale
- 4 files in `.claude/skills/business-workflow/references/`:
  - `rnd-proposal-workflow.md:4` — `SOURCE-RULES: "domain-rule-catalog.md routed R&D Proposal Domain Rules"`
  - `rnd-result-report-workflow.md:4` — `SOURCE-RULES: "domain-rule-catalog.md routed Result Report Domain Rules"`
  - `event-planning-workflow.md:4` — `SOURCE-RULES: "domain-rule-catalog.md routed Event Planning Domain Rules"`
  - `schedule-planning-workflow.md:4` — `SOURCE-RULES: "domain-rule-catalog.md routed Schedule Planning Domain Rules"`
- **Correction**: replace each `SOURCE-RULES` with standard convention `SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"` (matches sibling `allocation-participation-workflow.md:4` standard).

## SCOPE-BASELINE
F-1 (1 file update + marker refresh) + F-2 (4 files). Total: 6 file edits.

## CLAIM-CEILING
review findings (lane-bounded; binding promotion reserved for validator re-acceptance).

## COMPLETION-STOP-CONDITION
F-1 + F-2 verdict in retained carrier; corrections applied + Class A tool-call evidence for each.

## RECEIPT-COMPLETION-CONTRACT
First upward outcome dispatch-ack | scope-pressure | hold|blocker; completion-grade MESSAGE-CLASS: completion + RETAINED-OUTPUT-PATH; envelope canonical.

## WRITE-SCOPE
- `.claude/skills/task-execution/references/runtime-dispatch-law.md` (F-1 line 115)
- `.claude/skills/task-execution/references/truth-rules.md` (F-1 marker body refresh)
- `.claude/skills/business-workflow/references/rnd-proposal-workflow.md` (F-2 line 4)
- `.claude/skills/business-workflow/references/rnd-result-report-workflow.md` (F-2 line 4)
- `.claude/skills/business-workflow/references/event-planning-workflow.md` (F-2 line 4)
- `.claude/skills/business-workflow/references/schedule-planning-workflow.md` (F-2 line 4)
- `claude_doc/governance-audit-2026-05-27/patches/phase-4-7-wave-2-3-correction-verdict.md` (own retained-output)

## REQUIRED-SKILLS
agent-developer, governance-modification, self-verification, review-verification

## UPSTREAM-DECISION-BASIS
- validator task 23 HOLD verdict carrier: claude_doc/governance-audit-2026-05-27/patches/phase-4-7-wave-2-3-validator-verdict.md (F-1 + F-2 detail)

## DISPATCH-AUTHORIZATION-BASIS
frozen-independent-lane:developer + validator-HOLD-correction-cycle
