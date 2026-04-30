---
PRIMARY-OWNER: task-execution
LOAD-POLICY: on-demand reference only
---

# task-execution: Truth Rules
- team-agent runtime creation success = `team exists`
- team-scoped `Agent` or assignment-grade `SendMessage` success = `dispatch pending`
- standalone `Agent` success, if encountered as legacy or accidental host evidence, = synchronous returned result, not team-runtime `dispatch pending`
- `dispatch-ack` = receipt only
- `control-ack` = control receipt only
- `agent started` requires agent-side action or agent-originated progress beyond receipt
- if team-agent operation is frozen and canonical team-existence evidence is absent, the next consequential action is `TeamCreate`; only after team existence is proven may team-scoped `Agent` launch or assignment-grade message create dispatch-pending state
- user-facing output may report only the narrowest proven state
