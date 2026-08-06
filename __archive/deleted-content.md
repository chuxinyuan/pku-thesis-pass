# 归档：重组中被删除或改写的原文

本文件记录 2026-08-06 章节重组过程中被删除/大幅改写的原文，每段标注来源文件与行号，供后续取用。仅作存档，不作为正文渲染内容。

---

## template/content/appendix-about.typ

### 来源：appendix-about.typ:1-129（原全篇结构，重写为理念介绍 + 综合示例）

原文件全篇（含 gribouille 绘图段、插入图片段、表格/公式/代码块独立示例）如下：

```typ
#import "../../format/components.typ": as-booktab, code-block
// 注意：本地测试时保留上一行；发布（typst init 生成工程）时删除上一行，并取消注释下一行
// #import "@preview/pku-thesis-pass:0.3.0": as-booktab, code-block
#import "@preview/gribouille:0.6.0": *

撰写学位论文是每个研究生必须完成的功课。在 LaTeX 还是 Typst 的选择上，过去几年我们几乎没有悬念——LaTeX 是唯一的专业排版工具。然而，Typst 的出现正在改变这个局面。

Typst 是一个现代化的排版系统，相比 LaTeX 有诸多优势：

- _编译速度极快_：毫秒级增量编译，实时预览丝滑流畅
- _语法更直观_：不像 LaTeX 那样有大量反斜杠和宏包，Typst 的语法接近现代编程语言
- _包管理器内置_：`@preview/xxx` 可以直接在文档中引用，无需手动安装宏包
- _Unicode 优先_：原生支持中文等非拉丁文字，无需额外配置

北京大学学位论文 Typst 模板（pku-thesis-pass）致力于让排版变得简单。本模板基于 pkuthss-typst 重构而来，采用 DI（依赖注入）模式，用户可以通过 `config()` 函数获取各个页面组件的闭包，自行编排论文结构，而不是被固定的模板流程所限制。

本文档是模板的使用指南，涵盖从安装配置到进阶技巧的所有内容。

== 主要特点

+ *语法简洁*：Typst 的语法受到 Markdown 的启发，学习曲线平缓
+ *编译速度快*：增量编译技术使得大型文档也能快速预览
+ *实时预览*：官方编辑器支持实时渲染预览
+ *脚本能力*：内置图灵完备的脚本语言，支持复杂的排版逻辑
+ *现代设计*：原生支持 Unicode、OpenType 字体等现代排版技术

== 插入现有图片

最简单的插入方式：

```typ
#image("../assets/pkuword.pdf", width: 60%)
```

如果是写论文，那么有必要给图片一个 Figure 类、标题和标签，方便自动编号和交叉引用。

#figure(
  image("../assets/pkuword.pdf", width: 60%),
  caption: [
    北京大学字标
  ],
) <fig-wordmark>

同一类对象会自动编号，给一个标签是为了交叉引用。@fig-wordmark 展示的是北京大学的校名字标，本模板已内置（取自 CTAN 的 #link("https://ctan.org/pkg/pkuthss")[pkuthss] 包），封面通过 `config()` 的 `logo` / `wordmark` 参数导入。

== 代码生成图片

附录中也可以插入图片，如 @appendix-fig。

#let df = ((x: -calc.pi, y: -1.2), (x: calc.pi, y: 1.2))

#figure(
  plot(
    data: df,
    mapping: aes(x: "x", y: "y"),
    layers: (
      geom-blank(),
      geom-line(
        stat: stat-function(fun: x => calc.sin(x), x-limits: (-calc.pi, calc.pi)),
        colour: rgb("#1f77b4"),
        stroke: 1.2pt,
      ),
      geom-line(
        stat: stat-function(fun: x => calc.cos(x), x-limits: (-calc.pi, calc.pi)),
        colour: rgb("#d62728"),
        stroke: 1.2pt,
        linetype: "dashed",
      ),
    ),
    scales: scales(x: scale-continuous(breaks: (-3, -1.5, 0, 1.5, 3))),
    labels: labels(
      title: "Two Analytic Curves",
      x: "X",
      y: "f(x)",
    ),
    theme: theme-minimal(),
    width: 12cm,
    height: 9cm,
  ),
  caption: "gribouille 包绘制的正弦余弦曲线",
) <appendix-fig>

== 表格

@table-example 是一张很常见的三线表。

#figure(
  as-booktab(table(
    columns: (1fr, 1fr, 1fr, 1fr),
    align: center + horizon,
    table.header(
      table.cell(rowspan: 2)[*地区*],
      table.cell(colspan: 2)[*经济指标*],
      table.cell(rowspan: 2)[*人口（万）*],
      table.hline(start: 1, end: 3, stroke: 0.5pt),
      [*GDP（亿）*],
      [*增速（%）*],
    ),
    [城市 A], [41610], [3.5], [2189],
    [城市 B], [47218], [4.1], [2487],
    [城市 C], [135673], [5.2], [12684],
  )),
  caption: [城市 A、B、C 的 GDP 和人口情况],
) <table-example>

== 公式

+ 行内公式
  爱因斯坦的质能方程：$E=m c^2$
+ 行间公式

  $
    f(x) = frac(1, sigma sqrt(2 pi)) e^(- frac((x - mu)^2, 2 sigma^2))
  $ <eq-normal>

@eq-normal 是正态分布公式。

== 代码块

附录中也可以插入代码块，如 @appendix-code。

#code-block(
  ```rust
  fn main() {
      println!("Hello from Rust!");
  }
  ```,
  caption: "Rust Hello World",
) <appendix-code>
```

