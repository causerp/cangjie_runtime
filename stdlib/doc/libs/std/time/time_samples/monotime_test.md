# 利用 MonoTime 作计时

该示例演示了如何通过 `MonoTime` 类型进行计时。

<!-- run -->
```cangjie
import std.time.*

const count = 10000

main() {
    // 记录开始时间
    let start = MonoTime.now()
    for (_ in 0..count) {
        DateTime.now()
    }
    let end = MonoTime.now()

    // 通过两次 MonoTime 之差计算总耗时
    let elapsed = end - start
    println("总耗时: ${elapsed.toNanoseconds()}ns")
}
```

运行结果（以实际结果为准）

```text
总耗时: 951159ns
```
