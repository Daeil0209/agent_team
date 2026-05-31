---
name: task-execution
description: Use after work-planning freezes additional-agent dispatch. Governs assignment-grade packets, moves, and truth.
user-invocable: false
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
## Structural Contract
- Sharpens only its dispatch procedure surface.
- Fixed top-level section order starts after Structural Contract.
- Section 1 is Purpose.
- Section 2 is Activation.
- Section 3 is Entry Contract.
- Section 4 is Step 1: Activate Frozen Route.
- Section 5 is Step 2: Dispatch / Reuse.
- Section 6 is Step 3: Dispatch Truth.
- Section 7 is Step 4: Interrupt / Resume Boundary.
- Section 8 is Resolve Next Owner And Action.
- Section 9 is Move-Out Boundary.
- Reference Map stays inside Purpose.
## Purpose
Run frozen additional-agent execution after planning is complete.
Activate only for assignment-grade dispatch, standalone `Agent` result classification, or dispatch recovery from a frozen route; reuse only a fresh same-session loaded-and-learned basis.
When active, it handles dispatch packet assembly, dispatch-bound binding-surface materialization, send truth, runtime creation/launch, and dispatch interruption state.
Use `references/phase-transition-control.md` without loading this skill when the active workflow owner sends phase context without new bounded work.

Boundary:
- `work-planning` handles scope freeze, mode freeze, and frozen next action
- `Skill(self-verification)` handles produced work-product outbound convergence before phase/stage-end reporting or handoff
- `session-boot` handles runtime monitoring and post-dispatch agent-state observation
- `team-lead` handles synthesis, closeout, and user-facing reporting

