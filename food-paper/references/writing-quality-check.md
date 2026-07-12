# Writing Quality Check (self-review before internal review)

Run over the draft; fix before handing to `internal_reviewer`.

## Claims & evidence
- [ ] Every claim traces to a specific result or cited source; none beyond the data.
- [ ] Interpretation kept out of Results; Results state the numbers, not just "see Fig. 2".
- [ ] Limitations stated; no overreach in Discussion/Conclusion.

## Reporting completeness (food/nutrition)
- [ ] n (biological) and error type on every mean; statistical test named and appropriate.
- [ ] Methods reproducible: source/cultivar/breed/batch, prep, storage, instrument settings, LOD/LOQ, recovery.
- [ ] Units SI and consistent; composition basis stated; log CFU/g for microbes.

## Structure & style
- [ ] Sections and limits match the target journal (or APA 7.0 default).
- [ ] Abstract matches its required type (structured/unstructured) and word count.
- [ ] Every figure/table cited in order with a self-contained legend.
- [ ] Abbreviations defined once; terminology consistent; tenses correct.

## Anti-patterns to remove
- Vague quantifiers ("significantly higher" without the number/test).
- Bar-of-means where a distribution matters (fix in `food-figure`).
- Redundant restatement of Results in the Discussion.
- Undefined jargon; inconsistent naming of the same construct.
- `[NEEDS DATA]` / `[EVIDENCE GAP]` placeholders left in the text.

## Declarations present
- [ ] Competing interests, funding, CRediT, data availability, ethics/food-safety, AI-use disclosure (see `declarations-guide.md`).
