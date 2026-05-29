---
PRIMARY-OWNER: developer
SOURCE-ANCHOR: .claude/skills/document-automation/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# document-automation: Event Planning Documents
Use when document mode is institutional event planning, including retreats, workshops, ceremonies, team-building, and training camps.

## Pre-Generation Gate
- Before generation, freeze purpose type.
- Purpose type examples include education-focused, cohesion-focused, performance-sharing, morale, and hybrid.
- Freeze target participant response.
- Freeze approval-path logic and format constraints.
- Freeze atmosphere/mood type as a separate intake axis from purpose type.
- Atmosphere/mood examples include calm exchange, light relaxation, active socializing, seminar-included, and hybrid.
- When participant power is asymmetric, senior authority preferences are hard constraints.
- General participant preferences are soft constraints after authority constraints are satisfied.
- Begin element selection after purpose type, target response, and approval path are frozen.

## Element-To-Region Selection
- Document regions derive from the `business-workflow` element model.
- `business-workflow` owns element entity model, definitions, constraints, and institutional norms.
- Consume the business-workflow element model before selecting document regions.
- Each included element requires a purpose-link justification.
- Each excluded element requires brief rationale.
- Include only purpose-justified regions.
- When transport mode is personal vehicles, promote transport to an independent major section.
- Personal-vehicle transport requires a structured vehicle-allocation table.
- Vehicle-allocation table fields include driver, passengers, route, and departure time.
- When mandatory elements impose venue-level physical requirements, use operational-feasibility criteria.
- Operational-feasibility criteria include equipment, space layout, fire safety, and weather exposure.

## Generation Stage Sequence
1. Purpose/audience/constraints intake: freeze purpose type, participant profile, venue constraints, budget envelope, institutional culture norms, and approval path.
2. Full element enumeration with necessity checks: apply `why needed / removable / simpler alternative` check per element.
3. Logical dependency and sequence design: arrange elements respecting temporal dependencies, participant energy curve, logistics transitions, and venue constraints.
4. Compression preserving rationale chain: fit to target length while preserving necessity justifications and removing elements rejected by business-workflow gates.
- Between stages 1 and 2, classify venue type.
- Venue type examples include retreat/relaxation, gathering facility, urban facility, and outdoor/camping.
- Venue type cascades into preset adjustments to schedule density, free-time allocation, collective-vs-individual time ratio, and meal operation mode.

## Participant Burden Constraints
- Treat fatigue, concentration rhythm, logistics complexity, transition overhead, and post-meal energy as hard realism constraints.
- Use conservative defaults when thresholds are missing.
- Conservative defaults include short focused sessions with breaks, protected transitions, lighter content after meals, and progressive intensity reduction across multi-day events.
- Schedules violating these constraints mark a blocked feasibility state with correction owner/action.

## Visual Inclusion For Event Documents
- Candidate types include schedule/timetable tables, process flow diagrams, venue layout maps, role/responsibility matrices, budget allocation charts, and participant journey maps.
- Apply semantic duplication check before including any visual.
- Rendered composition quality belongs to `visual-composition`.

## Tone And Repeatability
- Tone is formal enough for approval circulation.
- Operational instructions remain unambiguous.
- Rationale-first writing outranks embellishment.
- Finalization checks reusable structure for the next similar event.
- Finalization checks operational complexity against practitioner capacity.
- Failed finalization check opens simplification or execution-instruction revision.

## Resolve Next Owner And Action
- Return pre-generation gate state, element decisions, venue cascade, participant-burden constraints, visual inclusion basis, and finalization check to the active document-automation workflow.
- If event element rules or institutional norms are missing, route to `business-workflow` before event document generation continues.
