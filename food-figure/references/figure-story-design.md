# Figure Story Design — From Charts to a Complete Evidence Narrative

Use this layer before the normal figure contract when a user requests a dense
Figure 1/2-style result plate rather than one chart or a small composite. The
goal is a coherent evidence sequence, not a collection of every available plot.

## Story contract

Define five items before choosing panels:

1. **One-sentence figure conclusion.** This becomes the figure-level title or
   the opening sentence of the caption.
2. **Experimental sequence.** Order the logic as design/input → raw observation
   → primary comparison → diagnostic/deviation → robustness → integrated
   conclusion. Skip stages that the data cannot support.
3. **Evidence hierarchy.** Mark each proposed panel as orientation, primary
   evidence, diagnostic, supporting evidence, or synthesis. The primary evidence
   receives the most space.
4. **Panel non-redundancy.** Write the question answered by each panel. Merge or
   remove panels that answer the same question with the same encoding.
5. **Source-data map.** Assign every panel to exact columns, transformations,
   replicate definitions, statistics, and a trace-card entry before rendering.

## Recommended dense-figure architecture

For 8–12 panels, use an asymmetric grid rather than equal small multiples:

- **Opening panel:** a code-drawn workflow, experimental timeline, sample map,
  or mechanism schematic. It may span two columns but must not imply unsupported
  biology or contain quantitative evidence.
- **Raw-data layer:** one or two panels that expose measurements or
  distributions before summarisation.
- **Primary evidence layer:** two or three panels for the central comparison,
  agreement, kinetics, or dose relationship.
- **Diagnostic and robustness layer:** residuals, sensitivity/robustness matrix,
  cross-batch/operator checks, or interval estimates.
- **Synthesis panel:** a compact scorecard, decision matrix, or multi-metric
  summary. State explicitly if thresholds or scores are illustrative.

Panel labels follow reading order (`a`, `b`, …). Use a figure-level title in the
form `Figure N | One-sentence theme` for gallery/tutorial examples; follow the
target journal's title rules for actual submissions.

## Visual system

- Use one semantic palette of 3–4 hues across the full figure. The same colour
  always carries the same meaning; neutral structure stays grey.
- Repeat encodings (colour + shape/linetype) for accessibility.
- Use a shared type scale and consistent panel-label position. At final size,
  body text is at least 7 pt and axis text at least 7 pt.
- Allocate whitespace around the opening schematic and synthesis panel. Dense
  does not mean crowded.
- Prefer direct labels and small legends. Avoid a separate legend in every panel.

## Schematic boundary

Draw simple experimental logic with deterministic vector geometry in Python/R
when possible. A schematic may show verified groups, measurement steps, time
order, or decision gates. It must not introduce invented mechanisms, results,
instruments, branding, or realistic images. AI image generation remains opt-in
and is governed separately by `ai-image-generation.md`.

## QA gate for a complete figure story

- Reading panels in order reconstructs the experimental logic without the main
  text.
- The conclusion depends on primary evidence, not on the summary scorecard.
- Raw observations and uncertainty appear before or beside derived conclusions.
- Model diagnostics and robustness checks are visible where relevant.
- Every quantitative panel has source data, units, n, and defined uncertainty.
- The schematic is clearly conceptual and the synthesis panel identifies any
  illustrative scoring or thresholds.
- The caption describes why each panel exists, not only what chart type it uses.
