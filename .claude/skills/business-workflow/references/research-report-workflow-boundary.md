---
PRIMARY-OWNER: developer
SOURCE-ANCHOR: .claude/skills/business-workflow/SKILL.md
SOURCE-RULES: "domain-rule-catalog.md routed Research Report Workflow Boundary"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# Research Report Workflow Boundary

## Purpose
Use this reference when report automation involves business workflow states, approval or mutation authority, source-of-truth separation, audit semantics, reconciliation semantics, configurable rule tables, or operator workflow meaning.

## Owner Boundary
Research evidence method belongs to `researcher` `Source-Family Method Floor`.
Reader structure belongs to `document-automation`.
Generated-document quality belongs to `document-automation`.
Pipeline software architecture belongs to `software-architecture`.
business-workflow owns workflow states, approval authority, mutation authority, source-of-truth separation, audit semantics, reconciliation semantics, configurable rule tables, and operator workflow meaning.

## Consumption Rule
When business-workflow is active, carry the `researcher` evidence packet instead of restating researcher methodology.
When no business workflow state or authority surface is material, return to `document-automation`, `researcher`, or `software-architecture`.

## Resolve Next Owner And Action
- Business workflow state opens business-workflow packet extraction.
- Research evidence need opens researcher evidence work.
- Reader/report structure need opens document-automation.
- Pipeline architecture need opens software-architecture.
