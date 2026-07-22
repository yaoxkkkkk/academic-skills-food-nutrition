# Reading & Normalizing Article Formats

An obtained article arrives as **XML, HTML, or PDF**. `content_reader` normalizes any
of them into **clean, sectioned text** (Markdown) for the synthesis/review agents —
preserving what extraction depends on: **section structure, tables, figure/table
captions, units, and a locator for every item**. This is a *normalize-for-synthesis*
step, not a human-facing bilingual reading document — we don't reproduce figure images
or translate; we extract the science.

## Prefer structured over scraped — the format hierarchy
Read from the most structured source available; it is more accurate and cheaper than
scraping a PDF's layout:

1. **JATS XML (best)** — for a PMC-OA article, fetch the full JATS from **NCBI
   E-utilities**:
   `https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=pmc&id=<PMCID-digits>&rettype=full&retmode=xml`
   (verified: returns the tagged article — `<sec>`, `<table-wrap>`, `<fig>`,
   `<ref>`). Europe PMC's `.../<SRC>/<ID>/fullTextXML` is an alternative but does **not
   always populate** (it returned empty for a known OA article in testing), so prefer
   E-utilities and fall back to HTML if the XML is empty. With tagged sections and
   tables, numbers come out **exactly**; convert tags → Markdown headings/tables.
2. **Clean HTML full text** — publisher OA / PMC reader HTML. Take the article body
   (drop nav/ads/consent banners); map headings and `<table>` to Markdown.
3. **PDF (selectable text)** — use the **`pdf` skill**. Watch the usual hazards:
   two-column flow, tables split across columns/pages, captions detached from figures,
   ligatures, and running headers/footers. Reassemble sections in reading order.
4. **Scanned / image-only PDF** — OCR via the `pdf` skill; mark lower confidence and
   flag any table read from an image for a sanity check.

When two formats exist for the same paper (e.g. a PDF *and* PMC XML), **use the XML**
for data and keep the PDF only for anything the XML lacks.

## What to preserve (extraction depends on it)
- **Section structure** — Abstract, Methods, Results, Discussion… so every extracted
  claim/value gets a locator (`Results §3.2`, `Table 2`, `Fig. 4`).
- **Tables as Markdown tables** — the single most important thing for `data_extractor`
  and for sanity-checking reported numbers. Never flatten a table to prose.
- **Figure and table captions** verbatim (values and n often live only in captions).
- **Units and symbols** exactly (µ, ±, °C, superscripts) — a mangled unit is a wrong number.
- **Numbers exactly** — never round, reformat, or infer a value the text doesn't state.

## Honesty
Normalize only what the source actually contains. If a table didn't OCR cleanly or a
section is missing, say so and mark it — do not reconstruct a value. A page/section
that couldn't be read is flagged, not summarized from memory
(`food-paper/references/faithfulness-and-citation.md`).

## Why a full "reader" skill isn't needed here
Human-facing paper *readers* (bilingual side-by-side, in-place figure images, reading
polish) solve a different problem. For evidence synthesis we need clean text + tables +
locators, which this normalization provides. Keep it inside `food-fetch`; don't build a
parallel reader.
