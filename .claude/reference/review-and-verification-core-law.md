---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Review And Verification Philosophy"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# 4. Review And Verification Core Law
## Reference Map
- `.claude/reference/design-definition-core-law.md`: load when frozen request, deliverable, scope, user burden, completion shape, user-surface closure, `REQUEST-FIT-BASIS`, `SEMANTIC-INTENT-BASIS`, `COMPLETION-STOP-CONDITION`, or `SCOPE-BASELINE` controls the review claim.
- `.claude/reference/detailed-design-core-law.md`: load when design intent, `TARGET-INTENT-BASIS`, solution structure, scope boundary, proof path, acceptance path, or design drift controls the review claim.
- `.claude/reference/work-execution-core-law.md`: load when owner boundary, next-owner/action, routing, procedure execution, or over-broad blocking is material.
- `.claude/reference/work-skill-reference-binding-law.md`: load when required-skill activation, skill-consumption fit, applied-rule mapping, or skill-consuming owner path is material.
- `.claude/reference/design-delivery-evidence-acceptance-law.md`: load when decisive evidence surface, proof surface, verified claim, user-ready claim, or positive evidence wording is material.

## Upstream Basis Review Law
- Before positive review, verification, defect, patch-worthiness, validation-readiness, completion, no-defect, or no-open-surface claims, the review owner consumes the current 1-3 basis that controls the claim.
- Design Definition supplies frozen request, deliverable, scope, user burden, completion shape, `REQUEST-FIT-BASIS`, `SEMANTIC-INTENT-BASIS`, `COMPLETION-STOP-CONDITION`, and `SCOPE-BASELINE` when material.
- Detailed Design supplies current design intent, `TARGET-INTENT-BASIS`, solution-structure basis, scope boundary, proof path, acceptance path, and drift stop when material.
- Work Execution supplies current owner/action, procedure path, route, skill/reference consumption, evidence, transport, open surfaces, blocker, and closure basis when material.
- Missing, stale, contradicted, or unconsumed 1-3 basis blocks the positive claim and opens the smallest correction owner: `work-planning` for frozen-boundary drift, design owner for target-intent drift, active execution owner for procedure or transport gap, proof or validation owner for evidence gap, or blocker-routing after internal correction routes are exhausted.

## Review Gate Law
- `[REVIEW-FIRST]` `Skill(review-verification)` tool call must appear in the current turn before any `Edit`/`MultiEdit`/`Write`/`Bash` mutation on a `.claude/` governance asset by the calling owner.
- `Skill(review-verification)` consumption uses defeater-first posture per its `### 5. Critical Review Gate`.
- Confirmation-only, convenience-aligned, or self-approval review-verification execution is invalid per the same gate.
- Review-verification gates consequential governance judgment before mutation.
- File mutation, final validation, and acceptance remain with their owning adjacent owners.

## Judgment Reliability Law
- `JUDGMENT-RELIABILITY` applies before a high-risk judgment is used as a decisive basis for downstream action, claim-strength upgrade, route selection, correction, mutation, verification, PASS-2, validation, acceptance, reporting, or closure.
- A high-risk judgment is not defined by task type, defect label, domain name, or listed example.
- A high-risk judgment is any non-observational or inference-dependent claim whose wrong acceptance can materially change owner action, scope, artifact state, proof burden, validation truth, acceptance truth, user burden, or deliverable closure.
- Direct observations, raw test results, inventory rows, and non-decisive evidence records are not high-risk judgments until an owner uses them as a decisive basis.
- The review owner records `JUDGMENT-RELIABILITY` for each material high-risk judgment: exact claim, current evidence surface, governing expectation basis, causal or fit path, strongest contrary hypothesis or classification tested, observable defeat condition, direct inspection result, downstream owner/action, and protected outcome/function or regression risk when correction or closure is proposed.
- Self-ratification risk exists when the same producer, same carrier chain, prior PASS label, prior verdict, or preferred conclusion raises claim strength without fresh `JUDGMENT-RELIABILITY` on the current decisive basis.
- Missing, stale, contradicted, or open `JUDGMENT-RELIABILITY` keeps the judgment at candidate, open, partial, or `HOLD` strength; it does not support promotion, closure, PASS-2, mutation-readiness, validation support, or verified-result reporting.
- Existing `PASS-1`, `PASS-2`, validator `PASS`, checklist, carrier, upstream acceptance label, or prior packet is evidence only inside its cited covered surface; it does not widen `JUDGMENT-RELIABILITY`, replace current live evidence, or create mutation, verification, or acceptance authority beyond that cited surface.

