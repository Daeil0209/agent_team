---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/review-verification/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
auto-inject: false
REPORTING-CURTAIN: .claude/reference/reporting-user-reporting-law.md
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
- Do not treat fluent explanation, internal confidence, repeated wording, or label similarity as evidence.
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
- Verify that governance text does not create evasion, residual ambiguity, semantic conflict, bottleneck, or over-broad blocking on its executing owner path.
- Anchor the reason for change in the review packet, change packet, failure-mode tag, recurrence tag, or owner-local rationale.
- Reject duplicate doctrine when adherence hardening to an existing owner-local rule is the real fix.

## Synthesis And Finding-Promotion Review
Synthesized conclusions do not inherit finding authority automatically.

Before positive synthesis:
- Consume completion-grade or otherwise evidence-bearing surfaces, not receipt, status, progress, file presence, or partial runtime signals.
- Reconcile conflicts between agent outputs, evidence families, prior decisions, and sibling artifacts.
- Separate candidate recall from defect-promotion filtering.
- Classify each item through `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law` before using defect, patch-worthiness, patch-readiness, severity, or count language.
- Keep occurrence counts separate from root-cause counts.
- Keep raw candidate counts separate from confirmed-defect, patch-worthy, patch-ready, rejected, and open-candidate counts.
- Preserve common finding classes until promotion evidence is current.
- Do not promote `risk-hypothesis`, `design-tradeoff`, `duplication`, `protected-restatement`, `non-issue`, or `unverified` findings to `confirmed-defect` during synthesis.
- Do not use bare `CONFIRMED`; name the exact finding-state ladder state.
- Preserve open surfaces instead of flattening them into a clean conclusion.
- Keep claim strength limited to the weakest material unresolved surface.
- Keep final wording inside the supported evidence scope when the evidence matrix or retained open surface is material.
- Apply design-intent and owner-boundary review before reporting positive existing-artifact integrity.

If outputs conflict, coverage is partial, or the synthesized conclusion outruns the evidence surface, narrow the claim, downgrade it, reopen the owner path, or hold.

## Patch-Worthiness Review
Patch-worthiness requires current proof of:
- protected function
- negative operating effect
- correction owner
- preserved or improved user outcome
- smallest owner surface
- selected operation type
- regression risk
- minimum-executable-information result
- behavior-weakening wording result
- upper-to-core executable-detail result when top doctrine changes execution
- core-to-trigger-bound guidance result when core-law execution detail needs situation-specific guidance
- tested rejection of `protected-restatement`
- tested rejection of `design-tradeoff`
- tested rejection of `non-issue`

Patch readiness additionally requires current proof of patch-owner surface, edit operation, source meaning, destination owner when moved, direct-consumption relevance, and verification basis.
Patch-worthiness without those fields remains `patch-worthy`, not `patch-ready`.
The selected patch direction is invalid when a stronger narrower alternative remains untested.
The selected patch direction is invalid when removal, trim, merge, re-home, replace, or tighten can preserve the rule with less burden than append.
The selected patch direction is invalid when the consumed execution surface cannot carry the corrected rule.
The selected patch direction is invalid when the destination owner is not on the failing execution path.
The selected patch direction is invalid when it leaves under-specified or over-specified governance on the executing owner surface.
The selected patch direction is invalid when it leaves evasion-enabling, ambiguous, conflicting, bottleneck-forming, or over-broad-blocking governance on the executing owner surface.
The selected patch direction is invalid when it leaves an upper-to-core gap open without mapped core-law executable detail or recorded existing-detail coverage.
The selected patch direction is invalid when it leaves a core-to-trigger-bound gap open without required triggered owner guidance or valid `not-material:<basis>`.

## Resolve Next Owner And Action
- Confirmed review packet returns to the triggering owner with the next owner/action named by `Skill(review-verification)` Step 14; standalone full workflow opens that owner/action.
- Missing evidence opens researcher, reviewer, local inspection, or `HOLD`.
- Patch-worthy governance asset change opens the named patch sequence or production owner.
- Confirmed recurrence-barrier need opens `Skill(governance-modification)`.
- Consequential reporting after review opens `Skill(self-verification)`.
