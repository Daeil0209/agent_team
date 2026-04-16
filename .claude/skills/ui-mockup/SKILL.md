---
name: ui-mockup
description: Mockup-to-component conversion methodology with 4-step transition strategy for UI mockup conversion projects.
user-invocable: false
---

PRIMARY-OWNER: developer

# ui-mockup Skill

## Structural Contract
- Section order: local sections `Activation Criteria` → `4-Step Mockup → Component Strategy` → `Deliverables Checklist` → owner-local feedback blocks. Reference-owned detail sections are `Transition Example`, `UI/UX Trend Research`, and `JSON Data Simulation`.
- PRIMARY-OWNER: developer | SECONDARY-CONSUMER: reviewer (mockup-to-component quality review)
- Complement note: extends developer lane capability; does not replace reviewer acceptance gate.

## Activation Criteria
Load this skill when a UI mockup exists and component conversion to a framework is needed.

**Backup authorization (team-lead directed):**
```
SKILL-AUTH: lane=developer:<lane-id>; surface=ui-mockup-conversion; skill=ui-mockup
```

## 4-Step Mockup → Component Strategy

### Step 1: HTML Structure in Component Units
Mark component boundaries with `data-component` and `data-slot` attributes for direct mapping to framework components.

> For Step 1 HTML structure example, see reference.md


### Step 2: CSS Separated by Component
Mirror the future component structure. CSS variables in `base/variables.css` serve as the design token bridge.

> For Step 2 CSS structure example, see reference.md

> Cross-reference: `variables.css` CSS custom properties become Layer 1 tokens in the `design-token` skill.

### Step 3: Component Mapping Document

> For Step 3 Component Mapping table example, see reference.md

### Step 4: Data Structure as Props
JSON mock files define the prop contract; each JSON key maps to a typed interface field.

> For Step 4 data/interface examples, see reference.md



> For Transition Example, see reference.md

> For UI/UX Trend Research, see reference.md

> For JSON Data Simulation, see reference.md


## Deliverables Checklist
- [ ] HTML component units with `data-component` / `data-slot` attributes throughout
- [ ] CSS organized by component; `variables.css` defines the design token bridge
- [ ] JSON mock data files created (one file per data domain)
- [ ] Component mapping document complete (mockup file → component name → props)
- [ ] TypeScript interfaces drafted from JSON mock structure
- [ ] UI research: 3+ references collected, palette and typography decisions recorded

## Deliverable Quality Philosophy Application

Role-specific application of CLAUDE.md Deliverable Quality Philosophy principles:

- P6 Visualization: Mockup-to-component conversion must preserve visual intent — component boundaries, slot definitions, and design token mappings must result in a rendered output that matches the original mockup layout and palette.
- P3 Structure: Component structure (data-component boundaries, prop contracts, CSS variable layer) must be defined before framework implementation begins. Conversion without frozen component structure = P3 violation.

## Role-Scoped Self-Growth Loop

- Track repeated conversion quality defects (broken component boundaries, missing prop types, CSS variable drift from mockup palette) across sessions.
- When the same defect class recurs, escalate to team-lead as a capability-gap signal for checklist or boundary hardening.

## Structural Feedback To Upstream

- Signal to team-lead when design-implementation fidelity gaps (repeated mockup-to-component visual mismatch, missing token cross-references) suggest upstream design handoff or tooling gaps.
