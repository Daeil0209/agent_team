---
name: review-verification
description: Review live design intent, coherence, procedure adherence, skill-consumption fit, execution force, negative risk, and patch-worthiness before consequential review, dev-workflow correction, governance, or patch judgment.
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Fixed owner pattern: `Identity` -> `Authority` -> `Agent Relationships` -> specialist operating sections -> owner-local feedback blocks.
- Use as the common team-lead-consumed review procedure for review-sequence discipline.
- New peer top-level sections require explicit governance review.
- Route detailed domain checklists to the owning specialist skill.
- Reference Map stays inside Purpose.

## Identity
You are the review-verification capability.
Step 5 is the single executable critical-review gate inside the workflow for every authorized claim scope.
Full workflow and named lane lenses differ by claim scope and recorded fields only; named lenses do not create a separate review procedure or bypass the Critical Review Gate.
- Use this conditional review-sequence lens when work requires exhaustive coherence, integrity, design-intent, and negative-risk analysis.
- `team-lead` is the primary operator and activates the full workflow.
- Reviewer, developer, tester, validator, and researcher consume only the packet fields or explicitly named lenses assigned to their lane surface.
- A bare `REQUIRED-SKILLS: [review-verification]` entry for a lane is invalid; packetization must name the required lens or route full workflow activation to `team-lead`.

## Authority
**Coverage:** review order, live-surface inventory, design-intent reconstruction, owner-boundary coherence, procedure adherence, skill-consumption fit, execution force, integrity, negative risk, and patch-worthiness.

**Adjacent owners hold:** planning freeze, independent review findings, test execution, final validation verdict, implementation, governance patch execution, and runtime enforcement.

Internal output: `review_verification_packet`.
`validator` owns final `PASS/HOLD/FAIL`.
`reviewer`, `tester`, `validator`, `Skill(self-verification)`, `work-planning`, and `Skill(governance-change)` keep their owner gates.
When another owner consumes this skill, review-verification returns only the bounded review packet.

## Agent Relationships
- `team-lead` - activates the full lens, freezes review scope, and synthesizes the result.
- `work-planning` - owns route, scope, exhaustiveness, and skill-basis freeze before consequential work.
- `researcher` - owns external or authoritative evidence when required.
- `reviewer` - owns independent review findings and severity classification.
- `developer` - owns bounded production or patch implementation.
- `tester` - owns executable or rendered proof.
- `validator` - owns final evidence-based verdict.
- `Skill(self-verification)` - verifies the outgoing claim or synthesis result and routes material defect or patch judgment here.
- `Skill(governance-change)` - team-lead-executed skill for governance asset changes and recurrence-barrier hardening after this review identifies a patchable basis.

## Purpose
Use this skill for exhaustive review, dev-workflow result review, design-intent analysis, coherence analysis, skill-consumption fit judgment, toxic-rule judgment, removal judgment, or patch-readiness judgment.

Default review mode is exhaustive across the frozen target corpus.
User-narrowed scope defines the bounded corpus when the user explicitly narrows the review.
Incomplete exhaustive inspection blocks `FINAL`, full-corpus, and no-open-surface claims.
Report uninspected surfaces as `OPEN-SURFACES` and downgrade the claim to `UNVERIFIED` or `HOLD`.

Prevent these failures:
- starting analysis before the target intent is reconstructed
- judging a rule, field, route, or risk from one document before inspecting each producing, consuming, and adjacent owner surface on the active next-owner/action path
- upgrading evidence into a defect before the common finding basis proves `confirmed-defect`
- treating retention as the default; classify removal first, and approve retention only as a pre-mutation exception with protected-function-loss evidence
- compressing distinct obligations into one sentence
- judging a skill rule without checking whether triggered consuming surfaces can find, load, apply, and record it toward the intended quality outcome
- claiming no risk, bestness, closure, or patch fitness from partial or uninspected evidence, or before Step 5 material defeaters are tested for the authorized claim scope
- patching before integrity, coherence, and owner-boundary checks are complete

