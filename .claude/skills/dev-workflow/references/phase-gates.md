# dev-workflow: Phase Transition Gates
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/dev-workflow/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
auto-inject: false

Hard gates verified by team-lead before phase advancement or dispatch.

| Transition | Gate Condition |
|---|---|
| Phase 0 -> Phase 1 | discovery output synthesized and verified enough for CP1 |
| Phase 1 -> Phase 2 | Phase 1 closure record exists for the canonical plan artifact with frozen `SCOPE-BASELINE`, executable `PRIMARY-OPERATOR-OS`/`ENV-COVERAGE`/`USER-RUN-PATH`/`BURDEN-CONTRACT` when applicable, CP1 + CP2 resolution, explicit open questions, YAGNI scope-review status, artifact-level convergence status, team-lead own-review basis, completed Codex review or fail-open with cited basis and fallback review, point-by-point reconciliation result, accepted high/medium issue state, `Skill(self-verification)` convergence coverage, and next owner/action. |
| Phase 2 -> Phase 3 | Phase 2 closure record exists for the design artifact or implementation-binding internal detail bundle with decision-bearing `SCOPE-BASELINE`, executable operator-delivery implementation contract when applicable, CP3 resolution, verification/correction-readiness basis, artifact-level convergence status, team-lead own-review basis, completed Codex review or fail-open with cited basis and fallback review, point-by-point reconciliation result, accepted high/medium issue state, `Skill(self-verification)` convergence coverage, internal detail bundle status, material specialist contract status when required specialist output shapes implementation/proof/acceptance, and next owner/action. |
| Phase 3 start | team-lead CP4 record translates the Phase 2 implementation-binding internal detail bundle into scope, executable operator-delivery fields when applicable, specialist-fit lane decomposition, first parallel dispatch segment, any later-segment parallel-fit basis, dependency boundaries, surface-to-agent map, merge ownership, and confirms no unresolved design-level gap before implementation dispatch. |
| Phase 3 -> Phase 4 | developer handoff includes `OUTPUT-SURFACE`, changed surfaces, checks, `ACTIVE-SLICE`, `SCOPE-BASELINE` coverage/stale rows, `DESIGN-ROW-IMPL-MATRIX`, and `FROZEN-CONTRACT-STATUS`; executable handoff also carries the produced launcher, `PRIMARY-OPERATOR-OS`, `ENV-COVERAGE`, `USER-RUN-PATH`, `BURDEN-CONTRACT`, `WINDOWS-LAUNCH-SURFACE` when Windows is primary, and blocked or unrun operator-delivery checks; parallel production satisfies the parent `SKILL.md` Phase 3 merge-owner exit law. |
| Phase 4/FAR reject -> Phase 2 | CP5 or validator-authored correction packet classifies at least one blocking gap as design-level under unchanged scope |
| Phase 4/FAR reject -> Phase 4 re-evidence | CP5 or validator-authored correction packet classifies proof/acceptance-chain evidence gap inside unchanged scope, owner map, route, proof chain, and acceptance chain |
| Phase 4/FAR reject -> Phase 5 | CP5 or validator-authored correction packet classifies a blocking or significant gap as implementation or operator-delivery inside the unchanged Phase 1/2 delivery contract |
| Phase 4/5 -> Complete | Blocking gap state is clear. Every frozen `SCOPE-BASELINE` feature/surface/control and every applicable `CORE-WORKFLOW-CLOSURE` row, including executable operator-delivery axes when applicable, is implemented, proven, or covered by a cited deferral authority from the original frozen request/plan/design. Triggered review convergence is resolved or failed open only with cited lawful authority and fallback review. Validator-required acceptance chains carry `FINAL-ACCEPT`. |

Additional gate law:
- Phase advancement requires completion-grade evidence, not artifact existence alone
- Carry-forward acceptance evidence is valid only when the original proof matched the same frozen scope, user surface, launch/read path, environment or equivalence basis, and acceptance chain. Otherwise it is stale for the affected surface and must be re-proven, narrowed, or reopened before advancement.
- Phase/workflow completion requires `SCOPE-BASELINE` reconciliation. Evidence over an `ACTIVE-SLICE` cannot be widened into full-scope completion while any frozen baseline item is missing, stubbed, placeholder-only, unproven, or silently deferred.
- Any artifact convergence fail-open is not Codex review resolution; for phase-gate material artifacts it requires cited fail-open basis, documented fallback review, and conservative `Skill(self-verification)` convergence before advancement
- Route-level `CODEX-INDEPENDENT-REVIEW-BASIS`, developer lane-local `Skill(self-verification)`, discussion-only Codex output, or an unspined Codex call never satisfies artifact-level convergence.
- Missing artifact-level convergence blocks CP user escalation that consumes the artifact, phase advancement, next-phase dispatch, and reporting-law-admitted user-facing prose.
- Any review-convergence fail-open is not Codex agreement; for material review surfaces it requires cited fail-open basis, configured reviewer lane synthesis, documented fallback review basis, and `Skill(self-verification)` convergence before advancement or completion
- For material Phase 4/5 review surfaces, review-convergence trigger status must be explicit. Silent non-trigger, discussion-only Codex output, or unspined Codex calls do not satisfy the gate.
- Phase cursor remains active until consumed by execute, dispatch, blocker-routing/re-handoff, explicit blocker, or explicit cancel
- When a verified handoff already fixes the next phase boundary, team-lead is the default bridge owner
- A satisfied non-destructive/non-security/non-operator-policy-choice phase gate executes its frozen next owner/action in the same execution segment; user-facing "proceed?" or "review first?" prompts are cursor-stall defects
- Material scope, owner-map, deliverable-shape, route, proof-chain, acceptance-chain, or delivery-surface change reopens `work-planning`.
- That reopening supersedes prior reviewer/tester/validator acceptance evidence for affected surfaces.
- New or sharpened doctrine targeting the active acceptance chain makes affected carry-forward PASS, handoff, or closure evidence stale.
- Stale evidence stays stale until `[RETRO-APPLY]` marks it not affected, fixed, invalidated, or deferred by the owning upstream record.
- Visible user-surface contradiction, unreadable rendered text, partial rendered coverage, missing baseline feature/surface/control, or missing launch/stop path invalidates the affected PASS scope.
- Such invalidation reopens the smallest correction/acceptance loop.
- The lead does not ask the user to choose whether to fix it.
- Validator PASS opens Final Acceptance Review closure reconciliation for validator-required chains.
- Final Acceptance Review uses `final-acceptance-review.md`.
- `FINAL-ACCEPT` opens workflow `Complete`.
- `FINAL-REJECT` opens `far-reject-routing` classification; correction or re-evidence dispatch enters `task-execution` after team-lead classification.

## Resolve Next Owner And Action
- Satisfied phase gate executes the frozen next owner/action in the same execution segment.
- Missing gate evidence keeps the phase cursor active.
- Missing artifact convergence opens `artifact-convergence-review`.
- Missing review convergence opens `review-convergence-review`.
- Validator `PASS` opens Final Acceptance Review for validator-required chains.
- `FINAL-ACCEPT` opens workflow `Complete`.
- `FINAL-REJECT` opens `far-reject-routing` classification; correction or re-evidence dispatch enters `task-execution` after team-lead classification.
- Proof/acceptance-chain evidence gap inside unchanged axes opens Phase 4 review/proof/validation re-evidence.
- Boundary-changing gate evidence reopens `work-planning`.
