---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# task-execution: Runtime Dispatch Law

Load only after `Skill(task-execution)` Step 2 reaches dispatch-law detail.

## Team Runtime Shape
- `TeamCreate` requires the dispatch-entry contract, including current mandatory `PLAN-VERIFICATION-BASIS`, before runtime creation.
- `TeamCreate` establishes team-agent runtime only when no current-session team registration exists.
- Team-agent runtime is required when the frozen route is parallel-fit for independent specialist work or names any of: additional lanes, `PARALLEL-GROUPS`, multiple concurrent agents, shared task/mailbox state, runtime monitoring, or continuity beyond lead-local work.
- Repeated `TeamCreate` is not the path to satisfy these requirements; one runtime serves all of them.
- If the frozen path is team-agent operation and canonical current-session team-runtime evidence is absent while no current-session team registration exists, `TeamCreate` is the next execution move.
- If current-session team registration exists without live panes, recover through `session-boot` and reattach needed lanes with team-scoped `Agent` on the existing team.
- For new team runtime, `TeamCreate` must succeed before any team-scoped `Agent` member creation.
- For current-session recovery, `session-boot` must precede team-scoped reattach.
- `Agent` before its owning entry path is a procedure violation, not a dispatch shape.
- For deferred team-runtime tool schemas, consume `.claude/reference/work-runtime-boundary-law.md` and fetch the schema via `ToolSearch` before the first `TeamCreate`, team-scoped `Agent`, or assignment-grade `SendMessage`; deferred visibility is not new-tool acquisition, runtime unavailability, or direct-Agent fallback basis outside team runtime.

## Runtime Entry Evidence Boundary
- `session-boot` classifies runtime-ready, runtime-blocked, monitoring-required, recovery-required, stale, stall, and cleanup truth.
- `task-execution` consumes current-session dispatch evidence before any `TeamCreate`, team-scoped `Agent`, assignment-grade `SendMessage`, or assignment-grade reuse move.
- Dispatch evidence is valid only after required current `PLAN-VERIFICATION-BASIS` passes.
- Current or required `session-boot` classification travels with that dispatch evidence.
- Current-session team registration evidence comes from the active procedure state, current team config, current live process-backed roster, or the hook-maintained team-runtime active marker when present.
- `TeamCreate` success is current-session team existence proof.
- Absence of current-session team registration opens `TeamCreate`.
- Current-session team registration without live process-backed roster opens `session-boot` recovery before team-scoped reattach.
- Team existence alone is not team-scoped launch readiness when hook policy requires tracked health monitoring; prove the required monitor or route the blocker before team-scoped `Agent`.
- Dispatch-runtime evidence on this owner surface is the launch preflight for `TeamCreate`, team-scoped `Agent`, assignment-grade `SendMessage`, and assignment-grade reuse.

