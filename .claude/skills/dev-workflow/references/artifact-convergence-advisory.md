# dev-workflow: Artifact Convergence Advisory
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

Use only inside active `dev-workflow` after `work-planning` selected the workflow and a canonical artifact exists or was materially revised.

## Authority
Codex is advisory-only artifact review.
team-lead owns reconciliation and phase cursor truth.
The artifact owner owns revision.
`task-execution` owns assignment-grade correction dispatch.

Codex never blocks, dispatches, validates, accepts, issues `PASS/HOLD/FAIL`, mutates files, repairs tools, changes MCP/settings/hooks, replaces owner gates, or satisfies `CODEX-ADVISORY-BASIS`.

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
1. Artifact owner writes or revises the canonical artifact.
2. team-lead reviews independently before seeing or using the new Codex result.
3. team-lead records own-review basis: inspected surfaces, axes, findings or `none`, and next-phase risk.
4. team-lead sends a bounded read-only Codex packet.
5. Codex derives artifact-specific axes from artifact, user goal, doctrine, downstream consumers, domain/data meaning, proof burden, and phase gate.
6. Codex axes must include user-perspective and user-convenience checks.
7. Plan, design, specification, report, governance, and implementation-binding artifacts also require Feynman clarity.
8. team-lead reconciles team-lead and Codex findings point-by-point.
9. Accept a point only against artifact evidence, doctrine, or frozen request basis.
10. Accepted high/medium defects become bounded correction requirements.
11. Repeat after revision while material convergence value remains.

The first Codex packet in a pass must not include team-lead findings, verdict, or suggested fixes.
A reconciliation challenge may include both reviews.
Correction requires a fresh independent review pass.

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
Record:
- artifact path and phase
- team-lead own-review basis status and verdict
- Codex advisory status: `converged`, `resolved-divergence`, `non-converged`, or `fail-open:<reason>`
- accepted/rejected/deferred point counts
- fallback inspection basis when fail-open is used
- downstream artifact status: `current`, `stale`, or `hold`
- next owner: correction dispatch, phase advancement, fallback review, or `HOLD`
