// ============================================================
// config.typ — 学位论文模板总控入口
// 定义 config() 函数，返回一组闭包字典（DI 模式）
// 用户解构后自行控制论文流程
//
// 用法：
//   #let (setup, cover, abstract-zh, ..., bibliography) = config(...)
//   #show: setup
//   #cover()
//   #abstract-zh(keywords-zh: (...))[摘要内容]
//   #show: bibliography
//
// 命令行参数（--input key=value）：
//   --input blind=true|false                    盲审模式
//   --input preview=true|false                  预览模式（默认 true，链接显示蓝色，打印时请设置为 false）
//   --input always-start-odd=true|false         章节是否总是从奇数页开始
//   --input system=default|mac|windows|linux    系统字体方案
//
// 命令行参数示例：
//   typst compile thesis.typ --input blind=true
//   typst compile thesis.typ --input preview=false
//   typst compile thesis.typ --input always-start-odd=false
//   typst compile thesis.typ --input system=linux
// ============================================================

// ========== 子模块导入 ==========

// 基础定义
#import "utils/supplement.typ": supplement
#import "utils/font.typ": font-set
#import "utils/style.typ": build
#import "utils/counter.typ": skippedstate
#import "utils/number.typ": appendix
#import "utils/util.typ": _resolve-path

// 基础设施
#import "layouts/setup.typ": page-setup
#import "components/wordcount.typ": word-count-cjk, total-words, total-characters

// 页面
#import "pages/covers.typ": cover-page-blind, cover-page-normal
#import "pages/spine.typ": spine-page
#import "pages/copyright.typ": copyright-page
#import "pages/abstract-zh.typ": abstract-page-zh
#import "pages/abstract-en.typ": abstract-page-en
#import "pages/outline.typ": chineseoutline
#import "pages/listoffigures.typ": listoffigures
#import "pages/notation.typ": notation-page
#import "pages/bibliography.typ": render-bibliography
#import "pages/achievement.typ": achievement-page
#import "pages/acknowledgements.typ": acknowledgements-page
#import "pages/declaration.typ": declaration-page

// ========== 命令行参数支持 ==========

/// 字符串转布尔值："true"/"1" → true, "false"/"0" → false, 否则返回默认值。
#let _parse-bool(value, default) = {
  if value == none { default }
  else if value == "true" or value == "1" { true }
  else if value == "false" or value == "0" { false }
  else { default }
}

/// 系统字体方案状态，供内容文件字体校验时读取当前生效的方案
#let system-state = state("sys", "default")

// CLI 参数解析
// 
// 解析命令行传入的配置参数，支持覆盖默认配置，值为 none 表示未传入。
// 每个 _cli-* 对应一个 --input 参数，值为 none 表示未传入
// 用法示例：typst compile --input blind=true --input system=windows

/// --input blind=true|false
#let _cli-blind = _parse-bool(sys.inputs.at("blind", default: none), none)
/// --input preview=true|false
#let _cli-preview = _parse-bool(sys.inputs.at("preview", default: none), none)
/// --input always-start-odd=true|false
#let _cli-always-start-odd = _parse-bool(sys.inputs.at("always-start-odd", default: none), none)
/// --input system=default|mac|windows|linux
#let _cli-system = sys.inputs.at("system", default: none)

// ========== 参数化配置入口 ==========