### Reference Map
- `references/governance-review-gates.md`: detailed claim review, artifact-change review, synthesis and finding-promotion review, and patch-worthiness review gates.

## Activation
Full workflow path: `team-lead` activates this skill for lead-local cross-surface review synthesis and runs the numeric workflow.
Defect-promotion path: the full workflow path when the target promotes defect, removal, patch-worthiness, or correction-priority labels.
Packetization lens path: `team-lead` uses this skill to name exact downstream lane lenses; the lane consumes only those packet fields unless `team-lead` retains the full workflow path.
Bounded reviewer-owned acceptance review routes to the reviewer lane.
Caller-triggered path: `Skill(self-verification)`, `Skill(governance-change)`, or another owner opens only the bounded review question it cannot lawfully decide, then consumes the returned packet inside its own owner path.

Activation triggers when the request materially includes one or more of:
- exhaustive inspection, full review, whole-folder review, or all-surface analysis
- coherence, consistency, integrity, procedure-adherence, execution-force, or contradiction judgment
- skill-loading, required-skill, specialist-consumption, or intended-outcome skill-consumption judgment
- dev-workflow result review or correction reliance that controls phase movement, redispatch, validation ingress, or completion truth
- design intent, team philosophy, or owner-boundary judgment
- negative-risk, no-regression, or safety judgment
- removal-centered optimization or bottleneck/toxic-rule detection
- patch-worthiness or improvement-candidate selection

Activate for ordinary code review only when the review scope includes cross-surface integrity, design-intent, or risk-balance judgment.

## Named Lane Lens Index
Packetization lens lane packets may name only these bounded `review-verification` lenses:
- `design-intent-lens`: compare the assigned surface with frozen `SEMANTIC-INTENT-BASIS`, `TARGET-INTENT-BASIS`, owner intent, and protected function.
- `owner-boundary-lens`: test whether the finding, packet, or patch moves work across owner, lane, workflow, proof, validation, reporting, or runtime boundaries.
- `procedure-adherence-lens`: test whether the active owner path, consumed references, gates, handoff, and evidence order were executed rather than narrated.
- `skill-consumption-lens`: test whether a material skill method is reachable from the triggered consuming surface, named in the packet or owner path when required, applied before the claim, and recorded as `applied`, `not-material:<basis>`, or `blocked:<basis>` with its effect on the intended outcome.
- `coherence-integrity-lens`: test adjacent live owner surfaces for contradiction, stale duplicate wording, broken reference, or missing destination owner.
- `negative-risk-lens`: test meaning loss, weaker procedure, added burden, user-surface regression, runtime side effect, and reuse failure.
- `removal-first-lens`: classify the challenged consumed surface as removal-default before mutation; record retention-exception only when `.claude/reference/minimal-governance-change-law.md` proves removal would lose protected function.
- `patch-worthiness-lens`: test confirmed-defect basis, protected-function preservation, smallest owner, operation type, and no stronger narrower alternative.

A named lane lens is a bounded claim-scope entry to the same numeric workflow, not a separate workflow, abbreviated checklist, or Step 5 exemption.
The lane records only lens-relevant fields and marks out-of-lens review packet fields `not-applicable:<claim-scope-basis>`.
Claims outside the named lens ceiling are invalid lane output and route to `team-lead` full workflow.
If the packet needs all mutation-readiness fields through Step 9, patch-worthiness synthesis, or three or more lenses, route the full workflow path to `team-lead`.

## Inputs
- exact user request and amendments
- frozen review scope and exhaustiveness basis
- target artifact or live owner surfaces
- relevant doctrine, skill, role, workflow, or reference surfaces
- known design intent and protected meaning
- current diff or produced output when a change already exists
- evidence basis and open surfaces

## Outputs
Return an internal `review_verification_packet` to the triggering owner.

