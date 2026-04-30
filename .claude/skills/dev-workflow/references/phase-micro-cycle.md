# dev-workflow: Phase Micro-Cycle
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

Within every active phase, use the same core procedure stack rather than inventing a workflow-local shortcut.
1. `work-planning` freezes the next bounded phase move
2. `SV-PLAN` verifies that move
3. the phase owner executes it directly or routes it through `task-execution`
4. delegated runtime is observed through `session-boot` when agents are active
5. completion-grade outputs return to team-lead
6. team-lead synthesizes the phase surface
7. `SV-RESULT` verifies the synthesized phase result
8. either the phase exit law clears, or the workflow reopens the correct owner/phase

`dev-workflow` adds phase order, checkpoint law, and iteration limits. It does not replace the standard planning, verification, dispatch, monitoring, synthesis, or reporting obligations.
