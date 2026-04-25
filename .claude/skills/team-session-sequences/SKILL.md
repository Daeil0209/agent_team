---
name: team-session-sequences
description: Standard operating sequences for boot, session start, monitoring, and closeout in the Claude team runtime. Use for the main team lead when establishing, running, or closing a team session.
user-invocable: false
---

## Structural Contract

- Fixed owner pattern for future skill growth:
  1. `Sequence Activation Discipline`
  2. named sequence sections
  3. `Required order` / `Required checks` / `Required actions` blocks
  4. sequence-specific constraints, gates, and state rules
- Do not add new top-level lifecycle names without explicit governance review.
- Keep exact sequence names stable when they are already referenced by doctrine, agents, settings, or hooks.
- Expand the owning sequence section rather than appending detached sidecar procedure blocks.
- Structural connectivity is immutable: new session-runtime rules must remain attached to an owning sequence or gate block rather than appearing as free-floating doctrine.

# Team Session Sequences

This skill defines the standard procedural sequences for session-level team operation.

Use the exact lifecycle names defined in `CLAUDE.md`:
- `Boot Sequence` (on-demand: session-boot skill)
- `Session-Start Sequence` (on-demand: session-boot skill)
- `Monitoring Sequence`
- `Closeout Sequence` (on-demand: session-closeout skill)

These procedures are mandatory when the corresponding sequence is materially in play.

## Sequence Activation Discipline

- When a session sequence is materially active, the lead should name that sequence explicitly in control updates rather than leaving the sequence state implicit.
- Keep the current phase, checkpoint, or blocking step visible enough that the next update can be interpreted against the same active sequence.
- Do not silently switch between `Boot Sequence`, `Session-Start Sequence`, `Monitoring Sequence`, and `Closeout Sequence` while the active runtime still depends on one of them.
- Do not compress a defined session procedure into a shorter convenience path. If a stage is optional, that optionality must come from the owning rule rather than from remembered habit.
- When you build a plan, owner map, or sequencing decision, derive it from the loaded doctrine and owner-local procedure files rather than from remembered habit or convenience. If the governing procedure cannot be pointed to cleanly, keep the lane on `HOLD` until the procedure basis is explicit.

## Mode Split

There are two operating cases:

1. Lead-managed session without explicit team runtime
- Use normal lead delegation and monitoring.
- Skip `TeamCreate` and session cron registration when they are not part of the active runtime.

2. Explicit team-runtime session
- Use the full `Boot Sequence`.
- Team lifecycle, `SendMessage`, monitoring rules, and closeout cleanup all apply.
- Recurring health-check registration is conditional on the active runtime policy or tracked runtime configuration; it is not the universal default startup step.

In this global environment, explicit team runtime is the normal startup default. The lead-managed no-runtime case applies only when the operator explicitly requests no-runtime startup or the active runtime policy makes explicit team orchestration unnecessary.

When the current runtime is ambiguous, the lead must resolve that ambiguity before production fan-out.


## Boot Sequence

> On-demand: see `session-boot` skill. Loaded at session start via hook trigger.

## Session-Start Sequence

> On-demand: see `session-boot` skill. Loaded at session start via hook trigger.

## Monitoring Sequence

The `Monitoring Sequence` general procedure (responsibilities, lane health, runtime-pressure handling, workflow integration) is owned by `session-boot/SKILL.md` § Monitoring Sequence. The canonical worker lifecycle vocabulary (5 states) is owned by `session-boot/reference.md` § Worker Lifecycle States. The subsections below cover lead-side monitoring decisions and lifecycle-message protocol that are not duplicated elsewhere.

### Runtime signals (not governance states)

- `idle_notification`: automatic runtime message indicating a worker's turn has ended. This is a technical signal, not a state transition. The worker remains `ACTIVE` until the governing lane makes an explicit lifecycle decision.
- Receiving `idle_notification` without a preceding completion report from the worker is a **handoff failure** (T2).
- Receiving a completion report without `REQUESTED-LIFECYCLE: standby` is a **standby non-entry defect** (T3).

