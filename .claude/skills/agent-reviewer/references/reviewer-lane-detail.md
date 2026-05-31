---
name: reviewer-reference
PRIMARY-OWNER: reviewer
SOURCE-ANCHOR: .claude/skills/agent-reviewer/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
auto-inject: false
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---
# Reviewer Reference
## Contents
- Role-Spine Completion
- Reviewer Packet Detail
- Domain Lenses
- Applied Review Techniques
- Severity Mapping
- Specialist Skill Loading
- Reviewer Completion Detail
- Resolve Next Owner And Action

## Role-Spine Completion
`agents/reviewer.md` owns only the always-loaded reviewer charter, boundary, receipt trigger, stop rule, and review-local completion duty. This reference owns detailed reviewer packet fields, review lenses, severity mapping, specialist skill order, validator-ready completion detail, and rendered/evidence gap detail.

When a reviewer role or skill says "reviewer additions" or "reviewer detail", consume this file directly. Do not re-expand `agents/reviewer.md` into a packet-field catalog. Missing decisive review detail is `hold|blocker` or `scope-pressure`, not local reconstruction unless the review target and evidence basis are anchored in packet or artifact evidence.

## Reviewer Packet Detail
- Consequential reviewer packets must carry these fields explicitly:
  - `REVIEW-TARGET-TYPE` (`plan`, `design`, `implementation`, `proof-result`, `report`, `governance`, or another explicit artifact type)
  - `REVIEW-SCOPE`
  - `REVIEW-TARGET`
  - `PREREQ-STATE`
  - `EVIDENCE-BASIS`
  - `ACCEPTANCE-RISK`
  - `ACCEPTANCE-SURFACE`
  - `EXPECTATION-SOURCES` when the review judges completion, scope fit, or contract fit; source from the frozen request, plan, design, upstream defer record, closure matrix, or Evidence-Quality Matrix, not from implemented artifacts alone
  - `PRIOR-ANALYSIS`
  - `SCOPE-BASELINE` and `ACTIVE-SLICE` when reviewing current-scope completion or multi-surface implementation
- For plan review, also keep explicit when material:
  - `PLAN-CLAIM`
  - `ROUTE-BASIS`
  - `OWNER-MAP`
  - `PROOF-CHAIN`
  - `ACCEPTANCE-CHAIN`
  - `STOP-CONDITIONS`
- For design review, also keep explicit when material:
  - `DESIGN-INTENT`
  - `CONSTRAINTS`
  - `QUALITY-ATTRIBUTES`
  - `TRADEOFFS`
  - `INTERFACES`
  - `FAILURE-MODES`
  - `REGRESSION-RADIUS`

If these fields are missing and truthful review would require inventing them, route `hold|blocker` state instead of guessing.

If truthful review needs a tool, rendered surface, or setup path unavailable to reviewer, the upward request to `team-lead` must include the common tool/evidence-gap fields from `.claude/skills/task-execution/references/request-bound-fields.md`. Do not replace a required rendered or executable review surface with source-only evidence.
If rendered evidence is available for review, inspect it for visible defects; do not treat capture existence as rendered fitness.
For contract-fit or rendered review, name the Evidence-Quality Matrix row inspected, or mark the missing row in `OPEN-SURFACES`.

## Domain Lenses
- Evidence quality
- Logical rigor
- Software quality
- Security
- Architecture/design tradeoff
- Plan feasibility and owner boundary
- Realizability
- Human-facing clarity
- Operational correctness
- Failure/risk
- UX
- Business logic
- Report/document quality
- Contextual consistency
Use only the lenses that materially affect the assigned surface.

## Applied Review Techniques
- Peer-inspection discipline: verify entry information, inspect the actual work product, record defects, require rework/follow-up evidence for blocking defects.
- Architecture/design tradeoff review: evaluate quality attributes, constraints, sensitivity points, tradeoffs, risks, and risk themes rather than only local correctness.
- Code/change review lens: check design, functionality, complexity, tests, naming, comments, documentation, every assigned line or declared reviewed subset, and system context.
- Contract-fit review lens: verify producer/consumer source-of-truth, runtime data shape, generated or audited types, field names, error states, and visible consumer failure.
- Scope/closure-baseline lens: compare produced or proven surfaces against `SCOPE-BASELINE` and material closure or oracle rows; implemented-subset quality does not close missing, placeholder-only, unproven, source-untraced, disposition-less, or stale-consumer baseline rows.
- Security review lens: manual security judgment remains necessary for security-sensitive surfaces; scanners or source-only checks do not replace human review of trust boundaries, threat paths, unsafe defaults, secrets, injection, authz/authn, and data exposure.
- Intent-preserving critique: before accepting a proposed defect or fix, apply `TARGET-INTENT-BASIS`, the common finding basis in `.claude/skills/task-execution/references/completion-handoff.md`, and the smallest meaning-preserving correction.
- Feynman clarity lens: when a plan, design, report, governance text, or completion cannot be explained plainly without invented meaning, treat that as a review finding.
- Negative-space review: look for required but missing constraints, evidence, edge cases, owner transfer, user paths, rollback/cleanup paths, and acceptance/proof surfaces.
- Expert claim challenge: convert each major claim into `claim -> evidence -> impact -> owner -> required change`; do not accept unsupported confidence language.

## Severity Mapping
| Severity | Meaning |
|---|---|
| Critical | Must fix before further progress; escalate immediately when the defect implies system halt, data loss, credential exposure, destructive or irreversible damage, or unacceptable user harm risk |
| Major | Must fix before this stage passes |
| Minor | Fix after blocking findings; does not block |
| Advisory | Observation only |

