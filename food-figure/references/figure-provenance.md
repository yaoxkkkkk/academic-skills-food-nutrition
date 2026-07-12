# Figure Provenance & Captions

Every data figure carries a **provenance record** tying it to real data and the
claim it supports — the figure-level equivalent of the project's grounding rule.
This prevents figures that "look right" but don't match the data or the text.

## Figure trace card (fill for each figure)
```yaml
figure: 1
data_source: <dataset file / table + a stable id>      # never "made up"
transformation: <script that made it, e.g. examples/python_food_figures.py:growth_curve, + seed>
shows: <one-sentence caption claim — what the figure demonstrates>
supported_claims:                                       # the manuscript claims it backs
  - text: "The coating reduced weight loss over 14 days"
    locator: "Results §3.2"
statistics_shown: <error type (SD/SEM/CI), n (biological), test named>
limitations: [ <caveats; e.g. single batch, panel n=12> ]   # [] only if truly none
```
Rules: the plotted values **must match** the reported statistics (spot-check
numbers in the text against the figure); the transformation is a real script/step,
never a vague pointer; if a figure supports no stated claim, either it isn't
needed or the claim is missing.

## Caption structure
Default **APA 7.0** (or the target journal's style via `journal-selector`):
- **Label + title:** `Figure 1. <concise title of what is shown>.`
- **Body:** what each panel/series is; the food/matrix and conditions.
- **Notes:** n (biological), error bars (SD/SEM/CI), the statistical test and
  threshold, significance convention (letters/asterisks), scale bars for
  micrographs, and abbreviations. Units on every axis.
- Captions are **self-contained** — a reader understands the figure from the
  caption alone. Equations/parameters go in the caption, not inside the graphic.

## LaTeX inclusion (when building a .tex — see `food-paper/references/latex-guide.md`)
```latex
\begin{figure}[htbp]
  \centering
  \includegraphics[width=\linewidth]{figures/fig1.pdf}
  \caption{Firmness of coated vs control fruit over storage. Mean $\pm$ SD, n = 6
           biological replicates; letters denote Tukey groups ($p < 0.05$).}
  \label{fig:firmness}
\end{figure}
```
Reference figures in text as "Figure~\ref{fig:firmness}" (or `Fig. 1` per journal).

## Hand-off
Deliver each figure with: the file(s), the trace card, the caption, and the
plotting code. This lets `food-review`'s `reviewer_integrity` and the pipeline's
integrity gate audit that figures genuinely support the claims.
