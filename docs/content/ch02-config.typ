#import "../../format/components.typ": booktab, eq-block

本模板提供了丰富的配置选项，在 `config()` 函数中以命名参数的方式传入。下面详细介绍各个配置项的含义和用法。

== 作者与论文信息

#booktab(
  width: 100%,
  columns: (auto, auto, 1fr),
  align: (left, left, left),
  caption: "作者与论文信息配置项",
  [*参数名*],
  [*默认值*],
  [*说明*],
  [`author-zh`],
  [`"张三"`],
  [作者中文姓名],
  [`author-en`],
  [`"San Zhang"`],
  [作者英文姓名],
  [`student-id`],
  [`"23000xxxxx"`],
  [学号（非盲审封面显示）],
  [`blind-id`],
  [`"L2023XXXXX"`],
  [盲审编号（盲审封面显示）],
  [`thesis-name`],
  [`"博士研究生学位论文"`],
  [论文类型名称],
  [`header-text`],
  [`"北京大学博士学位论文"`],
  [页眉文本（偶数页显示）],
  [`title-zh`],
  [--],
  [论文中文标题，可用 `\n` 控制换行；盲审模式下 `\n` 会被忽略],
  [`title-en`],
  [--],
  [论文英文标题，可用 `\n` 控制换行；盲审模式下 `\n` 会被忽略],
  [`degree-type`],
  [`"academic"`],
  [学位类型：`"academic"`（学术学位）或 `"professional"`（专业学位）],
  [`year`],
  [`2026`],
  [论文提交年份],
  [`month`],
  [`6`],
  [论文提交月份],
) <config-author>

其中 `title-zh` 与 `author-zh` 除了显示在封面外，还会写入 PDF 文档属性（元数据）：`title-zh` 作为标题，`author-zh` 作为作者。盲审模式（`blind: true`）下作者会被隐藏，仅保留标题。详见 @pdf-meta。

== 院系与专业信息

#booktab(
  width: 100%,
  columns: 3,
  align: left,
  caption: "院系与专业信息配置项",
  [*参数名*],
  [*默认值*],
  [*说明*],
  [`school`],
  [`"某个院系"`],
  [院系名称],
  [`first-major`],
  [`"某个一级学科"`],
  [一级学科名称],
  [`major-zh`],
  [`"某个专业"`],
  [专业中文名称],
  [`major-en`],
  [`"Some Major"`],
  [专业英文名称],
  [`direction`],
  [`"某个研究方向"`],
  [研究方向],
  [`supervisor-zh`],
  [`"李四"`],
  [导师中文姓名及职称],
  [`supervisor-en`],
  [`"Si Li"`],
  [导师英文姓名],
) <config-school>

== 排版选项

#booktab(
  width: 100%,
  columns: (auto, auto, 1fr),
  align: (left, left, left),
  caption: "排版选项配置项",
  [*参数名*],
  [*默认值*],
  [*说明*],
  [`system`],
  [`"default"`],
  [字体方案：`"default"`/`"mac"`/`"windows"`/`"linux"`],
  [`blind`],
  [`false`],
  [是否为盲审模式，盲审模式隐藏作者、导师等信息],
  [`preview`],
  [`true`],
  [预览模式，链接文本显示为蓝色；生成打印版时设为 `false`],
  [`first-line-indent`],
  [`2em`],
  [首行缩进，Word 模板为 `1.77em`，本模板默认 `2em`],
  [`always-start-odd`],
  [`true`],
  [章节是否总是从奇数页开始],
  [`clean-declaration`],
  [`false`],
  [原创性声明页是否隐藏页眉页脚],
  [`outline-depth`],
  [`3`],
  [目录显示的最大标题层级],
  [`word-count`],
  [`true`],
  [统计正文与附录字数（CJK 字数 / 总字符数），正文中可用 `total-words` / `total-characters` 显示统计结果],
  [`achievement-outlined`],
  [`true`],
  ["攻读学位期间发表的论文"页是否出现在目录中；设为 `false` 时该页不进入目录],
  [`supplements`],
  [`(:)`],
  [自定义引用记号和列表标题。可用字段及默认值：\
    引用前缀：`图`（"图"）、`表`（"表"）、`代码`（"代码"）、`公式`（"式"）、`节`（"节"）；\
    `图表`（"图表"，未知 figure kind 的 fallback）；\
    列表页标题：`插图列表`（"插图"）、`表格列表`（"表格"）、`代码列表`（"代码"）、`公式列表`（"公式"）、`符号表`（"主要符号对照表"）、`成果表`（"攻读学位期间发表的论文"）。\
    示例：`supplements: (图: "Figure", 插图列表: "List of Figures")`],
  [`use-latexref`],
  [`false`],
  [LaTeX 引用兼容：`@fig:xxx` 等带前缀的引用解析失败时，自动剥离前缀后重试 `@xxx`。\
    适合从 LaTeX 迁移的文档（LaTeX 习惯用 `\ref{fig:xxx}`），开启后无需改动原有标签写法。\
    详见 "进阶"一章的 @latexref 小节],
  [`latexref-prefixes`],
  [`("fig:", ..)`],
  [`use-latexref` 为 `true` 时尝试剥离的前缀列表，可按需增删，如 `("图:", "表:")`],
  [`codly-args`],
  [`(:)`],
  [传递给 `codly` 包的额外参数，用于自定义代码块样式。常用选项：\
    `number-format: none`  关闭代码行号；\
    `display-icon: false`  关闭语言图标；\
    `lang-format: none`    关闭语言名称；\
    `zebra-fill: none`     关闭交替背景色],
  [`logo`],
  [`none`],
  [封面校徽图片路径，`path` 类型，如 `path("assets/logo.svg")`；为 `none` 时封面显示灰色占位框],
  [`wordmark`],
  [`none`],
  [封面校名字标图片路径，`path` 类型；为 `none` 时封面显示灰色占位框],
) <config-layout>

