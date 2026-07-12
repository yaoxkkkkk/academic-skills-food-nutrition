# Contributing

Thanks for helping build this open food & nutrition skill suite! Contributions
from research groups worldwide are warmly welcomed.

## The one rule that matters most
**Never push to `main`.** Work on the **`development`** branch and open a **pull
request** to merge into `main`. `main` changes only through a reviewed PR.

```bash
git checkout development
git pull origin development
# make changes
git add -A && git commit -m "describe your change"
git push origin development
gh pr create --base main --head development   # or open the PR on GitHub
```

## Before you open a PR
- Update **README.md** and add a **CHANGELOG.md** entry for your change, and bump
  the `version` in both `.claude-plugin/*.json`.
- Run the verification steps and make sure they pass.

## Full instructions (for humans and coding agents)
See **[AGENTS.md](AGENTS.md)** — it is the complete, machine-actionable contract
(branching, required doc updates, verification commands, content rules, and
structure conventions). AI coding agents (Claude Code, Codex, Cursor, …) should
read `AGENTS.md` first.

## Questions & contact
Open an issue, or contact the development team at
**[food_agents@lists.unimelb.edu.au](mailto:food_agents@lists.unimelb.edu.au)** —
food research teams interested in contributing or collaborating are warmly
welcome to reach out. By contributing you agree your work is original and
released under the project's MIT license.
