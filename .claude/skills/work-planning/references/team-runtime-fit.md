# Work-Planning Team Runtime Fit
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

Official Claude Code team-fit rule: use team-agent runtime when independent teammates need sustained coordination, shared task state, direct teammate messaging, competing perspectives, cross-layer collaboration, or multi-turn lane interaction.

Prefer standalone `Agent` or lead-local only when the agent/lane can return one bounded result without team mailbox/task coordination.

Do not freeze team-agent runtime for sequential chains, same-file edits, many dependency-coupled steps, quick targeted changes, or latency-sensitive work unless the coordination value is explicitly stronger than the overhead and conflict risk.

If the request-visible deliverable already implies a dependent chain across two or more configured lanes, freeze it as team-routed multi-lane work even when the first assignment is one discovery surface. Do not classify the whole route from only the first agent turn.

Team-agent runtime is a coordination capability, not a way to bypass route freeze, owner separation, proof ownership, or acceptance ownership.
