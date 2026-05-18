---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "RPA-4 Planning Consumption; Reference Binding; Procedure And Ownership"
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
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

## Stop
Stop before execution when a required field is missing, contradictory, stale, or weaker than the floor.
Stop before dispatch when cross-continuity basis is missing.
Stop before team-agent runtime dispatch when receiving lanes depend on lead-only conversation history.

## Resolve Next Owner And Action
- A stopped execution route opens `work-planning`.
- A stopped dispatch route opens cross-continuity basis recovery.
- A stopped team-agent dispatch route opens packet fact transfer.

## Field Order
Read only fields consumed by the current next owner/action, in this relative order:
1. `REQUEST-FIT-BASIS`
2. `SEMANTIC-INTENT-BASIS`
3. `COMPLETION-STOP-CONDITION`
4. `DERIVED-DEFAULTS`
5. `REQUEST-BOUND-PACKET-FIELDS`
6. `CLAIM-CEILING` when material
7. `PROJECT-TIER`
8. `ACTIVE-REQUEST-TIER`
9. `TIER-RAISE-REASON`
10. `ACTIVE-WORKFLOW`
11. `CODEX-INDEPENDENT-REVIEW-BASIS` when configured independent-review handling is material or workflow-required
12. `ACTIVE-SEQUENCE`
13. `ROUTING-SIGNAL`
14. `NEXT-CONSEQUENTIAL-ACTION`
15. `DISPATCH-BLOCKERS` / `HOLD-CONDITIONS`
16. `EXECUTION-READINESS-BASIS`
17. `LEAD-LOCAL-REQUIRED-SKILLS` / `LANE-REQUIRED-SKILLS-MAP` from `.claude/skills/work-planning/references/planning-record-fields.md`
18. `AGENT-MAP` / `PARALLEL-GROUPS` when routed

## Reaction Rules
- `answer-only` means answer only.
- A field outside the current owner path is not a preflight floor.
- Do not reopen `work-planning` for a field that no current local execution, workflow, sequence, dispatch, or report owner consumes.
- Team-lead decision basis is the consumed frozen scope, route, owner map, proof chain, acceptance chain, parallel-fit basis, and active-route mandatory fields.
- Developer-level expansion starts inside that consumed basis.
- Missing request-fit basis reopens `work-planning`.
- Stale request-fit basis reopens `work-planning`.
- Contradictory request-fit basis reopens `work-planning`.
- `SEMANTIC-INTENT-BASIS` that cannot support the selected route class, owner choice, and next action reopens `work-planning`.
- Missing, stale, contradictory, or non-evidence-backed `COMPLETION-STOP-CONDITION` reopens `work-planning`.
- `COMPLETION-STOP-CONDITION` that cannot support the selected next action, report gate, or `HOLD` route reopens `work-planning`.
- Valid `COMPLETION-STOP-CONDITION` is instruction-derived, practical, evidence-verifiable, and at least as complete as the requested deliverable; otherwise reopen `work-planning`.
- Missing `DERIVED-DEFAULTS` reopens `work-planning` when deliverable type, receiver job, proof surface, or request-bound packet fields depend on it.
- Stale `DERIVED-DEFAULTS` reopens `work-planning`.
- Contradictory `DERIVED-DEFAULTS` reopens `work-planning`.
- Missing `REQUEST-BOUND-PACKET-FIELDS` reopens `work-planning`.
- Stale `REQUEST-BOUND-PACKET-FIELDS` reopens `work-planning`.
- Missing material `CLAIM-CEILING` reopens `work-planning`.
- Missing tier basis reopens `work-planning` per `.claude/skills/work-planning/references/governance-depth.md`.
- Contradictory tier basis reopens `work-planning`.
- Stale tier basis reopens `work-planning`.
- Weaker-than-floor tier basis reopens `work-planning`.
- Consume frozen tier basis before staffing, checkpoint, review, proof, or acceptance sizing.
- Missing required configured independent-review basis reopens `work-planning`.
- Stale configured independent-review basis reopens `work-planning`.
- Invalidly skipped configured independent-review basis reopens `work-planning`.
- Pre-`work-planning` configured independent-review basis reopens `work-planning`.
- `triggered:*` requires active adjudication.
- Treat `fail-open:*` as configured-review-unavailable evidence.
- Required `PARALLEL-GROUPS` carries boundary, non-overlap, and measured/cited burden basis.
- File-only, guessed, or pre-`work-planning` parallel measurement reopens `work-planning`.
- Named `ACTIVE-WORKFLOW` opens the workflow owner named by `NEXT-CONSEQUENTIAL-ACTION`.
- Active `ACTIVE-SEQUENCE` opens the sequence owner named by `NEXT-CONSEQUENTIAL-ACTION`.
- Missing `EXECUTION-READINESS-BASIS` reopens `work-planning` unless `NEXT-CONSEQUENTIAL-ACTION` names a verified same-route blocker-clear move.
- Blocked `EXECUTION-READINESS-BASIS` reopens `work-planning` unless `NEXT-CONSEQUENTIAL-ACTION` names a verified same-route blocker-clear move.
- Missing or contradictory planning fields reopen `work-planning`.

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
