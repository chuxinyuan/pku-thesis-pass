// ============================================================
// wordcount.typ — 字数统计组件
// 提供正文/附录的字数、字符数统计：word-count-cjk 与统计结果读取
// ============================================================

#import "../imports.typ": word-count-of

/// 字数统计 show 规则：排除标题，累计 CJK 字数 / 总词数 / 字符数
/// 统计结果写入三个 state，供 total-words / total-characters 读取
/// 由 config() 的 body-wrap 在 word-count: true 时应用（统计正文与附录）
#let word-count-cjk(content, ..options) = {
  let stats = word-count-of(
    content,
    exclude: (heading),
    counter: s => (
      characters: s.replace(regex("\s+"), "").clusters().len(),
      words: s.matches(regex("\b[\w'’.,\-]+\b")).len(),
      words-cjk: s.matches(regex("[\p{Han}]|[\p{Latin}'’.,\-]+")).len(),
    ),
    ..options,
  )
  state("total-words-cjk").update(prev => prev + stats.words-cjk)
  state("total-words").update(prev => prev + stats.words)
  state("total-characters").update(prev => prev + stats.characters)
  content
}

/// 正文 CJK 字数（含中文标点附近的汉字与拉丁词），显示为内容
#let total-words = context state("total-words-cjk").final()

/// 正文字符数（去空白后）
#let total-characters = context state("total-characters").final()