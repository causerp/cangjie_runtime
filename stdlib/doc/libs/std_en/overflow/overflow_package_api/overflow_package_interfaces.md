# Interface

## interface CarryingOp\<T>

```cangjie
public interface CarryingOp<T> {
  func carryingAdd(y: T): (Bool, T)
  func carryingSub(y: T): (Bool, T)
  func carryingMul(y: T): (Bool, T)
  func carryingDiv(y: T): (Bool, T)
  func carryingMod(y: T): (Bool, T)
  func carryingInc(): (Bool, T)
  func carryingDec(): (Bool, T)
  func carryingNeg(): (Bool, T)
  func carryingShl(y: UInt64): (Bool, T)
  func carryingShr(y: UInt64): (Bool, T)
}
```

Function: Provides an interface that returns whether integer operations resulted in truncation and their computation results.

### func carryingAdd(T)

```cangjie
func carryingAdd(y: T): (Bool, T)
```

Function: Returns a tuple where the first element indicates whether addition operation resulted in truncation (`true` if truncated), and the second element is the computation result.

Parameters:

- y: T - The addend.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), T) - Whether addition resulted in truncation and the computation result.

### func carryingDec()

```cangjie
func carryingDec(): (Bool, T)
```

Function: Returns a tuple where the first element indicates whether decrement operation resulted in truncation (`true` if truncated), and the second element is the computation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), T) - Whether decrement resulted in truncation and the computation result.

### func carryingDiv(T)

```cangjie
func carryingDiv(y: T): (Bool, T)
```

Function: Returns a tuple where the first element indicates whether division operation resulted in truncation (`true` if truncated), and the second element is the computation result.

Parameters:

- y: T - The divisor.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), T) - Whether division resulted in truncation and the computation result.

### func carryingInc()

```cangjie
func carryingInc(): (Bool, T)
```

Function: Returns a tuple where the first element indicates whether increment operation resulted in truncation (`true` if truncated), and the second element is the computation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), T) - Whether increment resulted in truncation and the computation result.

### func carryingMod(T)

```cangjie
func carryingMod(y: T): (Bool, T)
```

Function: Returns a tuple where the first element indicates whether modulo operation resulted in truncation (`true` if truncated), and the second element is the computation result.

Parameters:

- y: T - The divisor.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), T) - Whether modulo resulted in truncation and the computation result.

### func carryingMul(T)

```cangjie
func carryingMul(y: T): (Bool, T)
```

Function: Returns a tuple where the first element indicates whether multiplication operation resulted in truncation (`true` if truncated), and the second element is the computation result.

Parameters:

- y: T - The multiplier.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), T) - Whether multiplication resulted in truncation and the computation result.

### func carryingNeg()

```cangjie
func carryingNeg(): (Bool, T)
```

Function: Returns a tuple where the first element indicates whether negation operation resulted in truncation (`true` if truncated), and the second element is the computation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), T) - Whether negation resulted in truncation and the computation result.

### func carryingShl(UInt64)

```cangjie
func carryingShl(y: UInt64): (Bool, T)
```

Function: Returns a tuple where the first element indicates whether left shift operation resulted in truncation (`true` if truncated), and the second element is the computation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The number of bits to shift.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), T) - Whether left shift resulted in truncation and the computation result.

### func carryingShr(UInt64)

```cangjie
func carryingShr(y: UInt64): (Bool, T)
```

Function: Returns a tuple where the first element indicates whether right shift operation resulted in truncation (`true` if truncated), and the second element is the computation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The number of bits to shift.

Return Value:- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), T) - Whether right shift operation resulted in truncation and the operation result.

### func carryingSub(T)

```cangjie
func carryingSub(y: T): (Bool, T)
```

Function: Returns a tuple where the first element indicates whether subtraction resulted in truncation (`true` if occurred), and the second element is the operation result.

Parameters:

- y: T - The subtrahend.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), T) - Whether subtraction resulted in truncation and the operation result.

### extend Int16 <: CarryingOp\<Int16>

```cangjie
extend Int16 <: CarryingOp<Int16>
```

Function: Implements the [CarryingOp](./overflow_package_interfaces.md#interface-carryingopt) interface for [Int16](../../core/core_package_api/core_package_intrinsics.md#int16).

Parent Type:

- [CarryingOp](./overflow_package_interfaces.md#interface-carryingopt)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)>

#### func carryingAdd(Int16)

```cangjie
public func carryingAdd(y: Int16): (Bool, Int16)
```

Function: Performs addition using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

Returns `true` and the result if overflow occurs, otherwise returns `false` and the result.

Parameters:

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The addend.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int16](../../core/core_package_api/core_package_intrinsics.md#int16)) - A tuple where the first element indicates truncation (`true` if occurred), and the second element is the operation result.

#### func carryingDec()

```cangjie
public func carryingDec(): (Bool, Int16)
```

Function: Performs decrement operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

Returns `true` and the result if overflow occurs, otherwise returns `false` and the result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int16](../../core/core_package_api/core_package_intrinsics.md#int16)) - A tuple where the first element indicates truncation (`true` if occurred), and the second element is the operation result.

#### func carryingDiv(Int16)

```cangjie
public func carryingDiv(y: Int16): (Bool, Int16)
```

Function: Performs division using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

Returns `true` and the result if overflow occurs, otherwise returns `false` and the result.

Parameters:

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The divisor.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int16](../../core/core_package_api/core_package_intrinsics.md#int16)) - A tuple where the first element indicates truncation (`true` if occurred), and the second element is the operation result.

#### func carryingInc()

```cangjie
public func carryingInc(): (Bool, Int16)
```

Function: Performs increment operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

Returns `true` and the result if overflow occurs, otherwise returns `false` and the result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int16](../../core/core_package_api/core_package_intrinsics.md#int16)) - A tuple where the first element indicates truncation (`true` if occurred), and the second element is the operation result.

#### func carryingMod(Int16)

```cangjie
public func carryingMod(y: Int16): (Bool, Int16)
```

Function: Performs modulo operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

Returns `true` and the result if overflow occurs, otherwise returns `false` and the result.

Parameters:

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The divisor.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int16](../../core/core_package_api/core_package_intrinsics.md#int16)) - A tuple where the first element indicates truncation (`true` if occurred), and the second element is the operation result.

#### func carryingMul(Int16)

```cangjie
public func carryingMul(y: Int16): (Bool, Int16)
```

Function: Performs multiplication using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

Returns `true` and the result if overflow occurs, otherwise returns `false` and the result.

Parameters:

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The multiplier.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int16](../../core/core_package_api/core_package_intrinsics.md#int16)) - A tuple where the first element indicates truncation (`true` if occurred), and the second element is the operation result.

#### func carryingNeg()

```cangjie
public func carryingNeg(): (Bool, Int16)
```

Function: Performs negation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

Returns `true` and the result if overflow occurs, otherwise returns `false` and the result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int16](../../core/core_package_api/core_package_intrinsics.md#int16)) - A tuple where the first element indicates truncation (`true` if occurred), and the second element is the operation result.

#### func carryingShl(UInt64)

```cangjie
public func carryingShl(y: UInt64): (Bool, Int16)
```

Function: Left shift operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits to shift.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int16](../../core/core_package_api/core_package_intrinsics.md#int16)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingShr(UInt64)

```cangjie
public func carryingShr(y: UInt64): (Bool, Int16)
```

Function: Right shift operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits to shift.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int16](../../core/core_package_api/core_package_intrinsics.md#int16)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingSub(Int16)

```cangjie
public func carryingSub(y: Int16): (Bool, Int16)
```

Function: Subtraction operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Subtrahend.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int16](../../core/core_package_api/core_package_intrinsics.md#int16)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

### extend Int32 <: CarryingOp\<Int32>

```cangjie
extend Int32 <: CarryingOp<Int32>
```

Function: Implements the [CarryingOp](#interface-carryingopt) interface for [Int32](../../core/core_package_api/core_package_intrinsics.md#int32).

Parent Type:

- [CarryingOp](#interface-carryingopt)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)>

#### func carryingAdd(Int32)

```cangjie
public func carryingAdd(y: Int32): (Bool, Int32)
```

Function: Addition operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Addend.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingDec()

```cangjie
public func carryingDec(): (Bool, Int32)
```

Function: Decrement operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingDiv(Int32)

```cangjie
public func carryingDiv(y: Int32): (Bool, Int32)
```

Function: Division operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Divisor.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingInc()

```cangjie
public func carryingInc(): (Bool, Int32)
```

Function: Increment operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingMod(Int32)

```cangjie
public func carryingMod(y: Int32): (Bool, Int32)
```

Function: Modulus operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Divisor.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingMul(Int32)

```cangjie
public func carryingMul(y: Int32): (Bool, Int32)
```

Function: Multiplication operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.Returns `true` and the operation result when overflow occurs; otherwise, returns `false` and the operation result.

Parameters:

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The multiplier.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the result of the operation.

#### func carryingNeg()

```cangjie
public func carryingNeg(): (Bool, Int32)
```

Function: Performs negation operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

Returns `true` and the operation result when overflow occurs; otherwise, returns `false` and the operation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the result of the operation.

#### func carryingShl(UInt64)

```cangjie
public func carryingShl(y: UInt64): (Bool, Int32)
```

Function: Performs left shift operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

Returns `true` and the operation result when overflow occurs; otherwise, returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The number of bits to shift.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the result of the operation.

#### func carryingShr(UInt64)

```cangjie
public func carryingShr(y: UInt64): (Bool, Int32)
```

Function: Performs right shift operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

Returns `true` and the operation result when overflow occurs; otherwise, returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The number of bits to shift.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the result of the operation.

#### func carryingSub(Int32)

```cangjie
public func carryingSub(y: Int32): (Bool, Int32)
```

Function: Performs subtraction operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

Returns `true` and the operation result when overflow occurs; otherwise, returns `false` and the operation result.

Parameters:

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The subtrahend.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the result of the operation.

### extend Int64 <: CarryingOp\<Int64> & CarryingPow

```cangjie
extend Int64 <: CarryingOp<Int64> & CarryingPow
```

Function: Implements the [CarryingOp](#interface-carryingopt) interface and [CarryingPow](#interface-carryingpow) interface for [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).

Parent Types:

- [CarryingOp](#interface-carryingopt)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>
- [CarryingPow](#interface-carryingpow)

#### func carryingAdd(Int64)

```cangjie
public func carryingAdd(y: Int64): (Bool, Int64)
```

Function: Addition operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The addend.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncated), and the second element is the operation result.

#### func carryingDec()

```cangjie
public func carryingDec(): (Bool, Int64)
```

Function: Decrement operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs, returns `true` and the operation result; otherwise returns `false` and the operation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncated), and the second element is the operation result.

#### func carryingDiv(Int64)

```cangjie
public func carryingDiv(y: Int64): (Bool, Int64)
```

Function: Division operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The divisor.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncated), and the second element is the operation result.

#### func carryingInc()

```cangjie
public func carryingInc(): (Bool, Int64)
```

Function: Increment operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs, returns `true` and the operation result; otherwise returns `false` and the operation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncated), and the second element is the operation result.

#### func carryingMod(Int64)

```cangjie
public func carryingMod(y: Int64): (Bool, Int64)
```

Function: Modulo operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The divisor.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncated), and the second element is the operation result.

#### func carryingMul(Int64)

```cangjie
public func carryingMul(y: Int64): (Bool, Int64)
```

Function: Multiplication operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The multiplier.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncated), and the second element is the operation result.

#### func carryingNeg()

```cangjie
public func carryingNeg(): (Bool, Int64)
```

Function: Negation operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs, returns `true` and the operation result; otherwise returns `false` and the operation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncated), and the second element is the operation result.

#### func carryingPow(UInt64)

```cangjie
public func carryingPow(y: UInt64): (Bool, Int64)
```

Function: Exponentiation operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The exponent.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncated), and the second element is the operation result.

#### func carryingShl(UInt64)

```cangjie
public func carryingShl(y: UInt64): (Bool, Int64)
```

Function: Left shift operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The number of bits to shift.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncated), and the second element is the operation result.#### func carryingShr(UInt64)

#### func carryingShr(UInt64)

```cangjie
public func carryingShr(y: UInt64): (Bool, Int64)
```

Function: Right shift operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits to shift.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncated), and the second element is the operation result.

#### func carryingSub(Int64)

```cangjie
public func carryingSub(y: Int64): (Bool, Int64)
```

Function: Subtraction operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Subtrahend.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncated), and the second element is the operation result.

### extend Int8 <: CarryingOp\<Int8>

```cangjie
extend Int8 <: CarryingOp<Int8>
```

Function: Implements the [CarryingOp](#interface-carryingopt) interface for [Int8](../../core/core_package_api/core_package_intrinsics.md#int8).

Parent Type:

- [CarryingOp](#interface-carryingopt)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)>

#### func carryingAdd(Int8)

```cangjie
public func carryingAdd(y: Int8): (Bool, Int8)
```

Function: Addition operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Addend.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int8](../../core/core_package_api/core_package_intrinsics.md#int8)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncated), and the second element is the operation result.

#### func carryingDec()

```cangjie
public func carryingDec(): (Bool, Int8)
```

Function: Decrement operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int8](../../core/core_package_api/core_package_intrinsics.md#int8)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncated), and the second element is the operation result.

#### func carryingDiv(Int8)

```cangjie
public func carryingDiv(y: Int8): (Bool, Int8)
```

Function: Division operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Divisor.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int8](../../core/core_package_api/core_package_intrinsics.md#int8)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncated), and the second element is the operation result.

#### func carryingInc()

```cangjie
public func carryingInc(): (Bool, Int8)
```

Function: Increment operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int8](../../core/core_package_api/core_package_intrinsics.md#int8)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncated), and the second element is the operation result.

#### func carryingMod(Int8)

```cangjie
public func carryingMod(y: Int8): (Bool, Int8)
```

Function: Modulo operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Divisor.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int8](../../core/core_package_api/core_package_intrinsics.md#int8)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncated), and the second element is the operation result.

#### func carryingMul(Int8)

```cangjie
public func carryingMul(y: Int8): (Bool, Int8)
```

Function: Multiplication operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Multiplier.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int8](../../core/core_package_api/core_package_intrinsics.md#int8)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncated), and the second element is the operation result.

#### func carryingNeg()

```cangjie
public func carryingNeg(): (Bool, Int8)
```

Function: Performs negation operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Return value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int8](../../core/core_package_api/core_package_intrinsics.md#int8)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingShl(UInt64)

```cangjie
public func carryingShl(y: UInt64): (Bool, Int8)
```

Function: Performs left shift operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits to shift.

Return value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int8](../../core/core_package_api/core_package_intrinsics.md#int8)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingShr(UInt64)

```cangjie
public func carryingShr(y: UInt64): (Bool, Int8)
```

Function: Performs right shift operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits to shift.

Return value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int8](../../core/core_package_api/core_package_intrinsics.md#int8)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingSub(Int8)

```cangjie
public func carryingSub(y: Int8):(Bool, Int8)
```

Function: Performs subtraction operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Subtrahend.

Return value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int8](../../core/core_package_api/core_package_intrinsics.md#int8)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

### extend IntNative <: CarryingOp\<IntNative>

```cangjie
extend IntNative <: CarryingOp<IntNative>
```

Function: Implements the [CarryingOp](#interface-carryingopt) interface for [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).

Parent type:

- [CarryingOp](#interface-carryingopt)\<[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)>

#### func carryingAdd(IntNative)

```cangjie
public func carryingAdd(y: IntNative): (Bool, IntNative)
```

Function: Performs addition operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Addend.

Return value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingDec()

```cangjie
public func carryingDec(): (Bool, IntNative)
```

Function: Performs decrement operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Return value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingDiv(IntNative)

```cangjie
public func carryingDiv(y: IntNative): (Bool, IntNative)
```

Function: Performs division operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Divisor.

Return value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingInc()

```cangjie
public func carryingInc(): (Bool, IntNative)
```

Function: Performs increment operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Return value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingMod(IntNative)

```cangjie
public func carryingMod(y: IntNative): (Bool, IntNative)
```

Function: Performs modulus operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.Returns `true` and the operation result when overflow occurs; otherwise, returns `false` and the operation result.

Parameters:

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The divisor.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the result of the operation.

#### func carryingMul(IntNative)

```cangjie
public func carryingMul(y: IntNative): (Bool, IntNative)
```

Function: Multiplication operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

Returns `true` and the operation result when overflow occurs; otherwise, returns `false` and the operation result.

Parameters:

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The multiplier.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the result of the operation.

#### func carryingNeg()

```cangjie
public func carryingNeg(): (Bool, IntNative)
```

Function: Performs negation operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs, returns `true` and the operation result; otherwise returns `false` and the operation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncation happened), and the second element is the operation result.

#### func carryingShl(UInt64)

```cangjie
public func carryingShl(y: UInt64): (Bool, IntNative)
```

Function: Performs left shift operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits to shift.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncation happened), and the second element is the operation result.

#### func carryingShr(UInt64)

```cangjie
public func carryingShr(y: UInt64): (Bool, IntNative)
```

Function: Performs right shift operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits to shift.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncation happened), and the second element is the operation result.

#### func carryingSub(IntNative)

```cangjie
public func carryingSub(y: IntNative): (Bool, IntNative)
```

Function: Performs subtraction operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Subtrahend.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncation happened), and the second element is the operation result.

### extend UInt16 <: CarryingOp\<UInt16>

```cangjie
extend UInt16 <: CarryingOp<UInt16>
```

Function: Implements the [CarryingOp](#interface-carryingopt) interface for [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).

Parent Type:

- [CarryingOp](#interface-carryingopt)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)>

#### func carryingAdd(UInt16)

```cangjie
public func carryingAdd(y: UInt16): (Bool, UInt16)
```

Function: Performs addition operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Addend.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncation happened), and the second element is the operation result.

#### func carryingDec()

```cangjie
public func carryingDec(): (Bool, UInt16)
```

Function: Performs decrement operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs, returns `true` and the operation result; otherwise returns `false` and the operation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncation happened), and the second element is the operation result.

#### func carryingDiv(UInt16)

```cangjie
public func carryingDiv(y: UInt16): (Bool, UInt16)
```

Function: Performs division operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Divisor.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncation happened), and the second element is the operation result.

#### func carryingInc()

```cangjie
public func carryingInc(): (Bool, UInt16)
```

Function: Performs increment operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs, returns `true` and the operation result; otherwise returns `false` and the operation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncation happened), and the second element is the operation result.

#### func carryingMod(UInt16)

```cangjie
public func carryingMod(y: UInt16): (Bool, UInt16)
```

Function: Remainder operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Divisor.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingMul(UInt16)

```cangjie
public func carryingMul(y: UInt16): (Bool, UInt16)
```

Function: Multiplication operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Multiplier.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingNeg()

```cangjie
public func carryingNeg(): (Bool, UInt16)
```

Function: Negation operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingShl(UInt64)

```cangjie
public func carryingShl(y: UInt64): (Bool, UInt16)
```

Function: Left shift operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits to shift.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingShr(UInt64)

```cangjie
public func carryingShr(y: UInt64): (Bool, UInt16)
```

Function: Right shift operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits to shift.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingSub(UInt16)

```cangjie
public func carryingSub(y: UInt16): (Bool, UInt16)
```

