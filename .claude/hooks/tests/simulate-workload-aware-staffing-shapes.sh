#!/usr/bin/env bash
set -euo pipefail

node <<'NODE'
"use strict";

const scenarios = [
  {
    id: "bounded-single-artifact-review",
    title: "One authored artifact, no meaningful evidence expansion, one bounded judgment",
    artifactUnderReview: true,
    evidenceExpansion: "none",
    consequentialClosure: true,
    workSurfaceCount: 1,
    judgmentAxisCount: 1,
    readVolume: "bounded",
    crossCheckNeed: "none",
    expectedBest: "reviewer-only-single",
  },
  {
    id: "broad-governance-audit-two-surfaces",
    title: "Authored governance audit under review across doctrine and runtime/hook surfaces",
    artifactUnderReview: true,
    evidenceExpansion: "broad",
    consequentialClosure: true,
    workSurfaceCount: 2,
    judgmentAxisCount: 2,
    readVolume: "broad-multi-surface",
    crossCheckNeed: "mirrored-same-surface",
    expectedBest: "mirrored-per-surface",
  },
  {
    id: "broad-governance-audit-three-surfaces",
    title: "Authored governance audit under review across doctrine, workflow, and hook/runtime surfaces",
    artifactUnderReview: true,
    evidenceExpansion: "broad",
    consequentialClosure: true,
    workSurfaceCount: 3,
    judgmentAxisCount: 3,
    readVolume: "broad-multi-surface",
    crossCheckNeed: "mirrored-same-surface",
    expectedBest: "mirrored-per-surface",
  },
  {
    id: "fresh-evidence-sweep-three-surfaces",
    title: "No authored artifact, only broad evidence inventory across three independent governance surfaces",
    artifactUnderReview: false,
    evidenceExpansion: "broad",
    consequentialClosure: false,
    workSurfaceCount: 3,
    judgmentAxisCount: 1,
    readVolume: "broad-multi-surface",
    crossCheckNeed: "none",
    expectedBest: "research-only-sharded",
  },
  {
    id: "patch-rationale-review-one-surface",
    title: "Authored patch rationale review with one broad supporting evidence surface",
    artifactUnderReview: true,
    evidenceExpansion: "bounded",
    consequentialClosure: true,
    workSurfaceCount: 1,
    judgmentAxisCount: 2,
    readVolume: "broad-single-surface",
    crossCheckNeed: "lane-separated",
    expectedBest: "flattened-1-plus-1",
  },
  {
    id: "runtime-friction-report-two-surfaces",
    title: "Existing friction report recheck with runtime logs and governance text as distinct surfaces",
    artifactUnderReview: true,
    evidenceExpansion: "broad",
    consequentialClosure: true,
    workSurfaceCount: 2,
    judgmentAxisCount: 3,
    readVolume: "broad-multi-surface",
    crossCheckNeed: "mirrored-same-surface",
    expectedBest: "mirrored-per-surface",
  },
];

