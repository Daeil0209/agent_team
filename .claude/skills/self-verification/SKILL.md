---
name: self-verification
description: Verify the actual result surface produced by team-lead or a lane before analyzed-result reporting, completion claim, `Skill(review-verification)`, governance-asset `Skill(governance-modification)`, or redispatch. Use on the produced plan artifact, synthesis, patch result, proof result, or lane result being routed or reported.
user-invocable: false
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
## Structural Contract
- Sharpens only its owned verification surface.
- Fixed top-level section order after Structural Contract: Purpose, Reporting Principle, Activation Trigger, Step 0, Step 1, Step 2, Step 3, Step 4, Step 5, Verification Output Format, Resolve Next Owner And Action.
- Reference Map stays inside Purpose.
- Step names: Choose Verification Mode And Target, Scope Match, Critical Challenge, Evidence Basis, Converge Or HOLD, Output Verified State.
- Detailed target profiles, challenge lenses, claim-strength checks, harness/proof checks, synthesis checks, and expanded output fields live in `references/verification-targets-and-gates.md`.

## Purpose
Verify only the current produced result surface at the correct gate and from a skeptical, defeater-seeking posture.
Modes:
- `plan-audit`: exception-only verification when the produced frozen plan artifact is explicitly disputed or directly requested as the target.
- `result-verification`: verify a team-lead or lane-produced phase/stage-end consequential result before analyzed-result reporting, completion claim, `Skill(review-verification)`, governance-asset `Skill(governance-modification)`, or redispatch.

Analysis, diagnosis, advice, artifact-change, proof, synthesis, and completion checks become verification when the checked target is the produced result surface.

Boundary:
- self-verification can narrow, block, reopen, route, or downgrade a claim
- self-verification verifies the work product produced by the current team-lead or lane owner; modification design and patch execution stay with their owner skills
- Routine receipt, startup readiness, and `dispatch-ack` are Communication Plane state signals, not produced-result verification targets.
- self-verification records the next review judgment for the produced result: `owner-local-sufficient:<basis>`, `Skill(review-verification):<bounded-question>`, `Skill(governance-modification):<governance-modification-basis>`, redispatch, or report
- independent `reviewer`, `tester`, or `validator` owners still close required independent surfaces
- materially risky or acceptance-grade same-lane positive closure routes to the required independent owner before closure
- Binding governance or classification judgment follows Step 2 and Step 4 review-verification escalation; candidate discovery stays evidence-only under Step 3.

### Reference Map
- Exception-only `plan-audit` stays in this spine.
- `.claude/reference/judgment-core-law.md`: load when verifying proof, validation, acceptance, final-arbitration readiness, independent-lane requirement, or verdict-routing truth.
- `.claude/reference/review-and-verification-core-law.md`: load when verifying an outgoing result, completion claim, synthesized review result, or redispatch basis that depends on evidence quality or verification truth.
- Load `references/verification-targets-and-gates.md` whenever any trigger in its `## Reference Load Triggers` matches the current claim or surface.
- Step 2 mandatory review-verification escalation records and opens `Skill(review-verification):<bounded-question>` plus `.claude/skills/review-verification/references/governance-review-gates.md` before `Skill(governance-modification)`, redispatch, or reporting.
- Unavailable triggered references route to `HOLD`, `INFERENCE/UNVERIFIED`, or reopened owning path.

## Reporting Principle
Self-verification is internal process work governed by `.claude/reference/reporting-prohibition-law.md`.
Plan-audit and result-verification records, challenge notes, evidence basis, open surfaces, verification fields, and convergence state are Procedure Plane records.
User-facing output exposes only the verification outcome or concise verification basis that `.claude/reference/reporting-prohibition-law.md` grants as a narrow exception.
Expose residual risk, open surfaces, or unverified items only when `.claude/reference/reporting-prohibition-law.md` grants a narrow exception for that exact report surface.

Expose internal templates or labelled self-verification fields only on explicit request.
Report this skill as used only when it was actually loaded and applied to the current target.
A `Skill(self-verification)` tool call must appear in the current turn before any self-verification claim.
Absence of `Skill(self-verification)` tool call in the current turn invalidates the load or applied claim.
Inline reasoning, checklist wording, memory, or "self-verification-style" language is not skill execution.

