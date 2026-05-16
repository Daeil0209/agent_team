---
PRIMARY-OWNER: task-execution
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
---

# task-execution: Downward Phase-Transition Control Packet
Use a structured phase-transition control packet when a workflow owner advances the shared phase and affected agents must update coordination context, standby readiness, or immediate next-phase coordination without receiving a brand-new bounded assignment yet.

## Validity
- Phase-transition control updates coordination context after a workflow phase cursor advances truthfully.
- Lifecycle state uses lifecycle-control.
- Differing agent impact uses per-agent control.
- Same-segment assignment-grade work replaces phase-transition control for that agent.

Carry:
- `MESSAGE-CLASS: phase-transition-control`
- `PREVIOUS-PHASE`
- `NEXT-PHASE`
- `FEATURE`
- `CONTEXT-ANCHOR`
- `DELIVERY-CONSTRAINT`
- `GATE-STATUS`
- `ACTIVE-AGENTS`
- `BLOCKING-ISSUES`

Agents acknowledge receipt when their active assignment, standby readiness, or immediate next-phase coordination is affected.
Team-lead or the active workflow owner sends this control packet only after the workflow phase cursor is truthfully advanced.

## Resolve Next Owner And Action
- Valid phase movement sends `MESSAGE-CLASS: phase-transition-control` to each affected agent.
- New bounded work opens assignment-grade dispatch.
- Missing truthful phase cursor reopens the workflow owner.
- Differing agent impact opens per-agent control routing.