== 参考文献配置

本模板集成了 gb7714-bilingual 包，提供符合 GB/T 7714 标准的参考文献格式，并自动根据文献语言切换中英文术语。

#booktab(
  width: 100%,
  columns: (auto, auto, 1fr),
  align: (left, left, left),
  caption: "参考文献配置项",
  [*参数名*],
  [*默认值*],
  [*说明*],
  [`bib-file`],
  [`none`],
  [BibTeX 文件路径，`path` 类型，如 `path("ref.bib")`],
  [`bib-style`],
  [`"numeric"`],
  [引用风格：`"numeric"`（顺序编码制）或 `"author-date"`（著者—出版年制）],
  [`bib-version`],
  [`"2015"`],
  [GB/T 7714 标准版本：`"2015"` 或 `"2025"`。GB/T 7714-2025 标准从 2026 年 7 月 1 日开始实施],
  [`bib-cn-first`],
  [`true`],
  [仅 `bib-style: "author-date"`。`true` 时参考文献列表中中文条目排在外文之前；`false` 时外文在前。中文条目按作者姓氏拼音排序],
  [`bib-pinyin-override`],
  [`(:)`],
  [仅 `author-date` 且中文作者。多音字校正字典，如 `("重": "chong2")`],
  [`override-bib`],
  [`false`],
  [是否自定义参考文献引用样式。设为 `true` 时忽略上述参数，用户需自行处理参考文献],
) <config-bib>

== 补充说明

除了上述配置参数，`config()` 函数还返回若干额外字段：
- `font`：解析后的字体方案字典，可直接用于自定义页面（如 `#set text(font: font.仿宋)`）
- `smartpagebreak`：智能分页函数（支持 `always-start-odd`）
- `first-line-indent`：首行缩进值（供自定义页面使用）
- `blind` / `preview` / `always-start-odd`：当前配置值，可由 `--input` CLI 参数覆盖

模板还导出了 `booktab`、`as-booktab`、`code-block` 三个组件函数，可直接导入使用：

```typ
#import "@preview/pku-thesis-pass:0.3.0": booktab, as-booktab, code-block
```

=== booktab — 三线表

`booktab` 从零创建学术三线表，第一行位置参数自动作为表头（加粗），支持 `figure` 包装和 `@label` 引用：

```typ
#booktab(
  columns: (1fr, 1fr, 1fr),
  caption: [实验数据],
  [组别], [数值], [备注],
  [A], [1.0], [对照组],
  [B], [2.5], [实验组],
)
```

- `caption`：表格标题，省略时不编号
- `outlined: false`：不包装为 `figure`，生成纯表格
- 其他命名参数（`columns`、`align` 等）透传给 `table`

=== as-booktab — 表格装饰器

`as-booktab` 将现有原生 `table` 装饰为三线表，自动识别 `table.header` 或前 N 个单元格作为表头。更适合与 `figure` 组合，易被格式化工具整理：

```typ
#figure(
  as-booktab(table(
    columns: (1fr, 1fr, 1fr),
    table.header([左对齐], [居中], [右对齐]),
    [4], [5], [6],
    [7], [8], [9],
  )),
  caption: [三线表示例],
  kind: table,
) <my-table>
```

若 table 已包含 `table.hline`，则仅包裹不修改，保留手动样式。

=== code-block — 代码块

`code-block` 包装 raw 为带标题的可引用 `figure(kind: "code")`：

````typ
#code-block(
  ```python
  def fibonacci(n):
      if n <= 1:
          return n
      return fibonacci(n-1) + fibonacci(n-2)
  ```,
  caption: [斐波那契数列],
) <fib>
````

省略 `caption` 则只显示代码，无标题无编号、不入图列表、不可被 `@` 引用。

=== eq-block — 公式块

`eq-block` 将行间公式包装为带标题的可引用 `figure(kind: "equation")`，支持公式目录：

```typ
#eq-block(caption: [勾股定理])[
  $ a^2 + b^2 = c^2 $
] <eq-pythagoras>
```

- 省略 `caption` 时原样返回公式，不编号、不入公式目录
- 使用公式目录时，所有需要编号的公式应统一用 `eq-block`，避免与普通 `$ ... $` 的计数器冲突
- 不需要编号的公式可用 `#math.equation($...$, numbering: none, block: true)`