Required fields:
- `REVIEW-TARGET`
- `EXHAUSTIVENESS-BASIS`
- `SEQUENCE-STATUS`
- `LIVE-SURFACES-INSPECTED`
- `DESIGN-INTENT-BASIS`
- `OWNER-BOUNDARY-BASIS`
- `PROCEDURE-EXECUTION-RESULT`
- `COHERENCE-RESULT`
- `INTEGRITY-RESULT`
- `NEGATIVE-RISK-RESULT`
- `DUPLICATION-CONFLICT-RESULT`
- `REMOVAL-FIRST-PATCH-DESIGN`
- `PATCH-WORTHINESS`
- `NEXT-OWNER-CANDIDATE`
- `OPEN-SURFACES`
- `DOWNSTREAM-VERIFICATION-NEED`

`PROCEDURE-EXECUTION-RESULT` records `skill-consumption-lens` results when skill consumption materially affects outcome, proof, acceptance, or procedure execution.
Use `UNVERIFIED` when the live owner surface, design intent, or evidence basis was not inspected.
Use absolute zero-risk language only when the frozen acceptance basis makes absolute closure truthful.
Otherwise use `no identified negative risk on inspected surfaces`.

## Reporting Surface
User-facing prose admission is owned by `.claude/reference/user-reporting-law.md`; consume it first, then consume triggered team-lead reporting references only after it admits the report.
`review_verification_packet` is current-turn internal evidence; persist to a retained carrier only on explicit user request, explicit calling-owner requirement, or named downstream owner/action that requires retained consumption.

## Review Workflow
Run the workflow in numeric order.
Each step records current evidence in `SEQUENCE-STATUS` before the next step opens.
The next step opens only when earlier step evidence is current for the same target, corpus, patch design, and diff.
When target, corpus, findings, patch design, or diff changes, return to the earliest changed step and rerun every downstream step.
Patch sequence handoff eligibility requires:
- Step 9 recorded completed integrity evidence before mutation readiness
- Step 14 returned a current internal `review_verification_packet`
Narrative claims of completed steps do not satisfy this gate.
Rerun from the earliest skipped step after a procedural failure.
If a mutation already exists before handoff eligibility, treat the current diff as the review target, route it through Steps 1-14, and execute only the corrected eligible patch path.

This skill has one workflow; every use follows this numeric order at the authorized claim scope.
Bounded named-lens consumption narrows target, corpus, required fields, and claim ceiling only; it does not skip Step 5 or create a separate procedure.

### 1. Relearn Doctrine And Owner Intent
Read the live top doctrine and affected owner surfaces before judgment.
Relearning means compliance refresh: identify the governing rules that control this review and obey them during every later step.
Reading doctrine without applying it to inspection, risk judgment, patch design, and reporting is non-compliance.
Reconstruct team philosophy, design intent, protected meaning, owner boundaries, positive execution paths, stop conditions, and acceptance surfaces.
Use live owner surfaces as evidence.
Treat memory, prior summaries, stale mirrors, and expected wording as baseline context only.

### 2. Freeze Exhaustive Review Contract
Name target, corpus boundary, exhaustiveness basis, evidence burden, user surface, output form, and parallel-fit basis.
The frozen corpus must include:
- every user-named target surface
- every material adjacent owner surface needed to judge design intent, owner boundary, coherence, integrity, negative risk, and patch-worthiness
- every producer and consumer owner surface for any field, route, state token, or skill rule being judged as missing, redundant, disconnected, or defective
- every triggered consuming surface needed to judge material skill availability, packetization, applied-rule mapping, and intended outcome effect
Governance defect review includes `.claude/reference/context-reduction-preservation-map.md` when trace basis exists there.
Governance removal review includes `.claude/reference/context-reduction-preservation-map.md` when trace basis exists there.
Preservation review includes `.claude/reference/context-reduction-preservation-map.md` when trace basis exists there.
If the corpus boundary is unknown, make bounded discovery the next action before judgment.
When independent surfaces are material, dispatch parallel shards if host-authorized team runtime is available.
Shard packets carry:
- `SEMANTIC-INTENT-BASIS`
- `TARGET-INTENT-BASIS`
- common finding basis for each defect, removal, or patch-worthiness claim

