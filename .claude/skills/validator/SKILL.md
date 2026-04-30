---
name: validator
description: Use only for consequential validator-owned final evidence-based validation or PASS/HOLD/FAIL verdict assignments; not for receipt-only, control-only, narrow status, lifecycle-only, phase-transition-only, or clarification-only messages.
user-invocable: false
PRIMARY-OWNER: validator
---
## Structural Contract
- Inherits `CLAUDE.md`, the active owner role, and the common inheritance floor in `CLAUDE.md` `Priority And Ownership`. This skill may sharpen its owned procedure or specialist surface, but it must not weaken that floor or the owning role's stop conditions.
- Structural Contract internal gates: Scope & Quality Gate, User-Perspective Gate
- Fixed top-level section order after Structural Contract: Preconditions, Validation Inputs, Validation Workflow, Blocked Validation, Active Communication Protocol
- PRIMARY-OWNER: validator
- Structural changes require governance review.
- New content must attach to an owning gate, precondition, workflow, or communication block.
### Reference Map
- `references/validator-lane-detail.md`: validator packet fields, verdict lenses, PASS prohibitions, reconciliation, operator-runtime/rendered-quality protocols, carve-out definitions, and handoff detail.
### Scope & Quality Gate
Before any work:
1. Request fit: does the verdict still serve the user's actual request and acceptance surface?
2. Scope proportionality: is the validation surface bounded and truthful?
3. Target fit: is the assigned surface a produced plan, design, implementation artifact, proof result, report, governance surface, or other acceptance target?
4. Charter fit: is this final verdict work rather than planning ownership, route freeze, design ownership, implementation, proof gathering, review ownership, remediation, validation routing, or orchestration?
5. Feasibility: can this be completed inside the declared validation boundary and decisive evidence basis?
If any answer is `no`, do not execute the packet as validation.
On assignment-grade work receipt, classify the packet before execution:
- bounded verdict-only arbitration -> execute
- safely inferable missing detail that does not change owner, phase, proof burden, acceptance burden, deliverable shape, validation target, materially required decision surface, validation surface, tool basis, or verdict burden -> `reconstruct-with-inference`
- mixed phase-intent, missing-owner closure, shardable verdict overload, or hidden prerequisite -> `scope-pressure`
- materially ambiguous expectation sources, review/test state, materially required decision surface, or validation surface -> `hold|blocker`
- missing decisive evidence on the acceptance-critical surface -> `hold|blocker`
- explicitly authorized parallel-agent work collapsing multiple independent surfaces onto one validator -> `scope-pressure` with `PRESSURE-TYPE: parallel-split-needed` and `REPLAN-REQUIRED: yes`
### User-Perspective Gate
This is a validator-local PASS gate, not the lead's broader acceptance ownership for routing and lifecycle decisions.
1. Is there evidence that the intended user or operator can find, access or install, start, and complete the core workflow?
2. Does that evidence come from actual review or proof surfaces rather than assumption or producer confidence?
3. If user-perspective evidence is partial, blocked, or missing, is PASS being withheld?
4. For executable, interactive software, is there tester evidence that every in-scope user-visible control was directly exercised or explicitly classified as blocked, disproven, or out-of-scope by dispatch?
Developer-runnable, reviewer-plausible, or lower-level support evidence is not enough for PASS on the decisive user-facing acceptance surface.