Function: Subtraction operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Subtrahend.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

### extend UInt32 <: CarryingOp\<UInt32>

```cangjie
extend UInt32 <: CarryingOp<UInt32>
```

Function: Implements the [CarryingOp](#interface-carryingopt) interface for [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).

Parent Type:

- [CarryingOp](#interface-carryingopt)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)>

#### func carryingAdd(UInt32)

```cangjie
public func carryingAdd(y: UInt32): (Bool, UInt32)
```

Function: Addition operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Addend.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingDec()

```cangjie
public func carryingDec(): (Bool, UInt32)
```

Function: Decrement operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingDiv(UInt32)

```cangjie
public func carryingDiv(y: UInt32): (Bool, UInt32)
```

Function: Division operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.Returns `true` and the operation result when overflow occurs; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Divisor.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncation occurred), and the second element is the operation result.

#### func carryingInc()

```cangjie
public func carryingInc(): (Bool, UInt32)
```

Function: Increment operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

Returns `true` and the operation result when overflow occurs; otherwise returns `false` and the operation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncation occurred), and the second element is the operation result.

#### func carryingMod(UInt32)

```cangjie
public func carryingMod(y: UInt32): (Bool, UInt32)
```

Function: Modulo operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

Returns `true` and the operation result when overflow occurs; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Divisor.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncation occurred), and the second element is the operation result.

#### func carryingMul(UInt32)

```cangjie
public func carryingMul(y: UInt32): (Bool, UInt32)
```

Function: Multiplication operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

Returns `true` and the operation result when overflow occurs; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Multiplier.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncation occurred), and the second element is the operation result.

#### func carryingNeg()

```cangjie
public func carryingNeg(): (Bool, UInt32)
```

Function: Negation operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

Returns `true` and the operation result when overflow occurs; otherwise returns `false` and the operation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncation occurred), and the second element is the operation result.

#### func carryingShl(UInt64)

```cangjie
public func carryingShl(y: UInt64): (Bool, UInt32)
```

Function: Left shift operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

Returns `true` and the operation result when overflow occurs; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits to shift.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncation occurred), and the second element is the operation result.

#### func carryingShr(UInt64)

```cangjie
public func carryingShr(y: UInt64): (Bool, UInt32)
```

Function: Right shift operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

Returns `true` and the operation result when overflow occurs; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits to shift.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncation occurred), and the second element is the operation result.

#### func carryingSub(UInt32)

```cangjie
public func carryingSub(y: UInt32): (Bool, UInt32)
```

Function: Subtraction operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

Returns `true` and the operation result when overflow occurs; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Subtrahend.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncation occurred), and the second element is the operation result.

### extend UInt64 <: CarryingOp\<UInt64>

```cangjie
extend UInt64 <: CarryingOp<UInt64>
```

Function: Implements the [CarryingOp](#interface-carryingopt) interface for [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).

Parent Type:

- [CarryingOp](#interface-carryingopt)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)>

#### func carryingAdd(UInt64)

```cangjie
public func carryingAdd(y: UInt64): (Bool, UInt64)
```

Function: Addition operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

Returns `true` and the operation result when overflow occurs; otherwise returns `false` and the operation result.Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The addend.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the result of the operation.

#### func carryingDec()

```cangjie
public func carryingDec(): (Bool, UInt64)
```

Function: Decrement operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the result of the operation.

#### func carryingDiv(UInt64)

```cangjie
public func carryingDiv(y: UInt64): (Bool, UInt64)
```

Function: Division operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The divisor.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the result of the operation.

#### func carryingInc()

```cangjie
public func carryingInc(): (Bool, UInt64)
```

Function: Increment operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingMod(UInt64)

```cangjie
public func carryingMod(y: UInt64): (Bool, UInt64)
```

Function: Modulo operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The divisor.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingMul(UInt64)

```cangjie
public func carryingMul(y: UInt64): (Bool, UInt64)
```

Function: Multiplication operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The multiplier.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingNeg()

```cangjie
public func carryingNeg(): (Bool, UInt64)
```

Function: Negation operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingShl(UInt64)

```cangjie
public func carryingShl(y: UInt64): (Bool, UInt64)
```

Function: Left shift operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The number of bits to shift.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingShr(UInt64)

```cangjie
public func carryingShr(y: UInt64): (Bool, UInt64)
```

Function: Right shift operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The number of bits to shift.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingSub(UInt64)

```cangjie
public func carryingSub(y: UInt64): (Bool, UInt64)
```

Function: Subtraction operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The subtrahend.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

### extend UInt8 <: CarryingOp\<UInt8>

```cangjie
extend UInt8 <: CarryingOp<UInt8>
```

Function: Implements the [CarryingOp](#interface-carryingopt) interface for [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).

Parent Type:

- [CarryingOp](#interface-carryingopt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)>

#### func carryingAdd(UInt8)

```cangjie
public func carryingAdd(y: UInt8): (Bool, UInt8)
```

Function: Addition operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The addend.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingDec()

```cangjie
public func carryingDec(): (Bool, UInt8)
```

Function: Decrement operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingDiv(UInt8)

```cangjie
public func carryingDiv(y: UInt8): (Bool, UInt8)
```

Function: Division operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Divisor.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingInc()

```cangjie
public func carryingInc(): (Bool, UInt8)
```

Function: Increment operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingMod(UInt8)

```cangjie
public func carryingMod(y: UInt8): (Bool, UInt8)
```

Function: Modulo operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Divisor.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingMul(UInt8)

```cangjie
public func carryingMul(y: UInt8): (Bool, UInt8)
```

Function: Multiplication operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Multiplier.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingNeg()

```cangjie
public func carryingNeg(): (Bool, UInt8)
```

Function: Negation operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingShl(UInt64)

```cangjie
public func carryingShl(y: UInt64): (Bool, UInt8)
```

Function: Left shift operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits to shift.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingShr(UInt64)

```cangjie
public func carryingShr(y: UInt64): (Bool, UInt8)
```

Function: Right shift operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits to shift.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingSub(UInt8)

```cangjie
public func carryingSub(y: UInt8): (Bool, UInt8)
```

Function: Subtraction operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs during the operation, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Subtrahend.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

### extend UIntNative <: CarryingOp\<UIntNative>

```cangjie
extend UIntNative <: CarryingOp<UIntNative>
```

Function: Implements the [CarryingOp](#interface-carryingopt) interface for [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).

Parent Types:

- [CarryingOp](#interface-carryingopt)\<[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)>

#### func carryingAdd(UIntNative)

```cangjie
public func carryingAdd(y: UIntNative): (Bool, UIntNative)
```

Function: Performs addition using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The addend.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncated), and the second element is the operation result.

#### func carryingDec()

```cangjie
public func carryingDec(): (Bool, UIntNative)
```

Function: Performs decrement using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs, returns `true` and the operation result; otherwise returns `false` and the operation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncated), and the second element is the operation result.

#### func carryingDiv(UIntNative)

```cangjie
public func carryingDiv(y: UIntNative): (Bool, UIntNative)
```

Function: Performs division using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The divisor.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncated), and the second element is the operation result.

#### func carryingInc()

```cangjie
public func carryingInc(): (Bool, UIntNative)
```

Function: Performs increment using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs, returns `true` and the operation result; otherwise returns `false` and the operation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncated), and the second element is the operation result.

#### func carryingMod(UIntNative)

```cangjie
public func carryingMod(y: UIntNative): (Bool, UIntNative)
```

Function: Performs modulus operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The divisor.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncated), and the second element is the operation result.

#### func carryingMul(UIntNative)

```cangjie
public func carryingMul(y: UIntNative): (Bool, UIntNative)
```

Function: Performs multiplication using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The multiplier.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncated), and the second element is the operation result.

#### func carryingNeg()

```cangjie
public func carryingNeg(): (Bool, UIntNative)
```

Function: Performs negation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs, returns `true` and the operation result; otherwise returns `false` and the operation result.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncated), and the second element is the operation result.

#### func carryingShl(UInt64)

```cangjie
public func carryingShl(y: UInt64): (Bool, UIntNative)
```

Function: Performs left shift using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

When overflow occurs, returns `true` and the operation result; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The number of bits to shift.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)) - Returns a tuple where the first element indicates whether truncation occurred (`true` if truncated), and the second element is the operation result.

#### func carryingShr(UInt64)

```cangjie
public func carryingShr(y: UInt64): (Bool, UIntNative)
```

Function: Performs right shift using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.Returns `true` and the operation result when overflow occurs; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits to shift.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

#### func carryingSub(UIntNative)

```cangjie
public func carryingSub(y: UIntNative): (Bool, UIntNative)
```

Function: Subtraction operation using [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

Returns `true` and the operation result when overflow occurs; otherwise returns `false` and the operation result.

Parameters:

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Subtrahend.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

## interface CarryingPow

```cangjie
public interface CarryingPow {
  func carryingPow(y: UInt64): (Bool, Int64)
}
```

Function: Provides an interface for exponentiation operations using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

### func carryingPow(UInt64)

```cangjie
func carryingPow(y: UInt64): (Bool, Int64)
```

Function: Exponentiation operation using the [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) strategy.

Returns `true` and the operation result when overflow occurs; otherwise returns `false` and the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Exponent.

Return Value:

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) - Returns a tuple where the first element indicates whether truncation occurred during the operation (`true` if truncation occurred), and the second element is the operation result.

- ?T - Left shift operation result.

### func checkedShr(UInt64)

```cangjie
func checkedShr(y: UInt64): ?T
```

Function: Left shift operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

When the shift count is greater than or equal to the operand bit width, returns `?T.None`; otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- ?T - Left shift operation result.

### func checkedSub(T)

```cangjie
func checkedSub(y: T): ?T
```

Function: Subtraction operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns `?T.None` when overflow occurs; otherwise returns the operation result.

Parameters:

- y: T - Subtrahend.

Return value:

- ?T - Subtraction operation result.- ?T - Left shift operation result.

### func checkedShr(UInt64)

```cangjie
func checkedShr(y: UInt64): ?T
```

Function: Right shift operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

When the shift count is greater than or equal to the operand bit width, returns `?T.None`; otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- ?T - Right shift operation result.

### func checkedSub(T)

```cangjie
func checkedSub(y: T): ?T
```

Function: Subtraction operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns `?T.None` when overflow occurs; otherwise returns the operation result.

Parameters:

- y: T - Subtrahend.

Return value:

- ?T - Subtraction operation result.

### extend Int16 <: CheckedOp\<Int16>

```cangjie
extend Int16 <: CheckedOp<Int16>
```

Function: Implements the [CheckedOp](#interface-checkedopt) interface for [Int16](../../core/core_package_api/core_package_intrinsics.md#int16).

Parent type:

- [CheckedOp](#interface-checkedopt)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)>

#### func checkedAdd(Int16)

```cangjie
public func checkedAdd(y: Int16): ?Int16
```

Function: Addition operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16).None when overflow occurs; otherwise returns the operation result.

Parameters:

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Addend.

Return value:

- ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Addition operation result.

#### func checkedDec()

```cangjie
public func checkedDec(): ?Int16
```

Function: Decrement operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16).None when overflow occurs; otherwise returns the operation result.

Return value:

- ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Decrement operation result.

#### func checkedDiv(Int16)

```cangjie
public func checkedDiv(y: Int16): ?Int16
```

Function: Division operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16).None when overflow occurs; otherwise returns the operation result.

Parameters:

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Divisor.

Return value:

- ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Division operation result.

#### func checkedInc()

```cangjie
public func checkedInc(): ?Int16
```

Function: Increment operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16).None when overflow occurs; otherwise returns the operation result.

Return value:

- ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Increment operation result.

#### func checkedMod(Int16)

```cangjie
public func checkedMod(y: Int16): ?Int16
```

Function: Modulo operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16).None when overflow occurs; otherwise returns the operation result.

Parameters:

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Divisor.

Return value:

- ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Modulo operation result.

#### func checkedMul(Int16)

```cangjie
public func checkedMul(y: Int16): ?Int16
```

Function: Multiplication operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16).None when overflow occurs; otherwise returns the operation result.

Parameters:

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Multiplier.

Return value:

- ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Multiplication operation result.#### func checkedNeg()

```cangjie
public func checkedNeg(): ?Int16
```

Function: Performs negation operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16).None when overflow occurs, otherwise returns the operation result.

Return Value:

- ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Result of the negation operation.

#### func checkedShl(UInt64)

```cangjie
public func checkedShl(y: UInt64): ?Int16
```

Function: Performs left shift operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16).None when the shift count is greater than or equal to the operand bit width, otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits to shift.

Return Value:

- ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Result of the left shift operation.

#### func checkedShr(UInt64)

```cangjie
public func checkedShr(y: UInt64): ?Int16
```

Function: Performs right shift operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16).None when the shift count is greater than or equal to the operand bit width, otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits to shift.

Return Value:

- ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Result of the right shift operation.

#### func checkedSub(Int16)

```cangjie
public func checkedSub(y: Int16): ?Int16
```

Function: Performs subtraction operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16).None when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Subtrahend.

Return Value:

- ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Result of the subtraction operation.

### extend Int32 <: CheckedOp\<Int32>

```cangjie
extend Int32 <: CheckedOp<Int32>
```

Function: Implements the [CheckedOp](#interface-checkedopt) interface for [Int32](../../core/core_package_api/core_package_intrinsics.md#int32).

Parent Type:

- [CheckedOp](#interface-checkedopt)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)>

#### func checkedAdd(Int32)

```cangjie
public func checkedAdd(y: Int32): ?Int32
```

Function: Performs addition operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).None when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Addend.

Return Value:

- ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Result of the addition operation.

#### func checkedDec()

```cangjie
public func checkedDec(): ?Int32
```

Function: Performs decrement operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).None when overflow occurs, otherwise returns the operation result.

Return Value:

- ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Result of the decrement operation.

#### func checkedDiv(Int32)

```cangjie
public func checkedDiv(y: Int32): ?Int32
```

Function: Performs division operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).None when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Divisor.

Return Value:

- ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Result of the division operation.

#### func checkedInc()

```cangjie
public func checkedInc(): ?Int32
```

Function: Performs increment operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).None when overflow occurs, otherwise returns the operation result.

Return Value:

- ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Result of the increment operation.

#### func checkedMod(Int32)

```cangjie
public func checkedMod(y: Int32): ?Int32
```

Function: Performs remainder operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).None if overflow occurs during operation, otherwise returns the computation result.

Parameters:

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Divisor.

Return Value:

- ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Result of the remainder operation.

#### func checkedMul(Int32)

```cangjie
public func checkedMul(y: Int32): ?Int32
```

Function: Performs multiplication operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).None if overflow occurs during operation, otherwise returns the computation result.

Parameters:

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Multiplier.

Return Value:

- ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Result of the multiplication operation.

#### func checkedNeg()

```cangjie
public func checkedNeg(): ?Int32
```

Function: Performs negation operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).None if overflow occurs during operation, otherwise returns the computation result.

Return Value:

- ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Result of the negation operation.

#### func checkedShl(UInt64)

```cangjie
public func checkedShl(y: UInt64): ?Int32
```

Function: Performs left shift operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).None if the shift count is greater than or equal to the operand bit width, otherwise returns the computation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Result of the left shift operation.

#### func checkedShr(UInt64)

```cangjie
public func checkedShr(y: UInt64): ?Int32
```

Function: Right shift operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

When the shift count is greater than or equal to the operand bit width, returns ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).None; otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Right shift operation result.

#### func checkedSub(Int32)

```cangjie
public func checkedSub(y: Int32): ?Int32
```

Function: Subtraction operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).None when overflow occurs; otherwise returns the operation result.

Parameters:

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Subtrahend.

Return value:

- ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Subtraction operation result.

### extend Int64 <: CheckedOp\<Int64> & CheckedPow

```cangjie
extend Int64 <: CheckedOp<Int64> & CheckedPow
```

Function: Implements [CheckedOp](#interface-checkedopt) and [CheckedPow](#interface-checkedpow) interfaces for [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).

Parent types:

- [CheckedOp](#interface-checkedopt)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>
- [CheckedPow](#interface-checkedpow)

#### func checkedAdd(Int64)

```cangjie
public func checkedAdd(y: Int64): ?Int64
```

Function: Addition operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64).None when overflow occurs; otherwise returns the operation result.

Parameters:

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Addend.

Return value:

- ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Addition operation result.

#### func checkedDec()

```cangjie
public func checkedDec(): ?Int64
```

Function: Decrement operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64).None when overflow occurs; otherwise returns the operation result.

Return value:

- ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Decrement operation result.

#### func checkedDiv(Int64)

```cangjie
public func checkedDiv(y: Int64): ?Int64
```

Function: Division operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64).None when overflow occurs; otherwise returns the operation result.

Parameters:

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Divisor.

Return value:

- ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Division operation result.

#### func checkedInc()

```cangjie
public func checkedInc(): ?Int64
```

Function: Increment operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64).None when overflow occurs; otherwise returns the operation result.

Return value:

- ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Increment operation result.

#### func checkedMod(Int64)

```cangjie
public func checkedMod(y: Int64): ?Int64
```

Function: Modulo operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64).None when overflow occurs; otherwise returns the operation result.

Parameters:

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Divisor.

Return value:

- ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Modulo operation result.

#### func checkedMul(Int64)

```cangjie
public func checkedMul(y: Int64): ?Int64
```

Function: Multiplication operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64).None when overflow occurs; otherwise returns the operation result.

Parameters:

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Multiplier.

Return value:

- ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Multiplication operation result.#### func checkedNeg()

```cangjie
public func checkedNeg(): ?Int64
```

Function: Performs negation operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64).None when overflow occurs, otherwise returns the operation result.

Return Value:

- ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the negation operation.

#### func checkedPow(UInt64)

```cangjie
public func checkedPow(y: UInt64): ?Int64
```

Function: Performs exponentiation operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64).None when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Exponent.

Return Value:

- ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the exponentiation operation.

#### func checkedShl(UInt64)

```cangjie
public func checkedShl(y: UInt64): ?Int64
```

Function: Performs left shift operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64).None when the shift count is greater than or equal to the operand bit width, otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the left shift operation.

#### func checkedShr(UInt64)

```cangjie
public func checkedShr(y: UInt64): ?Int64
```

Function: Performs right shift operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64).None when the shift count is greater than or equal to the operand bit width, otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the right shift operation.

#### func checkedSub(Int64)

```cangjie
public func checkedSub(y: Int64): ?Int64
```

Function: Performs subtraction operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64).None when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Subtrahend.

Return Value:

- ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the subtraction operation.

### extend Int8 <: CheckedOp\<Int8>

```cangjie
extend Int8 <: CheckedOp<Int8>
```

Function: Implements the [CheckedOp](#interface-checkedopt) interface for [Int8](../../core/core_package_api/core_package_intrinsics.md#int8).

Parent Type:

- [CheckedOp](#interface-checkedopt)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)>

#### func checkedAdd(Int8)

```cangjie
public func checkedAdd(y: Int8): ?Int8
```

Function: Performs addition operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8).None when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Addend.

Return Value:

- ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Result of the addition operation.

#### func checkedDec()

```cangjie
public func checkedDec(): ?Int8
```

Function: Performs decrement operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8).None when overflow occurs, otherwise returns the operation result.

