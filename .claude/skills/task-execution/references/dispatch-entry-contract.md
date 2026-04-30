---
PRIMARY-OWNER: task-execution
LOAD-POLICY: on-demand reference only
---

# task-execution: Dispatch Entry Contract

Load before `task-execution/SKILL.md` performs any dispatch, reuse, blocker-clear, or packet assembly move.

## Prior Owner Requirements
Before this skill acts, the lead must already have:
- current-turn `work-planning`
- the current frozen workflow or sequence owner already opened when `ACTIVE-WORKFLOW` or non-`not-applicable` `ACTIVE-SEQUENCE` is present
- current-turn `SV-PLAN`
- a frozen additional-agent route or ambiguous dispatch route
- host-authorized active-runtime path for additional agents when new agent dispatch is required

## Consumed Frozen Fields
Consume dispatch-relevant frozen fields in this order. A consumed field must carry either a concrete frozen value or an explicit `not-applicable` basis allowed by `work-planning` for the current route.
1. `ROUTING-SIGNAL`
2. `NEXT-CONSEQUENTIAL-ACTION`
3. `DISPATCH-BLOCKERS`
4. `EXECUTION-READINESS-BASIS`
5. `AGENT-MAP`
6. `PARALLEL-GROUPS`
7. `LANE-REQUIRED-SKILLS-MAP`
8. `REQUEST-BOUND-PACKET-FIELDS`
9. `SKILL-RECOMMENDATIONS`
10. `ACTIVE-WORKFLOW` when present
11. `ACTIVE-SEQUENCE` when present

## Field Rules
- `AGENT-MAP` and `PARALLEL-GROUPS` must be concrete when additional-agent routing is host-authorized.
- If they are not mandatory but `task-execution` may consume the route, each must carry explicit `not-applicable:<basis>`.
- Valid `not-applicable` bases are limited to a dispatch-owned blocker-clear move or an ambiguous dispatch route that `SV-PLAN` kept dispatch-owned without authorizing an agent dispatch move yet.
- `not-applicable` is invalid once an authorized agent dispatch move exists.
- `EXECUTION-READINESS-BASIS` must be `ready:<basis>` for assignment-grade dispatch.
- `blocked:<basis>` may enter this skill only for a dispatch-owned blocker-clear move named by `NEXT-CONSEQUENTIAL-ACTION`; otherwise return to `work-planning`.
- If a field required by the frozen route is missing, contradictory, or marked `not-applicable` without an allowed basis, stop and reopen `work-planning`.

## Information Movement Rule
- `work-planning` -> `team-lead/task-execution` uses internal carry-forward of the frozen planning basis.
- `task-execution` -> agent uses an assignment-grade dispatch packet derived from that basis.
- agent -> `team-lead` uses message-class reports (`dispatch-ack`, `control-ack`, `status`, `scope-pressure`, `handoff`, `completion`, exact `hold|blocker`).
- Do not send the full internal planning block to agents.
- Translate only the bounded fields needed for the agent's owned surface.