### Worker identity rule

- If multiple workers of the same capability may exist concurrently, assign unique worker names at dispatch time.
- Standby, shutdown, stale tracking, and reuse decisions must refer to those concrete worker names rather than to the generic capability label alone.

### Supervisor decisions on idle_notification

When an idle_notification is received with a valid completion report, the governing lane must make one of these decisions:

- `Reuse`: more work is immediately available and preserved context is still valuable
- `Standby Approve`: no immediate work, but near-future reuse is plausible. Current standard control path is an explicit governing-lane lifecycle-control message (`MESSAGE-CLASS: lifecycle-control` with `LIFECYCLE-DECISION: standby`, per `.claude/skills/task-execution/reference.md`) to the concrete worker name; any helper or hook state update exists only to reflect that approved decision, not to replace it.
- `Force Stop`: worker is no longer needed, wrong, harmful, stuck, or must be terminated immediately. Shutdown sequence: first send `SendMessage(to: "<worker-name>", message: {type: "shutdown_request"})` and wait for acknowledgment. If the worker is unresponsive, then use `bash "$HOME/.claude/hooks/mark-force-stop.sh" "<worker-name>"` as emergency fallback. Skipping `shutdown_request` leaves ghost entries in Claude Code's internal tracking.

### Message-first lifecycle rule

- Worker lifecycle control is message-first: completion, reuse, standby approval, and shutdown decisions travel through explicit internal messages rather than through hook-feedback inference. `force-stop` remains the emergency runtime fallback when explicit shutdown cannot complete cleanly.
- Treat `TeammateIdle`, ledgers, and health-check output as observation surfaces that inform the next lifecycle message, not as authority to skip that message.
- Completion is an upward report requesting a governing decision; it does not by itself authorize auto-standby, replacement, or teammate removal.
- Consequential completion handoff should carry `REQUESTED-LIFECYCLE: standby|shutdown`. This is a worker request, not lifecycle authority.
- The governing lane owns the lifecycle transitions: dispatch or approved `assignment|reuse` moves a live worker to `ACTIVE`; turn completion without a further governing decision leaves the worker in ACTIVE state awaiting the governing lane's explicit lifecycle decision; explicit `standby` approval moves the worker to `STANDBY`; confirmed shutdown/removal removes the worker from teammate population.
- Until the governing lane answers with `standby`, `reuse`, or `shutdown`, the worker remains `ACTIVE`.
- Do not ignore a worker lifecycle request without reason. Brief hold is valid only while immediate reuse is being prepared.
- `assignment` is the generic downward activation packet for bounded work. `reuse` is the specific downward activation packet that reactivates an existing standby worker or reassigns work to an active worker awaiting a lifecycle decision on the same preserved topic/context. Both return the target worker to `ACTIVE`; neither creates a new teammate by itself.
- Teammate population changes only on worker creation and confirmed shutdown/removal. `standby` and `reuse` are state transitions, not teammate-count changes.
- Hook feedback may record or guard a lifecycle edge, but it does not create authority to infer session end or worker shutdown by itself.
- A worker-targeted `shutdown_request` sent after that worker is explicitly marked `FORCE-STOPPED` is part of worker lifecycle cleanup, not by itself evidence that the whole session is entering `Closeout Sequence`.
- If a stale current-runtime worker must be replaced outside closeout, keep the lifecycle order message-first: send `shutdown_request`, wait for acknowledgment or timeout, use `mark-force-stop.sh` only if the worker is unresponsive, then dispatch the replacement. Do not skip directly to replacement unless the worker is confirmed terminated.
- Previous-session remembered workers are continuity artifacts, not runtime shutdown targets in a later session. Do not send `shutdown_request` to historical workers unless they have been re-established as live workers in the current runtime.

### Cost rule

- New dispatch is expensive because context must be rebuilt.
- Reusing or keeping a suitable worker on standby is usually cheaper than shutdown plus redispatch.
- Reuse is preferred when workload, availability, context fit, and ownership safety all support it.

