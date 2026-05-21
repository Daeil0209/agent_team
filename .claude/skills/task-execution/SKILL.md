---
name: task-execution
description: Use after work-planning freezes host-authorized additional-agent dispatch. Governs assignment-grade packets, moves, and truth.
user-invocable: false
REPORTING-CURTAIN: .claude/reference/reporting-user-reporting-law.md
---
## Structural Contract
- Sharpens only its owned dispatch surface.
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
Own host-authorized additional-agent execution after planning is complete.
Load at most once per Claude session, and only for assignment-grade dispatch, standalone `Agent` result classification, or dispatch recovery from a frozen route.
When active, it owns dispatch packet assembly, dispatch-bound binding-surface materialization, send truth, runtime creation/launch, and dispatch interruption state.
Use `references/phase-transition-control.md` without loading this skill when the active workflow owner sends phase context without new bounded work.

Boundary:
- `work-planning` owns scope freeze, mode freeze, and frozen next action
- `Skill(self-verification)` owns exception-only plan audit and phase/stage-end result verification
- `session-boot` owns runtime monitoring and post-dispatch agent-state observation
- `team-lead` owns synthesis, closeout, and user-facing reporting

### Reference Map
After `Skill(task-execution)` is loaded, load trigger-specific references named below.
- For any listed `.claude/reference/*-core-law.md`, also consume that core law's triggered `## Reference Map` subreferences.
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
Load `Skill(task-execution)` at most once per Claude session when the first frozen host-authorized dispatch, reuse, blocker-clear, or standalone-result classification path requires it and no current same-session `task-execution` load exists.
After current same-session `task-execution` load exists, later dispatch, reuse, blocker-clear, and route-iteration paths consume the loaded skill instead of another `Skill(task-execution)` call.
Boundary changes refresh `work-planning` fields, route basis, dispatch-entry checks, and trigger-specific reference consumption; boundary changes do not make `task-execution` require another skill load.
`task-execution` activation basis is actual `Skill(task-execution)` load or `same-session-loaded:task-execution` for the current Claude session.
Direct reading, searching, listing, summarizing, or reference-map traversal of `.claude/skills/task-execution/**` is inspection only and never creates `task-execution` activation basis.
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
- `blocked:<basis>` enters only for a dispatch-owned blocker-clear move.
- Missing, contradictory, stale, or route-unfit `not-applicable` route fields reopen `work-planning`.
- Missing measured burden basis required by `work-planning` or `parallel-fit` reopens `work-planning` before `TeamCreate`, `Agent`, `SendMessage`, reuse, or packet assembly.
- Missing frozen `ACTIVE-CONCURRENT-AGENT-CAP` on a team-routed, ambiguous, or dispatch-capable route reopens `work-planning` before `TeamCreate`, `Agent`, `SendMessage`, reuse, or packet assembly.
- A frozen `AGENT-MAP` or `PARALLEL-GROUPS` that would exceed the active concurrent-agent cap defined by `.claude/skills/work-planning/references/parallel-fit.md` is dispatch-invalid.
- `PARALLEL-GROUPS: none` on multi-surface work is dispatch-invalid unless the frozen basis proves dependency or serial burden stronger than parallel.
- Route, staffing, parallelism, or dispatch option prompts to the user are not dispatch actions unless a proven user-owned blocker is frozen.
- Packet repair inside `task-execution` is limited to values already frozen by the owning path.
- Agents receive bounded assignment packets derived from the freeze; the full internal planning block stays internal.
- Same-boundary packet correction, receipt follow-up, execution follow-up, and bounded reuse consume the frozen boundary.
- Reopen `work-planning` when a `work-planning` boundary-change axis moves.
## Step 1: Activate Frozen Route
Select only the next concrete execution move that preserves the frozen routed state:
- lane ownership
- independent parallelism
- required review/proof/validation separation
- honest next-action truth

Core rule:
- `lead-local candidate` returns to the frozen lead-local owner
- `ambiguous-route` means the frozen route authorizes dispatch handling but the exact dispatch move is not safely reducible to lead-local execution without moving owner, phase, staffing, proof, acceptance, or work-surface boundaries
- an additional-agent route enters here as a frozen routed state
- `ambiguous-route` defaults to team-routed handling, not lead-local compression

