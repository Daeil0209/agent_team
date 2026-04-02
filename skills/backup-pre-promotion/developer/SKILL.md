---
name: developer
description: Standard implementation procedure for the developer lane when executing bounded approved edits within an assigned shard, task, or file scope.
user-invocable: false
---

# Developer

This skill defines the repeatable implementation procedure for the `developer` lane. Keep role identity, authority boundaries, and completion ownership in `.claude/agents/developer.md`; use this file for the detailed execution workflow.

## Procedure Preconditions

- Use only after `team-lead` or an active delegated `planner` has assigned a bounded implementation scope. Ordinary planning-support `planner` guidance is not execution authority by itself.
- Use this skill for approved implementation work inside an explicit task, shard, file set, or similarly bounded surface.
- Stay inside the assigned scope unless the lead explicitly reassigns it.
- If the assigned work is a file-list copy, overwrite, or sync manifest, require the dispatch packet to make these fields explicit before execution:
  - `TASK-CLASS: manifest-sync`
  - `MANIFEST-UNIQUE: <count>`
  - `OVERLAP-REVIEW: done`
  - `PRE-EXEC-REVIEW: done`
  - `WRITE-SCOPE: <unique target set>`
- If the manifest work is intentionally sharded, also require:
  - `SHARD-ID: <shard id>`
  - `SHARD-SET: disjoint`
- If any of those fields are missing, or if the shard write scope is not clearly disjoint, stop and escalate instead of starting edits.
- If the assigned surface is governance-sensitive, require the change packet to make the pre-execution sequence explicit before any edit begins:
  - `TASK-CLASS: governance-patch`
  - `SEQUENCE: change|self-growth|update-upgrade`
  - `PATCH-CLASS: hardening|structural-normalization|migration-rehome|config-owner-standardization|skill-up|new-skill|follow-on-optimization`
  - `OWNER-SURFACE: <owner files>`
  - `BASELINE-CLASS: preserved-asset|improvement-target|stability-anchor`
  - `INFO-LOSS-REVIEW: done`
  - `BALANCE-REVIEW: local-context-checked`
  - `RELATED-DOC-REVIEW: adjacent-owner-surfaces-checked`
  - `PATCH-REVIEW: pre-exec-done`
  - `MODIFICATION-PROPOSAL: explicit`
  - `SOURCE-MEANING-INVENTORY: explicit`
  - `DESTINATION-OWNER-MAP: explicit`
  - `CHANGE-BOUNDARY: <bounded intended delta>`
  - `VERIFY-BASIS: <review or verification basis>`
- Treat additions, deletions, rewrites, migrations, compressions, and optimizations all as governance modifications with loss risk. Do not improvise a shorter packet just because the requested change is framed as cleanup or a small follow-up.
- When optimization, compression, deduplication, rewrite, or self-growth optimization is in scope, also require:
  - `OPTIMIZATION-ORDER: post-change-only`
  - `OPTIMIZATION-GUARD: zero-loss`
  - `PROTECTED-MEANING: checked`
- When that governance modification targets `CLAUDE.md`, `agents/team-lead.md`, `skills/team-governance-sequences/SKILL.md`, `skills/team-session-sequences/SKILL.md`, runtime hooks, or `settings.json`, also require:
  - `SESSION-REVALIDATION: current-session-repo`
  - `BASELINE-ANCHOR: captured`
- If those governance packet fields are missing, stop and escalate instead of improvising a shorter path.
- If the governance patch is running under `SEQUENCE: self-growth`, also require:
  - `CAPABILITY-SIGNAL: <why this self-growth topic exists>`
  - `INSPECT-LANES: <lanes that inspected the topic>`
  - `OWNER-ROUTING: existing-owner|single-fit|competitive-bid`
  - `BALANCE-GUARD: average-capability-protected`
  - `BENCHMARK-MODE: light|full`
  - `BENCHMARK-BASIS: <baseline or simpler-path basis>`
  - `BENCHMARK-SURFACE: <what is being compared>`
  - `BENCHMARK-PROVENANCE: repo-observed|authoritative-external|mixed|simulator-only`
  - `CROSS-CHECK-STATUS: repo-confirmed|authority-confirmed|mixed-confirmed|simulator-unconfirmed`
  - `HALLUCINATION-GUARD: cite-or-hold`
  - `MODIFICATION-PROPOSAL: explicit`
  - `CHANGE-BOUNDARY: <bounded intended delta>`
