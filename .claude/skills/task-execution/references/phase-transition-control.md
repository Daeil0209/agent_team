---
PRIMARY-OWNER: task-execution
LOAD-POLICY: on-demand reference only
---

# task-execution: Downward Phase-Transition Control Packet
Use a structured phase-transition control packet when a workflow owner advances the shared phase and affected agents must update coordination context, standby readiness, or immediate next-phase coordination without receiving a brand-new bounded assignment yet.

This control packet is:
- not a replacement for assignment-grade assignment when new bounded work is being assigned
- not a lifecycle-control substitute
- not valid as a broadcast shortcut when individual agent impact differs
- valid only when the affected agent is not also receiving a new assignment-grade packet in the same execution segment

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
Team-lead or the active workflow owner may send this control packet only after the workflow phase cursor is truthfully advanced.
