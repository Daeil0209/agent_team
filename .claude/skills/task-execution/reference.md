---
name: task-execution-reference
PRIMARY-OWNER: team-lead
auto-inject: false
---

# task-execution — Reference Catalog

> **Not auto-injected.** This file does NOT load automatically when the `task-execution` skill activates.
> Load explicitly via `Read` when you need dispatch packet field specifications, compliance lookup tables, or governance-patch packet tier definitions.
> Referenced in SKILL.md at: § Pre-Dispatch Scope Check (items 10–13), § Dispatch Packet Compliance, § Task Decomposition Protocol. Full sections for Dispatch Packet And Authority Boundaries and Agent Dispatch Discipline are housed here.
> Also referenced in work-planning/SKILL.md at: § Step 1 Q3 (Deliverable-Type Workflow Reference table).

---

## Governance-Patch Packet Tiers

| Tier | Criteria | Fields Required |
|------|----------|----------------|
| Standard | Single-file, compliance fix, typo, clarification, wording | developer-general + TASK-CLASS: governance-patch + CHANGE-BOUNDARY + WRITE-SCOPE |
| Structural | Multi-file, new sections, meaning migration, architecture | Standard + BASELINE-CLASS + EDIT-OPERATION. For migration: CHANGE-BOUNDARY must include source-meaning inventory + cross-reference list |
| New capability | skill-up / new-skill | Full self-growth fields — see § Developer (self-growth) below |

---

## Deliverable-Type Workflow Reference

This table supports Q3 judgment in `work-planning` Step 1. It is a reference aid, not a rigid lookup. When Q3 judgment is unclear, ask the user rather than forcing a match.

| Deliverable Type | Governing Workflow | Typical Methodology Skills |
|---|---|---|
| Web/mobile application | dev-workflow | ui-ux, design-token, biz-sys |
| CLI tool / library / API | dev-workflow | sw-spec, code-quality |
| Data pipeline / ETL system | dev-workflow | eng-spec, biz-sys |
| Spreadsheet/workflow conversion to software | dev-workflow | biz-sys, ui-ux |
| Technical report / analysis report | doc-auto | eng-spec, math-spec |
| User manual / operation guide | doc-auto | ui-ux, biz-sys |
| Business report | doc-auto | biz-sys |
| Presentation | doc-auto | ui-ux |
| Single bug fix / small patch | none (Lightweight) | code-quality |
| Research / investigation | none (researcher dispatch) | domain-specific |
| Governance change | none (self-growth-sequence) | — |
| Design mockup only | none (methodology skills) | ui-mockup, ui-ux, design-token |
| Engineering calculation | none (methodology skills) | eng-spec, math-spec, bench-sim |

---

## Dispatch Packet Templates

All downward `message-class: assignment` dispatches require the base packet plus the target-specific additions below. Governance-patch, manifest-sync, and solution-development task-classes are exempt from the User-Perspective Acceptance Gate.

### Base (all worker lanes — downward: lead → worker)

`MESSAGE-CLASS: assignment|control|reroute|reuse|standby; MESSAGE-PRIORITY: normal|high|critical; WORK-SURFACE: <surface>; ACTIVE-WORKFLOW: <skill-id|none>; CURRENT-PHASE: <phase|n/a>; REQUIRED-SKILLS: work-planning(start), self-verification(plan-verify, handoff)`

`REQUIRED-SKILLS`, `ACTIVE-WORKFLOW`, and `CURRENT-PHASE` are **assignment-grade clean-packet fields** only. Lifecycle control messages (`MESSAGE-CLASS: control` with `LIFECYCLE-DECISION` field) use the minimal lifecycle packet (see §Task Identity And Communication Protocol below) and do not require the full base packet. Reroute and reuse messages are assignment-grade and should carry the full base packet when practical.

Dispatch-proof hook enforcement is advisory for outgoing team-lead packet shape. Missing or approximate clean-packet fields should not by itself block `Agent` dispatch when the lane, intent, and safe boundary are inferable. The receiving worker must reconstruct the working packet explicitly before execution, and must return `MESSAGE-CLASS: hold` when missing fields create material ambiguity in scope, authority, proof target, acceptance basis, or lifecycle.

### Developer (general)

base + `PLAN-STATE: ready|approved|updated|revalidated; PLAN-STEP: <step>; ACCEPTANCE-RISK: low|meaningful|high|critical; REVIEW-OWNER: reviewer; PROOF-OWNER: tester|not-needed; ACCEPTANCE-OWNER: reviewer|validator|not-needed; CHANGE-SPEC: <bounded-change|first-draft|integration>; SKILL-RECOMMENDATIONS: applicable skills with rationale or none`

For `ACCEPTANCE-RISK: low` — `ACCEPTANCE-OWNER: reviewer` (quality gate, no formal PASS/HOLD/FAIL verdict required) or `not-needed`. For `ACCEPTANCE-RISK: meaningful|high|critical` — `ACCEPTANCE-OWNER: validator` (formal verdict required): `PROOF-OWNER: tester; ACCEPTANCE-OWNER: validator`

For executable, user-facing software deliverables:
- minimum `ACCEPTANCE-RISK` is `meaningful`
- `PROOF-OWNER` must be `tester`
- `ACCEPTANCE-OWNER` must be `validator`
- `PROOF-OWNER: not-needed` is prohibited

For `dev-workflow` on executable, user-facing software deliverables:
- Phase 4 analysis routing is non-compliant unless both reviewer and tester are explicitly dispatched on the acceptance path.
- Reviewer-only closeout, build-only proof, or tester omission is a dispatch defect and requires HOLD.

### Developer (governance-patch)

Governance patches use the developer-general template plus 3 guardrail fields. Developer WP+SV cycle owns the protection that was previously carried by lead self-declaration checkboxes.

