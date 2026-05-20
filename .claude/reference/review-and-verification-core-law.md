---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Review And Verification Philosophy"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-user-reporting-law.md
---
# 4. Review And Verification Core Law
## Reference Map
When this core law is consumed, use this file as the representative law and load separated references only when their triggers are active.
- `.claude/reference/design-delivery-evidence-acceptance-law.md`: load when decisive evidence surface, proof surface, verified claim, user-ready claim, or positive evidence wording is material.

## Review Gate Law
- `[REVIEW-FIRST]` `Skill(review-verification)` tool call must appear in the current turn before any `Edit`/`MultiEdit`/`Write`/`Bash` mutation on a `.claude/` governance asset by the calling owner.
- `Skill(review-verification)` consumption uses defeater-first posture per its `## Critical Review Gate` Step 5.
- Confirmation-only, convenience-aligned, or self-approval review-verification execution is invalid per the same gate.
- Review-verification gates consequential governance judgment before mutation.
- Review-verification does not own file mutation, final validation, or acceptance.

## Candidate Filtering And Promotion Law
- Candidate discovery maximizes recall for evidence collection.
- Candidate discovery does not establish defect truth, severity truth, priority truth, patch-worthiness, or patch readiness.
- Review-verification uses the finding-state ladder: `candidate-evidence`, `candidate-classified`, `confirmed-defect`, `patch-worthy`, `patch-ready`, or `rejected:<basis>`.
- `candidate-evidence` records an observed rule, wording, behavior, output, or runtime signal without defect authority.
- `candidate-classified` maps candidate evidence to a proposed defect class, severity, owner, and inspected source surface without defect authority.
- `confirmed-defect` requires live evidence of design-intent conflict, negative operating effect, causal path, correction owner, and no stronger protected-function loss from correction.
- `patch-worthy` requires a `confirmed-defect` plus protected-function preservation, user-outcome impact, regression-risk basis, smallest owner, selected operation type, and rejection of `protected-restatement`, `design-tradeoff`, and `non-issue`.
- `patch-ready` requires `patch-worthy` plus current patch-owner surface, edit operation, source meaning, destination owner when moved, direct-consumption relevance, and verification basis.
- `rejected:<basis>` covers `protected-restatement`, `design-tradeoff`, `non-issue`, `risk-hypothesis`, `unverified`, and `not-material:<basis>`.
- A reportable governance issue is a filtered result whose state is `confirmed-defect`, `patch-worthy`, or `patch-ready`, or an open candidate explicitly labelled with its unclosed state and next owner.
- Raw candidate counts, repeated labels, similar wording, multi-lane convergence, and researcher outputs remain inventory evidence unless this ladder promotes them.
- Bare `CONFIRMED` is not a finding state; records use the exact ladder state that matches the evidence.

## Governance Coherence Gap Law
- Review-verification tests upper-to-core and core-to-trigger-bound continuity for governance claims that add, change, remove, or judge execution meaning.
- An upper-to-core gap exists when top doctrine changes execution without matching mapped core-law executable detail or recorded existing-detail coverage.
- A core-to-trigger-bound gap exists when core-law executable detail needs situation-specific consuming-owner guidance and no triggered owner reference carries it.
- A confirmed upper-to-core gap or core-to-trigger-bound gap is a coherence defect.
- A confirmed upper-to-core gap or core-to-trigger-bound gap is an execution-force defect.
- Positive governance integrity, patch-worthiness, no-defect, and completion claims stop while an upper-to-core gap lacks mapped core-law executable detail or recorded existing-detail coverage.
- Positive governance integrity, patch-worthiness, no-defect, and completion claims stop while a core-to-trigger-bound gap lacks required triggered owner-reference guidance or valid `not-material:<basis>`.
- `not-material:<basis>` for core-to-trigger-bound guidance is valid only when inspected consuming surfaces prove no active owner path needs situation-specific guidance or the mapped core law already carries complete executable detail.
- `not-material:<basis>` is invalid when based on convenience, broad traceability, expected future reuse, or uninspected consuming surfaces.

## Minimum Executable Information Law
- Review-verification tests governance proposals, plans, patches, and existing rules for minimum executable information.
- Minimum executable information is the smallest complete rule content needed to change or confirm owner action, trigger, stop, evidence, verification, acceptance truth, routing, or patch-readiness.
- Under-specified governance omits material executable information and leaves the active owner unable to act, stop, verify, route, or claim completion truthfully.
- Over-specified governance adds non-executed procedure, example, condition, explanation, or context that increases consumption burden without changing execution.
- Lower-surface repetition that masks weak top/core consumption is over-specified until review proves protected restatement, direct-consumption relevance, or isolation-safety need.
- Confirmed under-specified governance or over-specified governance is an execution-force defect.
- Positive no-defect claims stop until under-specified or over-specified governance is corrected.
- Positive governance integrity, patch-worthiness, and completion claims carry explicit precise-owner assignment for any out-of-scope under-specified or over-specified defect.
- Review-verification tests proposed or existing governance for evasion-enabling, ambiguous, conflicting, or bottleneck-forming wording when the wording controls owner action or procedure execution.
- Evasion-enabling governance lets an owner avoid a required action, evidence step, verification step, route, blocker, or completion truth.
- Ambiguous or conflicting governance leaves multiple plausible next actions or incompatible owner duties on the same active path.
- Bottleneck-forming governance serializes independent work, blocks reversible action, or adds non-required approval, evidence, or routing burden without a governing risk basis.
- Confirmed evasion-enabling, ambiguous, conflicting, or bottleneck-forming governance is an execution-force defect.
- Positive governance integrity, patch-worthiness, no-defect, and completion claims stop until behavior-weakening governance is corrected or assigned to the precise owner.

## Evidence Law
- `[EVI-ASSUM]` Evidence outranks assumption.
- `[USER-SURFACE]` Verification stays on the user's decisive surface.
- Completion requires verified result.
- User-facing brevity limits emitted content only.
- Internal evidence gathering and verification stay at deliverable-required quality.
Detailed decisive evidence and proof-surface rules live in `.claude/reference/design-delivery-evidence-acceptance-law.md`.