- In self-growth work, benchmark evidence does not authorize edits by itself. The sequence stays explicit: benchmark -> cross-check and anti-hallucination confirmation -> concrete modification proposal -> pre-edit loss-risk gate -> bounded modification -> verification -> only then optimization.
- If `PATCH-CLASS: new-skill|skill-up` or `OWNER-ROUTING: competitive-bid`, upgrade that packet to the full benchmark form and also require:
  - `BENCHMARK-MODE: full`
  - `BENCHMARK-SKILL: bench-sim`
  - `BENCHMARK-BASELINE: <before path or incumbent owner>`
  - `BENCHMARK-AXIS: fairness|promotion-gate|competitiveness|average-capability`
  - `BENCHMARK-EVIDENCE: simulator-only|repo-local|live-task|mixed`
- If `PATCH-CLASS: new-skill|skill-up`, also require:
  - `GROWTH-PATH: existing-skill-expansion|new-skill-introduction|agent-charter-hardening|path-scoped-governance-rule|role-routing-correction`
- If `PATCH-CLASS: new-skill`, also require the category gate packet:
  - `SKILL-CATEGORY: repeatable-procedure|specialist-judgment-surface|integration-environment-bridge|governance-quality-hardening`
  - `REUSE-PATTERN: <expected reuse pattern>`
  - `OVERLAP-RESULT: <existing-owner overlap result>`
  - `CHOSEN-OWNER: <chosen owner>`
  - `EXPANSION-INSUFFICIENCY: <why existing skill expansion was insufficient>`
  - `FIRST-ADOPTION-PATH: <first adoption path>`
- If `OWNER-ROUTING: competitive-bid`, also require:
  - `BID-CANDIDATES: <candidate owners>`
  - `BID-BASIS: ownership-fit|overlap-cost|throughput-effect|evidence-quality|rollback-path`
  - `ADJUDICATION-BASIS: durable-ownership-fit|acceptance-reliability|coordination-cost|neighbor-regression-risk|long-run-cumulative-team-benefit`
- If those benchmark fields are missing, stop and escalate instead of letting a comparative growth claim proceed on memory or habit alone.
- If benchmark discipline is present but the modification proposal or change boundary is still vague, stop and escalate instead of jumping from comparison to edits.
- If the packet still says `BENCHMARK-PROVENANCE: simulator-only` or `CROSS-CHECK-STATUS: simulator-unconfirmed`, stop and escalate. That is benchmark-stage `HOLD`, not edit-readiness.
- When self-growth or capability hardening is the active reason for the patch, preserve the baseline anchor, intended before/after delta, and still-pending follow-on optimization status in the implementation handoff so downstream lanes can judge whether the lane actually improved rather than merely stayed green.
- If the post-change surface is clean but before/after evidence or required follow-on optimization closure is still missing, do not label the result as promotion-ready.
- For consequential corrective or design work, require the solution-development packet before execution starts:
  - `INFO-LOSS-REVIEW: done`
  - `SOURCE-MEANING-INVENTORY: explicit`
  - `DESTINATION-OWNER-MAP: explicit`
  - `CHANGE-BOUNDARY: <bounded intended delta>`
  - `VERIFY-BASIS: <review or verification basis>`
  - `PROBLEM-CLASS: instance|structural|systemic`
  - `ROOT-CAUSE-BASIS: confirmed|supported|hypothesis|unknown`
  - `SOLUTION-PASS: 1|2|3`
  - `DECISION-BASIS: <why this path was selected>`
  - `REJECTED-OPTIONS: <alternatives considered and rejected>`
- For `PROBLEM-CLASS: structural|systemic`, also require:
  - `SOLUTION-PASS: 2|3`
  - `ALTERNATIVE-REVIEW: done`
  - `SELECTED-SCOPE: class-fix|system-fix|staged-class-fix`
