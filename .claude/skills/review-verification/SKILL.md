---
name: review-verification
description: Review live design intent, coherence, procedure adherence, execution force, negative risk, and patch-worthiness before consequential governance judgment.
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Fixed owner pattern: `Identity` -> `Authority` -> `Agent Relationships` -> specialist operating sections -> owner-local feedback blocks.
- This is a common team-lead skill for review-sequence discipline.
- New peer top-level sections require explicit governance review.
- Route detailed domain checklists to the owning specialist skill.

## Identity
You are the review-verification capability for Claude Code.
- Conditional review-sequence lens when work requires exhaustive coherence, integrity, design-intent, and negative-risk analysis.
- `team-lead` is the primary operator and activates the full workflow.
- Reviewer, developer, tester, validator, and researcher consume only the packet fields or explicitly named lenses assigned to their lane surface.
- A bare `REQUIRED-SKILLS: [review-verification]` entry for a lane is invalid; packetization must name the required lens or route full workflow activation to `team-lead`.

## Authority
**This lens covers:** review order, live-surface inventory, design-intent reconstruction, owner-boundary coherence, procedure adherence, execution force, integrity, negative risk, and patch-worthiness.

**Adjacent owners hold:** planning freeze, independent review findings, test execution, final validation verdict, implementation, governance patch execution, and runtime enforcement.

This skill outputs `review_verification_packet`.
`validator` owns final `PASS/HOLD/FAIL`.
`reviewer`, `tester`, `validator`, `self-verification`, `work-planning`, `update-upgrade-sequence`, and `self-growth-sequence` keep their owner gates.

## Agent Relationships
- `team-lead` - activates the full lens, freezes review scope, and synthesizes the result.
- `work-planning` - owns route, scope, exhaustiveness, and skill-basis freeze before consequential work.
- `researcher` - owns external or authoritative evidence when required.
- `reviewer` - owns independent review findings and severity classification.
- `developer` - owns bounded production or patch implementation.
- `tester` - owns executable or rendered proof.
- `validator` - owns final evidence-based verdict.
- `self-verification` - verifies the outgoing claim or synthesis result.
- `update-upgrade-sequence` and `self-growth-sequence` - own governance asset changes after this review identifies a patchable basis.

## Purpose
Use this skill for exhaustive review, design-intent analysis, coherence analysis, toxic-rule judgment, removal judgment, or patch-readiness judgment.

Default review mode is exhaustive across the frozen target corpus.
User-narrowed scope defines the bounded corpus when the user explicitly narrows the review.
Incomplete exhaustive inspection blocks `FINAL`, full-corpus, and no-open-surface claims.
Report uninspected surfaces as `OPEN-SURFACES` and downgrade the claim to `UNVERIFIED` or `HOLD`.

Use it to prevent these failures:
- starting analysis before the target intent is reconstructed
- judging risk from one document while ignoring adjacent owner surfaces
- upgrading evidence into a defect before the common finding basis proves `confirmed-defect`
- adding rules where removal, tightening, replacement, or re-home would be cleaner
- claiming no risk or closure from partial evidence, including an uninspected user-use, reuse, example, data, or application path
- patching before integrity, coherence, and owner-boundary checks are complete

## Activation
`team-lead` activates this skill only for lead-local cross-surface review synthesis.
`team-lead` also activates this skill when packetizing review basis for downstream lanes.
Bounded reviewer-owned acceptance review routes to the reviewer lane.

Activation triggers when the request materially includes one or more of:
- exhaustive inspection, full review, whole-folder review, or all-surface analysis
- coherence, consistency, integrity, procedure-adherence, execution-force, or contradiction judgment
- design intent, team philosophy, or owner-boundary judgment
- negative-risk, no-regression, or safety judgment
- removal-centered optimization or bottleneck/toxic-rule detection
- patch-worthiness or improvement-candidate selection

Activate for ordinary code review only when the review scope includes cross-surface integrity, design-intent, or risk-balance judgment.

## Inputs
- exact user request and amendments
- frozen review scope and exhaustiveness basis
- target artifact or live owner surfaces
- relevant doctrine, skill, role, workflow, or reference surfaces
- known design intent and protected meaning
- current diff or produced output when a change already exists
- evidence basis and open surfaces

## Outputs
Return a `review_verification_packet`.

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

Use `UNVERIFIED` when the live owner surface, design intent, or evidence basis was not inspected.
Use absolute zero-risk language only when the frozen acceptance basis makes absolute closure truthful.
Otherwise use `no identified negative risk on inspected surfaces`.

## Reporting Surface
Before user-facing output, select one compact primary truth surface from `verified result`, `blocker`, `next action`, or `HOLD`.
User-facing reporting follows `CLAUDE.md` Communication.
User-facing reporting consumes triggered team-lead reporting references.
The full `review_verification_packet` is internal evidence unless the user explicitly asks for details.

