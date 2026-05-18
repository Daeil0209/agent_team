---
name: governance-change
description: Govern team-system asset changes and install recurrence barriers.
user-invocable: false
PRIMARY-OWNER: team-lead
---
## Structural Contract
- Sharpens only governance change, recurrence hardening, and team-system asset mutation.
- Fixed top-level section order after Structural Contract: Purpose, Activation, Reference Map, Recurrence Hardening, Asset Change, Change Sequence, Patch Execution Method, Resolve Next Owner And Action.
- PRIMARY-OWNER: team-lead

## Purpose
Own controlled changes to `.claude` team-system assets.
Control how `team-lead` plans, reviews, executes, verifies, and closes governance document modification.
Own recurrence-barrier hardening after a behavioral, procedural, or capability defect is confirmed.
Own ordinary asset maintenance when no confirmed recurrence defect exists.

Adjacent owners:
- `Skill(review-verification)` owns material defect, removal, cross-surface governance, negative-risk, and patch-worthiness judgment.
- `Skill(self-verification)` owns final claim, result, completion, and reporting verification.
- `work-planning` owns fresh or reopened consequential change-boundary freeze.
- `task-execution` owns assignment-grade team dispatch and packet truth.
- `session-boot` and `session-closeout` keep runtime readiness and teardown truth.

This skill does not create a second review path.
This skill does not create a second result-verification path.
`team-lead` executes `Skill(governance-change)` only from a current owner, trigger, action, stop, and evidence basis.
This skill's entry, mode selection, records, and patch progress stay Procedure Plane.
User-facing change-result prose opens this skill's Post-Verify `Skill(self-verification)` gate before `team-lead` RPA-7 and `.claude/reference/user-reporting-law.md`.

## Activation
Load this skill for a verified next owner/action of governance asset change or recurrence-barrier hardening.
Ordinary task execution, ordinary analysis, ordinary deliverable correction, ordinary code/content change, and result verification stay with their active owners; this skill opens when that correction changes a governance asset or installs a team-operation recurrence barrier.

Governance asset change means creation, modification, deletion, splitting, merging, re-homing, reclassification, compression, migration, or runtime-enforcement change to one of:
- doctrine
- agents
- skills
- settings
- hooks
- enabled project-root `.mcp.json`
- live-surface mirrors
- other team-system governance assets

Recurrence-barrier hardening means evidence confirms or plausibly indicates a team-operation defect from justified user correction, self-detected process failure, hook signal, runtime/process error, repeated missed-catch, or confirmed capability gap and the correction requires a governance asset barrier.

Select one active mode:
- `recurrence-hardening`: defect classification and recurrence-barrier path triggered by a Recurrence Hardening Trigger Matrix row in `references/decision-and-repair.md`; barrier installation requires confirmed defect basis and recurrence path.
- `asset-change`: ordinary non-defect asset maintenance, skill introduction, specialist routing change, settings/hook change, migration, compression, or capability refinement.

After `Skill(governance-change)` entry, `team-lead` consumes `Skill(review-verification)` fresh per the change tier.
Standard or structural update consumes the full workflow.
Quick update consumes a single named lens per `Skill(review-verification)` `## Named Lane Lens Index`.
`REVIEW-VERIFICATION-NEED` records the chosen lens for quick update or `full-workflow` for standard/structural update.
`owner-local-sufficient:<basis>` is invalid for governance asset changes inside `Skill(governance-change)`.
Every governance asset change consumes `Skill(review-verification)`.
After Post-Verify, open `Skill(self-verification)` for the outgoing changed-result or report claim.
Destructive, security-sensitive, runtime-enforcement expansion, or operator-policy-choice changes require explicit operator approval.
Lane-side governance asset-change (developer lane applying frozen patch design): lane-local `Skill(self-verification)` consumes `Skill(review-verification)` named lenses (`removal-first-lens`, `coherence-integrity-lens`, `negative-risk-lens`, `patch-worthiness-lens`) inside its Critical Challenge step against the applied diff; the trio (`Skill(governance-change)` patch mechanics, lane-local `Skill(self-verification)`, named lenses) is the lane-side quality contract for governance asset changes — packet-design enforcement of this trio is owned by `.claude/skills/task-execution/references/assignment-packet.md` Packet Preflight + `.claude/skills/task-execution/references/lane-additions.md` review-verification lane lens naming rule.

