#!/usr/bin/env python3
"""Switch template imports between local dev mode and @preview preview mode.

In dev mode:
    #import "../format/lib.typ": ...          (template/*.typ)
    #import "../../format/lib.typ": ...       (template/content/*.typ)

In preview mode:
    #import "@preview/pku-thesis-pass:<version>": ...

Usage:
    python3 scripts/release.py preview   # switch to @preview imports
    python3 scripts/release.py dev       # switch back to local dev imports
"""

import re
import sys
from pathlib import Path

DEV_PATH_RE = re.compile(r'(#import\s+)"(?:\.\./)+format/lib\.typ"')
PUB_PATH_RE = re.compile(r'(#import\s+)"@preview/pku-thesis-pass:[\d.]+"')


def _get_version(root: Path) -> str:
    """Read version from typst.toml [package] section."""
    content = (root / "typst.toml").read_text()
    m = re.search(r'^version\s*=\s*"([^"]+)"', content, re.MULTILINE)
    if m is None:
        raise SystemExit("Could not find version in typst.toml")
    return m.group(1)


def _get_dev_import_path(file_path: str, template_dir: str) -> str:
    """Determine the relative dev import path for a file."""
    rel = str(Path(file_path).relative_to(template_dir))
    depth = len(rel.split("/"))  # thesis.typ → 1, content/ch01.typ → 2
    return "../" * depth + "format/lib.typ"


def _is_inside_code_block(lines: list[str], lineno: int) -> bool:
    depth = 0
    for i in range(lineno):
        stripped = lines[i].lstrip()
        if stripped.startswith("```"):
            depth = 1 - depth
    return depth == 1


def swap_to_preview(content: str, file_path: str, template_dir: Path, version: str) -> str:
    lines = content.split("\n")
    for i in range(len(lines)):
        if DEV_PATH_RE.match(lines[i]) and not _is_inside_code_block(lines, i):
            lines[i] = DEV_PATH_RE.sub(
                rf'\1"@preview/pku-thesis-pass:{version}"', lines[i]
            )
    return "\n".join(lines)


def swap_to_dev(content: str, file_path: str, template_dir: Path) -> str:
    dev_path = _get_dev_import_path(file_path, str(template_dir))
    lines = content.split("\n")
    for i in range(len(lines)):
        if PUB_PATH_RE.match(lines[i]) and not _is_inside_code_block(lines, i):
            lines[i] = PUB_PATH_RE.sub(rf'\1"{dev_path}"', lines[i])
    return "\n".join(lines)


def apply(mode: str, root: Path) -> None:
    version = _get_version(root)
    template_dir = root / "template"
    fn = {"preview": swap_to_preview, "dev": swap_to_dev}

    if mode == "preview":
        print(f"  version: {version} (from typst.toml)")

    for f in sorted(template_dir.rglob("*.typ")):
        old = f.read_text()
        if mode == "preview":
            new = fn[mode](old, str(f), template_dir, version)
        else:
            new = fn[mode](old, str(f), template_dir)
        if new != old:
            f.write_text(new)
            rel = f.relative_to(root)
            print(f"  {rel}")
        else:
            rel = f.relative_to(root)
            print(f"  {rel} (no change)")


def main() -> None:
    if len(sys.argv) != 2 or sys.argv[1] not in ("preview", "dev"):
        print("Usage: release.py [preview|dev]", file=sys.stderr)
        sys.exit(1)

    mode = sys.argv[1]
    label = {"preview": "preview (@preview)", "dev": "dev (local)"}[mode]
    print(f"Switching template imports to {label} mode...")
    root = Path(__file__).resolve().parent.parent
    apply(mode, root)
    print("Done.")


if __name__ == "__main__":
    main()
