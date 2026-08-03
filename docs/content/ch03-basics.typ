#import "../../format/utils.typ": as-booktab, booktab, codeblock

#let code-preview(code, result) = {
  booktab(
    columns: (1fr, 1fr),
    outlined: false,
    align(center)[*代码*],
    align(center)[*渲染结果*],
    code,
    result,
  )
}

本章介绍 Typst 的基本语法和功能，帮助用户快速上手。

== 内容模式与代码模式

理解 Typst 的两种基本模式是掌握其语法的关键：

*内容模式* `[...]`：用于书写文档内容，类似于 Markdown。在内容模式中，文本会直接渲染，可以使用 `*粗体*`、`_斜体_` 等标记语法。

*代码模式* `{...}`：用于编写逻辑代码，如变量定义、条件判断、循环等。代码模式中的内容不会直接渲染，而是作为程序执行。

两种模式可以相互嵌套：
- 在内容模式中使用 `#` 前缀进入代码模式：`这是文本 #calc.pow(2, 10) 继续文本`
- 在代码模式中使用 `[...]` 进入内容模式：`#let x = [这是内容]`

#code-preview(
  ```typ
  // 内容模式
  这是普通文本，*粗体*，_斜体_。

  // 在内容中嵌入代码
  计算结果：#(1 + 2 + 3)

  // 代码模式定义变量
  #let name = "张三"
  你好，#name！
  ```,
  [
    这是普通文本，*粗体*，_斜体_。

    计算结果：#(1 + 2 + 3)

    #let name = "张三"
    你好，#name！
  ],
)

== 标题与章节

Typst 中的标题使用 `=` 表示，其后跟着标题的内容。`=` 的数量对应于标题的级别。

#code-preview(
  ```typ
  == 二级标题
  === 三级标题
  ==== 四级标题

  #heading(level: 2, numbering: none, outlined: false)[无编号二级标题]
  ```,
  [
    == 二级标题
    === 三级标题
    ==== 四级标题
    #heading(level: 2, numbering: none, outlined: false)[无编号二级标题]
  ],
)

本模板对标题样式进行了定制，包括：
+ 一级标题使用"第 X 章"格式编号，附录使用"附录 A/B"格式；
+ 各级标题使用不同字号；
+ 章节前后的间距参照 Word 模板中的设置。

=== 三级标题示例

==== 四级标题示例

本模板目录的默认最大深度为 3。如需更深的目录层级，可以通过 `outline-depth` 配置项调整。

== 文本样式

=== 粗体与斜体

与 Markdown 类似，在 Typst 中使用 `*...*` 表示粗体，使用 `_..._` 表示斜体：

#code-preview(
  ```typ
  *bold* and _italic_ are simple.
  ```,
  [*bold* and _italic_ are simple.],
)

本模板遵循 PKUTHSS 的惯例：使用黑体表示粗体，楷体表示斜体。中文粗体通过 `#strong[...]` 实现。

#code-preview(
  ```typ
  这是*粗体*文字。
  这是#strong[粗体]文字，无额外空白。
  ```,
  [
    这是*粗体*文字。
    这是#strong[粗体]文字，无额外空白。
  ],
)

=== 脚注

Typst 原生支持脚注功能。本模板中，每一章节的脚注编号从 ① 开始重新计数：

#code-preview(
  ```typ
  Typst 支持添加脚注#footnote[这是一个脚注。]。
  ```,
  [Typst 支持添加脚注#footnote[这是一个脚注。]。],
)

=== 列表

Typst 支持无序列表和有序列表：

#code-preview(
  ```typ
  无序列表：
  - 第一项
  - 第二项
    - 嵌套项

  有序列表：
  + 第一步
  + 第二步
  + 第三步
  ```,
  [
    无序列表：
    - 第一项
    - 第二项
      - 嵌套项

    有序列表：
    + 第一步
    + 第二步
    + 第三步
  ],
)

== 图片

在 Typst 中插入图片使用 `image` 函数。如果需要给图片增加标题或在文章中引用，需要将其放置在 `figure` 中：

#code-preview(
  ```typ
  #figure(
    image("../assets/placeholder-logo.svg", width: 30%),
    caption: "校徽占位图",
  ) <logo>
  ```,
  [
    #figure(
      image("../assets/placeholder-logo.svg", width: 30%),
      caption: "校徽占位图",
    ) <logo>
  ],
)

@logo 展示了校徽占位图。出于版权考虑，这里*不包含*北京大学官方校徽和字标，需通过 `config()` 的 `logo` / `wordmark` 参数自行导入真实校徽和字标（见 @config-ref）。代码中的 `<logo>` 是标签，可以在文中通过 `@logo` 来引用。

== 表格

Typst 中定义表格使用 `table` 函数。如需标题和引用功能，同样需要将其放置在 `figure` 中。

本模板提供了 `booktab` 函数用于生成更美观的三线表。`booktab` 基于原生 `table` 实现，支持大部分 `table` 参数（`stroke` 除外），第一行自动作为表头。

