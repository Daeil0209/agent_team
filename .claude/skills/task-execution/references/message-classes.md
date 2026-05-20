---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-user-reporting-law.md
---

# task-execution: Message Classes
## Contents
- Common Message Law
- Canonical Channel Registry
- Communication Plane Law
- Structured Shutdown Request
- Upward Message Classes
- Resolve Next Owner And Action

## Common Message Law
- `work-planning` produces the full frozen plan internally.
- `task-execution` translates that frozen basis into agent-facing packets.
- Agents receive bounded agent-facing packets derived from the frozen internal planning basis.
- One agent, one execution segment, one primary downward message class.
- Every `SendMessage` call sets the recipient in the top-level `to` parameter before payload detail.
- Lane-to-lead `SendMessage` sets `to: team-lead`.
- Lead-to-lane `SendMessage` sets `to` to the exact live process-backed member name.
- Recipient text inside `summary`, `message`, `content`, `description`, packet fields, or prose does not satisfy `to`.
- Missing or blank top-level `to` is tool-envelope invalid; correct the envelope before another `SendMessage`.
- In team-agent runtime, official upward delivery requires `SendMessage` with a valid `MESSAGE-CLASS`.
- Every fresh assignment-grade `SendMessage` in team-agent runtime requires a first upward outcome unless upward transport was classified unsupported before dispatch.
- A first upward `dispatch-ack` means the lane reviewed the assignment packet, accepts it without objection, and starts the assigned work.
- A first upward `scope-pressure` or `hold|blocker` means the lane cannot truthfully start the assigned work as written.
- Unsupported upward transport is a dispatch-shape blocker before assignment send, not an after-the-fact excuse for silent idle.
- Treat plain-text output, pane output, and agent final prose as observation evidence only.
- Delivery proof, ledger evidence, cleanup evidence, and synthesis-ready completion require resend through `SendMessage`.
- Methodology skills identify blocker conditions.
- Methodology skills do not create message-class authority.
- The active owner sends `hold|blocker` through its governed Communication Plane channel.
- `status` is progress only.
- `MESSAGE-CLASS: completion` is positive-state transport only.
- `scope-pressure` is the structured objection path when the packet is directionally valid but unsafe as written.
- `hold|blocker` is the blocked path when truthful execution remains blocked after the narrow packet-correction route is exhausted.

## Canonical Channel Registry
The team-runtime data path has five channel families.
Each family names its tool surface, payload shape, owner reference, and next-action rule.
Tool envelope fields are actual top-level tool parameters only; governance packet fields live inside the tool's `prompt`, `message`, or `description` body, never as XML-style pseudo-parameters or packet lines inside another envelope field.
`SendMessage.to` is an actual top-level tool parameter.
No governed payload field can replace `SendMessage.to`.

| Family | Tool surface | Payload shape | Owner reference | Next-action rule |
|---|---|---|---|---|
| Runtime topology | `TeamCreate`, team-scoped `Agent`, `TeamDelete` | runtime creation, member creation/reattach with top-level `description`, `prompt`, `team_name`, and `name`; runtime deletion | `runtime-dispatch-law.md`; `session-closeout` closeout state | member-created truth, assignment-send next action, or closeout residual truth |
| Lead-directed work/control | `SendMessage` from `team-lead`, workflow owner, or `session-closeout` to exact live member | assignment, reuse, reroute, phase-transition-control, or `{"type":"shutdown_request"}` | `assignment-packet.md`; `phase-transition-control.md`; this file | first upward outcome, silent phase-context consumption, or shutdown evidence |
| Agent-to-lead transport | `SendMessage` from lane agent to `team-lead` | dispatch-ack, status, scope-pressure, completion, or blocked transport | this file; `scope-pressure.md`; `completion-handoff.md` | lane work, monitoring, pressure/blocker resolution, or synthesis |
| Direct teammate interaction | teammate UI or peer `SendMessage` | user instruction inside current authority or challenger evidence note for active surface | `.claude/skills/team-session-sequences/references/monitoring-lifecycle-detail.md` | receiver uses evidence; ownership, routing, cleanup, task-control, acceptance, or active-surface changes route to `team-lead` |
| Shared task state | `TaskCreate`, `TaskUpdate`, `TaskGet`, `TaskList`, `TaskOutput`, `TaskStop` | task row creation, status update, read, output read, or stop; never assignment delivery | this file `### Shared Task State Contract` | task correction, task identity recovery, retained-output `Read`, completion status closure, or exact task stop |

