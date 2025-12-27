# 枚举

## enum ConnectionState

```cangjie
public enum ConnectionState <: Equatable<ConnectionState> {
    | Broken
    | Closed
    | Connecting
    | Connected
}
```

功能：描述与数据源连接的当前状态。

父类型：

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[ConnectionState](#enum-connectionstate)>

### Broken

```cangjie
Broken
```

功能：表示与数据源的连接已中断。只有在 Connected 之后才可能发生这种情况。

### Closed

```cangjie
Closed
```

功能：表示连接对象已关闭。

### Connected

```cangjie
Connected
```

功能：表示连接对象已与数据源连接上。

### Connecting

```cangjie
Connecting
```

功能：表示连接对象正在与数据源连接。

### operator func !=(ConnectionState)

```cangjie
public operator func !=(rhs: ConnectionState): Bool
```

功能：判断数据源连接状态是否不同。

参数：

- rhs: [ConnectionState](database_sql_package_enums.md#enum-connectionstate) - 数据源连接状态。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 传入数据源连接状态与当前状态相同则返回 `false` ，否则返回 `true`。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建两个不同的ConnectionState枚举值
    let state1 = ConnectionState.Broken
    let state2 = ConnectionState.Closed

    // 使用!=操作符比较两个不同的枚举值
    let result1 = state1 != state2
    println("Broken != Closed: ${result1}")

    // 创建两个相同的ConnectionState枚举值
    let state3 = ConnectionState.Connected
    let state4 = ConnectionState.Connected

    // 使用!=操作符比较两个相同的枚举值
    let result2 = state3 != state4
    println("Connected != Connected: ${result2}")
}
```

运行结果：

```text
Broken != Closed: true
Connected != Connected: false
```

### operator func ==(ConnectionState)

```cangjie
public operator func ==(rhs: ConnectionState): Bool
```

功能：判断数据源连接状态是否相同。

参数：

- rhs: [ConnectionState](database_sql_package_enums.md#enum-connectionstate) - 数据源连接状态。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 传入数据源连接状态与当前状态相同则返回 `true` ，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建两个相同的ConnectionState枚举值
    let state1 = ConnectionState.Broken
    let state2 = ConnectionState.Broken

    // 使用==操作符比较两个相同的枚举值
    let result1 = state1 == state2
    println("Broken == Broken: ${result1}")

    // 创建两个不同的ConnectionState枚举值
    let state3 = ConnectionState.Connecting
    let state4 = ConnectionState.Connected

    // 使用==操作符比较两个不同的枚举值
    let result2 = state3 == state4
    println("Connecting == Connected: ${result2}")
}
```

运行结果：

```text
Broken == Broken: true
Connecting == Connected: false
```

## enum TransactionAccessMode

```cangjie
public enum TransactionAccessMode <: ToString & Hashable & Equatable<TransactionAccessMode> {
    | ReadOnly
    | ReadWrite
    | Unspecified
}
```

功能：事务读写模式。

父类型：

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TransactionAccessMode](#enum-transactionaccessmode)>

### ReadOnly

```cangjie
ReadOnly
```

功能：表示只读模式。

### ReadWrite

```cangjie
ReadWrite
```

功能：表示读 + 写模式。

### Unspecified

```cangjie
Unspecified
```

功能：表示未指定的事务读写模式。其行为取决于具体的数据库服务器。

### func hashCode()

```cangjie
public func hashCode(): Int64
```

功能：获取事务读写模式的哈希值。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 事务读写模式的哈希值。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建TransactionAccessMode枚举值
    let mode1 = TransactionAccessMode.ReadOnly
    let mode2 = TransactionAccessMode.ReadWrite
    let mode3 = TransactionAccessMode.Unspecified

    // 调用hashCode()函数获取哈希值
    let hash1 = mode1.hashCode()
    let hash2 = mode2.hashCode()
    let hash3 = mode3.hashCode()

    println("ReadOnly hashCode: ${hash1}")
    println("ReadWrite hashCode: ${hash2}")
    println("Unspecified hashCode: ${hash3}")
}
```

运行结果：

```text
ReadOnly hashCode: 3651810599539534113
ReadWrite hashCode: -370758141246720744
Unspecified hashCode: -7448071844418759893
```

### func toString()

```cangjie
public func toString(): String
```

功能：返回事务读写模式的字符串表示。枚举值和字符串的对应关系如下表所示：

| 枚举值      | 字符串        |
| ----------- | ------------- |
| ReadOnly    | "Read Only"   |
| ReadWrite   | "Read Write"  |
| Unspecified | "Unspecified" |

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 事务读写模式的字符串。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建TransactionAccessMode枚举值
    let mode1 = TransactionAccessMode.ReadOnly
    let mode2 = TransactionAccessMode.ReadWrite
    let mode3 = TransactionAccessMode.Unspecified

    // 调用toString()函数获取字符串表示
    let str1 = mode1.toString()
    let str2 = mode2.toString()
    let str3 = mode3.toString()

    println("ReadOnly toString: \"${str1}\"")
    println("ReadWrite toString: \"${str2}\"")
    println("Unspecified toString: \"${str3}\"")
}
```

