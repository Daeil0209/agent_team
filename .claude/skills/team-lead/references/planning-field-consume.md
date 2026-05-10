---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/agents/team-lead.md
SOURCE-RULES: "RPA-4 Planning Consumption; Reference Binding; Procedure And Ownership"
---
# team-lead: Planning Field Consume

## Purpose
Consume frozen planning fields in a fixed order before local execution, dispatch, phase movement, or reporting.

## Consume When
- `work-planning` has emitted frozen fields.
- A route, local execution path, workflow, sequence, dispatch, or report depends on those fields.
- A field may be stale, contradictory, missing, or weaker than the governing floor.

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

## Next-Action Drive
- A stopped execution route opens `work-planning`.
- A stopped dispatch route opens cross-continuity basis recovery.
- A stopped team-agent dispatch route opens packet fact transfer.

## Field Order
Read frozen planning fields in this order:
1. `PROJECT-TIER`
2. `ACTIVE-REQUEST-TIER`
3. `TIER-RAISE-REASON`
4. `ACTIVE-WORKFLOW`
5. `CODEX-ADVISORY-BASIS`
6. `ACTIVE-SEQUENCE`
7. `ROUTING-SIGNAL`
8. `NEXT-CONSEQUENTIAL-ACTION`
9. `DISPATCH-BLOCKERS` / `HOLD-CONDITIONS`
10. `EXECUTION-READINESS-BASIS`
11. `LEAD-LOCAL-REQUIRED-SKILLS` / `LANE-REQUIRED-SKILLS-MAP`
12. `AGENT-MAP` / `PARALLEL-GROUPS` when routed

## Reaction Rules
- `answer-only` means answer only.
- Missing tier basis reopens `work-planning` per `governance-scaling/SKILL.md`.
- Contradictory tier basis reopens `work-planning`.
- Stale tier basis reopens `work-planning`.
- Weaker-than-floor tier basis reopens `work-planning`.
- Consume frozen tier basis before staffing, checkpoint, review, proof, or acceptance sizing.
- Missing required Codex advisory basis reopens `work-planning`.
- Stale Codex advisory basis reopens `work-planning`.
- Invalidly skipped Codex advisory basis reopens `work-planning`.
- Pre-`work-planning` Codex advisory basis reopens `work-planning`.
- `triggered:*` requires active adjudication.
- Treat `fail-open:*` as advisory-unavailable evidence.
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
Material facts travel as packet fields.
Material facts travel as task state.
Material facts travel as workflow state.
Material facts travel as cited artifacts.
