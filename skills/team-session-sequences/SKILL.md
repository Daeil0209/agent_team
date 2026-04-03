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
- `Boot Sequence`
- `Session-Start Sequence`
- `Monitoring Sequence`
- `Closeout Sequence`

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

The `Boot Sequence` is the bounded activation path for explicit team-runtime sessions.
In this global agent-team environment, it is the mandatory startup path.
Run it automatically after the minimal continuity anchor. Skip only when the operator explicitly and directly requests no-runtime startup or immediate closeout in the current message.

### Required order

1. Reset only startup-volatile control residue before continuity interpretation.
   Clear only startup-local stop residue that should never survive a fresh session, but do not purge previous logs, current-project auto memory, or explicit closeout intent at boot.
2. Read inherited continuity state from the active project root first, including `<repo>/.claude/session-state.md` when present.
   Treat repo-local continuity documents as continuity input, not as proof that inherited runtime logs still describe the live session. Treat `$HOME/.claude` as a runtime control surface, not as the project continuity owner or repository-evidence surface.
3. Re-check planning continuity only when the imminent runtime work depends on that plan.
   If `execution_plan.md` or an equivalent planning artifact exists, verify that it is still valid before fan-out.
4. Create or confirm the session team runtime before production work begins.
5. Confirm any runtime-required routing or plugin layer is available before worker fan-out.
   Treat routing-layer availability as conditional on the actual runtime.
6. Boot Sequence does not register periodic monitoring. Memory pressure is checked internally (threshold: 80%) before worker fan-out. No `CronCreate` or external health-check script is required during boot.

### Boot speed requirements

- Minimize boot round-trips. Execute the following in ONE parallel tool-call turn:
  1. Read the repo-local continuity file (`<repo>/.claude/session-state.md`)
  2. `ToolSearch` for `TeamCreate` schema (`select:TeamCreate`)
  3. Check team existence (`ls $HOME/.claude/teams/*/config.json`)
- In the next turn, call `TeamCreate` if no team config exists, then respond to the user's original message immediately.
- Boot is invisible infrastructure. Do not output boot-status reports or startup summaries unless the user explicitly asks. The user expects a direct reply to their message.
- After boot completes, the user's first message MUST be answered. Do not treat boot completion as the response.

### Boot constraints

- No production fan-out before the `Boot Sequence` is complete.
- Do not confuse `TeamCreate` with `TaskCreate`.
- If the runtime does not use explicit team orchestration, skip only the steps that are truly runtime-specific and still complete continuity establishment.
- Do not start `Boot Sequence` only to inspect the repository. In this environment, use it to arm the agent-team runtime, not to produce repository summaries.
- Previous setup logs and project auto memory are stale carryover by default, not authoritative planning inputs, unless the current task explicitly reopens them as evidence.
- When continuity is empty, stale, or contradictory and repo context must be rebuilt, use a verified branch-discovery step from the active repo root before any cross-branch comparison.
- Apply the same root-local startup rule to the active repo, clone, or worktree. Do not guess continuity or repo paths from team names, prior sessions, or remembered directories.
- Do not assume `main`, `master`, or any other branch exists just because it is common elsewhere or appears in stale carryover. Verify actual heads first, then compare only existing refs.
- Treat a missing branch ref as repository topology information, not as an operational error that needs recovery action.
- If the user explicitly ends the session while the explicit runtime is only partially booted, do not complete `Boot Sequence` just to tear it down. Enter `Closeout Sequence` directly and dismantle the partial runtime.

## Session-Start Sequence

The `Session-Start Sequence` applies at fresh start, resume, and pause-return.

### Required checks

1. Establish active context and inherited state.
   Default startup scope is minimal: read repo-local continuity first, establish the active project root, decide whether explicit team runtime is needed, then stop unless continuity is missing, contradictory, or the user explicitly asks for deeper repository analysis.
   If `<repo>/.claude/session-state.md` exists and is readable, treat that read as sufficient startup context. Do not reconstruct repo context at startup in the normal case.
   In this environment, that minimal startup anchor should immediately flow into `Boot Sequence` runtime activation. Startup completion should be expressed as agent-team startup readiness, not as a repository-context summary.
2. Identify incomplete work, active blockers, current ownership, and pending acceptance gates.
3. Verify plan validity.
   If the current plan is inconsistent, stale, missing, or no longer matches the active request, re-run planning before implementation fan-out.
4. Reconfirm current-runtime workers and remembered workers separately.
   For workers that are actually live in the current runtime, decide reuse, standby, or shutdown.
   For remembered previous-session workers carried only through continuity, decide whether the continuity note still matters, but do not send runtime lifecycle messages unless that worker is confirmed live again in the current runtime.
