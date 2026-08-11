"""Shared version utility for scripts.

Read version from typst.toml [package] section.
"""

import re
from pathlib import Path


def get_version(root: Path) -> str:
    content = (root / "typst.toml").read_text()
    m = re.search(r'^version\s*=\s*"([^"]+)"', content, re.MULTILINE)
    if m is None:
        raise SystemExit("Could not find version in typst.toml")
    return m.group(1)
