# Paper Structure Patterns (food & nutrition)

Used by `structure_architect`. Adapt to the target journal's required structure
(from `journal-selector`); this is the default when the journal is generic.

## Original research (IMRaD)
Title · Abstract · Keywords · Introduction · Materials and Methods · Results ·
Discussion · (Conclusion) · Declarations · References · Figure/table legends.
- Some food journals combine **Results and Discussion**; check the journal.
- Elsevier food journals often want **Highlights** + a **graphical abstract**.

## Abstract types
- **Unstructured** (most food journals): one paragraph — aim, what was done, the
  key quantitative result, the conclusion; ≤200–250 words.
- **Structured** (e.g. British Food Journal): Purpose / Design-Methodology-Approach
  / Findings / Originality-Value.
- **Nutrition/clinical**: Background / Methods / Results / Conclusions.
- Keep abstracts unreferenced unless the style allows citations.

## Review article
Title · Abstract · Introduction (scope + why now) · thematic sections with
descriptive headings · (Summary points / Future directions) · Conclusion ·
References. Not IMRaD.

## Systematic review
Follows PRISMA (handled by `sr_synthesis`): Introduction with the questions ·
Methods (protocol, databases, screening, risk of bias) · Results (PRISMA flow,
study characteristics, risk of bias, per-question findings) · Discussion ·
Limitations · Conclusion.

## Short communication
Compressed IMRaD, tight word/display limits — one clear result.

## Evidence map per Results subsection
Each Results subsection = one research question × the figure/table that shows it ×
the statistic that supports it. Order Results to build the Discussion's argument.
