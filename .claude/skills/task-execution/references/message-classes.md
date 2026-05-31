---
PRIMARY-OWNER: team-lead
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
- First Upward State-Signal Gate
- Problem Report Contract
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
- Only top-level `to` satisfies recipient targeting; recipient text inside `summary`, `message`, `content`, `description`, packet fields, or prose remains payload text.
- Missing or blank top-level `to` is tool-envelope invalid; correct the envelope before another `SendMessage`.
- In team-agent runtime, official assignment-work upward delivery requires governed Communication Plane transport; renderable `SendMessage` upward delivery is limited by `### First Upward State-Signal Gate`.
- Every fresh assignment-grade `SendMessage` in team-agent runtime requires a first upward resolution outcome unless upward transport was classified unsupported before dispatch.
- `problem-report` detail is a non-rendered nonclosing intake record: the lane found a concrete start problem and gives `team-lead` the receiver-required problem basis before choosing a visible no-detail state decision.
- A first upward `dispatch-ack` is the team-lead orchestration feedback signal: the lane reviewed the assignment packet, accepts it with no unresolved objection, and receives successful `SendMessage` delivery before assigned work starts.
- A first upward `scope-pressure` or `hold|blocker` state means the assigned work as written is not truthfully startable after any required `problem-report`.
- Unsupported upward transport is a dispatch-shape blocker before assignment send, not an after-the-fact excuse for idle without recovery.
- Treat plain-text output, pane output, and agent final prose as observation evidence only.
- Receipt proof and synthesis-ready subjob handoff use `SendMessage` only for the admitted visible tokens; cleanup evidence follows `## Structured Shutdown Request` and termination proof.
- Methodology skills identify blocker conditions.
- Message-class authority remains with this Communication Plane law.
- `subjob-done` without qualifier means `MESSAGE-CLASS: subjob-done` transport.
- `completion-grade` means retained-carrier sufficiency for downstream synthesis or closure.
- `status: completed` is task-row handoff state only.
- `reuse` as a `MESSAGE-CLASS` is assignment delivery; runtime reuse-fit is the monitoring decision that selects a live or standby teammate for that delivery.
- The active owner routes blocker detail through `problem-report` or governed carriers and sends `hold|blocker` only as the no-detail state decision.
- `status` is progress only.
- `MESSAGE-CLASS: subjob-done` is positive subjob-handoff transport only.
- `problem-report` is the required non-rendered problem-detail path before a lane resolves a detected issue to `dispatch-ack`, `scope-pressure`, or `hold|blocker`.
- `scope-pressure` is the structured objection state when the packet is directionally valid but unsafe as written.
- `hold|blocker` is the blocked state when truthful execution remains blocked after evidence-backed defaults, lawful reconstruction, and the narrow packet-correction route are exhausted.
- Procedure Plane blocker-routing is the owner state; lane blocker detail uses `problem-report`, internal carriers, or task state while the state token stays no-detail.
- Structured shutdown control is runtime cleanup traffic, not assignment-work upward delivery; `shutdown_response` is optional cooperative cleanup evidence under `## Structured Shutdown Request`, not a `MESSAGE-CLASS`.

## Canonical Channel Registry
The team-runtime data path has five channel families.
Each family names its tool surface, payload shape, owner reference, and next-action rule.
Tool envelope fields are actual top-level tool parameters only; governance packet fields live inside the tool's `prompt`, `message`, or `description` body, never as XML-style pseudo-parameters or packet lines inside another envelope field.
A prompt template governs the value of the `prompt` field only; it is not a complete tool envelope and cannot satisfy required top-level fields such as `description`, `team_name`, or `name`.
`SendMessage.to` is an actual top-level tool parameter.
No governed payload field can replace `SendMessage.to`.

| Family | Tool surface | Payload shape | Owner reference | Next-action rule |
|---|---|---|---|---|
| Runtime topology | `TeamCreate`, team-scoped `Agent`, `TeamDelete` | runtime creation, member creation/reattach with top-level `description`, `prompt`, `team_name`, and `name`; runtime deletion | `runtime-dispatch-law.md`; `session-closeout` closeout state | member-created truth, assignment-send next action, or closeout residual truth |
| Lead-directed work/control | `SendMessage` from `team-lead`, workflow owner, or `session-closeout` to exact live member | assignment, reuse, reroute, dispatch-recovery state-reconciliation follow-up, phase-transition-control, or `{"type":"shutdown_request"}` | `assignment-packet.md`; `phase-transition-control.md`; `dispatch-recovery.md`; this file | first upward outcome, recovery state decision, internal phase-context consumption without user-facing report, or cleanup-control evidence |
| Agent-to-lead state transport | `SendMessage` from lane agent to `team-lead` | no-detail `dispatch-ack`, `scope-pressure`, `hold|blocker`, or `subjob-done` state token | this file; `completion-handoff.md` | lane work, pressure/blocker resolution, or synthesis |
| Agent-to-lead problem/detail transport | non-rendered carrier, task state, runtime ledger, or evidence artifact; paired with the following no-detail `SendMessage` state token when a state decision is needed | `problem-report` class-native fields and bounded carrier pointers | this file | team-lead problem consumption, recovery, correction, or state-decision monitoring |
| Agent-to-lead internal carrier | retained carrier, task state, runtime ledger, or evidence artifact | receiver-required internal state and detail; no renderable `SendMessage` body | this file; `scope-pressure.md`; `completion-handoff.md` | monitoring, pressure/blocker resolution, or correction routing |
| Direct teammate interaction | teammate UI or peer `SendMessage` | user instruction inside current authority or challenger evidence note for active surface | `.claude/skills/team-session-sequences/references/monitoring-lifecycle-detail.md` | receiver uses evidence; ownership, routing, cleanup, task-control, acceptance, or active-surface changes route to `team-lead` |
| Shared task state | `TaskCreate`, `TaskUpdate`, `TaskGet`, `TaskList` | task row creation, status update, read, or list; never assignment delivery | this file `### Assignment Delivery Contract` | task correction, task identity recovery, retained-output `Read`, or completion status closure |
| Background task inspection/control | `TaskOutput`, `TaskStop` | background task output read or stop; never assignment delivery or completion truth | `runtime-dispatch-law.md`; this file `### Assignment Delivery Contract` | fallback evidence retrieval, background-task stop truth, or retained-output `Read` when available |