### Manifest review gate

- When execution depends on a user-provided file list, copy set, or overwrite manifest, complete review before fan-out:
  - collapse duplicates
  - verify the final unique write set
  - make pre-execution review explicit
- Current standard packet fields use exact English keys:
  - `TASK-CLASS: manifest-sync`
  - `MANIFEST-UNIQUE: <count>`
  - `OVERLAP-REVIEW: done`
  - `PRE-EXEC-REVIEW: done`
  - `WRITE-SCOPE: <unique target set>`
  - if sharded: `SHARD-ID: <id>` and `SHARD-SET: disjoint`
- Deterministic manifest sync or overwrite propagation is single-writer by default.
- Shard that work only when each shard's write scope is explicit and disjoint before the first developer dispatch.

### Pre-Dispatch Self-Verification Gate

Before issuing a consequential dispatch (implementation, multi-worker fan-out, governance modification, or high-acceptance-risk work), the team lead must verify:

1. **Goal Alignment** — Does this dispatch directly serve the user's actual request? Am I solving what was asked, not what I assumed?
2. **Alternative Routing** — Did I consider at least one alternative worker type or scope decomposition? Why is this routing better?
3. **Worker-Charter Fit** — Is the chosen worker the best charter match? Would a different worker type handle this more effectively?
4. **Scope Appropriateness** — Is the scope neither too broad (unfocused) nor too narrow (missing context)? Is the boundary explicit?
5. **Prior-Analysis Handoff** — Have I included my existing analysis, findings, and reasoning in the dispatch? Will the worker be able to continue from where I left off rather than starting from scratch?
6. **Prerequisite Completeness** — Are all dependencies resolved? Is there something I should verify before dispatching?
7. **Failure Path** — If this dispatch fails or returns unexpected results, what is the recovery path?

For low-risk dispatch (simple reads, bounded inspection): items 1 and 5 are sufficient.
For medium-risk dispatch (implementation, multi-worker): all items required as quick self-check.
For high-risk dispatch (governance changes, architecture, deletion): all items required with explicit written record in the dispatch packet.

Do not skip this gate for ordinary urgency, operator pressure, or self-imposed speed concerns. Only an explicit safety-critical or runtime-protection emergency defined by the owning runtime policy may abbreviate the gate, and the abbreviated basis must be recorded.

### Task Decomposition Protocol

When work involves multiple concerns, file groups, or sequential dependencies, the team lead must decompose before dispatch:

0. **Freeze the split basis first** — State why the work is being split and what axis defines each child task: question, decision target, evidence family, file group, document section, or phase step. Do not split "because the task feels large" without naming the active split basis.
1. **Identify atomic steps** — Each dispatch should have a single clear purpose (e.g., "compare these 3 files" not "compare, classify, analyze risk, and summarize").
2. **Sequence the steps** — Order steps by dependency. Parallel dispatch of multiple agents is allowed and encouraged when tasks are independent. The key constraint is that each individual agent receives focused, decomposed work — not that agents must be dispatched one at a time.
3. **Size each dispatch** — Target 1-2 focused questions and at most 5 specific file paths per dispatch. If a step exceeds this, decompose further.
4. **Chain context forward** — Each subsequent dispatch must include concrete results from the prior step, not just a reference to "the previous work."
5. **Declare the child boundary explicitly** — Each child dispatch must say what it owns, what it must not absorb, and what dependency or parent objective it serves. "Take one part of this" is not a valid decomposition instruction.
6. **Make completion visible** — Each child dispatch must include a clear done condition and expected return form so the lead can decide whether to continue, merge, reroute, or hold without re-interpreting the worker's intent after the fact.

