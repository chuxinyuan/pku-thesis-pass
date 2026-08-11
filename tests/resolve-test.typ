// tests/resolve-test.typ — 解析函数单元测试

#import "../format/config/resolve.typ": resolve-supplements

// Test supplement merging
#let merged = resolve-supplements((:))
#assert.eq(merged.图, "图")
#assert.eq(merged.表, "表")
#assert.eq(merged.公式, "式")
#assert.eq(merged.代码, "代码")

// Test custom supplement override
#let custom = resolve-supplements((图: "Figure", 成果表: "Papers"))
#assert.eq(custom.图, "Figure")
#assert.eq(custom.成果表, "Papers")
#assert.eq(custom.表, "表")  // unchanged

= All tests passed
