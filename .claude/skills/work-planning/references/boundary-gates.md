# Work-Planning Boundary Gates
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/work-planning/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-user-reporting-law.md
auto-inject: false

Use this file when activation scope, corpus measurement, same-boundary exclusion, boundary-change axes, hard stops, or post-planning gate detail is material.

## Corpus Measurement Gate
- Corpus discovery is consequential when it is unknown, scope-changing, route-shaping, burden-sizing, or used as file/line/byte evidence for burden or parallel-fit judgment.
- Exhaustive, full-corpus, whole-folder, unknown-corpus, governance-audit, and governance-review work freezes bounded corpus measurement first.
- Measurement basis includes file count, line or byte scale, semantic surface inventory, high-touch or critical-surface notes, and the burden or parallel-fit judgment those facts support.
- Prefer scalar or small grouped measurement stdout when that satisfies the planning burden.
- Use retained carriers for raw path manifests, per-file inventories, and high-volume line-count tables when a retained carrier preserves evidence better.
- Do not block a lawful measurement command only to hide host-native tool output.
- Reporting discipline controls assistant-authored prose; it does not reduce or suppress measurement evidence required for the work.
- Run only the measurement action before route-ready freeze.
- Reopen or complete `work-planning` from the measured basis.
- Unmeasured material burden blocks dispatch-ready planning.

## Light And Same-Boundary Exclusions
- Known-owner lookup stays outside planning when it does not diagnose, audit, analyze, route, dispatch, mutate, size burden, or support a stronger claim.
- Known-owner status stays outside planning when it does not diagnose, audit, analyze, route, dispatch, mutate, size burden, or support a stronger claim.
- Planning belongs at boundary creation.
- Planning does not reopen for every internal correction.
- Same-artifact correction loops stay with the active workflow owner when all boundaries stay unchanged.
- Same-artifact review loops stay with the active workflow owner when all boundaries stay unchanged.
- Same-artifact revision loops stay with the active workflow owner when all boundaries stay unchanged.
- `answer-only` is a direct answer with no tool use, artifact judgment, route change, dispatch, mutation, acceptance, or stronger claim.
- `answer-only` stays outside planning unless it assigns, reopens, or changes consequential work.
- `self-verification-only audit` verifies an already-frozen plan or result claim without dispatch, mutation, acceptance, or report expansion.
- `self-verification-only audit` stays outside planning unless it assigns, reopens, or changes consequential work.
- `notification-only carry-forward` uses `.claude/CLAUDE.md` `## 3. Work Execution Philosophy` channel definition and stays outside planning unless it assigns, reopens, or changes consequential work.
- These light/control messages stay outside planning unless they assign, reopen, or change consequential work:
  - receipt-only messages
  - cleanup-only messages
  - phase-transition-only messages
  - clarification-only messages
- Artifact judgment ends the exclusion when it moves a boundary-change axis.
- Analysis result ends the exclusion when it moves a boundary-change axis.

## Boundary-Change Axes
- Boundary-change axes are owner/phase, surface/artifact, deliverable, proof/acceptance chain, route/dispatch shape, staffing/parallel shape, skill basis, and user requirement.
- The owner/phase axis moves when:
  - owner lane changes
  - workflow phase changes
  - sequence owner changes
- The surface/artifact axis moves when:
  - target artifact changes
  - user surface changes
  - consumed source changes
- The deliverable axis moves when:
  - output kind changes
  - content contract changes
  - scope baseline changes
- The proof/acceptance chain axis moves when:
  - proof burden changes
  - acceptance owner changes
  - verdict identity changes
- The route/dispatch shape axis moves when:
  - lead-local path changes
  - workflow path changes
  - `task-execution` path changes
  - team-runtime path changes
  - agent path changes
- The staffing/parallel shape axis moves when:
  - lane split changes
  - agent count changes
  - merge owner changes
  - parallel grouping changes
- The skill-basis axis moves when material methodology or capability skill basis changes.
- The user-requirement axis moves when:
  - explicit user constraint changes
  - priority changes
  - burden changes
  - scope changes
- Same-boundary correction requires every axis to cite the current frozen value.
- A moved axis reopens `work-planning`.

## Hard Stops
- `NEXT-CONSEQUENTIAL-ACTION` names the first local item, workflow owner, sequence owner, `Skill(task-execution)` activation, loaded `task-execution` consumption, blocker-clear move, authorization request, or `HOLD`.
- Consequential planning names the team-lead work plan before `NEXT-CONSEQUENTIAL-ACTION`; the next action executes the first row and carries the remaining rows as internal continuation.
- Planning opens one next owner/action before:
  - execution
  - dispatch
  - reporting
