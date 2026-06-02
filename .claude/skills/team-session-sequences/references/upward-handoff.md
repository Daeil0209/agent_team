---
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/team-session-sequences/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
REFERENCE-OWNER: team-session-sequences
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-prohibition-law.md
---

# team-session-sequences: Consequential Upward Completion Block
- For consequential upward `completion` transport from runtime lanes, keep one authoritative completion block in the retained-output carrier instead of scattering acceptance-critical state across prose. This reference does not replace `.claude/skills/task-execution/references/completion-handoff.md`; completion-grade transports must satisfy that common spine first, then add the lane-owned fields below.
- `hold|blocker` state uses the no-detail state token from `.claude/skills/task-execution/references/message-classes.md`; blocker detail uses the preceding non-rendered `problem-report` fields: `PROBLEM-TYPE`, `PROBLEM-BASIS`, `AFFECTED-ACTION`, `ATTEMPTED-RECOVERY`, `CAN-CONTINUE`, `NEXT-STATE`, and `SMALLEST-NEXT-OWNER-ACTION`. Add completion context fields in the payload carrier only when they are known and help team-lead correct, replan, continue independent lanes, or classify a true blocker.
- `status` and `scope-pressure` are Communication Plane states and carry receiver-required detail through non-rendered payload fields. Blocked state uses `hold|blocker`; do not emit bare `hold` or bare `blocker`.
- Once a lane declares `completion` transport, a missing authoritative completion block makes the transport synthesis-invalid: team-lead must consume it as blocker/open-surface evidence or request corrected transport, not treat it as completion.
- Retained-carrier completion blocks use the common completion spine as the required field floor; they are session-readable to the receiving owner through the carrier, not pane text, final prose, visible `SendMessage` body, or task-row fields.
- This reference adds only the lane-owned state fields below.
- Lane-owned enumerated fields for consequential upward completion blocks:
  - `developer` -> `PREREQ-STATE: complete|partial|missing`
  - `reviewer` -> `REVIEW-STATE: ready|hold|blocked`
  - `tester` -> `TEST-STATE: ready|hold|blocked`
  - `validator` -> `VERDICT: PASS|HOLD|FAIL`
- Preserve lane-owned state monotonically across reroute and re-dispatch. `team-lead` summarizes or routes from these fields, but must not strengthen an agent-owned state without fresh explicit transport from the owning lane; stronger evidence routes back to the owning lane, while team-lead may preserve, weaken, or mark the state open.
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
