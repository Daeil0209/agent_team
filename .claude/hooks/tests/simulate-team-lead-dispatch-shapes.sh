#!/usr/bin/env bash
set -euo pipefail

node <<'NODE'
"use strict";

const scenarios = [
  {
    id: "authored-audit-review-with-evidence-check",
    title: "Existing governance audit report under review plus bounded repo evidence check",
    existingArtifactUnderReview: true,
    evidenceExpansion: "broad",
    consequentialJudgment: true,
    independentReadPossible: true,
    implementationNeeded: false,
    testerNeeded: false,
    validatorNeeded: false,
    expected: {
      routingSignal: "team-routing candidate",
      nextAction: "TeamCreate",
      agentMap: ["researcher", "reviewer"],
      parallelGroups: "parallel",
    },
  },
  {
    id: "fresh-governance-evidence-sweep",
    title: "No authored artifact review, just broad contradiction mapping and evidence inventory",
    existingArtifactUnderReview: false,
    evidenceExpansion: "broad",
    consequentialJudgment: false,
    independentReadPossible: true,
    implementationNeeded: false,
    testerNeeded: false,
    validatorNeeded: false,
    expected: {
      routingSignal: "team-routing candidate",
      nextAction: "TeamCreate",
      agentMap: ["researcher"],
      parallelGroups: "parallel",
    },
  },
  {
    id: "bounded-single-artifact-review",
    title: "One identified artifact review with no meaningful extra evidence expansion",
    existingArtifactUnderReview: true,
    evidenceExpansion: "none",
    consequentialJudgment: true,
    independentReadPossible: false,
    implementationNeeded: false,
    testerNeeded: false,
    validatorNeeded: false,
    expected: {
      routingSignal: "team-routing candidate",
      nextAction: "TeamCreate",
      agentMap: ["reviewer"],
      parallelGroups: "none",
    },
  },
  {
    id: "runtime-friction-postmortem-and-priority-close",
    title: "Observed friction report re-check plus patch priority closure",
    existingArtifactUnderReview: true,
    evidenceExpansion: "broad",
    consequentialJudgment: true,
    independentReadPossible: true,
    implementationNeeded: false,
    testerNeeded: false,
    validatorNeeded: false,
    expected: {
      routingSignal: "team-routing candidate",
      nextAction: "TeamCreate",
      agentMap: ["researcher", "reviewer"],
      parallelGroups: "parallel",
    },
  },
  {
    id: "design-proposal-review-plus-fact-check",
    title: "Design proposal review with surrounding codebase fact check",
    existingArtifactUnderReview: true,
    evidenceExpansion: "bounded",
    consequentialJudgment: true,
    independentReadPossible: true,
    implementationNeeded: false,
    testerNeeded: false,
    validatorNeeded: false,
    expected: {
      routingSignal: "team-routing candidate",
      nextAction: "TeamCreate",
      agentMap: ["researcher", "reviewer"],
      parallelGroups: "parallel",
    },
  },
  {
    id: "patch-rationale-review",
    title: "Patch rationale review with evidence cross-check but no final patch priority closure",
    existingArtifactUnderReview: true,
    evidenceExpansion: "bounded",
    consequentialJudgment: false,
    independentReadPossible: true,
    implementationNeeded: false,
    testerNeeded: false,
    validatorNeeded: false,
    expected: {
      routingSignal: "team-routing candidate",
      nextAction: "TeamCreate",
      agentMap: ["researcher", "reviewer"],
      parallelGroups: "parallel",
    },
  },
  {
    id: "implementation-plus-review-plus-proof-validation",
    title: "Observed defect already known, needs implementation, review, proof, and explicit acceptance ownership",
    existingArtifactUnderReview: false,
    evidenceExpansion: "none",
    consequentialJudgment: true,
    independentReadPossible: false,
    implementationNeeded: true,
    testerNeeded: true,
    validatorNeeded: true,
    expected: {
      routingSignal: "team-routing candidate",
      nextAction: "TeamCreate",
      agentMap: ["developer", "reviewer", "tester", "validator"],
      parallelGroups: "mixed",
    },
  },
];

