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
- Completion-grade `LANE-LOCAL-RESULT-VERIFICATION` requires actual `Skill(self-verification)` loaded-and-learned basis; narrative checks, carrier-field text, and checklist-shaped prose route to completion correction.
- Procedure Plane blocker-routing and Communication Plane `hold|blocker` are blocker-routing records, not closure, waiting permission, or user-handoff states; they require owner, blocker, exhausted internal recovery basis, and next safe owner/action.
- Missing next owner or next action reopens the last valid owner.
- `[PROC-HABIT]` Procedure outranks habit, convenience, source memory, and model confidence.
- Result-verification boundary reporting follows `work-planning -> execution/dispatch -> owner synthesis -> Skill(self-verification)` convergence.
- Frozen `COMPLETION-STOP-CONDITION`, `SCOPE-BASELINE`, and opened closure units remain binding until deliverable closure, cited lawful owner-deferral authority, explicit user-narrowed out-of-scope basis, or blocker-routing that preserves the next recovery owner/action.
- An opened closure unit is the finest row, item, case, candidate, finding, proof row, validation row, patch row, or completion-stop row opened by the frozen request, plan, packet, lane carrier, synthesis inventory, or review basis.
- The active owner resolves each opened closure unit at that same unit by completion, current-review rejection where that state is valid, cited lawful owner-deferral authority, explicit user-narrowed out-of-scope basis, or blocker-routing that preserves recovery.
- Category/theme aggregation, representative slices, summary counts, open labels, waves, batches, priority tiers, and work-item mapping close only the organization or follow-on unit explicitly opened as their own closure unit per `SCOPE-BASELINE` or `COMPLETION-STOP-CONDITION` row; finer source units remain open until their own closure state is recorded.
- Team-lead plans must keep every material phase connected to a next executable owner/action until deliverable closure, cited lawful owner-deferral authority, explicit user cancellation/redirect, or blocker-routing with recovery owner/action.
- Whole-work completion requires every frozen requested stage to be closed or deferred by cited lawful owner-deferral authority; blocker-routing keeps the requested stage open and cannot be counted as completion.
- Stage evidence names the completed stage and carries every remaining material downstream stage as `OPEN-SURFACES`, next owner/action, cited lawful owner-deferral authority, or blocker.
- Any remaining same-request stage, correction return, `scope-pressure`, Communication Plane `hold|blocker`, open surface, or handoff input opens the next executable owner/action in the same request chain.
- New user input received while a live owner/action remains open opens interrupt handling and does not start a replacement request until the live owner/action closes, records cited lawful owner-deferral authority, records blocker-routing with resume owner/action, or the user explicitly states immediate priority for the interrupting request.
- When the user explicitly prioritizes the interrupting request, the active owner records the interrupted resume frame, executes the prioritized request to closure, cited lawful owner-deferral authority, or blocker-routing, then resumes the prior live owner/action unless the user also cancelled or redirected it.
- Correction and iteration chains preserve the frozen acceptance path; cleared gaps open required re-review, re-proof, validator ingress, and Final Acceptance Review when the chain is validator-required.
- The active owner continues, dispatches, verifies, or routes that next stage until closure, cited lawful owner-deferral authority, explicit user cancellation/redirect, or blocker-routing with recovery owner/action.
- Communication Plane `scope-pressure` and `hold|blocker` are resolution triggers; the receiving owner classifies and executes packet correction, replanning, owner routing, setup/research/tool acquisition, marked inference/default, parallel continuation, or blocker-routing after every executable internal resolution route is exhausted.
- Final/turn closure requires one closure basis: zero live same-request executable owner/action, explicit user cancellation/redirect, or cited lawful owner-deferral authority. Blocker-routing without lawful deferral is not closure.
- A live same-request executable owner/action drives the next tool call, dispatch, verification, mutation, routing action, or blocker-routing carrier before any reporting-law gate; final prose still requires `.claude/reference/reporting-prohibition-law.md` admission.
- Planned continuation path requires an executable next owner/action; status reporting, proceed prompts, wave boundaries, future replanning, context pressure, and response boundaries remain process evidence only.
- Downstream plans, assignment packets, correction packets, reuse packets, reroute packets, phase-transition packets, validation packets, and completion carriers must carry each material upstream review, verification, synthesis, validation, rejection, open-surface, blocker, or correction-ready basis that changes the next owner action, stop, evidence, claim ceiling, or acceptance truth.
- Execution, phase movement, completion, validation, and positive synthesis require the material upstream decision basis or a current superseding basis; dropping, summarizing away, reinterpreting, or replacing that basis opens packet correction, owner correction, basis refresh, or blocker-routing with recovery owner/action.
- Frozen completion and scope stay binding across lead-authored wave, batch, sample, priority tier, context limit, runtime limit, or convenience plans.
- `Skill(self-verification)` is the producer-owned outbound gate for produced work-product surfaces; plan readiness disputes reopen `work-planning` or the owning review path.
- Top-level Claude Code session is `team-lead`.
- Lanes are `researcher`, `developer`, `reviewer`, `tester`, and `validator`.
- `team-lead` owner-duty detail is owned by `.claude/reference/work-procedure-ownership-law.md` `## Owner Separation`.
- Lanes inherit `CLAUDE.md` and `.claude/skills/task-execution/references/lane-additions.md` Common Lane-Core Preconditions.
- Project lanes outrank lead-local substitution.
- Lead-local consequential work requires `work-planning` freeze.
- Lead-local user-facing final report requires current `Skill(self-verification)` convergence.
- Session start loads and learns `Skill(session-boot)`.
- A current instruction that creates, reopens, or changes a consequential work boundary loads and learns `Skill(work-planning)`.
- `session-boot` owns boot, session-start, monitoring, runtime-entry, and recovery readiness.
- `task-execution` owns assignment-grade team dispatch.
- `session-closeout` owns teardown truth.
- `Skill(governance-modification)` owns `.claude` asset changes and recurrence-barrier hardening.
- Before `.claude` governance asset mutation, the active owner opens `Skill(governance-modification)`; missing active path routes to `Skill(governance-modification)` or the recurrence-barrier hardening path as a Work Execution Philosophy violation.
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
- Record `not-material:<basis>` only when the inspected consumption surface proves the qualifier does not control the active action, evidence requirement, claim ceiling, acceptance truth, or routing.
- Missing, stale, uninspected, contradicted, or absent materiality basis opens the smallest basis-refresh, consumption-correction, owner-correction, or blocker route before the qualifier-gated action is skipped.
- `material` and `materially` are never operator-judgment-only qualifiers; application requires evidence-backed anchor from the material applicability test.

