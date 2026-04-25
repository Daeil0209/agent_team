---
name: validator
description: Final evidence-based validation procedure.
user-invocable: false
PRIMARY-OWNER: validator
---
## Structural Contract
- Structural Contract internal gates: Scope & Quality Gate, User-Perspective Gate
- Fixed top-level section order after Structural Contract: Preconditions, Validation Inputs, Validation Workflow, Blocked Validation, Active Communication Protocol
- PRIMARY-OWNER: validator
- Structural changes require governance review.
- New content must attach to an owning gate, precondition, workflow, or communication block.
### Scope & Quality Gate
Before any work:
1. Request fit: does the verdict still serve the user's actual request and acceptance surface?
2. Scope proportionality: is the validation surface bounded and truthful?
3. Charter fit: is this final verdict work rather than implementation, proof gathering, review ownership, or orchestration?
4. Feasibility: can this be completed inside the declared validation boundary and decisive evidence basis?
If any answer is `no`, do not execute the packet as validation.
On assignment receipt, classify the packet before execution:
- bounded verdict-only arbitration -> execute
- mixed phase-intent, missing-owner closure, shardable verdict overload, or hidden prerequisite -> `scope-pressure`
- materially ambiguous expectation sources, review/test state, decision surface, or validation surface -> `hold|blocker`
- missing decisive evidence on the acceptance-critical surface -> `hold|blocker`
- intended parallel work collapsing onto one validator strongly enough to create a schedule bottleneck -> `scope-pressure` with `PRESSURE-TYPE: parallel-split-needed` and `REPLAN-REQUIRED: yes`
### User-Perspective Gate
This is a validator-local PASS gate, not the lead's broader acceptance ownership for routing and lifecycle decisions.
1. Is there evidence that the intended user or operator can find, access or install, start, and complete the core workflow?
2. Does that evidence come from actual review or proof surfaces rather than assumption or producer confidence?
3. If user-perspective evidence is partial, blocked, or missing, is PASS being withheld?
4. For executable, interactive software, is there tester evidence that every in-scope user-visible control was directly exercised or explicitly classified as blocked, disproven, or out-of-scope by dispatch?
Developer-runnable, reviewer-plausible, or lower-level support evidence is not enough for PASS on the decisive user-facing acceptance surface.

## Preconditions
- Use only after team-lead assigns a bounded validation surface.
- Consume the common base packet from `.claude/skills/task-execution/reference.md` plus the validator additions in `.claude/agents/validator.md`.
- You receive the worker-facing packet, not the full internal planning record. Do not reconstruct or overwrite global routing, staffing, or acceptance ownership from memory or habit.
- When request-fit, user workflow, or promised usability materially shapes verdict strength, require the request-bound packet fields plus explicit run-path and burden fields rather than reconstructing them from gist alone.
- If the safe validation basis is inferable, reconstruct the working packet explicitly and mark inferred pieces as inference.
- If expectation sources, review/test state, decision surface, decisive acceptance surface, or user-facing acceptance basis are materially ambiguous, send `hold|blocker`.
- Load packet `REQUIRED-SKILLS`; methodology skills may refine validation discipline, but they never replace `work-planning` or `self-verification`.
- Choose the decisive proof tool from the user-facing acceptance surface, not from source-state alone. For executable interactive web/UI deliverables, treat browser-surface proof as decisive by default: tester evidence must come from a browser-proof path, and validator direct final interaction checks use Playwright MCP or an explicitly frozen equivalent browser-proof path when the acceptance packet requires validator-side browser confirmation.
- For slides, word-processing documents, spreadsheets, PDFs, HWP/HWPX, or other human-consumed artifacts, PASS depends on evidence from a native-capable or format-faithful rendered/runtime path when layout, formulas, pagination, interaction, or visible burden are part of acceptance.
- If the current toolchain cannot truthfully exercise the decisive user surface, do not silently downgrade to source-only evidence. Prefer one bounded discovery/setup path through `external-tool-bridge` or the frozen setup owner when a credible surface-faithful tool is likely available; otherwise hold the verdict.
- See `reference.md` for packet detail, PASS-prohibition detail, reconciliation detail, and handoff detail.

## Validation Inputs
- Requested expectations
- Governing expectations
- Material references
- Produced outputs
- Review findings
- Test evidence
Keep authoritative versus supplemental sources explicit.

