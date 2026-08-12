// tests/unit/util-test.typ — 辅助函数单元测试
// 编译：typst compile tests/unit/util-test.typ --root .
// 若有断言失败，编译以非零退出码终止

#import "../../format/utils/util.typ": resolve-path

#assert.eq(resolve-path(path("assets/logo.svg")), path("assets/logo.svg"))
#assert.eq(resolve-path("ref.bib"), "../ref.bib")

= All tests passed
