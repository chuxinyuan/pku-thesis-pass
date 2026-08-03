// ============================================================
// utils.typ — 工具函数
// 本文件包含两部分：
//   1. 状态管理（计数器、附录切换、中文编号）
//   2. 辅助函数
// ============================================================

// ========== 计数器定义 ==========

// phasecounter 状态:
//   0 = 封面区域（无页眉页脚）
//   1 = 前置部分（罗马数字页码，有页眉）
//   2 = 正文部分（阿拉伯数字页码，有页眉）
//   3 = 附录部分（页码同正文，编号切换为 "附录 A"/"A.1"）

#let phasecounter = counter("phase")
#let chaptercounter = counter("chapter")
#let footnotecounter = counter(footnote)
#let rawcounter = counter(figure.where(kind: "code"))
#let imagecounter = counter(figure.where(kind: image))
#let tablecounter = counter(figure.where(kind: table))
#let equationcounter = counter(math.equation)

/// 跳过页状态：用于 always-start-odd 时标记被跳过的空白偶数页。
#let skippedstate = state("skipped", false)

// ========== 辅助函数 ==========

/// 附录切换函数：在正文末尾调用，进入附录模式
/// 发射 pkuthss-appendix 元数据标记（用于触发参考文献渲染）
/// 并将阶段置为 3（附录区域），重置章节和标题计数器
#let appendix() = {
  metadata("pkuthss-appendix")
  phasecounter.update(3)
  chaptercounter.update(0)
  counter(heading).update(0)
}

/// 阿拉伯数字转中文数字（如 3 → "三"）
#let chinesenumber(num) = numbering("一", num)

/// 年份转中文（如 2026 → "二〇二六"）。
#let chineseyear(year) = (
  str(year)
    .clusters()
    .map(it => ("〇", "一", "二", "三", "四", "五", "六", "七", "八", "九").at(
      int(it),
    ))
    .join("")
)

/// 判断指定位置是否处于附录区域（phase >= 3）
#let in-appendix(location) = phasecounter.at(location).first() >= 3

/// 中文章节编号格式化
/// - 正文部分（appendix == 0）：一级标题显示"第X章"，多级显示"X.X"
/// - 附录部分（appendix == 1）：一级显示"附录 A"，多级显示"A.X"
/// brackets: 是否为公式引用加括号（如"(1.1)"）
#let chinesenumbering(..nums, location: none, brackets: false) = context {
  let actual_loc = if location == none { here() } else { location }
  if not in-appendix(actual_loc) {
    if nums.pos().len() == 1 {
      "第" + chinesenumber(nums.pos().first()) + "章"
    } else {
      numbering(if brackets { "(1.1)" } else { "1.1" }, ..nums)
    }
  } else {
    if nums.pos().len() == 1 {
      "附录 " + numbering("A.1", ..nums)
    } else {
      numbering(if brackets { "(A.1)" } else { "A.1" }, ..nums)
    }
  }
}

/// 将用户传入的文件路径解析为可被 `image()` / `read()` 直接使用的路径
/// - `path` 类型：在调用处创建，可穿透包沙箱访问用户项目文件
/// - `str` 类型：按本地开发模式处理，路径相对项目根目录（函数位于 format/ 下，需回溯一层）
#let _resolve-path(p) = if type(p) == path { p } else { ("../" + p) }

/// 校验图片文件不是 eps 格式（Typst 的 `image()` 仅支持 png/jpg/gif/webp/svg/pdf）
/// 通过文件头魔数 `%!PS-Adobe` 识别 eps，避免报出晦涩的 "unknown image format"
/// 返回原路径，以便直接传给 `image()`
#let _ensure-not-eps(p) = {
  let b = read(p, encoding: none)
  assert(
    not (b.len() >= 10 and b.slice(0, 10) == bytes("%!PS-Adobe")),
    message: "图片不支持 eps 格式：Typst 仅支持 png/jpg/gif/webp/svg/pdf，请先转换为支持的格式，或者直接用 CTAN pkuthss 包里的 PDF 文件",
  )
  p
}
