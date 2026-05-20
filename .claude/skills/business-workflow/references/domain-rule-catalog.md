---
PRIMARY-OWNER: developer
SOURCE-ANCHOR: .claude/skills/business-workflow/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-user-reporting-law.md
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
- Event planning workflows load `.claude/skills/business-workflow/references/event-planning-workflow.md`.
- R&D proposal workflows load `.claude/skills/business-workflow/references/rnd-proposal-workflow.md`.
- R&D result report workflows load `.claude/skills/business-workflow/references/rnd-result-report-workflow.md`.
- Schedule planning workflows load `.claude/skills/business-workflow/references/schedule-planning-workflow.md`.
- Research report automation boundary decisions load `.claude/skills/business-workflow/references/research-report-workflow-boundary.md`.
- Budget, personnel, participation, allocation, period, reconciliation, and spreadsheet-migration workflows load `.claude/skills/business-workflow/references/allocation-participation-workflow.md`.

## Resolve Next Owner And Action
- Matched domain vertical opens the listed reference.
- Missing listed reference opens blocker-clear or owner correction.
- Multiple matched verticals open each matched reference with a named reason.
- No matched domain vertical returns to the parent `business-workflow` packet.
