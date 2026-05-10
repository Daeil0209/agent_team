---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/team-session-sequences/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
REFERENCE-OWNER: team-session-sequences
LOAD-POLICY: on-demand reference only
---

# team-session-sequences: Monitoring Lifecycle Detail

## Runtime Signals
- `idle_notification`: automatic runtime message indicating an agent's turn has ended. This is a technical signal, not a state transition. The agent remains `ACTIVE` until the governing lane makes an explicit lifecycle decision.
- Receiving `idle_notification` without a preceding completion report from the agent is a handoff failure (T2).
- Receiving a completion report without canonical `REQUESTED-LIFECYCLE` is a lifecycle-request defect (T3).

## Agent Identity Rule
- If multiple agents of the same capability may exist concurrently, assign unique agent names at dispatch time.
- Standby, shutdown, stale tracking, and reuse decisions must refer to those concrete agent names rather than to the generic capability label alone.

## Supervisor Decisions On idle_notification
When an idle_notification is received with a valid completion report, the governing lane must choose:
- `Reuse`: more work is immediately available and preserved context is still valuable.
- `Standby Approve`: no immediate work, but near-future reuse is plausible. Send explicit lifecycle-control (`MESSAGE-CLASS: lifecycle-control`, `LIFECYCLE-DECISION: standby`) to the concrete agent name; helper or hook state only reflects that approved decision.
- `Shutdown`: agent is no longer needed, wrong, harmful, stuck, or must be terminated. Send `SendMessage(to: "<agent-name>", message: {type: "shutdown_request"})` and wait for `shutdown_response` or teammate termination evidence.
- `Hold for validation`: final verdict is pending. Reserve the agent with no new assignment until validation resolves.

## Message-First Lifecycle Rule
- Agent lifecycle control is message-first: completion, reuse, and standby approval travel through explicit internal messages; shutdown intent is normalized to structured `shutdown_request` rather than inferred from hook feedback or free text.
- Failed shutdown is a recovery surface owned by `session-closeout` or explicit runtime recovery. Hooks do not create shutdown authority.
- Treat `TeammateIdle`, ledgers, and health-check output as observation surfaces that inform the next lifecycle message, not authority to skip it.
- Completion is an upward report requesting a governing decision; it does not authorize auto-standby, replacement, or teammate removal.
- Consequential completion handoff must carry `REQUESTED-LIFECYCLE: standby|shutdown|hold-for-validation`; this is an agent request, not lifecycle authority.
- Governing lane owns lifecycle transitions: dispatch or approved `assignment|reuse` -> `ACTIVE`; explicit `standby` approval -> `STANDBY`; confirmed shutdown/removal -> removed from teammate population.
- Until the governing lane answers with `standby`, `reuse`, `shutdown`, or `hold-for-validation`, the agent is lifecycle-decision pending and remains `ACTIVE`.
- Do not ignore an agent lifecycle request without reason. Brief hold is valid only while immediate reuse is being prepared.
- `assignment` activates bounded work. `reuse` reactivates a standby agent or reassigns work to an active agent awaiting lifecycle decision on the same preserved topic/context. Neither creates a new teammate by itself.
- Teammate population changes only on agent creation and confirmed shutdown/removal. `standby` and `reuse` are state transitions, not teammate-count changes.
- Hook feedback may record or guard a lifecycle edge, but it does not create authority to infer session end or agent shutdown.
- Runtime task lists, mailbox state, and team config are Claude Code runtime surfaces. Do not hand-author or repair them through project documents or shell edits.
- An agent-targeted `shutdown_request` is agent lifecycle cleanup, not evidence that the whole session is entering `Closeout Sequence`.
- If a stale current-runtime agent must be replaced outside closeout, send `shutdown_request`, wait for shutdown evidence or classify recovery explicitly, then dispatch the replacement. Do not skip directly to replacement unless the agent is confirmed terminated or the replacement route has been frozen as recovery.
- Previous-session remembered agents are continuity artifacts, not runtime shutdown targets in a later session.

## Reuse Rule
- New dispatch rebuilds context.
- Reusing or keeping a suitable agent on standby is preferred when it preserves correct ownership and execution continuity.
- Reuse is preferred when workload, availability, context fit, and ownership safety all support it.

