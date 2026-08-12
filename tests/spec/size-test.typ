// tests/spec/size-test.typ — 字号表格式规范测试

#import "../../format/utils/size.typ": size

#assert.eq(size.三号, 16pt)
#assert.eq(size.四号, 14pt)
#assert.eq(size.小四, 12pt)
#assert.eq(size.五号, 10.5pt)
#assert.eq(size.小五, 9pt)

= All tests passed
