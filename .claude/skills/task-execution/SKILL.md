---
name: task-execution
description: Use after work-planning+SV-PLAN freeze host-authorized additional-agent dispatch; governs packets, moves, truth; not light, lead-local, receipt/control/lifecycle/phase-transition-only.
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Inherits `CLAUDE.md`, the active owner role, and the common inheritance floor in `CLAUDE.md` `Priority And Ownership`. This skill may sharpen its owned procedure or specialist surface, but it must not weaken that floor or the owning role's stop conditions.
- Fixed section order: Purpose, Activation, Entry Contract, Step 1: Activate Frozen Route, Step 2: Dispatch / Reuse, Step 3: Dispatch Truth, Step 4: Interrupt / Resume Boundary, Step 5: Next Owner, Move-Out Boundary
- PRIMARY-OWNER: team-lead
- Structural changes require governance review.
## Purpose
This skill owns host-authorized additional-agent execution after planning and `self-verification` in `SV-PLAN` mode are already complete.
This is the team-lead dispatch governance owner skill. It is not always-loaded context, and it must not be loaded for light channels, lead-local work, receipt-only state, lifecycle-only state, control-only state, or phase-transition-only state.
When active, it is the highest-priority team-lead-local procedure for dispatch governance before optional methodology or specialist skills. It still cannot override `CLAUDE.md`, its activation trigger, `work-planning`, the active workflow or sequence owner, `self-verification`, `session-boot`, or `session-closeout`.
It owns:
- activation of the frozen routed state
- selection of the next concrete execution move inside that frozen state
- dispatch packet assembly and final check
- actual standalone `Agent` dispatch, team-agent runtime creation, team-scoped agent launch, and assignment-grade `SendMessage`
- dispatch-phase truth before control returns to runtime monitoring
- dispatch interruption state needed to resume without duplicate dispatch, stale route use, or inflated runtime truth

It does not own control-only sending. Control packet templates in `references/phase-transition-control.md` and `references/lifecycle-control.md` may be used by the active workflow or lifecycle owner without loading this skill.

Boundary:
- `work-planning` owns scope freeze, mode freeze, and frozen next action
- `self-verification` owns `SV-PLAN` and `SV-RESULT`
- `session-boot` owns runtime monitoring and post-dispatch agent-state observation
- `team-lead` owns synthesis, closeout, and user-facing reporting

### Reference Map
Load these files directly from `SKILL.md` when their trigger is active. Do not route through an intermediate `reference.md`.
- `references/assignment-packet.md`: assignment-grade packet floor, packet preflight, field format, skill loading, and cross-continuity packet checks.
- `references/dispatch-entry-contract.md`: consumed planning fields, concrete-vs-not-applicable rules, execution readiness entry checks, and information movement rule.
- `references/request-bound-fields.md`: request-intent, exact user wording, governance tier, user-surface, proof/tool/setup, run-path, burden, decision, validation, environment, and scenario fields.
- `references/message-classes.md`: common message law, upward message classes, receipt spine, information-request consumption, and blocker/pressure routing.
- `references/scope-pressure.md`: canonical `scope-pressure` values, required fields, and replan vs packet-correction boundary.
- `references/truth-rules.md`: runtime truth ladder and user-facing claim limits.
- `references/runtime-dispatch-law.md`: TeamCreate vs standalone Agent, team-runtime-only lane dispatch, parallel/reuse law, SendMessage class boundaries, required-skill dispatch law, and partial-parallel-failure carve-out.
- `references/completion-handoff.md`: common completion result spine, resource cleanup, user-surface proof method fields, and lane handoff law.
- `references/dispatch-recovery.md`: interruption points, resume owner/action, duplicate-send prevention, and compaction recovery.
- `references/phase-transition-control.md`: phase-transition control packet schema.
- `references/lifecycle-control.md`: lifecycle-control packet schema and structured shutdown protocol.
- `references/lane-additions.md`: lane-specific packet-addition owner map and team-session controlled-value pointer.
## Activation
Open this skill only when the current path is already frozen for host-authorized additional-agent dispatch after current-turn `work-planning`, any frozen named workflow or sequence owner, and `self-verification` in `SV-PLAN` mode.
Do not open this skill for true light channels, `answer-only` turns, lead-local single-surface paths, receipt-only state, lifecycle-only state, control-only state, or phase-transition-only state.
If planning or `self-verification` in `SV-PLAN` mode is missing, return immediately to that owner before any dispatch step.
## Entry Contract
Use `references/dispatch-entry-contract.md` before this skill acts.
Hard surface:
- Required prior owners: current-turn `work-planning`, any frozen workflow/sequence owner, current-turn `SV-PLAN`, and a frozen additional-agent or ambiguous dispatch route.
- New agent dispatch also requires a host-authorized active-runtime path.
- `EXECUTION-READINESS-BASIS` must be `ready:<basis>` for assignment-grade dispatch; `blocked:<basis>` may enter only for a dispatch-owned blocker-clear move.
- Missing, contradictory, stale, or invalid `not-applicable` route fields reopen `work-planning`; do not repair the route by habit inside `task-execution`.
- Agents receive bounded assignment packets derived from the freeze, never the full internal planning block.
## Step 1: Activate Frozen Route
Select only the next concrete execution move that preserves the frozen routed state:
- lane ownership
- independent parallelism
- required review/proof/validation separation
- honest next-action truth