Task-list tools are task-state channels; background task tools are runtime inspection/control channels.
Agent communication uses `SendMessage` or teammate UI.
Direct `Agent` outside team runtime is fallback evidence outside Communication Plane channel families.
Assignment delivery, receipt, `problem-report`, status, `scope-pressure`, `hold|blocker`, subjob-done, reuse, and task-state truth require Communication Plane channels; state decisions use automatic no-detail `SendMessage` tokens.
Already-produced direct-Agent output from outside team runtime is fallback evidence consumed by `team-lead`, not lane transport.

## Communication Plane Law
This file owns agent-to-agent and agent-to-lead transport classes.
User-facing report admission is owned by `.claude/reference/reporting-prohibition-law.md`; admitted report shape is owned by `.claude/reference/reporting-user-reporting-law.md`.
Renderable assistant-authored transport fields remain under `.claude/reference/reporting-prohibition-law.md`; this file only defines the no-detail envelope that preserves internal transport without report content.
Screen suppression changes only the renderable projection; it never authorizes blanking, omitting, or replacing the receiver-consumable assignment, objection, completion, shutdown, or correction payload.

### Plane Boundary
`SendMessage`, teammate UI, `problem-report`, `dispatch-ack`, `status`, `scope-pressure`, `subjob-done`, `hold|blocker`, assignment packets, phase-transition packets, shutdown requests, shutdown responses, task rows, task output, runtime ledgers, and retained-output pointers are Communication Plane transport.
Communication Plane transport is addressed to an internal owner.
Communication Plane transport never satisfies a user report.
Procedure Plane consumes transport evidence before synthesis, correction, recovery, or validation movement.
Reporting Plane may cite only the user-relevant outcome granted a narrow exception by `.claude/reference/reporting-prohibition-law.md` and shaped by `.claude/reference/reporting-user-reporting-law.md`.

### First Upward State-Signal Gate
This category is the direct citation target for lane receipt/start, pressure/blocker, and subjob-handoff visible state signals.
Role files and lane surfaces cite this category instead of citing the whole message-class document for start-signal behavior.
The only automatic screen state signals admitted by this category are exactly `dispatch-ack`, `scope-pressure`, `hold|blocker`, and `subjob-done`.
When the `SendMessage` schema exposes `summary`, `summary` is the canonical visible state-signal slot.
Accepted assignment start emits exactly one visible token by sending `summary: dispatch-ack`.
Correctable unsafe intake emits exactly one visible token by sending `summary: scope-pressure` after the required `problem-report`.
Blocked intake emits exactly one visible token by sending `summary: hold|blocker` after the required `problem-report`.
Completed subjob handoff emits exactly one visible token by sending `summary: subjob-done`.
For those four state signals, omit the `message` body when possible and use empty or single ASCII space only when the schema requires a body.
For one executable assignment identity, `dispatch-ack` emits at most once before long-running lane work and `subjob-done` emits exactly once after completion.
Do not put `dispatch-ack`, `scope-pressure`, `hold|blocker`, or `subjob-done` in a string `message` body.
Do not send a string `message` state token without `summary`; Claude Code rejects string messages without `summary`, and repair prose becomes avoidable screen pollution.
If a host-rendered row or prompt line already displays the allowed state token from `summary`, omit the assistant-authored `message` body unless the schema requires it; if required, use empty or single ASCII space. Pane text and final text are omitted.
Do not add the token, stage text, or punctuation filler a second time.
If a runtime lacks `summary` but has another single visible slot, put the bare class token in that one slot, omit every other renderable field when possible, and use empty or single ASCII space only inside non-omittable fields.
If the schema rejects an empty body after the required token exists in `summary` or another single visible slot, use single ASCII space.
If single ASCII space is rejected, route tool-schema mismatch through task-execution correction instead of emitting punctuation filler.
Visible state tokens with task suffixes, field labels, packet fields, result text, punctuation, or any other detail are malformed transport display.
Long-running lane work starts only after `SendMessage` returns successful `dispatch-ack` transport; bounded same-block packet review plus completion may instead return completion-grade `subjob-done` as the first upward outcome.
Failed, schema-rejected, or visibly malformed `dispatch-ack` attempts leave the lane in receipt-pending state; the only next action is non-rendered `problem-report` when a concrete problem exists, corrected no-detail `dispatch-ack`, no-detail `scope-pressure`, or no-detail `hold|blocker`, not assigned work.
The exact correction for `summary is required when message is a string` is `SendMessage(to: team-lead, summary: dispatch-ack, message: " ")` with no explanatory pane/final prose.
Long-running work performed after a failed `dispatch-ack` attempt and before successful `dispatch-ack` transport is pre-receipt work; team-lead treats it as order-defect evidence, not valid active-lane execution.
After successful `dispatch-ack`, the lane starts assigned work inside the same assignment execution block without waiting for another prompt.
The visible body excludes state tokens, `MESSAGE-CLASS`, field labels, receiver-required detail, and report prose; only the visible state-signal slot may contain `dispatch-ack`, `scope-pressure`, `hold|blocker`, or `subjob-done`.