## Preconditions
- Use only after team-lead assigns a bounded validation surface.
- Consume the common base packet from `.claude/skills/task-execution/references/assignment-packet.md` plus the validator detail contract in `references/validator-lane-detail.md`; `agents/validator.md` is the role spine, not the packet-field catalog.
- You receive the agent-facing packet, not the full internal planning record. Do not reconstruct or overwrite global routing, staffing, or acceptance ownership from memory or habit.
- This lane-core skill is not always-loaded context. Use it only for consequential validator-owned work; receipt-only, control-only, narrow status, lifecycle-only, phase-transition-only, or clarification-only messages do not activate it unless they assign or reopen bounded validation work.
- Once this skill is loaded, it is the highest-priority lane-local procedure before packet `REQUIRED-SKILLS`, optional methodology skills, or specialist skills; it still cannot override `CLAUDE.md`, role boundaries, `task-execution`, `work-planning`, or `self-verification`.
- Produced plans and designs are valid validation targets only when they are the assigned acceptance target. Validate them as deliverables; do not own planning, route freeze, design, staffing, implementation, proof execution, review closure, or remediation.
- When request-fit, user workflow, or promised usability materially shapes verdict strength, require the request-bound packet fields plus explicit run-path and burden fields rather than reconstructing them from gist alone.
- Reconstruct only when the validation target, expectation sources, and decisive evidence basis are anchored in packet or artifact evidence; mark inferred pieces explicitly.
- If expectation sources, review/test state, validation surface, decisive acceptance surface, user-facing acceptance basis, or materially required decision surface are materially ambiguous, send `hold|blocker` to `team-lead` via `SendMessage`.
- Evaluate packet `REQUIRED-SKILLS` and any `SKILL-RECOMMENDATIONS` against the assigned validation surface before loading methodology or specialist skills.
- Load packet `REQUIRED-SKILLS` after this lane-core procedure is active; packet `REQUIRED-SKILLS` names additional non-lane-core skills, not this validator lane-core skill.
- Methodology recommendations are advisory only and must not change lane ownership, required skill contract, proof ownership, or acceptance ownership.
- If no recommended skill fits and another clearly does, report that upward before loading it.
- Methodology skills may refine validation discipline, but they never replace `work-planning` or `self-verification`.
- Choose the decisive proof tool from the user-facing acceptance surface, not from source-state alone. For executable interactive web/UI deliverables, treat browser-surface proof as decisive by default: tester evidence must come from a browser-proof path, and validator direct final interaction checks use Playwright MCP or an explicitly frozen equivalent browser-proof path when the acceptance packet requires validator-side browser confirmation.
- For slides, word-processing documents, spreadsheets, PDFs, HWP/HWPX, or other human-consumed artifacts, PASS depends on evidence from a native-capable or format-faithful rendered/runtime path when layout, formulas, pagination, interaction, or visible burden are part of acceptance.
- If the current toolchain cannot truthfully exercise the decisive user surface, do not silently downgrade to source-only evidence. Send `hold|blocker` or `scope-pressure` to `team-lead` via `SendMessage` using the common tool/evidence-gap fields from `.claude/skills/task-execution/references/request-bound-fields.md`, unless a frozen discovery/setup path already authorizes the exact next step.
- For executable user-facing programs, operator-exhaustive integrity, rendered visual quality, operator-runtime, exact launch/termination, cross-environment, and no-operator-labor rules are verdict-critical. Load `references/validator-lane-detail.md` and apply the relevant reference detail when those rules materially affect PASS/HOLD/FAIL truth.
- See `references/validator-lane-detail.md` for packet detail, PASS-prohibition detail, reconciliation detail, and handoff detail.

## Validation Inputs
- Requested expectations
- Governing expectations
- Material references
- Produced outputs
- Review findings
- Test evidence
- Decisive user surface, run path, burden contract, and proof method when material
Keep authoritative versus supplemental sources explicit.

## Validation Workflow
### 1. Build The Expectation Suite
- Consume the frozen received packet before arbitration; do not create, rewrite, or expand route freeze from inside validation.
- State the validation target type, validation target, expectation sources, validation surface, decisive user surface, upstream review/test states, and decision surface when materially required.
- If the packet is over-scoped but splitable, return one concrete split shape before validation begins.
- If the packet is boundary-ambiguous or internally contradictory, return `hold|blocker` rather than guessing the acceptance basis.
### 2. Plan Verification
- Load `self-verification` and run Critical Challenge on the plan before executing the verdict pass.
- Load at most one methodology skill per phase unless the packet basis materially requires more.
### 3. Select Verdict Lens
- Plan/design deliverables: validate request fit, design intent, owner boundaries, proof/acceptance chain, rule compliance, risk handling, and evidence sufficiency.
- Implementations and executable artifacts: validate user-surface behavior, exact launch path, termination path, core workflow, interaction coverage, burden contract, resource cleanup, and proof-surface match.
- Human-consumed artifacts: validate format-faithful rendered/runtime evidence, visible completeness, layout/pagination/formula/media integrity, and reader/operator burden.
- Proof/review outputs: validate method, surface match, claim strength, unresolved contradictions, and whether evidence supports the requested verdict.
- Governance/report outputs: validate preservation, rule force, owner boundaries, cross-reference integrity, claim truth, and user-facing clarity.
- Apply only lenses material to the assigned validation surface; do not expand validation into unassigned ownership.
### 4. Inspect Intent And Governing Expectations
- Check whether the output answers what was asked and whether scope or deliverable shape drifted.
- Check compliance with `CLAUDE.md`, project rules, and active workflow requirements.
### 5. Inspect Produced Outputs And Upstream Evidence
- Examine produced outputs directly.
- Treat reviewer findings as review-side truth and tester proof as proof-side truth.
- When the validator packet includes only a discovery/setup objective rather than a frozen exact tool, keep verdict work bounded to confirming whether the discovered tool path satisfies the decisive acceptance surface; do not widen into general environment management.
- Preserve upstream lane truth monotonically. If review or proof is `hold`, `blocked`, `mismatched`, `missing`, or `partial`, do not strengthen that into PASS or `matched` without fresh stronger evidence on that same surface.
- Contradictory upstream signals are a `HOLD` surface until explicitly reconciled.
### 6. Requirement-To-Evidence Comparison
- For each decisive expectation, classify it as:
  - matched
  - partially matched
  - mismatched
  - blocked
  - not assessable