运行结果：

```text
ReadOnly toString: "Read Only"
ReadWrite toString: "Read Write"
Unspecified toString: "Unspecified"
```

### operator func !=(TransactionAccessMode)

```cangjie
public operator func != (rhs: TransactionAccessMode): Bool
```

功能：判断两个 [TransactionAccessMode](database_sql_package_enums.md#enum-transactionaccessmode) 是否不相等。

参数：

- rhs: [TransactionAccessMode](database_sql_package_enums.md#enum-transactionaccessmode) - 传入 [TransactionAccessMode](database_sql_package_enums.md#enum-transactionaccessmode) 的枚举值。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果不相等，则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建两个不同的TransactionAccessMode枚举值
    let mode1 = TransactionAccessMode.ReadOnly
    let mode2 = TransactionAccessMode.ReadWrite

    // 使用!=操作符比较两个不同的枚举值
    let result1 = mode1 != mode2
    println("ReadOnly != ReadWrite: ${result1}")

    // 创建两个相同的TransactionAccessMode枚举值
    let mode3 = TransactionAccessMode.Unspecified
    let mode4 = TransactionAccessMode.Unspecified

    // 使用!=操作符比较两个相同的枚举值
    let result2 = mode3 != mode4
    println("Unspecified != Unspecified: ${result2}")
}
```

运行结果：

```text
ReadOnly != ReadWrite: true
Unspecified != Unspecified: false
```

### operator func ==(TransactionAccessMode)

```cangjie
public operator func == (rhs: TransactionAccessMode): Bool
```

功能：判断两个 [TransactionAccessMode](database_sql_package_enums.md#enum-transactionaccessmode) 是否相等。

参数：

- rhs: [TransactionAccessMode](database_sql_package_enums.md#enum-transactionaccessmode) - 传入 [TransactionAccessMode](database_sql_package_enums.md#enum-transactionaccessmode) 的枚举值。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果相等，则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建两个相同的TransactionAccessMode枚举值
    let mode1 = TransactionAccessMode.ReadOnly
    let mode2 = TransactionAccessMode.ReadOnly

    // 使用==操作符比较两个相同的枚举值
    let result1 = mode1 == mode2
    println("ReadOnly == ReadOnly: ${result1}")

    // 创建两个不同的TransactionAccessMode枚举值
    let mode3 = TransactionAccessMode.ReadWrite
    let mode4 = TransactionAccessMode.Unspecified

    // 使用==操作符比较两个不同的枚举值
    let result2 = mode3 == mode4
    println("ReadWrite == Unspecified: ${result2}")
}
```

运行结果：

```text
ReadOnly == ReadOnly: true
ReadWrite == Unspecified: false
```

## enum TransactionDeferrableMode

```cangjie
public enum TransactionDeferrableMode <: ToString & Hashable & Equatable<TransactionDeferrableMode> {
    | Deferrable
    | NotDeferrable
    | Unspecified
}
```

功能：事务的延迟模式。

父类型：

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TransactionDeferrableMode](#enum-transactiondeferrablemode)>

### Deferrable

```cangjie
Deferrable
```

功能：表示可延迟。

> **说明：**
>
> 延迟事务是指在前滚阶段结束时未提交的事务，并且遇到了阻止其回滚的错误。因为事务无法回滚，所以它被延迟。

### NotDeferrable

```cangjie
NotDeferrable
```

功能：表示不可延迟。

### Unspecified

```cangjie
Unspecified
```

功能：未指定的事务延迟模式，其行为取决于具体的数据库服务器。

### func hashCode()

```cangjie
public func hashCode(): Int64
```

功能：获取事务延迟模式的哈希值。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 事务延迟模式的哈希值。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建TransactionDeferrableMode枚举值
    let mode1 = TransactionDeferrableMode.Deferrable
    let mode2 = TransactionDeferrableMode.NotDeferrable
    let mode3 = TransactionDeferrableMode.Unspecified

    // 调用hashCode()函数获取哈希值
    let hash1 = mode1.hashCode()
    let hash2 = mode2.hashCode()
    let hash3 = mode3.hashCode()

    println("Deferrable hashCode: ${hash1}")
    println("NotDeferrable hashCode: ${hash2}")
    println("Unspecified hashCode: ${hash3}")
}
```

运行结果：

```text
Deferrable hashCode: 1616694862690435322
NotDeferrable hashCode: -116461110619119012
Unspecified hashCode: -7448071844418759893
```

### func toString()

```cangjie
public func toString(): String
```

功能：返回事务延迟模式的字符串表示。枚举值和字符串的对应关系如下表所示：

| 枚举值        | 字符串           |
| ------------- | ---------------- |
| Deferrable    | "Deferrable"     |
| NotDeferrable | "Not Deferrable" |
| Unspecified   | "Unspecified"    |

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 事务延迟模式的字符串。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建TransactionDeferrableMode枚举值
    let mode1 = TransactionDeferrableMode.Deferrable
    let mode2 = TransactionDeferrableMode.NotDeferrable
    let mode3 = TransactionDeferrableMode.Unspecified

    // 调用toString()函数获取字符串表示
    let str1 = mode1.toString()
    let str2 = mode2.toString()
    let str3 = mode3.toString()

    println("Deferrable toString: \"${str1}\"")
    println("NotDeferrable toString: \"${str2}\"")
    println("Unspecified toString: \"${str3}\"")
}
```