Return Value:

- ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Result of the decrement operation.

#### func checkedDiv(Int8)

```cangjie
public func checkedDiv(y: Int8): ?Int8
```

Function: Performs division operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8).None when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Divisor.

Return Value:

- ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Result of the division operation.

#### func checkedInc()

```cangjie
public func checkedInc(): ?Int8
```

Function: Performs increment operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8).None on overflow, otherwise returns the operation result.

Return value:

- ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Result of increment operation.

#### func checkedMod(Int8)

```cangjie
public func checkedMod(y: Int8): ?Int8
```

Function: Performs modulus operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8).None on overflow, otherwise returns the operation result.

Parameters:

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Divisor.

Return value:

- ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Result of modulus operation.

#### func checkedMul(Int8)

```cangjie
public func checkedMul(y: Int8): ?Int8
```

Function: Performs multiplication operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8).None on overflow, otherwise returns the operation result.

Parameters:

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Multiplier.

Return value:

- ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Result of multiplication operation.

#### func checkedNeg()

```cangjie
public func checkedNeg(): ?Int8
```

Function: Performs negation operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8).None on overflow, otherwise returns the operation result.

Return value:

- ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Result of negation operation.

#### func checkedShl(UInt64)

```cangjie
public func checkedShl(y: UInt64): ?Int8
```

Function: Performs left shift operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8).None when shift count ≥ operand bit width, otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Result of left shift operation.

#### func checkedShr(UInt64)

```cangjie
public func checkedShr(y: UInt64): ?Int8
```

Function: Performs right shift operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8).None when shift count ≥ operand bit width, otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Result of right shift operation.

#### func checkedSub(Int8)

```cangjie
public func checkedSub(y: Int8): ?Int8
```

Function: Performs subtraction operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8).None on overflow, otherwise returns the operation result.

Parameters:

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Subtrahend.

Return value:

- ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Result of subtraction operation.

### extend IntNative <: CheckedOp\<IntNative>

```cangjie
extend IntNative <: CheckedOp<IntNative>
```

Function: Implements the [CheckedOp](#interface-checkedopt) interface for [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).

Parent type:

- [CheckedOp](#interface-checkedopt)\<[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)>

#### func checkedAdd(IntNative)

```cangjie
public func checkedAdd(y: IntNative): ?IntNative
```

Function: Performs addition operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).None on overflow, otherwise returns the operation result.

Parameters:

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Addend.

Return value:

- ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Result of addition operation.

#### func checkedDec()

```cangjie
public func checkedDec(): ?IntNative
```

Function: Performs a decrement operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

When overflow occurs during the operation, returns ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).None; otherwise returns the operation result.

Return value:

- ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The result of the decrement operation.

#### func checkedDiv(IntNative)

```cangjie
public func checkedDiv(y: IntNative): ?IntNative
```

Function: Performs a division operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

When overflow occurs during the operation, returns ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).None; otherwise returns the operation result.

Parameters:

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The divisor.

Return value:

- ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The result of the division operation.

#### func checkedInc()

```cangjie
public func checkedInc(): ?IntNative
```

Function: Performs an increment operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

When overflow occurs during the operation, returns ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).None; otherwise returns the operation result.

Return value:

- ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The result of the increment operation.

#### func checkedMod(IntNative)

```cangjie
public func checkedMod(y: IntNative): ?IntNative
```

Function: Performs a modulo operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

When overflow occurs during the operation, returns ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).None; otherwise returns the operation result.

Parameters:

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The divisor.

Return value:

- ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The result of the modulo operation.

#### func checkedMul(IntNative)

```cangjie
public func checkedMul(y: IntNative): ?IntNative
```

Function: Performs a multiplication operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

When overflow occurs during the operation, returns ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).None; otherwise returns the operation result.

Parameters:

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The multiplier.

Return value:

- ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The result of the multiplication operation.

#### func checkedNeg()

```cangjie
public func checkedNeg(): ?IntNative
```

Function: Performs negation operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).None on overflow, otherwise returns the operation result.

Return Value:

- ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Result of the negation operation.

#### func checkedShl(UInt64)

```cangjie
public func checkedShl(y: UInt64): ?IntNative
```

Function: Performs left shift operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).None when shift bits ≥ operand bits, otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits to shift.

Return Value:

- ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Result of the left shift operation.

#### func checkedShr(UInt64)

```cangjie
public func checkedShr(y: UInt64): ?IntNative
```

Function: Performs right shift operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).None when shift bits ≥ operand bits, otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits to shift.

Return Value:

- ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Result of the right shift operation.

#### func checkedSub(IntNative)

```cangjie
public func checkedSub(y: IntNative): ?IntNative
```

Function: Performs subtraction operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).None on overflow, otherwise returns the operation result.

Parameters:

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Subtrahend.

Return Value:

- ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Result of the subtraction operation.

### extend UInt16 <: CheckedOp\<UInt16>

```cangjie
extend UInt16 <: CheckedOp<UInt16>
```

Function: Implements the [CheckedOp](#interface-checkedopt) interface for [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).

Parent Type:

- [CheckedOp](#interface-checkedopt)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)>

#### func checkedAdd(UInt16)

```cangjie
public func checkedAdd(y: UInt16): ?UInt16
```

Function: Performs addition operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).None on overflow, otherwise returns the operation result.

Parameters:

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Addend.

Return Value:

- ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Result of the addition operation.

#### func checkedDec()

```cangjie
public func checkedDec(): ?UInt16
```

Function: Performs decrement operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).None on overflow, otherwise returns the operation result.

Return Value:

- ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Result of the decrement operation.

#### func checkedDiv(UInt16)

```cangjie
public func checkedDiv(y: UInt16): ?UInt16
```

Function: Performs division operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).None on overflow, otherwise returns the operation result.

Parameters:

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Divisor.

Return Value:

- ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Result of the division operation.

#### func checkedInc()

```cangjie
public func checkedInc(): ?UInt16
```

Function: Performs increment operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).None on overflow, otherwise returns the operation result.

Return Value:

- ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Result of the increment operation.

#### func checkedMod(UInt16)

```cangjie
public func checkedMod(y: UInt16): ?UInt16
```Function: Performs modulo operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).None on overflow, otherwise returns the operation result.

Parameters:

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Divisor.

Return value:

- ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Modulo operation result.

#### func checkedMul(UInt16)

```cangjie
public func checkedMul(y: UInt16): ?UInt16
```

Function: Performs multiplication using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).None on overflow, otherwise returns the operation result.

Parameters:

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Multiplier.

Return value:

- ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Multiplication operation result.

#### func checkedNeg()

```cangjie
public func checkedNeg(): ?UInt16
```

Function: Performs negation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).None on overflow, otherwise returns the operation result.

Return value:

- ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Negation operation result.

#### func checkedShl(UInt64)

```cangjie
public func checkedShl(y: UInt64): ?UInt16
```

Function: Performs left shift using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).None when shift count ≥ operand bit width, otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Left shift operation result.

#### func checkedShr(UInt64)

```cangjie
public func checkedShr(y: UInt64): ?UInt16
```

Function: Performs right shift using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).None when shift count ≥ operand bit width, otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Right shift operation result.

#### func checkedSub(UInt16)

```cangjie
public func checkedSub(y: UInt16): ?UInt16
```

Function: Performs subtraction using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).None on overflow, otherwise returns the operation result.

Parameters:

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Subtrahend.

Return value:

- ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Subtraction operation result.

### extend UInt32 <: CheckedOp\<UInt32>

```cangjie
extend UInt32 <: CheckedOp<UInt32>
```

Function: Implements the [CheckedOp](#interface-checkedopt) interface for [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).

Parent type:

- [CheckedOp](#interface-checkedopt)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)>

#### func checkedAdd(UInt32)

```cangjie
public func checkedAdd(y: UInt32): ?UInt32
```

Function: Performs addition using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).None on overflow, otherwise returns the operation result.

Parameters:

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Addend.

Return value:

- ?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Addition operation result.

#### func checkedDec()

```cangjie
public func checkedDec(): ?UInt32
```

Function: Performs decrement using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).None on overflow, otherwise returns the operation result.

Return value:

- ?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Decrement operation result.

#### func checkedDiv(UInt32)

```cangjie
public func checkedDiv(y: UInt32): ?UInt32
```

Function: Performs division using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.Returns `?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).None` if overflow occurs during the operation, otherwise returns the operation result.

Parameters:

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The divisor.

Return Value:

- `?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)` - The division operation result.

#### func checkedInc()

```cangjie
public func checkedInc(): ?UInt32
```

Function: Increment operation using the `[Option](../../core/core_package_api/core_package_enums.md#enum-optiont)` return strategy.

Returns `?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).None` if overflow occurs during the operation, otherwise returns the operation result.

Return Value:

- `?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)` - The increment operation result.

#### func checkedMod(UInt32)

```cangjie
public func checkedMod(y: UInt32): ?UInt32
```

Function: Modulo operation using the `[Option](../../core/core_package_api/core_package_enums.md#enum-optiont)` return strategy.

Returns `?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).None` if overflow occurs during the operation, otherwise returns the operation result.

Parameters:

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The divisor.

Return Value:

- `?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)` - The modulo operation result.

#### func checkedMul(UInt32)

```cangjie
public func checkedMul(y: UInt32): ?UInt32
```

Function: Multiplication operation using the `[Option](../../core/core_package_api/core_package_enums.md#enum-optiont)` return strategy.

Returns `?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).None` if overflow occurs during the operation, otherwise returns the operation result.

Parameters:

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The multiplier.

Return Value:

- `?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)` - The multiplication operation result.

#### func checkedNeg()

```cangjie
public func checkedNeg(): ?UInt32
```

Function: Negation operation using the `[Option](../../core/core_package_api/core_package_enums.md#enum-optiont)` return strategy.

Returns `?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).None` if overflow occurs during the operation, otherwise returns the operation result.

Return Value:

- `?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)` - The negation operation result.

#### func checkedShl(UInt64)

```cangjie
public func checkedShl(y: UInt64): ?UInt32
```

Function: Left shift operation using the `[Option](../../core/core_package_api/core_package_enums.md#enum-optiont)` return strategy.

Returns `?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).None` if the shift count is greater than or equal to the operand bit width, otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The shift count.

Return Value:

- `?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)` - The left shift operation result.

#### func checkedShr(UInt64)

```cangjie
public func checkedShr(y: UInt64): ?UInt32
```

Function: Right shift operation using the `[Option](../../core/core_package_api/core_package_enums.md#enum-optiont)` return strategy.

Returns `?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).None` if the shift count is greater than or equal to the operand bit width, otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The shift count.

Return Value:

- `?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)` - The right shift operation result.

#### func checkedSub(UInt32)

```cangjie
public func checkedSub(y: UInt32): ?UInt32
```

Function: Subtraction operation using the `[Option](../../core/core_package_api/core_package_enums.md#enum-optiont)` return strategy.

Returns `?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).None` if overflow occurs during the operation, otherwise returns the operation result.

Parameters:

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The subtrahend.

Return Value:

- `?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)` - The subtraction operation result.

### extend UInt64 <: CheckedOp\<UInt64>

```cangjie
extend UInt64 <: CheckedOp<UInt64>
```

Function: Implements the `[CheckedOp](#interface-checkedopt)` interface for `[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)`.

Parent Type:

- `[CheckedOp](#interface-checkedopt)<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)>`

#### func checkedAdd(UInt64)

```cangjie
public func checkedAdd(y: UInt64): ?UInt64
```

Function: Addition operation using the `[Option](../../core/core_package_api/core_package_enums.md#enum-optiont)` return strategy.

Returns `?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).None` if overflow occurs during the operation, otherwise returns the operation result.Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The addend.

Return Value:

- ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The result of the addition operation.

#### func checkedDec()

```cangjie
public func checkedDec(): ?UInt64
```

Function: Decrement operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).None on overflow, otherwise returns the operation result.

Return value:

- ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Result of the decrement operation.

#### func checkedDiv(UInt64)

```cangjie
public func checkedDiv(y: UInt64): ?UInt64
```

Function: Division operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).None on overflow, otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Divisor.

Return value:

- ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Result of the division operation.

#### func checkedInc()

```cangjie
public func checkedInc(): ?UInt64
```

Function: Increment operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).None on overflow, otherwise returns the operation result.

Return value:

- ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Result of the increment operation.

#### func checkedMod(UInt64)

```cangjie
public func checkedMod(y: UInt64): ?UInt64
```

Function: Modulo operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).None on overflow, otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Divisor.

Return value:

- ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Result of the modulo operation.

#### func checkedMul(UInt64)

```cangjie
public func checkedMul(y: UInt64): ?UInt64
```

Function: Multiplication operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).None on overflow, otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Multiplier.

Return value:

- ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Result of the multiplication operation.

#### func checkedNeg()

```cangjie
public func checkedNeg(): ?UInt64
```

Function: Negation operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).None on overflow, otherwise returns the operation result.

Return value:

- ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Result of the negation operation.

#### func checkedShl(UInt64)

```cangjie
public func checkedShl(y: UInt64): ?UInt64
```

Function: Left shift operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).None when the shift count is greater than or equal to the operand bit width, otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Result of the left shift operation.

#### func checkedShr(UInt64)

```cangjie
public func checkedShr(y: UInt64): ?UInt64
```

Function: Right shift operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).None when the shift count is greater than or equal to the operand bit width, otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Result of the right shift operation.

#### func checkedSub(UInt64)

```cangjie
public func checkedSub(y: UInt64): ?UInt64
```

Function: Subtraction operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).None on overflow, otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Subtrahend.

Return value:

- ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Result of the subtraction operation.### extend UInt8 <: CheckedOp\<UInt8>

```cangjie
extend UInt8 <: CheckedOp<UInt8>
```

Function: Implements the [CheckedOp](#interface-checkedopt) interface for [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).

Parent Types:

- [CheckedOp](#interface-checkedopt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)>

#### func checkedAdd(UInt8)

```cangjie
public func checkedAdd(y: UInt8): ?UInt8
```

Function: Performs addition operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).None on overflow, otherwise returns the operation result.

Parameters:

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The addend.

Return Value:

- ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The addition operation result.

#### func checkedDec()

```cangjie
public func checkedDec(): ?UInt8
```

Function: Performs decrement operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).None on overflow, otherwise returns the operation result.

Return Value:

- ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The decrement operation result.

#### func checkedDiv(UInt8)

```cangjie
public func checkedDiv(y: UInt8): ?UInt8
```

Function: Performs division operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).None on overflow, otherwise returns the operation result.

Parameters:

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The divisor.

Return Value:

- ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The division operation result.

#### func checkedInc()

```cangjie
public func checkedInc(): ?UInt8
```

Function: Performs increment operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).None on overflow, otherwise returns the operation result.

Return Value:

- ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The increment operation result.

#### func checkedMod(UInt8)

```cangjie
public func checkedMod(y: UInt8): ?UInt8
```

Function: Performs modulus operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).None on overflow, otherwise returns the operation result.

Parameters:

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The divisor.

Return Value:

- ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The modulus operation result.

#### func checkedMul(UInt8)

```cangjie
public func checkedMul(y: UInt8): ?UInt8
```

Function: Performs multiplication operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).None on overflow, otherwise returns the operation result.

Parameters:

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The multiplier.

Return Value:

- ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The multiplication operation result.

#### func checkedNeg()

```cangjie
public func checkedNeg(): ?UInt8
```

Function: Performs negation operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).None on overflow, otherwise returns the operation result.

Return Value:

- ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The negation operation result.

#### func checkedShl(UInt64)

```cangjie
public func checkedShl(y: UInt64): ?UInt8
```

Function: Performs left shift operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).None when shift count is greater than or equal to operand bit width, otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The shift count.

Return Value:

- ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The left shift operation result.

#### func checkedShr(UInt64)

```cangjie
public func checkedShr(y: UInt64): ?UInt8
```

Function: Performs a right shift operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

When the shift count is greater than or equal to the operand's bit width, returns ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).None; otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The number of bits to shift.

Return Value:

- ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The result of the right shift operation.

#### func checkedSub(UInt8)

```cangjie
public func checkedSub(y: UInt8): ?UInt8
```

Function: Performs subtraction using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).None if overflow occurs; otherwise returns the operation result.

Parameters:

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The subtrahend.

Return Value:

- ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The result of the subtraction operation.

### extend UIntNative <: CheckedOp\<UIntNative>

```cangjie
extend UIntNative <: CheckedOp<UIntNative>
```

Function: Implements the [CheckedOp](#interface-checkedopt) interface for [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).

Parent Types:

- [CheckedOp](#interface-checkedopt)\<[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)>

#### func checkedAdd(UIntNative)

```cangjie
public func checkedAdd(y: UIntNative): ?UIntNative
```

Function: Performs addition using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).None if overflow occurs; otherwise returns the operation result.

Parameters:

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The addend.

Return Value:

- ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The result of the addition operation.

#### func checkedDec()

```cangjie
public func checkedDec(): ?UIntNative
```

Function: Performs decrement operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).None if overflow occurs; otherwise returns the operation result.

Return Value:

- ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The result of the decrement operation.

#### func checkedDiv(UIntNative)

```cangjie
public func checkedDiv(y: UIntNative): ?UIntNative
```

Function: Performs division using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).None if overflow occurs; otherwise returns the operation result.

Parameters:

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The divisor.

Return Value:

- ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The result of the division operation.

#### func checkedInc()

```cangjie
public func checkedInc(): ?UIntNative
```

Function: Performs increment operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).None if overflow occurs; otherwise returns the operation result.

Return Value:

- ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The result of the increment operation.

#### func checkedMod(UIntNative)

```cangjie
public func checkedMod(y: UIntNative): ?UIntNative
```

Function: Performs modulus operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).None if overflow occurs; otherwise returns the operation result.

Parameters:

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The divisor.

Return Value:

- ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The result of the modulus operation.

#### func checkedMul(UIntNative)

```cangjie
public func checkedMul(y: UIntNative): ?UIntNative
```

Function: Performs multiplication using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).None if overflow occurs; otherwise returns the operation result.

Parameters:

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The multiplier.

Return Value:

- ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The result of the multiplication operation.

#### func checkedNeg()

```cangjie
public func checkedNeg(): ?UIntNative
```

Function: Performs negation operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.Returns `?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).None` when arithmetic overflow occurs, otherwise returns the operation result.

Return Value:

- `?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)` - The result of the negation operation.

#### func checkedShl(UInt64)

```cangjie
public func checkedShl(y: UInt64): ?UIntNative
```

Function: Left shift operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns `?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).None` when the shift count is greater than or equal to the operand bit width, otherwise returns the operation result.

Parameters:

- `y`: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The number of bits to shift.

Return Value:

- `?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)` - The result of the left shift operation.

#### func checkedShr(UInt64)

```cangjie
public func checkedShr(y: UInt64): ?UIntNative
```

Function: Right shift operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

Returns `?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).None` when the shift count is greater than or equal to the operand bit width, otherwise returns the operation result.

Parameters:

- `y`: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The number of bits to shift.

Return Value:

- `?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)` - The result of the right shift operation.

#### func checkedSub(UIntNative)

```cangjie
public func checkedSub(y: UIntNative): ?UIntNative
```

Function: Subtraction operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

When overflow occurs during the operation, returns ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).None; otherwise returns the operation result.

