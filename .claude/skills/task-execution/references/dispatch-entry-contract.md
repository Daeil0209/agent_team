---
PRIMARY-OWNER: task-execution
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
- If a team-lead dispatch route lacks required `CODEX-ADVISORY-BASIS` or carries `skipped:*` while `ACTIVE-WORKFLOW: dev-workflow` is present, stop and reopen `work-planning`.
- `EXECUTION-READINESS-BASIS` must be `ready:<basis>` for assignment-grade dispatch.
- `blocked:<basis>` can enter this skill only for a dispatch-owned blocker-clear move named by `NEXT-CONSEQUENTIAL-ACTION`.
- Otherwise return to `work-planning`.
- If a field required by the frozen route is missing, contradictory, or marked `not-applicable` without an allowed basis, stop and reopen `work-planning`.

## Information Movement Rule
- `work-planning` -> `team-lead/task-execution` uses internal carry-forward of the frozen planning basis.
- `task-execution` -> agent uses an assignment-grade dispatch packet derived from that basis.
- agent -> `team-lead` uses message-class reports (`dispatch-ack`, `control-ack`, `status`, `scope-pressure`, `handoff`, `completion`, exact `hold|blocker`).
- In team-agent runtime this is official only through `SendMessage`.
- Plain-text output is not official delivery.
- Do not send the full internal planning block to agents.
- Translate only the bounded fields needed for the agent's owned surface.