Task tools are task-state channels.
Agent communication uses `SendMessage` or teammate UI.
Standalone `Agent` is not a Communication Plane channel family.
Standalone `Agent` cannot carry assignment delivery, receipt, status, `scope-pressure`, `hold|blocker`, completion, reuse, or task-state truth.
Already-produced standalone `Agent` output is fallback evidence consumed by `team-lead`, not lane transport.

## Communication Plane Law
This file owns agent-to-agent and agent-to-lead transport classes.
It does not own user-facing reporting.
User-facing reporting is owned by `.claude/reference/reporting-user-reporting-law.md`.

### Plane Boundary
`SendMessage`, teammate UI, `dispatch-ack`, `status`, `scope-pressure`, `completion`, `hold|blocker`, assignment packets, phase-transition packets, shutdown requests, task rows, task output, runtime ledgers, and retained-output pointers are Communication Plane transport.
Communication Plane transport is addressed to an internal owner.
Communication Plane transport never satisfies a user report.
Procedure Plane consumes transport evidence before synthesis, correction, recovery, or validation movement.
Reporting Plane may cite only the user-relevant outcome admitted by `.claude/reference/reporting-user-reporting-law.md`.

### Transport Payload
Communication payload carries the detail required by the receiving owner through the active envelope plus governed carriers.
Payload shape is governed by the active message class, assignment packet, completion contract, phase-transition packet, shutdown request, task state, or retained-output contract.
Do not shrink, omit, or distort receiver-required detail for user-display reasons.
When `SendMessage` can render on a user-visible screen, the `summary` parameter contains exactly the state-signal text (`ack task <TASK-ID>` or `ack`, `completion task <TASK-ID>` or `completion`) and no additional fields, paths, counts, coverage labels, OPEN-SURFACES, excerpts, summaries, or prose.
The `message` parameter is empty or a single ASCII space and carries no other content.
`SendMessage` render means the combined `summary` plus `message` display; both halves obey this canonical state-signal envelope rule.
This is the single canonical envelope rule for `ack` and `completion` state signals; other owner surfaces cite this rule and must not restate its content.
If the `SendMessage` schema rejects an empty body for a governed state signal, use exactly one ASCII space in the body slot and no other body content.
Receiver-required detail moves to the assignment packet, task state, retained-output file, shutdown request, or evidence artifact referenced by that envelope.
Use retained-output files or task output when detail is evidence, result inventory, counts, excerpts, operational notes, long-lived state, or material reused by later owners.
Screen-rendered transport never becomes Reporting Plane prose and never carries raw internal inventories.
Do not put `ack`, `completion`, `MESSAGE-CLASS`, field labels, receiver-required detail, or report prose in the visible message/body.

### Payload Fidelity
Communication payload is mission-critical internal evidence.
User non-display never permits loss, omission, distortion, or vague substitution of receiver-required information.
Transport carriers preserve exact user intent, `TARGET-INTENT-BASIS`, request-fit facts, acceptance basis, scope boundaries, constraints, assumptions, inferences, blocker truth, evidence pointers, and next owner/action when those facts are material to the receiving owner.
Summaries are routing aids only; they do not replace exact packet, task, or retained-output basis when downstream execution, synthesis, proof, or validation depends on the exact basis.
When exact wording, full evidence, result inventory, counts, excerpts, or operational notes are needed, carry them in task state or retained-output and send the pointer through the owning message class.
A receiving owner consumes the governed carrier before acting; a screen-visible envelope or excerpt is not sufficient basis when the governed carrier is required.

### Shared Task State Contract
Team-lead owns shared task-state use for planned team-runtime assignment through `task-execution`.
Task tracking is active when team-lead uses the shared task list as the planned assignment identity surface for team-runtime work.
When task tracking is active, team-lead creates or verifies the task row after current-session team runtime registration and before assignment-grade `SendMessage`.
`TaskCreate` uses top-level non-empty `subject` and `description`.
The task row supplies `TASK-ID` identity only.
`SendMessage.to` carries the live worker target and assignment delivery.
Task rows are not assignment-owner, assignee, or in-progress tracking surfaces.
Immediately after `completion` transport, the normal team-runtime `TaskUpdate` mutation sets `status: completed` on the same assigned task.
Task-scoped tools use exact task identity from `task_assignment`, `TaskList`, `TaskGet`, returned task mutation evidence, or the task file.
Unknown, guessed, pre-team, lead-local, next-numeric, same-batch planned-but-not-returned, completed, closed, cancelled, or missing ids are not executable assignment identity.
`TaskOutput` and retained-output reads may use completed task identity only as evidence retrieval, not as a new assignment basis.

