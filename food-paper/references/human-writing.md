# Write Like a Scientist, Not Like a Chatbot

Canonical anti-AI-tell guide for every skill in the suite that writes prose:
`food-paper` (`draft_writer`, `polisher`), `food-research` (`writer`),
`food-deep-research` (`compiler`), and `food-review` (which flags these in others'
manuscripts). Original text; the pattern taxonomy is informed by the MIT-licensed
`humanizer` skill (Siqi Chen) and Wikipedia's "Signs of AI writing", adapted here
for scientific manuscripts — see the repo README Acknowledgements.

## What this is — and is not
**This is about writing quality, not disguise.** LLM prose has specific, learnable
tells: inflated significance, vague attribution, stock vocabulary, and hedging so
thick it says nothing. Those are *bad scientific writing* on their own terms, and
removing them makes a manuscript clearer and more honest.

**It is not a way to hide AI involvement.** The suite's **AI-use acknowledgement is
mandatory and unaffected** by anything here (`declarations-guide.md`). Do **not**
rewrite text in order to defeat an AI detector, evade a journal's or institution's
AI policy, or misrepresent who wrote what. If the user asks for that, say plainly
that the disclosure requirement stands and offer the quality edit instead.

**Never let a style edit change the science.** Rewriting must not alter any value,
unit, statistical result, direction of effect, citation, or the scope of a claim. If
a cleaner sentence would overstate what was tested, keep the longer sentence. When
in doubt, meaning wins over style (`faithfulness-and-citation.md`).

## The tells — remove these
**Inflated significance.** *underscores/highlights the importance of; plays a
pivotal/crucial/key role; paves the way for; represents a paradigm shift; in the era
of; growing body of evidence; has garnered increasing attention.*
> ✗ Encapsulation has garnered increasing attention, playing a pivotal role in the evolving landscape of functional foods.
> ✓ Encapsulation is used to protect probiotics during storage. Reported survival gains range from 0.5 to 2 log CFU/g (refs).

**"-ing" tack-ons that fake depth.** *thereby ensuring…; highlighting the potential
of…; underscoring its role in…; contributing to…*
> ✗ Firmness decreased by 23%, highlighting the potential of HPP to enhance quality attributes.
> ✓ Firmness decreased by 23% (p < 0.05). This is consistent with pectin solubilisation reported by X et al. (2023).

**Vague attribution / weasel words.** *studies have shown; it is widely recognised;
research suggests; many experts agree; some researchers argue.* Every one of these
must become **a specific citation** — this is the grounding rule, not just style.
> ✗ Studies have shown that polyphenols improve gut health.
> ✓ In a 12-week randomised trial in adults with obesity, X et al. (2024) reported increased *Akkermansia* abundance after 500 mg/day of grape polyphenols.

**Stock AI vocabulary.** *delve, intricate, tapestry, landscape (figurative),
testament, showcase, underscore, leverage, foster, garner, realm, pivotal, crucial,
robust (as filler), seamless, meticulous, comprehensive (as filler).*

**Copula avoidance.** *serves as / stands as / represents / constitutes* → **is**.
> ✗ Chitosan serves as a promising coating material. ✓ Chitosan is a coating material.

**Promotional adjectives.** *novel, groundbreaking, cutting-edge, remarkable,
promising, excellent, rich in (figurative), vibrant.* "Novel" needs a claim of what
is new and a citation showing it was not done before, or it is puffery.

**Negative parallelism & rule-of-three.** *Not only… but also…*; three-item lists
where the third is padding. One or two real items beat three invented ones.

**Filler & stacked hedging.** *it is important to note that; in order to; due to the
fact that; at this point in time; it could potentially possibly be argued that.*
> ✗ It could potentially possibly be suggested that the treatment might have some effect.
> ✓ The treatment reduced lipid oxidation (p = 0.03). *(Keep one accurate hedge, not four.)*

**Generic upbeat conclusions.** *opens exciting new avenues; holds great promise;
future research should explore this fascinating area.* Say what specifically is
unresolved and what experiment would resolve it, or say nothing.

**Formulaic scaffolding.** Outline-shaped "Challenges and Future Prospects"
sections that list generic obstacles; signposting ("In this section, we will…");
chatbot artifacts ("Certainly! Here is…", "I hope this helps"); sycophancy
("That's an excellent point").

**Synonym cycling.** Rotating *sample / specimen / material* for the same thing to
avoid repetition. In science **one term per concept** — repeat the exact term.

## Academic exceptions — do NOT "fix" these
General-purpose humanising rules misfire on manuscripts. Leave these alone:
- **Passive voice in Methods.** "Samples were homogenised for 60 s" is correct and
  often required. Prefer active elsewhere where the journal allows.
- **Calibrated hedging.** *may, suggests, is consistent with, under these conditions*
  carry real scientific meaning. Cut hedge **stacking**, never scientific caution —
  de-hedging into a confident claim the data don't support is a **fabrication-grade
  error**, worse than clumsy prose.
- **Journal-mandated form.** Heading case, boldface, structured-abstract headings,
  and section order come from the target journal (`journal-selector`), not from this
  guide. A journal that wants Title Case gets Title Case.
- **Precise technical terms** that resemble AI vocabulary: *matrix, significant*
  (statistical sense), *robust* (of a method), *characterise*. Don't flatten
  domain vocabulary — the tell is the **figurative** use.
- **Repetition of a defined term**, standard formulae, and reporting conventions
  (mean ± SD, n =, p =).
- **Quoted material, titles, and the reference list** — never rewrite inside them.
- **An occasional em dash or transition word.** Isolated, these mean nothing.

## Two-pass check (run before internal review)
1. **Draft**, then reread against the tells above.
2. Ask explicitly: **"What in this text still reads as machine-written?"** List what
   you find — inflated significance, unattributed claims, stock vocabulary, even
   mid-length cadence.
3. **Revise** those specific spots. Then verify no number, hedge, claim scope, or
   citation changed in the process.

Judge by **clusters**, not single hits: one *however* is nothing; "delve into the
intricate landscape" plus "studies have shown" plus a "promising avenues" ending is
a machine talking.

## Preserve these — they read human because they are
Specific values and conditions (cultivar, batch, 4 °C, 21 days); honest, unresolved
tension ("we cannot rule out that…"); concrete methodological detail; **varied
sentence length** (AI drifts to an even mid-length cadence); plain *is/are/has*;
limitations stated in the authors' own terms.
