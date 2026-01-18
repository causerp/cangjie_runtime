# 结构体

## struct MemoryInfo <sup>(deprecated)</sup>

```cangjie
public struct MemoryInfo
```

功能：提供获取一些堆内存统计数据的接口。

> **注意：**
>
> 未来版本即将废弃，使用全局函数[getAllocatedHeapSize](./runtime_package_funcs.md#func-getallocatedheapsize)，[getUsedHeapSize](./runtime_package_funcs.md#func-getusedheapsize)，[getMaxHeapSize](./runtime_package_funcs.md#func-getmaxheapsize)替代相关静态属性成员。

### static prop allocatedHeapSize

```cangjie
public static prop allocatedHeapSize: Int64
```

功能：获取仓颉堆已被使用的大小，单位为 byte。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- run -->
```cangjie
import std.runtime.*

main() {
    println("已分配的堆大小: ${MemoryInfo.allocatedHeapSize} bytes")

    return 0
}
```

可能的运行结果：

```text
已分配的堆大小: 2097152 bytes
```

### static prop heapPhysicalMemory

```cangjie
public static prop heapPhysicalMemory: Int64
```

功能：在 Linux、OpenHarmony、HarmonyOS、Android 平台下获取仓颉堆实际占用的物理内存大小, 单位为 byte。在 Windows、macOS、iOS 平台下获取仓颉进程实际占用的物理内存大小, 单位为 byte。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- run -->
```cangjie
import std.runtime.*

main() {
    println("堆物理内存占用: ${MemoryInfo.heapPhysicalMemory} bytes")

    return 0
}
```

可能的运行结果：

```text
堆物理内存占用: 614400 bytes
```

### static prop maxHeapSize

```cangjie
public static prop maxHeapSize: Int64
```

功能：获取仓颉堆可以使用的最大值，单位为 byte。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- run -->
```cangjie
import std.runtime.*

main() {
    println(MemoryInfo.maxHeapSize)
}
```

可能的运行结果：

```text
268435456
```

## struct ProcessorInfo <sup>(deprecated)</sup>

```cangjie
public struct ProcessorInfo
```

功能：提供获取一些处理器信息的接口。

> **注意：**
>
> 未来版本即将废弃，使用[getProcessorCount](./runtime_package_funcs.md#func-getprocessorcount)替代相关静态属性成员。

### static prop processorCount

```cangjie
public static prop processorCount: Int64
```

功能：获取处理器数量。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- run -->
```cangjie
import std.runtime.*

main() {
    println("处理器数量: ${ProcessorInfo.processorCount}")

    return 0
}
```

可能的运行结果：

```text
处理器数量: 16
```

## struct ThreadInfo <sup>(deprecated)</sup>

```cangjie
public struct ThreadInfo
```

功能：提供获取一些仓颉线程统计数据的接口。

> **注意：**
>
> 未来版本即将废弃，使用[getBlockingThreadCount](./runtime_package_funcs.md#func-getblockingthreadcount)，[getNativeThreadCount](./runtime_package_funcs.md#func-getnativethreadcount)， [getThreadCount](./runtime_package_funcs.md#func-getthreadcount) 替代相关静态属性成员。

### static prop blockingThreadCount

```cangjie
public static prop blockingThreadCount: Int64
```

功能：获取阻塞的仓颉线程数。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- run -->
```cangjie
import std.runtime.*

main() {
    println("阻塞的线程数: ${ThreadInfo.blockingThreadCount}")

    return 0
}
```

可能的运行结果：

```text
阻塞的线程数: 0
```

### static prop nativeThreadCount

```cangjie
public static prop nativeThreadCount: Int64
```

功能：获取物理线程数。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- run -->
```cangjie
import std.runtime.*

main() {
    println("物理线程数: ${ThreadInfo.nativeThreadCount}")

    return 0
}
```

可能的运行结果：

```text
物理线程数: 1
```

### static prop threadCount

```cangjie
public static prop threadCount: Int64
```

功能：获取仓颉当前的线程数量。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- run -->
```cangjie
import std.runtime.*

main() {
    println("当前线程数: ${ThreadInfo.threadCount}")

    return 0
}
```

可能的运行结果：

```text
当前线程数: 1
```
