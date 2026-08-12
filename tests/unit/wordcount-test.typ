// tests/wordcount-test.typ — 字数统计模块编译验证

#import "../../format/components/wordcount.typ": word-count-cjk, total-words, total-characters

// Verify exports are defined (non-none)
#assert(word-count-cjk != none)
#assert(total-words != none)
#assert(total-characters != none)

// Word count requires context output; this test confirms compilation

= All tests passed
