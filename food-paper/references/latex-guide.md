# LaTeX Guide — prepare, edit, and build manuscript PDFs

Used by `food-paper` (`writer`, and the **format-convert** mode) and by
`food-pipeline` FINALIZE. Yes — the suite can prepare and edit LaTeX drafts and
build a PDF, when a LaTeX toolchain is available.

## Two routes to a PDF

**A. Markdown → PDF via Pandoc** (simplest; good default):
```bash
pandoc main.md -o main.pdf --pdf-engine=xelatex \
  --citeproc --bibliography=refs.bib --csl=<journal-style>.csl
```
- Use `--citeproc` + a **CSL** style so citations match the journal (APA 7, Vancouver, Nature, ACS, RSC…); pull the target style via `journal-selector`.
- `--template=<journal-template>.tex` applies a journal LaTeX template when supplied.

**B. Native LaTeX (`.tex`) → PDF** (when the journal provides a LaTeX class):
```bash
latexmk -pdf -xelatex main.tex        # preferred: handles reruns + bibtex/biber
# or, manually:
xelatex main.tex && bibtex main && xelatex main.tex && xelatex main.tex
```

## Engine & bibliography selection
- **Engine:** `pdflatex` by default; **`xelatex`/`lualatex`** if the class uses `fontspec`, `unicode-math`, or non-Latin text. `latexmk` (or **Tectonic**, which auto-fetches packages) is preferred as the driver.
- **Bibliography:** `bibtex` for `\bibliography{}`; **`biber`** for `biblatex`. Keep one `.bib` from `citation_manager` and cite by citekey.

## Editing an existing draft
- Edit the `.tex`/`.md` source directly; keep every in-text `\cite{key}` resolvable in the `.bib` (run `scripts/verify_citations.py` on the citations first — see `faithfulness-and-citation.md`).
- Figures from `food-figure`: include **PDF/EPS** (vector) or high-DPI **PNG/TIFF**; `\includegraphics[width=\linewidth]{fig1.pdf}`. food-figure exports these at the journal spec.
- Tables: use `booktabs`; keep tables editable (not images).

## Journal templates
Many journals ship a LaTeX class (`elsarticle`, `achemso` (ACS), `rsc` , Springer
`sn-jnl`, IEEE, Nature `nature`…). When the author targets such a journal, use its
class + `.bst`/`.csl`; get the structure/limits/reference style from
`journal-selector`. Do **not** hand-invent a class — use the official one.

## Preflight & failure handling
- **Preflight:** confirm all `\includegraphics` files exist, every `\cite{}` key is in the `.bib`, every `\ref{}`/`\label{}` resolves, and required packages/class are present.
- **On failure:** read the first error (file:line + message); fix that root cause before secondary warnings. Missing toolchain (`latexmk`/engine not installed) is a **UNAVAILABLE** environment issue, not a manuscript error — report it and fall back to Pandoc or deliver the `.tex` + build instructions.
- **Never** fabricate a compiled PDF or claim success without a real build.

## If no LaTeX toolchain is available
Deliver the `.tex` (or `.md`) plus the exact build commands above, and the `.bib`;
the author compiles locally or on Overleaf. DOCX remains available via
`pandoc main.md -o main.docx`.
