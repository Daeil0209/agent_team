---
PRIMARY-OWNER: task-execution
LOAD-POLICY: on-demand reference only
---

# task-execution: Downward Lifecycle Control Packet
Use a structured lifecycle control packet when team-lead resolves post-completion or runtime lifecycle state for an agent and no new bounded work is being assigned.

This control packet is:
- not an assignment-grade work packet
- not workflow phase control
- valid only when the agent is not also receiving a new assignment-grade packet in the same execution segment

Carry:
- `MESSAGE-CLASS: lifecycle-control`
- `LIFECYCLE-DECISION`
- `DECISION-BASIS`

Agents acknowledge receipt when the lifecycle decision materially affects their active assignment, standby readiness, or shutdown path.
Team-lead sends lifecycle control explicitly after agent completion, reuse decision, or runtime teardown coordination when the lifecycle edge must be recorded truthfully.

Termination form for `LIFECYCLE-DECISION: shutdown` specifically:
- A free-text lifecycle-control message with `LIFECYCLE-DECISION: shutdown` is a record of the decision; it does NOT actually terminate the agent process. Agents respond to it with `control-ack` and remain alive.
- To actually terminate the agent, send the structured shutdown protocol via `SendMessage` with `message: {"type": "shutdown_request"}`. The agent replies with `{"type": "shutdown_response", "approve": true|false}`; on approve, the agent process exits and the harness emits a `teammate_terminated` event.
- Use the free-text `lifecycle-control` form only when the decision is `reuse`, `standby`, or `hold-for-validation`; those do not need protocol-level termination, only a lifecycle-edge record.
- `TeamDelete` succeeds only after every teammate is confirmed terminated; do not treat `control-ack` of a text shutdown as proof of termination.