### Reference Map
After `Skill(task-execution)` is loaded, load trigger-specific references named below.
- `.claude/reference/work-execution-core-law.md`: load for assignment-grade dispatch, packet assembly, runtime send truth, handoff, communication-plane movement, or dispatch recovery.
- `references/assignment-packet.md`: assignment-grade packet floor, receipt/completion contract, packet preflight, field format, skill loading, and cross-continuity packet checks.
- `references/dispatch-entry-contract.md`: consumed planning fields, concrete-vs-not-applicable rules, execution readiness entry checks, and information movement rule.
- `references/request-bound-fields.md`: request-intent, exact user wording, governance tier, user-surface, proof/tool/setup, run-path, burden, decision, validation, environment, and scenario fields.
- `references/message-classes.md`: Communication Plane law, canonical channel registry, upward message classes, receipt spine, structured shutdown request, information-request consumption, and blocker/pressure routing.
- `references/scope-pressure.md`: canonical `scope-pressure` values, required fields, and replan vs packet-correction boundary.
- `references/truth-rules.md`: runtime truth ladder and user-facing claim limits.
- `references/runtime-dispatch-law.md`: team-runtime lane dispatch, TeamCreate sequencing, parallel/reuse law, SendMessage class boundaries, required-skill dispatch law, and partial-parallel-failure recovery.
- `references/completion-handoff.md`: common completion result spine, resource cleanup, user-surface proof method fields, and lane completion law.
- `references/dispatch-recovery.md`: interruption points, resume owner/action, duplicate-send prevention, and compaction recovery.
- `references/phase-transition-control.md`: phase-transition packet schema.
- `references/lane-additions.md`: lane-specific packet-addition owner map and team-session controlled-value pointer.
## Activation
Load and learn `Skill(task-execution)` when a frozen dispatch, reuse, blocker-clear, or standalone-result classification path requires it and no fresh current same-session `task-execution` load-and-learn basis exists.
After a fresh current same-session `task-execution` load-and-learn basis exists, later dispatch, reuse, blocker-clear, and route-iteration paths consume the loaded-and-learned skill instead of another `Skill(task-execution)` call.
Boundary changes refresh `work-planning` fields, route basis, dispatch-entry checks, and trigger-specific reference consumption; current same-session `task-execution` load basis is reusable only while fresh under the activation rule.
`task-execution` activation basis is actual full-body `Skill(task-execution)` load-and-learn or `same-session-loaded-and-learned:task-execution` for the current Claude session.
Same-session-loaded-and-learned `task-execution` basis becomes stale per `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules` staleness rule (session changed, this skill file changed after invocation, compaction/drop/truncation can affect the needed rule, or active path needs unconsumed trigger-specific detail); stale basis reloads and learns `Skill(task-execution)` or consumes the exact trigger-specific reference before action.
Direct reading, searching, listing, summarizing, or reference-map traversal of `.claude/skills/task-execution/**` is inspection only; activation basis requires actual full-body skill load-and-learn or current same-session loaded-and-learned basis.
Current boundary `work-planning` must be complete.
Any frozen named workflow or sequence owner must be complete.
Light channels, `answer-only`, lead-local single-surface paths, receipt-only state, runtime-cleanup state, and phase-transition-only state stay with their current owner.
Missing actual `work-planning` freeze discards the attempted dispatch path and returns to the missing owner before any dispatch step.
## Entry Contract
Use `references/dispatch-entry-contract.md` before this skill acts.
Hard surface:
- This skill must be active by actual `Skill(task-execution)` load or current same-session activation basis before dispatch-bound binding-surface materialization, packet assembly, `TeamCreate`, `Agent`, assignment-grade `SendMessage`, reuse, or blocker-clear movement.
- Required prior owners: current boundary `work-planning`, any frozen workflow/sequence owner, and a frozen additional-agent or ambiguous dispatch route.
- New agent dispatch also requires dispatch-runtime execution proof consumed from `references/runtime-dispatch-law.md`.
- `EXECUTION-READINESS-BASIS` must be `ready:<basis>` for assignment-grade dispatch.
- Assignment-grade packets require `RECEIPT-COMPLETION-CONTRACT` before `SendMessage`.
- `blocked:<basis>` enters only for a dispatch-bound blocker-clear move.
- Missing, contradictory, stale, or route-unfit `not-applicable` route fields reopen `work-planning`.
- Missing measured burden basis required by `work-planning` or `parallel-fit` reopens `work-planning` before `TeamCreate`, `Agent`, `SendMessage`, reuse, or packet assembly.
- Missing frozen `ACTIVE-CONCURRENT-AGENT-CAP` on a team-routed, ambiguous, or dispatch-capable route reopens `work-planning` before `TeamCreate`, `Agent`, `SendMessage`, reuse, or packet assembly.
- A frozen `AGENT-MAP` or `PARALLEL-GROUPS` that would exceed the active concurrent-agent cap defined by `.claude/skills/work-planning/references/parallel-fit.md` is dispatch-invalid.
- `PARALLEL-GROUPS: none` on multi-surface work is dispatch-invalid unless the frozen basis proves dependency or serial burden stronger than parallel.
- Route, staffing, parallelism, or dispatch option prompts to the user are not dispatch actions unless a proven user-action blocker is frozen.
- Packet repair inside `task-execution` is limited to values already frozen by the governing path.
- Agents receive bounded assignment packets derived from the freeze; the full internal planning block stays internal.
- Same-boundary packet correction, receipt follow-up, execution follow-up, and bounded reuse consume the frozen boundary.
- Reopen `work-planning` when a `work-planning` boundary-change axis moves.
## Step 1: Activate Frozen Route
Select only the next concrete execution move that preserves the frozen routed state:
- lane boundary
- independent parallelism
- required review/proof/validation separation
- honest next-action truth

Core rule:
- `lead-local candidate` returns to the frozen lead-local owner
- `ambiguous-route` means the frozen route opens dispatch handling but the exact dispatch move is not safely reducible to lead-local execution without moving owner, phase, staffing, proof, acceptance, or work-surface boundaries
- an additional-agent route enters here as a frozen routed state
- `ambiguous-route` defaults to team-routed handling, not lead-local compression

