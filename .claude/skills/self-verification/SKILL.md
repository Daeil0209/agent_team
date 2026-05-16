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
- Detailed target profiles, challenge lenses, artifact-change checks, harness/proof checks, synthesis checks, and expanded output fields live in `references/verification-targets-and-gates.md`.

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

### Reference Map
- Exception-only `SV-PLAN` audits stay in this spine.
- Load `references/verification-targets-and-gates.md` for non-routine analysis, artifact/governance change, data/state/behavior/design claim, harness proof, user-surface proof, or synthesized output.
- Also load it for lead-local runtime/proof, acceptance-grade claim, same-lane positive closure risk, partial/conflicting evidence, or material contrary interpretation.
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

Compact challenge that always applies:
- request-fit: did the target satisfy the explicit user instruction?
- semantic-fit: did the target preserve the frozen `SEMANTIC-INTENT-BASIS`, user anti-goal, priority order, and material `TARGET-INTENT-BASIS`?
- deliverable-fit: did the target satisfy the frozen deliverable and acceptance surface?
- continuity: did same-session corrections, patches, recurrence barriers, and active doctrine govern this claim?
- claim/evidence: what exact claim is made?
- claim/evidence: what supports it?
- claim/evidence: what would defeat it, and was that defeater actively checked?
- claim/evidence: what remains uncertain?
- counter-bias: what would a skeptical independent lane challenge, especially if the conclusion is convenient?
- defect-label: if the claim names a defect or patch recommendation, identify the owner with classification authority.
- defect-label: identify the protected function at risk from correction or removal.
- defect-label: reject `protected-restatement`, `design-tradeoff`, and `non-issue` classifications with evidence.
- owner/acceptance: does this require reviewer, tester, or validator ownership before closure?

`anti-self-certification`:
- same-lane positive closure starts as suspect, not presumed correct
- name the strongest plausible contrary interpretation, evidence gap, or failure mode before convergence
- materially risky or acceptance-grade surfaces can be narrowed, downgraded, held, reopened, or routed
- they cannot be self-certified through SV alone

Load the reference when detailed design, data/domain meaning, software mechanism, behavior proof, harness evidence, synthesis, or failure-risk lenses are material.

## Step 3: Evidence Basis
Rules:
- use the narrowest truthful runtime and result term
- synthesized outputs require reconciled verification for stronger claims
- positive synthesis requires one reconciled verified surface
- partial, conflicting, unstored, indirect, source-only-for-user-surface, or weaker-than-claim evidence becomes `INFERENCE/UNVERIFIED`, narrowed scope, `HOLD`, or replanning
- Before promoting any item to `confirmed-defect`, load `Skill(self-growth-sequence)` and apply its `Causal Repair Standard` plus `completion-handoff.md` common finding basis.
- Promote an item to `confirmed-defect` only when correction will not remove a stronger protected function.
- If that proof is missing, report the item as candidate evidence, `risk-hypothesis`, `design-tradeoff`, `protected-restatement`, `non-issue`, or `UNVERIFIED` instead of patch authorization.
- Treat raw finding counts, candidate lists, researcher-only evidence, and same-packet multi-lane convergence as evidence basis only, not classification authority.
- Apply detailed SV-PLAN reject conditions per `references/verification-targets-and-gates.md` `## SV-PLAN Detailed Gate` and detailed SV-RESULT verification per `## SV-RESULT Detailed Gate`.
- If final prose outruns the verified surface, apply the Activation Trigger reset rule.

Use the reference for detailed gates, evidence calibration, behavior proof, artifact identity, and output detail.

## Step 4: Converge Or HOLD
1. If the challenge changes the plan or result, correct the target and rerun on that corrected target.
2. If frozen scope or route fails, reopen `work-planning`.
3. If the target survives with no material change, it is converged.
4. If repeated challenge adds no new defect, evidence, or correction path, `HOLD`.
5. Workflow-owned Codex convergence loops stay with the workflow owner.

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
- `HOLD` records verification owner, blocker, and next safe evidence step.
