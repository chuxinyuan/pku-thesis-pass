#import "../../format/components.typ": code-block
// 注意：本地测试时保留上一行；发布（typst init 生成工程）时删除上一行，并取消注释下一行
// #import "@preview/pku-thesis-pass:0.3.0": code-block

== 安装与环境配置

Typst 是一个现代化的排版系统，可以通过以下方式使用：

#strong[在线使用]：访问 typst.app，注册账号后即可在线编辑。在线版本无需安装，支持实时预览和协作编辑。

#strong[本地安装]：
- 从 #link("https://github.com/typst/typst/releases")[GitHub Releases] 下载对应平台的可执行文件
- 使用包管理器安装：`brew install typst`（macOS）或 `cargo install typst-cli`（通用）

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
