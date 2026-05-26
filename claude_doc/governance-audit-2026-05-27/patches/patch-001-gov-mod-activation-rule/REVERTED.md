STATUS: REVERTED (all 4 file Edits undone; 4 consumed surfaces restored to original text)
REVERT-TRIGGER: operator correction 2026-05-26 — "이 스킬 뿐만 아니라 모든 스킬 로드는 상황에 맞게 사용되는기 기본 원칙이야~!!" ("for not just this skill, but ALL skill loads, being used according to situation is a basic principle")

## Lesson
Operator-identified principle: skill load timing follows a GENERALIZED basic principle that applies to ALL skills, not a per-skill specific clarification. Canonical owner of that principle: `.claude/reference/work-skill-reference-binding-law.md` `## Skill Rules`, particularly:
- line 62: "Skill-load eligibility is decided from the interpreted requested outcome or runtime-owned trigger, not from skill names, document names, doctrine names, or procedure words in the user message."
- line 72: "Before non-preloaded `Skill(<skill>)`, the consuming owner proves the requested outcome creates that skill's active execution owner path; pre-load inspection supports eligibility only."
- line 74: "Skill consumption is situation-scoped by current work surface, trigger flag, workflow phase, proof burden, acceptance burden, and same-boundary lane-local discovery."

The original behavioral failure (planning Phase 4 placement for governance-modification while leaving Phases 1-3 outside the skill flow) was an APPLICATION error on the consumer side (team-lead reading the general principle correctly), NOT a defect in the activation rule itself. The original rules at modification-core-law line 154-155 + agent-team-lead SKILL line 46, 77 + team-lead role line 78 correctly restate the general principle as per-skill triggers; the engagement-frozen-deliverable case is covered by "interpreted requested outcome" (line 62) — the requested outcome includes the patches deliverable, which creates governance-modification's active execution owner path AT the engagement freeze moment, not deferred to design step or mutation step.

## Why The 4 Patches Were Wrong
The 4 patches added "OR a frozen engagement deliverable" as an additional explicit trigger to each per-skill activation rule. Per CLAUDE.md §5 Modification Philosophy: "Distributed common execution meaning consolidates to its single owner surface" — this principle prohibits restating a generalized rule into multiple per-skill surfaces. The general principle in work-skill-reference-binding-law `## Skill Rules` already covers the frozen-engagement-deliverable case via "interpreted requested outcome"; the 4 per-skill additions duplicated this without adding new execution force. Per §5 keywords (`minimum-executable-information`, `removal-first`), the additions were over-specification.

## Correct Behavior Going Forward
- Read work-skill-reference-binding-law `## Skill Rules` carefully whenever a skill load decision is being made.
- Apply "interpreted requested outcome" + "situation-scoped" + "active execution owner path" reasoning to decide skill load timing per the general principle.
- Do NOT add per-skill specific triggers when the general principle already covers the case.
- For the current engagement (governance-audit-2026-05-27): governance-modification's active execution owner path was created at engagement freeze (Phase 1 work-planning Step 4 froze the patches deliverable). Skill(governance-modification) is correctly active from that moment (same-session-loaded since turn 4 of this session). The audit (Phase 2) + promotion (Phase 3) phases are PROBLEM-BASIS preparation steps inside the active governance-modification flow; design (Phase 4) is Step 2-5 of governance-modification; mutation (Phase 5) is Patch Execution Method; post-verify (Phase 6) is Post-Verify. No additional framing document or per-skill rule patch is needed — the general principle already handles this correctly when read with proper interpretation.

## Artifacts Preserved For Record
- `review-verification-packet.md` — preserved as record of the patch-design attempt (now superseded)
- `change-sequence-design.md` — preserved as record (now superseded)
- `self-verification-record.md` — preserved as record (now superseded)
- (no `patch-diff.md` was written; the 4 Edits were applied and then reverted directly)

## Revert Verification Evidence
All 4 surfaces re-verified this turn via Bash grep:
- `.claude/reference/modification-core-law.md` line 154-155: restored to original text
- `.claude/skills/agent-team-lead/SKILL.md` line 46: restored to original text
- `.claude/skills/agent-team-lead/SKILL.md` line 77: restored to original text
- `.claude/agents/team-lead.md` line 78: restored to original text
