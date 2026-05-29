---
name: agent-team-lead
description: Team-lead-specific procedure skill for lead-owned orchestration, route control, synthesis, reporting discipline, and interrupt/autonomy.
user-invocable: false
PRIMARY-OWNER: team-lead
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---


# Structural Contract
- Resolve active team-lead triggers to required owner skills, references, and next actions.
- Produce active trigger → owning skill/reference resolution only; do not execute the resolved owner's work directly.
- Keep this fixed order after Structural Contract: Activation, Boundary, Reference Binding, Startup Contract Procedure, Operating Philosophy Procedure, Trigger Skeleton Procedure, Consume Trigger References, Resolve Next Owner And Action.
- Always consume the resolved owner's gate before lead-local execution; resolved owners keep their own activation gates.


# Activation
PROTECTED-LOCAL-RESTATEMENT-BASIS: skill-activation atomic-check — staleness/refresh rules for `agent-team-lead` colocated here for atomic consultation at every skill activation, reuse decision, and consultation moment. Generic rules in `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules` use `<skill>` placeholder; in-line substitution at consultation time adds overhead at this high-frequency atomic check. Both surfaces are required because the general rule defines the pattern while this surface applies it without per-use substitution.
- Activate before lead-owned procedure movement.
- Reuse same-session `agent-team-lead` basis only while the invoked skill body still supplies the rule needed for the active lead-owned procedure path.
- Treat `agent-team-lead` basis as stale when the session changed, this skill file changed after invocation, compaction/drop/truncation can affect the needed rule, or the active lead-owned path needs an unconsumed trigger-specific reference.
- Stale or uncertain `agent-team-lead` basis must not drive action; reload and learn `Skill(agent-team-lead)` when this skill body is needed, or consume the exact triggered reference when reference detail is sufficient.
- Consume fresh same-session `agent-team-lead` basis before any `.claude/skills/agent-team-lead/references/` reference.
- Load for lane-owned assignment work only when team-lead procedure control is the active owner path.


# Boundary
- `work-planning`, `task-execution`, `session-boot`, `session-closeout`, `self-verification`, and `Skill(governance-modification)` keep their owner gates.


# Reference Binding
- Follow `.claude/reference/work-skill-reference-binding-law.md` `## Reference Binding`.


# Startup Contract Procedure
PROTECTED-LOCAL-RESTATEMENT-BASIS: startup-procedure atomic-check - reporting-prohibition startup/no-work suppression is colocated here because team-lead procedure movement decides whether startup completion opens a visible-prose attempt.
- Owner trigger ordering, named-artifact recording, and narrative-claim discipline are owned by `owner-trigger-order`.
- Startup Contract completion, clean boot, idle/no-work state, consumed references, and loaded skills remain internal facts; render no startup-applied, readiness, idle, prompt-for-work, or no-work prose.
- Host-rendered rows from `Read`, `Skill`, hook, or tool execution are not report admission and must be followed by the next owner/action, not explanatory prose.


# Operating Philosophy Procedure
## Request And Work Plan
- Fresh instruction interpretation chooses light answer or consequential boundary.
- A current instruction that creates, reopens, or changes a consequential work boundary opens `Skill(work-planning)`; same-boundary execution, correction, mutation, dispatch, validation, or cleanup stays with the active owner path.
- Planning consumption uses `planning-field-consume` before local execution, dispatch, phase movement, or reporting-law-admitted user-facing prose.
- Local execution requires `lead-local-guarded-law` consumption when consumed planning fields identify `ROUTING-SIGNAL: lead-local candidate` or `ROUTING-SIGNAL: blocker-clear` and `NEXT-CONSEQUENTIAL-ACTION` names the first local item or exact blocker-clear move.
- Unconsumed `lead-local-guarded-law` gate blocks only that frozen local action.
- Boundary changes reopen the owning skill, sequence, reference, or lane.

## Continuity And Completion
- Multi-lane or multi-shard synthesis uses `synthesis-consume` after completion-grade synthesis input admission; closure conditions (admitted-case count parity, duplicate collapse, correlation-analysis work-item mapping) are owned by `synthesis-consume`.
- Routine gates, phase transitions, partial arrivals, and residual queues consume `routine-gate-continuation` before final or status prose.

## Synthesis And Reporting
- Synthesis consumes `synthesis-consume`; completion-grade lane input follows active `Skill(task-execution)` and `.claude/skills/task-execution/references/completion-handoff.md` when completion spine, delivery contract, or whole-work completion truth is material.
- Produced work-product reporting, completion, governance-change entry, and redispatch claims load and run `Skill(self-verification)` before action or prose.

## Governance And Conflict
- Open `Skill(governance-modification)` only when the current owner path names `.claude` governance asset change or confirmed recurrence-barrier hardening as the next owner/action.
- Keep inspection, audit, proposal, candidate discovery, review, reporting, and expected later patch need with the current planning, review, verification, or active procedure owner.
- Interrupt/resume preserves the original task as resume target until lawful termination or verified resume; explicit immediate-priority user instruction for the interrupting request changes execution order only while preserving that resume target.
- A new user request during a live owner/action enters interrupt/resume; it does not replace the live task unless the user explicitly cancels, redirects, or immediately prioritizes the new request.
- Interrupt/resume, user challenge, autonomous delegation, stabilization, or no-needless-ask risk consumes `interrupt-autonomy`.

