# 常量&变量

## let DefaultMemoryOrder <sup>(deprecated)</sup>

```cangjie
public let DefaultMemoryOrder: MemoryOrder = MemoryOrder.SeqCst
```

功能：默认内存顺序，详见枚举 [MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated)。

类型：[MemoryOrder <sup>(deprecated)</sup>](sync_package_enums.md#enum-memoryorder-deprecated)

> **注意：**
>
> 未来版本即将废弃。

示例：

<!-- verify -->
```cangjie
import std.sync.*

main(): Unit {
    // 创建一个 AtomicBool 实例
    let atomicBool = AtomicBool(false)
    println("初始值: ${atomicBool.load()}")

    // 使用 deprecated 的 compareAndSwap 方法（带 MemoryOrder 参数）
    let result = atomicBool.compareAndSwap(false, true, successOrder: DefaultMemoryOrder,
        failureOrder: DefaultMemoryOrder)
    println("使用 deprecated 的 compareAndSwap 方法结果: ${result}")
    println("操作后值: ${atomicBool.load()}")
}
```

运行结果：

```text
初始值: false
使用 deprecated 的 compareAndSwap 方法结果: true
操作后值: true
```