运行结果：

```text
Deferrable toString: "Deferrable"
NotDeferrable toString: "Not Deferrable"
Unspecified toString: "Unspecified"
```

### operator func !=(TransactionDeferrableMode)

```cangjie
public operator func != (rhs: TransactionDeferrableMode): Bool
```

功能：判断两个 [TransactionDeferrableMode](database_sql_package_enums.md#enum-transactiondeferrablemode) 是否不相等。

参数：

- rhs: [TransactionDeferrableMode](database_sql_package_enums.md#enum-transactiondeferrablemode) - 传入 [TransactionDeferrableMode](database_sql_package_enums.md#enum-transactiondeferrablemode) 的枚举值。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果不相等，则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建两个不同的TransactionDeferrableMode枚举值
    let mode1 = TransactionDeferrableMode.Deferrable
    let mode2 = TransactionDeferrableMode.NotDeferrable

    // 使用!=操作符比较两个不同的枚举值
    let result1 = mode1 != mode2
    println("Deferrable != NotDeferrable: ${result1}")

    // 创建两个相同的TransactionDeferrableMode枚举值
    let mode3 = TransactionDeferrableMode.Unspecified
    let mode4 = TransactionDeferrableMode.Unspecified

    // 使用!=操作符比较两个相同的枚举值
    let result2 = mode3 != mode4
    println("Unspecified != Unspecified: ${result2}")
}
```

运行结果：

```text
Deferrable != NotDeferrable: true
Unspecified != Unspecified: false
```

### operator func ==(TransactionDeferrableMode)

```cangjie
public operator func == (rhs: TransactionDeferrableMode): Bool
```

功能：判断两个 [TransactionDeferrableMode](database_sql_package_enums.md#enum-transactiondeferrablemode) 是否相等。

参数：

- rhs: [TransactionDeferrableMode](database_sql_package_enums.md#enum-transactiondeferrablemode) - 传入 [TransactionDeferrableMode](database_sql_package_enums.md#enum-transactiondeferrablemode) 的枚举值。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果相等，则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建两个相同的TransactionDeferrableMode枚举值
    let mode1 = TransactionDeferrableMode.Deferrable
    let mode2 = TransactionDeferrableMode.Deferrable

    // 使用==操作符比较两个相同的枚举值
    let result1 = mode1 == mode2
    println("Deferrable == Deferrable: ${result1}")

    // 创建两个不同的TransactionDeferrableMode枚举值
    let mode3 = TransactionDeferrableMode.NotDeferrable
    let mode4 = TransactionDeferrableMode.Unspecified

    // 使用==操作符比较两个不同的枚举值
    let result2 = mode3 == mode4
    println("NotDeferrable == Unspecified: ${result2}")
}
```

运行结果：

```text
Deferrable == Deferrable: true
NotDeferrable == Unspecified: false
```

## enum TransactionIsoLevel

```cangjie
public enum TransactionIsoLevel <: ToString & Hashable & Equatable<TransactionIsoLevel> {
    | Chaos
    | Linearizable
    | ReadCommitted
    | ReadUncommitted
    | RepeatableRead
    | Serializable
    | Snapshot
    | Unspecified
}
```

功能：事务隔离级别。

> **说明：**
>
> 事务隔离定义了数据库系统中，一个事务中操作的结果在何时以何种方式对其他并发事务操作可见。

父类型：

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TransactionIsoLevel](#enum-transactionisolevel)>

### Chaos

```cangjie
Chaos
```

功能：表示无法覆盖来自隔离级别更高的事务的挂起更改。

### Linearizable

```cangjie
Linearizable
```

功能：表示事务线性化。

> **说明：**
>
> 区别于串行化（[Serializable]()），线性化主要强调单个对象上（即 db 行或 nosql 记录）的一组单个操作（比如一系列读写操作），线性化保证这些操作严格按真实时间顺序执行。比如当您查看单个对象上的操作子集时，线性化是相关的。

### ReadCommitted

```cangjie
ReadCommitted
```

功能：表示事务等待，直到其他事务写锁定的行被解锁；这将防止它读取任何“脏”数据。

### ReadUncommitted

```cangjie
ReadUncommitted
```

功能：表示事务之间不隔离。

### RepeatableRead

```cangjie
RepeatableRead
```

功能：表示事务可重复读。对同一字段的多次读取结果都是一致的，除非数据是被本身事务自己所修改。

### Serializable

```cangjie
Serializable
```

功能：表示事务可串行化。此隔离级别下，所有事务顺序执行，因此，脏读、不可重复读、幻读都不会出现。

### Snapshot

```cangjie
Snapshot
```

功能：表示快照隔离通过使用行版本控制避免了大多数锁定和阻止。

### Unspecified

```cangjie
Unspecified
```

功能：未指定的事务隔离级别，其行为取决于具体的数据库服务器。

### func hashCode()

```cangjie
public func hashCode(): Int64
```

功能：获取事务隔离级别的哈希值。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 事务隔离级别的哈希值。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建TransactionIsoLevel枚举值
    let level1 = TransactionIsoLevel.Serializable
    let level2 = TransactionIsoLevel.ReadCommitted
    let level3 = TransactionIsoLevel.Unspecified

    // 调用hashCode()函数获取哈希值
    let hash1 = level1.hashCode()
    let hash2 = level2.hashCode()
    let hash3 = level3.hashCode()

    println("Serializable hashCode: ${hash1}")
    println("ReadCommitted hashCode: ${hash2}")
    println("Unspecified hashCode: ${hash3}")
}
```

运行结果：

```text
Serializable hashCode: 4819576074386110657
ReadCommitted hashCode: 4236439733891016631
Unspecified hashCode: -7448071844418759893
```

### func toString()

```cangjie
public func toString(): String
```

功能：返回事务隔离级别的字符串表示。枚举值和字符串的对应关系如下表所示：

| 枚举值          | 字符串             |
| --------------- | ------------------ |
| Chaos           | "Chaos"            |
| Linearizable    | "Linearizable"     |
| ReadCommitted   | "Read Committed"   |
| ReadUncommitted | "Read Uncommitted" |
| RepeatableRead  | "Repeatable Read"  |
| Serializable    | "Serializable"     |
| Snapshot        | "Snapshot"         |
| Unspecified     | "Unspecified"      |

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 事务隔离级别的字符串。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建TransactionIsoLevel枚举值
    let level1 = TransactionIsoLevel.Serializable
    let level2 = TransactionIsoLevel.ReadCommitted
    let level3 = TransactionIsoLevel.Unspecified

    // 调用toString()函数获取字符串表示
    let str1 = level1.toString()
    let str2 = level2.toString()
    let str3 = level3.toString()

    println("Serializable toString: \"${str1}\"")
    println("ReadCommitted toString: \"${str2}\"")
    println("Unspecified toString: \"${str3}\"")
}
```

