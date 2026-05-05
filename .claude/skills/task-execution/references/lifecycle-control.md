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

Agents acknowledge non-terminating lifecycle receipt when the decision materially affects active assignment, reuse, standby readiness, or hold-for-validation.
Team-lead sends lifecycle control explicitly after agent completion, reuse decision, or runtime coordination when a non-terminating lifecycle edge must be recorded truthfully.
Shutdown intent is normalized to the structured shutdown protocol below.

Termination form for shutdown specifically:
- Any agent-shutdown intent must be normalized to the structured shutdown protocol.
- Send `SendMessage` with `message: {"type": "shutdown_request"}`.
- During session closeout, team-lead sends this automatically to every live process-backed teammate before `TeamDelete`.
- Routine teardown does not ask the user which idle teammate to stop.
- A free-text lifecycle-control message with `LIFECYCLE-DECISION: shutdown` is a malformed shutdown attempt.
- It records intent only.
- It does NOT terminate the agent process.
- It must be followed immediately by the structured shutdown request.
- `control-ack` from that text message is not termination evidence.
- The agent replies with `{"type": "shutdown_response", "approve": true|false}`.
- On approve, the agent process exits and the harness emits a `teammate_terminated` event.
- Use the free-text `lifecycle-control` form only when the decision is `reuse`, `standby`, or `hold-for-validation`.
- Those decisions do not need protocol-level termination.
- They need only a lifecycle-edge record.
- `TeamDelete` succeeds only after every live process-backed teammate is confirmed terminated.
- Do not treat `control-ack` of a text shutdown as proof of termination.
