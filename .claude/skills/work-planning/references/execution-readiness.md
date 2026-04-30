# Work-Planning Execution Readiness
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

`EXECUTION-READINESS-BASIS` is the planning-level readiness contract. It does not assemble packets or prove results. It records whether the frozen next owner has enough basis to act without re-deriving omitted route, packet, proof, setup, lifecycle, parallel, or acceptance facts.

For team-routed or dispatch-capable paths, readiness must cover:
- packet schema floor
- request-bound fields
- lane skill map
- user-surface/proof/tool/setup/run-path/environment fields
- lifecycle debt visibility
- parallel grouping or serial reason
- proof owner
- acceptance owner

If any category is unknown but material, record the blocker and freeze the smallest blocker-clear owner instead of passing the gap downstream.

For team-agent runtime paths, readiness must also account for teammate context isolation. Teammates receive project context plus the assignment packet, not the lead's conversation history. Material upstream facts must travel through the packet or an explicit task/workflow state surface.

For lead-local consequential paths, readiness must cover the first local item, stop point, required local skills, evidence/proof limit, and whether any independent lane or acceptance owner would be substituted.

A readiness gap that changes owner, phase, deliverable, surface decomposition, staffing shape, proof surface, or acceptance chain is a route problem and reopens `work-planning`. A gap that stays inside the same frozen owner, phase, surface, deliverable, proof/acceptance chain, and staffing shape may be carried as bounded packet-correction or blocker-clear basis for the next owner.

If an agent tool/evidence-gap request lacks adequate candidate-tool research, freeze a bounded `researcher` tool-selection research step before setup unless the correct tool is already proven or the route is a user-facing blocker.

If a later local parallel launch mechanism fails, serial carry-forward is lawful only when the failure happens before agent-boundary commitment and the fallback stays inside the same frozen owner, surface set, deliverable, acceptance chain, and material burden/timing meaning. If losing the planned parallel path changes staffing truth, independent-surface separation, burden, schedule, or closure risk, reopen `work-planning` instead of silently collapsing to serial continuation.
