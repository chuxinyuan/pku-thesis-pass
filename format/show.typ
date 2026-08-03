// ============================================================
// show.typ — 跨元素 show 规则
// 被 page.typ 的 page-setup 通过 #show figure / #show ref 等引用
// 职责：图/表/代码块的展示布局、交叉引用链接生成
// ============================================================

#import "style.typ": size
#import "utils.typ": chinesenumbering, chaptercounter, equationcounter, imagecounter, tablecounter, rawcounter

/// 图、表、代码块的 show 规则
/// 图片：caption 在下方；表格：caption 在上方；代码块：caption 在上方
/// supplements: 引用记号字典，用于生成"图 1.1"等标签
#let _figure-show-rule(it, supplements) = {
  set align(center)
  if it.kind == image {
    it.body
    [
      #set text(size: size.图题)
      #it.caption
    ]
  } else if it.kind == table {
    [
      #set text(size: size.表题)
      #it.caption
    ]
    it.body
  } else if it.kind == "code" {
    [
      #set text(size: size.代码块标题)
      #context { supplements.代码 + it.counter.display(it.numbering) + "   " }
      #it.caption.body
    ]
    it.body
  } else {
    it.body
    [
      #set text(size: size.图题)
      #context { supplements.图表 + it.counter.display(it.numbering) + "   " }
      #it.caption.body
    ]
  }
}

/// 交叉引用 @ 标签的 show 规则
/// 根据引用目标类型（equation / figure / heading）生成中文编号链接
/// supplements: 引用记号字典，控制"图/表/式/节"等前缀
#let _ref-show-rule(it, supplements) = {
  if it.element == none { it }
  else {
    h(0em, weak: true)
    let el = it.element
    let el_loc = el.location()
    if el.func() == math.equation {
      link(el_loc, [#supplements.公式 #chinesenumbering(chaptercounter.at(el_loc).first(), equationcounter.at(el_loc).first(), location: el_loc, brackets: true)])
      h(0.25em, weak: true)
    } else if el.func() == figure {
      if el.kind == image {
        link(el_loc, [#supplements.图 #chinesenumbering(chaptercounter.at(el_loc).first(), imagecounter.at(el_loc).first(), location: el_loc)])
      } else if el.kind == table {
        link(el_loc, [#supplements.表 #chinesenumbering(chaptercounter.at(el_loc).first(), tablecounter.at(el_loc).first(), location: el_loc)])
      } else if el.kind == "code" {
        link(el_loc, [#supplements.代码 #chinesenumbering(chaptercounter.at(el_loc).first(), rawcounter.at(el_loc).first(), location: el_loc)])
      } else {
        // 未知 figure kind 的 fallback：前缀用 supplements.图表，编号取该 kind 的
        // 子计数器（未随章节重置而跨章累计，与 _figure-show-rule 的图题编号一致）
        link(el_loc, [#supplements.图表 #chinesenumbering(
          chaptercounter.at(el_loc).first(),
          counter(figure.where(kind: el.kind)).at(el_loc).first(),
          location: el_loc,
        )])
      }
    } else if el.func() == heading {
      if el.level == 1 {
        link(el_loc, chinesenumbering(..counter(heading).at(el_loc), location: el_loc))
      } else {
        link(el_loc, [#supplements.节 #chinesenumbering(..counter(heading).at(el_loc), location: el_loc)])
      }
    } else { it }
    h(0em, weak: true)
  }
}
