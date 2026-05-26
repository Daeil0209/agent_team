---
CARRIER-TYPE: developer-scope-pressure-carrier
PACKET-ID: phase-4-7-wave-4-scope-pressure
ENGAGEMENT: governance-audit-2026-05-27
PATCH-WAVE: phase-4-7-wave-4
ROUTED-FROM: developer
ROUTED-TO: team-lead
PRODUCED-BY: developer (task #25)
ASSIGNMENT-PACKET: claude_doc/governance-audit-2026-05-27/patches/phase-4-7-wave-4-packet.md
PRESSURE-TYPE: parallel-split-needed
CORRECTION-OUTCOME: route-replan
CLAIM-CEILING: review findings (lane-bounded)
---

# Developer Scope-Pressure — Phase 4-7 Wave 4 (Hook Consolidation + P3.1 Mega-Bullet Splits)

## STATUS-OVERALL
SCOPE-PRESSURE-STATE: structured objection to packet workload with proposed splitting per packet `ACTIVE-SLICE` clause "If burden exceeds reasonable single-lane scope, lane sends scope-pressure with proposed splitting."
PARTIAL-COMPLETION-RECORD: Batch G (P6.1 legacy stub PROTECTED-LOCAL-RESTATEMENT-BASIS additions) + Batch I (P6.5 hook-config / hook-config-core bootstrap-isolation PROTECTED-LOCAL-RESTATEMENT-BASIS additions) APPLIED within this turn. Batch H (P6.2 cross-hook node-parse helper consolidation) + Batch J (P3.1 mega-bullet splits) propose route-replan to separate focused dispatches.

## REQUEST-FIT-BASIS
Per packet `ACTIVE-SLICE` clause authorizing scope-pressure with proposed splitting when burden exceeds reasonable single-lane scope, this carrier records: (a) G + I applied this turn with high-quality patch design + Class A tool-call evidence, AND (b) H + J proposed route-replan to focused sub-dispatches because their combined scope exceeds single-lane single-turn capacity at high-quality patch-design depth.

## EXACT CONSTRAINT
- Batch H (cross-hook node-parse helper consolidation): requires cross-hook investigation across 14+ active hooks per MANIFEST.md `## Active Hooks` listing for shared JSON-parse / stdin-read / node-script-shell-out patterns; helper design at `.claude/hooks/lib/<name>.sh`; per-consumer-hook source-line updates; per-hook smoke-test verification (each settings-wired hook must still pass its frozen behavior after the helper substitution). Conservative estimate: 25-40 tool calls covering investigation + design + per-consumer-update + smoke verification.
- Batch J (P3.1 mega-bullet splits): packet WORK-SURFACE enumerates A-13, A-14, A-22, A-25, A-26, A-34, B-10, B-12, B-15, C-10-16, C-21-30, D-06 — approximately 30+ enumerated mega-bullets across multiple core-law mapped surfaces (work-execution-core-law.md, review-and-verification-core-law.md, modification-core-law.md, work-skill-reference-binding-law.md per Shard A; pre-action-gate, runtime-dispatch-law, dev-workflow, assignment-packet per Shard B; review-verification SKILL + references, self-verification SKILL, codex-independent-review SKILL + references, team-meeting SKILL, validator-lane-detail per Shard C; architecture-extensions per Shard D). Each split requires identifying bundled independently-testable meanings + splitting + preserving every preserved meaning + verifying no-compression compliance. Conservative estimate: 40-60 tool calls covering read + split design + edit + verify per item.

## ATTEMPTED OR AVAILABLE PATH
- Batch G applied in 8 Edit operations (PROTECTED-LOCAL-RESTATEMENT-BASIS line added to each of 8 legacy stubs per option (b) per packet `## WORK-SURFACE` `### Batch G`).
- Batch I applied in 2 Edit operations (PROTECTED-LOCAL-RESTATEMENT-BASIS added to hook-config.sh and hook-config-core.sh declaring bootstrap-isolation as the basis for the namespace-parallel structure per packet `## WORK-SURFACE` `### Batch I` "If consolidation safe, apply; if structural-split is intentional, document the structural intent inline + skip consolidation" — selected the "document structural intent inline" path because the dependency-minimization for permission-request-gate.sh's minimal bootstrap is a functional reason for the namespace separation).
- Batches H + J could be executed in this turn but the combined estimated 65-100 tool calls + the careful design depth required (no semantic loss; no hook breakage; no-compression compliance per item) exceeds the reasonable single-turn capacity after the tasks 21+22+24 chain context budget already consumed in this session.

## WHY CURRENT EXECUTION CANNOT CONTINUE TRUTHFULLY
Per developer lane stance from `.claude/agents/developer.md` IR-1: "production craftsman with quality obligation". Per `.claude/skills/agent-developer/SKILL.md` `## Escalation Triggers`: "Send `scope-pressure` when the trigger can be resolved by: bounded split, replanning, route decision." Per packet `## ACTIVE-SLICE` explicit authorization: "If burden exceeds reasonable single-lane scope, lane sends scope-pressure with proposed splitting."
Attempting H + J in same turn after G + I would mean rushing through ~65-100 tool calls of investigation + careful patch design + verification under context pressure, with material risk of:
- Hook breakage from incomplete cross-hook investigation in Batch H (introducing regression in a settings-wired active hook).
- Core-law semantic loss from rushed mega-bullet splits in Batch J (a rushed split may discard preservable meaning or introduce no-compression violations).
- Carrier-fabrication risk if I claim PASS verdicts on rushed work without thorough Critical Review Gate defeater enumeration per item.
Lane quality obligation outweighs single-turn completion pressure; proper split delivers higher-quality patch design.

## SMALLEST NEXT EXECUTABLE STEP
Team-lead route-replan into 2-3 focused sub-dispatches:

### Proposed Sub-Dispatch 25b — Batch H (cross-hook node-parse helper consolidation)
- WORK-SURFACE: P6.2 cross-hook node-parse helper consolidation per promotion-catalog.md P6.2 (Shard E E-12 + E-29 evidence).
- Bounded scope: investigation across 14+ active hooks for shared JSON-parse / stdin-read / node-script-shell-out boilerplate patterns; design helper at `.claude/hooks/lib/<helper-name>.sh`; update each consumer hook to source the helper; per-hook smoke verification.
- Estimated single-lane single-turn capacity: feasible as a focused dispatch.
- Required additions to packet: explicit helper-name candidate (e.g., `hook-json-parse.sh`); explicit smoke-verification protocol (e.g., re-source each consumer hook; verify exit code 0 on stdin echo).

### Proposed Sub-Dispatch 25c — Batch J-A (P3.1 mega-bullet splits, Shard A core-law surfaces)
- WORK-SURFACE: A-13, A-14, A-22, A-25, A-26, A-34 (~6 Shard A items in core-law mapped surfaces).
- Bounded scope per Shard A surfaces only (work-execution-core-law.md, review-and-verification-core-law.md, modification-core-law.md, work-skill-reference-binding-law.md, CLAUDE.md).
- Feasible as a focused dispatch.

### Proposed Sub-Dispatch 25d — Batch J-B + J-C + J-D (P3.1 mega-bullet splits, Shard B/C/D items)
- WORK-SURFACE: B-10, B-12, B-15, C-10-16, C-21-30, D-06 (~25 items across Shards B/C/D).
- Possibly further sub-split per shard if 25+ items exceeds single-lane capacity.
- Each sub-shard feasible as a focused dispatch.

Note on sub-dispatch ordering: 25b (H) and 25c (J-A) are independent and can be dispatched in parallel. 25d (J-B/C/D) depends on no prior sub-dispatch and can also run in parallel.

## PARTIAL-COMPLETION DETAIL (G + I applied this turn)

### Batch G applied: 8 legacy stub PROTECTED-LOCAL-RESTATEMENT-BASIS additions
- Selected option (b) per packet (PROTECTED-LOCAL-RESTATEMENT-BASIS per stub) over option (a) (shim consolidation): option (b) preserves per-file Git history traceability + independent future-narrowing path per stub; option (a) would require structural change to hook infrastructure (creating a shim file + redirecting each stub to source it), invoking the packet `## CAVEAT` Hook-Last review pathway. Option (b) is the less invasive default within packet authorization.
- Applied: PROTECTED-LOCAL-RESTATEMENT-BASIS line added to each of 8 legacy stubs immediately after `set -euo pipefail`:
  - `.claude/hooks/dispatch-proof-gate.sh`
  - `.claude/hooks/dispatch-sizing-gate.sh`
  - `.claude/hooks/runtime-entry-gate.sh`
  - `.claude/hooks/spawn-prompt-screen-safety.sh`
  - `.claude/hooks/task-completed-gate.sh`
  - `.claude/hooks/task-created-gate.sh`
  - `.claude/hooks/task-start-gate.sh`
  - `.claude/hooks/validate-task-target.sh`
- Comment declares the disabled-stub-preservation basis citing MANIFEST.md `## Legacy Hooks` enumeration as the per-file evolutionary record.

### Batch I applied: hook-config / hook-config-core bootstrap-isolation PROTECTED-LOCAL-RESTATEMENT-BASIS additions
- Per packet `### Batch I` option "If consolidation safe, apply; if structural-split is intentional, document the structural intent inline + skip consolidation": investigation reveals the structural split IS intentional — `hook-config.sh` sources 12 hook lib files (full library for all settings-wired active hooks except permission-request-gate.sh), while `hook-config-core.sh` sources only `hook-policy.sh` (minimal bootstrap for permission-request-gate.sh). Consolidation to single shared source-lib function would couple permission-request-gate.sh's bootstrap to the full lib chain, a regression per dependency-minimization principle.
- Applied: PROTECTED-LOCAL-RESTATEMENT-BASIS comment added to each file (hook-config.sh and hook-config-core.sh) declaring `bootstrap-isolation` basis citing MANIFEST.md `## Hook Dependencies` and the dependency-minimization-for-permission-request-gate.sh rationale.

## EVIDENCE BASIS

### Class A citations (current-turn or same-session tool-call evidence)
- promotion-catalog.md P6.1 + P6.2 + P6.5 + P3.1 — Class A (Read same session via task 21+22+25).
- task 25 packet — Class A (Read this turn).
- MANIFEST.md `## Legacy Hooks` (8 stubs enumeration) + `## Hook Dependencies` (hook-config vs hook-config-core split rule) + `## Active Hooks` (14 active hooks list) — Class A (Read this turn).
- 8 legacy stub files (pre + post edit) — Class A (Read + Edit this turn).
- hook-config.sh + hook-config-core.sh (pre + post edit) — Class A (Read + Edit this turn).
- packet `## CAVEAT` Hook-Last review constraint — Class A (Read this turn).
- task 23 round 3 PASS verdict basis (Wave 2+3 infrastructure preserved) — Class A (same-session basis).

### Class A defeater enumeration (for Batches G + I applied work)
- Batch G defeater (option (a) shim consolidation might be better): probed; (b) evidence = single shim with sourced thin files would be more DRY; (c) inspected packet `## CAVEAT` — structural change to hooks invokes Hook-Last review pathway, which the packet says should be route-replan'd if applicable. Option (b) avoids the structural change while addressing the duplicate-without-basis finding. → DISPROVEN.
- Batch G defeater (per-stub PROTECTED-LOCAL-RESTATEMENT-BASIS adds boilerplate): probed; (b) evidence = each stub gains a long comment line; (c) inspected modification-core-law.md:101 — "Duplicate doctrine requires `PROTECTED-LOCAL-RESTATEMENT-BASIS: <basis>` declared in the patch record or at the local surface." The basis declaration IS the protected-restatement preservation mechanism; without it the duplicate is a defect. The comment line is the lawful basis carrier. → DISPROVEN.
- Batch I defeater (consolidation would be smaller code): probed; (b) evidence = a single shared `hook_bootstrap_source_lib` function consumed by both bootstrap surfaces would deduplicate the function body; (c) inspected `hook-config.sh` source list (12 libs) vs `hook-config-core.sh` source list (1 lib) — these are functionally distinct (permission-request-gate.sh has narrower dependency surface). A shared function with a lib-list parameter could work BUT consolidating to that pattern would either: (i) keep both bootstrap surfaces as separate caller-files that load the shared function — equivalent overhead to current structure, OR (ii) merge both bootstrap surfaces into one file with a mode flag — couples permission-request-gate.sh's minimal bootstrap to the file containing the full lib list (regression on dependency-minimization). Option (b) declared basis avoids both regressions. → DISPROVEN.

## SKILL-FIELD-CONSUMPTION
Per packet `REQUIRED-SKILLS`:
- `agent-developer`: applied (same-session loaded basis reused).
- `governance-modification`: applied (same-session loaded basis reused; Step 1-6 + Patch Execution Method executed for G + I applied work).
- `self-verification`: applied (same-session loaded basis reused; PASS-1 + PASS-2 records implicitly executed inline for G + I applied work via the defeater enumeration above).
- `review-verification`: applied (same-session loaded basis reused; lens-bounded `coherence-integrity-lens` + `minimum-executable-information-lens` + `removal-first-lens` consumed inline for G + I applied design).

## OPEN-SURFACES (post-scope-pressure residuals)

### OS-1: Batch H (P6.2) → propose 25b dispatch
- Status: UNATTEMPTED; route-replan needed per scope-pressure proposal.
- Bounded scope: P6.2 cross-hook node-parse helper consolidation.
- Smallest next executable step: team-lead create 25b sub-dispatch with bounded helper-design + per-consumer-update + smoke-verification scope.

### OS-2: Batch J (P3.1 mega-bullet splits) → propose 25c + 25d (or further sharded) dispatches
- Status: UNATTEMPTED; route-replan needed per scope-pressure proposal.
- Bounded scope: P3.1 mega-bullet splits across ~30+ enumerated items in Shard A/B/C/D core-law mapped surfaces.
- Smallest next executable step: team-lead create 25c (Shard A items, ~6 items) + 25d (Shard B/C/D items, ~25 items) sub-dispatches; if 25d is still too wide, further shard by Shard B / Shard C / Shard D.

## LANE-NEXT-CANDIDATE
- team-lead: route-replan Batches H + J into 2-3 focused sub-dispatches (25b, 25c, optionally 25d); accept G + I applied work; advance to validator re-acceptance OR continue Wave 4 sub-dispatches in parallel.

## CONVERGENCE RECORD
PROCEDURE-EXECUTION-RESULT: partial — G + I PASS; H + J route-replan-needed via scope-pressure
NEXT-OWNER-ACTION: team-lead route-replan + sub-dispatch creation
