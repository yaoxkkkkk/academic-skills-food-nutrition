# Source Quality Hierarchy (evidence grading)

Used by `screener_appraiser`, `source_verifier`, and `synthesis` to weigh
evidence. Two axes: **study design** (internal validity) and **venue quality**
(journal ranking, handled by `journal_ranker`). Weigh by both; a strong design in
a weak venue can still outrank a weak design in a strong venue.

## Design hierarchy — health / nutrition claims (strongest → weakest)
1. Systematic review / meta-analysis of RCTs
2. Randomized controlled trial (RCT)
3. Prospective cohort
4. Case–control
5. Cross-sectional
6. Case series / case report
7. Mechanistic in vitro / animal (supportive, not causal for human outcomes)
8. Expert opinion / narrative review

## Design hierarchy — compositional / process / food-technology claims
- **Highest confidence:** standardized measurement (AOAC/ISO), validated methods (LOD/LOQ, recovery, appropriate standards), adequate **biological** replication, appropriate statistics, multi-batch.
- **Lower confidence:** unvalidated methods, single batch, analytical (pseudo-)replication counted as n, identification by library match only.

## Regulatory / grey literature
Authoritative for regulatory and compositional facts (EFSA/FDA/USDA/Codex) — label
as regulatory, not peer-reviewed research; do not treat industry white papers as
independent evidence.

## Grading a body of evidence
State confidence per conclusion from: quantity, **consistency**, quality/risk of
bias, and directness. Prefer GRADE-style wording (high / moderate / low / very
low) for systematic reviews. Always disclose coverage bias (see the coverage
advisory in `synthesis`).
