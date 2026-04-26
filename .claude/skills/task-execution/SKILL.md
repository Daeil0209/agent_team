---
name: task-execution
description: Task execution procedures for team-lead dispatch governance and delivery verification.
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Fixed section order: Purpose, Activation, Entry Contract, Step 1: Determine Execution Shape, Step 2: Dispatch / Reuse, Step 3: Dispatch Truth, Step 4: Next Owner, Move-Out Boundary
- PRIMARY-OWNER: team-lead
- Structural changes require governance review.
## Purpose
This skill owns team-routed execution after planning and `SV-PLAN` are already complete.
It owns:
- staffing shape activation
- dispatch vs reuse choice
- dispatch packet assembly and final check
- actual `TeamCreate`, `Agent`, and assignment-grade `SendMessage`
- dispatch-phase truth before control returns to runtime monitoring

Boundary:
- `work-planning` owns scope freeze, mode freeze, and frozen next action
- `self-verification` owns `SV-PLAN` and `SV-RESULT`
- `session-boot` owns runtime monitoring and post-dispatch worker-state observation
- `team-lead` owns synthesis, closeout, and user-facing reporting
## Activation
Open this skill only when the current path is team-routed or route-ambiguous after current-turn `work-planning`, any frozen named workflow owner, and `SV-PLAN`.
Do not use this skill as a substitute for planning or verification.
## Entry Contract
Before this skill acts, the lead must already have:
- current-turn `work-planning`
- the current frozen workflow owner already opened when `ACTIVE-WORKFLOW` is present
- current-turn `SV-PLAN`
- a frozen route that is `team-routing candidate` or `ambiguous-route`

This skill consumes the frozen fields in this order:
1. `ROUTING-SIGNAL`
2. `NEXT-CONSEQUENTIAL-ACTION`
3. `DISPATCH-BLOCKERS`
4. `AGENT-MAP`
5. `PARALLEL-GROUPS`
6. `LANE-REQUIRED-SKILLS-MAP`
7. `ACTIVE-WORKFLOW` when present

If one of these is missing or contradictory, stop and reopen `work-planning`; do not repair the route by habit inside `task-execution`.

Information movement rule:
- `work-planning` -> `team-lead/task-execution` uses internal carry-forward of the frozen planning basis
- `task-execution` -> worker uses an assignment-grade dispatch packet derived from that basis
- worker -> `team-lead` uses message-class reports (`dispatch-ack`, `control-ack`, `status`, `scope-pressure`, `handoff|completion`, `hold|blocker`)
- do not send the full internal planning block to workers
- translate only the bounded fields needed for the worker's owned surface
## Step 1: Determine Execution Shape
Choose the smallest reliable team-routed shape that preserves:
- lane ownership
- independent parallelism
- required review/proof/validation separation
- honest next-action truth

Core rule:
- `lead-local candidate` does not belong here
- `team-routing candidate` enters here directly
- `ambiguous-route` defaults to team-routed handling, not lead-local compression

Keep explicit:
- whether the path is `TeamCreate`, `reuse-via-SendMessage`, `Agent`, or `clear-blocker`
- whether the dispatch is single-lane, mirrored, or parallel-sharded
- the exact serial reason when `PARALLEL-GROUPS` is `none`
## Step 2: Dispatch / Reuse
This skill owns the actual execution move:
- create runtime when needed
- reuse a suitable live or standby worker when that is the frozen path
- dispatch new workers when reuse does not fit
- assemble the real outgoing packet from the frozen plan basis
- run the packet final check before sending
- carry worker-facing `REQUIRED-SKILLS` from the frozen planning basis or the active workflow owner's phase-local refinement
- carry request-fit conditional fields when the receiving lane's contract needs original request shape or exact instruction wording to plan, verify, or judge the assigned surface truthfully
- carry frozen `SKILL-RECOMMENDATIONS` when planning or the active workflow already resolved methodology guidance for the receiving lane

