// ============================================================
// font.typ — 字体方案
// ============================================================

// ========== 字体方案 ==========

/// 字体方案：每个条目为一个字体列表，Typst 按顺序依次 Fallback。
/// 按系统分类，config() 的 system 参数可选择不同方案。
#let font-set = (
  // 跨平台通用（优先 Windows 字体，次选 Noto/Source Han，无 macOS 独占字体）
  default: (
    仿宋: ("Times New Roman", "FangSong", "STFangsong", "FandolFang"),
    宋体: ("Times New Roman", "SimSun", "STSong", "Noto Serif CJK SC", "Source Han Serif"),
    黑体: ("Times New Roman", "SimHei", "STHeiti", "WenQuanYi Micro Hei", "Noto Sans CJK SC", "Source Han Sans"),
    楷体: ("Times New Roman", "KaiTi", "STKaiti", "AR PL UKai"),
    代码: ("Consolas", "Courier New", "SimSun", "STSong", "Noto Serif CJK SC", "Source Han Serif"),
  ),

  // Windows：优先 SimSun / SimHei
  windows: (
    仿宋: ("Times New Roman", "FangSong"),
    宋体: ("Times New Roman", "SimSun"),
    黑体: ("Times New Roman", "SimHei"),
    楷体: ("Times New Roman", "KaiTi"),
    代码: ("Consolas", "Courier New", "SimSun"),
  ),

  // macOS：苹果自带字体，精简不留冗余 fallback
  mac: (
    仿宋: ("Times New Roman", "STFangsong"),
    宋体: ("Times New Roman", "STSong"),
    黑体: ("Times New Roman", "PingFang SC", "STHeiti"),
    楷体: ("Times New Roman", "STKaiti"),
    代码: ("Menlo", "Courier New", "STSong"),
  ),

  // Linux：优先 Noto / Source Han，包含 Linux 常见字体
  linux: (
    仿宋: ("Times New Roman", "FandolFang"),
    宋体: ("Times New Roman", "Noto Serif CJK SC", "Source Han Serif"),
    黑体: ("Times New Roman", "WenQuanYi Micro Hei", "Noto Sans CJK SC", "Source Han Sans"),
    楷体: ("Times New Roman", "AR PL UKai"),
    代码: ("DejaVu Sans Mono", "Courier New", "Noto Serif CJK SC", "Source Han Serif"),
  ),
)

/// 向前兼容：未设置 system 时使用 default 方案
#let font = font-set.default
