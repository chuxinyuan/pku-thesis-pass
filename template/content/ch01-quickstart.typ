#import "../../format/components.typ": code-block, booktab
#import "../../format/style.typ": font-set
// 注意：本地测试时保留上一行；发布（typst init 生成工程）时删除上一行，并取消注释下一行
// #import "@preview/pku-thesis-pass:0.3.0": code-block, booktab, font-set

== 安装与环境配置

Typst 是一个现代化的排版系统，可以通过以下方式使用：

#strong[在线使用]：访问 typst.app，注册账号后即可在线编辑。在线版本无需安装，支持实时预览和协作编辑。

#strong[本地安装]：
- 从 #link("https://github.com/typst/typst/releases")[GitHub Releases] 下载对应平台的可执行文件
- 使用包管理器安装：`brew install typst`（macOS）或 `cargo install typst-cli`（通用），本模板需要 Typst 0.15.0 或更高版本。

  ```bash
  # 查看当前 Typst 版本
  typst --version
  ```

#strong[编辑器支持]：
- VS Code 和 Positron：安装 Tinymist 插件
- Neovim：使用 typst.vim 或 typst-preview.nvim
- 其他编辑器：大多数现代编辑器都有社区维护的 Typst 支持

== 获取模板

=== 方式一：通过 Typst Universe（推荐）

模板已发布到 Typst Universe，可以直接创建新项目：

```bash
typst init @preview/pku-thesis-pass:0.3.0 my-thesis
cd my-thesis
```

这会在 `my-thesis` 目录下创建一个包含 `assets`、`content`、 `ref.bib` 和 `thesis.typ` 的干净项目，你可以通过如下命令编译文档：

```bash
typst compile thesis.typ
```

或使用实时预览模式：

```bash
typst watch thesis.typ
```

自带的 `thesis.typ` 文件，渲染为 `thesis.pdf` 就是一份完整的论文示例文档和用户指南。

=== 方式二：克隆仓库

如果需要完整的源代码对论文模板进行更多的定制，可以克隆仓库：

```bash
git clone https://github.com/chuxinyuan/pku-thesis-pass.git
cd pku-thesis-pass
```

进入 `pku-thesis-pass` 目录后，使用以下命令编译文档：

```bash
typst compile template/thesis.typ --root .
```

无论哪种方式，获取模板后，你都可以直接编辑 `thesis.typ` 文件开始写作。

== 字体配置

本模板的字体配置在 `format/style.typ` 中定义，支持四套字体方案，通过 `system` 参数切换。默认使用跨平台的 `default` 方案：

#booktab(
  width: 100%,
  columns: (auto, 1fr),
  align: (left, left),
  caption: "default 方案字体列表",
  [*用途*],
  [*字体列表*],
  [仿宋],
  [Times New Roman, FangSong, STFangsong],
  [宋体],
  [Times New Roman, SimSun, STSong, Noto Serif CJK SC, Source Han Serif],
  [黑体],
  [Times New Roman, SimHei, STHeiti, Noto Sans CJK SC, Source Han Sans],
  [楷体],
  [Times New Roman, KaiTi, STKaiti, AR PL UKai],
  [代码],
  [Consolas, Courier New, SimSun, STSong, Noto Serif CJK SC, Source Han Serif],
)

其他方案（`mac` / `windows` / `linux`）针对各平台预优化，无冗余 fallback，编译时零 warning。

#strong[注意]：中文粗体默认用黑体显示。如果需要对黑体再额外加粗，或对宋体、楷体等进行加粗，模板已集成 `cuti` 包的伪粗体功能，会自动处理。

=== 字体族校验

下面按当前生效的字体方案（`system: default` 或 `--input system=default`）实时渲染各字体族示例，请核对本机是否正确安装与渲染：

#{
  let sys = sys.inputs.at("system", default: none)
  let fonts = if sys != none {
    font-set.at(sys, default: font-set.default)
  } else { font-set.default }
  let lines = (
    ("仿宋", fonts.仿宋),
    ("宋体", fonts.宋体),
    ("黑体", fonts.黑体),
    ("楷体", fonts.楷体),
    ("代码", fonts.代码),
  )
let fam-cell(fam, normal-sample, bold-sample) = box(width: 100%, {
    set text(font: fam)
    normal-sample
    linebreak()
    bold-sample
  })
  booktab(
    width: 100%,
    columns: (auto, 2fr, 1fr, 1fr),
    align: (left, left, left, left),
    [#strong[字体族]], [#strong[字体列表]], [#strong[中文字形]], [#strong[西文字形]],
    ..(for (name, fam) in lines {
      (
        [#strong[#name]],
        [#fam.join("、")],
        fam-cell(fam, [为中华崛起而读书], [#strong[为中华崛起而读书]]),
        fam-cell(fam, [I love China.], [#strong[I love China.]]),
      )
    }),
    caption: "当前生效的字体族示例",
  )
}

若某字体未安装，Typst 会在该字体族的列表内逐级 fallback，直到命中已安装的字体；若列表中所有字体均缺失，编译时会报 `unknown font family` 警告，可参考下一节「字体警告」的处理方法。

=== 字体警告

如果编译时出现 `unknown font family` 警告，说明系统未安装对应字体。

*解决方案*：
- 使用 `--input system=mac`（macOS）或 `--input system=linux`（Linux）切换到对应平台的精简方案
- 下载对应字体（如思源宋体、思源黑体等）
  - 将字体安装到系统中
  - 或在编译时加上 `--font-path` 参数指定字体文件所在目录
- 开发者可以编辑 `format/style.typ` 中的字体配置

== 基本结构

一个使用本模板的论文文件基本结构如下：

#code-block(
  ```typ
  #import "@preview/pku-thesis-pass:0.3.0": config

  #let (
    setup, cover, copyright, abstract-zh, outline, body-wrap, 
    bibliography, appendix, acknowledgements, declaration,
  ) = config(
    author-zh: "张三",
    title-zh: "论文中文题目",
  )

  #show: setup
  #cover()
  #copyright()

  #abstract-zh(keywords-zh: ("关键词1", "关键词2"))[中文摘要内容...]

  #outline()
  #show: body-wrap
  #show: bibliography

  = 第一章 绪论

  这里是正文内容...

  #appendix()

  = 附录 A 补充材料

  这里是附录内容...

  #acknowledgements[致谢内容...]
  #declaration()
  ```,
  caption: "论文文件基本结构",
)

模板采用 DI（依赖注入）模式：`config()` 返回一组闭包，用户解构后自行编排论文流程，不受固定模板限制。
