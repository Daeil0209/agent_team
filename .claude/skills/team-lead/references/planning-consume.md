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
5. `ACTIVE-SEQUENCE`
6. `ROUTING-SIGNAL`
7. `NEXT-CONSEQUENTIAL-ACTION`
8. `DISPATCH-BLOCKERS` / `HOLD-CONDITIONS`
9. `EXECUTION-READINESS-BASIS`
10. `LEAD-LOCAL-REQUIRED-SKILLS` / `LANE-REQUIRED-SKILLS-MAP`
11. `AGENT-MAP` / `PARALLEL-GROUPS` when routed

## Reaction Rules
- `answer-only` means answer only.
- If `PROJECT-TIER` is frozen but `ACTIVE-REQUEST-TIER` or `TIER-RAISE-REASON` is missing, contradictory, or weaker than the floor, reopen `work-planning`.
- Consume the frozen tier basis before staffing, checkpoint, review, proof, or acceptance sizing. `PROJECT-TIER` sets the floor; `ACTIVE-REQUEST-TIER` may raise above it without silently rewriting the floor.
- `PROJECT-TIER: Lightweight` plus `ACTIVE-REQUEST-TIER: Lightweight` avoids precision-only staffing, gates, and checkpoint burden by habit.
- Raised `ACTIVE-REQUEST-TIER` carries the stronger request tier into the stronger acceptance path required by the frozen risk basis.
- Tier may lighten unnecessary governance burden, but it must not downshift decisive user-surface proof or acceptance integrity.
- Named `ACTIVE-WORKFLOW` or non-`not-applicable` `ACTIVE-SEQUENCE` opens the workflow or sequence owner named by `NEXT-CONSEQUENTIAL-ACTION` before `SV-PLAN` or consequential execution continues.
- Missing or blocked `EXECUTION-READINESS-BASIS` reopens `work-planning` unless `NEXT-CONSEQUENTIAL-ACTION` names a same-route blocker-clear move already verified by `SV-PLAN`.
- Direct work conditions for `lead-local candidate`: one bounded surface, no frozen independent lane owner, no material review/proof/validator separation, no meaningful parallelism loss, no executable/destructive/security-sensitive acceptance burden, and no claim stronger than lead-local evidence can verify.
- Read-only diagnostic, audit, and analytical reports default to `lead-local candidate` under those direct-work conditions. Team fan-out for such work requires a frozen context-cost or independent-evidence basis, not routing habit.
- `lead-local candidate` goes to `SV-PLAN`, then local only when `LEAD-LOCAL-WORK-ITEMS` is complete, `LEAD-LOCAL-REQUIRED-SKILLS` is frozen, `NEXT-CONSEQUENTIAL-ACTION` names the first local item or exact blocker-clear move, and no break condition fired.
- `team-routing candidate` and `ambiguous-route` go to `SV-PLAN`, then `task-execution`.
- Missing or contradictory planning fields reopen `work-planning`.
- Before opening `task-execution` for independent or parallel work, confirm the frozen route applied same-session prior patches, decisions, contract freezes, lane-charter changes, and acceptance-contract changes. Missing or contradictory cross-continuity basis reopens `work-planning`.
- Before opening `task-execution` for team-agent runtime, confirm the receiving lanes do not depend on lead-only conversation history. Material facts must be packetized, stored in task/workflow state, or cited as artifacts before dispatch.

## Guarded-Local Law
- Do not start local work from an implied remainder.
- If local execution reveals a new work item, new surface, lane-owned step, stronger claim, or route ambiguity, stop and reopen `work-planning`.
- Lead-local stays legitimate only while execution remains inside the frozen local item list and no new owner, new surface, hidden consequential step, or stronger claim appears.
- If `lead-local candidate` is frozen, load every skill named in `LEAD-LOCAL-REQUIRED-SKILLS` before bounded local work continues.
- If `team-routing candidate` or `ambiguous-route` is frozen, do not let `task-execution` invent or omit agent skill loads. Agent-facing `REQUIRED-SKILLS` must come from `LANE-REQUIRED-SKILLS-MAP` or lawful phase-local refinement and must contain additional non-lane-core skills only. Lane ownership, not packet skill listing, triggers lane-core loading; use `REQUIRED-SKILLS: []` when no additional skill is required.
- The full planning basis stays internal. Once work crosses the agent boundary, `task-execution` translates the frozen route into an assignment-grade dispatch packet.
