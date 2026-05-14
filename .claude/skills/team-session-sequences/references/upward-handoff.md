---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/team-session-sequences/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Reference Binding; active owner path"
REFERENCE-OWNER: team-session-sequences
LOAD-POLICY: on-demand reference only
---

# team-session-sequences: Consequential Upward Handoff Block
- For consequential upward `SendMessage` transport from runtime lanes with `MESSAGE-CLASS: handoff` or `MESSAGE-CLASS: completion`, keep one authoritative handoff block in the transport body or retained-output carrier instead of scattering acceptance-critical state across prose. This reference does not replace `.claude/skills/task-execution/references/completion-handoff.md`; completion-grade transports must satisfy that common spine first, then add the lane-owned fields below.
- Exact `MESSAGE-CLASS: hold|blocker` uses the blocker-native fields in `.claude/skills/task-execution/references/message-classes.md`: `BLOCKER-TYPE`, `BLOCKER-BASIS`, and `SAFE-NEXT-STEP`. Add handoff context fields in the payload carrier only when they are known and help team-lead correct, replan, continue independent lanes, or classify a true blocker.
- `status` and `scope-pressure` are Communication Plane transport and carry receiver-required detail through governed payload fields. Blocked transports use exact `MESSAGE-CLASS: hold|blocker`; do not emit bare `hold` or bare `blocker`.
- Runtime checks must not bottleneck ordinary chat. Once a lane declares `MESSAGE-CLASS: handoff` or `MESSAGE-CLASS: completion`, a missing authoritative handoff block makes the transport synthesis-invalid: team-lead must consume it as blocker/open-surface evidence or request corrected transport, not treat it as completion.
- Session-readable handoff blocks use the common completion spine as the required field floor.
- This reference adds only the lane-owned state fields below.
- Lane-owned enumerated fields for consequential upward handoff blocks:
  - `developer` -> `PREREQ-STATE: complete|partial|missing`
  - `reviewer` -> `REVIEW-STATE: ready|hold|blocked`
  - `tester` -> `TEST-STATE: ready|hold|blocked`
  - `validator` -> `VERDICT: PASS|HOLD|FAIL`
- Preserve lane-owned state monotonically across reroute and re-dispatch. `team-lead` summarizes or routes from these fields, but must not silently strengthen an agent-owned state without a fresh explicit transport from the owning lane or stronger evidence on that same lane surface.
- `tester` does not emit `TEST-STATE: not-needed`; that remains a lead-side validation-ingress decision when the acceptance design truthfully does not require tester proof.
- `TEST-STATE: ready` means the tester handoff is row-classified and decision-ready, not that the tested artifact passed.

## Resolve Next Owner And Action
- Valid completion-grade handoff opens `completion-handoff` reconciliation.
- Missing authoritative handoff block opens corrected transport request or blocker/open-surface routing.
- `hold|blocker` opens blocker resolution through team-lead.
- `status` returns to monitoring or active owner.
- `scope-pressure` opens packet correction, route replan, parallel continue, or blocker classification.
- Validator `VERDICT` opens acceptance synthesis or correction routing.
- Monotonic lane-owned state conflict opens fresh owner evidence request.
