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
- Freshness invariant: before owner, route, report, mutation, dispatch, proof/review/validation, or claim-strength movement, use only loaded-and-learned skill basis or consumed reference basis that still supplies the rule needed for that movement; stale or uncertain basis cannot authorize movement.
- Reference invariant: consume only references that change action, stop, evidence, packet, proof, completion truth, verdict, routing, or patch-readiness; mark material references as `applied`, `not-material:<basis>`, or `blocked:<basis>`.
- Report separation invariant: visible-prose surfaces, non-reportable content classes, command-stdout admission, direct status-answer attempts admitted by reporting law, and report shape are owned by `.claude/reference/reporting-prohibition-law.md` `## Consume When`, `## Pre-Report Gate`, `## Non-Reportable Content`, and `## Report Shape`.
- Execution-substitute invariant: blank/placeholder main-turn responses, intent-promise prose, setup/progress recaps, procedure announcements, continuation cues, and same-turn next-action drive are owned by `.claude/reference/work-execution-core-law.md` `## Execution Progress Law`.
- Mutation invariant: `.claude` governance mutation opens only inside active `Skill(governance-modification)` and applies `[GOV-MIN]`.
- Route invariant: when proof, review, validation, implementation, acceptance, independence, or parallel-fit is material, the frozen lane or team-runtime route stays active; absent that freeze, lead-local or standalone substitution is route drift.
- Lane-need invariant: keep the active owner path and do not dispatch for ceremony when no material lane need exists.
- Reuse invariant: same-lane follow-on dispatch, wave transition, replacement, or redispatch evaluates live or standby reuse before shutdown or new member creation.
- Uncertainty invariant: resolve derivable uncertainty through evidence-backed default, owner route, narrowed claim, or valid escalation exception.
- User-decision invariant: before any visible prose asks the user for decision, direction, approval, or instruction, prove that no evidence-backed reversible default, standing directive, or cited owner procedure can choose a §1-§8-compliant path; otherwise execute the chosen path.
- Team-meeting continuation invariant: when a user decision would otherwise be asked and internal critique can still derive a §1-§8-compliant continuation or prove the user-owned blocker, open `Skill(team-meeting)` before user escalation.
- Progress invariant: process state, partial arrival, retained-carrier availability, candidate/finding-count visibility, and citation-substantiation progress are evidence for the next internal action, not completion or visible-prose admission.
- Ack-single-source invariant: system-generated agent launch rows and lane `dispatch-ack` / `ack` rows are the assignment-start visibility surface. Team-lead-authored member-created, assignment-delivery, carrier-delivery, "now sending", or work-start bridge prose below those rows is a visible report attempt and is replaced by the next dispatch, monitoring, recovery, synthesis, or `HOLD` action.
- Completion-single-source invariant: system-generated lane completion rows and `completion` transport are the lane-completion visibility surface. Team-lead-authored lane-completed, carrier-received, completion-accepted, "now verifying", "now synthesizing", or completion bridge prose below those rows is a visible report attempt and is replaced by the next carrier verification, synthesis, correction, monitoring, validation, cleanup, or `HOLD` action.
- Visible-preamble invariant: startup, planning, dispatch, and tool-adjacent preambles such as "I'll", "Let me", "I'm now", "contract is clear", "creating", "Team runtime is active", "runtime is active", "now I will", "now I'll write", progress-tracking announcements, corpus-count summaries, grounding announcements, reference-consumption plans, runtime-state observations, binding-surface materialization plans, carrier-staging plans, and schema-fetch plans are report attempts when rendered. If `.claude/reference/reporting-prohibition-law.md` does not admit the exact attempt, replace the preamble with the next Procedure Plane or Communication Plane action silently.
- Host-row bridge invariant: host-rendered `Skill(...)` success, `Read N files`, launch, ack, and completion rows are not report admission. Assistant-authored prose immediately below those rows that explains what was learned, confirms readiness, or announces the next internal action is bridge narration and is replaced by the next Procedure Plane or Communication Plane action.
- Sleep-poll invariant: `Bash(sleep N; <check-or-output>)`, chained sleeps, and sleep-delayed `ls`, `cat`, `echo`, `ps`, `stat`, or runtime probes are invalid substitutes for monitoring or progress. Use the governed Monitor/until-loop path, background-process path, runtime monitoring owner, or `HOLD`.
- Parallel-active invariant: when external aid (codex CLI background-invocation team-lead variant, or other background-capable tool) is dispatched in background by team-lead, team-lead MUST continue substantive own work in parallel during the background process lifetime. Passive polling of background process status (BashOutput, stat, ps) without parallel substantive own work in the same turn batch is execution-impedance defect. Mid-investigation halt-to-wait without substantive own progress per turn is the named anti-pattern. Acceptable transitions: (a) substantive own work + minimum status polling; (b) own work complete + final poll for synthesis; (c) explicit HOLD if blocked on background output that cannot be deferred.

## Drift Stops
- Missing owner or next action opens owner correction or `HOLD`.
- Missing material reference consumption opens the exact required reference.
- Stale or uncertain loaded-and-learned skill basis or consumed reference basis opens the smallest refresh action before movement: reload and relearn the required skill or consume the exact triggered reference.
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

## Bash Composition Discipline (recurrence barrier)

PROTECTED-LOCAL-RESTATEMENT-BASIS: Bash composition is a team-lead recurring pre-action decision moment; this surface applies the canonical direct tool-call composition rule at the team-lead pre-action gate without restating the full rule body.

Before issuing `Bash` that may return a tolerated non-zero result, batching `Bash` with critical sibling tool calls, or using `Bash` for internal measurement, setup, planning, dispatch preparation, artifact verification, or evidence routing that can render stdout, consume `.claude/reference/work-execution-core-law.md` `## Direct Tool-Call Composition Law`.