## Reference Map
Load only the reference whose trigger is active.
- `references/decision-and-repair.md`: trigger interpretation, causal analysis, failure-mode response, owner-surface choice, patch classification, high-traffic surfaces, and constraints.
- `references/asset-change-checks.md`: ordinary asset update checks, skill introduction gate, specialist routing, configurable-value ownership, Hook-Last preflight, and MCP/external-tool asset coherence.
- `references/capability-gap-fast-path.md`: missing reusable-skill fast path and default rapid-skill routing.
- `references/benchmark-protocol.md`: benchmark-first preparation and capability-promotion comparison gates.
- `references/human-readable-packet-owners.md`: semantic packet catalog for governance patch dispatch.
- `references/change-patch-method.md`: Change Sequence detail, patch mechanics, retroactive application, meaning routing, file/runtime hygiene, and hook enforcement rules.

If a triggered reference cannot be loaded, freeze `HOLD` or reopen the owner that can supply the basis.

## Recurrence Hardening
Protect active request correctness and safety before durable hardening.
Harden the narrowest owner-local surface that blocks the recurrence without creating a parallel operating model.
Explanation alone is not hardening.

Record the applicable carrier.
Quick hardening records `DEFECT-BASIS`, `DESIGN-INTENT-BASIS`, `OWNER-SURFACE`, `CHANGE-BOUNDARY`, `VERIFICATION-BASIS`, `CONVERGENCE-STATUS`, and `RESUME-ACTION`.
Standard and structural hardening record `DEFECT-BASIS`, `DESIGN-INTENT-BASIS`, `CAUSAL-BASIS`, `FAILURE-MODE`, `RECURRENCE-PATH`, `REVIEW-VERIFICATION-NEED`, `OWNER-SURFACE`, `BARRIER-TYPE`, `CHANGE-BOUNDARY`, `VERIFICATION-BASIS`, `CONVERGENCE-STATUS`, `SUSPENDED-WORK-SURFACE`, `RESUME-OWNER`, `RESUME-CONDITION`, `RESUME-ACTION`, and `FOLLOW-ON-OPTIMIZATION`.
When active work is interrupted, record `SUSPENDED-WORK-SURFACE`, last safe state, `RESUME-OWNER`, `RESUME-CONDITION`, and candidate `RESUME-ACTION` before the interruption becomes invisible.

Quick hardening applies only to same-owner typo fixes, terminology normalization, dead-text removal, duplicate trim, pointer correction, or wording clarification when owner surface, write scope, meaning preservation, consumed path, and Patch-Ready compact-record eligibility are unambiguous.
Quick hardening must not change rule force, owner boundary, trigger, stop, evidence, acceptance, runtime effect, recurrence path, or consumed owner path.
If recurrence, owner ambiguity, cross-surface impact, new rule meaning, runtime enforcement, or acceptance impact appears, upgrade before execution.

Standard hardening covers behavioral rule changes, executable-rule force/trigger/stop/evidence changes, new constraints, and recurrence barriers.
Structural hardening covers architecture-level changes, owner re-home, cross-document impact, runtime-enforcement expansion, or capability-boundary changes.

Required order for standard and structural hardening:
1. Identify trigger source, defect class, impacted path, intended design, causal basis, recurrence path, likely owner, consumed owner path, and required barrier class.
2. Consume `Skill(review-verification)` fresh for every governance asset change inside `Skill(governance-change)`. Quick-hardening narrows the review scope to a single named-lens per `Skill(review-verification)` `## Named Lane Lens Index`; it does not skip skill load or workflow execution.
3. Adjudicate the owner surface explicitly.
4. Keep the hardening role-scoped unless the recurrence path proves a shared owner.
5. Execute through `Change Sequence`.
6. Install the recurrence barrier on the correct owner surface.
7. Apply retroactive current-session surfaces governed or contradicted by the new rule.
8. Make a bounded follow-on optimization decision.
9. Close only with current verification basis, explicit open surfaces, and verified resume action or `HOLD`.

## Asset Change
Use `asset-change` mode for ordinary team-system asset maintenance when no confirmed recurrence defect controls the change.
Asset-change mode still uses the same `Change Sequence`.
Asset-change mode still preserves owner boundary, live consumption path, protected procedure force, and information traceability.