### Transport Payload
Communication payload carries the detail required by the receiving owner through the active envelope plus governed carriers.
Payload shape is governed by the active message class, assignment packet, completion contract, phase-transition packet, shutdown request, non-rendered task state, or retained-output contract.
Receiver-required detail stays complete regardless of user-display suppression.
When `SendMessage` can render on a user-visible screen, visible fields obey `.claude/reference/reporting-prohibition-law.md` before rendering; admitted report prose shape follows `.claude/reference/reporting-user-reporting-law.md`.
First upward state-signal envelope and receipt-before-work behavior are governed by `### First Upward State-Signal Gate`.
Task identity, assignment class, carrier pointers, findings counts, file paths, evidence summaries, result previews, and completion narrative stay in non-rendered task state, assignment evidence, or retained carriers.
Only the four admitted state-signal tokens may occupy worker-originated visible `SendMessage` state fields.
`problem-report` carries class-native problem fields to `team-lead` only through non-rendered carrier, task state, runtime ledger, or evidence artifact; it is not a visible `SendMessage` state field, state decision, receipt-clearance signal, pane response, or final prose.
`status`, blocker-clear, blocker retraction, blocker correction, resume/proceeding notes, and next-transport notes have no worker-originated visible token and must not appear in `summary`, string `message`, pane text, or final prose.
If another internal state requires user-facing disclosure, `team-lead` consumes the internal carrier or task state first, then reports only through a reporting-law admission.
This is the single canonical envelope rule for upward state signals; other owner surfaces cite this rule and keep local restatement out.
Lane, role, and agent-specific skill surfaces that say send, emit, route, raise, or report `problem-report`, `scope-pressure`, `hold|blocker`, `dispatch-ack`, `status`, or `subjob-done` are interpreted through this Transport Payload rule.
Those local surfaces may name class-specific carrier facts, but they must not restate or override visible envelope shape.
Receiver-required detail moves to the assignment packet, non-rendered task state, retained-output file, shutdown request, shutdown response, runtime ledger, or evidence artifact referenced by that envelope.
Use retained-output files or task output when detail is evidence, result inventory, counts, excerpts, operational notes, long-lived state, or material reused by later owners.
Screen-rendered transport never satisfies a user report and never carries raw internal inventories.

### Intake Problem Report Contract
When a lane detects a concrete intake, runtime, packet, authority, tool, or evidence problem before choosing `dispatch-ack`, `scope-pressure`, or `hold|blocker`, it first records `MESSAGE-CLASS: problem-report` in a receiver-consumable non-rendered carrier, task state, runtime ledger, or evidence artifact when that channel is available.
`problem-report` is nonclosing Communication Plane evidence and does not clear the receipt barrier.
`problem-report` carries only receiver-required fields: `PROBLEM-TYPE`, `PROBLEM-BASIS`, `AFFECTED-ACTION`, `ATTEMPTED-RECOVERY`, `CAN-CONTINUE`, `NEXT-STATE`, and `SMALLEST-NEXT-OWNER-ACTION`.
`NEXT-STATE` is one of `dispatch-ack`, `scope-pressure`, or `hold|blocker`.
`NEXT-STATE` is the lane's current-packet state decision only; it never delegates downstream owner selection, recovery choice, or next-work planning to the worker.
If `CAN-CONTINUE: yes`, the lane sends no-detail `dispatch-ack` after recording the problem report and starts work from the corrected or recovered basis.
If `CAN-CONTINUE: needs-correction`, the lane sends no-detail `scope-pressure` after recording the problem report and stops only the unsafe packet execution attempt.
If `CAN-CONTINUE: no`, the lane sends no-detail `hold|blocker` after recording the problem report and preserves the smallest safe next owner/action in the problem report.
If a problem is discovered and resolved before state selection, `problem-report` records the resolution basis before `dispatch-ack`; the lane does not send visible `problem-report`, `retract`, `disregard`, `proceeding`, `ready`, or resume prose.
If no receiver-consumable non-rendered problem channel is available, the lane sends only the no-detail state token and team-lead recovers from runtime evidence, corrected packet, re-dispatch, or blocker-routing; it does not send visible problem detail.

### Internal Carrier Objection Channel
Use retained carriers, declared `WRITE-SCOPE`, task state, runtime ledgers, or evidence artifacts for objection detail whenever detail is needed by `team-lead`.
Class-native `problem-report` fields must remain receiver-consumable through non-rendered channels; screen suppression never permits private memory as the only carrier.
If no receiver-consumable carrier path exists and the problem detail is needed for `team-lead` to act, send only the no-detail state token and let team-lead recover by corrected packet, runtime evidence, re-dispatch, or blocker-routing; do not send visible `problem-report` detail through `SendMessage`.
If task tracking is active, any task mutation remains render-safe identity/status only; task subject/description do not carry blocker detail, paths, counts, or evidence summaries.
Team-lead clears the receipt or continuation barrier from `dispatch-ack`, `scope-pressure`, `hold|blocker`, or completion-grade `subjob-done`, and consumes non-rendered `problem-report` or carrier evidence when available before executing packet correction, blocker resolution, replanning, or recovery.
Team-lead owns the next recovery or continuation action after `problem-report`, `scope-pressure`, or `hold|blocker`; workers preserve evidence and state, not downstream work selection authority.

### Payload Fidelity
Communication payload is mission-critical internal evidence.
User non-display never permits loss, omission, distortion, or vague substitution of receiver-required information.
Transport carriers preserve exact user intent, `TARGET-INTENT-BASIS`, request-fit facts, acceptance basis, scope boundaries, constraints, assumptions, inferences, blocker truth, evidence pointers, and next owner/action when those facts are material to the receiving owner.
Summaries are routing aids only; they do not replace exact packet, task, or retained-output basis when downstream execution, synthesis, proof, or validation depends on the exact basis.
When exact wording, full evidence, result inventory, counts, excerpts, or operational notes are needed, carry them in non-rendered task state or retained-output and send the pointer through the owning message class.
A receiving owner consumes the governed carrier before acting; a screen-visible envelope or excerpt is not sufficient basis when the governed carrier is required.

