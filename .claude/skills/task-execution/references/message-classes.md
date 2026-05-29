---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
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
- Only top-level `to` satisfies recipient targeting; recipient text inside `message`, `content`, `description`, packet fields, or prose remains payload text.
- Missing or blank top-level `to` is tool-envelope invalid; correct the envelope before another `SendMessage`.
- In team-agent runtime, official upward delivery requires `SendMessage` with a valid `MESSAGE-CLASS`.
- Every fresh assignment-grade `SendMessage` in team-agent runtime requires a first upward outcome unless upward transport was classified unsupported before dispatch.
- A first upward `dispatch-ack` means the lane reviewed the assignment packet, accepts it without objection, sends the state-management signal to `team-lead`, and starts the assigned work.
- A first upward `scope-pressure` or `hold|blocker` means the assigned work as written is not truthfully startable.
- Unsupported upward transport is a dispatch-shape blocker before assignment send, not an after-the-fact excuse for silent idle.
- Treat plain-text output, pane output, and agent final prose as observation evidence only.
- Delivery proof, ledger evidence, cleanup evidence, and synthesis-ready completion require resend through `SendMessage`.
- Methodology skills identify blocker conditions.
- Message-class authority remains with this Communication Plane law.
- The active owner sends `hold|blocker` through its governed Communication Plane channel.
- `status` is progress only.
- `MESSAGE-CLASS: completion` is positive-state transport only.
- `scope-pressure` is the structured objection path when the packet is directionally valid but unsafe as written.
- `hold|blocker` is the blocked path when truthful execution remains blocked after the narrow packet-correction route is exhausted.
- Uppercase `HOLD` is Procedure Plane owner state; lane upward transport uses `MESSAGE-CLASS: hold|blocker` when transport is available.

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
| Direct teammate interaction | teammate UI or peer `SendMessage` | user instruction inside current authority or challenger evidence note for active surface | `.claude/skills/team-session-sequences/references/monitoring-lifecycle-detail.md` | receiver uses evidence; ownership, routing, cleanup, acceptance, or active-surface changes route to `team-lead` |

Agent communication uses `SendMessage` or teammate UI.
Standalone `Agent` is fallback evidence outside Communication Plane channel families.
Assignment delivery, receipt, status, `scope-pressure`, `hold|blocker`, completion, and reuse require governed Communication Plane channels.
Already-produced standalone `Agent` output is fallback evidence consumed by `team-lead`, not lane transport.

## Communication Plane Law
This file owns agent-to-agent and agent-to-lead transport classes.
User-facing reporting is owned by `.claude/reference/reporting-prohibition-law.md`.
Renderable assistant-authored transport fields remain under `.claude/reference/reporting-prohibition-law.md`; this file only defines the no-detail envelope that preserves internal transport without report content.

### Plane Boundary
`SendMessage`, teammate UI, `dispatch-ack`, `status`, `scope-pressure`, `completion`, `hold|blocker`, assignment packets, phase-transition packets, shutdown requests, runtime ledgers, and retained-output pointers are Communication Plane transport.
Communication Plane transport is addressed to an internal owner.
Communication Plane transport never satisfies a user report.
Procedure Plane consumes transport evidence before synthesis, correction, recovery, or validation movement.
Reporting Plane may cite only the user-relevant outcome granted a narrow exception by `.claude/reference/reporting-prohibition-law.md`.

### Transport Payload
Communication payload carries the detail required by the receiving owner through the active envelope plus governed carriers.
Payload shape is governed by the active message class, assignment packet, completion contract, phase-transition packet, shutdown request, or retained-output contract.
Receiver-required detail stays complete regardless of user-display suppression.
When `SendMessage` can render on a user-visible screen, visible fields obey `.claude/reference/reporting-prohibition-law.md` before rendering.

