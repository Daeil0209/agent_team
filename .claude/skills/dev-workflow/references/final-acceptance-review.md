# dev-workflow: Final Acceptance Review
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/dev-workflow/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
auto-inject: false

Final Acceptance Review is the workflow-closure reconciliation after validator `PASS` in validator-required chains.
Validator owns final `PASS/HOLD/FAIL`.
team-lead owns `FINAL-ACCEPT/FINAL-REJECT` as workflow-closure records; they do not replace validator verdict authority.

## Contents
- Entry
- Parallel Evaluation
- Acceptance Criteria
- Decision
- Reject Route
- Resolve Next Owner And Action

## Entry
Validator `PASS` opens Final Acceptance Review.
team-lead freezes one `FINAL-EVIDENCE-PACKET`.

`FINAL-EVIDENCE-PACKET` carries:
- `VALIDATOR-PASS`: validator verdict identity, completion-grade handoff path, reviewer evidence, tester evidence
- `INSTRUCTION-TRACE`: original user instructions, accepted follow-up instructions, and frozen `SCOPE-BASELINE` rows
- `CONTRACT`: frozen Receiver-Surface Contract, Consumption Chain, frozen upstream deferrals, frozen out-of-scope rows, requested output root
- `ARTIFACT-MAP`: final artifact identity, final location, produced output inventory, instruction-to-artifact mapping, artifact hygiene
- `USER-SURFACE`: target user environment, exact start/open/read/action path, material first-use/data-content/demo/import state, minimum-effort read/use/operate path, minimum-effort stop/close/cleanup/re-entry path, and operator-delivery closure identity when material
- `PROOF`: real user-surface proof, proof-surface match, tool path used, tool execution evidence, retained evidence paths, Evidence-Quality Matrix identity.
  For user-facing rendered surfaces, `PROOF` consumes `.claude/skills/dev-workflow/references/phase-surfaces.md` `Rendered Image Evidence Rule`.
  `PROOF` includes the required captures and an `IMAGE-INSPECTION-RECORD` for each rendered capture used as acceptance evidence.
  Missing required direct-open inspection under that rule is procedurally invalid for `FINAL-ACCEPT`.
  When external visual benchmarks materially shaped operator-facing UI, dashboards, reports, or decks, `FINAL-EVIDENCE-PACKET` carries the frozen benchmark-synthesis identity.
  Final Acceptance Review compares rendered proof against the frozen benchmark-synthesis characteristics.
  Missing required design-time benchmark synthesis is an acceptance gap.
  Final Acceptance Review does not create first-time design-shaping benchmark synthesis as a proof substitute.
- `COVERAGE`: every material requested content, function, structure, format, data/calculation, media, interaction/control, operation, generation path, workflow path, or frozen deferral/out-of-scope row
- `BOUNDARIES`: material Boundary Register rows and downstream handoff status
- `ENVIRONMENT`: covered environment, equivalence declaration, or frozen environment deferral
- `OPEN-SURFACES`: remaining surfaces with frozen upstream deferral or frozen out-of-scope basis

## Parallel Evaluation
team-lead starts own-review and Codex MCP independent review in parallel from the same frozen packet when the configured-review trigger is material or already frozen for this closure surface.
Use Codex tool, privacy, canonical-read, stabilization, and fail-open discipline from `.claude/skills/codex-independent-review/references/common-contract.md`.
team-lead records own-review basis before reading Codex findings.
Codex evaluates independently from the same frozen packet.
team-lead reconciles own-review, Codex findings, skipped-review basis, or fail-open fallback basis point by point, then applies reject-first decision order.
Each available evaluation:
- identifies the governing final-acceptance rules
- judges evidence after rule identification
Codex applies `feynman-clarity` as a non-authoritative independent-review lens.
Codex names:
- the user or receiver
- the task
- the completion path
- the evidence path
- the owner path
- the acceptance surface
Codex writes the basis in plain short sentences.
Codex ties each material point to:
- the identified rule
- the evidence row
- the user-ready completion effect

Codex packet carries:
- this reference
- active configured independent-review common contract
- active top-level doctrine
- active dev-workflow skill
- active phase-gates reference
- active validator skill
- active validator-lane-detail reference
- active task-execution completion handoff contract
- active feynman-clarity skill
- active benchmark-simulation skill when benchmark synthesis is material
- active operator-delivery reference when operator-delivery fit is material
- final evidence packet paths
- original instruction-trace plus frozen plan/design acceptance rows as scope-defining input (validator's `PASS-SCOPE-EXCLUSIONS` or narrowed claims travel as evidence rows for inspection, not as Codex's scope)

## Acceptance Criteria
Final ACCEPT answers one closure question.
Every original instruction, accepted follow-up instruction, and frozen `SCOPE-BASELINE` row maps to:
- final artifact or behavior
- retained evidence
- real user-surface proof
- matched, user-authorized-deferred (with frozen-record passage citation), or original-plan/design-out-of-scope (with frozen-record passage citation) status

Apply only the deliverable-type sub-bundles explicitly listed in `SCOPE-BASELINE` and the frozen Receiver-Surface Contract.
Mark non-applicable sub-bundles `not-applicable:<frozen-record-passage>`.
FAR records sub-bundle selection rationale citing the frozen-record passage before reject-first decision.
Self-defined narrowing without frozen-record citation is a silent-PASS defect.

