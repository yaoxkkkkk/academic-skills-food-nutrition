# Statistics Reporting Standards (food & nutrition)

Canonical for `food-paper`'s `statistician` (write) and `food-review`'s
`reviewer_methodology` (check).

## Report for every analysis
- The **experimental unit** and **n** (biological replicates, not analytical/technical).
- The **design** and **model** (fixed vs random terms for mixed models; blocking).
- The **test**, the **statistic**, and the **exact p-value** (not just "p<0.05").
- **Effect size** + variability (SD/SEM/CI); the **significance threshold**.
- **Software/packages** and version; seed where randomization/jitter is used.
- **Multiple-comparison** correction where relevant; **post-hoc** method named.

## Choose the test by design (common food/nutrition cases)
- Treatments × response → one/two-way **ANOVA** + Tukey/Dunnett (significance letters).
- Repeated measures / batch / panelist → **mixed models** (state random terms).
- Non-normal / small n → transformation or **non-parametric** (Kruskal–Wallis).
- Many variables (metabolomics, volatiles, sensory) → **PCA / PLS-DA** with
  cross-validation + permutation (report R²/Q²); avoid overfitting.
- Dose/time response, growth/inactivation → regression / model fit
  (Weibull/Gompertz/log-logistic) + goodness-of-fit.
- Method agreement → correlation **and Bland–Altman**, not correlation alone.
- Sensory → correct panel model; consumer vs trained analysis.

## Check assumptions
Normality, homoscedasticity, independence — state how checked and what was done
if violated.

## Red flags (reviewer)
p-hacking, HARKing, pseudo-replication, undisclosed n or error type, ANOVA on
non-independent data, correlation misread as agreement/causation, "trending"
language for non-significant results, missing multiple-comparison correction.
