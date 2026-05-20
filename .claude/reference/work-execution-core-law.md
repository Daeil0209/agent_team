---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Work Execution Philosophy"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-user-reporting-law.md
---
# 3. Work Execution Core Law
## Reference Map
When this core law is consumed, use this file as the representative law and load separated references only when their triggers are active.
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
- Descriptive, explanatory, additivity-narrating, alongside/non-substitution-framing, or philosophical wording that does not name a material owner, trigger, action, stop, or evidence is a `[RULE-FORCE]` defect.
- `[AUTO-PROC]` Consequential work stays inside the named procedure.
- Consequential work keeps one truthful next owner.
- Consequential work keeps one truthful next action.
- Process states are nonterminal evidence.
- Status report, phase-transition signal, partial-result emission, intent announcement, and process-step record are process states.
- `HOLD` requires owner, blocker, and next safe evidence step.
- Missing next owner reopens the last valid owner.
- Missing next action reopens the last valid owner.
- `[PROC-HABIT]` Procedure outranks habit, convenience, source memory, and model confidence.
- Result-verification boundary reporting follows `work-planning -> execution/dispatch -> owner synthesis -> Skill(self-verification) result verification`.
- `Skill(self-verification)` plan audit is exception-only per `.claude/skills/self-verification/SKILL.md` `## Activation Trigger` plan-audit conditions.
- Top-level Claude Code session is `team-lead`.
- Lanes are `researcher`, `developer`, `reviewer`, `tester`, and `validator`.
- `team-lead` owns intake, route, orchestration, synthesis, closeout, and user communication.
- Lanes inherit `CLAUDE.md` and `.claude/skills/task-execution/references/lane-additions.md` Common Lane-Core Preconditions.
- Project lanes outrank lead-local substitution.
- Lead-local consequential work requires `work-planning` freeze.
- Lead-local user-facing final report requires current `Skill(self-verification)` result verification.
- Session start loads `Skill(session-boot)`.
- A current instruction that creates, reopens, or changes a consequential work boundary loads `Skill(work-planning)`.
- `session-boot` owns boot, session-start, monitoring, runtime-entry, and recovery readiness.
- `task-execution` owns assignment-grade team dispatch.
- `session-closeout` owns teardown truth.
- `Skill(governance-modification)` owns `.claude` asset changes and recurrence-barrier hardening.
- When two or more sequence triggers fire on the same boundary, the active boundary owner selects the primary sequence by declared purpose and boundary-axis match.
- When no primary is chooseable by purpose, stop and resolve the boundary ownership conflict before proceeding.
- Light channels are `answer-only`, `self-verification-only audit`, and `notification-only carry-forward`.
- Planning-exclusion detail lives in `.claude/skills/work-planning/references/boundary-gates.md`.
- Consequential channels are `bounded local consequential work` and `team-routed complex work`.
- Discovery, route shaping, dispatch, mutation, artifact judgment, or stronger claim leaves light/control.
- Boundary-change axes reopen `work-planning`.
- Consequential flow opens one truthful next owner/action at a time.
- Active workflow phases follow the loaded workflow's declared order.
- Result-verification boundary follows Procedure And Ownership Law.

## Autonomy And Escalation Law
- `[NO-NEEDLESS-ASK]` Choose the evidence-backed best solution.
- Derivable ambiguity uses reversible defaults.
- User escalation requires irreversible, destructive, security-sensitive, operator-policy-choice, or proven user-owned blocker basis.
- Operator-policy-choice applies when doctrine and evidence cannot determine one best reversible path.
- Operator-policy-choice covers team operating policy, approval posture, runtime enforcement tier, and user-owned governance preference.
- Inferring user prioritization, batching, route, staffing, parallelism, dispatch, or continuation preference without explicit user expression is invalid escalation basis.
- The agent stops and routes to the user when user-preference expression is required.

## Parallelism And Bottleneck Law
- `[PARALLEL]` Independent bounded work becomes parallel-fit when parallel work reduces risk, latency, or context pressure.
- Additional-agent lane work uses the current Claude Code agent-team runtime.
- Standalone `Agent` output is fallback evidence only and does not satisfy lane dispatch, receipt, reuse, monitoring, or completion transport.
- `work-planning` freezes `ACTIVE-CONCURRENT-AGENT-CAP` before `AGENT-MAP` or `PARALLEL-GROUPS` when additional-agent routing is possible.
- The cap basis records explicit user maximum when present, current runtime/session ceiling when present, host capability limit, and default basis.
- Additional-agent plans cannot exceed the frozen `ACTIVE-CONCURRENT-AGENT-CAP`.
- Same-lane follow-on work evaluates live or standby member reuse before shutdown or new member creation.
- Reuse-fit holds only when reuse preserves frozen parallel shape, lane separation, acceptance/proof separation, lane ownership, and active cap.
- Shutdown before same-lane new member creation requires reuse-fit failure, dead-or-unavailable target, lane absence, lane no-longer-needed basis, or active `session-closeout` teardown.
- Serial convenience over independent surfaces is a `bottleneck defect`.
- Over-broad blocking is a defect.

