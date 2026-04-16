---
name: design-token
description: 3-layer design token architecture with cross-platform token management for design system projects.
user-invocable: false
---

PRIMARY-OWNER: developer

# Design Token Skill

## Structural Contract

- Fixed top-level section order: Activation Criteria -> Why Design Tokens -> 3-Layer Architecture -> Deliverable Quality Philosophy Application -> Role-Scoped Self-Growth Loop -> Structural Feedback To Upstream
- Reference-owned sections: platform tools, implementation examples, and checklist live in `reference.md`; do not duplicate them into `SKILL.md` without documented justification.
- PRIMARY-OWNER: developer (design system implementation and token authoring)
- SECONDARY-CONSUMER: reviewer (design system consistency review)
- Complement note: this skill governs token architecture methodology; platform-specific library installation steps belong in project-local documentation, not this skill.

## Activation Criteria

Load this skill when any of the following apply:
- Setting up a new design system from scratch
- Standardizing inconsistent tokens across an existing codebase
- Needing cross-platform token consistency (web + mobile + native)

**Backup authorization (team-lead directed):**
```
SKILL-AUTH: lane=developer:<lane-id>; surface=design-system-token-architecture; skill=design-token
```

**dev-workflow context**: This skill is loaded during Phase 2 (Design) and Phase 3 (Implementation) of the `dev-workflow` for design system work.

**Cross-skill note**: If `ui-mockup` skill was used, its Step 2 CSS variable definitions become Layer 1 tokens in this skill's 3-layer architecture. Import those variables as the starting token set rather than redefining from scratch.

## Why Design Tokens

| Problem | Token-Driven Solution |
|---------|----------------------|
| Inconsistent colors across screens | Single source of truth for all color values |
| Hard-coded spacing everywhere | Named spacing scale consumed by all components |
| Typography mismatch between platforms | Font tokens shared via platform conversion pipeline |
| Theme changes require find-and-replace | Change one token value, all consumers update |
| Designer-developer handoff errors | Token names serve as shared design vocabulary |

## 3-Layer Architecture

```
┌─────────────────────────────────────────────────────┐
│  Layer 1: Design Tokens                              │
│  Color, Typography, Spacing, Radius, Shadow          │
│  (raw named primitives — no component logic)         │
├─────────────────────────────────────────────────────┤
│  Layer 2: Core Components                            │
│  Button, Input, Card, Dialog, Avatar, Badge          │
│  (atomic UI; consumes tokens; exposes variants)      │
├─────────────────────────────────────────────────────┤
│  Layer 3: Composite Components                       │
│  Form, DataTable, Navigation, SearchBar              │
│  (assembled from core components; carries behavior)  │
└─────────────────────────────────────────────────────┘
```

**Key rule**: each layer references only the layer immediately below it. Composite components must not import raw tokens directly; core components must not embed composite logic.

> For platform implementation tools, CSS/Tailwind/JSON token examples, and design system checklist, see reference.md

## Deliverable Quality Philosophy Application

Role-specific application of CLAUDE.md Deliverable Quality Philosophy principles:

- P3 Structure: Token architecture layers (Layer 1 primitives → Layer 2 core components → Layer 3 composites) must be defined before component authoring begins. Tokens added ad hoc without a frozen layer structure = P3 violation.
- P6 Visualization: Token values must be visually verifiable — colors, spacing, and radius tokens should be reviewable in a rendered component catalog, not only in source files.

## Role-Scoped Self-Growth Loop

- Track repeated token consistency defects (cross-platform value drift, layer boundary violations, missing dark-mode overrides) across sessions.
- When the same defect class recurs, escalate to team-lead as a capability-gap signal for checklist or boundary hardening.

## Structural Feedback To Upstream

- Signal to team-lead when cross-platform token gaps or component-layer violations suggest upstream design system scope or tooling gaps.