Keep explicit:
- whether the next move is team-agent runtime creation, reuse by assignment message, team-scoped member creation, assignment-grade SendMessage, parallel assignment send, or blocker clearance
- whether the frozen dispatch is single-lane, mirrored, or parallel-sharded
- the exact serial reason when `PARALLEL-GROUPS` is `none`
## Step 2: Dispatch / Reuse
Run the actual execution move:
- create runtime when needed
- reuse a suitable live or standby agent when that is the frozen path
- dispatch new agents when reuse lacks fit
- assemble the real outgoing packet from the frozen plan basis
- run `.claude/skills/task-execution/references/message-classes.md` `### Assignment Delivery Contract` and packet final check before sending
- reject any planned task-state tool call that violates that contract before the tool call
- synchronize task-state lifecycle changes immediately on the same `TASK-ID` per `message-classes.md` `### Assignment Delivery Contract`; do not use task-row owner, assignee, subject, or description changes as state repair
- confirm retained-output carriers with commands shaped by `.claude/reference/work-runtime-boundary-law.md` `### Bash Internal Evidence Capture Contract`; failed checks surface only through the governing blocker or correction path
- keep task-state mutation instructions out of packets for receivers without the required task-state tool
- Carry `DERIVED-DEFAULTS`, `REQUIRED-SKILLS`, `SKILL-RECOMMENDATIONS`, and request-bound packet fields only from the frozen planning basis or active workflow owner's phase-local refinement.
- Packet skill and request-bound field duties route through `references/assignment-packet.md` and `references/request-bound-fields.md`; dispatch preserves their frozen names and values.
- Missing, lane-mismatched, contradictory, or route-changing entries use the correction routing in those references.

Packet final check:
- Run packet preflight per `references/assignment-packet.md` against the frozen planning/workflow basis before send.
- Reject any `TaskCreate` or `SendMessage` plan that fails `references/message-classes.md` `### Assignment Delivery Contract`.
- Retry assignment delivery only after correcting the tool-envelope defect.
- Reject assignment-grade `SendMessage` when the packet lacks `RECEIPT-COMPLETION-CONTRACT`.
- Reject assignment-grade `SendMessage` when `RECEIPT-COMPLETION-CONTRACT` contradicts first-outcome or completion-handoff law.
- Send only after every frozen route axis is current, present, and coherent; same-owner packet defects return to the same frozen owner, and any moved `work-planning` boundary-change axis reopens `work-planning`.
- For `Agent` member creation, the spawn prompt is member creation only: role/member identity plus screen-safety.
- Use the canonical team-member spawn prompt template: `Member: <name>. Role: <lane>. Screen-safety: no visible prose from this member-creation prompt.`
- In the canonical template, only `<name>` and `<lane>` vary.
- Ordinary team-scoped member creation uses the canonical spawn prompt.
- `Agent` spawn prompts contain only member identity, role identity, and screen-safety.
- Before any parallel `Agent` batch, preflight every planned spawn prompt in the batch against this screen-safety floor.
- Failed spawn-prompt preflight opens prompt-set correction before any `Agent` call from that batch.
- Hook denial is enforcement evidence. A hook `BLOCKED` result proves missed preflight only when the hook enforces a protected destructive, security-critical, or session-stability runtime rule; over-broad positive-pattern or doctrine-shape blocks route as hook defects.
- Assignment-grade work begins only through `SendMessage` after the live member address exists.
- After member creation or neutral task-row creation, the next executable dispatch move is assignment-grade `SendMessage` carrying or pointing to a complete receiver-consumable packet; do not substitute no-op commands, retained-output probes, output-carrier checks, or visible progress prose.
- Screen-safe dispatch still requires a real receiver-consumable packet before the send. If the planned visible envelope is empty or whitespace-only and no non-rendered packet body, retained assignment carrier, or runtime-owned assignment evidence exists for the receiver, correct that delivery path locally before `SendMessage`; do not create a task row plus blank message and then classify missing retained output as dispatch progress.
- The detailed Team Member Startup Recognition rule stays in `references/message-classes.md`; this `SKILL.md` surface carries the executable preflight floor.
- Dispatches that will receive completion-grade carriers invoke Step 3 `Completion acceptance` upon receipt; the assigned lane's verification work must satisfy the citation requirements named there (`Skill(review-verification)` `PACKET-ID`, `Skill(self-verification)` tool-call evidence) for the completion to pass.