- For `SOLUTION-PASS: 2|3`, also require:
  - `PASS-DELTA: <what improved after the challenge pass>`
- When `ROOT-CAUSE-BASIS` is `hypothesis` or `unknown`, also require:
  - `COMPETING-HYPOTHESES: <plausible alternatives>`
- If the wording already signals recurrence, architecture, doctrine, or hardening pressure, do not relabel the work as `instance` to escape the stronger gate.
- If `SELECTED-SCOPE: staged-class-fix`, also require:
  - `FOLLOW-UP-OWNER: <owner of the next hardening pass>`
- If those solution-development fields are missing, stop and escalate instead of executing the first plausible fix path by habit.
- If the assigned implementation is a request-bound artifact whose value depends on answering a defined question or supporting a defined decision, also require the request-fit packet before drafting or revision starts:
  - `REQUEST-INTENT: <operator ask or downstream action>`
  - `CORE-QUESTION: <single dominant question>`
  - `REQUIRED-DELIVERABLE: <artifact and format>`
  - `PRIMARY-AUDIENCE: <reader or operator>`
  - `EXCLUDED-SCOPE: <what should not take over the artifact>`
- If the assigned implementation is a visualized, office-format, or page-read human-facing artifact, also keep both review modes explicit before drafting or revision starts:
  - `REVIEW-OWNER: reviewer`
  - `PROOF-OWNER: tester`
  - `ACCEPTANCE-OWNER: reviewer|validator`
  - text review for wording, logic, and request-fit
  - capture-render review for rendered usefulness and page-read quality
- Do not let one of those review modes stand in for the other just because the artifact opens cleanly or reads well in extracted text.
- Preserve the operator's named subject at the same abstraction level when interpreting `CORE-QUESTION`; do not silently rewrite a broad ask as one subtype or favorite example.
- If the draft must branch through a subtype assumption, make that branch explicit instead of presenting the narrowed scope as the original request.
- Use `REQUIRED-DELIVERABLE` to keep the main answer surface separate from optional source appendices, evidence logs, or follow-on annexes.
- If those request-fit fields are missing, stop and escalate instead of replacing the missing user intent with generic background, broad completeness, or template habit.

## Escalation Routing

- If the task is underspecified, stop and escalate to `team-lead`.
- If `planner` is actively managing the assigned scope, report the issue through that lane as well.
- Escalate immediately before editing when any of the following is true:
  - the change touches 3 or more files across modules
  - the change introduces a new inter-module dependency
  - the change modifies a shared interface contract
  - the change conflicts with a pattern reused in 5 or more places
- Do not self-certify high-risk work. Handoff to `reviewer` or `tester` when acceptance risk is present.

## Specialist Skill Use

- Load a specialist skill only after explicit authorization from `team-lead`, or from `planner` when planner is clearly acting inside delegated sub-manager scope for the assigned work.
- Specialist skills in this repository are developer-exclusive execution aids. Other lanes may request or approve them, but direct loading belongs to `developer`.
- Runtime authorization packet format:
  - `team-lead` approval: `SKILL-AUTH: lane=developer:<lane-id>; surface=<blocked-surface>; skill=<skill-id>`
  - `team-lead` delegation grant to `planner`: `SKILL-AUTH-DELEGATION: lane=planner:<lane-id>; surface=<blocked-surface>; skill=<skill-id>`
  - delegated `planner` approval: `SKILL-AUTH-DELEGATED: lane=developer:<lane-id>; surface=<blocked-surface>; skill=<skill-id>`
