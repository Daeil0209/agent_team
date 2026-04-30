---
PRIMARY-OWNER: team-lead
REFERENCE-OWNER: team-session-sequences
LOAD-POLICY: on-demand reference only
---

# team-session-sequences: Consequential Upward Handoff Block
- For consequential upward `SendMessage` reports from runtime lanes with `MESSAGE-CLASS: handoff`, `MESSAGE-CLASS: completion`, or exact `MESSAGE-CLASS: hold|blocker`, keep one authoritative handoff block explicit instead of scattering acceptance-critical state across prose.
- `status` and `scope-pressure` may stay lighter, and ordinary conversational notes may remain free-form unless the sender is actually handing off a finished, held, or decision-ready surface. Blocked reports use exact `MESSAGE-CLASS: hold|blocker`; do not emit bare `hold` or bare `blocker`.
- Runtime checks must not bottleneck ordinary chat. Once a lane declares `MESSAGE-CLASS: handoff`, `MESSAGE-CLASS: completion`, or exact `MESSAGE-CLASS: hold|blocker`, a missing authoritative handoff block makes the report synthesis-invalid: team-lead must consume it as blocker/open-surface evidence or request a corrected report, not treat it as completion.
- Common presence-required fields for consequential upward handoff blocks:
  - `TASK-ID: <active task id>`
  - `OUTPUT-SURFACE: <artifact, claim, version, or bounded work product>`
  - `EVIDENCE-BASIS: <decisive evidence anchors, checks, commands, or governing basis>`
  - `OPEN-SURFACES: <blocked, unverified, residual-risk, or none-material surfaces>`
  - `RECOMMENDED-NEXT-LANE: <next owner or none>`
  - `REQUESTED-LIFECYCLE: standby|shutdown`
- Lane-owned enumerated fields for consequential upward handoff blocks:
  - `developer` -> `PREREQ-STATE: complete|partial|missing`
  - `reviewer` -> `REVIEW-STATE: ready|hold|blocked`
  - `tester` -> `TEST-STATE: ready|hold|blocked`
  - `validator` -> `VERDICT: PASS|HOLD|FAIL`
- Preserve lane-owned state monotonically across reroute and re-dispatch. `team-lead` may summarize or route from these fields, but must not silently strengthen an agent-owned state without a fresh explicit report from the owning lane or stronger evidence on that same lane surface.
- `tester` does not emit `TEST-STATE: not-needed`; that remains a lead-side validation-ingress decision when the acceptance design truthfully does not require tester proof.
