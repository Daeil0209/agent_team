---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
---

# task-execution: Runtime Dispatch Law

Load only after `Skill(task-execution)` Step 2 reaches dispatch-law detail.

## Team Runtime Shape
- `TeamCreate` establishes team-agent runtime only when no current-session team registration exists.
- Team-agent runtime is required when the frozen route names any of: additional lanes, `PARALLEL-GROUPS`, multiple concurrent agents, shared task/mailbox state, runtime monitoring, or continuity beyond lead-local work.
- Repeated `TeamCreate` is not the path to satisfy these requirements; one runtime serves all of them.
- Standalone `Agent` is not configured lane dispatch.
- If the frozen path is team-agent operation and canonical current-session team-runtime evidence is absent while no current-session team registration exists, `TeamCreate` is the next execution move.
- If current-session team registration exists without live panes, recover through `session-boot` and reattach needed lanes with team-scoped `Agent` on the existing team.
- For new team runtime, `TeamCreate` must succeed before any team-scoped `Agent` member creation.
- For current-session recovery, `session-boot` must precede team-scoped reattach.
- `Agent` before its owning entry path is a procedure violation, not a dispatch shape.

## Runtime Entry Evidence Boundary
- `session-boot` classifies runtime-ready, runtime-blocked, monitoring-required, recovery-required, stale, stall, and cleanup truth.
- `task-execution` consumes that classification plus current-session dispatch evidence before any `TeamCreate`, team-scoped `Agent`, assignment-grade `SendMessage`, or assignment-grade reuse move.
- Current-session team registration evidence comes from the active procedure state, current team config, current live process-backed roster, or the hook-maintained team-runtime active marker when present.
- `TeamCreate` success is current-session team existence proof.
- Absence of current-session team registration opens `TeamCreate`.
- Current-session team registration without live process-backed roster opens `session-boot` recovery before team-scoped reattach.
- Team existence alone is not team-scoped launch readiness when hook policy requires tracked health monitoring; prove the required monitor or route the blocker before team-scoped `Agent`.
- Dispatch-runtime evidence is consumed here; do not require `session-boot/references/runtime-state-detail.md` as a hidden preflight for `TeamCreate`, team-scoped `Agent`, assignment-grade `SendMessage`, or assignment-grade reuse.

## Team-Agent-Only Lane Dispatch
- When team runtime is active (`procedure-state.json` `teamRuntimeState: active`), team-scoped `Agent` uses `team_name` and `name` to create or reattach a live member addressable by `SendMessage`.
- Planned team-routed `Agent` dispatch is never standalone; missing top-level `team_name` or `name` is a preflight blocker before the host `Agent` call.
- Team-scoped `Agent` does not deliver assignment-grade work.
- Standalone `Agent` shape (`Agent` without `team_name`) does not satisfy team-runtime delegation.
- Standalone `Agent` bypasses team continuity, cleanup visibility, reuse, and inter-agent coordination.
- An already-happened standalone `Agent` result is treated only as fallback evidence.
- Role is responsibility; live process-backed member name is address.
- `SendMessage.to` must match the current live process-backed roster exactly.
- Configured role labels (`validator`, `reviewer`, `tester`, `developer`, `researcher`) are addresses only when the roster contains that exact member with live pane proof.
- A needed configured lane not yet present in the team runtime is added as a team member via `Agent` with `team_name` and `name`.
- Assignment-grade work then flows via `SendMessage` to that exact member.
- Already-existing standalone `Agent` evidence is fallback evidence only.
- Fallback evidence is not team-member runtime state, `dispatch-ack`, assignment delivery, or later `SendMessage` addressability.

Target-resolution preflight is mandatory before the tool call:
1. name the active `team_name` from current-runtime evidence
2. read the live process-backed roster, not config residue
3. map the frozen target role to an exact live process-backed member name
4. choose `SendMessage` only on exact live-process roster match
5. choose team-scoped `Agent` with top-level `team_name` and `name` when the lane is absent but team-runtime delegation remains the route
6. treat standalone host evidence only as legacy/fallback evidence, not dispatch
7. label the resulting truth before any user-facing claim: `member-created`, `dispatch pending`, fallback evidence, or `HOLD`
8. after `member-created`, send assignment-grade `SendMessage` before monitoring, fallback dispatch, replacement, or user-facing progress