5. Reconfirm current management mode and runtime mode.
   Decide internally whether explicit team runtime is actually required for the next work phase.
   If unfinished governance optimization or compression is the active topic at fresh start, resume, or pause-return, do not treat inherited continuity, remembered review, or partial draft intent as edit-readiness. For high-traffic shared surfaces such as `CLAUDE.md`, `agents/team-lead.md`, `skills/team-governance-sequences/SKILL.md`, `skills/team-session-sequences/SKILL.md`, runtime hooks, or `settings.json`, the resumed packet must keep `SESSION-REVALIDATION: current-session-repo`, `BASELINE-ANCHOR: captured`, `SOURCE-MEANING-INVENTORY: explicit`, `DESTINATION-OWNER-MAP: explicit`, and `CHANGE-BOUNDARY: <bounded intended delta>` before editing resumes.
6. Make the initial owner map explicit enough to avoid drift.
7. When explicit runtime activation becomes necessary later, rely on the runtime-entry gate to audit runtime hygiene before `TeamCreate` or new worker fan-out. Do not run memory-pressure or orphan-runtime scans during `Session-Start Sequence` by default.

### Startup boundaries

- Do not inspect commit history, compare branches, or probe `main` versus `master` during startup unless continuity is missing or contradictory, or the user explicitly asks for repository analysis.
- Do not inspect current branch, dirty state, or general repository status during startup unless continuity is missing or contradictory, or the user explicitly asks for repository analysis.
- Do not enumerate optional project-local `.claude/skills`, `.claude/hooks`, or `.claude/settings.json` as part of startup unless continuity or the active task explicitly depends on them.
- Do not run repo-context reconstruction during startup when the repo-local continuity file exists and is readable.
- If repo context must be rebuilt, keep it bounded to repo root and verified heads. Do not escalate into branch-to-branch diff, merge-base, or broad repository status checks during startup by default.
- Do not emit startup repository summaries, branch reports, or wide tables unless the user explicitly asked for them or the next visible action depends on them.
- Default startup completion should be a short readiness line or the exact blocking activation step, not a state bulletin.
- Do not enumerate project-root paths, inherited continuity warnings, previous-session advisory codes such as `S-32`, cron job ids, cron cadence restatements, or cron expiration metadata in the default startup completion unless the operator explicitly asked for that detail or one of those items is the current blocker.
- Do not end startup with `continuity established`, `previous session state is weak`, or similar repository-summary framing. End with agent-team readiness or the exact next activation step instead.
- Do not tell the user that `TeamCreate` will happen later if this environment is in normal startup mode. `TeamCreate` is part of the automatic boot path here.

### Session-state discipline

- Update `.claude/session-state.md` on every major task completion, major decision, stage transition, key configuration change, or material ownership change.
- Do not wait until termination to restore session continuity state.

## Monitoring Sequence

The `Monitoring Sequence` is continuous during active delegated operation.

### Monitoring responsibilities

- Track lane health, no-progress risk, ownership drift, stalled workers, and merge collisions.
- Use direct lead oversight and event-driven monitoring as the primary path during explicit team runtime.
- Add periodic health monitoring only when the active runtime policy or tracked runtime configuration actually enables a health-check cron.
- In single-primary automation mode, also track runtime pressure: available memory, swap headroom, orphan session workers, and stale tmux socket residue.
- Treat unattended no-progress lanes as management defects.
- Keep diagnostic and evidence-gathering work routed to the delegated evidence lane rather than letting the main lead absorb reproduction or root-cause work by convenience.
- Use bidirectional coordination actively during monitoring: acknowledge worker reports, request clarification or partial results when needed, answer bounded worker questions, and keep control changes explicit rather than assuming silent understanding.

### Worker lifecycle states

- `ACTIVE`: currently executing work — includes the period after turn completion until the governing lane explicitly approves standby, reuse, or shutdown
- `STANDBY`: governing lane has approved the worker to wait with preserved context for future reuse
- `FORCE-STOPPED`: explicitly terminated — worker is no longer needed, harmful, stuck, or must be stopped immediately

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
- `Standby Approve`: no immediate work, but near-future reuse is plausible. Current standard control path is an explicit governing-lane message (`MESSAGE-CLASS: standby`) to the concrete worker name; any helper or hook state update exists only to reflect that approved decision, not to replace it.
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

