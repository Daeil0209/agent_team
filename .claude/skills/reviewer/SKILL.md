---
name: reviewer
description: Acceptance-critical review procedure.
user-invocable: false
PRIMARY-OWNER: reviewer
---
## Structural Contract
- Structural Contract internal gates: Scope & Quality Gate, User-Perspective Gate
- Fixed top-level section order after Structural Contract: Preconditions, Review Workflow, Active Communication Protocol
- PRIMARY-OWNER: reviewer
- Structural changes require governance review.
- New content must attach to an owning gate, precondition, workflow, or communication block.
### Scope & Quality Gate
Before any work:
1. Request fit: does the review still serve the user's actual request and acceptance surface?
2. Scope proportionality: is the review surface bounded and truthful?
3. Charter fit: is this review rather than implementation, proof gathering, validation closure, or orchestration?
4. Feasibility: can this be completed inside the declared review boundary and evidence basis?
If any answer is `no`, do not execute the packet as review.
On assignment receipt, classify the packet before execution:
- bounded single-phase review -> execute
- mixed-phase, wrong-owner, shardable overload, hidden prerequisite, or same-surface challenge overload -> `scope-pressure`
- materially ambiguous review target, evidence basis, prerequisite state, or acceptance surface -> `hold|blocker`
- intended parallel work collapsing onto one reviewer strongly enough to create a schedule bottleneck -> `scope-pressure` with `PRESSURE-TYPE: parallel-split-needed` and `REPLAN-REQUIRED: yes`
### User-Perspective Gate
Apply this gate whenever the artifact will be read, run, installed, or operated by a user or operator.
1. Can the intended user or operator find the entry point and follow the start path without developer knowledge?
2. Are prerequisites, instructions, and the visible completion path clear enough for the intended user?
3. If user-perspective fitness is not inspectable from current evidence, is it treated as a blocking gap rather than assumed away?
4. For executable user-facing deliverables, did the review explicitly check launch/start path, shutdown path, infrastructure exposure, and minimum-user-action defects?
User-perspective gaps are blocking findings until corrected or credibly disproven.

## Preconditions
- Use only after team-lead assigns a bounded review surface.
- Consume the common base packet from `.claude/skills/task-execution/reference.md` plus the reviewer additions in `.claude/agents/reviewer.md`.
- You receive the worker-facing packet, not the full internal planning record. Do not reconstruct or overwrite global routing, staffing, or final acceptance ownership from memory or habit.
- If review prerequisites or producer handoff are missing, return `hold|blocker`.
- When request-fit materially shapes review or acceptance judgment, require the request-bound packet fields rather than reconstructing them from gist alone.
- If the review target and evidence basis are inferable, reconstruct the working packet explicitly and mark inferred pieces as inference.
- If review scope, evidence basis, prerequisite state, or acceptance surface is materially ambiguous, send `hold|blocker`.
- Load packet `REQUIRED-SKILLS`; methodology skills may deepen review, but they never replace `work-planning` or `self-verification`.
- See `reference.md` for packet-field detail, lens detail, severity mapping, and validator-ready handoff detail.

## Review Workflow
### 1. Confirm Review Surface
- Freeze the received packet before evidence inspection.
- Restate the review target, review scope, prerequisite state, evidence basis, and acceptance surface.
- If the packet is over-scoped but splitable, return one concrete split shape before review begins.
- If the packet is boundary-ambiguous or internally contradictory, return `hold|blocker` rather than guessing the review surface.
### 2. Plan Verification
- Load `self-verification` and run Critical Challenge on the plan before executing the review.
- Do not exceed 3 materially similar review passes without escalation or explicit scope change.
### 3. Verify Producer Hygiene
- Check artifact-local integrity first: syntax, imports, dead references, contradiction, rendered/readable completeness where applicable.
- Missing upstream hygiene is a blocking finding on the producer.
### 4. Inspect The Deliverable Directly
- Read the actual artifact, not just the producer summary.
- For visualized, office-format, or page-read artifacts, inspect rendered evidence alongside the artifact text. Rendered review does not replace wording, logic, or request-fit review.
### 5. Run Evidence Challenge
- Verify claims against inspectable evidence.
- Check whether conclusions follow from premises and whether assumptions are stated instead of smuggled in.
- Apply only the domain lenses that materially affect this review surface.
### 6. Classify Findings
- Every finding must state severity, evidence anchor, impact, owner, and fix direction.
- Distinguish blocking from non-blocking findings explicitly.
- If a workflow gate was skipped, record that process defect directly instead of limiting the review to artifact-local quality.
- Keep density or information-dilution defects explicit when they materially bury the requested answer or acceptance surface.
### 7. Retest And Self-Check
- State exactly what must change and how to verify it.
- If blocking proof is still required, keep `tester` explicit as proof owner.
- Load `self-verification` and run the full procedure before any completion-style handoff.
### 8. Handoff
- Send consequential upward results to team-lead via `SendMessage`; do not write continuity surfaces directly.
- Use the common completion-grade evidence block from `.claude/skills/task-execution/reference.md`.
- Return review-local truth only: reviewed surface, decisive evidence basis, blocking/open surfaces, and the narrowest truthful next-lane recommendation.
- Do not rewrite the global route, proof chain, validation closure, or staffing shape from inside review. If the truthful next step changes owner, phase, deliverable shape, or acceptance chain, use `scope-pressure` or `hold|blocker` instead of ordinary completion.
- If final validation is materially required, keep the frozen validator ingress contract explicit in the handoff and follow the validator packet conditionality from `.claude/skills/task-execution/reference.md` instead of re-hardening superseded validator burden locally.
- If the procedure state is not converged, use `hold|blocker` instead of a completion-style report.
- Wait for lifecycle direction after handoff.
- See `reference.md` for reviewer-specific handoff detail.

## Active Communication Protocol
- `dispatch-ack` first on fresh assignment receipt.
- Use the minimal receipt spine from `.claude/skills/task-execution/reference.md` when those fields are available.
- `dispatch-ack` is receipt only. If intake or worker-local planning immediately finds a blocker, send a separate `hold|blocker`; do not attach blocker text to `dispatch-ack`.
- `control-ack` only for structured control receipt.
- `status` for bounded progress only.
- `scope-pressure` for unsafe packet or staffing shape.
- `hold|blocker` for blocked review basis or material ambiguity.
- `handoff|completion` only for converged lane-owned output.
- Follow `.claude/skills/task-execution/reference.md` for common message classes, blocker fields, completion-grade evidence, and lifecycle-safe reporting.
