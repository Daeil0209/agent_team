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
Load and learn `Skill(task-execution)` at most once per Claude session by default; reload and relearn when current session loaded-and-learned basis is stale per the staleness rule in `## Activation` below. Load-and-learn triggers are assignment-grade dispatch, standalone `Agent` result classification, or dispatch recovery from a frozen route.
When active, it handles dispatch packet assembly, dispatch-bound binding-surface materialization, send truth, runtime creation/launch, and dispatch interruption state.
Use `references/phase-transition-control.md` without loading this skill when the active workflow owner sends phase context without new bounded work.

Boundary:
- `work-planning` handles scope freeze, mode freeze, and frozen next action
- `Skill(self-verification)` handles produced work-product outbound convergence before phase/stage-end reporting or handoff
- `session-boot` handles runtime monitoring and post-dispatch agent-state observation
- `team-lead` handles synthesis, closeout, and user-facing reporting

### Reference Map
After `Skill(task-execution)` is loaded and learned, load trigger-specific references named below.
- `.claude/reference/work-execution-core-law.md`: load for assignment-grade dispatch, packet assembly, runtime send truth, handoff, communication-plane movement, or dispatch recovery.
- `references/assignment-packet.md`: assignment-grade packet floor, receipt/completion contract, packet preflight, field format, skill loading, and cross-continuity packet checks.
- `references/dispatch-entry-contract.md`: consumed planning fields, concrete-vs-not-applicable rules, execution readiness entry checks, and information movement rule.
- `references/request-bound-fields.md`: request-intent, exact user wording, governance tier, user-surface, proof/tool/setup, run-path, burden, decision, validation, environment, and scenario fields.
- `references/message-classes.md`: Communication Plane law, canonical channel registry, upward message classes, receipt spine, structured shutdown request, information-request consumption, and blocker/pressure routing.
- `references/scope-pressure.md`: canonical `scope-pressure` values, required fields, and replan vs packet-correction boundary.
- Runtime truth ladder and user-facing claim limits consume `references/message-classes.md` `### Receipt Event Contract`, `### Transport Payload`, and `### Assignment Delivery Contract` + `.claude/skills/session-boot/references/runtime-state-detail.md` `## Canonical Runtime-State Model` and `## Agent Work States` + `references/runtime-dispatch-law.md` `## Team Runtime Shape` per the specific truth question; any admitted user answer omits internal dispatch/recovery detail and immediately resumes the next lawful internal move.
- `references/runtime-dispatch-law.md`: team-runtime lane dispatch, TeamCreate sequencing, parallel/reuse law, SendMessage class boundaries, required-skill dispatch law, and partial-parallel-failure recovery.
- `references/completion-handoff.md`: common completion result spine, resource cleanup, user-surface proof method fields, and lane completion law.
- `references/dispatch-recovery.md`: interruption points, resume owner/action, duplicate-send prevention, and compaction recovery.
- `references/phase-transition-control.md`: phase-transition packet schema.
- `references/lane-additions.md`: lane-specific packet-addition owner map and team-session controlled-value pointer.
- `.claude/reference/work-skill-reference-binding-law.md`: load for skill staleness rule, packet field vs loaded-and-learned skill law conflict resolution, applied-rule mapping consumption, and reference binding semantics.
## Activation
Load and learn `Skill(task-execution)` at most once per Claude session while same-session loaded-and-learned basis remains non-stale per the staleness rule below in this file.
First-load trigger: a frozen dispatch, reuse, blocker-clear, or standalone-result classification path requires `task-execution` AND no current same-session `task-execution` load-and-learn basis exists.
Stale basis reloads and relearns the skill per the staleness rule.
A second load under staleness conditions is not a "second activation".
After current same-session `task-execution` load-and-learn basis exists, later dispatch, reuse, blocker-clear, and route-iteration paths consume the loaded-and-learned skill instead of another `Skill(task-execution)` call.
Boundary changes refresh `work-planning` fields, route basis, dispatch-entry checks, and trigger-specific reference consumption; current same-session `task-execution` load-and-learn basis remains reusable under the activation rule.
`task-execution` activation basis is actual `Skill(task-execution)` load-and-learn or `same-session-loaded-and-learned:task-execution` for the current Claude session.
Same-session loaded-and-learned `task-execution` basis becomes stale per `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules` staleness rule (session changed, this skill file changed after invocation, compaction/drop/truncation can affect the needed rule, or active path needs unconsumed trigger-specific detail); stale basis reloads and relearns `Skill(task-execution)` or consumes the exact trigger-specific reference before action.
Direct reading, searching, listing, summarizing, or reference-map traversal of `.claude/skills/task-execution/**` is inspection only; activation basis requires actual skill load-and-learn or current same-session loaded-and-learned skill basis.
Skill load success, dispatch-owner entry, trigger-reference consumption plans, runtime-status observations, team-creation intent, binding-surface materialization intent, carrier-staging intent, and schema-discovery intent are internal dispatch process evidence, not report admission.
After activation, run the next required read, reference consumption, runtime, packet, send, recovery, wait, or `HOLD` move silently unless `.claude/reference/reporting-prohibition-law.md` admits a direct user answer.
Current boundary `work-planning` must be complete.
Any frozen named workflow or sequence owner must be complete.
Light channels, `answer-only`, lead-local single-surface paths, receipt-only state, runtime-cleanup state, and phase-transition-only state stay with their current owner.
Missing actual `work-planning` freeze discards the attempted dispatch path and returns to the missing owner before any dispatch step.
## Entry Contract
Use `references/dispatch-entry-contract.md` before this skill acts.
Hard surface:
- This skill must be active by actual `Skill(task-execution)` load-and-learn or current same-session activation basis before dispatch-bound binding-surface materialization, packet assembly, `TeamCreate`, `Agent`, assignment-grade `SendMessage`, reuse, or blocker-clear movement.
- Dispatch-bound materialization includes shared binding surfaces or charters, shard packets, retained assignment carriers, packet-family templates, and retained-output registry entries intended for assignment-grade dispatch.
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

