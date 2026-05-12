---
PRIMARY-OWNER: developer
SOURCE-ANCHOR: .claude/skills/document-automation/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand router only
---

# document-automation: Reference Router
Use this file to select the narrowest document-generation reference before generation, review, proof, or validation.

## Direct References
- `proposal-plan-grant.md`: proposal, plan, grant, and execution-control document generation.
- `research-survey-report.md`: research, survey, literature, patent, and source-based report structure.
- `operational-plan-schedule.md`: operational plan and schedule document structure.
- `review-analysis-report.md`: risk analysis, condition review, and go/no-go persuasion structure.
- `reader-density-application.md`: information density, practical application tools, and reader preparation.
- `event-planning-document.md`: institutional event-planning document generation.
- `result-report-generation.md`: result report generation from plan, proposal, or project reference.

## Selection Rules
- Load the reference that matches the document type or reader job.
- Load `reader-density-application.md` when the document must serve fast executive reading, field reuse, or practical decision support.
- Load multiple direct references only when the frozen document has multiple material document jobs.
- Keep evidence acquisition, domain validation, visual composition, and final acceptance on their adjacent owner surfaces.

## Resolve Next Owner And Action
- Return selected reference path, document job, reader job, evidence boundary, and open surfaces to the active document-automation workflow.
- If the selected reference changes generation, review, proof, or validation scope, carry the named requirement into the next owning packet before work continues.