### Assignment Delivery Contract
Team-lead owns assignment delivery for planned team-runtime work through `task-execution`.
Assignment delivery joins shared task-state identity and assignment `SendMessage` delivery under one contract.
Lower packet surfaces consume this contract before tool calls instead of restating `TaskCreate` or `SendMessage` tool-envelope field requirements.
Task tracking is inactive by default for team-runtime assignment receipt; assignment identity travels through the assignment packet, retained assignment carrier, non-rendered task state, runtime ledger, or returned tool evidence unless the frozen route explicitly requires host task-list identity.
Task tracking is active only when the frozen route requires host task-list identity and current host rendering preserves the exact no-detail state-signal envelope.
If host rendering appends task id, task subject, description, or other task-row identity to `dispatch-ack`, `scope-pressure`, `hold|blocker`, or `subjob-done`, task tracking is screen-unsafe for that run; stop creating pre-assignment task rows, carry assignment identity through non-rendered carriers/runtime state, and treat the decorated state-signal row as malformed transport display.
When task tracking is active, team-lead creates or verifies the task row after current-session team runtime registration and before assignment-grade `SendMessage`.
`TaskCreate` uses top-level non-empty `subject`; when the host schema requires `description`, use compact identity-only text.
Default render-safe task row shape is a compact operator-facing assignment identity such as `gov-audit SH-05/08`, `review shard-2`, `test surface-1`, or `validate final`; avoid generic subjects such as `work-item` when a stable shard, surface, phase, or bounded assignment label is available. `description` is omitted when optional; when required, it uses compact identity-only text and never empty or single ASCII space.
The task row supplies `TASK-ID` identity only.
Renderable `TaskCreate.subject` and `TaskCreate.description` must not carry assignment packet fields, `MESSAGE-CLASS`, `RETAINED-OUTPUT-PATH`, `WRITE-SCOPE`, evidence summaries, counts, route topology, target/member assignment detail, retained-carrier pointers, blocker detail, problem detail, or completion detail.
When task-state files are used as governed carriers, their renderable task-row projection remains identity-only.
`SendMessage.to` carries the live worker target.
Assignment delivery requires both the exact live-worker envelope and a receiver-consumable assignment packet in the same execution move.
Screen suppression never converts assignment delivery into a blank or whitespace-only `SendMessage`.
When assignment `SendMessage` content can render, assistant-authored visible fields are omitted when possible and use empty or single ASCII space only inside non-omittable fields, and the complete packet must be available through a receiver-consumable non-rendered runtime field, non-rendered task state, retained assignment carrier, or runtime-owned evidence before the send.
For write-producing assignment, reuse, or reroute packets, receiver-consumable packet availability requires the retained-output collision preflight owned by `assignment-packet.md`; existing output files, output probes, or directory creation do not satisfy assignment-send evidence.
If no receiver-consumable packet body or carrier exists, team-lead corrects the packet delivery path before `SendMessage`; it does not leak packet detail and does not send an empty placeholder as assignment delivery.
Neutral task rows, output directories, retained-output probes, absent output carriers, no-op commands, empty or whitespace-only `SendMessage`, and member creation are not assignment delivery and are not assignment-send evidence.
Task rows are not authoritative assignment-owner, assignee, result-truth, synthesis-acceptance, or reuse-eligibility surfaces.
Visible task status is a team-lead orchestration aid and best-effort assignment-block lifecycle mirror for the same `TASK-ID`; keep it current and use it for monitoring, but reconcile it against transport and retained-carrier acceptance before any synthesis, reuse, correction, or final-result claim.
When task tracking is active, the owner of each lifecycle transition attempts the matching `TaskUpdate` on the same `TASK-ID` in the same execution block as the transition, without delaying to batch reconciliation:
- after assignment-grade `SendMessage` succeeds and work remains open, keep or set the same task row to the host-supported open/in-progress state when such a status is available;
- after `scope-pressure` or `hold|blocker`, record the pressure/blocker detail in non-rendered state and update only a host-supported non-completion status when available; do not encode blocker detail in task subject/description;
- after producer-side carrier proof and governed `subjob-done`, set `status: completed` on the same assigned task immediately.
If the host lacks a visible status for the transition, record the transition in non-rendered task state, runtime ledger, retained carrier, or transport truth immediately; do not invent status words in renderable task fields.
If task status conflicts with transport or retained-carrier truth, team-lead treats it as a task-state synchronization gap and reconciles the same `TASK-ID` when a host-supported mutation exists; it does not rerun completed work, reopen a completed assignment, or treat the row alone as result truth.
After render, do not change task owner, assignee, subject, or description to repair monitoring display, detach a lane, or reuse a row. Correct only pre-send identity mistakes; otherwise leave the row as historical assignment identity and use governed transport/carriers for truth.
That task-row completion records the producing lane's internal handoff closure only; it is not team-lead synthesis acceptance, final verification, final user report admission, or assignment-result proof without the retained carrier.
Task-scoped tools use exact task identity from `task_assignment`, `TaskList`, `TaskGet`, returned task mutation evidence, or the task file.
Unknown, guessed, pre-team, lead-local, next-numeric, same-batch planned-but-not-returned, completed, closed, cancelled, or missing ids are not executable assignment identity.
`TaskOutput` and retained-output reads may use completed task identity only as evidence retrieval, not as a new assignment basis.

