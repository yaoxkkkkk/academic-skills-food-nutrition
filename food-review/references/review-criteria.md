# Review Criteria Framework (food & nutrition)

What each reviewer looks for. Pair with `quality-rubrics.md` (scores) and
`editorial-decisions.md` (verdict).

## Methodology & statistics (`reviewer_methodology`)
Design fits the question; controls/randomization/blinding where relevant; n is
**biological** and adequate; methods reproducible (source, prep, storage,
instrument settings); validation (LOD/LOQ, recovery, standards; MS/MS not library-
only); correct statistics with assumptions checked; figures/tables match the
stats. See `statistics-reporting.md` (in `food-paper/references/`).

## Domain, novelty & significance (`reviewer_domain`)
Is the advance real and clearly stated; significant to the field/food system/
health; in scope for the target journal; domain concepts/mechanisms/terminology
correct; prior work fairly and currently represented; claims proportionate to the
evidence (no over-generalization beyond matrix/dose/population).

## Integrity, ethics & reporting (`reviewer_integrity`)
Data/citation integrity; human/animal ethics + consent; allergen/food-safety
responsibility; required declarations and the correct reporting guideline
(CONSORT/STROBE/PRISMA). Full checklist: `ethics-integrity-checklist.md`.

## Devil's advocate (`devils_advocate`)
The strongest case that the central claim is wrong or unsupported: alternative
explanations, confounders, artifacts, selective reporting, the missing decisive
experiment. See `food-deep-research/references/reasoning-and-fallacies.md`.

## Formatting (`format_checker`)
Structure, limits, and reference style vs the target journal (APA 7.0 default);
figures at journal spec; no mixed citation styles.

## Writing quality — machine-generated tells (`format_checker`, `reviewer_domain`)
Flag prose that reads as chatbot-generated, because these are substantive faults,
not taste (`food-paper/references/human-writing.md`):
- **Inflated significance** ("pivotal role", "paves the way", "growing attention") —
  overstates contribution; often masks a weak novelty claim → `reviewer_domain`.
- **Vague attribution** ("studies have shown", "it is widely recognised") — an
  uncited claim; a citation-integrity issue → `reviewer_integrity`.
- **Stock AI vocabulary** (figurative "landscape", "delve", "intricate", "testament",
  "showcase"), "serves as" for "is", promotional adjectives, "-ing" tack-ons, filler,
  hedge stacking, generic upbeat endings, formulaic "Challenges and Future Prospects".

Report as writing-quality concerns with the fix. **Do not** flag correct academic
register: passive voice in Methods, calibrated hedging, journal-mandated heading
case/structure, precise technical terms, or a repeated defined term are all correct.
Judge by **clusters** of tells, not isolated hits — and never allege that a
manuscript was AI-written: review the writing, not the author.

## Reviewer conduct
Critique the work, not the author. Every major concern must state **what would
resolve it**. Distinguish must-fix (blocks) from should-fix and optional.
