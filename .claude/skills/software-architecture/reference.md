# Reference Material
## Dependency-And-Field Architecture Extension
For operator-facing workflow tools and document-backed systems:
- Cross-surface dependency graph: facts that unlock/recalculate views, summaries, exports, downstream records
- Explicit separation: manual inputs, imported seeds, editable overrides, derived calculations, locked summaries, exported outputs
- Lifecycle-safe architecture: delete, archive, restore, period rollover, history access
- Automation-ingestion pipelines as first-class contracts for repeated source files
Use `HOLD` when artifact treats derived state as free-form editable or leaves lifecycle/ingestion architecture implicit.
## Coupled-Core Architecture Extension
For tightly coupled workflow cores:
- Model many-to-many relationships explicitly; separate source facts, derived values, posted/closed results, reconciliation evidence into distinct write paths
- Make recalculation, reposting, reopen, adjustment, idempotent rerun boundaries explicit
- Isolate project-type/funding-mode variation in a visible rule path
- **L-07 Entity ID Stability Contract**: Persistent entities require stable immutable identifiers. Array-position-based addressing = defect; ID recycling = defect. Required: UUID or monotonically increasing ID, FK using stable IDs, referential integrity rules (cascade delete/nullify/restrict).
Use `HOLD` when architecture duplicates acceptance-critical facts across sibling stores or relies on hidden project-type assumptions.
## Operational Management Entity Architecture Extension
For operational management systems (project management, resource allocation, personnel tracking, budget control):
- **Core Entity Set Contract**: Define core entities (project, person, assignment, budget, derived cost) before module boundaries.
- **Junction-Entity Separation**: Person-to-project requires first-class junction entity (role, rate, period, status). Direct FK without junction = defect.
- **Mandatory Design Order**: scope definition → entity identification → relationship definition → user work sequence → UI/module boundaries. Screen-first skipping entity modeling = `HOLD`.
Use `HOLD` when module/UI boundaries frozen before core entity set and relationship graph are explicit.
## Workflow-Product Architecture Extension
For dense workflow tools:
- Support inheritance/override resolution: global, project-type, project, period, person, exception scopes
- Support archive/history-safe identity for long-lived master entities and closed periods
- Separate planning, actual, posted, monitoring summary, and export into visible contract layers
- Support freshness and readiness gating for output generation
## Constraint-Satisfaction Document Generator Architecture Extension
For document-structure/quality see `document-automation`; for business rules see `business-workflow`. This section owns pipeline software architecture: phase preconditions, gates, input classification, validation contracts.
### Pipeline Phase Model
Sequential phases; each phase requires predecessor gate to pass. No element selection before purpose resolution; no narrative spine before arrangement; no draft before spine.
1. **Input collection** — hard constraints and soft preferences
2. **Hidden criteria extraction** — surface unstated criteria (Pre-Generation Validation Loop below)
3. **Purpose resolution** — consume `development_target` and `persuasion_axis`; when divergent, narrative spine must demonstrate alignment
4. **Element selection** — from general pool; each element declares constraint implications; post-selection feasibility re-check against all hard constraints required
5. **Arrangement** — sequence for burden, flow, control feasibility; venue-type routes to structural profile (profile owned by `business-workflow`)
6. **Narrative spine resolution** — ordered claim-evidence-consequence chain; gates draft; non-traceable sections flagged for removal
7. **Draft generation** — purpose-to-element justification chains; not gated or partitioned by volume targets
8. **Compression** — redundancy removal; volume/page-count compliance exclusively here
9. **Output validation** — semantic dedup, repeatability scoring, constraint-satisfaction, volume compliance (non-compliance loops to compression only)
10. **Final output** — after all validation gates pass
### Input Contract
Three tiers with override resolution (org defaults < event-type defaults < event-specific overrides):
- **Hard constraints**: venue type, budget ceiling, time window, headcount, logistics. Non-negotiable; gate feasibility.
- **Soft preferences**: culture, decision-maker disposition, formality, interaction style. Shape selection but tradeable.
- **Derived constraints**: participant burden, control feasibility, element appropriateness. Calculated, not directly input.
Stakeholder-priority hierarchy declared in input contract (within-tier conflict resolution, orthogonal to scope-based override). Two required distinct fields: `development_target` (what is built) and `persuasion_axis` (document emphasis); must not be conflated. Page-count/volume targets are output-validation constraints; pre-generation phases must not gate sections by page allocation.
### Pre-Generation Validation Loop
Entry: hard constraints collected, soft preferences at least partial. Generate targeted questions to surface: purpose necessity, element alternatives, burden tolerance, culture fit, control feasibility, repeatability. Completeness gate before advancing to purpose resolution:
- Culture profile: formality level + interaction preference
- Decision-maker preference: approval style + risk tolerance
- Venue type: space category + capacity adequacy
- Logistics: transit mode + time budget
### Output Validation Contract
First-class gates before final delivery:
- **Semantic deduplication**: same factual content in body, tables, and diagrams = flagged; each element must have distinct information role
- **Repeatability scoring**: flag one-time-only designs requiring exceptional preparation as repeatability risks
- **Justification chain verification**: every element traces to resolved purpose; unjustified elements flagged for removal
- **Burden audit**: computed participant burden within tolerance; flag exceedances
- **Autonomous sub-plan detection**: autonomous modules (own data model, constraint set, rendering) must not be flattened into parent structure
- **Volume-target compliance**: non-compliance loops to compression, never to earlier phases
Use `HOLD` when: phase preconditions missing, derived constraints treated as inputs, pre-generation loop absent, or output validation lacks semantic dedup/repeatability gates.
### Research Report Architecture Extensions
- **Search Strategy Engine**: phase between input collection and purpose resolution; decomposes question into concept axes with synonyms; produces per-source-type query plans (academic DB, patent DB, market, standards); outputs structured search spec with inclusion/exclusion filter gate and logged decisions.
- **Multi-Source Pipeline**: each source family (academic paper, patent, market report, technical standard) uses own ingestion schema (metadata, epistemic-role tags, quality-tier); shared normalization → unified claim-evidence records; source-type distinctions preserved through cross-analysis phase.
- **Claim-Strength Validation Gate**: between cross-source analysis and draft; assigns each claim evidence-strength tier (confirmed/supported/inferred/unconfirmed/conflicting); untiered claims hard-blocked; conflicting claims carry both positions with source references.
- **Audit Trail Persistence**: persist search logs, inclusion/exclusion records, and claim-to-evidence mappings in queryable structure with write-point hooks at search execution, filter decision, and claim-evidence linking.
### Schedule-Planning Architecture Extensions
- **Multi-Audience Output Branching**: after compression, derive audience-specific variants from single authoritative schedule model; field-selection rules per audience are architecture contracts.
- **Parallel Resource Conflict Detection Gate**: no double-booking across concurrent slots; runs after arrangement, before draft; hard-blocked, not flagged.
- **Hidden-Time Taxonomy**: extend derived constraints to include setup, teardown, travel time; buffer-placement strategy is arrangement-phase parameter.
- **Version Lifecycle Architecture**: carry version metadata, change attribution, impact-scope markers; latest-version authority resolution must be explicit.
### Result Report Writing Extensions
- **Plan-to-Report Pipeline Variant**: routing (plan-only vs plan+refs) → gap analysis → adaptive depth selection → draft → visualization insertion → compression → output validation.
- **Adaptive Generation Depth (L1-L3)**: L1 = evidence-rich assembly; L2 = partial evidence, guided inference; L3 = plan-only structured reasoning; assigned per section, consumed by draft generation for specificity/hedging calibration.
- **Fabrication Firewall**: forbidden = quantitative metrics/measurements/statistics without source data; permitted = process narrative, expected-effect reasoning, methodology; conditional = explicit reference backing required. Violations hard-blocked.
- **Visualization Insertion Phase**: after draft, before compression; insert where visuals reduce textual burden; record all decisions (inserted/deferred/declined).
- **Reference Image Routing**: classify at input collection (text-only, text+images, images-only); provided images → visualization insertion phase as priority candidates; absence → concept-diagram generation path.
## Specialist Skill Maintainability Extension
- Generate only semantically identical shared blocks from one owner fragment source; commit `SKILL.md` as static directly readable artifact; runtime assembly prohibited
- Keep authority boundaries, domain defect taxonomies, and role-owned judgment rules owner-local; review generated diff as real contract surface before promotion
Use `HOLD` when a maintainability refactor hides the reader-facing skill, removes owner-local safety text, or templates away domain-specific judgment.
