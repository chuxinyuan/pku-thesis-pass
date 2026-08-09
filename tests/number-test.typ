// tests/number-test.typ — 中文编号单元测试
// 编译：typst compile tests/number-test.typ --root .
// 若有断言失败，编译以非零退出码终止

#import "../format/utils/number.typ": chinesenumber, chineseyear

#assert.eq(chinesenumber(1),    "一")
#assert.eq(chinesenumber(9),    "九")
#assert.eq(chinesenumber(10),   "十")
#assert.eq(chinesenumber(2026), "二千零二十六")

#assert.eq(chineseyear(2026),   "二〇二六")
#assert.eq(chineseyear(2000),   "二〇〇〇")

= All tests passed