const strategies = [
  {
    id: "reviewer-only-single",
    title: "One reviewer only",
    plan(s) {
      return {
        researcherCount: 0,
        reviewerCount: 1,
        crossCheckMode: "none",
        shardBasis: "none",
      };
    },
  },
  {
    id: "flattened-1-plus-1",
    title: "One broad researcher plus one broad reviewer",
    plan(s) {
      return {
        researcherCount: s.evidenceExpansion === "none" ? 0 : 1,
        reviewerCount: s.artifactUnderReview || s.consequentialClosure ? 1 : 0,
        crossCheckMode: s.evidenceExpansion === "none" ? "none" : "lane-separated",
        shardBasis: "none",
      };
    },
  },
  {
    id: "research-only-sharded",
    title: "Research-only sharded by independent surface",
    plan(s) {
      return {
        researcherCount: s.evidenceExpansion === "none" ? 0 : s.workSurfaceCount,
        reviewerCount: 0,
        crossCheckMode: "none",
        shardBasis: s.workSurfaceCount > 1 ? "by-surface" : "none",
      };
    },
  },
  {
    id: "undersharded-mixed",
    title: "Research sharded, review left global",
    plan(s) {
      return {
        researcherCount: s.evidenceExpansion === "none" ? 0 : Math.max(1, s.workSurfaceCount),
        reviewerCount: s.artifactUnderReview || s.consequentialClosure ? 1 : 0,
        crossCheckMode: "lane-separated",
        shardBasis: s.workSurfaceCount > 1 ? "by-surface" : "none",
      };
    },
  },
  {
    id: "mirrored-per-surface",
    title: "Mirror researcher and reviewer on each declared broad surface",
    plan(s) {
      const shardCount = Math.max(1, s.workSurfaceCount);
      return {
        researcherCount: s.evidenceExpansion === "none" ? 0 : shardCount,
        reviewerCount: s.artifactUnderReview || s.consequentialClosure ? shardCount : 0,
        crossCheckMode: s.crossCheckNeed === "none" ? "lane-separated" : "mirrored-same-surface",
        shardBasis: shardCount > 1 ? "mirrored-surface-pairs" : "none",
      };
    },
  },
  {
    id: "overfanout-mirrored-plus-extra",
    title: "Mirror by surface, then add one extra shard per lane",
    plan(s) {
      const shardCount = Math.max(1, s.workSurfaceCount + 1);
      return {
        researcherCount: s.evidenceExpansion === "none" ? 0 : shardCount,
        reviewerCount: s.artifactUnderReview || s.consequentialClosure ? shardCount : 0,
        crossCheckMode: s.crossCheckNeed === "none" ? "lane-separated" : "mirrored-same-surface",
        shardBasis: shardCount > 1 ? "mirrored-surface-pairs" : "none",
      };
    },
  },
];

function requiredResearcherCount(s) {
  if (s.evidenceExpansion === "none") return 0;
  if (s.readVolume === "broad-multi-surface") return s.workSurfaceCount;
  return 1;
}

function requiredReviewerCount(s) {
  const reviewNeeded = s.artifactUnderReview || s.consequentialClosure;
  if (!reviewNeeded) return 0;
  if (s.crossCheckNeed === "mirrored-same-surface") return s.workSurfaceCount;
  return 1;
}

