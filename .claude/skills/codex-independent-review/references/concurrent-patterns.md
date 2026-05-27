---
PRIMARY-OWNER: codex-independent-review
SOURCE-ANCHOR: .claude/skills/codex-independent-review/SKILL.md
SOURCE-RULES: "dual-pattern parallel codex governance; Pattern A lane-internal aid; Pattern C team-lead-orchestrated official independent review; safeguards"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# Concurrent Codex Usage Patterns

## Purpose
Govern dual-pattern parallel codex usage:
- **Pattern A** = lane-internal OR lead-internal codex CLI invocation during own work, output NEVER transported via any carrier or transport surface.
- **Pattern C** = team-lead-orchestrated official configured independent review via `mcp__codex__codex` (foreground-blocking, synchronous, transportable); output transported per `references/common-contract.md` governance. Pattern C is foreground-only per common-contract.md `## Tool Discipline`; there is no parallel-execution Pattern C path.

Both patterns may run in same wall-clock time across team-runtime — Pattern C in team-lead foreground orchestration (synchronous mcp__codex__codex) + Pattern A in any already-dispatched lane's own Bash background invocation (lane variant) OR in team-lead's own Bash background invocation (team-lead variant) during own orchestration work. The two patterns share infrastructure (codex CLI / mcp__codex__codex) but have distinct authority etiquette + lifecycle.

## Pattern A — Internal Codex Aid (Lane + Team-Lead Variants)

### Definition
Pattern A has two variants:
- **Lane variant**: A lane (developer / researcher / reviewer / tester / validator) invokes `codex exec` or `codex review` via its Bash tool (with `run_in_background: true` permitted) during own assigned work for craftsmanship aid, debug assistance, or doctrine consultation.
- **Team-lead variant**: The team-lead invokes `codex exec` or `codex review` via its Bash tool for lead-internal orchestration aid during own work (decision-support, doctrine-consultation, draft-checking). See `### Team-Lead Variant` subsection below for additional team-lead-specific safeguards.

In both variants, the codex output exists only in the invoking owner's scratch directory or working memory.

### Authority + Transport Boundary
- Codex output produced via Pattern A is **lane-internal aid (lane variant)** or **lead-internal aid (team-lead variant)** only.
- Codex output **MAY NOT** appear in any transported surface — not in any completion carrier, not in `SendMessage` envelope or body, not in retained-output files cited by completion handoff, not in task state, not in any retained carrier consumed by downstream owners, not in any user-facing reporting surface, not in any synthesis carrier consumed by downstream owners.
- Codex output **verbatim text** MAY NOT appear in any transported surface. The invoking owner's work product may be conceptually informed by codex output; the owner's own framing, writing, and decision authority remain owner-owned. The owner's transported work product carries the owner's own evidence basis — not codex's.
- If the invoking owner needs to surface codex output verbatim or as direct evidence basis, that escalation routes to Pattern C (team-lead-orchestrated official independent review via `mcp__codex__codex`); the invoking owner cannot self-promote Pattern A codex output to transported evidence.

### Authority Non-Substitution (CRITICAL safeguard)
- Pattern A codex result **NEVER substitutes** for `Skill(review-verification)` packet at `Skill(self-verification)` Step 3 `PASS-2`. Pattern A is information-gathering supplement only; PASS-2 still requires actual `Skill(review-verification)` load + Step 14 packet citation per existing rule.
- Substituting Pattern A codex result for `review_verification_packet` is fabrication per `Skill(self-verification)` Step 3 anti-fabrication rule + Carrier-citation rule per `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules`.

### Team-Lead Variant — Additional Safeguards (Lead-Internal Codex Aid)

The team-lead's invocation of Pattern A (per the Definition section above) carries the same Authority + Transport Boundary, Authority Non-Substitution, Sub-command Enumeration, Context Limit, Resource Accounting, Failure Mode Handling, and Lifecycle + RESOURCE-CLEANUP rules as the lane variant. The following additional safeguards reflect the team-lead's proximity to user-facing surface + synthesis ownership:

