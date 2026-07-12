#!/usr/bin/env python3
"""Lightweight citation & claim-binding verifier (anti-fabrication gate).

Checks a citations JSON so agents can't ship invented references or unbound
claims. Format + binding checks are offline (always run); DOI existence is an
optional online check (Crossref). Stdlib only.

Input JSON:
{
  "references": [
    {"citekey": "zhang2023", "doi": "10.1016/j.foodchem.2023.133912",
     "title": "…", "authors": "…", "year": 2023}
  ],
  "claims": [
    {"text": "coating cut weight loss", "citekeys": ["zhang2023"],
     "locator": "Fig. 2", "supports": true}
  ]
}

Usage:
  python verify_citations.py CITES.json          # offline: format + binding
  python verify_citations.py CITES.json --online # also resolve DOIs at Crossref
  python verify_citations.py --selftest

Exit code is non-zero if any hard problem is found (a reference with no verifiable
identifier, a dangling/unbound claim, or a CONFIRMED-MISSING DOI).
"""
import json
import re
import sys

DOI_RE = re.compile(r"^10\.\d{4,9}/\S+$", re.I)
ARXIV_RE = re.compile(r"^\d{4}\.\d{4,5}(v\d+)?$")
PMID_RE = re.compile(r"^\d{4,9}$")


def has_identifier(ref):
    return bool(
        (ref.get("doi") and DOI_RE.match(str(ref["doi"]).strip()))
        or (ref.get("arxiv") and ARXIV_RE.match(str(ref["arxiv"]).strip()))
        or (ref.get("pmid") and PMID_RE.match(str(ref["pmid"]).strip()))
        or ref.get("url")
    )


def resolve_doi(doi):
    """Return CONFIRMED / CONFIRMED-MISSING / UNAVAILABLE via Crossref."""
    import urllib.request
    import urllib.error
    url = "https://api.crossref.org/works/" + urllib.request.quote(doi)
    req = urllib.request.Request(url, method="HEAD",
                                 headers={"User-Agent": "food-nutrition-skills/1.0 (mailto:food_agents@lists.unimelb.edu.au)"})
    try:
        with urllib.request.urlopen(req, timeout=10) as r:
            return "CONFIRMED" if r.status == 200 else "UNRESOLVED"
    except urllib.error.HTTPError as e:
        return "CONFIRMED-MISSING" if e.code in (404, 410) else "UNAVAILABLE"
    except Exception:
        return "UNAVAILABLE"


def verify(data, online=False):
    refs = data.get("references", [])
    claims = data.get("claims", [])
    by_key = {r.get("citekey"): r for r in refs}
    problems, notes = [], []

    for r in refs:
        key = r.get("citekey", "<no-citekey>")
        if not has_identifier(r):
            problems.append(f"reference '{key}': no verifiable identifier (DOI/PMID/arXiv/URL) — possible fabrication")
        elif online and r.get("doi") and DOI_RE.match(str(r["doi"]).strip()):
            status = resolve_doi(str(r["doi"]).strip())
            notes.append(f"reference '{key}': DOI {status}")
            if status == "CONFIRMED-MISSING":
                problems.append(f"reference '{key}': DOI does not exist at Crossref (CONFIRMED-MISSING)")

    for i, c in enumerate(claims):
        keys = c.get("citekeys", [])
        if not keys:
            problems.append(f"claim #{i+1} ('{c.get('text','')[:40]}…'): no citation bound (unsupported)")
        for k in keys:
            if k not in by_key:
                problems.append(f"claim #{i+1}: dangling citekey '{k}' not in references")
        if keys and (c.get("supports") is not True or not c.get("locator")):
            problems.append(f"claim #{i+1}: binding not gate-4 supported (needs supports=true AND a locator)")

    return problems, notes


def selftest():
    good = {
        "references": [{"citekey": "z2023", "doi": "10.1016/j.foodchem.2023.133912",
                        "title": "x", "authors": "Z", "year": 2023}],
        "claims": [{"text": "effect", "citekeys": ["z2023"], "locator": "Fig. 2", "supports": True}],
    }
    p, _ = verify(good, online=False)
    assert p == [], p

    bad = {
        "references": [
            {"citekey": "noid", "title": "made up", "year": 2024},              # no identifier
            {"citekey": "ok", "doi": "10.1000/xyz123"},
        ],
        "claims": [
            {"text": "unbound", "citekeys": []},                                 # unsupported
            {"text": "dangling", "citekeys": ["ghost"], "locator": "p.1", "supports": True},  # dangling
            {"text": "weak", "citekeys": ["ok"]},                                # no locator/supports
        ],
    }
    p, _ = verify(bad, online=False)
    joined = " ".join(p)
    assert "no verifiable identifier" in joined
    assert "unsupported" in joined
    assert "dangling citekey" in joined
    assert "gate-4 supported" in joined
    print("OK: verify_citations selftest passed")


def main(argv):
    if "--selftest" in argv:
        selftest()
        return 0
    args = [a for a in argv[1:] if not a.startswith("--")]
    online = "--online" in argv
    if len(args) != 1:
        print(__doc__)
        return 2
    data = json.load(open(args[0], encoding="utf-8"))
    problems, notes = verify(data, online=online)
    for n in notes:
        print("  •", n)
    if problems:
        print(f"\nFAIL: {len(problems)} problem(s) — do not ship until resolved:")
        for p in problems:
            print("  ✗", p)
        return 1
    print("OK: all references have identifiers and all claims are bound with locators.")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
