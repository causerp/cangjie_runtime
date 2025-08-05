# Interface

## interface Digest

```cangjie
public interface Digest {
    prop size: Int64
    prop blockSize: Int64
    prop algorithm: String
    func write(buffer: Array<Byte>): Unit
    func finish(to!: Array<Byte>): Unit
    func finish(): Array<Byte>
    func reset(): Unit
}
```

Function: Digest algorithm interface. Classes, interfaces, or structs that inherit this interface must comply with the parameter and return value definitions specified in this interface.

### prop algorithm

```cangjie
prop algorithm: String
```

Function: Gets the algorithm name of the digest algorithm.

Type: [String](../../../core/core_package_api/core_package_structs.md#struct-string)

### prop blockSize

```cangjie
prop blockSize: Int64
```

Function: Returns the [Block](../../../ast/ast_package_api/ast_package_classes.md#class-block) length in bytes.

Type: [Int64](../../../core/core_package_api/core_package_intrinsics.md#int64)

### prop size

```cangjie
prop size: Int64
```

Function: Returns the length of the generated digest in bytes.

Type: [Int64](../../../core/core_package_api/core_package_intrinsics.md#int64)

### func finish()

```cangjie
func finish(): Array<Byte>
```

Function: Returns the generated digest value.

Return value:

- [Array](../../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../../core/core_package_api/core_package_types.md#type-byte)> - Returns the generated digest value.

### func finish(Array\<Byte>)

```cangjie
func finish(to!: Array<Byte>): Unit
```

Function: Gets the generated message digest value. Note that after calling finish(), no further digest calculations can be performed. To recalculate, the context must be reset using reset().

Parameters:

- to!: [Array](../../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../../core/core_package_api/core_package_types.md#type-byte)> - Target array.

### func reset()

```cangjie
func reset(): Unit
```

Function: Resets the digest object to its initial state.

### func write(Array\<Byte>)

```cangjie
func write(buffer: Array<Byte>): Unit
```

Function: Updates the digest object with the given buffer.