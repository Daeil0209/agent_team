---
PRIMARY-OWNER: developer
SOURCE-ANCHOR: .claude/skills/visual-composition/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# Reference Material
## Document-Class Visualization Discipline
For document deliverables (plan, report, schedule, proposal), apply document-class rules in addition to general visual standards. Visual type taxonomy ownership: `document-automation` defines domain-specific type selection; `visual-composition` owns render composition evaluation for all types.
### Format, Structure, and Role Rules
**Format Class Gate**: before finalizing layout, declare class as one of two:
- **management-type**: operational control, assignment tracking, logistics
- **explanation-type**: narrative reasoning, instructional exposition

Rules:
- Using explanation-type format for operational control = `format_class_mismatch`.
- Format-class disputes route to `document-automation` for content-tone aspects.
- This role owns the layout consequence.
- Audience-variant rule: when a schedule serves multiple audiences, visual format type differs per audience when reader job differs.
- Unchanged operator-density schedule to participants = candidate `format_class_mismatch`.
**Word/HWP Image Constraints**:
- Single image must not exceed ~one-third of page area by default unless template, submission, or benchmark evidence justifies another ratio (violation without basis: `poor_proportion`).
- Every figure requires descriptive caption (violation: `weak_hierarchy`).
- Placement must not break surrounding text flow (violation: `weak_hierarchy`).
**Visual Role Separation**: each visual element must serve exactly one purpose. A table simultaneously acting as schedule, role matrix, and status tracker = role separation violation; split or redesign to single reading task.
### Visual-Type Taxonomy and Composition Standards
**General Visual-Type Role Taxonomy**: **table** = comparison/structured lookup; **graph/chart** = trend, magnitude, or change; **diagram/image** = process flow, structural relationship, or spatial arrangement; **timeline** = continuous-flow or parallel-overlap temporal sequencing; **Gantt chart** = dependency-chain and phased-sequencing schedule. When type doesn't match stated purpose, re-type or remove. Schedule-class decision rule: parallel tracks or dependencies require timeline/Gantt evaluation — table alone fails the justification gate.
**Page Gaze-Path Rule**: no page contains competing visual elements of equal weight fighting for primary attention. When two or more equal-weight elements appear on the same page, one must be promoted or the other demoted = `weak_hierarchy` defect at page level.
**Semantic Deduplication Gate**: before finalizing any visual, verify it does not restate information already conveyed by adjacent text or another visual on the same surface. A restatement visual = `decorative_noise` or `narrative_redundancy`.
**Density Standards**:
- Short documents (2-3 pages) lean heavier on visuals when visuals compress decision-relevant information better than text.
- Medium documents (~10 pages) target ~5:5 or 6:4 text-to-visual ratio as default calibration.
- Available benchmark/reference proposals supply concrete density targets (visuals per page, text-to-visual ratio per section type, whitespace budget) as calibration inputs that override defaults.
- A visual included only to hit density still fails the justification gate.
### Event Planning Document Visual Composition Checks
When `document-automation` selects or freezes an event-planning visual type, `visual-composition` checks the rendered role and hierarchy:
- **schedule tables** — verify time-sequenced activity grids carry responsible party, location, and status without overloading another reading task
- **flow diagrams** — verify temporal or dependency chains make event phases and handoffs legible
- **venue layouts** — verify setup, movement, and logistics are spatially inspectable
- **role matrices** — verify responsibility assignment shows who does what, when, and with what authority
- **movement plans** — verify participant/resource flow across locations or phases stays traceable
- **assignment/logistics tables** — verify assignment tracking covers who, what, where, when, and status without duplicating another visual
- **preparation checklists** — verify binary-completion tracking has item, responsible party, and status when selected
- **Authority-Hierarchy Visual Marking**: assignment tables with authority-hierarchy participants must carry visually distinct row markers (shading, badge, or label). Absent distinct marking = `weak_hierarchy`.
### R&D Proposal Document Visual Composition Checks
When `document-automation` selects or freezes an R&D proposal visual, `visual-composition` checks the section role:
- **development overview visuals**: verify structural relationships or work breakdown are inspectable
- **implementation system visuals**: verify resource allocation, task assignment, or method comparison stays table/matrix-readable
- **market/expected effects visuals**: verify before-after, baseline-target, or multi-scenario comparison is legible
- **timeline visuals**: verify dependency/phase sequencing is clear in the selected Gantt or milestone form

