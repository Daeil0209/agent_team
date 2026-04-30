---
PRIMARY-OWNER: task-execution
LOAD-POLICY: on-demand reference only
---

# task-execution: Runtime Dispatch Law

Load only when `task-execution/SKILL.md` Step 2 reaches dispatch-law detail.

## Team Runtime Shape
- `TeamCreate` is used only for team-agent runtime. It is not standalone `Agent` dispatch.
- `TeamCreate` is required when the frozen route expects multiple assignment-grade turns across configured lanes that need shared task/mailbox state, lifecycle monitoring, or continuity beyond one synchronous returned result.
- Standalone `Agent` dispatch is valid only for one-off bounded lane work whose returned result can close the allowed deliverable, expose a blocker, or support replanning without a planned dependent lane handoff.
- If the frozen path is team-agent operation and canonical current-session team-runtime evidence is absent, `TeamCreate` is the next execution move.
- MUST sequence: when team runtime is needed, `TeamCreate` must succeed before any team-scoped `Agent` dispatch. `Agent` before `TeamCreate` is a procedure violation, not a dispatch shape.

## Team-Agent-Only Lane Dispatch
- When team runtime is active (`procedure-state.json` `teamRuntimeState: active`), every delegated lane dispatch via `Agent` must include `team_name` and `name` so the spawned agent joins the team runtime as a member addressable by `SendMessage`.
- Standalone `Agent` shape (`Agent` without `team_name`) is not a valid delegation channel for lane-owned work while team runtime is active. It bypasses team continuity, lifecycle visibility, reuse, and inter-agent coordination, and contradicts `session-boot` Mode Split's explicit-runtime activation.
- Any needed configured lane (`validator`, `reviewer`, `tester`, `developer`, or `researcher`) that is not yet present in the team runtime must be added as a team member via `Agent` with `team_name` and `name`; assignment-grade work then flows via `SendMessage` like any other team agent.
- Standalone `Agent` for delegated lane work is a procedure violation when the frozen route or active runtime requires team-agent operation.

## Parallel And Reuse Law
- Configured project lanes come first.
- Frozen `PARALLEL-GROUPS` and independent-surface separation outrank reuse cost.
- If `PARALLEL-GROUPS` contains two or more nonblocked groups, dispatch or reuse the required agents in parallel within the same execution segment before monitoring or user-facing progress beyond `dispatch pending`.
- Reuse a live or standby agent before unnecessary new spawn only when reuse preserves the frozen parallel shape, lane separation, and acceptance/proof separation.
- Do not reuse one agent when that would collapse independent frozen shards into a single-agent critical path.
- Lane-owned work must stay on the configured lane, not a generic helper path.

## SendMessage And Skill Law
- Assignment-grade `SendMessage` is for bounded assignment, reroute, or reuse.
- Workflow-control `SendMessage` is for canonical `phase-transition-control` only.
- Lifecycle-only `SendMessage` is not assignment and does not replace dispatch.
- Agent-facing `REQUIRED-SKILLS` is mandatory on every assignment-grade packet.
- When no additional non-lane-core skills are required, carry `REQUIRED-SKILLS: []`; omission is invalid and listing the receiving lane-core skill is invalid.
- `task-execution` may narrow or phase-specialize `REQUIRED-SKILLS` only when the active workflow owner already resolved that phase-local skill basis. Otherwise missing or contradictory skill basis reopens the previous freeze owner.

## Partial Parallel Failure Carve-Out
When N parallel dispatches are attempted and M succeed while K fail at receipt time (Agent spawn failure, ack timeout pre-start, or packet rejection), the failed K may be retried or reassigned to surviving M without reopening `work-planning` only when all hold:
- `AGENT-MAP`, `PARALLEL-GROUPS` independence, `LANE-REQUIRED-SKILLS-MAP`, and acceptance/proof separation are unchanged.
- The failure happened before agent-start evidence on the failed K.
- Surviving M can truthfully cover failed K's surface without packet shape change.

Otherwise reopen `work-planning` for redistribution per `CLAUDE.md` Communication And Reporting Law single-agent-collapse rule.
