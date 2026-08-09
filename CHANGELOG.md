# Changelog

## [0.3.0] — 2026-08-09

### 架构重构

- config() 字典访问替代位置解构，消除顺序依赖 ([0fdc2d8])
- config.typ 拆分为 `config/cli.typ` + `config/resolve.typ` ([644ca7a])
- 页面闭包移入 `config/builder.typ`，config.typ 从 497 行瘦身到 186 行 ([31af70d])
- `_make-theorem` 工厂函数消除 8 个定理环境代码重复 ([485a48f])
- 模板文档代码示例全面同步 cfg.xxx 模式 ([be5013c])

### SSOT 样式系统

- 新增 `format/utils/style.typ` 作为全模板样式单一事实来源 ([d0d2d79])
- 全部页面和布局模块迁移到 style.typ 引用 ([083708d])
- `build(font)` 工厂函数连接 font.typ → style.typ ([d2e0c4b])
- `weight` 字段统一由 style.typ 控制，消费者不再硬编码 `strong()` ([6169acb], [1b80e05])
- 清理死 fallback 模式，`s.` → `style.` 直接访问 ([9007cbf])
- 补齐 4 个全死 style.typ 条目（摘要标题、关键词、英文作者信息、版权声明）([5de3868])
- 标题对齐 `set align(center)` → `h-style.align` ([b067aba])
- 标题字体 `text()` 包裹替代 `set text()`，避免外层宋体覆盖 ([2e0b4db])
- 目录字体/行距回归修复 ([422c118])
- 全局 `show: show-cn-fakebold` 替代 `show strong: 黑体` ([d0d2d79])

### 字体方案

- 字体方案三文件同步（font.typ / README / quickstart）([a03e2fb])
- Linux 黑体移除 WenQuanYi 依赖 ([a03e2fb])
- 新增 `英文衬线`、`英文无衬线` 字体条目，统一从 font.typ 出口 ([d2e0c4b])
- Linux 代码字体改用 DejaVu Sans Mono ([df69148])
- 字体校验表通过 system-state 实时渲染当前方案 ([d3adc0a], [b42ab28])

### 新增功能

- 书脊页（`spine-page`）([32369c0])
- 公式列表（`list-of-equations`）([1e353c2])
- 成果页（`achievement-page`）([7d9c041])
- 符号对照表（`notation-page`）([1c33f8b])
- 定理环境 9 种（`_make-theorem` 工厂）([9ca80a1], [485a48f])
- 子图（`subfigure`）([2565aee])
- 公式块（`eq-block`）([1e353c2])
- CJK 字数统计（`word-count-cjk` / `total-words` / `total-characters`）([a35bb41])
- LaTeX 引用兼容（`use-latexref`）([a420895])
- 长表跨页自动续表（重复表头 + "续表"标注）([f87cd7d])

### 模板指南

- FAQ 从 8 条扩展到 13 条 ([b16447c])
- 新增公式三种方案对比 FAQ（`math.equation` / `figure(kind:)` / `eq-block`）([09d434e])
- 新增模块导入参考表（20 个导出模块清单）([b90f4d2])

### 修复

- 表单元格字号 10.5pt → 11pt（对齐 Word 标准）([083708d])
- 页码字号 9pt → 10.5pt（五号 = 10.5pt）([083708d])
- 中文摘要行距校准为 10.5pt ([27fca23])
- `notion` → `notation` 笔误 ([8382c27])

### 工具链

- `scripts/release.py` — 发布/开发模式导入切换 ([bd089ad])
- `scripts/bump.py` — 文档版本号自动同步 ([67fbfc5])
- `scripts/publish.py` — 发布文件收集到 `release/<version>/` ([66b611b])
- `.justfile` — 7 个 recipe（pdf/png/json/preview/dev/bump/publish）([53b90c6])
- `.github/workflows/ci.yml` — 4 变体编译 + GitHub Pages 部署 ([6ab4178])

### 代码质量

- 第三方依赖集中管理（`format/imports.typ`）([15913fa])
- 组件/布局/页面目录化重组 ([a6cf1d5], [2dc7586], [873dc96])
- utils 子模块拆分（font/size/style/supplement/counter/number）([98f2aeb])

---

## [0.2.0] — 2026-08-04

### DI 模式

- `config()` 返回闭包字典，用户可自由编排论文流程 ([07c6ca])
- 跨平台字体方案（`default`/`mac`/`windows`/`linux`）+ `--input system` 切换
- 字体校验表实时渲染（`system-state` 驱动）

### 模板指南

- 扩展为 5 章 + 附录文档（ch01–ch05 + appendix-about）
- 新增 8 条 FAQ
- README 功能特性与配置表格

### 新增

- 学位类型选择框（学术学位 / 专业学位）支持
- 封面校徽与校名字标占位框

---

## [0.1.0] — 2026-07-31

### 初始发布

