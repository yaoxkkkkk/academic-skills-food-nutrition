# Pipeline State Machine

The states, transitions, and loop caps `food-pipeline` follows. `intake_router`
sets the entry state; `quality_gate` governs transitions.

## States
`ROUTE → RESEARCH → WRITE → REVIEW → REVISE → RE-REVIEW → FINALIZE → done`

## Transitions
1. **ROUTE** → RESEARCH (or a later state if materials already exist).
2. **RESEARCH** → gate(evidence sufficient?) → WRITE | back to RESEARCH.
3. **WRITE** → gate(integrity + journal compliance) → REVIEW | back to WRITE.
4. **REVIEW** → **mandatory author decision** → REVISE (address concerns) | FINALIZE (accept) | stop (reject/withdraw).
5. **REVISE** → RE-REVIEW.
6. **RE-REVIEW** → gate(issues resolved?) → FINALIZE (accept) | back to REVISE (one more loop).
7. **FINALIZE** → gate(final compliance) → done | back to WRITE (fix).

## Entry points (mid-pipeline)
- Topic/dataset only → RESEARCH.
- Results/dataset ready → WRITE.
- Full draft → WRITE (finish) or REVIEW.
- Reviewer comments in hand → REVISE.

## Loop caps
- Research ↔ gate: until evidence is sufficient (no fixed cap; stop if saturated).
- Review ↔ revise: **max 2 review rounds**, then deliver with residual issues listed.
- Never restart a completed state without a gate failure that requires it.

## Rule
Every transition passes through a gate. Integrity and review gates cannot be
skipped; the review decision is always the author's.