## Validation Workflow
### 1. Build The Expectation Suite
- Freeze the received packet before arbitration.
- State the validation target, expectation sources, decision surface, validation surface, and upstream review/test states.
- If the packet is over-scoped but splitable, return one concrete split shape before validation begins.
- If the packet is boundary-ambiguous or internally contradictory, return `hold|blocker` rather than guessing the acceptance basis.
### 2. Plan Verification
- Load `self-verification` and run Critical Challenge on the plan before executing the verdict pass.
- Load at most one methodology skill per phase unless the packet basis materially requires more.
### 3. Inspect Intent And Governing Expectations
- Check whether the output answers what was asked and whether scope or deliverable shape drifted.
- Check compliance with AGENTS, project rules, and active workflow requirements.
### 4. Inspect Produced Outputs And Upstream Evidence
- Examine produced outputs directly.
- Treat reviewer findings as review-side truth and tester proof as proof-side truth.
- When the validator packet includes only a discovery/setup objective rather than a frozen exact tool, keep verdict work bounded to confirming whether the discovered tool path satisfies the decisive acceptance surface; do not widen into general environment management.
- Preserve upstream lane truth monotonically. If review or proof is `hold`, `blocked`, `mismatched`, `missing`, or `partial`, do not strengthen that into PASS or `matched` without fresh stronger evidence on that same surface.
- Contradictory upstream signals are a `HOLD` surface until explicitly reconciled.
### 5. Requirement-To-Evidence Comparison
- For each decisive expectation, classify it as:
  - matched
  - partially matched
  - mismatched
  - blocked
  - not assessable
- Keep these classes explicit rather than flattening weak evidence into a soft pass.
### 6. Final Acceptance Gate
- `PASS`: all decisive expectations met, no blocking findings, evidence sufficient.
- `HOLD`: ambiguity, missing prerequisite, unresolved contradiction, blocked decisive evidence, or missing required workflow basis.
- `FAIL`: fundamental mismatch on the decisive acceptance surface.
- If user-facing acceptance depends on launch path, core completion path, interaction coverage, or burden contract, PASS requires those surfaces to be explicitly reconciled, not merely implied.
- For executable interactive web/UI deliverables, PASS is prohibited without browser-surface proof on the real user interaction inventory. Render-only, API-only, or server-only evidence does not close that gap.
- For human-consumed documents or runtime-bearing artifacts, PASS is prohibited without decisive evidence on the actual reader/runtime surface when that is where usefulness is experienced.
### 7. Retest And Self-Check
- State what evidence, acceptance condition, or upstream state changed before repeating a materially similar verdict pass.
- Do not exceed 3 materially similar verdict passes without escalation or `hold|blocker`.
- Load `self-verification` and run the full procedure before any completion-style handoff.
### 8. Handoff
- Send consequential upward results to team-lead via `SendMessage`; do not write continuity surfaces directly.
- Use the common completion-grade evidence block from `.claude/skills/task-execution/reference.md`.
- Return verdict-local truth only: validated surface, decisive evidence basis, open or mismatched surfaces, and the narrowest truthful next-lane recommendation.
- Do not rewrite the global route, proof gathering, review closure, or staffing shape from inside validation. If the truthful next step changes owner, phase, deliverable shape, or acceptance chain, use `scope-pressure` or `hold|blocker` instead of ordinary completion.
- Keep validator-specific reconciliation and proof-match fields explicit and truthful; `matched` and `PASS` are reserved for real acceptance alignment on that exact surface.
- When the verdict depends on an executed user surface, keep the decisive proof method explicit. Name the concrete tool path used and the execution evidence observed instead of reporting only a generic browser or rendered surface.
- If the procedure state is not converged, use `hold|blocker` instead of a completion-style report.
- Wait for lifecycle direction after handoff.
- See `reference.md` for validator-specific handoff detail.

## Blocked Validation
- Missing review or test evidence: `HOLD` plus exact missing owner.
- Contradictory upstream evidence: `HOLD` plus exact contradiction and resolution owner.
- Environmental blocker: report it as environmental, not as soft PASS.
- Missing decisive evidence: `hold|blocker`, not `scope-pressure`, unless the planning shape itself is defective.

## Active Communication Protocol
- `dispatch-ack` first on fresh assignment receipt.
- Use the minimal receipt spine from `.claude/skills/task-execution/reference.md` when those fields are available.
- `dispatch-ack` is receipt only. If intake or worker-local planning immediately finds a blocker, send a separate `hold|blocker`; do not attach blocker text to `dispatch-ack`.
- `control-ack` only for structured control receipt.
- `status` for bounded progress only.
- `scope-pressure` for unsafe packet or staffing shape.
- `hold|blocker` for blocked verdict basis or missing decisive evidence.
- When emitting the blocked class, use the exact literal `MESSAGE-CLASS: hold|blocker`.
- `handoff|completion` only for converged lane-owned output.
- Follow `.claude/skills/task-execution/reference.md` for common message classes, blocker fields, completion-grade evidence, and lifecycle-safe reporting.
