# Interface

## interface BlockCipher

```cangjie
public interface BlockCipher {
    prop blockSize: Int64
    prop algorithm: String
    func encrypt(input: Array<Byte>): Array<Byte>
    func decrypt(input: Array<Byte>): Array<Byte>
    func encrypt(input: Array<Byte>, to!: Array<Byte>): Int64
    func decrypt(input: Array<Byte>, to!: Array<Byte>): Int64
}
```

Function: Block cipher algorithm interface. Classes, interfaces, or structs inheriting this interface must comply with the parameter and return value definitions specified in its functions.

### prop algorithm

```cangjie
prop algorithm: String
```

Function: Gets the algorithm name of the block cipher.

Type: [String](../../../core/core_package_api/core_package_structs.md#struct-string)

### prop blockSize

```cangjie
prop blockSize: Int64
```

Function: Block size in bytes.

Type: [Int64](../../../core/core_package_api/core_package_intrinsics.md#int64)

### func encrypt(Array\<Byte>)

```cangjie
func encrypt(input: Array<Byte>): Array<Byte>
```

Function: Provides encryption functionality.

Parameters:

- input: [Array](../../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../../core/core_package_api/core_package_types.md#type-byte)> - Data to be encrypted.

Return Value:

- [Array](../../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../../core/core_package_api/core_package_types.md#type-byte)> - Encrypted result.

### func decrypt(Array\<Byte>)

```cangjie
func decrypt(input: Array<Byte>): Array<Byte>
```

Function: Provides decryption functionality.

Parameters:

- input: [Array](../../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../../core/core_package_api/core_package_types.md#type-byte)> - Data to be decrypted.

Return Value:

- [Array](../../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../../core/core_package_api/core_package_types.md#type-byte)> - Decrypted result.

### func encrypt(Array\<Byte>, Array\<Byte>)

```cangjie
func encrypt(input: Array<Byte>, to!: Array<Byte>): Int64
```

Function: Provides encryption functionality.

Parameters:

- input: [Array](../../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../../core/core_package_api/core_package_types.md#type-byte)> - Data to be encrypted.
- to!: [Array](../../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../../core/core_package_api/core_package_types.md#type-byte)> - Output array.

Return Value:

- [Int64](../../../core/core_package_api/core_package_intrinsics.md#int64) - Output length.

### func decrypt(Array\<Byte>, Array\<Byte>)

```cangjie
func decrypt(input: Array<Byte>,  to!: Array<Byte>): Int64
```

Function: Provides decryption functionality.

Parameters:

- input: [Array](../../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../../core/core_package_api/core_package_types.md#type-byte)> - Data to be decrypted.
- to!: [Array](../../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../../core/core_package_api/core_package_types.md#type-byte)> - Output array.

Return Value:

- [Int64](../../../core/core_package_api/core_package_intrinsics.md#int64) - Output length.