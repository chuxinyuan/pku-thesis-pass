// tests/thesis-blind.typ — 盲审集成测试
// 编译后应通过 strings 验证不包含作者/导师姓名

#import "../format/lib.typ": config

#let cfg = config(
  author-zh: "张三",
  author-en: "San Zhang",
  supervisor-zh: "李四",
  title-zh: "盲审测试",
  blind: true,
)

#show: cfg.setup
#(cfg.cover)()
#(cfg.copyright)()
#(cfg.abstract-zh)(keywords-zh: ("测试", "模板"))[摘要内容。]

= 这是标题

正文内容。