Rendered `SendMessage` class policy:
- `state-signal-object`: `dispatch-ack`, `status`, `completion`, `scope-pressure`, and `hold|blocker` use `message: {"type":"state_signal","class":"<class>"}` with no `summary`; class is a no-detail state token and carries no fields, paths, counts, evidence, or prose.
- `assignment-carrier-pointer`: `assignment`, `reuse`, `reroute`, and `phase-transition-control` use `message: {"type":"carrier_pointer","class":"<class>","key":"CARRIER","value":"<path>"}` with no `summary`. Full packet floor fields live in the governed carrier.
- `structured-shutdown-payload`: runtime cleanup sends only the exact structured object payload `{"type":"shutdown_request"}` or `{"type":"shutdown_response"}`; no reason, comment, status, findings, evidence, or progress field is added to the rendered transport.
- `carrier-pointer-only`: team-meeting discussion, `critique-request`, `critique-response`, `verdict`, `redirect`, draft publication/update, peer-challenge notes, corrective instruction notices, and other non-assignment/non-state messages use `carrier_pointer` or `index_pointer` structured payloads only.
- `render-prohibited-detail`: content categories excluded from visible `SendMessage` fields are owned by `.claude/reference/reporting-prohibition-law.md` `## Non-Reportable Content`; receiver-required detail lives in retained carriers, assignment packet carriers, or evidence artifacts.
String `message` payloads are invalid because Claude Code requires `summary` when `message` is a string, and `summary` is prohibited by the reporting curtain.
The structured `message` payload admits no detail; a non-empty carrier/index value is allowed only when the active class below explicitly requires a no-detail carrier/index pointer.

For upward state classes, any rendered header/preview contains only the canonical no-detail state token required by the class, or stays empty when the runtime permits; it carries no fields, paths, counts, coverage labels, `OPEN-SURFACES`, excerpts, result text, rationale, or prose.
Canonical no-detail state tokens are closed routing tokens: a class token, a hook-safe round/turn id, a runtime handle such as `@reviewer-A`, a configured lane/role token, or a short combination of those tokens when the active class requires routing identity.
Raw host ids, ranges, counts, worker lists, delivery wording, envelope-shape explanations, and natural-language clauses are not canonical state tokens.
The `message` parameter is a structured object and carries no prose content.
`SendMessage` render means every visible field obeys this canonical structured envelope rule.
For `MESSAGE-CLASS: hold|blocker`, `BLOCKER-TYPE`, `BLOCKER-BASIS`, `SAFE-NEXT-STEP`, and any receiver-required detail live in the governed payload carrier or retained-output path referenced by the envelope; visible admission follows `.claude/reference/reporting-prohibition-law.md`.
This is the single canonical envelope rule for upward state-class signals; other owner surfaces cite this rule and keep local restatement out.
If a sender would otherwise use an empty or single-space string body for a governed state signal, use the structured `state_signal` object instead; do not add `summary`.
For downward assignment delivery `SendMessage`:
- `message` parameter is the exact structured carrier pointer object: `{"type":"carrier_pointer","class":"assignment|reuse|reroute|phase-transition-control","key":"CARRIER","value":"<path>"}`.
- The structured payload does not carry assignment-packet floor fields directly.
- Assignment-packet required-floor fields live in the governed carrier referenced by the structured pointer.
- Rendered assignment delivery does not carry multi-line continuations, findings, evidence inventories, rationale, critique text, file/line lists, or bulk context.
- Bulk shared context, full taxonomy text, parenthetical explanation, restated upstream basis, duplicated retained-carrier content, and report-shaped prose move to the retained carrier referenced via `RETAINED-OUTPUT-PATH` or `UPSTREAM-DECISION-BASIS` and stay out of the assignment body.
- This downward body is receiver-facing governed packet transport; user-facing report admission is owned by `.claude/reference/reporting-prohibition-law.md`.
For all other `SendMessage` classes — peer challenger evidence notes, team-meeting opinion exchange (`critique-request` / `critique-response`), corrective instruction messages, phase-context relay outside the canonical `phase-transition-control` class, and any class not explicitly governed by the upward state class rules or downward assignment delivery rules above — the same canonical-envelope-plus-retained-carrier-pointer shape applies:
- `message` is a structured `carrier_pointer` or `index_pointer` object carrying exactly one no-detail carrier/index value when a pointer is required (e.g., `{"type":"carrier_pointer","class":"critique-request","key":"CARRIER","value":"claude_doc/.../review.md#turn-7"}`, `{"type":"index_pointer","key":"VERDICT","value":"PASS"}`, `{"type":"index_pointer","key":"CRITIQUE","value":"carrier-only"}`, or `{"type":"index_pointer","key":"REDIRECT","value":"carrier-only"}`); no inline critique body, no inline opinion content, no inline corrective instruction body.
- Full critique / opinion / instruction / detail content lives in the retained carrier referenced via `RETAINED-OUTPUT-PATH` (or equivalent named field) within the receiving owner's consumption discipline; the carrier is what the receiving owner consumes for decision-affecting body.
- Inline full-content string body in non-state-class non-assignment-delivery `SendMessage` is non-compliant with the Constitutional Reporting Curtain `SendMessage` envelope rule per `.claude/CLAUDE.md` `## Constitutional Reporting Curtain` and is treated as curtain-class fabrication: the rendered body becomes user-visible host UI content in violation of the curtain. Senders MUST author such messages with structured carrier-based delivery from the outset; receivers MUST treat inline-body delivery as carrier-citation defect and route correction.
Before every `SendMessage` call, the sender verifies rendered content against this envelope by direction:
- Upward state classes use the canonical no-detail state-signal envelope above.
- Downward assignment delivery uses a no-detail structured assignment signal plus one carrier pointer object per the rules above.
- String `message` payloads are rejected at write-time and rewritten to the canonical structured object before send.
- Bulk content exceeding the envelope is rejected at write-time and rewritten to canonical structured envelope plus retained-carrier pointer before send.
- Tool rejection for a non-canonical rendered envelope is same-owner envelope-correction evidence. Correct from this section and retry the actual `SendMessage`.
- Envelope correction is part of the same dispatch/recovery execution block. If retry is impossible, route the blocker through the canonical no-detail blocker envelope and retained carrier.
Receiver-required detail moves to the assignment packet, retained-output file, shutdown request, or evidence artifact referenced by that envelope.
Use retained-output files when detail is evidence, result inventory, counts, excerpts, operational notes, long-lived state, or material reused by later owners.
Screen-rendered transport remains Communication Plane evidence.
The visible body uses only the canonical envelope shape from this file.
Canonical pointer labels such as `CARRIER`, `VERDICT`, `CRITIQUE`, or `REDIRECT` are allowed only as no-detail index labels; they do not carry receiver-required detail.