Decomposition is mandatory for work spanning more than 5 files, requiring both investigation and judgment, or crossing multiple categories. Decomposition may be skipped for single-file bounded reads or direct follow-up messages to an active worker on the same surface.
When decomposition produces multiple child tasks inside one parent objective, keep the parent objective and split basis readable in every child packet so later merge, reroute, or continuation decisions do not depend on remembered context.
For decomposed child packets, the recommended minimum readable fields are: `PARENT-OBJECTIVE`, `SPLIT-BASIS`, `CHILD-BOUNDARY`, `EXCLUDED-BOUNDARY`, `DONE-CONDITION`, and `RETURN-FORM`. These do not replace lane-specific compliance fields; they make the decomposition itself legible.

### Dispatch Packet Compliance

Before sending a dispatch, verify that all structured fields match the target lane's compliance hooks. Enumerated fields require exact values; presence fields require non-empty content.

**Enumerated fields** (exact values enforced):

| Lane | Field | Required Values |
|------|-------|----------------|
| researcher | RESEARCH-MODE | `bounded` \| `deep` \| `sharded` |
| researcher | SOURCE-FAMILY | `repo` \| `runtime` \| `web` \| `mixed` |
| researcher (benchmark) | BENCHMARK-MODE | `light` \| `full` |
| researcher (benchmark) | BENCHMARK-PROVENANCE | `repo-observed` \| `authoritative-external` \| `mixed` \| `simulator-only` |
| researcher (benchmark) | CROSS-CHECK-STATUS | `repo-confirmed` \| `authority-confirmed` \| `mixed-confirmed` \| `simulator-unconfirmed` |
| researcher (benchmark) | HALLUCINATION-GUARD | `cite-or-hold` |
| developer | PLAN-STATE | `ready` \| `approved` \| `updated` \| `revalidated` |
| developer | ACCEPTANCE-RISK | `low` \| `meaningful` \| `high` \| `critical` |
| developer | REVIEW-OWNER | `reviewer` |
| developer | PROOF-OWNER | `tester` \| `not-needed` |
| developer | ACCEPTANCE-OWNER | `reviewer` \| `validator` |
| reviewer | PREREQ-STATE | `complete` \| `partial` \| `missing` |
| validator | REVIEW-STATE | `ready` \| `hold` \| `blocked` |
| validator | TEST-STATE | `ready` \| `hold` \| `blocked` \| `not-needed` |

**Presence-required fields** (free-form, must be non-empty):

- researcher (always): DECISION-TARGET, QUESTION-BOUNDARY, DOWNSTREAM-CONSUMER
- researcher (sharded): SHARD-ID, SHARD-BOUNDARY, MERGE-OWNER
- researcher (benchmark): BENCHMARK-BASIS, BENCHMARK-SURFACE, BENCHMARK-AXIS
- developer: PLAN-STEP, CHANGE-SPEC
- developer (consequential): WORKER-FIT, SCOPE-MATCH, PRIOR-ANALYSIS
- reviewer: REVIEW-TARGET, EVIDENCE-BASIS, ACCEPTANCE-SURFACE
- tester: PROOF-TARGET, ENV-BASIS, SCENARIO-SCOPE, PROOF-EXPECTATION
- validator: VALIDATION-TARGET, EXPECTATION-SOURCES, DECISION-SURFACE

Free-form descriptions in enumerated fields are compliance failures. Use the exact values above.

For governance-sensitive `developer` packets, keep the human-readable packet contract in `skills/self-growth-sequence/reference.md` § Human-Readable Packet Owners. `team-session-sequences` remains the owner for the shared cross-lane dispatch baseline, while hooks enforce the exact runtime contract.

### Agent Load Guard

To prevent worker overload, each dispatch must stay within these bounds:

- **Focused dispatch per agent**: each agent must receive a focused, single-purpose task. Parallel dispatch of multiple agents is fine when tasks are independent. The overload risk comes from giving one agent too many diverse topics at once, not from running multiple agents simultaneously.
- **Questions per dispatch**: maximum 2 focused questions
- **Files per dispatch**: maximum 5 explicitly named file paths
- **Judgment types per dispatch**: maximum 1 (do not combine investigation + risk assessment + recommendation in one dispatch)
- **Context carry-forward**: when dispatching step N, include the concrete output of step N-1, not a pointer to "previous results"