## Manifest Review Gate
- When execution depends on a user-provided file list, copy set, or overwrite manifest, complete review before fan-out: collapse duplicates, verify final unique write set, and make pre-execution review explicit.
- Current standard packet fields use exact English keys:
  - `TASK-CLASS: manifest-sync`
  - `MANIFEST-UNIQUE: <count>`
  - `OVERLAP-REVIEW: done`
  - `PRE-EXEC-REVIEW: done`
  - `WRITE-SCOPE: <unique target set>`
  - if sharded: `SHARD-ID: <id>` and `SHARD-SET: disjoint`
- Deterministic manifest sync or overwrite propagation is single-writer by default.
- Shard only when each shard's write scope is explicit and disjoint before the first developer dispatch.

## Task Identity And Communication
- Task-scoped tools such as `TaskGet`, `TaskUpdate`, `TaskOutput`, and `TaskStop` take the task id from the explicit `task_assignment` packet.
- Agent names and `agentId@team` values are agent identifiers only.
- Agent-scoped communication uses `SendMessage(to: "<exact-live-member-name>")` for agent control.
- Keep agent identifiers separate from task identifiers.
- A configured role label becomes a message address only when the roster contains that exact live member name.
- Treat direct user-to-teammate messages as user instructions to the receiving teammate inside that teammate's current authority and active surface.
- Treat agent-to-agent communication as challenger traffic for evidence notes, critique, clarification, or partial-result context.
- Route ownership, acceptance, routing, lifecycle, task-control, and active-surface changes from direct user-to-teammate or agent-to-agent traffic through `team-lead`.
- Use free-form `SendMessage` for status, acknowledgment, clarification, or partial-result notes inside unchanged ownership, lifecycle, routing, and active surface.
- Authoritative downward control packets, upward report `MESSAGE-CLASS` vocabulary, and structured lifecycle paths are owned by `.claude/skills/task-execution/references/phase-transition-control.md`, `.claude/skills/task-execution/references/lifecycle-control.md`, and `.claude/skills/task-execution/references/message-classes.md`.
- If task output must be read later, carry the assigned task id forward explicitly instead of reconstructing it from the agent name by guesswork.

## Health-Check Standard
- For explicit team-runtime sessions, recurring health monitoring runs at the cadence configured in `hook-config.sh` only when a tracked health-check cron is actually active.
- The configured cron cadence and stale thresholds are defined in `hook-config.sh`; treat that file as the single literal owner.
- Direct oversight, event-driven agent monitoring, and memory-pressure checks remain the primary lead-owned monitoring path even when no tracked health-check cron is active.
- In single-primary automation mode, keep the watchdog armed during standby periods. Do not pause the health-check cron merely because all agents are standby.
- Replacing the tracked health-check cron is not session closeout. For monitor rotation, record explicit rotation intent in structured runtime state first, then perform `CronDelete` and replacement `CronCreate`.
- If no tracked health-check cron is active, do not create, rotate, or narrate one by ceremony.

## Stale Response
- High-confidence stale: investigate quickly. Replacement requires shutdown evidence or an explicit recovery freeze.
- Low-confidence stale during long-running bash: observe, extend if justified, then escalate if the lane remains unproductive.
- Repeated stale or error-loop behavior requires reroute, resize, replacement, or re-plan.
- Treat stale signals and idle_notification as observational only. Do not assert a specific tool-phase hang or team-infrastructure defect unless ledger evidence, dispatch behavior, runtime-pressure evidence, or explicit tool errors support it.
- Repo-local generated-output cleanup may use bounded destructive commands only inside the active repo's approved output root (`./projects/`).

## Runtime Pressure
- In single-primary automation mode, treat non-current `parent-session-id` agent processes as orphan runtime residue rather than valid parallel production sessions.
- When hard runtime pressure or unresolved orphan residue exists, stop new `Agent` fan-out until explicit recovery clears that pressure.
- Routine orphan scans report residue; they do not kill processes or rewrite team lifecycle truth.
- Runtime-pressure handling must not invent session closeout authority or bypass message-first lifecycle decisions for current live agents.
- If orphan historical agents are detected from a previous session, do not send `shutdown_request` to those remembered agent names from the new session. Route explicit orphan-runtime recovery instead.

## Next-Action Drive
- Healthy active lane returns to monitoring.
- Reuse-fit live lane opens bounded reuse.
- Standby decision opens lifecycle control.
- Shutdown decision opens structured `shutdown_request`.
- Stale response opens investigate, wait-extension, reroute, resize, replacement, or replan.
- Manifest overlap opens pre-execution manifest correction.
- Runtime pressure opens explicit recovery before new fan-out.
- Orphan historical residue opens orphan-runtime recovery.
