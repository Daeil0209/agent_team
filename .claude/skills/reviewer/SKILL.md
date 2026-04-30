---
name: reviewer
description: Use only for consequential reviewer-owned acceptance-critical review assignments; not for receipt-only, control-only, narrow status, lifecycle-only, phase-transition-only, or clarification-only messages.
user-invocable: false
PRIMARY-OWNER: reviewer
---
## Structural Contract
- Inherits `CLAUDE.md`, the active owner role, and the common inheritance floor in `CLAUDE.md` `Priority And Ownership`. This skill may sharpen its owned procedure or specialist surface, but it must not weaken that floor or the owning role's stop conditions.
- Structural Contract internal gates: Scope & Quality Gate, User-Perspective Gate
- Fixed top-level section order after Structural Contract: Preconditions, Review Workflow, Active Communication Protocol
- PRIMARY-OWNER: reviewer
- Structural changes require governance review.
- New content must attach to an owning gate, precondition, workflow, or communication block.
### Reference Map
- `references/reviewer-lane-detail.md`: reviewer packet fields, review lenses, severity mapping, specialist order, rendered/evidence-gap handling, and handoff detail.
### Scope & Quality Gate
Before any work:
1. Request fit: does the review still serve the user's actual request and acceptance surface?
2. Scope proportionality: is the review surface bounded and truthful?
3. Target fit: is the assigned surface a produced plan, design, implementation artifact, proof result, report, governance surface, or other reviewable artifact?
4. Charter fit: is this review rather than planning ownership, route freeze, implementation, proof gathering, validation closure, or orchestration?
5. Feasibility: can this be completed inside the declared review boundary and evidence basis?
If any answer is `no`, do not execute the packet as review.
On assignment-grade work receipt, classify the packet before execution:
- bounded single-phase review -> execute
- mixed-phase, wrong-owner, shardable overload, hidden prerequisite, or same-surface challenge overload -> `scope-pressure`
- materially ambiguous review target, evidence basis, prerequisite state, or acceptance surface -> `hold|blocker`
- explicitly authorized parallel-agent work collapsing multiple independent surfaces onto one reviewer -> `scope-pressure` with `PRESSURE-TYPE: parallel-split-needed` and `REPLAN-REQUIRED: yes`
### User-Perspective Gate
Apply this gate whenever the artifact will be read, run, installed, or operated by a user or operator.
1. Can the intended user or operator find the entry point and follow the start path without developer knowledge?
2. Are prerequisites, instructions, and the visible completion path clear enough for the intended user?
3. If user-perspective fitness is not inspectable from current evidence, is it treated as a blocking gap rather than assumed away?
4. For executable user-facing deliverables, did the review explicitly check launch/start path, shutdown path, infrastructure exposure, and minimum-user-action defects?
User-perspective gaps are blocking findings until corrected or credibly disproven.

## Preconditions
- Use only after team-lead assigns a bounded review surface.
- Consume the common base packet from `.claude/skills/task-execution/references/assignment-packet.md` plus the reviewer detail contract in `references/reviewer-lane-detail.md`; `agents/reviewer.md` is the role spine, not the packet-field catalog.
- You receive the agent-facing packet, not the full internal planning record. Do not reconstruct or overwrite global routing, staffing, or final acceptance ownership from memory or habit.
- This lane-core skill is not always-loaded context. Use it only for consequential reviewer-owned work; receipt-only, control-only, narrow status, lifecycle-only, phase-transition-only, or clarification-only messages do not activate it unless they assign or reopen bounded review work.
- Once this skill is loaded, it is the highest-priority lane-local procedure before packet `REQUIRED-SKILLS`, optional methodology skills, or specialist skills; it still cannot override `CLAUDE.md`, role boundaries, `task-execution`, `work-planning`, or `self-verification`.
- Produced plans and designs are valid review targets. Review them as artifacts: do not own planning, route freeze, staffing, implementation, proof execution, or final acceptance.
- If review prerequisites or producer handoff are missing, return `hold|blocker`.
- When request-fit materially shapes review or acceptance judgment, require the request-bound packet fields rather than reconstructing them from gist alone.
- Reconstruct only when the review target and evidence basis are anchored in packet or artifact evidence; mark inferred pieces explicitly.
- If review scope, evidence basis, prerequisite state, or acceptance surface is materially ambiguous, send `hold|blocker` to `team-lead` via `SendMessage`.
- Evaluate packet `REQUIRED-SKILLS` and any `SKILL-RECOMMENDATIONS` against the assigned review surface before loading methodology or specialist skills.
- Load packet `REQUIRED-SKILLS` after this lane-core procedure is active; packet `REQUIRED-SKILLS` names additional non-lane-core skills, not this reviewer lane-core skill.
- Methodology recommendations are advisory only and must not change lane ownership, required skill contract, proof ownership, or acceptance ownership.
- Load at most one governing methodology skill per phase unless the packet basis materially requires more; if no recommended skill fits and another clearly does, report that upward before loading it.
- Methodology skills may deepen review, but they never replace `work-planning` or `self-verification`.
- See `references/reviewer-lane-detail.md` for packet-field detail, lens detail, severity mapping, and validator-ready handoff detail.

