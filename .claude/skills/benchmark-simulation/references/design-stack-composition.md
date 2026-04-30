---
PRIMARY-OWNER: developer
LOAD-POLICY: on-demand reference only
---

# benchmark-simulation: Design-Stack Composition Recipes
When deliverable type triggers design-stack composition, follow the phase-aligned recipe. These recipes name which sibling skills compose with benchmark-simulation in each phase.

## Recipe A: Early-Design / Discovery Phase
- `benchmark-simulation`: external evidence + abstraction-fit-adapt synthesis
- `visual-composition`: layout + hierarchy framing for the synthesis output
- `design-system-tokens`: 3-layer token vocabulary (color / spacing / typography) that the layout will use
- output: design synthesis + macro layout + token system, ready for implementation

## Recipe B: Implementation-Bridge Phase
- `mockup-to-component`: 4-step transition from visual design to React component
- composes with token system from Recipe A
- output: implemented components matching synthesis intent

## Recipe C: Post-Implementation Verification Phase
- `dev-workflow` gap-iteration reference (`.claude/skills/dev-workflow/references/gap-iteration.md`): result-level diff between rendered output and synthesis intent
- composes with `tester` lane for execution and `reviewer` for visual blocker findings
- output: gap classification plus iteration plan

## Recipe D: Iteration Phase
- `dev-workflow` gap-iteration findings -> `benchmark-simulation` re-cycle with new evidence
- re-synthesize with the gap as new fit-judgment input
- output: refined design synthesis + re-implementation packet

## Composition Defects To Avoid
- skipping a sibling whose phase is materially active = composition defect
- invoking a sibling whose phase is not active = composition noise
- letting agents improvise composition by habit = composition drift; the dispatching owner must name composition explicitly
