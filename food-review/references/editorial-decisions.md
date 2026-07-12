# Editorial Decision Standards

How `review_coordinator` turns the panel into one verdict.

## Verdicts
- **Accept** — publishable; at most trivial fixes. Rare on first review.
- **Minor Revision** — sound; specific, bounded fixes; no new experiments.
- **Major Revision** — promising but needs substantial work (more data/analysis,
  restructured argument, added controls) that must be re-reviewed.
- **Reject** — fatal flaw (invalid design, unsupported central claim, out of
  scope, integrity/ethics breach) or contribution too limited for the venue.

## Deciding
1. Start from the weighted score band (`quality-rubrics.md`).
2. Apply **overrides:**
   - Any **critical integrity/ethics flag** (fabrication, missing human-ethics
     approval, unsafe guidance) → **Reject** or Major Revision with the block named.
   - A **fatal methods/validation flaw** that no revision can fix → Reject.
   - **Scope mismatch** with the target journal → Reject (suggest a better venue).
3. Reconcile reviewer disagreement explicitly — state the divergence and your
   adjudication; do not silently side with one reviewer.

## Output to the author
- The decision + the decisive reasons.
- A **prioritized revision checklist:** Critical → Major → Minor → Suggestions,
  each tied to a reviewer and a concrete fix.
- A **response-letter skeleton:** one numbered block per concern for the author to
  answer point by point.

## Tone
Firm, specific, fair. The decision must follow from the panel, not override it
without a stated reason.
