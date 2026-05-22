---
name: design-system-tokens
description: Define 3-layer design token architecture, token naming, layer consumption, and cross-platform token management. Use when design-system consistency, theme control, component-layer discipline, or cross-platform UI tokens materially affect implementation or review.
user-invocable: false
SECONDARY-CONSUMER: reviewer
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
## Structural Contract
- Fixed skill pattern:
  1. `Identity`
  2. `Coverage`
  3. specialist operating sections such as `Purpose`, `Responsibilities`, `Activation`, `Inputs`, `Outputs`, and `Handoff Boundary`
  4. skill-local structural feedback / governance modification / regression-guard blocks when present
- Reference detail sections live in `references/platform-implementation.md`.
- Those sections include platform tools, implementation examples, and checklist detail.
- Reference duplication into `SKILL.md` requires documented justification.
- Platform-specific library installation steps belong in project-local documentation.
### Reference Map
- `references/platform-implementation.md`: platform tools, implementation examples, and checklist detail.
## Identity
You are the design-system-tokens specialist capability.
- Conditional design-system token lens when cross-platform consistency, theme control, or component-layer discipline materially affects acceptance.
## Coverage
**Coverage:** token architecture, layer boundaries, token naming discipline, and token-to-component consumption rules.
**Adjacent boundaries:** platform-specific installation steps, broad UI composition policy, and final validation.

## Purpose
Load when a design system needs a stable token architecture.
## Responsibilities
- freeze a layered token architecture with a primitive token layer (color/typography/spacing/radius/shadow), an application-level consumption layer (components or aliases), and a documented inheritance rule from primitives to consumers
- expand to 3 layers (primitives -> core components -> composites) as the default when finer granularity is not required
- keep the token vocabulary as the single source of truth for color, typography, spacing, radius, and shadow primitives
- keep core components free of composite logic
- make composites consume Layer 2 component contracts instead of raw tokens
- import Layer 1 primitives from `mockup-to-component` CSS variables when that upstream packet already exists
- Report `hold|blocker` when:
  - credible token boundaries are absent
  - credible layer-consumption rules are absent
## Activation
Activate when setting up a new design system, standardizing inconsistent tokens, or needing cross-platform token consistency.
## Inputs
- active request source
- design-system scope and platform targets
- upstream `mockup-to-component` or UI packets when present
- canonical contract and execution plan
## Outputs
Capture only the decisive token packet:
- Layer 1 primitives
- Layer 2 core components
- Layer 3 composites
- consumption rules
- blocked surfaces and next owner/action
## Handoff Boundary
Hand off after downstream implementation can consume tokens from the packet-defined layer rules.
Keep platform tools, examples, and checklist detail in `references/platform-implementation.md`.
## Operational Discipline
- Freeze token architecture layers before component authoring begins.
- Token values require rendered component-catalog verification.
## Role-Scoped Structural Feedback
- Signal to `team-lead` when cross-platform token gaps or component-layer violations suggest upstream design-system scope or tooling gaps.
