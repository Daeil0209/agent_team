---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
---

# task-execution: Dispatch Entry Contract

Load before `task-execution/SKILL.md` performs any dispatch, reuse, blocker-clear, or packet assembly move.

## Prior Owner Requirements
Before this skill acts, the lead must already have:
- current boundary `work-planning`
- the current frozen workflow or sequence owner already opened when `ACTIVE-WORKFLOW` or non-`not-applicable` `ACTIVE-SEQUENCE` is present
- a frozen additional-agent route or ambiguous dispatch route
- host-authorized active-runtime path for additional agents when new agent dispatch is required

## Consumed Frozen Fields
Consume dispatch-relevant frozen fields in this order. A consumed field must carry either a concrete frozen value or an explicit `not-applicable` basis allowed by `work-planning` for the current route.
1. `ROUTING-SIGNAL`
2. `NEXT-CONSEQUENTIAL-ACTION`
3. `DISPATCH-BLOCKERS`
4. `CODEX-ADVISORY-BASIS`
5. `EXECUTION-READINESS-BASIS`
6. `AGENT-MAP`
7. `PARALLEL-GROUPS`
8. `LANE-REQUIRED-SKILLS-MAP`
9. `REQUEST-BOUND-PACKET-FIELDS`
10. `SKILL-RECOMMENDATIONS`
11. `ACTIVE-WORKFLOW` when present
12. `ACTIVE-SEQUENCE` when present

## Field Rules
- `AGENT-MAP` and `PARALLEL-GROUPS` must be concrete when additional-agent routing is host-authorized.
- If they are not mandatory but `task-execution` can consume the route, each must carry explicit `not-applicable:<basis>`.
- Valid `not-applicable` bases are limited to a dispatch-owned blocker-clear move or an ambiguous dispatch route that `work-planning` kept dispatch-owned without authorizing an agent dispatch move yet.
- `not-applicable` is invalid once an authorized agent dispatch move exists.
- Concrete `PARALLEL-GROUPS` must include boundary, non-overlap, and measured/cited burden basis from the frozen planning path. File-only, guessed, or pre-`work-planning` measurement is not dispatch-ready.
- `CODEX-ADVISORY-BASIS` is dispatch context only.
- `task-execution` consumes the frozen `triggered:*`, `fail-open:*`, or `skipped:*` truth.
- Does not call Codex.
- Does not adjudicate Codex points.
- Does not turn `fail-open:*` into a blocker unless `work-planning` already marked the route blocked.
- If a team-lead dispatch route lacks required `CODEX-ADVISORY-BASIS`, stop and reopen `work-planning`.
- If `ACTIVE-WORKFLOW: dev-workflow` is present, consume `skipped:no-material-advisory-trigger:<basis>` as valid skipped truth; other `skipped:*` values stop and reopen `work-planning`.
- `EXECUTION-READINESS-BASIS` must be `ready:<basis>` for assignment-grade dispatch.
- `blocked:<basis>` can enter this skill only for a dispatch-owned blocker-clear move named by `NEXT-CONSEQUENTIAL-ACTION`.
- Otherwise return to `work-planning`.
- If the frozen route lacks measured burden basis required by `work-planning` or `parallel-fit`, stop before runtime creation, packet assembly, reuse, `SendMessage`, or `Agent`, and reopen `work-planning`.
- If `PARALLEL-GROUPS: none` serializes multi-surface work without a measured dependency or serial-burden basis, stop and reopen `work-planning`.
- If the next move asks the user to choose route, staffing, parallelism, or dispatch options that doctrine and evidence can settle, stop and reopen `work-planning` or continue with the evidence-backed route.
- If a field required by the frozen route is missing, contradictory, or marked `not-applicable` without an allowed basis, stop and reopen `work-planning`.

## Information Movement Rule
- `work-planning` -> `team-lead/task-execution` uses internal carry-forward of the frozen planning basis.
- `task-execution` -> agent uses an assignment-grade dispatch packet derived from that basis.
- agent -> `team-lead` uses message-class reports (`dispatch-ack`, `control-ack`, `status`, `scope-pressure`, `handoff`, `completion`, exact `hold|blocker`).
- agent -> peer uses `SendMessage` challenger traffic for evidence notes, critique, clarification, or partial-result context inside unchanged ownership, lifecycle, routing, and active surface.
- user -> teammate uses Claude Code teammate UI for direct instruction, follow-up question, or redirect prompt inside the receiver's current authority and active surface.
- shared task-list state moves through `TaskCreate`, `TaskUpdate`, `TaskGet`, `TaskList`, `TaskOutput`, and `TaskStop`; task identity comes from `task_assignment`, `TaskList`, `TaskGet`, or returned task mutation evidence, not an agent name.
- Agent-originated team-runtime message traffic is official only through `SendMessage`.
- Official delivery uses the required message channel.
- Keep the full internal planning block in `team-lead/task-execution` carry-forward.
- Send only the bounded fields needed for the agent's owned surface.

## Next-Action Drive
- Passing entry contract opens `task-execution` Step 1 Activate Frozen Route.
- Missing `work-planning` opens `work-planning`.
- Missing frozen workflow or sequence owner opens that owner.
- Missing host-authorized runtime path opens `session-boot` or route correction before dispatch.
- Missing, contradictory, stale, or invalid route fields reopen `work-planning`.
- Dispatch-owned blocker-clear readiness returns to `task-execution`.
- Plain-text delivery attempts open official message-channel correction before dispatch truth.
- Missing task-state identity opens `TaskList`, `TaskGet`, `task_assignment`, or returned-mutation evidence recovery before task mutation.
- Available background task output path opens `Read` instead of `TaskOutput`.