### Payload Fidelity
Communication payload is mission-critical internal evidence.
User non-display never permits loss, omission, distortion, or vague substitution of receiver-required information.
Transport carriers preserve exact user intent, `TARGET-INTENT-BASIS`, request-fit facts, acceptance basis, scope boundaries, constraints, assumptions, inferences, blocker truth, evidence pointers, and next owner/action when those facts are material to the receiving owner.
When exact wording, full evidence, result inventory, counts, excerpts, or operational notes are needed, carry them in retained carriers or retained-output and send the pointer through the owning message class.
A receiving owner consumes the governed carrier before acting; a screen-visible envelope or excerpt is not sufficient basis when the governed carrier is required.

### Assignment Delivery Contract
Team-lead owns assignment delivery for planned team-runtime work through `task-execution`.
Assignment delivery uses retained carrier identity plus assignment `SendMessage` delivery under one contract.
Lower packet surfaces consume this contract before tool calls instead of restating `SendMessage` tool-envelope field requirements.
List-style assignment tracking is removed from team-runtime assignment delivery.
Do not create, verify, update, repair, require, or close external tracking rows for assignment delivery, progress, ownership, receipt, completion, correction, reuse, or reroute.
Do not use external tracking rows, state mutation, host assignment notices, numeric row ids, or background-control surfaces as assignment identity, worker targeting, progress state, completion closure, correction basis, or evidence retrieval for team-runtime assignment work.
Assignment identity and delivery use the retained `CARRIER: <path>` pointer per `### Transport Payload`.
Completion closure uses the completion carrier plus `MESSAGE-CLASS: completion` `SendMessage` per `completion-handoff.md`.
Team-lead materializes the per-lane assignment carrier under the frozen `RETAINED-OUTPUT-PATH` after current-session team runtime registration and delivers it via the assignment-class `SendMessage` carrier pointer.
`SendMessage.to` carries the live worker target and assignment delivery.
Future-wave preparation uses the shared binding surface, shard map, or a non-dispatchable planning record until the target is assignment/reuse-addressable and assignment-grade `SendMessage` is the next executable action.
Legacy tracking rows, host notifications, or numeric row ids are ignored as non-authoritative runtime residue for assignment and completion truth.

