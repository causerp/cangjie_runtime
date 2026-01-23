# 枚举

## enum ModifierInfo

```cangjie
public enum ModifierInfo <: Equatable<ModifierInfo> & Hashable & ToString  {
    | Open
    | Override
    | Redef
    | Abstract
    | Sealed
    | Mut
    | Static
}
```

功能：描述修饰符信息。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 由于开发者通过反射功能获取到的类型信息均来自于 `public` 的类型，这些类型都必定拥有 `public` 的访问控制语义，因此修饰符信息并不包含任何访问控制相关的修饰符。

父类型：

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[ModifierInfo](#enum-modifierinfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### Abstract

```cangjie
Abstract
```

功能：表示 abstract 修饰符。

> **注意：**
>
> 不支持平台：macOS、iOS。

### Mut

```cangjie
Mut
```

功能：表示 mut 修饰符。

> **注意：**
>
> 不支持平台：macOS、iOS。

### Open

```cangjie
Open
```

功能：表示 open 修饰符。

> **注意：**
>
> 不支持平台：macOS、iOS。

### Override

```cangjie
Override
```

功能：表示 override 修饰符。

> **注意：**
>
> 不支持平台：macOS、iOS。

### Redef

```cangjie
Redef
```

功能：表示 redef 修饰符。

> **注意：**
>
> 不支持平台：macOS、iOS。

### Sealed

```cangjie
Sealed
```

功能：表示 sealed 修饰符。

> **注意：**
>
> 不支持平台：macOS、iOS。

### Static

```cangjie
Static
```

功能：表示 static 修饰符。

> **注意：**
>
> 不支持平台：macOS、iOS。

### func hashCode()

```cangjie
public func hashCode(): Int64
```

功能：获取该修饰符信息的哈希值。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 该修饰符信息的哈希值。

> **注意：**
>
> 内部实现为该修饰符关键字字符串的哈希值。

示例：

<!-- verify -->
```cangjie
import std.reflect.ModifierInfo

main(): Int64 {
    // 创建一个 ModifierInfo 枚举值
    let modifier = ModifierInfo.Abstract

    // 获取该修饰符信息的哈希值
    let hash = modifier.hashCode()
    println("Abstract 修饰符的哈希值: ${hash}")

    return 0
}
```

运行结果：

```text
Abstract 修饰符的哈希值: -3361106216383856704
```

### func toString()

```cangjie
public override func toString(): String
```

功能：获取字符串形式的该修饰符信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 字符串形式的该修饰符信息。

> **注意：**
>
> 字符串形式的修饰符信息即为修饰符关键字的标识符。

示例：

<!-- verify -->
```cangjie
import std.reflect.ModifierInfo

main(): Int64 {
    // 创建一个 ModifierInfo 枚举值
    let modifier = ModifierInfo.Open

    // 获取字符串形式的该修饰符信息
    let str = modifier.toString()
    println("Open 修饰符的字符串形式: ${str}")

    return 0
}
```

运行结果：

```text
Open 修饰符的字符串形式: open
```

### operator func !=(ModifierInfo)

```cangjie
public override operator func !=(that: ModifierInfo): Bool
```

功能：判断该修饰符信息与给定的另一个修饰符信息是否不等。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 修饰符信息的相等性的语义等价于 `enum` 类型实例的相等性的语义。

参数：

- that: [ModifierInfo](reflect_package_enums.md#enum-modifierinfo) - 被比较相等性的另一个修饰符信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该修饰符信息与 `that` 不等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.reflect.ModifierInfo

main(): Int64 {
    // 创建两个不同的 ModifierInfo 枚举值
    let modifier1 = ModifierInfo.Open
    let modifier2 = ModifierInfo.Abstract

    // 判断两个修饰符信息是否不等
    let result = modifier1 != modifier2
    println("Open != Abstract: ${result}")

    // 创建两个相同的 ModifierInfo 枚举值
    let modifier3 = ModifierInfo.Open
    let modifier4 = ModifierInfo.Open

    // 判断两个相同的修饰符信息是否不等
    let result2 = modifier3 != modifier4
    println("Open != Open: ${result2}")

    return 0
}
```

运行结果：

```text
Open != Abstract: true
Open != Open: false
```

### operator func ==(ModifierInfo)

```cangjie
public override operator func ==(that: ModifierInfo): Bool
```

功能：判断该修饰符信息与给定的另一个修饰符信息是否相等。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- that: [ModifierInfo](reflect_package_enums.md#enum-modifierinfo) - 被比较相等性的另一个修饰符信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该修饰符信息与 `that` 相等则返回 `true`，否则返回 `false`。

> **注意：**
>
> 修饰符信息的相等性的语义等价于 `enum` 类型实例的相等性的语义。

示例：

<!-- verify -->
```cangjie
import std.reflect.ModifierInfo

main(): Int64 {
    // 创建两个相同的 ModifierInfo 枚举值
    let modifier1 = ModifierInfo.Static
    let modifier2 = ModifierInfo.Static

    // 判断两个修饰符信息是否相等
    let result = modifier1 == modifier2
    println("Static == Static: ${result}")

    // 创建两个不同的 ModifierInfo 枚举值
    let modifier3 = ModifierInfo.Static
    let modifier4 = ModifierInfo.Override

    // 判断两个不同的修饰符信息是否相等
    let result2 = modifier3 == modifier4
    println("Static == Override: ${result2}")

    return 0
}
```

运行结果：

```text
Static == Static: true
Static == Override: false
```