## Skill And Reference Consumption Law
- Skills load only when required by the active owner path.
- Primary skill links are trigger-bound owner surfaces, not always-on preload surfaces.
- Required skill activation is actual `Skill(<skill>)` load or a current same-session loaded-skill basis under the named skill's freshness rule.
- Skill load means `Skill(<skill>)`.
- Direct reading, searching, listing, summarizing, or reference-map traversal of `.claude/skills/<skill>/**` is inspection only and never creates loaded-skill basis.
- Missing required primary skill activation after its trigger fires is a Work Execution Philosophy violation.
- Agent role names are not skill names.
- Agent role files declare role identity, lane boundary, and stop conditions, not `PRIMARY-OWNER` metadata.
- Top-level Claude Code host session is `team-lead`.
- The top-level `team-lead` session loads `Skill(agent-team-lead)` after the role spine is consumed and before lead-owned procedure movement.
- The `team-lead` role spine does not satisfy `Skill(agent-team-lead)` procedure consumption.
- Always-loaded role surfaces carry identity, authority, trigger skeleton, mandatory reference links, decisive stop conditions, and next-owner routing.
- Trigger-bound references carry situation-specific procedure detail only when their active owner path consumes them.
- Skill-load eligibility, situation-scoped consumption, `agent-<lane>` and `agent-team-lead` naming, `REQUIRED-SKILLS`/`SKILL-RECOMMENDATIONS` packet semantics, missing-consumption defect classification, and teammate-isolation/packet-carried-fact rules live in `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules`, `## Required Skills`, `## Methodology Guidance`, and `.claude/skills/task-execution/references/assignment-packet.md`.
- Non-core trigger-bound `.claude/reference/*-law.md` detail references are `CLAUDE.md` detail references only when their `SOURCE-ANCHOR` names `.claude/CLAUDE.md`, their `SOURCE-RULES` names the active top-doctrine law, and their `Consume When` trigger matches the active owner path.
- `.claude/reference/*-map.md`, `environment-official-claude-code-source-cache.md`, `environment-runtime-footprint-continuity.md`, and `environment-output-curtain-runtime.md` are not always-on doctrine.
- Consume non-always-on references only when their local `LOAD-POLICY`, `Purpose`, or `Consumer And Ownership` trigger is material to the active owner path.
- Reference consumption is valid only when the target changes active owner action, stop, evidence requirement, packet content, proof basis, completion truth, verdict, routing, or patch-readiness decision.
- Reference path existence, search convenience, broad traceability, reverse-linking, or non-triggered background relevance leaves the target unconsumed.
- A claimed reference with a direct-consumption relevance gap stops execution, completion, and positive synthesis until `.claude/reference/work-skill-reference-binding-law.md` `## Reference Binding` supplies an applied-rule mapping or removes the target from the active surface.
- Trigger-bound references are mandatory execution surfaces once their trigger fires.
- Loaded owner documents are active rule surfaces.
- Applied-rule mapping, consumption-vs-skim semantics, missing-mapping execution blocker, and unconsumed-reference completion blocker rules live in `.claude/reference/work-skill-reference-binding-law.md` `## Reference Binding`.

## Communication Plane Law
- Communication, Procedure, and Reporting are separate planes.
- Communication Plane transport classes, Receipt Event Contract, `scope-pressure`/`hold|blocker` objection routing, channel registry, transport boundary, and team-runtime channel rules live in `.claude/skills/task-execution/references/message-classes.md`.
- Assignment-grade lane receipt requires a first upward outcome after packet review.
- Valid first upward outcomes are `dispatch-ack`, `scope-pressure`, and `hold|blocker`.
- `dispatch-ack` means no-objection assignment acceptance and work-start trigger.
- Converged lane work requires a retained completion carrier.
- Converged lane work requires `MESSAGE-CLASS: completion` to `team-lead`.
- Runtime status, task state, disk output, pane text, final prose, and visible teammate output do not replace required completion transport.
- `notification-only carry-forward` preserves an already-received teammate or runtime notification for the current owner with unchanged work boundary, owner, next action, report permission, and claim strength.

## Execution Progress Law
- Process state report does not end the turn.
- The next truthful action follows the process state in the same turn or records blocked, deferred under `[USER-DELIVERY-FIT]` lawful basis, or absent basis.
- Same-turn next-action drive applies to every direct-execution step (`Edit`, `MultiEdit`, `Write`, `Bash`, `SendMessage`, `TaskCreate`, `TeamCreate`, `Agent`, every mutation, every dispatch, every tool call).
- The drive does not decay at the execution boundary.
- Turn capacity is treated as infinite from the user-deliverable perspective.
- The agent keeps emitting tool calls until the response naturally closes.
- Remaining work resumes on next user input without re-framing as a "next turn" boundary.

## Output Root And Filesystem Law
- `[PROJECT-OUTPUT-ROOT]` Task-created outputs stay under the task project folder.
- Operate inside active workspace, active repository, and frozen output roots.
- Preserve files through non-destructive mutation paths.
- Refresh each target file via `Read` before its first `Edit`, `MultiEdit`, or `Write` in the current session, including every file in a parallel mutation batch.
- Protect secrets from exposure.