- Runtime approvals are lane-scoped and single-use for one explicitly named blocked surface in the current session. If the same specialist skill is needed again on a later blocked surface, require a fresh authorization packet.
- A `planner`-issued delegated approval is valid only when `team-lead` has already granted the matching `SKILL-AUTH-DELEGATION` for that same planner lane, blocked surface, and specialist skill.
- Do not keep multiple outstanding approvals for the same developer lane and specialist skill in one session. Consume or close the current blocked surface before requesting another packet for that same lane and skill.
- Once that authorization exists, prefer loading the relevant skill over spawning a separate specialist lane by default.
- Resolve the approved `skill-id` using the current project skill root and the active specialist skill subpath defined in `CLAUDE.md`.
- Treat developer-exclusive specialist skills as skills, not standalone operating lanes. If one of those skills needs hardening, expansion, or repair, `developer` is the default skill-up owner because `developer` is the consuming execution lane.
- If the blocked surface, expected specialist output, or reason the base developer lane is insufficient is still vague, return `HOLD` and clarify that packet before loading a specialist skill.
- Typical specialist-skill examples:
  - `bench-sim` for fair before/after comparison, competitiveness checks, promotion-gate evaluation, and leaner-path challenge
  - `sw-spec` for architecture boundaries, persistence contracts, and hard logic paths
  - `biz-sys` for workflow rules, authority boundaries, and state semantics
  - `doc-auto` for document-generation structure or automation constraints
  - `ui-ux` for rendered composition or operator-facing workflow clarity
  - `edu-spec`, `eng-spec`, or `math-spec` for domain-specific correctness
- Scenario-family routing defaults:
  - Institutional event planning, lab retreats, and operational gatherings usually mean `biz-sys` locks purpose, feasibility, and constraint logic before `doc-auto` finalizes generation structure; add `ui-ux` only when rendered logistics visuals materially affect acceptance.
  - R&D proposals, result reports, and schedules usually mean `biz-sys` locks strategy, fact/design boundaries, and workflow constraints before `doc-auto` locks section structure and compression; add `ui-ux` when report or slide visuals materially affect acceptance.
  - Research reports, survey reports, and patent landscapes usually pair `researcher` evidence shaping with `doc-auto` report-generation structure; add `ui-ux` when comparison visuals or landscape composition materially affect acceptance.
  - Spreadsheet-to-system operational tools and management dashboards usually mean `biz-sys` locks workflow/state meaning, `sw-spec` locks architecture and persistence, and `ui-ux` locks operator-facing composition.
- When multiple specialist skills are active on one blocked surface, apply the shared locking order from `CLAUDE.md` rather than letting later polish-oriented skills freeze the artifact before workflow, architecture, and domain constraints are stable.
- Use a specialist skill to sharpen implementation judgment inside the assigned scope, not to silently widen ownership.
- Do not self-initiate specialist-skill loading for convenience or curiosity when that specialist perspective was not part of the approved implementation path.
- If the work needs an independent authority, a separate evidence packet, or a reusable long-running lane, escalate to `team-lead` instead of pretending a skill load is equivalent to a new owner.
- When messaging a peer worker, default to challenge, counterexample, or bounded handoff pressure rather than cooperative scope-setting. If ownership, acceptance, routing, or task control would change, escalate to `team-lead` or delegated `planner` instead of negotiating it laterally.
- If the assigned work is blocked because a required reusable skill does not exist yet, stop implementation and escalate. Do not continue with an ad hoc workaround once the missing skill has been identified as a prerequisite for finishing the task safely or credibly.
- When a specialist skill upgrade is approved as prerequisite work, complete that skill-up first, then resume the blocked implementation surface and finally run the required bounded optimization pass without lowering the improved quality bar.

## Implementation Workflow

Use the assigned scope and the standard `Change Sequence` from `CLAUDE.md` and shared governance skills as the governing path.

### 1. Confirm Assigned Scope

- Restate the assigned scope to yourself before editing.
- Confirm the intended execution mode:
  - proposal-only / diff-only
  - apply / execution
- If the requested work exceeds the assigned boundary, stop and escalate rather than silently widening scope.

### 2. Pre-Implementation Discovery Checklist

Mandatory pre-edit checks before creating or modifying implementation content:

1. **Runtime hygiene check** (`governance-sensitive surfaces only`)
- If the assigned surface is doctrine, agents, skills, settings, hooks, or the patch ledger, verify that previous setup logs and known runtime-owned residue have already been reinitialized for the current session.
- Treat stale violation, permission, session-end, auto-memory, and similar setup residue as non-authoritative until the current environment has been cleaned and revalidated.
- If cleanup or environment reconciliation is still pending, stop before `Edit` or `Write` and route that need back through the governing patch method.

