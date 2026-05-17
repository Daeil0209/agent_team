# dev-workflow: Artifact Convergence Review
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/dev-workflow/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
auto-inject: false

Use only inside active `dev-workflow` after `work-planning` selected the workflow and a canonical artifact exists or was materially revised.

## Contents
- Authority
- Trigger
- Packet
- Dual Review
- Same-Boundary Loop
- Resolution
- Phase 2 Binding Surfaces
- Stale Downstream
- Output Record
- Resolve Next Owner And Action

## Authority
Codex MCP is the current configured independent-review adapter for design-coherence review.
Codex output is independent design-coherence evidence, not workflow phase authority.
team-lead owns phase design, configured-review consumption, reconciliation, `REDESIGN-PLAN` synthesis, and phase cursor truth.
Codex findings return to `team-lead` as configured-review input; team-lead adjudicates them and synthesizes one coherent phase basis.
For Phase 1/2 canonical artifacts (plan / design), team-lead authors and self-edits the document directly.
For Phase 3+ sub-artifact convergence with a separate assigned producer, the producer owns document writing or revision inside the frozen owner basis, and `task-execution` owns assignment-grade correction dispatch.
User-facing convergence reporting is silent by default; if needed, report only one short next-action, dispatch-pending, or blocker line.

Configured independent-review authority boundary is owned by `.claude/skills/work-planning/references/codex-independent-review.md`; this reference consumes that boundary for artifact-convergence review.
`CODEX-INDEPENDENT-REVIEW-BASIS` remains the team-lead trigger, adjudication, or fail-open record; Codex output alone never satisfies it.

`REDESIGN-PLAN` validity requires four named contents in order:
1. redesigned decisions
2. affected design dimensions
3. consistency impacts across materially affected scope/risk/user-surface/proof/acceptance/downstream/phase-gate surfaces
4. derived producer instructions
A section edit list, addendum, framing note, or renamed patch list is not a valid `REDESIGN-PLAN` or producer-dispatch basis.
Producer dispatch names the team-lead `REDESIGN-PLAN` as basis, not Codex findings.
Invalid `REDESIGN-PLAN` dispatch stops that producer path.
Produced output is diagnostic only until valid `REDESIGN-PLAN` redispatch replaces it.

## Trigger
Run for:
- Phase 1 canonical plan artifact
- Phase 2 design artifact or implementation-binding internal detail bundle
- first artifact that freezes data model, API, UX, proof, import/export lineage, exact operator launch/termination path, module decomposition, or acceptance basis

Do not run for receipt/status/phase-context-only messages, typo-only edits, already-converged artifacts without material upstream change, or light answer-only work.

## Packet
Use Codex tool, privacy, canonical-read, stabilization, and fail-open discipline from `.claude/skills/work-planning/references/codex-independent-review.md`.
Every packet includes:
- `.claude/CLAUDE.md`
- `.claude/skills/dev-workflow/SKILL.md`
- `.claude/skills/dev-workflow/references/phase-gates.md`
- `.claude/skills/dev-workflow/references/phase-surfaces.md`
- `.claude/skills/feynman-clarity/SKILL.md` when Feynman clarity applies
- `.claude/skills/benchmark-simulation/SKILL.md` when Phase 2 benchmark-required coverage is material
- current canonical artifact path
- potentially stale downstream artifact paths

Codex must read canonical paths directly.
A team-lead paraphrase is not doctrine.
Missing required path records `fail-open:blocked_by_config`.

## Dual Review
1. The artifact authoring owner writes or revises the canonical artifact from the frozen owner basis.
2. team-lead authors Phase 1/2 canonical plan and design artifacts.
3. The assigned producer authors Phase 3+ separate-producer artifacts.
4. team-lead defect-seeking own-review and Codex MCP independent review run in parallel when independence holds.
5. team-lead records own-review basis before reading or using Codex output.
6. team-lead own-review basis carries:
   - inspected surfaces
   - material specialist skills or `none`
   - challenge axes
   - plausible defects or `none`
   - plausible defeaters or `none`
   - next-phase risk
7. The first Codex packet in a pass uses canonical paths per `Packet`.
8. The first Codex packet excludes team-lead findings, verdict, and suggested fixes.
9. Artifact-producer or developer self-review is input only.
10. Artifact-producer or developer self-review never satisfies team-lead own-review basis.
11. Codex reviews design coherence, missing content, owner-boundary fit, downstream consistency, proof/acceptance sufficiency, and phase-gate readiness.
12. Codex derives artifact-specific axes from artifact, user goal, doctrine, downstream consumers, domain/data meaning, proof burden, and phase gate.
13. Codex axes include user-perspective checks.
14. Codex axes include user-convenience checks.
15. Operator-facing rendered UI axes consume `Skill(visual-composition)` for operator-naive comprehension.
16. Phase 2 benchmark-required axes consume `Skill(benchmark-simulation)` for external-reference capture, information-representation pattern extraction, and abstraction-fit-adapt synthesis.
17. Benchmark coverage checks invocation, source/capture basis, extracted concrete characteristics, rejected misfits, and destination-fit synthesis.
18. Operator-facing rendered UI axes include acceptance image-evidence path.
19. Acceptance image-evidence path checks per-AC capture cited and openable via multimodal `Read`.
20. Codex reports wording or typo issues only when they change design meaning, user burden, proof, acceptance, or downstream implementation.
21. Plan, design, specification, report, governance, and implementation-binding artifacts also require Feynman clarity.
22. team-lead reconciles team-lead and Codex findings point-by-point.
23. Accept a point only against artifact evidence, doctrine, or frozen request basis.
24. Accepted findings enter team-lead redesign as inputs.
25. team-lead synthesizes one coherent phase basis across affected scope, risk, user-surface, proof, acceptance, downstream artifact, and phase-gate surfaces.
26. team-lead records review evidence in the reconciliation record and records valid `REDESIGN-PLAN`.
27. For Phase 3+ separate-producer artifacts, `task-execution` dispatches the assigned artifact producer from valid team-lead `REDESIGN-PLAN` only.
28. Codex finding lists stay in the Codex review record.
29. For Phase 1/2 canonical artifacts, team-lead self-applies the `REDESIGN-PLAN` directly.
30. The artifact authoring owner updates the canonical artifact from the team-lead `REDESIGN-PLAN`.
31. After each revision, repeat the Dual Review sequence while material convergence value remains.
32. Reconciliation challenges include both reviews when both reviews are material.
33. Correction requires a fresh independent review pass for the changed material surface before relying on the correction.
34. The changed material artifact surface is reviewed again before the new Codex result is read or used.
35. Prior own-review, landing confirmation, diff-only spot-check, Codex-result relay, or consensus wording does not carry forward.

