// ============================================================
// theorem.typ — 定理环境组件
// 提供编号的定理类环境（定理/定义/引理/推论/命题/性质/例/注）及证明
// ============================================================

#import "../utils/number.typ": chinesenumbering
#import "../utils/counter.typ": chaptercounter, theoremcounter, definitioncounter, lemmacounter, corollarycounter, propositioncounter, propertycounter, examplecounter, remarkcounter

/// 编号定理的标签与正文构建
/// 生成"定理 3.1（标题）"标签并置入正文
/// 不设置段落格式，首行缩进与两端对齐继承正文样式
/// theorem-counter: 对应类型的计数器（如 theoremcounter）
/// kind-label: 环境类型前缀（如 [定理]）
/// title: 可选命名标题，显示为"（标题）"
/// body: 定理陈述内容
#let _theorem-block(theorem-counter, kind-label, title, body) = {
  context [
    #strong[#kind-label #chinesenumbering(
      chaptercounter.at(here()).first(),
      theorem-counter.at(here()).first(),
      location: here(),
    )]
    #if title != none { strong[（#title）] }
    #h(0.5em)
    #body
  ]
}

/// 编号定理环境：定义、定理、引理、推论、命题、性质、注、例
/// 各类型独立编号（随章重置，附录自动切换为 "附录 A.1"），支持 @label 引用
/// title: 可选命名（如 "定理 3.1（唯一分解定理）"）
#let theorem(title: none, body) = figure(
  _theorem-block(theoremcounter, [定理], title, body),
  kind: "theorem",
  supplement: [定理],
)

/// 定义环境
#let definition(title: none, body) = figure(
  _theorem-block(definitioncounter, [定义], title, body),
  kind: "definition",
  supplement: [定义],
)

/// 引理环境
#let lemma(title: none, body) = figure(
  _theorem-block(lemmacounter, [引理], title, body),
  kind: "lemma",
  supplement: [引理],
)

/// 推论环境
#let corollary(title: none, body) = figure(
  _theorem-block(corollarycounter, [推论], title, body),
  kind: "corollary",
  supplement: [推论],
)

/// 命题环境
#let proposition(title: none, body) = figure(
  _theorem-block(propositioncounter, [命题], title, body),
  kind: "proposition",
  supplement: [命题],
)

/// 性质环境
#let property(title: none, body) = figure(
  _theorem-block(propertycounter, [性质], title, body),
  kind: "property",
  supplement: [性质],
)

/// 例子环境
#let example(title: none, body) = figure(
  _theorem-block(examplecounter, [例], title, body),
  kind: "example",
  supplement: [例],
)

/// 注环境
#let remark(title: none, body) = figure(
  _theorem-block(remarkcounter, [注], title, body),
  kind: "remark",
  supplement: [注],
)

/// 证明环境：不编号，"证明"开头，正文后接空心方框 □ 收尾
#let proof(body) = par(
  [#strong[证明] #h(0.5em) #body #h(0.5em) #text(size: 0.7em)[#sym.square]],
)