2. **Existence check**
- Use `Grep` for names and synonyms before creating new files, functions, classes, constants, or helpers.

3. **Convention check**
- Use `Glob` and adjacent file inspection to match naming, placement, and structural conventions.

4. **Consumer check**
- Use `Grep` to estimate reference count and impact radius.
- If the target has a broad dependency surface, flag that risk before editing.

5. **Test coverage check**
- Use `Glob` to locate covering tests or the nearest test surfaces.

6. **Config key check**
- Search for existing definitions before introducing new keys, flags, or constants.

### Tool Selection For Discovery

| Need | Tool | Mode |
|---|---|---|
| Find files by name | `Glob` | - |
| Find symbol usage | `Grep` | content |
| List referencing files | `Grep` | files_with_matches |
| Count references | `Grep` | count |
| Understand file context | `Read` | - |

### Discovery Anti-Patterns

- Creating a helper when an equivalent one already exists
- Adding a constant or config key already defined elsewhere
- Editing a shared file without checking consumer count
- Breaking local naming or placement conventions
- Duplicating logic instead of extending an existing pattern

### 3. Pre-Edit Analysis Gate

Mandatory after discovery and before any `Edit` or `Write`:

1. Read the target section completely, not only the lines you plan to touch.
2. Check for semantic duplication against the target file and governing doctrine already in scope.
3. Perform explicit loss-risk analysis:
- Would the new edit overwrite, displace, or obscure existing valuable content?
- If repeated owner, lane, or acceptance-gate text keeps the file understandable in isolation, treat that local restatement as protected meaning rather than cosmetic duplication. Optimization, compression, cleanup, or rewrite instructions do not waive this protected-restatement check.
- If the work is resuming high-traffic governance optimization after a fresh session, reset, restart, or pause-return, do not rely on remembered prior review. Rebuild the current-session review packet from repository state before any edit.
- If the work is a request-bound artifact, check request-fit loss as well: would the draft stop answering the assigned `CORE-QUESTION`, bury the answer under supporting context, or let excluded scope take over the artifact?
4. Perform local-context balance review:
- Read the immediately adjacent owner surfaces that define, consume, or restate the same contract.
- Check whether the proposed edit would leave neighboring doctrine, skill, agent, or hook text semantically out of sync.
- If the patch changes a shared packet, sequence, or ownership rule, identify the nearby files that must stay aligned before editing.
5. Gate decision:
- If both checks pass, continue.
- If either fails, stop and report the finding with a narrower proposal or alternate placement.

#### Pre-Edit Anti-Patterns

- Write first, justify later
- Keyword-only duplication checks without semantic review
- Assuming the approved plan removes the need for execution-time checks

### 3A. Durability Gate

Mandatory after analysis gate and before any edit or proposal when the assigned work involves a fix, correction, or workaround.

#### Fix-Type Classification

Classify the intended change before execution:

| Fix type | Definition | Proceed? |
|---|---|---|
| `root-cause` | Addresses the verified origin of the defect | Yes |
| `symptom-relief` | Reduces visible impact without addressing the origin | Yes, with explicit disclosure |
| `hypothesis-based` | Addresses a plausible but unconfirmed cause | Yes, with explicit HOLD on verification |
| `open` | Cause unknown; change is exploratory | HOLD — escalate for guidance |

#### HOLD Conditions

- `open` fix type requires escalation before execution.
- `hypothesis-based` fix type requires the hypothesis and its falsification criteria to be stated in the handoff.
- `symptom-relief` fix type requires the known root cause or the reason root-cause is unavailable to be stated in the handoff.
- If fix type cannot be classified, treat as `open`.

#### Durability Gate Anti-Patterns

- Applying a symptom fix and reporting it as root-cause resolution
- Skipping classification because the fix "looks obvious"
- Treating hypothesis confirmation as someone else's problem

#### Quick Root Cause Analysis (5 Whys)