### Lead Recovery Follow-Up Contract
A dispatch-recovery follow-up is state-reconciliation control for an already-sent assignment identity; it is not assignment delivery, reuse, reroute, packet correction, work command, progress prompt, or completion command.
Team-lead sends a dispatch-recovery follow-up only when `.claude/skills/task-execution/references/dispatch-recovery.md` or `.claude/skills/session-boot/references/runtime-state-detail.md` classifies the target into a recovery row that permits the one bounded follow-up.
The follow-up preserves the current assignment identity: same live target, `TASK-ID`, `WORK-SURFACE`, `RETAINED-OUTPUT-PATH`, and `WRITE-SCOPE`.
The follow-up may request only the missing current state decision or state evidence: missing `dispatch-ack`, missing post-`problem-report` `dispatch-ack`/`scope-pressure`/`hold|blocker`, start/activity evidence, explicit `status` when requested by team-lead, `scope-pressure`, or `hold|blocker`.
The follow-up must not contain the original assignment packet, a new assignment packet, changed packet fields, a new retained-output path, a new write scope, `proceed`, `continue`, `do the work`, `send subjob-done`, completion instruction, result-shaping instruction, or any phrase that can be executed as a second work assignment.
Receiver-required follow-up detail travels through non-rendered task state, runtime ledger, or retained carrier when needed; renderable fields follow reporting-prohibition omission and schema-required body rules and never carry natural-language prompts.
If the needed recovery content changes any assignment field or supplies missing executable basis, route it as packet correction, `assignment`, `reuse`, or `reroute` under this file and `dispatch-recovery.md`; do not disguise it as a follow-up.
If prior assignment send evidence is absent, return to the assignment-delivery path after duplicate side-effect risk is checked; do not use a follow-up as a packet resend.
If prior assignment send evidence exists, a follow-up does not reopen `dispatch-ack` or `subjob-done` idempotency for an identity that already emitted either token.
Lane recipients treat a duplicate same-identity assignment, proceed prompt, or completion prompt as replay evidence and follow `### Receipt Event Contract` idempotency instead of emitting duplicate visible state tokens.

### Receipt Event Contract
`dispatch-ack` is the assignment acceptance and immediate work-start state token inside the Communication Plane.
It is not a work-start report and carries no user-facing start content.
This contract preserves Communication Plane payload capacity.
Receiver-required execution detail travels through the assignment packet, phase-transition packet, shutdown request, non-rendered task state, retained-output carrier, non-rendered `problem-report`, `status` when lead-requested, `scope-pressure`, `subjob-done`, or `hold|blocker`, according to the owning message class.
A receipt event uses `dispatch-ack` transport governed by Transport Payload above; the visible token is exactly `dispatch-ack`.
The receiving owner interprets the governed receipt as `MESSAGE-CLASS: dispatch-ack`.
Before `dispatch-ack`, the lane inspects the assignment packet for `WORK-SURFACE`, required task state, lane authority, full-body load-and-learned required skills, decisive basis, and blocker truth.
When that inspection finds a concrete problem, the lane records non-rendered `problem-report` before choosing `dispatch-ack`, `scope-pressure`, or `hold|blocker` when a receiver-consumable non-rendered channel is available.
`dispatch-ack` means the lane accepts the packet with no unresolved team-lead correction, replan, authority change, or blocker clearance.
`dispatch-ack` is required team-lead feedback for orchestration and monitoring before long-running assigned lane work starts.
`dispatch-ack` is edge-triggered for assignment acceptance; after it is visible or ledger-recorded for the current assignment identity, the lane must not send another visible `dispatch-ack` for that identity.
Agent-start evidence, side effects, pane activity, or runtime liveness never replaces missing `dispatch-ack`.
The start-before-work barrier is governed by `### First Upward State-Signal Gate`.
When packet review plus bounded lane work already completed inside that same execution block, completion-grade `subjob-done` may be the first upward outcome and no separate `dispatch-ack` is required.
A packet executable only through safe lane-local inference may emit `dispatch-ack` only when the inference changes no owner, phase, deliverable, proof/acceptance chain, staffing shape, agent boundary, parallel grouping, scope, source authority, closure row, disposition, consumer/recompute path, display-only status, or acceptance oracle.
A packet requiring team-lead correction before truthful start first records non-rendered `problem-report` when available, then suppresses `dispatch-ack` and sends no-detail `scope-pressure` only after same-boundary intake-stage evidence-backed defaults or lawful reconstruction cannot start work safely.
A packet blocked by missing or incoherent `WORK-SURFACE`, missing/non-open required `TASK-ID`, missing decisive basis, blocked environment, missing authority, or unsafe ambiguity first records non-rendered `problem-report` when available, then suppresses `dispatch-ack` and sends no-detail `hold|blocker` only after same-boundary intake-stage evidence-backed defaults, lawful reconstruction, and narrow packet-correction routes cannot restore truthful start.
Quiet Bash success, `No output`, suppressed stdout, folded tool rows, or stdout-based connectivity probes under `.claude/reference/work-runtime-boundary-law.md` `### Bash Internal Evidence Capture Contract` do not prove `blocked environment`; blocked-environment state requires explicit tool error, timeout, cancellation, permission denial, or absence of a completed tool-call result.
Non-rendered `problem-report` may precede the intake decision for the same packet.
For the same assignment intake decision, `dispatch-ack`, `scope-pressure`, and `hold|blocker` are mutually exclusive.
For long-running lane work, `subjob-done` follows only after successful `dispatch-ack` and completed lane work; bounded same-block packet review plus completion may instead use completion-grade `subjob-done` as the first upward outcome.
Lane work states (`ACTIVE`/`STANDBY`) and dispatch-ack/subjob-done transition semantics are owned by `.claude/skills/session-boot/references/runtime-state-detail.md` `## Agent Work States`.
The lane continues work until one current-packet closing class is sent.
The current-packet closing transport classes are `subjob-done`, `scope-pressure`, and `hold|blocker`.
For `scope-pressure` and `hold|blocker`, closure applies only to the unsafe packet execution attempt; same-request duty remains live with the receiving owner until corrected packet, reopened planning, owner route, setup/research/tool path, marked inference/default, parallel continuation, proven user-owned blocker, or blocker-routing with exhausted internal recovery basis and next safe owner/action.
Closed packet work reopens only through distinct bounded `assignment`, `reuse`, or `reroute` carrying new defect evidence, correction basis, or blocker basis.
A visible state token is edge-triggered and idempotent for the current sender plus assignment identity: `TASK-ID`, `WORK-SURFACE`, and `RETAINED-OUTPUT-PATH`.
After `dispatch-ack` is visible or ledger-recorded for that identity, the lane must not send another visible `dispatch-ack` for that identity.
After `subjob-done` is visible or ledger-recorded for that identity, the lane must not send another visible `subjob-done` for that identity.
Same `TASK-ID` / `WORK-SURFACE` / `RETAINED-OUTPUT-PATH` replay after `subjob-done` routes through retained carrier, task state, runtime ledger, non-rendered `problem-report`, or distinct bounded work.
Closed-packet replay sends no additional transport for `status`, `clarification`, duplicate `subjob-done`, and duplicate `dispatch-ack`.
A closed lane that discovers genuine post-subjob defect evidence or malformed subjob-done evidence records non-rendered `problem-report` with the new evidence when available, then waits for team-lead correction or distinct bounded work.
Team-lead routes the new evidence through corrected packet, reopened planning, or owner correction.
The lane drives its own continuation between intra-block turn boundaries without waiting for another team-lead prompt.
A valid `dispatch-ack` is successful governed transport, clears receipt, and establishes no-unresolved-objection assignment acceptance; later progress, work quality, completion, and acceptance require their own governed evidence.
Readiness, context-loaded, awaiting-assignment, skill-loading, file-read plan, retained-output plan, next-action, and progress messages stay outside `dispatch-ack`.
Detailed intake confirmation inside a rendered `dispatch-ack` is not stronger receipt evidence; it is Communication Plane leakage and opens packet/transport correction while the lane continues only from governed packet and carrier truth.

