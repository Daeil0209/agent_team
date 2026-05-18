# Configured Independent Review: WP-CONSULT
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/codex-independent-review/SKILL.md
SOURCE-RULES: "Configured independent-review route-freeze handling; Reference Binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/user-reporting-law.md
auto-inject: false

Use this reference for route-freeze configured independent review inside `work-planning`.
Load after `Skill(work-planning)` is active, draft planning fields exist, and route freeze needs planning, design, material review, or risk-triggered independent critique.
Also consume `.claude/skills/codex-independent-review/references/common-contract.md` before the Codex MCP call.

## WP-CONSULT Packet
`WP-CONSULT` adds these fields to the common packet:
- `request_summary`
- `draft_freeze`: `REQUEST-FIT-BASIS`, `SEMANTIC-INTENT-BASIS`, `DERIVED-DEFAULTS`, `REQUEST-BOUND-PACKET-FIELDS`, `ACTIVE-WORKFLOW`, `ACTIVE-SEQUENCE`, `ACTION-CLASS`, `ROUTING-SIGNAL`, `LEAD-LOCAL-WORK-ITEMS`, `LEAD-LOCAL-REQUIRED-SKILLS`, `AGENT-MAP`, `PARALLEL-GROUPS`, `LANE-REQUIRED-SKILLS-MAP`, `SKILL-RECOMMENDATIONS`, `EXECUTION-READINESS-BASIS`, `NEXT-CONSEQUENTIAL-ACTION`, `DISPATCH-BLOCKERS`
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
Adjudicate every valid `WP-CONSULT` point per `.claude/skills/codex-independent-review/references/common-contract.md` Handling rules before the planning basis is complete.

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
