---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
---

# task-execution: Assignment Packet
## Contents
- Downward Assignment Base Packet
- Session Cross-Continuity Packet Check
- Resolve Next Owner And Action

## Downward Assignment Base Packet
Assignment-grade means `SendMessage` that assigns, reroutes, or reuses bounded work for an existing live team member.
Team-scoped `Agent` creates or reattaches the member address; it is not assignment-grade work delivery.
Lifecycle control, phase-transition control, and status probes are not assignment-grade.
Standalone `Agent` is not a configured lane-work substitute under this governance.

Runtime shape terms:
- `standalone Agent` is legacy or fallback host evidence outside team-agent runtime.
- No `TeamCreate`, team mailbox state, `dispatch-ack`, or health-cron monitoring.
- Not configured lane dispatch.
- `team-agent runtime` is opened by `TeamCreate` for coordinated teammates with shared task/mailbox state. Team-scoped `Agent` calls use `team_name` and `name` to create or reattach a live member address.
- Assignment-grade work begins only after `SendMessage` with `MESSAGE-CLASS: assignment`, `reuse`, or `reroute` reaches that exact live member address.
- `team member address` is the exact live process-backed roster name. A configured role label is not a `SendMessage.to` address unless the roster contains that exact member with live pane proof.
- `teammate context` is independent. A teammate loads project context such as `CLAUDE.md`, configured MCP servers, and available skills, and receives the lead's spawn/assignment prompt; it does not inherit the lead's conversation history. Assignment packets must therefore be self-contained enough for the receiving lane to act without reconstructing prior chat.
- `visible teammate response` is not an assignment, receipt, handoff, completion, status, pressure, blocker, or lifecycle transport channel. It is UI rendering only and may contain only the Minimal Visible State Token when unavoidable.
- `SendMessage` is the first receipt transport channel for teammate ACK / pressure / blocker. Retained carriers and task state carry detailed payloads.

Every assignment-grade work packet carries:
- `MESSAGE-CLASS`
- `WORK-SURFACE`
- `CURRENT-PHASE`
- `REQUIRED-SKILLS`
- open executable `TASK-ID` when task tracking is active
- `SEMANTIC-INTENT-BASIS` from the frozen planning/request-bound basis.
- `TARGET-INTENT-BASIS` per `CLAUDE.md` `[DESIGN-INTENT]`.
- `CLAIM-CEILING` for analysis, critique, governance judgment, review, validation, or patch-worthiness packets. Allowed values are `evidence-only candidates`, `review findings`, `validation verdict input`, and `patch-worthiness classification`. Missing claim ceiling means returned items stay evidence-only until reviewer/review-verification/team-lead synthesis lawfully classifies them.

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
- tool-envelope validity per `message-classes.md` before packet-body checks
- `Agent` member-creation prompt screen-safety clause: no `ready`, `context loaded`, `awaiting assignment`, startup ACK, `MESSAGE-CLASS`, handoff, completion, status, findings, counts, paths, plans, next-action prose, or instruction to send such startup transport
- assignment `SendMessage` screen-safety clause: no visible `MESSAGE-CLASS`, ACK, handoff, completion, status, findings, counts, paths, plans, or next-action prose; use `SendMessage`, task state, or retained carriers as the governed transport
- common base packet floor: `MESSAGE-CLASS`, `WORK-SURFACE`, `CURRENT-PHASE`, `REQUIRED-SKILLS`, `SEMANTIC-INTENT-BASIS`, `TARGET-INTENT-BASIS`, and an open executable `TASK-ID` when task tracking is active
- analysis or defect-audit `CLAIM-CEILING`: the packet states whether the receiver returns evidence-only candidates, review findings, validation verdict input, or patch-worthiness classification; otherwise preflight keeps the packet evidence-only
- completed-task correction/follow-up uses an open executable task whose `TaskUpdate` or `TaskCreate` result has returned before dependent dispatch or task mutation
- receiving lane additions from the lane-core skill and lane-detail reference
- target-resolution basis for team runtime: active team name, live process-backed roster, target role, exact member address, tool shape, and resulting truth label (`member-created` for Agent; `assignment-sent` for assignment SendMessage)
- concrete requested action must be executable with the receiving lane's allowed tools and output channel
- do not tell a read-only lane to write files, mutate state, run unavailable tools, or send output through a channel it cannot use
- if the lane cannot produce the requested artifact directly, route the write/mutation to an owner that has the tool or require lane output through `SendMessage`
- the common start closure contract from `.claude/skills/task-execution/references/request-bound-fields.md`: every material request-bound axis frozen by planning or workflow is carried, marked `not-applicable:<basis>` where allowed, or routed to `packet-correction` / `route-replan`
- the carried axes include `REQUEST-BOUND-PACKET-FIELDS`, `SKILL-RECOMMENDATIONS`, governance tier fields, lane-specific phase context, user-defined coverage obligations, assigned surfaces, acceptance basis, user-surface/proof/tool/setup/run-path/burden/decision/validation/environment/scenario fields, and cited Receiver-Surface Contract, Consumption Chain, Boundary Register, and Evidence-Quality Matrix identities
- finding counts are retained evidence, not dispatch scope
- These packet types must carry `RETAINED-OUTPUT-PATH` when expected output includes Communication Plane detail that would pollute transport display:
  - parallel shard dispatches with large shared context use one shared retained context plus short per-shard packets; do not serialize large self-contained packet drafting when `PARALLEL-DISPATCH-LOCK` is open
  - handoff packets
  - completion packets