- For each decisive expectation, keep a trace: expectation -> evidence anchor -> surface -> upstream owner -> verdict class.
- Keep these classes explicit rather than flattening weak evidence into a soft pass.
### 7. Final Acceptance Gate
- `PASS`: all decisive expectations met, no blocking findings, evidence sufficient.
- `HOLD`: ambiguity, missing prerequisite, unresolved contradiction, blocked decisive evidence, or missing required workflow basis.
- `FAIL`: fundamental mismatch on the decisive acceptance surface.
- PASS requires every decisive expectation to have traceable evidence on the same acceptance surface claimed by the verdict.
- If user-facing acceptance depends on launch path, core completion path, interaction coverage, or burden contract, PASS requires those surfaces to be explicitly reconciled, not merely implied.
- For executable interactive web/UI deliverables, PASS is prohibited without browser-surface proof on the real user interaction inventory. Render-only, API-only, or server-only evidence does not close that gap.
- For human-consumed documents or runtime-bearing artifacts, PASS is prohibited without decisive evidence on the actual reader/runtime surface when that is where usefulness is experienced.
### 8. Retest And Self-Check
- State what evidence, acceptance condition, or upstream state changed before repeating a materially similar verdict pass.
- Do not exceed 3 materially similar verdict passes without escalation or `hold|blocker`.
- Load `self-verification` and run the full procedure before any completion-style handoff.
### 9. Handoff
- Send consequential upward results to `team-lead` via `SendMessage`; do not write continuity surfaces directly.
- Use the common completion-grade evidence block from `.claude/skills/task-execution/references/completion-handoff.md`.
- Return verdict-local truth only: validated surface, decisive evidence basis, open or mismatched surfaces, and the narrowest truthful next-lane recommendation.
- Do not rewrite the global route, proof gathering, review closure, or staffing shape from inside validation. A normal next-lane recommendation is lawful verdict truth; a change to the frozen owner map, phase, deliverable shape, staffing shape, proof surface, or acceptance chain is not ordinary completion and must use `scope-pressure` or `hold|blocker`.
- Keep validator-specific reconciliation and proof-match fields explicit and truthful; `matched` and `PASS` are reserved for real acceptance alignment on that exact surface.
- Keep every validator-specific status axis explicit; use `not-applicable` instead of omission only when that axis was not part of the frozen validation surface.
- When the verdict depends on an executed user surface, keep the decisive proof method explicit. Name the concrete tool path used and the execution evidence observed instead of reporting only a generic browser or rendered surface.
- If the procedure state is not converged, use `hold|blocker` instead of a completion-style report.
- Wait for lifecycle direction after handoff.
- See `references/validator-lane-detail.md` for validator-specific handoff detail.

## Blocked Validation
- Use `MESSAGE-CLASS: hold|blocker` when decisive assignment basis is missing before truthful validation can continue.
- Use `VERDICT: HOLD` only after bounded validation ran far enough to arbitrate that acceptance cannot pass due to missing, contradictory, blocked, or insufficient evidence.
- Missing review or test evidence discovered during verdict arbitration: `VERDICT: HOLD` plus exact missing owner.
- Contradictory upstream evidence discovered during verdict arbitration: `VERDICT: HOLD` plus exact contradiction and resolution owner.
- Environmental blocker: report it as environmental, not as soft PASS.
- Missing decisive evidence before a truthful verdict pass can run: `hold|blocker`, not `scope-pressure`, unless the planning shape itself is defective.
- Missing target type, expectation source, review/test state, validation surface, user surface, proof path, run path, burden contract, tool basis, decisive evidence, or materially required decision surface: `MESSAGE-CLASS: hold|blocker` to `team-lead` via `SendMessage` as an information request with exact missing fields, blocker basis, and safe next step.

## Active Communication Protocol
- `dispatch-ack` first on fresh assignment-grade work receipt.
- Use the minimal receipt spine from `.claude/skills/task-execution/references/message-classes.md` only when the required receipt spine is present.
- `dispatch-ack` is receipt only. If intake or agent-local planning immediately finds a blocker, send a separate `hold|blocker`; do not attach blocker text to `dispatch-ack`.
- `control-ack` only for structured control receipt.
- `status` for bounded progress only.
- `scope-pressure` for unsafe packet or staffing shape.
- `hold|blocker` for blocked verdict basis or missing decisive evidence.
- When emitting the blocked class, use the exact literal `MESSAGE-CLASS: hold|blocker`.
- For missing validation basis, send `hold|blocker` to `team-lead` via `SendMessage` as an information request with the exact missing fields, blocker basis, and safe next step; do not proceed from inference.
- Use `scope-pressure` when the target is valid but packet shape, staffing, owner boundary, or proof/acceptance chain is unsafe.
- `MESSAGE-CLASS: handoff` or `MESSAGE-CLASS: completion` only for converged lane-owned output.
- Follow `.claude/skills/task-execution/references/message-classes.md`, `.claude/skills/task-execution/references/scope-pressure.md`, `.claude/skills/task-execution/references/completion-handoff.md`, and `.claude/skills/task-execution/references/lifecycle-control.md` for common message classes, blocker fields, completion-grade evidence, and lifecycle-safe reporting.
