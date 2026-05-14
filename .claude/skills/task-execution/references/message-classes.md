---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
---

# task-execution: Message Classes
## Contents
- Common Message Law
- Canonical Channel Registry
- Screen Display Reporting Law
- Upward Message Classes
- Resolve Next Owner And Action

## Common Message Law
- `work-planning` produces the full frozen plan internally.
- `task-execution` translates that frozen basis into agent-facing packets.
- Agents receive bounded agent-facing packets derived from the frozen internal planning basis.
- One agent, one execution segment, one primary downward message class.
- In team-agent runtime, official upward delivery requires `SendMessage` with a valid `MESSAGE-CLASS`.
- Treat plain-text output, pane output, and agent final prose as observation evidence only.
- Delivery proof, ledger evidence, lifecycle evidence, and synthesis-ready handoff require resend through `SendMessage`.
- Methodology skills identify blocker conditions.
- Methodology skills do not create message-class authority.
- The active owner reports `hold|blocker` through its governed channel.
- `status` is progress only.
- `MESSAGE-CLASS: handoff` or `MESSAGE-CLASS: completion` is positive-state reporting only.
- `scope-pressure` is the structured objection path when the packet is directionally valid but unsafe as written.
- `hold|blocker` is the blocked path when truthful execution remains blocked after the narrow packet-correction route is exhausted.

## Canonical Channel Registry
The team-runtime data path has five channel families.
Each family names its tool surface, payload shape, owner reference, and next-action rule.
Tool envelope fields are actual top-level tool parameters only; governance packet fields live inside the tool's `prompt`, `message`, or `description` body, never as XML-style pseudo-parameters or packet lines inside another envelope field.

| Family | Tool surface | Payload shape | Owner reference | Next-action rule |
|---|---|---|---|---|
| Runtime topology | `TeamCreate`, team-scoped `Agent`, `TeamDelete` | runtime creation, member launch with top-level `description`, `prompt`, `team_name`, and `name`; runtime deletion | `runtime-dispatch-law.md`; `lifecycle-control.md` | dispatch truth, receipt monitoring, or closeout residual truth |
| Lead-directed work/control | `SendMessage` from `team-lead`, workflow owner, or `session-closeout` to exact live member | assignment, reuse, reroute, phase-transition-control, lifecycle-control, or `{"type":"shutdown_request"}` | `assignment-packet.md`; `phase-transition-control.md`; `lifecycle-control.md` | first upward outcome, `control-ack`, or shutdown evidence |
| Agent-to-lead reports | `SendMessage` from lane agent to `team-lead` | dispatch-ack, status, scope-pressure, handoff, completion, or blocked report | this file; `scope-pressure.md`; `completion-handoff.md` | lane work, monitoring, pressure/blocker resolution, or synthesis |
| Direct teammate interaction | Claude Code teammate UI or peer `SendMessage` | user instruction inside current authority or challenger evidence note for active surface | `.claude/skills/team-session-sequences/references/monitoring-lifecycle-detail.md` | receiver uses evidence; ownership, routing, lifecycle, task-control, acceptance, or active-surface changes route to `team-lead` |
| Shared task state | `TaskCreate`, `TaskUpdate`, `TaskGet`, `TaskList`, `TaskOutput`, `TaskStop` | task row creation, read, update, output read, or stop | `.claude/skills/team-session-sequences/references/monitoring-lifecycle-detail.md` | task correction, task identity recovery, retained-output `Read`, or exact task stop |

Task tools are task-state channels.
Agent communication uses `SendMessage` or Claude Code teammate UI.

