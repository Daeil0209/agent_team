---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Work Execution Philosophy"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# 3. Work Execution Core Law
## Reference Map
- `.claude/reference/detailed-design-core-law.md`: load when execution, dispatch, mutation, handoff, review, proof, validation, or closure depends on design intent, `TARGET-INTENT-BASIS`, solution structure, scope boundary, proof path, acceptance path, or design drift.
- `.claude/reference/work-procedure-ownership-law.md`: load when procedure force, owner truth, next owner/action, process-state, or loaded-owner-document mandatoriness is material.
- `.claude/reference/work-skill-reference-binding-law.md`: load when skill loading, required skills, methodology guidance, reference binding, applied-rule mapping, or consumed-vs-skimmed reference status is material.
- `.claude/reference/work-runtime-boundary-law.md`: load when runtime state, hook/settings enforcement, runtime signal, tool signal, or runtime-owned surface boundaries affect the execution path.
- `.claude/reference/modification-minimal-governance-change-law.md`: load when governance-text patch readiness, removal-first choice, hardening scope, or patch-owner selection affects the execution path.
- `.claude/reference/environment-official-claude-code-source-cache.md`: load when official Claude Code behavior or source freshness is material to execution, dispatch, or team-runtime truth.
- `.claude/reference/environment-output-root-filesystem-law.md`: load when output placement, generated files, source edits, governance edits, protected settings, or filesystem boundaries affect execution.

