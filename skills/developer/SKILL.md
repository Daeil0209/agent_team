---
name: developer
description: Implementation procedure for bounded approved edits.
user-invocable: false
---

# Developer Skill

## Preconditions

- Use only after team-lead assigns bounded scope.
- For manifest-sync: require TASK-CLASS, MANIFEST-UNIQUE, OVERLAP-REVIEW, WRITE-SCOPE.
- For governance-patch: require TASK-CLASS, SEQUENCE, PATCH-CLASS, OWNER-SURFACE, INFO-LOSS-REVIEW: done, BALANCE-REVIEW: local-context-checked, RELATED-DOC-REVIEW: adjacent-owner-surfaces-checked, MODIFICATION-PROPOSAL: explicit, SOURCE-MEANING-INVENTORY: explicit, CHANGE-BOUNDARY.
- For optimization/compression: also require OPTIMIZATION-ORDER: post-change-only, OPTIMIZATION-GUARD: zero-loss, PROTECTED-MEANING: checked.
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
- Wait for reuse/standby/release direction.

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
