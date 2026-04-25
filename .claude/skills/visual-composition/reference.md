# Reference Material
## Document-Class Visualization Discipline
For document deliverables (plan, report, schedule, proposal), apply document-class rules in addition to general visual standards. Visual type taxonomy ownership: `document-automation` defines domain-specific type selection; `visual-composition` owns render composition evaluation for all types.
### Format, Structure, and Role Rules
**Format Class Gate**: before finalizing layout, declare class — **management-type** (operational control, assignment tracking, logistics) or **explanation-type** (narrative reasoning, instructional exposition). Using explanation-type format for operational control = `format_class_mismatch`. Route format-class disputes to `document-automation` for content-tone aspects; this role owns the layout consequence. Audience-variant rule: when a schedule serves multiple audiences, visual format type (not just density) may differ per audience — unchanged operator-density schedule to participants = candidate `format_class_mismatch`.
**Word/HWP Image Constraints**: single image must not exceed ~one-third of page area; every figure requires descriptive caption; placement must not break surrounding text flow. Violations: `poor_proportion` (oversized) or `weak_hierarchy` (missing caption/broken flow).
**Visual Role Separation**: each visual element must serve exactly one purpose. A table simultaneously acting as schedule, role matrix, and status tracker = role separation violation; split or redesign to single reading task.
### Visual-Type Taxonomy and Composition Standards
**General Visual-Type Role Taxonomy**: **table** = comparison/structured lookup; **graph/chart** = trend, magnitude, or change; **diagram/image** = process flow, structural relationship, or spatial arrangement; **timeline** = continuous-flow or parallel-overlap temporal sequencing; **Gantt chart** = dependency-chain and phased-sequencing schedule. When type doesn't match stated purpose, re-type or remove. Schedule-class decision rule: parallel tracks or dependencies require timeline/Gantt evaluation — table alone fails the justification gate.
**Page Gaze-Path Rule**: no page should contain competing visual elements of equal weight fighting for primary attention. When two or more equal-weight elements appear on the same page, one must be promoted or the other demoted = `weak_hierarchy` defect at page level.
**Semantic Deduplication Gate**: before finalizing any visual, verify it does not restate information already conveyed by adjacent text or another visual on the same surface. A restatement visual = `decorative_noise` or `narrative_redundancy`.
**Density Standards**: short documents (2-3 pages) lean heavier on visuals; medium (~10 pages) target ~5:5 or 6:4 text-to-visual ratio. When benchmark/reference proposals are available, extract concrete density targets (visuals per page, text-to-visual ratio per section type, whitespace budget) and use as calibration inputs overriding defaults; a visual included only to hit density still fails the justification gate.
### Event Planning Document Visual Types
Role-appropriate visual types for operational planning documents; each must pass visualization justification gate before inclusion:
- **schedule tables** — time-sequenced activity grids with responsible party, location, status
- **flow diagrams** — temporal or dependency chains showing event phases and handoffs
- **venue layouts** — spatial arrangement for setup, movement, logistics
- **role matrices** — responsibility assignment (who does what, when, with what authority)
- **movement plans** — participant/resource flow across locations or phases
- **assignment/logistics tables** — assignment tracking (who, what, where, when, status); required when resource assignments are in scope and no other visual tracks them
- **preparation checklists** — binary-completion tracking (item, responsible party, status); required when preparatory tasks exist and no other visual tracks completion
- **Authority-Hierarchy Visual Marking**: assignment tables with authority-hierarchy participants must carry visually distinct row markers (shading, badge, or label). Absent distinct marking = `weak_hierarchy`.
### R&D Proposal Document Visual Types
**development overview** = structural diagram (component relationships or work breakdown); **implementation system** = table/matrix (resource allocation, task assignment, method comparison); **market/expected effects** = comparative diagram (before-after, baseline-target, multi-scenario); **timeline** = Gantt/milestone chart with dependency/phase sequencing. Each must pass the visualization justification gate before inclusion.
### Research Report Visual Types and Quality
Role-appropriate visual types for research reports, technology surveys, patent landscape analyses; each must pass the justification gate:
- **patent/paper distribution map** — temporal/geographic distribution; justified when trend or coverage visibility requires it
- **claim-evidence mapping table** — links claims to source citations and evidence-strength tier; required when report carries 10+ substantive claims
- **competitive positioning map** — two-axis scatter placing entities by relevant dimensions; justified when comparative positioning is a primary reader judgment
- **technology taxonomy diagram** — hierarchical/network diagram of classification relationships; must pass legibility floor when exceeding 12 nodes
- **comparison matrix table** — feature/criterion comparison; justified when 3+ entities on 4+ dimensions
**Research Diagram Legibility Floor**: diagrams with 12+ nodes must pass: minimum readable label size at target viewing distance, no overlapping node labels, edge crossings minimized. Failure = `diagram_text_unreadable`; blocks PASS until redesigned or split.
**Cross-Check Status Visual Marking**: evidence tables and claim-evidence mapping tables must visually distinguish row status using canonical evidence taxonomy. `confirmed` stays explicit; `conflicting` may render as **contested**; `inferred`/`unconfirmed` may group as **unverified** only when legend maps back to canonical statuses. Use shading, icon, or label — not color alone. Absent status marking in a mixed-confirmation table = `weak_hierarchy`.
## Visualization Production Sequence Gate
Visual insertion must occur after the text content draft is reviewable. Premature visual placement — inserting figures before text draft is complete = `render_contract_mismatch` defect; blocks PASS until sequencing corrected.
## Visual Tone for Document-Class Deliverables
This role owns: layout density, spacing, border weight, visual rhythm for document-class deliverables. Content tone (formality, narrative voice, terminology register) belongs to `document-automation`; structure/class rules (section ordering, element inclusion, generation staging) belong to `document-automation`.
For event planning and institutional documents: prefer clean table borders and consistent cell padding; maintain generous inter-section spacing; use border weight and shading sparingly to reinforce hierarchy; keep layout density appropriate for print or screen reading context.
## Surface-Promotion And Decision-Point Extension
For workflow tools, decks, reports, and other human-facing artifacts:
- Promote only task-worthy surfaces to full tabs, pages, or primary regions; demote low-frequency defaults and support settings
- Distinguish master-data maintenance, planning, reconciliation, monitoring, and closeout surfaces visually
- Expose dependency-critical indicators at the decision point (remaining capacity, budget balance, rollover pressure, constrained-planning signals)
- Treat section/surface role drift in documents same as tab role drift in apps; pages without defensible reading task should not stay dense and prominent
Use `HOLD` when promoted surface structure hides critical planning signals or lets low-frequency setup overwhelm primary work.
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
- Keep output readiness visible from upstream surfaces; require stateful novice guidance for first-start, post-import, post-failure, and resume states
### Dashboard Decorative Lobby Anti-Pattern
Dashboard showing only welcome text, feature descriptions, navigation cards, or non-actionable static summaries = `decorative_noise`. Required: (1) current work status (active record count or last modification timestamp), (2) items needing attention (overdue, incomplete, stale), (3) core KPIs with actual values, (4) one-click resume of last workflow. Upgrade losing operational scan capability vs. previous version = blocking regression.
Dashboard design principles: vertical scan > grid scan (full-width stacked areas, no parallel columns for non-comparative data); topmost = most important summary, increasing detail downward; color is semantic only (status/priority, not decoration); dashboard = work surface answering first 3 questions without navigation.
## Operational Management UI Composition Rules
For operational management systems (project dashboards, resource allocation UIs, personnel/budget tools):
- **Card-as-Summary-Entry-Point**: cards contain only identification, period, team summary, budget summary, quick actions. Detail tables, full participant lists, complex forms, or editable calculation UIs inside cards = `poor_proportion`.
- **Positional Consistency**: same-type information fields must occupy same position and style across all repeated elements. Position/style drift across instances = `positional_consistency_violation` (blocking).
- **Responsive Reflow Principle**: responsive means vertical restructure, not shrink. Force-shrinking below readability = blocking. Core information must never be hidden, only repositioned.
- **Merged-Cell Layout Prohibition**: spreadsheet merged-cell layouts in web UI = blocking. Mobile-first designs degrading desktop efficiency (excessive whitespace, single-column on wide screens, hidden controls) = blocking.
### Decorative Clutter Anti-Pattern
Icons, gradients, animations, hover effects, or badges not conveying operational status or priority = `decorative_noise`. Removal test: if removing causes zero operational information loss, it should not exist. Upgrading spartan but functional UI requires before/after scannability measurement; if extracting same operational data requires scanning more elements = regression regardless of aesthetic improvement.
Expert tool UI: button visual weight proportional to interaction frequency; rare destructive actions visually demoted (icon only, show on hover); status indicators must never be styled as buttons; page divisions correspond to workflow boundaries, not database table boundaries.
## Workflow Tool Design Patterns
Canonical patterns for desktop apps, workflow tools, and operator-facing programs.
### Core Design Principles
- Model tasks as **task-state machine**: start, resume, pause, save, import, export, finish
- Treat persistence as **part of the product**; context loss on exit = incomplete workflow
- Support bulk import as **first-class path** (spreadsheet/list source format)
- Reject if tabs/menus/pages don't describe next steps, prerequisite states, or completion states
- Expose final output path early; destination for generated forms/reports/artifacts must be clear
### Local Web App Launcher Requirements
Always apply for local-only web apps (Flask, Node, etc.):
- **Hide server console**: VBS (`WshShell.Run ..., 0`), `pythonw.exe`, etc.
- **Only 1 visible window — the browser**: auto-open after server start, hide all others
- **Auto-terminate server when browser closes**: heartbeat-based watchdog
- **Provide explicit exit button in UI**
- **Disable debug/reloader**: `debug=False`
- **Hide warning messages**: hide technical "development server" warnings
- **Double-click launch**: single file → environment setup → server start → browser open
