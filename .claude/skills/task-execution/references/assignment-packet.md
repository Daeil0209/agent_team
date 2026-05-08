---
PRIMARY-OWNER: task-execution
LOAD-POLICY: on-demand reference only
---

# task-execution: Assignment Packet
## Downward Assignment Base Packet
Assignment-grade means any team-scoped `Agent` launch or `SendMessage` that assigns, reroutes, or reuses bounded work for an agent.
Lifecycle control, phase-transition control, and status probes are not assignment-grade.
Standalone `Agent` is not a configured lane-work substitute under this governance.

Runtime shape terms:
- `standalone Agent` is legacy or fallback host evidence outside team-agent runtime.
- No `TeamCreate`, team mailbox state, `dispatch-ack`, or health-cron monitoring.
- Not configured lane dispatch.
- `team-agent runtime` is opened by `TeamCreate` for coordinated teammates with shared task/mailbox state. Team-scoped `Agent` calls use `team_name` and are monitored as team-runtime work.
- `team member address` is the exact live process-backed roster name. A configured role label is not a `SendMessage.to` address unless the roster contains that exact member with live pane proof.
- `teammate context` is independent. A teammate loads project context such as `CLAUDE.md`, configured MCP servers, and available skills, and receives the lead's spawn/assignment prompt; it does not inherit the lead's conversation history. Assignment packets must therefore be self-contained enough for the receiving lane to act without reconstructing prior chat.

Every assignment-grade agent packet carries:
- `MESSAGE-CLASS`
- `WORK-SURFACE`
- `CURRENT-PHASE`
- `REQUIRED-SKILLS`
- open executable `TASK-ID` when task tracking is active
- `TARGET-INTENT-BASIS` per `CLAUDE.md` `[DESIGN-INTENT]`.

### Tester Executable-Proof Schema Floor
For tester assignment-grade dispatch where the proof surface is executable, `ENV-BASIS` and `SCENARIO-SCOPE` are required schema floor.
Executable surfaces include browser-ui, cli, runtime, server, app, and api.
`task-execution` carries this doctrine-owned packet discipline.
Tester must raise `scope-pressure` or `hold|blocker` when omission makes truthful proof impossible.
Conditional carve-out: proof must be genuinely static-render with no runtime dependency.
Conditional carve-out also requires a single surface with no scenario variation.
When the carve-out applies, mark `ENV-BASIS: not-applicable (<reason>)` and `SCENARIO-SCOPE: not-applicable (<reason>)`.
Do not omit them silently.
`PROOF-TARGET`, `PROOF-EXPECTATION`, and `PROOF-SURFACE` alone are not sufficient for executable proof.
Env and scenario binding must be explicit.
See `agents/tester.md` RPA-1 for the lane-side restatement.

### Packet Preflight And Correction Routing
Before assignment-grade dispatch, `task-execution` must run packet preflight against the frozen planning/workflow basis, not against gist. Preflight checks:
- common base packet floor: `MESSAGE-CLASS`, `WORK-SURFACE`, `CURRENT-PHASE`, `REQUIRED-SKILLS`, and an open executable `TASK-ID` when task tracking is active
- completed-task correction/follow-up uses an open executable task whose `TaskUpdate` or `TaskCreate` result has returned before dependent dispatch or task mutation
- receiving lane additions from the lane-core skill and lane-detail reference
- target-resolution basis for team runtime: active team name, live process-backed roster, target role, exact member address, tool shape, and resulting truth label
- concrete requested action must be executable with the receiving lane's allowed tools and output channel
- do not tell a read-only lane to write files, mutate state, run unavailable tools, or report through a channel it cannot use
- if the lane cannot produce the requested artifact directly, route the write/mutation to an owner that has the tool or require lane output through `SendMessage`
- the common start closure contract from `.claude/skills/task-execution/references/request-bound-fields.md`: every material request-bound axis frozen by planning or workflow is carried, marked `not-applicable:<basis>` where allowed, or routed to `packet-correction` / `route-replan`
- the carried axes include `REQUEST-BOUND-PACKET-FIELDS`, `SKILL-RECOMMENDATIONS`, governance tier fields, lane-specific phase context, user-defined coverage obligations, assigned surfaces, acceptance basis, user-surface/proof/tool/setup/run-path/burden/decision/validation/environment/scenario fields, and cited Receiver-Surface Contract, Consumption Chain, Boundary Register, and Evidence-Quality Matrix identities
- finding counts are reported evidence, not dispatch scope
- for review/test/validation/completion packets, acceptance scope must come from the frozen request, plan, design, or upstream defer record; implemented files/routes/screens/sections may only populate `ACTIVE-SLICE`, never substitute for `SCOPE-BASELINE`
- Contract-truth preflight anchors verification packets to the frozen baseline, exact launch/read artifact, operator invocation, termination, cleanup, and defer basis.
- Convenient-subset, inherited server-state, or already-running endpoint packets route to correction from the frozen basis or reopen the owner.
- `FINAL-REJECT` follow-on packet preflight preserves frozen acceptance scope and carries the validator-authored correction packet in `EXECUTION-READINESS-BASIS` before correction dispatch.

