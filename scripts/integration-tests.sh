#!/usr/bin/env bash
set -euo pipefail

typst compile tests/integration/component-test.typ --root .
typst compile tests/integration/thesis-minimal.typ --root .
typst compile tests/integration/thesis-linux.typ --root . --input system=linux
typst compile tests/integration/thesis-full.typ --root .
typst compile tests/integration/thesis-blind.typ --root . --input blind=true

# Verify blind mode: sensitive info must NOT appear in the output PDF
echo "Verifying blind mode..."
for kw in "张三" "李四" "23000xxxxx" "Supervised by" "Si Li" "发表论文"; do
  if strings tests/integration/thesis-blind.pdf | grep -qF "$kw"; then
    echo "FAIL: Blind mode leaked '$kw'"
    exit 1
  fi
done
echo "PASS: All sensitive info hidden in blind mode"

typst compile tests/integration/thesis-heading.typ --root .
typst compile tests/integration/thesis-refs.typ --root .