## Team-Agent-Only Lane Dispatch
- When team runtime is active (`procedure-state.json` `teamRuntimeState: active`), team-scoped `Agent` creates or reattaches a live member address keyed by `team_name` and `name` and addressable by `SendMessage`.
- Planned team-routed `Agent` dispatch is always team-scoped; missing top-level `description`, `prompt`, `team_name`, or `name` is a preflight blocker before the host `Agent` call.
- Planned team-scoped `Agent` dispatch requires current mandatory `PLAN-VERIFICATION-BASIS` before target-resolution or host `Agent` call.
- The canonical spawn prompt supplies only the `prompt` value. It never satisfies, replaces, weakens, or carries assignment detail for top-level `description`, `team_name`, `name`, or other current host-schema envelope requirements.
- Team-scoped `Agent.name`, `team_name`, `description`, and `prompt` are assistant-authored renderable envelope fields when the host displays them; keep them compact identity/setup only and move assignment packets, evidence, counts, paths, blocker detail, result text, acceptance language, and completion detail through assignment-grade `SendMessage` plus governed non-rendered carriers.
- Before any team-scoped `Agent` call, verify the current host `Agent` envelope and required top-level parameters against the planned call; if the current host schema differs from this reference, consume the current schema evidence and correct this reference through governance modification before relying on the changed shape.
- A host/background `Agent` batch that runs reviewer/tester/validator/researcher/developer work without `team_name`, `name`, and assignment-grade `SendMessage` is route drift, even when the visible role label names a configured lane.
- Assignment-grade work delivery uses `SendMessage` after team-scoped `Agent` creates or reattaches the live member address.
- Direct `Agent` shape outside team runtime (`Agent` without `team_name`) is fallback evidence only for already-produced or lead-local evidence-only output.
- Codex-relay carve-out: a single `run_in_background` standalone `Agent` (no `team_name`) is sanctioned for exactly one purpose — relaying a `mcp__codex__codex` call and returning its evidence — so the team-lead/team is not blocked on the external call. This is the only background-standalone exception and is not route drift; the relay's configured lane role matches the checked work type (investigation->researcher, implementation cross-check->developer, review->reviewer, proof analysis->tester, validation->validator). All other configured lane work uses default team-agent runtime dispatch, the relay never substitutes team-agent dispatch, and team-lead retains adjudication, acceptance, route, and user-facing-claim ownership over the returned codex evidence.
- Direct `Agent` outside team runtime bypasses team continuity, cleanup visibility, reuse, inter-agent coordination, receipt, and completion transport.
- Operational burden, context size, setup friction, or coordination overhead is not a direct-Agent fallback basis outside team runtime for configured lane work, frozen `PARALLEL-GROUPS`, multi-surface audit work, or required review/proof/validation separation.
- When those surfaces remain required, choose team-scoped `Agent` plus assignment-grade `SendMessage`, reopen `work-planning` for cap, shard, or serial-route change, or record blocker-routing for a proven runtime blocker after internal recovery is exhausted.
- An already-happened direct-Agent result outside team runtime is treated only as bounded fallback evidence.
- A rendered host row that shows background agents running is host-runtime observation only; it is not team-runtime dispatch, receipt, active-lane state, reuse state, or completion transport.
- Role is responsibility; live process-backed member name is address.
- The assignment-delivery address must match the current live process-backed roster exactly per `message-classes.md` `### Assignment Delivery Contract`.
- Configured role labels (`validator`, `reviewer`, `tester`, `developer`, `researcher`) are addresses only when the roster contains that exact member with live pane proof.
- A needed configured lane not yet present in the team runtime is added through the team-scoped `Agent` member-creation envelope.
- Assignment-grade work then flows via `SendMessage` to that exact member.
- Fallback evidence is not team-member runtime state, `dispatch-ack`, assignment delivery, or later `SendMessage` addressability.

Target-resolution preflight is mandatory before the tool call:
1. name the active `team_name` from current-runtime evidence
2. read the live process-backed roster, not config residue
3. map the frozen target role to an exact live process-backed member name
4. choose assignment-grade `SendMessage` only on exact live-process roster match through `message-classes.md` `### Assignment Delivery Contract`
5. choose team-scoped `Agent` with the current required top-level member-creation envelope when the lane is absent but team-runtime delegation remains the route
6. create or verify the neutral identity task row through `message-classes.md` `### Assignment Delivery Contract` before assignment-grade `SendMessage` only when task tracking is active and screen-safe
7. treat direct host-Agent evidence outside team runtime only as legacy/fallback evidence, not dispatch
8. record the resulting truth internally before any later reporting-law-admitted user-facing claim: `member-created`, `task-row-created`, `dispatch pending`, fallback evidence, or blocker-routing with exhausted internal recovery basis. Do not render member-created, task-row-created, live-roster, cap, wave, round, dispatch-pending, or receipt-barrier labels as team-lead prose.
9. after `member-created` or `task-row-created`, send assignment-grade `SendMessage` before monitoring, fallback dispatch, replacement, or reporting-law-admitted prose