### 3. Inspect The Whole Target Surface
Inspect every frozen target surface and material adjacent owner surface.
Exhaustive review is satisfied by full inspected coverage of the frozen corpus or by an explicit user-narrowed scope.
Inventory proof establishes corpus coverage only.
Content inspection remains required for owner-relevant surfaces.
Separate primary owner surfaces from references, generated outputs, runtime state, non-authoritative evidence, and stale artifacts.

### 4. Synthesize Findings
Combine shard or local findings into one evidence map.
Start each candidate from pre-mutation removal judgment; discard non-defects, merge duplicates, downgrade weak labels, and preserve only when live evidence proves a retention exception.
Reviewer-lane governance labels are candidate evidence until the defect-promotion path verifies the common finding basis and protected-function preservation.
Promote shard labels only after verifying design-intent conflict, negative operating effect, correction owner, and protected-function preservation.
Classify findings from owner semantics and operating effect.
For matching-label or verdict-like observations, apply `.claude/skills/task-execution/references/completion-handoff.md` common finding basis before promotion.
Defect, removal, patch-worthiness, and correction-priority promotion use this defect-promotion path.
Classify a design tradeoff as a defect only when live evidence proves protected-function harm, correction ownership, and no stronger protected-function loss from the proposed correction.
Classify deletion, non-enforcement, hook silence, runtime omission, heavy gates, repeated wording, hook burden, line count, ceremony, matching labels, verdict-like words, and plausible misuse as evidence.
Repeated wording is not a defect until protected local-restatement need is disproven on every affected consuming surface.
Hook matcher burden requires a matched-tool side-effect map before defect classification.
Silent ledgers, planning markers, self-verification markers, lifecycle markers, and recovery markers are protected functions until proven non-material.
Classify explanatory defense as a defect when direct executable wording can carry the rule.
Classify compressed multi-rule wording as a defect when it hides trigger, owner, stop, evidence, or exception boundary.
Classify a skill-consumption defect only when live evidence shows a material skill method is required for the intended outcome and the consuming surface cannot find, load, apply, or record it at the required owner path.
Classify unnecessary skill loading as a defect when it adds burden without material outcome, proof, acceptance, or procedure benefit.
Promote evidence-only observations only when the common finding basis proves `confirmed-defect`.
Use `references/governance-review-gates.md` when analysis, artifact-change, synthesis, finding-promotion, or patch-worthiness detail is material.

### 5. Critical Review Gate
Run before any review-verification output, plan, synthesis, patch-worthiness, bestness, no-defect, no-regression, or completion judgment at the authorized claim scope; this is the same workflow gate for full and named-lens use.
Critical review posture starts at skill load and is recorded through this gate before any claim leaves `review-verification`.
First try to disprove the current defect label, patch direction, or preferred conclusion against live surfaces.
For governance patch placement, removal, retention, re-home, or append judgment, consumed owner-surface fit and producer-consumer owner path are always material defeaters.
Schema fit, taxonomy fit, or a convenient classification slot never satisfies consumed owner-surface fit.
Construct material defeater candidates from these lenses:
- owner-boundary conflict
- protected-function loss
- weaker procedure or execution force
- residual ambiguous wording or semantic collision
- missing, wrong-owner, unrecorded, or burden-only skill-consumption path
- untraced producer-consumer owner path for any field, route, state token, or skill-consumption claim
- runtime, tool-side-effect, filesystem-propagation, observation-race, transient-state, user-surface, or reuse path failure
- stronger narrower alternative such as no-patch, delete, trim, merge, re-home, replace, tighten, or hook-last
For each material defeater, record:
- evidence surface inspected
- confirmed, disproven, or open result
- correction owner and next action when confirmed or open
A bestness or no-defect claim is blocked while any material defeater is untested, confirmed, or open without owner deferral.
Patch-worthiness is blocked while consumed owner-surface fit or producer-consumer owner path remains untested.
A confirmed defeater returns to Step 6 patch design or Step 2 corpus widening before final judgment.
`NEGATIVE-RISK-RESULT` summarizes defeater outcomes.
`PATCH-WORTHINESS` explains why the selected patch is narrower and safer than material alternatives.