When fix type is `hypothesis-based` or `open`, apply before escalation:

1. State the visible symptom.
2. Ask "why?" and record the answer.
3. Repeat up to 5 times or until the answer points to a systemic cause.
4. If the chain reaches an actionable root cause, reclassify the fix type.
5. If the chain loops or dead-ends, keep the fix type and escalate with the chain attached.

Record the chain in the handoff so the reviewer can evaluate root-cause confidence.

### 4. Proposal-Only Or Diff-Only Branch

- If the assigned execution mode is proposal-only or diff-only:
  - do not use `Edit` or `Write`
  - produce a bounded implementation proposal based on discovery and analysis
  - identify the intended touched files, change surface, and key risks
  - hand off for review or apply authorization
  - wait for explicit next direction instead of treating the proposal as executed work

### 4A. Retry Governance

When a previous attempt at the same change failed or was rejected:

- Before retrying, state explicitly what failed and why.
- Identify what has changed since the last attempt that makes this retry meaningful.
- Do not retry with the same approach that already failed without a changed corrective basis.
- Maximum 3 retry attempts on the same bounded change before mandatory escalation to `team-lead`.
- On each retry, the reflection must be visible in the handoff — not hidden or implicit.

#### Retry Anti-Patterns

- Retrying immediately without diagnosing the failure
- Changing cosmetic details while repeating the same structural error
- Treating a retry count as someone else's responsibility to track

### 5. Execute The Bounded Change

- Apply only the approved bounded change.
- Keep diffs minimal, local, and reversible.
- Prefer concrete implementation over speculative expansion.
- Preserve existing architecture and conventions unless structural change was explicitly assigned.
- When multiple files must be read before editing, prefer parallel reads.

### 6. Pre-Handoff Integrity Verification

Mandatory after editing and before handoff:

1. No broken imports or missing local references
2. No contradictory logic, unreachable branches, or obvious infinite loops
3. New or changed functions remain callable from expected call sites
4. No syntax fragments, malformed blocks, or trailing partial edits
5. No dead references to renamed or removed symbols

### 7. Handoff And Wait State

- Report:
  - current execution mode (`proposal-only`, `diff-only`, or `applied`)
  - what changed
  - why it changed
  - touched files
  - known risks
  - blockers
  - what should be reviewed or tested next
- If execution could not proceed cleanly because of scope ambiguity, ownership ambiguity, or boundary overrun, state that the next step is managerial clarification rather than pretending the result is review-ready.
- Keep the handoff concise and implementation-focused.
- When the scope is complete, do not assume the next task.
- Wait for explicit reuse, standby, retask, or release direction from `team-lead` or delegated `planner`.

## Supervisor Query Protocol

When `team-lead` asks for status, judgment, or a continue / stop / retask recommendation while you are active:

- Pause at the nearest safe boundary.
- Reply with:
  - current subtask
  - approximate progress
  - active risks
  - preserved state
  - recommended continue / stop / retask action
- Remain paused until the lead responds explicitly.

## Active Communication Protocol

- After handoff content is prepared, actively deliver it via `SendMessage` to the governing lane (`team-lead` or delegated `planner`). Passive output availability alone is not sufficient — the lead cannot see worker internal state without an explicit message.
- When receiving a correction, redirect, or scope adjustment from the governing lane during active work, acknowledge receipt explicitly via `SendMessage` before continuing with the adjusted scope. If the correction conflicts with work already committed, report the conflict and current state.
- When approaching turn-budget exhaustion (within the last ~5 turns), proactively report via `SendMessage`: current progress, preserved state, incomplete surfaces, and what a successor worker would need to continue. Do not exhaust turns silently.
- When a blocker prevents continued execution, send `SendMessage` to the governing lane immediately with: blocker description, what was attempted, and what unblock step is needed. Do not wait for handoff or supervisor query.
- Do not redirect peer workers directly with new scope or control instructions. If another lane needs to be engaged, corrected, or rerouted, send that issue to the governing lane and let the governed dispatch chain carry the change.
- When bounded peer advice or challenge is genuinely needed on a local issue, keep the packet explicit: `PEER-MODE: bounded-advice|challenge`, `MESSAGE-PRIORITY: normal|high|critical`, `SURFACE-BOUNDARY: <local issue>`, `NO-OWNERSHIP-CHANGE: true`, `NO-ACCEPTANCE-CHANGE: true`, `ESCALATE-IF-UNRESOLVED: true`.

