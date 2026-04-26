---
name: work-planning
description: Universal work planning procedure for all agents.
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Fixed section order: Purpose, Activation Trigger, Step 0: Request-Fit Intake, Step 1: Q1-Q5 Work Analysis, Step 2: Freeze Scope And Route, Internal Planning Record, Progress Update Surface, Post-Planning Gate
- PRIMARY-OWNER: team-lead
- Structural changes require governance review.
## Purpose
Freeze scope before consequential work begins. This skill remains the owner of consequential mode freeze.
Quick contract:
- load at work start, reuse, reroute, or true scope change
- expand the thin interpreted request basis into full request fit before consequential action
- classify purpose, work type, governing workflow, stream relationship, and supporting skills
- freeze `PROJECT-TIER`, `ACTIVE-REQUEST-TIER`, and `TIER-RAISE-REASON` when governance depth is active or already known for the project
- freeze `ACTIVE-WORKFLOW` when one named workflow owns the path
- freeze `ACTION-CLASS`, `ROUTING-SIGNAL`, and `NEXT-CONSEQUENTIAL-ACTION`
- freeze `LEAD-LOCAL-WORK-ITEMS` when lead-local execution remains legitimate
- freeze `LEAD-LOCAL-REQUIRED-SKILLS` when team-lead will execute local consequential work directly
- freeze `LANE-REQUIRED-SKILLS-MAP` when worker lanes will receive assignment-grade packets
- freeze `AGENT-MAP`, `PARALLEL-GROUPS`, and `DISPATCH-BLOCKERS` when team routing is needed
- hand directly to the post-planning gate: frozen workflow owner when present, otherwise `self-verification`
Boundary:
- `team-lead` owns the first thin instruction interpretation and channel opening
- this skill owns the planning freeze
- `task-execution` owns dispatch mechanics, runtime activation, and packet execution
- `self-verification` owns plan/result verification gates
- `session-boot` still comes first for the main session when boot is pending
- the frozen planning record is an internal carry-forward surface; it is not the worker-facing dispatch packet
## Activation Trigger
Load this skill after Priority 0 (`agents/team-lead.md`) classifies the turn as consequential (Q2 = consequential). Priority 0 answers carry forward as input to Step 0 — do not re-derive them. Then execute the full procedure:
1. At task start for any fresh consequential assignment.
2. At reuse or reroute when a live or standby worker receives new consequential work.
3. At scope, phase, or route change that opens a new consequential surface.
4. Before the first consequential tool call on new or reopened work.
If the turn is truly `answer-only`, `SV-only audit`, or `notification-only`, this skill does not own the path.
Execution subject rule:
- this file is the procedure owner, not the autonomous actor
- the current actor loading this skill produces the freeze
- top-level `team-lead` produces the freeze for top-level consequential work
- delegated workers produce the freeze for their bounded lane-owned assignments
## Step 0: Request-Fit Intake
Expand and freeze the real request basis before Step 1.
Start from the thin interpretation already made by `team-lead`; this step deepens it into the consequential freeze owner surface.
Record:
- `REQUEST-INTENT`
- `CONCRETE-DELIVERABLE`
- `PRIMARY-USER`
- `REFERENCE-USE`
- `BURDEN-REDUCTION-CUES`
- `QUALITY-PROOF-DIRECTION`
- `DERIVED-DEFAULTS`
- `MATERIAL-BLOCKERS`
Full intake is mandatory when the task is reference-driven, corrected for earlier misread intent, or depends on burden-reduction / usability / delivery-experience cues.
If the incoming top-level interpretation is too weak, contradictory, or obviously misfit for the chosen channel, repair it here and continue as the freeze owner; do not push a thin or guessed basis forward.
## Step 1: Q1-Q5 Work Analysis
Before scope freeze, answer:
1. What is the real purpose?
2. What work type or types are present?
3. What governing workflow or methodology owns each type?
4. Are the streams local single-surface, independent, sequential, or interdependent?
5. Which supporting skills are needed inside each stream?
Hold instead of guessing when purpose, work type, or governing workflow cannot be named truthfully.
If truthful proof or acceptance depends on a user-facing surface the current toolchain cannot yet exercise, freeze one bounded tooling/setup owner path instead of allowing source-only fallback by habit.
When the truthful surface is important and no exact tool has been frozen yet, prefer a bounded discovery/setup path over an immediate permanent block when a credible surface-faithful tool is likely available.
For `team-lead`, make route-shaping inputs explicit now: artifact-under-review, evidence-expansion need, judgment-closure risk, and whether independent reads are possible.
When project complexity or request-specific risk materially changes governance depth, load and consume `governance-scaling` before final route freeze. Keep project floor separate from active request tier; do not infer one from the other by habit.
## Step 2: Freeze Scope And Route
Freeze the minimum plan basis required for truthful next action.
Keep in the spine:
1. Request-fit intake before consequential scope freeze
2. Q1-Q5 purpose/work-type/channel/relationship/supporting-skill analysis
3. Governance scaling basis when active:
   - `PROJECT-TIER`
   - `ACTIVE-REQUEST-TIER`
   - `TIER-RAISE-REASON`
