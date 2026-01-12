# 枚举

## enum CleanupPolicy

```cangjie
public enum CleanupPolicy <: Equatable<CleanupPolicy> {
    | EAGER
    | DEFERRED
}
```

功能：该枚举表示不同的弱引用清理策略，分别为 `EAGER` 和 `DEFERRED`。

在 [WeakRef](ref_package_classes.md#class-weakreft-where-t--object) 类中可以指定对象的清理策略。

父类型：

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[CleanupPolicy](ref_package_enums.md#enum-cleanuppolicy)>

### DEFERRED

```cangjie
DEFERRED
```

功能：指定 [WeakRef](ref_package_classes.md#class-weakreft-where-t--object) 实例的清理策略为 `DEFERRED`，在该清理策略下，GC 会尽可能保证 [WeakRef](ref_package_classes.md#class-weakreft-where-t--object) 中的对象存活，只有当可用内存不足时才回收它。

### EAGER

```cangjie
EAGER
```

功能：指定 [WeakRef](ref_package_classes.md#class-weakreft-where-t--object) 实例的清理策略为 `EAGER`，在该清理策略下，GC 会尽快回收 [WeakRef](ref_package_classes.md#class-weakreft-where-t--object) 指向的对象，但不能保证其立即回收，也不能保证其一定会被回收。

### operator func !=(CleanupPolicy)

```cangjie
public operator func !=(that: CleanupPolicy): Bool
```

功能：对 `Enum CleanupPolicy` 判断是否不等。

参数：

- that: [CleanupPolicy](ref_package_enums.md#enum-cleanuppolicy) - 被比较的枚举实例。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 当前回收策略与 `that` 回收策略不同时返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.ref.CleanupPolicy

main(): Int64 {
    // 创建两个不同的清理策略
    let policy1 = CleanupPolicy.EAGER
    let policy2 = CleanupPolicy.DEFERRED

    // 使用!=操作符比较两个策略
    let result = policy1 != policy2
    println("EAGER != DEFERRED: ${result}")

    // 比较相同的策略
    let result2 = policy1 != policy1
    println("EAGER != EAGER: ${result2}")

    return 0
}
```

运行结果：

```text
EAGER != DEFERRED: true
EAGER != EAGER: false
```

### operator func ==(CleanupPolicy)

```cangjie
public operator func ==(that: CleanupPolicy): Bool
```

功能：对 `Enum CleanupPolicy` 判断是否相等。

参数：

- that: [CleanupPolicy](ref_package_enums.md#enum-cleanuppolicy) - 被比较的枚举实例。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 当前回收策略与 `that` 回收策略相同时返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.ref.CleanupPolicy

main(): Int64 {
    // 创建两个相同的清理策略
    let policy1 = CleanupPolicy.EAGER
    let policy2 = CleanupPolicy.EAGER

    // 使用==操作符比较两个策略
    let result = policy1 == policy2
    println("EAGER == EAGER: ${result}")

    // 比较不同的策略
    let policy3 = CleanupPolicy.DEFERRED
    let result2 = policy1 == policy3
    println("EAGER == DEFERRED: ${result2}")

    return 0
}
```

运行结果：

```text
EAGER == EAGER: true
EAGER == DEFERRED: false
```