Autonomy law:
- If Step 1 exposes unresolved user-owned choice, apply `.claude/reference/work-execution-core-law.md` `## Autonomy And Escalation Law`; otherwise select the evidence-backed execution move and continue without a decision-support detour.
## Step 2: Dispatch / Reuse
Run the actual execution move:
- create runtime when needed
- reuse a suitable live or standby agent when that is the frozen path
- dispatch new agents when reuse lacks fit
- assemble the real outgoing packet from the frozen plan basis
- write each per-lane dispatchable assignment carrier once with the complete line-atomic required fields defined by `references/assignment-packet.md` `### Field Format Discipline`
- prepare future-wave material as shared context or non-dispatchable planning records until the target is assignment/reuse-addressable and assignment-grade `SendMessage` is the next executable move for that target

Curtained dispatch surface:
- This block is the task-execution local reporting-curtain execution surface.
- It manages dispatch-specific non-reportable states and replacement actions only; it does not create report exceptions or restate final-report shape.
- Treat dispatch setup, correction, recovery, and transport evidence as internal material under `.claude/reference/reporting-prohibition-law.md`; issue the next lawful dispatch/correction/recovery move while one exists.
- Host-rendered `Skill(...)` success rows and `Read N files` rows are host UI, not assistant report admission. Assistant-authored prose immediately after those rows that interprets runtime state, confirms readiness, or announces the next materialization/send action is bridge narration and must be replaced by the next tool/file/send action.
- When a next lawful dispatch/correction/recovery move exists, suppress assistant-authored visible progress narration and execute that move. Do not render corpus counts, frozen-plan summaries, work-directory rationale, reference-consumption prerequisites, filesystem or output-root law consumption, runtime-boundary law consumption, deferred tool-schema discovery, current-runtime or team-registration checks, binding-surface verification, runtime/tool-schema setup, member counts, or carrier-writing status as user-facing prose.
- Phrases such as "I'm now in dispatch", "Let me consume", "the dispatch contract is clear", "runtime is inactive", "Team runtime is active", "runtime is active", "creating the team runtime", "now I will materialize", "now I'll write", or "now I will write" are dispatch narration. Replace them with the next required read, `ToolSearch`, `TeamCreate`, `Agent`, `SendMessage`, carrier write/check, wait, retry, blocker routing, or `HOLD`.
- Dispatch-readiness narration that states available dispatch machinery, required references, deferred schema lookup, current runtime checks, pre-`TeamCreate` preparation, active runtime confirmation, binding-surface materialization intent, shard-carrier materialization intent, or canonical work-folder intent is internal material.
- Replace that narration with the next required read, `ToolSearch`, `TeamCreate`, `Agent`, `SendMessage`, retry, wait, blocker routing, or `HOLD`.
- Packet-preflight PASS, idle/runtime chrome interpretation, hook or envelope correction, and recovery-effectiveness checks are internal dispatch/recovery evidence. Unless `.claude/reference/reporting-prohibition-law.md` admits a direct user-requested status answer, continue with packet send, envelope correction, retry, wait, or blocker routing without rendering those details.
- System-generated agent launch rows and lane `dispatch-ack` / `ack` rows already carry assignment-start visibility. After `TeamCreate`, `Agent`, or assignment-grade `SendMessage`, do not render separate member-created, agent-count, assignment-delivery, carrier-delivery, or "now sending" prose; continue directly with assignment-grade `SendMessage`, wait, recovery, or blocker routing.
- In this skill, `wait` means the governed runtime monitoring path or Monitor/until-loop owner path. It never means `Bash(sleep N; ls|cat|echo|ps|stat ...)`, chained sleeps, or sleep-delayed filesystem polling.
- run `.claude/skills/task-execution/references/message-classes.md` `### Assignment Delivery Contract` and packet final check before sending
- confirm retained-output carriers with real verification commands whose success surface is quiet and evidence-bearing; no-op placeholders such as `Bash(true)` are not verification
- Carry `DERIVED-DEFAULTS`, `REQUIRED-SKILLS`, `SKILL-RECOMMENDATIONS`, and request-bound packet fields only from the frozen planning basis or active workflow owner's phase-local refinement.
- Packet skill and request-bound field duties route through `references/assignment-packet.md` and `references/request-bound-fields.md`; dispatch preserves their frozen names and values.
- Missing, lane-mismatched, contradictory, or route-changing entries use the correction routing in those references.

