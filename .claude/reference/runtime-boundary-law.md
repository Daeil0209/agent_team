---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/CLAUDE.md
SOURCE-RULES: "Core Laws 5 [HOOK-LAST]; Conditional Rules; Codex boundary"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
---
# Common Doctrine Reference: Runtime Boundary

## Source Binding
This reference is trigger-bound detail for `CLAUDE.md` `[HOOK-LAST]` and Conditional Rules runtime-boundary clauses.
This reference owns the prose-vs-technical-enforcement boundary.
Governance-text patch selection stays with `.claude/reference/minimal-governance-change-law.md` `## Patch-Ready Gate`.
Project output-root placement stays with `.claude/reference/output-root-and-filesystem-law.md`.

## Purpose
Use this reference when boundary confusion is possible:
- prose rules with runtime enforcement
- hooks with owner procedure
- settings with owner procedure
- tools with proof
- tools with acceptance
- non-owner tool output with owner judgment
- runtime state with project documents
It keeps runtime guardrails narrow and prevents runtime signals from replacing owner procedure.

## Consume When
- A hook or setting is proposed as enforcement.
- A runtime signal might be treated as:
  - planning
  - proof
  - validation
  - acceptance
- A tool signal might be treated as:
  - planning
  - proof
  - validation
  - acceptance
- A claim depends on hook, settings, sandbox, or runtime-footprint behavior.
- These influences affect a route:
  - external MCP influence
  - external review-tool influence
  - Codex output influence
- Codex output influence affects a verdict.
- A runtime state file or team-runtime artifact is involved.

## Required Output
The consuming owner records:
- runtime surface involved
- governing owner rule
- runtime boundary result
- measured evidence when a runtime-footprint claim is made
- owner procedure that remains responsible
- blocker or follow-up owner when material

## Stop
Stop before hook changes when the risk belongs to:
- doctrine
- skill
- packet
- owner report
- task state
Stop before settings changes when the risk belongs to:
- doctrine
- skill
- packet
- owner report
- task state
Stop before runtime-footprint claims without measured evidence.
Stop before treating tool availability as:
- proof
- validation
- acceptance
- dispatch truth
- owner completion
Stop before treating non-owner tool output as:
- a blocker
- a mutator
- validator
- acceptance owner

## Resolve Next Owner And Action
- A stopped hook route opens the smallest non-runtime correction owner.
- A stopped runtime-footprint claim opens measurement or narrows the claim to `UNVERIFIED`.
- A stopped tool-signal route opens the owner procedure that actually owns the claim.
- A stopped non-owner tool route opens the owner procedure that actually owns the claim.

## Runtime Boundary Rules
- Hooks are last-resort runtime guards.
- These ownership surfaces stay with owner procedures:
  - planning ownership
  - routing ownership
  - judgment ownership
- Proof ownership stays with tester or proof owner.
- Acceptance ownership stays with validator or acceptance owner.
- These provide technical enforcement:
  - settings
  - permissions
  - sandbox
  - hooks
- `CLAUDE.md`, role files, rules, skills, and references shape behavior through context.
- Label prose rules as context-bound operating rules in runtime-boundary claims.
- Governance-flow hooks stay separate from settings-deny secret protection.
- Hooks guard observable runtime edges that would otherwise produce reserved hard-deny danger.
- `settings.json` deny rules protect credential and secret paths.
- Treat external MCP as capability.
- Treat external review tools as capability.
- Runtime-boundary claims keep ownership with the governing role, skill, lane, or sequence.
- Route blocker decisions to the owning procedure.
- Route dispatch decisions to the owning procedure.
- Route validation decisions to `validator`.
- Route acceptance decisions to `validator`.
- Route mutation to the owning production or patch owner.
- Route credential repair to the security or setup owner.
- Route owner-gate changes to the owning governance sequence.
- Agent-team runtime state is runtime-owned.
- Keep runtime state on runtime-owned surfaces.

## Footprint Claims
- Runtime-footprint claims require measured evidence.
- Hook-footprint claims require measured evidence.
- Unmeasured improvements are design-level or `UNVERIFIED`.
- Footprint detail lives in `.claude/reference/runtime-footprint-and-continuity.md`.
