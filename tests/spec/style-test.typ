// tests/spec/style-test.typ — 格式规范白盒测试
// 以《北京大学研究生学位论文写作指南》(2014) 为蓝本，
// 断言 build() 返回的样式字典与指南格式规范一致。
// 编译：typst compile tests/spec/style-test.typ --root .
// 若有断言失败，编译以非零退出码终止。

#import "../../format/utils/style.typ": build
#import "../../format/utils/font.typ": font-set, fakebold-rules

#let s = build(font-set.windows, fakebold: fakebold-rules.windows)

// ── 1.1 封面 ──
#assert.eq(s.封面题头.size, 36pt)  // 小初
#assert.eq(s.封面题目.size, 26pt)  // 一号
#assert.eq(s.封面题目标签.size, 22pt)  // 二号
#assert.eq(s.封面信息.size, 16pt)  // 三号（作者/导师用仿宋）
#assert.eq(s.封面日期.size, 16pt)  // 三号（日期用宋体）
#assert.eq(s.封面题目.weight, "bold")

// ── 1.3 中文摘要 ──
#assert.eq(s.摘要标题.size, 16pt)  // 三号黑体
#assert.eq(s.摘要标题.spacing-before, 24pt)
#assert.eq(s.摘要标题.spacing-after, 18pt)
#assert.eq(s.摘要内容.size, 12pt)  // 小四
#assert.eq(s.摘要内容.first-line-indent, 2em)
// 有意偏离：指南规定行距固定 20pt，实测 10.5pt 更接近 Word
#assert.eq(s.摘要内容.leading, 10.5pt)

// ── 1.4 英文摘要 ──
#assert.eq(s.英文题目.size, 16pt)  // 三号 Arial（指南：Arial 三号）
#assert.eq(s.英文题目.spacing-before, 24pt)
#assert.eq(s.英文题目.spacing-after, 18pt)
#assert.eq(s.英文作者信息.size, 12pt)  // 小四 Times New Roman
#assert.eq(s.英文摘要标题.size, 12pt)  // ABSTRACT 小四
#assert.eq(s.英文摘要标题.spacing-before, 8pt)
#assert.eq(s.英文摘要标题.spacing-after, 6pt)
// 有意偏离：指南规定行距固定 20pt，实测 12.5pt 更接近 Word
#assert.eq(s.英文摘要内容.leading, 12.5pt)

// ── 1.5 目录 ──
#assert.eq(s.目录章标题.size, 12pt)  // 小四黑体
#assert.eq(s.目录章标题.spacing-before, 6pt)
#assert.eq(s.目录其他.size, 12pt)  // 小四宋体

// ── 1.7.1 标题 ──
// 指南 2014 里的章标题：三号（16pt）黑体居中，段前 24bp 后 18bp，单倍间距
// 硕士研究生学位论文格式模板（2024）文件里章标题：三号（16pt）黑体居中，段前 17bp 后 16.5bp，2.41 倍间距
// pkuthss-typst 也采用了最新的 Word 模板（2024）标准用的是段前 17bp 后 16.5bp，2.41 倍间距
#assert.eq(s.章标题.size, 16pt)
#assert.eq(s.章标题.align, center)
#assert.eq(s.章标题.spacing-before, 17pt)
#assert.eq(s.章标题.spacing-after, 16.5pt)
#assert.eq(s.章标题.weight, "regular")
// 一级节标题：四号（14pt），段前 24 段后 6
#assert.eq(s.一级节标题.size, 14pt)
#assert.eq(s.一级节标题.spacing-before, 24pt)
#assert.eq(s.一级节标题.spacing-after, 6pt)
#assert.eq(s.一级节标题.weight, "regular")
// 二级节标题：13pt，段前 12 段后 6
#assert.eq(s.二级节标题.size, 13pt)
#assert.eq(s.二级节标题.spacing-before, 12pt)
#assert.eq(s.二级节标题.spacing-after, 6pt)
#assert.eq(s.二级节标题.weight, "regular")
// 三级节标题：小四（12pt），段前 12 段后 6
#assert.eq(s.三级节标题.size, 12pt)
#assert.eq(s.三级节标题.spacing-before, 12pt)
#assert.eq(s.三级节标题.spacing-after, 6pt)
#assert.eq(s.三级节标题.weight, "regular")

// ── 1.7.2 段落文字 ──
#assert.eq(s.正文.size, 12pt)  // 小四宋体
#assert.eq(s.正文.first-line-indent, 2em)
// 有意偏离：指南规定行距固定 20pt，实测 10.5pt 更接近 Word
#assert.eq(s.正文.leading, 10.5pt)

// ── 1.7.3 脚注 ──
#assert.eq(s.脚注.size, 9pt)  // 小五
#assert.eq(s.脚注.悬挂缩进, 1.5em)

// ── 1.7.4 图表 ──
#assert.eq(s.图序图名.size, 11pt)
#assert.eq(s.表序表名.size, 11pt)
// 指南 2014 里的表单元格字号标准是 11pt
// 硕士研究生学位论文格式模板（2024）文件里表单元格字号是五号字体，对应 10.5pt
// pkuthss-typst 也采用了最新的 Word 模板（2024）标准用的是 10.5pt
#assert.eq(s.表单元格.size, 10.5pt)

// ── 1.8 参考文献 ──
#assert.eq(s.参考文献内容.size, 10.5pt)  // 五号
#assert.eq(s.参考文献内容.悬挂缩进, 1.66em)

// ── 1.11 页面设置 ──
// 页边距：上 3.0 / 下 2.5 / 左 2.6 / 右 2.6 cm
#assert.eq(s.页边距.top, 3.0cm)
#assert.eq(s.页边距.bottom, 2.5cm)
#assert.eq(s.页边距.left, 2.6cm)
#assert.eq(s.页边距.right, 2.6cm)
// 页眉：五号宋体居中，距页顶 2cm，下划线 0.75pt
#assert.eq(s.页眉.size, 10.5pt)
#assert.eq(s.页眉.垂直位置, 2cm)
#assert.eq(s.页眉.下划线粗细, 0.75pt)
// 页码：五号（10.5pt）居中，距页底 1.75cm（指南：Times New Roman 五号）
// 硕士研究生学位论文格式模板（2024）文件里页码字号是小五（9pt）
// pkuthss-typst 也采用了最新的 Word 模板（2024）标准用的是 9pt
#assert.eq(s.页码.size, 9pt)
#assert.eq(s.页码.垂直位置, 1.75cm)

= All tests passed