---

## template/content/ch04-faq.typ

### 来源：ch04-faq.typ:10-22（默认值与示例值的关系，改写为问答式）

```typ
== 默认值与示例值的关系

`config.typ` 中的函数参数默认值，与 `thesis.typ` 中示例填写的值，并不是一回事，需要注意区分：

- #strong[config.typ（源码默认值）]：函数签名中定义的默认值，是唯一的一级回退源。用户省略该参数时，最终生效的就是这里的值。
- #strong[thesis.typ（示例值）]：模板自带的一篇示例论文，其中填写的值是演示性的，会覆盖源码默认值，仅代表"这样写可以"，不代表默认行为。

以 `supervisor-zh` 为例：

- `config.typ` 源码默认值为 `"李四"`；
- `thesis.typ` 示例值为 `"李四 教授"`。

因此第 2 章参数详解表格（#strong[系统默认值] 一栏）与各参数详解中的 #strong[默认值] 一栏，均如实对应 `config.typ` 的源码默认值，而非 `thesis.typ` 的示例值。如果你在自己的论文中省略了某个参数，实际生效的就是表格中所列的默认值。
```

### 来源：ch04-faq.typ:24-45（省略参数与显式传 none，改写为问答式）

```typ
== 省略参数与显式传 none

在 `thesis.typ` 中修改配置时，省略某个参数与显式将其设置为 `none` 是两种不同的行为：

- #strong[省略该参数]：Typst 会使用 `config.typ` 中定义的默认值。这是获取默认行为的推荐方式。
- #strong[显式传 `none`]：会得到字面量 `none`，并不会回落到默认值。对于标题、姓名等字符串参数，这会破坏封面等页面的渲染，应避免这样做。

以 `direction` 为例，在 `thesis.typ` 中：

```typ
// 方式一：省略该参数，生效值为默认值 "某个研究方向"
config(
  // 不写 direction 这一行即可
)

// 方式二：显式传 none，生效值为 none，可能导致封面渲染异常
config(
  direction: none,
)
```

需要将某个可选功能关闭时，应查看对应参数的默认值说明，传合理的关闭值（如 `blind: false`、`override-bib: false`、`word-count: false`），而非直接传 `none`。
```

### 来源：ch04-faq.typ:2-8（行距说明，改写为问答式）

```typ
== 行距说明

本模板的行距已针对 Word 模板进行了校准。Word 中的"行距"指的是基线到基线的距离，而 Typst 的 `leading` 指的是行与行之间的间距（不含字符高度）。

本模板将正文行距固定为 `10.5pt`（视觉上近似对应 Word 的 20pt 行距）。如需精确匹配特定字体，可以使用 `top-edge` 和 `bottom-edge` 参数。

由于 Word 中的实际行距还会受到字体影响，即使使用这样的方式，也难以做到与 Word 的像素级对应。
```