### Receipt Event Contract
`dispatch-ack` is the assignment acceptance and work-start trigger inside the Communication Plane.
This contract does not reduce Communication Plane payload capacity.
Receiver-required execution detail travels through the assignment packet, phase-transition packet, shutdown request, task state, retained-output carrier, `status` when lead-requested, `scope-pressure`, `completion`, or `hold|blocker`, according to the owning message class.
A receipt event is one host-visible header/preview state signal: `ack task <TASK-ID>` when task tracking is active, otherwise `ack`.
The receiving owner interprets that state signal as `MESSAGE-CLASS: dispatch-ack`; envelope shape is governed by Transport Payload above.
Before `dispatch-ack`, the lane inspects the assignment packet for `WORK-SURFACE`, required task state, lane authority, required skills, decisive basis, and blocker truth.
`dispatch-ack` means the lane accepts the packet as currently executable without team-lead correction, replan, authority change, or blocker clearance.
`dispatch-ack` triggers lane intake and assigned work inside the same assignment execution block.
A packet executable only through safe lane-local inference may emit `dispatch-ack` only when the inference changes no owner, phase, deliverable, proof/acceptance chain, staffing shape, agent boundary, parallel grouping, scope, source authority, closure row, disposition, consumer/recompute path, display-only status, or acceptance oracle.
A packet requiring team-lead correction before truthful start suppresses `dispatch-ack` and emits `scope-pressure`.
A packet blocked by missing or incoherent `WORK-SURFACE`, missing/non-open required `TASK-ID`, missing decisive basis, blocked environment, missing authority, or unsafe ambiguity suppresses `dispatch-ack` and emits `hold|blocker`.
`dispatch-ack`, `scope-pressure`, and `hold|blocker` do not coexist as first outcomes for the same packet.
Lane work states (`ACTIVE`/`STANDBY`) and dispatch-ack/completion transition semantics are owned by `.claude/skills/session-boot/references/runtime-state-detail.md` `## Agent Work States`.
The lane continues work until one closing class is sent.
The closing classes are `completion`, `scope-pressure`, `hold|blocker`, and `HOLD`.
Closed work reopens only through distinct bounded `assignment`, `reuse`, or `reroute`.
Same `TASK-ID` / `WORK-SURFACE` / `RETAINED-OUTPUT-PATH` replay is duplicate packet noise; team-lead consumes the retained carrier or sends distinct bounded work.
After a closing class, the lane stays silent for that closed work.
Closed-work replay must not emit `status`, `clarification`, duplicate `completion`, or duplicate `dispatch-ack`.
A closed lane that discovers genuine post-completion defect evidence emits a distinct bounded `MESSAGE-CLASS: hold|blocker` naming the new evidence.
Team-lead routes the new evidence through corrected packet, reopened planning, or owner correction.
The lane drives its own continuation between intra-block turn boundaries without waiting for another team-lead prompt.
A valid `dispatch-ack` clears receipt and establishes no-objection assignment acceptance; it does not prove later progress, work quality, completion, or acceptance.
Do not emit readiness, context-loaded, awaiting-assignment, skill-loading, file-read plan, retained-output plan, next-action, or progress messages from inside that block.

### Communication Integrity
Transport silence is allowed only when no receiver action, recovery, synthesis, or runtime cleanup decision depends on the message.
Transport content remains binding for the receiving owner even when it is not a user report.
Hooks and ledgers observe, gate, or record channel truth.
The owning message class, packet, completion packet, phase-transition packet, or shutdown request remains decisive over hook and ledger observations.
Plain text in a pane is observation evidence only until resent through the required transport or retained carrier.
A pane/final response containing `MESSAGE-CLASS`, `DISPATCH-ACK`, `COMPLETION-HANDOFF`, or equivalent transport headers is malformed raw Communication Plane leakage and does not satisfy receipt, completion, status, pressure, or blocker transport.
If an agent cannot use the required transport tool, visible text is not a substitute transport and the lead resolves missing receipt through monitoring/recovery.
Task identity, `TaskCreate` field requirements, executable assignment identity, and `TaskUpdate` closure are owned by `### Shared Task State Contract`.
Use `Read` on the background task output path when the runtime provides that path.

