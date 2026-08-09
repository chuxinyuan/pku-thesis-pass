// tests/thesis-blind.typ — 盲审集成测试

#import "../format/lib.typ": config

#let cfg = config(
  author-zh: "张三",
  author-en: "San Zhang",
  title-zh: "盲审测试",
  blind: true,
)

#show: cfg.setup
#(cfg.cover)()