Parameters:

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The subtrahend.

Return Value:

- ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The subtraction operation result.

## interface CheckedPow

```cangjie
public interface CheckedPow {
    func checkedPow(y: UInt64): ?Int64
}
```

Function: Provides an exponentiation interface using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

### func checkedPow(UInt64)

```cangjie
func checkedPow(y: UInt64): ?Int64
```

Function: Exponentiation operation using the [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) return strategy.

When overflow occurs during the operation, returns ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64).None; otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The exponent.

Return Value:

- ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The exponentiation result.

## interface SaturatingOp\<T>

```cangjie
public interface SaturatingOp<T> {
    func saturatingAdd(y: T): T
    func saturatingDec(): T
    func saturatingDiv(y: T): T
    func saturatingInc(): T
    func saturatingMod(y: T): T
    func saturatingMul(y: T): T
    func saturatingNeg(): T
    func saturatingShl(y: UInt64): T
    func saturatingShr(y: UInt64): T
    func saturatingSub(y: T): T
}
```

Function: Performs saturation handling when integer operations overflow.

### func saturatingAdd(T)

```cangjie
func saturatingAdd(y: T): T
```

Function: Addition operation using saturation strategy.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the operation result.

Parameters:

- y: T - The addend.

Return Value:

- T - The addition operation result.

### func saturatingDec()

```cangjie
func saturatingDec(): T
```

Function: Decrement operation using saturation strategy.

When underflow occurs, returns the minimum value of the operand type; otherwise returns the operation result.

Return Value:

- T - The decrement operation result.

### func saturatingDiv(T)

```cangjie
func saturatingDiv(y: T): T
```

Function: Division operation using saturation strategy.

When overflow occurs, returns the maximum value of the operand type; otherwise returns the operation result.

Parameters:

- y: T - The divisor.

Return Value:

- T - The division operation result.

### func saturatingInc()

```cangjie
func saturatingInc(): T
```

Function: Increment operation using saturation strategy.

When overflow occurs, returns the maximum value of the operand type; otherwise returns the operation result.

Return Value:

- T - The increment operation result.

### func saturatingMod(T)

```cangjie
func saturatingMod(y: T): T
```

Function: Modulus operation using saturation strategy.

When overflow occurs, returns the maximum value of the operand type; otherwise returns the operation result.

Parameters:

- y: T - The divisor.

Return Value:

- T - The modulus operation result.

### func saturatingMul(T)

```cangjie
func saturatingMul(y: T): T
```

Function: Saturation-based multiplication operation.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the computation result.

Parameters:

- y: T - Multiplier.

Return value:

- T - Result of the multiplication operation.

### func saturatingNeg()

```cangjie
func saturatingNeg(): T
```

Function: Saturation-based negation operation.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the computation result.

Return value:

- T - Result of the negation operation.

### func saturatingShl(UInt64)

```cangjie
func saturatingShl(y: UInt64): T
```

Function: Saturation-based left shift operation.

When the shift count is greater than or equal to the bit width of the operand, sets the shift count to (operand bit width - 1) and returns the computation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- T - Result of the left shift operation.

### func saturatingShr(UInt64)

```cangjie
func saturatingShr(y: UInt64): T
```

Function: Saturation-based right shift operation.

When the shift count is greater than or equal to the bit width of the operand, sets the shift count to (operand bit width - 1) and returns the computation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- T - Result of the right shift operation.

### func saturatingSub(T)

```cangjie
func saturatingSub(y: T): T
```

Function: Saturation-based subtraction operation.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the computation result.

Parameters:

- y: T - Subtrahend.

Return value:

- T - Result of the subtraction operation.

### extend Int16 <: SaturatingOp\<Int16>

```cangjie
extend Int16 <: SaturatingOp<Int16>
```

