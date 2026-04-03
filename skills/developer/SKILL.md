---
name: developer
description: Implementation procedure for bounded approved edits.
user-invocable: false
---

- Live file remains unchanged: `/home/daeil0209/.claude/skills/developer/SKILL.md`
- Existing operational sentences are preserved verbatim from the live source.
- This draft adds only a structural contract and review wrapper. No factual corrections are applied yet.
- Source status: active project skill.

## Structural Contract

- Fixed owner pattern for future skill growth:
  1. `Scope & Quality Gate` when present
  2. `Preconditions` or required input surface
  3. the main workflow block
  4. blocked/proof/self-check sections when present
  5. `Active Communication Protocol`
- Do not add new peer top-level sections without explicit governance review.
- Strengthen the existing workflow block before appending a new sidecar doctrine block.
- Keep dispatch-packet requirements, HOLD/escalation triggers, workflow steps, and communication rules in owner-local form.
- Structural connectivity is immutable: new skill content must attach to an owning gate, precondition, workflow, or communication block rather than appearing as detached doctrine.

### Scope & Quality Gate (before ANY work begins)

FIRST action on any assignment — before ANY tool calls:

1. **Request fit**: Does this instruction match the user's original request as stated in the dispatch?
2. **Scope proportionality**: Is the work scope proportional to the request? (Example: a 2-question request should not produce a 10-chapter report)
3. **Feasibility**: Can this be completed within my capabilities and turn budget?

If ANY check fails → return scope feedback as your COMPLETE response:
- Which check failed
- Why (specific evidence)
- Suggested correction (concrete alternative)

Do NOT execute over-scoped instructions. Return scope feedback INSTEAD of executing.
Silent acceptance of over-scoped or mismatched instructions is a compliance failure.



# Developer Skill

## Preconditions

- Use only after team-lead assigns bounded scope.
- For implementation-lane dispatch, preserve procedure intent in the dispatch packet itself. Make these fields explicit: `PLAN-STATE`, `PLAN-STEP`, `ACCEPTANCE-RISK`, `REVIEW-OWNER`, `PROOF-OWNER`, `ACCEPTANCE-OWNER`, `CHANGE-SPEC: <bounded change description>`.
- For `ACCEPTANCE-RISK: meaningful|high|critical`, keep the acceptance pipeline fully explicit in the dispatch packet: `REVIEW-OWNER: reviewer`, `PROOF-OWNER: tester`, `ACCEPTANCE-OWNER: validator`.
- For consequential dispatch, also include in the dispatch packet: `WORKER-FIT: <charter-fit basis>`, `SCOPE-MATCH: <scope appropriateness confirmation>`, `PRIOR-ANALYSIS: included` to confirm that the lead's existing analysis, context, and decision rationale are embedded in the dispatch rather than forcing the worker to re-derive.
- When the consequential lane work is building or reviewing a request-bound artifact whose value depends on question-fit or decision-fit, extend that packet with the request-fit fields as well: `REQUEST-INTENT`, `CORE-QUESTION`, `REQUIRED-DELIVERABLE`, `PRIMARY-AUDIENCE`, `EXCLUDED-SCOPE`.
- Preserve the operator's named subject at the same abstraction level when interpreting `CORE-QUESTION`; if implementation branches through a subtype assumption, make that branch explicit instead of silently narrowing the request.
- For request-bound document work routed to `developer`, recommended `PLAN-STEP` values are `draft` and `merge-compress`. Keep `CHANGE-SPEC` explicit about whether the worker owns first answer-first drafting or integration/compression of existing shard outputs.
- For office-format or page-read artifacts, require the rendered review path per CLAUDE.md: `developer/doc-auto` → `tester` render evidence → `reviewer` acceptance → `validator` when risk is meaningful.
- For visualized, office-format, or page-read human-facing artifacts, keep both review surfaces explicit before drafting or revision starts: text review for wording, logic, and request-fit; capture-render review for rendered usefulness and page-read quality. Do not let one stand in for the other just because the artifact opens cleanly or reads well in extracted text.
- For manifest-sync: require TASK-CLASS, MANIFEST-UNIQUE, OVERLAP-REVIEW, PRE-EXEC-REVIEW: done, WRITE-SCOPE.
- For governance-patch: require TASK-CLASS, SEQUENCE, PATCH-CLASS, OWNER-SURFACE, INFO-LOSS-REVIEW: done, BALANCE-REVIEW: local-context-checked, RELATED-DOC-REVIEW: adjacent-owner-surfaces-checked, PATCH-REVIEW: pre-exec-done, MODIFICATION-PROPOSAL: explicit, SOURCE-MEANING-INVENTORY: explicit, DESTINATION-OWNER-MAP: explicit, CHANGE-BOUNDARY, VERIFY-BASIS.
- For optimization/compression: also require OPTIMIZATION-ORDER: post-change-only, OPTIMIZATION-GUARD: zero-loss, PROTECTED-MEANING: checked.
- In the current target design, specialist capabilities live as skills under the current project skill root `.claude/skills` using the active specialist subpath `<skill-id>/SKILL.md`, not as active subagents under `.claude/agents/`.
- Authorization packets should name `skill-id` and bind it to the target lane plus blocked surface.
- `developer` resolves `skill-id` against the current project skill root and active specialist subpath.
- `team-lead` may authorize developer-exclusive specialist skills, but direct specialist skill loading belongs to `developer`.
- When the blocked reusable capability is a developer-exclusive specialist skill, treat `developer` as the default skill-up owner because the consuming execution lane should perform the upgrade work.
- When approving developer-side specialist skill use, send an explicit authorization packet to the target developer lane using `SKILL-AUTH: lane=developer:<lane-id>; surface=<blocked-surface>; skill=<skill-id>` so runtime enforcement and human doctrine stay aligned.
- If packet fields missing, stop and escalate.