---

## template/content/ch05-advanced.typ

### 来源：ch05-advanced.typ:216-244（模板提供的辅助函数，与"补充说明"合并为"组件与辅助函数参考"）

```typ
== 模板提供的辅助函数

`config()` 返回以下函数和字段：

*页面函数*：
- `setup(body)`：页面设置（字号、行距、页眉页脚、show 规则），作为 `#show: setup` 调用
- `cover()`：生成封面（根据 `blind` 自动选择正常/盲审版）
- `copyright()`：版权声明页
- `abstract-zh` / `abstract-en`：中英文摘要
- `outline()`：中文目录
- `list-of-figures()` / `list-of-tables()` / `list-of-code()` / `list-of-equations()`：插图/表格/代码/公式列表
- `notation(body)`：主要符号对照表（`/ 符号: 说明` 语法，空行分组）
- `achievement(body)`：攻读学位期间发表的论文（`+` 条目自动编号，作者姓名加粗）
- `body-wrap(body)`：正文段落样式，作为 `#show: body-wrap` 调用
- `bibliography(body)`：参考文献渲染，作为 `#show: bibliography` 调用
- `acknowledgements(body)`：致谢
- `declaration()`：原创性声明
- `appendix()`：开始附录部分，后续章节编号切换为字母格式

*工具值*：
- `font`：解析后的字体方案字典
- `smartpagebreak`：智能分页函数（支持 `always-start-odd`）
- `blind` / `preview` / `always-start-odd` / `first-line-indent`：当前配置值

可直接导入的组件：

```typ
#import "@preview/pku-thesis-pass:0.x.0": booktab, as-booktab, code-block
```

- `#booktab(...)`：生成三线表，第一行自动加粗为表头，支持 `outlined: false` 生成纯表格
- `#as-booktab(table)`：将原生 `table` 装饰为三线表样式，便于和 `figure` 组合使用
- `#code-block(...)`：生成带标题和编号的可引用代码块
```

---

## template/content/ch03-basics.typ

### 来源：ch03-basics.typ:589-684（主要符号对照表 / 攻读学位期间发表的论文 / 字数统计 三节，重组后内容保留于 ch03 但叙述精简，重复实现细节指向 ch05）

（注：这三节的正文内容重组后仍保留在 ch03，此处仅为行号记录，未删除。）

### 来源：ch03-basics.typ:675、705、743（config 解构示例，修复为命名解构）

```typ
#let (setup, ..., total-words) = config(
  word-count: true, // 统计正文与附录的字数
)

#let (setup, ..., body-wrap, bibliography) = config(
  bib-file: path("ref.bib"),
  bib-style: "numeric",
  bib-version: "2015",
)

#let (setup, ..., body-wrap, bibliography) = config(
  bib-file: path("ref.bib"),
  override-bib: true,
  ...
)
```

### 来源：ch05-advanced.typ:46（盲审模式解构示例，修复为命名解构）

```typ
#let (setup, cover, blind, ..) = config(
  blind: true,
  ...
)
```

---

## template/content/ch04-faq.typ（改写为 8 条问答式）

### 来源：ch04-faq.typ 原文（3 节：行距说明 / 默认值与示例值的关系 / 省略参数与显式传 none，已改写为问句标题并扩至 8 条）

原「行距说明」节：

```typ
== 行距说明

本模板的行距已针对 Word 模板进行了校准。Word 中的"行距"指的是基线到基线的距离，而 Typst 的 `leading` 指的是行与行之间的间距（不含字符高度）。

本模板将正文行距固定为 `10.5pt`（视觉上近似对应 Word 的 20pt 行距）。如需精确匹配特定字体，可以使用 `top-edge` 和 `bottom-edge` 参数。

由于 Word 中的实际行距还会受到字体影响，即使使用这样的方式，也难以做到与 Word 的像素级对应。
```

原「默认值与示例值的关系」节与「省略参数与显式传 none」节请以 `git show HEAD:template/content/ch04-faq.typ` 为准（本次改写仅将标题改为问句、并将前两条/第三条内容并入新问答，措辞微调）。

---

## template/content/ch05-advanced.typ（合并"模板提供的辅助函数"与"补充说明"）

### 来源：ch05-advanced.typ 原 L212-245「模板提供的辅助函数」整节（重组后并入「组件与辅助函数参考」，其中 0.x.0 占位版本号已清理为 0.3.0）

```typ
== 模板提供的辅助函数

