# Type Aliases

## type Byte

```cangjie
public type Byte = UInt8
```

Function: The [Byte](core_package_types.md#type-byte) type is an alias for the built-in type [UInt8](core_package_intrinsics.md#uint8).

Example：

<!-- verify -->
```cangjie
main() {
    let u8: UInt8 = 10
    let isByte = u8 is Byte
    println("UInt8 is Byte? ${isByte}")
}
```

Execution Result：

```text
UInt8 is Byte? true
```

## type Int

```cangjie
public type Int = Int64
```

Function: The [Int](core_package_types.md#type-int) type is an alias for the built-in type [Int64](core_package_intrinsics.md#int64).

Example：

<!-- verify -->
```cangjie
main() {
    let i64: Int64 = 10
    let isInt = i64 is Int
    println("Int64 is Int? ${isInt}")
}
```

Execution Result：

```text
Int64 is Int? true
```

## type UInt

```cangjie
public type UInt = UInt64
```

Function: The [UInt](core_package_types.md#type-uint) type is an alias for the built-in type [UInt64](core_package_intrinsics.md#uint64).

Example：

<!-- verify -->
```cangjie
main() {
    let u64: UInt64 = 10
    let isUInt = u64 is UInt
    println("UInt64 is UInt? ${isUInt}")
}
```

Execution Result：

```text
UInt64 is UInt? true
```