## Qualifier Selection Law
- `smallest` and `narrowest` mean the least authority, scope, owner movement, user burden, runtime footprint, file mutation, or report detail that still satisfies the governing action, evidence, verification, acceptance, safety, and recovery requirements.
- When two options satisfy the same requirement, choose the option with fewer changed owner surfaces, fewer irreversible effects, less user burden, and no weaker evidence path.
- If no option can be proven smallest or narrowest from current evidence, open basis-refresh, owner-correction, or blocker-routing instead of using the qualifier as a preference label.
- `credible` means cited evidence supports the active claim ceiling and no material defeater remains open on the governing surface.
- Missing credibility evidence opens the named proof, review, validation, or blocker route instead of allowing a weaker claim.
- Evidence-strength qualifiers such as `too weak`, `weak`, `strong enough`, and `strongly enough` compare the current evidence against the governing claim ceiling, proof burden, acceptance burden, or delivery burden named by the active surface.
- Scope, size, and pressure qualifiers such as `trivial`, `non-trivial`, `thin`, `major`, `high-traffic`, and `hard pressure` require a named observable basis: affected owner count, affected surface count, user-outcome risk, runtime footprint, context/load pressure, or execution-frequency impact.
- Quality-readiness qualifiers such as `over-dense`, `self-explanatory`, `genuine`, and `submission-ready` require the active surface's acceptance, reader, proof, or receiver-job criteria; absent criteria opens basis-refresh or review rather than pass/fail by label.
- A qualifier not covered by this law requires a local operational anchor before it can block, pass, route, or close an owner action.

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
- Scope reduction, sample-only completion, tier-only completion, wave-only completion, or partial-with-deferral requires explicit user instruction or recorded `[USER-DELIVERY-FIT]` cited lawful owner-deferral authority.
- Resource, context, runtime, turn, response-length, or tool-call pressure routes to the next safe action, owner recovery, parallel continuation, or blocker-routing with recovery owner/action; deferral, completion, dispatch, and validation require their own lawful basis.
- The agent routes to the user only after internal evidence-backed defaults, correction, routing, setup, recovery, and named owner paths are exhausted and a proven user-owned action remains; admitted user prose names only the exact user action needed and smallest safe next step, while preserved resume owner/action stays internal.

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
- Serial convenience over independent surfaces is a `bottleneck defect` only when it satisfies the top-doctrine `bottleneck defect` test without dependency, evidence, safety, verification, acceptance-truth, runtime-parser, or required-procedure-force basis.
- Bottleneck-forming execution is classified only when the top-doctrine `bottleneck defect` test is met; otherwise preserve required procedure, evidence, safety, verification, acceptance truth, parser compatibility, and reporting suppression.
- Over-broad blocking is a defect.