## Candidate Filtering And Promotion Law
- Candidate discovery maximizes recall for evidence collection.
- Candidate discovery records recall-only evidence; defect truth, patch-worthiness, and patch readiness require promotion filtering.
- Repair order and execution order are downstream scheduling metadata only; they are not defect-truth inputs and cannot promote a candidate.
- Governance audit binding filtering, final rejection, cross-surface rejection, removal judgment, patch-readiness judgment, and patch/no-patch selection are promotion-filtering work, not candidate discovery.
- Lane-local first-pass classification or `rejected:<basis>` inside the assigned surface remains candidate evidence until current `Skill(review-verification)` defect-promotion basis consumes it or team-lead synthesis consumes that current basis.
- Team-lead synthesis lawfully promotes only from current `Skill(review-verification)` defect-promotion basis for the same corpus; otherwise it preserves candidate state.
- Lawful team-lead synthesis for final rejection, cross-surface rejection, promotion, patch-readiness, or patch/no-patch selection means team-lead consumes a current `Skill(review-verification)` defect-promotion basis; team-lead synthesis does not create an independent promotion path.
- Promoted, rejected, open-candidate, patch-worthy, patch-ready, and no-patch bases remain upstream decision bases for downstream correction, mutation, validation, and reporting until a current `Skill(review-verification)` basis or lawful team-lead synthesis of that basis supersedes them.
- For exhaustive, full-corpus, whole-folder, or governance-audit scope, promotion, rejection, patch/no-patch, and count claims use the opened closure unit from the frozen basis.
- When the frozen claim or deliverable opens promotion filtering, each opened candidate remains open until it is promoted, rejected by current `Skill(review-verification)` basis, covered by cited lawful owner-deferral authority, excluded by explicit user-narrowed out-of-scope basis, or blocker-routed after internal correction routes are exhausted.
- Open-candidate reporting remains valid only as open-surface reporting with state, evidence basis, and next owner/action; category/theme convergence or an open-unpromoted label is not closure.
- Corpus inspection coverage records inspection-stage evidence only; defect-identification, defect-promotion, patch-worthiness, patch-readiness, mutation, and post-verify each require their own current closure basis when the frozen request includes them.
- A governance audit deliverable whose frozen scope includes defect promotion stays open while any opened candidate lacks promotion, current-review rejection, cited lawful owner-deferral authority, explicit user-narrowed out-of-scope basis, or blocker-routing after internal correction routes are exhausted.
- A governance audit-plus-patch deliverable also stays open while any confirmed defect lacks patch-worthiness judgment, any patch-worthy defect lacks patch-ready basis, or any patch-ready row remains unapplied, unverified, deferred by cited lawful owner-deferral authority, rejected by current review basis, or blocker-routing after internal correction routes are exhausted.
- Each open governance-audit or audit-plus-patch stage opens the next filtering, judgment, mutation, verification, or correction owner in the same request chain.
- Sample-only, tier-only, or wave-only filtering supports the inspected narrowed claim only; full-corpus completion, no-open-surface, final patch inventory, and validator-ready claims require frozen-corpus coverage.
- Review-verification uses the finding-state ladder: `candidate-evidence`, `candidate-classified`, `open-candidate`, `confirmed-defect`, `patch-worthy`, `patch-ready`, or `rejected:<basis>`.
- `candidate-evidence` records an observed rule, wording, behavior, output, or runtime signal without defect authority.
- `candidate-classified` maps candidate evidence to a proposed defect class, owner, and inspected source surface without defect authority.
- `open-candidate` records an inspected candidate whose defect judgment still lacks one or more required `confirmed-defect` elements or whose rejection basis is not yet proven.
- `confirmed-defect` requires all item-level elements: expected behavior from the governing design or owner basis, observed deviation from that expectation, causal link from the candidate source to the deviation, correction-restores-behavior basis, correction owner, and no stronger protected-function loss from correction.
- Missing any `confirmed-defect` element keeps the item at `candidate-evidence`, `candidate-classified`, `open-candidate`, or `rejected:<basis>`; reviewer agreement, repeated wording, label similarity, plausible future risk, explanation fluency, ordering pressure, or repair-order need cannot substitute for any element.
- `patch-worthy` requires a `confirmed-defect` plus protected-function preservation, user-outcome impact, regression-risk basis, smallest owner, selected operation type, and rejection of `protected-restatement`, `design-tradeoff`, and `non-issue`.
- `patch-ready` requires `patch-worthy` plus current patch-owner surface, edit operation, source meaning, destination owner when moved, direct-consumption relevance, and verification basis.
- `rejected:<basis>` covers `protected-restatement`, `design-tradeoff`, `non-issue`, `non-executable-difference`, `wrong-cause`, `promoter-error`, `risk-hypothesis`, `unverified`, and `not-material:<basis>`.
- Finding-state promotion, final rejection, patch/no-patch selection, patch-worthiness, and patch-readiness are high-risk judgments when they affect downstream correction, mutation, validation, reporting, or closure; those judgments require current `JUDGMENT-RELIABILITY`.
- A reportable governance issue is a filtered result whose state is `confirmed-defect`, `patch-worthy`, or `patch-ready`, or an open candidate explicitly labelled with its unclosed state and next owner.
- Raw candidate counts, repeated labels, similar wording, multi-lane convergence, and researcher outputs remain inventory evidence unless this ladder promotes them.
- Bare `CONFIRMED` is not a finding state; records use the exact ladder state that matches the evidence.
- Any review packet, lane carrier, synthesis, or user-facing defect report that carries candidates, findings, defects, removal, patch-worthiness, patch-readiness, rejection, no-patch, or finding counts records the exact per-item ladder state and keeps raw candidate, candidate-classified, confirmed-defect, patch-worthy, patch-ready, rejected, no-patch, and open-candidate counts separate when counts are material.
- `CLAIM-CEILING` limits finding-state, verdict, or claim-strength authority.
- `CLAIM-CEILING` does not reduce evidence inspection, source-truth verification, basis-fit verification, or material-defeater testing required for the outgoing claim.