### Communication Integrity
Transport silence is allowed only when no receiver action, recovery, synthesis, or runtime cleanup decision depends on the message.
Transport content remains binding for the receiving owner even when it is not a user report.
Hooks and ledgers observe, gate, or record channel truth.
The owning message class, packet, completion packet, phase-transition packet, or shutdown request remains decisive over hook and ledger observations.
Plain text in a pane is observation evidence only until resent through the required transport or retained carrier.
A pane/final response containing `MESSAGE-CLASS`, `DISPATCH-ACK`, `SUBJOB-DONE`, `COMPLETION-HANDOFF`, or equivalent transport headers is malformed raw Communication Plane leakage and leaves receipt, subjob-done, status, pressure, or blocker transport unresolved.
Required transport-tool unavailability routes missing receipt or missing closing transport through lead monitoring/recovery; visible text remains observation evidence only.
Task identity, `TaskCreate` field requirements, executable assignment identity, and `TaskUpdate` closure are owned by `### Assignment Delivery Contract`.
Use `Read` on the background task output path when the runtime provides that path.

### Team Member Startup Recognition
In team-agent runtime, the team-scoped `Agent` prompt creates or reattaches a live member address; it is not the assignment-grade work packet.
The member startup prompt is the `prompt` field value only; the team-scoped `Agent` call still requires the actual top-level envelope fields named by the Canonical Channel Registry and `runtime-dispatch-law.md`.
Default team-scoped member creation uses this exact prompt template: `Member: <name>. Role: <lane>. Screen-safety: no visible prose from this member-creation prompt.`
Only `<name>` and `<lane>` vary inside the default `prompt` template.
The top-level `description` is a compact render-safe member identity label; it never carries assignment packet fields, evidence summaries, counts, paths, route topology, progress, blocker detail, or completion detail.
The startup prompt carries role and screen-safety only; `ready`, `context loaded`, `awaiting assignment`, `readiness ack`, `dispatch-ack`, `status`, `subjob-done`, and every other upward message stay absent.
The spawn prompt restriction applies to upward Communication Plane transport and visible prose only.
Internal Procedure Plane action remains active.
Passive-wait phrasing in the spawn prompt (such as `do not load skills`, `do not read references`, or `do not use tools before assignment`) is a spawn-prompt defect.
Normal lane intake consumes the role file, lane-detail reference, and required skills through internal tool calls once the assignment SendMessage arrives; required skills use full-body load-and-learn and applied-basis recording before execution.
Assignment-grade work begins only when `team-lead` sends `SendMessage` with `MESSAGE-CLASS: assignment`, `reuse`, or `reroute` to the exact live member name.
Lane intake treats the `SendMessage` assignment body or its retained assignment carrier pointer as the assignment packet.
The system-generated `task_assignment` notification carries `TASK-ID` and a brief subject for task identity only.
It is not an authoritative assignment packet.
If only a `task_assignment` notification, identity-only task row, blank task description, empty/whitespace `SendMessage`, or absent output/carrier state exists and no assignment-grade `SendMessage` body or retained assignment carrier exists, the lane remains pre-assignment silent; it does not send `dispatch-ack`, `scope-pressure`, `hold|blocker`, status, readiness, or packet-empty diagnostics.
An identity-only task row, blank task description, empty/whitespace `SendMessage`, or absent retained-output file is not a malformed assignment packet; it is pre-assignment state until an authoritative assignment packet arrives.
Only the authoritative assignment packet triggers `dispatch-ack`.
The authoritative assignment packet is the `SendMessage` body with `MESSAGE-CLASS: assignment` or the retained assignment carrier named by that body.
When both arrive, the lane treats the `SendMessage` body or named retained carrier as authoritative and uses `task_assignment` only to confirm `TASK-ID`.
If no assignment packet arrives, the lane waits without shard work and sends no startup readiness transport.
A startup-pane `online`, `ready`, or `awaiting packet` response is observation only and never satisfies `dispatch-ack`.
Direct `Agent` prompts outside team runtime are fallback host evidence only when the route explicitly permits non-runtime evidence; they do not create team-runtime receipt debt.

