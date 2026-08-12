// tests/thesis-linux.typ — Linux 字体方案集成测试

#import "../../format/lib.typ": config

#let cfg = config(
  author-zh: "测试",
  title-zh: "Linux 字体方案测试",
  system: "linux",
)

#show: cfg.setup
#(cfg.cover)()