Every material requested axis carries one of:
- retained matched evidence on the real user surface with Evidence-Quality Matrix support
- cited frozen upstream-deferral basis
- cited original-plan/design-out-of-scope basis (with frozen-record passage citation)

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
- minimum-effort read, use, operate, regenerate, data/example application, or method-reuse path when material
- minimum-effort stop, close, cleanup, and re-entry path when material
- every requested content, function, structure, format, data/calculation, media, interaction/control, operation, generation path, workflow path, and use-instruction path
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
- sufficient first-use visible data state, including empty/demo/seed/imported coverage, representative workflow/calculation/validation evidence, and reset/reload path when visible behavior depends on operator data
- operator environment fit

Reader-, decision-, or learning-facing deliverables add:
- answered-question or learning-objective closure
- audience/job fit
- section or slide sequence
- evidence, source-data, example-application, use-method, or explanation trace
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
Reject-first decision order: if any material instruction, baseline row, acceptance axis, `CORE-WORKFLOW-CLOSURE` row, or executable user-facing operator-delivery axis lacks retained matched evidence, record `FINAL-REJECT` before `FINAL-ACCEPT` or workflow `Complete`.
Subset-anchor own-review (anchoring on implemented routes/templates instead of the design's `CORE-WORKFLOW-CLOSURE` rows) is automatic FINAL-REJECT.
FAR own-review compares retained matched-evidence axes against original instruction-trace and frozen plan/design acceptance rows directly; validator-narrowed PASS-scope without frozen-record passage citation is automatic FINAL-REJECT-CANDIDATE on the excluded axis.
FAR own-review, validator-result consumption, and Codex fallback review consume applicable `Skill(review-verification)` named lenses before `FINAL-ACCEPT` or correction dispatch relies on the reviewed surface.
Only after reject-first checks find no blocking gap, `FINAL-ACCEPT` opens workflow `Complete` from the current Final Acceptance Review entry identity: validator `PASS`, verified operator-delivery closure when executable user-facing, no later `FINAL-REJECT` in the acceptance loop, and team-lead `Skill(self-verification)` result verification on the `FINAL-ACCEPT` record.
`FINAL-REJECT` converts its referenced validator `PASS` into rejection-analysis input for `far-reject-routing`; enter `task-execution` only for assigned correction dispatch after team-lead classification.
Codex unavailable status records `fail-open:<reason>` with fallback closure-inspection basis and conservative `Skill(self-verification)` result verification; validator `PASS` identity remains the acceptance prerequisite.

`FINAL-ACCEPT` record carries:
- validator `PASS` identity
- governing final-acceptance rule set
- Evidence-Quality Matrix supported scope
- Feynman plain-explanation basis
- team-lead own-review basis
- Codex MCP independent-review status
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
- Codex MCP independent-review status
- reconciliation result
- validator return instruction
- `IMAGE-EVIDENCE` for every visual / rendered defect follows `.claude/skills/dev-workflow/references/phase-surfaces.md` `Rendered Image Evidence Rule`; each entry names the capture path, design-stated expectation, concrete observed deviation, and multimodal `Read` direct-open confirmation. Visual defects without an attached image entry are procedurally invalid; FAR producers capture the image at FAR time when the prior tester/validator capture is missing or stale.

## Reject Route
Assigned validator writes the correction packet using active validator-lane-detail reference.
`FINAL-REJECT` keeps the active `dev-workflow` acceptance loop open; it is not workflow completion, user-decision wait, or a new top-level task.
task-execution routes `FINAL-REJECT` follow-on work through the validator-authored correction packet before the owning correction route.
team-lead direct execution of production, test, or validation correction work without validator-authored correction packet routing through task-execution is lane-bypass; treat as procedural failure equivalent to silent self-certification.
Validator correction packet names root-cause class, correction owner surface, required evidence, and revalidation target; it is evidence for route classification, not route freeze.
team-lead classifies the owning correction route per `.claude/skills/dev-workflow/references/checkpoints.md` CP5 Auto-resolve priority before dispatch.
After the owning correction route returns a corrected artifact, applicable Phase 4/5 review, test, validation, and operator-delivery closure rerun on the corrected artifact when executable user-facing.
The fresh validator `PASS` from that rerun is the next Final Acceptance Review entry identity.

## Resolve Next Owner And Action
- Reject-first gap opens `FINAL-REJECT`.
- `FINAL-REJECT` opens `far-reject-routing` classification; correction dispatch enters `task-execution` only after team-lead route classification.
- Validator correction packet opens CP5 route classification.
- CP5 design-level classification opens Phase 2 correction.
- CP5 implementation or operator-delivery classification opens Phase 5 correction.
- Corrected artifact opens applicable Phase 4/5 review, proof, validation, and operator-delivery rerun.
- Fresh validator `PASS` opens a new Final Acceptance Review entry.
- Clean reject-first result opens `FINAL-ACCEPT` after current `Skill(self-verification)` result verification.
- `FINAL-ACCEPT` opens workflow `Complete`.
