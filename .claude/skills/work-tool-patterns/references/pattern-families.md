# work-tool-patterns: Pattern Families
PRIMARY-OWNER: developer
SOURCE-ANCHOR: .claude/skills/work-tool-patterns/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
auto-inject: false

## Contents
- Dashboard Management Tool
- Research Analysis Tool
- Patent Analysis Tool
- Report Automation Tool
- Engineering Calculation Or Design Tool
- Spreadsheet Migration Tool
- Resolve Next Owner And Action

Use this file to select the smallest credible practical work-tool family.
These are product patterns, not full app templates.

## Dashboard Management Tool
Use when the tool manages ongoing entities, statuses, allocations, tasks, people, projects, budgets, or operational monitoring.

Pattern:
- home or dashboard acts as a resume console, not a marketing landing page
- entity detail surfaces hold durable records and edit history when material
- mutation flows expose create, edit, delete/restore, close/reopen, and recalculation meaning when material
- monitoring signals appear where the operator decides
- import/export and backup/restore are explicit when the user must keep using the tool over time

Anti-patterns:
- a dashboard that only displays vanity totals
- every field promoted into one giant sheet-like surface
- settings mixed into repeated daily operation
- completion claim that lacks save, reload, and representative workflow proof

## Research Analysis Tool
Use when the tool supports market, technology, literature, standards, or mixed-source analysis.

Pattern:
- researcher evidence packet defines source families, inclusion/exclusion, confidence, claim-evidence schema, and update trace
- product surface separates source inventory, evidence extraction, synthesis, claims, and final report or decision artifact
- operator can trace important claims back to sources or evidence rows
- stale-source or missing-source states are visible

Anti-patterns:
- polished report output that lacks inspectable evidence basis
- search results treated as final analysis
- confidence hidden inside prose
- source refresh or update trace left implicit

## Patent Analysis Tool
Use when patent landscape, patent mapping, claim comparison, legal-status awareness, or technology/IP monitoring is material.

Pattern:
- researcher packet freezes jurisdiction, database, search strategy, date window, CPC/IPC or taxonomy, assignee/inventor handling, family handling, and legal-status basis when material
- product surface separates search set, family grouping, taxonomy, claim/evidence extraction, landscape views, and report outputs
- legal-status and date freshness limits are visible as evidence limits
- outputs avoid legal conclusions unless the user explicitly supplies qualified legal basis

Anti-patterns:
- single-keyword search treated as complete patent analysis
- patent count charts that lack family, date, classification, or legal-status basis
- legal-risk language unsupported by qualified evidence

## Report Automation Tool
Use when the deliverable is a program or workflow that repeatedly creates reports, decks, PDFs, documents, or decision artifacts.

Pattern:
- source ingestion, evidence model, outline/template, generation, review, export, and rerun path are separate surfaces or stages
- document-automation owns reader structure, formatting intent, and generated-output quality
- evidence-bearing reports preserve claim-source or data-source trace where material
- export format and post-generation review path are acceptance surfaces

Anti-patterns:
- one-shot generation that lacks rerun or correction path
- template styling treated as evidence quality
- generated prose that cannot be traced to source, data, or rule basis
- final report accepted before rendered/readable export proof when the user reads the export

## Engineering Calculation Or Design Tool
Use when equations, standards, units, tolerances, simulation assumptions, operating ranges, or numeric output quality determines acceptance.

Pattern:
- engineering-grounding and mathematical-correctness freeze equations, assumptions, unit path, standards, valid ranges, tolerances, and reference vectors
- product surface separates inputs, parameter defaults, calculation/design core, result explanation, warnings, plots/tables, and export
- invalid range, unit mismatch, and out-of-scope assumptions are visible to the operator
- proof uses reference vectors, boundary cases, and user-surface result inspection

Anti-patterns:
- formula hidden in UI event code
- unit conversion inferred from labels only
- pretty plots that lack numeric oracle
- acceptance based only on error-free execution while calculation correctness is material

## Spreadsheet Migration Tool
Use when a workbook, manual sheet process, or repeated spreadsheet operation becomes software.

Pattern:
- business-workflow extracts source-of-truth, workflow states, mutation authority, reconciliation, and configurable categories
- source sheets map into canonical data structures with validation and import diagnostics
- operator can import representative files, resolve failures, inspect converted records, save, rerun, and export required artifacts
- sheet layout is evidence, not the product structure

Anti-patterns:
- recreating every sheet as a tab while workflow design is absent
- hidden import mapping
- no reconciliation between source totals and converted records
- no representative import failure proof

## Resolve Next Owner And Action
- Return selected pattern family, operator workflow requirements, anti-pattern findings, and proof-oracle candidates to the active work-tool-patterns workflow.
- If a pattern family changes product structure, domain workflow, or acceptance proof, carry the named requirement to the owning planning or lane packet.
