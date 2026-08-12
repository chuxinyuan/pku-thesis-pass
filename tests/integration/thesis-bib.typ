// tests/integration/thesis-bib.typ — 参考文献渲染集成测试
// 引用 template/ref.bib 中的中英文文献，验证 GB/T 7714 参考文献列表实际渲染。

#import "../../format/lib.typ": config

#let cfg = config(
  author-zh: "参考文献测试",
  title-zh: "参考文献渲染集成测试",
  bib-file: path("../../template/ref.bib"),
)

#show: cfg.setup
#(cfg.cover)()

#show: cfg.body-wrap
#show: cfg.bibliography

= 参考文献

正文引用中文文献 @wang2010guide 和英文文献 @kopka2004guide。