## Skill And Reference Consumption Law
- Skills load only when required by the active owner path.
- Primary skill links load through their active owner-path triggers.
- Required skill activation and loaded-skill basis require actual full-body `Skill(<skill>)` load-and-learn or current same-session loaded-and-learned basis under the named skill's freshness rule.
- Skill load means the full active skill body is loaded and learned through `Skill(<skill>)`; frontmatter preload claims, direct reading, searching, listing, summarizing, reference-map traversal of `.claude/skills/<skill>/**`, host-rendered tool rows, tool status, or visible `Skill(...) loaded` text remains inspection/status evidence only.
- Missing required primary skill activation after its trigger fires is a Work Execution Philosophy violation.
- Agent role names remain role identifiers.
- Loaded skill owner resolution uses this order: explicit owner, phase owner, or sequence owner declared by a loaded procedure skill; then the agent that loaded the skill when the loaded skill does not declare a procedure owner for the current action.
- Non-agent specialist skills state coverage, method, packet, and handoff boundaries only; they do not declare independent ownership, authority, or mutation permission.
- Agent role files declare role identity, lane boundary, and routing conditions.
- Top-level Claude Code host session is `team-lead`.
- The top-level agent-team `team-lead` session loads and learns `Skill(agent-team-lead)` before lead-owned procedure movement.
- `agent-team-lead` procedure consumption requires actual `Skill(agent-team-lead)` full-body activation or current same-session loaded-and-learned basis.
- Always-loaded role surfaces carry identity, authority, trigger skeleton, mandatory reference links, decisive routing conditions, and next-owner routing.
- Trigger-bound references carry situation-specific procedure detail only when their active owner path consumes them.
- Skill-load eligibility, situation-scoped consumption, `agent-<lane>` and `agent-team-lead` naming, `REQUIRED-SKILLS`/`SKILL-RECOMMENDATIONS` packet semantics, missing-consumption defect classification, and teammate-isolation/packet-carried-fact rules live in `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules`, `## Required Skills`, `## Methodology Guidance`, and `.claude/skills/task-execution/references/assignment-packet.md`.
- Non-core trigger-bound `.claude/reference/*-law.md` detail references are `CLAUDE.md` detail references only when their `SOURCE-ANCHOR` names `.claude/CLAUDE.md`, their `SOURCE-RULES` names the active top-doctrine law, and their `Consume When` trigger matches the active owner path.
- `.claude/reference/*-map.md`, `environment-official-claude-code-source-cache.md`, and `environment-runtime-footprint-continuity.md` load through their trigger rules as reference surfaces.
- For the map/runtime references named above, `LOAD-POLICY`, `Purpose`, `Consumer And Ownership`, or an equivalent trigger section supplies the trigger gate when `Consume When` is absent; `SOURCE-ANCHOR` and `SOURCE-RULES` still bind the reference to the active top-doctrine law.
- Reference consumption requires the active owner to read-and-learn the complete active reference or complete triggered section and is valid only when the target changes active owner action, stop, evidence requirement, packet content, proof basis, completion truth, verdict, routing, or patch-readiness decision.
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
- Assignment-grade lane receipt requires a first upward outcome after packet review; `dispatch-ack` is the team-lead orchestration signal that the lane received the assignment, accepts it without objection, and starts work immediately.
- First upward outcome validity and `dispatch-ack` work-start semantics are consumed from `.claude/skills/task-execution/references/message-classes.md`.
- Agent-start evidence, pane activity, file mutation, or runtime liveness is monitoring evidence only and never substitutes for missing receipt transport.
- Converged lane work requires both a retained completion carrier and `MESSAGE-CLASS: completion` to `team-lead`.
- `MESSAGE-CLASS: completion` is an internal lane handoff signal plus result-carrier readiness signal for team-lead synthesis; it is not final acceptance or user-facing report admission.
- Required completion transport uses the retained completion carrier and `MESSAGE-CLASS: completion`; runtime status, task state, disk output, pane text, final prose, and visible teammate output remain supporting signals.
- `notification-only carry-forward` preserves an already-received teammate or runtime notification for the current owner with unchanged work boundary, owner, next action, visible-prose admission, and claim strength.

