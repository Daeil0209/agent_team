#!/usr/bin/env bash
set -euo pipefail

node <<'NODE'
"use strict";

const scenarios = [
  {
    id: "authored-audit-report-review",
    title: "User provides an already-written governance audit report and asks for a review of its claims",
    existingArtifact: true,
    explicitReviewRequest: true,
    specifiedReviewPoints: true,
    evidenceExpansionNeeded: true,
    finalJudgmentNeeded: true,
    independentReadPossible: true,
    expectedBest: "research-plus-review-parallel",
  },
  {
    id: "fresh-governance-evidence-sweep",
    title: "User asks for a broad governance sweep whose output is evidence inventory only",
    existingArtifact: false,
    explicitReviewRequest: false,
    specifiedReviewPoints: false,
    evidenceExpansionNeeded: true,
    finalJudgmentNeeded: false,
    independentReadPossible: false,
    expectedBest: "research-only",
  },
  {
    id: "bounded-single-artifact-review",
    title: "User asks for a bounded review of one already-identified artifact with no extra repo-wide evidence sweep",
    existingArtifact: true,
    explicitReviewRequest: true,
    specifiedReviewPoints: true,
    evidenceExpansionNeeded: false,
    finalJudgmentNeeded: true,
    independentReadPossible: false,
    expectedBest: "reviewer-only",
  },
  {
    id: "runtime-friction-report-recheck",
    title: "User provides an existing friction report and asks for re-check plus corrective priority judgment",
    existingArtifact: true,
    explicitReviewRequest: true,
    specifiedReviewPoints: true,
    evidenceExpansionNeeded: true,
    finalJudgmentNeeded: true,
    independentReadPossible: true,
    expectedBest: "research-plus-review-parallel",
  },
  {
    id: "report-clarification-pass",
    title: "User asks whether a drafted report's stated concerns are grounded, without asking for new patch priority",
    existingArtifact: true,
    explicitReviewRequest: true,
    specifiedReviewPoints: true,
    evidenceExpansionNeeded: true,
    finalJudgmentNeeded: false,
    independentReadPossible: true,
    expectedBest: "research-plus-review-parallel",
  },
  {
    id: "design-proposal-review-with-fact-check",
    title: "User provides a design proposal and asks for critique plus bounded evidence check against surrounding surfaces",
    existingArtifact: true,
    explicitReviewRequest: true,
    specifiedReviewPoints: true,
    evidenceExpansionNeeded: true,
    finalJudgmentNeeded: true,
    independentReadPossible: true,
    expectedBest: "research-plus-review-parallel",
  },
  {
    id: "patch-rationale-review",
    title: "User points to an authored patch rationale and asks whether the justification is sound and sufficiently evidenced",
    existingArtifact: true,
    explicitReviewRequest: true,
    specifiedReviewPoints: true,
    evidenceExpansionNeeded: true,
    finalJudgmentNeeded: false,
    independentReadPossible: true,
    expectedBest: "research-plus-review-parallel",
  },
];

const strategies = [
  {
    id: "research-only",
    title: "Q2 freezes the turn as research-analysis only",
    researcher: true,
    reviewer: false,
    parallel: false,
  },
  {
    id: "reviewer-only",
    title: "Q2 freezes the turn as review only",
    researcher: false,
    reviewer: true,
    parallel: false,
  },
  {
    id: "research-then-review-sequential",
    title: "Q2 recognizes both lanes but serializes them by habit",
    researcher: true,
    reviewer: true,
    parallel: false,
  },
  {
    id: "research-plus-review-parallel",
    title: "Q2/Q4 recognize report-review intent and route researcher + reviewer as independent parallel lanes",
    researcher: true,
    reviewer: true,
    parallel: true,
  },
];

