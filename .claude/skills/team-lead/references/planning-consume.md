---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
---

# team-lead: Planning Consume Detail

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
- If `PROJECT-TIER` is frozen but `ACTIVE-REQUEST-TIER` or `TIER-RAISE-REASON` is missing, contradictory, or weaker than the floor, reopen `work-planning`.
- Consume the frozen tier basis before staffing, checkpoint, review, proof, or acceptance sizing.
- `PROJECT-TIER` sets the floor.
- `ACTIVE-REQUEST-TIER` can raise above it without silently rewriting the floor.
- `PROJECT-TIER: Lightweight` plus `ACTIVE-REQUEST-TIER: Lightweight` avoids precision-only staffing, gates, and checkpoint burden by habit.
- Raised `ACTIVE-REQUEST-TIER` carries the stronger request tier into the stronger acceptance path required by the frozen risk basis.
- Tier can lighten unnecessary governance burden.
- Tier must not downshift decisive user-surface proof or acceptance integrity.
- If a Codex advisory trigger applied, missing, stale, invalidly skipped, or pre-`work-planning` `CODEX-ADVISORY-BASIS` reopens `work-planning`.
- `triggered:*` requires active adjudication.
- `fail-open:*` means advisory unavailable, not Codex agreement.
- Required `PARALLEL-GROUPS` must carry boundary, non-overlap, and measured/cited burden basis. File-only, guessed, or pre-`work-planning` measurement reopens `work-planning`.
- Named `ACTIVE-WORKFLOW` or non-`not-applicable` `ACTIVE-SEQUENCE` opens the workflow or sequence owner named by `NEXT-CONSEQUENTIAL-ACTION` before consequential execution continues.
- Missing or blocked `EXECUTION-READINESS-BASIS` reopens `work-planning` unless `NEXT-CONSEQUENTIAL-ACTION` names a same-route blocker-clear move already verified by the active owner.
- Direct work conditions for `lead-local candidate`:
  - one bounded surface
  - no frozen independent lane owner
  - no material review/proof/validator separation
  - no meaningful parallelism loss
  - no executable/destructive/security-sensitive acceptance burden
  - no claim stronger than lead-local evidence can verify
- Read-only diagnostic, audit, and analytical reports default to `lead-local candidate` under those direct-work conditions. Team fan-out for such work requires a frozen context-footprint or independent-evidence basis, not routing habit.
- Governance refresh/read-only relearning that uses only `Read`/`Grep` on known, bounded owner docs and produces no Bash/status/listing, corpus discovery/measurement, diagnostic, audit, analytical, route, dispatch, mutation, or stronger-claim output is not `lead-local candidate`; keep it light/control.
- `lead-local candidate` executes locally only when `LEAD-LOCAL-WORK-ITEMS` is complete.
- `LEAD-LOCAL-REQUIRED-SKILLS` must be frozen.
- `NEXT-CONSEQUENTIAL-ACTION` must name the first local item or exact blocker-clear move.
- No break condition can have fired.
- `team-routing candidate` and `ambiguous-route` go to `task-execution`.
- Missing or contradictory planning fields reopen `work-planning`.
- Before opening `task-execution` for independent or parallel work, confirm the frozen route applied same-session prior patches, decisions, contract freezes, lane-charter changes, and acceptance-contract changes. Missing or contradictory cross-continuity basis reopens `work-planning`.
- Before opening `task-execution` for team-agent runtime, confirm the receiving lanes do not depend on lead-only conversation history. Material facts must be packetized, stored in task/workflow state, or cited as artifacts before dispatch.

## Guarded-Local Law
- Do not start local work from an implied remainder.
- If local execution reveals a new work item, new surface, lane-owned step, stronger claim, or route ambiguity, stop and reopen `work-planning`.
- Lead-local stays legitimate only while execution remains inside the frozen local item list and no new owner, new surface, hidden consequential step, or stronger claim appears.
- If `lead-local candidate` is frozen, load and apply every skill named in `LEAD-LOCAL-REQUIRED-SKILLS` before bounded local work continues.
- A lead-local specialist skill must either declare `SECONDARY-CONSUMER: team-lead` or have another lawful lead-local support basis frozen by `work-planning`.
- If a named local required skill cannot be applied inside the frozen boundary, reopen `work-planning` or report `HOLD`; do not continue with an unconsumed skill.
- If `team-routing candidate` or `ambiguous-route` is frozen, do not let `task-execution` invent or omit agent skill loads.
- Agent-facing `REQUIRED-SKILLS` carries required non-lane-core skills from `LANE-REQUIRED-SKILLS-MAP` or lawful phase-local refinement.
- Lane ownership, not packet skill listing, triggers lane-core loading.
- Use `REQUIRED-SKILLS: []` when no upstream required-skill basis exists.
- The full planning basis stays internal. Once work crosses the agent boundary, `task-execution` translates the frozen route into an assignment-grade dispatch packet.