/// 论文主配置函数，返回闭包字典（DI 模式）
/// 返回 `(setup, cover, ...)` 字典，用户解构后自行编排顺序
///
/// 基本信息：
///   author-zh — 中文姓名
///   author-en — 英文姓名
///   student-id — 学号
///   blind-id — 盲审论文编号
///   thesis-name — 论文类型（博士/硕士学位论文）
///   header-text — 页眉统一文本
///   title-zh — 中文题目
///   title-en — 英文题目
///   school — 院系
///   first-major — 一级学科
///   major-zh — 专业中文名
///   major-en — 专业英文名
///   direction — 研究方向
///   supervisor-zh — 导师中文名
///   supervisor-en — 导师英文名
///   degree-type — "academic"(学术) / "professional"(专业)
///   year — 论文提交年份
///   month — 论文提交月份
///
/// 排版配置：
///   system — 系统字体方案："default"/"mac"/"windows"/"linux"（默认 "default"）
///   blind — 盲审模式（默认 false）
///   preview — 预览模式（链接显示蓝色，默认 true）
///   first-line-indent — 首行缩进（默认 2em）
///   always-start-odd — 章节从奇数页开始（默认 true）
///   clean-declaration — 声明页清除页眉页码（默认 false）
///   outline-depth — 目录深度（默认 3）
///   word-count — 统计正文字数（默认 true，正文任意处可用 total-words / total-characters 显示）
///   achievement-outlined — "攻读学位期间发表的论文"页是否出现在目录（默认 true）
///   supplements — 自定义引用记号
///   use-latexref — 是否启用 LaTeX 引用兼容（默认 false）
///   latexref-prefixes — LaTeX 引用剥离前缀列表（默认 ("fig:", "tbl:", "eqt:", "lst:", "img:", "alg:")）
///   codly-args — 控制代码块行号、背景色、语言图标等
///   logo — 封面校徽图片路径，`path` 类型（如 `path("assets/logo.svg")`，默认 none 显示占位框）
///   wordmark — 封面校名字标图片路径，`path` 类型（如 `path("assets/wordmark.svg")`，默认 none 显示占位框）
///
/// 参考文献：
///   override-bib — 使用 Typst 原生 bibliography（默认 false）
///   bib-file — BibTeX 文件（如：`path("path/to/xxxx.bib")`，`path` 类型）
///   bib-style — "numeric"(顺序编码) / "author-date"(著者-出版年)
///   bib-version — "2015" / "2025"
///   bib-cn-first — 中文文献优先（默认 true）
///   bib-pinyin-override — 拼音排序覆写