For governance-sensitive `developer` packets, keep the human-readable packet contract in `skills/team-governance-sequences/SKILL.md`. `team-session-sequences` remains the owner for the shared cross-lane dispatch baseline, while hooks enforce the exact runtime contract.

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
- Keep `SendMessage` direction explicit. Free-form is fine for status, acknowledgment, clarification, or partial-result notes that do not change ownership, lifecycle, routing, or active surface. Downward authoritative control uses `MESSAGE-CLASS: assignment|control|reroute|reuse|standby`, `MESSAGE-PRIORITY: normal|high|critical`, and `WORK-SURFACE: <bounded active surface>`; lifecycle shutdown uses `shutdown_request` / `shutdown_response`; upward authoritative reports use `MESSAGE-CLASS: blocker|handoff|completion|hold|scope-pressure|status`, `MESSAGE-PRIORITY: normal|high|critical`, `WORK-SURFACE: <current surface>`, and `REQUESTED-GOVERNING-ACTION: <decision needed or none>`; peer worker challenge stays on `PEER-MODE` plus `MESSAGE-PRIORITY`.
- If task output must be read later, carry the assigned task id forward explicitly instead of reconstructing it from the worker name by guesswork.

### Consequential Upward Handoff Block

- For consequential upward `SendMessage` reports from runtime lanes with `MESSAGE-CLASS: handoff|completion|hold`, keep one authoritative handoff block explicit instead of scattering acceptance-critical state across prose.
- `status`, `blocker`, and `scope-pressure` may stay lighter, and ordinary conversational notes may remain free-form unless the sender is actually handing off a finished, held, or decision-ready surface.
- Runtime checks must not bottleneck ordinary chat. Once a lane declares `MESSAGE-CLASS: handoff|completion|hold`, the authoritative handoff block is mandatory and blocking.
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

The `Closeout Sequence` is mandatory whenever the session is explicitly ending or a confirmed handoff requires runtime teardown.
Hook feedback alone is not sufficient evidence that the user wants the session to end.

Treat this skill as the procedure owner for closeout sequencing. Closeout `phase` is teardown progress only; clean closeout also requires an explicit governance-completeness vector that covers final validation ownership, authoritative acceptance evidence, and supervisor review state. The persisted runtime fields for that vector live in the hook-owned runtime state surface; this skill remains the human-readable procedure owner.

### Closeout preemption rule

- Explicit user-directed session end preempts incomplete boot.
- If the runtime is active but `Boot Sequence` is incomplete, do not register a new health-check cron or otherwise finish boot solely to satisfy shutdown.
- Mark explicit closeout intent, shut down workers, remove any already-registered runtime monitors, and tear down the runtime directly.
- Once explicit closeout intent is active, message-based worker coordination needed to finish teardown may continue even if monitor removal makes boot incomplete again. Do not re-arm the health-check cron just to send teardown or closeout-coordination messages.

### Required actions

1. Mark explicit closeout intent before sending any session-level `shutdown_request`, deleting the tracked health-check cron, or tearing down the explicit team runtime.
   Current standard: set explicit closeout intent in the session-bound structured closeout state before teardown begins, and clear that state if closeout is later deferred. Do not model closeout as a timeless on/off residue.
   When the current user prompt itself explicitly requests session end, the `UserPromptSubmit` hook should pre-mark closeout intent before the lead reaches any guarded closeout tool. In that case, do not intentionally trigger `CronDelete`, `TeamDelete`, or `shutdown_request` once just to discover that intent is required.
   Worker-specific termination remains message-first: after `mark-force-stop.sh` terminates a worker, the cleanup is a worker lifecycle edge, not by itself a session closeout edge.
2. Integrate worker outputs and disclose unresolved issues.
   Before monitor teardown or `TeamDelete`, resolve the contract-owned teardown governance prerequisites for this session: final validation ownership and authoritative acceptance evidence.
   When acceptance risk is meaningful, assign an explicit final validation owner before closeout rather than letting review or testing silently stand in for final validation.
   When standalone review, test, or validation reports are intentionally suppressed, keep one authoritative acceptance-evidence block in the closeout or continuity state before granting clean closeout.
   At closeout, do not rely on remembered intent to prove governance completeness. Record the final closeout governance packet explicitly before clean stop, and if governance is still unresolved, prepare a truthful hold rather than compressing the sequence.
   Current standard: record the final closeout governance packet explicitly in the same structured closeout state, including validation-owner state, acceptance-evidence state, and supervisor-review state.
   If truthful clean closeout is not yet earned, prepare explicit carry-forward hold state with a concrete reason instead of compressing the sequence or hoping teardown cleanup will infer it.
3. Release or explicitly account for remaining workers through explicit internal lifecycle messages.
   Closeout is not the time to invent a new continuity lane. `session-state.md` should already be current from normal work, and remaining live workers must be accounted for before monitor teardown.
4. Keep continuity handling minimal during teardown.
   Do not dispatch a new continuity writer or other ad hoc helper lane as part of normal closeout. If continuity is materially stale, refresh it before teardown starts as ordinary session work. Otherwise rely on `SessionEnd` capture for the final timestamp and residual warnings.