If a dispatch exceeds any bound, decompose it before sending. Exception: researcher in `deep` mode may receive broader file scope when cross-file pattern discovery is required, but the question count limit still applies.

### Dispatch execution contract

- During explicit team-runtime sessions, non-exempt worker lanes should normally run in background rather than foreground.
- Use the current runtime-configured foreground exemptions instead of hardcoding an informal exception list in session behavior.
- When a dispatched lane requires explicit write authority under runtime policy, supply the required execution mode rather than relying on foreground execution as a shortcut.
- For request-bound work, interpret dispatch design in this order: request-fit packet -> deliverable shape -> phase intent -> staffing choice. Do not let TOC, shard count, or runtime convenience redefine the document class.
- For request-bound document work, keep phase intent explicit using existing packet surfaces rather than inventing new fields. `researcher` packets already express the evidence phase; `developer` packets should use `PLAN-STEP` plus `CHANGE-SPEC` to say whether the active phase is `draft` or `merge-compress`; downstream acceptance lanes remain distinct later phases even when they are expressed through reviewer/tester/validator packets rather than a separate phase field.
- Treat `review` and `validation` as acceptance phases, not cleanup afterthoughts. Review checks artifact quality, request fit, and defect classification; validation arbitrates final PASS/HOLD/FAIL against the authoritative expectation surfaces after review/test state is visible.
- Mixed-purpose prompts are invalid even when all requested work is related. A single dispatch must not ask one worker to expand broad evidence, draft the main artifact body, and perform final merge-compress integration at the same time.
- The most important forbidden combinations are: `research + main-body draft`, `broad research + merge-compress`, `draft + final acceptance review`, and `review + validation verdict` in one worker prompt.
- Do not require a new worker only because the phase changed. When scope remains single-purpose and context reuse is beneficial, continue with the current worker through a bounded follow-up dispatch instead of manufacturing handoff overhead.
- Late-arriving shard updates may be absorbed narrowly without reopening the whole staffing plan. If the frozen packet and current evidence already support useful progress, the designated draft or merge owner may continue and then take a bounded follow-up update for the late shard while keeping the active phase intent explicit.
- Use one foreground scout first only when independence, staffing shape, or boundary quality is still uncertain after the `intent -> deliverable shape -> phase` freeze. When those are already explicit and non-overlapping, immediate parallel fan-out is preferred over scout-first delay.
- When dispatching `developer` or another implementation lane, keep the designed downstream procedure explicit in the dispatch packet rather than assuming later cleanup will restore it. Current standard packet fields:
  - `PLAN-STATE: ready|approved|updated|revalidated`
  - `PLAN-STEP: <active plan step>`
  - `ACCEPTANCE-RISK: low|meaningful|high|critical`
  - `REVIEW-OWNER: reviewer`
  - `PROOF-OWNER: tester|not-needed`
  - `ACCEPTANCE-OWNER: reviewer|validator`
- For request-bound document work routed to `developer`, recommended `PLAN-STEP` values are `draft` and `merge-compress`. Keep `CHANGE-SPEC` explicit about whether the worker owns first answer-first drafting or integration/compression of existing shard outputs.
- For `ACCEPTANCE-RISK: meaningful|high|critical`, preserve the full downstream gate map explicitly: `REVIEW-OWNER: reviewer`, `PROOF-OWNER: tester`, `ACCEPTANCE-OWNER: validator`.

### Parallel Shard And Merge Protocol