## Parallel And Reuse Law
- Configured project lanes come first.
- Additional-agent dispatch uses team-agent runtime.
- If no current-session team registration exists, `TeamCreate` is the next move before any `Agent` only after dispatch-entry and current mandatory `PLAN-VERIFICATION-BASIS` pass.
- When task tracking is active and screen-safe for team-agent dispatch, consume `message-classes.md` `### Assignment Delivery Contract` before assignment-grade `SendMessage` and before task-scoped mutation.
- Runtime dispatch keeps `TaskCreate`, `TaskUpdate`, task identity, and worker targeting inside that contract.
- Task-state synchronization follows `message-classes.md` `### Assignment Delivery Contract`: update the same `TASK-ID` immediately at lifecycle transitions, never by changing a rendered row's owner, assignee, subject, or description, and never as a substitute for transport or retained-carrier truth.
- Frozen `PARALLEL-GROUPS` and independent-surface separation outrank reuse convenience.
- Runtime dispatch follows frozen `ACTIVE-CONCURRENT-AGENT-CAP`.
- Before any same-segment parallel dispatch, reuse batch, or new `Agent`, count current live or standby dispatched-lane members plus planned nonblocked assignment targets.
- A live or standby dispatched-lane member stays in the count until shutdown or termination evidence removes it from the active roster.
- If the count is at cap and a no-longer-needed live or standby member blocks required new member creation, complete `shutdown_request` before any new `Agent`.
- A batch that would exceed frozen `ACTIVE-CONCURRENT-AGENT-CAP` reopens `work-planning` for shard merging, sub-batching, or sequential phasing.
- If `PARALLEL-GROUPS` contains two or more nonblocked groups, dispatch or reuse the required agents in parallel within the same execution segment.
- Do this before monitoring or any Reporting Plane status consideration; `dispatch pending` is internal dispatch truth unless `.claude/reference/reporting-prohibition-law.md` grants a narrow exception for an explicit status answer.
- Dispatch, reuse, cap, runtime-readiness, shard, wave, round, target-state, and receipt-barrier facts stay internal Procedure Plane or Communication Plane truth; `task-execution` keeps required evidence in tool results, retained carriers, or runtime state, and any `Bash` evidence command follows `.claude/reference/work-runtime-boundary-law.md` `### Bash Internal Evidence Capture Contract`.
- When that condition holds, `PARALLEL-DISPATCH-LOCK` opens only after route freeze, dispatch-entry contract pass, current mandatory `PLAN-VERIFICATION-BASIS` pass, and target-resolution preflight.
- Parallel `Agent` batch dispatch is not a trial step; every `Agent` call in each atomic same-envelope subgroup must pass target-resolution, team-scope, tool-envelope, and canonical spawn-prompt screen-safety preflight before that subgroup is sent.
- Ordinary team-scoped member creation uses the canonical prompt template from `message-classes.md`; alternate prompt text is a preflight exception, not the default.
- All-or-none batch preflight applies only to an atomic same-envelope subgroup that cannot be segmented without changing frozen route, cap, lane separation, proof/acceptance separation, or payload truth.
- One invalid planned call blocks only its affected atomic subgroup; independent valid subgroups proceed while the invalid target routes to packet correction, target correction, or route replan.
- Tool-call envelope shape (parameter tag form, namespace prefix, required-parameter presence, attribute names) must be verified call-by-call against the first validated call's exact envelope before send; same-class copy-paste without per-call shape verification is the named batch-preflight failure mode.
- The spawn-prompt template is not a first validated call envelope. A first validated team-scoped `Agent` envelope includes the current required top-level fields.
- A hook `BLOCKED` result, host `InputValidationError`, or `Invalid tool parameters` rejection on any call of a batch is batch-preflight-failure evidence only when the rejection matches a protected runtime rule or tool-envelope requirement; over-broad positive-pattern or doctrine-shape hook blocks route to hook narrowing/removal while preserving the valid dispatch path.
- While `PARALLEL-DISPATCH-LOCK` is open, every move must directly create, verify, send, or repair the next dispatch state for a frozen nonblocked group.
- Allowed lock moves are only: required `TeamCreate`; deferred team-runtime tool schema discovery via `ToolSearch`; target-resolution preflight reads; binding-surface on-disk verification reads for the frozen packet's external carrier; quiet output-root and retained-path collision preflight reads for the frozen retained-output registry; same-batch valid `TaskCreate` satisfying `message-classes.md` `### Assignment Delivery Contract` for assignment `TASK-ID` identity only when task tracking is active and screen-safe; team-scoped `Agent`; assignment-grade `SendMessage`; or retained-output directory or shared-carrier creation without assistant-authored visible output when the frozen packet requires it.
- Narrow blocker exception: `hold|blocker` or `scope-pressure` for a proven dispatch blocker is the only lawful exit from lock-move execution; it is not one of the lock moves listed above but the lawful abandonment of the lock when execution cannot proceed.
- Retained-output directory or shared-carrier creation while `PARALLEL-DISPATCH-LOCK` is open uses no assistant-authored visible output: no listing, count, probe, diagnostic output, or user-facing prose.
- After any assignment-grade `SendMessage` cites a shared binding surface, that cited surface is frozen for already-dispatched lanes. Corrections use a per-lane correction packet, a versioned addendum for future lanes, or route replan; do not edit the already-cited binding file while live lanes are working from it.
- Per-lane correction for already-dispatched live lane work preserves the frozen `TASK-ID`, `WORK-SURFACE`, `RETAINED-OUTPUT-PATH`, and `WRITE-SCOPE` unless the prior assignment has been reconciled as no-side-effect, closed by accepted retained carrier, or superseded by route replan.
- A correction that changes `RETAINED-OUTPUT-PATH` while the prior lane can still produce output is duplicate side-effect risk; route through `dispatch-recovery` or route replan instead of sending another packet.
- `PARALLEL-DISPATCH-LOCK` contains only lawful lock moves until the dispatch/reuse attempt runs for every frozen nonblocked group; reads outside target-resolution or binding-surface verification are extra reads.
- Codex/review tools, lead-side `TaskUpdate` mutations, packet rewrites after `assignment-packet.md` preflight has passed, monitoring, synthesis, and user-facing prose are outside the lock.
- Plan-draft review-verification is not a lock move; missing or failed mandatory `PLAN-VERIFICATION-BASIS` blocks lock opening.
- Lock state, lawful move list, retained-output setup, and dispatch preparation stay internal; visible non-tool prose appears only as a report admitted by `.claude/reference/reporting-prohibition-law.md` and shaped by `.claude/reference/reporting-user-reporting-law.md`.
- Packet size or self-contained packet burden is not a reason to delay dispatch or omit receiver-required basis; put complete shared context in a retained carrier and send required-floor shard packets that point to it.
- A user challenge about missing parallel dispatch answers the cause only through `.claude/reference/reporting-prohibition-law.md` admission and `.claude/reference/reporting-user-reporting-law.md` shape control, then resumes the locked dispatch action unless the user redirects.
- A parallel execution segment then reconciles every intended target before it moves out.
- Assignment-grade `SendMessage` success arms a per-target receipt barrier keyed by the exact live process-backed member name.
- Assignment-send success is `dispatch pending` only; it is not `agent started`, `running`, progress, or completion.
- The receipt barrier clears only through official Communication Plane evidence: message-classes token-only `dispatch-ack`, token-only `scope-pressure`, token-only `hold|blocker`, completion-grade token-only `subjob-done`, failed-send truth, replacement truth, or team-lead-recorded blocker-routing with exhausted internal recovery basis. `problem-report` preserves receipt-pending state until one of those resolution outcomes occurs.
- Token-only `dispatch-ack`, `scope-pressure`, `hold|blocker`, and `subjob-done` projections are transport evidence only; they never authorize adjacent team-lead prose, status/progress sentences, waiting narratives, completion previews, or continuation promises.
- Pane/final prose, teammate UI chatter, host-native rendered rows, inbox read state, and role labels do not clear the receipt barrier.
- Valid target states after assignment send are `problem-reported-pending-outcome`, token-only `dispatch-ack`, completion-grade token-only `subjob-done`, token-only `scope-pressure`, token-only `hold|blocker`, failed-send truth, replacement truth, or team-lead-recorded blocker-routing with exhausted internal recovery basis. Agent-start evidence without a valid first upward resolution outcome is activity evidence for monitoring and recovery only; it is not receipt clearance. `member-created` or `task-row-created` without assignment-grade `SendMessage` is `team-created-no-assignment` and immediately opens assignment-grade `SendMessage` on the same frozen route; it is not monitoring, fallback dispatch, or operator-policy-choice when the frozen route remains unchanged.
- A target with `problem-report` but no following token-only `dispatch-ack`, completion-grade token-only `subjob-done`, token-only `scope-pressure`, or token-only `hold|blocker` enters `dispatch-recovery` as `problem-reported-pending-outcome`.
- A target with no token-only `dispatch-ack`, completion-grade token-only `subjob-done`, token-only `scope-pressure`, token-only `hold|blocker`, or `problem-report` enters `dispatch-recovery` as missing assignment receipt.
- Newly sent assignment state, idle observation, inbox read/unread state, absent retained output, and no immediate side-effect do not authorize a same-target proceed prompt, assignment repeat, or `subjob-done` instruction; only `dispatch-recovery.md` state-reconciliation may follow after its recovery evidence threshold.
- Replacement, redistribution, or shutdown follows after the required follow-up, frozen re-check wait, and absent response/activity evidence classify that target as dead-or-unavailable for the current assignment.
- A target with valid `dispatch-ack` stays active inside the frozen quiet activity window; absent or unchanged artifacts are expected-not-yet-produced, and lead-owned filesystem, carrier, count, root, mtime, synthesis-prep, or progress-proving probes for that target open only after that window closes with no agent-originated activity, blocker, scope-pressure, failure, permission request, completion-grade handoff, or assigned-surface side-effect evidence, or after another completion/recovery trigger exists.
- Before new `Agent` member creation, `task-execution` evaluates live or standby same-lane reuse when such a member exists; raw `subjob-done` without retained-carrier acceptance is not standby and is not reuse-fit evidence.
- Reuse after `subjob-done` consumes `.claude/skills/task-execution/references/completion-handoff.md` retained-carrier acceptance and phrase-suppression rules before any reuse-via-`SendMessage`; completion, reuse, standby, and next-work facts stay internal while reuse, monitoring, correction, synthesis, or closeout can continue.
- Reuse-fit holds only under `.claude/reference/work-execution-core-law.md` `## Parallelism And Bottleneck Law`.
- When reuse-fit holds, `task-execution` creates or verifies a distinct open assignment-block `TASK-ID` when task tracking is active, then sends assignment-grade reuse-via-`SendMessage` before cleanup. Reuse does not reopen, reassign, rename, or change status on the prior completed task row.
- Successful same-segment dispatch or reuse proceeds to receipt monitoring, completion handling, or the next executable owner action without assistant-authored visible narration; preserve required evidence, but do not narrate readiness, cap, active-lane, wave, round, waiting, or holding state.
- New `Agent` member creation opens only when no live or standby fit exists, the target is dead-or-unavailable for the assignment, the lane is absent, or reuse-fit fails by named basis.
- `shutdown_request` before same-lane new member creation is valid only after reuse-fit fails, the target is dead-or-unavailable, the lane is no longer needed, or active `session-closeout` owns teardown.
- User-directed cleanup of named lane members without explicit session-end intent is a lane-member no-longer-needed basis for those members and uses runtime-cleanup `SendMessage`; session-closeout opens only from explicit session-end intent.
- Reuse preserves independent frozen shards outside a single-agent critical path.
- Lane-owned work must stay on the configured lane, not a generic helper path.
- Recoverable packet or target gaps route to packet correction, team-scoped creation, route replan, or lane `hold|blocker`.
- Recoverable packet or target gaps stay outside hook-controlled blocking.

