---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "RPA-8 Planning Consumption; Work Execution Philosophy"
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# team-lead: Planning Field Consume

## Purpose
Consume route-relevant frozen planning fields before local execution, dispatch, phase movement, or reporting.

## Consume When
- `work-planning` has emitted frozen fields.
- A route, local execution path, workflow, sequence, dispatch, or report depends on those fields.
- A field is stale, contradictory, missing, or weaker than the governing floor.

## Required Output
Record:
- field order consumed
- stale or missing fields
- reopened owner when needed
- planned next executable owner/action

## Routing Gate
Execution requires every consumed required field current, noncontradictory, and at or above the floor.
Dispatch requires cross-continuity basis.
Team-agent runtime dispatch requires receiving lanes to get the needed facts through packet fields, task/workflow state, or cited artifacts.

## Resolve Next Owner And Action
- Execution gaps open `work-planning`.
- Dispatch gaps open cross-continuity basis recovery.
- Team-agent dispatch gaps open packet fact transfer.

## Field Order
Read only fields consumed by the current next owner/action, in the order and conditionals owned by `.claude/skills/work-planning/references/planning-record-fields.md` `## Allowed Values`. Consumer surfaces (this file and `.claude/skills/task-execution/references/dispatch-entry-contract.md`) follow that canonical order without restating the field list.

## Reaction Rules
- Preflight floor applies only to fields inside the current owner path.
- Fields outside every current local execution, workflow, sequence, dispatch, or report owner stay outside `work-planning` reopening.
- Team-lead decision basis is the consumed frozen scope, route, owner map, proof chain, acceptance chain, parallel-fit basis, and active-route mandatory fields.
- Developer-level expansion starts inside that consumed basis.
- For every consumed planning field, missing, stale, contradictory, or weaker-than-floor basis reopens `work-planning`.
- `SEMANTIC-INTENT-BASIS` unsupported for the selected route class, owner choice, and next action reopens `work-planning`.
- `COMPLETION-STOP-CONDITION` reopens `work-planning` when it is non-evidence-backed, unsupported for the selected next action, report gate, or `HOLD` route, or less complete than the requested deliverable; valid form is instruction-derived, practical, evidence-verifiable, and at least as complete as the requested deliverable.
- `DERIVED-DEFAULTS` reopens only when deliverable type, receiver job, proof surface, or request-bound packet fields depend on it.
- `TEAM-LEAD-WORK-PLAN` reopens only when local execution, dispatch, synthesis, reporting, or termination depends on it.
- `NEXT-CONSEQUENTIAL-ACTION` must trace to the first executable row of `TEAM-LEAD-WORK-PLAN`; failed trace reopens `work-planning`.
- Missing material `CLAIM-CEILING` reopens `work-planning`.
- Consume frozen tier basis per `.claude/skills/work-planning/references/governance-depth.md` before staffing, checkpoint, review, proof, or acceptance sizing.
- Pre-`work-planning` configured independent-review basis reopens `work-planning`.
- `triggered:*` requires active adjudication.
- Treat `fail-open:*` as configured-review-unavailable evidence.
- Required `PARALLEL-GROUPS` carries boundary, non-overlap, and measured/cited burden basis.
- File-only, guessed, or pre-`work-planning` parallel measurement reopens `work-planning`.
- Named `ACTIVE-WORKFLOW` opens the workflow owner named by `NEXT-CONSEQUENTIAL-ACTION`.
- Active `ACTIVE-SEQUENCE` opens the sequence owner named by `NEXT-CONSEQUENTIAL-ACTION`.
- `EXECUTION-READINESS-BASIS` that is missing or blocked reopens `work-planning` unless `NEXT-CONSEQUENTIAL-ACTION` names a verified same-route blocker-clear move.

## Cross-Continuity
Before `task-execution`, confirm the frozen route applied:
- same-session prior patches
- confirmed decisions
- contract freezes
- lane-charter changes
- acceptance-contract changes

Missing cross-continuity basis reopens `work-planning`.
Contradictory cross-continuity basis reopens `work-planning`.

## Lead-Only Context Guard
Before team-agent runtime dispatch, confirm receiving lanes have every material lead-context fact.
Material facts travel as:
- packet fields
- task state
- workflow state
- cited artifacts