**Standard** (single-file, compliance fix, typo, clarification, wording):
base + developer-general fields + `TASK-CLASS: governance-patch; CHANGE-BOUNDARY: <bounded delta>; WRITE-SCOPE: <paths>`

**Structural** (multi-file, new sections, meaning migration, architecture change):
base + developer-general fields + `TASK-CLASS: governance-patch; CHANGE-BOUNDARY: <bounded delta>; WRITE-SCOPE: <paths>; BASELINE-CLASS: preserved-asset|improvement-target|stability-anchor; EDIT-OPERATION: tighten|replace|re-home|merge|append|delete`

For meaning migration (re-home, move, transfer): CHANGE-BOUNDARY must include source-meaning inventory, destination rationale, and cross-reference update list.

High-traffic surfaces add: `SESSION-REVALIDATION: current-session-repo; BASELINE-ANCHOR: captured`

### Developer (self-growth)

governance-patch fields + `CAPABILITY-SIGNAL: <why>; INSPECT-LANES: <lanes>; OWNER-ROUTING: existing-owner|single-fit|competitive-bid; BALANCE-GUARD: average-capability-protected; BENCHMARK-MODE: light|full; BENCHMARK-BASIS: <baseline>; BENCHMARK-SURFACE: <compared>; BENCHMARK-PROVENANCE: repo-observed|authoritative-external|mixed|simulator-only; CROSS-CHECK-STATUS: repo-confirmed|authority-confirmed|mixed-confirmed|simulator-unconfirmed; HALLUCINATION-GUARD: cite-or-hold`

### Developer (solution-dev)

base + `PROBLEM-CLASS: instance|structural|systemic; ROOT-CAUSE-BASIS: confirmed|supported|hypothesis|unknown; SOLUTION-PASS: 1|2|3; DECISION-BASIS: <why>; REJECTED-OPTIONS: <alternatives>; CHANGE-BOUNDARY: <delta>`

structural/systemic add: `SOLUTION-PASS: 2|3; SELECTED-SCOPE: class-fix|system-fix|staged-class-fix`

solution-pass 2|3 add: `PASS-DELTA: <what improved>`

hypothesis/unknown add: `COMPETING-HYPOTHESES: <alternatives>`

staged-class-fix add: `FOLLOW-UP-OWNER: <owner>`

### Researcher

base + `RESEARCH-MODE: bounded|deep|sharded; DECISION-TARGET: <blocked decision>; QUESTION-BOUNDARY: <bounded question>; OUTPUT-SURFACE: <artifact or state the research must produce>; SOURCE-FAMILY: repo|runtime|web|mixed; DOWNSTREAM-CONSUMER: <consumer>; SKILL-RECOMMENDATIONS: applicable skills with rationale or none`

sharded add: `SHARD-ID: <id>; SHARD-BOUNDARY: <boundary>; MERGE-OWNER: <owner>`

Parallel researcher work must use sharded dispatch, not duplicate plain `researcher` dispatch. Runtime tracking uses `researcher-<SHARD-ID>` as the shard worker identity; keep `SHARD-ID` stable for same-shard reuse and unique for independent parallel shards.

benchmark-sensitive add: `BENCHMARK-MODE: light|full; BENCHMARK-BASIS: <baseline>; BENCHMARK-SURFACE: <compared>; BENCHMARK-AXIS: <axes>; BENCHMARK-PROVENANCE: repo-observed|authoritative-external|mixed|simulator-only; CROSS-CHECK-STATUS: repo-confirmed|authority-confirmed|mixed-confirmed|simulator-unconfirmed; HALLUCINATION-GUARD: cite-or-hold`

### Reviewer

base + `REVIEW-TARGET: <artifact>; REVIEW-SCOPE: <what surfaces and boundaries are in scope>; PREREQ-STATE: complete|partial|missing; EVIDENCE-BASIS: <proof basis>; ACCEPTANCE-RISK: low | meaningful | high | critical; ACCEPTANCE-SURFACE: <decision surface>`

For executable, user-facing deliverables:
- `ACCEPTANCE-SURFACE` must explicitly include delivery experience, user-readiness, functional correctness, interaction behavior, and visual/layout fit.
- When the deliverable has a UI or runnable operator surface, the review packet must explicitly cover launch/start path, shutdown path, infrastructure exposure, and minimum-user-action defects.

### Tester

base + `PROOF-TARGET: <claim under test>; ENV-BASIS: <environment>; SCENARIO-SCOPE: <scope>; PROOF-EXPECTATION: <expected proof>; PROOF-SURFACE: browser-ui|api|cli|document-rendered; TOOL-REQUIREMENT: <tooling requirement>`

For executable, user-facing deliverables:
- `SCENARIO-SCOPE` must explicitly include the real launch/start path, shutdown path, infrastructure exposure, and interaction coverage basis.
- For web UI deliverables, `PROOF-SURFACE` must be `browser-ui` and `TOOL-REQUIREMENT` must explicitly require Playwright CLI. curl or API-only proof may supplement diagnosis but cannot replace the browser-level proof surface.

### Validator

base + `VALIDATION-TARGET: <delivery surface>; EXPECTATION-SOURCES: <comparison sources>; REVIEW-STATE: ready|hold|blocked; TEST-STATE: ready|hold|blocked|not-needed; DECISION-SURFACE: <pass/hold/fail surface>; VALIDATION-SURFACE: browser-ui|api|cli|document-rendered; TOOL-REQUIREMENT: <tooling requirement>`

For executable, user-facing deliverables:
- `DECISION-SURFACE` must explicitly reconcile delivery experience, user-readiness, and interaction coverage.
- For web UI deliverables, `VALIDATION-SURFACE` must be `browser-ui` and `TOOL-REQUIREMENT` must explicitly require Playwright MCP visual inspection before PASS can be considered.

### Upward Worker Reports (worker → lead)