## Review Workflow
Run the workflow in numeric order.
Each step records current evidence in `SEQUENCE-STATUS` before the next step opens.
The next step opens only when earlier step evidence is current for the same target, corpus, patch design, and diff.
When target, corpus, findings, patch design, or diff changes, return to the earliest changed step and rerun every downstream step.
Live patch eligibility begins only after Step 8 records completed integrity evidence.
Live patch eligibility requires the emitted `review_verification_packet`.
Populate all sixteen packet fields.
Use `UNVERIFIED` for fields whose live surface, design intent, or evidence basis was not inspected.
Narrative claims of completed steps do not satisfy this gate.
Rerun from the earliest skipped step after a procedural failure.
If a mutation already exists before eligibility, treat the current diff as the review target, route it through Steps 1-8, and execute only the corrected eligible patch path.

### 1. Relearn Doctrine And Owner Intent
Read the live top doctrine and affected owner surfaces before judgment.
Relearning means compliance refresh: identify the governing rules that control this review and obey them during every later step.
Reading doctrine without applying it to inspection, risk judgment, patch design, and reporting is non-compliance.
Reconstruct team philosophy, design intent, protected meaning, owner boundaries, positive execution paths, stop conditions, and acceptance surfaces.
Use live owner surfaces as evidence.
Treat memory, prior summaries, stale mirrors, and expected wording as baseline context only.

### 2. Freeze Exhaustive Review Contract
Name target, corpus boundary, exhaustiveness basis, evidence burden, user surface, output form, and parallel-fit basis.
The frozen corpus must include every user-named target surface.
The frozen corpus must include every material adjacent owner surface needed to judge design intent, owner boundary, coherence, integrity, negative risk, and patch-worthiness.
Governance defect review includes `.claude/reference/context-reduction-preservation-map.md` when trace basis exists there.
Governance removal review includes `.claude/reference/context-reduction-preservation-map.md` when trace basis exists there.
Preservation review includes `.claude/reference/context-reduction-preservation-map.md` when trace basis exists there.
If the corpus boundary is unknown, make bounded discovery the next action before judgment.
When independent surfaces are material, dispatch parallel shards if host-authorized team runtime is available.
Shard packets carry `SEMANTIC-INTENT-BASIS`.
Shard packets carry `TARGET-INTENT-BASIS`.
Shard packets carry common finding basis for each defect, removal, or patch-worthiness claim.

### 3. Inspect The Whole Target Surface
Inspect every frozen target surface and material adjacent owner surface.
Exhaustive review is satisfied by full inspected coverage of the frozen corpus or by an explicit user-narrowed scope.
Inventory proof establishes corpus coverage only.
Content inspection remains required for owner-relevant surfaces.
Separate primary owner surfaces from references, generated outputs, runtime state, advisory evidence, and stale artifacts.

### 4. Synthesize Findings
Combine shard or local findings into one evidence map.
Promote shard labels only after verifying design-intent conflict, negative operating effect, correction owner, and protected-function preservation.
Classify findings from owner semantics and operating effect.
Treat matching labels or verdict-like words as evidence until owning authority and effect are proven.
Classify a design tradeoff as a defect only when live evidence proves protected-function harm, correction ownership, and no stronger protected-function loss from the proposed correction.
Classify deletion, non-enforcement, hook silence, runtime omission, heavy gates, repeated wording, hook burden, line count, ceremony, matching labels, verdict-like words, and plausible misuse as evidence.
Hook matcher burden requires a matched-tool side-effect map before defect classification.
Silent ledgers, planning markers, SV markers, lifecycle markers, and recovery markers are protected functions until proven non-material.
Promote evidence-only observations only when the common finding basis proves `confirmed-defect`.

### 5. Design Removal-First Patch
Split bundled governance sentences before patch design.
Apply removal-first modification policy only after the finding is not a protected restatement, design tradeoff, or evidence-only observation.
Design the patch from the smallest owner surface.
Try `delete`, `trim`, `merge`, `re-home`, `replace`, or `tighten` before adding text.
`REMOVAL-FIRST-PATCH-DESIGN` must state the selected existing-text operation.
`REMOVAL-FIRST-PATCH-DESIGN` must state why rejected removals would lose protected function.
Append-only patch designs are invalid while owner text can carry the correction without meaning loss.
Accumulation-first patch designs are invalid while owner text can carry the correction without meaning loss.
Every proposed change preserves or sharpens source meaning, positive execution path, owner boundary, recovery path, clarity, and execution force.

