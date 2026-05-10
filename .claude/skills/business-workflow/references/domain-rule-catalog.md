---
PRIMARY-OWNER: developer
SOURCE-ANCHOR: .claude/skills/business-workflow/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
---

# Business Workflow Domain Rule Catalog

## Purpose
Use this file as the domain-rule router for `business-workflow`.
Load the smallest domain reference that matches the assigned workflow surface.
Keep detailed vertical rules in their own reference files.

## Consume When
- A business-workflow assignment names a domain vertical.
- A spreadsheet or manual process maps to a listed domain vertical.
- A downstream owner needs the exact domain reference path before design, implementation, review, proof, or validation.

## Domain References
- Event planning workflows load `references/event-planning-workflow.md`.
- R&D proposal workflows load `references/rnd-proposal-workflow.md`.
- R&D result report workflows load `references/rnd-result-report-workflow.md`.
- Schedule planning workflows load `references/schedule-planning-workflow.md`.
- Research report automation boundary decisions load `references/research-report-workflow-boundary.md`.
- Budget, personnel, participation, allocation, period, reconciliation, and spreadsheet-migration workflows load `references/allocation-participation-workflow.md`.

## Next-Action Drive
- Matched domain vertical opens the listed reference.
- Missing listed reference opens blocker-clear or owner correction.
- Multiple matched verticals open each matched reference with a named reason.
- No matched domain vertical returns to the parent `business-workflow` packet.
