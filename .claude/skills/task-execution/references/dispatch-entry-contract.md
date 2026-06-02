---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/task-execution/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# task-execution: Dispatch Entry Contract

Load after `Skill(task-execution)` is active per the activation rule at `.claude/skills/task-execution/SKILL.md` `## Activation` and before any dispatch, reuse, blocker-clear, or packet assembly move.

## Prior Owner Requirements
Before this skill acts, the lead must already have:
- actual full-body `Skill(task-execution)` load-and-learn or `same-session-loaded-and-learned:task-execution` for the current Claude session
- current boundary `work-planning`
- current `PLAN-VERIFICATION-BASIS` from `Skill(review-verification):plan-draft-readiness` when mandatory under work-planning
- the current frozen workflow or sequence owner already opened when `ACTIVE-WORKFLOW` or non-`not-applicable` `ACTIVE-SEQUENCE` is present
- a frozen additional-agent route or ambiguous dispatch route
- frozen team-runtime route basis from `work-planning` readiness for any `TeamCreate`, team-scoped `Agent`, assignment-grade `SendMessage`, reuse, blocker-clear, or packet assembly move on a team-agent route
- `session-boot` supplies current-runtime readiness or recovery classification only when live runtime truth can change the next owner/action

## Consumed Frozen Fields
Consume only dispatch-relevant frozen fields in the order and conditionals owned by `.claude/skills/work-planning/references/planning-record-fields.md` `## Allowed Values`. A consumed field must carry either a concrete frozen value or an explicit `not-applicable` basis allowed by `work-planning` for the current route.

## Field Rules
- Missing, stale, or contradictory request-fit basis reopens `work-planning`.
- Dispatch-entry floor applies only to fields inside packet assembly, runtime dispatch, receiving-lane execution, workflow, or active report gates.
- Missing or contradictory `SEMANTIC-INTENT-BASIS` reopens `work-planning`.
- Missing or contradictory material `TARGET-INTENT-BASIS` reopens `work-planning` when packet assembly, receiving-lane execution, review, proof, validation, synthesis, report gating, or completion truth depends on target purpose, existing-artifact integrity, design or scope fit, or protected outcome.
- Missing or contradictory `COMPLETION-STOP-CONDITION` reopens `work-planning` when packet assembly, receiving-lane execution, report gating, or completion truth depends on it.
- Missing or contradictory `DERIVED-DEFAULTS` reopens `work-planning` when packet assembly, proof surface, or receiving-lane execution depends on it.
- Missing `REQUEST-BOUND-PACKET-FIELDS` reopens `work-planning`.
- `TEAM-LEAD-WORK-PLAN` names the plan-draft review row when required, the dispatch row, post-dispatch synthesis/verification row, and termination row for the assignment-grade route.
- Missing material `CLAIM-CEILING` reopens `work-planning`.
- `AGENT-MAP`, `PARALLEL-GROUPS`, and `ACTIVE-CONCURRENT-AGENT-CAP` consumption (concrete-required conditions, cap consumption rule, cap-exceed routing, valid `not-applicable` bases) is governed by `.claude/skills/work-planning/references/parallel-fit.md` and `.claude/skills/work-planning/references/planning-record-fields.md`; `task-execution` consumes the frozen values without inferring or raising them from runtime convenience.
- `task-execution` consumes the frozen team-runtime route basis together with `AGENT-MAP`, `PARALLEL-GROUPS`, and `ACTIVE-CONCURRENT-AGENT-CAP`; it must not infer team-runtime eligibility from tool visibility, convenience, or direct-Agent output outside team runtime.
- Concrete `PARALLEL-GROUPS` must include boundary, non-overlap, and measured/cited burden basis from the frozen planning path.
- Dispatch readiness requires measurement from the frozen planning path rather than file-only, guessed, or pre-`work-planning` measurement.
- `CODEX-INDEPENDENT-REVIEW-BASIS` is dispatch context only for configured independent-review handling.
- `task-execution` consumes the frozen `triggered:*`, `fail-open:*`, or `skipped:*` truth.
- Configured independent reviewer calls stay with the configured independent-review owner.
- Configured-review point adjudication stays with the owning adjudication path.
- `fail-open:*` remains fail-open truth unless `work-planning` already marked the route blocked.
- A team-lead dispatch route lacking required `CODEX-INDEPENDENT-REVIEW-BASIS` reopens `work-planning`.
- `NEXT-CONSEQUENTIAL-ACTION` traces to the first executable row of `TEAM-LEAD-WORK-PLAN`; failed trace opens `work-planning`.
- If `ACTIVE-WORKFLOW: dev-workflow` is present, consume `skipped:no-material-independent-review-trigger:<basis>` as valid skipped truth; other `skipped:*` values reopen `work-planning`.
- `EXECUTION-READINESS-BASIS` must be `ready:<basis>` before packet assembly, dispatch-bound carrier materialization, `TeamCreate`, `Agent`, assignment-grade `SendMessage`, assignment reuse, or assignment-grade dispatch.
- When `PLAN-VERIFICATION-BASIS` is mandatory under work-planning, `ready:<basis>` is dispatch-valid only with current `PLAN-VERIFICATION-BASIS: Skill(review-verification):plan-draft-readiness:<PACKET-ID>:pass`; stale review, owner-local judgment, inline checklist, proxy prose, required corrections, or blocking `OPEN-SURFACES` reopens `work-planning` before packet assembly, materialization, runtime creation, or dispatch.
- `blocked:<basis>` can enter this skill only for a dispatch-owned blocker-clear move named by `NEXT-CONSEQUENTIAL-ACTION`.
- Otherwise return to `work-planning`.
- A frozen route lacking measured burden basis reopens `work-planning`.
- A frozen route whose binding surface materialized as an external carrier requires on-disk verification of that carrier per `.claude/skills/work-planning/references/parallel-fit.md`. PROTECTED-LOCAL-RESTATEMENT-BASIS: runtime-side enforcement of the planning-side verification rule; runtime preflight requires planning-side verification before dispatch.
- Missing on-disk verification reopens `work-planning` before runtime creation, packet assembly, reuse, `SendMessage`, or `Agent`.
- A frozen route that will create retained outputs or write-producing lane carriers requires quiet artifact-footprint and retained-path collision preflight from `.claude/reference/environment-output-root-filesystem-law.md` before runtime creation, packet assembly, reuse, `SendMessage`, or `Agent`.
- Missing, stale, or contradicted collision preflight reopens `work-planning` or packet correction before send; an existing retained-output path with mismatched current-run identity blocks assignment delivery instead of pushing collision discovery to the lane.
- Output-root or retained-path creation/preflight failure consumes `.claude/reference/environment-output-root-filesystem-law.md` `## Output-Root Failure Recovery` before any same-path retry, packet assembly, reuse, `SendMessage`, or `Agent`.
- `PARALLEL-GROUPS: none` on multi-surface work requires a measured dependency or serial-burden basis; missing basis reopens `work-planning`.
- Route, staffing, parallelism, or dispatch options that doctrine and evidence can settle reopen `work-planning` or continue with the evidence-backed route.
- A field required by the frozen route that is missing, contradictory, or marked `not-applicable` without an allowed basis reopens `work-planning`.
- Assigned output requiring detailed internal material requires a retained-output path or non-visible carrier before dispatch.
- Task-state mutation assignment requires the receiver to have the required task-state tool before dispatch.