- a receiving lane that receives such a packet without the path sends `hold|blocker`
- for review/test/validation/completion packets, acceptance scope must come from the frozen request, plan, design, or upstream defer record; implemented files/routes/screens/sections populate `ACTIVE-SLICE` only, never substitute for `SCOPE-BASELINE`
- Contract-truth preflight anchors verification packets to the frozen baseline, exact launch/read artifact, operator invocation, termination, cleanup, and defer basis.
- Convenient-subset, inherited server-state, or already-running endpoint packets route to correction from the frozen basis or reopen the owner.
- `FINAL-REJECT` follow-on packet preflight preserves frozen acceptance scope and carries the validator-authored correction packet in `EXECUTION-READINESS-BASIS` before correction dispatch.

Preflight outcome names:
- `packet-correction`: a packet defect that materially affects the receiver's in-flight truthful execution and whose missing or malformed value already exists in the frozen basis with all `work-planning` boundary-change axes unchanged. Post-convergence transport-display defects in delivered handoffs do not qualify — the retained output already carries the truth, re-emit multiplies auto-notification noise without effect, and cleanup routes to `self-growth-sequence` as a recurrence barrier (not to mid-flight correction). Correct the packet and rerun preflight before sending.
- `route-replan`: the missing or contradictory basis is absent from the frozen basis, stale, or would move a `work-planning` boundary-change axis. Reopen `work-planning`.
- `parallel-continue`: one affected surface is blocked or being corrected, but unrelated independent surfaces remain inside the same frozen parallel route. Continue those unaffected surfaces while resolving the blocked surface through `packet-correction`, `route-replan`, or proven user-owned blocker.

Packet preflight never invents route facts, tool facts, acceptance facts, or skill openings. It corrects a bounded packet translation defect, reopens the route owner, or keeps independent unblocked work moving.
Target resolution is packet translation only when active team name, live process-backed roster, and exact target already exist in current-runtime evidence.
If the frozen route already names the missing member, create it through team-scoped `Agent`.
If member creation would move a `work-planning` boundary-change axis, reopen `work-planning`.
Never guess that a role label is addressable.
When the receiving path is team-agent runtime, preflight must also reject packets that rely on lead-only conversation context, unlinked prior reasoning, or implicit upstream decisions. Those facts must be carried as packet fields, task/workflow state, or preserved artifacts before dispatch.
For live owner-document verification assignments, carry the post-execution live diff and owner-document basis as packet facts, task/workflow state, or preserved artifacts, or require returned evidence that proves the receiver used those live owner documents. If that evidence is absent or unproved, the receiver returns `hold|blocker` or marks findings non-authoritative; team-lead must not use that output as verification evidence.

### Field Format Discipline
Packet field shape follows a strict line-prefix form compatible with `hooks/lib/hook-agent-dispatch.sh` `dispatch_populate_field_cache`: `^([[:alnum:]_-]+)[[:space:]]*:[[:space:]]*(.*)$`.
A field counts as "present" only when this form matches its first line.
Fields that look semantically present in prose but fail this format are packet defects.
Warning hooks can flag them as missing.
The primary correction owner is the packet-producing procedure.

Required shape for every dispatch field (assignment, validator, reviewer, tester, lifecycle control):
- field name MUST start the field segment (no leading prose, list bullet, or quote prefix)
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
- Use `REQUIRED-SKILLS: []` to record absence of upstream required skills.
- Carry `SKILL-RECOMMENDATIONS` when planning or the active workflow owner froze methodology instructions for the receiving lane.
- The receiver classifies each carried recommendation as applied, not-material, or blocked.
- The receiver loads and applies material recommendations before first lane work.
- The receiver records recommendation classification basis in handoff.

## Session Cross-Continuity Packet Check
Before assignment-grade dispatch for independent or parallel work, packet construction must apply prior same-session patches, confirmed corrections, recurrence barriers, decisions, contract freezes, lane-charter changes, sibling outputs, and acceptance-contract changes that affect packet fields, owner boundaries, proof burden, or acceptance truth.

If the required prior invariant is missing from the frozen route, stop and reopen `work-planning`. If the packet would contradict a prior invariant, do not dispatch and do not repair by prose inside `task-execution`.

Use assignment-grade packets for:
- new assignment
- reroute
- bounded reuse

If an agent is receiving new bounded work in the same execution segment, carry any needed workflow phase context inside the assignment packet instead of sending a separate standalone control packet.

## Resolve Next Owner And Action
- Passing packet preflight opens `task-execution` dispatch or reuse.
- `packet-correction` opens same-owner packet correction and reruns packet preflight.
- `route-replan` opens `work-planning`.
- `parallel-continue` keeps unaffected lanes moving while the blocked surface resolves.
- Missing target-resolution evidence opens runtime target resolution before dispatch.
- Missing field format truth opens correction in the packet-producing procedure.
- Missing lane-required additions opens lane-addition correction before dispatch.
- Packets relying on lead-only conversation context open packet fact transfer before dispatch.
