// tests/cli-test.typ — CLI 参数解析单元测试

#import "../../format/config/cli.typ": _parse-bool

#assert.eq(_parse-bool("true", false), true)
#assert.eq(_parse-bool("1", false), true)
#assert.eq(_parse-bool("false", true), false)
#assert.eq(_parse-bool("0", true), false)
#assert.eq(_parse-bool(none, true), true)
#assert.eq(_parse-bool("invalid", false), false)

= All tests passed
