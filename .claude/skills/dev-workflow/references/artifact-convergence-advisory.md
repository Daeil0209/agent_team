# dev-workflow: Artifact Convergence Advisory
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

Use only inside active `dev-workflow` after `work-planning` selected the workflow and a canonical artifact exists or was materially revised.

## Authority
Codex is advisory-only design-coherence review.
team-lead owns phase design, Codex advisory consumption, reconciliation, `REDESIGN-PLAN` synthesis, and phase cursor truth.
Codex findings return to `team-lead` as redesign input; team-lead adjudicates them and synthesizes one coherent phase basis before artifact-producer dispatch.
The assigned artifact producer owns document writing or revision inside the frozen owner basis.
`task-execution` owns assignment-grade correction dispatch.
User-facing convergence reporting is silent by default; if needed, report only one short next-action, dispatch-pending, or blocker line.

Codex never blocks, dispatches, validates, accepts, issues `PASS/HOLD/FAIL`, mutates files, repairs tools, changes MCP/settings/hooks, or replaces owner gates.
`CODEX-ADVISORY-BASIS` remains the team-lead trigger, adjudication, or fail-open record; Codex output alone never satisfies it.

`REDESIGN-PLAN` is valid only when it states redesigned decisions, affected design dimensions, consistency impacts across materially affected scope/risk/user-surface/proof/acceptance/downstream/phase-gate surfaces, then derived producer instructions.
A section edit list, addendum, framing note, or renamed patch list is not a valid `REDESIGN-PLAN` or producer-dispatch basis.
Producer dispatch names the team-lead `REDESIGN-PLAN` as basis, not Codex findings.
Invalid `REDESIGN-PLAN` dispatch stops that producer path; produced output is diagnostic only until valid `REDESIGN-PLAN` redispatch replaces it.

## Trigger
Run for:
- Phase 1 canonical plan artifact
- Phase 2 design artifact or implementation-binding design bundle
- first artifact that freezes data model, API, UX, proof, import/export lineage, exact operator launch/termination path, module decomposition, or acceptance basis

Do not run for receipt/status/control-only messages, typo-only edits, already-converged artifacts without material upstream change, or light answer-only work.

## Packet
Use Codex tool, privacy, canonical-read, stabilization, and fail-open discipline from `.claude/skills/work-planning/references/codex-advisory.md`.
Every packet includes:
- `.claude/CLAUDE.md`
- `.claude/skills/dev-workflow/SKILL.md`
- `.claude/skills/dev-workflow/references/phase-gates.md`
- `.claude/skills/dev-workflow/references/phase-surfaces.md`
- `.claude/skills/feynman-clarity/SKILL.md` when Feynman clarity applies
- current canonical artifact path
- downstream artifact paths that may be stale

Codex must read canonical paths directly.
A team-lead paraphrase is not doctrine.
Missing required path records `fail-open:blocked_by_config`.

## Dual Review
1. Assigned artifact producer writes or revises the canonical artifact from the frozen owner basis.
2. team-lead reviews independently before seeing or using the new Codex result.
3. team-lead records own-review basis: inspected surfaces, axes, findings or `none`, and next-phase risk.
4. team-lead sends a bounded read-only Codex packet.
5. Codex reviews design coherence, missing content, owner-boundary fit, downstream consistency, proof/acceptance sufficiency, and phase-gate readiness.
6. Codex derives artifact-specific axes from artifact, user goal, doctrine, downstream consumers, domain/data meaning, proof burden, and phase gate.
7. Codex axes must include user-perspective and user-convenience checks.
8. Codex reports wording or typo issues only when they change design meaning, user burden, proof, acceptance, or downstream implementation.
9. Plan, design, specification, report, governance, and implementation-binding artifacts also require Feynman clarity.
10. team-lead reconciles team-lead and Codex findings point-by-point.
11. Accept a point only against artifact evidence, doctrine, or frozen request basis.
12. Accepted findings enter team-lead redesign as inputs.
13. team-lead synthesizes one coherent phase basis across affected scope, risk, user-surface, proof, acceptance, downstream artifact, and phase-gate surfaces.
14. team-lead records review evidence in the reconciliation record and records valid `REDESIGN-PLAN`.
15. `task-execution` dispatches the assigned artifact producer from valid team-lead `REDESIGN-PLAN` only; Codex finding lists stay in the advisory record.
16. Assigned artifact producer updates the canonical artifact from the team-lead `REDESIGN-PLAN`.
17. After each revision, repeat steps 2-16 while material convergence value remains.

