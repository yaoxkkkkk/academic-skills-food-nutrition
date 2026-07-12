# Quality Rubrics (1–5 scoring)

Used by `review_coordinator` to score and by `reviewer_*` to justify. Score each
dimension 1–5 with a one-line reason; the coordinator weights them.

## Dimensions & weights
| Dimension | Weight | 5 (excellent) | 1 (unacceptable) |
|---|---|---|---|
| Contribution / novelty | 20% | Clear, important advance | No new contribution / already known |
| Rigor & evidence | 25% | Sound design; claims fully supported; adequate biological n; validated methods | Fatal design/validation flaws; claims unsupported; pseudo-replication |
| Method & reporting | 20% | Reproducible; correct stats; right reporting guideline | Not reproducible; wrong/absent stats; no guideline |
| Argument coherence | 20% | Logical flow question→results→conclusions; each RQ answered | Disjointed; conclusions not supported |
| Writing & formatting | 15% | Clear; matches journal style/limits | Unclear; non-compliant; mixed citation styles |

## Scoring anchors
- **5** publishable as-is on this dimension. **4** minor fixes. **3** needs work
  but salvageable. **2** major rework required. **1** fatal on this dimension.

## Weighted overall → verdict band
- ≥4.0 → Accept · 3.0–3.9 → Minor Revision · 2.0–2.9 → Major Revision · <2.0 → Reject.
- Any **critical integrity/ethics flag** caps the outcome at Major Revision or
  Reject regardless of the numeric score (see `editorial-decisions.md`).

## Note
Rigor & evidence is the heaviest weight — a beautifully written paper with a fatal
methods flaw still fails. Journal ranking is not a scoring dimension (that's for
source selection, not manuscript quality).
