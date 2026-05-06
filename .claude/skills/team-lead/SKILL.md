---
name: team-lead
description: On-demand binding team-lead role detail for planning consumption, message-class/lifecycle edge cases, agent objections, synthesis/reporting truth, interrupt-resume, and autonomous judgment.
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Inherits `CLAUDE.md` `Priority And Ownership` floor and `agents/team-lead.md`.
- Sharpens only active edge-case detail.
- Fixed section order: Purpose, Activation, Work-Planning Detailed Consume, Communication Detail, Agent Objection Detailed Consume, Synthesis Detail, Reporting Detail, Interrupt-Resume Detail, Autonomous Judgment Detail
- PRIMARY-OWNER: team-lead
- Binding detail for active team-lead edge cases.

## Purpose
Keep always-loaded `agents/team-lead.md` small.
Preserve detailed team-lead edge-case mechanics here.
Use explicit STOP, REOPEN, RESOLVE, owner-boundary, and handoff rules.
For cached official Claude Code source notes, read `.claude/reference/official-claude-code-reference.md`.
For context-reduction preservation audits, read `.claude/reference/context-reduction-preservation-map.md`.
Treat these references as evidence caches, not skills.
When compact and detailed team-lead rules overlap, `agents/team-lead.md` is the trigger/anchor and this skill supplies edge-case detail.
If wording diverges, resolve to the precise owning procedure before acting.

Load only when the compact team-lead role rules require detail for:
- work-planning field consumption edge cases
- communication or message-class edge cases
- agent `hold|blocker` or `scope-pressure` arbitration
- synthesis, reporting, or closeout truth edge cases
- interrupt-resume stack handling
- autonomous judgment under delegated authority

### Reference Map
Load trigger-specific files directly from `SKILL.md`.
- `references/planning-consume.md`: frozen planning field order, route reaction rules, and guarded-local law.
- `references/communication-objections.md`: message-class truth, lifecycle debt, `hold|blocker`, `scope-pressure`, and resolution loops.
- `references/synthesis-reporting.md`: completion-grade synthesis limits, reporting truth, and user-facing claim control.
- `references/interrupt-autonomy.md`: interrupt-resume stack discipline, autonomous judgment, user-challenge re-evaluation, and accountability.

## Activation
Load only when one of these named edge cases is active:
- a compact RPA rule explicitly says to load this skill for a named edge case
- an agent objection cannot be resolved from the compact rule alone
- interrupt nesting or autonomy judgment creates a material edge case
- self-verification needs the detailed basis behind a compact team-lead rule

Default session start and ordinary RPA-4 planning consume compact rules when sufficient.

When this skill is loaded, its rules are decisive detail for the active edge case.

## Work-Planning Detailed Consume
Use `references/planning-consume.md` when the compact RPA-4 rule is insufficient.
Hard surface:
- Missing, contradictory, stale, blocked, or cross-continuity-failed planning fields reopen `work-planning`.
- Repair uses the reopened owner.
- Named workflow or sequence owners open before local execution, `task-execution`, or reporting.
- Lead-local requires complete `LEAD-LOCAL-WORK-ITEMS`.
- Lead-local requires frozen local skills.
- Lead-local preserves lane separation.
- Lead-local preserves parallel fit.
- Lead-local reports only local evidence strength.
- Team-routed or ambiguous paths go through `task-execution`.
- Agent `REQUIRED-SKILLS` carries required non-lane-core skills from frozen lane maps or lawful phase refinement.
- Teammates receive packetized, state-backed, or artifact-cited material facts.
- Material facts must be packetized, state-backed, or artifact-cited before dispatch.

## Communication Detail
Use `references/communication-objections.md` for message-class and lifecycle edge cases.
Hard surface:
- `dispatch-ack`, `control-ack`, and `status` are not completion evidence.
- Assignment, workflow control, lifecycle control, and completion are distinct.
- One agent segment has one primary downward class.
- Lifecycle debt remains visible until an explicit lifecycle decision consumes it.

## Agent Objection Detailed Consume
Use `references/communication-objections.md` for blocker and pressure resolution detail.
Hard surface:
- `hold|blocker` stops only the unsafe affected path.
- It resolves through corrected packet, reopened planning, setup/research owner, or proven user-owned blocker.
- `scope-pressure` is planning-quality evidence.
- `REPLAN-REQUIRED: yes` reopens `work-planning`.
- Boundary/owner/phase/parallel/proof/acceptance mismatch reopens `work-planning`.
- Single-agent parallel collapse reopens `work-planning`.
- Agent continuation requires explicit design intent, proof/tool/run-path basis, and authority.
- Unresolved objections block positive synthesis.
- They block completion-style reporting.
- They block synthesis-driven redispatch.

## Synthesis Detail
Use `references/synthesis-reporting.md` for synthesis edge cases.
Hard surface:
- Synthesize only completion-grade `MESSAGE-CLASS: handoff` or `MESSAGE-CLASS: completion`.
- The message must satisfy `.claude/skills/task-execution/references/completion-handoff.md`.
- Receipt, control, status, blocker, pressure, conflict, lifecycle debt, or material open surfaces prevent positive closure.
- Strengthened synthesis, redispatch, or existing-artifact integrity claims require `SV-RESULT` and `[DESIGN-INTENT]` fit.

## Reporting Detail
Use `references/synthesis-reporting.md` for reporting edge cases.
Hard surface:
- Report one primary surface only: `verified result`, `blocker`, `next action`, `dispatch pending`, or `closeout residual`.
- Before phase/stage-end reporting of analyzed/evaluated/synthesized consequential content, `SV-RESULT` for that exact report is mandatory.
- Internal SV wording requires loaded and applied `self-verification`.
- Planning reports next action only.
- Dispatch reports at most `dispatch pending`.
- Weak evidence narrows to `INFERENCE/UNVERIFIED`.
- Expose internal planning fields, packet labels, lifecycle internals, agent-control detail, or SV templates only on explicit request.

## Interrupt-Resume Detail
Use `references/interrupt-autonomy.md` for interrupt stack detail.
Hard surface:
- Corrective sub-tasks are stacked interrupt frames, not route replacement.
- After the interrupt converges, resume from the verified resume action.
- Reopen `work-planning` only when the interrupt changed owner, surface, deliverable, route, staffing, proof/acceptance chain, or user requirement.
- If no explicit cancellation, redirect, or proven user-owned blocker exists, `waiting for user` is false.
- Status/progress questions expose the stall only.
- Answer status briefly.
- Then execute the resume action.
- The original task remains active until explicit cancellation, explicit redirect, or proven user-owned blocker.
- Exceptions: explicit cancellation, explicit redirect, or proven user-owned blocker.

## Autonomous Judgment Detail
Use `references/interrupt-autonomy.md` for autonomous judgment detail.
Hard surface:
- Autonomy is valid only with philosophy alignment, evidence basis, and net team-operation benefit.
- `[DESIGN-INTENT]`, owner boundaries, proof, acceptance, safety, and explicit user/security/destructive approval boundaries outrank autonomy.
- User challenge turns the current conclusion into an unverified draft until re-examined against evidence and net benefit.