### Receipt Event Contract
`dispatch-ack` is the assignment acceptance and immediate work-start state token inside the Communication Plane.
This contract preserves Communication Plane payload capacity.
Receiver-required execution detail travels through the assignment packet, phase-transition packet, shutdown request, retained-output carrier, lead-requested internal `status`, `scope-pressure`, `completion`, or `hold|blocker`, according to the owning message class.
A receipt event uses the canonical no-detail visible token `ack` only when the runtime requires a visible transport token.
The rendered receipt envelope is exactly visible token `ack` plus empty/single-space body.
Do not render shard id, lane id, `MESSAGE-CLASS`, carrier path, receipt explanation, work-start wording, or assignment-start prose in the visible `ack` envelope.
Any shard, lane, carrier, or assignment identity needed by team-lead stays in the governed carrier, runtime state, retained assignment map, or internal dispatch evidence.
The receiving owner interprets that token as `MESSAGE-CLASS: dispatch-ack`; envelope shape is governed by Transport Payload above.
Before `dispatch-ack`, the lane inspects the assignment packet for `WORK-SURFACE`, lane authority, required skills, decisive basis, and blocker truth.
`dispatch-ack` means the lane accepts the packet without team-lead correction, replan, authority change, or blocker clearance.
After sending `dispatch-ack`, the lane starts assigned work inside the same assignment execution block.
A packet executable only through safe lane-local inference may send `dispatch-ack` only when the inference changes no owner, phase, deliverable, proof/acceptance chain, staffing shape, agent boundary, parallel grouping, scope, source authority, closure row, disposition, consumer/recompute path, display-only status, or acceptance oracle.
A packet requiring team-lead correction before truthful start suppresses `dispatch-ack` and sends `scope-pressure`.
A packet blocked by missing or incoherent `WORK-SURFACE`, missing decisive basis, blocked environment, missing authority, or unsafe ambiguity suppresses `dispatch-ack` and sends `hold|blocker`.
`dispatch-ack`, `scope-pressure`, and `hold|blocker` do not coexist as first outcomes for the same packet.
Lane work states (`ACTIVE`/`STANDBY`) and dispatch-ack/completion transition semantics are owned by `.claude/skills/session-boot/references/runtime-state-detail.md` `## Agent Work States`.
The lane continues work until one closing class is sent.
The closing transport classes are `completion`, `scope-pressure`, and `hold|blocker`.
Closed work reopens only through distinct bounded `assignment`, `reuse`, or `reroute`.
Same `WORK-SURFACE` / `RETAINED-OUTPUT-PATH` replay is duplicate packet noise; team-lead consumes the retained carrier or sends distinct bounded work.
After a closing class, the lane stays silent for that closed work.
Closed-work replay stays silent for `status`, `clarification`, duplicate `completion`, and duplicate `dispatch-ack`.
A closed lane that discovers genuine post-completion defect evidence sends a distinct bounded `MESSAGE-CLASS: hold|blocker` whose governed carrier names the new evidence.
Team-lead routes the new evidence through corrected packet, reopened planning, or owner correction.
The lane drives its own continuation between intra-block turn boundaries without waiting for another team-lead prompt.
A valid `dispatch-ack` clears receipt and establishes no-objection assignment acceptance; later progress, work quality, completion, and acceptance require their own governed evidence.
Readiness, context-loaded, awaiting-assignment, skill-loading, file-read plan, retained-output plan, next-action, and progress messages stay outside `dispatch-ack`.

### Communication Integrity
Transport silence is allowed only when no receiver action, recovery, synthesis, or runtime cleanup decision depends on the message.
Transport content remains binding for the receiving owner even when it is not a user report.
Hooks and ledgers observe, gate, or record channel truth.
The owning message class, packet, completion packet, phase-transition packet, or shutdown request remains decisive over hook and ledger observations.
Plain text in a pane is observation evidence only until resent through the required transport or retained carrier.
A pane/final response containing `MESSAGE-CLASS`, `DISPATCH-ACK`, `COMPLETION-HANDOFF`, or equivalent transport headers is malformed raw Communication Plane leakage and leaves receipt, completion, status, pressure, or blocker transport unresolved.
Required transport-tool unavailability routes missing receipt through lead monitoring/recovery; visible text remains observation evidence only.
Use `Read` on the background output path when the runtime provides that path.

