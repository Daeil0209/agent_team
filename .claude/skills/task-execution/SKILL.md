---
name: task-execution
description: Use after work-planning freezes host-authorized additional-agent dispatch. Governs assignment-grade packets, moves, and truth.
user-invocable: false
PRIMARY-OWNER: team-lead
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
- PRIMARY-OWNER: team-lead
## Purpose
Own host-authorized additional-agent execution after planning is complete.
Load only for assignment-grade dispatch, standalone `Agent` result classification, or dispatch recovery from a frozen route.
When active, it owns dispatch packet assembly, send truth, runtime creation/launch, and dispatch interruption state.
Use `references/phase-transition-control.md` or `references/lifecycle-control.md` without loading this skill when the active workflow or lifecycle owner sends control-only messages.

Boundary:
- `work-planning` owns scope freeze, mode freeze, and frozen next action
- `self-verification` owns exception-only `SV-PLAN` and phase/stage-end `SV-RESULT`
- `session-boot` owns runtime monitoring and post-dispatch agent-state observation
- `team-lead` owns synthesis, closeout, and user-facing reporting

### Reference Map
Load trigger-specific files directly from `SKILL.md`.
- `references/assignment-packet.md`: assignment-grade packet floor, packet preflight, field format, skill loading, and cross-continuity packet checks.
- `references/dispatch-entry-contract.md`: consumed planning fields, concrete-vs-not-applicable rules, execution readiness entry checks, and information movement rule.
- `references/request-bound-fields.md`: request-intent, exact user wording, governance tier, user-surface, proof/tool/setup, run-path, burden, decision, validation, environment, and scenario fields.
- `references/message-classes.md`: common message law, canonical channel registry, upward message classes, receipt spine, information-request consumption, and blocker/pressure routing.
- `references/scope-pressure.md`: canonical `scope-pressure` values, required fields, and replan vs packet-correction boundary.
- `references/truth-rules.md`: runtime truth ladder and user-facing claim limits.
- `references/runtime-dispatch-law.md`: team-runtime lane dispatch, TeamCreate sequencing, parallel/reuse law, SendMessage class boundaries, required-skill dispatch law, and partial-parallel-failure recovery.
- `references/completion-handoff.md`: common completion result spine, resource cleanup, user-surface proof method fields, and lane handoff law.
- `references/dispatch-recovery.md`: interruption points, resume owner/action, duplicate-send prevention, and compaction recovery.
- `references/phase-transition-control.md`: phase-transition control packet schema.
- `references/lifecycle-control.md`: lifecycle-control packet schema and structured shutdown protocol.
- `references/lane-additions.md`: lane-specific packet-addition owner map and team-session controlled-value pointer.
## Activation
Open this skill only when the current path is already frozen for host-authorized additional-agent dispatch and the current loaded `task-execution` basis is absent, stale, or wrong-boundary.
If already loaded for the same session and current dispatch owner, consume the loaded skill and execute the dispatch move without another `Skill(task-execution)` call.
Current boundary `work-planning` must be complete.
Any frozen named workflow or sequence owner must be complete.
Light channels, `answer-only`, lead-local single-surface paths, receipt-only state, lifecycle-only state, control-only state, and phase-transition-only state stay with their current owner.
Missing actual `work-planning` freeze discards the attempted dispatch path and returns to the missing owner before any dispatch step.
## Entry Contract
Use `references/dispatch-entry-contract.md` before this skill acts.
Hard surface:
- Required prior owners: current boundary `work-planning`, any frozen workflow/sequence owner, and a frozen additional-agent or ambiguous dispatch route.
- New agent dispatch also requires a host-authorized active-runtime path.
- `EXECUTION-READINESS-BASIS` must be `ready:<basis>` for assignment-grade dispatch.
- `blocked:<basis>` enters only for a dispatch-owned blocker-clear move.
- Missing, contradictory, stale, or route-unfit `not-applicable` route fields reopen `work-planning`.
- Missing measured burden basis required by `work-planning` or `parallel-fit` reopens `work-planning` before `TeamCreate`, `Agent`, `SendMessage`, reuse, or packet assembly.
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
- an additional-agent route enters here as a frozen routed state
- `ambiguous-route` defaults to team-routed handling, not lead-local compression

