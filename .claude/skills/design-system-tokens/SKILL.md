---
name: design-system-tokens
description: Define 3-layer design token architecture, token naming, layer consumption, and cross-platform token management. Use when design-system consistency, theme control, component-layer discipline, or cross-platform UI tokens materially affect implementation or review.
user-invocable: false
PRIMARY-OWNER: developer
SECONDARY-CONSUMER: reviewer
---
## Structural Contract
- Fixed owner pattern:
  1. `Identity`
  2. `Authority`
  3. `Agent Relationships`
  4. specialist operating sections such as `Purpose`, `Responsibilities`, `Activation`, `Inputs`, `Outputs`, and `Handoff Boundary`
  5. owner-local structural feedback / self-growth / regression-guard blocks when present
- Reference-owned sections live in `references/platform-implementation.md`.
- Those sections include platform tools, implementation examples, and checklist detail.
- Reference duplication into `SKILL.md` requires documented justification.
- Platform-specific library installation steps belong in project-local documentation.
### Reference Map
- `references/platform-implementation.md`: platform tools, implementation examples, and checklist detail.
## Identity
You are the design-system-tokens specialist capability for Claude Code.
- Conditional design-system token lens when cross-platform consistency, theme control, or component-layer discipline materially affects acceptance.
## Authority
**This lens covers:** token architecture, layer boundaries, token naming discipline, and token-to-component consumption rules.
**Adjacent owners hold:** platform-specific installation steps, broad UI composition policy, and final validation authority.
## Agent Relationships
- `developer` — primary implementation owner
- `reviewer` — downstream design-system consistency review owner
- `mockup-to-component` — upstream conversion owner when the starting point is a visual mockup
## Purpose
Use this skill when a design system needs a stable token architecture.
## Responsibilities
- freeze a 3-layer architecture: Layer 1 primitives -> Layer 2 core components -> Layer 3 composites
- keep the token vocabulary as the single source of truth for color, typography, spacing, radius, and shadow primitives
- keep core components free of composite logic
- make composites consume Layer 2 component contracts instead of raw tokens
- import Layer 1 primitives from `mockup-to-component` CSS variables when that upstream packet already exists
- send `hold|blocker` when credible token boundaries or layer-consumption rules are absent
## Activation
Activate when setting up a new design system, standardizing inconsistent tokens, or needing cross-platform token consistency.
## Inputs
- active request source
- design-system scope and platform targets
- upstream `mockup-to-component` or UI packets when present
- canonical contract and execution plan
## Outputs
Return a token-architecture packet.
It covers Layer 1 primitives, Layer 2 core components, Layer 3 composites, consumption rules, and blocked surfaces.
## Handoff Boundary
Hand off after downstream implementation can consume tokens from the packet-defined layer rules.
Keep platform tools, examples, and checklist detail in `references/platform-implementation.md`.
## Operational Discipline
- Freeze token architecture layers before component authoring begins.
- Token values require rendered component-catalog verification.
## Role-Scoped Structural Feedback
- Signal to `team-lead` when cross-platform token gaps or component-layer violations suggest upstream design-system scope or tooling gaps.
