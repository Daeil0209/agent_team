# governance-modification: Asset Change Checks
PRIMARY-OWNER: team-lead
SOURCE-ANCHOR: .claude/skills/governance-modification/SKILL.md
SOURCE-RULES: "Parent skill Reference Map; Work Execution Philosophy reference binding; active owner path"
LOAD-POLICY: on-demand reference only
REPORTING-CURTAIN: .claude/reference/reporting-user-reporting-law.md
auto-inject: false

Use this file for ordinary team-system asset changes, skill introduction, specialist routing, Hook-Last preflight, and MCP/external-tool asset coherence.

## Update Checks
On skill, reference, and declared metadata-owner surfaces, mapping keys such as `PRIMARY-OWNER`, `SOURCE-ANCHOR`, `SOURCE-RULES`, `LOAD-POLICY`, and `REPORTING-CURTAIN` are structural metadata; classify only missing, wrong, or divergent mapping as defects.
Where a runtime setting or threshold must remain configurable, keep one owner for the literal value and make every other document reference that owner.
Preserve approved structural hierarchies, role procedure hierarchy, skill Structural Contract, reference maps, and connection mappings.
New top-level sections, orphaned procedure blocks, orphaned reference blocks, or broken mapping chains record `Skill(review-verification):<bounded-question>` before execution.
Upper-to-core executable-detail gaps and core-to-trigger-bound guidance gaps record `Skill(review-verification):governance-continuity-lens` before execution.
Under-specified governance and over-specified governance record `Skill(review-verification):minimum-executable-information-lens` before execution.
Evasion-enabling, ambiguous, conflicting, bottleneck-forming, or over-broad-blocking governance records `Skill(review-verification):minimum-executable-information-lens` before execution.
When reducing context footprint, prove moved meaning remains reachable through an owning trigger or direct reference path.
Record remaining migration, affected-surface, in-flight-output, or prior-verdict gaps instead of assuming completion.

Material defect promotion is owned by `Skill(review-verification)`.
This reference supplies asset-change evidence only.
Literal contradiction, repeated sentence, heavy gate, hook burden, deletion permission, or plausible misuse remains evidence until `Skill(review-verification):<bounded-question>` proves `confirmed-defect`.
Intended protection preserves the protection and reduces only avoidable burden.

## Skill Introduction
Use when creating, deleting, splitting, merging, re-homing, or reclassifying skills.

New skills are allowed when a reusable procedure or specialist judgment surface is missing and repeated reuse is expected.
Skill introduction starts by checking whether an existing skill, agent charter, or path-scoped rule already owns the need.
If the missing skill is prerequisite for safe or credible active-task completion, complete the skill update or introduction before that blocked surface resumes; keep the pause scoped to that surface.
A new skill states the capability gap it closes, owning role, non-owned surfaces, and invocation boundary.

Classify the proposed skill into exactly one primary category:
- `repeatable procedure`
- `specialist judgment surface`
- `integration or environment bridge`
- `governance or quality hardening`

Reject a proposed skill when it is a one-off task brief, project-local knowledge, temporary workaround, duplicate owner, or style preference without reusable procedure or authority boundary.
Approval packet names category, expected reuse pattern, existing-owner overlap result, chosen owner, why existing skill expansion is insufficient, and first adoption path.

## Specialist Routing
Specialist capabilities live as skills under `.claude/skills/<skill-id>/SKILL.md`.
Agent role files stay role identity, boundary, and stop-condition surfaces.
Agent role files use frontmatter `name`, heading, lane identity, boundary, and stop-condition rules instead of `PRIMARY-OWNER` metadata.
Authorization packets name `skill-id` and bind it to target lane plus blocked surface.
Specialist-skill authorization binds a blocked lane to bounded specialist aid.
Common-skill ownership binds a shared procedure surface to one primary owner plus named impacted lanes.

When multiple specialist skills are active on one blocked surface, use the owning role's specialist matrix and controlling order as source of truth.
Developer-owned specialist order lives in `.claude/skills/agent-developer/references/developer-lane-detail.md` `Specialist Skill Loading`.
Reviewer-owned specialist order lives in `.claude/skills/agent-reviewer/references/reviewer-lane-detail.md` `Specialist Skill Loading`.
Tester-owned specialist order lives in `.claude/skills/agent-tester/references/tester-lane-detail.md`.
`benchmark-simulation` and `external-tool-bridge` are support overlays and never override the owning role's specialist matrix.

When approving developer-side specialist skill use, send `SKILL-AUTH: lane=developer:<lane-id>; surface=<blocked-surface>; skill=<skill-id>`.

## External Tool And Hook Checks
For MCP or external-tool capability updates, verify asset-set coherence: project-root `.mcp.json`, `.claude/settings.json`, role tool authorization, hook/settings posture, and owning skill trigger/authority.
A mismatch is an update blocker or explicit deferred owner.

Promotion from non-blocking rule or fail-open use to blocking authority, self-verification-stage use, worker-lane use, custom wrapper use, or persistent metric automation requires measured benefit, authority/footprint review, and user-visible rollback or fail-open semantics before activation.

Hook/settings runtime-enforcement expansion requires Hook-Last preflight before execution.
Required basis covers non-hook failure, non-hook insufficiency, exact matcher or payload condition, recovery path, false-positive/regression check, `.claude/hooks/MANIFEST.md` Hook-Last Review Ledger entry, and explicit operator approval.
Missing basis routes to doctrine-only, owner-rule-only, or `HOLD`.
Runtime enforcement edits are forbidden without the required basis.

## Resolve Next Owner And Action
- Completed asset checks return evidence to this skill.
- Missing structural preservation opens patch redesign.
- Broken mapping chain opens owner/reference correction.
- Runtime setting or threshold owner conflict opens single-owner correction.
- Failed skill category gate opens the existing-owner update path named by the overlap check.
- Missing category, owner, or specialist routing evidence opens `HOLD`.
- Valid developer-side specialist authorization opens a `SKILL-AUTH` packet to the target lane.
- Hook/settings expansion without Hook-Last basis opens doctrine-only/owner-rule-only path or `HOLD`.
- Confirmed recurrence-barrier defect opens `Recurrence Hardening`.