Each selected visual must pass the visualization justification gate before visual-ready handoff.
### Research Report Visual Composition Checks
When `document-automation` selects or freezes a research-report, technology-survey, or patent-landscape visual, `visual-composition` checks the visual quality:
- **patent/paper distribution maps** — verify temporal/geographic distribution makes trend or coverage visible
- **claim-evidence mapping tables** — verify claims, source citations, and evidence-strength tiers remain scannable
- **competitive positioning maps** — verify two-axis placement supports the stated comparative reader judgment
- **technology taxonomy diagrams** — verify hierarchical/network classification relationships pass the legibility floor when exceeding 12 nodes
- **comparison matrix tables** — verify feature/criterion comparison remains readable for the selected entity/dimension count
**Research Diagram Legibility Floor**: diagrams with 12+ nodes must pass: minimum readable label size at target viewing distance, no overlapping node labels, edge crossings minimized. Failure = `diagram_text_unreadable`; blocks visual-ready handoff until redesigned or split.
**Cross-Check Status Visual Marking**: evidence tables and claim-evidence mapping tables must visually distinguish row status using canonical evidence taxonomy.
- `confirmed` stays explicit.
- `conflicting` renders as **contested** when a shorter label is needed.
- `inferred`/`unconfirmed` group as **unverified** only when legend maps back to canonical statuses.
- Use shading, icon, or label — not color alone.
- Absent status marking in a mixed-confirmation table = `weak_hierarchy`.
## Visualization Production Sequence Gate
Visual insertion must occur after the text content draft is reviewable. Premature visual placement — inserting figures before text draft is complete = `render_contract_mismatch` defect; blocks visual-ready handoff until sequencing corrected.
## Visual Tone for Document-Class Deliverables
This role owns: layout density, spacing, border weight, visual rhythm for document-class deliverables. Content tone (formality, narrative voice, terminology register) belongs to `document-automation`; structure/class rules (section ordering, element inclusion, generation staging) belong to `document-automation`.
For event planning and institutional documents: prefer clean table borders and consistent cell padding; maintain generous inter-section spacing; use border weight and shading sparingly to reinforce hierarchy; keep layout density appropriate for print or screen reading context.
## Surface-Promotion And Decision-Point Extension
For workflow tools, decks, reports, and other human-facing artifacts:
- Promote only task-worthy surfaces to full tabs, pages, or primary regions; demote low-frequency defaults and support settings
- Distinguish master-data maintenance, planning, reconciliation, monitoring, and closeout surfaces visually
- Expose dependency-critical indicators at the decision point (remaining capacity, budget balance, rollover pressure, constrained-planning signals)
- Treat section/surface role drift in documents same as tab role drift in apps; pages without defensible reading task must not stay dense and prominent
Emit a blocking surface-promotion finding when promoted surface structure hides critical planning signals or lets low-frequency setup overwhelm primary work.
## Workflow-Product Surface Extension
For dense workflow tools, protect operator workflow meaning beyond generic layout quality:
- Home = resume and monitoring console, not decorative landing page; recommend one immediate next action with reason when not at clean done state
- Prefer project-centric or chain-centric planning surfaces when that matches operator planning work better than person-by-person drilling
- Show critical constraints, stale state, and readiness warnings where the operator edits or decides
- Make input semantics visible: planned, actual, imported, derived, override, and locked values distinguishable without instruction
- Make each primary surface explain entry/exit: why here, what gets resolved, where next; keep linked-surface mental model visible
- Require progressive disclosure: novice-safe essentials first, exception-heavy controls secondary
- Make important fields self-explanatory: unit, authority, auto/manual status, blank meaning, override reset path
- Make constraint indicators actionable at editing: current value, calculation basis, likely post-edit effect, correction route
- Treat destructive-action affordances as usability-critical: archive/delete/restore/reset must expose consequence and recovery before commitment
- Design empty, partial, failed-import, and blocked-prerequisite states as first-class surfaces with one clear next action
- Keep output readiness visible from upstream surfaces; require stateful novice instructions for first-start, post-import, post-failure, and resume states
### Dashboard Decorative Lobby Anti-Pattern
Dashboard showing only welcome text, feature descriptions, navigation cards, or non-actionable static summaries = `decorative_noise`.

Required content:
1. current work status (active record count or last modification timestamp)
2. items needing attention (overdue, incomplete, stale)
3. core KPIs with actual values
4. one-click resume of last workflow

Upgrade losing operational scan capability vs. previous version = blocking regression.
Dashboard design principles:
- vertical scan > grid scan: full-width stacked areas, no parallel columns for non-comparative data
- topmost = most important summary, increasing detail downward
- color is semantic only (status/priority), not decoration
- dashboard = work surface answering first 3 questions without navigation
## Operational Management UI Composition Rules
For operational management systems (project dashboards, resource allocation UIs, personnel/budget tools):
- **Card-as-Summary-Entry-Point**: cards contain only identification, period, team summary, budget summary, quick actions. Detail tables, full participant lists, complex forms, or editable calculation UIs inside cards = `poor_proportion`.
- **Positional Consistency**: same-type information fields must occupy same position and style across all repeated elements. Position/style drift across instances = `positional_consistency_violation` (blocking).
- **Responsive Reflow Principle**: responsive means vertical restructure, not shrink. Force-shrinking below readability = blocking. Core information must never be hidden, only repositioned.
- **Merged-Cell Layout Prohibition**: Block spreadsheet-style merged-cell translation in web UI when it obscures data relationships, breaks responsive inspection, hides controls, or forces manual scanning that a structured table, grouped header, or workflow panel should preserve. Block mobile-first layouts when desktop operators lose visible controls, comparison density, or repeated-action efficiency.
### Decorative Clutter Anti-Pattern
Icons, gradients, animations, hover effects, or badges not conveying operational status or priority = `decorative_noise`.
Removal test: if removing causes zero operational information loss, remove it.
Upgrading spartan but functional UI requires before/after scannability measurement.
If extracting same operational data requires scanning more elements = regression regardless of aesthetic improvement.
Expert tool UI:
- button visual weight proportional to interaction frequency
- rare destructive actions visually demoted (icon only, show on hover)
- status indicators must never be styled as buttons
- page divisions correspond to workflow boundaries, not database table boundaries

## Resolve Next Owner And Action
- Return visual defect records, operator-surface rules, composition requirements, and proof needs to the active visual-composition workflow.
- If visual composition changes workflow design, implementation, testing, or validation, carry the named visual requirement to that owner before completion continues.
## Workflow Tool Design Patterns
Canonical patterns for desktop apps, workflow tools, and operator-facing programs.
### Core Design Principles
- Model tasks as **task-state machine**: start, resume, pause, save, import, export, finish
- Treat persistence as **part of the product**; context loss on exit = incomplete workflow
- Support bulk import as **first-class path** (spreadsheet/list source format)
- Reject if tabs/menus/pages don't describe next steps, prerequisite states, or completion states
- Expose final output path early; destination for generated forms/reports/artifacts must be clear
