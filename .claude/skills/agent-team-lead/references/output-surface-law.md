---
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
SOURCE-ANCHOR: .claude/skills/agent-team-lead/SKILL.md
SOURCE-RULES: "RPA-13 User Reporting; Reporting Philosophy; Work Execution Philosophy"
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# team-lead: Output Surface Law

## Contents
- Purpose
- Consume When
- Required Output
- Output Routing Gate
- Resolve Next Owner And Action
- MID-FLIGHT
- PHASE-RESULT
- FINAL
- Reporting Law Boundary
- Claim Control

## Purpose
Use this reference only after `.claude/reference/reporting-prohibition-law.md` grants a narrow exception for a user-facing team-lead report.
It stages narrow-exception reports as `MID-FLIGHT`, `PHASE-RESULT`, or `FINAL`.
Report-content authorization stays with `.claude/reference/reporting-prohibition-law.md`.
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
Report prohibition and primary truth class are owned by `.claude/reference/reporting-prohibition-law.md`.
This surface adds team-lead output-surface staging only.
Pick exactly one output surface from:
- `MID-FLIGHT`
- `PHASE-RESULT`
- `FINAL`

## Output Routing Gate
Pre-report suppression is owned by `.claude/reference/reporting-prohibition-law.md`; this surface stages only reports excepted by that law.
Additional team-lead-specific routing requirements:
`FINAL` requires closed, lawfully deferred, out-of-scope, or truthful-`HOLD` residual deliverable convergence under `.claude/skills/agent-team-lead/references/routine-gate-continuation.md`, `.claude/skills/agent-team-lead/references/synthesis-consume.md`, or the active acceptance/proof owner.
`verified result` requires `Skill(self-verification)` result verification that is not:
- missing
- stale
- narrower than the outgoing claim

## Resolve Next Owner And Action
- An output prose gap continues internal execution.
- An output `FINAL` gap opens residual queue processing.
- A `verified result` gap opens `Skill(self-verification)` result verification.

## MID-FLIGHT
`MID-FLIGHT` executes required tool calls without status prose.
User-facing prose during `MID-FLIGHT` requires a narrow exception from `.claude/reference/reporting-prohibition-law.md`.
The following signals remain internal evidence until reporting-prohibition law grants a narrow exception: lane transport arrival, retained-output availability, shard completion, partial convergence, candidate counts, findings counts, hook notes, and agent notes.
`PHASE-RESULT` requires completed fan-out integration for the claimed surface.
Partial fan-out remains Procedure Plane until all-required-output integration and required `Skill(self-verification)` result verification close.
Report content follows `.claude/reference/reporting-prohibition-law.md`; this surface records only output staging.

## PHASE-RESULT
`PHASE-RESULT` is a staging label only after `.claude/reference/reporting-prohibition-law.md` grants a verified-result exception for a phase/stage-end result.
Content shape and exception fields stay with reporting-prohibition law.
Current `Skill(self-verification)` result verification is required before reporting analyzed, evaluated, or synthesized consequential content.

## FINAL
`FINAL` is a staging label only after `.claude/reference/reporting-prohibition-law.md` grants a verified-result or closeout-residual exception.
Residual queue status comes from `.claude/skills/agent-team-lead/references/routine-gate-continuation.md`, `.claude/skills/agent-team-lead/references/synthesis-consume.md`, or the active synthesis, acceptance, or proof owner.
Report prohibition, content shape, and evidence inclusion stay with `.claude/reference/reporting-prohibition-law.md`.

## Reporting Law Boundary
Use `.claude/reference/reporting-prohibition-law.md` as the canonical reporting rule and disclosure test.
Team-lead user-facing prose applies only after that law grants a narrow exception.
This surface preserves that law as the canonical report owner.

## Claim Control
Dispatch remains internal unless `.claude/reference/reporting-prohibition-law.md` grants a narrow exception for an explicit status answer.
Status answer content shape stays with `.claude/reference/reporting-prohibition-law.md`.
Runtime, receipt, status, control, hook, and partial-lane signals are evidence only.
Evidence-only signals are not reportable results.
When basis is insufficient for the outgoing claim:
- narrow the claim if basis is weaker than claim strength
- report `INFERENCE/UNVERIFIED` if basis is insufficient for a claim
