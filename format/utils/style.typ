// ============================================================
// style.typ — 北大格式规范（《研究生学位论文写作指南》2014）
// ============================================================
//
// build(font) 返回各元素的字体/字号/间距样式字典，作为全模板的单一事实来源。
// font 为 config() 解析出的当前系统字体方案（font-set.default/mac/windows/linux），
// 调用方通过 style.正文.font 可直接拿到字体数组，用于 set text() 等。
//
// 条目命名与指南章节号对应，注释中的字号（三号、小四等）对应 size.typ。
//
// 如需按 Word 模板做视觉校准，调整 size.typ 中对应字号的 pt 值即可全局生效。

#import "size.typ": size
#import "font.typ": font-set

#let build(font) = (
  // ======== 1.1 封面 ========
  // 题目：一号（26pt）黑体居中
  封面题目: (font: font.黑体, size: size.一号, align: center),
  // 作者/导师/院系：三号（16pt）仿宋
  封面信息: (font: font.仿宋, size: size.三号),
  // 日期：三号（16pt）宋体，中文数字
  封面日期: (font: font.宋体, size: size.三号),

  // ======== 1.3 中文摘要 ========
  // 标题：三号（16pt）黑体居中，段前 24bp 后 18bp
  摘要标题: (font: font.黑体, size: size.三号, align: center, spacing-before: 24pt, spacing-after: 18pt),
  // 内容：小四（12pt）宋体，行距固定 20bp
  摘要内容: (font: font.宋体, size: size.小四, align: left, first-line-indent: 2em, leading: 20pt),
  // 关键词：小四（12pt）宋体
  关键词: (font: font.宋体, size: size.小四),

  // ======== 1.4 英文摘要 ========
  // 英文题目：三号（16pt）居中
  英文题目: (font: font.英文无衬线, size: size.三号, align: center, spacing-before: 24pt, spacing-after: 18pt),
  // 作者/专业/导师：小四（12pt）居中
  英文作者信息: (font: font.英文衬线, size: size.小四, align: center, leading: 20pt),
  // "ABSTRACT"：小四（12pt）居中，段前 8bp 后 6bp
  英文摘要标题: (font: font.英文无衬线, size: size.小四, align: center, spacing-before: 8pt, spacing-after: 6pt),
  // 内容：小四（12pt），段前 8bp 后 6bp
  // 注意：PKU 指南规定行距固定 20bp，但实际编译测试下 12.5pt 更接近 Word 模板效果
  英文摘要内容: (font: font.英文衬线, size: size.小四, align: left, leading: 12.5pt, spacing-before: 8pt, spacing-after: 6pt),

  // ======== 1.5 目录 ========
  // 章标题行：小四（12pt）黑体，行距 20bp，段前 6bp
  目录章标题: (font: font.黑体, size: size.小四, leading: 20pt, spacing-before: 6pt, spacing-after: 0pt),
  // 节标题等：小四（12pt）宋体，行距 20bp
  目录其他: (font: font.宋体, size: size.小四, leading: 20pt),

  // ======== 1.7.1 标题 ========
  // 章标题：三号（16pt）黑体居中，单倍行距，段前 24bp 后 18bp
  章标题: (font: font.黑体, size: size.三号, align: center, spacing-before: 24pt, spacing-after: 18pt),
  // 一级节标题：四号（14pt）黑体居左，行距 20bp，段前 24bp 后 6bp
  一级节标题: (font: font.黑体, size: size.四号, align: left, leading: 20pt, spacing-before: 24pt, spacing-after: 6pt),
  // 二级节标题：13pt 黑体居左
  二级节标题: (font: font.黑体, size: 13pt, align: left, leading: 20pt, spacing-before: 12pt, spacing-after: 6pt),
  // 三级节标题：小四（12pt）黑体居左
  三级节标题: (font: font.黑体, size: size.小四, align: left, leading: 20pt, spacing-before: 12pt, spacing-after: 6pt),

  // ======== 1.7.2 段落文字 ========
  // 正文：小四（12pt）宋体，行距固定 20bp，首行缩进 2 字符
  正文: (font: font.宋体, size: size.小四, align: left, first-line-indent: 2em, leading: 20pt),

  // ======== 1.7.3 脚注 ========
  // 脚注：小五（9pt）宋体
  脚注: (font: font.宋体, size: size.小五, align: left),

  // ======== 1.7.4 图表 ========
  // 图序图名：11pt 宋体居中，段前 6bp 后 12bp
  图序图名: (font: font.宋体, size: 11pt, align: center, spacing-before: 6pt, spacing-after: 12pt),
  // 表序表名：11pt 宋体居中，段前 12bp 后 6bp
  表序表名: (font: font.宋体, size: 11pt, align: center, spacing-before: 12pt, spacing-after: 6pt),
  // 表单元格：11pt 宋体（Word 标准 11pt，旧版本误写为 10.5pt）
  表单元格: (font: font.宋体, size: 11pt),
  // 代码块标题：11pt 宋体
  代码块标题: (font: font.宋体, size: 11pt),

  // ======== 1.8 参考文献 ========
  // 内容：五号（10.5pt）宋体，行距固定 16bp，段前 3bp
  参考文献内容: (font: font.宋体, size: size.五号, leading: 16pt, spacing-before: 3pt, spacing-after: 0pt),

  // ======== 1.11 页面设置 ========
  页边距: (top: 3.0cm, bottom: 2.5cm, left: 2.6cm, right: 2.6cm),
  // 页眉：五号（10.5pt）宋体居中
  页眉: (font: font.宋体, size: size.五号, align: center),
  // 页码：五号（10.5pt）居中（旧版本误写为 9pt）
  页码: (font: font.英文衬线, size: size.五号, align: center),
)

/// 默认样式（基于 font-set.default），供尚未迁移的模块使用。
/// 迁移后应改为通过函数参数接收 build(font) 的返回值。
#let style = build(font-set.default)