### Team Member Startup Recognition
In team-agent runtime, the team-scoped `Agent` prompt creates or reattaches a live member address; it is not the assignment-grade work packet.
The member startup prompt carries role and screen-safety only.
Default team-scoped member creation uses this exact prompt template: `Member: <name>. Role: <lane>. Screen-safety: no visible prose from this member-creation prompt.`
Only `<name>` and `<lane>` vary in the default template.
It must not instruct or request `ready`, `context loaded`, `awaiting assignment`, `readiness ack`, `dispatch-ack`, `status`, `completion`, or any other upward message.
The spawn prompt restriction applies to upward Communication Plane transport and visible prose only.
It does not suppress internal Procedure Plane action.
Passive-wait phrasing in the spawn prompt (such as `do not load skills`, `do not read references`, or `do not use tools before assignment`) is a spawn-prompt defect.
Normal lane intake consumes the role file, lane-detail reference, and required skills through internal tool calls once the assignment SendMessage arrives.
Assignment-grade work begins only when `team-lead` sends `SendMessage` with `MESSAGE-CLASS: assignment`, `reuse`, or `reroute` to the exact live member name.
Lane intake treats the `SendMessage` assignment body as the assignment packet.
The system-generated `task_assignment` notification carries `TASK-ID` and a brief subject for task identity only.
It is not an authoritative assignment packet.
It must not trigger `dispatch-ack`.
The authoritative assignment packet is the `SendMessage` body with `MESSAGE-CLASS: assignment`.
When both arrive, the lane treats the `SendMessage` body as authoritative and uses `task_assignment` only to confirm `TASK-ID`.
If no assignment packet arrives, the lane waits without shard work and sends no startup readiness transport.
A startup-pane `online`, `ready`, or `awaiting packet` response is observation only and never satisfies `dispatch-ack`.
Standalone `Agent` prompts are fallback host evidence only when the route explicitly permits non-runtime evidence; they do not create team-runtime receipt debt.

## Structured Shutdown Request
Shutdown is runtime cleanup, not lane work state and not a `MESSAGE-CLASS`.
Team-lead or `session-closeout` sends `SendMessage(to: "<agent-name>", message: {"type":"shutdown_request"})` only to a live process-backed teammate selected for cleanup.
The teammate stops accepting work and exits or is terminated by runtime cleanup.
Termination proof is live-roster absence, `teammate_terminated`, or hook/runtime shutdown evidence.
`TeamDelete` waits for termination proof for every live process-backed teammate.

## Upward Message Classes
Every class below is Communication Plane transport. The descriptions name when to use the class; payload carries receiver-required execution truth and uses retained-output or task carriers when size, evidence retention, or reuse requires it.

- `dispatch-ack`
  - acceptance and work-start trigger; follows `Receipt Event Contract`
  - use only after the lane reviews the fresh assignment-grade packet and finds coherent `WORK-SURFACE`, required task state, lane authority, required skills, decisive basis, and no blocker requiring team-lead action
  - first upward outcome is mandatory: `dispatch-ack`, `scope-pressure`, or `hold|blocker`
  - after sending, continue inside the same assignment execution block across subsequent tool turns
  - newly discovered blockers after accepted intake use separate `scope-pressure` or `hold|blocker`
  - missing/incoherent `WORK-SURFACE` uses `hold|blocker`
  - missing/non-open required `TASK-ID` uses `scope-pressure` or `hold|blocker`
  - missing fields route to `scope-pressure` or `hold|blocker`
  - if one bounded packet correction is required before truthful start, suppress `dispatch-ack` and send `scope-pressure`
  - if the defect prevents truthful execution even with narrow correction, suppress `dispatch-ack` and send `hold|blocker`
  - if the packet remains executable after explicit same-boundary inference that does not invent scope, closure rows, source authority, disposition, consumer/recompute, display-only, or acceptance-oracle basis, continue lane work and mark the inference
  - blocker text travels through separate `scope-pressure` or `hold|blocker`
- `status`
  - internal progress only
  - emit only when team-lead explicitly requested status
  - closure proof remains with cleanup evidence, completion evidence, or acceptance evidence
- `scope-pressure`
  - structured objection to workload, ownership split, hidden prerequisite, missing critical field, or burden contract
  - use when the agent rejects the packet as written while packet correction or replanning remains viable
- `completion`
  - completion-grade candidate only
  - use only after converged lane work has written the retained carrier required by `completion-handoff.md`
  - send to `team-lead` through `SendMessage`
  - requires converged lane-owned work
  - screen-rendered `SendMessage` header/preview is one state signal only: `completion task <TASK-ID>` when task tracking is active, otherwise `completion`
  - envelope shape governed by Transport Payload above
  - no files-read counts, findings counts, per-class totals, excerpts, evidence summaries, operational notes, completion narrative, path-substitution rationale, next-step prose, or retained-output contents in the `SendMessage` render
  - synthesis-ready only when the retained carrier satisfies `.claude/skills/task-execution/references/completion-handoff.md` Common Completion Result Spine