- When one parent task is split across multiple workers inside the same phase, freeze the parent packet first: request-fit, deliverable shape, phase intent, and merge objective must stay shared across all shards.
- Parallel shard fan-out is allowed only when shard boundaries are genuinely non-overlapping at the active work surface. If boundaries overlap, the work is not independent and must be resized, resequenced, or routed to one owner instead of parallelized by convenience.
- Name one explicit `MERGE-OWNER` before full fan-out whenever the parent task will require a recomposed deliverable, integrated judgment, or compressed final body. `MERGE-OWNER` may be the lead or a designated worker, but it must be explicit before shard outputs start accumulating.
- Naming `MERGE-OWNER` does not force a global wait for shard completeness. Once the frozen parent packet and available shard set support useful progress, that owner may begin bounded drafting or integration and fold later shard arrivals into explicit follow-up merge work while missing inputs remain visible.
- Each shard dispatch must stay bounded and must say what part of the parent work it owns, what it must not absorb, and what form its handoff should take so the merge owner does not have to reconstruct shard intent from prose.
- Each shard handoff should carry at minimum:
  - shard id or equivalent surface label
  - covered boundary and excluded boundary
  - concrete result payload
  - unresolved gaps or blockers
  - duplication or conflict risk seen from that shard
  - recommended downstream placement when the parent artifact will be recomposed
- Merge work is its own phase-intent. Do not hide merge responsibility inside one shard writer's ordinary draft step after parallel fan-out has already happened.
- Phase separation does not require passive waiting. Starting draft from an incomplete but already useful shard set, then advancing the designated owner through bounded merge-compress follow-up as later shard results arrive, is valid when the parent packet, merge ownership, and unresolved gaps stay explicit.
- The merge owner must:
  - collect shard outputs against the frozen parent packet
  - remove duplication and collapse overlapping support material
  - keep the direct answer, decision surface, or controlling conclusion visible early
  - preserve `EXCLUDED-SCOPE` and final page/volume target when the parent artifact is request-bound
  - make any unresolved contradiction, missing shard, or weak-evidence area explicit rather than flattening it into a false clean merge
- If shard outputs expand the volume beyond the intended artifact class, optimize at merge time by demoting or trimming locally correct but non-decisive material before acceptance routing. Merge does not owe every shard full local preservation in the final reader-facing body.
- After merge, route one authoritative integrated output forward. Do not send multiple shard bodies downstream as if acceptance lanes should perform the merge implicitly.

### Task identity rule

- Task-scoped tools such as `TaskGet`, `TaskUpdate`, `TaskOutput`, and `TaskStop` take the task id from the explicit `task_assignment` packet, not a worker name or `agentId@team`.
- Agent-scoped communication remains separate: use `SendMessage(to: "<worker-or-agentId>")` for worker control, and do not reuse that worker identifier as a task identifier.
- Treat worker-to-worker communication as challenger traffic, not shared management. Workers may send bounded peer advice or challenge on a local claim, but any ownership, acceptance, routing, or task-control change must come back through `team-lead`.
- Keep `SendMessage` direction explicit. Free-form is fine for status, acknowledgment, clarification, or partial-result notes that do not change ownership, lifecycle, routing, or active surface. Authoritative downward control packets, upward report `MESSAGE-CLASS` vocabulary, and the structured `shutdown_request` / `shutdown_response` lifecycle path are owned by `.claude/skills/task-execution/reference.md`; consume the canonical schema there rather than restating it locally. Peer worker challenge stays on `PEER-MODE` plus `MESSAGE-PRIORITY`.
- If task output must be read later, carry the assigned task id forward explicitly instead of reconstructing it from the worker name by guesswork.

### Consequential Upward Handoff Block

- For consequential upward `SendMessage` reports from runtime lanes with `MESSAGE-CLASS: handoff|completion` or `MESSAGE-CLASS: hold|blocker`, keep one authoritative handoff block explicit instead of scattering acceptance-critical state across prose.
- `status`, `blocker`, and `scope-pressure` may stay lighter, and ordinary conversational notes may remain free-form unless the sender is actually handing off a finished, held, or decision-ready surface.
- Runtime checks must not bottleneck ordinary chat. Once a lane declares `MESSAGE-CLASS: handoff|completion` or `MESSAGE-CLASS: hold|blocker`, the authoritative handoff block is mandatory and blocking.
- Common presence-required fields for consequential upward handoff blocks:
  - `OUTPUT-SURFACE: <artifact, claim, version, or bounded work product>`
  - `EVIDENCE-BASIS: <decisive evidence anchors, checks, commands, or governing basis>`
  - `OPEN-SURFACES: <blocked, unverified, residual-risk, or none-material surfaces>`
  - `RECOMMENDED-NEXT-LANE: <next owner or none>`
  - `REQUESTED-LIFECYCLE: standby|shutdown`