## Screen Display Reporting Law
This law is the only canonical screen-display reporting rule for teammate, lane, and subagent upward messages.
Other owner surfaces must reference this law instead of restating screen-display criteria.
Every rule in this law is a mandatory operating rule.
Agent-team operation must apply this law before every upward message, status, handoff, completion, and team-lead user-facing report.
Violating this law is screen pollution.
Screen pollution is an operational defect because it prevents user monitoring.
A screen-visible report is not a work log.
A screen-visible report is not an evidence store.
A screen-visible report is not a place to show who did what.
Every teammate, lane, and subagent upward message is screen-visible.
Screen-visible reports must carry only:
- the required message-class envelope
- user-relevant blocker, action, or status truth
- retained-output path or pointer
Internal detail includes:
- teammate work detail
- role activity
- shard topology
- raw inventories
- findings lists
- packet bodies
- skill-load plans
- audit details
- task-state complaints
- raw findings
- evidence inventories
- file lists
- quotes
- methodology notes
- full evidence packs
Internal detail stays retained and silent.
Keeping internal detail off-screen never reduces evidence, handoff, retention, synthesis, or verification duties.
Retain internal detail internally or at the required retained path before reporting.
Screen output must expose only the compact envelope or pointer.
Do not disclose internal detail on screen unless one applies:
- the user explicitly asks for that specific raw material
- the detail is necessary to report a blocker
- the detail is necessary to report a required user action
If no retained-output path or non-visible carrier exists for detailed assigned output, send `hold|blocker` instead of visible raw output.
If a screen-visible report violates this law, reject it as report-correction required.

Task identity comes from `task_assignment`, `TaskList`, `TaskGet`, or returned task mutation evidence.
`TaskCreate` requires top-level non-empty `subject` and `description`.
Use `Read` on the background task output path when the runtime provides that path.
Blocked reports use exact literal `MESSAGE-CLASS: hold|blocker`.
Hooks and ledgers observe, gate, or record channel truth.
The owning message class, packet, handoff, or lifecycle payload remains decisive over hook and ledger observations.
Plain text in a pane is evidence only until resent through the required channel.

## Upward Message Classes
- `dispatch-ack`
  - accepted assignment receipt with same-turn lane work, `scope-pressure`, or `hold|blocker` as required continuation
  - use when fresh assignment-grade work has coherent `WORK-SURFACE` and required task state
  - first upward outcome is mandatory: `dispatch-ack`, `scope-pressure`, or `hold|blocker`
  - first-outcome silence routes to monitoring recovery
  - after it, continue the same turn into lane work or send a separate `scope-pressure` / `hold|blocker`
  - use the minimal receipt spine:
    - `MESSAGE-CLASS: dispatch-ack`
    - `WORK-SURFACE`
    - `ACK-STATUS: accepted`
    - `PLANNING-BASIS: loading`
    - `TASK-ID` when assigned or present
  - no other receipt prose is allowed
  - missing/incoherent `WORK-SURFACE` uses `hold|blocker`
  - missing/non-open required `TASK-ID` uses `scope-pressure` or `hold|blocker`
  - missing fields route to `scope-pressure` or `hold|blocker`
  - if one bounded packet correction preserves the same owner, phase, deliverable, proof/acceptance chain, staffing shape, and agent boundary, send a separate `scope-pressure` in the same turn
  - if the defect prevents truthful execution even with narrow correction, send a separate `hold|blocker` in the same turn
  - if the packet remains executable after explicit same-boundary inference that does not invent scope, closure rows, source authority, disposition, consumer/recompute, display-only, or acceptance-oracle basis, continue lane work and mark the inference
  - blocker text travels through separate `scope-pressure` or `hold|blocker`
- `control-ack`
  - receipt only for structured control packets such as `phase-transition-control` or `lifecycle-control`
  - closure proof remains with lifecycle evidence, handoff evidence, or acceptance evidence
- `status`
  - internal progress only
  - use only the status class, task id when assigned, work surface, and user-relevant waiting condition when team-lead explicitly requested status
  - do not include internal detail named by Screen Display Reporting Law in status
  - closure proof remains with lifecycle evidence, handoff evidence, or acceptance evidence
- `scope-pressure`
  - structured objection to workload, ownership split, hidden prerequisite, missing critical field, or burden contract
  - use when the agent rejects the packet as written while packet correction or replanning remains viable
  - must include:
    - `PRESSURE-TYPE`
    - `WHY-CURRENT-PACKET-FAILS`
    - `SMALLEST-SAFE-BOUNDARY`
    - `LANE-NEXT-CANDIDATE`
    - `REPLAN-REQUIRED`
- `handoff` / `completion`
  - completion-grade candidate only
  - requires converged lane-owned work
  - visible message body carries only the compact completion envelope and retained-output path
  - internal detail named by Screen Display Reporting Law stays out of the visible message body
  - missing retained-output path or non-visible carrier follows Screen Display Reporting Law
  - synthesis-ready only when the lane report satisfies `.claude/skills/task-execution/references/completion-handoff.md` Common Completion Result Spine
