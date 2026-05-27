---
PRIMARY-OWNER: codex-independent-review
SOURCE-ANCHOR: .claude/skills/codex-independent-review/SKILL.md
SOURCE-RULES: "codex CLI background usage governance; lane-internal aid; team-lead-internal aid; safeguards"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# Codex CLI Background Usage

## Purpose
Govern codex CLI background usage as the sole codex consultation path per operator standing directive.
Codex CLI background invocation (lane-internal OR lead-internal) via Bash with `run_in_background: true` permitted during own work for craftsmanship aid, debug assistance, doctrine consultation, decision support, or evidence basis per operator standing directive.

## Codex CLI Background Usage (Lane + Team-Lead Variants)

### Definition
Two variants:
- **Lane variant**: A lane (developer / researcher / reviewer / tester / validator) invokes `codex exec` or `codex review` via its Bash tool (with `run_in_background: true` permitted) during own assigned work for craftsmanship aid, debug assistance, or doctrine consultation.
- **Team-lead variant**: The team-lead invokes `codex exec` or `codex review` via its Bash tool for lead-internal orchestration aid during own work (decision-support, doctrine-consultation, draft-checking). See `### Team-Lead Variant — Additional Safeguards` subsection below for additional team-lead-specific safeguards.

In both variants, the codex output exists in the invoking owner's scratch directory or working memory.

### Authority + Transport Boundary
- Codex output is **lane-internal aid (lane variant)** or **lead-internal aid (team-lead variant)**.
- Codex output is usable as evidence basis by the invoking owner per operator standing directive (background codex utilization).
- The invoking owner's transported work product MAY cite codex output as evidence basis, summarize codex points in transport-acceptable form, OR carry codex output verbatim with explicit `CODEX-SOURCE: <invocation-identifier>` marker so receivers see the codex provenance.
- The invoking owner remains the decision authority; codex output informs but does not substitute for the invoking owner's own judgment + framing where decisive owner authority applies.

### Authority Non-Substitution (CRITICAL safeguard)
- Codex result **NEVER substitutes** for `Skill(review-verification)` packet at `Skill(self-verification)` Step 3 `PASS-2`. Codex usage is information-gathering supplement only; PASS-2 still requires actual `Skill(review-verification)` load + Step 14 packet citation per existing rule.
- Substituting codex result for `review_verification_packet` is fabrication per `Skill(self-verification)` Step 3 anti-fabrication rule + Carrier-citation rule per `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules`.

### Team-Lead Variant — Additional Safeguards (Lead-Internal Codex Aid)

The team-lead's invocation (per the Definition section above) carries the same Authority + Transport Boundary, Authority Non-Substitution, Sub-command Enumeration, Context Limit, Resource Accounting, Failure Mode Handling, and Lifecycle + RESOURCE-CLEANUP rules as the lane variant. The following additional safeguards reflect the team-lead's proximity to user-facing surface + synthesis ownership:

