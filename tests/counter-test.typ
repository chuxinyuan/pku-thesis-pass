// tests/counter-test.typ — 计数器定义单元测试

#import "../format/utils/counter.typ": (
  partcounter, chaptercounter, imagecounter, tablecounter, rawcounter,
  equationcounter, theoremcounter, definitioncounter, lemmacounter,
  corollarycounter, propositioncounter, propertycounter, examplecounter,
  remarkcounter, theorem-kinds, skippedstate,
)

// Verify all counter variables are defined
#assert(partcounter != none, message: "partcounter missing")
#assert(chaptercounter != none, message: "chaptercounter missing")
#assert(imagecounter != none, message: "imagecounter missing")
#assert(tablecounter != none, message: "tablecounter missing")
#assert(rawcounter != none, message: "rawcounter missing")
#assert(equationcounter != none, message: "equationcounter missing")

// Verify theorem counters
#assert(theoremcounter != none)
#assert(definitioncounter != none)
#assert(lemmacounter != none)
#assert(corollarycounter != none)
#assert(propositioncounter != none)
#assert(propertycounter != none)
#assert(examplecounter != none)
#assert(remarkcounter != none)

// Verify theorem-kinds array
#assert.eq(theorem-kinds.len(), 8)
#assert(theorem-kinds.contains("theorem"))
#assert(theorem-kinds.contains("definition"))

// Verify skippedstate
#assert(skippedstate != none)

= All tests passed
