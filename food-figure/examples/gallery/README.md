# Food-Figure Gallery

This gallery is a runnable end-to-end test of the `food-figure` Figure-story
workflow. Every value, sample, study design, threshold, score, figure, and
caption is **synthetic/illustrative**. Nothing here is evidence, a real
experiment, or a result suitable for citation or submission.

Run from the repository root:

```bash
Rscript food-figure/examples/gallery/render_gallery.R
```

The base-R script deterministically rebuilds the source CSV files and writes one
final vector PDF plus one 2600 x 3400 RGB PNG for each case to `figures/`. On
macOS, it uses the built-in `sips` renderer so PNG export also works when R lacks
optional Cairo/X11 components. Captions and trace cards map every panel to its
source data, transformations, statistics, and limitations.

| Case | Experimental story | Panels | Final files |
|---|---|---:|---|
| 1 | Active pectin packaging: film design and material performance through chilled blueberry quality | 11 (a-k) | `fig1_active_packaging.*` |
| 2 | Probiotic encapsulation: formulation through storage, challenge survival, batch variation, and synthesis | 11 (a-k) | `fig2_probiotic_storage_kinetics.*` |
| 3 | Trained sensory panel: blinded design through profiling, PCA, repeatability, liking, and actionability | 11 (a-k) | `fig3_sensory_radar.*` |
| 4 | Rapid phenolic assay: validation design through calibration, agreement, diagnostics, accuracy, precision, robustness, and synthesis | 12 (a-l) | `fig4_method_validation_and_evidence.*` |

The four figures use one shared semantic palette while tailoring the panel
types to the research question. The opening schematic contains only the
illustrative experimental logic. Data-bearing panels are generated in R, and
the final synthesis panels are explicitly labelled illustrative.

The AI schematic route was separately tested with a four-layer food-science
prompt. The image service returned HTTP 403 in that test environment, so no
AI-generated asset is included or represented as generated. See
`ai-image-test.md`.

For actual research, replace every synthetic CSV with verified study data;
validate statistics and model assumptions; update the trace card; and disclose
any AI use in line with institutional and journal requirements.