`message-class: blocker|handoff|completion|hold|scope-pressure|status; message-priority: normal|high|critical; work-surface: <current surface>; task-id: <assigned-id|none>; requested-governing-action: <decision needed or none>`

Note: Lane-specific completion-grade evidence blocks (tester, validator, researcher, developer handoff packets) extend this base template. Their fields augment rather than replace the base fields above. The base template provides the minimum shared communication surface; lane-specific blocks add proof, validation, or research-specific tracing fields.

---

## Dispatch Packet Compliance Fields

Enumerated fields (exact values enforced):

| Lane | Field | Required Values |
|------|-------|----------------|
| researcher | RESEARCH-MODE | bounded or deep or sharded |
| researcher | SOURCE-FAMILY | repo or runtime or web or mixed |
| researcher (benchmark) | BENCHMARK-MODE | light or full |
| researcher (benchmark) | BENCHMARK-PROVENANCE | repo-observed or authoritative-external or mixed or simulator-only |
| researcher (benchmark) | CROSS-CHECK-STATUS | repo-confirmed or authority-confirmed or mixed-confirmed or simulator-unconfirmed |
| researcher (benchmark) | HALLUCINATION-GUARD | cite-or-hold |
| developer | PLAN-STATE | ready or approved or updated or revalidated |
| developer | ACCEPTANCE-RISK | low or meaningful or high or critical |
| developer | REVIEW-OWNER | reviewer |
| developer | PROOF-OWNER | tester or not-needed |
| developer | ACCEPTANCE-OWNER | reviewer or validator or not-needed |
| reviewer | PREREQ-STATE | complete or partial or missing |
| tester | PROOF-SURFACE | browser-ui or api or cli or document-rendered |
| validator | REVIEW-STATE | ready or hold or blocked |
| validator | TEST-STATE | ready or hold or blocked or not-needed |
| validator | VALIDATION-SURFACE | browser-ui or api or cli or document-rendered |

---

## Consequential Upward Evidence Block Fields

Common presence-required fields:

| Field | Description |
|-------|-------------|
| TASK-ID | assigned task id when the runtime issued one; otherwise `none` |
| OUTPUT-SURFACE | artifact, claim, version, or bounded work product |
| EVIDENCE-BASIS | decisive evidence anchors |
| OPEN-SURFACES | blocked, unverified, or residual-risk surfaces |
| RECOMMENDED-NEXT-LANE | next owner or none |
| REQUESTED-LIFECYCLE | standby or shutdown (worker→lead) |
| LIFECYCLE-DECISION | reuse, standby, shutdown, hold-for-validation (lead→worker; omit from worker reports) |
| DECISION-BASIS | concise evidence basis for the lifecycle decision |
| NEXT-OWNER | worker name, team-lead, or none |

Note: `REQUESTED-LIFECYCLE` (worker → lead) is the worker's suggested next state. `LIFECYCLE-DECISION` (lead → worker) is the lead's authoritative decision. The lead always owns the final lifecycle call.

Lane-owned enumerated fields:

| Lane | Field | Values |
|------|-------|--------|
| developer | PREREQ-STATE | complete, partial, missing |
| reviewer | REVIEW-STATE | ready, hold, blocked |
| tester | TEST-STATE | ready, hold, blocked |
| validator | VERDICT | PASS, HOLD, FAIL |

---

## Consequential Tool Recovery Contract

- This contract applies to dispatch (`Agent`, `TaskCreate`, assignment-grade `SendMessage`), task-state mutation (`TaskUpdate`, `TaskStop`), runtime teardown (`TeamDelete`, `CronDelete`), file mutation (`Edit`, `Write`, `MultiEdit`), and mutable `Bash`.
- Status, progress, current-state, and "what remains?" questions do not authorize consequential tool use by themselves. Answer from existing evidence unless the user explicitly requests continuation, correction, dispatch, validation, mutation, or cleanup.
- A hook block is not a workflow step to probe through. Treat the hook's `Next:` field as the required recovery path.
- Retrying a blocked tool requires a changed corrective basis: for example current-turn `work-planning`, Phase 1 `self-verification`, confirmed task id, lifecycle decision, duplicate-worker reuse/shutdown decision, or a completed packet field.
- Do not retry the same tool, or move sideways to a sibling consequential tool, while the same preflight gap remains.
- If the same blocker appears twice on the same operating surface, stop retries and report HOLD with the blocker, the missing preflight step, and the functional result already known.

---

## No-Probe / Blocked Retry Rule

- Hooks are safety gates, not discovery tools. Do not call a consequential tool just to learn whether it is currently allowed.
- After any `PreToolUse` block, do not retry the same tool or a sibling consequential tool until the hook's `Next:` action has been completed and the corrective basis has changed.
- If the same blocker appears twice in the same operating surface, stop tool retries, hold the runtime action, and report the blocker plus the exact preflight step needed. Do not continue with adjacent dispatch, task-state mutation, or teardown attempts.
- **Deadlock escape:** If the corrective `Next:` action is itself blocked by a different hook, identify the first unconditionally permitted step in the corrective chain. `Read`, `Glob`, `Grep`, and `Skill` carry no PreToolUse deny hooks and are therefore always permitted as deadlock-escape steps. (PostToolUse hooks may observe them but cannot deny.) Execute that step first to establish the minimum corrective basis, then retry the original blocked tool. If no permitted step exists, report the circular block chain explicitly and halt.

## Canonical Dispatch Preflight

Run this exact preflight before any `Agent`, `TaskCreate`, or assignment-grade `SendMessage`. Reuse does not bypass dispatch gates; a worker-control `SendMessage` that assigns, delegates, reuses, or reroutes work is dispatch. Note: lifecycle control messages (`MESSAGE-CLASS: control` with `LIFECYCLE-DECISION` field) are not assignment-grade and follow §Worker Lifecycle rules instead of full dispatch preflight.

