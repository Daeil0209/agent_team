---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-user-reporting-law.md
---

# task-execution: Dispatch Entry Contract

Load after `Skill(task-execution)` is active by actual skill load or current same-session activation basis and before any dispatch, reuse, blocker-clear, or packet assembly move.
Direct reading, searching, listing, summarizing, or reference-map traversal of `.claude/skills/task-execution/**` does not satisfy this entry condition.

## Prior Owner Requirements
Before this skill acts, the lead must already have:
- actual `Skill(task-execution)` load or `same-session-loaded:task-execution:<owner-boundary-basis>` for the same dispatch owner boundary
- current boundary `work-planning`
- the current frozen workflow or sequence owner already opened when `ACTIVE-WORKFLOW` or non-`not-applicable` `ACTIVE-SEQUENCE` is present
- a frozen additional-agent route or ambiguous dispatch route
- frozen additional-agent runtime route basis when new agent dispatch is required
- `session-boot` supplies current-runtime readiness or recovery classification only when live runtime truth can change the next owner/action

## Consumed Frozen Fields
Consume only dispatch-relevant frozen fields in the order and conditionals owned by `.claude/skills/work-planning/references/planning-record-fields.md` `## Allowed Values`. A consumed field must carry either a concrete frozen value or an explicit `not-applicable` basis allowed by `work-planning` for the current route.

## Field Rules
- Missing, stale, or contradictory request-fit basis reopens `work-planning`.
- A field outside packet assembly, runtime dispatch, receiving-lane execution, workflow, or active report gates is not dispatch-entry floor.
- Missing or contradictory `SEMANTIC-INTENT-BASIS` reopens `work-planning`.
- Missing or contradictory `COMPLETION-STOP-CONDITION` reopens `work-planning` when packet assembly, receiving-lane execution, report gating, or completion truth depends on it.
- Missing or contradictory `DERIVED-DEFAULTS` reopens `work-planning` when packet assembly, proof surface, or receiving-lane execution depends on it.
- Missing `REQUEST-BOUND-PACKET-FIELDS` reopens `work-planning`.
- `TEAM-LEAD-WORK-PLAN` names the dispatch row, post-dispatch synthesis/verification row, and termination row for the assignment-grade route.
- Missing material `CLAIM-CEILING` reopens `work-planning`.
- `AGENT-MAP` and `PARALLEL-GROUPS` must be concrete when additional-agent routing is host-authorized.
- `ACTIVE-CONCURRENT-AGENT-CAP` must be concrete when additional-agent routing is possible, host-authorized, team-routed, ambiguous-route, or dispatch-capable.
- `task-execution` consumes the frozen cap and does not infer or raise it from runtime convenience.
- If planned concurrent nonblocked groups exceed `ACTIVE-CONCURRENT-AGENT-CAP`, stop and reopen `work-planning`.
- If they are not mandatory but `task-execution` can consume the route, each must carry explicit `not-applicable:<basis>`.
- Valid `not-applicable` bases are limited to a dispatch-owned blocker-clear move or an ambiguous dispatch route that `work-planning` kept dispatch-owned without authorizing an agent dispatch move yet.
- `not-applicable` is invalid once an authorized agent dispatch move exists.
- Concrete `PARALLEL-GROUPS` must include boundary, non-overlap, and measured/cited burden basis from the frozen planning path.
- File-only, guessed, or pre-`work-planning` measurement is not dispatch-ready.
- `CODEX-INDEPENDENT-REVIEW-BASIS` is dispatch context only for configured independent-review handling.
- `task-execution` consumes the frozen `triggered:*`, `fail-open:*`, or `skipped:*` truth.
- Does not call the configured independent reviewer.
- Does not adjudicate configured-review points.
- Does not turn `fail-open:*` into a blocker unless `work-planning` already marked the route blocked.
- If a team-lead dispatch route lacks required `CODEX-INDEPENDENT-REVIEW-BASIS`, stop and reopen `work-planning`.
- `NEXT-CONSEQUENTIAL-ACTION` traces to the first executable row of `TEAM-LEAD-WORK-PLAN`; failed trace opens `work-planning`.
- If `ACTIVE-WORKFLOW: dev-workflow` is present, consume `skipped:no-material-independent-review-trigger:<basis>` as valid skipped truth; other `skipped:*` values stop and reopen `work-planning`.
- `EXECUTION-READINESS-BASIS` must be `ready:<basis>` for assignment-grade dispatch.
- `blocked:<basis>` can enter this skill only for a dispatch-owned blocker-clear move named by `NEXT-CONSEQUENTIAL-ACTION`.
- Otherwise return to `work-planning`.
- A frozen route lacking measured burden basis stops dispatch and reopens `work-planning`.
- A frozen route whose binding surface materialized as an external carrier requires on-disk verification of that carrier per `.claude/skills/work-planning/references/parallel-fit.md`. PROTECTED-LOCAL-RESTATEMENT-BASIS: runtime-side enforcement of the planning-side verification rule; runtime preflight stops dispatch when planning-side verification is missing.
- Missing on-disk verification stops runtime creation, packet assembly, reuse, `SendMessage`, and `Agent`; the route reopens `work-planning`.
- If `PARALLEL-GROUPS: none` serializes multi-surface work without a measured dependency or serial-burden basis, stop and reopen `work-planning`.
- If the next move asks the user to choose route, staffing, parallelism, or dispatch options that doctrine and evidence can settle, stop and reopen `work-planning` or continue with the evidence-backed route.
- If a field required by the frozen route is missing, contradictory, or marked `not-applicable` without an allowed basis, stop and reopen `work-planning`.
- Stop before dispatch when the assigned output requires detailed internal material and no retained-output path or non-visible carrier is available.
- Stop before dispatch when the packet assigns task-state mutation to a receiver without the required task-state tool.

