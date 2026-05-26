---
PACKET-TYPE: developer-implementation-packet
ENGAGEMENT: governance-audit-2026-05-27
PATCH-WAVE: phase-4-7-wave-4
ROUTED-FROM: team-lead
ROUTED-TO: developer-2
---

# Developer Implementation Packet — Phase 4-7 Wave 4 (Runtime Hook Consolidation)

## REQUEST-FIT-BASIS
Phase 4-7 audit Wave 4 patches per promotion-catalog.md P6.1/P6.2/P6.5 (runtime hook consolidation cluster) + P3.1 deferred (mega-bullet splits in core-law mapped surfaces). Continuing per operator standing directive "자동 진행 규정에 따라 수행해" after Wave 2+3 validator PASS (task 23 round 3).

## TARGET-INTENT-BASIS
§1-§8 + 8-keyword INVARIANT (esp. removal-first + minimum-executable-information + consumed-surface + dimensional-independence + no-compression); preserve all positive working functions including task 20 essence-discipline runtime layer; cross-reference integrity (Same-Category Coverage Defeater discipline per task 20 + task 23 PASS precedents).

## WORK-SURFACE

### Batch G — P6.1 Legacy stub hook consolidation
Per promotion-catalog.md P6.1: 8 legacy stub hooks in `.claude/hooks/` are file-level no-op (`exit 0` at top) per MANIFEST.md `## Legacy Hooks` rule. They remain in `./` for traceability but contribute load cost + cognitive overhead.

Inspect MANIFEST.md `## Legacy Hooks` enumeration. For each legacy stub:
- (a) Consolidate to single shim file with PROTECTED-LOCAL-RESTATEMENT-BASIS per stub for the disable-basis comment block, OR
- (b) Add PROTECTED-LOCAL-RESTATEMENT-BASIS to each individual stub file naming the specific disable-basis (allows independent traceability).
- Lane decision per same-category coverage discipline; document rationale in verdict carrier.

### Batch H — P6.2 Cross-hook node-parse boilerplate helper consolidation
Per promotion-catalog: multiple hook scripts have similar JSON-parse / stdin-read / node-script-shell-out boilerplate. Re-home to shared helper at `.claude/hooks/lib/<helper-name>.sh` per existing hook-lib convention (per `.claude/hooks/lib/*.sh` directory).

Identify the cross-hook node-parse / JSON-extraction shared patterns. Re-home to shared helper. Update each consumer hook to source the helper. Verify per-hook smoke test still passes.

### Batch I — P6.5 hook-config / hook-config-core source-lib function consolidation
Per promotion-catalog: `.claude/hooks/hook-config.sh` and `.claude/hooks/hook-config-core.sh` have parallel structure with shared function bodies. Per MANIFEST.md `## Hook Dependencies` rule (`hook-config.sh` sourced by all settings-wired hooks except `permission-request-gate.sh`; `hook-config-core.sh` sourced by `permission-request-gate.sh`).

Investigate the parallel-function structure. Determine if a single shared function library + per-hook source path can replace the parallel structure without breaking the `hook-config.sh` vs `hook-config-core.sh` consumer split. If consolidation safe, apply; if structural-split is intentional (e.g., permission-request-gate.sh needs minimal bootstrap), document the structural intent inline + skip consolidation.

### Batch J — P3.1 Mega-bullet splits (deferred from Wave 2)
Per promotion-catalog.md P3.1: large bullets in core-law mapped surfaces (A-13, A-14, A-22, A-25, A-26, A-34, B-10, B-12, B-15, C-10-16, C-21-30, D-06) bundle multiple meanings violating no-compression rule.

Iterate each enumerated mega-bullet:
- Identify the distinct meanings bundled within the bullet
- Split into separate bullets per no-compression rule (same-subject repeated-pattern allowed; bundled different-meaning clauses prohibited)
- Apply removal-first to redundant sub-clauses
- Preserve every preserved meaning (no semantic loss)

## SCOPE-BASELINE
Batches G + H + I + J (4 batches). Per-batch verdict tracked. No silent narrowing.

## ACTIVE-SLICE
All 4 batches in this assignment. If burden exceeds reasonable single-lane scope, lane sends scope-pressure with proposed splitting.

## CLAIM-CEILING
review findings (lane-bounded; binding promotion reserved for validator final acceptance).

## COMPLETION-STOP-CONDITION
Every batch + per-batch row PASS/FAIL/HOLD verdict in retained carrier; partial routes hold|blocker.

## RECEIPT-COMPLETION-CONTRACT
First upward outcome dispatch-ack | scope-pressure | hold|blocker; completion-grade MESSAGE-CLASS: completion + RETAINED-OUTPUT-PATH; envelope canonical (CARRIER + STATE, ≤3 lines body).

## WRITE-SCOPE
- `.claude/hooks/*.sh` (legacy stubs + lib helper)
- `.claude/hooks/lib/*.sh`
- `.claude/hooks/MANIFEST.md` (Active Hooks / Legacy Hooks / Hook Dependencies ledger updates per applied consolidations)
- `.claude/reference/*.md` (P3.1 mega-bullet splits in mapped core-law surfaces; specifically the core-laws enumerated in promotion-catalog P3.1)
- `claude_doc/governance-audit-2026-05-27/patches/phase-4-7-wave-4-verdict.md` (own retained-output)

## REQUIRED-SKILLS
agent-developer, governance-modification, self-verification, review-verification

## UPSTREAM-DECISION-BASIS
- promotion-catalog.md P6.1 + P6.2 + P6.5 + P3.1 (Shard E + Shard A evidence)
- task 23 round 3 PASS verdict (Wave 2+3 infrastructure preserved)
- task 20 PASS (essence-discipline runtime layer; same-category coverage defeater discipline)

## DISPATCH-AUTHORIZATION-BASIS
frozen-independent-lane:developer + team-meeting-outcome:team-lead-essence-discipline-r2 (continuation)

## ESSENCE-EVIDENCE-BASIS
Promotion catalog from 4-shard reviewer audit = path (a) basis; task 23 round 3 PASS validates Wave 2+3 infrastructure; lane-local Critical Review Gate during patch design (same-category coverage defeater + cumulative-input integrity defeater applied).

## CAVEAT
Hook-Last review applies per Constitutional Curtain Protection for any blocking-hook expansion. Batch G + H + I should NOT add new blocking hooks; only consolidate existing legacy stubs / helper functions. If consolidation requires structural change to active hooks, route via separate Hook-Last review pathway.
