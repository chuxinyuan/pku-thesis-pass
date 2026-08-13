// tests/spec/font-test.typ — 字体方案格式规范测试

#import "../../format/utils/font.typ": font-set, fakebold-rules

// 每套方案都必须包含 5 个核心中文字体条目
#for scheme in (font-set.windows, font-set.macos, font-set.linux) {
  assert(scheme.仿宋.len() > 0, message: "仿宋 missing")
  assert(scheme.宋体.len() > 0, message: "宋体 missing")
  assert(scheme.黑体.len() > 0, message: "黑体 missing")
  assert(scheme.楷体.len() > 0, message: "楷体 missing")
  assert(scheme.代码.len() > 0, message: "代码 missing")
}

// 伪粗体策略：true = 该字体无真粗体，需 cuti 描边；false = 有真粗体
// Windows 中文字体（SimHei/NSimSun/KaiTi/FangSong）均为单一字重 → 全部描边
#assert(fakebold-rules.windows.黑体 == true, message: "Windows 黑体 SimHei 无真粗体")
#assert(fakebold-rules.windows.宋体 == true, message: "Windows 宋体 NSimSun 无真粗体")
// macOS 黑体 PingFang SC 有粗体 → 真粗体；宋体 STSong / 楷体 STKaiti 无粗体 → 描边
#assert(fakebold-rules.macos.黑体 == false, message: "macOS 黑体 PingFang SC 有真粗体")
#assert(fakebold-rules.macos.宋体 == true, message: "macOS 宋体 STSong 无真粗体")
// Linux 思源黑体/思源宋体有粗体 → 真粗体；楷体 AR PL UKai / 仿宋 FandolFang 无 → 描边
#assert(fakebold-rules.linux.黑体 == false, message: "Linux 黑体 Source Han Sans 有真粗体")
#assert(fakebold-rules.linux.宋体 == false, message: "Linux 宋体 Source Han Serif 有真粗体")

// Linux 必须以开源字体为主
#assert(font-set.linux.黑体.contains("Noto Sans CJK SC"), message: "Linux 黑体缺少 Noto Sans CJK SC")
#assert(font-set.linux.楷体.contains("AR PL UKai"), message: "Linux 楷体缺少 AR PL UKai")

= All tests passed
