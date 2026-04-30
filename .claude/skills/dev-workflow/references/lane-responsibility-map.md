# dev-workflow: Lane Responsibility Map
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

| Phase | team-lead | researcher | developer | reviewer | tester | validator |
|---|---|---|---|---|---|---|
| 0 Discovery | orchestrate, synthesize | evidence gathering | -- | -- | -- | -- |
| 1 Plan | CP1/CP2, gate check | support if gaps remain | write plan surface | -- | -- | -- |
| 2 Design | CP3, gate check | -- | write design surface | -- | -- | -- |
| 3 Implementation | CP4, gate check, monitor | -- | implement per design | -- | -- | -- |
| 4 Analysis | CP5, gap judgment | -- | provide handoff context | review and gap classification | proof and coverage | final acceptance when required |
| 5 Iteration | cycle tracking, auto-resolution | -- | apply fixes | quick-check | re-verify | final acceptance when still required |

Acceptance chain:
- reviewer -> tester -> validator
- executable, user-facing software enters validator path by default through task-execution routing
