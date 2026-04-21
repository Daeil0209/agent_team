#!/usr/bin/env bash
set -euo pipefail

node <<'NODE'
"use strict";

const scenarios = [
  {
    id: "evidence-inventory-only",
    title: "Broad governance sweep whose output is only evidence inventory",
    multiSurface: true,
    evidenceExpansionNeeded: true,
    userFacingClosure: false,
    requiresSeverity: false,
    requiresPatchPriority: false,
    patchBundleDecision: false,
    directArtifactReviewSurface: false,
    expectedBest: ["baseline-current", "closure-review-challenge"],
    notes: [
      "Researcher fan-out should remain allowed.",
      "Requiring reviewer for every audit would over-route this case.",
    ],
  },
  {
    id: "final-defect-triage",
    title: "Broad audit that returns final defect classes, T-severity, and repair priority",
    multiSurface: true,
    evidenceExpansionNeeded: true,
    userFacingClosure: true,
    requiresSeverity: true,
    requiresPatchPriority: true,
    patchBundleDecision: true,
    directArtifactReviewSurface: true,
    expectedBest: ["reviewer-always", "closure-review-challenge"],
    notes: [
      "This models the current failure: researchers produced candidate findings and lead closed the judgment without reviewer challenge.",
    ],
  },
  {
    id: "single-surface-governance-review",
    title: "Bounded single-surface governance review over an already-identified artifact",
    multiSurface: false,
    evidenceExpansionNeeded: false,
    userFacingClosure: true,
    requiresSeverity: true,
    requiresPatchPriority: false,
    patchBundleDecision: false,
    directArtifactReviewSurface: true,
    expectedBest: ["reviewer-always", "closure-review-challenge"],
    notes: [
      "Reviewer should be allowed to own this directly without mandatory researcher fan-out.",
    ],
  },
  {
    id: "clarification-candidate-sweep",
    title: "Cross-surface wording drift scan whose deliverable is clarification candidates only",
    multiSurface: true,
    evidenceExpansionNeeded: true,
    userFacingClosure: true,
    requiresSeverity: false,
    requiresPatchPriority: false,
    patchBundleDecision: false,
    directArtifactReviewSurface: false,
    expectedBest: ["baseline-current", "closure-review-challenge"],
    notes: [
      "Reviewer should remain optional here because the output does not close consequential defect judgment.",
    ],
  },
  {
    id: "runtime-friction-postmortem",
    title: "Observed runtime friction plus cross-surface doctrine review leading to patch prioritization",
    multiSurface: true,
    evidenceExpansionNeeded: true,
    userFacingClosure: true,
    requiresSeverity: true,
    requiresPatchPriority: true,
    patchBundleDecision: true,
    directArtifactReviewSurface: true,
    expectedBest: ["reviewer-always", "closure-review-challenge"],
    notes: [
      "Requires both evidence gathering and an independent review-side judgment before user-facing repair priority is closed.",
    ],
  },
];

const strategies = [
  {
    id: "baseline-current",
    title: "Researcher shards + lead synthesis only",
    shardResearchers: true,
    reviewerOnAnyAudit: false,
    reviewerOnJudgmentClosure: false,
    reviewerSurfaceWideParallel: false,
    reviewerSingleSurfaceOnly: false,
  },
  {
    id: "reviewer-always",
    title: "Reviewer required on every governance audit",
    shardResearchers: true,
    reviewerOnAnyAudit: true,
    reviewerOnJudgmentClosure: true,
    reviewerSurfaceWideParallel: false,
    reviewerSingleSurfaceOnly: false,
  },
  {
    id: "closure-review-challenge",
    title: "Researcher evidence sweep + reviewer required only for consequential judgment closure",
    shardResearchers: true,
    reviewerOnAnyAudit: false,
    reviewerOnJudgmentClosure: true,
    reviewerSurfaceWideParallel: false,
    reviewerSingleSurfaceOnly: false,
  },
  {
    id: "reviewer-only",
    title: "Reviewer handles the audit without researcher evidence sharding",
    shardResearchers: false,
    reviewerOnAnyAudit: true,
    reviewerOnJudgmentClosure: true,
    reviewerSurfaceWideParallel: false,
    reviewerSingleSurfaceOnly: false,
  },
  {
    id: "parallel-research-plus-review-everywhere",
    title: "Researcher shards plus reviewer participates on every audit surface in parallel",
    shardResearchers: true,
    reviewerOnAnyAudit: true,
    reviewerOnJudgmentClosure: true,
    reviewerSurfaceWideParallel: true,
    reviewerSingleSurfaceOnly: false,
  },
  {
    id: "reviewer-one-shard",
    title: "One reviewer replaces one audit shard but no final integrated challenge",
    shardResearchers: true,
    reviewerOnAnyAudit: false,
    reviewerOnJudgmentClosure: false,
    reviewerSurfaceWideParallel: false,
    reviewerSingleSurfaceOnly: true,
  },
];

function requiresReviewerClosure(scenario) {
  return scenario.userFacingClosure &&
    (scenario.requiresSeverity || scenario.requiresPatchPriority || scenario.patchBundleDecision);
}

