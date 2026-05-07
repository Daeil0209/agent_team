# dev-workflow: Lane Responsibility Map
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

| Phase | team-lead | researcher | developer | reviewer | tester | validator |
|---|---|---|---|---|---|---|
| 0 Discovery | orchestrate, synthesize | evidence gathering | -- | -- | -- | -- |
| 1 Plan | own planning design, CP1/CP2, gate check, convergence | support if gaps remain | write plan document from frozen team-lead/workflow design basis | -- | -- | -- |
| 2 Design | own selected design direction, CP3, gate check, convergence | -- | write design document from frozen team-lead/workflow design basis | -- | -- | -- |
| 3 Implementation | freeze CP4 from Phase 2 contract, gate check, monitor | -- | implement per CP4/design contract | -- | -- | -- |
| 4 Analysis | CP5, gap judgment | -- | provide handoff context | review and gap classification | proof and coverage | validator verdict when required |
| 5 Iteration | cycle tracking, auto-resolution | -- | apply fixes | quick-check | re-verify | fresh validator verdict when still required |

Lane evidence chain:
- reviewer evidence + tester proof -> validator PASS
- validator PASS opens Final Acceptance Review; validator-required workflow `Complete` requires `FINAL-ACCEPT`
- executable, user-facing software enters validator path by default through task-execution routing
- executable completion traces every frozen `SCOPE-BASELINE` feature/surface/control and operator launch/termination contract through developer implementation, reviewer conformance, tester proof, and validator verdict