## Cause And Remedy Classification Law
- Review-verification records `CAUSE-REMEDY-CLASSIFICATION` before defect promotion, final rejection, patch-worthiness, patch-readiness, patch/no-patch selection, or no-defect judgment when the claim can affect owner action, procedure, reporting, transport defect/remedy, runtime/tool behavior, hook/settings behavior, or governance mutation.
- Ordinary governed `dispatch-ack` and `subjob-done` emission, receipt, state transition, and retained-carrier handoff are protocol promises, not cause/remedy cases; classify only a defect, malformed transport, no-patch, hook/runtime/schema, or reporting-remedy judgment about those signals.
- `CAUSE-REMEDY-CLASSIFICATION` contains these exact fields: `observed-symptom`, `failure-source`, `negative-effect`, `remedy-owner`, `remedy-class`, `hook-eligibility`, `stronger-narrower-alternative`, and `counterexample-oracle`.
- Each entry is scoped to one candidate, finding, rejection, no-patch basis, patch-worthiness basis, patch-ready basis, remedy-owner route, or behavior-affecting claim; category-level or theme-level classification does not satisfy item-level classification.
- `failure-source` is exactly one of: `governance-rule-defect`, `tool-schema-failure`, `reserved-runtime-danger`, `screen-pollution`, `procedure-bottleneck`, `evidence-gap`, `non-issue`, or `mixed:<split-required>`.
- `remedy-class` is exactly one of: `governance-rule-correction`, `owner-procedure-correction`, `reporting-transport-correction`, `tool-schema-correction`, `hook-settings-guard`, `evidence-proof-correction`, `no-patch`, or `blocker-routing`.
- `hook-eligibility` is exactly `eligible:<tool-schema-failure|reserved-runtime-danger>:<evidence>` or `not-eligible:<basis>`.
- A mixed failure source must split into independently judged entries before promotion, rejection, patch-worthiness, patch-readiness, or no-patch selection.
- `tool-schema-failure` requires live tool behavior or official schema evidence showing the tool rejects the exact invocation shape.
- `reserved-runtime-danger` requires destructive, security-critical, session-stability-breaking, protected-filesystem-bypass, or other runtime-boundary law named hard-deny basis.
- `screen-pollution`, reporting-law violation, communication-plane malformed display, procedure bottleneck, governance wording defect, or evidence gap is not hook-eligible on that basis alone.
- Hook eligibility is valid only when the failure source is `reserved-runtime-danger` or proven `tool-schema-failure`, the proposed guard blocks only the rejected or reserved-danger shape, and the stronger narrower alternative test fails.
- The stronger narrower alternative field names the tested narrower remedy, the evidence that would make it sufficient, and the observed result; `untested`, broad preference, or convenience-only rejection is invalid.
- Counterexample oracle records `allowed-behavior`, `disallowed-behavior`, and `expected-remedy-result`; for `no-patch`, it records the protected baseline behavior and the rejected intervention.
- Missing, stale, unsplit, invalid-enum, theme-level-only, contradicted, or open `CAUSE-REMEDY-CLASSIFICATION` blocks positive no-defect, confirmed-defect, patch-worthiness, patch-readiness, final rejection, no-patch, and mutation-readiness claims.