Record `ASSET-CHANGE-BASIS` with target asset, owner surface, change type, update tier, triggered references, affected surfaces, source-to-destination trace when meaning moves, verification basis, and open surfaces.
Record `REVIEW-VERIFICATION-NEED` for each asset-change row before Draft.

Change types:
- `ordinary asset maintenance`
- `capability introduction`
- `external-tool/MCP integration`
- `compression`
- `migration`
- `settings/hook change`
- `runtime enforcement expansion`
- `specialist-routing change`

Update tiers:
- `quick update`: same-owner typo, dead-text deletion, duplicate trim, pointer correction, terminology normalization, or wording clarification that preserves rule force, owner, trigger, stop, evidence, acceptance, runtime effect, live references, and consumed path.
- `standard update`: ordinary governance, role, skill, or reference edits inside the same owner family without moving ownership, expanding runtime enforcement, changing acceptance authority, or migrating meaning across owner surfaces.
- `structural update`: owner re-home, migration, compression with destination-owner change, skill introduction, skill split or merge, specialist-routing change, external-tool/MCP integration, settings/hook change, runtime enforcement expansion, acceptance/validation authority change, or cross-surface structural impact.

Unknown, mixed, or disputed tiers upgrade to the highest material tier before mutation.
Use `references/asset-change-checks.md` for triggered structural checks, skill introduction, specialist routing, Hook-Last preflight, and MCP/external-tool asset coherence.

## Change Sequence
The `Change Sequence` is the standard controlled path for rule, code, config, hook, agent, skill, reference, and governance asset changes.
Use `references/change-patch-method.md` for detailed step order and constraints.

Hard surface:
- Load `work-planning` only at a fresh or reopened change boundary.
- Use `Skill(self-verification)` plan audit only when the change plan is disputed.
- Consume the recorded `Skill(review-verification):<bounded-question>` output per `Activation` per-change-tier rule before Draft, Execute, and convergence.
- The `Skill(review-verification)` tool call must appear in the current turn before any `Edit`/`MultiEdit`/`Write`/`Bash` mutation on a `.claude/` governance asset by the calling owner (team-lead or lane).
- Post-hoc `Skill(review-verification)` on already-applied patches is recurrence-class defect per `.claude/CLAUDE.md` `Core Laws 5` `[HARDEN]` and does not satisfy this gate.
- The failed pre-mutation order returns to recurrence-hardening at the narrowest calling-owner surface.
- Review changed content, not just the plan.
- Execute only the reviewed, bounded, policy-compliant change.
- Governance-sensitive execution follows `references/change-patch-method.md` Step 5b.
- Hook/settings runtime-enforcement expansion follows `references/asset-change-checks.md` Hook-Last preflight and explicit operator approval.
- Post-verify resulting diff, owner semantics, live references, information preservation, affected consumed surfaces, and in-flight/prior-verdict impact; record and consume `Skill(review-verification):<bounded-question>` when that check exposes material coherence, owner-surface, removal, patch-worthiness, or negative-risk judgment.
- Load `Skill(self-verification)` for changed-result closure after post-verify and any required `Skill(review-verification)` re-engagement converge, before consequential reporting.

## Patch Execution Method
Detailed patch mechanics are owned by `references/change-patch-method.md`.
Confirmed recurrence-hardening patches install a bounded recurrence barrier without content accumulation.
Ordinary asset-change patches preserve the live asset contract without inventing recurrence basis.

## Resolve Next Owner And Action
- Confirmed recurrence defect opens `Recurrence Hardening`.
- Ordinary team-system asset maintenance opens `Asset Change`.
- Material defect, removal, governance judgment, negative risk, or patch-worthiness gap opens `Skill(review-verification):<bounded-question>` inside the current change row.
- Patch execution opens `Change Sequence`.
- Missing triggered reference basis opens blocker-clear, owner reopening, or `HOLD`.
- Runtime-enforcement expansion opens Hook-Last preflight and operator approval.
- Failed Post-Verify auto-reopens Change Sequence at the earliest invalidated step at the current cumulative live state without user authorization, subject to `CLAUDE.md` `[NO-NEEDLESS-ASK]` escalation criteria; the iteration loop continues until Post-Verify converges or an escalation-class blocker is recorded.
- Verified change opens `Skill(self-verification)`; after result verification, resume the open Change Sequence or verified `RESUME-ACTION` before consequential reporting.
- Converged recurrence barrier opens the verified `RESUME-ACTION`.