## Structured Shutdown Request
Shutdown belongs to runtime cleanup/control; lane work state and `MESSAGE-CLASS` remain separate surfaces.
Team-lead or `session-closeout` sends `SendMessage(to: "<agent-name>", message: {"type":"shutdown_request"})` only to a live process-backed teammate selected for cleanup, reuse-cap release, agent-count management, or session teardown.
Cooperative `shutdown_request` executes on a runtime cleanup basis from `task-execution`, `session-boot`, or `session-closeout`; operator approval enters only when the path escalates to non-tmux force cleanup.
`tmux kill-*` remains unavailable as shutdown cleanup.
When transport remains available and the selected teammate can respond before exit, it may return `SendMessage(to: "team-lead", message: {"type":"shutdown_response"})` after accepting cleanup.
Worker-originated `shutdown_response` is an optional cooperative cleanup sign for faster runtime roster reconciliation; it is not assignment completion, proof, validation, a required work reply, or user report.
Missing `shutdown_response` does not create assignment-work blockage; cleanup truth remains open until live-roster absence, `teammate_terminated`, or hook/runtime shutdown evidence resolves the teammate.
The teammate ceases accepting work and exits or is terminated by runtime cleanup.
Termination proof is live-roster absence, `teammate_terminated`, or hook/runtime shutdown evidence.
`TeamDelete` opens only after termination proof for every live process-backed teammate; absent proof routes to `session-closeout` warning, runtime recovery, or blocker-routing with cleanup owner/action instead of passive waiting.

## Upward Message Classes
Every class below is Communication Plane transport. The descriptions name when to use the class; receiver-required execution truth travels through non-rendered packets, non-rendered task state, retained-output, or retained carriers when size, evidence retention, reuse, or visible-render suppression requires it.
Structured shutdown response is cleanup/control evidence under `## Structured Shutdown Request`, not an upward assignment-work message class.

- `dispatch-ack`
  - acceptance and immediate work-start state signal; follows `Receipt Event Contract`
  - use only after the lane reviews the fresh assignment-grade packet and finds coherent `WORK-SURFACE`, required task state, lane authority, full-body load-and-learned required skills, decisive basis, and no unresolved blocker requiring team-lead action
  - first upward resolution outcome is mandatory: no-detail `dispatch-ack` before long-running lane work, completion-grade `subjob-done` when packet review plus bounded lane work completes in the same execution block, or no-detail `scope-pressure` / `hold|blocker` when truthful start is blocked; non-rendered `problem-report` may precede that outcome when a problem was detected
  - after sending, continue inside the same assignment execution block across subsequent tool turns
  - newly discovered blockers after accepted intake record non-rendered `problem-report` before no-detail `scope-pressure` or `hold|blocker` when team-lead needs the problem basis and a non-rendered channel is available
  - missing/incoherent `WORK-SURFACE` uses non-rendered `problem-report` plus no-detail `hold|blocker` only after lawful reconstruction cannot identify the assigned surface without inventing scope
  - missing/non-open required `TASK-ID` uses non-rendered `problem-report` plus no-detail `scope-pressure` or `hold|blocker` only after task identity recovery cannot restore an executable task identity
  - missing fields route through non-rendered `problem-report` plus no-detail `scope-pressure` or `hold|blocker` only after packet-carried or governance-authorized defaults or lawful reconstruction cannot satisfy them inside the lane boundary
  - if one bounded packet correction is required before truthful start after default/reconstruction checks, suppress `dispatch-ack` and record non-rendered `problem-report` plus no-detail `scope-pressure`
  - if the defect prevents truthful execution even with default, reconstruction, and narrow correction routes, suppress `dispatch-ack` and record non-rendered `problem-report` plus no-detail `hold|blocker`
  - if the packet remains executable after explicit same-boundary inference that does not invent scope, closure rows, source authority, disposition, consumer/recompute, display-only, or acceptance-oracle basis, continue lane work and mark the inference
  - blocker text travels through non-rendered `problem-report` fields or governed carriers, not the state token
  - rendered envelope, when present, must contain only the canonical no-detail token from Transport Payload
  - a later blocker after valid `dispatch-ack` does not authorize visible blocker, retraction, resume, or progress prose; those facts remain internal carrier state until `subjob-done` or a reporting-law-admitted team-lead report
- `problem-report`
  - nonclosing problem-detail record for `team-lead`
  - record in non-rendered carrier, task state, runtime ledger, or evidence artifact before `dispatch-ack`, `scope-pressure`, or `hold|blocker` whenever a concrete problem was detected and the problem basis is needed for team-lead recovery, monitoring, or later verification
  - required fields: `PROBLEM-TYPE`, `PROBLEM-BASIS`, `AFFECTED-ACTION`, `ATTEMPTED-RECOVERY`, `CAN-CONTINUE`, `NEXT-STATE`, and `SMALLEST-NEXT-OWNER-ACTION`
  - `CAN-CONTINUE: yes` requires the next state token to be `dispatch-ack`
  - `CAN-CONTINUE: needs-correction` requires the next state token to be `scope-pressure`
  - `CAN-CONTINUE: no` requires the next state token to be `hold|blocker`
  - does not clear receipt, start work, close the packet, replace retained completion evidence, or authorize user-facing prose
  - never render the problem fields in visible `SendMessage` summary/body, pane text, or final prose
  - if the problem basis is large or long-lived, carry the full basis in a governed carrier and keep any non-rendered `problem-report` index bounded to the fields above plus the carrier pointer
- `status`
  - internal progress only
  - record in non-rendered carrier, task state, runtime ledger, or evidence artifact only when team-lead explicitly requested status
  - no visible state token is defined for `status`
  - closure proof remains with cleanup evidence, subjob-done evidence, or acceptance evidence
- `scope-pressure`
  - no-detail structured objection state after `problem-report`
  - use when the agent rejects the packet as written while packet correction or replanning remains viable
  - receiver-required detail travels through the preceding `problem-report`, `scope-pressure.md`, retained carrier, task state, or runtime ledger
  - stale or corrected `scope-pressure` state is resolved by carrier correction, packet correction, route replan, or continued lane execution; visible retraction/proceeding prose is malformed transport display