- 北京大学学位论文 Typst 模板（博士 / 硕士）
- 封面（正常 + 盲审）、版权声明、中英文摘要、目录
- 正文（中英文标题、段落）、参考文献、附录
- 致谢、原创性声明与授权说明
- GB/T 7714 参考文献（2015 / 2025 标准）
- 三线表（`booktab` / `as-booktab`）
- 代码高亮与斑马条纹（codly）
- 中文章节编号（chinesenumbering）
- 盲审模式自动隐藏个人信息
- 命令行参数支持（`blind` / `preview` / `always-start-odd`）
- 跨平台字体 fallback 链
- 模板指南（快速开始 + 基本功能）

[0.3.0]: https://github.com/chuxinyuan/pku-thesis-pass/compare/v0.2.0...main
[0.2.0]: https://github.com/chuxinyuan/pku-thesis-pass/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/chuxinyuan/pku-thesis-pass/releases/tag/v0.1.0
[31af70d]: https://github.com/chuxinyuan/pku-thesis-pass/commit/31af70d
[644ca7a]: https://github.com/chuxinyuan/pku-thesis-pass/commit/644ca7a
[485a48f]: https://github.com/chuxinyuan/pku-thesis-pass/commit/485a48f
[be5013c]: https://github.com/chuxinyuan/pku-thesis-pass/commit/be5013c
[0fdc2d8]: https://github.com/chuxinyuan/pku-thesis-pass/commit/0fdc2d8
[eae6d98]: https://github.com/chuxinyuan/pku-thesis-pass/commit/eae6d98
[5de3868]: https://github.com/chuxinyuan/pku-thesis-pass/commit/5de3868
[b067aba]: https://github.com/chuxinyuan/pku-thesis-pass/commit/b067aba
[422c118]: https://github.com/chuxinyuan/pku-thesis-pass/commit/422c118
[2e0b4db]: https://github.com/chuxinyuan/pku-thesis-pass/commit/2e0b4db
[6169acb]: https://github.com/chuxinyuan/pku-thesis-pass/commit/6169acb
[1b80e05]: https://github.com/chuxinyuan/pku-thesis-pass/commit/1b80e05
[9007cbf]: https://github.com/chuxinyuan/pku-thesis-pass/commit/9007cbf
[083708d]: https://github.com/chuxinyuan/pku-thesis-pass/commit/083708d
[27fca23]: https://github.com/chuxinyuan/pku-thesis-pass/commit/27fca23
[d2e0c4b]: https://github.com/chuxinyuan/pku-thesis-pass/commit/d2e0c4b
[d0d2d79]: https://github.com/chuxinyuan/pku-thesis-pass/commit/d0d2d79
[a03e2fb]: https://github.com/chuxinyuan/pku-thesis-pass/commit/a03e2fb
[d3adc0a]: https://github.com/chuxinyuan/pku-thesis-pass/commit/d3adc0a
[b42ab28]: https://github.com/chuxinyuan/pku-thesis-pass/commit/b42ab28
[df69148]: https://github.com/chuxinyuan/pku-thesis-pass/commit/df69148
[32369c0]: https://github.com/chuxinyuan/pku-thesis-pass/commit/32369c0
[1e353c2]: https://github.com/chuxinyuan/pku-thesis-pass/commit/1e353c2
[7d9c041]: https://github.com/chuxinyuan/pku-thesis-pass/commit/7d9c041
[1c33f8b]: https://github.com/chuxinyuan/pku-thesis-pass/commit/1c33f8b
[9ca80a1]: https://github.com/chuxinyuan/pku-thesis-pass/commit/9ca80a1
[2565aee]: https://github.com/chuxinyuan/pku-thesis-pass/commit/2565aee
[a35bb41]: https://github.com/chuxinyuan/pku-thesis-pass/commit/a35bb41
[a420895]: https://github.com/chuxinyuan/pku-thesis-pass/commit/a420895
[f87cd7d]: https://github.com/chuxinyuan/pku-thesis-pass/commit/f87cd7d
[b16447c]: https://github.com/chuxinyuan/pku-thesis-pass/commit/b16447c
[09d434e]: https://github.com/chuxinyuan/pku-thesis-pass/commit/09d434e
[b90f4d2]: https://github.com/chuxinyuan/pku-thesis-pass/commit/b90f4d2
[8382c27]: https://github.com/chuxinyuan/pku-thesis-pass/commit/8382c27
[bd089ad]: https://github.com/chuxinyuan/pku-thesis-pass/commit/bd089ad
[67fbfc5]: https://github.com/chuxinyuan/pku-thesis-pass/commit/67fbfc5
[66b611b]: https://github.com/chuxinyuan/pku-thesis-pass/commit/66b611b
[53b90c6]: https://github.com/chuxinyuan/pku-thesis-pass/commit/53b90c6
[6ab4178]: https://github.com/chuxinyuan/pku-thesis-pass/commit/6ab4178
[15913fa]: https://github.com/chuxinyuan/pku-thesis-pass/commit/15913fa
[a6cf1d5]: https://github.com/chuxinyuan/pku-thesis-pass/commit/a6cf1d5
[2dc7586]: https://github.com/chuxinyuan/pku-thesis-pass/commit/2dc7586
[873dc96]: https://github.com/chuxinyuan/pku-thesis-pass/commit/873dc96
[98f2aeb]: https://github.com/chuxinyuan/pku-thesis-pass/commit/98f2aeb
