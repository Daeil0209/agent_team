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
- `material` means an axis, fact, or trigger that changes what the active owner must do next.
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
- The active owner continues, dispatches, verifies, or routes that next stage until closure, lawful owner deferral, explicit user cancellation/redirect, or truthful `HOLD`.
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
- Result-verification boundary follows Procedure And Ownership Law.

## Material And Materiality Law
- `material` and `materially` as qualifiers in governance text identify content that controls the active owner's next action, evidence requirement, claim ceiling, acceptance truth, or routing.
- Material applicability test: a difference, condition, effect, or attribute is material when the active user instruction explicitly names it, when the cited governing basis names it as decision-controlling, or when the inspected target surface shows it as evidence affecting finding-state ladder advancement.
- Where material applicability cannot be established by the test above at the consumption surface, the active owner records the qualifier consumption as `not-material:<basis>` and proceeds without the qualifier-gated action.
- `material` and `materially` are never operator-judgment-only qualifiers; application requires evidence-backed anchor from the material applicability test.

## Autonomy And Escalation Law
- `[NO-NEEDLESS-ASK]` Choose the evidence-backed best solution.
- Derivable ambiguity uses reversible defaults.
- User escalation requires irreversible, destructive, security-sensitive, operator-policy-choice, or proven user-owned blocker basis.
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
- Required skill activation and loaded-skill basis require actual `Skill(<skill>)` load, officially applied frontmatter `skills` preload, or current same-session loaded-skill basis under the named skill's freshness rule.
- Skill load means `Skill(<skill>)` or officially applied frontmatter `skills` preload; direct reading, searching, listing, summarizing, or reference-map traversal of `.claude/skills/<skill>/**` remains inspection only.
- Missing required primary skill activation after its trigger fires is a Work Execution Philosophy violation.
- Agent role names remain role identifiers.
- Loaded skill owner resolution uses this order: explicit owner, phase owner, or sequence owner declared by a loaded procedure skill; then the agent that loaded the skill when the loaded skill does not declare a procedure owner for the current action.
- Non-agent specialist skills state coverage, method, packet, and handoff boundaries only; they do not declare independent ownership, authority, or mutation permission.
- Agent role files declare role identity, lane boundary, and routing conditions.
- Top-level Claude Code host session is `team-lead`.
- The top-level agent-team `team-lead` session loads `Skill(agent-team-lead)` before lead-owned procedure movement.
- `agent-team-lead` procedure consumption requires actual `Skill(agent-team-lead)` activation or current same-session loaded-skill basis.
- Always-loaded role surfaces carry identity, authority, trigger skeleton, mandatory reference links, decisive routing conditions, and next-owner routing.
- Trigger-bound references carry situation-specific procedure detail only when their active owner path consumes them.
- Skill-load eligibility, situation-scoped consumption, `agent-<lane>` and `agent-team-lead` naming, `REQUIRED-SKILLS`/`SKILL-RECOMMENDATIONS` packet semantics, missing-consumption defect classification, and teammate-isolation/packet-carried-fact rules live in `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules`, `## Required Skills`, `## Methodology Guidance`, and `.claude/skills/task-execution/references/assignment-packet.md`.
- Non-core trigger-bound `.claude/reference/*-law.md` detail references are `CLAUDE.md` detail references only when their `SOURCE-ANCHOR` names `.claude/CLAUDE.md`, their `SOURCE-RULES` names the active top-doctrine law, and their `Consume When` trigger matches the active owner path.
- `.claude/reference/*-map.md`, `environment-official-claude-code-source-cache.md`, `environment-runtime-footprint-continuity.md`, and `environment-output-curtain-runtime.md` load through their trigger rules as reference surfaces.
- For the map/runtime references named above, `LOAD-POLICY`, `Purpose`, or `Consumer And Ownership` supplies eligibility while the `SOURCE-ANCHOR`/`SOURCE-RULES`/`Consume When` gate controls non-core law reference consumption.
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
- Required completion transport uses the retained completion carrier and `MESSAGE-CLASS: completion`; runtime status, task state, disk output, pane text, final prose, and visible teammate output remain supporting signals.
- `notification-only carry-forward` preserves an already-received teammate or runtime notification for the current owner with unchanged work boundary, owner, next action, visible-prose admission, and claim strength.

## Execution Progress Law
- Process state report opens the next truthful action in the same turn.
- The next truthful action executes in the same turn or records lawful deferral, truthful blocker `HOLD`, explicit user cancellation/redirect, or absent basis.
- Same-turn next-action drive applies to every direct-execution step (`Edit`, `MultiEdit`, `Write`, `Bash`, `SendMessage`, `TaskCreate`, `TeamCreate`, `Agent`, every mutation, every dispatch, every tool call).
- The drive remains active at the execution boundary.
- Turn capacity preserves same-request execution from the user-deliverable perspective.
- The agent keeps emitting required tool calls while live same-request executable owner/actions remain.
- Final/turn closure requires one closure basis from `## Procedure And Ownership Law`.
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