Hard stop: if any idle worker on the same work surface lacks an explicit lifecycle decision, no `Agent`, `TaskCreate`, or assignment-grade `SendMessage` dispatch is allowed for that surface. Dispatch to a different, non-overlapping work surface is not blocked by unrelated idle workers, provided those workers have a pending lifecycle decision queued for the next available processing cycle. Resolve that backlog first even when the next work is urgent, corrective, or parallelizable. Recovery: send each undecided worker a lifecycle `SendMessage`.

Parallel researcher work is not a duplicate plain `researcher` dispatch. Use `RESEARCH-MODE: sharded` with `SHARD-ID`, `SHARD-BOUNDARY`, and `MERGE-OWNER`; hooks track each shard as a separate `researcher-<SHARD-ID>` worker identity. Plain duplicate researcher dispatch means same-worker continuation and must reuse or resolve lifecycle first.

**Lifecycle decision deadlock escape:** apply the `Deadlock escape` under `§No-Probe / Blocked Retry Rule`.

1-2. Prerequisite: Fresh Turn Dispatch Gate must be satisfied.
3. Classify the outgoing action as `Agent`, `TaskCreate`, or assignment-grade `SendMessage`.
4. Resolve lifecycle backlog: every idle worker **on the same work surface** must have an explicit `reuse`, `standby`, `shutdown`, or `hold-for-validation` decision before dispatching to that surface.
5. Check whether the target lane/name already has a live or standby worker.
6. If an existing worker fits, reuse it with bounded `SendMessage`; if not, decide `shutdown`, `standby`, or `hold-for-validation` before replacement spawn.
7. Run the dispatch packet final check against the actual outgoing payload, including any task row that will be created, then dispatch.

SV trigger (6) (before re-dispatch) is satisfied by the same-turn carry-forward rule when no intervening consequential modifications occurred since the last SV load in the current turn.

If any step fails, stop before tool use and complete that step. Do not probe hooks by attempting dispatch first.

Worker outputs synthesized into concrete patch instructions create a new dispatch basis. Before developer dispatch, Trigger 6 self-verification must challenge that exact synthesized patch set unless current-turn self-verification already challenged the same patch set after synthesis and no consequential change occurred afterward.

## Task-State Mutation Preflight

Run this before `TaskUpdate` or `TaskStop`.

1-2. Prerequisite: Fresh Turn Dispatch Gate must be satisfied.
3. Confirm the exact task id from `TaskList`, `TaskGet`, or the original `task_assignment` packet.
4. If the task id is absent, stale, or already cleaned up, do not guess or reuse remembered numbers. Report the administrative task state as unavailable and preserve the functional result separately.
5. Mutate task state only after the id is evidence-backed.

## Lead Dispatch Rules

- Every dispatch carries plan basis AND skill-load instructions (work-planning at start, self-verification at plan-verify and handoff). Planless dispatch = planless execution.
- After TeamCreate, every Agent fan-out must be team-bound: include team_name and a stable worker name in the Agent call.
- Governance analysis or review dispatch must include `GOVERNING-LENS: CLAUDE.md [GOV-MIN]`; downstream defect claims must classify items as real defect, intentional minimal-boundary design, or clarification candidate.
- For governance/process review synthesis, require an explicit evidence class on each consequential issue: `observed-runtime-break`, `observed-operational-friction`, `static-contradiction`, or `theoretical-risk`. Do not silently promote document-only contradiction into runtime breakage.
- Keep skill channels explicit per `CLAUDE.md` `§Skill Loading Philosophy`: `REQUIRED-SKILLS` carries baseline obligations, `SKILL-RECOMMENDATIONS` carries situational suggestions. Lane-execution skills (e.g., `skills/developer/SKILL.md`) load via agent `initialPrompt` and are implicit in dispatch; they need not be repeated in `REQUIRED-SKILLS`.
- `.claude/agents/*.md` is the source of truth for dispatchable Agent lanes. Runtime instance labels do not create new agent definitions; they must carry a configured lane through the tool's agent-type field.
- Specialist capabilities under `.claude/skills/<skill-id>/SKILL.md` are skills, not `Agent` targets. Route them through a real worker lane, normally `developer`, using `SKILL-RECOMMENDATIONS` for methodology guidance or `SKILL-AUTH` when explicit specialist authorization is required.
- Current runtime default is `SPECIALIST_SKILL_ENFORCEMENT_MODE=autonomous`; `SKILL-AUTH` is therefore an explicit authorization and traceability contract, not a guaranteed runtime deny/warn gate unless enforcement hooks and required-skill lists are separately enabled and verified.
- For executable, user-facing deliverables, acceptance dispatches must keep delivery-surface criteria explicit and must satisfy the active workflow/reference/hook requirements for review, proof, and validation. Do not leave those surfaces implied.
- Analyze phase dependencies and launch independent phases simultaneously; sequential dispatch of independent phases = bottleneck failure.
- Staff for throughput, not for the lowest worker count. Choose the smallest reliable set that prevents serial waiting, preserves required separation, and avoids avoidable redispatch churn.
- Lifecycle preflight before spawning: resolve all undecided idle workers on the same work surface before dispatch. Reuse existing workers before spawning replacements. Worker completion creates an immediate lifecycle obligation.
- Assignments handoff-complete: prior analysis, bounded scope, judgment surface, expected output — not topic name alone.
- When the shared task runtime is active, keep each `TaskCreate` row operationally legible before or alongside worker dispatch. Task descriptions must carry bounded-scope and completion coordinates; task rows are state surfaces, not informal labels.
- Use the completion-grade handoff protocol, task-state coordination, and session-state handling owned by `CLAUDE.md` `§Worker Communication Baseline`, `skills/task-execution/reference.md`, and the active lifecycle skills. Do not invent alternate reporting channels, sidecar handoff files, or worker-written session-state paths.
- Require the frozen request-fit basis and the active lane's dispatch packet before research, drafting, implementation, or acceptance staffing. Freeze deliverable shape before staffing.
- Document modification dispatch must require worker to identify and respect target document's authoring principles before changes.
- Include agent utilization map in work plan. Confirm active plan matches request before dispatching. Do not become passive while workers require oversight.
- Keep explicit user-perspective acceptance ownership whenever acceptance risk is meaningful; the concrete gate wording and packet structure belong to the active workflow/reference layer.
- Maintain active inter-agent communication for clarifications, partial results, blockers, reroutes, reuse, and handoff; message classes and field schemas belong to `CLAUDE.md` `§Worker Communication Baseline` and `skills/task-execution/reference.md`.
- Governance-sensitive modifications must follow the governing governance-change path owned by the active workflow or self-growth procedure. Lead-local governance edits permitted under IR-3(b) satisfy this rule when they use the active governance-change path non-destructively. Do not improvise a parallel path from this role document.
- When governance rules change during active worker execution, notify active workers of relevant changes via SendMessage immediately.
- Track missed-catch patterns; repeated same-class failure must harden the owning doctrine, skill, conditional-rule, or hook layer. Derive plans from loaded doctrine, not habit, and HOLD if the governing procedure basis is unclear.
- **Checkpoint C** (governance-sensitive modifications): owned by `task-execution` and the active governance workflow. Satisfy that checkpoint before presenting results.

