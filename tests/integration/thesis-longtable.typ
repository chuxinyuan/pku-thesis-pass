// tests/integration/thesis-longtable.typ — 长表跨页续表集成测试
// 用 60 行数据强制三线表跨页，验证 booktab / as-booktab 的续表标题与表头重复渲染。

#import "../../format/lib.typ": config, booktab, as-booktab

#let cfg = config(
  author-zh: "长表测试",
  title-zh: "长表跨页续表集成测试",
)

#show: cfg.setup
#(cfg.cover)()

#show: cfg.body-wrap

= 长表测试

正文段落，用于验证长表跨页行为。

#booktab(
  columns: 2,
  caption: [跨页长表],
  [序号], [数据],
  ..range(1, 61).map(i => (
    [#i],
    [第 #i 行数据，用于验证表格跨页。],
  )).flatten(),
)

#figure(
  as-booktab(table(
    columns: 2,
    [序号], [数据],
    ..range(1, 61).map(i => (
      [#i],
      [第 #i 行数据，用于验证 as-booktab 跨页。],
    )).flatten(),
  )),
  caption: [as-booktab 跨页长表],
  kind: table,
)
