# dev-workflow: Final Acceptance Review
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

Final Acceptance Review is the final ACCEPT/REJECT workflow gate after validator `PASS` in validator-required chains.
Validator owns `PASS/HOLD/FAIL`.
team-lead owns `FINAL-ACCEPT/FINAL-REJECT`.

## Entry
Validator `PASS` opens Final Acceptance Review.
team-lead freezes one `FINAL-EVIDENCE-PACKET`.

`FINAL-EVIDENCE-PACKET` carries:
- `VALIDATOR-PASS`: validator verdict identity, completion-grade handoff path, reviewer evidence, tester evidence
- `INSTRUCTION-TRACE`: original user instructions, accepted follow-up instructions, and frozen `SCOPE-BASELINE` rows
- `CONTRACT`: frozen Receiver-Surface Contract, Consumption Chain, frozen upstream deferrals, frozen out-of-scope rows, requested output root
- `ARTIFACT-MAP`: final artifact identity, final location, produced output inventory, instruction-to-artifact mapping, artifact hygiene
- `USER-SURFACE`: target user environment, exact start/open/read/action path, minimum-effort read/use/operate path, minimum-effort stop/close/cleanup/re-entry path, and operator-delivery closure identity when material
- `PROOF`: real user-surface proof, proof-surface match, tool path used, tool execution evidence, retained evidence paths, Evidence-Quality Matrix identity
- `COVERAGE`: every material requested content, function, structure, format, data/calculation, media, interaction/control, operation, generation path, workflow path, or frozen deferral/out-of-scope row
- `BOUNDARIES`: material Boundary Register rows and downstream handoff status
- `ENVIRONMENT`: covered environment, equivalence declaration, or frozen environment deferral
- `OPEN-SURFACES`: remaining surfaces with frozen upstream deferral or frozen out-of-scope basis

## Parallel Evaluation
team-lead starts own-review and Codex advisory in parallel from the same frozen packet.
team-lead records own-review basis before reading Codex findings.
Codex evaluates independently from the same frozen packet.
team-lead reconciles own-review, Codex findings, or fail-open fallback basis point by point, then applies reject-first decision order.
Each available evaluation identifies the governing final-acceptance rules.
Each available evaluation judges evidence after rule identification.
Codex applies `feynman-clarity` as an advisory lens.
Codex names the user or receiver.
Codex names the task.
Codex names the completion path.
Codex names the evidence path.
Codex names the owner path.
Codex names the acceptance surface.
Codex writes the basis in plain short sentences.
Codex ties each material point to the identified rule.
Codex ties each material point to the evidence row.
Codex ties each material point to the user-ready completion effect.

Codex packet carries:
- this reference
- active top-level doctrine
- active dev-workflow skill
- active phase-gates reference
- active validator skill
- active validator-lane-detail reference
- active task-execution completion handoff contract
- active feynman-clarity skill
- active operator-delivery reference when operator-delivery fit is material
- final evidence packet paths

## Acceptance Criteria
Final ACCEPT answers one closure question.
Every original instruction, accepted follow-up instruction, and frozen `SCOPE-BASELINE` row maps to:
- final artifact or behavior
- retained evidence
- real user-surface proof
- matched, frozen upstream-deferred, or frozen out-of-scope status

Every material requested axis carries one of:
- retained matched evidence on the real user surface with Evidence-Quality Matrix support
- cited frozen upstream-deferral basis
- cited frozen out-of-scope basis

Material requested axes:
- original instruction trace
- accepted follow-up instruction trace
- `SCOPE-BASELINE` trace
- final artifact or behavior map
- decisive user-surface path
- target user environment fit
- audience, reader, learner, operator, or decision-surface fit
- proof-surface match
- minimum-effort start, open, read, or action path
- minimum-effort read, use, operate, or regenerate path when material
- minimum-effort stop, close, cleanup, and re-entry path when material
- every requested content, function, structure, format, data/calculation, media, interaction/control, operation, generation path, and workflow path
- visual-material purpose, evidence/source basis, readability, placement, and reader/learner value when material
- environment coverage or equivalence declaration
- error-channel visibility
- project output root and artifact hygiene
- open-surface state

Executable or runtime deliverables add:
- exact launch artifact
- operator invocation
- access
- termination
- cleanup
- clean relaunch
- visible data state when material
- operator environment fit

Reader-, decision-, or learning-facing deliverables add:
- answered-question or learning-objective closure
- audience/job fit
- section or slide sequence
- evidence or explanation trace
- navigability
- reader/learner burden

Rendered or human-consumed deliverables add:
- native-capable or format-faithful rendered evidence
- visible completeness
- material layout integrity
- reader burden

Visual-material deliverables add:
- visual-purpose mapping
- evidence/source basis
- proportion and placement fit
- readability
- media integrity
- unique reader/learner value

Generation or automation deliverables add:
- source-to-output mapping
- template/format fidelity
- reproducible generation path
- output inventory
- rerun path
- generated-artifact proof

Interface, API, library, or data-exchange deliverables add:
- contract completeness
- schema/bit fidelity
- conversion correctness
- integration proof against a real or representative consumer

Source-read outputs add:
- changed source or read surface
- rule force
- owner boundary
- cross-reference integrity
- design-intent preservation
- claim truth

## Decision
Reject-first decision order: if any material instruction, baseline row, acceptance axis, or executable user-facing operator-delivery axis lacks retained matched evidence, record `FINAL-REJECT` before `FINAL-ACCEPT` or workflow `Complete`.
Only after reject-first checks find no blocking gap, `FINAL-ACCEPT` opens workflow `Complete` from the current Final Acceptance Review entry identity: validator `PASS`, verified operator-delivery closure when executable user-facing, no later `FINAL-REJECT` in the acceptance loop, and team-lead `SV-RESULT` on the `FINAL-ACCEPT` record.
`FINAL-REJECT` converts its referenced validator `PASS` into rejection-analysis input and opens `task-execution` for assigned-validator rejection analysis.
Codex unavailable status records `fail-open:<reason>` with fallback final-acceptance inspection basis and conservative `SV-RESULT`; validator `PASS` identity remains the acceptance prerequisite.

`FINAL-ACCEPT` record carries:
- validator `PASS` identity
- governing final-acceptance rule set
- Evidence-Quality Matrix supported scope
- Feynman plain-explanation basis
- team-lead own-review basis
- Codex status
- reconciliation result
- 100% instruction-closure basis
- user-ready completion basis, including operator-delivery closure when executable user-facing
- final evidence packet identity
- open-surface state

`FINAL-REJECT` record carries:
- validator `PASS` identity
- governing final-acceptance rule set
- Feynman plain-explanation basis
- rejected instruction, acceptance, or operator-delivery axis
- evidence gap or contradiction
- user-ready gap
- team-lead own-review basis
- Codex status
- reconciliation result
- validator return instruction.

## Reject Route
Assigned validator writes the correction packet using active validator-lane-detail reference.
task-execution routes `FINAL-REJECT` follow-on work through the validator-authored correction packet before the owning correction route.
After the owning correction route returns a corrected artifact, applicable Phase 4/5 review, test, validation, and operator-delivery closure rerun on the corrected artifact when executable user-facing.
The fresh validator `PASS` from that rerun is the next Final Acceptance Review entry identity.