Packet final check:
- Run packet preflight per `references/assignment-packet.md` against the frozen planning/workflow basis before send.
- Treat packet preflight PASS as observed dispatch evidence from `references/assignment-packet.md` exact checks; a prose assertion of PASS without those checks is not evidence.
- Without observed packet preflight PASS, send zero assignment-grade `SendMessage` calls for the defective packet; continue unaffected siblings through `parallel-continue` when the frozen route, active cap, proof separation, and owner boundaries remain intact.
- A packet family that shares phase, role, schema, and packet template is one preflight surface only for shared-template defects; row-local independence defects split or reassign the affected rows without blocking unaffected siblings.
- Apply packet field, receipt-completion, `SendMessage`, target-resolution, and spawn-prompt preflight through `references/assignment-packet.md`, `references/message-classes.md`, and `references/runtime-dispatch-law.md`.
- Retry assignment delivery only after correcting the exact preflight or tool-envelope defect named by those references.
- Send only after every frozen route axis is current, present, and coherent; same-owner packet defects return to the same frozen owner, and any moved `work-planning` boundary-change axis reopens `work-planning`.
- Assignment-grade work begins only through `SendMessage` after the live member address exists.
- Dispatches that will receive completion-grade carriers invoke Step 3 `Completion acceptance` upon receipt; the assigned lane's verification work must satisfy the citation requirements named there (`Skill(review-verification)` `PACKET-ID`, `Skill(self-verification)` tool-call evidence) for the completion to pass.

Dispatch law:
- Apply `references/runtime-dispatch-law.md` before any `TeamCreate`, `Agent`, parallel assignment-send segment, reuse-via-`SendMessage`, or packet-correction-via-`SendMessage` move.
- Consume `references/runtime-dispatch-law.md` for runtime entry evidence, runtime readiness classification, `TeamCreate`, team-scoped `Agent`, assignment-grade `SendMessage`, parallel dispatch lock, reuse, partial-parallel-failure recovery, and standalone-fallback classification.
- Consume `references/completion-handoff.md` for malformed, missing, or false retained-carrier completion payload routing.
- Configured lanes, frozen `PARALLEL-GROUPS`, lane separation, proof/acceptance separation, and packet skill-field law outrank reuse or dispatch convenience.
- Assignment-grade `SendMessage` uses the assignment-class transport defined by `references/message-classes.md`: a structured carrier-pointer object and complete `MESSAGE-CLASS: assignment` packet fields inside the governed carrier.
- Assignment-grade `SendMessage` payload passes the canonical structured assignment-carrier-pointer envelope in `references/message-classes.md`; hook denial opens same-owner envelope correction and actual `SendMessage` retry.
- Phase-transition control `SendMessage` uses phase-transition-control-class transport; rendered envelope stays no-detail and the governed phase packet carries `MESSAGE-CLASS: phase-transition-control`.
- Runtime cleanup uses structured `shutdown_request`.
- Match each `SendMessage` to the exact class or structured payload defined by its reference.
- `SendMessage` and retained carrier delivery carry assignment-grade teammate output.
- Treat member creation plus assignment send plus lane receipt plus subsequent lane work as one assignment execution block.
- Intermediate assignment-block states are not a user-report reason, status answer, wait boundary, or completion claim; keep them in packets, retained carriers, or internal evidence and continue the block.
- `dispatch-ack` may create an internal tool-turn boundary, but that boundary is not a wait, status, blocker, or user-report reason.
- System launch rows and lane `dispatch-ack` / `ack` receipt rows are not invitations for team-lead bridge prose. Do not add visible explanations below those rows; execute the next dispatch, monitoring, recovery, merge, synthesis, or `HOLD` action.
- Tool rejection or envelope correction inside dispatch/recovery remains part of the same internal execution block. Correct and retry or route the canonical blocker.
- Details required only by that block stay in its packet, retained carrier, or lane-local context.
- Bounded partial-parallel-failure recovery is valid only under `references/runtime-dispatch-law.md`; otherwise reopen `work-planning`.

