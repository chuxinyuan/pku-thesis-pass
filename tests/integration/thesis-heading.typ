// tests/thesis-heading.typ — 标题渲染集成测试

#import "../../format/lib.typ": config

#let cfg = config(
  author-zh: "标题测试",
  title-zh: "标题渲染集成测试",
)

#show: cfg.setup
#(cfg.cover)()
#(cfg.copyright)()

= 绪论
== 背景
正文内容。

= 方法
正文内容。
