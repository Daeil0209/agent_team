---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/team-session-sequences/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
REFERENCE-OWNER: team-session-sequences
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# team-session-sequences: Consequential Upward Completion Block
- For consequential upward completion-class `SendMessage` transport from runtime lanes, keep one authoritative completion block in the retained-output carrier instead of scattering acceptance-critical state across prose. This reference does not replace `.claude/skills/task-execution/references/completion-handoff.md`; completion-grade transports must satisfy that common spine first, then add the lane-owned fields below.
- Hold|blocker-class transport uses the blocker-native fields in `.claude/skills/task-execution/references/message-classes.md`: `BLOCKER-TYPE`, `BLOCKER-BASIS`, and `SAFE-NEXT-STEP`. Keep those fields in the governed payload carrier, task state, or retained-output path rather than rendered `SendMessage` body text. Add completion context fields in the payload carrier only when they are known and help team-lead correct, replan, continue independent lanes, or classify a true blocker.
- `status` and `scope-pressure` are Communication Plane transport and carry receiver-required detail through governed payload fields. Blocked transports use hold|blocker-class transport; do not emit bare `hold` or bare `blocker`.
- Once a lane declares completion-class transport, a missing authoritative completion block makes the transport synthesis-invalid: team-lead must consume it as blocker/open-surface evidence or request corrected transport, not treat it as completion.
- Session-readable completion blocks use the common completion spine as the required field floor.
- This reference adds only the lane-owned state fields below.
- Lane-owned enumerated fields for consequential upward completion blocks:
  - `developer` -> `PREREQ-STATE: complete|partial|missing`
  - `reviewer` -> `REVIEW-STATE: ready|hold|blocked`
  - `tester` -> `TEST-STATE: ready|hold|blocked`
  - `validator` -> `VERDICT: PASS|HOLD|FAIL`
- Preserve lane-owned state monotonically across reroute and re-dispatch. `team-lead` summarizes or routes from these fields, but must not silently strengthen an agent-owned state without a fresh explicit transport from the owning lane or stronger evidence on that same lane surface.
- `tester` does not emit `TEST-STATE: not-needed`; that remains a lead-side validation-ingress decision when the acceptance design truthfully does not require tester proof.
- `TEST-STATE: ready` means the tester completion is row-classified and decision-ready, not that the tested artifact passed.

## Resolve Next Owner And Action
- Valid completion-grade output opens completion-contract reconciliation.
- Missing authoritative completion block opens corrected transport request or blocker/open-surface routing.
- `hold|blocker` opens blocker resolution through team-lead.
- `status` returns to monitoring or active owner.
- `scope-pressure` opens packet correction, route replan, parallel continue, or blocker classification.
- Validator `VERDICT` opens acceptance synthesis or correction routing.
- Monotonic lane-owned state conflict opens fresh owner evidence request.