Keep explicit:
- whether the next move is team-agent runtime creation, reuse by assignment message, team-scoped member creation, assignment-grade SendMessage, parallel assignment send, or blocker clearance
- whether the frozen dispatch is single-lane, mirrored, or parallel-sharded
- the exact serial reason when `PARALLEL-GROUPS` is `none`
## Step 2: Dispatch / Reuse
Own the actual execution move:
- create runtime when needed
- reuse a suitable live or standby agent when that is the frozen path
- dispatch new agents when reuse lacks fit
- assemble the real outgoing packet from the frozen plan basis
- run `.claude/skills/task-execution/references/message-classes.md` `### Assignment Delivery Contract` and packet final check before sending
- reject any planned task-state tool call that violates that contract before the tool call
- confirm retained-output carriers with silent success commands; failed checks surface only through the owning blocker or correction path
- keep task-state mutation instructions out of packets for receivers without the required task-state tool
- Carry `DERIVED-DEFAULTS`, `REQUIRED-SKILLS`, `SKILL-RECOMMENDATIONS`, and request-bound packet fields only from the frozen planning basis or active workflow owner's phase-local refinement.
- Packet skill and request-bound field duties route through `references/assignment-packet.md` and `references/request-bound-fields.md`; do not invent, drop, or relabel them during dispatch.
- Missing, lane-mismatched, contradictory, or ownership-changing entries use the correction routing in those references; do not repair them with dispatch prose.

Packet final check:
- Run packet preflight per `references/assignment-packet.md` against the frozen planning/workflow basis before send.
- Reject any `TaskCreate` or `SendMessage` plan that fails `references/message-classes.md` `### Assignment Delivery Contract`.
- Correct assignment-delivery tool-envelope defects before retry; do not repeat the same malformed call.
- Reject assignment-grade `SendMessage` when the packet lacks `RECEIPT-COMPLETION-CONTRACT`.
- Reject assignment-grade `SendMessage` when `RECEIPT-COMPLETION-CONTRACT` contradicts first-outcome or completion-handoff law.
- Send only after every frozen route axis is current, present, and coherent; same-owner packet defects return to the same frozen owner, and any moved `work-planning` boundary-change axis reopens `work-planning`.
- For `Agent` member creation, the spawn prompt is member creation only: role/member identity plus screen-safety.
- Use the canonical team-member spawn prompt template: `Member: <name>. Role: <lane>. Screen-safety: no visible prose from this member-creation prompt.`
- In the canonical template, only `<name>` and `<lane>` vary.
- Do not hand-write alternate spawn prompts for ordinary team-scoped member creation.
- `Agent` spawn prompts must not contain `MESSAGE-CLASS`, assignment payload, `SendMessage` instructions, ACK requests, `dispatch-ack` fields, work plans, retained-output paths, or future-action language.
- Before any parallel `Agent` batch, preflight every planned spawn prompt in the batch against this screen-safety floor.
- If any planned spawn prompt fails the floor, send zero `Agent` calls from that batch; correct the prompt set first, then dispatch only the corrected batch.
- Hook denial is not preflight. A hook `BLOCKED` result proves the preflight was missed.
- Assignment-grade work begins only through `SendMessage` after the live member address exists.
- The detailed Team Member Startup Recognition rule stays in `references/message-classes.md`; this `SKILL.md` surface carries the executable preflight floor.

Dispatch law:
- Apply `references/runtime-dispatch-law.md` before any `TeamCreate`, `Agent`, parallel assignment-send segment, reuse-via-`SendMessage`, or packet-correction-via-`SendMessage` move.
- Runtime readiness classification may come from `session-boot`, but the preflight that authorizes `TeamCreate`, team-scoped `Agent`, assignment-grade `SendMessage`, or assignment-grade reuse is consumed here.
- Planned `Agent` inside a team-routed path is team-scoped member creation only.
- A same-task packet-correction-via-`SendMessage` whose receiver has no open executable task (post-completion, idle, converged) fails the `SendMessage And Skill Law` necessity check; suppress the same-task send.
- Malformed or missing retained-carrier completion payload after task closure opens distinct bounded `assignment`, `reuse`, or `reroute` only when the producer lane remains the truthful correction owner; otherwise route cleanup to `Skill(governance-modification)`.
- `TeamCreate` / team-scoped `Agent` / `SendMessage` runtime-shape rules (runtime-creation-order, team-scope-identity, BLOCKED-result handling, blocked-pre-agent-start treatment, address-vs-role, standalone-fallback classification, blocker-shape stop rule) are owned by `references/runtime-dispatch-law.md` `## Team Runtime Shape` + `## Team-Agent-Only Lane Dispatch` + `## Parallel And Reuse Law`; consume there for the rule body.
- Configured lanes, frozen `PARALLEL-GROUPS`, lane separation, proof/acceptance separation, and packet skill-field law outrank reuse or dispatch convenience.
- Assignment-grade `SendMessage` uses `MESSAGE-CLASS: assignment`.
- Phase-transition control `SendMessage` uses `MESSAGE-CLASS: phase-transition-control`.
- Runtime cleanup uses structured `shutdown_request`.
- Match each `SendMessage` to the exact class or structured payload owned by its reference.
- Do not use teammate pane/final output as a substitute for `SendMessage`, task state, or retained carrier delivery.
- Treat member creation plus assignment send plus lane receipt plus subsequent lane work as one assignment execution block; `dispatch-ack` may create an internal tool-turn boundary, but that boundary is not a wait, status, blocker, or user-report reason.
- Details required only by that block stay in its packet, task state, retained carrier, or lane-local context; they do not become user-facing prose or extra upward messages.
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
- if a branch requires new route judgment, new work surface decomposition, or changed ownership, reopen `work-planning` first
## Step 3: Dispatch Truth
Dispatch truth is Procedure Plane and Communication Plane state.
User-facing reporting is owned only by `.claude/reference/reporting-user-reporting-law.md`.
Dispatch execution is silent while the next dispatch, monitoring, recovery, merge, or synthesis action can run.
Tool-adjacent progress prose is forbidden while dispatch, monitoring, recovery, merge, synthesis, or locked parallel dispatch can continue.
Transport dispatch state through `message-classes.md`; do not convert dispatch state into a user report.
Report to the user only when `.claude/reference/reporting-user-reporting-law.md` admits a user-facing report.
Keep runtime setup, packet work, lane choice, receipt handling, and team-state changes internal.
When `runtime-dispatch-law.md` opens `PARALLEL-DISPATCH-LOCK`, do not insert extra reference reads, Codex/review passes, lead-side `TaskUpdate` mutations, packet rewrites after `references/assignment-packet.md` preflight has passed, monitoring, or user-facing prose before the dispatch/reuse attempt for every frozen nonblocked group.
Do not narrate `PARALLEL-DISPATCH-LOCK`, allowed move lists, retained-output setup, or dispatch preparation to the user; execute the allowed move.

