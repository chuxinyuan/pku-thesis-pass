// tests/thesis-full.typ — 全参数编译集成测试

#import "../format/lib.typ": config, booktab, code-block, theorem, definition, lemma, corollary, proposition, property, example, remark, proof

#let cfg = config(
  author-zh: "张三",
  author-en: "San Zhang",
  student-id: "23000xxxxx",
  title-zh: "完整配置编译测试",
  title-en: "Full Config Compilation Test",
  school: "信息科学技术学院",
  first-major: "计算机科学与技术",
  major-zh: "计算机软件与理论",
  major-en: "Computer Software and Theory",
  direction: "程序设计语言",
  supervisor-zh: "李四 教授",
  supervisor-en: "Prof. Si Li",
  degree-type: "academic",
  year: 2026,
  month: 6,
  system: "windows",
  supplements: (成果表: "发表论文"),
)

#show: cfg.setup
#(cfg.cover)()
#(cfg.spine)()
#(cfg.copyright)()

#(cfg.abstract-zh)(keywords-zh: ("测试", "模板"))[这是摘要正文。]
#(cfg.abstract-en)(keywords-en: ("Test", "Template"))[This is the main body of the abstract.]

#(cfg.outline)()

#(cfg.list-of-figures)()
#(cfg.list-of-tables)()
#(cfg.list-of-equations)()
#(cfg.list-of-code)()

#(cfg.notation)[
  / $pi$: 圆周率
  / $integral$: 积分符号
  / $bold(A)$: 矩阵

  / $g$: 重力加速度
  / $lambda$: 波长
]

#show: cfg.body-wrap
#show: cfg.bibliography

= 绪论

正文段落内容，测试段落渲染和首行缩进。

#figure(table(columns: 2, [A], [B]), caption: [测试表格]) <fig-logo>

#booktab(
  columns: 2,
  caption: [测试数据表],
  [项目], [数值],
  [A], [1],
) <tbl-test>

如 @fig-logo 和 @tbl-test 所示。

#theorem[这是一个定理。]
#definition[这是一个定义。]
#lemma[这是一个引理。]
#corollary[这是一个推论。]
#proposition[这是一个命题。]
#property[这是一个性质。]
#example[这是一个例子。]
#remark[这是一个注释。]
#proof[证明内容。]

= 结论

结论正文内容。

#(cfg.appendix)()

= 这是附录

附录内容写在这里。

#(cfg.achievement)[
  + *张三*, 李四, 王五. 论文题目[J]. 期刊名, 2025, 60(3): 123-130. （SCI 收录期刊；SCI 收录号 601JP；IF=9.432）
  + *Zhang, S.*, Li, S., Wang, W. Paper title[J]. Journal Name, 2024, 55(2): 45-52. （SCI 收录期刊；SCI 收录号 5W1A；IF=8.123）
]

#(cfg.acknowledgements)[感谢一切#footnote("包括使用本模板的你。")。]
#(cfg.declaration)()
