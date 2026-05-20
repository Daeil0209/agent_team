---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "RPA-4 Lead-local candidate work; Work Execution Philosophy"
REPORTING-CURTAIN: .claude/reference/reporting-user-reporting-law.md
---
# team-lead: Lead-Local Guarded Law

## Purpose
Use this reference when team-lead might execute work locally instead of routing to a configured lane.

## Consume When
- `ROUTING-SIGNAL` is `lead-local candidate`.
- Work is read-only diagnostic, audit, or analytical.
- Local execution reveals a new work item or stronger claim.
- A same-route blocker-clear move is proposed.

## Required Output
Record:
- local item
- excluded lane-owned surfaces
- required local skills
- first action
- stop point
- evidence limit
- break condition result

## Stop
Stop before lead-local execution unless all direct work conditions hold.
Stop when local execution reveals new owner, new surface, hidden consequential step, or stronger claim.
Stop when a lane-owned proof, validation, review, implementation, or acceptance function appears.

## Resolve Next Owner And Action
- A stopped lead-local route opens `work-planning`.
- A new owner opens that owner.
- A new surface opens `work-planning`.
- A hidden consequential step opens `work-planning`.
- A stronger claim opens `work-planning`.
- A stopped lane-owned function reopens `.claude/skills/agent-team-lead/references/pre-action-gate.md` `### ROUTE` for next-owner selection.

## Direct Work Conditions
Lead-local execution is allowed only when all hold:
- one bounded surface
- no frozen independent lane owner
- no material review/proof/validator separation
- no meaningful parallelism loss
- no executable acceptance burden
- no destructive acceptance burden
- no security-sensitive acceptance burden
- no claim stronger than lead-local evidence can verify
- complete `LEAD-LOCAL-WORK-ITEMS`
- frozen `LEAD-LOCAL-REQUIRED-SKILLS`
- named first local item
- named stop point

## Read-Only Analytical Conditions
Read-only diagnostic, audit, and analytical reports stay lead-local only when all hold:
- one bounded surface
- no independent evidence-family separation
- no independent decision target
- no independent document section
- no independent production surface
- no independent source-of-truth boundary
- no independent interface or format boundary
- no independent proof burden
- no independent correction owner
- a `measured` footprint record under `.claude/reference/environment-runtime-footprint-continuity.md` `## Runtime Footprint Claims` shows no context-size, latency, or runtime-burden benefit from fan-out

Otherwise apply `[PARALLEL]` and route through one-time same-session `Skill(task-execution)` activation or loaded `task-execution` consumption according to current session state.

## Guarded-Local Rules
- Start local work from explicit `LEAD-LOCAL-WORK-ITEMS`.
- Local execution stays inside frozen local item list.
- If a new item appears, reopen `work-planning`.
- If a new surface appears, reopen `work-planning`.
- If route ambiguity appears, reopen `work-planning`.
- If a stronger claim appears, reopen `work-planning`.
- Lead-local required skills must be loaded and applied before local work.
- A lead-local specialist skill must declare `SECONDARY-CONSUMER: team-lead` or have another frozen lawful support basis.
- When a named local required skill is unavailable, reopen `work-planning`.
- When `work-planning` leaves the skill gap unresolved, report `HOLD`.
- Consume required skills before continuation.

## Team-Routing Guard
If `team-routing candidate` is frozen, carry required methodology or capability skills from the `LANE-REQUIRED-SKILLS-MAP` defined by `.claude/skills/work-planning/references/planning-record-fields.md`.
If `ambiguous-route` is frozen, carry required methodology or capability skills from lawful phase-local refinement.
Lane ownership triggers agent-specific skill loading.
Packet skill listing carries methodology or capability required skills.
Use `REQUIRED-SKILLS: []` to record absence of upstream required-skill basis.