Specialist skill output is not automatically advisory. `security-review` and `code-quality-review` findings use this same severity mapping; remediation stays with the producing owner.

## Specialist Skill Loading
Reviewer lane evaluation selects and applies the materially relevant specialist lenses from the assigned review surface, frozen `SCOPE-BASELINE`, Phase 1/2 design basis, and expectation sources.
Before acceptance-review severity classification, consume frozen specialist contracts, oracles, and skill-basis records as review authority. If a material oracle is missing and cannot be derived from packet or artifact evidence, route `hold|blocker` instead of reviewing against a narrower surface.
Defect promotion whose truth depends on governance, process, analysis, critique, review, validation, removal, patch-worthiness, or other team/design meaning follows `.claude/skills/task-execution/references/completion-handoff.md` `Common finding basis` before any reviewer severity mapping; severity mapping never creates `confirmed-defect` authority.
Use this surface map:
- Work-tool, spreadsheet, operations, business-rule, and workflow-state review: `business-workflow`, `work-tool-patterns`.
- Report, document automation, reader/presenter-facing generation, and explanation-critical artifact review: `document-automation`, `visual-composition`, `feynman-clarity`.
- Engineering, calculation, units, formulas, quantitative constraints, and data-shape review: `engineering-grounding`, `mathematical-correctness`.
- UI, browser, visual layout, component conversion, rendered operator surface, and design-system contract review: `visual-composition`, `mockup-to-component`, `design-system-tokens`.
- Software implementation, maintainability, architecture-coded contract, and security review: `code-quality-review`, `security-review`.

When security and code quality are both active on one review surface, run `security-review` first because security findings can block acceptance regardless of code quality, then `code-quality-review`.
Run `feynman-clarity` when target intent, protected function, reader action, or explanation failure materially affects review truth.
These are review lenses; acceptance findings use normal severity and are blocking when severity warrants it.
Remediation stays with the producing owner.

## Reviewer Completion Detail
- Reviewer `completion` carrier blocks must include `REVIEW-STATE: ready|hold|blocked`; `hold|blocker` state uses the no-detail state token plus preceding non-rendered `problem-report` or governed carrier detail, and `REVIEW-STATE` is completion-context only.
- Reviewer completion must include `TARGET-INTENT-BASIS` through the common completion spine.
- Findings that propose removal, reduction, simplification, or optimization must satisfy the common finding basis in `.claude/skills/task-execution/references/completion-handoff.md`.
- Without that basis, classify the item as preliminary evidence, not a completed review finding.
- Governance defect, removal, and patch-worthiness assignments use the candidate ceiling in `agent-reviewer/SKILL.md`; reviewer completion does not promote to `confirmed-defect`.
- Use `ready` only when the assigned review scope is complete, decisive evidence supports the findings, and no blocking review defect remains.
- Use `hold` when review cannot truthfully complete because required basis, evidence, tool path, or upstream state is missing but resolvable.
- Use `blocked` when the assigned review surface cannot proceed under the frozen packet without replanning, rerouting, or upstream correction.
- `No output`, quiet command success, suppressed stdout, folded `Read`/`Bash` rows, or stdout-based connectivity probes do not prove missing evidence or unavailable tool path. Before `REVIEW-STATE: hold|blocked` for a tool-path claim, cite explicit tool error, timeout, cancellation, permission denial, or absent completed tool-call result; otherwise continue through screen-safe evidence paths under `.claude/reference/work-runtime-boundary-law.md` `### Bash Internal Evidence Capture Contract`.
- If runnable proof is still required, keep `tester` explicit as the proof owner.
- If final validation is materially required, keep the validator ingress contract explicit:
  - `VALIDATION-TARGET-TYPE`
  - `VALIDATION-TARGET`
  - `EXPECTATION-SOURCES`
  - `REVIEW-STATE`
  - `TEST-STATE`
  - `VALIDATION-SURFACE`
- Keep `DECISION-SURFACE` explicit when final arbitration still needs a distinct decisive surface or multi-surface reconciliation.
- Keep these validator additions explicit when applicable:
  - exact frozen tool: `TOOL-REQUIREMENT`
  - bounded discovery/setup alternative: `TOOL-DISCOVERY-GOAL`, `TOOL-DISCOVERY-BOUNDARY`, `TOOL-VERIFICATION-STANDARD`, `TOOL-CLEANUP-EXPECTATION`
  - `USER-RUN-PATH`
  - `BURDEN-CONTRACT`
- For request-bound acceptance, keep the request-fit contract explicit in the same completion rather than rewriting it from memory.
- For visual/rendered review, name the inspected rendered evidence and any visible defect classes checked or found.
- If review evidence makes the frozen contract untruthful, set `REVIEW-STATE: hold` or `REVIEW-STATE: blocked` and explain the contradiction in `OPEN-SURFACES`.

## Resolve Next Owner And Action
- `execute` opens reviewer-owned review work.
- `reconstruct-with-inference` opens reviewer-owned review work with marked inference.
- Blocking review finding opens producer correction through team-lead.
- Reviewer-local `REVIEW-STATE: ready` opens reviewer `completion` transport emission (post-completion downstream routing per SKILL.md `## Resolve Next Owner And Action`).
- `REVIEW-STATE: hold` opens team-lead basis, evidence, tool, or upstream-state correction.
- `REVIEW-STATE: blocked` opens team-lead replanning, rerouting, or upstream correction.
- Runnable proof need opens tester routing.
- Final validation need opens validator ingress.
