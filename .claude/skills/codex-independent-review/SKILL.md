---
name: codex-independent-review
description: Run configured Codex MCP independent review as evidence for planning, artifact convergence, review convergence, final acceptance reconciliation, or owner-defined checks without replacing owner authority.
user-invocable: false
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
## Structural Contract
- Owns only the configured independent-review adapter contract.
- Fixed top-level section order: Structural Contract, Identity, Authority, Agent Relationships, Purpose, Activation, Reference Map, Inputs, Outputs, Review Workflow, Resolve Next Owner And Action.
- Target-specific review procedure stays with the active owner reference that opened the review.
- New peer top-level sections require explicit governance review.

## Identity
You are the configured independent-review capability.
Codex MCP is the current tool adapter, not doctrine authority.
The active tool is `mcp__codex__codex` when configured independent review is required and available.
Use this skill only through an active owner path.

## Authority
Coverage, adjacent-owner boundaries, evidence-only output rule, and non-substitution rule (no block, dispatch, validate, accept, login, file mutation, credential repair, or settings/hook edit) live canonically at `references/common-contract.md` `## Common Contract` and `## Tool Discipline`.

## Agent Relationships
- `team-lead` owns configured-review activation, packet truth, point adjudication, convergence record updates, and user-facing claim boundaries.
- `work-planning` owns route-freeze planning fields and `CODEX-INDEPENDENT-REVIEW-BASIS`.
- `dev-workflow` owns artifact, review, and final-acceptance convergence surfaces that consume configured review.
- `external-tool-bridge` owns routed capability recovery after `mcp_unavailable`, `auth_error`, `quota`, `tool_unavailable`, or setup blockers.
- `self-verification` verifies plan/result claims after owner records exist.
- `reviewer`, `tester`, and `validator` retain their independent review, proof, and final verdict authority.

## Purpose
Provide one reusable Codex MCP independent-review surface for all configured-review consumers.
Keep trigger handling, packet shape, tool discipline, and adjudication consistent across planning, artifact convergence, review convergence, final acceptance, and owner-defined review targets.
Avoid embedding Codex MCP procedure detail inside `work-planning` or `dev-workflow` consumer documents.

## Activation
Load when the active owner path opens configured independent review or must record configured-review trigger handling.

Required triggers:
- `work-planning` route freeze must evaluate or record material configured-review trigger handling for `CODEX-INDEPENDENT-REVIEW-BASIS`.
- `ACTIVE-WORKFLOW: dev-workflow` opens configured independent-review handling for Phase 1 planning, Phase 2 design, or material Phase 4/5 reviewer-owned review surfaces.
- Artifact convergence uses `.claude/skills/dev-workflow/references/artifact-convergence-review.md`.
- Review convergence uses `.claude/skills/dev-workflow/references/review-convergence-review.md`.
- Final acceptance reconciliation uses `.claude/skills/dev-workflow/references/final-acceptance-review.md` when that reference opens configured independent review.
- An owner-defined reference explicitly opens configured independent review.

Risk-triggered review also applies when:
- `ROUTING-SIGNAL` is `team-routing candidate` or `ambiguous-route`
- lead-local would substitute for a configured lane
- parallel fit affects correctness or bottleneck risk
- team-lead is considering a non-destructive, non-security, non-operator-policy-choice user question instead of a default, parameter, assumption, or owner-evidence route

Skip when no risk-triggered axis applies.
Record skip basis in `CODEX-INDEPENDENT-REVIEW-BASIS`.
For `ACTIVE-WORKFLOW: dev-workflow`, `skipped:*` is valid only when no planning, design, material review, risk, route, artifact-convergence, final-acceptance, or workflow boundary is being frozen, revised, or used for advancement.
Pre-`work-planning` external review output is not planning evidence.

## Reference Map
Load only the references whose trigger is active:
- `references/common-contract.md` before every configured Codex MCP review call.
- `references/wp-consult.md` for `WP-CONSULT` route-freeze review.
- `.claude/skills/dev-workflow/references/artifact-convergence-review.md` for artifact convergence review.
- `.claude/skills/dev-workflow/references/review-convergence-review.md` for reviewer-grade convergence review.
- `.claude/skills/dev-workflow/references/final-acceptance-review.md` for final acceptance reconciliation.

## Inputs
- active owner path and stage
- user goal and target intent basis
- live doctrine and owner references Codex must read
- exact evidence surfaces
- claim, route, convergence, correction, acceptance, or completion decision being checked
- target-specific criteria from the owning reference

## Outputs
- `CODEX-INDEPENDENT-REVIEW-BASIS` for route-freeze planning
- target-specific configured-review status for artifact, review, final-acceptance, or owner-defined records
- accepted, rejected, dropped, deferred, or fail-open point counts
- adjudication basis for every valid returned point

## Review Workflow
1. Confirm the active owner path opened configured independent review.
2. Load `references/common-contract.md`.
3. Load the target-specific owner reference.
4. Build a derived configured-review packet from canonical fields and evidence surfaces.
5. Call `mcp__codex__codex` under the common tool discipline.
6. Parse the returned JSON.
7. Retry once for first-use connection miss or parse failure when the common contract permits.
8. Record `fail-open:<reason>` after exhausted tool, auth, quota, timeout, config, or parse failure.
9. Adjudicate every valid point against doctrine, user instruction, artifact evidence, proof evidence, acceptance evidence, or frozen request basis.
10. Update only the owning planning field, artifact, correction basis, convergence record, acceptance record, blocker basis, or fail-open record.

## Resolve Next Owner And Action
- Planning configured review opens `references/wp-consult.md`.
- Every Codex MCP call opens `references/common-contract.md`.
- Accepted `WP-CONSULT` points update planning fields or blocker basis.
- Accepted non-planning points update the owning artifact, correction basis, convergence record, or acceptance record.
- Rejected points record cited doctrine, user instruction, artifact evidence, proof evidence, acceptance evidence, or frozen request basis.
- Codex MCP access failure records `fail-open:<reason>` on the owning configured-review record.
- Unadjudicated valid points keep the owning path open.
- Unsupported post-route-freeze expansion opens the owning `Skill(governance-modification)` path.