## Parallel And Reuse Law
- Configured project lanes come first.
- Additional-agent dispatch uses team-agent runtime.
- If no current-session team registration exists, `TeamCreate` is the next move before any `Agent`.
- When task tracking is active for team-agent dispatch, task rows used as assignment `TASK-ID` are created or verified only after current-session `TeamCreate` or team registration is proven and before assignment-grade `SendMessage`; pre-team task rows are not team assignment identity.
- Task rows provide `TASK-ID` identity; worker targeting and assignment delivery use assignment-grade `SendMessage.to`.
- Task rows are not assignment-owner, assignee, or in-progress tracking surfaces; `TaskUpdate` is completion-closure only.
- Frozen `PARALLEL-GROUPS` and independent-surface separation outrank reuse convenience.
- If `PARALLEL-GROUPS` contains two or more nonblocked groups, dispatch or reuse the required agents in parallel within the same execution segment.
- Do this before monitoring or any Reporting Plane status consideration; `dispatch pending` is internal dispatch truth unless `.claude/reference/user-reporting-law.md` admits an explicit status answer.
- When that condition holds, `PARALLEL-DISPATCH-LOCK` opens immediately after route freeze and target-resolution preflight.
- Parallel `Agent` batch dispatch is not a trial step; every `Agent` call in the batch must pass target-resolution, team-scope, and canonical spawn-prompt screen-safety preflight before the batch is sent.
- Ordinary team-scoped member creation uses the canonical prompt template from `message-classes.md`; alternate prompt text is a preflight exception, not the default.
- All-or-none batch preflight applies to every parallel same-class tool-call batch (`Agent`, `TaskCreate`, `SendMessage`, or any other tool family issued together in one parallel-batch segment).
- One invalid planned call in such a batch blocks the entire batch before any call in the batch is issued.
- Tool-call envelope shape (parameter tag form, namespace prefix, required-parameter presence, attribute names) must be verified call-by-call against the first validated call's exact envelope before send; same-class copy-paste without per-call shape verification is the named batch-preflight failure mode.
- A hook `BLOCKED` result, host `InputValidationError`, or `Invalid tool parameters` rejection on any call of a batch is batch-preflight-failure evidence; stop the rest of that dispatch shape and retry only after correcting the failed preflight cause.
- While `PARALLEL-DISPATCH-LOCK` is open, allowed moves are only: required `TeamCreate`; target-resolution preflight reads; binding-surface on-disk verification reads when the frozen packet's binding surface materializes as an external carrier; same-batch valid `TaskCreate` with top-level non-empty `subject` and `description` for assignment `TASK-ID` identity when task tracking is active; team-scoped `Agent`; assignment-grade `SendMessage`; silent retained-output directory or shared-carrier creation when the frozen packet requires it; or `hold|blocker`/`scope-pressure` for a proven dispatch blocker.
- Retained-output directory or shared-carrier creation while `PARALLEL-DISPATCH-LOCK` is open must not emit listing, count, probe, diagnostic output, or user-facing prose.
- While `PARALLEL-DISPATCH-LOCK` is open, do not run Codex/review tools, extra corpus reads, `TaskUpdate` mutations, packet-polishing passes, monitoring, synthesis, or user-facing prose before the dispatch/reuse attempt for every frozen nonblocked group.
- Do not narrate the lock, allowed move list, retained-output setup, or dispatch preparation; the next visible non-tool prose is only a report admitted by `.claude/reference/user-reporting-law.md`.
- Packet size or self-contained packet burden is not a reason to delay dispatch or omit receiver-required basis; put complete shared context in a retained carrier and send required-floor shard packets that point to it.
- A user challenge about missing parallel dispatch answers the cause through `.claude/reference/user-reporting-law.md` Tool-Adjacent Prose Suppression and then resumes the locked dispatch action unless the user redirects.
- A parallel execution segment then reconciles every intended target before it moves out.
- Assignment-grade `SendMessage` success arms a per-target receipt barrier keyed by the exact live process-backed member name.
- Assignment-send success is `dispatch pending` only; it is not `agent started`, `running`, progress, or completion.
- The receipt barrier clears only through official Communication Plane evidence: valid `dispatch-ack`, `scope-pressure`, `hold|blocker`, completion-grade `completion`, failed-send truth, replacement truth, or explicit `HOLD`.
- Pane/final prose, teammate UI chatter, host-native rendered rows, inbox read state, and role labels do not clear the receipt barrier.
- Valid target states after assignment send are `dispatch-ack`, agent-start evidence, blocker, scope-pressure, failed-send truth, replacement truth, or explicit `HOLD`. `member-created` without assignment is `team-created-no-assignment` and immediately opens assignment-grade `SendMessage` on the same frozen route; it is not monitoring, fallback dispatch, or operator-policy-choice when the frozen route remains unchanged.
- A target with no receipt or no start evidence enters `dispatch-recovery`; replacement or shutdown follows only after the required follow-up, frozen re-check wait, and absent response/activity evidence.
- Reuse a live or standby agent before unnecessary new spawn only when reuse preserves the frozen parallel shape, lane separation, and acceptance/proof separation.
- Do not reuse one agent when that would collapse independent frozen shards into a single-agent critical path.
- Lane-owned work must stay on the configured lane, not a generic helper path.
- Recoverable packet or target gaps route to packet correction, team-scoped creation, route replan, or lane `hold|blocker`.
- They do not route to hook-controlled blocking.