5. Remove periodic session runtime monitors that were registered for the live session only after current-runtime workers have been fully accounted for.
   Current standard: read the stored job ID, run `CronDelete(id: stored_job_id)`, then clear the tracked health-check job record from runtime state.
   Do not treat monitor-rotation handling as a substitute for this step. Closeout teardown still requires explicit closeout intent, not rotation intent.
   Delete the tracked health-check only after the current-runtime workers that still need coordination have been fully accounted for. Do not recreate the monitor just to keep messaging open.
   If no tracked health-check cron is active, skip this step rather than manufacturing monitor teardown ceremony.
6. Tear down the explicit team runtime when that runtime was used and the workers are no longer active.
   `TeamDelete` is not a shortcut for worker cleanup. Normal closeout requires drained current-runtime worker state first; unterminated workers must block teardown.
7. Let `SessionEnd` finish continuity stamping after runtime teardown.
   Preserve `.claude/session-state.md` as the continuity owner; do not clear it as part of closeout cleanup. After `CronDelete` or `TeamDelete`, do not dispatch a new `Agent` just to write continuity.
   If continuity remains stale at that point, do not reopen runtime teardown or start a helper lane just to change the continuity timestamp. Leave the state truthful and let `SessionEnd` capture it as warnings-bearing continuity.
8. Let `SessionEnd` cleanup clear runtime-owned logs, ledgers, transient closeout residue, and current-project auto memory after continuity capture and session-end logging complete.
9. Run an explicit supervisor-effectiveness review only when the user asked for team-operation evaluation, a real teardown/management defect occurred, or `Self-Growth Sequence` / `Update/Upgrade Sequence` work is active.
   If triggered, inspect detection timeliness, reroute quality, checkpoint cleanliness, stalled-lane handling, and whether the user had to surface a problem before the team did. A required supervisor review remains a clean-closeout gate even after runtime teardown.
10. End with a truthful operator-facing closeout only when step 9 was actually triggered, the closeout is blocked or in truthful hold, restart or handoff guidance is materially needed, or the user explicitly asked for a summary.
   Clean closeout with no meaningful carry-forward state may be silent or reduced to a one-line acknowledgement; in that case the authoritative detail remains the closeout state plus `SessionEnd` continuity capture rather than a recap message.

### Closeout constraints

- Do not leave orphaned workers or live recurring monitors silently running.
- Do not treat a force-stopped worker as fully cleaned up until the tmux pane is confirmed terminated or equivalent runtime teardown is complete.
- Do not manually write runtime marker files to bypass boot or closeout gates. If runtime state is contradictory, hold and clean the residue instead of inventing runtime truth.
- Do not infer user end-of-session intent from hook feedback, runtime residue, or repeated closeout warnings alone.
- Do not trust closeout state that belongs to another session. Closeout guards and stop gating must bind to the current runtime session before they authorize teardown.
- Lifecycle shutdown decisions must remain message-first: hooks may guard or report, but they must not invent shutdown authority in place of the lead's explicit message path.
- Do not dispatch a new continuity helper during normal closeout. The fast path is worker accounting -> `CronDelete` -> `TeamDelete` -> `SessionEnd` capture.
- Do not dispatch a new `Agent` for continuity capture after `CronDelete` or `TeamDelete`.
- If stale continuity is the only remaining issue after teardown, stop there and let `SessionEnd` capture it. Do not loop on repeated hook feedback.
- If closeout is aborted, deferred, or narrowed, clear explicit closeout intent immediately and return control to the `Monitoring Sequence`.
- Do not present blocked or partially cleaned-up closeout as complete success.
- Prefer lean closeout: default to silence or one-line acknowledgement; expand only for decisive evidence, blockers, restart requirements, or residual risk.
- Prefer one authoritative closeout narrative over multiple thin summaries or duplicate status artifacts when a narrative is actually needed.
- Make unresolved blockers, risks, and follow-up state explicit before closeout.
- Default clean closeout reporting to silent or one-line acknowledgement. Do not emit recap bullets, file lists, risk lists, or handoff sections when no material carry-forward state exists.
- Keep clean closeout reporting compact. Do not emit long diagnostic tables or retrospective audits unless the user asked or the teardown actually blocked.
- Do not replace unfinished teardown with a long retrospective diagnosis. State the concrete residue, keep the state on `HOLD`, and stop.
- If a full closeout cannot be completed, report the exact residual state explicitly.
- Do not expect runtime cleanup or `SessionEnd` cleanup to invent missing governance resolution. Those gates now require an explicit clean governance packet or an explicit truthful hold.