- These option lists to the user are invalid when doctrine, current request, and evidence can choose the next action:
  - route option lists
  - staffing option lists
  - parallelism option lists
  - dispatch option lists
  - prior-artifact reuse vs restart option lists
  - deliverable-source option lists
- Prior task-created outputs are excluded sources for current-target or current-corpus work unless the user explicitly asks to reuse, merge, validate, report, or compare against that artifact.
- Excluded source means do not copy, paraphrase, cite as evidence, or derive shard shape, taxonomy, finding shape, workflow, methodology, route, or conclusion from that prior output; opening or reading is lawful only as non-shape-defining sanity consultation after the current live-source basis is frozen.
- Prior outputs become deliverables or reference sources only when the user explicitly asks to reuse, merge, validate, report, or compare against that artifact.
- If excluded prior output shaped shard shape, taxonomy, workflow, route, packet, or conclusion, discard the derived surface and rebuild it from the current live target/corpus.
- Non-shape-defining consultation records `prior-output-consulted:no-derivation` and continues from current live sources; it cannot change route, packet, taxonomy, finding shape, workflow, methodology, or conclusion without explicit prior-output use.
- Prior outputs are not a replacement deliverable, user choice, route source, or methodology source unless explicit prior-output use was requested.
- Missing required bounded corpus measurement from any Corpus Measurement Gate work type blocks dispatch-ready planning.
- Dispatch-ready planning includes:
  - `team-dispatch-readiness-plan`
  - `AGENT-MAP`
  - `PARALLEL-GROUPS`
  - dispatch-ready `NEXT-CONSEQUENTIAL-ACTION`
- `PARALLEL-GROUPS: none` is invalid unless measured dependency or serial-burden basis proves serial stronger than parallel for:
  - multi-surface work
  - unmeasured material corpus work
- Agent-specific skills are not listed in packet `REQUIRED-SKILLS`.
- Lane ownership lazy-loads agent-specific skills.
- Use `[]` when no additional methodology or capability skill is required.
- Agent-boundary transfer uses `task-execution` packet translation.
- Agent-boundary transfer does not use the internal planning record.
- Reopen `work-planning` when any of these changes the frozen boundary:
  - new consequential item
  - new surface
  - new owner map
  - hidden step
  - route ambiguity
  - stronger claim
- Same-phase same-artifact workflow iteration is not new when every Activation Trigger boundary remains unchanged.
- Multi-wave patch routes consume `SCOPE-BASELINE` union rules in `.claude/skills/work-planning/references/planning-record-fields.md`.

## Post-Planning Gate
1. Open exactly one next owner/action from the frozen team-lead work plan.
2. If `ACTIVE-WORKFLOW` is set, open the owner named by `NEXT-CONSEQUENTIAL-ACTION`.
3. If a non-`not-applicable` `ACTIVE-SEQUENCE` is set, open the owner named by `NEXT-CONSEQUENTIAL-ACTION`.
4. Load the named owner when absent or insufficient under that owner's freshness rule.
5. Load a named skill owner only through `Skill(<skill>)`; `Read`, `Grep`, `Glob`, `LS`, summary, memory, or reference-map traversal does not satisfy the load.
6. Run the named owner to its named outcome when required by that owner's freshness rule.
7. Consume the named owner before lead-local action.
8. Consume the named owner before `task-execution`.
9. Consume the named owner before user reporting.
10. Consume the named owner before phase movement.
11. Consume the named owner before mutation.
12. Rerun stale owner consumption to outcome before downstream movement.
13. Source lookup, remembered procedure text, non-owner review input, and unchecked owner summary do not satisfy named-owner consumption per `.claude/reference/work-skill-reference-binding-law.md` `## Reference Binding`.
14. `team-routing candidate` and `ambiguous-route` open `Skill(task-execution)` activation per the activation rule at `.claude/skills/task-execution/SKILL.md` `## Activation`.
17. Load `Skill(self-verification)` in plan-audit mode only for an explicit plan-audit target or disputed frozen-plan readiness.
18. Reopen `work-planning` when the frozen target is missing, vague, contradicted, or unconsumed.
19. Reopen `work-planning` when the route is missing, vague, contradicted, or unconsumed.
20. Reopen `work-planning` when the readiness basis is missing, vague, contradicted, or unconsumed.
21. Consume the team-lead work plan as phase, owner, action, stop/evidence, review/verification, iteration, and termination rows.
22. Trace the next action to the first executable row of the team-lead work plan; failed trace reopens `work-planning`.

## Resolve Next Owner And Action
- Measurement gaps open bounded corpus measurement.
- Boundary-change findings reopen `work-planning`.
- Same-boundary findings return to the active workflow owner.
- Hard-stop failure opens `HOLD`, blocker-clear, or reopened owner.
- Completed post-planning gate opens the named next owner/action.
