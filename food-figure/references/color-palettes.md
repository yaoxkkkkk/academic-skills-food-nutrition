# Color Palettes — academic, colourblind-safe

Pick by **data type**, not decoration. Decision hierarchy: **user-specified →
target-journal convention → data type (below) → default (Okabe-Ito)**. Always
colourblind-safe; encode redundantly (colour + shape/linetype); never `jet`/rainbow.

## Qualitative (categorical groups)
- **Okabe–Ito (default, colourblind-safe):**
  `#000000 #E69F00 #56B4E9 #009E73 #F0E442 #0072B2 #D55E00 #CC79A7`
- **Cool academic (blue-led):** `#0072B2 #009E73 #56B4E9 #CC79A7 #E69F00 #000000`
- **Food/earth tones** (for food-themed categories; still distinguishable):
  `#8C5A2B #C88A3A #6B8E23 #4E7C59 #B24C3A #46739E` — check contrast if >6 groups.

Use ≤6–7 categories; beyond that, group or facet rather than add colours.

## Sequential (ordered / low→high, single hue family)
- **viridis** / **cividis** (cividis is optimised for colour vision deficiency) —
  perceptually uniform; use for heatmaps, concentration, intensity, log CFU/g.
- **Amber→brown** (food browning/oxidation): light `#FDE68A` → `#F59E0B` → dark `#7C3A12`.
Never use a rainbow/`jet` map for continuous data.

## Diverging (around a meaningful midpoint, e.g. z-score, log2 fold-change)
- **Blue–white–red (RdBu-like):** `#0072B2` ↔ `#FFFFFF` ↔ `#D55E00`.
- **Teal–white–coral:** `#008080` ↔ `#FFFFFF` ↔ `#E9573F`.
Centre the map on the neutral value (0) and make the two arms perceptually equal.

## Monochrome (one variable, ordered, or print-safe)
- **Blue mono:** `#DEEBF7 #9ECAE1 #4292C6 #08519C`
- **Grey:** `#F0F0F0 #BDBDBD #737373 #252525`

## Applying in code
- **Python (matplotlib/seaborn):** `sns.set_palette(OKABE)`; sequential `cmap="viridis"`; diverging `cmap="vlag"`/custom `LinearSegmentedColormap`.
- **R (ggplot2):** `scale_*_manual(values = okabe)`; `scale_*_viridis_c()`; diverging via `scale_*_gradient2()` or `circlize::colorRamp2` (ComplexHeatmap).

## Rules
- Same colour = same meaning across every panel of a figure and across figures in the paper.
- Keep the palette to 2–3 hues + greyscale for schematics (see `ai-image-generation.md`).
- Verify legibility in greyscale (redundant encoding) and against a colourblindness simulator for key figures.