Core rule:
- `lead-local candidate` does not belong here
- an additional-agent route enters here as a frozen routed state
- `ambiguous-route` defaults to team-routed handling, not lead-local compression

Keep explicit:
- whether the next move is standalone `Agent` dispatch, team-agent runtime creation, reuse by assignment message, team-scoped agent launch, parallel-agent dispatch, or blocker clearance
- whether the frozen dispatch is single-lane, mirrored, or parallel-sharded
- the exact serial reason when `PARALLEL-GROUPS` is `none`
## Step 2: Dispatch / Reuse
This skill owns the actual execution move:
- create runtime when needed
- reuse a suitable live or standby agent when that is the frozen path
- dispatch new agents when reuse does not fit
- assemble the real outgoing packet from the frozen plan basis
- run the packet final check before sending
- carry agent-facing `REQUIRED-SKILLS` from the frozen planning basis or the active workflow owner's phase-local refinement
- carry `REQUEST-BOUND-PACKET-FIELDS` from the frozen planning basis as exact agent-facing request-fit fields when the receiving lane's contract needs original request shape, exact instruction wording, user surface, burden cue, or acceptance basis to plan, verify, or judge the assigned surface truthfully
- carry frozen `SKILL-RECOMMENDATIONS` only when `work-planning` or the active workflow owner already resolved methodology guidance for the receiving lane; missing, lane-mismatched, or ownership-changing recommendations reopen the previous freeze owner

Packet final check:
- every assignment-grade packet must carry `MESSAGE-CLASS`, `WORK-SURFACE`, `CURRENT-PHASE`, `REQUIRED-SKILLS`, and `TASK-ID` when task tracking is active
- every assignment-grade packet must be self-contained for teammate context isolation; do not rely on lead-only conversation history, unlinked prior reasoning, or implied upstream decisions
- packet preflight must reconcile the outgoing packet against `EXECUTION-READINESS-BASIS`; a missing packet value may be corrected inside `task-execution` only when the value already exists in the frozen basis and the same owner, phase, surface, deliverable, proof/acceptance chain, and staffing shape remain unchanged
- if the missing or contradictory value is absent from the frozen basis, stale, or route-changing, stop and reopen `work-planning`
- if `REQUEST-BOUND-PACKET-FIELDS` is non-empty, every named field must be present in the outgoing packet or the path returns to `work-planning`
- if `SKILL-RECOMMENDATIONS` is non-empty, each recommendation must be lane-scoped, bounded to the assigned `WORK-SURFACE`, and consistent with `REQUIRED-SKILLS`; otherwise the path returns to the previous freeze owner
- user-surface, proof, tool, run-path, burden, decision, validation, environment, and scenario fields are carried exactly when required by `.claude/skills/task-execution/references/request-bound-fields.md`
- no packet may leak the full internal planning block

Dispatch law:
- Apply `references/runtime-dispatch-law.md` before any `TeamCreate`, `Agent`, `parallel-agent-dispatch`, or reuse-via-`SendMessage` move.
- `TeamCreate` is team-agent runtime creation, not standalone `Agent` dispatch; when team runtime is required, `TeamCreate` must succeed before any team-scoped `Agent` dispatch.
- When team runtime is active, delegated lane `Agent` dispatch must be team-scoped with `team_name` and `name`. Standalone `Agent` for lane-owned work is a procedure violation.
- Configured lanes, frozen `PARALLEL-GROUPS`, lane separation, proof/acceptance separation, and packet `REQUIRED-SKILLS` law outrank reuse cost or dispatch convenience.
- Assignment-grade `SendMessage`, workflow-control `SendMessage`, and lifecycle-only `SendMessage` are distinct message classes; do not substitute one for another.
- Bounded partial-parallel-failure recovery is allowed only under the exact carve-out in `references/runtime-dispatch-law.md`; otherwise reopen `work-planning`.

