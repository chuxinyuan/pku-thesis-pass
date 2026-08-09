// tests/util-test.typ — 辅助函数单元测试
// 编译：typst compile tests/util-test.typ --root .
// 若有断言失败，编译以非零退出码终止

#import "../format/utils/util.typ": _resolve-path

#assert.eq(_resolve-path(path("assets/logo.svg")), path("assets/logo.svg"))
#assert.eq(_resolve-path("ref.bib"), "../ref.bib")

= All tests passed
