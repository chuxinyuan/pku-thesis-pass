#!/usr/bin/env python3
"""Collect packaged files into release/<version>/ for Typst Universe submission.

Prepares the publish-ready directory after `just release` has switched
imports to @preview mode and `just bump` has synced doc version refs.

Usage:
    python3 scripts/publish.py
"""

import re
import shutil
import sys
from pathlib import Path


def _get_version(root: Path) -> str:
    content = (root / "typst.toml").read_text()
    m = re.search(r'^version\s*=\s*"([^"]+)"', content, re.MULTILINE)
    if m is None:
        raise SystemExit("Could not find version in typst.toml")
    return m.group(1)


def main() -> None:
    root = Path(__file__).resolve().parent.parent
    version = _get_version(root)
    dest = root / "release" / version

    print(f"Collecting release files to release/{version}/ ...")

    if dest.exists():
        shutil.rmtree(dest)

    # top-level files
    for filename in ["typst.toml", "thumbnail.png", "LICENSE", "README.md"]:
        path = root / filename
        if path.exists():
            copy_fn = shutil.copy2 if path.is_file() else shutil.copytree
            dest_path = dest / filename
            dest_path.parent.mkdir(parents=True, exist_ok=True)
            copy_fn(str(path), str(dest_path))
            print(f"  {filename}")

    # format/ (entire directory)
    dest_fmt = dest / "format"
    shutil.copytree(str(root / "format"), str(dest_fmt))
    print(f"  format/")

    # template/ (exclude thesis.pdf)
    def _ignore(path, names):
        return {"thesis.pdf"} & set(names)

    dest_tpl = dest / "template"
    shutil.copytree(str(root / "template"), str(dest_tpl), ignore=_ignore)
    print(f"  template/")

    print(f"Done. Files staged at release/{version}/")
    print(f"Next: copy release/{version}/* to packages repo.")


if __name__ == "__main__":
    main()