## Same-Boundary Loop
`.claude/skills/dev-workflow/references/artifact-convergence-review.md` `## Same-Boundary Loop` owns same-boundary common fields for artifact-convergence and review-convergence:
- `ACTIVE-WORKFLOW: dev-workflow`
- phase
- owner map
- deliverable shape
- staffing shape
- proof/acceptance chain
- user requirement and request-fit basis

Artifact-convergence adds canonical artifact or named stale downstream artifact under repair.
Do not reopen `work-planning` between passes while the common fields and artifact-convergence added field remain unchanged.
Reopen `work-planning` when any boundary changes, becomes untrue, or cannot be named.

Same-artifact continuation packet carries:
```text
REVIEW-CONTINUATION: artifact-convergence
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
- owner-decidable defaults and routine phase advancement route to the next owner/action
- `SV-RESULT` verifies the reconciled claim

After `converged` or `resolved-divergence` phase-gate artifact resolution satisfies Phase advancement requirements, execute `next owner/action` as phase advancement, next phase boundary `work-planning`, or the named downstream owner.
User-facing review/proceed prompts are valid only when the user already requested review, explicit approval is required, or a verified user-owned blocker exists; otherwise keep review offers internal and execute the next owner/action.

Route-level `CODEX-INDEPENDENT-REVIEW-BASIS` does not satisfy this artifact-level convergence record.
Missing output record blocks CP user escalation that consumes the artifact, phase advancement, next-phase dispatch, and phase-result reporting.
For phase-gate material artifacts, lawful fail-open requires fallback reviewer-style artifact inspection plus conservative `SV-RESULT`.
If Codex reports non-ready, close only by `resolved-divergence` grounded in doctrine, artifact evidence, or frozen request basis.
Codex non-ready state is evidence, not veto.

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
- real-use contract fields for material user-facing surfaces
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
They must not control implementation, review, testing, validation, or acceptance.

After upstream convergence, choose exactly one:
- revise downstream artifacts
- regenerate downstream artifacts
- `HOLD` with exact reason

## Output Record
`INDEPENDENT-REVIEW-CONVERGENCE-RECORD` is internal phase evidence.
Same-artifact convergence passes do not produce `PHASE-RESULT`; routine pass detail stays internal.
Use `PHASE-RESULT` only when the phase exits, reaches `HOLD`, or reports a completed phase outcome.
Do not print own-review findings, Codex findings, reconciliation tables, point lists, or raw Codex review payloads unless the user explicitly asks for details.
Record:
- artifact path and phase
- team-lead own-review basis status and verdict
- Codex MCP independent-review status: `converged`, `resolved-divergence`, `non-converged`, or `fail-open:<reason>`
- accepted/rejected/deferred point counts
- redesign plan validity for accepted findings: `not-needed`, `valid`, `invalid`, or `missing`
- fallback inspection basis when fail-open is used
- downstream artifact status: `current`, `stale`, or `hold`
- implementation-binding internal detail bundle status when Phase 2 closure uses that bundle: `not-applicable`, `complete`, `missing`, `stale`, or `hold`
- material specialist contract status when specialist output shapes implementation, proof, or acceptance: `not-applicable`, `current`, `missing`, `stale`, or `hold`
- next owner/action: correction dispatch, phase advancement, fallback review, or `HOLD`
For `converged` or `resolved-divergence` phase-gate artifacts that satisfy Phase advancement requirements, the output record carries an executable next owner/action; it does not end at user direction.
A conditional status of `missing`, `stale`, or `hold` blocks phase advancement and records correction, stale-surface repair, or `HOLD` as next owner/action.

## Resolve Next Owner And Action
- Accepted findings open artifact owner redesign or correction.
- Valid `REDESIGN-PLAN` opens artifact mutation by the owning producer.
- Missing output record blocks phase advancement and next-phase dispatch.
- `converged` or `resolved-divergence` output opens the recorded next owner/action.
- `non-converged` output opens correction, fallback review, or `HOLD`.
- Lawful `fail-open` opens fallback artifact inspection plus conservative `SV-RESULT`.
- Stale downstream artifact opens revise, regenerate, or `HOLD`.
