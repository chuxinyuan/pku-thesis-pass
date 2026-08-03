// ============================================================
// components.typ — 论文组件
//   1. 三线表（booktab、as-booktab）
//   2. 代码块（codeblock）
//   3. 字数统计（word-count-cjk、total-words、total-characters）
// ============================================================

#import "@preview/wordometer:0.1.5": *
#import "style.typ": size

// ========== 三线表组件 ==========

/// 续表标记状态：表格渲染前重置，跨页续表时在表头右上显示"续表"
#let _booktab-xubiao = state("booktab-xubiao")

/// 计算表格列数：int 直接返回，array 返回长度，否则默认为 1
#let _booktab-column-count(columns) = if type(columns) == int {
  columns
} else if type(columns) == array { columns.len() } else { 1 }

/// 三线表内部构建块：block 包裹的 table
/// 固定顶线 1.5pt、表头线 0.75pt、底线 1.5pt
/// 顶线与表头线放在 table.header 内，跨页时随表头一起重复；
/// 表头前插入跨列"续表"标记行：首页隐形占位，续表页右上显示"续表"
/// footer: 可选的 table.footer 内容
#let _booktab-block(table-args, header, body, width: auto, footer: none) = block(
  width: width,
  breakable: true,
  {
    _booktab-xubiao.update(false)
    let col-count = _booktab-column-count(table-args.at("columns", default: 1))
    set text(size: size.表文)
    table(
      stroke: none,
      ..table-args,
      table.header(
        table.cell(colspan: col-count, {
          context if _booktab-xubiao.get() {
            align(right)[续表]
          } else {
            v(-0.9em)
            _booktab-xubiao.update(true)
          }
        }),
        table.hline(stroke: 1.5pt),
        ..header.children,
        table.hline(stroke: 0.75pt),
      ),
      ..body,
      ..if footer != none { (footer,) } else { () },
      table.hline(stroke: 1.5pt),
    )
  },
)

/// 创建并可选包装为 figure 的三线表
/// 第一行位置参数自动作为表头行（strong 加粗）
/// outlined: true 时包装为 figure(kind: table)，支持 caption 和 @ 引用
/// 支持所有 table 的命名参数（除 stroke 被固定为 none）
/// 示例：
///   #booktab(
///     columns: 3,
///     caption: [示例表格],
///     [列1], [列2], [列3],
///     [数据], [数据], [数据],
///   )
#let booktab(width: auto, caption: none, outlined: true, ..args) = {
  let table-args = args.named()
  let all-cells = args.pos()
  let columns = table-args.at("columns", default: 1)
  let col-count = _booktab-column-count(columns)
  if all-cells.len() < col-count {
    panic("booktab: not enough cells for header row")
  }
  let headers = all-cells.slice(0, col-count)
  let contents = all-cells.slice(col-count)
  let _ = table-args.remove("stroke", default: none)
  let the-table = _booktab-block(
    table-args,
    table.header(..headers.map(cell => table.cell[#strong(cell)])),
    contents,
    width: width,
  )
  if outlined {
    figure(the-table, caption: caption, kind: table)
  } else {
    the-table
  }
}

/// 将 table.cell 的内容用 strong 包裹（用于 as-booktab 的表头单元）
#let _booktab-header-cell(cell) = {
  if cell.func() != table.cell {
    cell
  } else {
    let cell-args = cell.fields()
    let body = cell-args.remove("body")
    table.cell(..cell-args)[#strong(body)]
  }
}

/// 不修改 table 结构，仅包裹在 block 中设置表文字号
#let _booktab-unstyled(it, width: auto) = block(
  width: width,
  breakable: true,
  {
    set text(size: size.表文)
    it
  },
)

/// 将现有原生 table 装饰为三线表样式
/// 自动识别 table.header，或取前 N 个单元格作为表头
/// 若 table 已包含 table.hline，则仅包裹不修改（保留已有样式）
/// 示例：
///   #figure(
///     as-booktab(table(
///       columns: 3,
///       [列1], [列2], [列3],
///       [数据], [数据], [数据],
///     )),
///     caption: [示例表格],
///     kind: table,
///   )
#let as-booktab(it, width: auto) = {
  if it.func() != table { panic("as-booktab: expected a table") }
  let table-args = it.fields()
  let children = table-args.remove("children")
  // 已有 hline 时仅包裹（保留手动样式）
  if children.any(child => child.func() == table.hline) {
    return _booktab-unstyled(it, width: width)
  }
  let _ = table-args.remove("stroke", default: none)
  let header = children.find(child => child.func() == table.header)
  let footer = children.find(child => child.func() == table.footer)
  if header != none {
    let body = children.filter(child => (
      child.func() != table.header and child.func() != table.footer
    ))
    return _booktab-block(
      table-args,
      table.header(..header.children.map(_booktab-header-cell)),
      body,
      width: width,
      footer: footer,
    )
  }
  // 无显式 header 时：取前列数个单元格作为表头
  let col-count = _booktab-column-count(table-args.at("columns", default: 1))
  let header-cells = ()
  let body = ()
  for child in children {
    if child.func() == table.cell and header-cells.len() < col-count {
      header-cells.push(_booktab-header-cell(child))
    } else { body.push(child) }
  }
  if header-cells.len() < col-count {
    panic("as-booktab: not enough cells for header row")
  }
  _booktab-block(table-args, table.header(..header-cells), body, width: width)
}

// ========== 代码块组件 ==========

/// 代码块组件
/// raw: 由 ``` 标记的 raw 代码块
/// caption: 代码标题（可选，有标题时可被 @label 引用）
/// 省略 caption 时仅显示代码，不编号、不入列表、不可引用
#let codeblock(raw, caption: none) = {
  if caption != none {
    figure(
      {
        set align(left)
        raw
      },
      caption: caption,
      kind: "code",
      supplement: "",
    )
  } else {
    raw
  }
}

// ========== 字数统计组件 ==========

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
