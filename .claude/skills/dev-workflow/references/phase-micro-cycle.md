# dev-workflow: Phase Micro-Cycle
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

Within every active phase, use the core procedure stack for new phase boundaries or changed work-surface boundaries rather than inventing a workflow-local shortcut.
1. `work-planning` freezes only a new phase boundary or changed work-surface boundary.
2. the phase owner executes it directly or routes it through `task-execution`.
3. delegated runtime is observed through `session-boot` when agents are active.
4. completion-grade outputs return to team-lead.
5. team-lead synthesizes the phase surface.
6. `SV-RESULT` verifies the synthesized phase result.
7. either the phase exit law clears, or the workflow reopens the correct owner/action/phase.

`dev-workflow` adds phase order, checkpoint law, and convergence routing. It does not replace the standard planning, verification, dispatch, monitoring, synthesis, or reporting obligations.