- `subjob-done`
  - completion-grade candidate only
  - use only after converged lane work has written the retained carrier required by `completion-handoff.md`
  - send to `team-lead` through `SendMessage`
  - requires converged lane-owned work
  - creates `STANDBY` and reuse eligibility only after retained-carrier acceptance passes under `completion-handoff.md`
  - screen-rendered transport contains exactly one token-only `subjob-done` signal under Transport Payload
  - envelope shape governed by Transport Payload above
  - `subjob-done` is not a user-facing work-completion report; it carries no stage-completion prose, result preview, acceptance statement, or summary in renderable fields
  - no files-read counts, findings counts, per-class totals, excerpts, evidence summaries, operational notes, completion narrative, path-substitution rationale, next-step prose, or retained-output contents in the `SendMessage` render
  - synthesis-ready only when the retained carrier satisfies `.claude/skills/task-execution/references/completion-handoff.md` Common Completion Result Spine
- `hold|blocker`
  - required when ambiguity, missing authority, blocked environment, or missing decisive basis prevents truthful execution after evidence-backed defaults, lawful reconstruction, and narrow correction routes are exhausted
  - use as a no-detail blocked state after non-rendered `problem-report` when truthful lane execution is blocked and a non-rendered problem channel is available
  - route unavailable decisive user-surface exercise through `hold|blocker`
  - route retained-carrier write unavailability through `hold|blocker`; completion transport stays invalid until the carrier exists at the frozen retained path
  - if the blocker is an information request, team-lead must answer it through a corrected packet, reopened planning, or proven user-owned blocker
  - receiver-required detail travels through the preceding non-rendered `problem-report`, retained carrier, task state, runtime ledger, or governed evidence artifact
  - worker-originated `hold|blocker` delivery uses the no-detail state token; the blocker detail belongs to non-rendered `problem-report` or governed carriers
  - stale, erroneous, or resolved blocker state is corrected through internal carrier state and team-lead recovery; `retract blocker`, `packet readable`, `proceeding`, `no team-lead action needed`, and similar visible prose are not message classes
  - resolution requires blocker handling through a truthful next owner/action

### Agent Information Request Consumption
When an agent records non-rendered `MESSAGE-CLASS: problem-report` followed by `hold|blocker` because decisive assignment basis is missing, team-lead must consume the problem report before any re-dispatch, synthesis, completion claim, or user-facing positive report.
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

`problem-report` carries the initial problem basis; `scope-pressure` carries the correction classification as `CORRECTION-OUTCOME` when a detailed carrier is used.

Tool/evidence-gap consumption:
- If the agent names a missing evidence surface, required tool, setup owner, or current-toolchain gap, team-lead resolves it through `Skill(tool-acquisition)`, `Skill(external-tool-bridge)`, packet correction, or route replan.
- A usable tool/evidence-gap request names the missing evidence surface, required capability, current toolset limit, candidate tools considered, selected tool or program candidate, fit rationale, why weaker evidence is invalid, smallest truthful boundary, and setup owner candidate or packet correction.
- If those details are missing, team-lead must request corrected blocker/pressure transport, route `Skill(tool-acquisition)` under the active owner path, or reopen `work-planning`.
- Missing basis becomes explicit packet correction, route replan, or blocker truth.
- A corrected packet is valid only when the same frozen route remains truthful and the missing setup/tool basis is explicit.
- Otherwise reopen `work-planning` to freeze `Skill(tool-acquisition)`, `Skill(external-tool-bridge)`, the exact setup owner, or a proven user-owned blocker.

The corrected packet must name the original blocker, the supplied field or correction, the unchanged boundary, and the open executable `TASK-ID` when task tracking is active.
`packet-correction` handling requires those names.
A lane recognizes a packet-correction only when an incoming `SendMessage` with `MESSAGE-CLASS: assignment` carries those explicit fields; absent that signal, the prior blocker remains unresolved and post-correction labels stay unavailable.
If one missing basis affects multiple assignments, correct the shared basis once.
Then send bounded corrected packets to every affected agent.
When one lane is blocked, keep unrelated independent lanes moving inside the frozen route.
For any blocked owner or lane constraint, the expected outcome is resumed execution.
Valid resume routes are method research, setup/tool bridge, packet correction, or owner split.
Then return the corrected executable path to the blocked owner or lane.
Treat the constraint transport as a resume-route trigger until a genuine impossible or unsafe condition is proven.

## Resolve Next Owner And Action
- `problem-report` opens team-lead problem consumption and preserves receipt-pending state until `dispatch-ack`, `scope-pressure`, `hold|blocker`, `subjob-done`, failed-send truth, replacement truth, or blocker-routing resolves the target.
- `dispatch-ack` opens the same assignment execution block; waiting, status narration, and user reporting stay closed.
- Executable same-boundary packet correction opens corrected assignment messaging.
- `scope-pressure` opens team-lead classification as `packet-correction`, `route-replan`, `parallel-continue`, or proven user-owned blocker.
- `hold|blocker` opens team-lead blocker resolution through corrected packet, reopened planning, owner routing, setup/research routing, default, parameter, or marked inference path.
- `subjob-done` opens completion-contract reconciliation; team-lead synthesis opens only after retained-carrier acceptance passes.
- `status` returns to monitoring or the active owner as progress evidence only.
- Missing team-scoped `Agent` top-level envelope field opens runtime-dispatch tool-envelope correction before the host `Agent` call.
- Missing `TaskCreate` subject or description opens task packet correction.
- Missing or stale task identity opens `TaskList`, `TaskGet`, `task_assignment`, or returned-mutation evidence recovery before task mutation.
- Available background task output path opens `Read` as the output-read channel.