## Activation Trigger
Load and run the appropriate mode:
1. `plan-audit`: for an explicit plan-audit target or disputed readiness of a produced frozen plan artifact.
2. `result-verification`: before reporting a phase/stage-end analyzed, evaluated, synthesized, or produced consequential result.
3. `result-verification`: before a completion claim.
4. `result-verification`: before opening `Skill(review-verification)`, governance-asset `Skill(governance-modification)`, or redispatching from lane-produced, multi-source, or synthesized result.

In-phase repeated review, independent-review, correction, and convergence checks stay with the active owner.
Temporal gate: verify first, then act or report.
Carry-forward stays valid inside the same frozen workflow loop until a phase/stage-end report, completion claim, or new claim strength is formed.
Phase/stage-end reporting needs current result verification for the exact outgoing claim.
After result verification, narrowing or editorial compression keeps the pass current.
Reset result verification for new scope, stronger claim, materially changed claim, out-of-loop mutation, dispatch/reuse, synthesis report, proof/acceptance change, or phase change.
PROTECTED-LOCAL-RESTATEMENT-BASIS: verification-owner-split parallel basis — the cumulative-live-state + stale-baseline-invalidation rule pair below is also declared at `.claude/skills/review-verification/SKILL.md` `## Activation` for the review-verification workflow owner; each verification skill owns the rule for its own verification activity (result-verification here vs review-verification Steps 1-14 there), so the parallel restatement is defense-in-depth not duplication.
Each fresh result verification runs against the current cumulative live state of the target surfaces, including every session-applied patch up to this verification time.
Pre-session, pre-prior-patch, or memory-based baselines are stale evidence and invalidate the verification record.

## Step 0: Choose Verification Mode And Target
Choose mode and material target profiles before verifying.

`plan-audit` minimum targets:
- produced frozen plan artifact, route, `NEXT-CONSEQUENTIAL-ACTION`, readiness basis, owner path, and first allowed move
- lane-local assignment packet, `WORK-SURFACE`, `CURRENT-PHASE`, `REQUIRED-SKILLS`, first lane action, and routing/closure condition

Result-verification minimum targets:
- exact produced result surface
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
- `plan-audit`: is the produced frozen plan artifact still the correct path?
- Result verification: is the produced result actually verified at the claim strength being used?

Challenge floor:
- test request, semantic intent, deliverable, exact claim, evidence, defeater, uncertainty, owner, and acceptance fit
- treat same-lane positive closure as suspect until a contrary interpretation, evidence gap, or owner-separation need is tested
- apply mandatory review-verification escalation before the verification result authorizes binding defect promotion, final or cross-surface rejection, ranking, prioritization, removal, correction-priority, patch/no-patch, patch-worthiness, patch-readiness, cross-surface governance, or correction-design judgment; otherwise narrow to candidate inventory, redispatch, or `HOLD`
- record and open `Skill(governance-modification):<governance-modification-basis>` when the review-verified result confirms governance asset change
- when the verified target is a lane-produced governance asset change (applied patch on `.claude/` doctrine, agents, skills, settings, hooks, or live-surface mirrors), the Critical Challenge applies the lane-side quality contract (trio) per `.claude/skills/task-execution/references/lane-additions.md` `## Common Lane-Core Preconditions`

Load the reference when a detailed profile, challenge lens, proof check, synthesis check, or anti-self-certification check is material.

## Step 3: Evidence Basis
Rules:
- use the narrowest truthful runtime and result term
- synthesized outputs require reconciled verification for stronger claims
- positive synthesis requires one reconciled verified surface
- partial, conflicting, unstored, indirect, source-only-for-user-surface, or weaker-than-claim evidence becomes `INFERENCE/UNVERIFIED`, narrowed scope, `HOLD`, or replanning
- Defect promotion requires current `Skill(review-verification)` defect-promotion basis.
- Self-verification checks the outgoing claim against that basis; promotion authority remains with the defect-promotion path.
- If that basis is missing, downgrade, narrow, or `HOLD` instead of authorizing patch dispatch.
- A review-verified produced result that identifies team-operation defect correction or recurrence-barrier work opens `Skill(governance-modification)` for governance asset change; `Skill(governance-modification)` consumes `Skill(review-verification)` before Draft for material patch design or mutation-readiness judgment.
- Treat raw finding counts, candidate lists, researcher-only evidence, and same-packet multi-lane convergence as evidence basis only, not classification authority.
- For governance audit candidate maps, self-verification verifies candidate-map integrity, lane-local state preservation (`candidate-evidence`, `candidate-classified`, or lane-local `rejected:<basis>`), and next owner/action only; binding filtering, final rejection, promotion, priority, removal, patch-worthiness, and patch-readiness authority remain with their owning path.
- Verify finding reports against `.claude/reference/review-and-verification-core-law.md` `## Candidate Filtering And Promotion Law`.
- If an outgoing report collapses raw candidates into confirmed defects, patch-worthy defects, or patch-ready defects without promotion basis, narrow the report to candidate inventory or reopen `Skill(review-verification)`.
- If an outgoing report uses bare `CONFIRMED`, require exact ladder state wording before reporting.
- Apply detailed plan-audit reject conditions and result-verification checks from `references/verification-targets-and-gates.md`.
- If final prose outruns the verified surface, apply the Activation Trigger reset rule.