### Team Member Startup Recognition
In team-agent runtime, the team-scoped `Agent` prompt creates or reattaches a live member address; it is not the assignment-grade work packet.
The member startup prompt carries role and screen-safety only.
Default team-scoped member creation uses this exact prompt template: `Member: <name>. Role: <lane>. Screen-safety: visible emission requires reporting-prohibition-law admission.`
Only `<name>` and `<lane>` vary in the default template.
The startup prompt carries role and screen-safety only; `ready`, `context loaded`, `awaiting assignment`, `readiness ack`, `dispatch-ack`, `status`, `completion`, and every other upward message stay absent.
The spawn prompt restriction applies to upward Communication Plane transport and visible prose only.
Internal Procedure Plane action remains active.
Passive-wait phrasing in the spawn prompt (such as `do not load skills`, `do not read references`, or `do not use tools before assignment`) is a spawn-prompt defect.
Normal lane intake consumes the role file, lane-detail reference, and required skills through internal tool calls once the assignment SendMessage arrives.
Assignment-grade work begins only when `team-lead` sends an assignment-class `SendMessage` (`assignment`, `reuse`, or `reroute`) to the exact live member name with the structured payload limited to one carrier pointer object.
Lane intake treats the governed carrier referenced by that structured pointer as the authoritative assignment packet.
Only the authoritative assignment packet triggers `dispatch-ack`.
The authoritative assignment packet contains `MESSAGE-CLASS: assignment`, `reuse`, or `reroute` inside the governed carrier, never in the rendered `SendMessage` body.
If no assignment packet arrives, the lane waits without shard work and sends no startup readiness transport.
A startup-pane `online`, `ready`, or `awaiting packet` response is observation only and never satisfies `dispatch-ack`.
Standalone `Agent` prompts are fallback host evidence only when the route explicitly permits non-runtime evidence; they do not create team-runtime receipt debt.

## Structured Shutdown Request
Shutdown belongs to runtime cleanup; lane work state and `MESSAGE-CLASS` remain separate surfaces.
Team-lead or `session-closeout` sends `SendMessage(to: "<agent-name>", message: {"type":"shutdown_request"})` only to a live process-backed teammate selected for cleanup.
The structured shutdown payload is exact: no reason field, no free-form body, no `MESSAGE-CLASS`, and no carrier pointer is added to the rendered `message` body.
Cooperative `shutdown_request` executes on a runtime cleanup basis from `task-execution`, `session-boot`, or `session-closeout`; operator approval enters only when the path escalates to non-tmux force cleanup.
`tmux kill-*` remains unavailable as shutdown cleanup.
When transport remains available, the selected teammate returns `SendMessage(to: "team-lead", message: {"type":"shutdown_response"})` after accepting cleanup and before exit.
Worker-originated `shutdown_response` is cooperative cleanup evidence for runtime roster reconciliation; it is not assignment completion, proof, validation, or user report.
Missing `shutdown_response` keeps termination proof open until live-roster absence, `teammate_terminated`, or hook/runtime shutdown evidence resolves the teammate.
The teammate ceases accepting work and exits or is terminated by runtime cleanup.
Termination proof is live-roster absence, `teammate_terminated`, or hook/runtime shutdown evidence.
`TeamDelete` waits for termination proof for every live process-backed teammate.

## Upward Message Classes
Every class below is Communication Plane transport. The descriptions name when to use the class; receiver-required execution truth travels through non-rendered packets, retained-output, or retained carriers when size, evidence retention, reuse, or visible-render suppression requires it.

- `dispatch-ack`
  - acceptance and immediate work-start state signal; follows `Receipt Event Contract`
  - use only after the lane reviews the fresh assignment-grade packet and finds coherent `WORK-SURFACE`, lane authority, required skills, decisive basis, and no blocker requiring team-lead action
  - first upward outcome is mandatory: `dispatch-ack`, `scope-pressure`, or `hold|blocker`
  - after sending, continue inside the same assignment execution block across subsequent tool turns
  - newly discovered blockers after accepted intake use separate `scope-pressure` or `hold|blocker`
  - missing/incoherent `WORK-SURFACE` uses `hold|blocker`
  - missing fields route to `scope-pressure` or `hold|blocker`
  - if one bounded packet correction is required before truthful start, suppress `dispatch-ack` and send `scope-pressure`
  - if the defect prevents truthful execution even with narrow correction, suppress `dispatch-ack` and send `hold|blocker`
  - if the packet remains executable after explicit same-boundary inference that does not invent scope, closure rows, source authority, disposition, consumer/recompute, display-only, or acceptance-oracle basis, continue lane work and mark the inference
  - blocker detail travels through the governed carrier for the separate `scope-pressure` or `hold|blocker`
- `status`
  - internal progress only
  - send only when team-lead explicitly requested internal status
  - closure proof remains with cleanup evidence, completion evidence, or acceptance evidence
- `scope-pressure`
  - structured objection to workload, ownership split, hidden prerequisite, missing critical field, or burden contract
  - use when the agent rejects the packet as written while packet correction or replanning remains viable
