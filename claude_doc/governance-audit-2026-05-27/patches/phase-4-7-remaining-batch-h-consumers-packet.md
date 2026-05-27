---
PACKET-TYPE: developer-implementation-packet
ENGAGEMENT: governance-audit-2026-05-27
PATCH-WAVE: phase-4-7-batch-h-remaining-consumers
ROUTED-FROM: team-lead
ROUTED-TO: developer-2
---

# Developer-2 Sub-Dispatch — Batch H Remaining P6.2 Consumer Migrations

## REQUEST-FIT-BASIS
Per ANTI-PASSIVE-WAIT no-deferred-narrowing rule: Batch H P6.2 closure deferred without lawful basis → now active. Validator task 28 codex W4-CX-1 + W4-CX-2 named the remaining consumer migration scope.

## TARGET-INTENT-BASIS
P6.2 catalog closure: complete remaining JSON.parse / stdin-read / shell-stdin-grep consumer migrations to use hook-json-helpers.js shared helper (created in Batch H task 26). Preserve per-hook behavior; preserve fail-open posture; per-consumer smoke verification.

## WORK-SURFACE
Per task 28 verdict + codex W4-CX-2 inventory refinement requirement:
- Identify remaining consumer hooks containing inline JSON.parse blocks AND/OR shell stdin-grep boilerplate that map to the helper interface
- For each migration-feasible consumer: refactor to source helper + invoke helper function
- For each non-migration-feasible consumer (different parse pattern / specific behavior): record rejected:non-applicable with rationale
- Per-consumer smoke verification (re-source; verify exit 0 on stdin echo or equivalent)
- Refine MANIFEST.md remaining-consumer inventory per W4-CX-2 (distinguish node JSON.parse / shell stdin-grep / already-migrated)

## SCOPE-BASELINE
Remaining P6.2 consumers per Batch H verdict + refined inventory.

## CLAIM-CEILING
review findings (lane-bounded).

## COMPLETION-STOP-CONDITION
Per-consumer PASS/REJECTED-non-applicable/HOLD verdict + refined MANIFEST inventory.

## RECEIPT-COMPLETION-CONTRACT
First upward outcome dispatch-ack | scope-pressure | hold|blocker; completion-grade MESSAGE-CLASS: completion + RETAINED-OUTPUT-PATH; envelope canonical.

## WRITE-SCOPE
- Active hook scripts in `.claude/hooks/*.sh` needing migration
- `.claude/hooks/lib/hook-json-helpers.js` (helper extension if needed)
- `.claude/hooks/MANIFEST.md` (inventory refinement per W4-CX-2)
- claude_doc/governance-audit-2026-05-27/patches/phase-4-7-batch-h-remaining-verdict.md

## REQUIRED-SKILLS
agent-developer, governance-modification, self-verification

## UPSTREAM-DECISION-BASIS
- task 26 Batch H verdict (partial migration + remaining inventory)
- task 28 Wave 4 codex W4-CX-1 (P6.2 closure requirement) + W4-CX-2 (inventory refinement)
- ANTI-PASSIVE-WAIT no-deferred-narrowing rule

## DISPATCH-AUTHORIZATION-BASIS
frozen-independent-lane:developer + no-deferred-narrowing-auto-proceed

## ESSENCE-EVIDENCE-BASIS
Task 26 + task 28 validator + codex evidence; lane-local Critical Review Gate per consumer.