Dispatch law:
- Apply `references/runtime-dispatch-law.md` before any `TeamCreate`, `Agent`, parallel assignment-send segment, reuse-via-`SendMessage`, or packet-correction-via-`SendMessage` move.
- Runtime readiness classification may come from `session-boot`, but the preflight required before `TeamCreate`, team-scoped `Agent`, assignment-grade `SendMessage`, or assignment-grade reuse is consumed here.
- Planned `Agent` inside a team-routed path is team-scoped member creation only.
- Host/background `Agent` execution without team-scope parameters is standalone route drift for team-routed work; stop before synthesis or reuse claims and recover through `references/runtime-dispatch-law.md`.
- A same-task packet-correction-via-`SendMessage` whose receiver has no open executable task (post-completion, idle, converged) fails the `SendMessage And Skill Law` necessity check; suppress the same-task send.
- Malformed or missing retained-carrier completion payload after task closure opens distinct bounded `assignment`, `reuse`, or `reroute` only when the producer lane remains the truthful correction owner; otherwise route cleanup to `Skill(governance-modification)`.
- `TeamCreate` / team-scoped `Agent` / `SendMessage` runtime-shape rules (runtime-creation-order, team-scope-identity, BLOCKED-result handling, blocked-pre-agent-start treatment, address-vs-role, standalone-fallback classification, blocker-shape stop rule) live in `references/runtime-dispatch-law.md` `## Team Runtime Shape` + `## Team-Agent-Only Lane Dispatch` + `## Parallel And Reuse Law`; consume there for the rule body.
- Configured lanes, frozen `PARALLEL-GROUPS`, lane separation, proof/acceptance separation, and packet skill-field law outrank reuse or dispatch convenience.
- Assignment-grade `SendMessage` uses `MESSAGE-CLASS: assignment`.
- Phase-transition control `SendMessage` uses `MESSAGE-CLASS: phase-transition-control`.
- Runtime cleanup uses structured `shutdown_request`.
- Match each `SendMessage` to the exact class or structured payload defined by its reference.
- `SendMessage`, non-rendered task state, and retained carrier delivery carry assignment-grade teammate output.
- Treat member creation plus assignment send plus lane receipt plus subsequent lane work as one assignment execution block; `dispatch-ack` may create an internal tool-turn boundary, but that boundary is not a wait, status, blocker, or user-report reason.
- Work-start and work-completion transition facts stay inside the assignment execution block, retained carrier, task state, or governed state token; they do not create assistant-authored visible start or completion reports.
- Details required only by that block stay in its packet, non-rendered task state, retained carrier, or lane-local context.
- Bounded partial-parallel-failure recovery is valid only under the exact recovery rule in `references/runtime-dispatch-law.md`.
- Otherwise reopen `work-planning`.

Inside the frozen routed state, treat these as the only valid next actions:
- `TeamCreate`
- `TaskCreate` under `references/message-classes.md` `### Assignment Delivery Contract` when task tracking is active
- `reuse-via-SendMessage`
- `Agent` member creation
- assignment-grade `SendMessage`
- parallel assignment send
- `clear-blocker:<exact blocker>`
Branch rule:
- branch only across these frozen execution moves and packet templates
- new route, owner, or claim class reopens `work-planning`
- if a branch requires new route judgment, new work surface decomposition, or changed route, reopen `work-planning` first
## Step 3: Dispatch Truth
Dispatch truth is Procedure Plane and Communication Plane state.
User-facing report admission is governed by `.claude/reference/reporting-prohibition-law.md`; admitted report shape is governed by `.claude/reference/reporting-user-reporting-law.md`.
Dispatch execution follows the top Reporting Curtain: host/tool/runtime rows do not admit assistant-authored progress prose while the next dispatch, monitoring, recovery, merge, or synthesis action can run.
Progress narration, status labels, receipt barriers, and dispatch-pending truth never substitute for the next executable tool, dispatch, recovery, carrier-consumption, synthesis, or blocker-routing action.
Transport display is owned by `references/message-classes.md`; receiver-required detail stays in packets, non-rendered task state, retained carriers, or lane-local context.
When `runtime-dispatch-law.md` opens `PARALLEL-DISPATCH-LOCK`, the next actions stay inside the allowed dispatch/reuse moves for every frozen nonblocked group.
Execute the lawful `PARALLEL-DISPATCH-LOCK` move; user-visible prose appears only after `.claude/reference/reporting-prohibition-law.md` admission and `.claude/reference/reporting-user-reporting-law.md` shape control.