Function: Implements the [SaturatingOp](#interface-saturatingopt) interface for [Int16](../../core/core_package_api/core_package_intrinsics.md#int16).

Parent type:

- [SaturatingOp](#interface-saturatingopt)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)>

#### func saturatingAdd(Int16)

```cangjie
public func saturatingAdd(y: Int16): Int16
```

Function: Saturation-based addition operation.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the computation result.

Parameters:

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Addend.

Return value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Result of the addition operation.

#### func saturatingDec()

```cangjie
public func saturatingDec(): Int16
```

Function: Saturation-based decrement operation.

When underflow occurs, returns the minimum value of the operand type; otherwise returns the computation result.

Return value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Result of the decrement operation.

#### func saturatingDiv(Int16)

```cangjie
public func saturatingDiv(y: Int16): Int16
```

Function: Saturation-based division operation.

When overflow occurs, returns the maximum value of the operand type; otherwise returns the computation result.

Parameters:

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Divisor.

Return value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Result of the division operation.

#### func saturatingInc()

```cangjie
public func saturatingInc(): Int16
```

Function: Saturating Increment Operation.

When an overflow occurs during the operation, returns the maximum value of the operand type; otherwise, returns the operation result.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Result of the increment operation.

#### func saturatingMod(Int16)

```cangjie
public func saturatingMod(y: Int16): Int16
```

Function: Saturating Modulo Operation.

When an overflow occurs during the operation, returns the maximum value of the operand type; otherwise, returns the operation result.

Parameters:

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Divisor.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Result of the modulo operation.

#### func saturatingMul(Int16)

```cangjie
public func saturatingMul(y: Int16): Int16
```

Function: Saturating Multiplication Operation.

When an overflow occurs during the operation, returns the maximum value of the operand type; when an underflow occurs, returns the minimum value of the operand type; otherwise, returns the operation result.

Parameters:

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Multiplier.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Result of the multiplication operation.

#### func saturatingNeg()

```cangjie
public func saturatingNeg(): Int16
```

Function: Saturating Negation Operation.

When an overflow occurs during the operation, returns the maximum value of the operand type; when an underflow occurs, returns the minimum value of the operand type; otherwise, returns the operation result.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Result of the negation operation.

#### func saturatingShl(UInt64)

```cangjie
public func saturatingShl(y: UInt64): Int16
```

Function: Saturating Left Shift Operation.

When the shift count is greater than or equal to the bit width of the operand, sets the shift count to the operand bit width - 1 and returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Result of the left shift operation.

#### func saturatingShr(UInt64)

```cangjie
public func saturatingShr(y: UInt64): Int16
```

Function: Saturating Right Shift Operation.

When the shift count is greater than or equal to the bit width of the operand, sets the shift count to the operand bit width - 1 and returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Result of the right shift operation.

#### func saturatingSub(Int16)

```cangjie
public func saturatingSub(y: Int16): Int16
```

Function: Saturating Subtraction Operation.

When an overflow occurs during the operation, returns the maximum value of the operand type; when an underflow occurs, returns the minimum value of the operand type; otherwise, returns the operation result.

Parameters:

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Subtrahend.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Result of the subtraction operation.

### extend Int32 <: SaturatingOp\<Int32>

```cangjie
extend Int32 <: SaturatingOp<Int32>
```

Function: Implements the [SaturatingOp](#interface-saturatingopt) interface for [Int32](../../core/core_package_api/core_package_intrinsics.md#int32).

Parent Type:

- [SaturatingOp](#interface-saturatingopt)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)>

#### func saturatingAdd(Int32)

```cangjie
public func saturatingAdd(y: Int32): Int32
```

Function: Saturating Addition Operation.

When an overflow occurs during the operation, returns the maximum value of the operand type; when an underflow occurs, returns the minimum value of the operand type; otherwise, returns the operation result.

Parameters:

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Addend.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Result of the addition operation.

#### func saturatingDec()

```cangjie
public func saturatingDec(): Int32
```

Function: Saturating Decrement Operation.

When underflow occurs during the operation, returns the minimum value of the operand type; otherwise, returns the operation result.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Result of the decrement operation.

#### func saturatingDiv(Int32)

```cangjie
public func saturatingDiv(y: Int32): Int32
```

Function: Saturating Division Operation.

When overflow occurs during the operation, returns the maximum value of the operand type; otherwise, returns the operation result.

Parameters:

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Divisor.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Result of the division operation.

#### func saturatingInc()

```cangjie
public func saturatingInc(): Int32
```

Function: Saturating Increment Operation.

When overflow occurs during the operation, returns the maximum value of the operand type; otherwise, returns the operation result.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Result of the increment operation.

#### func saturatingMod(Int32)

```cangjie
public func saturatingMod(y: Int32): Int32
```

Function: Saturating Modulo Operation.

When overflow occurs during the operation, returns the maximum value of the operand type; otherwise, returns the operation result.

Parameters:

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Divisor.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Result of the modulo operation.

#### func saturatingMul(Int32)

```cangjie
public func saturatingMul(y: Int32): Int32
```

Function: Saturation arithmetic multiplication.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the operation result.

Parameters:

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Multiplier.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Result of the multiplication operation.

#### func saturatingNeg()

```cangjie
public func saturatingNeg(): Int32
```

Function: Saturation arithmetic negation.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the operation result.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Result of the negation operation.

#### func saturatingShl(UInt64)

```cangjie
public func saturatingShl(y: UInt64): Int32
```

Function: Saturation arithmetic left shift.

When the shift count is greater than or equal to the bit width of the operand, sets the shift count to (operand bit width - 1) and returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Result of the left shift operation.

#### func saturatingShr(UInt64)

```cangjie
public func saturatingShr(y: UInt64): Int32
```

Function: Saturation arithmetic right shift.

When the shift count is greater than or equal to the bit width of the operand, sets the shift count to (operand bit width - 1) and returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Result of the right shift operation.

#### func saturatingSub(Int32)

```cangjie
public func saturatingSub(y: Int32): Int32
```

Function: Saturation arithmetic subtraction.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the operation result.

Parameters:

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Subtrahend.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Result of the subtraction operation.

### extend Int64 <: SaturatingOp\<Int64> & SaturatingPow

```cangjie
extend Int64 <: SaturatingOp<Int64> & SaturatingPow
```

Function: Implements [SaturatingOp](#interface-saturatingopt) and [SaturatingPow](#interface-saturatingpow) interfaces for [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).

Parent Types:

- [SaturatingOp](#interface-saturatingopt)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>
- [SaturatingPow](#interface-saturatingpow)

#### func saturatingAdd(Int64)

```cangjie
public func saturatingAdd(y: Int64): Int64
```

Function: Saturation arithmetic addition.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the operation result.

Parameters:

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Addend.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the addition operation.

#### func saturatingDec()

```cangjie
public func saturatingDec(): Int64
```

Function: Saturation arithmetic decrement.

When underflow occurs, returns the minimum value of the operand type; otherwise returns the operation result.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the decrement operation.

#### func saturatingDiv(Int64)

```cangjie
public func saturatingDiv(y: Int64): Int64
```

Function: Saturation arithmetic division.

When overflow occurs, returns the maximum value of the operand type; otherwise returns the operation result.

Parameters:

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Divisor.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the division operation.#### func saturatingInc()

```cangjie
public func saturatingInc(): Int64
```

Function: Saturating increment operation.

When overflow occurs, returns the maximum value of the operand type; otherwise returns the computation result.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the increment operation.

#### func saturatingMod(Int64)

```cangjie
public func saturatingMod(y: Int64): Int64
```

Function: Saturating modulus operation.

When overflow occurs, returns the maximum value of the operand type; otherwise returns the computation result.

Parameters:

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Divisor.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the modulus operation.

#### func saturatingMul(Int64)

```cangjie
public func saturatingMul(y: Int64): Int64
```

Function: Saturating multiplication operation.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the computation result.

Parameters:

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Multiplier.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the multiplication operation.

#### func saturatingNeg()

```cangjie
public func saturatingNeg(): Int64
```

Function: Saturating negation operation.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the computation result.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the negation operation.

#### func saturatingPow(UInt64)

```cangjie
public func saturatingPow(y: UInt64): Int64
```

Function: Saturating exponentiation operation.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the computation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Exponent.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the exponentiation operation.

#### func saturatingShl(UInt64)

```cangjie
public func saturatingShl(y: UInt64): Int64
```

Function: Saturating left shift operation.

When the shift count is greater than or equal to the bit width of the operand, sets the shift count to (operand bit width - 1) and returns the computation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the left shift operation.

#### func saturatingShr(UInt64)

```cangjie
public func saturatingShr(y: UInt64): Int64
```

Function: Saturating right shift operation.

When the shift count is greater than or equal to the bit width of the operand, sets the shift count to (operand bit width - 1) and returns the computation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the right shift operation.

#### func saturatingSub(Int64)

```cangjie
public func saturatingSub(y: Int64): Int64
```

Function: Saturating subtraction operation.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the computation result.

Parameters:

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Subtrahend.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the subtraction operation.

### extend Int8 <: SaturatingOp\<Int8>

```cangjie
extend Int8 <: SaturatingOp<Int8>
```

Function: Implements the [SaturatingOp](#interface-saturatingopt) interface for [Int8](../../core/core_package_api/core_package_intrinsics.md#int8).

Parent type:

- [SaturatingOp](#interface-saturatingopt)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)>

#### func saturatingAdd(Int8)

```cangjie
public func saturatingAdd(y: Int8): Int8
```

Function: Saturating addition operation.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the operation result.

Parameters:

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The addend.

Return value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The result of the addition operation.

#### func saturatingDec()

```cangjie
public func saturatingDec(): Int8
```

Function: Saturating decrement operation.

When underflow occurs, returns the minimum value of the operand type; otherwise returns the operation result.

Return value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The result of the decrement operation.

#### func saturatingDiv(Int8)

```cangjie
public func saturatingDiv(y: Int8): Int8
```

Function: Saturating division operation.

When overflow occurs, returns the maximum value of the operand type; otherwise returns the operation result.

Parameters:

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The divisor.

Return value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The result of the division operation.

#### func saturatingInc()

```cangjie
public func saturatingInc(): Int8
```

Function: Saturating increment operation.

When overflow occurs, returns the maximum value of the operand type; otherwise returns the operation result.

Return value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The result of the increment operation.

#### func saturatingMod(Int8)

```cangjie
public func saturatingMod(y: Int8): Int8
```

Function: Saturating modulus operation.

When overflow occurs, returns the maximum value of the operand type; otherwise returns the operation result.

Parameters:

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The divisor.

Return value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The result of the modulus operation.

#### func saturatingMul(Int8)

```cangjie
public func saturatingMul(y: Int8): Int8
```

Function: Saturating multiplication operation.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the operation result.

Parameters:

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The multiplier.

Return value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The result of the multiplication operation.

#### func saturatingNeg()

```cangjie
public func saturatingNeg(): Int8
```

Function: Saturating negation operation.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the operation result.

Return value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The result of the negation operation.

#### func saturatingShl(UInt64)

```cangjie
public func saturatingShl(y: UInt64): Int8
```

Function: Saturating left shift operation.

When the shift count is greater than or equal to the bit width of the operand, sets the shift count to the operand bit width - 1 and returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The shift count.

Return value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The result of the left shift operation.

#### func saturatingShr(UInt64)

```cangjie
public func saturatingShr(y: UInt64): Int8
```

Function: Saturating right shift operation.

When the shift count is greater than or equal to the bit width of the operand, sets the shift count to the operand bit width - 1 and returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The shift count.

Return value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The result of the right shift operation.

#### func saturatingSub(Int8)

```cangjie
public func saturatingSub(y: Int8): Int8
```

Function: Saturation arithmetic subtraction.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the computation result.

Parameters:

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The subtrahend.

Return value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The result of the subtraction operation.

### extend IntNative <: SaturatingOp\<IntNative>

```cangjie
extend IntNative <: SaturatingOp<IntNative>
```

Function: Implements the [SaturatingOp](#interface-saturatingopt) interface for [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).

Parent type:

- [SaturatingOp](#interface-saturatingopt)\<[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)>

#### func saturatingAdd(IntNative)

```cangjie
public func saturatingAdd(y: IntNative): IntNative
```

Function: Saturation arithmetic addition.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the computation result.

Parameters:

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The addend.

Return value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The result of the addition operation.

#### func saturatingDec()

```cangjie
public func saturatingDec(): IntNative
```

Function: Saturating decrement operation.

When underflow occurs, returns the minimum value of the operand type; otherwise returns the computation result.

Return value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Result of the decrement operation.

#### func saturatingDiv(IntNative)

```cangjie
public func saturatingDiv(y: IntNative): IntNative
```

Function: Saturating division operation.

When overflow occurs, returns the maximum value of the operand type; otherwise returns the computation result.

Parameters:

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Divisor.

Return value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Result of the division operation.

#### func saturatingInc()

```cangjie
public func saturatingInc(): IntNative
```

Function: Saturating increment operation.

When overflow occurs, returns the maximum value of the operand type; otherwise returns the computation result.

Return value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Result of the increment operation.

#### func saturatingMod(IntNative)

```cangjie
public func saturatingMod(y: IntNative): IntNative
```

Function: Saturating modulus operation.

When overflow occurs, returns the maximum value of the operand type; otherwise returns the computation result.

Parameters:

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Divisor.

Return value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Result of the modulus operation.

#### func saturatingMul(IntNative)

```cangjie
public func saturatingMul(y: IntNative): IntNative
```

Function: Saturating multiplication operation.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the computation result.

Parameters:

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Multiplier.

Return value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Result of the multiplication operation.

#### func saturatingNeg()

```cangjie
public func saturatingNeg(): IntNative
```

Function: Saturating negation operation.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the computation result.

Return value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Result of the negation operation.

#### func saturatingShl(UInt64)

```cangjie
public func saturatingShl(y: UInt64): IntNative
```

Function: Saturating left shift operation.

When the shift count is greater than or equal to the operand bit width, sets the shift count to (operand bit width - 1) and returns the computation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Result of the left shift operation.

#### func saturatingShr(UInt64)

```cangjie
public func saturatingShr(y: UInt64): IntNative
```

Function: Saturating right shift operation.

When the shift count is greater than or equal to the operand bit width, sets the shift count to (operand bit width - 1) and returns the computation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Result of the right shift operation.

#### func saturatingSub(IntNative)

```cangjie
public func saturatingSub(y: IntNative): IntNative
```

Function: Saturating subtraction operation.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the computation result.

Parameters:

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Subtrahend.

Return value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Result of the subtraction operation.### extend UInt16 <: SaturatingOp\<UInt16>

```cangjie
extend UInt16 <: SaturatingOp<UInt16>
```

Function: Implements the [SaturatingOp](#interface-saturatingopt) interface for [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).

Parent Types:

- [SaturatingOp](#interface-saturatingopt)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)>

#### func saturatingAdd(UInt16)

```cangjie
public func saturatingAdd(y: UInt16): UInt16
```

Function: Performs saturation arithmetic addition.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the operation result.

Parameters:

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The addend.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The result of the addition operation.

#### func saturatingDec()

```cangjie
public func saturatingDec(): UInt16
```

Function: Performs saturation arithmetic decrement.

When underflow occurs, returns the minimum value of the operand type; otherwise returns the operation result.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The result of the decrement operation.

#### func saturatingDiv(UInt16)

```cangjie
public func saturatingDiv(y: UInt16): UInt16
```

Function: Performs saturation arithmetic division.

When overflow occurs, returns the maximum value of the operand type; otherwise returns the operation result.

Parameters:

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The divisor.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The result of the division operation.

#### func saturatingInc()

```cangjie
public func saturatingInc(): UInt16
```

Function: Performs saturation arithmetic increment.

When overflow occurs, returns the maximum value of the operand type; otherwise returns the operation result.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The result of the increment operation.

#### func saturatingMod(UInt16)

```cangjie
public func saturatingMod(y: UInt16): UInt16
```

Function: Performs saturation arithmetic modulus.

When overflow occurs, returns the maximum value of the operand type; otherwise returns the operation result.

Parameters:

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The divisor.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The result of the modulus operation.

#### func saturatingMul(UInt16)

```cangjie
public func saturatingMul(y: UInt16): UInt16
```

Function: Performs saturation arithmetic multiplication.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the operation result.

Parameters:

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The multiplier.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The result of the multiplication operation.

#### func saturatingNeg()

```cangjie
public func saturatingNeg(): UInt16
```

Function: Performs saturation arithmetic negation.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the operation result.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The result of the negation operation.

#### func saturatingShl(UInt64)

```cangjie
public func saturatingShl(y: UInt64): UInt16
```

Function: Performs saturation arithmetic left shift.

When the shift count is greater than or equal to the bit width of the operand, sets the shift count to (operand bit width - 1) and returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The shift count.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The result of the left shift operation.

#### func saturatingShr(UInt64)

```cangjie
public func saturatingShr(y: UInt64): UInt16
```

Function: Right shift operation using saturation strategy.

When the shift count is greater than or equal to the operand bit width, set the shift count to (operand bit width - 1) and return the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Result of right shift operation.

#### func saturatingSub(UInt16)

```cangjie
public func saturatingSub(y: UInt16): UInt16
```

Function: Subtraction operation using saturation strategy.

Returns the maximum value of the operand type when overflow occurs, the minimum value of the operand type when underflow occurs, otherwise returns the operation result.

Parameters:

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Subtrahend.

Return value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Result of subtraction operation.

### extend UInt32 <: SaturatingOp\<UInt32>

```cangjie
extend UInt32 <: SaturatingOp<UInt32>
```

Function: Implements the [SaturatingOp](#interface-saturatingopt) interface for [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).

Parent type:

- [SaturatingOp](#interface-saturatingopt)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)>

#### func saturatingAdd(UInt32)

```cangjie
public func saturatingAdd(y: UInt32): UInt32
```

Function: Addition operation using saturation strategy.

Returns the maximum value of the operand type when overflow occurs, the minimum value of the operand type when underflow occurs, otherwise returns the operation result.

Parameters:

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Addend.

Return value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Result of addition operation.

#### func saturatingDec()

```cangjie
public func saturatingDec(): UInt32
```

Function: Decrement operation using saturation strategy.

Returns the minimum value of the operand type when underflow occurs, otherwise returns the operation result.

Return value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Result of decrement operation.

#### func saturatingDiv(UInt32)

```cangjie
public func saturatingDiv(y: UInt32): UInt32
```

Function: Division operation using saturation strategy.

Returns the maximum value of the operand type when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Divisor.

Return value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Result of division operation.

#### func saturatingInc()

```cangjie
public func saturatingInc(): UInt32
```

Function: Increment operation using saturation strategy.

Returns the maximum value of the operand type when overflow occurs, otherwise returns the operation result.

Return value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Result of increment operation.

#### func saturatingMod(UInt32)

```cangjie
public func saturatingMod(y: UInt32): UInt32
```

Function: Modulo operation using saturation strategy.

Returns the maximum value of the operand type when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Divisor.

Return value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Result of modulo operation.

#### func saturatingMul(UInt32)

```cangjie
public func saturatingMul(y: UInt32): UInt32
```

Function: Multiplication operation using saturation strategy.

Returns the maximum value of the operand type when overflow occurs, the minimum value of the operand type when underflow occurs, otherwise returns the operation result.

Parameters:

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Multiplier.

Return value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Result of multiplication operation.

#### func saturatingNeg()

```cangjie
public func saturatingNeg(): UInt32
```

Function: Negation operation using saturation strategy.When an operation overflows, return the maximum value of the operand type; when an operation underflows, return the minimum value of the operand type; otherwise, return the operation result.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Result of the negation operation.

#### func saturatingShl(UInt64)

```cangjie
public func saturatingShl(y: UInt64): UInt32
```

Function: Left shift operation using saturation strategy.

When the shift count is greater than or equal to the bit width of the operand, set the shift count to the operand bit width - 1 and return the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Result of the left shift operation.

#### func saturatingShr(UInt64)

```cangjie
public func saturatingShr(y: UInt64): UInt32
```

Function: Right shift operation using saturation strategy.

When the shift count is greater than or equal to the bit width of the operand, set the shift count to the operand bit width - 1 and return the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Result of the right shift operation.

#### func saturatingSub(UInt32)

```cangjie
public func saturatingSub(y: UInt32): UInt32
```

Function: Subtraction operation using saturation strategy.

When the operation overflows, return the maximum value of the operand type; when the operation underflows, return the minimum value of the operand type; otherwise, return the operation result.

Parameters:

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Subtrahend.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Result of the subtraction operation.

### extend UInt64 <: SaturatingOp\<UInt64>

```cangjie
extend UInt64 <: SaturatingOp<UInt64>
```

Function: Implements the [SaturatingOp](#interface-saturatingopt) interface for [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).

Parent Types:

- [SaturatingOp](#interface-saturatingopt)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)>

#### func saturatingAdd(UInt64)

```cangjie
public func saturatingAdd(y: UInt64): UInt64
```

Function: Performs saturating addition.

On overflow, returns the maximum value of the operand type; on underflow, returns the minimum value of the operand type; otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The addend.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The result of the addition operation.

#### func saturatingDec()

```cangjie
public func saturatingDec(): UInt64
```

Function: Performs saturating decrement.

On underflow, returns the minimum value of the operand type; otherwise returns the operation result.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The result of the decrement operation.

#### func saturatingDiv(UInt64)

```cangjie
public func saturatingDiv(y: UInt64): UInt64
```

Function: Performs saturating division.

On overflow, returns the maximum value of the operand type; otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The divisor.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The result of the division operation.

#### func saturatingInc()

```cangjie
public func saturatingInc(): UInt64
```

Function: Performs saturating increment.

On overflow, returns the maximum value of the operand type; otherwise returns the operation result.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The result of the increment operation.

#### func saturatingMod(UInt64)

```cangjie
public func saturatingMod(y: UInt64): UInt64
```

Function: Performs saturating modulus.

On overflow, returns the maximum value of the operand type; otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The divisor.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The result of the modulus operation.

#### func saturatingMul(UInt64)

```cangjie
public func saturatingMul(y: UInt64): UInt64
```

Function: Performs saturating multiplication.

On overflow, returns the maximum value of the operand type; on underflow, returns the minimum value of the operand type; otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The multiplier.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The result of the multiplication operation.

#### func saturatingNeg()

```cangjie
public func saturatingNeg(): UInt64
```

Function: Performs saturating negation.

On overflow, returns the maximum value of the operand type; on underflow, returns the minimum value of the operand type; otherwise returns the operation result.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The result of the negation operation.

#### func saturatingShl(UInt64)

```cangjie
public func saturatingShl(y: UInt64): UInt64
```

Function: Performs saturating left shift.

When the shift count is greater than or equal to the bit width of the operand, sets the shift count to (operand bit width - 1) and returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The shift count.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The result of the left shift operation.

#### func saturatingShr(UInt64)

```cangjie
public func saturatingShr(y: UInt64): UInt64
```

Function: Right shift operation using saturation strategy.

When the shift count is greater than or equal to the operand bit width, the shift count is set to (operand bit width - 1), and the operation result is returned.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Result of the right shift operation.

#### func saturatingSub(UInt64)

```cangjie
public func saturatingSub(y: UInt64): UInt64
```

Function: Subtraction operation using saturation strategy.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Subtrahend.

Return value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Result of the subtraction operation.

### extend UInt8 <: SaturatingOp\<UInt8>

```cangjie
extend UInt8 <: SaturatingOp<UInt8>
```

Function: Implements the [SaturatingOp](#interface-saturatingopt) interface for [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).

Parent type:

- [SaturatingOp](#interface-saturatingopt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)>

#### func saturatingAdd(UInt8)

```cangjie
public func saturatingAdd(y: UInt8): UInt8
```

Function: Addition operation using saturation strategy.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the operation result.

Parameters:

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Addend.

Return value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the addition operation.

#### func saturatingDec()

```cangjie
public func saturatingDec(): UInt8
```

Function: Decrement operation using saturation strategy.

When underflow occurs, returns the minimum value of the operand type; otherwise returns the operation result.

Return value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the decrement operation.

#### func saturatingDiv(UInt8)

```cangjie
public func saturatingDiv(y: UInt8): UInt8
```

Function: Division operation using saturation strategy.

When overflow occurs, returns the maximum value of the operand type; otherwise returns the operation result.

Parameters:

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Divisor.

Return value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the division operation.

#### func saturatingInc()

```cangjie
public func saturatingInc(): UInt8
```

Function: Increment operation using saturation strategy.

When overflow occurs, returns the maximum value of the operand type; otherwise returns the operation result.

Return value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the increment operation.

#### func saturatingMod(UInt8)

```cangjie
public func saturatingMod(y: UInt8): UInt8
```

Function: Modulo operation using saturation strategy.

When overflow occurs, returns the maximum value of the operand type; otherwise returns the operation result.

Parameters:

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Divisor.

Return value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the modulo operation.

#### func saturatingMul(UInt8)

```cangjie
public func saturatingMul(y: UInt8): UInt8
```

Function: Multiplication operation using saturation strategy.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the operation result.

Parameters:

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Multiplier.

Return value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the multiplication operation.

#### func saturatingNeg()

```cangjie
public func saturatingNeg(): UInt8
```

Function: Negation operation using saturation strategy.When an operation overflows, return the maximum value of the operand type; when an operation underflows, return the minimum value of the operand type; otherwise, return the operation result.

Return value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the negation operation.

#### func saturatingShl(UInt64)

```cangjie
public func saturatingShl(y: UInt64): UInt8
```

Function: Left shift operation using saturation strategy.

When the shift count is greater than or equal to the bit width of the operand, set the shift count to the operand bit width - 1 and return the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the left shift operation.

#### func saturatingShr(UInt64)

```cangjie
public func saturatingShr(y: UInt64): UInt8
```

Function: Right shift operation using saturation strategy.

When the shift count is greater than or equal to the bit width of the operand, set the shift count to the operand bit width - 1 and return the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the right shift operation.

#### func saturatingSub(UInt8)

```cangjie
public func saturatingSub(y: UInt8): UInt8
```

Function: Subtraction operation using saturation strategy.

When an operation overflows, return the maximum value of the operand type; when an operation underflows, return the minimum value of the operand type; otherwise, return the operation result.

Parameters:

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Subtrahend.

Return value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the subtraction operation.

### extend UIntNative <: SaturatingOp\<UIntNative>

```cangjie
extend UIntNative <: SaturatingOp<UIntNative>
```

Function: Implements the [SaturatingOp](#interface-saturatingopt) interface for [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).

Parent type:

- [SaturatingOp](#interface-saturatingopt)\<[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)>

#### func saturatingAdd(UIntNative)

```cangjie
public func saturatingAdd(y: UIntNative): UIntNative
```

Function: Addition operation using saturation strategy.

When an operation overflows, return the maximum value of the operand type; when an operation underflows, return the minimum value of the operand type; otherwise, return the operation result.

Parameters:

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Addend.

Return value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Result of the addition operation.

#### func saturatingDec()

```cangjie
public func saturatingDec(): UIntNative
```

Function: Decrement operation using saturation strategy.

When an operation underflows, return the minimum value of the operand type; otherwise, return the operation result.

Return value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Result of the decrement operation.

#### func saturatingDiv(UIntNative)

```cangjie
public func saturatingDiv(y: UIntNative): UIntNative
```

Function: Division operation using saturation strategy.

When an operation overflows, return the maximum value of the operand type; otherwise, return the operation result.

Parameters:

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Divisor.

Return value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Result of the division operation.

#### func saturatingInc()

```cangjie
public func saturatingInc(): UIntNative
```

Function: Increment operation using saturation strategy.

When an operation overflows, return the maximum value of the operand type; otherwise, return the operation result.

Return value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Result of the increment operation.

#### func saturatingMod(UIntNative)

```cangjie
public func saturatingMod(y: UIntNative): UIntNative
```

Function: Modulo operation using saturation strategy.

When an operation overflows, return the maximum value of the operand type; otherwise, return the operation result.

Parameters:

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Divisor.Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The result of the modulo operation.

#### func saturatingMul(UIntNative)

```cangjie
public func saturatingMul(y: UIntNative): UIntNative
```

Function: Multiplication operation using saturation strategy.

When overflow occurs during the operation, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise, returns the operation result.

Parameters:

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The multiplier.

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The result of the multiplication operation.

#### func saturatingNeg()

```cangjie
public func saturatingNeg(): UIntNative
```

Function: Negation operation using saturation strategy.

When overflow occurs during the operation, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise, returns the operation result.

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The result of the negation operation.

#### func saturatingShl(UInt64)

```cangjie
public func saturatingShl(y: UInt64): UIntNative
```

Function: Left shift operation using saturation strategy.

When the shift count is greater than or equal to the operand bit width, the shift count is set to (operand bit width - 1), then returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Result of left shift operation.

#### func saturatingShr(UInt64)

```cangjie
public func saturatingShr(y: UInt64): UIntNative
```

Function: Right shift operation using saturation strategy.

When the shift count is greater than or equal to the operand bit width, the shift count is set to (operand bit width - 1), then returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Result of right shift operation.

#### func saturatingSub(UIntNative)

```cangjie
public func saturatingSub(y: UIntNative): UIntNative
```

Function: Subtraction operation using saturation strategy.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the operation result.

Parameters:

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Subtrahend.

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Result of subtraction operation.

## interface SaturatingPow

```cangjie
public interface SaturatingPow {
    func saturatingPow(y: UInt64): Int64
}
```

Function: Provides power operation interface using saturation strategy.

### func saturatingPow(UInt64)

```cangjie
func saturatingPow(y: UInt64): Int64
```

Function: Power operation using saturation strategy.

When overflow occurs, returns the maximum value of the operand type; when underflow occurs, returns the minimum value of the operand type; otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Exponent.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of power operation.

## interface ThrowingOp\<T>

```cangjie
public interface ThrowingOp<T> {
    func throwingAdd(y: T): T
    func throwingSub(y: T): T
    func throwingMul(y: T): T
    func throwingDiv(y: T): T
    func throwingMod(y: T): T
    func throwingInc(): T
    func throwingDec(): T
    func throwingNeg(): T
    func throwingShl(y: UInt64): T
    func throwingShr(y: UInt64): T
}
```

Function: Throws exceptions when integer operations overflow.

### func throwingAdd(T)

```cangjie
func throwingAdd(y: T): T
```

Function: Addition operation using exception-throwing strategy.

Throws an exception when overflow occurs; otherwise returns the operation result.

Parameters:

- y: T - Addend.

Return Value:

- T - Result of addition operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Throws exception when addition operation overflows.

### func throwingDec()

```cangjie
func throwingDec(): T
```

Function: Decrement operation using exception-throwing strategy.

Throws an exception when overflow occurs; otherwise returns the operation result.

Return Value:

- T - Result of decrement operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Throws exception when decrement operation overflows.

### func throwingDiv(T)

```cangjie
func throwingDiv(y: T): T
```

Function: Division operation using exception-throwing strategy.Throws an exception when overflow occurs during the operation; otherwise, returns the operation result.

Parameters:

- y: T - The divisor.

Return Value:

- T - The result of the division operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the division operation.

### func throwingInc()

```cangjie
func throwingInc(): T
```

Function: Increment operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation; otherwise, returns the operation result.

Return Value:

- T - The result of the increment operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the increment operation.

### func throwingMod(T)

```cangjie
func throwingMod(y: T): T
```

Function: Modulo operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation; otherwise, returns the operation result.

Parameters:

- y: T - The divisor.

Return Value:

- T - The result of the modulo operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the modulo operation.

### func throwingMul(T)

```cangjie
func throwingMul(y: T): T
```

Function: Multiplication operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation; otherwise, returns the operation result.

Parameters:

- y: T - The multiplier.

Return Value:

- T - The result of the multiplication operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the multiplication operation.

### func throwingNeg()

```cangjie
func throwingNeg(): T
```

Function: Negation operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation; otherwise, returns the operation result.

Return Value:

- T - The result of the negation operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the negation operation.

### func throwingShl(UInt64)

```cangjie
func throwingShl(y: UInt64): T
```

Function: Left shift operation with exception-throwing strategy.

Throws an exception when the shift count is greater than or equal to the operand's bit width; otherwise, returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The shift count.

Return Value:

- T - The result of the left shift operation.

Exceptions:

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - Thrown when the shift count is greater than or equal to the operand's bit width.

### func throwingShr(UInt64)

```cangjie
func throwingShr(y: UInt64): T
```

Function: Right shift operation.

Throws an exception when the shift count is greater than or equal to the operand's bit width; otherwise, returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The shift count.

Return Value:

- T - The result of the right shift operation.

Exceptions:

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - Thrown when the shift count is greater than or equal to the operand's bit width.

### func throwingSub(T)

```cangjie
func throwingSub(y: T): T
```

Function: Subtraction operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation; otherwise, returns the operation result.

Parameters:- y: T - The subtrahend.

Return Value:

- T - The result of the subtraction operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when the subtraction operation overflows.

### extend Int16 <: ThrowingOp\<Int16>

```cangjie
extend Int16 <: ThrowingOp<Int16>
```

Function: Implements the [ThrowingOp](#interface-throwingopt) interface for [Int16](../../core/core_package_api/core_package_intrinsics.md#int16).

Parent Type:

- [ThrowingOp](#interface-throwingopt)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)>

#### func throwingAdd(Int16)

```cangjie
public func throwingAdd(y: Int16): Int16
```

Function: Addition operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The addend.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The result of the addition operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when the addition operation overflows.

#### func throwingDec()

```cangjie
public func throwingDec(): Int16
```

Function: Decrement operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The result of the decrement operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when the decrement operation overflows.

#### func throwingDiv(Int16)

```cangjie
public func throwingDiv(y: Int16): Int16
```

Function: Division operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The divisor.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The result of the division operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when the division operation overflows.

#### func throwingInc()

```cangjie
public func throwingInc(): Int16
```

Function: Increment operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The result of the increment operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when the increment operation overflows.

#### func throwingMod(Int16)

```cangjie
public func throwingMod(y: Int16): Int16
```

Function: Modulo operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The divisor.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The result of the modulo operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when the modulo operation overflows.

#### func throwingMul(Int16)

```cangjie
public func throwingMul(y: Int16): Int16
```

Function: Multiplication operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The multiplier.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The result of the multiplication operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when the multiplication operation overflows.

#### func throwingNeg()

```cangjie
public func throwingNeg(): Int16
```

Function: Negation operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation; otherwise returns the computation result.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Result of the negation operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the negation operation.

#### func throwingShl(UInt64)

```cangjie
public func throwingShl(y: UInt64): Int16
```

Function: Left shift operation with exception-throwing strategy.

Returns the computation result when the shift count is greater than or equal to the operand bit width.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Result of the left shift operation.

Exceptions:

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - Thrown when the shift count is greater than or equal to the operand bit width.

#### func throwingShr(UInt64)

```cangjie
public func throwingShr(y: UInt64): Int16
```

Function: Right shift operation.

Throws an exception when the shift count is greater than or equal to the operand bit width; otherwise returns the computation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Result of the right shift operation.

Exceptions:

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - Thrown when the shift count is greater than or equal to the operand bit width.

#### func throwingSub(Int16)

```cangjie
public func throwingSub(y: Int16): Int16
```

Function: Subtraction operation with exception throwing strategy.

Throws an exception when overflow occurs during the operation, otherwise returns the computation result.

Parameters:

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The subtrahend.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The result of the subtraction operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during subtraction.

### extend Int32 <: ThrowingOp\<Int32>

```cangjie
extend Int32 <: ThrowingOp<Int32>
```

Function: Implements the [ThrowingOp](#interface-throwingopt) interface for [Int32](../../core/core_package_api/core_package_intrinsics.md#int32).

Parent Type:

- [ThrowingOp](#interface-throwingopt)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)>

#### func throwingAdd(Int32)

```cangjie
public func throwingAdd(y: Int32): Int32
```

Function: Addition operation with exception throwing strategy.

Throws an exception when overflow occurs during the operation, otherwise returns the computation result.

Parameters:

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The addend.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The result of the addition operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during addition.

#### func throwingDec()

```cangjie
public func throwingDec(): Int32
```

Function: Decrement operation with exception throwing strategy.

Throws an exception when overflow occurs during the operation, otherwise returns the computation result.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The result of the decrement operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during decrement.

#### func throwingDiv(Int32)

```cangjie
public func throwingDiv(y: Int32): Int32
```

Function: Division operation with exception throwing strategy.

Throws an exception when overflow occurs during the operation, otherwise returns the computation result.

Parameters:

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The divisor.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The result of the division operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during division.

#### func throwingInc()

```cangjie
public func throwingInc(): Int32
```

Function: Increment operation with exception throwing strategy.

Throws an exception when overflow occurs during the operation, otherwise returns the computation result.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The result of the increment operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during increment.

#### func throwingMod(Int32)

```cangjie
public func throwingMod(y: Int32): Int32
```

Function: Modulo operation with exception throwing strategy.

Throws an exception when overflow occurs during the operation, otherwise returns the computation result.

Parameters:

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The divisor.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The result of the modulo operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during modulo.

#### func throwingMul(Int32)

```cangjie
public func throwingMul(y: Int32): Int32
```

Function: Multiplication operation with exception throwing strategy.

Throws an exception when overflow occurs during the operation, otherwise returns the computation result.

Parameters:

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The multiplier.Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Result of the multiplication operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when multiplication overflow occurs.

#### func throwingNeg()

```cangjie
public func throwingNeg(): Int32
```

Function: Negation operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Result of the negation operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when negation overflow occurs.

#### func throwingShl(UInt64)

```cangjie
public func throwingShl(y: UInt64): Int32
```

Function: Left shift operation with exception-throwing strategy.

Throws an exception when the shift count is greater than or equal to the operand bit width, otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits to shift.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Result of the left shift operation.

Exceptions:

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - Thrown when shift count ≥ operand bit width.

#### func throwingShr(UInt64)

```cangjie
public func throwingShr(y: UInt64): Int32
```

Function: Right shift operation.

Throws an exception when the shift count is greater than or equal to the operand bit width, otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits to shift.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Result of the right shift operation.

Exceptions:

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - Thrown when shift count ≥ operand bit width.

#### func throwingSub(Int32)

```cangjie
public func throwingSub(y: Int32): Int32
```

Function: Subtraction operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Subtrahend.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Result of the subtraction operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when subtraction overflow occurs.

### extend Int64 <: ThrowingOp\<Int64> & ThrowingPow

```cangjie
extend Int64 <: ThrowingOp<Int64> & ThrowingPow
```

Function: Implements [ThrowingOp](#interface-throwingopt) and [ThrowingPow](#interface-throwingpow) interfaces for [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).

Parent Types:

- [ThrowingOp](#interface-throwingopt)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>
- [ThrowingPow](#interface-throwingpow)

#### func throwingAdd(Int64)

```cangjie
public func throwingAdd(y: Int64): Int64
```

Function: Addition operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Addend.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the addition operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when addition overflow occurs.

#### func throwingDec()

```cangjie
public func throwingDec(): Int64
```

Function: Decrement operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the decrement operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when decrement overflow occurs.

#### func throwingDiv(Int64)

```cangjie
public func throwingDiv(y: Int64): Int64
```

Function: Division operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation, otherwise returns the computation result.

Parameters:

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Divisor.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the division operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the division operation.

#### func throwingInc()

```cangjie
public func throwingInc(): Int64
```

Function: Increment operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation, otherwise returns the computation result.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the increment operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the increment operation.

#### func throwingMod(Int64)

```cangjie
public func throwingMod(y: Int64): Int64
```

Function: Modulo operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation, otherwise returns the computation result.

Parameters:

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Divisor.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the modulo operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the modulo operation.

#### func throwingMul(Int64)

```cangjie
public func throwingMul(y: Int64): Int64
```

Function: Multiplication operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation, otherwise returns the computation result.

Parameters:

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Multiplier.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the multiplication operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the multiplication operation.

#### func throwingNeg()

```cangjie
public func throwingNeg(): Int64
```

Function: Negation operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation, otherwise returns the computation result.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the negation operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the negation operation.

#### func throwingPow(UInt64)

```cangjie
public func throwingPow(y: UInt64): Int64
```

Function: Exponentiation operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation, otherwise returns the computation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Exponent.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the exponentiation operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the exponentiation operation.

#### func throwingShl(UInt64)

```cangjie
public func throwingShl(y: UInt64): Int64
```

Function: Left shift operation with exception-throwing strategy.

Throws an exception when the shift count is greater than or equal to the operand's bit width, otherwise returns the computation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the left shift operation.

Exceptions:

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - Thrown when the shift count is greater than or equal to the operand's bit width.

#### func throwingShr(UInt64)

```cangjie
public func throwingShr(y: UInt64): Int64
```

Function: Right shift operation.Throws an exception when the shift amount is greater than or equal to the operand's bit width; otherwise, returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The number of bits to shift.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The result of the right shift operation.

Exceptions:

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - Thrown when the shift amount is greater than or equal to the operand's bit width.

#### func throwingSub(Int64)

```cangjie
public func throwingSub(y: Int64): Int64
```

Function: Subtraction operation with exception-throwing strategy.

Throws an exception when overflow occurs; otherwise, returns the operation result.

Parameters:

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The subtrahend.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The result of the subtraction operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when the subtraction operation results in overflow.

### extend Int8 <: ThrowingOp\<Int8>

```cangjie
extend Int8 <: ThrowingOp<Int8>
```

Function: Implements the [ThrowingOp](#interface-throwingopt) interface for [Int8](../../core/core_package_api/core_package_intrinsics.md#int8).

Parent Type:

- [ThrowingOp](#interface-throwingopt)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)>

#### func throwingAdd(Int8)

```cangjie
public func throwingAdd(y: Int8): Int8
```

Function: Addition operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The addend.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The result of the addition operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Throws an exception when addition overflow occurs.

#### func throwingDec()

```cangjie
public func throwingDec(): Int8
```

Function: Decrement operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The result of the decrement operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Throws an exception when decrement overflow occurs.

#### func throwingDiv(Int8)

```cangjie
public func throwingDiv(y: Int8): Int8
```

Function: Division operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The divisor.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The result of the division operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Throws an exception when division overflow occurs.

#### func throwingInc()

```cangjie
public func throwingInc(): Int8
```

Function: Increment operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The result of the increment operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Throws an exception when increment overflow occurs.

#### func throwingMod(Int8)

```cangjie
public func throwingMod(y: Int8): Int8
```

Function: Modulo operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The divisor.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The result of the modulo operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Throws an exception when modulo overflow occurs.

#### func throwingMul(Int8)

```cangjie
public func throwingMul(y: Int8): Int8
```

Function: Multiplication operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The multiplier.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The result of the multiplication operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Throws an exception when multiplication overflow occurs.

#### func throwingNeg()

```cangjie
public func throwingNeg(): Int8
```

Function: Negation operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The result of the negation operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Throws an exception when negation overflow occurs.

#### func throwingShl(UInt64)

```cangjie
public func throwingShl(y: UInt64): Int8
```

Function: Left shift operation with exception-throwing strategy.Throws an exception when the shift count is greater than or equal to the operand bit width; otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Left shift operation result.

Exceptions:

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - Throws an exception when the shift count is greater than or equal to the operand bit width.

#### func throwingShr(UInt64)

```cangjie
public func throwingShr(y: UInt64): Int8
```

Function: Right shift operation.

Throws an exception when the shift count is greater than or equal to the operand bit width; otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Right shift operation result.

Exceptions:

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - Throws an exception when the shift count is greater than or equal to the operand bit width.

#### func throwingSub(Int8)

```cangjie
public func throwingSub(y: Int8): Int8
```

Function: Subtraction operation with exception-throwing strategy.

Throws an exception when overflow occurs; otherwise returns the operation result.

Parameters:

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Subtrahend.

Return value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Subtraction operation result.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Throws an exception when subtraction overflow occurs.

### extend IntNative <: ThrowingOp\<IntNative>

```cangjie
extend IntNative <: ThrowingOp<IntNative>
```

Function: Implements the [ThrowingOp](#interface-throwingopt) interface for [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).

Parent type:

- [ThrowingOp](#interface-throwingopt)\<[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)>

#### func throwingAdd(IntNative)

```cangjie
public func throwingAdd(y: IntNative): IntNative
```

Function: Addition operation with exception-throwing strategy.

Throws an exception when overflow occurs; otherwise returns the operation result.

Parameters:

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Addend.

Return value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Addition operation result.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Throws an exception when addition overflow occurs.

#### func throwingDec()

```cangjie
public func throwingDec(): IntNative
```

Function: Decrement operation with exception-throwing strategy.

Throws an exception when overflow occurs; otherwise returns the operation result.

Return value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Decrement operation result.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Throws an exception when decrement overflow occurs.

#### func throwingDiv(IntNative)

```cangjie
public func throwingDiv(y: IntNative): IntNative
```

Function: Division operation with exception-throwing strategy.

Throws an exception when overflow occurs; otherwise returns the operation result.

Parameters:

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Divisor.

Return value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Division operation result.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Throws an exception when division overflow occurs.

#### func throwingInc()

```cangjie
public func throwingInc(): IntNative
```

Function: Increment operation with exception-throwing strategy.

Throws an exception when overflow occurs; otherwise returns the operation result.

Return value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Increment operation result.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Throws an exception when increment overflow occurs.#### func throwingMod(IntNative)

```cangjie
public func throwingMod(y: IntNative): IntNative
```

Function: Modulo operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation, otherwise returns the computation result.

Parameters:

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The divisor.

Return Value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The result of the modulo operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the modulo operation.

#### func throwingMul(IntNative)

```cangjie
public func throwingMul(y: IntNative): IntNative
```

Function: Multiplication operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation, otherwise returns the computation result.

Parameters:

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The multiplier.

Return Value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The result of the multiplication operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the multiplication operation.

#### func throwingNeg()

```cangjie
public func throwingNeg(): IntNative
```

Function: Negation operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation, otherwise returns the computation result.

Return Value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The result of the negation operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the negation operation.

#### func throwingShl(UInt64)

```cangjie
public func throwingShl(y: UInt64): IntNative
```

Function: Left shift operation with exception-throwing strategy.

Throws an exception when the shift count is greater than or equal to the operand's bit width, otherwise returns the computation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The number of bits to shift.

Return Value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The result of the left shift operation.

Exceptions:

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - Thrown when the shift count is greater than or equal to the operand's bit width.

#### func throwingShr(UInt64)

```cangjie
public func throwingShr(y: UInt64): IntNative
```

Function: Right shift operation.

Throws an exception when the shift count is greater than or equal to the operand's bit width, otherwise returns the computation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The number of bits to shift.

Return Value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The result of the right shift operation.

Exceptions:

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - Thrown when the shift count is greater than or equal to the operand's bit width.

#### func throwingSub(IntNative)

```cangjie
public func throwingSub(y: IntNative): IntNative
```

Function: Subtraction operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation, otherwise returns the computation result.

Parameters:

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The subtrahend.

Return Value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The result of the subtraction operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the subtraction operation.

### extend UInt16 <: ThrowingOp\<UInt16>

```cangjie
extend UInt16 <: ThrowingOp<UInt16>
```

Function: Implements the [ThrowingOp](#interface-throwingopt) interface for [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).

Parent Type:

- [ThrowingOp](#interface-throwingopt)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)>

#### func throwingAdd(UInt16)

```cangjie
public func throwingAdd(y: UInt16): UInt16
```

Function: Addition operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation, otherwise returns the computation result.Parameters:

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The addend.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The result of the addition operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the addition operation.

#### func throwingDec()

```cangjie
public func throwingDec(): UInt16
```

Function: Decrement operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The result of the decrement operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the decrement operation.

#### func throwingDiv(UInt16)

```cangjie
public func throwingDiv(y: UInt16): UInt16
```

Function: Division operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The divisor.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The result of the division operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the division operation.

#### func throwingInc()

```cangjie
public func throwingInc(): UInt16
```

Function: Increment operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation; otherwise returns the computation result.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Result of the increment operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the increment operation.

#### func throwingMod(UInt16)

```cangjie
public func throwingMod(y: UInt16): UInt16
```

Function: Modulo operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation; otherwise returns the computation result.

Parameters:

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Divisor.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Result of the modulo operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the modulo operation.

#### func throwingMul(UInt16)

```cangjie
public func throwingMul(y: UInt16): UInt16
```

Function: Multiplication operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation; otherwise returns the computation result.

Parameters:

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Multiplier.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Result of the multiplication operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the multiplication operation.

#### func throwingNeg()

```cangjie
public func throwingNeg(): UInt16
```

Function: Negation operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation; otherwise returns the computation result.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Result of the negation operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the negation operation.

#### func throwingShl(UInt64)

```cangjie
public func throwingShl(y: UInt64): UInt16
```

Function: Left shift operation with exception-throwing strategy.

Throws an exception when the shift count is greater than or equal to the operand bit width; otherwise returns the computation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Result of the left shift operation.

Exceptions:

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - Thrown when the shift count is greater than or equal to the operand bit width.

#### func throwingShr(UInt64)

```cangjie
public func throwingShr(y: UInt64): UInt16
```

Function: Right shift operation.

Throws an exception when the shift count is greater than or equal to the operand bit width; otherwise returns the computation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Result of the right shift operation.

Exceptions:

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - Thrown when the shift count is greater than or equal to the operand bit width.

#### func throwingSub(UInt16)

```cangjie
public func throwingSub(y: UInt16): UInt16
```

Function: Subtraction operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation; otherwise returns the computation result.

Parameters:

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Subtrahend.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Result of the subtraction operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the subtraction operation.

### extend UInt32 <: ThrowingOp\<UInt32>

```cangjie
extend UInt32 <: ThrowingOp<UInt32>
```

Function: Implements the [ThrowingOp](#interface-throwingopt) interface for [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).

Parent Type:

- [ThrowingOp](#interface-throwingopt)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)>

#### func throwingAdd(UInt32)

```cangjie
public func throwingAdd(y: UInt32): UInt32
```

Function: Addition operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The addend.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The result of the addition operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when addition operation overflows.

#### func throwingDec()

```cangjie
public func throwingDec(): UInt32
```

Function: Decrement operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The result of the decrement operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when decrement operation overflows.

#### func throwingDiv(UInt32)

```cangjie
public func throwingDiv(y: UInt32): UInt32
```

Function: Division operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The divisor.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The result of the division operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when division operation overflows.

#### func throwingInc()

```cangjie
public func throwingInc(): UInt32
```

Function: Increment operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The result of the increment operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when increment operation overflows.

#### func throwingMod(UInt32)

```cangjie
public func throwingMod(y: UInt32): UInt32
```

Function: Modulo operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The divisor.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The result of the modulo operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when modulo operation overflows.

#### func throwingMul(UInt32)

```cangjie
public func throwingMul(y: UInt32): UInt32
```

Function: Multiplication operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The multiplier.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The result of the multiplication operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when multiplication operation overflows.

#### func throwingNeg()

```cangjie
public func throwingNeg(): UInt32
```

Function: Negation operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The result of the negation operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when negation operation overflows.

#### func throwingShl(UInt64)

```cangjie
public func throwingShl(y: UInt64): UInt32
```

Function: Left shift operation with exception-throwing strategy.

Throws an exception when the shift count is greater than or equal to the operand bit width; otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits to shift.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Result of left shift operation.

Exceptions:

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - Thrown when shift count is greater than or equal to operand bit width.

#### func throwingShr(UInt64)

```cangjie
public func throwingShr(y: UInt64): UInt32
```

Function: Right shift operation.

Throws an exception when the shift count is greater than or equal to the operand bit width; otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits to shift.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Result of right shift operation.

Exceptions:

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - Thrown when shift count is greater than or equal to operand bit width.

#### func throwingSub(UInt32)

```cangjie
public func throwingSub(y: UInt32): UInt32
```

Function: Subtraction operation with exception-throwing strategy.

Throws an exception when overflow occurs; otherwise returns the operation result.

Parameters:

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Subtrahend.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Result of subtraction operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when subtraction operation overflows.

### extend UInt64 <: ThrowingOp\<UInt64>

```cangjie
extend UInt64 <: ThrowingOp<UInt64>
```

Function: Implements [ThrowingOp](#interface-throwingopt) interface for [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).

Parent Type:

- [ThrowingOp](#interface-throwingopt)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)>

#### func throwingAdd(UInt64)

```cangjie
public func throwingAdd(y: UInt64): UInt64
```

Function: Addition operation with exception-throwing strategy.

Throws an exception when overflow occurs; otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Addend.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Result of addition operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when addition operation overflows.

#### func throwingDec()

```cangjie
public func throwingDec(): UInt64
```

Function: Decrement operation with exception-throwing strategy.

Throws an exception when overflow occurs; otherwise returns the operation result.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Result of decrement operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when decrement operation overflows.

#### func throwingDiv(UInt64)

```cangjie
public func throwingDiv(y: UInt64): UInt64
```

Function: Division operation with exception-throwing strategy.

Throws an exception when overflow occurs; otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Divisor.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Result of division operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when division operation overflows.

#### func throwingInc()

```cangjie
public func throwingInc(): UInt64
```

Function: Increment operation with exception-throwing strategy.

Throws an exception when overflow occurs; otherwise returns the operation result.Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The result of the increment operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Throws an exception when overflow occurs during the increment operation.

#### func throwingMod(UInt64)

```cangjie
public func throwingMod(y: UInt64): UInt64
```

Function: Modulo operation with exception-throwing strategy.

Throws an exception when overflow occurs; otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The divisor.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The result of the modulo operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Throws an exception when overflow occurs during the modulo operation.

#### func throwingMul(UInt64)

```cangjie
public func throwingMul(y: UInt64): UInt64
```

Function: Multiplication operation with exception-throwing strategy.

Throws an exception when overflow occurs; otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The multiplier.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The result of the multiplication operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Throws an exception when overflow occurs during the multiplication operation.

#### func throwingNeg()

```cangjie
public func throwingNeg(): UInt64
```

Function: Negation operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation, otherwise returns the computation result.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Result of the negation operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the negation operation.

#### func throwingShl(UInt64)

```cangjie
public func throwingShl(y: UInt64): UInt64
```

Function: Left shift operation with exception-throwing strategy.

Throws an exception when the shift count is greater than or equal to the operand bit width, otherwise returns the computation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Result of the left shift operation.

Exceptions:

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - Thrown when the shift count is greater than or equal to the operand bit width.

#### func throwingShr(UInt64)

```cangjie
public func throwingShr(y: UInt64): UInt64
```

Function: Right shift operation.

Throws an exception when the shift count is greater than or equal to the operand bit width, otherwise returns the computation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Result of the right shift operation.

Exceptions:

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - Thrown when the shift count is greater than or equal to the operand bit width.

#### func throwingSub(UInt64)

```cangjie
public func throwingSub(y: UInt64): UInt64
```

Function: Subtraction operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation, otherwise returns the computation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Subtrahend.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Result of the subtraction operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the subtraction operation.

### extend UInt8 <: ThrowingOp\<UInt8>

```cangjie
extend UInt8 <: ThrowingOp<UInt8>
```

Function: Implements the [ThrowingOp](#interface-throwingopt) interface for [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).

Parent Type:

- [ThrowingOp](#interface-throwingopt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)>

#### func throwingAdd(UInt8)

```cangjie
public func throwingAdd(y: UInt8): UInt8
```

Function: Addition operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation, otherwise returns the computation result.

Parameters:

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Addend.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the addition operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the addition operation.

#### func throwingDec()

```cangjie
public func throwingDec(): UInt8
```

Function: Decrement operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation, otherwise returns the computation result.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the decrement operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the decrement operation.

#### func throwingDiv(UInt8)

```cangjie
public func throwingDiv(y: UInt8): UInt8
```

Function: Division operation with exception-throwing strategy.

Throws an exception when overflow occurs during the operation, otherwise returns the computation result.

Parameters:

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Divisor.Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the division operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during division.

#### func throwingInc()

```cangjie
public func throwingInc(): UInt8
```

Function: Increment operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the increment operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during increment.

#### func throwingMod(UInt8)

```cangjie
public func throwingMod(y: UInt8): UInt8
```

Function: Modulo operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Divisor.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the modulo operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during modulo.

#### func throwingMul(UInt8)

```cangjie
public func throwingMul(y: UInt8): UInt8
```

Function: Multiplication operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Multiplier.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the multiplication operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during multiplication.

#### func throwingNeg()

```cangjie
public func throwingNeg(): UInt8
```

Function: Negation operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the negation operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during negation.

#### func throwingShl(UInt64)

```cangjie
public func throwingShl(y: UInt64): UInt8
```

Function: Left shift operation with exception-throwing strategy.

Throws an exception when shift count is greater than or equal to operand bit width, otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the left shift operation.

Exceptions:

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - Thrown when shift count ≥ operand bit width.

#### func throwingShr(UInt64)

```cangjie
public func throwingShr(y: UInt64): UInt8
```

Function: Right shift operation.

Throws an exception when shift count is greater than or equal to operand bit width, otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the right shift operation.

Exceptions:

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - Thrown when shift count ≥ operand bit width.

#### func throwingSub(UInt8)

```cangjie
public func throwingSub(y: UInt8): UInt8
```

Function: Subtraction operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Subtrahend.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the subtraction operation.Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when subtraction operation results in overflow.

### extend UIntNative <: ThrowingOp\<UIntNative>

```cangjie
extend UIntNative <: ThrowingOp<UIntNative>
```

Function: Implements the [ThrowingOp](#interface-throwingopt) interface for [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).

Parent Type:

- [ThrowingOp](#interface-throwingopt)\<[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)>

#### func throwingAdd(UIntNative)

```cangjie
public func throwingAdd(y: UIntNative): UIntNative
```

Function: Addition operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The addend.

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The result of the addition operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when addition operation results in overflow.

#### func throwingDec()

```cangjie
public func throwingDec(): UIntNative
```

Function: Decrement operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The result of the decrement operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when decrement operation results in overflow.

#### func throwingDiv(UIntNative)

```cangjie
public func throwingDiv(y: UIntNative): UIntNative
```

Function: Division operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The divisor.

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The result of the division operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when division operation results in overflow.

#### func throwingInc()

```cangjie
public func throwingInc(): UIntNative
```

Function: Increment operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The result of the increment operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when increment operation results in overflow.

#### func throwingMod(UIntNative)

```cangjie
public func throwingMod(y: UIntNative): UIntNative
```

Function: Modulus operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The divisor.

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The result of the modulus operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when modulus operation results in overflow.

#### func throwingMul(UIntNative)

```cangjie
public func throwingMul(y: UIntNative): UIntNative
```

Function: Multiplication operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The multiplier.

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The result of the multiplication operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when multiplication operation results in overflow.

#### func throwingNeg()

```cangjie
public func throwingNeg(): UIntNative
```

Function: Negation operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Result of the negation operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when overflow occurs during the negation operation.

#### func throwingShl(UInt64)

```cangjie
public func throwingShl(y: UInt64): UIntNative
```

Function: Left shift operation with exception-throwing strategy.

Throws an exception when the shift count is greater than or equal to the operand bit width; otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits to shift.

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Result of the left shift operation.

Exceptions:

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - Thrown when the shift count is greater than or equal to the operand bit width.

#### func throwingShr(UInt64)

```cangjie
public func throwingShr(y: UInt64): UIntNative
```

Function: Right shift operation.

Throws an exception when the shift count is greater than or equal to the operand bit width; otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits to shift.

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Result of the right shift operation.

Exceptions:

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - Thrown when the shift count is greater than or equal to the operand bit width.

#### func throwingSub(UIntNative)

```cangjie
public func throwingSub(y: UIntNative): UIntNative
```

Function: Subtraction operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Subtrahend.

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Result of subtraction operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when subtraction operation overflows.

## interface ThrowingPow

```cangjie
public interface ThrowingPow {
    func throwingPow(y: UInt64): Int64
}
```

Function: Provides an interface for exponentiation operations with exception-throwing strategy.

### func throwingPow(UInt64)

```cangjie
func throwingPow(y: UInt64): Int64
```

Function: Exponentiation operation with exception-throwing strategy.

Throws an exception when overflow occurs, otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Exponent.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of exponentiation operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when exponentiation operation overflows.

## interface WrappingOp\<T>

```cangjie
public interface WrappingOp<T> {
    func wrappingAdd(y: T): T
    func wrappingDec(): T
    func wrappingDiv(y: T): T
    func wrappingInc(): T
    func wrappingMod(y: T): T
    func wrappingMul(y: T): T
    func wrappingNeg(): T
    func wrappingShl(y: UInt64): T
    func wrappingShr(y: UInt64): T
    func wrappingSub(y: T): T
}
```

Function: Performs integer operations with high-order truncation when overflow occurs.

### func wrappingAdd(T)

```cangjie
func wrappingAdd(y: T): T
```

Function: Addition operation with high-order truncation strategy.

Returns the operation result with high-order truncation when overflow occurs.

Parameters:

- y: T - Addend.

Return Value:

- T - Result of addition operation.

### func wrappingDec()

```cangjie
func wrappingDec(): T
```

Function: Decrement operation with high-order truncation strategy.

Returns the operation result with high-order truncation when overflow occurs.

Return Value:

- T - Result of decrement operation.

### func wrappingDiv(T)

```cangjie
func wrappingDiv(y: T): T
```

Function: Division operation with high-order truncation strategy.

Returns the operation result with high-order truncation when overflow occurs.

Parameters:

- y: T - Divisor.

Return Value:

- T - Result of division operation.

### func wrappingInc()

```cangjie
func wrappingInc(): T
```

Function: Increment operation with high-order truncation strategy.

Returns the operation result with high-order truncation when overflow occurs.

Return Value:

- T - Result of increment operation.

### func wrappingMod(T)

```cangjie
func wrappingMod(y: T): T
```

Function: Modulo operation with high-order truncation strategy.

Returns the operation result with high-order truncation when overflow occurs.

Parameters:

- y: T - Divisor.

Return Value:

- T - Result of modulo operation.

### func wrappingMul(T)

```cangjie
func wrappingMul(y: T): T
```

Function: Multiplication operation with high-order truncation strategy.

Returns the operation result with high-order truncation when overflow occurs.

Parameters:

- y: T - Multiplier.

Return Value:

- T - Result of multiplication operation.

### func wrappingNeg()

```cangjie
func wrappingNeg(): T
```

Function: Negation operation with high-order truncation strategy.

Returns the operation result with high-order truncation when overflow occurs.

Return Value:

- T - Result of negation operation.

### func wrappingShl(UInt64)

```cangjie
func wrappingShl(y: UInt64): T
```

Function: Left shift operation with high-order truncation strategy.

Performs high-order truncation when shift count exceeds operand bit width. For example, when shifting an [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) value, if y (shift count) is greater than or equal to 8, only the lower 3 bits of y are used as the shift count to ensure it remains between 0 and 7.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- T - Result of left shift operation.

### func wrappingShr(UInt64)

```cangjie
func wrappingShr(y: UInt64): T
```

Function: Right shift operation with high-order truncation strategy.

Performs high-order truncation when shift count exceeds operand bit width. For example, when shifting an [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) value, if y (shift count) is greater than or equal to 8, only the lower 3 bits of y are used as the shift count to ensure it remains between 0 and 7.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- T - Result of right shift operation.

### func wrappingSub(T)

```cangjie
func wrappingSub(y: T): T
```

Function: Subtraction operation with high-order truncation strategy.

Returns the operation result with high-order truncation when overflow occurs.

Parameters:

- y: T - Subtrahend.

Return Value:

- T - Result of subtraction operation.

### extend Int16 <: WrappingOp\<Int16>

```cangjie
extend Int16 <: WrappingOp<Int16>
```

Function: Implements [WrappingOp](#interface-wrappingopt) interface for [Int16](../../core/core_package_api/core_package_intrinsics.md#int16).

Parent Type:

- [WrappingOp](#interface-wrappingopt)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)>

#### func wrappingAdd(Int16)

```cangjie
public func wrappingAdd(y: Int16): Int16
```

Function: Addition operation with high-order truncation strategy.

Returns the operation result with high-order truncation when overflow occurs.

Parameters:

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Addend.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Result of addition operation.

#### func wrappingDec()

```cangjie
public func wrappingDec(): Int16
```

Function: Decrement operation with high-order truncation strategy.

Returns the operation result with high-order truncation when overflow occurs.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Result of decrement operation.

#### func wrappingDiv(Int16)

```cangjie
public func wrappingDiv(y: Int16): Int16
```

Function: Division operation with high-order truncation strategy.

Returns the operation result with high-order truncation when overflow occurs.

Parameters:

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Divisor.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Result of division operation.Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The result of the division operation.

#### func wrappingInc()

```cangjie
public func wrappingInc(): Int16
```

Function: Increment operation with high-bit truncation strategy.

When overflow occurs during operation, high bits are truncated; otherwise, the operation result is returned.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The result of the increment operation.

#### func wrappingMod(Int16)

```cangjie
public func wrappingMod(y: Int16): Int16
```

Function: Modulo operation with high-bit truncation strategy.

When overflow occurs during operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The divisor.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The result of the modulo operation.

#### func wrappingMul(Int16)

```cangjie
public func wrappingMul(y: Int16): Int16
```

Function: Multiplication operation with high-bit truncation strategy.

When overflow occurs during operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The multiplier.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The result of the multiplication operation.

#### func wrappingNeg()

```cangjie
public func wrappingNeg(): Int16
```

Function: Negation operation with high-bit truncation strategy.

When overflow occurs during operation, high bits are truncated; otherwise, the operation result is returned.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The result of the negation operation.

#### func wrappingShl(UInt64)

```cangjie
public func wrappingShl(y: UInt64): Int16
```

Function: Left shift operation with high-bit truncation strategy.

When the right operand is greater than or equal to the bit width of the left operand, the lower 4 bits of the right operand are taken as the shift count.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The shift count.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The result of the left shift operation.

#### func wrappingShr(UInt64)

```cangjie
public func wrappingShr(y: UInt64): Int16
```

Function: Right shift operation with high-bit truncation strategy.

When the right operand is greater than or equal to the bit width of the left operand, the lower 4 bits of the right operand are taken as the shift count.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The shift count.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The result of the right shift operation.

#### func wrappingSub(Int16)

```cangjie
public func wrappingSub(y: Int16): Int16
```

Function: Subtraction operation with high-bit truncation strategy.

When overflow occurs during operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The subtrahend.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The result of the subtraction operation.

### extend Int32 <: WrappingOp\<Int32>

```cangjie
extend Int32 <: WrappingOp<Int32>
```

Function: Implements the [WrappingOp](#interface-wrappingopt) interface for [Int32](../../core/core_package_api/core_package_intrinsics.md#int32).

Parent Type:

- [WrappingOp](#interface-wrappingopt)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)>

#### func wrappingAdd(Int32)

```cangjie
public func wrappingAdd(y: Int32): Int32
```

Function: Addition operation with high-bit truncation strategy.

When overflow occurs during operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The addend.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The result of the addition operation.

#### func wrappingDec()

```cangjie
public func wrappingDec(): Int32
```

Function: Decrement operation with high-bit truncation strategy.

When overflow occurs during operation, high bits are truncated; otherwise, the operation result is returned.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The result of the decrement operation.

#### func wrappingDiv(Int32)

```cangjie
public func wrappingDiv(y: Int32): Int32
```

Function: Division operation with high-bit truncation strategy.

When overflow occurs during operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The divisor.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The result of the division operation.

#### func wrappingInc()

```cangjie
public func wrappingInc(): Int32
```

Function: Increment operation with high-bit truncation strategy.

When overflow occurs during operation, high bits are truncated; otherwise, the operation result is returned.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The result of the increment operation.

#### func wrappingMod(Int32)

```cangjie
public func wrappingMod(y: Int32): Int32
```

Function: Modulo operation with high-bit truncation strategy.

When overflow occurs during operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The divisor.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The result of the modulo operation.

#### func wrappingMul(Int32)

```cangjie
public func wrappingMul(y: Int32): Int32
```

Function: Multiplication operation with high-bit truncation strategy.

When overflow occurs during operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The multiplier.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The result of the multiplication operation.

#### func wrappingNeg()

```cangjie
public func wrappingNeg(): Int32
```

Function: Negation operation with high-bit truncation strategy.

When overflow occurs during operation, high bits are truncated; otherwise, the operation result is returned.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The result of the negation operation.
### extend Int64 <: WrappingOp\<Int64> & WrappingPow

```cangjie
extend Int64 <: WrappingOp<Int64> & WrappingPow
```

Function: Implements [WrappingOp](#interface-wrappingopt) and [WrappingPow](#interface-wrappingpow) interfaces for [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).

Parent types:

- [WrappingOp](#interface-wrappingopt)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>
- [WrappingPow](#interface-wrappingpow)

#### func wrappingAdd(Int64)

```cangjie
public func wrappingAdd(y: Int64): Int64
```

Function: Addition operation using high-bit truncation strategy.

When overflow occurs during operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Addend.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of addition operation.

#### func wrappingDec()

```cangjie
public func wrappingDec(): Int64
```

Function: Decrement operation using high-bit truncation strategy.

When overflow occurs during operation, high bits are truncated; otherwise, the operation result is returned.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of decrement operation.

#### func wrappingDiv(Int64)

```cangjie
public func wrappingDiv(y: Int64): Int64
```

Function: Division operation using high-bit truncation strategy.

When overflow occurs during operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Divisor.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of division operation.

#### func wrappingInc()

```cangjie
public func wrappingInc(): Int64
```

Function: Increment operation using high-bit truncation strategy.

When overflow occurs during operation, high bits are truncated; otherwise, the operation result is returned.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of increment operation.

#### func wrappingMod(Int64)

```cangjie
public func wrappingMod(y: Int64): Int64
```

Function: Modulo operation using high-bit truncation strategy.

When overflow occurs during operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Divisor.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of modulo operation.#### func wrappingMul(Int64)

```cangjie
public func wrappingMul(y: Int64): Int64
```

Function: Multiplication operation with high-bit truncation strategy.

When overflow occurs during the operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Multiplier.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the multiplication operation.

#### func wrappingNeg()

```cangjie
public func wrappingNeg(): Int64
```

Function: Negation operation with high-bit truncation strategy.

When overflow occurs during the operation, high bits are truncated; otherwise, the operation result is returned.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the negation operation.

#### func wrappingPow(UInt64)

```cangjie
public func wrappingPow(y: UInt64): Int64
```

Function: Exponentiation operation with high-bit truncation strategy.

When overflow occurs during the operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Exponent.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the exponentiation operation.

#### func wrappingShl(UInt64)

```cangjie
public func wrappingShl(y: UInt64): Int64
```

Function: Left shift operation with high-bit truncation strategy.

When the right operand is greater than or equal to the bit width of the left operand, the lower 6 bits of the right operand are used as the shift count.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the left shift operation.

#### func wrappingShr(UInt64)

```cangjie
public func wrappingShr(y: UInt64): Int64
```

Function: Right shift operation with high-bit truncation strategy.

When the right operand is greater than or equal to the bit width of the left operand, the lower 6 bits of the right operand are used as the shift count.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the right shift operation.

#### func wrappingSub(Int64)

```cangjie
public func wrappingSub(y: Int64): Int64
```

Function: Subtraction operation with high-bit truncation strategy.

When overflow occurs during the operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Subtrahend.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Result of the subtraction operation.

### extend Int8 <: WrappingOp\<Int8>

```cangjie
extend Int8 <: WrappingOp<Int8>
```

Function: Implements the [WrappingOp](#interface-wrappingopt) interface for [Int8](../../core/core_package_api/core_package_intrinsics.md#int8).

Parent type:

- [WrappingOp](#interface-wrappingopt)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)>

#### func wrappingAdd(Int8)

```cangjie
public func wrappingAdd(y: Int8): Int8
```

Function: Addition operation with high-bit truncation strategy.

When overflow occurs during the operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Addend.

Return value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Result of the addition operation.

#### func wrappingDec()

```cangjie
public func wrappingDec(): Int8
```

Function: Decrement operation with high-bit truncation strategy.

When overflow occurs during the operation, high bits are truncated; otherwise, the operation result is returned.

Return value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Result of the decrement operation.

#### func wrappingDiv(Int8)

```cangjie
public func wrappingDiv(y: Int8): Int8
```

Function: Division operation with high-bit truncation strategy.

When overflow occurs during computation, high bits are truncated; otherwise, the computation result is returned.

Parameters:

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Divisor.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Result of the division operation.

#### func wrappingInc()

```cangjie
public func wrappingInc(): Int8
```

Function: Increment operation with high-bit truncation strategy.

When overflow occurs during computation, high bits are truncated; otherwise, the computation result is returned.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Result of the increment operation.

#### func wrappingMod(Int8)

```cangjie
public func wrappingMod(y: Int8): Int8
```

Function: Modulo operation with high-bit truncation strategy.

When overflow occurs during computation, high bits are truncated; otherwise, the computation result is returned.

Parameters:

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Divisor.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Result of the modulo operation.

#### func wrappingMul(Int8)

```cangjie
public func wrappingMul(y: Int8): Int8
```

Function: Multiplication operation with high-bit truncation strategy.

When overflow occurs during computation, high bits are truncated; otherwise, the computation result is returned.

Parameters:

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Multiplier.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Result of the multiplication operation.

#### func wrappingNeg()

```cangjie
public func wrappingNeg(): Int8
```

Function: Negation operation with high-bit truncation strategy.

When overflow occurs during computation, high bits are truncated; otherwise, the computation result is returned.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Result of the negation operation.

#### func wrappingShl(UInt64)

```cangjie
public func wrappingShl(y: UInt64): Int8
```

Function: Left shift operation with high-bit truncation strategy.

When the right operand is greater than or equal to the bit width of the left operand, the lower 3 bits of the right operand are used as the shift count.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Result of the left shift operation.

#### func wrappingShr(UInt64)

```cangjie
public func wrappingShr(y: UInt64): Int8
```

Function: Right shift operation with high-bit truncation strategy.

When the right operand is greater than or equal to the bit width of the left operand, the lower 3 bits of the right operand are used as the shift count.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Result of the right shift operation.

#### func wrappingSub(Int8)

```cangjie
public func wrappingSub(y: Int8): Int8
```

Function: Subtraction operation with high-bit truncation strategy.

When overflow occurs during computation, high bits are truncated; otherwise, the computation result is returned.

Parameters:

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Subtrahend.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Result of the subtraction operation.

### extend IntNative <: WrappingOp\<IntNative>

```cangjie
extend IntNative <: WrappingOp<IntNative>
```

Function: Implements the [WrappingOp](#interface-wrappingopt) interface for [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).

Parent Type:

- [WrappingOp](#interface-wrappingopt)\<[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)>

#### func wrappingAdd(IntNative)

```cangjie
public func wrappingAdd(y: IntNative): IntNative
```

Function: Addition operation with high-bit truncation strategy.

When overflow occurs during the operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The addend.

Return Value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The result of the addition operation.

#### func wrappingDec()

```cangjie
public func wrappingDec(): IntNative
```

Function: Decrement operation with high-bit truncation strategy.

When overflow occurs during the operation, high bits are truncated; otherwise, the operation result is returned.

Return Value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The result of the decrement operation.

#### func wrappingDiv(IntNative)

```cangjie
public func wrappingDiv(y: IntNative): IntNative
```

Function: Division operation with high-bit truncation strategy.

When overflow occurs during the operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The divisor.

Return Value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The result of the division operation.

#### func wrappingInc()

```cangjie
public func wrappingInc(): IntNative
```

Function: Increment operation with high-bit truncation strategy.

When overflow occurs during the operation, high bits are truncated; otherwise, the operation result is returned.

Return Value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The result of the increment operation.

#### func wrappingMod(IntNative)

```cangjie
public func wrappingMod(y: IntNative): IntNative
```

Function: Modulo operation with high-bit truncation strategy.

When overflow occurs during the operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The divisor.

Return Value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The result of the modulo operation.

#### func wrappingMul(IntNative)

```cangjie
public func wrappingMul(y: IntNative): IntNative
```

Function: Multiplication operation with high-bit truncation strategy.

When overflow occurs during the operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The multiplier.

Return Value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The result of the multiplication operation.

#### func wrappingNeg()

```cangjie
public func wrappingNeg(): IntNative
```

Function: Negation operation with high-bit truncation strategy.

When overflow occurs during the operation, high bits are truncated; otherwise, the operation result is returned.

Return Value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The result of the negation operation.

#### func wrappingShl(UInt64)

```cangjie
public func wrappingShl(y: UInt64): IntNative
```

Function: Left shift operation with high-bit truncation strategy.

When the right operand is greater than or equal to the bit width of the left operand, the lower bits of the right operand are taken as the shift count. The exact number of bits taken depends on the bit width of [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) on the current system.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The shift count.

Return Value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The result of the left shift operation.

#### func wrappingShr(UInt64)

```cangjie
public func wrappingShr(y: UInt64): IntNative
```

Function: Right shift operation with high-bit truncation strategy.

When the right operand is greater than or equal to the bit width of the left operand, the lower bits of the right operand are taken as the shift count. The exact number of bits taken depends on the bit width of [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) on the current system.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The shift count.

Return Value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The result of the right shift operation.#### func wrappingSub(IntNative)

```cangjie
public func wrappingSub(y: IntNative): IntNative
```

Function: Subtraction operation with high-bit truncation strategy.

When overflow occurs during operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The subtrahend.

Return Value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The result of the subtraction operation.

### extend UInt16 <: WrappingOp\<UInt16>

```cangjie
extend UInt16 <: WrappingOp<UInt16>
```

Function: Implements the [WrappingOp](#interface-wrappingopt) interface for [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).

Parent Type:

- [WrappingOp](#interface-wrappingopt)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)>

#### func wrappingAdd(UInt16)

```cangjie
public func wrappingAdd(y: UInt16): UInt16
```

Function: Addition operation with high-bit truncation strategy.

When overflow occurs during operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The addend.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The result of the addition operation.

#### func wrappingDec()

```cangjie
public func wrappingDec(): UInt16
```

Function: Decrement operation with high-bit truncation strategy.

When overflow occurs during operation, high bits are truncated; otherwise, the operation result is returned.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The result of the decrement operation.

#### func wrappingDiv(UInt16)

```cangjie
public func wrappingDiv(y: UInt16): UInt16
```

Function: Division operation with high-bit truncation strategy.

When overflow occurs during operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The divisor.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The result of the division operation.

#### func wrappingInc()

```cangjie
public func wrappingInc(): UInt16
```

Function: Increment operation with high-bit truncation strategy.

When overflow occurs during operation, high bits are truncated; otherwise, the operation result is returned.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The result of the increment operation.

#### func wrappingMod(UInt16)

```cangjie
public func wrappingMod(y: UInt16): UInt16
```

Function: Modulo operation with high-bit truncation strategy.

When overflow occurs during operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The divisor.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The result of the modulo operation.

#### func wrappingMul(UInt16)

```cangjie
public func wrappingMul(y: UInt16): UInt16
```

Function: Multiplication operation with high-bit truncation strategy.

When overflow occurs during operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The multiplier.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The result of the multiplication operation.

#### func wrappingNeg()

```cangjie
public func wrappingNeg(): UInt16
```

Function: Negation operation with high-bit truncation strategy.

When overflow occurs during operation, high bits are truncated; otherwise, the operation result is returned.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The result of the negation operation.

#### func wrappingShl(UInt64)

```cangjie
public func wrappingShl(y: UInt64): UInt16
```

Function: Left shift operation using high-bit truncation strategy.

When the right operand is greater than or equal to the bit width of the left operand, the lower 4 bits of the right operand are taken as the shift count.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Result of the left shift operation.

#### func wrappingShr(UInt64)

```cangjie
public func wrappingShr(y: UInt64): UInt16
```

Function: Right shift operation using high-bit truncation strategy.

When the right operand is greater than or equal to the bit width of the left operand, the lower 4 bits of the right operand are taken as the shift count.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Result of the right shift operation.

#### func wrappingSub(UInt16)

```cangjie
public func wrappingSub(y: UInt16): UInt16
```

Function: Subtraction operation using high-bit truncation strategy.

When overflow occurs during the operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Subtrahend.

Return value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Result of the subtraction operation.

### extend UInt32 <: WrappingOp\<UInt32>

```cangjie
extend UInt32 <: WrappingOp<UInt32>
```

Function: Implements the [WrappingOp](#interface-wrappingopt) interface for [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).

Parent type:

- [WrappingOp](#interface-wrappingopt)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)>

#### func wrappingAdd(UInt32)

```cangjie
public func wrappingAdd(y: UInt32): UInt32
```

Function: Addition operation using high-bit truncation strategy.

When overflow occurs during the operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Addend.

Return value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Result of the addition operation.

#### func wrappingDec()

```cangjie
public func wrappingDec(): UInt32
```

Function: Decrement operation using high-bit truncation strategy.

When overflow occurs during the operation, high bits are truncated; otherwise, the operation result is returned.

Return value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Result of the decrement operation.

#### func wrappingDiv(UInt32)

```cangjie
public func wrappingDiv(y: UInt32): UInt32
```

Function: Division operation using high-bit truncation strategy.

When overflow occurs during the operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Divisor.

Return value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Result of the division operation.

#### func wrappingInc()

```cangjie
public func wrappingInc(): UInt32
```

Function: Increment operation using high-bit truncation strategy.

When overflow occurs during the operation, high bits are truncated; otherwise, the operation result is returned.

Return value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Result of the increment operation.

#### func wrappingMod(UInt32)

```cangjie
public func wrappingMod(y: UInt32): UInt32
```

Function: Modulo operation using high-bit truncation strategy.

When overflow occurs during the operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Divisor.

Return value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Result of the modulo operation.

#### func wrappingMul(UInt32)

```cangjie
public func wrappingMul(y: UInt32): UInt32
```

Function: Multiplication operation using high-bit truncation strategy.When an arithmetic overflow occurs, the high-order bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The multiplier.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The result of the multiplication operation.

#### func wrappingNeg()

```cangjie
public func wrappingNeg(): UInt32
```

Function: Negation operation using high-order bit truncation strategy.

When an arithmetic overflow occurs, the high-order bits are truncated; otherwise, the operation result is returned.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The result of the negation operation.

#### func wrappingShl(UInt64)

```cangjie
public func wrappingShl(y: UInt64): UInt32
```

Function: Left shift operation using high-bit truncation strategy.

When the right operand's bit width is greater than or equal to the left operand's, the lower 5 bits of the right operand are used as the shift count.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Result of left shift operation.

#### func wrappingShr(UInt64)

```cangjie
public func wrappingShr(y: UInt64): UInt32
```

Function: Right shift operation using high-bit truncation strategy.

When the right operand's bit width is greater than or equal to the left operand's, the lower 5 bits of the right operand are used as the shift count.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Result of right shift operation.

#### func wrappingSub(UInt32)

```cangjie
public func wrappingSub(y: UInt32): UInt32
```

Function: Subtraction operation using high-bit truncation strategy.

When overflow occurs, high bits are truncated; otherwise returns the operation result.

Parameters:

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Subtrahend.

Return value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Result of subtraction operation.

### extend UInt64 <: WrappingOp\<UInt64>

```cangjie
extend UInt64 <: WrappingOp<UInt64>
```

Function: Implements the [WrappingOp](#interface-wrappingopt) interface for [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).

Parent type:

- [WrappingOp](#interface-wrappingopt)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)>

#### func wrappingAdd(UInt64)

```cangjie
public func wrappingAdd(y: UInt64): UInt64
```

Function: Addition operation using high-bit truncation strategy.

When overflow occurs, high bits are truncated; otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Addend.

Return value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Result of addition operation.

#### func wrappingDec()

```cangjie
public func wrappingDec(): UInt64
```

Function: Decrement operation using high-bit truncation strategy.

When overflow occurs, high bits are truncated; otherwise returns the operation result.

Return value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Result of decrement operation.

#### func wrappingDiv(UInt64)

```cangjie
public func wrappingDiv(y: UInt64): UInt64
```

Function: Division operation using high-bit truncation strategy.

When overflow occurs, high bits are truncated; otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Divisor.

Return value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Result of division operation.

#### func wrappingInc()

```cangjie
public func wrappingInc(): UInt64
```

Function: Increment operation using high-bit truncation strategy.

When overflow occurs, high bits are truncated; otherwise returns the operation result.

Return value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Result of increment operation.

#### func wrappingMod(UInt64)

```cangjie
public func wrappingMod(y: UInt64): UInt64
```

Function: Modulo operation using high-bit truncation strategy.

When overflow occurs, high bits are truncated; otherwise returns the operation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Divisor.

Return value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Result of modulo operation.

#### func wrappingMul(UInt64)

```cangjie
public func wrappingMul(y: UInt64): UInt64
```

Function: Multiplication operation with high-order truncation strategy.

When overflow occurs during the operation, the high-order bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The multiplier.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The result of the multiplication operation.

#### func wrappingNeg()

```cangjie
public func wrappingNeg(): UInt64
```

Function: Negation operation with high-order truncation strategy.

When overflow occurs during the operation, the high-order bits are truncated; otherwise, the operation result is returned.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The result of the negation operation.

#### func wrappingShl(UInt64)

```cangjie
public func wrappingShl(y: UInt64): UInt64
```

Function: Left shift operation with high-order truncation strategy.

When the right operand is greater than or equal to the bit width of the left operand, the lower 6 bits of the right operand are used as the shift count.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The shift count.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The result of the left shift operation.

#### func wrappingShr(UInt64)

```cangjie
public func wrappingShr(y: UInt64): UInt64
```

Function: Right shift operation with high-order truncation strategy.

When the right operand is greater than or equal to the bit width of the left operand, the lower 6 bits of the right operand are used as the shift count.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The shift count.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The result of the right shift operation.

#### func wrappingSub(UInt64)

```cangjie
public func wrappingSub(y: UInt64): UInt64
```

Function: Subtraction operation with high-order truncation strategy.

When overflow occurs during the operation, the high-order bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The subtrahend.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The result of the subtraction operation.

### extend UInt8 <: WrappingOp\<UInt8>

```cangjie
extend UInt8 <: WrappingOp<UInt8>
```

Function: Implements the [WrappingOp](#interface-wrappingopt) interface for [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).

Parent Type:

- [WrappingOp](#interface-wrappingopt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)>

#### func wrappingAdd(UInt8)

```cangjie
public func wrappingAdd(y: UInt8): UInt8
```

Function: Addition operation with high-order truncation strategy.

When overflow occurs during the operation, the high-order bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The addend.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The result of the addition operation.

#### func wrappingDec()

```cangjie
public func wrappingDec(): UInt8
```

Function: Decrement operation with high-order truncation strategy.

When overflow occurs during the operation, the high-order bits are truncated; otherwise, the operation result is returned.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The result of the decrement operation.

#### func wrappingDiv(UInt8)

```cangjie
public func wrappingDiv(y: UInt8): UInt8
```

Function: Division operation with high-order truncation strategy.

When overflow occurs during the operation, the high-order bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The divisor.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The result of the division operation.

#### func wrappingInc()

```cangjie
public func wrappingInc(): UInt8
```

Function: Increment operation with high-bit truncation strategy.

When overflow occurs during the operation, high bits are truncated; otherwise, the operation result is returned.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the increment operation.

#### func wrappingMod(UInt8)

```cangjie
public func wrappingMod(y: UInt8): UInt8
```

Function: Modulo operation with high-bit truncation strategy.

When overflow occurs during the operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Divisor.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the modulo operation.

#### func wrappingMul(UInt8)

```cangjie
public func wrappingMul(y: UInt8): UInt8
```

Function: Multiplication operation with high-bit truncation strategy.

When overflow occurs during the operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Multiplier.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the multiplication operation.

#### func wrappingNeg()

```cangjie
public func wrappingNeg(): UInt8
```

Function: Negation operation with high-bit truncation strategy.

When overflow occurs during the operation, high bits are truncated; otherwise, the operation result is returned.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the negation operation.

#### func wrappingShl(UInt64)

```cangjie
public func wrappingShl(y: UInt64): UInt8
```

Function: Left shift operation with high-bit truncation strategy.

When the right operand is greater than or equal to the bit width of the left operand, the lower 3 bits of the right operand are used as the shift count.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the left shift operation.

#### func wrappingShr(UInt64)

```cangjie
public func wrappingShr(y: UInt64): UInt8
```

Function: Right shift operation with high-bit truncation strategy.

When the right operand is greater than or equal to the bit width of the left operand, the lower 3 bits of the right operand are used as the shift count.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the right shift operation.

#### func wrappingSub(UInt8)

```cangjie
public func wrappingSub(y: UInt8): UInt8
```

Function: Subtraction operation with high-bit truncation strategy.

When overflow occurs during the operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Subtrahend.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Result of the subtraction operation.

### extend UIntNative <: WrappingOp\<UIntNative>

```cangjie
extend UIntNative <: WrappingOp<UIntNative>
```

Function: Implements the [WrappingOp](#interface-wrappingopt) interface for [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).

Parent Type:

- [WrappingOp](#interface-wrappingopt)\<[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)>

#### func wrappingAdd(UIntNative)

```cangjie
public func wrappingAdd(y: UIntNative): UIntNative
```

Function: Addition operation with high-bit truncation strategy.

When overflow occurs during the operation, high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Addend.

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Result of the addition operation.

#### func wrappingDec()

```cangjie
public func wrappingDec(): UIntNative
```

Function: Decrement operation using high-bit truncation strategy.

When overflow occurs during the operation, the high bits are truncated; otherwise, the operation result is returned.

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Result of the decrement operation.

#### func wrappingDiv(UIntNative)

```cangjie
public func wrappingDiv(y: UIntNative): UIntNative
```

Function: Division operation using high-bit truncation strategy.

When overflow occurs during the operation, the high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Divisor.

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Result of the division operation.

#### func wrappingInc()

```cangjie
public func wrappingInc(): UIntNative
```

Function: Increment operation using high-bit truncation strategy.

When overflow occurs during the operation, the high bits are truncated; otherwise, the operation result is returned.

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Result of the increment operation.

#### func wrappingMod(UIntNative)

```cangjie
public func wrappingMod(y: UIntNative): UIntNative
```

Function: Modulo operation using high-bit truncation strategy.

When overflow occurs during the operation, the high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Divisor.

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Result of the modulo operation.

#### func wrappingMul(UIntNative)

```cangjie
public func wrappingMul(y: UIntNative): UIntNative
```

Function: Multiplication operation using high-bit truncation strategy.

When overflow occurs during the operation, the high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Multiplier.

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Result of the multiplication operation.

#### func wrappingNeg()

```cangjie
public func wrappingNeg(): UIntNative
```

Function: Negation operation using high-bit truncation strategy.

When overflow occurs during the operation, the high bits are truncated; otherwise, the operation result is returned.

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Result of the negation operation.

#### func wrappingShl(UInt64)

```cangjie
public func wrappingShl(y: UInt64): UIntNative
```

Function: Left shift operation using high-bit truncation strategy.

When the right operand is greater than or equal to the bit width of the left operand, the lower bits of the right operand are used as the shift count, with the exact number of bits depending on the bit width of UIntNative on the current system.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Result of the left shift operation.

#### func wrappingShr(UInt64)

```cangjie
public func wrappingShr(y: UInt64): UIntNative
```

Function: Right shift operation using high-bit truncation strategy.

When the right operand is greater than or equal to the bit width of the left operand, the lower bits of the right operand are used as the shift count, with the exact number of bits depending on the bit width of UIntNative on the current system.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Shift count.

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Result of the right shift operation.

#### func wrappingSub(UIntNative)

```cangjie
public func wrappingSub(y: UIntNative): UIntNative
```

Function: Subtraction operation using high-bit truncation strategy.

When overflow occurs during the operation, the high bits are truncated; otherwise, the operation result is returned.

Parameters:

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Subtrahend.

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Result of the subtraction operation.

## interface WrappingPow

```cangjie
public interface WrappingPow {
    func wrappingPow(y: UInt64): Int64
```

Feature: Provides an interface for exponentiation operations using high-order truncation strategy.

### func wrappingPow(UInt64)

```cangjie
func wrappingPow(y: UInt64): Int64
```

Function: Performs exponentiation using high-order truncation strategy.

When overflow occurs during computation, the high-order bits are truncated; otherwise, returns the computation result.

Parameters:

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The exponent.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The result of the exponentiation operation.