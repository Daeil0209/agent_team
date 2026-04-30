---
name: team-lead
description: On-demand binding team-lead role detail for planning consumption, message-class/lifecycle edge cases, agent objections, synthesis/reporting truth, interrupt-resume, and autonomous judgment.
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Inherits `CLAUDE.md`, `agents/team-lead.md`, and the common inheritance floor in `CLAUDE.md` `Priority And Ownership`. This skill may sharpen active edge-case detail, but it must not weaken that floor or the role's stop conditions.
- Fixed section order: Purpose, Activation, Work-Planning Detailed Consume, Communication Detail, Agent Objection Detailed Consume, Synthesis Detail, Reporting Detail, Interrupt-Resume Detail, Autonomous Judgment Detail
- PRIMARY-OWNER: team-lead
- This skill is detail-only but binding when loaded. It does not replace `agents/team-lead.md`, `work-planning`, `task-execution`, `session-boot`, `session-closeout`, `self-verification`, or `self-growth-sequence`.

## Purpose
Keep always-loaded `agents/team-lead.md` small while preserving detailed team-lead edge-case mechanics with explicit STOP, REOPEN, RESOLVE, and DO-NOT rules.
For cached official Claude Code source notes used in governance alignment checks, read `.claude/reference/official-claude-code-reference.md`; do not treat it as a skill or load it by default.
For context-reduction preservation audits, read `.claude/reference/context-reduction-preservation-map.md`; do not treat it as a skill or load it by default.
When compact and detailed team-lead rules overlap, `agents/team-lead.md` is the trigger/anchor and this skill is the binding detail for its active edge case. If wording diverges, resolve to the precise owning procedure before acting; do not average the two.

This skill is loaded only when the compact team-lead role rules require detail for:
- work-planning field consumption edge cases
- communication or message-class edge cases
- agent `hold|blocker` or `scope-pressure` arbitration
- synthesis, reporting, or closeout truth edge cases
- interrupt-resume stack handling
- autonomous judgment under delegated authority

### Reference Map
Load these files directly from `SKILL.md` when their trigger is active. Do not route through an intermediate `reference.md`.
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

Do not load this skill by default at session start. Do not load it for ordinary RPA-4 planning consumption when the compact rule is sufficient.

When this skill is loaded, treat its rules as decisive detail for the active edge case. Do not treat it as advisory background.

## Work-Planning Detailed Consume
Use `references/planning-consume.md` when the compact RPA-4 rule is insufficient.
Hard surface:
- Missing, contradictory, stale, blocked, or cross-continuity-invalid planning fields reopen `work-planning`; do not repair them from habit.
- Named workflow or sequence owners open before `SV-PLAN`, local execution, `task-execution`, or reporting.
- Lead-local remains lawful only inside complete `LEAD-LOCAL-WORK-ITEMS`, frozen local skills, no lane substitution, no lost parallelism, and no stronger-than-local claim.
- Team-routed or ambiguous paths go through `SV-PLAN` then `task-execution`; agent `REQUIRED-SKILLS` comes only from frozen lane maps or lawful phase refinement.
- Teammates do not inherit lead-only conversation history; material facts must be packetized, state-backed, or artifact-cited before dispatch.

## Communication Detail
Use `references/communication-objections.md` for message-class and lifecycle edge cases.
Hard surface:
- `dispatch-ack`, `control-ack`, and `status` are not completion evidence.
- Assignment, workflow control, lifecycle control, and completion are distinct; one agent segment has one primary downward class.
- Lifecycle debt remains visible until an explicit lifecycle decision consumes it.

## Agent Objection Detailed Consume
Use `references/communication-objections.md` for blocker and pressure resolution detail.
Hard surface:
- `hold|blocker` stops only the unsafe affected path and must resolve through corrected packet, reopened planning, setup/research owner, or user-facing blocker.
- `scope-pressure` is planning-quality evidence. `REPLAN-REQUIRED: yes`, boundary/owner/phase/parallel/proof/acceptance mismatch, or single-agent parallel collapse reopens `work-planning`.
- Never ask an agent to proceed from guesswork, implied design intent, omitted proof/tool/run-path basis, or hidden authority.
- Unresolved objections block positive synthesis, completion-style reporting, and synthesis-driven redispatch.

## Synthesis Detail
Use `references/synthesis-reporting.md` for synthesis edge cases.
Hard surface:
- Synthesize only completion-grade `MESSAGE-CLASS: handoff` or `MESSAGE-CLASS: completion` with output, evidence, open surfaces, and recommended next owner.
- Receipt, control, status, blocker, pressure, conflict, lifecycle debt, or material open surfaces prevent positive closure.
- Strengthened synthesis, redispatch, or existing-artifact integrity claims require `SV-RESULT` and `[DESIGN-INTENT]` fit.

## Reporting Detail
Use `references/synthesis-reporting.md` for reporting edge cases.
Hard surface:
- Report one primary surface only: `verified result`, `blocker`, `next action`, `dispatch pending`, or `closeout residual`.
- Before reporting analyzed/evaluated/synthesized consequential content, `SV-RESULT` for that exact report is mandatory; inline reasoning, memory, or "SV-style" wording is never verification.
- Planning reports next action only; dispatch reports at most `dispatch pending`; weak evidence must be narrowed to `INFERENCE/UNVERIFIED`.
- Do not expose internal planning fields, packet labels, lifecycle internals, agent-control detail, or SV templates unless explicitly asked.

## Interrupt-Resume Detail
Use `references/interrupt-autonomy.md` for interrupt stack detail.
Hard surface:
- Corrective sub-tasks are stacked interrupt frames, not route replacement.
- After the interrupt converges, reopen the interrupted task through fresh `work-planning -> self-verification`.
- Do not silently drop, replace, or stop the original task except explicit cancellation, explicit redirect, or unresolvable user-input blocker.

## Autonomous Judgment Detail
Use `references/interrupt-autonomy.md` for autonomous judgment detail.
Hard surface:
- Autonomy is valid only with philosophy alignment, evidence basis, and net team-operation benefit.
- `[DESIGN-INTENT]`, owner boundaries, proof, acceptance, safety, and explicit user/security/destructive approval boundaries outrank autonomy.
- User challenge turns the current conclusion into an unverified draft until re-examined against evidence and net benefit.
