# Interfaces

## interface ToBytes

```cangjie
public interface ToBytes {
    func toBytes(): Array<UInt8>
}
```

Function: Provides serialization capability for the corresponding type.

### func toBytes()

```cangjie
func toBytes(): Array<UInt8>
```

Function: Provides serialization capability for the corresponding type.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - The serialized byte sequence.

## interface ToTokens

```cangjie
public interface ToTokens {
    func toTokens(): Tokens
}
```

Function: Interface for converting instances of corresponding types to [Tokens](ast_package_classes.md#class-tokens), which must be implemented to support `quote` interpolation operations.

### func toTokens()

```cangjie
func toTokens(): Tokens
```

Function: Converts instances of corresponding types to [Tokens](ast_package_classes.md#class-tokens).

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The converted [Tokens](ast_package_classes.md#class-tokens).

### extend\<T> Array\<T> <: ToTokens

```cangjie
extend<T> Array<T> <: ToTokens
```

Function: Implements conversion from [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> type to [Tokens](ast_package_classes.md#class-tokens) type.

Parent Type:

- [ToTokens](#interface-totokens)

#### func toTokens()

```cangjie
public func toTokens(): Tokens
```

Function: Implements conversion from [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> type to [Tokens](ast_package_classes.md#class-tokens) type, supporting only numeric types, [Rune](../../core/core_package_api/core_package_intrinsics.md#rune), [Bool](../../core/core_package_api/core_package_intrinsics.md#bool), and [String](../../core/core_package_api/core_package_structs.md#struct-string) types.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The converted [Tokens](ast_package_classes.md#class-tokens).

### extend\<T> ArrayList\<T> <: ToTokens

```cangjie
extend<T> ArrayList<T> <: ToTokens
```

Function: Implements conversion from [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<T> type to [Tokens](ast_package_classes.md#class-tokens) type.

Parent Type:

- [ToTokens](#interface-totokens)

#### func toTokens()

```cangjie
public func toTokens(): Tokens
```

Function: Implements conversion from [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt) type to [Tokens](ast_package_classes.md#class-tokens) type. Currently supported types include [Decl](ast_package_classes.md#class-decl), [Node](ast_package_classes.md#class-node), [Constructor](ast_package_classes.md#class-constructor), [Argument](ast_package_classes.md#class-argument), [FuncParam](ast_package_classes.md#class-funcparam), [MatchCase](ast_package_classes.md#class-matchcase), [Modifier](ast_package_classes.md#class-modifier), [Annotation](ast_package_classes.md#class-annotation), [ImportList](ast_package_classes.md#class-importlist), [Pattern](ast_package_classes.md#class-pattern), [TypeNode](ast_package_classes.md#class-typenode), etc.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The converted [Tokens](ast_package_classes.md#class-tokens).

### extend Bool <: ToTokens

```cangjie
extend Bool <: ToTokens
```

Function: Implements conversion from [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) type to [Tokens](ast_package_classes.md#class-tokens) type.

Parent Type:

- [ToTokens](#interface-totokens)

#### func toTokens()

```cangjie
public func toTokens(): Tokens
```

Function: Implements conversion from [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) type to [Tokens](ast_package_classes.md#class-tokens) type.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The converted [Tokens](ast_package_classes.md#class-tokens).

### extend Float16 <: ToTokens

```cangjie
extend Float16 <: ToTokens
```

Function: Implements conversion from [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) type to [Tokens](ast_package_classes.md#class-tokens) type.

Parent Type:

- [ToTokens](#interface-totokens)

#### func toTokens()

```cangjie
public func toTokens(): Tokens
```

Function: Implements conversion from [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) type to [Tokens](ast_package_classes.md#class-tokens) type.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The converted [Tokens](ast_package_classes.md#class-tokens).

### extend Float32 <: ToTokens

```cangjie
extend Float32 <: ToTokens
```

Function: Implements conversion from [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) type to [Tokens](ast_package_classes.md#class-tokens) type.

Parent Type:

- [ToTokens](#interface-totokens)

#### func toTokens()

```cangjie
public func toTokens(): Tokens
```

Function: Implements conversion from [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) type to [Tokens](ast_package_classes.md#class-tokens) type.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The converted [Tokens](ast_package_classes.md#class-tokens).

### extend Float64 <: ToTokens

```cangjie
extend Float64 <: ToTokens
```

Function: Implements conversion from [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) type to [Tokens](ast_package_classes.md#class-tokens) type.

Parent Type:

- [ToTokens](#interface-totokens)

#### func toTokens()

```cangjie
public func toTokens(): Tokens
```

Function: Implements conversion from [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) type to [Tokens](ast_package_classes.md#class-tokens) type.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The converted [Tokens](ast_package_classes.md#class-tokens).

### extend Int16 <: ToTokens

```cangjie
extend Int16 <: ToTokens
```

Function: Implements conversion from [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) type to [Tokens](ast_package_classes.md#class-tokens) type.

Parent Type:

- [ToTokens](#interface-totokens)

#### func toTokens()

```cangjie
public func toTokens(): Tokens
```

Function: Implements conversion from [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) type to [Tokens](ast_package_classes.md#class-tokens) type.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The converted [Tokens](ast_package_classes.md#class-tokens).

### extend Int32 <: ToTokens

```cangjie
extend Int32 <: ToTokens
```

Function: Implements conversion from [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) type to [Tokens](ast_package_classes.md#class-tokens) type.

Parent Type:

- [ToTokens](#interface-totokens)

#### func toTokens()

```cangjie
public func toTokens(): Tokens
```

Function: Implements conversion from [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) type to [Tokens](ast_package_classes.md#class-tokens) type.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The converted [Tokens](ast_package_classes.md#class-tokens).

### extend Int64 <: ToTokens

```cangjie
extend Int64 <: ToTokens
```

Function: Implements conversion from [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) type to [Tokens](ast_package_classes.md#class-tokens) type.

Parent Type:

- [ToTokens](#interface-totokens)

#### func toTokens()

```cangjie
public func toTokens(): Tokens
```

Function: Implements conversion from [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) type to [Tokens](ast_package_classes.md#class-tokens) type.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The converted [Tokens](ast_package_classes.md#class-tokens).

### extend Int8 <: ToTokens

```cangjie
extend Int8 <: ToTokens
```

Function: Implements conversion from [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) type to [Tokens](ast_package_classes.md#class-tokens) type.

Parent Type:

- [ToTokens](#interface-totokens)

#### func toTokens()

```cangjie
public func toTokens(): Tokens
```

Function: Implements conversion from [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) type to [Tokens](ast_package_classes.md#class-tokens) type.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The converted [Tokens](ast_package_classes.md#class-tokens).

### extend Rune <: ToTokens

```cangjie
extend Rune <: ToTokens
```

Function: Implements conversion from [Rune](../../core/core_package_api/core_package_intrinsics.md#rune) type to [Tokens](ast_package_classes.md#class-tokens) type.

Parent Type:

- [ToTokens](#interface-totokens)

#### func toTokens()

```cangjie
public func toTokens(): Tokens
```

Function: Implements conversion from [Rune](../../core/core_package_api/core_package_intrinsics.md#rune) type to [Tokens](ast_package_classes.md#class-tokens) type.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The converted [Tokens](ast_package_classes.md#class-tokens).

### extend String <: ToTokens

```cangjie
extend String <: ToTokens
```

Function: Implements conversion from [String](../../core/core_package_api/core_package_structs.md#struct-string) type to [Tokens](ast_package_classes.md#class-tokens) type.

Parent Type:

- [ToTokens](#interface-totokens)

#### func toTokens()

```cangjie
public func toTokens(): Tokens
```

Function: Implements conversion from [String](../../core/core_package_api/core_package_structs.md#struct-string) type to [Tokens](ast_package_classes.md#class-tokens) type.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The converted [Tokens](ast_package_classes.md#class-tokens).

### extend Token <: ToTokens

```cangjie
extend Token <: ToTokens
```

Function: Implements conversion from [Token](ast_package_structs.md#struct-token) type to [Tokens](ast_package_classes.md#class-tokens) type.

Parent Type:

- [ToTokens](#interface-totokens)

#### func toTokens()

```cangjie
public func toTokens(): Tokens
```

Function: Implements conversion from [Token](ast_package_structs.md#struct-token) type to [Tokens](ast_package_classes.md#class-tokens) type.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The converted [Tokens](ast_package_classes.md#class-tokens).

### extend Tokens <: ToTokens

```cangjie
extend Tokens <: ToTokens
```

Function: Implements conversion from [Tokens](ast_package_classes.md#class-tokens) type to [Tokens](ast_package_classes.md#class-tokens) type.

Parent Type:

- [ToTokens](#interface-totokens)

#### func toTokens()

```cangjie
public func toTokens(): Tokens
```

Function: Implements conversion from [Tokens](ast_package_classes.md#class-tokens) type to [Tokens](ast_package_classes.md#class-tokens) type.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The converted [Tokens](ast_package_classes.md#class-tokens).

### extend UInt16 <: ToTokens

```cangjie
extend UInt16 <: ToTokens
```

Function: Implements conversion from [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) type to [Tokens](ast_package_classes.md#class-tokens) type.

Parent Type:

- [ToTokens](#interface-totokens)

#### func toTokens()

```cangjie
public func toTokens(): Tokens
```

Function: Implements conversion from [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) type to [Tokens](ast_package_classes.md#class-tokens) type.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The converted [Tokens](ast_package_classes.md#class-tokens).### extend UInt32 <: ToTokens

```cangjie
extend UInt32 <: ToTokens
```

Function: Implements conversion from the [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) type to the [Tokens](ast_package_classes.md#class-tokens) type.

Parent Types:

- [ToTokens](#interface-totokens)

#### func toTokens()

```cangjie
public func toTokens(): Tokens
```

Function: Implements conversion from the [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) type to the [Tokens](ast_package_classes.md#class-tokens) type.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The converted [Tokens](ast_package_classes.md#class-tokens).

### extend UInt64 <: ToTokens

```cangjie
extend UInt64 <: ToTokens
```

Function: Implements conversion from the [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) type to the [Tokens](ast_package_classes.md#class-tokens) type.

Parent Types:

- [ToTokens](#interface-totokens)

#### func toTokens()

```cangjie
public func toTokens(): Tokens
```

Function: Implements conversion from the [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) type to the [Tokens](ast_package_classes.md#class-tokens) type.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The converted [Tokens](ast_package_classes.md#class-tokens).

### extend UInt8 <: ToTokens

```cangjie
extend UInt8 <: ToTokens
```

Function: Implements conversion from the [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) type to the [Tokens](ast_package_classes.md#class-tokens) type.

Parent Types:

- [ToTokens](#interface-totokens)

#### func toTokens()

```cangjie
public func toTokens(): Tokens
```

Function: Implements conversion from the [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) type to the [Tokens](ast_package_classes.md#class-tokens) type.

Return Value:

- [Tokens](ast_package_classes.md#class-tokens) - The converted [Tokens](ast_package_classes.md#class-tokens).