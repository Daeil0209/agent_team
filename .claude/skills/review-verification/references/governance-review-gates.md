---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/review-verification/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
auto-inject: false
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
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
- Anchor the reason for change in the review packet, change packet, failure-mode tag, recurrence tag, or owner-local rationale.
- Reject duplicate doctrine when adherence hardening to an existing owner-local rule is the real fix.

## Synthesis And Finding-Promotion Review
Synthesized conclusions do not inherit finding authority automatically.

Before positive synthesis:
- Consume completion-grade or otherwise evidence-bearing surfaces, not receipt, status, progress, file presence, or partial runtime signals.
- Reconcile conflicts between agent outputs, evidence families, prior decisions, and sibling artifacts.
- Preserve common finding classes until promotion evidence is current.
- Do not promote `risk-hypothesis`, `design-tradeoff`, `duplication`, `protected-restatement`, `non-issue`, or `unverified` findings to `confirmed-defect` during synthesis.
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
- tested rejection of `protected-restatement`
- tested rejection of `design-tradeoff`
- tested rejection of `non-issue`

The selected patch direction is invalid when a stronger narrower alternative remains untested.
The selected patch direction is invalid when removal, trim, merge, re-home, replace, or tighten can preserve the rule with less burden than append.
The selected patch direction is invalid when the consumed execution surface cannot carry the corrected rule.
The selected patch direction is invalid when the destination owner is not on the failing execution path.

## Resolve Next Owner And Action
- Confirmed review packet returns to the triggering owner or opens the next owner/action named by `review-verification` Step 14.
- Missing evidence opens researcher, reviewer, local inspection, or `HOLD`.
- Patch-worthy governance asset change opens the named patch sequence or production owner.
- Confirmed recurrence-barrier need opens `governance-change`.
- Consequential reporting after review opens `self-verification`.