function simulate(scenario, strategy) {
  const events = [];
  const reasons = [];
  let score = 100;

  const needsReviewerClosure = requiresReviewerClosure(scenario);
  const researcherCoverageNeeded = scenario.evidenceExpansionNeeded && scenario.multiSurface;

  if (researcherCoverageNeeded) {
    if (strategy.shardResearchers) {
      events.push("researcher-shards");
    } else {
      reasons.push("evidence-undercoverage");
      score -= 30;
    }
  }

  if (!researcherCoverageNeeded && strategy.shardResearchers && !scenario.directArtifactReviewSurface) {
    reasons.push("unneeded-research-overhead");
    score -= 8;
  }

  if (scenario.directArtifactReviewSurface && strategy.reviewerSingleSurfaceOnly) {
    events.push("reviewer-one-slice");
    score -= 10;
    reasons.push("no-integrated-review-closure");
  }

  if (strategy.reviewerSurfaceWideParallel && scenario.multiSurface) {
    reasons.push("duplicated-read-load");
    score -= 12;
  }

  const reviewerPresent =
    strategy.reviewerOnAnyAudit ||
    (needsReviewerClosure && strategy.reviewerOnJudgmentClosure) ||
    strategy.reviewerSingleSurfaceOnly;

  if (needsReviewerClosure) {
    if (strategy.reviewerOnJudgmentClosure || strategy.reviewerOnAnyAudit) {
      events.push("reviewer-challenge-before-close");
    } else {
      reasons.push("closure-without-reviewer");
      score -= 55;
    }
  } else if (strategy.reviewerOnAnyAudit) {
    reasons.push("over-routing");
    score -= 14;
  }

  if (scenario.directArtifactReviewSurface && !reviewerPresent) {
    reasons.push("review-authority-missing");
    score -= 25;
  }

  let outcome = "pass";

  if (reasons.includes("closure-without-reviewer")) {
    outcome = "fail";
  } else if (reasons.includes("evidence-undercoverage")) {
    outcome = "fail";
  } else if (score < 75) {
    outcome = "weak-pass";
  }

  return { outcome, reasons, events, score };
}

function assert(condition, label, context = "") {
  if (!condition) {
    console.error(`FAIL ${label}`);
    if (context) console.error(context);
    process.exitCode = 1;
  } else {
    console.log(`PASS ${label}`);
  }
}

const rows = [];
for (const scenario of scenarios) {
  for (const strategy of strategies) {
    rows.push({
      scenario: scenario.id,
      strategy: strategy.id,
      ...simulate(scenario, strategy),
    });
  }
}

const byScenario = new Map();
for (const row of rows) {
  if (!byScenario.has(row.scenario)) byScenario.set(row.scenario, []);
  byScenario.get(row.scenario).push(row);
}

for (const scenario of scenarios) {
  const options = byScenario.get(scenario.id).slice().sort((a, b) => b.score - a.score);
  const best = options[0];
  console.log(`\n=== ${scenario.id} ===`);
  console.log(`best=${best.strategy} score=${best.score} outcome=${best.outcome}`);
  assert(
    scenario.expectedBest.includes(best.strategy),
    `${scenario.id} expected best strategy`,
    `expected one of ${scenario.expectedBest.join(", ")}, got ${best.strategy}`
  );
}

const baselineFailureScenarios = rows.filter(
  (row) => row.strategy === "baseline-current" && row.outcome === "fail"
).map((row) => row.scenario);

assert(
  baselineFailureScenarios.includes("final-defect-triage"),
  "baseline fails the observed reviewer-omission case",
  `baseline failures=${baselineFailureScenarios.join(",")}`
);

assert(
  baselineFailureScenarios.includes("runtime-friction-postmortem"),
  "baseline fails runtime-friction plus patch-priority closure",
  `baseline failures=${baselineFailureScenarios.join(",")}`
);

const closureStrategyRows = rows.filter((row) => row.strategy === "closure-review-challenge");
assert(
  closureStrategyRows.every((row) => row.outcome === "pass"),
  "closure-review-challenge passes all modeled scenarios",
  JSON.stringify(closureStrategyRows, null, 2)
);

const reviewerAlwaysRows = rows.filter((row) => row.strategy === "reviewer-always");
const evidenceOnlyAlways = reviewerAlwaysRows.find((row) => row.scenario === "evidence-inventory-only");
assert(
  evidenceOnlyAlways && evidenceOnlyAlways.score < 100,
  "reviewer-always pays overhead on evidence-only audit",
  JSON.stringify(evidenceOnlyAlways, null, 2)
);

const reviewerOnlyRows = rows.filter((row) => row.strategy === "reviewer-only");
assert(
  reviewerOnlyRows.some((row) => row.scenario === "final-defect-triage" && row.outcome !== "pass"),
  "reviewer-only loses needed researcher coverage on broad audit",
  JSON.stringify(reviewerOnlyRows, null, 2)
);

const reviewerOneShard = rows.find(
  (row) => row.strategy === "reviewer-one-shard" && row.scenario === "final-defect-triage"
);
assert(
  reviewerOneShard && reviewerOneShard.outcome === "fail",
  "reviewer-one-shard does not solve integrated closure omission",
  JSON.stringify(reviewerOneShard, null, 2)
);

const summary = strategies.map((strategy) => {
  const samples = rows.filter((row) => row.strategy === strategy.id);
  const avg = samples.reduce((sum, row) => sum + row.score, 0) / samples.length;
  const fails = samples.filter((row) => row.outcome === "fail").length;
  const weakPasses = samples.filter((row) => row.outcome === "weak-pass").length;
  return {
    strategy: strategy.id,
    avgScore: Number(avg.toFixed(1)),
    fails,
    weakPasses,
  };
}).sort((a, b) => b.avgScore - a.avgScore);

console.log("\n=== strategy-summary ===");
for (const row of summary) {
  console.log(`${row.strategy} avg=${row.avgScore} fails=${row.fails} weak=${row.weakPasses}`);
}

const bestOverall = summary[0];
assert(
  bestOverall.strategy === "closure-review-challenge",
  "best overall strategy is closure-review-challenge",
  JSON.stringify(summary, null, 2)
);

if (process.exitCode) {
  console.log("\nASSERTIONS_FAILED");
  process.exit(process.exitCode);
}

console.log("\nASSERTIONS_PASSED 10");
NODE
