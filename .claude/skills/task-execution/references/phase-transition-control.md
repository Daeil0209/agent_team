---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# task-execution: Downward Phase-Transition Packet
Use a structured phase-transition packet when a workflow owner advances the shared phase and affected agents must update coordination context, standby readiness, or immediate next-phase coordination without receiving a brand-new bounded assignment yet.

## Validity
- Phase-transition updates coordination context after a workflow phase cursor advances truthfully.
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
- `PHASE-ADVANCE-BASIS`
- `UPSTREAM-DECISION-BASIS`
- `OPEN-SURFACES`
- `NEXT-COORDINATION-ACTION`
- `ACTIVE-AGENTS`
- `BLOCKING-ISSUES`
- `RETAINED-CARRIER-PATH` when phase evidence or receiver-required context is too large for the packet

Affected agents consume phase context without user-facing report; new bounded work uses an assignment-grade packet and normal `dispatch-ack`.
Team-lead or the active workflow owner sends this packet only after the workflow phase cursor is truthfully advanced.

## Resolve Next Owner And Action
- Valid phase movement sends `MESSAGE-CLASS: phase-transition-control` to each affected agent.
- New bounded work opens assignment-grade dispatch.
- Missing truthful phase cursor reopens the workflow owner.
- Differing agent impact opens per-agent control routing.