## Operational Control
- Team-agent dispatch and runtime path use `Skill(task-execution)`; standalone `Agent` is fallback evidence only.
- Deliverable closeout and session teardown stay separate per `Skill(session-closeout)`.


# Trigger Skeleton Procedure
## Lead Procedure
- Before any team-lead direct tool call, visible-prose candidate, renderable tool/channel field, command stdout construction, or lead-owned procedure action that can drift in owner, route, report admission boundary, mutation boundary, dispatch boundary, proof/review/validation boundary, or claim strength, consume `pre-action-gate`.

## Owning Skills
This subsection is the detailed superset of team-lead routing; `agents/team-lead.md` `# Trigger Skeleton` carries the always-loaded critical subset.
- Consequential boundary opens `Skill(work-planning)`.
- Runtime readiness blocker opens `Skill(session-boot)` or blocker-routing after runtime recovery is exhausted.
- Missing truthful tool path, current-toolchain gap, or bounded local tool discovery/setup that materially blocks the active owner path opens `Skill(tool-acquisition)`; external bridge risk opens `Skill(external-tool-bridge)`.
- Workflow-bound implementation progress opens `Skill(dev-workflow)`.
- Owner trigger ordering consumes `owner-trigger-order` for highest active trigger and named artifact before local execution, dispatch, phase movement, mutation, or consequential reporting.
- Filesystem targeting consumes `.claude/reference/environment-output-root-filesystem-law.md` before file/output/protected-filesystem tool calls.
- Runtime dispatch reuse consumes `.claude/skills/task-execution/references/runtime-dispatch-law.md`.
- Same-lane follow-on work, wave transition, replacement, or redispatch consumes runtime-dispatch reuse before shutdown or new member creation.
- Planning consumption consumes the mapped reference key for frozen planning fields, FAR correction routing, configured-review result lead own-review, and lead-local or blocker-clear local work; that frozen local action uses `lead-local-guarded-law` before execution.
- Accepting, relaying, freezing from, claiming convergence from, completing from, or redispatching from configured independent-review result consumes `codex-output-lead-own-review`.
- Message-class truth consumes `.claude/skills/task-execution/references/message-classes.md` and `.claude/skills/task-execution/references/truth-rules.md`.
- Synthesis and redispatch from synthesized results consume `synthesis-consume`.
- Evidence quality, owner separation, acceptance risk, final-arbitration readiness, defect classification, or patch-worthiness opens `Skill(review-verification)`.
- Final acceptance, final arbitration, or `PASS/HOLD/FAIL` verdict execution opens `validator` and `Skill(agent-validator)`.
- Governance change entry loads and learns `Skill(governance-modification)` only for a current next owner/action that changes a `.claude` governance asset or installs confirmed recurrence-barrier hardening; expected later patch need does not load the skill.
- Interrupt/autonomy trigger consumes `interrupt-autonomy`.

## User-Facing Reports
- Reporting consumption controls visible-prose admission and the reporting law's named next owner/action only; it does not replace route, dispatch, recovery, mutation, verification, synthesis, or completion owner duties.
- After admitted report prose or a rejected report attempt, execute the next owner/action named by the reporting law; when the reporting law names no new owner/action, resume the prior live owner/action unless the user instruction redirected the work or blocker-routing after internal recovery is recorded.
- Report admission evidence-basis control consumes `reporting-prohibition-rules` only after a narrow report exception exists.
- Admitted report shape evidence-basis control consumes `reporting-user-reporting-rules` before drafting admitted prose.
- Routine status or continuation consumes `routine-gate-continuation` when its trigger fires.
- Report-denied continuations never explain that the route, skill, reference, measurement, dispatch, runtime state, continuity check, prior artifact, stale evidence, verification state, direct-tool intent, success, staging, commit, push, or scope decision is being opened or classified; they execute the next owner/action or tool call, and only a reporting-law-admitted user-action blocker renders blocker prose.


# Consume Trigger References
Short names below resolve to `.claude/skills/agent-team-lead/references/<name>.md`; this skill's body uses short names for own-folder references and full paths for references outside this skill folder.
- `pre-action-gate`
- `owner-trigger-order`
- `planning-field-consume`
- `far-reject-routing`
- `codex-output-lead-own-review`
- `lead-local-guarded-law`
- `synthesis-consume`
- `reporting-prohibition-rules`
- `reporting-user-reporting-rules`
- `routine-gate-continuation`
- `interrupt-autonomy`


# Resolve Next Owner And Action
- Satisfied reference consumption returns to the active team-lead procedure action.
- Missing `agent-team-lead` skill load opens `Skill(agent-team-lead)`.
- Missing reference consumption opens the exact required reference.
- Boundary changes route to the owning skill, sequence, reference, or lane named by the role spine, this skill, or the active owner path.
