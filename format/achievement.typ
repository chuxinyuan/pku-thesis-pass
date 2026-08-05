// ============================================================
// achievement.typ — 攻读学位期间发表的论文（成果页）
// 提供攻读学位期间发表论文的列表页，放在附录之后、致谢之前。
// 条目使用 `+` 书写，自动编号 [1]、[2]…，格式同参考文献列表；
// 作者姓名用 `*...*` 加粗，并标注检索类型（SCI/EI）、
// SCI 收录号及期刊影响因子（IF）。
// ============================================================

#import "headings.typ": back-heading

/// 攻读学位期间发表的论文
/// title: 页面标题（默认"攻读学位期间发表的论文"）
/// outlined: 是否出现在目录中（默认 true，与致谢/声明一致）
/// body: 内容，使用 `+` 书写条目，作者姓名用 `*...*` 加粗
#let achievement-page(
  title: "攻读学位期间发表的论文",
  outlined: true,
  body,
) = {
  back-heading(title, outlined: outlined)

  set par(first-line-indent: 0em)
  set enum(
    indent: 0pt,
    numbering: "[1]",
    body-indent: 1.2em,
    spacing: 1.14em,
  )

  body
}