- Pattern A output (team-lead variant) MAY NOT appear in any user-facing reporting surface, any retained synthesis carrier consumed by downstream owners (lane assignments, validator verdict carriers, final reports), any completion-grade transport, any reportable prose admitted by `.claude/reference/reporting-prohibition-law.md`, or any retained carrier or task-state field.
- Team-lead Pattern A is strictly self-orchestration aid (decision-support, doctrine-consultation, draft-checking). Pattern C remains the only path for "official independent review" producing transported evidence consumed by validator final arbitration or governance-modification basis.
- Team-lead synthesis carriers MUST cite their own evidence basis (Read/Grep/Bash tool-call evidence, lane completion carriers, validator verdicts, review-verification packets) — NOT Pattern A codex output. Citing Pattern A codex output as synthesis evidence is carrier-as-evidence fabrication per `Skill(self-verification)` Step 3 anti-fabrication rule + Receiver applicability rule + carrier-citation rule per `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules`.
- **Negative-Scope Boundary (Lead-Internal-Aid vs Frozen-Independent-Owner-Work)**: Pattern A team-lead variant scope is bounded by §6 Judgment Philosophy independent-specialist-lane separation; any work surface that has a frozen independent owner per §6 (including, open-set: review production, proof execution, final acceptance arbitration, or any lane whose ownership is established by §6 plus the team's frozen route) is OUTSIDE lead-internal aid scope and MUST route to that owner via `Skill(task-execution)` dispatch.
- Lead-internal aid (positive scope: decision-support / doctrine-consultation / draft-checking) operates only on work surfaces without a frozen independent owner and never produces outputs substituting for a frozen owner's work product; team-lead self-executing frozen-owner work under "lead-internal aid" classification is a boundary defect regardless of the specific lane.
- This negative-scope rule is additive to the three boundary clauses below (Authority Non-Substitution + Context Limit security + RESOURCE-CLEANUP); each applies independently.

### Team-Lead Variant — Pattern-A-Mediated CODEX-INDEPENDENT-REVIEW-BASIS (parallel-execution path for high-risk verdict class)

When validator SKILL Step 8 high-risk verdict class requires `CODEX-INDEPENDENT-REVIEW-BASIS` citation, team-lead's path choice is governed by parallel-execution need:

- **Pattern C direct path** (default): `mcp__codex__codex` synchronous foreground call; codex output is transportable per Pattern C governance. Trade-off: blocks team-lead orchestration + user-conversation-continuity during the call.
- **Pattern-A-mediated path** (parallel-execution alternative): team-lead invokes Pattern A team-lead variant via Bash background (`codex exec --run-in-background` or equivalent) in parallel with own orchestration, then transports **team-lead's own adjudication** (informed by Pattern A codex output but authored by team-lead with own evidence basis) as `CODEX-INDEPENDENT-REVIEW-BASIS`.

Pattern-A-mediated path safety conditions (ALL required for validator-acceptable basis):
- (i) Team-lead adjudication is owner-authored work product per existing Pattern A rule (own analysis, own evidence basis, own decision authority); codex Pattern A output informs but does NOT appear verbatim.
- (ii) Team-lead adjudication carrier explicitly records: Pattern A invocation identifier (codex CLI invocation tag, background process ID, or scratch-path reference for forensic trace); codex output summary in team-lead's own framing per-point; team-lead's per-point disposition with own evidence; record of which codex point informed which team-lead analysis line.
- (iii) Team-lead adjudication carrier marks `CODEX-BASIS-CLASS: Pattern-A-mediated` (distinct from `CODEX-BASIS-CLASS: Pattern-C-direct`) so validator and downstream owners see the basis class explicitly.
- (iv) Validator re-verification right: validator MAY independently re-invoke codex Pattern C (`mcp__codex__codex` direct) when material defeater suspected in team-lead's Pattern-A-mediated adjudication; validator escalation is non-blocking on team-lead (validator runs its own Pattern C check in parallel with team-lead's continued orchestration).
- (v) Pattern A negative-scope boundary preserved: Pattern A invocation MUST NOT target frozen-independent-owner work (review production / proof execution / final acceptance arbitration) per Negative-Scope Boundary above; codex consultation in Pattern-A-mediated path is for decision-support / doctrine-consultation / adjudication-aid on the team-lead's own adjudication work product, not for executing the owning lane's work.

Pattern-A-mediated path defects:
- Pattern A codex output verbatim in team-lead adjudication carrier → carrier-as-evidence fabrication per Authority + Transport Boundary above; the adjudication must be team-lead's own writing informed by codex, not codex verbatim transported under team-lead's name.
- Missing `CODEX-BASIS-CLASS: Pattern-A-mediated` marker → basis class invisibility defect; validator cannot apply Pattern-C-direct re-verification choice without the marker.
- Missing per-point invocation/output/disposition trace → forensic-trace defect; downstream owners cannot audit which codex point informed which team-lead analysis.