Keep explicit:
- whether the next move is team-agent runtime creation, reuse by assignment message, team-scoped agent launch, parallel-agent dispatch, or blocker clearance
- whether the frozen dispatch is single-lane, mirrored, or parallel-sharded
- the exact serial reason when `PARALLEL-GROUPS` is `none`
## Step 2: Dispatch / Reuse
Own the actual execution move:
- create runtime when needed
- reuse a suitable live or standby agent when that is the frozen path
- dispatch new agents when reuse lacks fit
- assemble the real outgoing packet from the frozen plan basis
- run the task-state and packet final check before sending
- carry required non-lane-core skills in `REQUIRED-SKILLS` from the frozen planning basis or the active workflow owner's phase-local refinement
- treat each `REQUIRED-SKILLS` entry as receiver-mandatory load/apply work, not advisory method guidance
- carry `REQUEST-BOUND-PACKET-FIELDS` as exact agent-facing request-fit fields when the receiving lane needs original request shape, exact instruction wording, user surface, burden cue, or acceptance basis
- carry frozen `SKILL-RECOMMENDATIONS` only when `work-planning` or active workflow owner resolved methodology guidance for the receiving lane
- missing or lane-mismatched skill-basis entries return to the same frozen owner when all `work-planning` boundary-change axes stay unchanged
- ownership-changing `REQUIRED-SKILLS` or `SKILL-RECOMMENDATIONS` entries reopen `work-planning`

Packet final check:
- Run packet preflight per `references/assignment-packet.md` against the frozen planning/workflow basis before send.
- Send only after every frozen route axis is current, present, and coherent; same-owner packet defects return to the same frozen owner, and any moved `work-planning` boundary-change axis reopens `work-planning`.

Dispatch law:
- Apply `references/runtime-dispatch-law.md` before any `TeamCreate`, `Agent`, `parallel-agent-dispatch`, or reuse-via-`SendMessage` move.
- `TeamCreate` is team-agent runtime creation, not standalone `Agent` dispatch.
- When team runtime is required, `TeamCreate` must succeed before any team-scoped `Agent` dispatch.
- When team runtime is active, delegated lane `Agent` satisfies team-runtime dispatch only when it is team-scoped with the resolved active `team_name` and concrete `name`.
- Role is responsibility.
- Live process-backed member name is address.
- `SendMessage.to` must match the live process-backed roster exactly.
- If the role is absent, create the member with team-scoped `Agent`.
- Standalone host evidence remains fallback classification only.
- Configured lanes, frozen `PARALLEL-GROUPS`, lane separation, proof/acceptance separation, and packet skill-field law outrank reuse or dispatch convenience.
- Assignment-grade `SendMessage` uses `MESSAGE-CLASS: assignment`.
- Phase-transition control `SendMessage` uses `MESSAGE-CLASS: phase-transition-control`.
- Non-terminating lifecycle control `SendMessage` uses `MESSAGE-CLASS: lifecycle-control`.
- Terminating lifecycle control uses structured `shutdown_request`.
- Match each `SendMessage` to the exact class or structured payload owned by its reference.
- Bounded partial-parallel-failure recovery is valid only under the exact recovery rule in `references/runtime-dispatch-law.md`.
- Otherwise reopen `work-planning`.

Inside the frozen routed state, treat these as the only valid next actions:
- `TeamCreate`
- `reuse-via-SendMessage`
- `Agent`
- `parallel-agent-dispatch`
- `clear-blocker:<exact blocker>`
Branch rule:
- branch only across these frozen execution moves and packet templates
- new route, owner, or claim class reopens `work-planning`
- if a branch requires new route judgment, new work surface decomposition, or changed ownership, reopen `work-planning` first
## Step 3: Dispatch Truth
Follow `team-lead/references/output-surface-law.md`.
Dispatch execution is silent while the next dispatch, monitoring, recovery, merge, or synthesis action can run.
Report only blocker, required user action, explicit status answer, next owner/action when blocked, or first `dispatch pending`.
Keep runtime setup, packet work, lane choice, receipt handling, and team-state changes internal.

