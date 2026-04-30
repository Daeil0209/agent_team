# Work-Planning Record Fields
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

Use this file when field-level semantics, allowed values, the internal planning record, `not-applicable` bases, serial reasons, or bounded correction rules are material.

`PROJECT-TIER`, `ACTIVE-REQUEST-TIER`, and `TIER-RAISE-REASON` field semantics are produced by `.claude/skills/governance-scaling/SKILL.md` and consumed here.

## Allowed Values
- `ACTION-CLASS` must be one of `lead-local`, `team-routed`, `workflow-owner`, `sequence-owner`, `authorization-request`, `blocker-clear`, or `hold`.
- `ROUTING-SIGNAL` must be one of `lead-local candidate`, `team-routing candidate`, `ambiguous-route`, `workflow-owner`, `sequence-owner`, `authorization-request`, `blocker-clear`, or `hold`.
- `DISPATCH-BLOCKERS` must be `[]`, `blocked:<owner-and-basis>`, or `authorization-required:<basis>`.
- `EXECUTION-READINESS-BASIS` must be `ready:<basis>`, `blocked:<owner-and-basis>`, or `not-applicable:<basis>` when required.

- `REQUEST-FIT-BASIS` is mandatory for consequential plans and must preserve the Step 0 request-fit record enough to reconstruct request intent, deliverable, user/audience, proof direction, and blocker truth.
- `REQUEST-BOUND-PACKET-FIELDS` is mandatory as `[]` or the exact request-bound fields that `task-execution` must carry into downstream assignment packets.
- `PROJECT-TIER` is mandatory when the project has already been tiered or the current plan explicitly sizes governance depth.
- `ACTIVE-REQUEST-TIER` is mandatory whenever `PROJECT-TIER` is present on a consequential `team-lead` plan.
- `TIER-RAISE-REASON` is mandatory whenever `PROJECT-TIER` is present; record `stay` explicitly when no material raise signal exists.
- `ACTIVE-WORKFLOW` is mandatory when one named workflow governs the path.
- `ACTIVE-SEQUENCE` is mandatory when one named primary sequence governs the path; use `not-applicable:<basis>` when no primary sequence governs the path but a sequence candidate was considered.
- If both `ACTIVE-WORKFLOW` and `ACTIVE-SEQUENCE` are present, `NEXT-CONSEQUENTIAL-ACTION` must name which owner opens first and why.
- `ACTION-CLASS` is mandatory for consequential plans and must use one of the allowed immediate action families above.
- `ROUTING-SIGNAL`, `NEXT-CONSEQUENTIAL-ACTION`, and `DISPATCH-BLOCKERS` are mandatory for consequential `team-lead` plans.
- `LEAD-LOCAL-WORK-ITEMS` is mandatory when `ROUTING-SIGNAL` is `lead-local candidate`.
- `LEAD-LOCAL-REQUIRED-SKILLS` is mandatory when `ROUTING-SIGNAL` is `lead-local candidate` and the acting subject needs any non-owner skill to complete the frozen local path truthfully.
- `AGENT-MAP` and `PARALLEL-GROUPS` are mandatory when routing is team-routed or becomes team-routed after one named blocker-clear move.
- `AGENT-MAP` and `PARALLEL-GROUPS` are mandatory when additional-agent routing is host-authorized.
- When `AGENT-MAP` or `PARALLEL-GROUPS` is not mandatory but `task-execution` may consume the route, record `not-applicable:<basis>` instead of leaving the field blank.
- Valid `not-applicable` bases are limited to the current route basis. Do not use `not-applicable` to hide missing decomposition or missing readiness.
- `LANE-REQUIRED-SKILLS-MAP` is mandatory when routing is team-routed or ambiguous-route. Every lane entry must be an explicit list of additional non-lane-core skills; use `[]` when no additional skill is required and do not list the lane-core skill.
- `SKILL-RECOMMENDATIONS` is mandatory as `[]` or a lane-scoped methodology guidance map when any configured lane is a candidate receiver for assignment-grade work. It must not list lane-core skills and must not substitute for `LANE-REQUIRED-SKILLS-MAP`.
- `EXECUTION-READINESS-BASIS` is mandatory for consequential `team-lead` plans. Use `ready:<basis>` only when the next owner can proceed from the frozen basis without rediscovering material packet, skill, proof, tool/setup, lifecycle, parallel, or acceptance facts. Use `blocked:<owner-and-basis>` when the next lawful action is blocker-clear, authorization request, or hold. Use `not-applicable:<basis>` only for delegated lane-local plans that are not producing a top-level route.
- For any route that may enter `task-execution`, `EXECUTION-READINESS-BASIS` must state that packet preflight categories are frozen or explicitly blocked.
- If additional-agent routing is authorized and `PARALLEL-GROUPS` does not name the parallel groups, reopen `work-planning`.
- If `PARALLEL-GROUPS` is `none`, record the exact serial reason.
- `NEXT-CONSEQUENTIAL-ACTION` must point to the first named local item, frozen workflow owner, frozen sequence owner, `task-execution`, exact blocker-clear move, or exact authorization request, not an implied "inspect more".
- If execution reveals a new consequential local item that is not frozen here, stop and reopen `work-planning`.
- A bounded correction may stay inside the same frozen owner, surface, deliverable, and acceptance chain through fresh verification plus packet correction or bounded local carry-forward.
- That bounded correction exception ends immediately when execution reveals a hidden consequential step, new owner, new surface, or changed acceptance chain.
- Do not treat the full planning record as the outbound agent message. Downstream agent communication must receive a bounded assignment packet derived from this freeze by `task-execution`.

## Internal Planning Record Template
Hold this record in current-turn context only. Do not print it to the user, mirror it to a continuity file, or forward it as an agent packet.

```
REQUEST-FIT-BASIS:
REQUEST-BOUND-PACKET-FIELDS:
PROJECT-TIER:
ACTIVE-REQUEST-TIER:
TIER-RAISE-REASON:
ACTIVE-WORKFLOW:
ACTIVE-SEQUENCE:
ACTION-CLASS:
ROUTING-SIGNAL:
LEAD-LOCAL-WORK-ITEMS:
LEAD-LOCAL-REQUIRED-SKILLS:
AGENT-MAP:
PARALLEL-GROUPS:
LANE-REQUIRED-SKILLS-MAP:
SKILL-RECOMMENDATIONS:
EXECUTION-READINESS-BASIS:
NEXT-CONSEQUENTIAL-ACTION:
DISPATCH-BLOCKERS:
```
