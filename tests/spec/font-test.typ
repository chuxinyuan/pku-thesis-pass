// tests/spec/font-test.typ — 字体方案格式规范测试

#import "../../format/utils/font.typ": font-set

// 每套方案都必须包含 5 个核心中文字体条目
#for scheme in (font-set.windows, font-set.macos, font-set.linux) {
  assert(scheme.仿宋.len() > 0, message: "仿宋 missing")
  assert(scheme.宋体.len() > 0, message: "宋体 missing")
  assert(scheme.黑体.len() > 0, message: "黑体 missing")
  assert(scheme.楷体.len() > 0, message: "楷体 missing")
  assert(scheme.代码.len() > 0, message: "代码 missing")
}

// Linux 必须以开源字体为主
#assert(font-set.linux.黑体.contains("Noto Sans CJK SC"), message: "Linux 黑体缺少 Noto Sans CJK SC")
#assert(font-set.linux.楷体.contains("AR PL UKai"), message: "Linux 楷体缺少 AR PL UKai")

= All tests passed