Inside the frozen routed state, treat these as the only valid next actions:
- `TeamCreate`
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
Reporting admission and visible dispatch prose are owned by `.claude/reference/reporting-prohibition-law.md`.
Suppressed dispatch prose continues the next dispatch, monitoring, recovery, merge, synthesis, or locked parallel-dispatch action while it can run.
Transport dispatch state through `message-classes.md`; dispatch state remains internal unless reporting law grants a narrow user-report exception.
Keep runtime setup, packet work, lane choice, receipt handling, team-state changes, corrections, and recovery evidence internal.
A user interruption about dispatch, ack, idle, completion, or runtime state opens only reporting-law status-exception evaluation for the direct answer; it does not close, widen, or replan the dispatch block. After any admitted concise answer, resume from the last proven dispatch truth.
Apply `.claude/reference/work-execution-core-law.md` `## Direct Tool-Call Composition Law` for dispatch evidence, retained-output inspection, runtime checks, contained failure handling, and no-op placeholder rejection.
When `runtime-dispatch-law.md` opens `PARALLEL-DISPATCH-LOCK`, the next actions stay inside the allowed dispatch/reuse moves for every frozen nonblocked group.
Execute the lawful `PARALLEL-DISPATCH-LOCK` move; user-visible prose appears only through `.claude/reference/reporting-prohibition-law.md`.

Completion acceptance:
- Completion-class receipt opens completion acceptance per `references/completion-handoff.md` `## Common Completion Result Spine`.
- File presence, watcher success, mtime, size, or pre-completion carrier read is not completion acceptance and not merge-eligible input; it may only trigger monitoring or recovery for missing completion transport.
- Verify retained-carrier field presence and field-value truth through `references/completion-handoff.md`, `Skill(self-verification)` citation requirements, and `Skill(review-verification)` packet-citation requirements.
- Completion-class receipt, retained-carrier read, completion acceptance, and lane `STANDBY` state are internal nonterminal evidence.
- Those states do not create report admission, bridge-prose permission, milestone narration, completion claim, or wait-boundary prose.
- System-generated lane completion rows and `completion` transport already carry lane-completion visibility. After a lane completion row, completion-class `SendMessage`, or lane `STANDBY` observation, do not render separate completion-arrived, lane-completed, carrier-received, completion-accepted, or "now verifying/synthesizing" prose.
- After completion acceptance succeeds, immediately continue the next owning action silently: remaining carrier verification, synthesis, correction, monitoring, workflow phase movement, `Skill(self-verification)`, `Skill(review-verification)`, validation, redispatch, cleanup, or truthful `HOLD`.
- Do not render per-lane completion, carrier grade, coverage counts, live-evidence confirmation, phase-promotion prerequisite, accepted-lane inventory, or next internal procedure as user-facing prose unless `.claude/reference/reporting-prohibition-law.md` admits that exact user-requested material.
- Treat carrier-as-evidence fabrication as completion rejection and correction routing per `references/completion-handoff.md`.
- Reopen `work-planning` only when retained-carrier truth failure exposes a moved boundary axis.

Recovery reconciliation:
- Before monitoring, replacement, shutdown, or any direct status answer admitted by reporting law, reconcile every parallel target by exact live target with runtime truth plus assigned-surface activity or side-effect evidence.
- Consume `references/dispatch-recovery.md` for completion conditions, missing-`dispatch-ack` follow-up, `dispatch-ack`-without-agent-start follow-up, dead-or-unavailable classification, unaffected-target movement, and resume owner/action.
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
- what user-facing truth limit applies before agent-start evidence exists
- if interrupted, what last proven dispatch truth and resume owner/action apply
- which owner takes over next
