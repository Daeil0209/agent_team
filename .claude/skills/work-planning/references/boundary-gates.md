# Work-Planning Boundary Gates
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/work-planning/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
auto-inject: false

Use this file when activation scope, corpus measurement, same-boundary exclusion, boundary-change axes, hard stops, or post-planning gate detail is material.

## Corpus Measurement Gate
- Unknown corpus discovery is consequential discovery.
- Scope-changing corpus discovery is consequential discovery.
- Route-shaping corpus discovery is consequential discovery.
- Burden-sizing corpus discovery is consequential discovery.
- File counts used for burden sizing are consequential discovery.
- Line counts used for burden sizing are consequential discovery.
- Byte counts used for burden sizing are consequential discovery.
- Exhaustive work freezes bounded corpus measurement first.
- Full-corpus work freezes bounded corpus measurement first.
- Whole-folder work freezes bounded corpus measurement first.
- Unknown-corpus work freezes bounded corpus measurement first.
- Governance audit uses the bounded corpus measurement rule.
- Governance review uses the bounded corpus measurement rule.
- Measurement basis includes file count.
- Measurement basis includes line or byte scale.
- Measurement basis includes semantic surface inventory.
- Measurement basis includes high-touch or critical-surface notes.
- Measurement basis must support burden judgment.
- Measurement basis must support parallel-fit judgment.
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
- `answer-only` stays outside planning unless it assigns, reopens, or changes consequential work.
- `SV-only audit` stays outside planning unless it assigns, reopens, or changes consequential work.
- `notification-only carry-forward` stays outside planning unless it assigns, reopens, or changes consequential work.
- Receipt-only messages stay outside planning unless they assign, reopen, or change consequential work.
- Control-only messages stay outside planning unless they assign, reopen, or change consequential work.
- Lifecycle-only messages stay outside planning unless they assign, reopen, or change consequential work.
- Phase-transition-only messages stay outside planning unless they assign, reopen, or change consequential work.
- Clarification-only messages stay outside planning unless they assign, reopen, or change consequential work.
- Artifact judgment ends the exclusion when it moves a boundary-change axis.
- Analysis result ends the exclusion when it moves a boundary-change axis.

## Boundary-Change Axes
- Boundary-change axes are owner/phase, surface/artifact, deliverable, proof/acceptance chain, route/dispatch shape, staffing/parallel shape, skill basis, and user requirement.
- The owner/phase axis moves when owner lane changes.
- The owner/phase axis moves when workflow phase changes.
- The owner/phase axis moves when sequence owner changes.
- The surface/artifact axis moves when target artifact changes.
- The surface/artifact axis moves when user surface changes.
- The surface/artifact axis moves when consumed source changes.
- The deliverable axis moves when output kind changes.
- The deliverable axis moves when content contract changes.
- The deliverable axis moves when scope baseline changes.
- The proof/acceptance chain axis moves when proof burden changes.
- The proof/acceptance chain axis moves when acceptance owner changes.
- The proof/acceptance chain axis moves when verdict identity changes.
- The route/dispatch shape axis moves when lead-local path changes.
- The route/dispatch shape axis moves when workflow path changes.
- The route/dispatch shape axis moves when `task-execution` path changes.
- The route/dispatch shape axis moves when team-runtime path changes.
- The route/dispatch shape axis moves when agent path changes.
- The staffing/parallel shape axis moves when lane split changes.
- The staffing/parallel shape axis moves when agent count changes.
- The staffing/parallel shape axis moves when merge owner changes.
- The staffing/parallel shape axis moves when parallel grouping changes.
- The skill-basis axis moves when material non-lane-core skill basis changes.
- The user-requirement axis moves when explicit user constraint changes.
- The user-requirement axis moves when priority changes.
- The user-requirement axis moves when burden changes.
- The user-requirement axis moves when scope changes.
- Same-boundary correction requires every axis to cite the current frozen value.
- A moved axis reopens `work-planning`.

