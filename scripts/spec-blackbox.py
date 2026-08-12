#!/usr/bin/env python3
"""格式规范黑盒测试 — 检查编译后的 PDF 实际渲染结果是否符合北大指南。

用法:
    python3 scripts/spec-blackbox.py <fixture.pdf>

依赖:
    pdfplumber (pip install pdfplumber)

检查项（以《北京大学研究生学位论文写作指南》2014 为准）:
    1. 页面尺寸 A4 (595.276 x 841.890 pt)
    2. 封面题头 36pt（小初）/ 封面题目 26pt（一号）
    3. 章标题 16pt（三号）、一级节标题 14pt（四号）、二级节标题 13pt
    4. 正文 12pt（小四）、脚注 9pt（小五）
    5. 图题/表题 11pt
    6. 页码 10.5pt（五号，显式断言非 9pt）

说明: 字号断言为系统无关（字体 pt 值不随字体方案改变），
      故本黑盒测试在任何平台 / 任何 system 参数下均可运行。
"""

import sys

try:
    import pdfplumber
except ImportError:
    print("ERROR: pdfplumber 未安装。请执行: pip install pdfplumber")
    sys.exit(1)

A4_WIDTH = 595.276
A4_HEIGHT = 841.890
TOL = 1.0  # 字号容差 (pt)

# (标记文本, 期望字号 pt, 对应指南条目)
MARKERS = [
    ("博士研究生学位论文", 36.0, "1.1 封面题头（小初）"),
    ("格式规范检查样张", 26.0, "1.1 封面题目（一号）"),
    ("引言", 16.0, "1.7.1 章标题（三号）"),
    ("一级节标题", 14.0, "1.7.1 一级节标题（四号）"),
    ("二级节标题", 13.0, "1.7.1 二级节标题（13pt）"),
    ("正文段落内容", 12.0, "1.7.2 正文（小四）"),
    ("脚注内容", 9.0, "1.7.3 脚注（小五）"),
    ("图题标记", 11.0, "1.7.4 图题（11pt）"),
    ("表题标记", 11.0, "1.7.4 表题（11pt）"),
]

failures = []


def chars_in_reading_order(page):
    """按 (行, x) 排序字符，近似阅读顺序。"""
    return sorted(page.chars, key=lambda c: (round(c["top"], 1), c["x0"]))


def marker_rendered_at(chars, marker, expected, tol):
    """判断标记文本是否存在某一处连续出现且字号符合期望。

    标记可能在页眉（五号）与正文（目标字号）同时出现，
    因此只要存在任意一处字号符合期望即判定通过。
    """
    m = list(marker)
    n = len(m)
    for i in range(len(chars) - n + 1):
        if all(chars[i + j]["text"] == m[j] for j in range(n)):
            sizes = [round(chars[i + j]["size"], 1) for j in range(n)]
            if all(abs(s - expected) <= tol for s in sizes):
                return True
    return False


def main(pdf_path):
    with pdfplumber.open(pdf_path) as pdf:
        # 1. 页面尺寸 A4
        for i, page in enumerate(pdf.pages, start=1):
            w, h = round(page.width, 1), round(page.height, 1)
            if abs(w - A4_WIDTH) > 1.0 or abs(h - A4_HEIGHT) > 1.0:
                failures.append(
                    f"第 {i} 页尺寸 {w}x{h}pt，期望 A4 {A4_WIDTH}x{A4_HEIGHT}pt"
                )

        # 2. 全文档字符（按页顺序拼接）
        all_chars = []
        for page in pdf.pages:
            all_chars.extend(chars_in_reading_order(page))

        for marker, expected, desc in MARKERS:
            if not marker_rendered_at(all_chars, marker, expected, TOL):
                failures.append(
                    f"「{marker}」未以 {expected}pt 渲染（{desc}）"
                )

        # 3. 页码字号（五号 10.5pt，非 9pt）
        page_num_sizes = set()
        found_page_num = False
        for page in pdf.pages[1:]:
            footer = [c for c in page.chars if c["top"] > page.height - 70]
            for c in footer:
                if c["text"].isdigit() or c["text"] in "IVX":
                    found_page_num = True
                    page_num_sizes.add(round(c["size"], 1))
        if not found_page_num:
            failures.append("未在页脚区域检测到页码")
        else:
            bad = [s for s in page_num_sizes if abs(s - 10.5) > TOL]
            if bad:
                failures.append(
                    f"页码字号 {sorted(page_num_sizes)}pt，期望 10.5pt（五号，非 9pt）"
                )

    if failures:
        print("格式规范黑盒检查失败：")
        for f in failures:
            print(f"  ✗ {f}")
        sys.exit(1)

    print("格式规范黑盒检查通过：A4 页面 + 9 项字号 + 页码均符合指南")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(__doc__)
        sys.exit(2)
    main(sys.argv[1])
