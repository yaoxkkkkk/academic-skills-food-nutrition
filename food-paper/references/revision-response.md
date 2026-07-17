# Revision with Tracked Changes + Point-by-Point Response Letter

When revising a manuscript against an **existing review** — a `food-review` report
and/or **margin comments** on a Word file — `food-paper` (revise mode) produces two
Word deliverables. **Which second deliverable depends on the context:**

| Context | Deliverables |
|---|---|
| **Inside `food-pipeline`** | 1. the manuscript with Tracked Changes (original only if authorized), and 2. **the existing `Review_and_Response_Report_….docx` updated in place** — fill each item's `Response (<type>)` with what you actually did. **Do not create a separate response letter**; that report *is* the response. |
| **Standalone** (responding to a real journal's reviewers) | 1. the **original manuscript revised with Tracked Changes**, and 2. a **point-by-point response letter** as a new Word (`.docx`) document addressed to the editor. |

Both are **Word (`.docx`)** — Markdown is a working format, never the deliverable.
Convert with Pandoc (`pandoc x.md -o x.docx`) or the **`docx` skill**; never claim a
`.docx` you did not produce.

The **revision log / combined report** follows
`food-review/references/report-format.md`: stable issue IDs (`A#/B#/C#/D#`, `SQ#`,
`R2-*`, `FC#`), each concern paired with a `Response (<type>)` line where type ∈
**Tracked edit · Editor query · Recommendation · Residual**, precise locations
(`P##` / Table / Figure), overall assessment, editorial decision, summary of
changes, and a residual-items list. Reuse the same IDs in the manuscript comments
and the response letter so the three cross-reference.

## 1. Revise with Tracked Changes (original file is opt-in)
- **Standalone `food-paper` revise** (user asked to revise this file): edit **the
  original `.docx`** with Tracked Changes so the editor can accept/reject each
  change — unless the user asks for a separate revised copy.
- **Inside `food-pipeline`:** do **not** modify the original Word file unless the
  author has **explicitly authorized** in-place tracked changes. Default: leave
  the original untouched; deliver a **revised copy** (or change log / marked
  draft) plus the updated **Review & Response Report** (§2a).
- When editing in place is authorized: make every edit as a **tracked change**.
  In OOXML: insertions are
  `<w:ins w:id=".." w:author=".." w:date="..">…</w:ins>` and deletions
  `<w:del …><w:r><w:delText>…</w:delText></w:r></w:del>`; enabling
  `<w:trackChanges/>` in `word/settings.xml` keeps further edits marked. Use the
  **`docx` skill** (or a Word-capable tool) to apply these — it handles the plumbing.
- **Preserve citation field codes.** EndNote/Zotero/Mendeley citations are Word
  **fields**: the code lives in a hidden `w:instrText`, and only `(Author, Year)`
  is shown. Never flatten a field into visible text (that dumps
  `ADDIN EN.CITE <EndNote>…</EndNote>` into the manuscript as a stray paragraph).
  Treat each field as one atomic unit and edit the prose around it — see
  `word-field-codes.md`.
- **Resolve the margin comments** as you address them (or leave a reply noting the
  change), so each reviewer comment maps to a visible edit.
- **Items you cannot edit** (need the author's data/decision) are classified
  **Editor query**: instead of a silent recommendation, insert a comment or tracked
  `EDITOR QUERY` note **in the manuscript at that location**, tagged with the issue
  ID, so the author sees exactly where to act (see
  `food-review/references/word-review-comments.md`).
- Keep the project's grounding rule: every new claim/number/citation is real and
  verified (`faithfulness-and-citation.md`); run `scripts/verify_citations.py`,
  `scripts/check_docx_fields.py` (no leaked EndNote/Zotero field codes), and
  `scripts/privacy_scan.py` before delivering.

## 2a. Inside `food-pipeline` — update the one report, don't write a letter
Open the existing **`Review_and_Response_Report_<slug>_<date>.docx`** produced at
Stage 3 and **edit it in place**: for every issue ID, fill in its
`Response (<type>)` line (blue) — **Tracked edit** (what changed and where, `P##`) ·
**Editor query** (the comment placed in the manuscript) · **Recommendation** ·
**Residual** — then update the *Summary of changes applied* and the *residual items*
list. The result holds the reviewer feedback **and** the editing response in one
document. **No separate response letter.** See
`food-review/references/report-format.md`.

## 2b. Standalone — point-by-point response letter (new .docx)
Only when responding to a **real journal's reviewers** outside the pipeline. A new
Word document, addressed to the editor/reviewers, with one numbered block per
concern (reuse the same issue IDs):

```
Reviewer <n>, Comment <n.m>:
> "<the reviewer's comment, quoted verbatim>"

Response:
<how you addressed it — what changed and why; or a courteous, evidenced rebuttal
if you disagree, citing sources>.

Change: <what was edited and where — Section/Page/Line, e.g. "Methods §2.3, p.4,
lines 112–118">. [Optionally quote the revised text.]
```
- Cover **every** comment (major and minor); never silently skip one.
- Group by reviewer; open with a brief thank-you + summary of key changes.
- Where you disagree, say so respectfully with evidence — do not overstate.

## Equivalents & fallback
- **LibreOffice `.odt` / Pages / Google Docs:** use that tool's track-changes /
  suggesting mode; the report/letter is a document in the same format.
- **No Word tooling at all:** this is a **last resort, not a shortcut** — try Pandoc
  (`pandoc x.md -o x.docx`) and the **`docx` skill** first. Only if both are
  unavailable, deliver the revised manuscript with changes marked (a diff or change
  log) and the report/letter as Markdown, **state plainly which format was used and
  why**, and give the conversion command — never claim a tracked-changes `.docx` you
  did not produce.

## Combined vs per-round
Run **standalone**, produce one revised manuscript + one response letter (§2b).

Inside **`food-pipeline`**, the **default is one** review→revise round (a second
round needs author authorization). Never emit per-round copies: there is **one
manuscript** and **one `Review_and_Response_Report_….docx`** (§2a), and an authorized
round 2 appends `R2-*` items to that same report. Only when the author has authorized
in-place edits does the manuscript accumulate tracked changes in the original;
otherwise it is a revised copy. See the pipeline's "Deliverables" rules.
