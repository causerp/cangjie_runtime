# Interface

## interface Arbitrary\<T>

```cangjie
public interface Arbitrary<T> {
    static func arbitrary(random: RandomSource): Generator<T>
}
```

Function: Interface for generating random values of type T.

### static func arbitrary(RandomSource)

```cangjie
static func arbitrary(random: RandomSource): Generator<T>
```

Function: Obtains a generator for random values of type T.

Parameters:

- random: [RandomSource](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<T> - Generator for random values of type T.

### extend Bool <: Arbitrary\<Bool>

```cangjie
extend Bool <: Arbitrary<Bool>
```

Function: Implements the [Arbitrary](#interface-arbitraryt)\<T> interface for [Bool](../../core/core_package_api/core_package_intrinsics.md#bool).

Parent Type:

- [Arbitrary](#interface-arbitraryt)\<[Bool](../../core/core_package_api/core_package_intrinsics.md#bool)>

#### static func arbitrary(RandomSource)

```cangjie
static func arbitrary(random: RandomSource): Generator<Bool>
```

Function: Obtains a generator for random values of type T.

Parameters:

- random: [RandomSource](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<Bool> - Generator for random Bool values.

### extend Float16 <: Arbitrary\<Float16>

```cangjie
extend Float16 <: Arbitrary<Float16>
```

Function: Implements the [Arbitrary](#interface-arbitraryt)\<T> interface for [Float16](../../core/core_package_api/core_package_intrinsics.md#float16).

Parent Type:

- [Arbitrary](#interface-arbitraryt)\<[Float16](../../core/core_package_api/core_package_intrinsics.md#float16)>

#### static func arbitrary(RandomSource)

```cangjie
static func arbitrary(random: RandomSource): Generator<Float16>
```

Function: Obtains a generator for random values of type T.

Parameters:

- random: [RandomSource](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<Float16> - Generator for random Float16 values.

### extend Float32 <: Arbitrary\<Float32>

```cangjie
extend Float32 <: Arbitrary<Float32>
```

Function: Implements the [Arbitrary](#interface-arbitraryt)\<T> interface for [Float32](../../core/core_package_api/core_package_intrinsics.md#float32).

Parent Type:

- [Arbitrary](#interface-arbitraryt)\<[Float32](../../core/core_package_api/core_package_intrinsics.md#float32)>

#### static func arbitrary(RandomSource)

```cangjie
static func arbitrary(random: RandomSource): Generator<Float32>
```

Function: Obtains a generator for random values of type T.

Parameters:

- random: [RandomSource](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<Float32> - Generator for random Float32 values.

### extend Float64 <: Arbitrary\<Float64>

```cangjie
extend Float64 <: Arbitrary<Float64>
```

Function: Implements the [Arbitrary](#interface-arbitraryt)\<T> interface for [Float64](../../core/core_package_api/core_package_intrinsics.md#float64).

Parent Type:

- [Arbitrary](#interface-arbitraryt)\<[Float64](../../core/core_package_api/core_package_intrinsics.md#float64)>

#### static func arbitrary(RandomSource)

```cangjie
static func arbitrary(random: RandomSource): Generator<Float64>
```

Function: Obtains a generator for random values of type T.

Parameters:

- random: [RandomSource](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<Float64> - Generator for random Float64 values.

### extend Int16 <: Arbitrary\<Int16>

```cangjie
extend Int16 <: Arbitrary<Int16>
```

Function: Implements the [Arbitrary](#interface-arbitraryt)\<T> interface for [Int16](../../core/core_package_api/core_package_intrinsics.md#int16).

Parent Type:

- [Arbitrary](#interface-arbitraryt)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)>- [Arbitrary](#interface-arbitraryt)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)>

#### static func arbitrary(RandomSource)

```cangjie
static func arbitrary(random: RandomSource): Generator<Int16>
```

Function: Obtains a generator for random values of type T.

Parameters:

- random: [RandomSource](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.

Return value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<Int16> - Generator for random values of type Int16.

### extend Int32 <: Arbitrary\<Int32>

```cangjie
extend Int32 <: Arbitrary<Int32>
```

Function: Implements the [Arbitrary](#interface-arbitraryt)\<T> interface for [Int32](../../core/core_package_api/core_package_intrinsics.md#int32).

Parent types:

- [Arbitrary](#interface-arbitraryt)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)>

#### static func arbitrary(RandomSource)

```cangjie
static func arbitrary(random: RandomSource): Generator<Int32>
```

Function: Obtains a generator for random values of type T.

Parameters:

- random: [RandomSource](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.

Return value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<Int32> - Generator for random values of type Int32.

### extend Int64 <: Arbitrary\<Int64>

```cangjie
extend Int64 <: Arbitrary<Int64>
```

Function: Implements the [Arbitrary](#interface-arbitraryt)\<T> interface for [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).

Parent types:

- [Arbitrary](#interface-arbitraryt)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>

#### static func arbitrary(RandomSource)

```cangjie
static func arbitrary(random: RandomSource): Generator<Int64>
```

Function: Obtains a generator for random values of type Int64.

Parameters:

- random: [RandomSource](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.

Return value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<Int64> - Generator for random values of type Int64.

### extend Int8 <: Arbitrary\<Int8>

```cangjie
extend Int8 <: Arbitrary<Int8>
```

Function: Implements the [Arbitrary](#interface-arbitraryt)\<T> interface for [Int8](../../core/core_package_api/core_package_intrinsics.md#int8).

Parent types:

- [Arbitrary](#interface-arbitraryt)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)>

#### static func arbitrary(RandomSource)

```cangjie
static func arbitrary(random: RandomSource): Generator<Int8>
```

Function: Obtains a generator for random values of type Int8.

Parameters:

- random: [RandomSource](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.

Return value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<Int8> - Generator for random values of type Int8.

### extend IntNative <: Arbitrary\<IntNative>

```cangjie
extend IntNative <: Arbitrary<IntNative>
```

Function: Implements the [Arbitrary](#interface-arbitraryt)\<T> interface for [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).

Parent types:

- [Arbitrary](#interface-arbitraryt)\<[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)>

#### static func arbitrary(RandomSource)

```cangjie
static func arbitrary(random: RandomSource): Generator<IntNative>
```

Function: Obtains a generator for random values of type IntNative.

Parameters:

- random: [RandomSource](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.

Return value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<IntNative> - Generator for random values of type IntNative.

### extend Ordering <: Arbitrary\<Ordering>

```cangjie
extend Ordering <: Arbitrary<Ordering>
```

Function: Implements the [Arbitrary](#interface-arbitraryt)\<T> interface for [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).

Parent types:

- [Arbitrary](#interface-arbitraryt)\<[Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering)>

#### static func arbitrary(RandomSource)

```cangjie
static func arbitrary(random: RandomSource): Generator<Ordering>
```

Function: Obtains a generator for random values of type Ordering.Parameters:

- random: [RandomSource](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<Ordering> - Generator for random values of type Ordering.

### extend Rune <: Arbitrary\<Rune>

```cangjie
extend Rune <: Arbitrary<Rune>
```

Function: Implements the [Arbitrary](#interface-arbitraryt)\<T> interface for [Rune](../../core/core_package_api/core_package_intrinsics.md#rune).

Parent Type:

- [Arbitrary](#interface-arbitraryt)\<[Rune](../../core/core_package_api/core_package_intrinsics.md#rune)>

#### static func arbitrary(RandomSource)

```cangjie
static func arbitrary(random: RandomSource): Generator<Rune>
```

Function: Obtains a generator for random values of type Rune.

Parameters:

- random: [RandomSource](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<Rune> - Generator for random values of type Rune.

### extend String <: Arbitrary\<String>

```cangjie
extend String <: Arbitrary<String>
```

Function: Implements the [Arbitrary](#interface-arbitraryt)\<T> interface for [String](../../core/core_package_api/core_package_structs.md#struct-string).

Parent Type:

- [Arbitrary](#interface-arbitraryt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)>

#### static func arbitrary(RandomSource)

```cangjie
static func arbitrary(random: RandomSource): Generator<String>
```

Function: Obtains a generator for random values of type String.

Parameters:

- random: [RandomSource](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<String> - Generator for random values of type String.

### extend UInt16 <: Arbitrary\<UInt16>

```cangjie
extend UInt16 <: Arbitrary<UInt16>
```

Function: Implements the [Arbitrary](#interface-arbitraryt)\<T> interface for [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).

Parent Type:

- [Arbitrary](#interface-arbitraryt)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)>

#### static func arbitrary(RandomSource)

```cangjie
static func arbitrary(random: RandomSource): Generator<UInt16>
```

Function: Obtains a generator for random values of type UInt16.

Parameters:

- random: [RandomSource](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<UInt16> - Generator for random values of type UInt16.

### extend UInt32 <: Arbitrary\<UInt32>

```cangjie
extend UInt32 <: Arbitrary<UInt32>
```

Function: Implements the [Arbitrary](#interface-arbitraryt)\<T> interface for [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).

Parent Type:

- [Arbitrary](#interface-arbitraryt)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)>

#### static func arbitrary(RandomSource)

```cangjie
static func arbitrary(random: RandomSource): Generator<UInt32>
```

Function: Obtains a generator for random values of type UInt32.

Parameters:

- random: [RandomSource](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<UInt32> - Generator for random values of type UInt32.

### extend UInt64 <: Arbitrary\<UInt64>

```cangjie
extend UInt64 <: Arbitrary<UInt64>
```

Function: Implements the [Arbitrary](#interface-arbitraryt)\<T> interface for [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).

Parent Type:

- [Arbitrary](#interface-arbitraryt)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)>

#### static func arbitrary(RandomSource)

```cangjie
static func arbitrary(random: RandomSource): Generator<UInt64>
```

Function: Obtains a generator for random values of type UInt64.

Parameters:

- random: [RandomSource](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<UInt64> - Generator for random values of type UInt64.

### extend UInt8 <: Arbitrary\<UInt8>

```cangjie
extend UInt8 <: Arbitrary<UInt8>
```

Function: Implements the [Arbitrary](#interface-arbitraryt)\<T> interface for [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).

Parent Types:

- [Arbitrary](#interface-arbitraryt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)>

#### static func arbitrary(RandomSource)

```cangjie
static func arbitrary(random: RandomSource): Generator<UInt8>
```

Function: Obtains a generator for random values of type UInt8.

Parameters:

- random: [RandomSource](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<UInt8> - Generator for random values of type UInt8.

### extend UIntNative <: Arbitrary\<UIntNative>

```cangjie
extend UIntNative <: Arbitrary<UIntNative>
```

Function: Implements the [Arbitrary](#interface-arbitraryt)\<T> interface for [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).

Parent Types:

- [Arbitrary](#interface-arbitraryt)\<[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)>

#### static func arbitrary(RandomSource)

```cangjie
static func arbitrary(random: RandomSource): Generator<UIntNative>
```

Function: Obtains a generator for random values of type UIntNative.

Parameters:

- random: [RandomSource](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<UIntNative> - Generator for random values of type UIntNative.

### extend Unit <: Arbitrary\<Unit>

```cangjie
extend Unit <: Arbitrary<Unit>
```

Function: Implements the [Arbitrary](#interface-arbitraryt)\<T> interface for [Unit](../../core/core_package_api/core_package_intrinsics.md#unit).

Parent Types:

- [Arbitrary](#interface-arbitraryt)\<[Unit](../../core/core_package_api/core_package_intrinsics.md#unit)>

#### static func arbitrary(RandomSource)

```cangjie
static func arbitrary(random: RandomSource): Generator<Unit>
```

Function: Obtains a generator for random values of type Unit.

Parameters:

- random: [RandomSource](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<Unit> - Generator for random values of type Unit.

### extend\<T> Array\<T> <: Arbitrary\<Array\<T>> where T <: Arbitrary\<T>

```cangjie
extend<T> Array<T> <: Arbitrary<Array<T>> where T <: Arbitrary<T>
```

Function: Implements the [Arbitrary](#interface-arbitraryt)\<[Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T>> interface for [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T>, where T must implement the [Arbitrary](#interface-arbitraryt)\<T> interface.

Parent Types:

- [Arbitrary](#interface-arbitraryt)\<[Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T>>

#### static func arbitrary(RandomSource)

```cangjie
static func arbitrary(random: RandomSource): Generator<Array<T>>
```

Function: Obtains a generator for random values of type Array\<T>.

Parameters:

- random: [RandomSource](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<Array\<T>> - Generator for random values of type Array\<T>.

### extend\<T> Option\<T> <: Arbitrary\<Option\<T>> where T <: Arbitrary\<T>

```cangjie
extend<T> option<T> <: Arbitrary<Option<T>> where T <: Arbitrary<T>
```

Function: Implements the [Arbitrary](#interface-arbitraryt)\<[Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T>> interface for [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T>, where T must implement the [Arbitrary](#interface-arbitraryt)\<T> interface.

Parent Types:

- [Arbitrary](#interface-arbitraryt)\<[Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T>>

#### static func arbitrary(RandomSource)

```cangjie
static func arbitrary(random: RandomSource): Generator<option<T>>
```

Function: Obtains a generator for random values of type option\<T>.

Parameters:

- random: [RandomSource](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<option\<T>> - Generator for random values of type option\<T>.

### extend\<T> ArrayList\<T> <: Arbitrary\<ArrayList\<T>> where T <: Arbitrary\<T>

```cangjie
extend<T> ArrayList<T> <: Arbitrary<ArrayList<T>> where T <: Arbitrary<T>
```

Function: Implements the [Arbitrary](#interface-arbitraryt) interface for [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<T>, where T must implement the [Arbitrary](#interface-arbitraryt)\<T> interface.

Parent Types:

- [Arbitrary](#interface-arbitraryt)\<[ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<T>>

#### static func arbitrary(RandomSource)

```cangjie
static func arbitrary(random: RandomSource): Generator<ArrayList<T>>
```

Function: Obtains a generator for random values of type ArrayList\<T>.

Parameters:

- random: [RandomSource](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<ArrayList\<T>> - Generator for random values of type ArrayList\<T>.

### extend\<T> HashSet\<T> <: Arbitrary\<HashSet\<T>> where T <: Arbitrary\<T>

```cangjie
extend<T> HashSet<T> <: Arbitrary<HashSet<T>> where T <: Arbitrary<T>
```

Function: Implements the [Arbitrary](#interface-arbitraryt) interface for [HashSet](../../collection/collection_package_api/collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T>, where T must implement the [Arbitrary](#interface-arbitraryt)\<T> interface.

Parent Type:

- [Arbitrary](#interface-arbitraryt)\<[HashSet](../../collection/collection_package_api/collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T>>

#### static func arbitrary(RandomSource)

```cangjie
static func arbitrary(random: RandomSource): Generator<HashSet<T>>
```

Function: Obtains a generator for random values of type HashSet\<T>.

Parameters:

- random: [RandomSource](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<HashSet\<T>> - Generator for random values of type HashSet\<T>.

### extend\<K, V> HashMap\<K, V> <: Arbitrary\<HashMap\<K, V>> where K <: Arbitrary\<K>, V <: Arbitrary\<V>

```cangjie
extend<K, V> HashMap<K, V> <: Arbitrary<HashMap<K, V>> where K <: Arbitrary<K>, V <: Arbitrary<V>
```

Function: Implements the [Arbitrary](#interface-arbitraryt) interface for [HashMap](../../collection/collection_package_api/collection_package_class.md#class-hashmapk-v)\<T>, where T must implement the [Arbitrary](#interface-arbitraryt)\<T> interface.

Parent Type:

- [Arbitrary](#interface-arbitraryt)\<[HashMap](../../collection/collection_package_api/collection_package_class.md#class-hashmapk-v)\<K, V>>

#### static func arbitrary(RandomSource)

```cangjie
static func arbitrary(random: RandomSource): Generator<HashMap<K, V>>
```

Function: Obtains a generator for random values of type HashMap\<K, V>.

Parameters:

- random: [RandomSource](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<HashMap\<K, V>> - Generator for random values of type HashMap\<K, V>.

## interface IndexAccess

```cangjie
public interface IndexAccess {
    func getElementAsAny(index: Int64): ?Any
}
```

Function: Utility interface for accessing tuple elements by index.

### func getElementAsAny(Int64)

```cangjie
func getElementAsAny(index: Int64): ?Any
```

Function: Accesses a tuple element by index.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Index value.

Return Value:

- ?[Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - Element value. Returns `None` if not found.

## interface RandomSource

```cangjie
public interface RandomSource {
    func nextBool(): Bool
    func nextInt8(): Int8
    func nextInt16(): Int16
    func nextInt32(): Int32
    func nextInt64(): Int64
    func nextInt8(max: Int8): Int8
    func nextInt16(max: Int16): Int16
    func nextInt32(max: Int32): Int32
    func nextInt64(max: Int64): Int64
    func nextUInt8(): UInt8
    func nextUInt16(): UInt16
    func nextUInt32(): UInt32
    func nextUInt64(): UInt64
    func nextUInt8(max: UInt8): UInt8
    func nextUInt16(max: UInt16): UInt16
    func nextUInt32(max: UInt32): UInt32
    func nextUInt64(max: UInt64): UInt64
    func nextFloat16(): Float16
    func nextFloat32(): Float32
    func nextFloat64(): Float64
    func nextGaussianFloat64(mean!: Float64, sigma!: Float64): Float64
    func nextIntNative(): IntNative
    func nextUIntNative(): UIntNative

    func suggestUInt8(): UInt8
    func suggestUInt16(): UInt16
    func suggestUInt32(): UInt32
    func suggestUInt64(): UInt64
    func suggestUIntNative(): UIntNative
    func suggestInt8(): Int8
    func suggestInt16(): Int16
    func suggestInt32(): Int32
    func suggestInt64(): Int64
    func suggestIntNative(): IntNative
    func suggestFloat16(): Float16
    func suggestFloat32(): Float32
    func suggestFloat64(): Float64
    func suggestBool(): Bool
    func suggestRune(): Rune
}
```

Function: Provides the capability to generate random primitive type data required by [Arbitrary](#interface-arbitraryt).

### func nextBool()

```cangjie
public open func nextBool(): Bool
```

Function: Obtain a pseudo-random boolean value.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - A pseudo-random number of type [Bool](../../core/core_package_api/core_package_intrinsics.md#bool).

### func nextFloat16()

```cangjie
public open func nextFloat16(): Float16
```

Function: Obtain a pseudo-random number of type [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) within the range [0.0, 1.0).

Return Value:

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - A pseudo-random number of type [Float16](../../core/core_package_api/core_package_intrinsics.md#float16).

### func nextFloat32()

```cangjie
public open func nextFloat32(): Float32
```

Function: Obtain a pseudo-random number of type [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) within the range [0.0, 1.0).

Return Value:

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - A pseudo-random number of type [Float32](../../core/core_package_api/core_package_intrinsics.md#float32).

### func nextFloat64()

```cangjie
public open func nextFloat64(): Float64
```

Function: Obtain a pseudo-random number of type [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) within the range [0.0, 1.0).

Return Value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - A pseudo-random number of type [Float64](../../core/core_package_api/core_package_intrinsics.md#float64).

### func nextGaussianFloat64(Float64, Float64)

```cangjie
public func nextGaussianFloat64(mean!: Float64 = 0.0, sigma!: Float64 = 1.0): Float64
```

Function: Obtain a random number of type [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) that follows a Gaussian distribution with the specified mean and standard deviation.

By default, it returns a random number of type [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) following a Gaussian distribution with mean 0.0 and standard deviation 1.0. The mean represents the expected value (location parameter) determining the distribution's position, while the standard deviation (scale parameter) determines its amplitude. This function calls `nextGaussianFloat64Implement` to obtain the return value. When a subclass inherits [Random](../../random/random_package_api/random_package_classes.md#class-random) and overrides the `nextGaussianFloat64Implement` function, calling this function on the subclass will return the overridden function's result.

Parameters:

- mean!: [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The mean value, default is 0.0.
- sigma!: [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The standard deviation, default is 1.0.

Return Value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - A random number of type [Float64](../../core/core_package_api/core_package_intrinsics.md#float64).

### func nextInt16()

```cangjie
public open func nextInt16(): Int16
```

Function: Obtain a pseudo-random number of type [Int16](../../core/core_package_api/core_package_intrinsics.md#int16).

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - A pseudo-random number of type [Int16](../../core/core_package_api/core_package_intrinsics.md#int16).

### func nextInt16(Int16)

```cangjie
public open func nextInt16(upper: Int16): Int16
```

Function: Obtain a pseudo-random number of type [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) within the range [0, `upper`).

Parameters:

- upper: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The upper bound (exclusive) of the generated pseudo-random number range, with valid values in (0, [Int16](../../core/core_package_api/core_package_intrinsics.md#int16).Max].

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - A pseudo-random number of type [Int16](../../core/core_package_api/core_package_intrinsics.md#int16).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if `upper` is less than or equal to 0.

### func nextInt32()

```cangjie
public open func nextInt32(): Int32
```

Function: Obtain a pseudo-random number of type [Int32](../../core/core_package_api/core_package_intrinsics.md#int32).

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - A pseudo-random number of type [Int32](../../core/core_package_api/core_package_intrinsics.md#int32).

### func nextInt32(Int32)

```cangjie
public open func nextInt32(upper: Int32): Int32
```

Function: Obtain a pseudo-random number of type [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) within the range [0, `upper`).

Parameters:

- upper: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The upper bound (exclusive) of the generated pseudo-random number range, with valid values in (0, [Int32](../../core/core_package_api/core_package_intrinsics.md#int32).Max].

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - A pseudo-random number of type [Int32](../../core/core_package_api/core_package_intrinsics.md#int32).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if `upper` is less than or equal to 0.

### func nextInt64()

```cangjie
public open func nextInt64(): Int64
```

Function: Obtain a pseudo-random number of type [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - A pseudo-random number of type [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).

### func nextInt64(Int64)

```cangjie
public open func nextInt64(upper: Int64): Int64
```

Function: Obtain a pseudo-random number of type [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) within the range [0, `upper`).

Parameters:

- upper: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The upper bound (exclusive) of the generated pseudo-random number range, with valid values in (0, [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).Max].

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - A pseudo-random number of type [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - A pseudorandom number of type [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if `upper` is less than or equal to 0.

### func nextInt8()

```cangjie
public open func nextInt8(): Int8
```

Function: Obtains a pseudorandom number of type [Int8](../../core/core_package_api/core_package_intrinsics.md#int8).

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - A pseudorandom number of type [Int8](../../core/core_package_api/core_package_intrinsics.md#int8).

### func nextInt8(Int8): Int8

```cangjie
public open func nextInt8(upper: Int8): Int8
```

Function: Obtains a pseudorandom number of type [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) within the range [0, `upper`).

Parameters:

- upper: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The upper bound (exclusive) of the generated pseudorandom number range, with valid values in (0, [Int8](../../core/core_package_api/core_package_intrinsics.md#int8).Max].

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - A pseudorandom number of type [Int8](../../core/core_package_api/core_package_intrinsics.md#int8).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if `upper` is less than or equal to 0.

### func nextIntNative():IntNative

```cangjie
public func nextIntNative(): IntNative
```

Function: Obtains a pseudorandom number of type [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).

Return Value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - A pseudorandom number of type [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).

### func nextUInt16()

```cangjie
public open func nextUInt16(): UInt16
```

Function: Obtains a pseudorandom number of type [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - A pseudorandom number of type [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).

### func nextUInt16(UInt16)

```cangjie
public open func nextUInt16(upper: UInt16): UInt16
```

Function: Obtains a pseudorandom number of type [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) within the range [0, `upper`).

Parameters:

- upper: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The upper bound (exclusive) of the generated pseudorandom number range, with valid values in (0, [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).Max].

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - A pseudorandom number of type [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if `upper` equals 0.

### func nextUInt32()

```cangjie
public open func nextUInt32(): UInt32
```

Function: Obtains a pseudorandom number of type [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - A pseudorandom number of type [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).

### func nextUInt32(UInt32)

```cangjie
public open func nextUInt32(upper: UInt32): UInt32
```

Function: Obtains a pseudorandom number of type [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) within the range [0, `upper`).

Parameters:

- upper: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The upper bound (exclusive) of the generated pseudorandom number range, with valid values in (0, [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).Max].

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - A pseudorandom number of type [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if `upper` equals 0.

### func nextUInt64()

```cangjie
public open func nextUInt64(): UInt64
```

Function: Obtains a pseudorandom number of type [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - A pseudorandom number of type [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).

### func nextUInt64(UInt64)

```cangjie
public open func nextUInt64(upper: UInt64): UInt64
```

Function: Obtains a pseudorandom number of type [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) within the range [0, `upper`).

Parameters:

- upper: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The upper bound (exclusive) of the generated pseudorandom number range, with valid values in (0, [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).Max].

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - A pseudorandom number of type [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if `upper` equals 0.

### func nextUInt8()

```cangjie
public open func nextUInt8(): UInt8
```

Function: Generates a pseudo-random number of type [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - A pseudo-random number of type [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).

### func nextUInt8(UInt8)

```cangjie
public open func nextUInt8(upper: UInt8): UInt8
```

Function: Generates a pseudo-random number of type [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) within the range [0, `upper`).

Parameters:

- upper: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The upper bound (exclusive) of the generated pseudo-random number range, with valid values in (0, [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).Max].

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - A pseudo-random number of type [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if `upper` equals 0.

### func nextUIntNative():UIntNative

```cangjie
public func nextUIntNative(): UIntNative
```

Function: Generates a pseudo-random number of type [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - A pseudo-random number of type [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).

### func suggestBool()

```cangjie
public open func suggestBool(): Bool
```

Function: Generates a pseudo-random boolean value.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - A pseudo-random number of type [Bool](../../core/core_package_api/core_package_intrinsics.md#bool).

### func suggestRune()

```cangjie
public open func suggestRune(): Rune
```

Function: Generates a pseudo-random value of type [Rune](../../core/core_package_api/core_package_intrinsics.md#rune).

Return Value:

- [Rune](../../core/core_package_api/core_package_intrinsics.md#rune) - A pseudo-random number of type [Rune](../../core/core_package_api/core_package_intrinsics.md#rune).

### func suggestFloat16()

```cangjie
public open func suggestFloat16(): Float16
```

Function: Generates a pseudo-random number of type [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) within the range [0.0, 1.0).

Return Value:

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - A pseudo-random number of type [Float16](../../core/core_package_api/core_package_intrinsics.md#float16).

### func suggestFloat32()

```cangjie
public open func suggestFloat32(): Float32
```

Function: Generates a pseudo-random number of type [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) within the range [0.0, 1.0).

Return Value:

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - A pseudo-random number of type [Float32](../../core/core_package_api/core_package_intrinsics.md#float32).

### func suggestFloat64()

```cangjie
public open func suggestFloat64(): Float64
```

Function: Generates a pseudo-random number of type [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) within the range [0.0, 1.0).

Return Value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - A pseudo-random number of type [Float64](../../core/core_package_api/core_package_intrinsics.md#float64).

### func suggestInt16()

```cangjie
public open func suggestInt16(): Int16
```

Function: Generates a pseudo-random number of type [Int16](../../core/core_package_api/core_package_intrinsics.md#int16).

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - A pseudo-random number of type [Int16](../../core/core_package_api/core_package_intrinsics.md#int16).

### func suggestInt32()

```cangjie
public open func suggestInt32(): Int32
```

Function: Generates a pseudo-random number of type [Int32](../../core/core_package_api/core_package_intrinsics.md#int32).

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - A pseudo-random number of type [Int32](../../core/core_package_api/core_package_intrinsics.md#int32).

### func suggestInt64()

```cangjie
public open func suggestInt64(): Int64
```

Function: Generates a pseudo-random number of type [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - A pseudo-random number of type [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).

### func suggestInt8()

```cangjie
public open func suggestInt8(): Int8
```

Function: Generates a pseudo-random number of type [Int8](../../core/core_package_api/core_package_intrinsics.md#int8).

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - A pseudo-random number of type [Int8](../../core/core_package_api/core_package_intrinsics.md#int8).

### func suggestIntNative():IntNative

```cangjie
public func suggestIntNative(): IntNative
```

Function: Generates a pseudo-random number of type [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).

Return value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - A pseudo-random number of type [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).

### func suggestUInt16()

```cangjie
public open func suggestUInt16(): UInt16
```

Function: Generates a pseudo-random number of type [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).

Return value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - A pseudo-random number of type [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).

### func suggestUInt32()

```cangjie
public open func suggestUInt32(): UInt32
```

Function: Generates a pseudo-random number of type [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).

Return value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - A pseudo-random number of type [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).

### func suggestUInt64()

```cangjie
public open func suggestUInt64(): UInt64
```

Function: Generates a pseudo-random number of type [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).

Return value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - A pseudo-random number of type [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).

### func suggestUInt8()

```cangjie
public open func suggestUInt8(): UInt8
```

Function: Generates a pseudo-random number of type [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).

Return value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - A pseudo-random number of type [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).

### func suggestUIntNative():UIntNative

```cangjie
public func suggestUIntNative(): UIntNative
```

Function: Generates a pseudo-random number of type [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).

Return value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - A pseudo-random number of type [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).

## interface Shrink\<T>

```cangjie
public interface Shrink<T> {
    func shrink(): Iterable<T>
}
```

Function: Reduces a value of type T to multiple "smaller" values.

### func shrink()

```cangjie
func shrink(): Iterable<T>
```

Function: Shrinks the value into a set of possible "smaller" values.

Return value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - An iterator of possible "smaller" values.

### extend Bool <: Shrink\<Bool>

```cangjie
extend Bool <: Shrink<Bool>
```

Function: Implements the [Shrink](#interface-shrinkt)\<T> interface for [Bool](../../core/core_package_api/core_package_intrinsics.md#bool).

Parent type:

- [Shrink](#interface-shrinkt)\<[Bool](../../core/core_package_api/core_package_intrinsics.md#bool)>

#### func shrink()

```cangjie
func shrink(): Iterable<Bool>
```

Function: Shrinks the value into a set of possible "smaller" values.

Return value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<Bool> - An iterator of possible "smaller" values.

### extend Int16 <: Shrink\<Int16>

```cangjie
extend Int16 <: Shrink<Int16>
```

Function: Implements the [Shrink](#interface-shrinkt)\<T> interface for [Int16](../../core/core_package_api/core_package_intrinsics.md#int16).

Parent type:

- [Shrink](#interface-shrinkt)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)>

#### func shrink()

```cangjie
func shrink(): Iterable<Int16>
```

Function: Shrinks the value into a set of possible "smaller" values.

Return value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<Int16> - An iterator of possible "smaller" values.

### extend Int32 <: Shrink\<Int32>

```cangjie
extend Int32 <: Shrink<Int32>
```

Function: Implements the [Shrink](#interface-shrinkt)\<T> interface for [Int32](../../core/core_package_api/core_package_intrinsics.md#int32).Parent Type:

- [Shrink](#interface-shrinkt)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)>

#### func shrink()

```cangjie
func shrink(): Iterable<Int32>
```

Function: Shrinks this value into a set of possible "smaller" values.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<Int32> - An iterator of possible "smaller" values.

### extend Int64 <: Shrink\<Int64>

```cangjie
extend Int64 <: Shrink<Int64>
```

Function: Implements the [Shrink](#interface-shrinkt)\<T> interface for [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).

Parent Type:

- [Shrink](#interface-shrinkt)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>

#### func shrink()

```cangjie
func shrink(): Iterable<Int64>
```

Function: Shrinks this value into a set of possible "smaller" values.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<Int64> - An iterator of possible "smaller" values.

### extend Int8 <: Shrink\<Int8>

```cangjie
extend Int8 <: Shrink<Int8>
```

Function: Implements the [Shrink](#interface-shrinkt)\<T> interface for [Int8](../../core/core_package_api/core_package_intrinsics.md#int8).

Parent Type:

- [Shrink](#interface-shrinkt)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)>

#### func shrink()

```cangjie
func shrink(): Iterable<Int8>
```

Function: Shrinks this value into a set of possible "smaller" values.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<Int8> - An iterator of possible "smaller" values.

### extend IntNative <: Shrink\<IntNative>

```cangjie
extend IntNative <: Shrink<IntNative>
```

Function: Implements the [Shrink](#interface-shrinkt)\<T> interface for [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).

Parent Type:

- [Shrink](#interface-shrinkt)\<[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)>

#### func shrink()

```cangjie
func shrink(): Iterable<IntNative>
```

Function: Shrinks this value into a set of possible "smaller" values.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<IntNative> - An iterator of possible "smaller" values.

### extend Rune <: Shrink\<Rune>

```cangjie
extend Rune <: Shrink<Rune>
```

Function: Implements the [Shrink](#interface-shrinkt)\<T> interface for [Rune](../../core/core_package_api/core_package_intrinsics.md#rune).

Parent Type:

- [Shrink](#interface-shrinkt)\<[Rune](../../core/core_package_api/core_package_intrinsics.md#rune)>

#### func shrink()

```cangjie
func shrink(): Iterable<Rune>
```

Function: Shrinks this value into a set of possible "smaller" values.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<Rune> - An iterator of possible "smaller" values.

### extend String <: Shrink\<String>

```cangjie
extend String <: Shrink<String>
```

Function: Implements the [Shrink](#interface-shrinkt)\<T> interface for [String](../../core/core_package_api/core_package_structs.md#struct-string).

Parent Type:

- [Shrink](#interface-shrinkt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)>

#### func shrink()

```cangjie
func shrink(): Iterable<String>
```

Function: Shrinks this value into a set of possible "smaller" values.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<String> - An iterator of possible "smaller" values.

### extend UInt16 <: Shrink\<UInt16>

```cangjie
extend UInt16 <: Shrink<UInt16>
```

Function: Implements the [Shrink](#interface-shrinkt)\<T> interface for [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).

Parent Type:

- [Shrink](#interface-shrinkt)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)>

#### func shrink()

```cangjie
func shrink(): Iterable<UInt16>
```

Function: Reduces this value to a set of possible "smaller" values.

Return value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<UInt16> - An iterator of possible "smaller" values.

### extend UInt32 <: Shrink\<UInt32>

```cangjie
extend UInt32 <: Shrink<UInt32>
```

Function: Implements the [Shrink](#interface-shrinkt)\<T> interface for [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).

Parent type:

- [Shrink](#interface-shrinkt)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)>

#### func shrink()

```cangjie
func shrink(): Iterable<UInt32>
```

Function: Reduces this value to a set of possible "smaller" values.

Return value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<UInt32> - An iterator of possible "smaller" values.

### extend UInt64 <: Shrink\<UInt64>

```cangjie
extend UInt64 <: Shrink<UInt64>
```

Function: Implements the [Shrink](#interface-shrinkt)\<T> interface for [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).

Parent type:

- [Shrink](#interface-shrinkt)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)>

#### func shrink()

```cangjie
func shrink(): Iterable<UInt64>
```

Function: Reduces this value to a set of possible "smaller" values.

Return value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<UInt64> - An iterator of possible "smaller" values.

### extend UInt8 <: Shrink\<UInt8>

```cangjie
extend UInt8 <: Shrink<UInt8>
```

Function: Implements the [Shrink](#interface-shrinkt)\<T> interface for [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).

Parent type:

- [Shrink](#interface-shrinkt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)>

#### func shrink()

```cangjie
func shrink(): Iterable<UInt8>
```

Function: Reduces this value to a set of possible "smaller" values.

Return value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<UInt8> - An iterator of possible "smaller" values.

### extend UIntNative <: Shrink\<UIntNative>

```cangjie
extend UIntNative <: Shrink<UIntNative>
```

Function: Implements the [Shrink](#interface-shrinkt)\<T> interface for [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).

Parent type:

- [Shrink](#interface-shrinkt)\<[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)>

#### func shrink()

```cangjie
func shrink(): Iterable<UIntNative>
```

Function: Reduces this value to a set of possible "smaller" values.

Return value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<UIntNative> - An iterator of possible "smaller" values.

### extend Unit <: Shrink\<Unit>

```cangjie
extend Unit <: Shrink<Unit>
```

Function: Implements the [Shrink](#interface-shrinkt)\<T> interface for [Unit](../../core/core_package_api/core_package_intrinsics.md#unit).

Parent type:

- [Shrink](#interface-shrinkt)\<[Unit](../../core/core_package_api/core_package_intrinsics.md#unit)>

#### func shrink()

```cangjie
func shrink(): Iterable<Unit>
```

Function: Reduces this value to a set of possible "smaller" values.

Return value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<Unit> - An iterator of possible "smaller" values.

### extend Float16 <: Shrink\<Float16>

```cangjie
extend Float16 <: Shrink<Float16>
```

Function: Implements the [Shrink](#interface-shrinkt)\<T> interface for [Float16](../../core/core_package_api/core_package_intrinsics.md#float16).

Parent type:

- [Shrink](#interface-shrinkt)\<[Float16](../../core/core_package_api/core_package_intrinsics.md#float16)>

#### func shrink()

```cangjie
func shrink(): Iterable<Float16>
```

Function: Reduces this value to a set of possible "smaller" values.Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<Float16> - An iterator of possible "smaller" values.

### extend Float32 <: Shrink\<Float32>

```cangjie
extend Float32 <: Shrink<Float32>
```

Function: Implements the [Shrink](#interface-shrinkt)\<T> interface for [Float32](../../core/core_package_api/core_package_intrinsics.md#float32).

Parent Types:

- [Shrink](#interface-shrinkt)\<[Float32](../../core/core_package_api/core_package_intrinsics.md#float32)>

#### func shrink()

```cangjie
func shrink(): Iterable<Float32>
```

Function: Shrinks the value to a set of possible "smaller" values.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<Float32> - An iterator of possible "smaller" values.

### extend Float64 <: Shrink\<Float64>

```cangjie
extend Float64 <: Shrink<Float64>
```

Function: Implements the [Shrink](#interface-shrinkt)\<T> interface for [Float64](../../core/core_package_api/core_package_intrinsics.md#float64).

Parent Types:

- [Shrink](#interface-shrinkt)\<[Float64](../../core/core_package_api/core_package_intrinsics.md#float64)>

#### func shrink()

```cangjie
func shrink(): Iterable<Float64>
```

Function: Shrinks the value to a set of possible "smaller" values.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<Float64> - An iterator of possible "smaller" values.

### extend\<T> Array\<T> <: Shrink\<Array\<T>>

```cangjie
extend<T> Array<T> <: Shrink<Array<T>>
```

Function: Implements the [Shrink](#interface-shrinkt)\<[Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T>> interface for [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T>.

Parent Types:

- [Shrink](#interface-shrinkt)\<[Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T>>

#### func shrink()

```cangjie
func shrink(): Iterable<Array<T>>
```

Function: Shrinks the value to a set of possible "smaller" values.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<Array\<T>> - An iterator of possible "smaller" values.

### extend\<T> Option\<T> <: Shrink\<Option\<T>>

```cangjie
extend<T> Option<T> <: Shrink<Option<T>>
```

Function: Implements the [Shrink](#interface-shrinkt)\<[Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T>> interface for [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T>.

Parent Types:

- [Shrink](#interface-shrinkt)\<[Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T>>

#### func shrink()

```cangjie
func shrink(): Iterable<Option<T>>
```

Function: Shrinks the value to a set of possible "smaller" values.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<Option\<T>> - An iterator of possible "smaller" values.

### extend\<T> ArrayList\<T> <: Shrink\<ArrayList\<T>>

```cangjie
extend<T> ArrayList<T> <: Shrink<ArrayList<T>>
```

Function: Implements the [Shrink](#interface-shrinkt)\<[ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<T>> interface for [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<T>.

Parent Types:

- [Shrink](#interface-shrinkt)\<[ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<T>>

#### func shrink()

```cangjie
func shrink(): Iterable<ArrayList<T>>
```

Function: Shrinks the value to a set of possible "smaller" values.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<ArrayList\<T>> - An iterator of possible "smaller" values.

### extend\<T> HashSet\<T> <: Shrink\<HashSet\<T>>

```cangjie
extend<T> HashSet<T> <: Shrink<HashSet<T>>
```

Function: Implements the [Shrink](#interface-shrinkt)\<[HashSet](../../collection/collection_package_api/collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T>> interface for [HashSet](../../collection/collection_package_api/collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T>.

Parent Types:

- [Shrink](#interface-shrinkt)\<[HashSet](../../collection/collection_package_api/collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T>>

#### func shrink()

```cangjie
func shrink(): Iterable<HashSet<T>>
```

Function: Shrinks the value to a set of possible "smaller" values.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<HashSet\<T>> - An iterator of possible "smaller" values.

### extend\<K, V> HashMap\<K, V> <: Shrink\<HashMap\<K, V>>

```cangjie
extend<K, V> HashMap<K, V> <: Shrink<HashMap<K, V>>
```

Function: Implements the [Shrink](#interface-shrinkt)\<[HashMap](../../collection/collection_package_api/collection_package_class.md#class-hashmapk-v)\<T>> interface for [HashMap](../../collection/collection_package_api/collection_package_class.md#class-hashmapk-v)\<T>.

Supertype:

- [Shrink](#interface-shrinkt)\<[HashMap](../../collection/collection_package_api/collection_package_class.md#class-hashmapk-v)\<T>>

#### func shrink()

```cangjie
func shrink(): Iterable<HashMap<K, V>>
```

Function: Reduces this value to a set of possible "smaller" values.

Return value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<HashMap\<K, V>> - An iterator of possible "smaller" values.
