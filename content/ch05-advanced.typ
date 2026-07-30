#import "../format/utils.typ": booktab

== 自定义页眉页脚

本模板的页眉页脚通过 `format/header.typ` 和 `format/footer.typ` 控制。页眉规则：
- 奇数页显示当前章节标题
- 偶数页显示论文标题（`header-text` 参数）
- 封面区域无页眉

页脚规则：
- 前置部分（摘要、目录等）使用罗马数字
- 正文部分使用阿拉伯数字

== 附录

使用 `#appendix()` 命令开始附录部分。附录中的章节、图表、公式编号会自动切换为字母格式（如 A.1、A.2）：

```typ
#appendix()

= 附录 A 补充材料

这里是附录内容...
```

`appendix()` 由 `config()` 返回，在解构时获取。

== 盲审模式

`config()` 的 `blind` 参数控制盲审模式：

```typ
#let (setup, cover, blind, ..) = config(
  blind: true,
  ...
)
```

盲审模式下：
- 封面使用盲审格式，显示盲审编号
- 隐藏作者、导师等个人信息
- 隐藏致谢和原创性声明

也可以通过命令行参数临时切换：

```bash
# 生成盲审版本
typst compile thesis.typ --input blind=true

# 生成正常版本
typst compile thesis.typ --input blind=false
```

== 预览与打印模式

`preview` 参数控制链接文本的显示方式：
- `preview: true`（默认）：链接显示为蓝色，便于电子版阅读
- `preview: false`：链接显示为正常颜色，适合打印

同样支持命令行切换：

```bash
# 生成打印版（链接不着色）
typst compile thesis.typ --input preview=false
```

== 命令行参数汇总

本模板支持以下命令行参数，通过 `--input key=value` 传递：

#booktab(
  columns: (auto, 1fr),
  align: (left, left),
  caption: "支持的命令行参数",
  [*参数*],
  [*说明*],
  [`blind`],
  [盲审模式：`true` 启用，`false` 禁用],
  [`preview`],
  [预览模式：`true` 链接显示蓝色，`false` 正常颜色],
  [`always-start-odd`],
  [章节从奇数页开始：`true` 启用，`false` 禁用],
  [`system`],
  [系统字体方案：`default`/`mac`/`windows`/`linux`],
)

```bash
# 组合多个参数示例
typst compile thesis.typ --input blind=true --input preview=false --input system=linux
```

== 自定义章节样式

如果需要创建不出现在目录中的章节（如致谢），可以使用：

```typ
#heading(numbering: none, outlined: false)[致谢]
```

如果需要章节出现在目录但无编号（如参考文献），可以使用：

```typ
#heading(numbering: none, outlined: true)[参考文献]
```

== 使用 `include` 拆分文件

对于较长的论文，可以将各部分内容拆分到单独的文件中，使用 `include` 引入：

```typ
= 引言 <intro>
#include "content/ch01-intro.typ"

= 文献综述 <litrev>
#include "content/ch02-litrev.typ"
```

== 模板提供的辅助函数

`config()` 返回以下函数和字段：

*页面函数*：
- `setup(body)`：页面设置（字号、行距、页眉页脚、show 规则），作为 `#show: setup` 调用
- `cover()`：生成封面（根据 `blind` 自动选择正常/盲审版）
- `copyright()`：版权声明页
- `abstract-zh` / `abstract-en`：中英文摘要
- `outline()`：中文目录
- `list-of-figures()` / `list-of-tables()` / `list-of-code()`：插图/表格/代码列表
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
#import "@preview/pku-thesis-pass:0.1.0": booktab, as-booktab, codeblock
```

- `#booktab(...)`：生成三线表，第一行自动加粗为表头，支持 `outlined: false` 生成纯表格
- `#as-booktab(table)`：将原生 `table` 装饰为三线表样式，便于和 `figure` 组合使用
- `#codeblock(...)`：生成带标题和编号的可引用代码块
