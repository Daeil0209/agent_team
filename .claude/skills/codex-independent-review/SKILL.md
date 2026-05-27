---
name: codex-independent-review
description: Run codex CLI background consultation as evidence for planning, artifact convergence, review convergence, final acceptance reconciliation, or bounded checks without replacing frozen scope.
user-invocable: false
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
## Structural Contract
- Handles only the configured independent-review adapter contract.
- Fixed top-level section order: Structural Contract, Identity, Coverage, Purpose, Activation, Reference Map, Inputs, Outputs, Review Workflow, Resolve Next Owner And Action.
- Target-specific review procedure stays with the active reference that opened the review.
- New peer top-level sections require explicit governance review.

## Identity
You are the configured independent-review capability.
Codex CLI is the current tool adapter, not doctrine basis.
The active tool is codex CLI via Bash background invocation when codex consultation is required and available.
Use this skill only through an active path.

## Coverage
Coverage, adjacent boundaries, evidence-only output rule, and non-substitution rule (no block, dispatch, validate, accept, login, file mutation, credential repair, or settings/hook edit) live canonically at `references/concurrent-patterns.md` `## Codex CLI Background Usage (Lane + Team-Lead Variants)` (Authority + Transport Boundary + Authority Non-Substitution).


## Purpose
Provide one reusable Codex MCP independent-review surface for all configured-review consumers.
Keep trigger handling, packet shape, tool discipline, and adjudication consistent across planning, artifact convergence, review convergence, final acceptance, and bounded review targets.
Avoid embedding Codex MCP procedure detail inside `work-planning` or `dev-workflow` consumer documents.

## Activation
Load when the active path opens configured independent review or must record configured-review trigger handling.

**Required triggers** (codex-review consumption is mandatory whenever any axis below applies):
- `work-planning` route freeze must evaluate or record material configured-review trigger handling for `CODEX-INDEPENDENT-REVIEW-BASIS`.
- `ACTIVE-WORKFLOW: dev-workflow` opens configured independent-review handling for Phase 1 planning, Phase 2 design, or material Phase 4/5 reviewer-grade review surfaces.
- Artifact convergence uses `.claude/skills/dev-workflow/references/artifact-convergence-review.md`.
- Review convergence uses `.claude/skills/dev-workflow/references/review-convergence-review.md`.
- Final acceptance reconciliation uses `.claude/skills/dev-workflow/references/final-acceptance-review.md` when that reference opens configured independent review.
- An active reference explicitly opens configured independent review.

**Risk-triggered triggers** (codex-review additionally applies when no Required trigger has already fired but any risk axis below applies):
- `ROUTING-SIGNAL` is `team-routing candidate` or `ambiguous-route`
- lead-local would substitute for a configured lane
- parallel fit affects correctness or bottleneck risk
- team-lead is considering a non-destructive, non-security, non-operator-policy-choice user question instead of a default, parameter, assumption, or evidence route

**Skip semantics** rule 1: "Skip when no risk-triggered axis applies" applies to the Risk-triggered evaluation only.
**Skip semantics** rule 2: this does not skip codex-review when any Required trigger fires.
**Skip semantics** rule 3: record `skipped:no-material-independent-review-trigger:<basis>` in `CODEX-INDEPENDENT-REVIEW-BASIS` only when no Required trigger AND no Risk-triggered trigger applies.
For `ACTIVE-WORKFLOW: dev-workflow`, `skipped:*` is further valid only when no planning, design, material review, risk, route, artifact-convergence, final-acceptance, or workflow boundary is being frozen, revised, or used for advancement.
Pre-`work-planning` external review output is not planning evidence.

## Reference Map
Load only the references whose trigger is active:
- `references/concurrent-patterns.md` before every codex CLI background invocation (lane-internal aid + team-lead-internal aid) — sole canonical codex usage governance owner.
- `references/wp-consult.md` for `WP-CONSULT` route-freeze review.
- `.claude/skills/dev-workflow/references/artifact-convergence-review.md` for artifact convergence review.
- `.claude/skills/dev-workflow/references/review-convergence-review.md` for reviewer-grade convergence review.
- `.claude/skills/dev-workflow/references/final-acceptance-review.md` for final acceptance reconciliation.

## Inputs
- active path and stage
- user goal and target intent basis
- live doctrine and governing references Codex must read
- exact evidence surfaces
- claim, route, convergence, correction, acceptance, or completion decision being checked
- target-specific criteria from the active reference

## Outputs
- `CODEX-INDEPENDENT-REVIEW-BASIS`
- accepted/rejected/deferred/fail-open points
- adjudication basis
- open surfaces and next owner/action

## Review Workflow
1. Confirm the active path opened configured independent review.
2. Load `references/concurrent-patterns.md` for codex CLI background usage governance.
3. Load the target-specific reference.
4. Build a derived configured-review packet from canonical fields and evidence surfaces.
5. Call codex CLI via Bash background invocation under the common tool discipline.
6. Parse the returned JSON.
7. Retry once for first-use connection miss or parse failure when the common contract permits.
8. Record `fail-open:<reason>` after exhausted tool, auth, quota, timeout, config, or parse failure.
9. Adjudicate every valid point against doctrine, user instruction, artifact evidence, proof evidence, acceptance evidence, or frozen request basis.
10. Update only the active planning field, artifact, correction basis, convergence record, acceptance record, blocker basis, or fail-open record.

## Resolve Next Owner And Action
- Planning configured review opens `references/wp-consult.md`.
- Every codex CLI call opens `references/concurrent-patterns.md`.
- Accepted `WP-CONSULT` points update planning fields or blocker basis.
- Accepted non-planning points update the active artifact, correction basis, convergence record, or acceptance record.
- Rejected points record cited doctrine, user instruction, artifact evidence, proof evidence, acceptance evidence, or frozen request basis.
- Codex CLI access failure records `fail-open:<reason>` on the active configured-review record.
- Unadjudicated valid points keep the active path open.
- Unsupported post-route-freeze expansion opens the active `Skill(governance-modification)` path.