`config()` 返回以下函数和字段：

*页面函数*：
- `setup(body)`：页面设置（字号、行距、页眉页脚、show 规则），作为 `#show: setup` 调用
- `cover()`：生成封面（根据 `blind` 自动选择正常/盲审版）
- `copyright()`：版权声明页
- `abstract-zh` / `abstract-en`：中英文摘要
- `outline()`：中文目录
- `list-of-figures()` / `list-of-tables()` / `list-of-code()` / `list-of-equations()`：插图/表格/代码/公式列表
- `notation(body)`：主要符号对照表（`/ 符号: 说明` 语法，空行分组）
- `achievement(body)`：攻读学位期间发表的论文（`+` 条目自动编号，作者姓名加粗）
- `body-wrap(body)`：正文段落样式，作为 `#show: body-wrap` 调用
- `bibliography(body)`：参考文献渲染，作为 `#show: bibliography` 调用
- `acknowledgements(body)`：致谢
- `declaration()`：原创性声明
- `appendix()`：开始附录部分，后续章节编号切换为字母格式

*工具值*：
- `font`：解析后的字体方案字典
- `smartpagebreak`：智能分页函数（支持 `always-start-odd`）
- `blind` / `preview` / `always-start-odd` / `first-line-indent`：当前配置值

可直接导入的组件：

```typ
#import "@preview/pku-thesis-pass:0.x.0": booktab, as-booktab, code-block
```

- `#booktab(...)`：生成三线表，第一行自动加粗为表头，支持 `outlined: false` 生成纯表格
- `#as-booktab(table)`：将原生 `table` 装饰为三线表样式，便于和 `figure` 组合使用
- `#code-block(...)`：生成带标题和编号的可引用代码块
```

### 来源：ch05-advanced.typ 原「补充说明」节的 `eq-block` 小标题（重组后改名为「eq-block — 公式自动编号」）

重组将原「公式自动编号」小节的 `===` 标题改为 `====` 并与组件参考合并，正文内容未变。

---

---

## template/content/appendix-about.typ（重写为综合示例）

### 来源：appendix-about.typ 原全文（含 gribouille 依赖与绘图段，已删除并替换为原生 Typst 绘制示例；分散的 插入现有图片/代码生成图片/表格/公式/代码块 五节合并为「综合示例」一节）

原文件以 `git show HEAD:template/content/appendix-about.typ` 为准，要点：

- 原 L4 `#import "@preview/gribouille:0.6.0": *` 依赖及其 L46-81 plot 绘图段（@appendix-fig 曾为 gribouille 绘制的正弦余弦曲线）已删除，替换为纯原生 Typst 绘制，消除外部依赖。
- 原「插入现有图片」节（figure 包装 image，<fig-wordmark>）、「表格」节（as-booktab 三线表，<table-example>）、「公式」节（<eq-normal>）、「代码块」节（<appendix-code>）合并入新「综合示例」节，内容基本保留，仅调整叙述。
- 与 ch03 重复的逐组件讲解改为指向第 3 章与第 5 章「组件与辅助函数参考」。

### 来源：template/ref.bib 的 gribouille 条目（随绘图段删除而废弃，已从 ref.bib 移除）

```bib
@online{gribouille,
	title = {Gribouille},
	url = {https://m.canouil.dev/gribouille/},
	abstract = {Create elegant graphics with the Grammar of Graphics for Typst.},
	titleaddon = {Gribouille},
	urldate = {2026-07-26},
	langid = {british}
}
```

## template/content/ch03-basics.typ（论文特殊页面合并）

### 来源：ch03-basics.typ 原「主要符号对照表」「攻读学位期间发表的论文」「字数统计」三个独立 `==` 节（已合并为一个 `== 论文特殊页面`，下设三个 `===` 子节，正文内容未删改）

合并仅将三个 `==` 改为 `===` 并置于统一的 `== 论文特殊页面` 之下，新增一句引导语；正文与示例保持不变。

---