## Dispatch Packet Final Check

Immediately before every consequential `Agent` dispatch or `TaskCreate`, check the actual outgoing payload against these targets — not the plan summary.

Required fields on every outgoing packet:
- `MESSAGE-CLASS`
- `WORK-SURFACE`
- `CURRENT-PHASE`
- `REQUIRED-SKILLS`
- If `work-planning` declared `ACTIVE-WORKFLOW` with a value other than `none`, confirm the workflow skill was loaded via `Skill` tool in the current turn before dispatch.
- If an output format is specified, confirm it preserves mandatory output surfaces from each `REQUIRED-SKILLS` entry.
- target-lane required fields from `§Dispatch Packet Templates`
- For web UI or user-facing executable reviewer dispatch: `ACCEPTANCE-SURFACE` must explicitly include delivery experience, user-readiness, functional correctness, interaction behavior, and visual/layout fit.
- Agent tool call: both `description` (3–5 word summary) and `prompt` (full packet content) required; omitting either causes `InputValidationError`.
- `TaskCreate`: non-empty subject plus description containing one bounded-scope coordinate (`QUESTION-BOUNDARY`, `CHANGE-BOUNDARY`, `CHILD-BOUNDARY`, `EXCLUDED-BOUNDARY`, `EXCLUDED-SCOPE`, or `WORK-SURFACE`) and one completion coordinate (`DONE-CONDITION`, `OUTPUT-SURFACE`, `PROOF-TARGET`, `VALIDATION-TARGET`, `ACCEPTANCE-SURFACE`, or `DECISION-SURFACE`).

| ACCEPTANCE-RISK | Required PROOF-OWNER |
|-----------------|----------------------|
| `low` | `not-needed` |
| `meaningful` | `tester` (mandatory) |
| `high` | `tester` (mandatory) |
| `critical` | `tester` (mandatory) |

Per-lane minimum required fields: see `§Dispatch Packet Templates`.

Rules:
- `REQUIRED-SKILLS` must be copied into the outgoing packet, not merely mentioned in planning prose.
- If the packet specifies an output format, it must preserve every mandatory output surface required by each `REQUIRED-SKILL`.
- Payload is the authority over plan summary; fix payload before dispatch when they differ.
- Build lane packets from `§Dispatch Packet Templates`, not from memory.
- `dispatch-proof-gate` is advisory for non-material wording drift. Core fields (`MESSAGE-CLASS`, `WORK-SURFACE`, `CURRENT-PHASE`, `REQUIRED-SKILLS`, target-lane required fields) remain mandatory; wording of other fields is best-effort. Receiving workers return `MESSAGE-CLASS: hold` when missing fields create material ambiguity.

## Workflow Authority Guard

- On workflow-governed work, researcher/discovery completion returns to the active workflow's next phase; it does not authorize implementation dispatch. [Rule-Class: mandatory]
- Internal reasoning, private synthesis, and worker instructions are not the canonical plan surface. [Rule-Class: mandatory]
- When asked whether planning is complete, cite the active workflow phase/checkpoint or state that planning remains provisional. [Rule-Class: mandatory]
- When user criticism targets process failure, diagnose the exact failure mode before responding rather than collapsing distinct cases into one rhetorical summary. [Rule-Class: mandatory]

## Output And Handoff Rules

- Closeout default: one-line acknowledgement when clean. Details only when blocked/hold/handoff/restart/user-requested.
- For workflow-governed executable deliverables, `clean` requires the active acceptance path to be satisfied. Without the required acceptance evidence or verdict, closeout state is HOLD regardless of self-reported progress.
- Handoff quality = acceptance-critical: preserve findings, evidence anchors, blockers, next-owner state. Require one completion-grade evidence block for consequential reports.
- Preserve worker-owned state monotonically during reroute — do not silently upgrade upstream review, proof, or validation state without fresh owning-lane evidence.
- Carry forward prior analysis during worker reuse/reroute. Reuse authoritative acceptance-evidence blocks instead of rephrasing into competing summaries.
- Human-facing deliverables must be accepted on the real user-facing surface required by the active workflow or acceptance path.

---

## Task Identity And Communication Protocol