Dispatch law:
- **MUST** sequence — when team runtime is needed (per `session-boot` Mode Split), `TeamCreate` must succeed before any `Agent` dispatch. `Agent` before `TeamCreate` is a procedure violation, not a dispatch shape.
- configured project lanes first
- frozen `PARALLEL-GROUPS` and independent-surface separation outrank reuse cost
- reusable live or standby worker before unnecessary new spawn only when reuse preserves the frozen parallel shape, lane separation, and acceptance/proof separation
- do not reuse one worker when that would collapse independent frozen shards into a single-worker critical path
- lane-owned work must stay on the configured lane, not a generic helper path
- assignment-grade `SendMessage` is for bounded assignment, reroute, or reuse
- workflow-control `SendMessage` is for canonical `phase-transition-control` only
- lifecycle-only `SendMessage` is not assignment and does not replace dispatch
- worker-facing `REQUIRED-SKILLS` is mandatory on every assignment-grade packet
- `task-execution` may narrow or phase-specialize `REQUIRED-SKILLS` only when the active workflow owner already resolved that phase-local skill basis; otherwise missing or contradictory skill basis reopens the previous freeze owner
- bounded partial-parallel-failure carve-out: when N parallel dispatches are attempted and M succeed while K fail at receipt time (Agent spawn failure, ack timeout pre-start, packet rejection), the failed K may be retried or reassigned to surviving M without reopening `work-planning` only when ALL hold: (a) `AGENT-MAP`, `PARALLEL-GROUPS` independence, `LANE-REQUIRED-SKILLS-MAP`, and acceptance/proof separation are unchanged; (b) the failure happened BEFORE worker-start evidence on the failed K; (c) surviving M can truthfully cover failed K's surface without packet shape change. Otherwise reopen `work-planning` for redistribution per CLAUDE.md `Communication And Reporting Law` single-worker-collapse rule.

For compact routing, treat these as the only valid next actions:
- `TeamCreate`
- `reuse-via-SendMessage`
- `Agent`
- `clear-blocker:<exact blocker>`
Branch rule:
- branch inside `task-execution` only across these frozen execution moves and packet templates
- do not branch into a new route, new owner, or new claim class here
- if a branch would require new route judgment, new work surface decomposition, or changed ownership, reopen `work-planning` first
## Step 3: Dispatch Truth
This skill must keep runtime truth narrow.

Truth ladder:
- `TeamCreate` success -> runtime available
- `Agent` or assignment-grade `SendMessage` success -> `dispatch pending`
- `dispatch-ack` -> receipt only
- worker-originated progress or first real worker action -> `worker started`

Therefore:
- do not report `worker started` from dispatch success alone
- do not report `running`, `underway`, or equivalent when only dispatch-pending evidence exists
- if only planning is frozen, report only the next action
- if dispatch succeeded but start evidence is absent, report only `dispatch pending`
## Step 4: Next Owner
After dispatch:
- `session-boot` owns monitoring and worker-state interpretation
- worker lanes own execution and handoff/completion packets
- `team-lead` owns synthesis after worker outputs arrive
- `self-verification` reopens as `SV-RESULT` before consequential reporting, completion claim, or synthesis-driven re-dispatch

Canonical sequence:
1. `work-planning`
2. named workflow owner when `ACTIVE-WORKFLOW` is frozen
3. `SV-PLAN`
4. `task-execution`
5. `session-boot` runtime observation
6. worker execution
7. team-lead synthesis
8. `SV-RESULT`
9. user report or downstream consequential re-dispatch
## Move-Out Boundary
Keep out of this spine:
- long packet field catalogs -> `reference.md`
- lane-specific packet or handoff deltas -> worker references and role docs
- runtime monitoring/lifecycle recovery detail -> `session-boot` / `session-closeout`
- worker-only completion contracts -> worker role docs
- broad evidence-burden or claim-strength rules -> `self-verification`

Rule:
Compaction is valid only while the operator can still answer, immediately and without skimming:
- why `task-execution` opened
- which frozen fields it consumed
- what exact dispatch move it owns now
- what user-facing truth limit applies before worker-start evidence exists
- which owner takes over next
