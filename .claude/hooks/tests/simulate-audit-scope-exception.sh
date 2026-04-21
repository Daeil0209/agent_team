#!/usr/bin/env bash
set -euo pipefail

node <<'NODE'
"use strict";

const scenarios = [
  {
    id: "bounded-dev",
    lane: "developer",
    files: 3,
    questions: 1,
    judgmentTypes: 1,
    phaseIntents: 1,
    categoryCount: 1,
    auditClass: false,
    expected: "allow",
  },
  {
    id: "researcher-deep-crossfile",
    lane: "researcher",
    files: 14,
    questions: 2,
    judgmentTypes: 1,
    phaseIntents: 1,
    categoryCount: 1,
    auditClass: false,
    researcherDeep: true,
    expected: "allow",
  },
  {
    id: "reviewer-balance-audit",
    lane: "reviewer",
    files: 42,
    questions: 1,
    judgmentTypes: 1,
    phaseIntents: 1,
    categoryCount: 1,
    auditClass: true,
    expected: "allow",
  },
  {
    id: "reviewer-audit-mixed-phase",
    lane: "reviewer",
    files: 42,
    questions: 1,
    judgmentTypes: 1,
    phaseIntents: 2,
    categoryCount: 2,
    auditClass: true,
    expected: "decompose",
  },
  {
    id: "reviewer-audit-too-many-questions",
    lane: "reviewer",
    files: 42,
    questions: 3,
    judgmentTypes: 1,
    phaseIntents: 1,
    categoryCount: 1,
    auditClass: true,
    expected: "decompose",
  },
  {
    id: "researcher-audit-multiple-judgments",
    lane: "researcher",
    files: 18,
    questions: 2,
    judgmentTypes: 2,
    phaseIntents: 1,
    categoryCount: 1,
    auditClass: true,
    expected: "decompose",
  },
  {
    id: "tester-proof-surface-still-split",
    lane: "tester",
    files: 18,
    questions: 1,
    judgmentTypes: 1,
    phaseIntents: 1,
    categoryCount: 1,
    auditClass: true,
    expected: "decompose",
  },
];

function evaluate(s) {
  const fileLimitHit = s.files > 5;
  const crossCategory = s.categoryCount > 1;
  const mixedIntent = s.phaseIntents > 1;
  const mixedInvestigationAndJudgment = s.judgmentTypes > 1;

  const auditException =
    fileLimitHit &&
    (s.lane === "reviewer" || s.lane === "researcher") &&
    s.auditClass &&
    s.questions <= 2 &&
    s.judgmentTypes === 1 &&
    s.phaseIntents === 1 &&
    s.categoryCount === 1;

  const researcherDeepException =
    fileLimitHit &&
    s.lane === "researcher" &&
    s.researcherDeep &&
    s.questions <= 2 &&
    s.phaseIntents === 1 &&
    s.judgmentTypes === 1;

  const allowFileScope = !fileLimitHit || auditException || researcherDeepException;

  if (!allowFileScope) {
    return "decompose";
  }
  if (mixedIntent || crossCategory || mixedInvestigationAndJudgment) {
    return "decompose";
  }
  return "allow";
}

let passes = 0;
let failures = 0;
for (const scenario of scenarios) {
  const actual = evaluate(scenario);
  const ok = actual === scenario.expected;
  if (ok) {
    passes += 1;
    console.log(`PASS ${scenario.id} -> ${actual}`);
  } else {
    failures += 1;
    console.log(`FAIL ${scenario.id} -> expected=${scenario.expected} actual=${actual}`);
  }
}

console.log(`ASSERTIONS_PASSED ${passes}`);
if (failures > 0) {
  console.log(`ASSERTIONS_FAILED ${failures}`);
  process.exit(1);
}
NODE
