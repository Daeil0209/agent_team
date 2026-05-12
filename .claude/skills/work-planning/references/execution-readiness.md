# Work-Planning Execution Readiness
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/work-planning/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
auto-inject: false

`EXECUTION-READINESS-BASIS` is the planning-level readiness contract. It does not assemble packets or prove results. It records whether the frozen next owner can execute the next action without re-deriving omitted route, packet, proof, setup, lifecycle, parallel, or acceptance facts.

For team-routed or dispatch-capable paths, readiness must cover:
- packet schema floor
- request-bound fields
- lane skill map
- user-surface/proof/tool/setup/run-path/environment fields
- lifecycle debt visibility
- parallel grouping with burden-balance basis, or serial reason
- proof owner
- acceptance owner
- setup safety when environment/tool setup is needed: classify the setup as `allowed-setup`, `approval-required`, `defer-capable`, or `blocked`, and do not convert `allowed-setup` into a user choice.

If any category is unknown but material, record the blocker and freeze the smallest blocker-clear owner instead of passing the gap downstream.
Parallel readiness requires cited or SV-verified measured burden facts; unknown material burden means `blocked:<measurement-owner-and-basis>`, not `ready:*`.

For team-agent runtime paths, readiness must also account for teammate context isolation. Teammates receive project context plus the assignment packet, not the lead's conversation history. Material upstream facts must travel through the packet or an explicit task/workflow state surface.

For lead-local consequential paths, readiness must cover the first local item, stop point, required local skills, evidence/proof limit, and whether any independent lane or acceptance owner would be substituted.

A readiness gap that changes owner, phase, deliverable, surface decomposition, staffing shape, proof surface, or acceptance chain is a route problem and reopens `work-planning`. A gap that stays inside the same frozen owner, phase, surface, deliverable, proof/acceptance chain, and staffing shape is carried as bounded packet-correction or blocker-clear basis for the next owner/action.

If an agent tool/evidence-gap request lacks adequate candidate-tool research, freeze a bounded `researcher` tool-selection research step before setup unless the correct tool is already proven or the route is a proven user-owned blocker.

Allowed setup is bounded, reversible where practical, non-damaging, credential-free, non-paid, and directly needed for the frozen user-surface proof or delivery path. Standard font packages, browser runtime/cache, and equivalent local tool prerequisites proceed inside that boundary when needed. Heavyweight installers, persistent services/daemons, credential repair, paid/licensed tools, destructive package actions, or security-setting changes require explicit approval or deferral.

If a later local parallel launch mechanism fails, serial carry-forward is lawful only when the failure happens before agent-boundary commitment and the fallback stays inside the same frozen owner, surface set, deliverable, acceptance chain, and material burden/timing meaning. If losing the planned parallel path changes staffing truth, independent-surface separation, burden, schedule, or closure risk, reopen `work-planning` instead of silently collapsing to serial continuation.

## Resolve Next Owner And Action
- Ready basis opens the frozen next owner/action.
- Team-routed ready basis opens `task-execution`.
- Blocked basis opens the named blocker-clear owner or `HOLD`.
- Unknown material readiness category opens blocker-clear or route correction before dispatch.
- Route-changing readiness gap reopens `work-planning`.
- Same-boundary readiness gap opens bounded packet correction or blocker-clear.
- Setup approval need opens explicit approval or deferral path.
- Proven allowed setup opens the setup owner inside the frozen boundary.