function simulate(scenario, strategy) {
  const plan = strategy.plan(scenario);
  let score = 100;
  const reasons = [];

  const minResearcher = requiredResearcherCount(scenario);
  const minReviewer = requiredReviewerCount(scenario);

  if (plan.researcherCount < minResearcher) {
    reasons.push("research-understaffed");
    score -= 18 * (minResearcher - plan.researcherCount);
  }

  if (plan.reviewerCount < minReviewer) {
    reasons.push("review-understaffed");
    score -= 22 * (minReviewer - plan.reviewerCount);
  }

  if (scenario.crossCheckNeed === "mirrored-same-surface" && plan.crossCheckMode !== "mirrored-same-surface") {
    reasons.push("same-surface-cross-check-missing");
    score -= 28;
  }

  if (scenario.readVolume === "broad-multi-surface" && scenario.evidenceExpansion !== "none" && plan.researcherCount === 1 && scenario.workSurfaceCount >= 3) {
    reasons.push("broad-research-bottleneck");
    score -= 20;
  }

  if ((scenario.artifactUnderReview || scenario.consequentialClosure) && plan.reviewerCount === 1 && scenario.judgmentAxisCount >= 3) {
    reasons.push("review-judgment-bottleneck");
    score -= 16;
  }

  if (scenario.evidenceExpansion === "none" && plan.researcherCount > 0) {
    reasons.push("unneeded-research-overhead");
    score -= 12;
  }

  if (!scenario.artifactUnderReview && !scenario.consequentialClosure && plan.reviewerCount > 0) {
    reasons.push("unneeded-review-overhead");
    score -= 12;
  }

  if (plan.researcherCount > minResearcher + 1) {
    reasons.push("research-overfanout");
    score -= 6 * (plan.researcherCount - (minResearcher + 1));
  }

  if (plan.reviewerCount > minReviewer + 1) {
    reasons.push("review-overfanout");
    score -= 6 * (plan.reviewerCount - (minReviewer + 1));
  }

  let outcome = "pass";
  if (reasons.includes("research-understaffed") || reasons.includes("review-understaffed") || reasons.includes("same-surface-cross-check-missing")) {
    outcome = "fail";
  } else if (score < 85) {
    outcome = "weak-pass";
  }

  return {
    ...plan,
    totalWorkers: plan.researcherCount + plan.reviewerCount,
    score,
    outcome,
    reasons,
  };
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

for (const scenario of scenarios) {
  const ranked = rows
    .filter((row) => row.scenario === scenario.id)
    .slice()
    .sort((a, b) => b.score - a.score);
  const best = ranked[0];
  console.log(`\n=== ${scenario.id} ===`);
  console.log(`best=${best.strategy} workers=${best.totalWorkers} score=${best.score} outcome=${best.outcome}`);
  assert(
    best.strategy === scenario.expectedBest,
    `${scenario.id} best staffing strategy`,
    JSON.stringify(ranked, null, 2)
  );
}

const twoSurfaceAudit = rows.find(
  (row) => row.scenario === "broad-governance-audit-two-surfaces" && row.strategy === "mirrored-per-surface"
);
assert(
  twoSurfaceAudit &&
    twoSurfaceAudit.researcherCount === 2 &&
    twoSurfaceAudit.reviewerCount === 2 &&
    twoSurfaceAudit.crossCheckMode === "mirrored-same-surface",
  "two-surface authored audit uses mirrored 2x2 challenge",
  JSON.stringify(twoSurfaceAudit, null, 2)
);

const threeSurfaceSweep = rows.find(
  (row) => row.scenario === "fresh-evidence-sweep-three-surfaces" && row.strategy === "research-only-sharded"
);
assert(
  threeSurfaceSweep &&
    threeSurfaceSweep.researcherCount === 3 &&
    threeSurfaceSweep.reviewerCount === 0,
  "fresh broad evidence sweep stays researcher-only but shards by surface",
  JSON.stringify(threeSurfaceSweep, null, 2)
);

const asymmetricFailure = rows.find(
  (row) => row.scenario === "broad-governance-audit-three-surfaces" && row.strategy === "flattened-1-plus-1"
);
assert(
  asymmetricFailure && asymmetricFailure.outcome === "fail",
  "flattened 1+1 fails broad three-surface authored audit",
  JSON.stringify(asymmetricFailure, null, 2)
);

const boundedReview = rows.find(
  (row) => row.scenario === "bounded-single-artifact-review" && row.strategy === "reviewer-only-single"
);
assert(
  boundedReview && boundedReview.outcome === "pass",
  "bounded artifact review keeps one reviewer",
  JSON.stringify(boundedReview, null, 2)
);

const mirroredRows = rows.filter((row) => row.strategy === "mirrored-per-surface");
const mirroredAverage = mirroredRows.reduce((sum, row) => sum + row.score, 0) / mirroredRows.length;
console.log(`\nmirrored-per-surface avg=${mirroredAverage.toFixed(1)}`);

const flattenedRows = rows.filter((row) => row.strategy === "flattened-1-plus-1");
const flattenedAverage = flattenedRows.reduce((sum, row) => sum + row.score, 0) / flattenedRows.length;
console.log(`flattened-1-plus-1 avg=${flattenedAverage.toFixed(1)}`);

if (process.exitCode) {
  console.log("\nASSERTIONS_FAILED");
  process.exit(process.exitCode);
}

const assertionCount = scenarios.length + 4;
console.log(`\nASSERTIONS_PASSED ${assertionCount}`);
NODE
