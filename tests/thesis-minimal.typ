// tests/thesis-minimal.typ — 最小编译集成测试

#import "../format/lib.typ": config

#let cfg = config(
  author-zh: "测试",
  title-zh: "最小编译测试",
)

#show: cfg.setup
#(cfg.cover)()