- `hold|blocker`
  - required when ambiguity, missing authority, blocked environment, or missing decisive basis prevents truthful execution
  - use as a separate blocked message class after receipt or intake when truthful lane execution is blocked
  - route unavailable decisive user-surface exercise through `hold|blocker`
  - if the blocker is an information request, team-lead must answer it through a corrected packet, reopened planning, or proven user-owned blocker
  - resolution requires blocker handling through a truthful next owner/action

### Agent Information Request Consumption
When an agent sends `MESSAGE-CLASS: hold|blocker` because decisive assignment basis is missing, team-lead must consume it before any re-dispatch, synthesis, completion claim, or user-facing positive report.
Information requests are quality-control events.
They are resolution triggers.
They must improve the assignment basis.
They must restore an executable route.
Independent executable surfaces continue while the blocked lane is resolved.

Before any re-dispatch, synthesis, or user-facing positive report, team-lead must classify the request as one of:
- `packet-correction`: same frozen owner, phase, deliverable, proof or acceptance chain, staffing shape, and agent boundary
  - send the missing field explicitly through a corrected packet
- `route-replan`: missing basis changes owner, phase, deliverable, proof surface, acceptance chain, staffing shape, parallel grouping, or route
  - reopen `work-planning`
- `parallel-continue`: the affected lane is blocked or being corrected, but unrelated independent lanes remain executable inside the same frozen route
  - keep those lanes moving while the affected lane is resolved
- proven user-owned blocker: team-lead exhausts corrected packet, reopened planning, owner routing, setup/research routing, default, parameter, and assumption routes while the requested basis remains unavailable

`scope-pressure` carries this classification as `CORRECTION-OUTCOME`.

Tool/evidence-gap consumption:
- If the agent names a missing evidence surface, required tool, setup owner, or current-toolchain gap, team-lead resolves it through tool/setup research, setup owner routing, packet correction, or route replan.
- A usable tool/evidence-gap request names the missing evidence surface, required capability, current toolset limit, candidate tools considered, selected tool or program candidate, fit rationale, why weaker evidence is invalid, smallest truthful boundary, and setup owner candidate or packet correction.
- If those details are missing, team-lead must request corrected blocker/pressure transport, route bounded tool-selection research to `researcher`, or reopen `work-planning`.
- Missing basis becomes explicit packet correction, route replan, or blocker truth.
- A corrected packet is valid only when the same frozen route remains truthful and the missing setup/tool basis is explicit.
- Otherwise reopen `work-planning` to freeze `external-tool-bridge`, the exact setup owner, or a proven user-owned blocker.

The corrected packet must name the original blocker, the supplied field or correction, the unchanged boundary, and the open executable `TASK-ID` when task tracking is active.
`packet-correction` handling requires those names.
A lane recognizes a packet-correction only when an incoming `SendMessage` with `MESSAGE-CLASS: assignment` carries those explicit fields; absent that signal, the lane must not classify or transport state as `post-correction`, `correction-attempted`, or any equivalent inferred-correction label, and must not treat the prior blocker as resolved.
If one missing basis affects multiple assignments, correct the shared basis once.
Then send bounded corrected packets to every affected agent.
When one lane is blocked, keep unrelated independent lanes moving inside the frozen route.
For developer constraints, the expected outcome is resumed execution.
Valid resume routes are method research, setup/tool bridge, packet correction, or owner split.
Then return the corrected executable path to developer.
Treat the constraint transport as a resume-route trigger until a genuine impossible or unsafe condition is proven.

## Resolve Next Owner And Action
- `dispatch-ack` opens the same assignment execution block; it does not open waiting, status narration, or user reporting.
- Executable same-boundary packet correction opens corrected assignment messaging.
- `scope-pressure` opens team-lead classification as `packet-correction`, `route-replan`, `parallel-continue`, or proven user-owned blocker.
- `hold|blocker` opens team-lead blocker resolution through corrected packet, reopened planning, owner routing, setup/research routing, default, parameter, or marked inference path.
- `completion` opens completion-contract reconciliation and team-lead synthesis.
- `status` returns to monitoring or the active owner as progress evidence only.
- Missing `TaskCreate` subject or description opens task packet correction.
- Missing or stale task identity opens `TaskList`, `TaskGet`, `task_assignment`, or returned-mutation evidence recovery before task mutation.
- Available background task output path opens `Read` as the output-read channel.
