# Structures

## struct MemoryInfo <sup>(deprecated)</sup>

```cangjie
public struct MemoryInfo
```

Function: Provides interfaces for obtaining heap memory statistics.

> **Note:**
>
> Will be deprecated in future versions. Use global functions [getAllocatedHeapSize](./runtime_package_funcs.md#func-getallocatedheapsize), [getUsedHeapSize](./runtime_package_funcs.md#func-getusedheapsize), [getMaxHeapSize](./runtime_package_funcs.md#func-getmaxheapsize) to replace related static property members.

### static prop allocatedHeapSize

```cangjie
public static prop allocatedHeapSize: Int64
```

Function: Gets the allocated size of the Cangjie heap in bytes.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### static prop heapPhysicalMemory

```cangjie
public static prop heapPhysicalMemory: Int64
```

Function: On Linux platforms, gets the actual physical memory occupied by the Cangjie heap in bytes. On Windows and macOS platforms, gets the actual physical memory occupied by the Cangjie process in bytes.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### static prop maxHeapSize

```cangjie
public static prop maxHeapSize: Int64
```

Function: Gets the maximum available size of the Cangjie heap in bytes.

Example:

```cangjie
import std.runtime.*
main() {
  println(MemoryInfo.maxHeapSize)
}
```

Execution result (varies by environment):

```text
268435456
```

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

## struct ProcessorInfo <sup>(deprecated)</sup>

```cangjie
public struct ProcessorInfo
```

Function: Provides interfaces for obtaining processor information.

> **Note:**
>
> Will be deprecated in future versions. Use [getProcessorCount](./runtime_package_funcs.md#func-getprocessorcount) to replace related static property members.

### static prop processorCount

```cangjie
public static prop processorCount: Int64
```

Function: Gets the number of processors.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

## struct ThreadInfo <sup>(deprecated)</sup>

```cangjie
public struct ThreadInfo
```

Function: Provides interfaces for obtaining Cangjie thread statistics.

> **Note:**
>
> Will be deprecated in future versions. Use [getBlockingThreadCount](./runtime_package_funcs.md#func-getblockingthreadcount), [getNativeThreadCount](./runtime_package_funcs.md#func-getnativethreadcount), [getThreadCount](./runtime_package_funcs.md#func-getthreadcount) to replace related static property members.

### static prop blockingThreadCount

```cangjie
public static prop blockingThreadCount: Int64
```

Function: Gets the number of blocked Cangjie threads.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### static prop nativeThreadCount

```cangjie
public static prop nativeThreadCount: Int64
```

Function: Gets the number of physical threads.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### static prop threadCount

```cangjie
public static prop threadCount: Int64
```

Function: Gets the current number of Cangjie threads.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)