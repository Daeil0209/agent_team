# Configured Independent Review: WP-CONSULT
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/codex-independent-review/SKILL.md
SOURCE-RULES: "Configured independent-review route-freeze handling; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
auto-inject: false

Use this reference for route-freeze configured independent review inside `work-planning`.
Load after `Skill(work-planning)` is active, draft planning fields exist, and route freeze needs planning, design, material review, or risk-triggered independent critique.
Also consume `.claude/skills/codex-independent-review/references/concurrent-patterns.md` before the codex CLI background invocation.

## WP-CONSULT Packet
`WP-CONSULT` adds these fields to the common packet:
- `request_summary`
- `draft_freeze`: every `Always freeze` field plus every material `Freeze when material` field per the canonical work-planning record schema at `.claude/skills/work-planning/references/planning-record-fields.md` (consume that canonical schema rather than this list; field list evolves there and this packet stays in sync automatically).
- `context_notes`
- `prior_session_invariants`
- `doctrine_read_paths`
- `user_confirmation_candidate`

`doctrine_read_paths` must include `.claude/CLAUDE.md` plus owner paths needed for doctrine-specific judgment.
Add `.claude/skills/feynman-clarity/SKILL.md` when the deliverable is a plan, design, report, governance/document artifact, specification, or user-facing delivery path.
Add `.claude/skills/benchmark-simulation/SKILL.md` when external visual benchmark, information-representation benchmark, methodology benchmark, verification-method benchmark, domain-pattern benchmark, or capability-growth benchmark materially affects the planning basis.
Populate `user_confirmation_candidate` only to challenge a proposed user question.

## WP-CONSULT Review Focus
Codex checks the draft freeze for:
- missing required planning fields
- wrong owner, workflow, sequence, or action class
- unsupported parallel grouping, serial basis, or staffing shape
- missing `EXECUTION-READINESS-BASIS`
- missing or invalid `CODEX-INDEPENDENT-REVIEW-BASIS`
- weak request-fit, semantic-intent, or user-convenience basis
- needless user confirmation where doctrine and evidence can select a default
- acceptance, proof, skill-map, or carry-forward gaps that would make dispatch unsafe

## WP-CONSULT Handling
Adjudicate every valid `WP-CONSULT` point per team-lead Accept/Reject/Defer adjudication before the planning basis is complete; codex output transport rules per `.claude/skills/codex-independent-review/references/concurrent-patterns.md` Authority + Transport Boundary.

Freeze one:
- `CODEX-INDEPENDENT-REVIEW-BASIS: skipped:<basis>`
- `CODEX-INDEPENDENT-REVIEW-BASIS: triggered:accepted=<n>;rejected=<n>;dropped=<n>`
- `CODEX-INDEPENDENT-REVIEW-BASIS: fail-open:<reason>`

## Resolve Next Owner And Action
- Accepted points update the affected planning field or blocker basis.
- Rejected points record cited doctrine, user instruction, evidence, or frozen request basis.
- Exhausted configured-review attempt records `CODEX-INDEPENDENT-REVIEW-BASIS: fail-open:<reason>`.
- No-trigger path records `CODEX-INDEPENDENT-REVIEW-BASIS: skipped:<basis>`.
- Unadjudicated valid points keep `work-planning` open.