#### Anti-Patterns

- Silent idle — going idle without sending any handoff, progress, or blocker message — is a communication failure.

## Changeset Separation Discipline

When a task mixes multiple change types, keep edit units separable whenever practical.

### Change Type Examples

- translation or conversion
- removal
- addition
- modification

### Separation Rules

- When 2 or more change types affect the same file, prefer distinct edits with clear boundaries instead of one blended rewrite.
- In the handoff, separate change types when that distinction matters for review.
- If one edit must combine tightly coupled removal and replacement, state that coupling reason in the handoff.

## Technical Implementation Standards

### Test-Adjacent Discipline

- When the assigned scope creates new logic paths, check whether covering tests exist or should be proposed.
- If test infrastructure exists in the project, follow existing test conventions for naming, placement, and assertion style.
- When the assigned scope modifies existing logic, check whether existing tests still pass conceptually after the change.
- If test creation is not part of the assigned scope but is materially needed, flag it in the handoff as a recommended follow-up.

### Code Quality Baseline

- Prefer explicit over implicit: named constants over magic numbers, descriptive variable names over abbreviations, clear control flow over clever shortcuts.
- Keep functions focused: one function should do one well-defined thing.
- Handle errors explicitly: do not silently swallow errors or exceptions.
- Preserve existing error handling patterns unless the assigned scope explicitly includes error handling changes.
- When adding dependencies, verify they are already available in the project before importing.

### SOLID Principles Quick Reference

Apply when designing or modifying class structures, module boundaries, or interface contracts:

| Principle | Check Question |
|---|---|
| Single Responsibility | Does this unit have exactly one reason to change? |
| Open/Closed | Can behavior be extended without modifying existing code? |
| Liskov Substitution | Can subtypes replace their base without breaking callers? |
| Interface Segregation | Are callers forced to depend on methods they don't use? |
| Dependency Inversion | Do high-level modules depend on abstractions, not concrete implementations? |

- Violation of any principle in new code is a pre-handoff integrity finding.
- In existing code, record the violation as a non-blocking observation unless the assigned scope includes refactoring.
- Do not refactor for SOLID compliance outside the assigned scope.

### Fact And Design Boundary

When the assigned work involves generating content that mixes factual claims with designed or projected elements:

- Clearly distinguish facts (verifiable from existing evidence) from design elements (proposed, projected, or generated).
- Do not fabricate performance metrics, test results, verification data, or quantitative claims.
- When generating projected content, calibrate depth to input specificity:
  - detailed input → summarize and structure
  - standard input → generate proportionally
  - sparse input → supplement carefully with explicit assumptions marked
- State the generation basis in the handoff so reviewers can verify the fact/design boundary was maintained.

## Skill Maintenance Rule

- When this skill itself is being patched, preserve role-owned implementation procedure here and keep shared doctrine in `CLAUDE.md`.
- If a proposed addition mostly restates repository-wide or team-wide doctrine, trim it or move it back to the correct owning document.
- When patching governance-sensitive assets such as doctrine, agents, skills, settings, or hooks, follow the `Patch Execution Method` in `team-governance-sequences` and make the patch class, owner surface, preserved meaning, and verification basis explicit in the handoff.
- For governance-sensitive patches, keep the active preservation packet and verification basis explicit enough that another model can reconstruct the patch from repository state alone without a dedicated patch-ledger file.
- If the patch raised capability, expanded doctrine, or hardened a reusable asset, do not close on the quality-raising change alone. Complete the required bounded follow-on optimization pass, or explicitly record that no further safe optimization was available without lowering quality or dropping protected meaning.
- If any hardening or migration gap remains after the patch, assign that gap to a concrete owner in the handoff or continuity state instead of leaving it implicit.
