---
name: self-verification
description: Verify frozen plans and produced or synthesized results before consequential action, dispatch, reporting, handoff, or redispatch; not for light or receipt/control-only messages.
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Inherits `CLAUDE.md`, the active owner role, and the common inheritance floor in `CLAUDE.md` `Priority And Ownership`. This skill may sharpen its owned verification surface, but it must not weaken that floor or the owning role's stop conditions.
- Fixed section order: Purpose, Reporting Principle, Activation Trigger, Step 0: Choose Verification Mode And Target, Step 1: Scope Match, Step 2: Critical Challenge, Step 3: Evidence Basis, Step 4: Converge Or HOLD, Step 5: Output Verified State, Verification Output Format
- PRIMARY-OWNER: team-lead
- Structural changes require governance review.
- Detailed target profiles, challenge lenses, artifact-change checks, harness/proof checks, synthesis checks, and expanded output fields live in `references/verification-targets-and-gates.md`.

## Purpose
Verify before acting or reporting. This remains one skill with two modes:
- `SV-PLAN`: verify a frozen plan before consequential action, dispatch, reuse, or local execution.
- `SV-RESULT`: verify a produced or synthesized result before reporting, handoff, completion claim, or redispatch.

There is no third analysis mode. Analysis, diagnosis, recommendation, artifact-change, proof, synthesis, and handoff checks are target profiles inside `SV-PLAN` or `SV-RESULT`.

Boundary:
- self-verification may narrow, block, reopen, route, or downgrade a claim
- it never replaces independent `reviewer`, `tester`, or `validator` ownership when those owners are required
- materially risky or acceptance-grade same-lane positive closure must route to the required independent owner before closure

### Reference Map
- Routine `SV-PLAN` route checks stay in this spine.
- Load `references/verification-targets-and-gates.md` when the target involves non-routine analysis, artifact/governance change, data/state/behavior/design claim, harness or user-surface proof, synthesized outputs, lead-local runtime/proof, acceptance-grade claim, same-lane positive closure risk, partial/conflicting evidence, or any material contrary interpretation.
- If a triggered reference cannot be consulted, use `HOLD`, `INFERENCE/UNVERIFIED`, or reopen the owning path instead of approving from the compact spine.

## Reporting Principle
Self-verification is internal process work. User-facing output may expose only concise verification basis, residual risk/open surfaces, or unverified items when the answer is final, audit-like, consequential, or explicitly asks for basis.

Never show internal templates or labelled SV fields to the user unless explicitly requested.
It is forbidden to imply this skill was used unless it was actually loaded and applied to the current target. Inline reasoning, checklist wording, memory, or "SV-style" language is not `SV-RESULT`.

## Activation Trigger
Load and run the appropriate mode:
1. after `work-planning` freezes a consequential plan
2. before consequential execution, reuse, dispatch, conclusion, recommendation, report, or handoff
3. after consequential modification
4. after synthesizing multiple outputs into one conclusion
5. before redispatch driven by a synthesized result

Temporal gate: verify first, then act or report. Carry-forward is valid only while no new scope, stronger claim, file modification, dispatch/reuse, synthesis, or phase change has appeared since the last relevant SV pass.

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

Target profiles are listed in `references/verification-targets-and-gates.md`. If profile choice changes owner, surface, deliverable, proof basis, or acceptance chain, reopen `work-planning`. Profile-specific reference-use and citation discipline live in that reference; do not duplicate the detailed trigger list in this compact spine.

## Step 1: Scope Match
Check against the frozen plan, `REQUEST-FIT-BASIS`, `REQUEST-BOUND-PACKET-FIELDS`, assignment packet fields, explicit user instruction, user philosophy, and active constraints.

Fail when the target:
- widens scope, drops a stated priority, weakens a user constraint, ignores failure-history cues, or departs from the frozen deliverable
- treats progress, dispatch, receipt, status, or partial runtime signal as completion
- uses phase-local skill refinement to create a new lane, work surface, proof surface, acceptance owner, or hidden route
- changes doctrine, skills, agents, hooks, code, configs, or references without preserving declared design intent

Use the reference for artifact-change design-intent detail.

## Step 2: Critical Challenge
Ask the mode question:
- `SV-PLAN`: is the frozen plan still the correct path?
- `SV-RESULT`: is the result actually verified at the claim strength being used?

Compact challenge that always applies:
- request-fit: would this satisfy the user's request if read literally?
- claim/evidence: what exact claim is made, what supports it, what would defeat it, and what remains uncertain?
- counter-bias: what would a skeptical independent lane challenge, especially if the conclusion is convenient?
- owner/acceptance: does this require reviewer, tester, or validator ownership before closure?

`anti-self-certification`:
- same-lane positive closure starts suspect
- name the strongest plausible contrary interpretation, evidence gap, or failure mode before convergence
- materially risky or acceptance-grade surfaces may be narrowed, downgraded, held, reopened, or routed; they may not be self-certified through SV alone

Load the reference when detailed design, data/domain meaning, software mechanism, behavior proof, harness evidence, synthesis, or failure-risk lenses are material.

## Step 3: Evidence Basis
Rules:
- use the narrowest truthful runtime and result term
- synthesized outputs do not inherit stronger verification automatically
- positive synthesis requires one reconciled verified surface
- partial, conflicting, unstored, indirect, source-only-for-user-surface, or weaker-than-claim evidence becomes `INFERENCE/UNVERIFIED`, narrowed scope, `HOLD`, or replanning
- `SV-PLAN` rejects missing planning/readiness fields, incoherent packets, lead-only conversation dependence, hidden local steps, unauthorized dispatch, and unfrozen tool/workspace probing
- `SV-RESULT` states exact verified surface, concise basis, open surfaces, and retained evidence identity when artifacts/logs/screenshots/reports/datasets support the claim
- if final prose outruns the verified surface, reset `SV-RESULT`

Use the reference for detailed gates, evidence calibration, behavior proof, artifact identity, and output detail.

## Step 4: Converge Or HOLD
1. If the challenge changes the plan or result, restart once on the corrected target.
2. If frozen scope or route is invalid, reopen `work-planning`.
3. If the target survives with no material change, it is converged.
4. Maximum three passes; if still not converged, `HOLD`.

Only converged work may proceed as verified.

## Step 5: Output Verified State
Output only the next verified state:
- `SV-PLAN`: `proceed-local`, `open-task-execution`, `clear-blocker`, `reopen-work-planning`, or `HOLD`
- `SV-RESULT`: `verified-result`, `narrow-to-verified-scope`, `INFERENCE/UNVERIFIED`, `reopen-work-planning`, or `HOLD`

User-facing prose reports only the needed verification outcome surface. It never dumps the procedure.
`SV-RESULT` is current only for the exact target, evidence basis, open surfaces, and claim strength verified in this pass. New synthesis, stronger wording, changed acceptance surface, or an analysis/evaluation/synthesis report draft not checked by this pass voids report-preflight; the report must be re-verified or narrowed before it is shown as verified.

## Verification Output Format
Internal handoff only; hold in current-turn context and do not write a continuity file by habit.
`SELF-VERIFICATION:` is the internal verification block label only. Completion-grade lane reports use `SV-RESULT-VERIFY: converged` under `task-execution` completion contract; do not substitute this internal label for the completion field.
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
