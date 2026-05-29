# Work-Planning Execution Readiness
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/work-planning/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
auto-inject: false

`EXECUTION-READINESS-BASIS` is the planning-level readiness contract.
It does not assemble packets or prove results.
It records whether the frozen next owner can execute the next action without re-deriving omitted route, packet, proof, setup, cleanup, parallel, or acceptance facts.

For team-routed or dispatch-capable paths, readiness must cover:
- packet schema floor
- request-bound fields
- lane skill map
- user-surface/proof/tool/setup/run-path/environment fields
- lane work-state and reuse or cleanup readiness
- team-runtime route basis from `team-runtime-fit.md`; use an explicit lead-local evidence-only standalone basis only when no configured lane, assignment-grade lane, independent specialist separation, receipt, reuse, monitoring, or completion handoff is frozen
- parallel grouping with burden-balance basis, or serial reason
- proof owner
- acceptance owner
- setup safety when environment/tool setup is needed: classify the setup as `allowed-setup`, `approval-required`, `defer-capable`, or `blocked`, and do not convert `allowed-setup` into a user choice.

An unknown but material readiness category records the blocker and freezes the smallest blocker-clear owner.
Passing such a gap downstream is forbidden.
Parallel readiness requires cited or self-verification-verified measured burden facts.
Unknown material burden means `blocked:<measurement-owner-and-basis>`, not `ready:*`.

For team-agent runtime paths, readiness also accounts for teammate context isolation.
Teammates receive project context plus the assignment packet, not the lead's conversation history.
Material upstream facts must travel through the packet or an explicit task/workflow state surface.

For lead-local consequential paths, readiness covers the first local item, stop point, required local skills, evidence/proof limit, and whether any independent lane or acceptance owner would be substituted.

A readiness gap that changes owner, phase, deliverable, surface decomposition, staffing shape, proof surface, or acceptance chain is a route problem and reopens `work-planning`.
A gap that stays inside the same frozen owner, phase, surface, deliverable, proof/acceptance chain, and staffing shape is carried as bounded packet-correction or blocker-clear basis for the next owner/action.

An agent tool/evidence-gap request lacking adequate candidate-tool research freezes a bounded `researcher` tool-selection research step before setup.
The exception is when the correct tool is already proven or the route is a proven user-owned blocker.

Allowed setup is bounded, reversible where practical, non-damaging, credential-free, non-paid, and directly needed for the frozen user-surface proof or delivery path.
Standard font packages, browser runtime/cache, and equivalent local tool prerequisites proceed inside that boundary when needed.
Heavyweight installers, persistent services/daemons, credential repair, paid/licensed tools, destructive package actions, or security-setting changes require explicit approval or deferral.

A later local parallel launch mechanism failure allows serial carry-forward only when the failure happens before agent-boundary commitment.
Serial carry-forward also requires the fallback to stay inside the same frozen owner, surface set, deliverable, acceptance chain, and material burden/timing meaning.
Losing the planned parallel path while it changes staffing truth, independent-surface separation, burden, schedule, or closure risk reopens `work-planning` instead of silently collapsing to serial continuation.

## Resolve Next Owner And Action
- Ready basis opens the frozen next owner/action.
- Team-routed ready basis opens `Skill(task-execution)` when no fresh current same-session loaded-and-learned `task-execution` basis exists.
- Team-routed ready basis opens loaded `task-execution` consumption only when fresh same-session `task-execution` basis exists.
- Blocked basis opens the named blocker-clear owner or blocker-routing after internal recovery is exhausted.
- Unknown material readiness category opens blocker-clear or route correction before dispatch.
- Route-changing readiness gap reopens `work-planning`.
- Same-boundary readiness gap opens bounded packet correction or blocker-clear.
- Setup approval need opens explicit approval or deferral path.
- Proven allowed setup opens the setup owner inside the frozen boundary.