When path choice is open (no operator preference recorded), default is Pattern-A-mediated (preserves parallel orchestration capacity); Pattern C direct is selected only when codex verbatim transport is operator-directed or validator-specifically-required.

### Pattern C Team-Lead Parallel-Execution Choice

Team-lead's path to Pattern C output (transportable official independent review) is `mcp__codex__codex` direct invocation per Pattern C section below; this is foreground-blocking (synchronous, blocks team-lead orchestration during invocation).
Team-lead's path to PARALLEL-EXECUTION codex aid (preserving orchestration + user-conversation-continuity) is team-lead Pattern A (this Team-Lead Variant), NOT Pattern C.
The two paths therefore present an explicit either-or choice: foreground-blocking + transportable (Pattern C via `mcp__codex__codex`) vs parallel + non-transportable (Pattern A team-lead variant).
There is NO "team-lead Pattern C with parallel-execution" path — Pattern C is foreground-only per common-contract.md `## Tool Discipline`.

### Sub-command Enumeration
- Pattern A admissible sub-commands: `codex exec` (non-interactive run) + `codex review` (code review). These are one-shot non-interactive analysis modes suitable for lane evidence-gathering aid.
- Pattern A inadmissible sub-commands: `codex login`, `codex logout`, `codex mcp`, `codex plugin`, `codex mcp-server`, `codex app-server`, `codex remote-control`, `codex completion`, `codex update`, `codex doctor`. These are interactive / credential-handling / configuration / runtime-daemon / utility sub-commands outside Pattern A's evidence-gathering aid scope. Using these via lane Bash is governance violation.

### Context Limit (Security Boundary)
- Pattern A invocation: lane MUST limit codex context to the frozen `WORK-SURFACE` files named in the assignment packet (or files explicitly within `WRITE-SCOPE` for lane self-correction loops).
- Files containing secrets, credentials, auth tokens, private keys, or other security-sensitive material **MAY NOT** be passed as codex context.
- Out-of-scope files (files outside the frozen `WORK-SURFACE` and not explicitly authorized by assignment packet) **MAY NOT** be passed as codex context.
- Context limit violation invalidates the Pattern A invocation; any codex output from a violating invocation is inadmissible as lane-internal aid.

### Resource Accounting
- Pattern A invocations across multiple lanes share the codex API quota.
- Each lane is responsible for self-discipline regarding invocation count: invoke codex only for material craftsmanship aid; do not invoke for trivial questions answerable by lane-local reasoning.
- Unlimited invocation may exhaust quota → subsequent lane Pattern A invocations may fail → each lane bears the failure consequence.

### Failure Mode Handling
- codex CLI invocation may fail (network, quota, timeout, auth, parse, process error, etc.).
- On failure, the lane proceeds with own discipline without codex output — Pattern A is supplementary aid, not blocking.
- Pattern A invocation failure does NOT block lane completion. Lane completion proceeds per the lane's own evidence basis.

### Lifecycle + RESOURCE-CLEANUP
- Pattern A `codex exec` with `run_in_background: true` creates a long-running background process and may produce output files (logs, JSON results, scratch files).
- The lane MUST terminate the codex background process before lane completion per `.claude/skills/task-execution/references/completion-handoff.md` `## Common Completion Result Spine` RESOURCE-CLEANUP enumeration.
- The lane MUST clean up codex output files (logs, JSON, scratch artifacts) before lane completion as part of the same RESOURCE-CLEANUP discipline.
- Process termination + output file cleanup are both completion preconditions; missing either is a RESOURCE-CLEANUP defect blocking completion-grade transport.

## Pattern C — Team-Lead-Orchestrated Configured Independent Review

### Definition
Team-lead invokes `mcp__codex__codex` directly per team-lead role frontmatter. Output is transported through `references/common-contract.md` governance. Pattern C is foreground-blocking per common-contract.md `## Tool Discipline` ("Use only `mcp__codex__codex`") + line 35 ("Do not use shell `codex exec`, custom wrappers, worker lanes"). Team-lead's path to parallel-execution codex aid is Pattern A (see Team-Lead Variant subsection above), NOT a parallel Pattern C path.