## Information Movement Rule
- `work-planning` -> `team-lead/task-execution` uses internal carry-forward of the frozen planning basis.
- `task-execution` -> agent uses an assignment-grade dispatch packet derived from that basis.
- agent -> `team-lead` uses message-class transports (`dispatch-ack`, `status`, `scope-pressure`, `completion`, exact `hold|blocker`).
- agent -> peer uses `SendMessage` challenger traffic for evidence notes, critique, clarification, or partial-result context inside unchanged ownership, cleanup, routing, and active surface.
- user -> teammate uses teammate UI for direct instruction, follow-up question, or redirect prompt inside the receiver's current authority and active surface.
- Shared task-list state moves through `TaskCreate`, `TaskUpdate`, `TaskGet`, `TaskList`, `TaskOutput`, and `TaskStop`.
- Task identity comes from `task_assignment`, `TaskList`, `TaskGet`, or returned task mutation evidence.
- Agent name alone is not task identity.
- Task-state mutation is assigned only to an owner whose tool surface includes the required task-state tool.
- Agent-originated team-runtime message traffic is official only through `SendMessage`.
- Visible teammate pane/final text is never the official message channel and must not contain ACK, completion, status, blocker, findings, counts, paths, or `MESSAGE-CLASS` blocks.
- Official delivery uses the required message channel.
- Keep the full internal planning block in `team-lead/task-execution` carry-forward.
- Send only the bounded fields needed for the agent's owned surface.
- Assignment packets carry the governed Communication Plane payload through `SendMessage`, task state, or retained carriers.

## Resolve Next Owner And Action
- Passing entry contract opens `task-execution` Step 1 Activate Frozen Route.
- Missing `work-planning` opens `work-planning`.
- Missing frozen workflow or sequence owner opens that owner.
- Missing frozen runtime route basis reopens `work-planning`.
- Current-runtime uncertainty or recovery need opens `session-boot`.
- Absent current-session team registration inside a frozen team-agent route opens `TeamCreate` through `runtime-dispatch-law.md`, not `session-boot`.
- Missing, contradictory, stale, or invalid route fields reopen `work-planning`.
- Dispatch-owned blocker-clear readiness returns to `task-execution`.
- Plain-text delivery attempts open official message-channel correction before dispatch truth.
- Missing task-state identity opens `TaskList`, `TaskGet`, `task_assignment`, or returned-mutation evidence recovery before task mutation.
- Available background task output path opens `Read` instead of `TaskOutput`.
