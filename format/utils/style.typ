// ============================================================
// style.typ — 北大格式规范（《研究生学位论文写作指南》2014）
// ============================================================
//
// 各元素字体/字号/间距对照北大官方要求，作为模板配置的单一事实来源。
// 条目命名与指南章节号对应，以便查证。

#let style = (
  // ---- 1.1 封面 ----
  封面题目: (font: "黑体", size: 26pt, align: center),       // 一号黑体居中
  封面信息: (font: "仿宋", size: 16pt),                      // 三号仿宋（作者、导师等）
  封面日期: (font: "宋体", size: 16pt),                      // 三号宋体汉字

  // ---- 1.3 中文摘要 ----
  摘要标题: (font: "黑体", size: 16pt, align: center, spacing-before: 24pt, spacing-after: 18pt),
  摘要内容: (font: "宋体", size: 12pt, align: justify, first-line-indent: 2em, leading: 20pt),
  关键词: (font: "宋体", size: 12pt),

  // ---- 1.4 英文摘要 ----
  英文题目: (font: "Arial", size: 16pt, align: center, spacing-before: 24pt, spacing-after: 18pt),
  英文作者信息: (font: "Times New Roman", size: 12pt, align: center, leading: 20pt),
  英文摘要标题: (font: "Arial", size: 12pt, align: center, spacing-before: 8pt, spacing-after: 6pt),
  英文摘要内容: (font: "Times New Roman", size: 12pt, align: justify, leading: 20pt),

  // ---- 1.5 目录 ----
  目录章标题: (font: "黑体", size: 12pt, leading: 20pt, spacing-before: 6pt, spacing-after: 0pt),
  目录其他: (font: "宋体", size: 12pt, leading: 20pt),

  // ---- 1.7.1 标题 ----
  章标题: (font: "黑体", size: 16pt, align: center, spacing-before: 24pt, spacing-after: 18pt),
  一级节标题: (font: "黑体", size: 14pt, align: left, leading: 20pt, spacing-before: 24pt, spacing-after: 6pt),
  二级节标题: (font: "黑体", size: 13pt, align: left, leading: 20pt, spacing-before: 12pt, spacing-after: 6pt),
  三级节标题: (font: "黑体", size: 12pt, align: left, leading: 20pt, spacing-before: 12pt, spacing-after: 6pt),

  // ---- 1.7.2 段落文字 ----
  正文: (font: "宋体", size: 12pt, align: justify, first-line-indent: 2em, leading: 20pt),

  // ---- 1.7.3 脚注 ----
  脚注: (font: "宋体", size: 9pt, align: justify, leading: auto),

  // ---- 1.7.4 图表 ----
  图序图名: (font: "宋体", size: 11pt, align: center, spacing-before: 6pt, spacing-after: 12pt),
  表序表名: (font: "宋体", size: 11pt, align: center, spacing-before: 12pt, spacing-after: 6pt),
  表单元格: (font: "宋体", size: 11pt),

  // ---- 1.8 参考文献 ----
  参考文献内容: (font: "宋体", size: 10.5pt, leading: 16pt, spacing-before: 3pt, spacing-after: 0pt),

  // ---- 1.11 页面设置 ----
  页边距: (top: 3.0cm, bottom: 2.5cm, left: 2.6cm, right: 2.6cm),
  页眉: (font: "宋体", size: 10.5pt, align: center),
  页码: (font: "Times New Roman", size: 10.5pt, align: center),
)