## SendMessage And Skill Law
- Assignment-grade `SendMessage` is for bounded assignment, reroute, or reuse against an open executable task per `truth-rules.md`.
- `SendMessage.to` is the worker-targeting field for assignment; task-row mutation is not worker targeting.
- Completed-task correction first needs an open executable task whose `TaskCreate` result has returned before dependent dispatch or task mutation.
- Workflow-control `SendMessage` is for canonical `phase-transition-control` only.
- Runtime-cleanup `SendMessage` is not assignment and does not replace dispatch.
- Agent-facing `REQUIRED-SKILLS` is mandatory on every assignment-grade packet as required methodology or capability skills frozen by planning or the active workflow owner.
- When no upstream required skill exists, carry `REQUIRED-SKILLS: []`; omission is invalid and listing the receiving agent-specific skill is invalid.
- `task-execution` can narrow or phase-specialize the required skill basis only when the active workflow owner already resolved that phase-local basis.
- Same-owner missing or contradictory skill basis returns to that workflow owner.
- Any owner, lane, independent surface, proof, acceptance, or staffing change reopens `work-planning`.

## Partial Parallel Failure Recovery
When N parallel dispatches are attempted and M succeed while K fail before agent-start, recover K without stopping M.
The K-failure conditions are: Agent spawn failure, missing receipt, no-start receipt, or packet rejection.

The failed K is retried or reassigned to surviving M without reopening `work-planning` only when all hold:
- `AGENT-MAP`, `PARALLEL-GROUPS` independence, `LANE-REQUIRED-SKILLS-MAP`, and acceptance/proof separation are unchanged.
- The failure happened before agent-start evidence on the failed K.
- Surviving M can truthfully cover failed K's surface without packet shape change.

Otherwise reopen `work-planning` for redistribution per `CLAUDE.md` `## Communication` single-agent-collapse rule.

## Resolve Next Owner And Action
- Valid runtime creation, lane dispatch, or reuse returns to `task-execution` Step 3 Dispatch Truth.
- Required new team runtime opens `TeamCreate` through `task-execution`.
- Current-session runtime recovery opens `session-boot`.
- Missing live roster evidence opens target-resolution recovery before dispatch.
- Missing or contradictory packet skill basis returns to the same frozen owner when boundary axes stay unchanged.
- Changed owner, lane, independent surface, proof, acceptance, or staffing opens `work-planning`.
- Partial parallel failure follows `Partial Parallel Failure Recovery` or opens `work-planning`.
- Fallback standalone evidence returns to `team-lead` as bounded evidence only.
