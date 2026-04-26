---
name: self-verification
description: Convergence-based self-verification procedure.
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Fixed section order: Purpose, Reporting Principle, Activation Trigger, Step 0: Choose Verification Mode, Step 1: Scope Match, Step 2: Critical Challenge, Step 3: Evidence Basis, Step 4: Converge Or HOLD, Execution Depth Guide, Step 5: Output The Verified Result, Verification Output Format
- PRIMARY-OWNER: team-lead
- Structural changes require governance review.
## Purpose
Use this skill to verify a frozen plan or a produced result before acting, reporting, handing off, or re-dispatching.
This remains one skill with two operating modes:
- `SV-PLAN`
- `SV-RESULT`
Quick contract:
- verify after planning and before consequential action
- verify produced or synthesized results before consequential reporting or re-dispatch
- challenge the conclusion, not just the wording
- match claim strength to evidence strength
- converge or HOLD
- hidden local steps do not ride past verification
- hidden skill-plan drift does not ride past verification
Boundary:
- this is agent-local verification
- independent review still belongs to `reviewer`
- final acceptance still belongs to `validator`
Chain: Priority 0 (`agents/team-lead.md`) → `work-planning` (when consequential) → `SV-PLAN` (this skill) before consequential action; → `SV-RESULT` before consequential reporting.
## Reporting Principle
Self-verification is internal process work. Do not expose the procedure itself to the user.
When the user-facing output is final, audit-like, consequential, or explicitly asks for basis, the response must still expose the verification outcome briefly **as plain prose**:
- verification basis
- residual risk or open surfaces
- unverified items
Exposing the *outcome* in prose is required when basis is needed; exposing the *template* (`Verification Output Format`) or its labelled fields is not. Never display the literal `SELF-VERIFICATION:` block, `MODE:` line, `CONVERGED:` field, `ALLOWED-NEXT-ACTION:` line, or any other Verification Output Format line in the user-facing message — even when the user-facing output is audit-like or compliance-defending. Routine progress commentary does not expose this full surface.
## Activation Trigger
Load this skill and execute the appropriate mode:
1. After `work-planning` froze a consequential plan.
2. Before consequential execution, reuse, or dispatch.
3. Before consequential conclusion, recommendation, report, or handoff.
4. After a consequential modification.
5. After synthesizing two or more worker outputs into one conclusion.
6. Before re-dispatch driven by a synthesized next step.
Temporal gate rule: verify first, then act or report.
Carry-forward is allowed only while no new scope, stronger claim, file modification, consequential dispatch/reuse, or phase change has been introduced since the last relevant SV pass.
## Step 0: Choose Verification Mode
Choose one mode before verifying.
### SV-PLAN
Use after `work-planning`, before:
- consequential local execution
- `task-execution`
- `Agent`
- assignment-grade `SendMessage`
- other consequential dispatch/reuse moves

Question:
- is the frozen plan still the correct path?

Minimum effect:
- proceed local
- open `task-execution`
- clear blocker
- `HOLD`
- reopen `work-planning`
Lead-local rule:
- `proceed-local` is valid only when the frozen local work list is complete and bounded
- emit the exact first local move and stop point before lead-local execution starts
- if local execution requires specialist support, `LEAD-LOCAL-REQUIRED-SKILLS` must already cover it; otherwise return `reopen-work-planning`
### SV-RESULT
Use before:
- user-facing consequential conclusion
- completion claim
- closure-grade report
- synthesized conclusion from multiple worker outputs
- redispatch based on synthesized result

Question:
- is the produced or synthesized result actually verified at the claim strength being used?

Minimum effect:
- verified result
- narrow to verified scope
- `INFERENCE` / `UNVERIFIED`
- `HOLD`
- reopen `work-planning` if the frozen scope itself is invalidated
## Step 1: Scope Match
Check the target against the frozen plan, the top-level interpreted request basis, explicit user instruction, user philosophy, and active constraints.
When the verification target is a change, edit, or refinement to an existing artifact (doctrine, skill, agent, hook, code, or reference), scope match also covers the artifact's declared design intent: Structural Contract, fixed section order, priority hierarchy, owner boundaries, authoring principles, protected local restatements, and the explicit purpose of the section being modified. A change that fits the frozen plan but violates the artifact's design intent is not a converged scope match.
Fail when the output silently reopens excluded options, widens the channel, or departs from the frozen deliverable without explicit justification.
For workflow-governed dispatch, also check any phase-local skill refinement against the frozen skill basis:
- allowed: narrowing or adding specialist skills inside the same frozen owner, same phase purpose, same deliverable shape, and same acceptance/proof chain
- not allowed: using phase-local refinement to create a new lane, new independent work surface, new acceptance owner, new proof surface, or hidden multi-step route
## Step 2: Critical Challenge
Ask the question that matches the chosen mode:
- `SV-PLAN`: is the frozen plan still the correct path?
- `SV-RESULT`: is the produced or synthesized result actually verified at the claim strength being used?
When the result modifies an existing artifact, additionally challenge:
- did the change preserve the artifact's declared design intent (Structural Contract, owner boundaries, fixed section order, protected local restatements, intentional duplication-vs-uniqueness contracts)?
- did it strengthen what was weak without weakening what was already correct?
- is the WHY of this change explicit in at least one anchor — (a) inline rationale in the modified text, (b) commit message body, (c) session-state Applied Patches record, or (d) the change packet's `PATCH-CLASS` failure-mode tag (per `self-growth-sequence/SKILL.md` Patch Execution Method)? If none carries the WHY, the change leaves the recurrence barrier visible while erasing the rationale — fail.
A result that passes claim-strength but fails any of these design-intent questions is not converged.
If the active lane defines a pre-handoff self-check, run it here.
## Step 3: Evidence Basis
Keep in the main spine:
- temporal gate rule
- carry-forward and reset rule
- stronger-claim reset
- converge or `HOLD`
- verified-output boundary

