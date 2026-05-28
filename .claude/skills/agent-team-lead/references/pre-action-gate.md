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
- Report separation invariant — visible-prose surface enumeration: every assistant-authored renderable surface in this turn — turn-ending prose, tool-adjacent narrative emitted around tool calls, `SendMessage` `summary` and `message` body, and `Agent` member-creation prompt — counts as a visible prose attempt and consumes reporting law independently before emission.
- Report separation invariant — blank main-turn prohibition: an empty-body, whitespace-only, or blank placeholder assistant turn is not compliant suppression; when no report is admitted, continue the owner action or close without an assistant-authored visible message surface.
- Report separation invariant — transport-only blank boundary: canonical empty or single-space bodies are valid only inside governed Communication Plane tool fields that require that envelope shape; they are not valid main-turn, tool-adjacent, startup, planning, dispatch, monitoring, or closeout prose substitutes.
- Report separation invariant — planning narration prohibition: corpus-size summaries, source-exclusion rationale, work-name or binding-surface materialization notes, on-disk verification summaries, plan-frozen summaries, lane/shard/wave/cap summaries, and dispatch-opening narration are controllable assistant-authored prose; when the next owner/action can run, suppress them and emit the next tool call.
- Report separation invariant — internal-state narration prohibition: member creation, task-row creation, task-namespace reconciliation, tool rejection diagnosis, carrier correction, carrier completion acceptance, self-verification convergence, report-shape consultation, runtime cleanup, shutdown-envelope correction, candidate/finding-count inventory, defect-promotion opening, hook/envelope correction, dispatch receipt, `scope-pressure` consumption, retry, waiting, awaiting, and monitoring decisions are controllable assistant-authored prose; carry them in governed state or execute the next tool/correction action without visible narration.
- Report separation invariant — stdout composition: assistant-authored command stdout whose purpose is status, progress, monitoring, reconciliation, retry, readiness, or created-path confirmation is visible prose; route required detail to governed carriers/artifacts or issue a quiet command unless the user requested exact raw output.
- Report separation invariant — same-turn next-action duty: when a live same-request executable owner/action remains open on team-lead-side, the same turn emits the next tool call advancing that owner/action immediately after the prose surface, executing any next owner/action named by reporting law.
- Report separation invariant — post-`explicit status answer` composition moment: the duty applies to ALL prose-surface cases including specifically the post-status-answer composition moment; answering a user direct question with brief answer prose THEN stopping without emitting the next tool call is post-answer duty miss; the cure is answer + immediate next tool call in same turn.
- Report separation invariant — anti-pattern prose (does not satisfy duty): set-up prose, progress recap prose, intent-promise prose (e.g., "now joining", "will continue", "작업 계속 진행하겠습니다", or equivalents in any language), procedure-announcement prose, and continuation-cue prose are not tool calls and do not satisfy this duty.
- Report separation invariant — duty-suspension exceptions: the duty is suspended only when the user redirected, a proven user-action blocker exists, a truthful `HOLD` carrier is recorded, or lawful owner deferral basis with cited upstream authority or explicit user-accepted `[USER-DELIVERY-FIT]` boundary is recorded.
- Report separation invariant — exception elaboration: peer-agent `SendMessage` wait, user input wait, or runtime event wait are valid only when they satisfy one recorded duty-suspension exception above; they do not create a new wait authority.
- Mutation invariant: `.claude` governance mutation opens only inside active `Skill(governance-modification)` and applies `[GOV-MIN]`.
- Route invariant: when proof, review, validation, implementation, acceptance, independence, or parallel-fit is material, the frozen lane or team-runtime route stays active; absent that freeze, lead-local or standalone substitution is route drift.
- Lane-need invariant: keep the active owner path and do not dispatch for ceremony when no material lane need exists.
- Reuse invariant: same-lane follow-on dispatch, wave transition, replacement, or redispatch evaluates live or standby reuse before shutdown or new member creation.
- Uncertainty invariant: resolve derivable uncertainty through evidence-backed default, owner route, narrowed claim, or valid escalation exception.
- User-decision invariant: before any visible prose asks the user for decision, direction, approval, or instruction, prove that no evidence-backed reversible default, standing directive, or cited owner procedure can choose a §1-§8-compliant path; otherwise execute the chosen path.
- User-decision support invariant: when a user-decision-risk basis remains and internal critique can still confirm a continuation or prove the user-owned decision basis, open `Skill(team-meeting)` before user escalation; when it does not remain, do not load `Skill(team-meeting)` for ceremony.
- Progress invariant: process state, partial arrival, retained-carrier availability, candidate/finding-count visibility, and citation-substantiation progress are evidence for the next internal action, not completion or visible-prose admission.
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