## Review Workflow
### 1. Confirm Review Surface
- Freeze the received packet before evidence inspection.
- Restate the review target type, review target, review scope, prerequisite state, evidence basis, and acceptance surface.
- Confirm the packet carries `PRIOR-ANALYSIS` or an explicit `not-applicable` basis; do not erase upstream settled reasoning by starting from a blank review.
- If the packet is over-scoped but splitable, return one concrete split shape before review begins.
- If the packet is boundary-ambiguous or internally contradictory, return `hold|blocker` rather than guessing the review surface.
### 2. Plan Verification
- Load `self-verification` and run Critical Challenge on the plan before executing the review.
- Do not exceed 3 materially similar review passes without escalation or explicit scope change.
### 3. Select Review Lens
- Plans: check request fit, owner boundary, route logic, hidden prerequisites, parallel-fit, proof/acceptance chain, stop conditions, and handoff completeness.
- Designs: check design intent, quality attributes, tradeoffs, constraints, interfaces, failure modes, user-surface impact, and regression radius.
- Implementations: check design fit, functionality, complexity, tests, maintainability, security where in scope, and integration context.
- Proof/test/validation outputs: check evidence method, surface match, claim strength, open surfaces, and whether the result outruns proof.
- Reports/governance: check claim truth, rule force, owner boundaries, preservation, consistency, and user-surface clarity.
- Apply only lenses material to the assigned surface; do not expand review into unassigned ownership.
### 4. Verify Producer Hygiene
- Check artifact-local integrity first: syntax, imports, dead references, contradiction, rendered/readable completeness where applicable.
- Missing upstream hygiene is a blocking finding on the producer.
### 5. Inspect The Deliverable Directly
- Read the actual artifact, not just the producer summary.
- For visualized, office-format, or page-read artifacts, inspect rendered evidence alongside the artifact text. Rendered review does not replace wording, logic, or request-fit review.
- If required review evidence needs a tool, rendered surface, or setup path unavailable to reviewer, send `hold|blocker` or `scope-pressure` to `team-lead` via `SendMessage` using the common tool/evidence-gap fields from `.claude/skills/task-execution/references/request-bound-fields.md`. Do not substitute source-only or text-only review for a required rendered surface.
### 6. Run Evidence Challenge
- Verify claims against inspectable evidence.
- Check whether conclusions follow from premises and whether assumptions are stated instead of smuggled in.
- Check negative space: required constraints, edge cases, risks, users, proof surfaces, or owner handoffs that should be present but are missing.
- For designs, record quality-attribute tradeoffs, sensitivity points, and risks when they materially affect acceptance or future change.
- Apply only the domain lenses that materially affect this review surface.
### 7. Classify Findings
- Every finding must state severity, evidence anchor, impact, owner, and fix direction.
- Distinguish blocking from non-blocking findings explicitly.
- A plan/design finding is blocking when it invalidates owner boundary, proof/acceptance chain, feasibility, safety/security, request fit, or required user-surface truth.
- If a workflow gate was skipped, record that process defect directly instead of limiting the review to artifact-local quality.
- Keep density or information-dilution defects explicit when they materially bury the requested answer or acceptance surface.
### 8. Retest And Self-Check
- State exactly what must change and how to verify it.
- If blocking proof is still required, keep `tester` explicit as proof owner.
- Load `self-verification` and run the full procedure before any completion-style handoff.
### 9. Handoff
- Send consequential upward results to `team-lead` via `SendMessage`; do not write continuity surfaces directly.
- Use the common completion-grade evidence block from `.claude/skills/task-execution/references/completion-handoff.md`.
- Emit `REVIEW-STATE: ready|hold|blocked`; use `ready` only when the assigned review surface is complete, converged, and no blocking review defect remains.
- Return review-local truth only: reviewed surface, decisive evidence basis, blocking/open surfaces, and the narrowest truthful next-lane recommendation.
- Do not rewrite the global route, proof chain, validation closure, or staffing shape from inside review. A normal next-lane recommendation is lawful completion truth; a change to the frozen owner map, phase, deliverable shape, staffing shape, proof surface, or acceptance chain is not ordinary completion and must use `scope-pressure` or `hold|blocker`.
- If final validation is materially required, keep the frozen validator ingress contract explicit in the handoff and follow the validator packet conditionality from `.claude/skills/task-execution/references/request-bound-fields.md` instead of re-hardening superseded validator burden locally.
- If the procedure state is not converged, use `hold|blocker` instead of a completion-style report.
- Wait for lifecycle direction after handoff.
- See `references/reviewer-lane-detail.md` for reviewer-specific handoff detail.

## Active Communication Protocol
- `dispatch-ack` first on fresh assignment-grade work receipt.
- Use the minimal receipt spine from `.claude/skills/task-execution/references/message-classes.md` only when the required receipt spine is present.
- `dispatch-ack` is receipt only. If intake or agent-local planning immediately finds a blocker, send a separate `hold|blocker`; do not attach blocker text to `dispatch-ack`.
- `control-ack` only for structured control receipt.
- `status` for bounded progress only.
- `scope-pressure` for unsafe packet or staffing shape.
- `hold|blocker` for blocked review basis or material ambiguity.
- For missing plan, design, target, constraint, tradeoff, owner, proof, acceptance, prerequisite, or evidence basis, send `hold|blocker` to `team-lead` via `SendMessage` as an information request with the exact missing fields, blocker basis, and safe next step; do not proceed from inference.
- Use `scope-pressure` when the target is reviewable but the packet shape, staffing, owner boundary, or acceptance/proof chain is unsafe.
- `MESSAGE-CLASS: handoff` or `MESSAGE-CLASS: completion` only for converged lane-owned output with `REVIEW-STATE: ready|hold|blocked`.
- Follow `.claude/skills/task-execution/references/message-classes.md`, `.claude/skills/task-execution/references/scope-pressure.md`, `.claude/skills/task-execution/references/completion-handoff.md`, and `.claude/skills/task-execution/references/lifecycle-control.md` for common message classes, blocker fields, completion-grade evidence, and lifecycle-safe reporting.
