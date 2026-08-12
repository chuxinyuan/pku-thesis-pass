// tests/spec/spec-fixture.typ — 格式规范黑盒检查样张
// 渲染一份包含封面、各级标题、正文、脚注、图题、表题的最小文档，
// 供 scripts/spec-blackbox.py 检查 PDF 中实际渲染的字号与页面尺寸。
// 编译：typst compile tests/spec/spec-fixture.typ --root .

#import "../../format/lib.typ": config, booktab

#let cfg = config(
  author-zh: "张三",
  title-zh: "格式规范检查样张",
  title-en: "Format Spec Fixture",
  system: "windows",
)

#show: cfg.setup
#(cfg.cover)()

#show: cfg.body-wrap

= 第一章 引言

正文段落内容，用于检查小四号宋体十二磅。

== 一级节标题

正文段落内容，包含脚注测试#footnote("脚注内容，用于检查小五号九磅。")。

=== 二级节标题

#figure(rect(width: 100%, height: 1.5cm), caption: [图题标记]) <fig>

#booktab(columns: 2, caption: [表题标记], [列1], [列2], [A], [B]) <tbl>

= 第二章 结论

结论段落内容，用于检查页码五号十点五磅。