- Lane-owned enumerated fields for consequential upward handoff blocks:
  - `developer` -> `PREREQ-STATE: complete|partial|missing`
  - `reviewer` -> `REVIEW-STATE: ready|hold|blocked`
  - `tester` -> `TEST-STATE: ready|hold|blocked`
  - `validator` -> `VERDICT: PASS|HOLD|FAIL`
- Preserve lane-owned state monotonically across reroute and re-dispatch. `team-lead` may summarize or route from these fields, but must not silently strengthen a worker-owned state without a fresh explicit report from the owning lane or stronger evidence on that same lane surface.
- `tester` does not emit `TEST-STATE: not-needed`; that remains a lead-side validation-ingress decision when the acceptance design truthfully does not require tester proof.

### Health-check standard

- For explicit team-runtime sessions, recurring health monitoring runs at the cadence configured in `hook-config.sh` only when a tracked health-check cron is actually active.
- The configured cron cadence and stale thresholds are defined in `hook-config.sh`.
- Treat `hook-config.sh` as the single literal owner for those runtime values. Session procedure text should reference the configured thresholds rather than re-copying the current numbers.
- Direct oversight, event-driven worker monitoring, and memory-pressure checks remain the primary lead-owned monitoring path even when no tracked health-check cron is active.
- `health-check.sh` classifies agents as active, standby, stale, or ghost (>600s without activity, auto force-killed) based on the current ledgers.
- In single-primary automation mode, keep the watchdog armed during standby periods. Do not pause the health-check cron merely because all workers are currently standby.
- Replacing the tracked health-check cron is not the same as session closeout. For monitor rotation, record explicit rotation intent in structured runtime state first, then perform `CronDelete` and the replacement `CronCreate`. If rotation is deferred after intent was recorded, clear the deferred rotation residue before returning to normal monitoring.
- If no tracked health-check cron is active, do not create, rotate, or narrate one by ceremony. Continue the `Monitoring Sequence` through direct oversight until runtime policy or explicit runtime state requires cron-backed monitoring.

### Stale-response rule

- High-confidence stale: investigate quickly and consider replacement or force-stop.
- Low-confidence stale during long-running bash: observe, extend if justified, then escalate if the lane remains unproductive.
- Repeated stale or error-loop behavior requires reroute, resize, replacement, or re-plan rather than silent hope.
- Treat stale signals and idle_notification as observational only. Do not assert a specific tool-phase hang or a team-infrastructure defect unless ledger evidence, dispatch behavior, runtime-pressure evidence, or explicit tool errors support that diagnosis.
- Repo-local generated-output cleanup may use bounded destructive commands only inside the active repo's approved output roots (`./projects/`, `./backups/`). Keep that allowance scoped to generated contents; it does not authorize arbitrary repo deletion or main-thread mutation.

### Runtime-pressure rule

- In single-primary automation mode, treat non-current `parent-session-id` worker processes as orphan runtime residue rather than as valid parallel production sessions.
- When hard runtime pressure or unresolved orphan residue exists, stop new `Agent` fan-out until automatic or explicit cleanup clears that pressure.
- Use automatic orphan cleanup only against non-current runtime residue; do not let runtime-pressure handling invent session closeout authority or bypass message-first worker lifecycle decisions for the current live session.
- If orphan historical workers are detected from a previous session, do not send `shutdown_request` to those remembered worker names from the new session. Use the orphan-runtime cleanup path instead of worker messaging.

## Closeout Sequence

> On-demand: see `session-closeout` skill. Loaded when explicit session end is detected via hook trigger.
