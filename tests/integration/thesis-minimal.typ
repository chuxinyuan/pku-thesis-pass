// tests/thesis-minimal.typ — 最小编译集成测试

#import "../../format/lib.typ": config

#let cfg = config()

#show: cfg.setup
#(cfg.cover)()
