# Changelog

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
