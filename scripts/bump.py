#!/usr/bin/env python3
"""Bump version references in doc examples to match typst.toml.

Scans template/content/*.typ and replaces all occurrences of
@preview/pku-thesis-pass:<old-version> with the current version
read from typst.toml [package] section.

Usage:
    python3 scripts/bump.py
"""

import re
import sys
from pathlib import Path

VERSION_DOC_RE = re.compile(r"@preview/pku-thesis-pass:\d+\.\d+\.\d+")


def _get_version(root: Path) -> str:
    content = (root / "typst.toml").read_text()
    m = re.search(r'^version\s*=\s*"([^"]+)"', content, re.MULTILINE)
    if m is None:
        raise SystemExit("Could not find version in typst.toml")
    return m.group(1)


def main() -> None:
    root = Path(__file__).resolve().parent.parent
    version = _get_version(root)
    print(f"Bumping doc version references to {version}...")

    content_dir = root / "template" / "content"
    for f in sorted(content_dir.rglob("*.typ")):
        old = f.read_text()
        new = VERSION_DOC_RE.sub(rf"@preview/pku-thesis-pass:{version}", old)
        if new != old:
            f.write_text(new)
            rel = f.relative_to(root)
            print(f"  {rel}")
        else:
            rel = f.relative_to(root)
            print(f"  {rel} (no change)")

    print("Done.")


if __name__ == "__main__":
    main()
