---
PACKET-TYPE: developer-implementation-packet
ENGAGEMENT: governance-audit-2026-05-27
PATCH-WAVE: phase-4-7-wave-4-batch-h
ROUTED-FROM: team-lead
ROUTED-TO: developer-2 (sub-dispatch 25b from scope-pressure 25)
UPSTREAM-DECISION-BASIS: task 25 scope-pressure carrier route-replan acceptance
---

# Developer Sub-Dispatch 25b — Batch H (P6.2 Cross-Hook Node-Parse Helper Consolidation)

## REQUEST-FIT-BASIS
Sub-dispatch from task 25 scope-pressure proposed splitting. Bounded scope: P6.2 cross-hook node-parse / JSON-extraction / stdin-read helper consolidation.

## TARGET-INTENT-BASIS
§1-§8 + 8-keyword INVARIANT; preserve all active-hook behavior post-consolidation; no regression on settings-wired hook smoke verification.

## WORK-SURFACE
Per promotion-catalog.md P6.2 (Shard E E-12 + E-29 evidence):
- Investigate cross-hook patterns across 14+ active hooks per MANIFEST.md Active Hooks list
- Identify shared JSON-parse / stdin-read / node-script-shell-out boilerplate
- Design helper at `.claude/hooks/lib/<helper-name>.sh` per existing hook-lib convention (candidate name: `hook-json-parse.sh`)
- Update each consumer hook to source the helper
- Per-hook smoke verification (re-source each consumer; verify exit 0 on stdin echo or equivalent minimal smoke probe)

## SCOPE-BASELINE
Batch H only (P6.2). Per-consumer-hook verdict tracked.

## CLAIM-CEILING
review findings (lane-bounded).

## COMPLETION-STOP-CONDITION
Per-consumer-hook PASS/FAIL/HOLD verdict in retained carrier; helper exists at `.claude/hooks/lib/<name>.sh`; smoke verification transcripts captured.

## RECEIPT-COMPLETION-CONTRACT
First upward outcome dispatch-ack | scope-pressure | hold|blocker; completion-grade MESSAGE-CLASS: completion + RETAINED-OUTPUT-PATH; envelope canonical.

## WRITE-SCOPE
- `.claude/hooks/lib/<helper-name>.sh` (new shared helper)
- Each consumer `.claude/hooks/<name>.sh` (source line update)
- `.claude/hooks/MANIFEST.md` (Hook Dependencies update if helper consumption changes dependency graph)
- `claude_doc/governance-audit-2026-05-27/patches/phase-4-7-wave-4-batch-h-verdict.md` (own retained-output)

## REQUIRED-SKILLS
agent-developer, governance-modification, self-verification

## UPSTREAM-DECISION-BASIS
- task 25 scope-pressure carrier (Batches G + I applied; H + J split)
- promotion-catalog.md P6.2 (Shard E evidence)

## DISPATCH-AUTHORIZATION-BASIS
frozen-independent-lane:developer + scope-pressure-route-replan

## ESSENCE-EVIDENCE-BASIS
Promotion catalog + scope-pressure carrier (task 25 lane self-disclosed cross-hook investigation scope estimate); lane-local Critical Review Gate during patch design.

## CAVEAT
Hook-Last review applies if structural change to active hook dependency graph results (e.g., new bootstrap path). Pure additive shared-helper consumption (each hook sources the helper before its existing logic) does NOT require Hook-Last expansion; intent-preserving extraction.