- Team-lead codex output is usable as evidence basis in team-lead-authored carriers (synthesis, adjudication, validator routing) per operator standing directive (background codex utilization).
- Team-lead synthesis / adjudication carriers carrying codex output cite the codex invocation explicitly via `CODEX-SOURCE: <invocation-identifier>` (codex CLI tag, background process PID, or output-file path) so receivers see the codex provenance + can re-verify by reading the same source.
- Team-lead codex output retains its lead-internal-aid character; team-lead remains the decision authority + framing owner. Codex output is decision-support evidence the team-lead consumes; the team-lead's final decision + framing are team-lead's own work product.
- Team-lead carriers MAY also cite team-lead's own Read/Grep/Bash tool-call evidence + lane completion carriers + validator verdicts + review-verification packets alongside codex evidence; multiple evidence sources strengthen the basis.
- **Negative-Scope Boundary (Lead-Internal-Aid vs Frozen-Independent-Owner-Work)**: codex consultation team-lead variant scope is bounded by §6 Judgment Philosophy independent-specialist-lane separation; any work surface that has a frozen independent owner per §6 (including, open-set: review production, proof execution, final acceptance arbitration, or any lane whose ownership is established by §6 plus the team's frozen route) is OUTSIDE lead-internal aid scope and MUST route to that owner via `Skill(task-execution)` dispatch.
- Lead-internal aid (positive scope: decision-support / doctrine-consultation / draft-checking) operates only on work surfaces without a frozen independent owner and never produces outputs substituting for a frozen owner's work product; team-lead self-executing frozen-owner work under "lead-internal aid" classification is a boundary defect regardless of the specific lane.
- This negative-scope rule is additive to the boundary clauses below (Authority Non-Substitution + Context Limit security + RESOURCE-CLEANUP); each applies independently.

### Team-Lead Variant — Codex Background as CODEX-INDEPENDENT-REVIEW-BASIS (default path)

Per operator standing directive (codex utilized via background execution), team-lead variant Bash background invocation is the default path for `CODEX-INDEPENDENT-REVIEW-BASIS` citation when validator SKILL Step 8 high-risk verdict class requires codex basis.

Required for validator-acceptable CODEX-INDEPENDENT-REVIEW-BASIS:
- Codex invocation identifier (codex CLI invocation tag, background process PID, or scratch-path reference) recorded in the basis-citing carrier.
- Carrier marks `CODEX-SOURCE: <invocation-identifier>` so validator and downstream owners see the basis source.
- Negative-scope boundary preserved (codex invocation MUST NOT target frozen-independent-owner work per Negative-Scope Boundary above).

Validator re-verification right: validator MAY independently re-invoke codex via own Bash background path when material defeater suspected; validator escalation is non-blocking on team-lead.

### Sub-command Enumeration
- Admissible sub-commands: `codex exec` (non-interactive run) + `codex review` (code review). These are one-shot non-interactive analysis modes suitable for evidence-gathering aid.
- Inadmissible sub-commands: `codex login`, `codex logout`, `codex mcp`, `codex plugin`, `codex mcp-server`, `codex app-server`, `codex remote-control`, `codex completion`, `codex update`, `codex doctor`. These are interactive / credential-handling / configuration / runtime-daemon / utility sub-commands outside codex evidence-gathering aid scope. Using these via lane Bash is governance violation.

### Context Limit (Security Boundary)
- Codex invocation: lane MUST limit codex context to the frozen `WORK-SURFACE` files named in the assignment packet (or files explicitly within `WRITE-SCOPE` for lane self-correction loops).
- Files containing secrets, credentials, auth tokens, private keys, or other security-sensitive material **MAY NOT** be passed as codex context.
- Out-of-scope files (files outside the frozen `WORK-SURFACE` and not explicitly authorized by assignment packet) **MAY NOT** be passed as codex context.
- Context limit violation invalidates the codex invocation; any codex output from a violating invocation is inadmissible as lane-internal aid.

### Resource Accounting
- Codex invocations across multiple lanes share the codex API quota.
- Each lane is responsible for self-discipline regarding invocation count: invoke codex only for material craftsmanship aid; do not invoke for trivial questions answerable by lane-local reasoning.
- Unlimited invocation may exhaust quota → subsequent lane codex invocations may fail → each lane bears the failure consequence.

### Failure Mode Handling
- codex CLI invocation may fail (network, quota, timeout, auth, parse, process error, etc.).
- On failure, the lane proceeds with own discipline without codex output — codex usage is supplementary aid, not blocking.
- Codex invocation failure does NOT block lane completion. Lane completion proceeds per the lane's own evidence basis.

### Lifecycle + RESOURCE-CLEANUP
- Codex `codex exec` with `run_in_background: true` creates a long-running background process and may produce output files (logs, JSON results, scratch files).
- The lane MUST terminate the codex background process before lane completion per `.claude/skills/task-execution/references/completion-handoff.md` `## Common Completion Result Spine` RESOURCE-CLEANUP enumeration.
- The lane MUST clean up codex output files (logs, JSON, scratch artifacts) before lane completion as part of the same RESOURCE-CLEANUP discipline.
- Process termination + output file cleanup are both completion preconditions; missing either is a RESOURCE-CLEANUP defect blocking completion-grade transport.

## External CLI Tools — Slippery-Slope Guard

This concurrent-patterns.md authorizes lane Bash invocation of **codex CLI specifically**. Other external CLI tools (e.g., other AI model CLIs, third-party analysis tools) remain governed by `Skill(external-tool-bridge)` per the lane Bash scope identity-layer wording "where the active operational skill body authorizes such invocation". Inlining other external CLIs into lane Bash scope requires a fresh `Skill(governance-modification)` cycle producing a new operational-layer authorization surface (analogous to this file's role for codex) — NOT interpretation extension of the codex authorization at this file.

## Infrastructure Limit — Codex Is Not A Team-Runtime Member

Codex CLI is NOT a Claude Code agent process. It cannot be:
- registered as TeamCreate roster member
- addressed via SendMessage (no teammate inbox)
- spawned as parallel peer-class teammate via Agent tool

The closest achievable approximation to "codex as parallel teammate":
- `Bash(codex exec, run_in_background=true)` (lane or team-lead variant) = background process invocation. Parallel execution available; user-conversation-continuity preserved; codex output polled via BashOutput; codex is NOT a teammate, just a background process owned by the invoking owner.
- Team-lead dispatches a Claude Code lane as the teammate; the lane uses codex CLI background invocation as its own internal aid.
- The lane's WORK PRODUCT (lane's own framing/evidence/decision) is transported normally per lane completion contract.

This infrastructure limit is named here as a recurrence barrier against re-asking the same question. Treating codex as a SendMessage-addressable teammate is an infrastructure mismatch, not a governance gap.

## Cross-References
- `.claude/skills/codex-independent-review/SKILL.md` — codex usage activation triggers + workflow
- `.claude/skills/task-execution/references/completion-handoff.md` `## Common Completion Result Spine` — RESOURCE-CLEANUP enumeration (codex background process)
- `.claude/skills/self-verification/SKILL.md` Step 3 — anti-fabrication + codex non-substitution rule
- `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules` — Carrier-citation rule (covers codex output transport boundary)
- `.claude/skills/external-tool-bridge/SKILL.md` — slippery-slope guard for other external CLI tools

## Resolve Next Owner And Action
- Lane invoking codex CLI background: load this file at codex CLI invocation moment; apply codex usage rules; terminate process at lane completion.
- Codex invocation outside permitted sub-commands or context limits → governance violation; lane records `not-applicable:codex-usage-violation` for the invocation; invokes lane-local discipline.
- Codex output transport without `CODEX-SOURCE:` marker on transported carrier → marker missing; correct the carrier.