- Task-scoped tools (TaskGet, TaskUpdate, TaskOutput, TaskStop) take the task id from the explicit task_assignment packet — not a worker name or agentId@team.
- Dispatch preflight is shared by `Agent`, `TaskCreate`, and assignment-grade `SendMessage`. Required order: current-turn `work-planning` -> Phase 1 `self-verification` -> lifecycle backlog decision -> target reuse/duplicate check -> packet final check -> dispatch. `SendMessage` reuse is still dispatch and must not be used to bypass the fresh-turn gate.
- Lifecycle backlog means idle workers without an explicit `reuse`, `standby`, `shutdown`, or `hold-for-validation` decision. The target is zero undecided idle workers before additional fan-out, not zero idle workers.
- Corrective work and bottleneck fixes still obey lifecycle order. When a new fix is needed and idle workers exist, the next action is lifecycle resolution or bounded reuse, not a fresh `Agent` spawn.
- Reuse-first: when the target lane/name already has a live or standby worker, use bounded `SendMessage` reuse if the context fits. Spawn a replacement only after an explicit lifecycle decision makes the existing worker unsuitable for reuse.
- Task-state mutation preflight is shared by `TaskUpdate` and `TaskStop`: current-turn `work-planning` -> Phase 1 `self-verification` -> confirm exact task id from `TaskList`, `TaskGet`, or the original `task_assignment` packet -> mutate task state. If the id is stale or absent, do not guess; report administrative task-state unavailable.
- Runtime teardown preflight is shared by `TeamDelete`, `CronDelete`, and closeout cleanup: current-turn `work-planning` -> Phase 1 `self-verification` -> confirm closeout/teardown intent -> verify no active worker has unresolved handoff, task-state, or lifecycle decision -> mutate runtime state.
- When the runtime exposes a task id or `task_assignment` packet, preserve that id across reroute, follow-up task-tool use, completion-grade SendMessage reports, and completion review. Do not reconstruct task identity from worker names, message order, or remembered chronology.
- Task state is authoritative on the shared task runtime. SendMessage carries communication and handoff content, but does not by itself close a task.
- `TaskCreate` must keep the shared task runtime legible: non-empty subject, plus a description that states bounded scope and expected completion surface using existing packet coordinates. For scope, use fields such as `QUESTION-BOUNDARY`, `CHANGE-BOUNDARY`, `CHILD-BOUNDARY`, `EXCLUDED-BOUNDARY`, `EXCLUDED-SCOPE`, or `WORK-SURFACE`. For completion surface, use fields such as `DONE-CONDITION`, `OUTPUT-SURFACE`, `PROOF-TARGET`, `VALIDATION-TARGET`, `ACCEPTANCE-SURFACE`, or `DECISION-SURFACE`. Placeholder or topic-only task rows are non-compliant.
- Agent-scoped communication remains separate: use SendMessage(to: worker-name) for worker control; do not reuse the worker identifier as a task identifier.
- SendMessage direction: downward authoritative control uses MESSAGE-CLASS, MESSAGE-PRIORITY, WORK-SURFACE; lifecycle shutdown uses shutdown_request / shutdown_response; upward authoritative reports use message-class, message-priority, work-surface, requested-governing-action; peer worker challenge uses PEER-MODE + MESSAGE-PRIORITY. Free-form is fine for status, acknowledgment, clarification, partial-result notes, or inferable assignment context that does not create material ambiguity in ownership, lifecycle, routing, or active surface.
- Structured worker-control or lifecycle messages must target a concrete worker name. Do not send structured packets to `to: "*"`; broadcast is not a valid target for structured control surfaces such as phase transitions, assignments, reroutes, standby approvals, or `shutdown_request`.
- Minimal lifecycle decision packet: `LIFECYCLE-DECISION: reuse|standby|shutdown|hold-for-validation`. Add `DECISION-BASIS: <evidence>` when useful. Full control fields are optional for lifecycle cleanup; they must not become a formatting wall before dispatch can resume.
- Consequential upward reports should arrive before TaskCompleted; the completion gate evaluates the report and its verification evidence before task state closes.
- If task output must be read later, carry the assigned task id forward explicitly; do not reconstruct from the worker name.
- `handoff|completion` reports are positive-state declarations. They require `PLANNING-BASIS: loaded`, `SV-PLAN-VERIFY: done`, `SELF-VERIFICATION: converged`, and `CONVERGENCE-PASS: 1|2|3` on the actual current-task evidence surface. If the work is blocked, unconverged, or under-verified, use `message-class: hold` and keep the task open.

---

## Manifest Sync Packet

Required fields: `TASK-CLASS: manifest-sync; MANIFEST-UNIQUE: <count>; OVERLAP-REVIEW: done; PRE-EXEC-REVIEW: done; WRITE-SCOPE: <unique target set>`

Sharded adds: `SHARD-ID: <id>; SHARD-SET: disjoint`

Single-writer default: shard only when each shard's write scope is explicit and disjoint before the first developer dispatch.

---

## Task Decomposition Child Packet Fields

Recommended minimum readable fields: `PARENT-OBJECTIVE`, `SPLIT-BASIS`, `CHILD-BOUNDARY`, `EXCLUDED-BOUNDARY`, `DONE-CONDITION`, `RETURN-FORM`

Note: These do not replace lane-specific compliance fields; they make the decomposition legible.

### TaskCreate Minimal Description Templates

Use these when the shared task runtime is active. The task row must stay readable without opening the worker prompt history.

Sharded researcher task:

`PARENT-OBJECTIVE: <overall research goal>; SPLIT-BASIS: domain|source-family|question-axis; CHILD-BOUNDARY: <this shard only>; EXCLUDED-BOUNDARY: <what this shard must not absorb>; WORK-SURFACE: <bounded research surface>; DONE-CONDITION: <explicit shard completion signal>; OUTPUT-SURFACE: <handoff surface>`

Bounded developer task:

`WORK-SURFACE: <owned file or change surface>; CHANGE-BOUNDARY: <bounded delta>; EXCLUDED-SCOPE: <out of scope>; DONE-CONDITION: <observable completion>; OUTPUT-SURFACE: <changed artifact or file set>`

Acceptance-lane task:

`WORK-SURFACE: <artifact under review or proof>; EXCLUDED-SCOPE: <what this lane is not deciding>; DONE-CONDITION: <review/proof/verdict complete>; ACCEPTANCE-SURFACE|PROOF-TARGET|DECISION-SURFACE: <owned completion surface>`

---

## Shard Handoff Fields

Required minimum: shard id or surface label; covered boundary; excluded boundary; concrete result payload; unresolved gaps or blockers; duplication or conflict risk from this shard; recommended downstream placement when the parent artifact will be recomposed.

---

## Dispatch Packet And Authority Boundaries

- Do not directly load `researcher`, `developer`, `reviewer`, `tester`, or `validator` lane-local skills from the main lane. Route the work through those lanes so their packets, evidence state, and authority boundaries remain explicit.
- For implementation-lane dispatch, keep procedure intent explicit in the packet: current plan state, active plan step, acceptance risk, downstream review or proof owners, final acceptance owner, and the bounded change specification.
- For `ACCEPTANCE-RISK: meaningful|high|critical`, keep the acceptance pipeline fully explicit in the dispatch packet so review, proof, and final acceptance ownership cannot blur together.
- For consequential dispatch, keep `WORKER-FIT`, `SCOPE-MATCH`, and `PRIOR-ANALYSIS: included` explicit so the lead's existing analysis is actually embedded rather than forwarded raw.
  - **Adherence guard**: Pattern: raw researcher output forwarded to `developer`. `PRIOR-ANALYSIS: included` requires real lead synthesis, not raw forwarding.
- For governance-sensitive modification work, keep the stronger order explicit: loss-risk analysis, information-loss review, local-context balance review, and related-owner review first; bounded modification second; optimization only afterward.
- Additions, deletions, rewrites, migrations, compressions, and optimizations are all governance modifications with the same loss-risk class; cleanup framing or small-follow-up framing does not bypass the packet.
- Shared preservation doctrine comes from `CLAUDE.md`. This file operationalizes that doctrine as the lead-local governance dispatch packet surface; it does not claim a separate canonical packet owner there.
- Before governance-sensitive execution, keep at minimum balance review, related-owner review, patch review, modification proposal, source-meaning inventory, destination-owner map, bounded change boundary, and verification basis explicit. When optimization, compression, deduplication, rewrite, or self-growth optimization is in scope, also keep the lead-local post-change-only and zero-loss guards explicit.
- When a governance modification targets high-traffic governance surfaces (CLAUDE.md § Document Ownership), also require `SESSION-REVALIDATION: current-session-repo` and `BASELINE-ANCHOR: captured`. If such work resumes after reset, restart, or pause-return, keep it on `HOLD` until the current session rebuilds that packet from repository state.
- For consequential lane dispatch, keep the lane packet explicit instead of relying on habit. `researcher` must receive decision target, question boundary, source family, and downstream consumer; `reviewer` must receive review target, prerequisite state, evidence basis, and acceptance surface; `tester` must receive proof target, environment basis, scenario scope, and proof expectation; `validator` must receive validation target, expectation sources, visible review or test state, and decision surface.
- When a consequential worker report returns upward via `handoff`, `completion`, or `hold`, derive any follow-on lane packet from the completion-grade evidence block plus preserved prior analysis instead of from topic-only prose or a softened summary.
- When the consequential lane work is building or reviewing a request-bound artifact whose value depends on question-fit or decision-fit, extend that packet with the request-fit fields as well: `REQUEST-INTENT`, `CORE-QUESTION`, `REQUIRED-DELIVERABLE`, `PRIMARY-AUDIENCE`, `EXCLUDED-SCOPE`.
- Keep governed instruction flow explicit as well: `team-lead` issues execution/control packets downward, and workers return blockers, handoffs, and scope corrections upward to the governing lane. Direct worker-to-worker traffic is limited to explicit bounded peer advice or challenge packets and must not silently reroute ownership or acceptance authority.
- Before dispatching a developer for user-provided file-list copy, overwrite, or sync work, complete a manifest review gate: collapse duplicates, verify the final unique write set, and make that review explicit before execution starts.
- For manifest review packet fields and single-writer sharding rule: see `reference.md § Manifest Sync Packet`.
- When sending ordinary control downward, keep the message packet explicit: message class, priority, and work surface must be readable. Worker shutdown uses the explicit `shutdown_request` protocol path rather than an ordinary control packet.

### Task Identity And Communication Protocol

See `reference.md § Task Identity And Communication Protocol` for tool-scoping, SendMessage direction types, and task-id carry-forward rules.

### Consequential Upward Evidence Block

- For consequential upward SendMessage with message-class: handoff, completion, or hold, one completion-grade evidence block is mandatory — do not scatter acceptance-critical state across prose. Status notes and conversational messages may remain lighter.
- See `reference.md § Consequential Upward Evidence Block Fields` for required presence fields and lane-owned enumerated fields.
- Preserve lane-owned state monotonically across reroute and re-dispatch. team-lead may summarize or route from these fields, but must not silently strengthen a worker-owned state without a fresh explicit report from the owning lane or stronger evidence on that same lane surface.
- Tester does not emit TEST-STATE: not-needed; that remains a lead-side validation-ingress decision when the acceptance design truthfully does not require tester proof.

---

## Agent Dispatch Discipline

