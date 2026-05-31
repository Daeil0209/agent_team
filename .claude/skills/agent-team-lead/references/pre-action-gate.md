---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "action-invariants; owner-action; skill-freshness; applied-rule-mapping; reporting-prohibition; governance-mutation-gate; drift-stop"
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# team-lead: Pre-Action Invariants

## Purpose
Use this reference to keep team-lead action aligned with the current request, owner path, and allowed report/mutation boundary.
This reference supplies action invariants, not a field ledger, packet template, progress report, or universal checklist.
This reference governs Procedure Plane movement and `REPORTING-BASIS` freshness only; user-facing report admission stays with the reporting law at visible-prose attempt time.
Do not delay execution to fill fields.
When an invariant is satisfied, continue the active owner action.
When an invariant fails, open the smallest correcting owner/action.

## Consume When
- Team-lead is about to use `Read`, `Grep`, `Glob`, `Bash`, `Skill`, `Task*`, `Team*`, `Agent`, `SendMessage`, VCS, runtime, or dispatch tools, or construct `Bash` command text, tool parameters, stdout, or stderr behavior.
- Any assistant-authored prose, renderable tool field, command text, command stdout label, or state token could be emitted.
- A visible-prose candidate, report-denied continuation, stage-start/stage-completion wording, or punctuation/filler placeholder is possible.
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
- Reporting invariant: before a renderable boundary, apply the current same-session reporting-prohibition basis to the exact candidate surface; missing, stale, or denied mapping opens the reporting-law continuation or stale-basis refresh, otherwise returns to the active owner/action.
- Host-row invariant: visible host rows from `Read`, `Skill`, `Bash`, `TeamCreate`, `Agent`, `SendMessage`, task tools, hooks, or sandbox UI are execution evidence only; they never admit adjacent assistant-authored prose.
- Direct-tool invariant: before or after direct tools, suppress adjacent narration and execute the tool or the smallest correcting owner/action; Bash command/stdout/stderr mechanics stay with `.claude/reference/work-runtime-boundary-law.md`.
- Tool-call safety invariant: current host tool availability, current schema, independent parallel-batch shape, producer-before-consumer ordering, and probe-first handling for uncertain evidence-producing tool shapes must hold before tool execution; failed items open the smallest correction or recovery path.
- Tool-error recovery invariant: a failed `Read`, `Grep`, `Glob`, `Bash`, `Edit`, `MultiEdit`, `Write`, `Skill`, VCS, task, runtime, or dispatch tool call is internal evidence for retry, corrected path, structured edit, carrier regeneration, route correction, or blocker-routing. It never admits adjacent assistant-authored explanation, apology, rationale, or phase narration while a next internal action can run.
- Mutation invariant: `.claude` governance mutation opens only inside active `Skill(governance-modification)` and applies `[GOV-MIN]`.
- VCS scope invariant: commit, push, branch, tag, or release work on a user-named path resolves tracked changes, deletions, and untracked non-ignored descendants before external publication; unresolved in-path items open inclusion, ignore-policy, explicit-exclusion, or blocker routing before final-result prose.
- Route invariant: when proof, review, validation, implementation, acceptance, independence, or parallel-fit is material, the frozen lane or team-runtime route stays active; absent that freeze, lead-local or direct-Agent substitution outside team runtime is route drift.
- No material lane need: keep the active owner path and do not dispatch for ceremony.
- Reuse invariant: same-lane follow-on dispatch, wave transition, replacement, or redispatch evaluates live or standby reuse before shutdown or new member creation.
- Uncertainty invariant: resolve derivable uncertainty through evidence-backed default, owner route, narrowed claim, or valid escalation exception.
- Progress invariant: process state, partial arrival, retained-carrier availability, and findings-count visibility are evidence for the next internal action, not completion or visible-prose admission.

## Drift Stops
- Missing owner or next action opens owner correction or blocker-routing after internal recovery is exhausted.
- Missing material reference consumption opens the exact required reference.
- Missing or stale `REPORTING-BASIS` opens the stale reporting document or triggered-section refresh before renderable-boundary movement.
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
- Report attempt: use the current `REPORTING-BASIS`, refresh stale reporting basis first when required, execute the next owner/action named by reporting law, and otherwise return to the active owner/action unless user instruction redirects or blocker-routing after internal recovery applies.
