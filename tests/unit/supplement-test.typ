// tests/supplement-test.typ — 引用记号字典单元测试

#import "../../format/utils/supplement.typ": supplement

// Verify all required keys exist
#assert.eq(supplement.图, "图")
#assert.eq(supplement.表, "表")
#assert.eq(supplement.公式, "式")
#assert.eq(supplement.代码, "代码")
#assert.eq(supplement.节, "节")
#assert.eq(supplement.图表, "图表")
#assert.eq(supplement.插图列表, "插图")
#assert.eq(supplement.表格列表, "表格")
#assert.eq(supplement.公式列表, "公式")
#assert.eq(supplement.代码列表, "代码")
#assert.eq(supplement.符号表, "主要符号对照表")
#assert.eq(supplement.成果表, "攻读学位期间发表的论文")

= All tests passed