function deriveDispatchShape(s) {
  const agentSet = new Set();
  let routingSignal = "lead-local candidate";
  let nextAction = "lead-local-none";
  let parallelGroups = "none";
  let serialReason = "none";

  const hasArtifactReview = s.existingArtifactUnderReview;
  const needsResearch = s.evidenceExpansion !== "none";
  const needsReviewer = hasArtifactReview || s.consequentialJudgment;

  if (needsResearch) agentSet.add("researcher");
  if (needsReviewer) agentSet.add("reviewer");
  if (s.implementationNeeded) agentSet.add("developer");
  if (s.testerNeeded) agentSet.add("tester");
  if (s.validatorNeeded) agentSet.add("validator");

  if (agentSet.size > 0) {
    routingSignal = "team-routing candidate";
    nextAction = "TeamCreate";
  }

  if (agentSet.has("developer") || agentSet.has("tester") || agentSet.has("validator")) {
    parallelGroups = "mixed";
    serialReason = "implementation/review/proof pipeline has at least one downstream dependency";
  } else if (agentSet.has("researcher") && agentSet.has("reviewer")) {
    if (s.independentReadPossible) {
      parallelGroups = "parallel";
      serialReason = "none";
    } else {
      parallelGroups = "none";
      serialReason = "review depends on prior evidence expansion";
    }
  } else if (agentSet.has("researcher") && s.evidenceExpansion === "broad") {
    parallelGroups = "parallel";
    serialReason = "none";
  } else {
    parallelGroups = "none";
    serialReason = "single-lane bounded work";
  }

  return {
    routingSignal,
    nextAction,
    agentMap: Array.from(agentSet).sort(),
    parallelGroups,
    serialReason,
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

for (const scenario of scenarios) {
  const actual = deriveDispatchShape(scenario);
  console.log(`\n=== ${scenario.id} ===`);
  console.log(JSON.stringify(actual));
  assert(actual.routingSignal === scenario.expected.routingSignal, `${scenario.id} routing signal`, JSON.stringify({ expected: scenario.expected, actual }, null, 2));
  assert(actual.nextAction === scenario.expected.nextAction, `${scenario.id} next consequential action`, JSON.stringify({ expected: scenario.expected, actual }, null, 2));
  assert(JSON.stringify(actual.agentMap) === JSON.stringify(scenario.expected.agentMap.slice().sort()), `${scenario.id} agent map`, JSON.stringify({ expected: scenario.expected, actual }, null, 2));
  assert(actual.parallelGroups === scenario.expected.parallelGroups, `${scenario.id} parallel groups`, JSON.stringify({ expected: scenario.expected, actual }, null, 2));
}

const authoredAudit = deriveDispatchShape(scenarios.find((s) => s.id === "authored-audit-review-with-evidence-check"));
assert(
  authoredAudit.agentMap.includes("researcher") && authoredAudit.agentMap.includes("reviewer"),
  "authored audit review keeps researcher+reviewer"
);

const freshSweep = deriveDispatchShape(scenarios.find((s) => s.id === "fresh-governance-evidence-sweep"));
assert(
  JSON.stringify(freshSweep.agentMap) === JSON.stringify(["researcher"]),
  "fresh evidence sweep stays researcher-only"
);

const boundedReview = deriveDispatchShape(scenarios.find((s) => s.id === "bounded-single-artifact-review"));
assert(
  JSON.stringify(boundedReview.agentMap) === JSON.stringify(["reviewer"]),
  "bounded artifact review stays reviewer-only"
);

const implementationPipeline = deriveDispatchShape(scenarios.find((s) => s.id === "implementation-plus-review-plus-proof-validation"));
assert(
  implementationPipeline.parallelGroups === "mixed",
  "implementation plus review plus proof validation records mixed parallel/serial shape"
);

if (process.exitCode) {
  console.log("\nASSERTIONS_FAILED");
  process.exit(process.exitCode);
}

console.log("\nASSERTIONS_PASSED 32");
NODE
