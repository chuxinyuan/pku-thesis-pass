// ============================================================
// style.typ — 北大格式规范（《研究生学位论文写作指南》2014）
// ============================================================
//
// build(font) 返回各元素的字体/字号/间距样式字典，作为全模板的单一事实来源。
// font 为 config() 解析出的当前系统字体方案（font-set.default/mac/windows/linux），
// 调用方通过 style.正文.font 可直接拿到字体数组，用于 set text() 等。
//
// 条目按指南章节号组织，注释中的字号（三号、小四等）对应 size.typ。
// 如需按 Word 模板做视觉校准，调整 size.typ 中对应字号的 pt 值即可全局生效。

#import "size.typ": size
#import "font.typ": font-set

#let build(font) = (
  // ── 1.1 封面 ──
  // "博士研究生学位论文"：小初（36pt）黑体
  封面题头: (font: font.黑体, size: size.小初),
  // "题目：" 前缀标签：二号（22pt）宋体
  封面题目标签: (font: font.宋体, size: size.二号),
  // 题目：一号（26pt）黑体居中加粗
  封面题目: (font: font.黑体, size: size.一号, weight: "bold"),
  // 字段标签（"姓  名："等）：黑体，与仿宋值形成对比
  封面字段标签: (font: font.黑体, size: size.三号),
  // 作者/导师/院系：三号（16pt）仿宋
  封面信息: (font: font.仿宋, size: size.三号),
  // 日期：三号（16pt）宋体
  封面日期: (font: font.宋体, size: size.三号),
  // 日期后缀（"年"、"月"）：黑体
  封面日期标点: (font: font.黑体, size: size.三号),
  // 校徽/字标占位框文字字号
  封面占位符: (字号: 0.6em),
  // 盲审封面正文段落
  封面盲审: (leading: 1em, spacing: 1.5em),

  // ── 1.3 中文摘要 ──
  // 标题：三号（16pt）黑体加粗，段前 24bp 后 18bp
  摘要标题: (font: font.黑体, size: size.三号, spacing-before: 24pt, spacing-after: 18pt, weight: "bold"),
  // 内容：小四（12pt）宋体。PKU 指南规定行距固定 20bp，实测 10.5pt 更接近 Word
  摘要内容: (font: font.宋体, size: size.小四, first-line-indent: 2em, leading: 10.5pt, spacing: 10.5pt),
  // 关键词：小四（12pt）宋体
  关键词: (font: font.宋体, size: size.小四),

  // ── 1.4 英文摘要 ──
  // 英文题目：三号（16pt），段前 24bp 后 18bp
  英文题目: (font: font.英文无衬线, size: size.三号, spacing-before: 24pt, spacing-after: 18pt, linespacing: 2em, weight: "regular"),
  // 作者/专业/导师：小四（12pt）居中
  英文作者信息: (font: font.英文衬线, size: size.小四, leading: 20pt),
  // "ABSTRACT"：小四（12pt）加粗，段前 8bp 后 6bp
  英文摘要标题: (font: font.英文无衬线, size: size.小四, spacing-before: 8pt, spacing-after: 6pt, weight: "bold"),
  // 内容：小四（12pt），首行缩进 0.74cm。PKU 指南规定 20bp，实测 12.5pt 更接近 Word
  英文摘要内容: (font: font.英文衬线, size: size.小四, first-line-indent: 0.74cm, leading: 12.5pt),

  // ── 1.5 目录 ──
  // 章标题行：小四（12pt）黑体加粗，段前 6bp
  目录章标题: (font: font.黑体, size: size.小四, spacing-before: 6pt, weight: "bold"),
  // 节标题等：小四（12pt）宋体，实测 10.5pt 更接近 Word
  目录其他: (font: font.宋体, size: size.小四, leading: 10.5pt),

  // ── 1.6 主要符号对照表 ──
  符号表: (row-gutter: 10pt, group-gutter: 20pt),

  // ── 1.7 正文 ──
  // ── 1.7.1 标题 ──
  // 章标题：三号（16pt）黑体居中加粗
  章标题: (font: font.黑体, size: size.三号, align: center, weight: "bold"),
  // 一级节标题：四号（14pt）黑体居左加粗
  一级节标题: (font: font.黑体, size: size.四号, weight: "bold"),
  // 二级节标题：13pt 黑体居左加粗（指南直接指定，非传统字号名）
  二级节标题: (font: font.黑体, size: 13pt, weight: "bold"),
  // 三级节标题：小四（12pt）黑体居左加粗
  三级节标题: (font: font.黑体, size: size.小四, weight: "bold"),

  // ── 1.7.2 段落文字 ──
  // 正文：小四（12pt）宋体。PKU 指南规定行距固定 20bp，实测 10.5pt 更接近 Word
  正文: (font: font.宋体, size: size.小四, first-line-indent: 2em, leading: 10.5pt, spacing: 10.5pt),

  // ── 1.7.3 脚注 ──
  // 脚注：小五（9pt）宋体，单倍行距，悬挂缩进
  脚注: (font: font.宋体, size: size.小五, leading: 1.2em, super-size: 0.65em),

  // ── 1.7.4 图表 ──
  // 图序图名：11pt 宋体居中（指南直接指定，非传统字号名）
  图序图名: (font: font.宋体, size: 11pt),
  // 表序表名：11pt 宋体居中
  表序表名: (font: font.宋体, size: 11pt),
  // 表单元格：11pt 宋体（指南里写明是 11pt，但是 Word 模板是五号字体，对应 10.5pt）
  表单元格: (font: font.宋体, size: 11pt),
  // 代码块标题：11pt 宋体
  代码块标题: (font: font.宋体, size: 11pt),

  // ── 1.7 其他 ──
  // 无序列表符号尺寸（圆/方/菱）
  列表: (符号尺寸: 6pt),
  // 定理证明结束标记（□）字号
  证明: (标记字号: 0.7em),
  // 版权声明标题行距倍数
  版权声明: (linespacing-multiplier: 2),

  // ── 1.8 参考文献 ──
  // 内容：五号（10.5pt）宋体，行距 ~16bp，段前 3bp
  参考文献内容: (font: font.宋体, size: size.五号, leading: 6.5pt, para-spacing: 6.5pt + 3pt),

  // ── 1.9 附录与后置部分 ──
  // 致谢/后记/说明：格式同正文
  致谢: (font: font.宋体, size: size.小四, leading: 10.5pt, spacing: 10.5pt),
  // 原创性声明与授权说明：固定法律文书，标题加粗
  声明: (font: font.宋体, size: size.小四, leading: 0.95em, spacing: 0.95em, weight: "bold"),
  // 攻读学位期间发表的论文列表
  成果列表: (font: font.宋体, size: size.小四, spacing: 1.14em),
  // 书脊页：仿宋 12pt，左右窄边距
  书脊: (font: font.仿宋, size: 12pt, margin: (x: 1cm, y: 5.4cm)),

  // ── 1.11 页面设置 ──
  // A4 纸，左侧装订
  页边距: (top: 3.0cm, bottom: 2.5cm, left: 2.6cm, right: 2.6cm),
  // 页眉：五号（10.5pt）宋体居中，距页顶 2cm
  页眉: (font: font.宋体, size: size.五号, 堆叠间距: 3pt, 垂直位置: 2cm),
  // 页码：五号（10.5pt）居中，距页底 1.75cm（旧版本误写为 9pt）
  页码: (font: font.英文衬线, size: size.五号, 垂直位置: 1.75cm),
)

/// 默认样式（基于 font-set.default），供以下场景使用：
/// 1. booktab.typ 等用户组件的模块级回退
/// 2. 所有页面函数的 style 参数默认值（参数为 none 时回退到此）
#let style = build(font-set.default)
