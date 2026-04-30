---
PRIMARY-OWNER: developer
LOAD-POLICY: on-demand reference only
---

# benchmark-simulation: Research-Agent Search Strategy Extension
Use this section when `benchmark-simulation` is consumed by researcher for external evidence acquisition, capability hardening, methodology selection, or comparative research. This section strengthens search method and evidence evaluation only; it does not transfer benchmark ownership, routing authority, proof authority, or final acceptance to researcher.

## Search Mode
- `lookup`: direct fact or source retrieval; stop when an authoritative source answers the question and contradiction risk is low.
- `learn`: concept, method, or domain mapping; use exploratory search, term harvesting, and triangulation.
- `investigate`: contradiction, unclear decision target, or multi-source evidence path; use a query ledger, source-family targets, and explicit stopping rule.
- `benchmark-shaped`: comparative or capability-hardening research; combine search strategy with benchmark fields, fair baseline awareness, and evidence coverage checks.

## Search Loop
1. Frame concept blocks, source families, and first queries from the decision target.
2. Rank source patches by information scent: title or abstract, author or venue, official or standard status, DOI or publisher, recency, citation context, and fit to the decision target.
3. Berry-pick from every high-value source: harvest terms, entities, citations, anti-patterns, subquestions, and rejected branches into the query ledger.
4. Reformulate with explicit operators: `broaden`, `narrow`, `synonym/paraphrase`, `entity-shift`, `source-type-shift`, `time-shift`, `anti-pattern-search`, and `citation-snowball`.
5. Snowball backward and forward from strong seed sources when citation networks materially affect confidence.
6. Triangulate across independent source families and downgrade single-family evidence on consequential claims.
7. Stop only by explicit rule: branch saturation, citation fixed point, enough convergent evidence for the decision threshold, cost-exceeds-value with downgrade, or `HOLD` with residual miss-risk.

## Benchmark Evaluation For Research Agents
- Benchmark core = corpus or source snapshot + information needs or query set + relevance/evidence judgments + scoring rule.
- Keep development and test sets separated; do not tune prompts, search operators, or source filters on the test set.
- Score answer correctness separately from evidence coverage.
- Use claim-level support checks for consequential claims: `supported`, `refuted`, `not-enough-info`, or `unsupported`.
- Match metrics to purpose: Precision, Recall, P@k, Recall@k, nDCG@k, MAP, R-precision, evidence coverage, citation faithfulness, and search cost.
- Include baseline and ablation where possible.
- Report variance or repeat-run uncertainty for stochastic agent runs instead of treating a single run as durable capability proof.

## External Grounding References For Search Capability
- Bates, "The Design of Browsing and Berrypicking Techniques for the Online Search Interface": https://pages.gseis.ucla.edu/faculty/bates/berrypicking.html
- Pirolli and Card, "Information Foraging": https://doi.org/10.1037/0033-295X.106.4.643
- Marchionini, "Exploratory Search": https://doi.org/10.1145/1121949.1121979
- Wohlin, "Guidelines for Snowballing in Systematic Literature Studies": https://www.wohlin.eu/ease14.pdf
- Stanford IR Book, "Information retrieval system evaluation": https://nlp.stanford.edu/IR-book/html/htmledition/information-retrieval-system-evaluation-1.html
- Stanford IR Book, "Evaluation of ranked retrieval results": https://nlp.stanford.edu/IR-book/html/htmledition/evaluation-of-ranked-retrieval-results-1.html
- CDC ACIP GRADE Handbook, evidence certainty criteria: https://www.cdc.gov/acip-grade-handbook/hcp/chapter-7-grade-criteria-determining-certainty-of-evidence/index.html
- BEIR benchmark: https://arxiv.org/abs/2104.08663
- KILT benchmark: https://aclanthology.org/2021.naacl-main.200/
- FEVER fact verification dataset: https://aclanthology.org/N18-1074/
- FACTSCORE: https://arxiv.org/abs/2305.14251
- ARES: https://arxiv.org/abs/2311.09476
- RAGAS: https://aclanthology.org/2024.eacl-demo.16/
- RAGChecker: https://arxiv.org/abs/2408.08067
- GAIA benchmark: https://arxiv.org/abs/2311.12983
- BrowseComp: https://openai.com/index/browsecomp/
