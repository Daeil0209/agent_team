---
PRIMARY-OWNER: task-execution
LOAD-POLICY: on-demand reference only
---

# task-execution: Runtime Dispatch Law

Load only when `task-execution/SKILL.md` Step 2 reaches dispatch-law detail.

## Team Runtime Shape
- `TeamCreate` is used only for team-agent runtime. It is not standalone `Agent` dispatch.
- `TeamCreate` is required for configured lane additional-agent dispatch.
- `TeamCreate` is required when the frozen route names any additional lane, `PARALLEL-GROUPS`, multiple concurrent agents, shared task/mailbox state, lifecycle monitoring, or continuity beyond lead-local work.
- Standalone `Agent` is not configured lane dispatch.
- If the frozen path is team-agent operation and canonical current-session team-runtime evidence is absent, `TeamCreate` is the next execution move.
- MUST sequence: when team runtime is needed, `TeamCreate` must succeed before any team-scoped `Agent` dispatch. `Agent` before `TeamCreate` is a procedure violation, not a dispatch shape.

## Team-Agent-Only Lane Dispatch
- When team runtime is active (`procedure-state.json` `teamRuntimeState: active`), every delegated lane dispatch via `Agent` must include `team_name` and `name` so the spawned agent joins the team runtime as a member addressable by `SendMessage`.
- Standalone `Agent` shape (`Agent` without `team_name`) does not satisfy team-runtime delegation. It bypasses team continuity, lifecycle visibility, reuse, and inter-agent coordination. If it already happened, treat its result only as fallback evidence.
- Role is responsibility; live process-backed member name is address. `SendMessage.to` must match the current live process-backed roster exactly. Configured role labels (`validator`, `reviewer`, `tester`, `developer`, `researcher`) are addresses only when the roster contains that exact member with live pane proof.
- Any needed configured lane that is not yet present in the team runtime must be added as a team member via `Agent` with `team_name` and `name`; assignment-grade work then flows via `SendMessage`. If standalone `Agent` evidence already exists, report it as fallback evidence, not team-member lifecycle state, `dispatch-ack`, or later `SendMessage` addressability.

Target-resolution preflight is mandatory before the tool call:
1. name the active `team_name` from current-runtime evidence
2. read the live process-backed roster, not config residue
3. map the frozen target role to an exact live process-backed member name
4. choose `SendMessage` only on exact live-process roster match
5. choose team-scoped `Agent(team_name, name)` when the lane is absent but team-runtime delegation remains the route
6. treat standalone host evidence only as legacy/fallback evidence, not dispatch
7. label the resulting truth before reporting: `dispatch pending`, fallback evidence, or `HOLD`

## Parallel And Reuse Law
- Configured project lanes come first.
- Additional-agent dispatch uses team-agent runtime.
- If current-session team runtime is absent, `TeamCreate` is the next move before any `Agent`.
- Frozen `PARALLEL-GROUPS` and independent-surface separation outrank reuse convenience.
- If `PARALLEL-GROUPS` contains two or more nonblocked groups, dispatch or reuse the required agents in parallel within the same execution segment.
- Do this before monitoring or user-facing progress beyond `dispatch pending`.
- A parallel execution segment then reconciles every intended target before it moves out.
- Valid target states are `dispatch-ack`, agent-start evidence, blocker, scope-pressure, failed-send truth, replacement truth, or explicit `HOLD`.
- A target with no receipt or no start evidence is a recovery target, not a wait state.
- Reuse a live or standby agent before unnecessary new spawn only when reuse preserves the frozen parallel shape, lane separation, and acceptance/proof separation.
- Do not reuse one agent when that would collapse independent frozen shards into a single-agent critical path.
- Lane-owned work must stay on the configured lane, not a generic helper path.

- Before new `Agent`, reuse a fitting live/standby agent when it preserves the frozen surface.
- Otherwise use the frozen concrete agent identity.
- Recoverable packet or target gaps route to packet correction, team-scoped creation, route replan, or lane `hold|blocker`.
- They do not route to hook-owned blocking.

## SendMessage And Skill Law
- Assignment-grade `SendMessage` is for bounded assignment, reroute, or reuse against an open executable task per `truth-rules.md`.
- Completed-task correction first needs an open executable task whose `TaskUpdate` or `TaskCreate` result has returned before dependent dispatch or task mutation.
- Workflow-control `SendMessage` is for canonical `phase-transition-control` only.
- Lifecycle-only `SendMessage` is not assignment and does not replace dispatch.
- Agent-facing `REQUIRED-SKILLS` is mandatory on every assignment-grade packet as recommended non-lane-core skills.
- When no upstream recommendation exists, carry `REQUIRED-SKILLS: []`; omission is invalid and listing the receiving lane-core skill is invalid.
- `task-execution` can narrow or phase-specialize the recommended skill basis only when the active workflow owner already resolved that phase-local basis.
- Same-owner missing or contradictory skill basis returns to that workflow owner.
- Any owner, lane, independent surface, proof, acceptance, or staffing change reopens `work-planning`.

## Partial Parallel Failure Recovery
When N parallel dispatches are attempted and M succeed while K fail before agent-start (Agent spawn failure, missing receipt, no-start receipt, or packet rejection), recover K without stopping M.

The failed K may be retried or reassigned to surviving M without reopening `work-planning` only when all hold:
- `AGENT-MAP`, `PARALLEL-GROUPS` independence, `LANE-REQUIRED-SKILLS-MAP`, and acceptance/proof separation are unchanged.
- The failure happened before agent-start evidence on the failed K.
- Surviving M can truthfully cover failed K's surface without packet shape change.

Otherwise reopen `work-planning` for redistribution per `CLAUDE.md` Communication And Reporting Law single-agent-collapse rule.