Artifact-producer or developer self-review is input only.
It never satisfies team-lead own-review basis.
The first Codex packet in a pass must not include team-lead findings, verdict, or suggested fixes.
A reconciliation challenge may include both reviews.
Correction requires a fresh independent review pass.
The changed artifact is reviewed again before the new Codex result is seen or used.
Prior own-review, landing confirmation, diff-only spot-check, Codex-result relay, or consensus wording cannot carry forward.

## Same-Boundary Loop
Do not reopen `work-planning` between passes while all remain unchanged:
- `ACTIVE-WORKFLOW: dev-workflow`
- phase
- canonical artifact or named stale downstream artifact under repair
- owner map
- deliverable shape
- staffing shape
- proof/acceptance chain
- user requirement and request-fit basis

Reopen `work-planning` when any boundary changes, becomes untrue, or cannot be named.

Same-artifact continuation packet carries:
```text
ADVISORY-CONTINUATION: artifact-convergence
ACTIVE-WORKFLOW: dev-workflow
CONTINUATION-CLASS: bounded-iteration
CURRENT-PHASE: <Phase N name>
CANONICAL-ARTIFACT: <path>
BOUNDARY-UNCHANGED: yes
```

Missing or false continuation values reopen `work-planning` or stop on `HOLD`.
Valid continuation preserves boundary only.
It does not preserve prior own-review, Codex review, or reconciliation as current-pass result.

## Resolution
Phase advancement requires:
- recorded team-lead own-review basis
- completed Codex review or lawful fail-open
- point-by-point reconciliation
- no accepted high/medium issue affecting the next phase
- every point accepted, rejected, or deferred with reason
- deferred low issues have later phase and owner
- downstream artifact status is current, intentionally held, or explicitly stale
- no owner-decidable default or routine phase advance is turned into a user question
- `SV-RESULT` verifies the reconciled claim

Route-level `CODEX-ADVISORY-BASIS` does not satisfy this artifact-level convergence record.
Missing output record blocks CP user escalation that consumes the artifact, phase advancement, next-phase dispatch, and phase-result reporting.
For phase-gate material artifacts, lawful fail-open requires fallback reviewer-style artifact inspection plus conservative `SV-RESULT`.
If Codex reports non-ready, close only by `resolved-divergence` grounded in doctrine, artifact evidence, or frozen request basis.
Codex non-ready state is advisory, not veto.

Stop on `HOLD` when:
- two consecutive passes add no material finding
- the same unresolved point repeats without new evidence
- the artifact owner cannot revise the blocker
- required access is unavailable outside fail-open
- another pass would repeat an adjudicated dispute

## Phase 2 Binding Surfaces
Phase 2 convergence covers implementation-binding:
- launcher and operator-runtime contract
- architecture and selected rationale
- material specialist packets, oracles, and contract deltas that shape implementation, proof, or acceptance
- ERD, data invariants, and lifecycle
- API/request/response/error contracts
- screen specs, first-viewport priority, and user-flow contracts
- import/export mapping and validation error model
- service/module responsibility map
- proof plan and user-surface acceptance path
- CP4 implementation decomposition

If one design artifact exists, converge on that artifact.
If a bundle exists, converge on explicit bundle paths.
If later sub-artifacts become implementation contracts, converge on affected paths before Phase 3 or CP4.

## Stale Downstream
Accepted high/medium upstream changes make dependent downstream artifacts stale when they affect user-fit, data/domain meaning, API, UX, operator-delivery path, proof, validation, or acceptance basis.
Stale artifacts support diagnosis only.
They must not drive implementation, review, testing, validation, or acceptance.

After upstream convergence, choose exactly one:
- revise downstream artifacts
- regenerate downstream artifacts
- `HOLD` with exact reason

## Output Record
Output record is internal phase evidence.
Same-artifact convergence passes do not produce `PHASE-RESULT`; routine pass detail stays internal.
Use `PHASE-RESULT` only when the phase exits, reaches `HOLD`, or reports a completed phase outcome.
Do not print own-review findings, Codex findings, reconciliation tables, point lists, or raw advisory payloads unless the user explicitly asks for details.
Record:
- artifact path and phase
- team-lead own-review basis status and verdict
- Codex advisory status: `converged`, `resolved-divergence`, `non-converged`, or `fail-open:<reason>`
- accepted/rejected/deferred point counts
- redesign plan validity for accepted findings: `not-needed`, `valid`, `invalid`, or `missing`
- fallback inspection basis when fail-open is used
- downstream artifact status: `current`, `stale`, or `hold`
- next owner/action: correction dispatch, phase advancement, fallback review, or `HOLD`