*引用规则*：
  - 仅当 `outlined = true`（默认）时，`booktab` 才会包装为 `figure`，此时 `caption` 生效、表格可被 `@label` 引用。
  - 设 `outlined: false` 时为纯表格，`caption` 不生效，且不能使用 `@` 引用。

*注意*：本模板默认允许表格跨页显示（`show figure: set block(breakable: true)`）。如果不希望某个表格被分割，可以在表格前手动插入 `#pagebreak()` 进行调整。

@booktab-example 展示了 `booktab` 的示例效果：

#code-preview(
  ```typ
  #booktab(
    columns: (1fr, 1fr, 1fr),
    align: (left, center, right),
    caption: [三线表示例],
    [左对齐], [居中], [右对齐],
    [4], [5], [6],
    [7], [8], [9],
  ) <booktab-example>
  ```,
  [
    #booktab(
      columns: (1fr, 1fr, 1fr),
      align: (left, center, right),
      caption: [三线表示例],
      [左对齐],
      [居中],
      [右对齐],
      [4],
      [5],
      [6],
      [7],
      [8],
      [9],
    ) <booktab-example>
  ],
)

如果你更喜欢先写原生 `table`，再统一套用三线表样式，可以使用 `as-booktab`。这种写法更适合与原生 `figure` 组合，也更容易被 Tinymist 等格式化工具整理。若需要标题、编号和 `@label` 引用，请像原生表格一样继续使用 `figure(..., kind: table)` 包装。对于包含 `table.vline(...)` 或其他非单元格结构元素的表格，建议显式使用 `table.header(...)`，不要依赖 `as-booktab` 的首行表头推断。

#code-preview(
  ```typ
  #figure(
    as-booktab(table(
      columns: (1fr, 1fr, 1fr),
      align: (left, center, right),
      table.header([左对齐], [居中], [右对齐]),
      [4], [5], [6],
      [7], [8], [9],
    )),
    caption: [三线表示例（as-booktab）],
    kind: table,
  ) <as-booktab-example>
  ```,
  [
    #figure(
      as-booktab(table(
        columns: (1fr, 1fr, 1fr),
        align: (left, center, right),
        table.header([左对齐], [居中], [右对齐]),
        [4], [5], [6],
        [7], [8], [9],
      )),
      caption: [三线表示例（as-booktab）],
      kind: table,
    ) <as-booktab-example>
  ],
)

== 公式

Typst 使用 `$...$` 包裹数学公式。行内公式前后需要有空格，行间公式会自动编号：

#code-preview(
  ```typ
  行内公式：$E = m c^2$

  行间公式：
  $ integral_0^infinity e^(-x^2) dif x = sqrt(pi) / 2 $ <integral>
  ```,
  [
    行内公式：$E = m c^2$

    行间公式：
    $ integral_0^infinity e^(-x^2) dif x = sqrt(pi) / 2 $ <integral>
  ],
)

@integral 展示了一个积分公式。

=== 多行公式

