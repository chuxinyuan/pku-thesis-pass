// tests/thesis-full.typ — 全参数编译集成测试

#import "../format/lib.typ": config

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
  system: "default",
  supplements: (成果表: "发表论文"),
)

#show: cfg.setup
#(cfg.cover)()
#(cfg.copyright)()

#(cfg.abstract-zh)(keywords-zh: ("测试", "模板"))[这是中文摘要正文，用于验证完整配置下的编译流程。]

#(cfg.outline)()
