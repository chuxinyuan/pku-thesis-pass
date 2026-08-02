// ============================================================
// 北京大学学位论文 Typst 模板使用指南
// 渲染文档：typst compile docs/guide.typ --root .
//
// 命令行参数（--input key=value）：
//   --input blind=true|false                    盲审模式
//   --input preview=true|false                  预览模式（默认 true，链接显示蓝色，打印时请设置为 false）
//   --input always-start-odd=true|false         章节是否总是从奇数页开始
//   --input system=default|mac|windows|linux    系统字体方案
// ============================================================

#import "../format/lib.typ": config

#let (
  setup,
  cover,
  copyright,
  abstract-zh,
  abstract-en,
  outline,
  list-of-figures,
  list-of-tables,
  list-of-code,
  body-wrap,
  bibliography,
  appendix,
  acknowledgements,
  declaration,
  font,
  blind,
) = config(
  // ========== 基本信息 ==========
  author-zh: "张三",
  author-en: "San Zhang",
  student-id: "23000xxxxx",
  blind-id: "L2023XXXXX",
  thesis-name: "博士研究生学位论文",
  header-text: "北京大学博士学位论文",
  title-zh: "北京大学学位论文 \nTypst 模板使用指南",
  title-en: "User Guide for PKU Dissertation\nTypst Template",
  school: "信息科学技术学院",
  first-major: "计算机科学与技术",
  major-zh: "计算机软件与理论",
  major-en: "Computer Software and Theory",
  direction: "程序设计语言与编译技术",
  supervisor-zh: "李四 教授",
  supervisor-en: "Prof. Si Li",
  degree-type: "academic",
  year: 2026,
  month: 6,

  // ========== 样式参数 ==========
  system: "default",
  blind: false,
  preview: true,
  first-line-indent: 2em,
  always-start-odd: false,
  clean-declaration: true,
  outline-depth: 3,
  supplements: (:),
  codly-args: (:),
  // 1.封面校徽和字标：因版权原因，参数默认值为 none，封面显示灰色占位框
  // 2.官方校徽和字标 pdf 文件建议从 CTAN 的 pkuthss 包获取：
  //  https://ctan.org/pkg/pkuthss
  // 3.请您将相关文件放在项目根目录的 `assets` 路径下，设置 `path` 指向该文件即可，例如：
  //   logo: path("assets/pkulogo.pdf"),
  //   wordmark: path("assets/pkuword.pdf"),
  logo: path("assets/placeholder-logo.svg"),
  wordmark: path("assets/placeholder-wordmark.svg"),

  // ========== 参考文献 ==========
  bib-file: path("ref.bib"),
  bib-style: "numeric",
  bib-version: "2025",
)

// ========== 页面设置 ==========
#show: setup

// ========== 论文封面 ==========
#cover()

// ========== 版权声明 ==========
#copyright()

// ========== 中文摘要 ==========
#abstract-zh(
  keywords-zh: ("Typst", "学位论文", "模板", "北京大学")
)[#include "content/abstract-zh.typ"]

// ========== 英文摘要 ==========
#abstract-en(
  keywords-en: ("Typst", "Dissertation", "Template", "Peking University")
)[#include "content/abstract-en.typ"]

// ========== 论文目录 ==========
#outline()

// ========== 图片列表 ==========
#list-of-figures()

// ========== 表格列表 ==========
#list-of-tables()

// ========== 代码列表 ==========
#list-of-code()

// ========== 正文部分 ==========
#show: body-wrap
#show: bibliography

= 快速开始 <quickstart>

#include "content/ch01-quickstart.typ"

= 模板配置选项 <config-ref>

#include "content/ch02-config.typ"

= Typst 基本功能 <basics>

#include "content/ch03-basics.typ"

= 常见问题与解决方案 <faq>

#include "content/ch04-faq.typ"

= 进阶使用技巧 <advanced>

#include "content/ch05-advanced.typ"

// ========== 附录部分 ==========
#appendix()

= 关于 Typst <about>

#include "content/appendix-about.typ"

// ========== 致谢部分 ==========
#acknowledgements[#include "content/acknowledgements.typ"]

// ========== 原创声明 ==========
#declaration()
