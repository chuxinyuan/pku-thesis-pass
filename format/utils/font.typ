// ============================================================
// font.typ — 字体方案
// ============================================================

// ========== 字体方案 ==========

/// 字体方案：每个条目为一个字体列表，Typst 按顺序依次 Fallback。
/// 按系统分类，config() 的 system 参数可选择不同方案。
#let font-set = (
  // 跨平台通用：优先使用 Windows 字体，Noto / Source Han 等开源字体兜底
  default: (
    仿宋: ("Times New Roman", "FangSong", "STFangsong", "FandolFang R"),
    宋体: ("Times New Roman", "NSimSun", "STSong", "Noto Serif CJK SC", "Source Han Serif"),
    黑体: ("Times New Roman", "SimHei", "STHeiti", "Noto Sans CJK SC", "Source Han Sans"),
    楷体: ("Times New Roman", "KaiTi", "STKaiti", "AR PL UKai"),
    代码: ("Consolas", "DejaVu Sans Mono", "NSimSun", "STSong", "Noto Serif CJK SC", "Source Han Serif"),
    英文衬线: ("Times New Roman", "Liberation Serif"),
    英文无衬线: ("Arial", "Liberation Sans"),
  ),

  // Windows：使用自带字体（FangSong / NSimSun / SimHei / KaiTi）
  windows: (
    仿宋: ("Times New Roman", "FangSong"),
    宋体: ("Times New Roman", "NSimSun"),
    黑体: ("Times New Roman", "SimHei"),
    楷体: ("Times New Roman", "KaiTi"),
    代码: ("Consolas", "NSimSun"),
    英文衬线: ("Times New Roman"),
    英文无衬线: ("Arial"),
  ),

  // macOS：使用苹果电脑自带字体，精简不留冗余 fallback
  mac: (
    仿宋: ("Times New Roman", "STFangsong"),
    宋体: ("Times New Roman", "STSong"),
    黑体: ("Times New Roman", "PingFang SC", "STHeiti"),
    楷体: ("Times New Roman", "STKaiti"),
    代码: ("Menlo", "STSong"),
    英文衬线: ("Times New Roman"),
    英文无衬线: ("Arial"),
  ),

  // Linux：优先使用 Noto / Source Han / Fandol 等常见开源字体
  linux: (
    仿宋: ("Times New Roman", "Liberation Serif", "FandolFang R", "Zhuque Fangsong (technical preview)"),
    宋体: ("Times New Roman", "Liberation Serif", "Noto Serif CJK SC", "Source Han Serif"),
    黑体: ("Times New Roman", "Liberation Serif", "Noto Sans CJK SC", "Source Han Sans"),
    楷体: ("Times New Roman", "Liberation Serif", "AR PL UKai"),
    代码: ("DejaVu Sans Mono", "Noto Serif CJK SC", "Source Han Serif"),
    英文衬线: ("Times New Roman", "Liberation Serif"),
    英文无衬线: ("Arial", "Liberation Sans"),
  ),
)

/// 向前兼容：未设置 system 时使用 default 方案
#let font = font-set.default
