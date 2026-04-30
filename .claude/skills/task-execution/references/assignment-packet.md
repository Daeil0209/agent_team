---
PRIMARY-OWNER: task-execution
LOAD-POLICY: on-demand reference only
---

# task-execution: Assignment Packet
## Downward Assignment Base Packet
Assignment-grade means any team-scoped `Agent` launch or `SendMessage` that assigns, reroutes, or reuses bounded work for an agent. Lifecycle control, phase-transition control, and status probes are not assignment-grade. Standalone `Agent` is not a configured lane-work substitute under this governance.

Runtime shape terms:
- `standalone Agent` is a synchronous host call outside team-agent runtime. It does not use `TeamCreate`, team mailbox state, `dispatch-ack`, or health-cron monitoring; do not use it for configured lane dispatch.
- `team-agent runtime` is opened by `TeamCreate` for coordinated teammates with shared task/mailbox state. Team-scoped `Agent` calls use `team_name` and are monitored as team-runtime work.
- `teammate context` is independent. A teammate loads project context such as `CLAUDE.md`, configured MCP servers, and available skills, and receives the lead's spawn/assignment prompt; it does not inherit the lead's conversation history. Assignment packets must therefore be self-contained enough for the receiving lane to act without reconstructing prior chat.

Every assignment-grade agent packet carries:
- `MESSAGE-CLASS`
- `WORK-SURFACE`
- `CURRENT-PHASE`
- `REQUIRED-SKILLS`
- `TASK-ID` when task tracking is active

### Tester Executable-Proof Schema Floor
For tester assignment-grade dispatch where the proof surface is executable (browser-ui, cli, runtime, server, app, api), `ENV-BASIS` and `SCENARIO-SCOPE` are required schema floor. This is doctrine-owned packet discipline: `task-execution` must carry it, and tester must raise `scope-pressure` or `hold|blocker` when omission makes truthful proof impossible. Conditional carve-out: only when proof is genuinely static-render with no runtime dependency AND single-surface with no scenario variation, mark `ENV-BASIS: not-applicable (<reason>)` and `SCENARIO-SCOPE: not-applicable (<reason>)` explicitly rather than omitting silently. `PROOF-TARGET`, `PROOF-EXPECTATION`, and `PROOF-SURFACE` alone are not sufficient for executable proof; env and scenario binding must be explicit. See `agents/tester.md` RPA-1 for the lane-side restatement.

### Packet Preflight And Correction Routing
Before assignment-grade dispatch, `task-execution` must run packet preflight against the frozen planning/workflow basis, not against gist. Preflight checks:
- common base packet floor: `MESSAGE-CLASS`, `WORK-SURFACE`, `CURRENT-PHASE`, `REQUIRED-SKILLS`, and `TASK-ID` when task tracking is active
- receiving lane additions from the lane-core skill and lane-detail reference
- `REQUEST-BOUND-PACKET-FIELDS`, `SKILL-RECOMMENDATIONS`, governance tier fields, and lane-specific phase context when frozen
- user-surface, proof, tool/setup/discovery, run-path, burden, decision, validation, environment, and scenario fields when the frozen surface makes them material
- `EXECUTION-READINESS-BASIS`, lifecycle debt visibility, parallel grouping or serial reason, and proof/acceptance owner

Preflight outcome names:
- `packet-correction`: a packet defect whose missing or malformed value already exists in the frozen basis and can be corrected without changing owner, phase, work surface, deliverable, proof/acceptance chain, staffing shape, or parallel grouping. Correct the packet and rerun preflight before sending.
- `route-replan`: the missing or contradictory basis is absent from the frozen basis, stale, or would change owner, phase, deliverable, work-surface decomposition, staffing shape, proof surface, acceptance chain, or parallel grouping. Reopen `work-planning`.
- `parallel-continue`: one affected surface is blocked or being corrected, but unrelated independent surfaces remain inside the same frozen parallel route. Continue those unaffected surfaces while resolving the blocked surface through `packet-correction`, `route-replan`, or user-facing blocker.

Packet preflight does not authorize `task-execution` to invent route facts, tool facts, acceptance facts, or skill openings. It either corrects a bounded packet translation defect, reopens the route owner, or keeps independent unblocked work moving.
When the receiving path is team-agent runtime, preflight must also reject packets that rely on lead-only conversation context, unlinked prior reasoning, or implicit upstream decisions. Those facts must be carried as packet fields, task/workflow state, or preserved artifacts before dispatch.