4. Frozen route ownership:
   - `ACTIVE-WORKFLOW`
   - `ACTION-CLASS`
   - `ROUTING-SIGNAL`
   - `NEXT-CONSEQUENTIAL-ACTION`
5. Lead-local execution basis when needed:
   - `LEAD-LOCAL-WORK-ITEMS`
   - `LEAD-LOCAL-REQUIRED-SKILLS`
6. Team-lead routing basis when needed:
   - `AGENT-MAP`
   - `PARALLEL-GROUPS`
   - `DISPATCH-BLOCKERS`
   - `LANE-REQUIRED-SKILLS-MAP`
7. Direct handoff to the post-planning gate

Keep explicit:
- `ACTIVE-WORKFLOW` is frozen here, not by top-level interpretation alone
- when governance depth is active, freeze `PROJECT-TIER` first, then `ACTIVE-REQUEST-TIER`, then `TIER-RAISE-REASON` before deeper routing or staffing decisions continue
- `PROJECT-TIER` sets the floor; `ACTIVE-REQUEST-TIER` may stay or raise, but it must not silently rewrite the project floor
- tier may reduce unnecessary governance burden, but it must not be used to downshift decisive user-surface proof or acceptance integrity
- when Step 1 Q3 names `dev-workflow`, freeze `ACTIVE-WORKFLOW: dev-workflow` before the post-planning gate
- `team-lead` opens this skill from a thin interpreted basis; `work-planning` owns the first full consequential freeze
- `work-planning` is where `team-lead` decides `lead-local candidate` vs `team-routing candidate`
- `lead-local candidate` is lawful only for one bounded surface with no frozen independent lane owner, no material review/proof/validator separation, no meaningful parallelism loss, no executable/destructive/security-sensitive acceptance burden, and no need to make a claim stronger than lead-local evidence can verify
- planning opens exactly one next owner; it does not silently fall through into execution, dispatch, or report
- that one next owner is the supervisory owner from the current control point; once routing is frozen, `AGENT-MAP` and `PARALLEL-GROUPS` may authorize multiple parallel worker openings inside the same frozen routing decision, and those openings are not competing next owners
- if `ROUTING-SIGNAL` is `lead-local candidate`, freeze every planned consequential local item before execution begins
- if `ROUTING-SIGNAL` is `lead-local candidate`, freeze every non-owner skill the acting subject must load to complete that bounded local path truthfully under `LEAD-LOCAL-REQUIRED-SKILLS`
- `NEXT-CONSEQUENTIAL-ACTION` must name the first frozen local item or an exact blocker-clear move, not vague continued inspection
- if a new consequential local item or surface appears later, reopen `work-planning` instead of extending the pass by habit
- if routing is team-routed or ambiguous, planning must leave the next owner unambiguous
- if routing is team-routed or ambiguous, freeze each lane's `REQUIRED-SKILLS` under `LANE-REQUIRED-SKILLS-MAP`; `task-execution` may translate or phase-refine that basis, but it may not invent worker skill openings by habit
- if decisive user-surface proof requires missing tool acquisition, setup, or bridge work, freeze one bounded tooling path through `external-tool-bridge` or the exact owning setup lane; do not let downstream workers silently search, install, or downgrade by habit
- if the exact tool is not yet known but the surface is clear, freeze the discovery objective, verification standard, and cleanup boundary rather than prematurely freezing a guessed tool name
- if a later local parallel launch mechanism fails, serial carry-forward is lawful only when the failure happens before worker-boundary commitment and the fallback stays inside the same frozen owner, surface set, deliverable, acceptance chain, and material burden/timing meaning.
- if losing the planned parallel path changes staffing truth, independent-surface separation, burden, schedule, or closure risk, reopen `work-planning` instead of silently collapsing to serial continuation.
- planning is not runtime dispatch authority; dispatch mechanics stay with `task-execution`
- worker-boundary transfer happens later through `task-execution` packet translation, not by forwarding the full internal plan block
## Internal Planning Record
After planning, freeze the internal plan block before the first consequential action after this skill load.
This block is **internal carry-forward only**. Do NOT emit this block, its fields, or any labelled freeze line (e.g., `PROJECT-TIER:`, `ROUTING-SIGNAL:`, `NEXT-CONSEQUENTIAL-ACTION:`, `LEAD-LOCAL-WORK-ITEMS:`, `AGENT-MAP:`) inside the user-facing assistant message — including in audit reports, completion summaries, or compliance-justification turns. Hold it in internal context for the duration of the current turn — do not write it to a continuity file by habit. Surface only what `Progress Update Surface` allows.
```
PROJECT-TIER:
ACTIVE-REQUEST-TIER:
TIER-RAISE-REASON:
ACTIVE-WORKFLOW:
ACTION-CLASS:
ROUTING-SIGNAL:
LEAD-LOCAL-WORK-ITEMS:
LEAD-LOCAL-REQUIRED-SKILLS:
AGENT-MAP:
PARALLEL-GROUPS:
LANE-REQUIRED-SKILLS-MAP:
NEXT-CONSEQUENTIAL-ACTION:
DISPATCH-BLOCKERS:
```
Rules:
- `PROJECT-TIER` is mandatory when the project has already been tiered or the current plan explicitly sizes governance depth.
- `ACTIVE-REQUEST-TIER` is mandatory whenever `PROJECT-TIER` is present on a consequential `team-lead` plan.
- `TIER-RAISE-REASON` is mandatory whenever `PROJECT-TIER` is present; record `stay` explicitly when no material raise signal exists.
- `ACTIVE-WORKFLOW` is mandatory when one named workflow governs the path.
- `ROUTING-SIGNAL`, `NEXT-CONSEQUENTIAL-ACTION`, and `DISPATCH-BLOCKERS` are mandatory for consequential `team-lead` plans.
- `LEAD-LOCAL-WORK-ITEMS` is mandatory when `ROUTING-SIGNAL` is `lead-local candidate`.
- `LEAD-LOCAL-REQUIRED-SKILLS` is mandatory when `ROUTING-SIGNAL` is `lead-local candidate` and the acting subject needs any non-owner skill to complete the frozen local path truthfully.
- `AGENT-MAP` and `PARALLEL-GROUPS` are mandatory when routing is team-routed or becomes team-routed after one named blocker-clear move.
- `LANE-REQUIRED-SKILLS-MAP` is mandatory when routing is team-routed or ambiguous-route.
- If `PARALLEL-GROUPS` is `none`, record the exact serial reason.
- `NEXT-CONSEQUENTIAL-ACTION` must point to the first named local item or exact blocker-clear move, not an implied "inspect more".
- If execution reveals a new consequential local item that is not frozen here, stop and reopen `work-planning`.
- A bounded correction may stay inside the same frozen owner, surface, deliverable, and acceptance chain through fresh verification plus packet correction or bounded local carry-forward.
- That bounded correction exception ends immediately when execution reveals a hidden consequential step, new owner, new surface, or changed acceptance chain.
- Do not treat this full record as the outbound worker message. Downstream worker communication must receive a bounded assignment packet derived from this freeze by `task-execution`.
## Progress Update Surface
If a progress update is actually needed before execution:
- use plain prose only
- keep it to one or two sentences
- mention only the current decision, next action, or blocker
- do not expose planning fields, packet labels, the literal `Internal Planning Record` block, or any labelled freeze line (e.g., `PROJECT-TIER:`, `ROUTING-SIGNAL:`, `NEXT-CONSEQUENTIAL-ACTION:`, `LEAD-LOCAL-WORK-ITEMS:`, `AGENT-MAP:`)
- exposing the internal plan to defend a procedural decision is itself a procedure violation, not transparency; the user's verification basis is the verified result and concise basis prose, not the raw plan block
## Post-Planning Gate
After planning:
1. Open exactly one next owner.
2. If `ACTIVE-WORKFLOW` is set, load that workflow owner first. The workflow owner then hands to `self-verification` before any local execution, `task-execution`, or reporting.
3. Otherwise load `self-verification` immediately; planning does not jump straight to local execution, `task-execution`, or reporting.
4. If `ROUTING-SIGNAL` is `team-routing candidate` or `ambiguous-route`, `SV-PLAN` must validate the route before `task-execution`.
5. If the frozen route or next action is missing, vague, or contradicted by verification, reopen `work-planning` instead of improvising.
