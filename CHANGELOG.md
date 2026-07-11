# Changelog

## 1.3.0 — 2026-07

- `food-research`: new **`journal_ranker`** subagent that prioritizes sources by
  journal ranking (Q1/Q2 food-science & nutrition, Nature/Science/Cell families,
  and Q1/Q2 in any other discipline = highest; Q3 second; Q4 avoided), backed by
  `references/journal-priority.csv` (JCR quartiles for Food Science & Technology
  and Nutrition & Dietetics). Applied to the quick brief, full review, and deep
  research streams — **not** to systematic review (eligibility-based inclusion).
- Clarified `food-research` into four named streams (quick brief / full review /
  deep research / systematic) with when-to-use guidance and a workflow flowchart.
- Added workflow flowcharts to `food-research` and the `systematic_reviewer`
  subagent.

## 1.2.0 — 2026-07

- New **`deep-research`** skill: general iterative deep-research engine (scope →
  plan → investigate → verify → synthesize → critique → report) with a 6-subagent
  team (`question_scoper`, `research_planner`, `investigator`, `verifier`,
  `synthesizer`, `critic`). Runs standalone or as `food-research`'s deep-dive engine.
- `food-research` gains a **PRISMA 2020 systematic-review** capability: new
  `systematic_reviewer` (protocol → search → PRISMA flow → extraction →
  risk-of-bias → synthesis ± meta-analysis) and `data_extractor` (parallel,
  batched structured extraction) subagents; `systematic` mode now routes to them.

## 1.1.0 — 2026-07

- `food-research` expanded to a comprehensive, multi-source workflow: four-layer
  search (structured → backward chaining → forward chaining → semantic),
  two-phase screening with a food-science quality rubric, and cross-source
  synthesis with an evidence matrix, evidence grading, coverage advisory, and gap
  analysis. MCP-tool-aware (PubMed, Consensus, bioRxiv, CrossRef, …) with web
  fallback.
- Added four `food-research` subagents: `search_strategist`, `source_scout`,
  `screener_appraiser`, `synthesis`.

## 1.0.0 — 2026-07

First open-source release. Original, MIT-licensed work.

### Skills
- Core workflow: `food-research`, `food-paper` (journal-aware), `food-review`,
  `food-pipeline`.
- `journal-selector` + 16 publisher-tiered journal author-guideline skills under
  `journals/` covering 60 food & nutrition journals
  (see `journals/_coverage.md`).
- `food-figure`: food-science figure workflow (Python or R; journal-ready
  SVG/PDF/TIFF).

### Notes
- Every skill's body and description is in English.
- Journal skills capture each journal's reference/citation style; `food-paper`
  re-flows references to the target journal's style.
- Coverage of all 60 journals verified by `scripts/check_journal_coverage.py`.