Use the reference for detailed gates, evidence calibration, behavior proof, artifact identity, and output detail.

## Step 4: Converge Or HOLD
1. If the challenge changes the plan or result, correct the target and rerun on that corrected target.
2. If frozen scope or route fails, reopen `work-planning`.
3. Record the next review judgment for the produced result.
4. Use `owner-local-sufficient:<basis>` only when no Step 2 escalation trigger is present; candidate discovery may use it only for Step 3 evidence-only states.
5. Use `Skill(review-verification):<bounded-question>` for every mandatory review-verification escalation trigger; resume only after the review owner returns a current basis.
6. Use `Skill(governance-modification):<governance-modification-basis>` when the review-verified produced result confirms governance asset change or recurrence-barrier need.
7. If the target survives with no material change, it is converged.
8. If repeated challenge adds no new defect, evidence, or correction path, `HOLD`.
9. Workflow-owned Codex convergence loops stay with the workflow owner.

Only converged work proceeds as verified.

## Step 5: Output Verified State
Output only the next verified state:
- `plan-audit`: `proceed-local`, `open-task-execution`, `clear-blocker`, `reopen-work-planning`, or `HOLD`
- `result-verification`: `verified-result`, `narrow-to-verified-scope`, `INFERENCE/UNVERIFIED`, `reopen-work-planning`, or `HOLD`

User-facing prose reports only the needed verification outcome surface.
Procedure detail stays internal unless explicitly requested.
Result verification is current only for the exact target, evidence basis, open surfaces, and claim strength verified in this pass.
New or stronger report drafts follow the Activation Trigger reset rule.
Re-verify or narrow the report before showing it as verified.

## Verification Output Format
Internal handoff only.
Hold in current-turn context.
Write continuity only when a continuity owner requires it.
`SELF-VERIFICATION:` is the internal verification block label only.
Completion-grade lane labels are not team-lead result verification.
Internal labels carry authority only through loaded `Skill(self-verification)`.
```
SELF-VERIFICATION:
MODE: plan-audit | result-verification
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
- `plan-audit: proceed-local` opens the frozen local action.
- `plan-audit: open-task-execution` opens `task-execution`.
- `plan-audit: clear-blocker` opens the named blocker-clear move.
- `result-verification: verified-result` permits only the verified claim surface and returns to the calling owner for the recorded `ALLOWED-NEXT-ACTION`.
- `result-verification: narrow-to-verified-scope` opens claim narrowing.
- `INFERENCE/UNVERIFIED` opens claim downgrade or evidence correction.
- `reopen-work-planning` opens `work-planning`.
- Non-converged result-verification (`narrow-to-verified-scope`, `INFERENCE/UNVERIFIED`, `reopen-work-planning`, or `HOLD` with recoverable basis) auto-reopens the calling owner's smallest invalidated step at the current cumulative live state.
- The calling owner executes the iteration without user authorization unless irreversible, destructive, security-sensitive, operator-policy-choice, or proven user-owned blocker criteria apply per `.claude/reference/work-execution-core-law.md` `[NO-NEEDLESS-ASK]`.
- The iteration loop continues until `verified-result` converges or `HOLD` records an escalation-class blocker.
- Review-verified produced-result confirmation of governance asset change or recurrence-barrier need opens `Skill(governance-modification)`; other defect-promotion, governance-judgment, removal, or patch-worthiness gaps open `Skill(review-verification):<bounded-question>`; same-request open review, proof, validation, `Skill(governance-modification)`, or redispatch owners execute or dispatch unless a user-action blocker or approval gate applies.
- `HOLD` records verification owner, blocker, and next safe evidence step.
