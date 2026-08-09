// tests/thesis-refs.typ — 图表与交叉引用集成测试

#import "../format/lib.typ": config, booktab, code-block, subfigure

#let cfg = config(
  author-zh: "引用测试",
  title-zh: "图表引用集成测试",
)

#show: cfg.setup
#(cfg.cover)()

= 第一章 测试

#figure(table(columns: 2, [A], [B]), caption: [测试表格]) <fig-logo>

#booktab(
  columns: 2,
  caption: [示例数据],
  [列1], [列2],
  [A], [B],
) <tbl-data>

如 @fig-logo 所示，数据见表 @tbl-data。
#(cfg.outline)()
#(cfg.list-of-figures)()
#(cfg.list-of-tables)()
