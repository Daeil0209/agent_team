# dev-workflow: Phase Transition Gates
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

Hard gates verified by team-lead before phase advancement or dispatch.

| Transition | Gate Condition |
|---|---|
| Phase 0 -> Phase 1 | discovery output synthesized and verified enough for CP1 |
| Phase 1 -> Phase 2 | Phase 1 closure record exists for the canonical plan artifact with frozen `SCOPE-BASELINE`, CP1 + CP2 resolution, explicit open questions, artifact-convergence advisory status, reconciliation result, accepted high/medium issue state, and next owner action. |
| Phase 2 -> Phase 3 | Phase 2 closure record exists for the design artifact or implementation-binding design bundle with decision-bearing `SCOPE-BASELINE`, CP3 resolution, artifact-convergence advisory status, reconciliation result, accepted high/medium issue state, implementation-binding status, and next owner action. |
| Phase 3 start | CP4 scope, specialist-fit lane decomposition, dependency boundaries, surface-to-agent map, and merge ownership resolved |
| Phase 3 -> Phase 4 | developer handoff includes `OUTPUT-SURFACE`, changed surfaces, checks, `ACTIVE-SLICE`, `SCOPE-BASELINE` coverage/stale rows, and `FROZEN-CONTRACT-STATUS`; if parallel production occurred, one authoritative integrated output surface is routed forward from the frozen `MERGE-OWNER`. |
| Phase 4 -> Phase 2 | CP5 classifies at least one blocking gap as design-level |
| Phase 4 -> Phase 5 | CP5 classifies blocking or significant coverage gap as implementation-level |
| Phase 4/5 -> Complete | Blocking gap state is clear. Every frozen `SCOPE-BASELINE` feature/surface/control is implemented or explicitly deferred by upstream scope. Triggered review convergence is resolved or lawfully failed open with fallback review. Validator-required acceptance chains carry `FINAL-ACCEPT`. |

Additional gate law:
- Phase advancement requires completion-grade evidence, not artifact existence alone
- Carry-forward acceptance evidence is valid only when the original proof matched the same frozen scope, user surface, launch/read path, environment or equivalence basis, and acceptance chain. Otherwise it is stale for the affected surface and must be re-proven, narrowed, or reopened before advancement.
- Phase/workflow completion requires `SCOPE-BASELINE` reconciliation. Evidence over an `ACTIVE-SLICE` cannot be widened into full-scope completion while any frozen baseline item is missing, stubbed, placeholder-only, unproven, or silently deferred.
- Any artifact-advisory fail-open is not advisory resolution; for phase-gate material artifacts it requires conservative `SV-RESULT` plus documented fallback review before advancement
- Any review-convergence fail-open is not Codex agreement; for material review surfaces it requires Claude reviewer synthesis, documented fallback review basis, and `SV-RESULT` before advancement or completion
- For material Phase 4/5 review surfaces, review-convergence trigger status must be explicit. Silent non-trigger, discussion-only Codex output, or unspined Codex calls do not satisfy the gate.
- Phase cursor remains active until consumed by execute, dispatch, HOLD/re-handoff, explicit blocker, or explicit cancel
- When a verified handoff already fixes the next phase boundary, team-lead is the default bridge owner
- A satisfied non-destructive/non-security/non-policy phase gate is not a user-confirmation point; asking "proceed?" or offering "review first?" is cursor-stall, not governance
- Material delivery-surface change supersedes prior reviewer/tester/validator acceptance evidence
- New or sharpened doctrine targeting the active acceptance chain makes affected carry-forward PASS, handoff, or closure evidence stale until `[RETRO-APPLY]` marks it not affected, fixed, owner-deferred, or invalidated.
- A visible user-surface contradiction, unreadable rendered text, partial rendered coverage, missing baseline feature/surface/control, or missing launch/stop path invalidates the affected PASS scope and reopens the smallest correction/acceptance loop; do not ask the user to choose whether to fix it
- Validator PASS opens Final Acceptance Review for validator-required chains.
- Final Acceptance Review uses `final-acceptance-review.md`.
- `FINAL-ACCEPT` opens workflow `Complete`.
- `FINAL-REJECT` opens `task-execution` for validator rejection analysis.
