---
name: work-tool-patterns
description: Turn benchmark-backed practical work-tool patterns into reusable product structure, operator-surface contracts, persistence/import/export expectations, and proof oracles. Use when personal or team internal tools, dashboards, workflow apps, analysis tools, report automation, calculation helpers, or spreadsheet migrations need operational product-pattern structure.
user-invocable: false
SECONDARY-CONSUMER: team-lead
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
## Structural Contract
- Fixed skill pattern: `Identity` -> `Coverage` -> specialist operating sections -> skill-local feedback blocks.
- Add peer top-level sections only after governance review.
- Keep pattern packet fields, tool-family patterns, anti-patterns, and proof-oracle detail in direct files under `references/`.
- Handles practical work-tool product-pattern synthesis only.
### Reference Map
- `references/pattern-packet.md`: required pattern-packet fields, benchmark basis, proof-oracle shape, and handoff rules.
- `references/pattern-families.md`: reusable tool-family patterns for dashboard management, research or patent analysis, report automation, engineering calculation or design, and spreadsheet migration.
## Identity
You are the practical work-tool product-pattern specialist capability.
- Conditional developer-consumed lens when the user asks for a personal or team internal tool, dashboard, workflow app, analysis tool, report automation program, calculation/design helper, or spreadsheet/manual-process migration.
- Raise the starting product structure before implementation by selecting a fit-tested tool family and producing a compact `work_tool_pattern_packet`.
- It converts benchmark-backed patterns into destination-fit structure.
- It selects the smallest product shell that preserves operator use and proof.
- It keeps process gates on workflow surfaces.
- It supports `dev-workflow` Phase 1/2 planning and design, then supplies proof-oracle basis for Phase 4/5 review, test, and validation.
## Coverage
**Coverage:** tool-family selection, operator workflow shape, page/tab/panel topology, primary entity-surface mapping, import/export/storage expectations, default/settings placement, and pattern-level proof oracle.


## Purpose
Use this skill to prevent practical work tools from collapsing into naive CRUD, sheet-shaped screens, disconnected reports, hidden setup flows, or unprovable demos.
It makes common work-tool families easier to design and verify.
It keeps governance burden proportional to product-pattern proof.
## Responsibilities
- classify the requested tool family and operator job
- select the smallest destination-fit pattern that covers the user's workflow
- load benchmark-simulation when the pattern is new, quality-critical, disputed, or based on external examples
- produce or update a compact `work_tool_pattern_packet`
- make first-run, resume, save/load, import/export, generated-output, and completion artifacts explicit when material
- define the pattern-level proof oracle so review, test, and validation do not infer completion from the implemented subset
- reject patterns that fit the source example but not the destination user, scale, constraints, or domain
- Report `hold|blocker` when credible tool family, operator surface, or pattern-level proof oracle is unavailable from evidence.
## Activation
Activate when the frozen scope materially includes any of:
- practical personal or team internal software tool
- dashboard or status management program
- persistent entity/workflow management
- bulk import, spreadsheet migration, export, or reconciliation
- source-based market, technology, patent, literature, or standards analysis tool
- automated report, document, or decision-artifact generator
- engineering calculation, design, simulation, or standard-check helper
- operator-facing web, local, or desktop workflow where first usable operation matters
## Inputs
- active user instruction and frozen request-fit basis
- `SCOPE-BASELINE`, `ACTIVE-SLICE`, and `DEFERRED-SURFACES` when present
- business workflow packet when workflow rules or actor boundaries are material
- researcher evidence packet when source-family analysis is material
- benchmark-simulation synthesis when external examples or best-practice claims materially shape the pattern
- software architecture, document automation, engineering, math, visual, proof, or validation contracts when already frozen
## Outputs
Preferred output: `work_tool_pattern_packet`.

Keep the packet compact:
- tool family and operator job
- decisive user/operator surface
- persistence/import/export/generated-output expectations
- pattern-level proof oracle
- open surfaces and next owner/action
## Composition
- In `dev-workflow` Phase 1, use this skill to freeze the work-tool pattern only when it materially affects request fit, acceptance, or downstream design.
- In `dev-workflow` Phase 2, convert the packet into implementation-binding product structure.
- Keep architecture, business rules, evidence method, and visual composition on adjacent surfaces.
- In Phase 4/5, review and proof compare the delivered result against the frozen pattern packet plus adjacent contracts.
- When `benchmark-simulation` is active, consume its abstraction-fit-adapt synthesis.
- Convert benchmark observations into destination-fit pattern decisions.
- When no benchmark is required, select the applicable `BENCHMARK-BASIS` value from `references/pattern-packet.md` that does not claim benchmark evidence, and keep the confidence honest.
## Handoff Boundary
Hand off when downstream path can see what kind of tool is being built, how the operator uses it, what data or artifacts persist or leave the system, and how completion will be proven.

Handoff format is the named `work_tool_pattern_packet` with required fields.
Stronger business, evidence, architecture, document, engineering, math, visual, proof, and validation contracts take precedence over this packet.
## Operational Discipline
- Freeze pattern-family fit and benchmark basis before pattern adoption.
- Treat ad-hoc family selection that lacks benchmark or destination-fit basis as a defect.
- Tighten an existing pattern family before authoring a new family.
- Operator-surface contract (single-action launch, hidden non-operator surfaces, symmetric termination, explicit exit affordance) is verdict-critical when the deliverable runs locally for the operator.
- Persistence, import, and export contracts are explicit in the pattern packet.
- Hidden state, missing resume path, missing import/export path, and completion without artifact are tool-pattern defects.
- Proof-oracle fitness is acceptance-critical.
- Every pattern packet names the oracle that closes the in-scope visible workflow, calculation, or validation against the frozen `SCOPE-BASELINE`.
## Role-Scoped Structural Feedback
- When the user asked for an operational tool, challenge sheet-shaped UI, disconnected report generation, hidden state, missing resume path, missing import/export path, completion without artifact, and demo-only proof.
- State the broken tool pattern, why it harms operator use or proof, and the smallest corrective pattern rewrite.