## Owner Boundary And Skill Consumption Law
- Review-verification tests owner-boundary and skill-consumption fit when a claim, packet, patch, route, verdict input, or completion depends on who owns the action or which skill/reference must shape the result.
- Owner-boundary conflict exists when a finding, packet, patch, route, verdict input, or completion moves work across owner, lane, workflow, proof, validation, reporting, runtime, or mutation boundaries without current owner authority.
- Skill-consumption defect exists when a material required skill/reference is missing, wrong-owner, unrecorded, narrated without applied effect, or added only as burden without shaping the intended outcome.
- Confirmed owner-boundary conflict or skill-consumption defect is a procedure-adherence defect and an execution-force defect.
- Positive no-defect, governance integrity, patch-worthiness, validation-readiness, and completion claims require material owner-boundary and skill-consumption items to be recorded as `applied`, `not-material:<basis>`, or `blocked:<basis>` on the consumed owner path.

## Governance Coherence Gap Law
- Review-verification tests upper-to-core and core-to-trigger-bound continuity for governance claims that add, change, remove, or judge execution meaning.
- Governance-continuity review applies `.claude/reference/work-execution-core-law.md` governance hierarchy order; lower-layer conclusions before that basis are procedure-adherence defects.
- An upper-to-core gap exists when top doctrine changes execution without matching mapped core-law executable detail or recorded existing-detail coverage.
- A core-to-trigger-bound gap exists when core-law executable detail needs situation-specific consuming-owner guidance and no triggered owner reference carries it.
- A confirmed upper-to-core gap or core-to-trigger-bound gap is a coherence defect.
- A confirmed upper-to-core gap or core-to-trigger-bound gap is an execution-force defect.
- Positive governance integrity, patch-worthiness, no-defect, and completion claims require mapped core-law executable detail or recorded existing-detail coverage for every upper-to-core gap.
- Positive governance integrity, patch-worthiness, no-defect, and completion claims require triggered owner-reference guidance or valid `not-material:<basis>` for every core-to-trigger-bound gap.
- `not-material:<basis>` for core-to-trigger-bound guidance is valid only when inspected consuming surfaces prove no active owner path needs situation-specific guidance or the mapped core law already carries complete executable detail.
- `not-material:<basis>` is invalid when based on convenience, broad traceability, expected future reuse, or uninspected consuming surfaces.