Preflight outcome names:
- `packet-correction`: a packet defect whose missing or malformed value already exists in the frozen basis and can be corrected with all `work-planning` boundary-change axes unchanged. Correct the packet and rerun preflight before sending.
- `route-replan`: the missing or contradictory basis is absent from the frozen basis, stale, or would move a `work-planning` boundary-change axis. Reopen `work-planning`.
- `parallel-continue`: one affected surface is blocked or being corrected, but unrelated independent surfaces remain inside the same frozen parallel route. Continue those unaffected surfaces while resolving the blocked surface through `packet-correction`, `route-replan`, or proven user-owned blocker.

Packet preflight never invents route facts, tool facts, acceptance facts, or skill openings. It corrects a bounded packet translation defect, reopens the route owner, or keeps independent unblocked work moving.
Target resolution is packet translation only when active team name, live process-backed roster, and exact target already exist in current-runtime evidence.
If the frozen route already names the missing member, create it through team-scoped `Agent`.
If member creation would move a `work-planning` boundary-change axis, reopen `work-planning`.
Never guess that a role label is addressable.
When the receiving path is team-agent runtime, preflight must also reject packets that rely on lead-only conversation context, unlinked prior reasoning, or implicit upstream decisions. Those facts must be carried as packet fields, task/workflow state, or preserved artifacts before dispatch.
For live owner-document verification assignments, carry the post-execution live diff and owner-document basis as packet facts, task/workflow state, or preserved artifacts, or require returned evidence that proves the receiver used those live owner documents. If that evidence is absent or unproved, the receiver returns `hold|blocker` or marks findings advisory; team-lead must not use that output as verification evidence.

### Field Format Discipline
Packet field shape follows a strict line-prefix form compatible with `hooks/lib/hook-agent-dispatch.sh` `dispatch_populate_field_cache`: `^([[:alnum:]_-]+)[[:space:]]*:[[:space:]]*(.*)$`.
A field counts as "present" only when this form matches its first line.
Fields that look semantically present in prose but fail this format are packet defects.
Warning hooks can report them as missing.
The primary correction owner is the packet-producing procedure.

Required shape for every dispatch field (assignment, validator, reviewer, tester, lifecycle control):
- field name MUST start the line (no leading prose, indentation, list bullet, or quote prefix)
- only `[A-Za-z0-9_-]` allowed in the field name
- `:` MUST come directly after the field name (only whitespace allowed between)
- NO parenthetical descriptor, type annotation, or natural-language qualifier between key and colon
- value follows the colon on the same line
- multi-line continuation is allowed on subsequent lines
- numbered lists, bullets, and nested detail are continuation content only
- continuation content is NOT what the parser keys against

| Wrong | Right |
|---|---|
| `EXPECTATION-SOURCES (consolidated frozen criteria - read in this order):` | `EXPECTATION-SOURCES: Consolidated frozen criteria, read in order. (1) ...` |
| `**MESSAGE-CLASS**: assignment` (markdown bold prefix) | `MESSAGE-CLASS: assignment` |
| `- TASK-ID: ...` (list bullet prefix) | `TASK-ID: ...` |

Note on leading whitespace: the compatible packet parser strips leading/trailing whitespace from each segment via `gsub(/^[[:space:]]+|[[:space:]]+$/, "", segment)` before the regex match.
An indented field parses at runtime.
Column-0 starts remain the readable convention.
Indentation alone is not a packet-warning cause.

Recovery discipline: when a packet warning flags a "missing field" you have written into the packet, the format is the likely cause.
Read the field's first-line shape against the rules above before retrying.
Treat same-shape retry as a recurrence-barrier defect, not a parser bug.

Packet skill fields separate required skills from methodology recommendations.
- Use `REQUIRED-SKILLS` for non-lane-core skills frozen as necessary for the receiving lane's bounded work.
- Receiving lanes must load and apply every `REQUIRED-SKILLS` entry or return `scope-pressure` / `hold|blocker`.
- Use `REQUIRED-SKILLS: []` when no upstream required skill exists.
- Carry `SKILL-RECOMMENDATIONS` only when planning or the active workflow owner froze methodology guidance for the receiving lane; the receiver selects, loads, and applies material entries before first lane work and records applied or blocked skill basis in handoff.

## Session Cross-Continuity Packet Check
Before assignment-grade dispatch for independent or parallel work, packet construction must apply prior same-session patches, confirmed corrections, recurrence barriers, decisions, contract freezes, lane-charter changes, sibling outputs, and acceptance-contract changes that affect packet fields, owner boundaries, proof burden, or acceptance truth.

If the required prior invariant is missing from the frozen route, stop and reopen `work-planning`. If the packet would contradict a prior invariant, do not dispatch and do not repair by prose inside `task-execution`.

Use assignment-grade packets for:
- new assignment
- reroute
- bounded reuse

If an agent is receiving new bounded work in the same execution segment, carry any needed workflow phase context inside the assignment packet instead of sending a separate standalone control packet.
