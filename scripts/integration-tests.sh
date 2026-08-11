#!/usr/bin/env bash
set -euo pipefail

typst compile tests/thesis-minimal.typ --root .
typst compile tests/thesis-linux.typ --root . --input system=linux
typst compile tests/thesis-full.typ --root .
typst compile tests/thesis-blind.typ --root . --input blind=true

# Verify blind mode: sensitive info must NOT appear in the output PDF
echo "Verifying blind mode..."
for kw in "张三" "李四" "23000xxxxx" "Supervised by" "Si Li"; do
  if strings tests/thesis-blind.pdf | grep -qF "$kw"; then
    echo "FAIL: Blind mode leaked '$kw'"
    exit 1
  fi
done
echo "PASS: All sensitive info hidden in blind mode"

typst compile tests/thesis-heading.typ --root .
typst compile tests/thesis-refs.typ --root .
typst compile tests/thesis-refs.typ --root .
