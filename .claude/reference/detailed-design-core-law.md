---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Detailed Design Philosophy"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# 2. Detailed Design Core Law
## Reference Map
- `.claude/reference/design-definition-core-law.md`: load when frozen request, deliverable, scope, user burden, completion shape, or user-surface closure basis controls detailed design.
- `.claude/reference/detailed-scope-continuity-change-law.md`: load when existing-artifact judgment, modification, reduction, migration, reporting, scope-abuse signals, drift, preservation, redistribution, or current-session continuity is material.

## Design Intent And Scope Law
- Detailed design consumes Design Definition's frozen request, deliverable, scope, user burden, and completion shape as upstream basis.
- `TARGET-INTENT-BASIS` extends that upstream basis into target purpose, solution structure, scope boundary, proof path, acceptance path, and drift stop.
- `TARGET-INTENT-BASIS` does not replace `REQUEST-FIT-BASIS`, `SEMANTIC-INTENT-BASIS`, `COMPLETION-STOP-CONDITION`, or row-granular `SCOPE-BASELINE` when those bases are material.
- A detailed-design move that changes frozen request, deliverable, scope, user burden, or completion shape is design drift and reopens `work-planning` before downstream execution.
- The active downstream owner consumes current design intent, `TARGET-INTENT-BASIS`, solution-structure basis, scope boundary, proof path, acceptance path, and drift stop as Work Execution input.
- `[DESIGN-SPECIFICATION]` The active design owner specifies design intent, `TARGET-INTENT-BASIS`, solution structure, scope boundary, proof path, and acceptance path before design-dependent execution, dispatch, review, proof, validation, or mutation.
- `[DESIGN-INTENT]` Existing-artifact work and existing-governance judgment start from cited design intent and cited applicable core-law axes.
- `TARGET-INTENT-BASIS` records cited design intent, applicable core-law axes, target purpose, affected owner surfaces, scope boundary, proof path, acceptance path, and drift stop.
- When solution structure is material, `TARGET-INTENT-BASIS` also records the solution-structure basis and boundary fit.
- Existing-artifact packets carry `TARGET-INTENT-BASIS`.
- Original creation records `TARGET-INTENT-BASIS` when downstream work needs target artifact, program, report, document, governance, proof, or acceptance purpose.
- Original creation uses `TARGET-INTENT-BASIS: not-applicable:<basis>` only when no target artifact, program, report, document, or governance surface exists and `REQUEST-FIT-BASIS` plus `SEMANTIC-INTENT-BASIS` fully controls the action.
- Design drift exists when cited design intent, `TARGET-INTENT-BASIS`, solution-structure basis, scope boundary, affected owner surfaces, or applicable core-law axes change, conflict, or become unsafe.
- Scope-abuse signals route to correction per `.claude/reference/detailed-scope-continuity-change-law.md` `## Scope-Abuse Rules`.
- Current-session continuity applies before consequential movement.
- Design drift reopens `work-planning`.

## Resolve Next Owner And Action
- Complete `TARGET-INTENT-BASIS` returns to the active downstream owner that needs design intent.
- Missing frozen request, deliverable, scope, user-burden, or completion-shape basis opens `.claude/reference/design-definition-core-law.md` or `Skill(work-planning)`.
- Existing-artifact, preservation, migration, reduction, redistribution, continuity, or scope-abuse gaps open `.claude/reference/detailed-scope-continuity-change-law.md`.
- Design drift opens `Skill(work-planning)` before downstream execution, dispatch, review, proof, validation, or mutation.
