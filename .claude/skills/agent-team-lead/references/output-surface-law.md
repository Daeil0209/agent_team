---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "RPA-7 User Reporting; Reporting Philosophy; Work Execution Philosophy"
REPORTING-CURTAIN: .claude/reference/reporting-user-reporting-law.md
---
# team-lead: Output Surface Law

## Contents
- Purpose
- Consume When
- Required Output
- Stop
- Resolve Next Owner And Action
- MID-FLIGHT
- PHASE-RESULT
- FINAL
- Reporting Law Boundary
- Claim Control

## Purpose
Use this reference only after `.claude/reference/reporting-user-reporting-law.md` admits a user-facing team-lead report.
It stages admitted reports as `MID-FLIGHT`, `PHASE-RESULT`, or `FINAL`.
It does not authorize Communication Plane or Procedure Plane content as report content.
Terminal-visible team-lead prose is user-facing output.
Pane-visible team-lead prose is user-facing output.
Visible task-plan UI is user-facing output.
Visible todo UI is user-facing output.
Visible checklist UI is user-facing output.

## Consume When
- The next action has a user-facing text path.
- The next action has a terminal-visible team-lead prose path.
- The next action has a pane-visible team-lead prose path.
- A status question arrives during an active path.
- A phase/stage-end report is about to be emitted.
- A completion claim is about to be emitted.
- A blocker report is about to be emitted.
- A dispatch-state report is about to be emitted.
- A closeout-residual report is about to be emitted.

## Required Output
Report admissibility and primary truth class are owned by `.claude/reference/reporting-user-reporting-law.md`.
This surface adds team-lead output-surface staging only.
Pick exactly one output surface from:
- `MID-FLIGHT`
- `PHASE-RESULT`
- `FINAL`

## Stop
Pre-report suppression is owned by `.claude/reference/reporting-user-reporting-law.md`; this surface does not restate it.
Additional team-lead-specific stops:
Stop before `FINAL` when residual deliverable convergence remains open under `.claude/skills/agent-team-lead/references/routine-gate-continuation.md`, `.claude/skills/agent-team-lead/references/synthesis-consume.md`, or the active acceptance/proof owner.
Stop before `verified result` when `Skill(self-verification)` result verification is:
- missing
- stale
- narrower than the outgoing claim

## Resolve Next Owner And Action
- A stopped output prose route continues internal execution.
- A stopped output `FINAL` route opens residual queue processing.
- A stopped `verified result` route opens `Skill(self-verification)` result verification.

## MID-FLIGHT
`MID-FLIGHT` executes required tool calls without status prose.
User-facing prose during `MID-FLIGHT` requires admission by `.claude/reference/reporting-user-reporting-law.md`.
The following signals are not admitted prose by themselves: lane transport arrival, retained-output availability, shard completion, partial convergence, candidate counts, findings counts, hook notes, and agent notes.
Partial fan-out state cannot become `PHASE-RESULT`.
Partial fan-out remains Procedure Plane until all-required-output integration and required `Skill(self-verification)` result verification close.
Report content follows `.claude/reference/reporting-user-reporting-law.md`; this surface does not restate that allowlist.

## PHASE-RESULT
`PHASE-RESULT` is a staging label only after `.claude/reference/reporting-user-reporting-law.md` admits a phase-result report.
Content shape and allowed fields stay with user-reporting law.
Current `Skill(self-verification)` result verification is required before reporting analyzed, evaluated, or synthesized consequential content.

## FINAL
`FINAL` is a staging label only after `.claude/reference/reporting-user-reporting-law.md` admits a verified result or closeout residual.
Residual queue status comes from `.claude/skills/agent-team-lead/references/routine-gate-continuation.md`, `.claude/skills/agent-team-lead/references/synthesis-consume.md`, or the active synthesis, acceptance, or proof owner.
Report admissibility, content shape, and evidence inclusion stay with `.claude/reference/reporting-user-reporting-law.md`.

## Reporting Law Boundary
Use `.claude/reference/reporting-user-reporting-law.md` as the canonical reporting rule and disclosure test.
Team-lead user-facing prose applies only after that law admits the report.
This surface does not restate, override, or replace that law.

## Claim Control
Dispatch remains internal unless `.claude/reference/reporting-user-reporting-law.md` admits an explicit status answer.
Status answer content shape stays with `.claude/reference/reporting-user-reporting-law.md`.
Runtime, receipt, status, control, hook, and partial-lane signals are evidence only.
Evidence-only signals are not reportable results.
When basis cannot support the outgoing claim:
- narrow the claim if basis is weaker than claim strength
- report `INFERENCE/UNVERIFIED` if basis is insufficient for a claim
