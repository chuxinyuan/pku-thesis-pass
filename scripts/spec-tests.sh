#!/usr/bin/env bash
set -euo pipefail

# 格式规范测试：以《北京大学研究生学位论文写作指南》为蓝本
#
# 白盒：编译并断言 build() 样式字典的格式值（字号/段距/页边距/页眉页脚）
# 黑盒：编译样张并用 pdfplumber 检查 PDF 实际渲染结果 + PDF 元数据

# ---------- 白盒 ----------
typst compile tests/spec/size-test.typ --root .
typst compile tests/spec/font-test.typ --root .
typst compile tests/spec/style-test.typ --root .

# ---------- 黑盒 ----------
typst compile tests/spec/spec-fixture.typ --root .
typst compile tests/spec/spec-fixture.typ tests/spec/spec-fixture-blind.pdf --root . --input blind=true
python3 scripts/spec-blackbox.py tests/spec/spec-fixture.pdf tests/spec/spec-fixture-blind.pdf
