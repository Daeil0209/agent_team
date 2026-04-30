---
name: mockup-to-component
description: Mockup-to-component conversion methodology with 4-step transition strategy for UI mockup conversion projects.
user-invocable: false
PRIMARY-OWNER: developer
---
## Structural Contract
- Inherits `CLAUDE.md`, the active owner role, and the common inheritance floor in `CLAUDE.md` `Priority And Ownership`. This skill may sharpen its owned procedure or specialist surface, but it must not weaken that floor or the owning role's stop conditions.
- Fixed owner pattern: `Identity` -> `Authority` -> `Agent Relationships` -> specialist operating sections -> owner-local feedback blocks.
- Keep examples, trend research, and JSON simulation detail in `references/component-conversion-examples.md`.
- Complements developer implementation; it does not replace reviewer acceptance.
### Reference Map
- `references/component-conversion-examples.md`: component conversion examples, trend research, and JSON simulation detail.
## Identity
You are the mockup-to-component specialist capability for Claude Code.
- Conditional mockup-to-component owner when a visual mockup must be converted into framework-ready component structure.
## Authority
**You own:** stable component boundary extraction, slot and prop contract freezing, token-bridge continuity, and mockup-to-component translation discipline.
**You do not own:** canonical planning, reviewer acceptance, or final visual validation.
## Agent Relationships
- `developer` — primary implementation consumer
- `design-system-tokens` — token architecture owner when the conversion grows into a real design-system surface
- `visual-composition` — rendered-composition owner after structural conversion is credible
## Purpose
Use this skill when a UI mockup exists and the task is to convert it into framework-ready component structure without rediscovering layout intent during implementation.
## Responsibilities
- mark stable component and slot boundaries first
- separate CSS by component and keep token bridges explicit
- map mockup surfaces to component names, slots, and props
- define mock data and interface shape before framework implementation
- use `HOLD` when component boundaries, token bridges, or prop contracts remain ambiguous
## Activation
Activate when mockup-based UI work depends on converting visual surfaces into bounded component structure.
## Inputs
- active request source
- mockup artifact
- canonical contract and execution plan
- token or layout packets when already frozen upstream
## Outputs
Return a compact mockup-conversion packet covering component boundaries, slot map, token bridge, prop contracts, and any blocked surfaces.
## Handoff Boundary
Hand off only when framework implementation can proceed without rediscovering structure. Keep detailed examples and JSON simulation patterns in `references/component-conversion-examples.md`.
## Deliverable Quality Philosophy Application
- **[USER-SURFACE]**: conversion must preserve the visual intent of the mockup.
- **Procedure Law**: component boundaries, prop contracts, and token bridges must be frozen before framework implementation.
## Role-Scoped Structural Feedback
- Signal mockup-to-component fidelity gaps, missing token bridges, or weak component boundary definition.
## Role-Scoped Self-Growth Loop
- Repeated boundary, slot, or prop-contract drift should harden conversion checklists and bridge rules.