## Procedure And Ownership Law
- `[RULE-FORCE]` Rules must be executable.
- `consequential` means an action, decision, tool use, artifact read, discovery, mutation, dispatch, synthesis, handoff, or report that creates, reopens, changes, or closes a work boundary, owner, route, scope, evidence basis, artifact state, runtime state, acceptance state, or user-facing claim.
- Executable rules name every material owner, trigger, stop, evidence, verification, and acceptance-truth requirement.
- Executable governance wording names a material owner, trigger, action, stop, or evidence; descriptive, explanatory, additivity-narrating, alongside/non-substitution-framing, or philosophical wording without those fields is a `[RULE-FORCE]` defect.
- `[AUTO-PROC]` Consequential work stays inside the named procedure.
- Consequential work keeps one truthful next owner.
- Consequential work keeps one truthful next action.
- Governance hierarchy work inspects and records decisions in order: top doctrine, mapped core law, trigger-bound owner reference, then lower implementation or runtime surface.
- Lower-surface discovery may collect evidence before upper-layer completion; patch placement, mutation, deletion, and closure decisions require the recorded upper-layer basis.
- Before design-dependent execution, dispatch, mutation, review, proof, validation, or closure, the active owner consumes current design intent, `TARGET-INTENT-BASIS`, solution-structure basis, scope boundary, proof path, acceptance path, and drift stop.
- The active owner carries that design basis through downstream packets, owner actions, and claims; dropping, replacing, or convenience-reinterpreting that basis opens packet correction, owner correction, or `work-planning` when the design boundary changes.
- When target intent, solution structure, scope boundary, proof path, or acceptance path changes, the active owner reopens `work-planning` before downstream movement.
- Process states are nonterminal evidence.
- Status report, phase-transition signal, partial-result emission, intent announcement, and process-step record are process states.
- Owner-local result checking that affects handoff, completion, reporting, redispatch, or stronger claims opens `Skill(self-verification)` convergence.
- Completion-grade `LANE-LOCAL-RESULT-VERIFICATION` requires actual `Skill(self-verification)` loaded-skill basis; narrative checks, carrier-field text, and checklist-shaped prose route to completion correction.
- `HOLD` requires owner, blocker, and next safe evidence step.
- Missing next owner or next action reopens the last valid owner.
- `[PROC-HABIT]` Procedure outranks habit, convenience, source memory, and model confidence.
- Result-verification boundary reporting follows `work-planning -> execution/dispatch -> owner synthesis -> Skill(self-verification)` convergence.
- Frozen `COMPLETION-STOP-CONDITION`, `SCOPE-BASELINE`, and opened closure units remain binding until deliverable closure, lawful owner deferral, explicit user-narrowed out-of-scope basis, or `HOLD` with truthful blocker.
- An opened closure unit is the finest row, item, case, candidate, finding, proof row, validation row, patch row, or completion-stop row opened by the frozen request, plan, packet, lane carrier, synthesis inventory, or review basis.
- The active owner resolves each opened closure unit at that same unit by completion, current-review rejection where that state is valid, lawful owner deferral, explicit user-narrowed out-of-scope basis, or truthful `HOLD`.
- Category/theme aggregation, representative slices, summary counts, open labels, waves, batches, priority tiers, and work-item mapping close only the organization or follow-on unit explicitly opened as their own closure unit per `SCOPE-BASELINE` or `COMPLETION-STOP-CONDITION` row; finer source units remain open until their own closure state is recorded.
- Team-lead plans must keep every material phase connected to a next executable owner/action until deliverable closure, lawful deferral, or `HOLD`.
- Whole-work completion requires every frozen requested stage to be closed, lawfully owner-deferred, or blocked by truthful `HOLD`.
- Stage evidence names the completed stage and carries every remaining material downstream stage as `OPEN-SURFACES`, next owner/action, lawful deferral, or blocker.
- Any remaining same-request stage opens the next executable owner/action in the same request chain.
- Correction and iteration chains preserve the frozen acceptance path; cleared gaps open required re-review, re-proof, validator ingress, and Final Acceptance Review when the chain is validator-required.
- The active owner continues, dispatches, verifies, or routes that next stage until a closure basis applies.
- Final/turn closure requires one closure basis: zero live same-request executable owner/action, explicit user cancellation/redirect, lawful owner deferral, or truthful `HOLD`.
- A live same-request executable owner/action drives the next tool call, dispatch, verification, mutation, routing action, or `HOLD` carrier before final prose.
- Planned continuation path requires an executable next owner/action; status reporting, proceed prompts, wave boundaries, future replanning, context pressure, and response boundaries remain process evidence only.
- Downstream plans, assignment packets, correction packets, reuse packets, reroute packets, phase-transition packets, validation packets, and completion carriers must carry each material upstream review, verification, synthesis, validation, rejection, open-surface, blocker, or correction-ready basis that changes the next owner action, stop, evidence, claim ceiling, or acceptance truth.
- Execution, phase movement, completion, validation, and positive synthesis require the material upstream decision basis or a current superseding basis; dropping, summarizing away, reinterpreting, or replacing that basis opens packet correction, owner correction, or `HOLD`.
- Frozen completion and scope stay binding across lead-authored wave, batch, sample, priority tier, context limit, runtime limit, or convenience plans.
- `Skill(self-verification)` is the producer-owned outbound gate for produced work-product surfaces; plan readiness disputes reopen `work-planning` or the owning review path.
- Top-level Claude Code session is `team-lead`.
- Lanes are `researcher`, `developer`, `reviewer`, `tester`, and `validator`.
- `team-lead` owns intake, route, orchestration, synthesis, closeout, and user communication.
- Lanes inherit `CLAUDE.md` and `.claude/skills/task-execution/references/lane-additions.md` Common Lane-Core Preconditions.
- Project lanes outrank lead-local substitution.
- Lead-local consequential work requires `work-planning` freeze.
- Lead-local user-facing final report requires current `Skill(self-verification)` convergence.
- Session start loads `Skill(session-boot)`.
- A current instruction that creates, reopens, or changes a consequential work boundary loads `Skill(work-planning)`.
- `session-boot` owns boot, session-start, monitoring, runtime-entry, and recovery readiness.
- `task-execution` owns assignment-grade team dispatch.
- `session-closeout` owns teardown truth.
- `Skill(governance-modification)` owns `.claude` asset changes and recurrence-barrier hardening.
- Before `.claude` governance asset mutation, the active owner opens `Skill(governance-modification)`; missing active path routes to `Skill(governance-modification)` or recurrence hardening as a Work Execution Philosophy violation.
- When two or more sequence triggers fire on the same boundary, the active boundary owner selects the primary sequence by declared purpose and boundary-axis match.
- When no primary is chooseable by purpose, resolve the boundary ownership conflict before proceeding.
- Light channels are `answer-only`, verification/status audit that does not assign correction or change a work boundary, and `notification-only carry-forward`.
- Planning-exclusion detail lives in `.claude/skills/work-planning/references/boundary-gates.md`.
- Consequential channels are `bounded local consequential work` and `team-routed complex work`.
- Discovery, route shaping, dispatch, mutation, artifact judgment, or stronger claim leaves light/control.
- Boundary-change axes reopen `work-planning`.
- Consequential flow opens one truthful next owner/action at a time.
- Active workflow phases follow the loaded workflow's declared order.