The runtime truth ladder lives in `references/truth-rules.md`. Apply it at every assignment-success, dispatch-ack, progress, or recovery decision.
Before assignment-send evidence exists, missing retained-output files are expected non-evidence; do not classify `dispatch-pending-no-ack`, dispatch-recovery, packet rejection, or no-start from absent output carriers before a valid assignment-grade `SendMessage` has been sent.

Reporting consequences:
- Assignment success, no-change dispatch, dispatch-ack, lane-count, waiting, idle, individual completion, partial fan-out completion, and retained-output availability stay internal while monitoring, recovery, retained-carrier consumption, merge, or synthesis can continue.
- Ack, returned, verified, accepted, standby, reuse, next-shard, next-batch, waiting, and idle facts stay internal while monitoring, recovery, retained-carrier consumption, task-state synchronization, reuse, merge, synthesis, correction, or closeout can continue.
- User-requested dispatch status routes through `.claude/reference/reporting-prohibition-law.md` and `.claude/reference/reporting-user-reporting-law.md`, citing only the admitted user-relevant waiting condition; after the admitted answer, resume the active owner action without assistant-authored resume, waiting, or monitoring narration.
- Multi-lane result reporting opens only after all frozen required outputs are reconciled, synthesized, covered by required `Skill(self-verification)` convergence or the independent verification route, admitted by `.claude/reference/reporting-prohibition-law.md`, and shaped by `.claude/reference/reporting-user-reporting-law.md`.

Completion acceptance:
- `MESSAGE-CLASS: subjob-done` receipt opens completion acceptance per `references/completion-handoff.md` `## Common Completion Result Spine`.
- Verify the retained carrier exists and contains every required completion payload field; field-presence check is necessary but not sufficient, field-value truth (actual evidence citation) is the acceptance gate.
- Treat raw `subjob-done` as a completion-candidate signal only until retained-carrier acceptance passes; it does not create `STANDBY`, reuse eligibility, synthesis input, or task-result acceptance by itself.
- Run acceptance probes and post-acceptance routing under `references/completion-handoff.md`; expected false branches stay internal, and acceptance/reuse narration remains suppressed by `.claude/reference/reporting-prohibition-law.md`.
- If the carrier is absent or incomplete, keep the producer on the same correction path and route only a bounded carrier-correction assignment to that same producer when an executable task is needed; do not assign fresh shard/work to that lane from the failed signal.
- For carrier-asserted `PASS-1`/`PASS-2`/`CONVERGENCE-PASS`/`Skill(...) loaded` claims, verify each cites actual tool-call evidence per `Skill(self-verification)` Step 1 and Step 3 citation requirements.
- For carrier-asserted review-verification basis (`REVIEW-PACKET-CITATION`, packet consumption claims), verify each cites the `review_verification_packet` `PACKET-ID` or content reference per `Skill(review-verification)` Step 14 citation form.
- Carrier-as-evidence fabrication (PASS, skill-load, or packet-citation assertion without actual evidence) is a procedural defect; reject the completion-grade transport, mark the assigned task non-converged, and route correction via distinct bounded `assignment`, `reuse`, or `reroute` to the producing lane with `INPUT-FINDINGS` naming the carrier defect.
- Carrier-truth fabrication is not a packet defect; reopen `work-planning` only when the fabrication exposes a moved boundary axis.