## Information Movement Rule
- `work-planning` -> `team-lead/task-execution` uses internal carry-forward of the frozen planning basis.
- `task-execution` -> agent uses an assignment-grade dispatch packet derived from that basis.
- agent -> `team-lead` state transport uses only the no-detail `dispatch-ack`, `scope-pressure`, `hold|blocker`, and `subjob-done` tokens.
- agent -> `team-lead` problem/detail transport carries `problem-report`, lead-requested `status`, blocker-clear facts, blocker corrections, findings, counts, paths, and `MESSAGE-CLASS` blocks through non-rendered task state, retained carriers, runtime ledgers, or governed evidence artifacts as owned by `message-classes.md`; visible `SendMessage` fields carry only the allowed no-detail state token.
- agent -> peer visible `SendMessage` fields carry no evidence notes, critique detail, clarification detail, or partial-result context. Peer-required detail moves through retained carriers, non-rendered task state, runtime ledgers, or governed evidence artifacts while the visible envelope remains no-detail.
- user -> teammate uses teammate UI for direct instruction, follow-up question, or redirect prompt inside the receiver's current authority and active surface.
- Shared task-list state moves through `TaskCreate`, `TaskUpdate`, `TaskGet`, and `TaskList`; `TaskOutput` and `TaskStop` are background-task inspection/control, not task-list identity.
- Task identity follows `.claude/skills/task-execution/references/message-classes.md` `### Assignment Delivery Contract`.
- Task identity requires the contract-owned task basis rather than agent name alone.
- Task-state mutation is assigned only to an owner whose tool surface includes the required task-state tool.
- Agent-originated team-runtime message traffic is official only through `SendMessage`.
- Official message-channel payload keeps state detail, status, blocker, findings, counts, paths, `MESSAGE-CLASS` blocks, and `problem-report` fields out of visible teammate pane/final text; visible worker-originated transport is limited to the exact token-only state signal allowed by Transport Payload.
- Official delivery uses the required message channel.
- Keep the full internal planning block in `team-lead/task-execution` carry-forward.
- Send only the bounded fields needed for the agent's owned surface.
- Assignment packets carry the governed Communication Plane payload through `SendMessage`, non-rendered task state, or retained carriers.

## Resolve Next Owner And Action
- Passing entry contract opens `task-execution` Step 1 Activate Frozen Route.
- Missing `work-planning` opens `work-planning`.
- Missing frozen workflow or sequence owner opens that owner.
- Missing frozen runtime route basis reopens `work-planning`.
- Current-runtime uncertainty or recovery need opens `session-boot`.
- Absent current-session team registration inside a frozen team-agent route opens `TeamCreate` through `runtime-dispatch-law.md`, not `session-boot`.
- Missing, contradictory, stale, or invalid route fields reopen `work-planning`.
- Dispatch-owned blocker-clear readiness returns to `task-execution`.
- Plain-text delivery attempts open official message-channel correction before dispatch truth.
- Missing task-state identity opens `TaskList`, `TaskGet`, `task_assignment`, or returned-mutation evidence recovery before task mutation.
- Available background task output path opens `Read` instead of `TaskOutput`.
