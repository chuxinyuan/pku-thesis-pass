// ============================================================
// exports.typ — 包公开 API 出口
// 包入口 lib.typ 直接 re-export 本文件，用户通过
//   #import "@preview/pku-thesis-pass:0.3.0"
// 获取这里声明的全部符号
// ============================================================

/// ----- ///
/// 入口  ///
/// ----- ///

#import "config.typ": config

/// ------- ///
/// 组件  ///
/// ------- ///

#import "components/booktab.typ": booktab, as-booktab, code-preview
#import "components/eqblock.typ": eq-block
#import "components/codeblock.typ": code-block
#import "components/subfigure.typ": subfigure
#import "components/wordcount.typ": word-count-cjk, total-words, total-characters
#import "components/theorem.typ": theorem, definition, lemma, corollary, proposition, property, example, remark, proof