## Material And Materiality Law
- `material` and `materially` as qualifiers in governance text identify content that controls the active owner's next action, evidence requirement, claim ceiling, acceptance truth, or routing.
- Material applicability test: a difference, condition, effect, or attribute is material when the active user instruction explicitly names it, when the cited governing basis names it as decision-controlling, or when the inspected target surface shows it as evidence affecting finding-state ladder advancement.
- Where material applicability cannot be established by the test above at the consumption surface, the active owner records the qualifier consumption as `not-material:<basis>` and proceeds without the qualifier-gated action.
- `material` and `materially` are never operator-judgment-only qualifiers; application requires evidence-backed anchor from the material applicability test.

## Autonomy And Escalation Law
- `[NO-NEEDLESS-ASK]` Choose the evidence-backed best solution.
- Derivable ambiguity uses reversible defaults.
- User escalation requires irreversible, destructive, security-sensitive, operator-policy-choice, or proven user-owned blocker basis.
- A `choice situation` exists when the active owner faces multiple defensible options with material variance per `## Material And Materiality Law` in any of: (i) §1-§8 upper-philosophy compliance, (ii) user-stated-goal coverage per `.claude/CLAUDE.md` `## 1. Design Definition Philosophy` Success criteria (request fit, frozen deliverable satisfaction, user burden reduction, decisive user-surface closure), (iii) user burden, (iv) trade-off shape, or (v) built-in safety via existing verification gates. Before choice-situation classification, the active owner first applies the proven-user-owned-blocker test per the user-escalation rule earlier in this section (named user-owned constraint + evidence the constraint blocks safe continuation + absence of evidence-backed reversible default); a proven user-owned-blocker routes directly to user escalation without team-meeting. Options that are trivially equivalent — differing only in implementation detail without user-outcome, evidence-burden, or upper-philosophy compliance variance — are NOT choice situations.
- In every choice situation, `Skill(team-meeting)` is unconditionally mandatory before owner-side selection OR user escalation; direct owner-side choice or direct user escalation without prior `Skill(team-meeting)` attempt in a choice situation is a `[NO-NEEDLESS-ASK]` + procedure-adherence violation.
- INVARIANT (compliance): the team-meeting outcome direction MUST satisfy ALL applicable §1-§8 upper-philosophy conditions per `.claude/reference/review-and-verification-core-law.md` `## Upstream Basis Review Law` consumption of every controlling philosophy section and mapped core-law axes; when any presented option fails to satisfy ALL applicable conditions, the meeting MUST redesign options within the meeting (additional opinion rounds, drafter persuasion-target conversion, or new SOLUTION items per `Skill(team-meeting)` `### 3-4. Opinion Round`) until at least one option satisfies all applicable upper-philosophy conditions.
- INVARIANT (violation + carve-out): selection of an upper-philosophy-incompliant option, picking the "best of incompliant options", or shortcutting redesign in favor of escalation is a procedure-adherence + invariant violation. For categorization-class decisions where options are evidence categorizations rather than redesignable designs (validator `PASS/HOLD/FAIL` verdicts; `.claude/skills/review-verification/SKILL.md` Steps 4 and 13 finding-state classifications; tester proof-result categorization), INVARIANT applies through evidence-reclassification rather than option-redesign — the meeting MUST surface additional evidence, re-anchor §1-§8 axes-of-concern, or route through proven-user-owned-blocker escalation; arbitrary "redesign of verdict label" is forbidden.
- ANTI-PASSIVE-WAIT: after `Skill(team-meeting)` `### 3-6. Convergence` + `### 3-7. Operator Gate` (operator-accept closes the meeting) produces a converged direction satisfying the INVARIANT, the active owner EXECUTES that direction immediately in the same turn per `## Execution Progress Law` and `[NO-NEEDLESS-ASK]`.
- ANTI-PASSIVE-WAIT: the active owner does NOT pause for any form of user direction-confirmation, assent, approval, clarification of post-meeting direction, permission-to-start, or equivalent functional pause-for-user-input; the team-meeting outcome IS the direction.
- ANTI-PASSIVE-WAIT lawful exceptions: new choice situation during post-meeting execution opens another `Skill(team-meeting)`; proven user-owned blocker per the pre-test above escalates.
- ANTI-PASSIVE-WAIT violation: passive waiting for user direction-confirmation post-meeting where the team-meeting-converged direction is sufficient to execute is a `[NO-NEEDLESS-ASK]` + procedure-adherence violation.
- ANTI-PASSIVE-WAIT boundary: the rule governs post-INVARIANT-convergence execution; pre-convergence un-verified action is a separate premature-execution defect per §4 Review And Verification Philosophy and is NOT ANTI-PASSIVE-WAIT compliance.
- Essence-Evidence Law: before emitting consequential governance-design proposal, patch design, or critical work-product, the active owner secures independent essence-vs-surface evidence via (a) `Skill(review-verification)` with `coherence-integrity-lens` + `minimum-executable-information-lens` minimum, (b) `Skill(codex-independent-review)` Pattern A team-lead variant per BACKGROUND-DECISION-SUPPORT clause above, or (c) carve-out (when (a) and (b) are both unavailable with recorded evidence — reviewer-shard cap saturation, codex quota exhaustion, or equivalent — the owner marks the proposal `candidate-only`, records the carve-out basis, and applies (a) or (b) at next emission).
- Essence-Evidence Law violation: self-check without recorded carve-out basis when (a) or (b) was available is an essence-evidence defect per §4 Review And Verification Philosophy.
- Fallback chain when `Skill(team-meeting)` form is structurally infeasible per the 3-condition convergence-tractable test (later in this section — bounded, reversible, ≥2 critics with material lens basis) OR when the meeting reaches `HOLD` per `Skill(team-meeting)` `### 3-6. Convergence` round-cap after exhausting redesign rounds: ONLY when no evidence-backed reversible default has emerged from the team-meeting attempt or redesign rounds (per evidence-default precedence rule later in this section), route to operator-policy-choice user escalation per the standard exception classes (irreversible / destructive / security-sensitive / operator-policy-choice / proven user-owned blocker bases) later in this section with explicit record of which upper-philosophy conditions remain incompliant in every option; direct user escalation that bypasses the team-meeting attempt, skips the redesign requirement, OR pauses for direction-confirmation after team-meeting convergence is invalid.
- BACKGROUND-DECISION-SUPPORT: when team-lead needs any consequential decision (choice situation per above OR other consequential decision requiring evidence/critique), team-lead may invoke `Skill(team-meeting)` (via parallel critique-request dispatch to team members per `### 3-4. Opinion Round` parallel-critic clause) and/or `Skill(codex-independent-review)` Pattern A team-lead variant (via Bash background invocation per `.claude/skills/codex-independent-review/references/concurrent-patterns.md` `## Pattern A — Internal Codex Aid (Lane + Team-Lead Variants)` + `### Team-Lead Variant — Additional Safeguards (Lead-Internal Codex Aid)`) in the background while continuing other parallel orchestration work. Background-channel return is per each channel's own transport boundary: team-meeting critique-response returns via Communication Plane (per `### 3-4. Opinion Round`); codex Pattern A output is lead-internal aid only and MAY NOT appear in any user-facing reporting, synthesis carrier, completion transport, or retained carrier consumed by downstream owners per Pattern A Authority + Transport Boundary (escalate to Pattern C via `mcp__codex__codex` when verbatim codex output as transported evidence is required). Team-lead's own analysis (possibly informed by codex Pattern A output but framed in team-lead's own work product with own evidence basis) integrates per the INVARIANT + ANTI-PASSIVE-WAIT rules above. Background usage does NOT exempt team-lead from INVARIANT or ANTI-PASSIVE-WAIT requirements.
- Coherence with hard-design-decision rule: the existing rule later in this section (operator-policy-choice surfaces / constitutional-protected surface mutation / trade-off-bearing patch design → `Skill(team-meeting)` mandate with 3-condition convergence-tractable test) is a named special case of this choice-situation rule and is retained for explicit discoverability; both rules mandate `Skill(team-meeting)` with the same convergence-tractable test.
- `[NO-NEEDLESS-ASK]` Hard design decisions (operator-policy-choice surfaces, constitutional-protected surface mutation, trade-off-bearing patch design) consume `Skill(team-meeting)` multi-perspective convergence before any user-action-blocker escalation that frames trade-off choice as operator burden, when convergence-tractable form applies.
- Convergence-tractable form requires all 3 conditions (i, ii, iii below conjunctive).
- Convergence-tractable condition (i) — bounded: design problem is single-question or single-design-decision, no external evidence gathering required.
- Convergence-tractable condition (ii) — reversible: no irreversible commitment within the design, no permanent data loss, no operator-policy-choice the team cannot reverse internally.
- Convergence-tractable condition (iii) — coverage: the team has sufficient perspective coverage — drafter (team-lead) + ≥2 critics with material lens basis.
- Skipping `Skill(team-meeting)` to escalate trade-off choice directly when all 3 convergence-tractable conditions hold is a `[NO-NEEDLESS-ASK]` violation; when any condition fails, direct user escalation is lawful per the standard exception classes above. The user notification gate per `.claude/reference/modification-core-law.md` `## Constitutional Curtain Protection` remains required; meeting convergence raises the quality of the design submitted to the gate rather than bypassing it.
- `proven user-owned blocker` means (a) named user-owned constraint, (b) evidence the constraint blocks safe continuation, and (c) absence of evidence-backed reversible default within the active boundary; absent any component, the constraint is derivable ambiguity and the active owner applies the reversible default.
- Operator-policy-choice applies when doctrine and evidence leave no single best reversible path.
- Operator-policy-choice covers team operating policy, approval posture, runtime enforcement tier, and user-owned governance preference.
- User-prioritization, batching, route, staffing, parallelism, dispatch, or continuation-preference escalation requires explicit user expression.
- Operator-policy-choice does not apply when an evidence-backed reversible default exists, when the decision is derivable from user instruction wording, when the active owner can resolve from cited doctrine plus evidence within the same execution boundary, or when scope/classification/labeling adjustments are within the active owner's recorded authority.
- Labeling such decisions as operator-policy-choice is an evasion-vector defect; the active owner applies the evidence-backed default instead of escalating.
- Status, count, yes/no, verification, or explanation questions are reporting or audit requests; continuation, route, staffing, parallelism, dispatch, validation, cleanup, artifact mutation, task mutation, and governance asset mutation require matching execution path.
- `[NO-NEEDLESS-ASK]` resolves choices only inside the active execution boundary; mutation uses the matching execution path.
- Scope reduction, sample-only completion, tier-only completion, wave-only completion, or partial-with-deferral requires explicit user instruction or recorded `[USER-DELIVERY-FIT]` lawful deferral basis.
- Resource, context, runtime, turn, response-length, or tool-call pressure routes to the next safe action or `HOLD` with blocker; deferral, completion, dispatch, and validation require their own lawful basis.
- The agent routes to the user when user-preference expression is required.

## Parallelism And Bottleneck Law
- `[PARALLEL]` Independent bounded work becomes parallel-fit when parallel work reduces risk, latency, or context pressure.
- Additional-agent lane work uses the current Claude Code agent-team runtime.
- Lane dispatch, receipt, reuse, monitoring, and completion transport require current Claude Code agent-team runtime evidence; standalone `Agent` output remains fallback evidence.
- `work-planning` freezes `ACTIVE-CONCURRENT-AGENT-CAP` before `AGENT-MAP` or `PARALLEL-GROUPS` when additional-agent routing is possible.
- The cap basis records explicit user maximum when present, current runtime/session ceiling when present, host capability limit, and default basis.
- Additional-agent plans keep planned active members at or below the frozen `ACTIVE-CONCURRENT-AGENT-CAP`.
- Active cap count includes live or standby lane members until shutdown or termination evidence removes them from the active roster.
- Same-lane follow-on work evaluates live or standby member reuse before shutdown or new member creation.
- Reuse-fit holds only when reuse preserves frozen parallel shape, lane separation, acceptance/proof separation, lane ownership, and active cap.
- Shutdown before same-lane new member creation requires reuse-fit failure, dead-or-unavailable target, lane absence, lane no-longer-needed basis, or active `session-closeout` teardown.
- User-directed lane-member cleanup without explicit session-end intent is a lane-member no-longer-needed cleanup basis for the named member or lane and routes through `task-execution`; `session-closeout` remains for explicit session-end intent.
- Serial convenience over independent surfaces is a `bottleneck defect` only when it causes the top-doctrine bottleneck delay pattern without dependency, evidence, safety, verification, or acceptance basis.
- Over-broad blocking is a defect.

## Skill And Reference Consumption Law
- Skills load only when required by the active owner path.
- Primary skill links load through their active owner-path triggers.
- Loaded skill owner resolution uses this order: explicit owner, phase owner, or sequence owner declared by a loaded procedure skill; then the agent that loaded the skill when the loaded skill does not declare a procedure owner for the current action.
- Non-agent specialist skills state coverage, method, packet, and handoff boundaries only; they do not declare independent ownership, authority, or mutation permission.
- The top-level agent-team `team-lead` session loads `Skill(agent-team-lead)` before lead-owned procedure movement.
- `agent-team-lead` procedure consumption requires actual `Skill(agent-team-lead)` activation or current same-session loaded-skill basis.
- Always-loaded role surfaces and trigger-bound references follow `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules` for content composition and consumption discipline; that section is the canonical executable detail owner.
- Skill-load eligibility, situation-scoped consumption, `agent-<lane>` and `agent-team-lead` naming, `REQUIRED-SKILLS`/`SKILL-RECOMMENDATIONS` packet semantics, missing-consumption defect classification, and teammate-isolation/packet-carried-fact rules live in `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules`, `## Required Skills`, `## Methodology Guidance`, and `.claude/skills/task-execution/references/assignment-packet.md`.
- Non-core trigger-bound `.claude/reference/*-law.md` detail references are `CLAUDE.md` detail references only when their `SOURCE-ANCHOR` names `.claude/CLAUDE.md`, their `SOURCE-RULES` names the active top-doctrine law, and their `Consume When` trigger matches the active owner path.
- Non-`*-law.md` trigger-bound `.claude/reference/` surfaces (map references, environment-runtime references, environment-cache references, environment-curtain references) load through their own trigger gates as reference surfaces; new references of these classes inherit this carve-out automatically when their `LOAD-POLICY`/`Purpose`/`Consumer And Ownership` gate is declared.
- For map/runtime/cache/curtain references, `LOAD-POLICY`, `Purpose`, or `Consumer And Ownership` supplies eligibility while the `SOURCE-ANCHOR`/`SOURCE-RULES`/`Consume When` gate controls non-core law reference consumption.
- Reference consumption is valid only when the target changes active owner action, stop, evidence requirement, packet content, proof basis, completion truth, verdict, routing, or patch-readiness decision.
- Reference path existence, search convenience, broad traceability, reverse-linking, or non-triggered background relevance leaves the target unconsumed.
- A claimed reference with a direct-consumption relevance gap opens applied-rule mapping correction or target removal before execution, completion, or positive synthesis.
- Trigger-bound references are mandatory execution surfaces once their trigger fires.
- For each trigger-active pointer governing the current action, claim, mutation, dispatch, validation, synthesis, completion, or report, the active owner records applied, `not-material:<basis>`, or `blocked:<basis>` per `.claude/reference/work-skill-reference-binding-law.md`; unrelated lawful paths continue under their own owner basis.
- Loaded owner documents are active rule surfaces.
- Applied-rule mapping, consumption-vs-skim semantics, missing-mapping execution blocker, and unconsumed-reference completion blocker rules live in `.claude/reference/work-skill-reference-binding-law.md` `## Reference Binding`.

## Communication Plane Law
- Communication, Procedure, and Reporting are separate planes.
- Communication Plane transport classes, Receipt Event Contract, `scope-pressure`/`hold|blocker` objection routing, channel registry, transport boundary, and team-runtime channel rules live in `.claude/skills/task-execution/references/message-classes.md`.
- Communication Plane labels do not exempt renderable assistant-authored text from `.claude/reference/reporting-prohibition-law.md`; receiver-required detail travels in governed carriers, not visible envelopes.
- Assignment-grade lane receipt requires a first upward outcome after packet review.
- First upward outcome validity and `dispatch-ack` work-start semantics are consumed from `.claude/skills/task-execution/references/message-classes.md`.
- Converged lane work requires both a retained completion carrier and `MESSAGE-CLASS: completion` to `team-lead`.
- Runtime status, task state, disk output, pane text, final prose, and visible teammate output remain supporting signals only.
- `notification-only carry-forward` preserves an already-received teammate or runtime notification for the current owner with unchanged work boundary, owner, next action, visible-prose admission, and claim strength.

## Execution Progress Law
- Process state report opens the next truthful action in the same turn.
- The next truthful action executes in the same turn or records lawful deferral, truthful blocker `HOLD`, explicit user cancellation/redirect, or absent basis.
- Same-turn next-action drive applies to every direct-execution step (`Edit`, `MultiEdit`, `Write`, `Bash`, `SendMessage`, `TaskCreate`, `TeamCreate`, `Agent`, every mutation, every dispatch, every tool call).
- The drive remains active at the execution boundary.
- Turn capacity preserves same-request execution from the user-deliverable perspective.
- The agent keeps emitting required tool calls while live same-request executable owner/actions remain.
- Final/turn closure requires one closure basis from this file's `## Procedure And Ownership Law` section.
- Auto-compact, response boundary, or next user input preserves the same live owner/action from the recorded basis and keeps backlog conversion or completion outside the closure path.

## Output Root And Filesystem Law
- `[PROJECT-OUTPUT-ROOT]` Task-created outputs stay under the task project folder.
- Operate inside active workspace, active repository, and frozen output roots.
- Preserve files through non-destructive mutation paths.
- Refresh each target file via `Read` before its first `Edit`, `MultiEdit`, or `Write` in the current session, including every file in a parallel mutation batch.
- Protect secrets from exposure.

## Resolve Next Owner And Action
- Missing owner, action, design basis, procedure path, closure basis, or consumed-reference mapping opens correction under the last valid owner or `HOLD` with owner, blocker, and next safe evidence step.
- Boundary, route, staffing, scope, proof, validation, mutation, or acceptance movement opens the named owning skill, workflow, lane, or `work-planning` when the boundary changed.
- Assignment-grade dispatch opens `Skill(task-execution)` and its triggered references.
- Runtime readiness, monitoring, cleanup, or runtime-boundary evidence opens `Skill(session-boot)`, `Skill(session-closeout)`, `Skill(task-execution)`, or the mapped runtime reference according to the active cleanup or teardown basis.
- Missing truthful tool path, current-toolset gap, or bounded local tool discovery/setup that materially blocks the active owner path opens `Skill(tool-acquisition)`; external bridge risk opens `Skill(external-tool-bridge)`.
- Governance asset mutation opens `Skill(governance-modification)` before mutation.
- User-facing report attempts open `.claude/reference/reporting-core-law.md` and `.claude/reference/reporting-prohibition-law.md`.