- `hold|blocker`
  - required when ambiguity, missing authority, blocked environment, or missing decisive basis prevents truthful execution
  - use as a separate blocked message class after receipt or intake when truthful lane execution is blocked
  - when emitting the blocked class, use the exact literal `MESSAGE-CLASS: hold|blocker`
  - route unavailable decisive user-surface exercise through `MESSAGE-CLASS: hold|blocker`
  - if the blocker is an information request, team-lead must answer it through a corrected packet, reopened planning, or proven user-owned blocker
  - resolution requires blocker handling through a truthful next owner/action
  - must include:
    - `BLOCKER-TYPE`
    - `BLOCKER-BASIS`
    - `SAFE-NEXT-STEP` with owner when the blocker is outside lane-local control

### Agent Information Request Consumption
When an agent sends `MESSAGE-CLASS: hold|blocker` because decisive assignment basis is missing, team-lead must consume it before any re-dispatch, synthesis, completion claim, or user-facing positive report.
Information requests are quality-control events.
They are resolution triggers.
They must improve the assignment basis.
They must restore an executable route.
Independent executable surfaces continue while the blocked lane is resolved.

Before any re-dispatch, synthesis, or positive report, team-lead must classify the request as one of:
- `packet-correction`: same frozen owner, phase, deliverable, proof or acceptance chain, staffing shape, and agent boundary
  - send the missing field explicitly through a corrected packet
- `route-replan`: missing basis changes owner, phase, deliverable, proof surface, acceptance chain, staffing shape, parallel grouping, or route
  - reopen `work-planning`
- `parallel-continue`: the affected lane is blocked or being corrected, but unrelated independent lanes remain executable inside the same frozen route
  - keep those lanes moving while the affected lane is resolved
- proven user-owned blocker: team-lead exhausts corrected packet, reopened planning, owner routing, setup/research routing, default, parameter, and assumption routes while the requested basis remains unavailable

Tool/evidence-gap consumption:
- If the agent names a missing evidence surface, required tool, setup owner, or current-toolchain gap, team-lead resolves it through tool/setup research, setup owner routing, packet correction, or route replan.
- A usable tool/evidence-gap request names the missing evidence surface, required capability, current toolset limit, candidate tools considered, selected tool or program candidate, fit rationale, why weaker evidence is invalid, smallest truthful boundary, and setup owner candidate or packet correction.
- If those details are missing, team-lead must request a corrected blocker/pressure report, route bounded tool-selection research to `researcher`, or reopen `work-planning`.
- Missing basis becomes explicit packet correction, route replan, or blocker truth.
- A corrected packet is valid only when the same frozen route remains truthful and the missing setup/tool basis is explicit.
- Otherwise reopen `work-planning` to freeze `external-tool-bridge`, the exact setup owner, or a proven user-owned blocker.

The corrected packet must name the original blocker, the supplied field or correction, the unchanged boundary, and the open executable `TASK-ID` when task tracking is active.
`packet-correction` handling requires those names.
If one missing basis affects multiple assignments, correct the shared basis once.
Then send bounded corrected packets to every affected agent.
When one lane is blocked, keep unrelated independent lanes moving inside the frozen route.
For developer constraints, the expected outcome is resumed execution.
Valid resume routes are method research, setup/tool bridge, packet correction, or owner split.
Then return the corrected executable path to developer.
Treat the constraint report as a resume-route trigger until a genuine impossible or unsafe condition is proven.

## Resolve Next Owner And Action
- `dispatch-ack` opens same-turn lane work.
- Executable same-boundary packet correction opens corrected assignment messaging.
- `scope-pressure` opens team-lead classification as `packet-correction`, `route-replan`, `parallel-continue`, or proven user-owned blocker.
- `hold|blocker` opens team-lead blocker resolution through corrected packet, reopened planning, owner routing, setup/research routing, default, parameter, or marked inference path.
- `handoff` and `completion` open `completion-handoff` reconciliation and team-lead synthesis.
- `control-ack` returns to the active control owner.
- `status` returns to monitoring or the active owner as progress evidence only.
- Missing `TaskCreate` subject or description opens task packet correction.
- Missing or stale task identity opens `TaskList`, `TaskGet`, `task_assignment`, or returned-mutation evidence recovery before task mutation.
- Available background task output path opens `Read` as the output-read channel.
