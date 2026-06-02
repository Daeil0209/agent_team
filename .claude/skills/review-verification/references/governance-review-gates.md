---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/review-verification/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
auto-inject: false
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# Review-Verification Reference: Governance Review Gates
Load only after `Skill(review-verification)` triggers detailed claim review, artifact-change review, synthesis and finding-promotion review, or patch-worthiness review.

## Contents
- Claim Review
- Artifact-Change Review
- Synthesis And Finding-Promotion Review
- Patch-Worthiness Review
- Resolve Next Owner And Action

## Claim Review
For analysis, diagnosis, consistency review, risk analysis, causal explanation, recommendation, or design judgment:
- Separate observation, inference, judgment, and recommendation.
- Name the evidence surface that supports each controlling claim.
- Search for the strongest contrary interpretation or evidence that would defeat the conclusion.
- Mark partial coverage as partial instead of generalizing to the whole corpus.
- Treat fluent explanation, internal confidence, repeated wording, and label similarity as non-evidence.
- Verify that the conclusion follows the inspected reference rather than a convenient substitute.
- Route action-changing conclusions back through the owning planning or sequence gate.

## Artifact-Change Review
For doctrine, skill, agent, hook, code, config, reference, or produced-artifact changes:
- Check the change against the frozen request and target intent.
- Preserve Structural Contract, fixed section order, priority hierarchy, owner boundaries, authoring principles, protected local restatements, and section purpose.
- Verify that the change strengthens the weak path without weakening an already-correct path.
- For moved, compressed, replaced, or removed meaning, require source meaning, destination owner, and bounded change scope to remain reconstructable.
- Verify live cross-references after the proposed move, merge, deletion, or replacement.
- Verify that execution-changing top-doctrine text has mapped core-law executable detail or recorded existing-detail coverage.
- Verify that execution-changing core-law text has required trigger-bound owner guidance or recorded not-material basis.
- Verify that governance text is neither under-specified nor over-specified for its executing owner.
- Verify that governance text keeps the executing owner path free of evasion, residual ambiguity, semantic conflict, bottleneck, and over-broad blocking.
- Anchor the reason for change in the review packet, change packet, failure-mode tag, recurrence tag, or owner-local rationale.
- Reject duplicate doctrine when adherence hardening to an existing owner-local rule is the real fix.

## Synthesis And Finding-Promotion Review
Synthesized conclusions require current finding authority before positive use.

Before positive synthesis:
- Consume completion-grade or otherwise evidence-bearing surfaces, not receipt, status, progress, file presence, or partial runtime signals.
- Reconcile conflicts between agent outputs, evidence families, prior decisions, and sibling artifacts.
- Separate candidate recall from elimination-first filtering and defect-promotion filtering; candidate recall names the suspected failure and the strongest visible protected-function, target-intent, direct-consumption, or non-defect classification that could defeat promotion.
- Classify each item through `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law` and `## Cause And Remedy Classification Law` before using defect, patch-worthiness, patch-readiness, remedy, hook/settings, runtime/tool, reporting, transport-defect, malformed-transport, transport-remedy, or count language.
- Promote a synthesized item only through `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law`; otherwise preserve the supported lower ladder state or `rejected:<basis>`.
- Treat reviewer agreement, repeated labels, similar wording, apparent-defect framing, repair-order pressure, fluent synthesis, and lane-local conclusion labels as non-promoting metadata until the evidence defeats the strongest rejection basis.
- Keep occurrence counts separate from root-cause counts.
- Keep raw candidate counts separate from confirmed-defect, patch-worthy, patch-ready, rejected, and open-candidate counts.
- Record per-item finding-state inventory before any downstream correction, routing, mutation, validation, reporting, or closure uses the synthesis.
- Preserve common candidate and rejection classifications by mapping them to the canonical finding-state ladder before synthesis.
- Keep proven rejection bases as `rejected:<basis>` values; treat repeated meaning without protected local-restatement basis as a duplication candidate class until canonical rejection or promotion is proven.
- Name the exact finding-state ladder state instead of bare `CONFIRMED`.
- Preserve open surfaces instead of flattening them into a clean conclusion.
- Keep claim strength limited to the weakest material unresolved surface.
- Keep final wording inside the supported evidence scope when the evidence matrix or retained open surface is material.
- Apply design-intent and owner-boundary review before reporting positive existing-artifact integrity.

If outputs conflict, coverage is partial, or the synthesized conclusion outruns the evidence surface, narrow the claim, downgrade it, reopen the owner path, or hold.

## Patch-Worthiness Review
Patch-worthiness requires current proof of:
- protected function
- item-level cause/remedy classification
- negative operating effect
- correction owner
- preserved or improved user outcome
- smallest owner surface
- selected operation type
- regression risk
- intended changed function set
- positive-function inventory in the coherence radius
- correlated functions changed by governed interface
- per-function no-negative-impact result
- minimum-executable-information result
- behavior-weakening wording result
- upper-to-core executable-detail result when top doctrine changes execution
- core-to-trigger-bound guidance result when core-law execution detail needs situation-specific guidance
- tested rejection of `protected-restatement`
- tested rejection of `design-tradeoff`
- tested rejection of `non-issue`

Patch readiness additionally requires current proof of patch-owner surface, edit operation, source meaning, destination owner when moved, direct-consumption relevance, intended changed function set, positive-function inventory, per-function no-negative-impact result, and verification basis.
Patch-worthiness without those fields remains `patch-worthy`, not `patch-ready`.
The selected patch direction is patch-ready only when:
- item-level cause/remedy classification is current and matches remedy owner, remedy class, hook eligibility, and counterexample oracle
- every stronger narrower alternative is tested or rejected by current evidence
- removal, trim, merge, re-home, replace, or tighten is selected whenever it preserves the rule with less burden than append
- the consumed execution surface can carry the corrected rule
- the destination owner sits on the failing execution path
- the executing owner surface has specified governance at the needed detail level
- the executing owner surface is free of evasion-enabling, ambiguous, conflicting, bottleneck-forming, and over-broad-blocking governance
- upper-to-core execution changes have mapped core-law executable detail or recorded existing-detail coverage
- core-to-trigger-bound execution changes have required triggered owner guidance or valid `not-material:<basis>`

## Resolve Next Owner And Action
- Confirmed review packet returns to the triggering owner with the next owner/action named by `Skill(review-verification)` Step 14; full workflow execution opens that owner/action.
- Missing evidence opens researcher, reviewer, local inspection, or blocker-routing after internal recovery.
- Patch-ready governance asset change opens the named patch sequence or production owner for mutation.
- Patch-worthy governance asset change without patch-ready basis opens patch-readiness completion on the current review or governance-modification path, not mutation.
- Confirmed recurrence-barrier need opens `Skill(governance-modification)`.
- Consequential reporting after review opens `Skill(self-verification)`.
