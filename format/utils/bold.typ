// ============================================================
// bold.typ — 统一加粗入口
// ============================================================
//
// 唯一的加粗策略实现：给定内容与「该字体是否有真粗体」标志，
// - fakebold = true  无真粗体 → 用 cuti 描边伪粗体（拉丁字符仍走真粗体）
// - fakebold = false 有真粗体 → weight: bold（交给字体匹配）
//
// 标志值通常来自 font.typ 的 fakebold-rules，经 style 字典的 fakebold
// 字段透传；拉丁字体（如 ABSTRACT 的 Arial）有真粗体，直接传 false。
// 所有加粗（正文强调、封面题目、声明标题等）都应经由此入口，
// 避免各页面各自硬编码 show-cn-fakebold。

#import "../imports.typ": show-cn-fakebold

/// 统一加粗：fakebold=true 无真粗体 → cuti 描边；false 有真粗体 → weight:bold
/// ..args 透传给 text（如 size、font）
#let bold(body, fakebold, ..args) = {
  if fakebold {
    show-cn-fakebold(text(weight: "bold", ..args, body))
  } else {
    text(weight: "bold", ..args, body)
  }
}
