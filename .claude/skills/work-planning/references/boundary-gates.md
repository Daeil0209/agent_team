# Work-Planning Boundary Gates
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/work-planning/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
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
- Prefer scalar or small grouped measurement stdout when that satisfies the planning burden.
- Use retained carriers for raw path manifests, per-file inventories, and high-volume line-count tables when a retained carrier preserves evidence better.
- Do not block a lawful measurement command only to hide Claude Code host-native tool output.
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
- `answer-only` stays outside planning unless it assigns, reopens, or changes consequential work.
- `SV-only audit` stays outside planning unless it assigns, reopens, or changes consequential work.
- `notification-only carry-forward` stays outside planning unless it assigns, reopens, or changes consequential work.
- These light/control messages stay outside planning unless they assign, reopen, or change consequential work:
  - receipt-only messages
  - control-only messages
  - lifecycle-only messages
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
- `NEXT-CONSEQUENTIAL-ACTION` names the first local item, workflow owner, sequence owner, `task-execution`, blocker-clear move, authorization request, or `HOLD`.
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
- Excluded source means do not open, read, copy, paraphrase, cite, or derive shard shape, taxonomy, finding shape, workflow, methodology, route, or conclusion from that prior output.
- Prior outputs become deliverables or reference sources only when the user explicitly asks to reuse, merge, validate, report, or compare against that artifact.
- If an excluded prior output was consulted before the exclusion was recognized, any planning record, binding surface, packet, shard map, taxonomy, or workflow derived from it is tainted and must be discarded and rebuilt from the current live target/corpus.
- Prior outputs are not a replacement deliverable, user choice, route source, or methodology source unless explicit prior-output use was requested.
- Required measurement missing from these work types blocks dispatch-ready planning:
  - exhaustive work
  - full-corpus work
  - whole-folder work
  - governance audit/review
  - unknown-corpus work
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
14. Non-owner review input does not satisfy named-owner consumption.
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
