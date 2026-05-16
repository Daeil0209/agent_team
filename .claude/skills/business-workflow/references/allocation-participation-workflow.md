---
PRIMARY-OWNER: developer
SOURCE-ANCHOR: .claude/skills/business-workflow/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
---

# Allocation And Participation Workflow Oracle

## Purpose
Use this reference when a tool manages budgets, personnel, participation rates, labor cost, project years, allocations, or spreadsheet-based operational reconciliation.
It turns workbook or manual-process meaning into implementation and proof rules.

## Consume When
- The workflow has personnel assignment.
- The workflow has project-year or period selection.
- The workflow has participation rate.
- The workflow has labor cost.
- The workflow has budget category allocation.
- The workflow imports or mirrors a spreadsheet.
- The workflow reconciles totals.
- The workflow links people, projects, years, budget lines, payments, or ledger rows.

## Required Output
The business workflow packet records:
- source workbook or manual-process basis
- operator job
- source-of-truth table per entity
- period basis
- mutation authority per entity
- participation semantics
- labor-cost semantics
- allocation and reconciliation rules
- linked UI workflow surfaces
- proof oracle
- open decisions and next owner/action

## Rule Extraction
- Separate workbook layout from workflow meaning.
- Classify each sheet, tab, table, and column as master data, transaction data, derived data, report view, import staging, or export surface.
- Preserve workbook-coupled concepts as linked workflow concepts.
- Represent layout accidents as implementation choices only after workflow meaning is frozen.
- Treat undefined labels as configurable categories or open decisions.

## Participation And Labor Semantics
- Participation rate records who contributes to which project during which period.
- Labor cost records paid or budgeted money tied to a person, project, category, and period.
- A design that separates participation and labor cost surfaces must preserve visible navigation between them.
- A design that separates participation and labor cost surfaces must preserve shared totals and reconciliation status.
- Editing participation rate must recompute every dependent total, balance, warning, and status on the user surface.
- Editing labor cost must recompute every dependent total, balance, warning, and status on the user surface.
- Reload proof must show saved participation and labor-cost changes persisted.

## Period And Allocation Semantics
- Period basis names fiscal year, project year, month, effective date range, or other governing calendar.
- Project-year selection changes every dependent budget, participation, payment, and ledger view that is in scope.
- Overlapping periods require an explicit overlap rule.
- Over-allocation requires an explicit warning, block, or approval rule.
- Closed periods require explicit edit, reopen, and audit behavior.
- Rollover requires explicit carry-forward and reset behavior.

## Entity Link Semantics
- Person, project, project-year, budget category, participation row, labor-cost row, payment row, and ledger row are linked entities when more than one appears in scope.
- Every linked entity exposes a user-visible route to its related entity.
- Every related entity route exposes a user-visible route back when the reverse relation is meaningful.
- Deleting an entity requires a visible dependency result: blocked, cascaded, archived, detached, or reassigned.
- Import-created entities require the same link behavior as manually created entities.

## Reconciliation Semantics
- Totals reconcile by project, project-year, person, budget category, and period when those dimensions are in scope.
- Imported workbook totals reconcile against saved application totals.
- Exported totals reconcile against saved application totals.
- Differences produce user-visible warnings with source row, target row, amount, and required action.
- Empty-state proof records why the state is empty.
- Populated-state proof uses representative data for every material workflow path.

## Proof Oracle
- Proof uses representative workbook or seeded data when spreadsheet meaning determines acceptance.
- Proof covers create-disposition for in-scope master entities, including delete, clear, archive, deactivate, or frozen no-disposition basis.
- Proof covers edit-save-reload for in-scope mutable rows.
- Proof covers input-to-recompute for participation, labor cost, budget total, balance, warning, and status fields.
- Proof covers inspection, action, or navigation from each in-scope displayed record, metric, card, row, icon, and button to its destination or explicit display-only basis.
- Proof covers entity-to-related-entity links in both meaningful directions.
- Proof covers import, reconciliation, export, and reload when they are in scope.
- Proof records each uncovered oracle row as blocked, deferred by upstream record, or out-of-scope by frozen basis.

## Resolve Next Owner And Action
- Missing workflow meaning opens business-workflow packet correction.
- Missing source-of-truth mapping opens design correction.
- Missing linked workflow surface opens design correction.
- Missing proof oracle row opens tester packet correction.
- Missing reconciliation evidence opens validator `HOLD` or correction routing.
