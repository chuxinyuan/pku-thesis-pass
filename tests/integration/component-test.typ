// tests/integration/component-test.typ — 核心组件渲染集成测试

#import "../../format/lib.typ": booktab, eq-block, code-block, proof

#booktab(columns: 2, caption: [组件测试], [A], [B], [1], [2])
#eq-block(caption: [质能方程])[$ E = m c^2 $]
#code-block(caption: [Hello World], ```python
print("hello")
```)
#proof[证明内容。]

= All tests passed