多行公式使用 `\` 换行，使用 `&` 对齐：

#code-preview(
  ```typ
  $ sum_(k=0)^n k
      &= 1 + 2 + ... + n \
      &= (n(n+1)) / 2 $ <sum>
  ```,
  [
    $
      sum_(k=0)^n k & = 1 + 2 + ... + n \
                    & = (n(n+1)) / 2
    $ <sum>
  ],
)

=== 常用数学符号

#code-preview(
  ```typ
  $ frac(a^2, 2) $
  $ vec(1, 2, delim: "[") $
  $ mat(1, 2; 3, 4) $
  $ lim_(x -> 0) sin(x) / x = 1 $
  ```,
  [
    $ frac(a^2, 2) $
    $ vec(1, 2, delim: "[") $
    $ mat(1, 2; 3, 4) $
    $ lim_(x -> 0) sin(x) / x = 1 $
  ],
)

== 代码块

像 Markdown 一样，可以使用三个反引号插入代码块：

#code-preview(
  ````typ
  ```python
  def hello():
      print("Hello, world!")
  ```
  ````,
  [
    ```python
    def hello():
        print("Hello, world!")
    ```
  ],
)

本模板使用 codly 包提供代码块的语法高亮和样式增强。默认启用行号、语言图标、语言名称和交替背景色。可以通过 `codly-args` 配置项自定义样式。

如果需要给代码块加标题并在文章中引用，可以使用本模板提供的 `codeblock` 命令：

#codeblock(
  ```python
  def fibonacci(n):
      if n <= 1:
          return n
      return fibonacci(n-1) + fibonacci(n-2)
  ```,
  caption: "斐波那契数列递归实现",
) <fib>

@fib 展示了斐波那契数列的递归实现。

== 参考文献

本模板集成了 gb7714-bilingual 包，提供符合 GB/T 7714 标准的参考文献格式。该包会自动根据文献语言切换中英文术语（如英文文献使用 "et al."，中文文献使用 "等"）。

=== 基本用法

Typst 支持 BibLaTeX 格式的 `.bib` 文件。在文档中引用文献使用 `@` 符号：

#code-preview(
  ```typ
  可以像这样引用参考文献@wang2010guide @kopka2004guide。
  ```,
  [可以像这样引用参考文献@wang2010guide @kopka2004guide。],
)

使用本模板时，只需在 `config()` 函数中配置 `bib-file` 等参数即可：

#codeblock(
  ```typ
  #let (setup, ..., body-wrap, bibliography) = config(
    bib-file: path("ref.bib"),
    bib-style: "numeric",
    bib-version: "2015",
  )
  #show: setup
  ...
  #show: bibliography
  ```,
  caption: "参考文献配置示例",
)

根据#link("https://grs.pku.edu.cn/docs/2024-02/20240229092001843564.doc")[北京大学博士研究生学位论文格式模板(2024)]，文献索引方式可选择"顺序编码制"（`bib-style: "numeric"`）或"著者—出版年制"（`bib-style: "author-date"`）。

著者—出版年制下，参考文献列表默认先中文、后外文；中文条目按作者姓氏的汉语拼音排序（由集成的 gb7714-bilingual 与 auto-pinyin 实现）。若个别姓氏的多音字排序不符合预期，可通过 `bib-pinyin-override` 指定读音。

=== 语言检测

gb7714-bilingual 会自动检测文献语言。如果自动检测不准确，可以在 `.bib` 文件中显式指定 `language` 字段：

#codeblock(
  ```bib
  @book{kopka2004guide,
    title     = {Guide to LATEX},
    author    = {Kopka, Helmut and Daly, Patrick W},
    year      = {2004},
    publisher = {Addison-Wesley},
    language  = {english}
  }
  ```,
  caption: "在 .bib 文件中指定语言",
)

=== 高级用法

如果需要使用其他引用样式（如 APA、IEEE 等），可以设置 `override-bib: true`，此时模板会跳过 gb7714-bilingual，改用 Typst 原生 `bibliography` 函数：

```typ
#let (setup, ..., body-wrap, bibliography) = config(
  bib-file: path("ref.bib"),
  override-bib: true,
  ...
)
#show: setup
#show: body-wrap

// ... 正文内容 ...

// 在需要的位置自行调用 bibliography
#bibliography("ref.bib", style: "ieee")
```

`override-bib: true` 时模板仍会应用已预设参考文献的排版样式（五号字、悬挂缩进 1.66 字符、行距 16pt、段前 3pt），以匹配 Word 模板规范。如需进一步自定义排版，可以添加自己的 `show bibliography` 规则来覆盖：

```typ
#show bibliography: it => {
  set text(size: 10pt)
  set par(hanging-indent: 2em)
  it
}
#bibliography("ref.bib", style: "apa")
```

== 交叉引用

Typst 使用标签 `<label>`（或`label(...)`）和引用 `@label`（或`link(dst, src)`）实现交叉引用。当原始标签引用的对象是章节、图表等时，`@label` 会自动转换为链接文本。对于一般的引用，则需要通过 `link` 函数手动创建链接文本。

*图表与表格*：图片需放在 `figure` 中；`booktab` 表格需要使用 `outlined: true`（默认），才能用 `<label>` 配合 `@label` 引用。`outlined: false` 的纯表格不能作为引用目标。

=== 创建标签

在任意元素后附加 `<标签名>` 即可创建标签：

```typ
= 第一章 绪论 <ch-intro>

#figure(
  image("chart.svg"),
  caption: "实验数据",
) <fig-data>

$ a^2 + b^2 = c^2 $ <eq-pythagoras>
```

标签名可以是任意不包含空格的字符串。

=== 引用标签

使用 `@标签名` 引用已定义的标签：

#code-preview(
  ```typ
  如 @appendix-fig 所示...
  根据 @eq-normal...
  详见 @booktab-example...
  ```,
  [
    如 @appendix-fig 所示...
    根据 @eq-normal...
    详见 @booktab-example...
  ],
)

=== 引用显示效果

本模板自定义了各类型对象的引用前缀：

#booktab(
  width: 100%,
  columns: (8em, 1fr),
  align: (center, center),
  caption: "引用显示效果",
  [*类型*],
  [*引用示例*],
  [插图],
  ["如图 1.1 所示"],
  [表格],
  ["如表 1.1 所示"],
  [代码],
  ["如代码 1.1 所示"],
  [公式],
  ["如式 (1.1) 所示"],
  [章节],
  ["如第一章所述"],
  [附录],
  ["如附录 A 所述"],
)

引用前缀可通过 `supplements` 参数自定义：

```typ
#let (setup, ...) = config(
  supplements: (图: "Figure", 表: "Table"),
)
```

=== 手动引用

如果默认的 `@` 引用效果不满足需求，可以使用 `#link` 和 `#ref` 函数手动构造引用文本：

```typ
#link(<fig-wordmark>)[北京大学字标（占位图）]
```

这会在"北京大学字标（占位图）"上创建指向 @fig-wordmark 的超链接。
