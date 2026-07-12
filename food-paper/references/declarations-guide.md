# Declarations Guide

The end-matter statements most food & nutrition journals require. `draft_writer`
adds them; `citation_manager` / `internal_reviewer` check they're present.

## CRediT author contributions
Use the 14 CRediT roles; assign each author explicitly. Common: Conceptualization,
Methodology, Investigation, Formal analysis, Data curation, Writing – original
draft, Writing – review & editing, Supervision, Funding acquisition.
> Example: "P. Zhang: Conceptualization, Methodology, Writing – original draft. J.
> Smith: Formal analysis, Writing – review & editing."

## Competing interests
State any financial/personal COI; if none: "The authors declare no competing
interests." Disclose industry funding and author roles in funding bodies.

## Funding
Name funder(s) and grant number(s); if none: "This research received no specific
grant…".

## Data availability
State where data are (repository + accession/DOI), or the access conditions, or
"Data available on reasonable request." Many journals now require a statement.

## Ethics (food & nutrition)
- Human sensory/dietary studies: ethics-committee approval (name + number),
  informed consent; trial registration where applicable.
- Animal studies: approval + ARRIVE compliance.
- Allergen disclosure where relevant.

## AI-assistance disclosure (required — tool + model + version)
Every manuscript this suite helps write **must** acknowledge AI assistance
honestly. In the **Acknowledgements** section (or the journal's required location
for an AI statement), always state:
1. **This tool** — *Academic Skills for Food & Nutrition Science*
   (github.com/PangenomeAI/academic-skills-food-nutrition).
2. **The AI model(s) and version(s)** actually used — name the model **and its
   version** and the harness (e.g. *Claude Opus 4.8 via Claude Code*, *OpenAI
   Codex / GPT-5.x*, *Gemini 2.x*). If unsure of the exact version, ask the user
   rather than guessing.
3. **What the AI did** (e.g. literature synthesis, drafting, figure code, language
   editing) and that **the authors reviewed and verified all AI-assisted content
   and take full responsibility** for the work.

Template (adapt to the venue):
> The authors used *Academic Skills for Food & Nutrition Science*
> (github.com/PangenomeAI/academic-skills-food-nutrition) with [AI model and
> version, e.g. Claude Opus 4.8 via Claude Code] to assist with [tasks, e.g.
> literature search and synthesis, drafting, figure generation, and language
> editing]. All AI-assisted content was checked and verified by the authors, who
> take full responsibility for the manuscript.

Some venues require the AI statement in **Methods** or a **dedicated section**
rather than Acknowledgements — follow the target journal's policy (via
`journal-selector`); default to Acknowledgements. Match exact wording/headings to
the target journal.