Inside the frozen routed state, treat these as the only valid next actions:
- `TeamCreate`
- `reuse-via-SendMessage`
- `Agent`
- `parallel-agent-dispatch`
- `clear-blocker:<exact blocker>`
Branch rule:
- branch inside `task-execution` only across these frozen execution moves and packet templates
- do not branch into a new route, new owner, or new claim class here
- if a branch would require new route judgment, new work surface decomposition, or changed ownership, reopen `work-planning` first
## Step 3: Dispatch Truth
This skill must keep runtime truth narrow.

Runtime-only truth ladder:
- standalone `Agent` success -> synchronous returned result, not team-runtime `dispatch pending`
- `TeamCreate` success -> `team exists`
- team-scoped `Agent` or assignment-grade `SendMessage` success -> `dispatch pending`
- `dispatch-ack` -> receipt only
- agent-originated progress or first real agent action -> `agent started`

Therefore:
- do not report `agent started` from dispatch success alone
- do not report `running`, `underway`, or equivalent when only dispatch-pending evidence exists
- if only planning is frozen, report only the next action
- if team-agent runtime creation succeeded but no agent dispatch followed yet, report only `team exists` or the next dispatch move
- do not present `team exists` as the ordinary user-facing primary truth unless the user explicitly asks for runtime state; otherwise translate it to the narrow next action, or to `dispatch pending` only after assignment success
- if dispatch succeeded but start evidence is absent, report only `dispatch pending`
## Step 4: Interrupt / Resume Boundary
Use `references/dispatch-recovery.md` for detailed interruption points and resume actions.
If an interruption, user correction, self-growth trigger, compaction/resume event, permission/runtime stop, or control/lifecycle/phase-transition interruption occurs while this skill is active or before a clean move-out, preserve the dispatch side-effect boundary before continuing.

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
- if the interruption happened before this skill opened, do not open `task-execution` as a recovery owner; reopen the last valid active owner such as `work-planning`, the active workflow, or `self-verification`
- if the interruption happened after clean move-out, the current owner handles recovery; use any dispatch recovery record only as evidence for `session-boot`, lane execution, team-lead synthesis, or `SV-RESULT`
- resume from the last proven dispatch truth, not memory, intent, or packet text
- do not resend an assignment-grade packet unless send evidence is absent and duplicate side effect risk has been checked
- do not promote `team exists`, `dispatch pending`, or `dispatch-ack` into stronger agent-start or completion truth
- if the interruption invalidates route, owner, work surface, acceptance chain, proof surface, or skill basis, reopen `work-planning`
- if a behavioral or procedural defect meets the `self-growth-sequence` entry gate, open `self-growth-sequence`; the suspended dispatch surface still requires `RESUME-OWNER` and verified `RESUME-ACTION` before closure or return
- partial dispatch is not completion, started-work, or agent-output truth
## Step 5: Next Owner
After the execution move:
- standalone `Agent` returned results go to `team-lead` synthesis, then `self-verification (SV-RESULT)` before reporting or redispatch; they do not enter team-runtime monitoring
- `session-boot` owns monitoring and agent-state interpretation
- agent lanes own execution and handoff/completion packets
- `team-lead` owns synthesis after agent outputs arrive
- `self-verification` reopens as `SV-RESULT` before consequential reporting, completion claim, or synthesis-driven re-dispatch

Canonical sequence:
1. `work-planning`
2. named workflow or sequence owner when `ACTIVE-WORKFLOW` or non-`not-applicable` `ACTIVE-SEQUENCE` is frozen
3. `SV-PLAN`
4. `task-execution`
5. `session-boot` runtime observation
6. agent execution
7. team-lead synthesis
8. `SV-RESULT`
9. user report or downstream consequential re-dispatch

Canonical standalone `Agent` sequence replaces steps 5-6 with the synchronous returned result, then continues through team-lead synthesis and `SV-RESULT`.
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