- `completion`
  - completion-grade candidate only
  - use only after converged lane work has written the retained carrier required by `completion-handoff.md`
  - send to `team-lead` through `SendMessage`
  - requires converged lane-owned work
  - screen-rendered `SendMessage` header/preview is one state signal only: `completion`
  - the rendered completion envelope is exactly visible token `completion` plus empty/single-space body
  - do not render shard id, lane id, `MESSAGE-CLASS`, carrier path, result summary, acceptance wording, verification wording, synthesis wording, or completion-report prose in the visible `completion` envelope
  - any lane, carrier, proof, result, or acceptance identity needed by team-lead stays in the governed completion carrier, runtime state, retained assignment map, or internal dispatch evidence
  - envelope shape governed by Transport Payload above
  - completion-render content exclusion is governed by `.claude/reference/reporting-prohibition-law.md` `## Non-Reportable Content`
  - synthesis-ready only when the retained carrier satisfies `.claude/skills/task-execution/references/completion-handoff.md` Common Completion Result Spine
- `hold|blocker`
  - required when ambiguity, missing authority, blocked environment, or missing decisive basis prevents truthful execution
  - use as a separate blocked message class after receipt or intake when truthful lane execution is blocked
  - route unavailable decisive user-surface exercise through `hold|blocker`
  - if the blocker is an information request, team-lead must answer it through a corrected packet, reopened planning, or proven user-owned blocker
  - resolution requires blocker handling through a truthful next owner/action

### Agent Information Request Consumption
When an agent sends hold|blocker-class transport because decisive assignment basis is missing, team-lead must consume the governed blocker carrier before any re-dispatch, synthesis, completion claim, or user-facing positive report.
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
- If the agent names a missing evidence surface, required tool, setup owner, or current-toolchain gap, team-lead resolves it through `Skill(tool-acquisition)`, `Skill(external-tool-bridge)`, packet correction, or route replan.
- A usable lane-origin tool/evidence-gap blocker names the missing evidence surface, required capability, current toolset or toolchain limit, why weaker evidence is invalid, and smallest truthful boundary.
- Candidate tools considered, selected tool or program candidate, fit rationale, setup owner, and setup path are supplied by `Skill(tool-acquisition)` or `Skill(external-tool-bridge)` unless already known by the lane.
- If minimum lane blocker facts are missing, team-lead must request corrected blocker/pressure transport, route `Skill(tool-acquisition)` under the active owner path, or reopen `work-planning`.
- If only acquisition facts are missing, team-lead routes `Skill(tool-acquisition)` or `Skill(external-tool-bridge)` before requiring a corrected lane blocker.
- Missing basis becomes explicit packet correction, route replan, or blocker truth.
- A corrected packet is valid only when the same frozen route remains truthful and the missing setup/tool basis is explicit.
- Otherwise reopen `work-planning` to freeze `Skill(tool-acquisition)`, `Skill(external-tool-bridge)`, the exact setup owner, or a proven user-owned blocker.

The corrected packet must name the original blocker, the supplied field or correction, and the unchanged boundary.
`packet-correction` handling requires those names.
A lane recognizes a packet-correction only when an incoming assignment-class `SendMessage` points to a governed corrected packet carrying those explicit fields; absent that signal, the prior blocker remains unresolved and post-correction labels stay unavailable.
If one missing basis affects multiple assignments, correct the shared basis once.
Then send bounded corrected packets to every affected agent.
When one lane is blocked, keep unrelated independent lanes moving inside the frozen route.
For any blocked owner or lane constraint, the expected outcome is resumed execution.
Valid resume routes are method research, setup/tool bridge, packet correction, or owner split.
Then return the corrected executable path to the blocked owner or lane.
Treat the constraint transport as a resume-route trigger until a genuine impossible or unsafe condition is proven.

## Resolve Next Owner And Action
- `dispatch-ack` opens the same assignment execution block.
- Executable same-boundary packet correction opens corrected assignment messaging.
- `scope-pressure` opens team-lead classification as `packet-correction`, `route-replan`, `parallel-continue`, or proven user-owned blocker.
- `hold|blocker` opens team-lead blocker resolution through corrected packet, reopened planning, owner routing, setup/research routing, default, parameter, or marked inference path.
- `completion` opens completion-contract reconciliation and team-lead synthesis.
- `status` returns to monitoring or the active owner as progress evidence only.
- Available background output path opens `Read` as the output-read channel.