The runtime truth ladder is owned by `references/truth-rules.md`. Apply it at every assignment-success, ack, progress, or recovery decision.

Reporting consequences:
- Assignment success, no-change dispatch, ack, lane-count, waiting, idle, individual completion, partial fan-out completion, and retained-output availability stay internal while monitoring, recovery, retained-carrier consumption, merge, or synthesis can continue.
- User-requested dispatch status reports only the user-relevant waiting condition.
- Multi-lane result reporting opens only after all frozen required outputs are reconciled, synthesized, and covered by required `Skill(self-verification)` result verification or the independent verification route.

Recovery reconciliation:
- A dispatch segment is not complete while any target lacks `dispatch-ack`, agent-start evidence, blocker, scope-pressure, failed-send truth, replacement truth, or team-lead-recorded Procedure Plane `HOLD`.
- Reconcile by exact live target, not by role label, shard count, pane text, or inbox read state.
- Before monitoring, replacement, shutdown, or user-facing progress, reconcile every parallel target with runtime truth plus assigned-surface activity/side-effect evidence.
- Missing `dispatch-ack` after current dispatch check triggers one same-assignment receipt follow-up through `session-boot` before stale, replacement, or shutdown recovery.
- Missing `dispatch-ack` after that follow-up and absent activity evidence classifies the target as dead-or-unavailable for the current assignment.
- `dispatch-ack` without agent-start, blocker, scope-pressure, failure, or team-lead-recorded Procedure Plane `HOLD` after the receipt segment triggers one same-assignment execution follow-up through `session-boot`.
- Keep unaffected independent targets moving while the affected target is recovered.
## Step 4: Interrupt / Resume Boundary
Use `references/dispatch-recovery.md` for detailed interruption points and resume actions.
If interruption occurs while this skill is active or before clean move-out, preserve the dispatch side-effect boundary before continuing.
Interruption includes user correction, `Skill(governance-modification)` trigger, compaction/resume, permission/runtime stop, cleanup, and phase-transition interruption.

Rules:
- pre-open interruption resumes the last valid active owner: `work-planning`, active workflow, or `self-verification`
- if the interruption happened after clean move-out, the current owner handles recovery
- use any dispatch recovery record only as evidence for `session-boot`, lane execution, team-lead synthesis, or `Skill(self-verification)` result verification
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
- then `Skill(self-verification)` runs result verification before phase/stage-end reporting or synthesis-triggered redispatch
- fallback standalone results stay outside team-runtime monitoring
- `session-boot` owns monitoring and agent-state interpretation
- agent lanes own execution and completion packets
- `team-lead` owns synthesis after agent outputs arrive
- `Skill(self-verification)` reopens for result verification before phase/stage-end consequential reporting, completion claim, or synthesis-triggered re-dispatch

Canonical sequence:
1. `work-planning`
2. named workflow or sequence owner when `ACTIVE-WORKFLOW` or non-`not-applicable` `ACTIVE-SEQUENCE` is frozen
3. `task-execution`
4. `session-boot` runtime observation
5. agent execution
6. team-lead synthesis
7. `Skill(self-verification)` result verification
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
- what exact dispatch move it owns now
- what user-facing truth limit applies before agent-start evidence exists
- if interrupted, what last proven dispatch truth and resume owner/action apply
- which owner takes over next
