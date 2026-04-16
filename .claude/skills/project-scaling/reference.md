# Reference Material

## Detection Heuristics Table

These signals indicate a likely tier. They are suggestions for `team-lead` judgment, not automatic project-tier authority. Project-level governance parameters apply only after the user-confirmed tier in SKILL.md §Classification Procedure; per-request handling may still be raised autonomously when direct risk signals require a stricter task tier.

| Signal | Likely Tier |
|---|---|
| `terraform/`, `k8s/`, `docker-compose.yml` present in repo | Precision |
| Security-sensitive changes, auth systems, secrets management | Precision |
| API integration, third-party service wiring, multi-file feature | Standard |
| Structured development project with spec or design doc | Standard |
| Single page, simple script, isolated config change, typo fix | Lightweight |

## Governance Parameters Per Tier Table

| Parameter | Lightweight | Standard | Precision |
|---|---|---|---|
| **Default review/proof depth** | `reviewer` gate | `reviewer` + `tester` | `reviewer` + `tester` + `validator` |
| **Review scope** | Code quality | + architecture consistency | + security (`sec-review`) + infrastructure |
| **Testing requirements** | Basic verification | Structured testing | E2E + security + performance |
| **Documentation required** | Minimal (inline) | Feature-specific docs | Architecture + design + API docs |
| **Recommended team size** | 1–2 workers | 2–3 workers | Precision 5-lane deployment |
| **Design options** | Optional | Recommended | Required (3 architecture options) |
| **Interactive checkpoints** | CP4 only (implementation approval) | CP1, CP3, CP4 | All 5 checkpoints (CP1–CP5) |
| **Gap analysis** | Optional | Recommended | Required before acceptance |
| **Specialist skills** | None by default | `dev-workflow` | `dev-workflow` + `sec-review` + `enterprise-arch` |

### Checkpoint Semantics

Checkpoint semantics (CP1-CP5) are defined by dev-workflow when active. This skill governs which checkpoints are required at each governance level, not their content. The "Interactive checkpoints" column lists checkpoints that require user confirmation; dev-workflow mandatory checkpoints (e.g., CP2) still execute at all tiers but may auto-resolve without user interaction when bounded by the user's directive.

Acceptance-depth semantics: the table sizes default review and proof depth for project governance. It does not transfer final `PASS/HOLD/FAIL` authority away from the validator lane when a final validation verdict is required by role separation, task risk, or the active workflow.


## Quality Metrics Table

| Metric | Description | Use |
|---|---|---|
| **Design-implementation match score** | How well does the code match the design doc? (0–100 per file or component) | Feed into team-lead's decision to iterate, escalate, or proceed to acceptance |
| **Coverage indicator** | Percentage of design requirements with corresponding implementation | Identify unimplemented surfaces before routing to acceptance chain |


### Governance Trust Score (Input Signal)

A composite score that gives team-lead a quantitative view of project quality trends. This is an INPUT SIGNAL for judgment — it does NOT automatically change governance tier or approval gates.

**5 Components (100-point scale):**

| Component | Weight | Measures |
|---|---|---|
| Phase completion rate | 25 pts | How often do development phases complete without rollback? |
| Quality check pass rate | 25 pts | What percentage of reviews/tests pass on first attempt? |
| Error recovery rate | 20 pts | When issues occur, how quickly and cleanly are they resolved? |
| Iteration efficiency | 15 pts | How many iteration cycles needed before acceptance? (fewer = better) |
| Scope stability | 15 pts | How often does scope change after plan approval? (less change = better) |

**Score Interpretation (advisory only):**

| Range | Signal | Team-Lead Action |
|---|---|---|
| 86-100 | Strong execution | Consider lighter oversight for routine work |
| 71-85 | Healthy | Standard governance appropriate |
| 51-70 | Needs attention | Increase checkpoint frequency, review depth |
| 31-50 | Concerning | Full governance pipeline for all work, root cause analysis |
| 0-30 | Critical | Pause and reassess project approach with user |

**Rules:**
- Score is NEVER used to auto-promote or auto-demote governance tier
- Score changes are reported to team-lead as trend signals, not commands
- Team-lead uses score alongside direct evidence and user feedback
- Score calculation happens at phase transitions, not continuously
- If score and direct evidence disagree, direct evidence wins