运行结果：

```text
Serializable toString: "Serializable"
ReadCommitted toString: "Read Committed"
Unspecified toString: "Unspecified"
```

### operator func !=(TransactionIsoLevel)

```cangjie
public operator func != (rhs: TransactionIsoLevel): Bool
```

功能：判断两个 [TransactionIsoLevel](database_sql_package_enums.md#enum-transactionisolevel) 是否不相等。

参数：

- rhs: [TransactionIsoLevel](database_sql_package_enums.md#enum-transactionisolevel) - 传入的 [TransactionIsoLevel](database_sql_package_enums.md#enum-transactionisolevel)。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果不相等，则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建两个不同的TransactionIsoLevel枚举值
    let level1 = TransactionIsoLevel.Serializable
    let level2 = TransactionIsoLevel.ReadCommitted

    // 使用!=操作符比较两个不同的枚举值
    let result1 = level1 != level2
    println("Serializable != ReadCommitted: ${result1}")

    // 创建两个相同的TransactionIsoLevel枚举值
    let level3 = TransactionIsoLevel.Unspecified
    let level4 = TransactionIsoLevel.Unspecified

    // 使用!=操作符比较两个相同的枚举值
    let result2 = level3 != level4
    println("Unspecified != Unspecified: ${result2}")
}
```

运行结果：

```text
Serializable != ReadCommitted: true
Unspecified != Unspecified: false
```

### operator func ==(TransactionIsoLevel)

```cangjie
public operator func == (rhs: TransactionIsoLevel): Bool
```

功能：判断两个 [TransactionIsoLevel](database_sql_package_enums.md#enum-transactionisolevel) 是否相等。

参数：

- rhs: [TransactionIsoLevel](database_sql_package_enums.md#enum-transactionisolevel) - 传入的 [TransactionIsoLevel](database_sql_package_enums.md#enum-transactionisolevel)。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果相等，则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.database.sql.*

main() {
    // 创建两个相同的TransactionIsoLevel枚举值
    let level1 = TransactionIsoLevel.Serializable
    let level2 = TransactionIsoLevel.Serializable

    // 使用==操作符比较两个相同的枚举值
    let result1 = level1 == level2
    println("Serializable == Serializable: ${result1}")

    // 创建两个不同的TransactionIsoLevel枚举值
    let level3 = TransactionIsoLevel.ReadCommitted
    let level4 = TransactionIsoLevel.Unspecified

    // 使用==操作符比较两个不同的枚举值
    let result2 = level3 == level4
    println("ReadCommitted == Unspecified: ${result2}")
}
```

运行结果：

```text
Serializable == Serializable: true
ReadCommitted == Unspecified: false
```