The runtime truth ladder is owned by `references/truth-rules.md`. Apply it at every assignment-success, ack, progress, or recovery decision.

Reporting consequences:
- `dispatch pending` is reported once at first assignment success when a report is needed.
- No-change dispatch, ack, lane-count, waiting, and idle events stay internal.

Recovery reconciliation:
- A dispatch segment is not complete while any target lacks `dispatch-ack`, agent-start evidence, blocker, scope-pressure, failed-send truth, replacement truth, or explicit `HOLD`.
- Before monitoring, replacement, shutdown, or user-facing progress, reconcile every parallel target with runtime truth plus assigned-surface activity/side-effect evidence.
- Missing `dispatch-ack` after current dispatch check triggers one same-assignment receipt follow-up through `session-boot` before stale, replacement, or shutdown recovery.
- `dispatch-ack` without agent-start, blocker, scope-pressure, failure, or `HOLD` after the receipt segment triggers one same-assignment execution follow-up through `session-boot`.
- Keep unaffected independent targets moving while the affected target is recovered.
## Step 4: Interrupt / Resume Boundary
Use `references/dispatch-recovery.md` for detailed interruption points and resume actions.
If interruption occurs while this skill is active or before clean move-out, preserve the dispatch side-effect boundary before continuing.
Interruption includes user correction, self-growth trigger, compaction/resume, permission/runtime stop, control, lifecycle, and phase-transition interruption.

Required recovery record:
- `INTERRUPT-POINT`
- `LAST-PROVEN-DISPATCH-TRUTH`
- `RECOVERY-EVIDENCE`
- `PACKET-SEND-STATUS`
- `RUNTIME-SIDE-EFFECT`
- `RESUME-OWNER`
- `RESUME-ACTION`
- `REPLAN-REQUIRED`

Rules:
- pre-open interruption resumes the last valid active owner: `work-planning`, active workflow, or `self-verification`
- if the interruption happened after clean move-out, the current owner handles recovery
- use any dispatch recovery record only as evidence for `session-boot`, lane execution, team-lead synthesis, or `SV-RESULT`
- resume from the last proven dispatch truth, not memory, intent, or packet text
- resend an assignment-grade packet only when send evidence is absent and duplicate side-effect risk has been checked
- stronger agent-start or completion truth requires stronger evidence than `team exists`, `dispatch pending`, or `dispatch-ack`
- if the interruption moves any `work-planning` boundary-change axis, reopen `work-planning`
- if a behavioral or procedural defect meets the `self-growth-sequence` entry gate, open `self-growth-sequence`
- the suspended dispatch surface still requires `RESUME-OWNER` and verified `RESUME-ACTION` before closure or return
- partial dispatch maps to recovery or resume truth only
## Resolve Next Owner And Action
After the execution move:
- fallback standalone returned results, if already present, go to `team-lead` synthesis as bounded evidence only
- then `self-verification (SV-RESULT)` runs before phase/stage-end reporting or synthesis-triggered redispatch
- fallback standalone results stay outside team-runtime monitoring
- `session-boot` owns monitoring and agent-state interpretation
- agent lanes own execution and handoff/completion packets
- `team-lead` owns synthesis after agent outputs arrive
- `self-verification` reopens as `SV-RESULT` before phase/stage-end consequential reporting, completion claim, or synthesis-triggered re-dispatch

Canonical sequence:
1. `work-planning`
2. named workflow or sequence owner when `ACTIVE-WORKFLOW` or non-`not-applicable` `ACTIVE-SEQUENCE` is frozen
3. `task-execution`
4. `session-boot` runtime observation
5. agent execution
6. team-lead synthesis
7. `SV-RESULT`
8. user report or downstream consequential re-dispatch

## Move-Out Boundary
Keep out of this spine:
- long packet field catalogs -> `references/assignment-packet.md` and `references/request-bound-fields.md`
- lane-specific packet or handoff deltas -> agent references and role docs
- runtime monitoring/lifecycle recovery detail -> `session-boot` / `session-closeout`
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
