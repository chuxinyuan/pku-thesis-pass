// tests/thesis-blind.typ — 盲审集成测试
// 编译后应通过 strings 验证不包含作者/导师姓名

#import "../format/lib.typ": config

#let cfg = config(
  // 反向验证的内容
  author-zh: "张三",
  author-en: "San Zhang",
  student-id: "23000xxxxx",
  supervisor-zh: "李四",
  supervisor-en: "Si Li",

  // 正向验证的内容
  title-zh: "盲审测试",
  title-en: "Blind Test",
  first-major: "某个一级学科",
  major-zh: "某个专业",
  blind-id: "L2023XXXXX",
  degree-type: "professional",
  year: 2099,
  month: 9,

  // 控制开关验证
  blind: true,
)

#show: cfg.setup
#(cfg.cover)()
#(cfg.copyright)()

#(cfg.abstract-zh)(keywords-zh: ("测试", "模板"))[摘要正文。]

// 反向验证内容
#(cfg.abstract-en)(keywords-en: ("Test", "Template"))[Body of the abstract.]
#(cfg.achievement)[
  + *张三*, 李四, 王五. 论文题目[J]. 期刊名, 2025, 60(3): 123-130. （SCI 收录期刊；SCI 收录号 601JP；IF=9.432）
  + *Zhang, S.*, Li, S., Wang, W. Paper title[J]. Journal Name, 2024, 55(2): 45-52. （SCI 收录期刊；SCI 收录号 5W1A；IF=8.123）
]
#(cfg.acknowledgements)[感谢一切李四教授。]
#(cfg.declaration)()