### Field Format Discipline
Packet field shape follows a strict line-prefix form compatible with `hooks/lib/hook-agent-dispatch.sh` `dispatch_populate_field_cache`: `^([[:alnum:]_-]+)[[:space:]]*:[[:space:]]*(.*)$`. A field counts as "present" only when this form matches its first line. Fields that look semantically present in prose but fail this format are packet defects; warning hooks may report them as missing, but the primary correction owner is the packet-producing procedure.

Required shape for every dispatch field (assignment, validator, reviewer, tester, lifecycle control):
- field name MUST start the line (no leading prose, indentation, list bullet, or quote prefix)
- only `[A-Za-z0-9_-]` allowed in the field name
- `:` MUST come directly after the field name (only whitespace allowed between)
- NO parenthetical descriptor, type annotation, or natural-language qualifier between key and colon
- value follows the colon on the same line; multi-line continuation (numbered lists, bullets, nested detail) is allowed on subsequent lines but is NOT what the parser keys against

| Wrong | Right |
|---|---|
| `EXPECTATION-SOURCES (consolidated frozen criteria - read in this order):` | `EXPECTATION-SOURCES: Consolidated frozen criteria, read in order. (1) ...` |
| `**MESSAGE-CLASS**: assignment` (markdown bold prefix) | `MESSAGE-CLASS: assignment` |
| `- TASK-ID: ...` (list bullet prefix) | `TASK-ID: ...` |

Note on leading whitespace: the compatible packet parser strips leading/trailing whitespace from each segment via `gsub(/^[[:space:]]+|[[:space:]]+$/, "", segment)` before the regex match, so an indented field parses at runtime. Column-0 starts remain the recommended convention for human readability, but indentation alone is not a packet-warning cause.

Recovery discipline: when a packet warning flags a "missing field" you have written into the packet, the format is the likely cause. Read the field's first-line shape against the rules above before retrying. Retrying with the same shape is itself a recurrence-barrier defect, not a parser bug.

`REQUIRED-SKILLS` is not optional decoration. It is the agent-facing skill-load contract derived from the frozen planning basis or the active workflow owner's phase-local refinement.
- `team-lead` may load a non-owner skill locally only when a frozen and `SV-PLAN`-verified lead-local path requires it.
- agent lanes must not preload lane-core skills for receipt-only, control-only, narrow status, lifecycle-only, phase-transition-only, or clarification-only messages.
- assignment-grade lane packets open consequential lane-owned work; the receiving lane must load its lane-core skill as the highest-priority lane-local procedure, then load packet `REQUIRED-SKILLS`.
- packet `REQUIRED-SKILLS` names additional non-lane-core skills only; do not list the receiving lane-core skill as a packet skill.
- if no additional non-lane-core skills are required, the packet must still carry `REQUIRED-SKILLS: []`; omission is invalid on assignment-grade packets.
- lane-core priority does not override shared doctrine, role boundaries, `task-execution`, `work-planning`, or `self-verification`.
- optional, methodology, specialist, and packet-requested skills refine execution only inside the lane-core boundary and frozen packet basis.
- if `REQUIRED-SKILLS` is missing, contradictory, or too weak to keep the lane-owned path truthful, do not improvise a hidden skill plan inside the agent; raise `scope-pressure` or `hold|blocker`.
- active workflow owners may refine `REQUIRED-SKILLS` only inside the already frozen lane map, deliverable shape, and proof/acceptance chain.
- if a proposed refinement would create a new lane, new independent surface, or changed acceptance/proof owner, it is not packet-local refinement; reopen `work-planning` first.

## Session Cross-Continuity Packet Check
Before assignment-grade dispatch for independent or parallel work, packet construction must apply prior same-session patches, decisions, contract freezes, lane-charter changes, and acceptance-contract changes that affect packet fields, owner boundaries, proof burden, or acceptance truth.

If the required prior invariant is missing from the frozen route, stop and reopen `work-planning`. If the packet would contradict a prior invariant, do not dispatch and do not repair by prose inside `task-execution`.

Use assignment-grade packets for:
- new assignment
- reroute
- bounded reuse

If an agent is receiving new bounded work in the same execution segment, carry any needed workflow phase context inside the assignment packet instead of sending a separate standalone control packet.