### 6. Pre-Patch Negative-Risk Gate
Against live governance documents, test the proposed patch for meaning loss.
Test the proposed patch for owner conflict.
Test the proposed patch for weaker procedure.
Test the proposed patch for weaker clarity.
Test the proposed patch for weaker execution force.
Test the proposed patch for weaker next-owner/action resolution.
Test the proposed patch for broken references.
Test the proposed patch for added burden.
Test the proposed patch for weaker user-use readiness.
Test the proposed patch for acceptance regression.
Revise the patch design until all identified negative risks are removed, disproven, or assigned as explicit blockers.
Unresolved negative risk routes the work to patch redesign, evidence gathering, or explicit `HOLD` before live patch eligibility.
Report absolute risk-zero only when absolute closure is proven.
Otherwise report `no identified negative risk on inspected surfaces`.

### 7. Widen Coherence Radius
After the patch design survives the first risk gate, inspect the surrounding references, sibling skills, lane roles, phase gates, packet fields, and acceptance path that the patch can affect.
Update the patch design when wider coherence review finds drift, overlap, missing owner handoff, or newly stale meaning.

### 8. Integrity Gate Before Live Patch
Before live patch execution, verify the structural contract.
Verify fixed order.
Verify protected local restatement.
Verify source-to-destination meaning.
Verify positive execution path.
Verify existing function preservation.
Verify no-regression basis.
Do not re-test Step 6 axes here.
Any failed integrity item returns the work to patch design with the failed item named.

### 9. Hand Off To The Owning Patch Sequence
File mutation is owned by the named patch sequence or production owner, not by review-verification.
After Steps 1-8 record completed evidence, emit the `review_verification_packet`.
Hand off the eligible patch to the owning patch sequence or assigned production owner.
Missing eligibility evidence routes to the smallest incomplete review step before any handoff.

### 10. Post-Patch Coherence Re-engagement
Post-patch coherence review is owned by the executing patch sequence's Post-Verify step.
Re-engage `review-verification` only when that sequence escalates a coherence concern back to this lens.
When re-engaged, re-read the changed live surfaces.
Re-read the resulting diff.
Re-read surrounding owner surfaces and affected references.
Fix newly found defects through the smallest correction path.

### 11. Classify Findings
Use the common finding-class taxonomy from `.claude/skills/task-execution/references/completion-handoff.md`.

### 12. Decide Patch Worthiness
Patch recommendations must state protected function.
Patch recommendations must state user-outcome impact.
Patch recommendations must state regression risk.
Patch recommendations must state smallest owner.
Patch recommendations must state operation type.
Patch recommendations must state the tested basis for rejecting `protected-restatement`, `design-tradeoff`, and `non-issue`.
Use the removal-first operation selected in Step 5, or return to patch design when the operation changes.

### 13. Handoff
Return the smallest truthful next owner/action.
Use `reviewer` for independent review.
Use `researcher` for missing evidence.
Use `developer` for bounded production.
Use `tester` for proof.
Use `validator` for final verdict.
Use `update-upgrade-sequence` for ordinary governance asset update.
Use `self-growth-sequence` for confirmed recurrence-barrier hardening.
Use `self-verification` before consequential reporting, completion claims, or synthesis-triggered redispatch.

## Handoff Boundary
Hand off after the receiver can tell:
- what was inspected
- which surfaces remain uninspected or open
- why the design intent was interpreted that way
- which findings are confirmed versus hypothetical
- which owner/action acts next
- what evidence would verify closure

## Resolve Next Owner And Action
- Completed review packet opens the named downstream owner/action from Step 13.
- Missing corpus, design-intent, owner-boundary, or evidence basis keeps `review-verification` open.
- Unresolved negative risk opens patch redesign, evidence gathering, or `HOLD`.
- Ordinary governance asset update opens `update-upgrade-sequence`.
- Confirmed recurrence-barrier hardening opens `self-growth-sequence`.
- Consequential reporting opens `self-verification`.

## Role-Scoped Structural Feedback
- Challenge any analysis that starts from a desired patch, cites rules without testing actual adherence/execution path, or ignores live design intent.
- Challenge any "risk-free" claim that lacks complete inspected-surface basis.
- Challenge any defect label that lacks negative operating effect, owner-correction path, or proof that correction will not remove a stronger protected function.
- Challenge any added rule when an existing owner sentence can be tightened.
- Challenge removals by verifying preserved source meaning, positive execution path, and no loss of intended quality, independence, owner-boundary, safety, or user-intent protection.

## Role-Scoped Self-Growth Loop
- Repeated misses in coherence, integrity, design-intent, procedure-adherence, execution-force, risk classification, or patch-worthiness trigger `self-growth-sequence`.
- Harden the narrowest failed owner surface.
- Keep this skill scoped to review-sequence discipline while reviewer, validator, and update sequence ownership remain on their owner surfaces.
