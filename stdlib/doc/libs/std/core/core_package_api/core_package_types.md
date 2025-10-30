# 类型别名

## type Byte

```cangjie
public type Byte = UInt8
```

功能：[Byte](core_package_types.md#type-byte) 类型是内置类型 [UInt8](core_package_intrinsics.md#uint8) 的别名。

示例：

<!-- verify -->
```cangjie
main() {
    let u8: UInt8 = 10
    let isByte = u8 is Byte
    println("UInt8 is Byte? ${isByte}")
}
```

运行结果：

```text
UInt8 is Byte? true
```

## type Int

```cangjie
public type Int = Int64
```

功能：[Int](core_package_types.md#type-int) 类型是内置类型 [Int64](core_package_intrinsics.md#int64) 的别名。

示例：

<!-- verify -->
```cangjie
main() {
    let i64: Int64 = 10
    let isInt = i64 is Int
    println("Int64 is Int? ${isInt}")
}
```

运行结果：

```text
Int64 is Int? true
```

## type UInt

```cangjie
public type UInt = UInt64
```

功能：[UInt](core_package_types.md#type-uint) 类型是内置类型 [UInt64](core_package_intrinsics.md#uint64) 的别名。

示例：

<!-- verify -->
```cangjie
main() {
    let u64: UInt64 = 10
    let isUInt = u64 is UInt
    println("UInt64 is UInt? ${isUInt}")
}
```

运行结果：

```text
UInt64 is UInt? true
```