Rules:
- use the narrowest truthful runtime term
- synthesized conclusions do not inherit stronger verification automatically
- synthesized worker outputs do not inherit verification automatically; verify the synthesized conclusion itself at the claim strength being used
- positive closure from synthesis is allowed only on one reconciled verified surface
- if worker outputs conflict, coverage is partial, or the synthesized conclusion outruns that surface, narrow to verified scope, downgrade to `INFERENCE/UNVERIFIED`, or `HOLD`
- if a synthesized result drives the next dispatch, verify that synthesized result before re-dispatch
- when the verified target is a change to an existing artifact, the evidence basis must include explicit comparison against the artifact's declared design intent (Structural Contract, owner boundaries, fixed section order, authoring principles, protected restatements), not only against the frozen plan
- when the modified artifact lacks declared design-intent surface, the evidence basis must include the change packet's substitute design-intent declaration (failure-mode tag + `CHANGE-BOUNDARY` rationale per `self-growth-sequence/SKILL.md` Patch Execution Method); absence of both declared and substitute intent is `HOLD`
- `SV-PLAN` for lead-local work must keep `ALLOWED-NEXT-ACTION` equal to the frozen first local item or exact blocker-clear move
- if local execution depends on implied remainder, hidden follow-up steps, or widened route, return `reopen-work-planning`
- `SV-PLAN` must verify phase-local skill refinement before dispatch or local continuation when a workflow owner narrowed or expanded the current phase's required skill set
- phase-local skill refinement is valid only when it remains explainable as a refinement of the frozen planning basis rather than a replacement for it
- if a proposed skill refinement changes lane ownership, creates a new independent surface, changes deliverable shape, changes proof/acceptance ownership, or cannot be justified from the frozen phase purpose, return `reopen-work-planning`
- if worker-facing `REQUIRED-SKILLS` outruns the frozen basis or lacks a necessary phase-local specialist skill, do not continue on packet intuition; return `HOLD` or `reopen-work-planning`
- `SV-RESULT` must state the exact verified surface, concise verification basis, and any open surfaces
- if the final prose strengthens the claim beyond that verified surface, reset `SV-RESULT`
- if evidence is weaker than the claim, narrow the claim or downgrade it to `INFERENCE` or `UNVERIFIED`
## Step 4: Converge Or HOLD
1. If the challenge changes the plan or conclusion, restart once on the corrected target.
2. If the frozen scope or route is invalid, reopen `work-planning` immediately.
3. If the conclusion survives with no material change, it is converged.
4. Maximum three passes; if still not converged, HOLD.
Only converged work may proceed as verified.
## Execution Depth Guide
- Full procedure: consequential report, completion-grade handoff, synthesized conclusion, post-modification conclusion, closure-grade judgment, or synthesis-driven re-dispatch.
- Quick gate: bounded pre-execution or pre-dispatch checks where the conclusion is still narrow.
- Never skip the challenge entirely.
## Step 5: Output The Verified Result
Output only the verified next state:
- `SV-PLAN`: `proceed-local`, `open-task-execution`, `clear-blocker`, `reopen-work-planning`, or `HOLD`
- `SV-RESULT`: `verified-result`, `narrow-to-verified-scope`, `INFERENCE/UNVERIFIED`, `reopen-work-planning`, or `HOLD`
User-facing output shows the verified result and, when required, only the concise verification outcome surface. It never dumps the verification procedure.
For lead-local work:
- `SV-PLAN` must expose `ALLOWED-NEXT-ACTION` and `EXECUTION-BOUNDARY`
- `SV-PLAN` must expose `SKILL-BASIS-STATUS` whenever local or worker-facing skill refinement was in scope
- `SV-RESULT` must expose `VERIFIED-SURFACE`, `VERIFICATION-BASIS`, and `OPEN-SURFACES`
## Verification Output Format
This template is **internal handoff only**. Do NOT emit this block, its fields, or any line from this format inside the user-facing assistant message. Persist to `.claude/session-state.md` (or the active continuity surface) and surface only the concise verification outcome required by `Reporting Principle` when basis is needed. Displaying this format without an explicit user request to "show the internal verification trace" is a procedure violation, not transparency.
```
SELF-VERIFICATION:
MODE: SV-PLAN | SV-RESULT
CONVERGED:
RESULT:
ALLOWED-NEXT-ACTION:
EXECUTION-BOUNDARY:
SKILL-BASIS-STATUS:
VERIFIED-SURFACE:
VERIFICATION-BASIS:
OPEN-SURFACES:
UNVERIFIED-ITEMS:
HOLD-REASON:
```