## Execution Progress Law
- Process state report opens the next truthful action in the same turn.
- The next truthful action executes in the same turn or records cited lawful owner-deferral authority, blocker-routing with recovery owner/action, or explicit user cancellation/redirect.
- Missing, stale, or absent basis is not closure; it opens the smallest basis-refresh, packet-correction, owner-correction, or blocker-routing only after executable correction routes are exhausted.
- Same-turn next-action drive applies to every direct-execution step (`Edit`, `MultiEdit`, `Write`, `Bash`, `SendMessage`, `TaskCreate`, `TeamCreate`, `Agent`, every mutation, every dispatch, every tool call).
- The drive remains active at the execution boundary.
- Host-rendered tool rows are execution evidence only and never create a user-facing prose slot.
- Assistant-authored shell stdout labels, banners, progress summaries, and explanatory `echo` lines are renderable report content; internal evidence commands use bare evidence output or retained artifacts.
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
- Missing owner, action, design basis, procedure path, closure basis, or consumed-reference mapping opens correction under the last valid owner or blocker-routing with owner, blocker, exhausted internal recovery basis, and next safe owner/action.
- Boundary, route, staffing, scope, proof, validation, mutation, or acceptance movement opens the named owning skill, workflow, lane, or `work-planning` when the boundary changed.
- Assignment-grade dispatch opens `Skill(task-execution)` and its triggered references.
- Runtime readiness, monitoring, cleanup, or runtime-boundary evidence opens `Skill(session-boot)`, `Skill(session-closeout)`, `Skill(task-execution)`, or the mapped runtime reference according to the active cleanup or teardown basis.
- Missing truthful tool path, current-toolset gap, or bounded local tool discovery/setup that materially blocks the active owner path opens `Skill(tool-acquisition)`; external bridge risk opens `Skill(external-tool-bridge)`.
- Governance asset mutation opens `Skill(governance-modification)` before mutation.
- User-facing report attempts open `.claude/reference/reporting-core-law.md` and `.claude/reference/reporting-prohibition-law.md`.
