# Work-Planning Team Runtime Fit
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

Team operating rule: additional-agent lane work uses `TeamCreate` plus team-scoped `Agent`.

Standalone `Agent` is not configured lane dispatch.

Do not create additional agents for sequential chains, same-file edits, many dependency-coupled steps, quick targeted changes, or latency-sensitive single-surface work unless team-lane value is explicitly stronger than the overhead and conflict risk.

If the request-visible deliverable already implies a dependent chain across two or more configured lanes, freeze it as team-routed multi-lane work even when the first assignment is one discovery surface. Do not classify the whole route from only the first agent turn.

Team-agent runtime is not a way to bypass route freeze, owner separation, proof ownership, or acceptance ownership.