function simulate(scenario, strategy) {
  let score = 100;
  const reasons = [];
  const events = [];

  if (scenario.evidenceExpansionNeeded) {
    if (!strategy.researcher) {
      reasons.push("missing-researcher-coverage");
      score -= 40;
    } else {
      events.push("researcher-evidence-check");
    }
  } else if (strategy.researcher) {
    reasons.push("unneeded-research-overhead");
    score -= 8;
  }

  if (scenario.explicitReviewRequest || scenario.finalJudgmentNeeded || scenario.existingArtifact) {
    if (!strategy.reviewer) {
      reasons.push("missing-reviewer-challenge");
      score -= 55;
    } else {
      events.push("reviewer-independent-judgment");
    }
  }

  if (strategy.researcher && strategy.reviewer) {
    if (scenario.independentReadPossible) {
      if (strategy.parallel) {
        events.push("parallel-independent-read");
      } else {
        reasons.push("avoidable-serial-bottleneck");
        score -= 14;
      }
    } else if (strategy.parallel) {
      reasons.push("parallel-overhead-on-tight-surface");
      score -= 10;
    }
  }

  if (scenario.explicitReviewRequest && !scenario.evidenceExpansionNeeded && strategy.researcher && strategy.reviewer && !strategy.parallel) {
    reasons.push("overstaffed-bounded-review");
    score -= 6;
  }

  let outcome = "pass";
  if (reasons.includes("missing-reviewer-challenge") || reasons.includes("missing-researcher-coverage")) {
    outcome = "fail";
  } else if (score < 85) {
    outcome = "weak-pass";
  }

  return { outcome, score, reasons, events };
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
  console.log(`best=${best.strategy} score=${best.score} outcome=${best.outcome}`);
  assert(
    best.strategy === scenario.expectedBest,
    `${scenario.id} best strategy`,
    `expected ${scenario.expectedBest}, got ${best.strategy}`
  );
}

const researchOnlyFailures = rows
  .filter((row) => row.strategy === "research-only" && row.outcome === "fail")
  .map((row) => row.scenario);
assert(
  researchOnlyFailures.includes("authored-audit-report-review"),
  "research-only fails authored report review",
  `research-only failures=${researchOnlyFailures.join(",")}`
);

const parallelRows = rows.filter((row) => row.strategy === "research-plus-review-parallel");
assert(
  parallelRows.find((row) => row.scenario === "authored-audit-report-review")?.outcome === "pass",
  "parallel strategy passes authored report review"
);
assert(
  parallelRows.find((row) => row.scenario === "runtime-friction-report-recheck")?.outcome === "pass",
  "parallel strategy passes runtime-friction report recheck"
);
assert(
  parallelRows.find((row) => row.scenario === "design-proposal-review-with-fact-check")?.outcome === "pass",
  "parallel strategy passes design proposal review with fact check"
);
assert(
  parallelRows.find((row) => row.scenario === "patch-rationale-review")?.outcome === "pass",
  "parallel strategy passes patch rationale review"
);

const reviewerOnlyRow = rows.find(
  (row) => row.strategy === "reviewer-only" && row.scenario === "fresh-governance-evidence-sweep"
);
assert(
  reviewerOnlyRow?.outcome === "fail",
  "reviewer-only fails fresh evidence sweep",
  JSON.stringify(reviewerOnlyRow, null, 2)
);

const sequentialRow = rows.find(
  (row) => row.strategy === "research-then-review-sequential" && row.scenario === "authored-audit-report-review"
);
assert(
  sequentialRow?.score < parallelRows.find((row) => row.scenario === "authored-audit-report-review")?.score,
  "parallel beats sequential when independent read is available",
  JSON.stringify({ sequentialRow, parallelRow: parallelRows.find((row) => row.scenario === "authored-audit-report-review") }, null, 2)
);

console.log("\n=== strategy-summary ===");
const summary = strategies
  .map((strategy) => {
    const samples = rows.filter((row) => row.strategy === strategy.id);
    const avg = samples.reduce((sum, row) => sum + row.score, 0) / samples.length;
    const fails = samples.filter((row) => row.outcome === "fail").length;
    const weak = samples.filter((row) => row.outcome === "weak-pass").length;
    return `${strategy.id} avg=${avg.toFixed(1)} fails=${fails} weak=${weak}`;
  });
for (const line of summary) {
  console.log(line);
}

if (process.exitCode) {
  console.log("\nASSERTIONS_FAILED");
  process.exit(process.exitCode);
}

console.log("\nASSERTIONS_PASSED 9");
NODE
