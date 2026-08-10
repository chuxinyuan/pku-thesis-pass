// tests/style-test.typ — SSOT 样式字典单元测试

#import "../format/utils/style.typ": build
#import "../format/utils/font.typ": font-set, fakebold-rules

#let s = build(font-set.windows, fakebold: fakebold-rules.windows)

// 标题字号
#assert.eq(s.章标题.size, 16pt)
#assert.eq(s.一级节标题.size, 14pt)
#assert.eq(s.二级节标题.size, 13pt)
#assert.eq(s.三级节标题.size, 12pt)

// 正文字号
#assert.eq(s.正文.size, 12pt)
#assert.eq(s.脚注.size, 9pt)

// 参考文献字号
#assert.eq(s.参考文献内容.size, 10.5pt)

// 图表字号
#assert.eq(s.图序图名.size, 11pt)
#assert.eq(s.表单元格.size, 11pt)

// 封面字号
#assert.eq(s.封面题目.size, 26pt)
#assert.eq(s.封面信息.size, 16pt)

// weight 字段存在且正确
#assert.eq(s.章标题.weight, "bold")
#assert.eq(s.一级节标题.weight, "bold")

= All tests passed
