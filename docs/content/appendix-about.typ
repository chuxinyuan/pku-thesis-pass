#import "../../format/utils.typ": as-booktab, codeblock
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
#image("../../assets/placeholder-wordmark.svg", width: 60%)
```

如果是写论文，那么有必要给图片一个 Figure 类、标题和标签，方便自动编号和交叉引用。

#figure(
  image("../assets/placeholder-wordmark.svg", width: 60%),
  caption: [
    北京大学字标（占位图）
  ],
) <fig-wordmark>

同一类对象会自动编号，给一个标签是为了交叉引用。@fig-wordmark 展示的是校名字标的占位图：出于版权考虑，这里不包含北京大学官方校徽和字标。封面上的校徽可通过 `config()` 的 `logo` / `wordmark` 参数导入，官方校徽和字标（`pkulogo` / `pkuword`）可从 CTAN 的 `pkuthss` 包获取：#link("https://ctan.org/pkg/pkuthss")，CTAN 提供 eps 和 pdf 两种格式，Typst 的 `image()` 不支持 eps 格式，请使用其中的 pdf 格式文件或自行转换为 svg 等支持的格式。

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

#codeblock(
  ```rust
  fn main() {
      println!("Hello from Rust!");
  }
  ```,
  caption: "Rust Hello World",
) <appendix-code>
