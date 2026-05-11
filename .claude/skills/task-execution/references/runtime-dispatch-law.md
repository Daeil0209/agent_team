---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
---

# task-execution: Runtime Dispatch Law

Load only when `task-execution/SKILL.md` Step 2 reaches dispatch-law detail.

## Team Runtime Shape
- `TeamCreate` establishes team-agent runtime only when no current-session team registration exists.
- Frozen routes naming additional lanes, `PARALLEL-GROUPS`, multiple concurrent agents, shared task/mailbox state, lifecycle monitoring, or continuity beyond lead-local work require team-agent runtime, not repeated `TeamCreate`.
- Standalone `Agent` is not configured lane dispatch.
- If the frozen path is team-agent operation and canonical current-session team-runtime evidence is absent while no current-session team registration exists, `TeamCreate` is the next execution move.
- If current-session team registration exists without live panes, recover through `session-boot` and reattach needed lanes with team-scoped `Agent` on the existing team.
- For new team runtime, `TeamCreate` must succeed before any team-scoped `Agent` dispatch.
- For current-session recovery, `session-boot` must precede team-scoped reattach.
- `Agent` before its owning entry path is a procedure violation, not a dispatch shape.

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
5. choose team-scoped `Agent` with top-level `team_name` and `name` when the lane is absent but team-runtime delegation remains the route
6. treat standalone host evidence only as legacy/fallback evidence, not dispatch
7. label the resulting truth before reporting: `dispatch pending`, fallback evidence, or `HOLD`

## Parallel And Reuse Law
- Configured project lanes come first.
- Additional-agent dispatch uses team-agent runtime.
- If no current-session team registration exists, `TeamCreate` is the next move before any `Agent`.
- Frozen `PARALLEL-GROUPS` and independent-surface separation outrank reuse convenience.
- If `PARALLEL-GROUPS` contains two or more nonblocked groups, dispatch or reuse the required agents in parallel within the same execution segment.
- Do this before monitoring or user-facing progress beyond `dispatch pending`.
- A parallel execution segment then reconciles every intended target before it moves out.
- Valid target states are `dispatch-ack`, agent-start evidence, blocker, scope-pressure, failed-send truth, replacement truth, or explicit `HOLD`.
- A target with no receipt or no start evidence enters `dispatch-recovery`; replacement or shutdown follows only after the required follow-up, frozen re-check wait, and absent response/activity evidence.
- Reuse a live or standby agent before unnecessary new spawn only when reuse preserves the frozen parallel shape, lane separation, and acceptance/proof separation.
- Do not reuse one agent when that would collapse independent frozen shards into a single-agent critical path.
- Lane-owned work must stay on the configured lane, not a generic helper path.

- Before new `Agent`, reuse a fitting live/standby agent when it preserves the frozen surface.
- Otherwise use the frozen concrete agent identity.
- Recoverable packet or target gaps route to packet correction, team-scoped creation, route replan, or lane `hold|blocker`.
- They do not route to hook-controlled blocking.

## SendMessage And Skill Law
- Assignment-grade `SendMessage` is for bounded assignment, reroute, or reuse against an open executable task per `truth-rules.md`.
- Completed-task correction first needs an open executable task whose `TaskUpdate` or `TaskCreate` result has returned before dependent dispatch or task mutation.
- Workflow-control `SendMessage` is for canonical `phase-transition-control` only.
- Lifecycle-only `SendMessage` is not assignment and does not replace dispatch.
- Agent-facing `REQUIRED-SKILLS` is mandatory on every assignment-grade packet as required non-lane-core skills frozen by planning or the active workflow owner.
- When no upstream required skill exists, carry `REQUIRED-SKILLS: []`; omission is invalid and listing the receiving lane-core skill is invalid.
- `task-execution` can narrow or phase-specialize the required skill basis only when the active workflow owner already resolved that phase-local basis.
- Same-owner missing or contradictory skill basis returns to that workflow owner.
- Any owner, lane, independent surface, proof, acceptance, or staffing change reopens `work-planning`.

## Partial Parallel Failure Recovery
When N parallel dispatches are attempted and M succeed while K fail before agent-start (Agent spawn failure, missing receipt, no-start receipt, or packet rejection), recover K without stopping M.

The failed K may be retried or reassigned to surviving M without reopening `work-planning` only when all hold:
- `AGENT-MAP`, `PARALLEL-GROUPS` independence, `LANE-REQUIRED-SKILLS-MAP`, and acceptance/proof separation are unchanged.
- The failure happened before agent-start evidence on the failed K.
- Surviving M can truthfully cover failed K's surface without packet shape change.

Otherwise reopen `work-planning` for redistribution per `CLAUDE.md` Communication And Reporting Law single-agent-collapse rule.

## Next-Action Drive
- Valid runtime creation, lane dispatch, or reuse returns to `task-execution` Step 3 Dispatch Truth.
- Required new team runtime opens `TeamCreate` through `task-execution`.
- Current-session runtime recovery opens `session-boot`.
- Missing live roster evidence opens target-resolution recovery before dispatch.
- Missing or contradictory packet skill basis returns to the same frozen owner when boundary axes stay unchanged.
- Changed owner, lane, independent surface, proof, acceptance, or staffing opens `work-planning`.
- Partial parallel failure follows `Partial Parallel Failure Recovery` or opens `work-planning`.
- Fallback standalone evidence returns to `team-lead` as bounded evidence only.
