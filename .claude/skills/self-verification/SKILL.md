---
name: self-verification
description: Verify disputed frozen plans and phase/stage-end consequential results before analyzed-result reporting, completion claim, or redispatch. Use when SV-PLAN or SV-RESULT is triggered for consequential planning, reporting, completion, or synthesis-triggered redispatch.
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Sharpens only its owned verification surface.
- Fixed top-level section order after Structural Contract: Purpose, Reporting Principle, Activation Trigger, Step 0, Step 1, Step 2, Step 3, Step 4, Step 5, Verification Output Format, Resolve Next Owner And Action.
- Reference Map stays inside Purpose.
- Step names: Choose Verification Mode And Target, Scope Match, Critical Challenge, Evidence Basis, Converge Or HOLD, Output Verified State.
- PRIMARY-OWNER: team-lead
- Detailed target profiles, challenge lenses, claim-strength checks, harness/proof checks, synthesis checks, and expanded output fields live in `references/verification-targets-and-gates.md`.

## Purpose
Verify only at the correct gate and from a skeptical, defeater-seeking posture.
Modes:
- `SV-PLAN`: exception-only verification when a frozen plan is explicitly disputed or directly requested as the target.
- `SV-RESULT`: verify a phase/stage-end consequential result before analyzed-result reporting, completion claim, or redispatch.

Analysis, diagnosis, advice, artifact-change, proof, synthesis, and completion checks become verification only through one of those modes.

Boundary:
- self-verification can narrow, block, reopen, route, or downgrade a claim
- independent `reviewer`, `tester`, or `validator` owners still close required independent surfaces
- materially risky or acceptance-grade same-lane positive closure routes to the required independent owner before closure
- material defect, cross-surface governance, removal, or patch-worthiness review routes to `review-verification`; this skill keeps claim and resume control

### Reference Map
- Exception-only `SV-PLAN` audits stay in this spine.
- Load `references/verification-targets-and-gates.md` for non-routine analysis, artifact/governance change, data/state/behavior/design claim, harness proof, user-surface proof, or synthesized output.
- Also load it for lead-local runtime/proof, acceptance-grade claim, same-lane positive closure risk, partial/conflicting evidence, or material contrary interpretation.
- Material defect, removal, cross-surface governance, or patch-worthiness detail opens `Skill(review-verification)` and its `references/governance-review-gates.md`; this skill resumes only after that review packet exists.
- If a triggered reference cannot be consulted, use `HOLD`, `INFERENCE/UNVERIFIED`, or reopen the owning path.

## Reporting Principle
Self-verification is internal process work governed by `.claude/reference/user-reporting-law.md`.
`SV-PLAN`, `SV-RESULT`, challenge notes, evidence basis, open surfaces, verification fields, and convergence state are Procedure Plane records.
User-facing output exposes only the verification outcome or concise verification basis that `.claude/reference/user-reporting-law.md` admits.
Expose residual risk, open surfaces, or unverified items only when `.claude/reference/user-reporting-law.md` admits that exact report surface.

Expose internal templates or labelled SV fields only on explicit request.
Report this skill as used only when it was actually loaded and applied to the current target.
Inline reasoning, checklist wording, memory, or "SV-style" language is not `SV-RESULT`.

## Activation Trigger
Load and run the appropriate mode:
1. `SV-PLAN`: only for an explicit plan-audit target or disputed frozen-plan readiness.
2. `SV-RESULT`: before reporting a phase/stage-end analyzed, evaluated, synthesized, or produced consequential result.
3. `SV-RESULT`: before a completion claim.
4. `SV-RESULT`: before redispatching from a synthesized result.

In-phase repeated review, independent-review, correction, and convergence checks stay with the active owner.
Temporal gate: verify first, then act or report.
Carry-forward stays valid inside the same frozen workflow loop for non-reporting iteration only.
Phase/stage-end reporting needs current `SV-RESULT` for the exact outgoing claim.
After `SV-RESULT`, narrowing or editorial compression keeps the pass current.
Reset `SV-RESULT` for new scope, stronger claim, materially changed claim, out-of-loop mutation, dispatch/reuse, synthesis report, proof/acceptance change, or phase change.

## Step 0: Choose Verification Mode And Target
Choose mode and material target profiles before verifying.

`SV-PLAN` minimum targets:
- top-level plan route, `NEXT-CONSEQUENTIAL-ACTION`, readiness basis, owner path, and first allowed move
- lane-local assignment packet, `WORK-SURFACE`, `CURRENT-PHASE`, `REQUIRED-SKILLS`, first lane action, and stop condition

`SV-RESULT` minimum targets:
- exact verified surface
- claim strength
- evidence basis
- open surfaces
- whether the result is produced, synthesized, inferred, or externally evidenced

Target profiles are listed in `references/verification-targets-and-gates.md`.
If profile choice moves a `work-planning` boundary-change axis, reopen `work-planning`.
Profile-specific reference-use and citation discipline live in that reference.
Keep the detailed trigger list in that reference.

## Step 1: Scope Match
Check these frozen surfaces before challenge:
- frozen plan
- `REQUEST-FIT-BASIS`
- `SEMANTIC-INTENT-BASIS`
- `DERIVED-DEFAULTS`
- material `TARGET-INTENT-BASIS`
- `REQUEST-BOUND-PACKET-FIELDS`
- assignment packet fields
- explicit user instruction
- user philosophy
- active constraints

