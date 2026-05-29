---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "frozen-local-action; local-limit; drift-exit; owner-route"
---
# team-lead: Lead-Local Guarded Law

## Purpose
Let team-lead execute only the frozen lead-local or same-route blocker-clear action.
Exit lead-local immediately when the action needs a different owner, wider boundary, stronger claim, lane function, or material parallelism.
This reference blocks only the frozen local action; unrelated lawful owner paths continue under their own basis.

## Consume When
- `NEXT-CONSEQUENTIAL-ACTION` points to a frozen `lead-local candidate` first local item or exact same-route blocker-clear move.
- Team-lead is about to perform a frozen lead-local diagnostic, audit, analysis, evidence-only standalone `Agent` use, or same-route blocker-clear work.
- Local execution shows drift from the frozen local action.

## Record
Record only the active row:
- frozen local action or blocker-clear move
- surface, evidence limit, claim ceiling, required-skill status, and stop point
- drift signal and next owner/action when drift appears

## Lead-Local Procedure
1. Confirm `planning-field-consume` supplies a current `ROUTING-SIGNAL: lead-local candidate` or `ROUTING-SIGNAL: blocker-clear`.
2. Confirm the frozen local action names the exact item or blocker-clear move, one surface, evidence limit, claim ceiling, required-skill status, and stop point.
3. Execute only that frozen action until its stop point.
4. Keep evidence and claims inside the frozen limit.
5. Load and learn only the required skills named for the first material surface; missing or stale required-skill basis exits lead-local.
6. Use non-owner specialist skills only when the frozen support basis permits team-lead consumption.
7. Treat read-only diagnostic, audit, analysis, or explicitly frozen evidence-only standalone `Agent` use as lead-local only while it creates no independent evidence family, decision target, production/source-of-truth/interface boundary, proof burden, or correction owner.
8. At the stop point, return to the active team-lead plan or named replanning boundary before any next local action.

## Drift Exit
Exit lead-local when any `.claude/skills/work-planning/references/boundary-gates.md` `## Boundary-Change Axes` axis moves for the frozen local action, or when the action would create a destructive, security-sensitive, external-bridge, or final-acceptance burden (lead-local-specific additions beyond the boundary-change axes).
Context-size, latency, or runtime-burden benefit that changes owner route counts as material parallel-fit only when evidence shows it affects coverage, proof, risk, owner separation, or executable continuity; convenience alone does not reopen route or force parallelization.
After drift, take no further local tool call, report, claim, or continuation until `Resolve Next Owner And Action` selects the next owner/action.

## Resolve Next Owner And Action
- If the local procedure fits, execute the frozen action.
- If the stop point is reached, return to the next row of the active team-lead plan or the blocker-clear plan's named replanning boundary.
- Missing, stale, contradictory, or weaker planning fields reopen `work-planning`.
- A frozen new owner routes to that owner; an unfrozen owner, item, surface, route ambiguity, hidden consequential step, or material parallel-fit reopens `work-planning`.
- Lane-owned proof, review, validation, implementation, or acceptance routes through `Skill(task-execution)` when frozen, or `work-planning` when not frozen.
- Required-skill gap opens the named skill when the boundary permits it; otherwise reopen `work-planning` or blocker-routing after internal recovery is exhausted.
- Claim beyond the frozen evidence limit opens claim narrowing, `Skill(self-verification)`, or `Skill(review-verification)` according to claim type.