Recovery reconciliation:
- A dispatch segment becomes complete only after every target has a valid first upward resolution outcome (`dispatch-ack`, completion-grade `subjob-done`, `scope-pressure`, or `hold|blocker`), failed-send truth, replacement truth, or team-lead-recorded blocker-routing with exhausted internal recovery basis and next safe owner/action; `problem-report` is a pending-problem event, not segment completion.
- Agent-start evidence after valid receipt supports monitoring and no-start recovery; agent-start evidence without valid receipt does not clear missing-receipt debt.
- Reconcile by exact live target, not by role label, shard count, pane text, or inbox read state.
- Before monitoring, replacement, shutdown, or user-facing progress, reconcile every parallel target with runtime truth plus assigned-surface activity/side-effect evidence.
- Per-interruption-point recovery procedures (missing-`dispatch-ack` follow-up, `dispatch-ack`-without-agent-start follow-up, dead-or-unavailable classification, unaffected-target movement) live in `references/dispatch-recovery.md` `## Dispatch Interruption Recovery`; SKILL.md consumes that reference for the executable detail at every recovery decision.
## Step 4: Interrupt / Resume Boundary
Use `references/dispatch-recovery.md` for detailed interruption points and resume actions.
If interruption occurs while this skill is active or before clean move-out, preserve the dispatch side-effect boundary before continuing.
Interruption includes user correction, `Skill(governance-modification)` trigger, compaction/resume, access/runtime stop, cleanup, and phase-transition interruption.

Rules:
- pre-open interruption resumes the last valid active owner: `work-planning`, active workflow, or `self-verification`
- if the interruption happened after clean move-out, the current owner handles recovery
- use any dispatch recovery record only as evidence for `session-boot`, lane execution, team-lead synthesis, or `Skill(self-verification)` convergence
- resume from the last proven dispatch truth, not memory, intent, or packet text
- resend an assignment-grade packet only when send evidence is absent and duplicate side-effect risk has been checked
- stronger agent-start or completion truth requires stronger evidence than `team exists`, `dispatch pending`, or `dispatch-ack`
- if the interruption moves any `work-planning` boundary-change axis, reopen `work-planning`
- if a behavioral or procedural defect meets the `Skill(governance-modification)` entry gate, open `Skill(governance-modification)`
- the suspended dispatch surface still requires `RESUME-OWNER` and verified `RESUME-ACTION` before closure or return
- partial dispatch maps to recovery or resume truth only
## Resolve Next Owner And Action
After the execution move:
- fallback standalone returned results, if already present, go to `team-lead` synthesis as bounded evidence only
- then `Skill(self-verification)` runs convergence before phase/stage-end reporting or synthesis-triggered redispatch
- fallback standalone results stay outside team-runtime monitoring
- `session-boot` handles monitoring and agent-state interpretation
- agent lanes handle execution and completion packets
- `team-lead` handles synthesis after agent outputs arrive
- `Skill(self-verification)` reopens for convergence before phase/stage-end consequential reporting, completion claim, or synthesis-triggered re-dispatch

Canonical sequence:
1. `work-planning`
2. named workflow or sequence owner when `ACTIVE-WORKFLOW` or non-`not-applicable` `ACTIVE-SEQUENCE` is frozen
3. `task-execution`
4. `session-boot` runtime observation
5. agent execution
6. team-lead synthesis
7. `Skill(self-verification)` convergence
8. user report or downstream consequential re-dispatch

## Move-Out Boundary
Keep out of this spine:
- long packet field catalogs -> `references/assignment-packet.md` and `references/request-bound-fields.md`
- lane-specific packet or completion deltas -> agent references and role docs
- runtime monitoring/cleanup recovery detail -> `session-boot` / `session-closeout`
- agent-only completion contracts -> agent role docs
- broad evidence-burden or claim-strength rules -> `self-verification`

Rule:
Compaction is valid only while the operator can still answer, immediately and without skimming:
- why `task-execution` opened
- which frozen fields it consumed
- what exact dispatch move it handles now
- what user-facing truth limit applies before valid receipt, agent-start, or completion evidence exists
- if interrupted, what last proven dispatch truth and resume owner/action apply
- which owner takes over next
