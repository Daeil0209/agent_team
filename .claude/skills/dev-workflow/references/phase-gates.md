# dev-workflow: Phase Transition Gates
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

Hard gates verified by team-lead before phase advancement or dispatch.

| Transition | Gate Condition |
|---|---|
| Phase 0 -> Phase 1 | discovery output synthesized and verified enough for CP1 |
| Phase 1 -> Phase 2 | canonical plan surface exists; CP1 + CP2 resolved |
| Phase 2 -> Phase 3 | design artifact exists; CP3 resolved |
| Phase 3 start | CP4 scope and lane decomposition resolved |
| Phase 3 -> Phase 4 | developer handoff includes changed surfaces, checks, and verification-plan delta |
| Phase 4 -> Phase 2 | CP5 classifies at least one blocking gap as design-level |
| Phase 4 -> Phase 5 | CP5 classifies blocking or significant coverage gap as implementation-level |
| Phase 4/5 -> Complete | no blocking gaps remain, coverage is sufficient, and validator PASS exists when required |

Additional gate law:
- Phase advancement requires completion-grade evidence, not artifact existence alone
- Phase cursor remains active until consumed by execute, dispatch, HOLD/re-handoff, explicit blocker, or explicit cancel
- When a verified handoff already fixes the next phase boundary, team-lead is the default bridge owner
- Material delivery-surface change supersedes prior reviewer/tester/validator acceptance evidence