## SendMessage And Skill Law
- Assignment-grade `SendMessage` is for bounded assignment, reroute, or reuse against an open executable task per `truth-rules.md`.
- Assignment-grade `SendMessage` requires current mandatory `PLAN-VERIFICATION-BASIS` before send.
- Assignment worker targeting follows `message-classes.md` `### Assignment Delivery Contract`; task-row mutation is not worker targeting.
- Completed-task correction first needs an open executable task whose `TaskCreate` result has returned before dependent dispatch or task mutation.
- Workflow-control `SendMessage` is for canonical `phase-transition-control` only.
- Runtime-cleanup `SendMessage` carries cleanup only; assignment dispatch uses assignment-grade `SendMessage`.
- Agent-facing `REQUIRED-SKILLS` is mandatory on every assignment-grade packet as required methodology or capability skills frozen by planning or the active workflow owner.
- When no upstream required skill exists, carry `REQUIRED-SKILLS: []`; omission is invalid and listing the receiving agent-specific skill is invalid.
- `task-execution` can narrow or phase-specialize the required skill basis only when the active workflow owner already resolved that phase-local basis.
- Same-owner missing or contradictory skill basis returns to that workflow owner.
- Any owner, lane, independent surface, proof, acceptance, or staffing change reopens `work-planning`.