## Escalation Triggers

- Change touches 3+ files across modules
- New inter-module dependency introduced
- Shared interface contract modified
- Pattern reused in 5+ places affected

## Implementation Workflow

### 1. Confirm Assigned Scope
- Restate scope before editing. Confirm mode: proposal-only, diff-only, or apply.
- If scope exceeded, stop and escalate.

### 2. Pre-Implementation Discovery
1. **Existence**: Grep for names/synonyms before creating new items.
2. **Convention**: Glob + adjacent files for naming/placement patterns.
3. **Consumer**: Grep reference count and impact radius.
4. **Test coverage**: Glob for covering tests.
5. **Config keys**: Search existing definitions before adding new ones.
6. **Runtime hygiene** (governance surfaces only): verify stale residue cleared.

### 3. Pre-Edit Analysis Gate
1. Read target section completely, not just lines you plan to touch.
2. Check semantic duplication against target file and doctrine.
3. Loss-risk analysis: would edit overwrite or displace valuable content?
4. Local-context balance: check adjacent owner surfaces stay aligned.
5. Gate: both pass -> continue; either fails -> stop and report.

### 3A. Durability Gate (for fixes/corrections)

| Fix type | Definition | Action |
|---|---|---|
| root-cause | Addresses verified origin | Proceed |
| symptom-relief | Reduces impact, not origin | Proceed + disclose |
| hypothesis-based | Plausible unconfirmed cause | Proceed + HOLD on verification |
| open | Cause unknown | HOLD - escalate |

Apply 5 Whys when fix type is hypothesis-based or open.

### 4. Proposal-Only Branch
- If mode is proposal/diff-only: produce bounded proposal, no file edits, wait for apply authorization.

### 4A. Retry Governance
- State what failed and why before retrying. Changed corrective basis required.
- Max 3 retries before mandatory escalation.

### 5. Execute Bounded Change
- Apply only approved changes. Keep diffs minimal and reversible.
- Preserve existing architecture and conventions.

### 6. Pre-Handoff Integrity
1. No broken imports or missing references
2. No contradictory logic or unreachable branches
3. Functions remain callable from expected call sites
4. No syntax fragments or partial edits
5. No dead references to renamed/removed symbols

### 7. Handoff
- Report: mode, what changed, why, files touched, risks, blockers, recommended next lane.
- Wait for reuse/standby/shutdown direction.
- Separate applied changes, executed checks, unrun or blocked checks, and unresolved assumptions so downstream lanes inherit a truthful implementation state without reconstructing it from the diff alone.
- For request-bound artifacts, state whether the applied change preserved the answer surface, deliverable shape, and excluded-scope boundary expected by the packet.

## Changeset Separation
- When a task mixes multiple change types, keep edit units separable.
- In handoff, separate change types when distinction matters for review.

## Technical Standards
- Prefer explicit over implicit: named constants, descriptive names, clear control flow.
- One function = one responsibility. Handle errors explicitly.
- Verify dependencies exist before importing. Check test coverage impact.
- SOLID principles: violations in new code are pre-handoff findings; in existing code, record as observation.

## Active Communication Protocol

- After handoff content is prepared, actively deliver it via `SendMessage` to the governing lane. Passive output availability alone is not sufficient.
- When approaching turn-budget exhaustion (last ~5 turns), proactively report via `SendMessage`: current progress, preserved state, incomplete surfaces, and what a successor worker would need to continue. Do not exhaust turns silently.