## Minimum Executable Information Law
- Review-verification tests governance proposals, plans, patches, and existing rules for minimum executable information.
- Minimum executable information is the smallest complete rule content needed to change or confirm owner action, trigger, stop, evidence, verification, acceptance truth, routing, or patch-readiness.
- Under-specified governance omits material executable information and leaves the active owner unable to act, stop, verify, route, or claim completion truthfully.
- Over-specified governance adds non-executed procedure, example, condition, explanation, or context that increases consumption burden without changing execution.
- Lower-surface repetition that masks weak top/core consumption is over-specified until review proves protected restatement, direct-consumption relevance, or isolation-safety need.
- Confirmed under-specified governance or over-specified governance is an execution-force defect.
- Positive no-defect claims require correction of under-specified or over-specified governance.
- Positive governance integrity, patch-worthiness, and completion claims carry explicit precise-owner assignment for any out-of-scope under-specified or over-specified defect.
- Review-verification tests proposed or existing governance for evasion-enabling, ambiguous, conflicting, bottleneck-forming, or over-broad-blocking wording when the wording controls owner action or procedure execution.
- Evasion-enabling governance lets an owner avoid a required action, evidence step, verification step, route, blocker, or completion truth.
- Ambiguous or conflicting governance leaves multiple plausible next actions or incompatible owner duties on the same active path.
- Bottleneck-forming governance applies the top-doctrine `bottleneck defect` definition to governance wording that controls owner action or procedure execution when that definition's delay pattern appears without one of that definition's named benefits.
- Over-broad-blocking governance blocks, stalls, or downgrades a valid owner action, continuation, dispatch, verification, mutation, report exception, or completion path beyond the evidence, safety, verification, acceptance-truth, or required-procedure-force need.
- Confirmed evasion-enabling, ambiguous, conflicting, bottleneck-forming, or over-broad-blocking governance is an execution-force defect.
- Positive governance integrity, patch-worthiness, no-defect, and completion claims require behavior-weakening governance to be corrected or assigned to the precise owner.
- Recurring qualifier definitions live in `.claude/reference/work-execution-core-law.md` `## Qualifier Selection Law`.
- Subjective-judgment qualifiers in governance text (`proven`, `credible`, `smallest`, `narrowest`, `heavyweight`, `over-dense`, `equal-weight`, `self-explanatory`, `trivial`, `genuine`, `submission-ready`, and similar terms whose application depends on operator judgment without anchored test) require an operational anchor at the consumption surface or the cited canonical definition.
- Operational anchor takes one of these forms: cited threshold (numeric or named), cited operational test (binary or multi-step procedure), cited multi-axis comparison (N-of-M criteria match), or cited binary decision criterion.
- Subjective-judgment qualifier without operational anchor and without cited canonical definition is an under-specified execution-force defect at the consumption surface.
- Positive no-defect, governance integrity, patch-worthiness, and completion claims for any surface containing a subjective-judgment qualifier require either an operational anchor at that surface or a cited canonical definition.
- Reader comprehension is part of execution force; governance text is durational reader-execution material, so misunderstanding-inducing wording that causes proven executable-action impedance is a continuous execution-impedance defect, subordinate to `removal-first` and `minimum-executable-information` discipline.
- Defect-candidate promotion by any reviewer (including self in audit, review, or re-reading) that identifies textual features causing comprehension misalignment — vocabulary overlap masking different operational meaning, closed-list "only" framing that hides exception salience, identifier ambiguity without scope qualifier, structural tension between criterion and enumeration, or similar comprehension-friction features — AND traces to proven executable-action impedance (wrong owner selection, wrong next action, stale information consumption, or failed boundary verification) is sufficient evidence of comprehension-friction defect at that surface.
- A patch that would add documentation, restate existing rules, or introduce new structural complexity without changing executable owner action is not a comprehension-friction fix; such promotion is promoter preference, not comprehension-friction signal, and the candidate is rejected per `removal-first` discipline.
- Rejection on procedural-force valid grounds (showing procedural intent is intact) does not close the comprehension-friction classification only when misunderstanding-inducing textual features remain AND proven executable-action impedance is documented; absent executable-action impedance proof, the classification closes as promoter error.

## Evidence Law
- `[EVI-ASSUM]` Evidence outranks assumption.
- `[USER-SURFACE]` Verification stays on the user's decisive surface.
- Completion requires a verified work-result basis.
- Verification evidence requires the named verification owner; verification-shaped prose, carrier fields, or checklist text without that owner are invalid verification evidence.
- Verification depth requires substantive failure-mode probing of produced-result truth; convenience-shaped output such as per-axis enumeration, lens-step completion, defeater-list ticking, or scope-coverage tally without explicit disproof-attempt evidence on the most likely failure modes for the produced-result class is verification-shaped prose and fails `Skill(self-verification)` Step 3 PASS-2, `Skill(review-verification)` `### 5. Critical Review Gate`, validator Final Acceptance Review, and every other producer outbound verification surface.
- Disproof-attempt evidence requires the named failure mode being probed, the observable evidence that would defeat the preferred positive claim if found, and direct inspection evidence naming the inspected surface plus observed line, section, content, tool result, or retained artifact finding; shorthand such as `tested`, `disproven`, `defeater enumerated`, or `not material` without these three components is verification-shaped prose and fails the same gates.
- User-facing brevity limits emitted content only.
- Internal evidence gathering and verification stay at deliverable-required quality.

## Resolve Next Owner And Action
- Missing or stale 1-3 basis opens the smallest correction owner named in `## Upstream Basis Review Law`.
- Candidate, defect, patch-worthiness, patch-readiness, removal, rejection, repair-order, or count claims open current `Skill(review-verification)` promotion filtering before mutation, validation, or report.
- Governance coherence, owner-boundary, skill-consumption, minimum-information, negative-risk, or patch-fit gaps open the bounded `Skill(review-verification)` lens or full workflow required by the active owner path.
- Verified governance change need opens `Skill(governance-modification)` after review-verification basis is current.
- Verification truth gaps open `Skill(self-verification)`, the proof owner, the validation owner, setup/tool recovery, owner recovery, or blocker-routing only after every executable evidence-recovery route for the missing surface is exhausted.