## Partial Parallel Failure Recovery
When N parallel dispatches are attempted and M succeed while K fail before agent-start, recover K without stopping M.
The K-failure conditions are: Agent spawn failure, missing receipt, quiet-window no-start after valid `dispatch-ack`, or packet rejection.

The failed K is retried or reassigned to surviving M without reopening `work-planning` only when all hold:
- `AGENT-MAP`, `PARALLEL-GROUPS` independence, `LANE-REQUIRED-SKILLS-MAP`, and acceptance/proof separation are unchanged.
- The failure happened before agent-start evidence on the failed K.
- Surviving M can truthfully cover failed K's surface without packet shape change.

Otherwise reopen `work-planning` for redistribution per `.claude/CLAUDE.md` `## 3. Work Execution Philosophy`.

## Resolve Next Owner And Action
- Valid runtime creation, lane dispatch, or reuse returns to `task-execution` Step 3 Dispatch Truth.
- Required new team runtime opens `TeamCreate` through `task-execution` only after dispatch-entry and current mandatory `PLAN-VERIFICATION-BASIS` pass.
- Current-session runtime recovery opens `session-boot`.
- Missing live roster evidence opens target-resolution recovery before dispatch.
- Missing or contradictory packet skill basis returns to the same frozen owner when boundary axes stay unchanged.
- Changed owner, lane, independent surface, proof, acceptance, or staffing opens `work-planning`.
- Partial parallel failure follows `Partial Parallel Failure Recovery` or opens `work-planning`.
- Fallback direct-Agent evidence from outside team runtime returns to `team-lead` as bounded evidence only.