Fail when the target:
- widens scope, drops a stated priority, weakens a user constraint, ignores failure-history cues, or departs from the frozen deliverable
- omits, contradicts, or replaces frozen semantic intent with literal wording, target purpose alone, or local convenience
- treats progress, dispatch, receipt, status, or partial runtime signal as completion
- uses phase-local skill refinement to create a new lane, work surface, proof surface, acceptance owner, or hidden route
- changes doctrine, skills, agents, hooks, code, configs, or references without preserving declared design intent

Use the reference for artifact-change design-intent detail.

## Step 2: Critical Challenge
Try to disprove the plan or result before any positive wording. Confirmation-only, convenience-aligned, or self-approval review is invalid.

Ask the mode question:
- `SV-PLAN`: is the frozen plan still the correct path?
- `SV-RESULT`: is the result actually verified at the claim strength being used?

Challenge floor:
- test request, semantic intent, deliverable, exact claim, evidence, defeater, uncertainty, owner, and acceptance fit
- treat same-lane positive closure as suspect until a contrary interpretation, evidence gap, or owner-separation need is tested
- route material defect, removal, cross-surface governance, or patch-worthiness judgment to `review-verification`

Load the reference when a detailed profile, challenge lens, proof check, synthesis check, or anti-self-certification check is material.

## Step 3: Evidence Basis
Rules:
- use the narrowest truthful runtime and result term
- synthesized outputs require reconciled verification for stronger claims
- positive synthesis requires one reconciled verified surface
- partial, conflicting, unstored, indirect, source-only-for-user-surface, or weaker-than-claim evidence becomes `INFERENCE/UNVERIFIED`, narrowed scope, `HOLD`, or replanning
- Defect promotion requires current `review-verification` defect-promotion basis.
- Self-verification checks the outgoing claim against that basis; it does not create an alternate promotion path.
- If that basis is missing, downgrade, narrow, or `HOLD` instead of authorizing patch dispatch.
- Possible team-operation defect or recurrence path routes through `review-verification` before governance-change hardening.
- Treat raw finding counts, candidate lists, researcher-only evidence, and same-packet multi-lane convergence as evidence basis only, not classification authority.
- Apply detailed SV-PLAN reject conditions per `references/verification-targets-and-gates.md` `## SV-PLAN Detailed Gate` and detailed SV-RESULT verification per `## SV-RESULT Detailed Gate`.
- If final prose outruns the verified surface, apply the Activation Trigger reset rule.

Use the reference for detailed gates, evidence calibration, behavior proof, artifact identity, and output detail.

## Step 4: Converge Or HOLD
1. If the challenge changes the plan or result, correct the target and rerun on that corrected target.
2. If frozen scope or route fails, reopen `work-planning`.
3. If the challenge opens defect promotion, cross-surface governance judgment, removal judgment, or patch-worthiness, route to `review-verification` and resume this verification only after the review owner returns a current basis.
4. If the target survives with no material change, it is converged.
5. If repeated challenge adds no new defect, evidence, or correction path, `HOLD`.
6. Workflow-owned Codex convergence loops stay with the workflow owner.

Only converged work proceeds as verified.

## Step 5: Output Verified State
Output only the next verified state:
- `SV-PLAN`: `proceed-local`, `open-task-execution`, `clear-blocker`, `reopen-work-planning`, or `HOLD`
- `SV-RESULT`: `verified-result`, `narrow-to-verified-scope`, `INFERENCE/UNVERIFIED`, `reopen-work-planning`, or `HOLD`

User-facing prose reports only the needed verification outcome surface.
Procedure detail stays internal unless explicitly requested.
`SV-RESULT` is current only for the exact target, evidence basis, open surfaces, and claim strength verified in this pass.
New or stronger report drafts follow the Activation Trigger reset rule.
Re-verify or narrow the report before showing it as verified.

## Verification Output Format
Internal handoff only.
Hold in current-turn context.
Write continuity only when a continuity owner requires it.
`SELF-VERIFICATION:` is the internal verification block label only.
Completion-grade lane labels are not team-lead `SV-RESULT`.
Internal labels carry SV authority only through loaded self-verification.
```
SELF-VERIFICATION:
MODE: SV-PLAN | SV-RESULT
CONVERGED:
RESULT:
ALLOWED-NEXT-ACTION:
EXECUTION-BOUNDARY:
VERIFIED-SURFACE:
VERIFICATION-BASIS:
OPEN-SURFACES:
UNVERIFIED-ITEMS:
HOLD-REASON:
```

## Resolve Next Owner And Action
- `SV-PLAN: proceed-local` opens the frozen local action.
- `SV-PLAN: open-task-execution` opens `task-execution`.
- `SV-PLAN: clear-blocker` opens the named blocker-clear move.
- `SV-RESULT: verified-result` permits only the verified claim surface.
- `SV-RESULT: narrow-to-verified-scope` opens claim narrowing.
- `INFERENCE/UNVERIFIED` opens claim downgrade or evidence correction.
- `reopen-work-planning` opens `work-planning`.
- Defect-promotion, governance-judgment, removal, or patch-worthiness gaps open `review-verification`; confirmed recurrence-barrier need opens `governance-change`.
- `HOLD` records verification owner, blocker, and next safe evidence step.