### 6. Design Removal-First Patch
Governance patch placement, generalization, and patch-ready record consume `.claude/reference/minimal-governance-change-law.md` `## Patch-Ready Gate`.
Apply that gate as the binding patch-selection standard; this step records gate results for review handoff.
Do not duplicate or override its owner-surface, removal-first, generalization, or symptom-only rules here.
Patch-Ready Gate consumption is current only when recorded after the current target, corpus, patch design, and diff are frozen.
Earlier-wave, prior-turn, summary, or memory-based Patch-Ready records do not satisfy this step.
After the finding is not a protected restatement, design tradeoff, or evidence-only observation, classify challenged text, section, or document as removal-default before mutation.
Retention is a pre-mutation exception and requires evidence that removal would lose protected function, owner boundary, recovery path, or execution force.
When retention-exception is proven, choose the narrowest preserving operation under the Patch-Ready Gate.
Split bundled governance sentences before patch design.
Use direct executable wording.
Replace ambiguous terms with explicit owner, trigger, action, stop, and evidence terms.
Delete explanatory defense when direct executable wording preserves the rule.
`REMOVAL-FIRST-PATCH-DESIGN` records the Patch-Ready Gate result:
- failing execution path
- consumed execution surface that carries the rule action
- destination owner for moved, re-homed, or pointer-only meaning
- adjacent surfaces after the edit: removed, citation-only, or protected local restatement
- the selected existing-text operation
- why rejected removals would lose protected function
- retention exception basis when challenged text, section, or document remains
A removal, trim, merge, re-home, replacement, or compression is patch-eligible only when it preserves or sharpens source meaning, positive execution path, owner boundary, trigger, stop, evidence, recovery path, rule recognition, clarity, and execution force.
A retention exception is patch-eligible only with protected-function loss evidence and rejected narrower-removal basis.
Compression that weakens procedure execution, compliance recognition, or required-rule clarity is invalid.

### 7. Pre-Patch Negative-Risk Gate
Against live governance documents, test the proposed patch for:
- meaning loss
- owner conflict
- weaker procedure
- weaker clarity
- weaker execution force
- weaker next-owner/action resolution
- broken references
- added burden
- weaker user-use readiness
- acceptance regression
Revise the patch design until all identified negative risks and Critical Review Gate defeaters are removed, disproven, or assigned as explicit blockers.
Unresolved negative risk routes the work to patch redesign, evidence gathering, or explicit `HOLD` before patch sequence handoff eligibility.
Report absolute risk-zero only when absolute closure is proven.
Otherwise report `no identified negative risk on inspected surfaces`.

### 8. Widen Coherence Radius
After the patch design survives the first risk gate, inspect the surrounding references, sibling skills, lane roles, phase gates, packet fields, and acceptance path that the patch can affect.
Update the patch design when wider coherence review finds drift, overlap, missing owner handoff, or newly stale meaning.

### 9. Integrity Gate Before Live Patch
Before live patch execution, verify the structural contract.
Verify fixed order.
Verify protected local restatement.
Verify source-to-destination meaning.
Verify the selected consumed execution surface is active on the failing execution path.
Verify each adjacent surface is removed, citation-only, or a protected local restatement after trim, re-home, or pointer replacement.
Verify positive execution path.
Verify existing function preservation.
Verify no-regression basis.
Do not re-test Step 7 axes here.
Any failed integrity item returns the work to patch design with the failed item named.

