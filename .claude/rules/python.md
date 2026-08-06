---
paths:
  - "**/*.py"
  - "**/requirements.txt"
  - "**/pyproject.toml"
---

# Python rules

These load only when you touch a Python file. That's the point of `paths:` frontmatter — the rule costs nothing on the 90% of turns that don't involve Python.

- Use `uv` if available, otherwise `pip` with a venv. Never install globally.
- Type hints on function signatures. Not on locals.
- `pathlib` over `os.path`. `httpx` over `requests` for anything async.
- Any script that reads data prints `df.head()` or an equivalent sample before doing anything else. Blake can't spot a parsing bug from a diff, only from output.
- Data analysis: `polars` if the file is over 100MB, `pandas` otherwise.
- Stats work: `scipy` and `statsmodels`. Do not hand-roll a t-test.
- Secrets come from the environment. If a script needs a key, read it from `os.environ` and fail loudly with the variable name if it's missing.