## Hard Stops
- `NEXT-CONSEQUENTIAL-ACTION` names the first local item, workflow owner, sequence owner, `task-execution`, blocker-clear move, authorization request, or `HOLD`.
- Planning opens one next owner/action before execution.
- Planning opens one next owner/action before dispatch.
- Planning opens one next owner/action before reporting.
- Route option lists to the user are invalid when doctrine and evidence can choose the best route.
- Staffing option lists to the user are invalid when doctrine and evidence can choose the best route.
- Parallelism option lists to the user are invalid when doctrine and evidence can choose the best route.
- Dispatch option lists to the user are invalid when doctrine and evidence can choose the best route.
- Required measurement missing from exhaustive work blocks dispatch-ready planning.
- Required measurement missing from full-corpus work blocks dispatch-ready planning.
- Required measurement missing from whole-folder work blocks dispatch-ready planning.
- Required measurement missing from governance audit/review blocks dispatch-ready planning.
- Required measurement missing from unknown-corpus work blocks dispatch-ready planning.
- Dispatch-ready planning includes `team-dispatch-readiness-plan`.
- Dispatch-ready planning includes `AGENT-MAP`.
- Dispatch-ready planning includes `PARALLEL-GROUPS`.
- Dispatch-ready planning includes dispatch-ready `NEXT-CONSEQUENTIAL-ACTION`.
- `PARALLEL-GROUPS: none` is invalid for multi-surface work unless measured dependency or serial-burden basis proves serial stronger than parallel.
- `PARALLEL-GROUPS: none` is invalid for unmeasured material corpus work unless measured dependency or serial-burden basis proves serial stronger than parallel.
- Lane-core skills are not listed in packet `REQUIRED-SKILLS`.
- Lane ownership lazy-loads lane-core skills.
- Use `[]` when no additional non-lane-core skill is required.
- Agent-boundary transfer uses `task-execution` packet translation.
- Agent-boundary transfer does not use the internal planning record.
- New consequential item reopens `work-planning` when it changes the frozen boundary.
- New surface reopens `work-planning` when it changes the frozen boundary.
- New owner map reopens `work-planning` when it changes the frozen boundary.
- Hidden step reopens `work-planning` when it changes the frozen boundary.
- Route ambiguity reopens `work-planning` when it changes the frozen boundary.
- Stronger claim reopens `work-planning` when it changes the frozen boundary.
- Same-phase same-artifact workflow iteration is not new when every Activation Trigger boundary remains unchanged.

## Post-Planning Gate
1. Open exactly one next owner/action.
2. If `ACTIVE-WORKFLOW` is set, open the owner named by `NEXT-CONSEQUENTIAL-ACTION`.
3. If a non-`not-applicable` `ACTIVE-SEQUENCE` is set, open the owner named by `NEXT-CONSEQUENTIAL-ACTION`.
4. Load the named owner when absent, stale, or wrong-boundary.
5. Run the named owner to its named outcome when absent, stale, or wrong-boundary.
6. Consume the named owner before lead-local action.
7. Consume the named owner before `task-execution`.
8. Consume the named owner before user reporting.
9. Consume the named owner before phase movement.
10. Consume the named owner before mutation.
11. Rerun stale owner consumption to outcome before downstream movement.
12. Source lookup does not satisfy named-owner consumption.
13. Remembered procedure text does not satisfy named-owner consumption.
14. Advisory input does not satisfy named-owner consumption.
15. Unchecked owner summary does not satisfy named-owner consumption.
16. `team-routing candidate` opens `task-execution`.
17. `ambiguous-route` opens `task-execution`.
18. Load `self-verification` in `SV-PLAN` mode only for an explicit plan-audit target.
19. Load `self-verification` in `SV-PLAN` mode only for disputed frozen-plan readiness.
20. Reopen `work-planning` when the frozen target is missing, vague, contradicted, or unconsumed.
21. Reopen `work-planning` when the route is missing, vague, contradicted, or unconsumed.
22. Reopen `work-planning` when the readiness basis is missing, vague, contradicted, or unconsumed.
23. Reopen `work-planning` when the next action is missing, vague, contradicted, or unconsumed.

## Resolve Next Owner And Action
- Measurement gaps open bounded corpus measurement.
- Boundary-change findings reopen `work-planning`.
- Same-boundary findings return to the active workflow owner.
- Hard-stop failure opens `HOLD`, blocker-clear, or reopened owner.
- Completed post-planning gate opens the named next owner/action.