- The lead's routing order is fixed: `intent -> deliverable shape -> phase -> staffing -> lifecycle -> dispatch packet`. Do not let bottleneck pressure, TOC existence, self-growth urgency, or runtime convenience reorder that chain.
- During explicit team-runtime sessions, all worker lanes must run in background (`run_in_background: true`). No exceptions.
- When a dispatched lane requires explicit write authority under runtime policy, supply the required execution mode via agent configuration, not via dispatch mode shortcuts.
- All Agent tool dispatches must use a deliberate permission mode that matches the work surface and the active repository policy. Do not assume one universal default. If the repository intentionally operates with high autonomy, keep destructive-risk handling explicit instead of smuggling in extra approval gates.
- Agent dispatch requires an active team runtime (`TeamCreate`) — without it, inter-agent communication, task tracking, and lifecycle management are unavailable. Lead-managed no-runtime is strictly lead-local; activate explicit runtime before any delegation.
- Cost efficiency is measured by end-to-end throughput, reuse value, and rework avoidance — not by minimizing active workers as a standalone goal.
- Understaffing that serializes already-independent work or pushes specialist work back onto the lead is a cost defect even when it appears cheaper in the moment.
- `AGENT-MAP` is a routing commitment, not a planning note. After post-planning verification, a declared team map must advance to `TeamCreate`, `Agent`, or assignment-grade `SendMessage` unless the lead names a concrete dispatch blocker being cleared.
- When project scale or supervision load is unusually high, you may delegate bounded management-support work to an approved support lane, but you retain top-level ownership, user communication, and final integration responsibility.
- For broad-scope research (3+ independent sub-topics), split into parallel researcher shards by default. Single-researcher dispatch on independent domains is a bottleneck defect.
- Dispatch independent work immediately upon discovery when independence, non-overlap, and phase boundaries are already explicit. Do not wait for unrelated active work to complete before dispatching. Batching independent work into sequential phases is a bottleneck.
- For request-bound document work, phase selection comes before staffing choice. Decide first whether the next needed work is `research`, `draft`, or `merge-compress`; then choose the smallest reliable staffing shape for that phase.
- Use `researcher` for evidence expansion, contradiction mapping, source-family coverage, or benchmark framing. Use `developer` for main artifact drafting or merge-compress from already available evidence. Do not combine broad evidence gathering, main drafting, and final merge-compress in one mixed-purpose prompt.
- The most important forbidden combinations are: research + main-body draft, broad research + merge-compress, draft + final acceptance review, and review + validation verdict in one worker prompt.
- Separate phase from staffing: one dispatch = one phase intent, not one phase = one mandatory worker. Multiple workers may run in parallel inside the same phase when independent; a single worker may span consecutive phases when reuse is the lower-friction path.
- Merge work is its own phase-intent. Do not hide merge responsibility inside one shard writer's ordinary draft step after parallel fan-out has already happened.
- Before splitting one parent job into child dispatches, freeze the split basis explicitly: question, decision target, evidence family, file group, document section, or phase step. Do not split by vague size pressure alone.
- Each child dispatch must make the parent objective and child boundary readable: what this worker owns, what it must not absorb, what dependency or merge relationship it serves, and what return form the lead expects back.
- Each child dispatch must also state the local done condition. If the worker cannot tell when its bounded assignment is complete, the split instruction is under-specified and must be rewritten before dispatch.
- When parallel shards will later be recomposed into one parent deliverable, assign one explicit `MERGE-OWNER` before full fan-out. Merge ownership must not be left implicit or discovered only after shard volume accumulates.
- The merge owner is responsible for synthesis quality, not just concatenation: remove duplication, preserve the direct answer or controlling conclusion early, maintain final length/volume fit, preserve `EXCLUDED-SCOPE`, and make unresolved conflicts explicit.
- Assigning `MERGE-OWNER` does not require all shards to arrive before productive work continues. If current evidence already supports bounded drafting or integration, the designated owner should proceed and fold late shard updates in through explicit follow-up.
- Use one sequential scout dispatch first only when independence, staffing shape, or boundary quality is still uncertain after the `intent -> deliverable shape -> phase` freeze. When those are already explicit and non-overlapping, immediate parallel fan-out is preferred over scout-first delay.
- Before dispatch, confirm that the new work's work surface does not overlap with any active worker's work surface. Work with overlapping work scope is not independent.
- Each dispatch must stay single-purpose and within the focused load bounds. The lead owns the decision to decompose before overload occurs.
- Do not expect downstream acceptance lanes to perform hidden merge work. After parallel production, route one authoritative integrated output forward rather than multiple shard bodies plus an implied merge request.
- When shard outputs inflate the parent artifact beyond its frozen class, optimize during merge-compress by trimming or demoting locally correct but non-decisive material. Reader utility, answer visibility, and coherence outrank shard-local completeness in the final integrated surface.
- Each shard handoff must carry the minimum fields in `reference.md § Shard Handoff Fields`.
- Phase separation does not require passive waiting. Starting draft from an incomplete but already useful shard set, then advancing the designated owner through bounded merge-compress follow-up as later shard results arrive, is valid when the parent packet, merge ownership, and unresolved gaps stay explicit.
- Reuse the standby worker for same-topic follow-up unless context consumption is excessive. Create a new agent for different-topic work to prevent context contamination.
- Do not create a new `Agent` with the same concrete worker identity while that worker is still live, standby, or idle-pending. Resolve reuse, standby, or shutdown on the existing identity first.
- If 2 or more workers are idle and still awaiting an explicit lifecycle decision, treat that as a dispatch backlog defect and resolve the backlog before adding more fan-out.
- Check the memory pressure 80% guard before every dispatch. If exceeded, shut down unneeded standby workers first, then dispatch.
- After task completion, default to standby when same-topic follow-up is probable. Shut down only when the topic is fully closed, context is near exhaustion, or memory pressure requires it.
- During planning, identify standby agents with no remaining role and mark them as shutdown candidates. Actual shutdown (per Checkpoint D) requires closeout, 80%+ memory pressure, or context exhaustion.
- An idle_notification means the worker's turn ended, not failure. Before replacing a worker: ask what blocks, request partial results, consider scope reduction, and allow wait time proportional to scope. Replacement is the last resort.
- Start deliverable work with available inputs immediately. Do not block on pending inputs when partial progress is possible; integrate late results as updates.
  - **Adherence guard**: Pattern: passive waiting for every researcher before synthesis or developer dispatch. Partial progress with available inputs is mandatory.