#let config(
  // ========== 基本信息 ==========
  author-zh: "张三",
  author-en: "San Zhang",
  student-id: "23000xxxxx",
  blind-id: "L2023XXXXX",
  thesis-name: "博士研究生学位论文",
  header-text: "北京大学博士学位论文",
  // 可以用 \n 控制中英文标题在非盲审封面 (blind=false) 中的换行点
  // 在盲审封面 (blind=true) 中，手工插入的 \n 会被忽略，以确保标题连续
  title-zh: "北京大学学位论文 Typst 模板",
  title-en: "Typst Template for Peking University Thesis",
  school: "某个院系",
  first-major: "某个一级学科",
  major-zh: "某个专业",
  major-en: "Some Major",
  direction: "某个研究方向",
  supervisor-zh: "李四",
  supervisor-en: "Si Li",
  // 学位类型："academic"（学术学位）或 "professional"（专业学位）
  degree-type: "academic", // "academic" 或 "professional"
  year: 2026,
  month: 6,
  // ========== 排版配置 ==========
  system: "default",       // "default" / "mac" / "windows" / "linux"
  blind: false,            // 盲审模式
  // 预览模式下会将链接文本显示为蓝色
  // 在生成打印版时，可以设置为 false
  // 可通过命令行 --input preview=false 覆盖
  preview: true,
  // 这里设置为 2em 是为了更加美观
  // Word 模板中中文正文的首行缩进固定为 1.77em
  // 如果要求严格对应，请将 first-line-indent 设置为 1.77em
  first-line-indent: 2em,  // 首行缩进
  always-start-odd: true,  // 章节从奇数页开始
  // 是否清除原创性声明页的页眉和页码
  // 如果想要去除原创性声明页的页眉和页码，可以设置为 true
  // Word 模板中包含原创性声明页的页眉和页码，所以这里默认为 false
  clean-declaration: false,
  outline-depth: 3,       // 目录深度
  // 引用记号自定义（图、表、代码、公式、节）
  // 示例：supplements: (图: "Figure", 表: "Table")
  supplements: (:),
  // LaTeX 引用兼容：@fig:xxx 等带前缀引用解析失败时，剥离前缀重试 @xxx
  // 用于从 LaTeX 迁移的文档（LaTeX 习惯写 \ref{fig:xxx}）。默认关闭
  use-latexref: false,
  // use-latexref 时尝试剥离的前缀列表
  latexref-prefixes: ("fig:", "tbl:", "eqt:", "lst:", "img:", "alg:"),
  // "攻读学位期间发表的论文"页是否出现在目录中（与致谢、声明一致，默认 true）
  achievement-outlined: true,
  // 统计正文字数（CJK 字数 / 总字符数），可用 total-words / total-characters 显示，如不需要可设为 false
  word-count: true,
  // 代码块参数：行号、语言图标、斑马条纹等
  codly-args: (
    display-icon: true,      // 语言图标
    // number-format: none,  // 代码行号
    // lang-format: none,    // 语言名称
    // zebra-fill: none,     // 斑马条纹
  ),
  // 封面校徽、字标图片文件路径，参数值为 none 时封面显示灰色占位框
  // 示例：logo: path("assets/logo.svg"), wordmark: path("assets/wordmark.svg")
  logo: none,
  wordmark: none,
  // ========== 参考文献 ==========
  // 完全自定义参考文献样式，忽略以下参数
  override-bib: false,    // 自定义引用样式时设为 true
  bib-file: none,
  bib-style: "numeric",   // 引用风格："numeric" 或 "author-date"
  // 引用版本（默认为 "2015"，可选 "2025"。注意： GB/T 7714-2025 标准从 2026 年 7 月 1 日开始实施）
  bib-version: "2015",    // "2015" 或 "2025"
  // 仅 bib-style: "author-date"。true（默认）时中文条目排在外文之前；false 时外文在前（传给 gb7714-bilingual 的 cn-first）
  bib-cn-first: true,
  // 仅 author-date 且中文作者：多音字校正，传给 auto-pinyin 的 to-pinyin(..., override: ...)
  // 键为汉字（字符串），值为 tone-num-end 音节串，如 ("重": "chong2")
  bib-pinyin-override: (:),
) = {
  // 命令行参数覆盖
  let blind = if _cli-blind != none { _cli-blind } else { blind }
  let preview = if _cli-preview != none { _cli-preview } else { preview }
  let always-start-odd = if _cli-always-start-odd != none { _cli-always-start-odd } else { always-start-odd }

  // 解析系统字体方案：CLI 参数优先，否则用 config() 参数
  let resolved-system = if _cli-system != none { _cli-system } else { system }
  let font = font-set.at(resolved-system, default: font-set.default)
  let style = build(font)

  // 读取参考文献文件；路径应使用 path 类型（在调用处解析，可穿透包沙箱），
  // 字符串路径则按本地模式处理（相对项目根目录）
  let _bib-content = if bib-file != none {
    read(_resolve-path(bib-file))
  }

  // 合并用户自定义引用记号
  let merged-supplements = supplement
  for (key, value) in supplements {
    merged-supplements.insert(key, value)
  }

  // 智能分页：always-start-odd: true 时章节从奇数页开始
  let smartpagebreak = () => {
    if always-start-odd {
      skippedstate.update(false)
      pagebreak(weak: true)
      skippedstate.update(true)
      pagebreak(to: "odd", weak: true)
      skippedstate.update(false)
    } else {
      pagebreak(weak: true)
    }
  }

  // ========== 页面基础设置 ==========
  let setup = (body) => {
    system-state.update(resolved-system)
    page-setup(
      style: style,
      font: font,
      header-text: header-text,
      preview: preview,
      first-line-indent: first-line-indent,
      smartpagebreak: smartpagebreak,
      merged-supplements: merged-supplements,
      codly-args: codly-args,
      use-latexref: use-latexref,
      latexref-prefixes: latexref-prefixes,
      // PDF 元数据：盲审时隐藏作者，避免在文件属性中泄露
      // 文档日期（CreationDate）由 Typst 原生写入编译时间，无需在此设置
      document-title: title-zh,
      document-author: if blind { none } else { author-zh },
      body: body,
    )
  }

  // ========== 论文封面 ==========
  // front-heading 以外的自定义页面，闭包内含换页
  let cover = () => {
    if blind {
      cover-page-blind(
        font: font,
        header-text: header-text,
        title-zh: title-zh,
        title-en: title-en,
        first-major: first-major,
        major-zh: major-zh,
        blind-id: blind-id,
        year: year,
        month: month,
        degree-type: degree-type,
      )
    } else {
      cover-page-normal(
        font: font,
        thesis-name: thesis-name,
        title-zh: title-zh,
        author-zh: author-zh,
        student-id: student-id,
        school: school,
        major-zh: major-zh,
        direction: direction,
        supervisor-zh: supervisor-zh,
        degree-type: degree-type,
        year: year,
        month: month,
        logo: logo,
        wordmark: wordmark,
      )
    }
    smartpagebreak()
  }

  // ========== 书脊页 ==========
  // 打印装订用，非规范强制要求；默认不启用，需在 thesis.typ 显式调用
  let spine = () => {
    spine-page(
      title: title-zh,
      author: author-zh,
      font: font,
      blind: blind,
    )
    smartpagebreak()
  }

  // ========== 版权声明 ==========
  let copyright = () => {
    copyright-page()
    smartpagebreak()
  }

  // ========== 中文摘要 ==========
  let abstract-zh = (body, keywords-zh: ()) => {
    set align(left + top)
    abstract-page-zh(
      style: style,
      keywords-zh: keywords-zh,
      first-line-indent: first-line-indent,
    )[#body]
  }

  // ========== 英文摘要 ==========
  let abstract-en = (body, keywords-en: ()) => {
    set align(left + top)
    abstract-page-en(
      style: style,
      title-en: title-en,
      author-en: author-en,
      major-en: major-en,
      supervisor-en: supervisor-en,
      keywords-en: keywords-en,
      blind: blind,
    )[#body]
  }

  // ========== 论文目录 ==========
  let outline = () => {
    chineseoutline(
      title: "目录",
      depth: outline-depth,
      indent: true
    )
  }

  // ========== 插图列表 ==========
  let list-of-figures = () => {
    listoffigures(
      title: merged-supplements.插图列表,
      kind: image,
      supplements: merged-supplements,
    )
  }

  // ========== 表格列表 ==========
  let list-of-tables = () => {
    listoffigures(
      title: merged-supplements.表格列表,
      kind: table,
      supplements: merged-supplements,
    )
  }

  // ========== 公式列表 ==========
  let list-of-equations = () => {
    listoffigures(
      title: merged-supplements.公式列表,
      kind: "equation",
      supplements: merged-supplements,
    )
  }

  // ========== 代码列表 ==========
  let list-of-code = () => {
    listoffigures(
      title: merged-supplements.代码列表,
      kind: "code",
      supplements: merged-supplements,
    )
  }

  // ========== 主要符号对照表 ==========
  let notation = (body) => {
    notation-page(
      title: merged-supplements.符号表,
    )[#body]
  }

  // ========== 正文段落样式 ==========
  let body-wrap = (body) => {
    set align(left + top)
    set par(
      justify: true,
      first-line-indent: (amount: first-line-indent, all: true),
      leading: 10.5pt,
      spacing: 10.5pt,
    )
    // 字数统计：统计正文与附录（show 规则必须与 body 处于同一作用域才生效）
    if word-count {
      show: word-count-cjk
      body
    } else {
      body
    }
  }

  // ========== 参考文献 ==========
  let bibliography = (body) => {
    render-bibliography(
      bib-content: _bib-content,
      bib-style: bib-style,
      bib-version: bib-version,
      bib-cn-first: bib-cn-first,
      bib-pinyin-override: bib-pinyin-override,
      override-bib: override-bib,
      body,
    )
  }

  // ========== 攻读学位期间发表的论文 ==========
  let achievement = (body) => {
    if blind {
      return
    }
    set align(left + top)
    achievement-page(
      title: merged-supplements.成果表,
      outlined: achievement-outlined,
    )[#body]
  }

  // ========== 致谢部分 ==========
  let acknowledgements = (body) => {
    if blind {
      return
    }
    set align(left + top)
    acknowledgements-page(
      first-line-indent: first-line-indent,
    )[#body]
  }

  // ========== 原创声明 ==========
  let declaration = () => {
    if blind {
      return
    }
    declaration-page(clean-declaration: clean-declaration)
  }

  // ========== 返回字典 ==========
  (
    setup: setup,
    cover: cover,
    spine: spine,
    copyright: copyright,
    abstract-zh: abstract-zh,
    abstract-en: abstract-en,
    outline: outline,
    list-of-figures: list-of-figures,
    list-of-tables: list-of-tables,
    list-of-equations: list-of-equations,
    list-of-code: list-of-code,
    notation: notation,
    body-wrap: body-wrap,
    bibliography: bibliography,
    appendix: appendix,
    achievement: achievement,
    acknowledgements: acknowledgements,
    declaration: declaration,
    font: font,
    style: style,
    system: resolved-system,
    blind: blind,
    preview: preview,
    always-start-odd: always-start-odd,
    first-line-indent: first-line-indent,
    achievement-outlined: achievement-outlined,
    smartpagebreak: smartpagebreak,
    total-words: total-words,
    total-characters: total-characters,
  )
}