### Authority + Transport
- Pattern C codex output is "official independent review" — full common-contract.md scope: Common Review Axes, Point Schema, Handling (Accept / Reject / Defer adjudication by team-lead).
- Pattern C output is transported per the configured-review consumer reference that opened the review (e.g., `references/wp-consult.md` for `WP-CONSULT` route-freeze; `dev-workflow/references/artifact-convergence-review.md` for artifact convergence; etc.).
- Pattern C output **DOES** appear in retained carriers consumed by team-lead synthesis and validator final arbitration.
- High-risk verdict class invocation per `.claude/skills/agent-validator/SKILL.md` Step 8 Completion `## High-risk verdict class mandatory external verification` (governance-asset patch acceptance / anti-fabrication-correction acceptance / recurrence-barrier-hardening acceptance / user-direct-correction-response acceptance) uses Pattern C; validator routes through team-lead when validator lane lacks `mcp__codex__codex` (per recently-patched mandate).

### Pattern C Governance Body
Owned at `references/common-contract.md` — Common Contract + Tool Discipline + Packet Contract + Common Review Axes + Point Schema + Handling. concurrent-patterns.md (this file) does not duplicate that body; this section is citation-only.

## External CLI Tools — Slippery-Slope Guard

This concurrent-patterns.md authorizes lane Bash invocation of **codex CLI specifically** for Pattern A. Other external CLI tools (e.g., other AI model CLIs, third-party analysis tools) remain governed by `Skill(external-tool-bridge)` per the lane Bash scope identity-layer wording "where the active operational skill body authorizes such invocation". Inlining other external CLIs into lane Bash scope requires a fresh `Skill(governance-modification)` cycle producing a new operational-layer authorization surface (analogous to this file's role for codex) — NOT interpretation extension of the codex authorization at this file.

## Infrastructure Limit — Codex Is Not A Team-Runtime Member

Codex CLI and `mcp__codex__codex` MCP tool are NOT Claude Code agent processes. They cannot be:
- registered as TeamCreate roster members
- addressed via SendMessage (no teammate inbox)
- spawned as parallel peer-class teammates via Agent tool

The closest achievable approximations to "codex as parallel teammate":
- `mcp__codex__codex` direct invocation (Pattern C) = synchronous foreground-blocking MCP tool call. Output transportable per common-contract.md governance; but parallel execution blocked during invocation and user-conversation-continuity blocked.
- `Bash(codex exec, run_in_background=true)` (Pattern A, lane or team-lead variant) = background process invocation. Parallel execution available; user-conversation-continuity preserved; codex output polled via BashOutput; codex is NOT a teammate, just a background process owned by the invoking owner. Output is non-transportable per Pattern A Authority + Transport Boundary.
- Team-lead dispatches a Claude Code lane as the teammate; the lane uses codex CLI via Pattern A (lane variant) as its own internal aid.
- The lane's WORK PRODUCT (lane's own framing/evidence/decision; NOT codex output) is transported normally per lane completion contract.
- This is NOT "team-lead Pattern C with parallel execution" — codex output stays lane-internal; only the lane's normal work product (which may be informed by codex aid) is transported.

This infrastructure limit is named here as a recurrence barrier against re-asking the same question. Treating codex as a SendMessage-addressable teammate is an infrastructure mismatch, not a governance gap. The dispatched-lane-with-Pattern-A approximation specifically does NOT produce transportable codex evidence; it produces transportable lane work product that codex informally aided.

## Cross-References
- `.claude/skills/codex-independent-review/references/common-contract.md` — Pattern C canonical contract body (this file does not duplicate)
- `.claude/skills/codex-independent-review/SKILL.md` — Pattern C activation triggers + workflow
- `.claude/skills/task-execution/references/completion-handoff.md` `## Common Completion Result Spine` — RESOURCE-CLEANUP enumeration (Pattern A codex background process)
- `.claude/skills/self-verification/SKILL.md` Step 3 — anti-fabrication + Pattern A non-substitution rule
- `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules` — Carrier-citation rule (covers Pattern A output → transport boundary)
- `.claude/skills/external-tool-bridge/SKILL.md` — slippery-slope guard for other external CLI tools

## Resolve Next Owner And Action
- Lane invoking Pattern A: load this file at codex CLI invocation moment; apply Pattern A rules; terminate process at lane completion.
- Team-lead invoking Pattern C: load `references/common-contract.md` (and target-specific reference) per existing workflow; concurrent-patterns.md cites separation but does not override Pattern C body.
- Pattern A invocation outside permitted sub-commands or context limits → governance violation; lane records `not-applicable:pattern-a-violation` for the invocation; invokes lane-local discipline.
- Pattern A output transport attempt → carrier-citation fabrication per `## Skill Rules`; reject at carrier authoring time.
