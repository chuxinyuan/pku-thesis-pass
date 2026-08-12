#!/usr/bin/env bash
set -euo pipefail

typst compile tests/integration/component-test.typ --root .
typst compile tests/integration/thesis-minimal.typ --root .
typst compile tests/integration/thesis-linux.typ --root . --input system=linux
typst compile tests/integration/thesis-full.typ --root .
typst compile tests/integration/thesis-blind.typ --root . --input blind=true

# Verify blind mode: sensitive info must NOT appear in the output PDF
# 注意：不能用 strings —— Typst 的 PDF 内容流是 Flate 压缩的，strings 提取不出文本，
# 会导致假阴性。用 pdftotext 解压提取后检查。
echo "Verifying blind mode..."
for kw in "张三" "李四" "23000xxxxx" "Supervised by" "Si Li" "发表论文"; do
  if pdftotext tests/integration/thesis-blind.pdf - | grep -qF "$kw"; then
    echo "FAIL: Blind mode leaked '$kw'"
    exit 1
  fi
done
echo "PASS: All sensitive info hidden in blind mode"

typst compile tests/integration/thesis-heading.typ --root .
typst compile tests/integration/thesis-refs.typ --root .
typst compile tests/integration/thesis-longtable.typ --root .
typst compile tests/integration/thesis-bib.typ --root .

# Verify longtable: cross-page continued table must render the "续表" marker
if ! pdftotext tests/integration/thesis-longtable.pdf - | grep -q "续表"; then
  echo "FAIL: longtable did not render 续表 marker"
  exit 1
fi
echo "PASS: longtable renders 续表 marker"

# Verify bibliography: GB/T 7714 entries must actually render
if ! pdftotext tests/integration/thesis-bib.pdf - | grep -q "王晓华"; then
  echo "FAIL: bibliography did not render Chinese reference entry"
  exit 1
fi
if ! pdftotext tests/integration/thesis-bib.pdf - | grep -q "KOPKA"; then
  echo "FAIL: bibliography did not render English reference entry"
  exit 1
fi
echo "PASS: bibliography renders Chinese and English entries"
