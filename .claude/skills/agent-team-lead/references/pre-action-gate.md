---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "action-invariants; owner-action; skill-freshness; applied-rule-mapping; reporting-prohibition; governance-mutation-gate; drift-stop"
---
# team-lead: Pre-Action Invariants

## Purpose
Use this reference to keep team-lead action aligned with the current request, owner path, and allowed report/mutation boundary.
This reference supplies action invariants, not a field ledger, packet template, progress report, or universal checklist.
This reference governs Procedure Plane movement only; user-facing report admission stays with the reporting law at visible-prose attempt time.
Do not delay execution to fill fields.
When an invariant is satisfied, continue the active owner action.
When an invariant fails, open the smallest correcting owner/action.

## Consume When
- The next procedure action can change owner, route, mutation boundary, dispatch boundary, proof/review/validation boundary, or claim strength.
- Team-lead might act locally instead of routing to a lane.
- Team-lead might mutate `.claude`, dispatch, redispatch, or continue after partial lane/runtime evidence.
- The user challenges whether team-lead is progressing according to the intended procedure.

## Action Invariants
PROTECTED-LOCAL-RESTATEMENT-BASIS: pre-action atomic-sweep — Action Invariants colocated for atomic team-lead consultation at every consequential action boundary. Cross-reference traversal at sweep moment adds high-frequency consultation cost. Destinations (`work-execution-core-law`, `work-skill-reference-binding-law`, `reporting-core-law`, `modification-core-law`) define rules in their domains; this surface assembles them as one complete sweep-check.
- Request invariant: keep the current user deliverable, scope, and burden-reduction purpose active.
- Owner invariant: keep one truthful next owner and one truthful next action.
- Procedure invariant: open the triggered owner skill, sequence, reference, or lane before acting on that owner path.
- Freshness invariant: before owner, route, report, mutation, dispatch, proof/review/validation, or claim-strength movement, use only loaded skill/reference basis that still supplies the rule needed for that movement; stale or uncertain basis cannot authorize movement.
- Reference invariant: consume only references that change action, stop, evidence, packet, proof, completion truth, verdict, routing, or patch-readiness; mark material references as `applied`, `not-material:<basis>`, or `blocked:<basis>`.
- Report separation invariant: visible prose attempts consume reporting law independently, execute any next owner/action named by that law, and otherwise return to the active owner/action unless user instruction redirects or truthful `HOLD` applies.
- Mutation invariant: `.claude` governance mutation opens only inside active `Skill(governance-modification)` and applies `[GOV-MIN]`.
- Route invariant: when proof, review, validation, implementation, acceptance, independence, or parallel-fit is material, the frozen lane or team-runtime route stays active; absent that freeze, lead-local or standalone substitution is route drift.
- No material lane need: keep the active owner path and do not dispatch for ceremony.
- Reuse invariant: same-lane follow-on dispatch, wave transition, replacement, or redispatch evaluates live or standby reuse before shutdown or new member creation.
- Uncertainty invariant: resolve derivable uncertainty through evidence-backed default, owner route, narrowed claim, or valid escalation exception.
- Progress invariant: process state, partial arrival, retained-carrier availability, and findings-count visibility are evidence for the next internal action, not completion or visible-prose admission.

## Drift Stops
- Missing owner or next action opens owner correction or `HOLD`.
- Missing material reference consumption opens the exact required reference.
- Stale or uncertain loaded skill/reference basis opens the smallest refresh action before movement: reload the required skill or consume the exact triggered reference.
- Visible-prose denial executes the reporting-law named continuation or otherwise continues the current owner action without user-facing prose.
- Lane-arrival or partial-completion evidence opens retained-carrier consumption, synthesis, monitoring, redispatch, or `Skill(self-verification)`.
- Local-action drift opens `lead-local-guarded-law` only for frozen lead-local items; material lane need opens the owning lane through `Skill(task-execution)` when frozen, or `Skill(work-planning)` when the boundary changed.
- Mutation drift opens `Skill(governance-modification)` before mutation.
- Claim-strength drift opens claim narrowing, `Skill(self-verification)`, or `Skill(review-verification)` according to the claim type.

## Resolve Next Owner And Action
- All material invariants hold: continue the active owner action.
- Invariant failure: open the smallest correcting owner/action named above.
- Boundary change: open `Skill(work-planning)`.
- Runtime readiness, monitoring, recovery, or cleanup evidence: open `Skill(session-boot)`, `Skill(task-execution)`, or `Skill(session-closeout)` according to the active runtime path.
- Report attempt: open `.claude/reference/reporting-prohibition-law.md`, execute the next owner/action named by that law, and otherwise return to the active owner/action unless user instruction redirects or truthful `HOLD` applies.