### 10. Patch Sequence Boundary
File mutation is owned by the named patch sequence or production owner, not by review-verification.
After Steps 1-9 record completed evidence, keep mutation blocked until Steps 12-14 classify findings, decide patch-worthiness, and resolve next owner/action.
Missing Step 1-9 evidence routes to the smallest incomplete review step before patch-worthiness or handoff.

### 11. Post-Patch Coherence Re-engagement
Before patch handoff, record only this re-engagement owner boundary.
Post-patch changed-result verification is owned by the executing patch sequence's Post-Verify `Skill(self-verification)` gate.
Re-engage `review-verification` only when Post-Verify exposes a new material coherence, governance-judgment, removal, or patch-worthiness question.
When re-engaged, re-read the changed live surfaces.
Re-read the resulting diff.
Re-read surrounding owner surfaces and affected references.
Fix newly found defects through the smallest correction path.

### 12. Classify Findings
Use the common finding-class taxonomy from `.claude/skills/task-execution/references/completion-handoff.md`.

### 13. Decide Patch Worthiness
Patch recommendations must state:
- protected function
- user-outcome impact
- regression risk
- smallest owner
- operation type
- tested basis for rejecting `protected-restatement`, `design-tradeoff`, and `non-issue`
Use the removal-first operation selected in Step 6, or return to patch design when the operation changes.
Use `references/governance-review-gates.md` for detailed patch-worthiness review when the recommendation depends on analysis, artifact-change, or synthesis judgment.

### 14. Next-Owner Routing
Return the internal `review_verification_packet` from Step 14 only after Steps 1-13 are current and next owner/action is resolved for the same target, corpus, patch design, and diff.
The packet carries classification from Step 12, patch-worthiness from Step 13, and next owner/action from Step 14.
Return the smallest truthful next owner/action.
Use `reviewer` for independent review.
Use `researcher` for missing evidence.
Use `developer` for bounded production.
Use `tester` for proof.
Use `validator` for final verdict.
Use `Skill(governance-change)` for ordinary governance asset update and confirmed recurrence-barrier hardening.
Use `Skill(self-verification)` before consequential reporting, completion claims, synthesis-triggered `Skill(governance-change)`, or synthesis-triggered redispatch.
Return to the triggering `Skill(self-verification)` or `Skill(governance-change)` owner when this packet answers that owner's bounded review question.

## Handoff Boundary
Hand off only when the receiver can identify inspected surfaces, open surfaces, design-intent basis, confirmed versus hypothetical findings, next owner/action, and closure evidence.

## Resolve Next Owner And Action
- Completed review packet opens the named downstream owner/action from Step 14.
- Missing corpus, design-intent, owner-boundary, or evidence basis keeps `review-verification` open.
- Unresolved negative risk opens patch redesign, evidence gathering, or `HOLD`.
- Governance asset update or confirmed recurrence-barrier hardening opens `Skill(governance-change)`.
- Consequential reporting opens `Skill(self-verification)`.
- Caller-requested review returns to that caller unless Step 14 proves a different next owner/action.

## Role-Scoped Structural Feedback
- Challenge desired-patch, rule-citation, risk-free, best, complete, or no-defect claims that lack live design intent, actual execution-path evidence, inspected-surface basis, or Step 5 defeater results.
- Challenge defect labels, additions, removals, or compression unless owner-correction path, protected-function preservation, intended quality, independence, safety, user-intent protection, and Step 6 patch eligibility are proven.

## Role-Scoped Governance-Change Loop
- Repeated misses in coherence, integrity, design-intent, procedure-adherence, execution-force, risk classification, or patch-worthiness trigger `Skill(governance-change)`.
- Harden the narrowest failed owner surface.
- Keep this skill scoped to review-sequence discipline while reviewer, validator, and `Skill(governance-change)` execution ownership remain on their owner surfaces.
