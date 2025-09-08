# Interfaces

## interface FloatingPoint\<T>

```cangjie
public interface FloatingPoint<T> <: Number<T> {
    static func getE(): T
    static func getInf(): T
    static func getPI(): T
    static func getMinDenormal(): T
    static func getMinNormal(): T
    static func getNaN(): T
    func isInf(): Bool
    func isNaN(): Bool
    func isNormal(): Bool
}
```

Functionality: This interface provides methods related to floating-point numbers.

Parent Types:

- [Number](#interface-numbert)\<T>

### static func getE()

```cangjie
static func getE(): T
```

Functionality: Gets the natural constant (Euler's number) of type T.

Return Value:

- T - The natural constant of type T.

### static func getInf()

```cangjie
static func getInf(): T
```

Functionality: Gets the infinity value for floating-point numbers.

Return Value:

- T - The infinity value of type T.

### static func getPI()

```cangjie
static func getPI(): T
```

Functionality: Gets the pi constant of type T.

Return Value:

- T - The pi constant of type T.

### static func getMinDenormal()

```cangjie
static func getMinDenormal(): T
```

Functionality: Gets the minimum denormal value for single-precision floating-point numbers.

Return Value:

- T - The minimum denormal value of type T.

### static func getMinNormal()

```cangjie
static func getMinNormal(): T
```

Functionality: Gets the minimum normal value for single-precision floating-point numbers.

Return Value:

- T - The minimum normal value of type T.

### static func getNaN()

```cangjie
static func getNaN(): T
```

Functionality: Gets the Not-a-Number (NaN) value for floating-point numbers.

Return Value:

- T - The NaN value of type T.

### func isInf()

```cangjie
func isInf(): Bool
```

Functionality: Determines whether the floating-point number is an infinity value.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the floating-point value is positive or negative infinity; otherwise, returns `false`.

### func isNaN()

```cangjie
func isNaN(): Bool
```

Functionality: Determines whether the floating-point number is a Not-a-Number (NaN) value.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the floating-point value is NaN; otherwise, returns `false`.

### func isNormal()

```cangjie
func isNormal(): Bool
```

Functionality: Determines whether the floating-point number is a normal value.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the floating-point number is normal; otherwise, returns `false`.

### extend Float16 <: FloatingPoint\<Float16>

```cangjie
extend Float16 <: FloatingPoint<Float16>
```

Functionality: Extends the [FloatingPoint\<Float16>](#interface-floatingpointt) interface for the [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) type.

Parent Types:

- [FloatingPoint](#interface-floatingpointt)\<[Float16](../../core/core_package_api/core_package_intrinsics.md#float16)>

#### static func getE()

```cangjie
public static func getE(): Float16
```

Functionality: Gets the natural constant for the half-precision floating-point type.

Return Value:

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - The natural constant of the half-precision floating-point type.

#### static func getInf()

```cangjie
public static func getInf(): Float16
```

Functionality: Gets the infinity value for the half-precision floating-point type.

Return Value:

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - The infinity value of the half-precision floating-point type.

#### static func getPI()

```cangjie
public static func getPI(): Float16
```

Functionality: Gets the pi constant for the half-precision floating-point type.

Return Value:

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - The pi constant of the half-precision floating-point type.

#### static func getMinDenormal()

```cangjie
public static func getMinDenormal(): Float16
```

Functionality: Gets the minimum denormal value for the half-precision floating-point type.

Return Value:

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - The minimum denormal value of the half-precision floating-point type.

#### static func getMinNormal()

```cangjie
public static func getMinNormal(): Float16
```

Functionality: Gets the minimum normal value for the half-precision floating-point type.

Return Value:

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - The minimum normal value of the half-precision floating-point type.

#### static func getNaN()

```cangjie
public static func getNaN(): Float16
```

Functionality: Gets the Not-a-Number (NaN) value for the half-precision floating-point type.

Return Value:

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - The NaN value of the half-precision floating-point type.

### extend Float32 <: FloatingPoint\<Float32>

```cangjie
extend Float32 <: FloatingPoint<Float32>
```

Functionality: Extends the [FloatingPoint\<Float32>](#interface-floatingpointt) interface for the [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) type.

Parent Types:

- [FloatingPoint](#interface-floatingpointt)\<[Float32](../../core/core_package_api/core_package_intrinsics.md#float32)>

#### static func getE()

```cangjie
public static func getE(): Float32
```

Functionality: Gets the natural constant for the single-precision floating-point type.

Return Value:

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - The natural constant of the single-precision floating-point type.

#### static func getInf()

```cangjie
public static func getInf(): Float32
```

Functionality: Gets the infinity value for the single-precision floating-point type.

Return Value:

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - The infinity value of the single-precision floating-point type.

#### static func getPI()

```cangjie
public static func getPI(): Float32
```

Functionality: Gets the pi constant for the single-precision floating-point type.

Return Value:

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - The pi constant of the single-precision floating-point type.

#### static func getMinDenormal()

```cangjie
public static func getMinDenormal(): Float32
```

Functionality: Gets the minimum denormal value for the single-precision floating-point type.

Return Value:

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - The minimum denormal value of the single-precision floating-point type.

#### static func getMinNormal()

```cangjie
public static func getMinNormal(): Float32
```

Functionality: Gets the minimum normal value for the single-precision floating-point type.

Return Value:

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - The minimum normal value of the single-precision floating-point type.

#### static func getNaN()

```cangjie
public static func getNaN(): Float32
```

Functionality: Gets the Not-a-Number (NaN) value for the single-precision floating-point type.

Return Value:

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - The NaN value of the single-precision floating-point type.

### extend Float64 <: FloatingPoint\<Float64>

```cangjie
extend Float64 <: FloatingPoint<Float64>
```

Functionality: Extends the [FloatingPoint\<Float64>](#interface-floatingpointt) interface for the [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) type.

Parent Types:

- [FloatingPoint](#interface-floatingpointt)\<[Float64](../../core/core_package_api/core_package_intrinsics.md#float64)>

#### static func getE()

```cangjie
public static func getE(): Float64
```

Functionality: Gets the natural constant for the double-precision floating-point type.

Return Value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The natural constant of the double-precision floating-point type.

#### static func getInf()

```cangjie
public static func getInf(): Float64
```

Functionality: Gets the infinity value for the double-precision floating-point type.

Return Value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The infinity value of the double-precision floating-point type.

#### static func getPI()

```cangjie
public static func getPI(): Float64
```

Functionality: Gets the pi constant for the double-precision floating-point type.

Return Value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The pi constant of the double-precision floating-point type.

#### static func getMinDenormal()

```cangjie
public static func getMinDenormal(): Float64
```

Functionality: Gets the minimum denormal value for the double-precision floating-point type.

Return Value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The minimum denormal value of the double-precision floating-point type.

#### static func getMinNormal()

```cangjie
public static func getMinNormal(): Float64
```

Functionality: Gets the minimum normal value for the double-precision floating-point type.

Return Value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The minimum normal value of the double-precision floating-point type.

#### static func getNaN()

```cangjie
public static func getNaN(): Float64
```

Functionality: Gets the Not-a-Number (NaN) value for the double-precision floating-point type.

Return Value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The NaN value of the double-precision floating-point type.

## interface Integer\<T>

```cangjie
public interface Integer<T> <: Number<T> {
    static func isSigned(): Bool
    operator func %(rhs: T): T
    operator func &(rhs: T): T
    operator func |(rhs: T): T
    operator func ^(rhs: T): T
    operator func !(): T
    operator func >>(n: Int64): T
    operator func <<(n: Int64): T
}
```

Functionality: This interface provides methods related to integer types.

Parent Types:

- [Number\<T>](#interface-numbert)### static func isSigned()

```cangjie
static func isSigned(): Bool
```

Function: Determines whether the type is signed.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the type is signed; otherwise returns `false`.

### operator func %(T)

```cangjie
operator func %(rhs: T): T
```

Function: Arithmetic operator that calculates the remainder.

Parameters:

- rhs: T - The right-hand side operand representing the divisor.

Return Value:

- T - The calculated remainder.

### operator func &(T)

```cangjie
operator func &(rhs: T): T
```

Function: Bitwise AND operator.

Parameters:

- rhs: T - The right-hand side operand.

Return Value:

- T - The computed result.

### operator func |(T)

```cangjie
operator func |(rhs: T): T
```

Function: Bitwise OR operator.

Parameters:

- rhs: T - The right-hand side operand.

Return Value:

- T - The computed result.

### operator func ^(T)

```cangjie
operator func ^(rhs: T): T
```

Function: Bitwise XOR operator.

Parameters:

- rhs: T - The right-hand side operand.

Return Value:

- T - The computed result.

### operator func !()

```cangjie
operator func !(): T
```

Function: Bitwise NOT operator.

Return Value:

- T - The computed result.

### operator func >>(Int64)

```cangjie
operator func >>(n: Int64): T
```

Function: Bitwise right shift operator.

Parameters:

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The right-hand side operand representing the number of bits to shift.

Return Value:

- T - The computed result.

### operator func <<(Int64)

```cangjie
operator func <<(n: Int64): T
```

Function: Bitwise left shift operator.

Parameters:

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The right-hand side operand representing the number of bits to shift.

Return Value:

- T - The computed result.

### extend Int16 <: Integer\<Int16>

```cangjie
extend Int16 <: Integer<Int16>
```

Function: Extends the [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) type with the [Integer\<T>](#interface-integert) interface.

Parent Type:

- [Integer](#interface-integert)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)>

#### static func isSigned()

```cangjie
public static func isSigned(): Bool
```

Function: Determines whether the [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) type is signed.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Always returns `true`.

### extend Int32 <: Integer\<Int32>

```cangjie
extend Int32 <: Integer<Int32>
```

Function: Extends the [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) type with the [Integer\<T>](#interface-integert) interface.

Parent Type:

- [Integer](#interface-integert)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)>

#### static func isSigned()

```cangjie
public static func isSigned(): Bool
```

Function: Determines whether the [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) type is signed.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Always returns `true`.

### extend Int64 <: Integer\<Int64>

```cangjie
extend Int64 <: Integer<Int64>
```

Function: Extends the [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) type with the [Integer\<T>](#interface-integert) interface.

Parent Type:

- [Integer](#interface-integert)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>

#### static func isSigned()

```cangjie
public static func isSigned(): Bool
```

Function: Determines whether the [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) type is signed.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Always returns `true`.

### extend Int8 <: Integer\<Int8>

```cangjie
extend Int8 <: Integer<Int8>
```

Function: Extends the [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) type with the [Integer\<T>](#interface-integert) interface.

Parent Type:

- [Integer](#interface-integert)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)>

#### static func isSigned()

```cangjie
public static func isSigned(): Bool
```

Function: Determines whether the [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) type is signed.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Always returns `true`.

### extend IntNative <: Integer\<IntNative>

```cangjie
extend IntNative <: Integer<IntNative>
```

Function: Extends the [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) type with the [Integer\<T>](#interface-integert) interface.

Parent Type:

- [Integer](#interface-integert)\<[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)>

#### static func isSigned()

```cangjie
public static func isSigned(): Bool
```

Function: Determines whether the [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) type is signed.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Always returns `true`.

### extend UInt16 <: Integer\<UInt16>

```cangjie
extend UInt16 <: Integer<UInt16>
```

Function: Extends the [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) type with the [Integer\<T>](#interface-integert) interface.

Parent Type:

- [Integer](#interface-integert)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)>

#### static func isSigned()

```cangjie
public static func isSigned(): Bool
```

Function: Determines whether the [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) type is signed.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Always returns `false`.

### extend UInt32 <: Integer\<UInt32>

```cangjie
extend UInt32 <: Integer<UInt32>
```

Function: Extends the [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) type with the [Integer\<T>](#interface-integert) interface.

Parent Type:

- [Integer](#interface-integert)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)>

#### static func isSigned()

```cangjie
public static func isSigned(): Bool
```

Function: Determines whether the [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) type is signed.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Always returns `false`.

### extend UInt64 <: Integer\<UInt64>

```cangjie
extend UInt64 <: Integer<UInt64>
```

Function: Extends the [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) type with the [Integer\<T>](#interface-integert) interface.

Parent Type:

- [Integer](#interface-integert)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)>

#### static func isSigned()

```cangjie
public static func isSigned(): Bool
```

Function: Determines whether the [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) type is signed.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Always returns `false`.

### extend UInt8 <: Integer\<UInt8>

```cangjie
extend UInt8 <: Integer<UInt8>
```

Function: Extends the [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) type with the [Integer\<T>](#interface-integert) interface.

Parent Type:

- [Integer](#interface-integert)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)>

#### static func isSigned()

```cangjie
public static func isSigned(): Bool
```

Function: Determines whether the [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) type is signed.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Always returns `false`.

### extend UIntNative <: Integer\<UIntNative>

```cangjie
extend UIntNative <: Integer<UIntNative>
```

Function: Extends the [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) type with the [Integer\<T>](#interface-integert) interface.

Parent Type:

- [Integer](#interface-integert)\<[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)>

#### static func isSigned()

```cangjie
public static func isSigned(): Bool
```

Function: Determines whether the [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) type is signed.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Always returns `false`.

## interface MathExtension\<T> <sup>(deprecated)</sup>

```cangjie
public interface MathExtension<T> {
    static func GetPI(): T
    static func GetE(): T
}
```

Function: This interface provides unified methods to access certain mathematical constants.

> **Note:**
>
> This will be deprecated in future versions. Use [FloatingPoint\<T>](#interface-floatingpointt) instead.

### static func GetPI()

```cangjie
static func GetPI(): T
```

Function: Retrieves the pi constant for type T.

Return Value:

- T - The pi constant of type T.

### static func GetE()

```cangjie
static func GetE(): T
```

Function: Retrieves the natural constant for type T.

Return Value:

- T - The natural constant of type T.

### extend Float16 <: MathExtension\<Float16>

```cangjie
extend Float16 <: MathExtension<Float16>
```

Function: Extends half-precision floating-point numbers to support certain mathematical constants.

Parent Type:

- [MathExtension <sup>(deprecated)</sup>](#interface-mathextensiont-deprecated)\<[Float16](../../../std/core/core_package_api/core_package_intrinsics.md#float16)>

#### static func GetPI()

```cangjie
public static func GetPI(): Float16
```

Function: Retrieves the pi constant for half-precision floating-point numbers.

Return Value:

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - The pi constant of type Float16.

#### static func GetE()

```cangjie
public static func GetE(): Float16
```

Function: Retrieves the natural constant for half-precision floating-point numbers.

Return Value:

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - The natural constant of type Float16.

### extend Float32 <: MathExtension\<Float32>

```cangjie
extend Float32 <: MathExtension<Float32>
```

Function: Extends single-precision floating-point numbers to support certain mathematical constants.

Parent Type:

- [MathExtension <sup>(deprecated)</sup>](#interface-mathextensiont-deprecated)\<[Float32](../../../std/core/core_package_api/core_package_intrinsics.md#float32)>

#### static func GetPI()

```cangjie
public static func GetPI(): Float32
```

Function: Retrieves the pi constant for single-precision floating-point numbers.

Return Value:

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - The pi constant of type Float32.

#### static func GetE()

```cangjie
public static func GetE(): Float32
```

Function: Retrieves the natural constant for single-precision floating-point numbers.

Return Value:

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - The natural constant of type Float32.

### extend Float64 <: MathExtension\<Float64>

```cangjie
extend Float64 <: MathExtension<Float64>
```

Function: Extends double-precision floating-point numbers to support certain mathematical constants.

Parent Type:

- [MathExtension <sup>(deprecated)</sup>](#interface-mathextensiont-deprecated)\<[Float64](../../../std/core/core_package_api/core_package_intrinsics.md#float64)>

#### static func GetPI()

```cangjie
public static func GetPI(): Float64
```

Function: Retrieves the pi constant for double-precision floating-point numbers.

Return Value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The pi constant of type Float64.

#### static func GetE()

```cangjie
public static func GetE(): Float64
```

Function: Retrieves the natural constant for double-precision floating-point numbers.

Return Value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The natural constant of type Float64.## interface MaxMinValue\<T>

```cangjie
public interface MaxMinValue<T> {
    static func getMax(): T
    static func getMin(): T
}
```

Function: Provides methods to obtain maximum and minimum values.

### static func getMax()

```cangjie
static func getMax(): T
```

Function: Gets the maximum value.

Return value:

- T - The maximum value.

### static func getMin()

```cangjie
static func getMin(): T
```

Function: Gets the minimum value.

Return value:

- T - The minimum value.

### extend Float16 <: MaxMinValue\<Float16>

```cangjie
extend Float16 <: MaxMinValue<Float16>
```

Function: Extends the [MaxMinValue](#interface-maxminvaluet) interface for [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) type.

Parent type:

- [MaxMinValue](#interface-maxminvaluet)\<[Float16](../../core/core_package_api/core_package_intrinsics.md#float16)>

#### static func getMax()

```cangjie
public static func getMax(): Float16
```

Function: Gets the maximum value of [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) type.

Return value:

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - The maximum value of half-precision floating-point type.

#### static func getMin()

```cangjie
public static func getMin(): Float16
```

Function: Gets the minimum value of [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) type.

Return value:

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - The minimum value of half-precision floating-point type.

### extend Float32 <: MaxMinValue\<Float32>

```cangjie
extend Float32 <: MaxMinValue<Float32>
```

Function: Extends the [MaxMinValue](#interface-maxminvaluet) interface for [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) type.

Parent type:

- [MaxMinValue](#interface-maxminvaluet)\<[Float32](../../core/core_package_api/core_package_intrinsics.md#float32)>

#### static func getMax()

```cangjie
public static func getMax(): Float32
```

Function: Gets the maximum value of [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) type.

Return value:

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - The maximum value of single-precision floating-point type.

#### static func getMin()

```cangjie
public static func getMin(): Float32
```

Function: Gets the minimum value of [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) type.

Return value:

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - The minimum value of single-precision floating-point type.

### extend Float64 <: MaxMinValue\<Float64>

```cangjie
extend Float64 <: MaxMinValue<Float64>
```

Function: Extends the [MaxMinValue](#interface-maxminvaluet) interface for [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) type.

Parent type:

- [MaxMinValue](#interface-maxminvaluet)\<[Float64](../../core/core_package_api/core_package_intrinsics.md#float64)>

#### static func getMax()

```cangjie
public static func getMax(): Float64
```

Function: Gets the maximum value of [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) type.

Return value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The maximum value of double-precision floating-point type.

#### static func getMin()

```cangjie
public static func getMin(): Float64
```

Function: Gets the minimum value of [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) type.

Return value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The minimum value of double-precision floating-point type.

### extend Int16 <: MaxMinValue\<Int16>

```cangjie
extend Int16 <: MaxMinValue<Int16>
```

Function: Extends the [MaxMinValue](#interface-maxminvaluet) interface for [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) type.

Parent type:

- [MaxMinValue](#interface-maxminvaluet)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)>

#### static func getMax()

```cangjie
public static func getMax(): Int16
```

Function: Gets the maximum value of [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) type.

Return value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The maximum value of [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) type.

#### static func getMin()

```cangjie
public static func getMin(): Int16
```

Function: Gets the minimum value of [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) type.

Return value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The minimum value of [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) type.

### extend Int32 <: MaxMinValue\<Int32>

```cangjie
extend Int32 <: MaxMinValue<Int32>
```

Function: Extends the [MaxMinValue](#interface-maxminvaluet) interface for [极Int32](../../core/core_package_api/core_package_intrinsics.md#int32) type.

Parent type:

- [MaxMinValue](#interface-maxminvaluet)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)>

#### static func getMax()

```cangjie
public static func getMax(): Int32
```

Function: Gets the maximum value of [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) type.

Return value:

- [Int32](../../core/core_package_api/core_package极rinsics.md#int32) - The maximum value of [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) type.

#### static func getMin()

```cangjie
public static func getMin(): Int32
```

Function: Gets the minimum value of [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) type.

Return value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The minimum value of [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) type.

### extend Int64 <: MaxMinValue\<Int64>

```cangjie
extend Int64 <: MaxMinValue<Int64>
```

Function: Extends the [MaxMinValue](#interface-maxminvaluet) interface for [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) type.

Parent type:

- [MaxMinValue](#interface-maxminvaluet)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>

#### static func getMax()

```cangjie
public static func getMax(): Int64
```

Function: Gets the maximum value of [Int64](../../core/core_package_api/core_package_intrinsics.md#极64) type.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The maximum value of [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) type.

#### static func getMin()

```cangjie
public static func getMin(): Int64
```

Function: Gets the minimum value of [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) type.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The minimum value of [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) type.

### extend Int8 <: MaxMinValue\<Int8>

```cangjie
extend Int8 <: MaxMinValue<Int8>
```

Function: Extends the [MaxMinValue](#interface-maxminvaluet) interface for [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) type.

Parent type:

- [MaxMinValue](#interface-maxminvaluet)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)>

#### static func getMax()

```cangjie
public static func getMax(): Int8
```

Function: Gets the maximum value of [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) type.

Return value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The maximum value of [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) type.

#### static func getMin()

```cangjie
public static func getMin(): Int8
```

Function: Gets the minimum value of [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) type.

Return value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The minimum value of [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) type.

### extend IntNative <: MaxMinValue\<IntNative>

```cangjie
extend IntNative <: MaxMinValue<IntNative>
```

Function: Extends the [MaxMinValue](#interface-maxminvaluet) interface for [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) type.

Parent type:

- [MaxMinValue](#interface-maxminvaluet)\<[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)>

#### static func getMax()

```cangjie
public static func getMax(): IntNative
```

Function: Gets the maximum value of [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) type.

Return value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The maximum value of [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) type.

#### static func getMin()

```cangjie
public static func getMin(): IntNative
```

Function: Gets the minimum value of [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) type.

Return value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The minimum value of [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) type.

### extend UInt16 <: MaxMinValue\<UInt16>

```cangjie
extend UInt极6 <: MaxMinValue<UInt16>
```

Function: Extends the [MaxMinValue](#interface-maxminvaluet) interface for [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) type.

Parent type:

- [MaxMinValue](#interface-maxminvaluet)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)>

#### static func getMax()

```cangjie
public static func getMax(): UInt16
```

Function: Gets the maximum value of [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) type.

Return value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The maximum value of [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) type.

#### static func getMin()

```cangjie
public static func getMin(): UInt16
```

Function: Gets the minimum value of [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) type.

Return value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The minimum value of [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) type.

### extend UInt32 <: MaxMinValue\<UInt32>

```cangjie
extend UInt32 <: MaxMinValue<UInt32>
```

Function: Extends the [MaxMinValue](#interface-maxminvaluet) interface for [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) type.

Parent type:

- [MaxMinValue](#interface-maxminvaluet)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)>

#### static func getMax()

```cangjie
public static func getMax(): UInt32
```

Function: Gets the maximum value of [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) type.

Return value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The maximum value of [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) type.

#### static func getMin()

```cangjie
public static func getMin(): UInt32
```

Function: Gets the minimum value of [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) type.

Return value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The minimum value of [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) type.

### extend UInt64 <: MaxMinValue\<UInt64>

```cangjie
extend UInt64 <: MaxMinValue<UInt64>
```

Function: Extends the [MaxMinValue](#interface-maxminvaluet) interface for [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) type.

Parent type:

- [MaxMinValue](#interface-maxminvaluet)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)>

#### static func getMax()

```cangjie
public static func getMax(): UInt64
```

Function: Gets the maximum value of [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) type.

Return value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The maximum value of [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) type.

#### static func getMin()

```cangjie
public static func getMin(): UInt64
```

Function: Gets the minimum value of [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) type.

Return value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The minimum value of [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) type.

### extend UInt8 <: MaxMinValue\<UInt8>

```cangjie
extend UInt8 <: MaxMinValue<UInt8>
```

Function: Extends the [MaxMinValue](#interface-maxminvaluet) interface for [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) type.

Parent type:

- [MaxMinValue](#interface-maxminvaluet)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)>

#### static func getMax()

```cangjie
public static func getMax(): UInt8
```

Function: Gets the maximum value of [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) type.

Return value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The maximum value of [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) type.

#### static func getMin()

```cangjie
public static func getMin(): UInt8
```

Function: Gets the minimum value of [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) type.

Return value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The minimum value of [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) type.

### extend UIntNative <: MaxMinValue\<UIntNative>

```cangjie
extend UIntNative <: MaxMinValue<UIntNative>
```

Function: Extends the [MaxMinValue](#interface-maxminvaluet) interface for [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) type.

Parent type:

- [MaxMinValue](#interface-maxminvaluet)\<[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)>

#### static func getMax()

```cangjie
public static func getMax(): UIntNative
```

Function: Gets the maximum value of [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) type.

Return value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The maximum value of [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) type.

#### static func getMin()

```cangjie
public static func getMin(): UIntNative
```

Function: Gets the minimum value of [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) type.

Return value## interface Number\<T>

```cangjie
public interface Number<T> {
    operator func +(rhs: T): T
    operator func -(rhs: T): T
    operator func *(rhs: T): T
    operator func /(rhs: T): T
    operator func -(): T
}
```

Function: Provides methods related to numeric types.

### operator func +(T)

```cangjie
operator func +(rhs: T): T
```

Function: Arithmetic operator for addition.

Parameters:

- rhs: T - The number on the right side of the operator, representing another addend.

Return value:

- T - The calculated sum.

### operator func -(T)

```cangjie
operator func -(rhs: T): T
```

Function: Arithmetic operator for subtraction.

Parameters:

- rhs: T - The number on the right side of the operator, representing the subtrahend.

Return value:

- T - The calculated difference.

### operator func *(T)

```cangjie
operator func *(rhs: T): T
```

Function: Arithmetic operator for multiplication.

Parameters:

- rhs: T - The number on the right side of the operator, representing another multiplier.

Return value:

- T - The calculated product.

### operator func /(T)

```cangjie
operator func /(rhs: T): T
```

Function: Arithmetic operator for division.

Parameters:

- rhs: T - The number on the right side of the operator, representing the divisor.

Return value:

- T - The calculated quotient.

### operator func -()

```cangjie
operator func -(): T
```

Function: Arithmetic operator for negation.

Return value:

- T - The negated value.

### extend Float16 <: Number\<Float16>

```cangjie
extend Float16 <: Number<Float16> {}
```

Function: Extends the [Number\<T>](#interface-numbert) interface for the [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) type.

Parent type:

- [Number](#interface-numbert)\<[Float16](../../core/core_package_api/core_package_intrinsics.md#float16)>

### extend Float32 <: Number\<Float32>

```cangjie
extend Float32 <: Number<Float32> {}
```

Function: Extends the [Number\<T>](#interface-numbert) interface for the [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) type.

Parent type:

- [Number](#interface-numbert)\<[Float32](../../core/core_package_api/core_package_intrinsics.md#float32)>

### extend Float64 <: Number\<Float64>

```cangjie
extend Float64 <: Number<Float64> {}
```

Function: Extends the [Number\<T>](#interface-numbert) interface for the [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) type.

Parent type:

- [Number](#interface-numbert)\<[Float64](../../core/core_package_api/core_package_intrinsics.md#float64)>

### extend Int16 <: Number\<Int16>

```cangjie
extend Int16 <: Number<Int16> {}
```

Function: Extends the [Number\<T>](#interface-numbert) interface for the [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) type.

Parent type:

- [Number](#interface-numbert)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)>

### extend Int32 <: Number\<Int32>

```cangjie
extend Int32 <: Number<Int32> {}
```

Function: Extends the [Number\<T>](#interface-numbert) interface for the [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) type.

Parent type:

- [Number](#interface-numbert)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)>

### extend Int64 <: Number\<Int64>

```cangjie
extend Int64 <: Number<Int64> {}
```

Function: Extends the [Number\<T>](#interface-numbert) interface for the [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) type.

Parent type:

- [Number](#interface-numbert)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>

### extend Int8 <: Number\<Int8>

```cangjie
extend Int8 <: Number<Int8> {}
```

Function: Extends the [Number\<T>](#interface-numbert) interface for the [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) type.

Parent type:

- [Number](#interface-numbert)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)>

### extend IntNative <: Number\<IntNative>

```cangjie
extend IntNative <: Number<IntNative> {}
```

Function: Extends the [Number\<T>](#interface-numbert) interface for the [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) type.

Parent type:

- [Number](#interface-numbert)\<[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)>

### extend UInt16 <: Number\<UInt16>

```cangjie
extend UInt16 <: Number<UInt16> {}
```

Function: Extends the [Number\<T>](#interface-numbert) interface for the [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) type.

Parent type:

- [Number](#interface-numbert)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)>

### extend UInt32 <: Number\<UInt32>

```cangjie
extend UInt32 <: Number<UInt32> {}
```

Function: Extends the [Number\<T>](#interface-numbert) interface for the [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) type.

Parent type:

- [Number](#interface-numbert)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)>

### extend UInt64 <: Number\<UInt64>

```cangjie
extend UInt64 <: Number<UInt64> {}
```

Function: Extends the [Number\<T>](#interface-numbert) interface for the [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) type.

Parent type:

- [Number](#interface-numbert)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)>

### extend UInt8 <: Number\<UInt8>

```cangjie
extend UInt8 <: Number<UInt8> {}
```

Function: Extends the [Number\<T>](#interface-numbert) interface for the [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) type.

Parent type:

- [Number](#interface-numbert)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)>

### extend UIntNative <: Number\<UIntNative>

```cangjie
extend UIntNative <: Number<UIntNative> {}
```

Function: Extends the [Number\<T>](#interface-numbert) interface for the [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) type.

Parent type:

- [Number](#interface-numbert)\<[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)>