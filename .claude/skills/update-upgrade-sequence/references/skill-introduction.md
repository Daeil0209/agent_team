# update-upgrade-sequence: Skill Introduction
PRIMARY-OWNER: team-lead
LOAD-POLICY: on-demand reference only
auto-inject: false

Use this file when creating, deleting, splitting, merging, re-homing, or reclassifying skills.

## Skill Introduction Rules
- New skills are allowed when a reusable procedure or specialist judgment surface is missing and repeated reuse is expected.
- Before introducing a new skill, check whether the need is better handled by updating an existing skill, strengthening an existing agent charter, or adding a path-scoped rule.
- If the missing skill is the declared prerequisite for finishing the active task safely or credibly, complete the skill update or introduction before the blocked task surface re-enters normal execution. Keep that pause scoped to the blocked surface.
- A new skill must state the capability gap it closes, owning role, non-owned surfaces, and invocation boundary.

## Ownership Classification
Distinguish `specialist skill` from `common skill` before assigning ownership.
- `specialist skill`: sharpens one lane's charter-bound execution or judgment surface. That lane is the direct patch owner.
- `common skill`: carries shared runtime, governance, routing, lifecycle, or cross-lane operating procedure. It has one primary owner even when many lanes consume it.

Common-skill ownership follows the Single Writer Principle.
- Every common skill has exactly one primary owner.
- Other impacted lanes are inspectors, challengers, or reviewers, not co-owners of the direct patch.
- A common-skill patch packet names at minimum `PRIMARY-OWNER`, `IMPACTED-LANES`, `OVERLAP-REVIEW`, `INFO-LOSS-REVIEW`, and `VERIFY-BASIS`.

Current default: `team-session-sequences` is a `team-lead`-owned common skill for session-sequence indexing and dispatch-detail lookup. Runtime spine stays with `.claude/skills/session-boot/SKILL.md`, closeout spine stays with `.claude/skills/session-closeout/SKILL.md`, and packet schema stays with `.claude/skills/task-execution/SKILL.md` unless an explicit governance decision reassigns one of those owner surfaces.

## Category Gate
Every proposed new skill must be classified into exactly one primary category:
- `repeatable procedure`: reusable multi-step workflow that recurs across tasks or sessions
- `specialist judgment surface`: recurring expert perspective that sharpens implementation, review, or planning quality
- `integration or environment bridge`: reusable external-tool, connector, or setup protocol with stable verification and fallback steps
- `governance or quality hardening`: reusable review, validation, migration, or operational-discipline procedure not already owned elsewhere

Reject the proposal when it is primarily:
- a one-off task brief
- project-local knowledge that belongs in local doctrine
- a temporary workaround with no expected reuse
- a duplicate of an existing skill, agent charter, or rule owner
- a style preference with no clear reusable procedure or authority boundary

Approval packet for a new skill must name category, expected reuse pattern, existing-owner overlap result, chosen owner, why existing skill expansion was insufficient, and first adoption path.

If the proposal cannot survive this gate cleanly, do not create a new skill. Update the correct existing owner instead.
