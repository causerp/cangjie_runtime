# Functions

## func abs(BigInt)

```cangjie
public func abs(i: BigInt): BigInt
```

Function: Calculates the absolute value of a [BigInt](math_numeric_package_structs.md#struct-bigint).

Parameters:

- i: [BigInt](math_numeric_package_structs.md#struct-bigint) - The [BigInt](math_numeric_package_structs.md#struct-bigint) whose absolute value is to be calculated.

Return Value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - Returns the absolute value of the input [BigInt](math_numeric_package_structs.md#struct-bigint).

Example:
<!-- verify -->
```cangjie
import std.math.numeric.*

main() {
    let n: BigInt = BigInt(-23)
    let abs = abs(n)
    println(abs)
}
```

Execution Result:

```text
23
```

## func abs(Decimal)

```cangjie
public func abs(d: Decimal): Decimal
```

Function: Calculates the absolute value of a [Decimal](math_numeric_package_structs.md#struct-decimal).

Parameters:

- d: [Decimal](math_numeric_package_structs.md#struct-decimal) - The [Decimal](math_numeric_package_structs.md#struct-decimal) whose absolute value is to be calculated.

Return Value:

- [Decimal](math_numeric_package_structs.md#struct-decimal) - Returns the absolute value of the input [Decimal](math_numeric_package_structs.md#struct-decimal).

Example:
<!-- verify -->
```cangjie
import std.math.numeric.*

main() {
    let d: Decimal = Decimal.parse("-1.23")
    let abs = abs(d)
    println(abs)
}
```

Execution Result:

```text
1.23
```

## func countOne(BigInt) <sup>(deprecated)<sup>

```cangjie
public func countOne(i: BigInt): Int64
```

Function: Counts and returns the number of 1's in the two's complement binary representation of the input [BigInt](math_numeric_package_structs.md#struct-bigint).

> **Note:**
>
> This function will be deprecated in future versions. Use [countOnes(BigInt)](#func-countonesbigint) instead.

Parameters:

- i: [BigInt](math_numeric_package_structs.md#struct-bigint) - The [BigInt](math_numeric_package_structs.md#struct-bigint) whose number of 1's in two's complement is to be counted.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Returns the count of 1's in the two's complement binary representation of the input [BigInt](math_numeric_package_structs.md#struct-bigint).

## func countOnes(BigInt)

```cangjie
public func countOnes(i: BigInt): Int64
```

Function: Counts and returns the number of 1's in the two's complement binary representation of the input [BigInt](math_numeric_package_structs.md#struct-bigint).

Parameters:

- i: [BigInt](math_numeric_package_structs.md#struct-bigint) - The [BigInt](math_numeric_package_structs.md#struct-bigint) structure whose number of 1's in two's complement is to be counted.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Returns the count of 1's in the two's complement binary representation of the input [BigInt](math_numeric_package_structs.md#struct-bigint).

Example:
<!-- verify -->
```cangjie
import std.math.numeric.*

main() {
    let i: BigInt = BigInt(255)
    let countOnes = countOnes(i)
    println(countOnes)
}
```

Execution Result:

```text
8
```

## func gcd(BigInt, BigInt)

```cangjie
public func gcd(i1: BigInt, i2: BigInt): BigInt
```

Function: Calculates the greatest common divisor (GCD) of two [BigInt](math_numeric_package_structs.md#struct-bigint) values. Always returns a non-negative value (equivalent to the GCD of absolute values).

Parameters:

- i1: [BigInt](math_numeric_package_structs.md#struct-bigint) - The first input parameter for GCD calculation.
- i2: [BigInt](math_numeric_package_structs.md#struct-bigint) - The second input parameter for GCD calculation.

Return Value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - Returns the GCD of `i1` and `i2`, always a non-negative value.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.*

main() {
    let i1: BigInt = BigInt(-36)
    let i2: BigInt = BigInt(48)
    let gcd = gcd(i1, i2)
    println(gcd)
}
```

Execution Result:

```text
12
```

## func lcm(BigInt, BigInt)

```cangjie
public func lcm(i1: BigInt, i2: BigInt): BigInt
```

Function: Calculates the least common multiple (LCM) of two [BigInt](math_numeric_package_structs.md#struct-bigint) values. Returns 0 if either input is 0; otherwise always returns a positive value (equivalent to the LCM of absolute values).

Parameters:

- i1: [BigInt](math_numeric_package_structs.md#struct-bigint) - The first input parameter for LCM calculation.
- i2: [BigInt](math_numeric_package_structs.md#struct-bigint) - The second input parameter for LCM calculation.

Return Value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - Returns the LCM of `i1` and `i2`. Returns 0 if either input is 0; otherwise always returns a positive value (equivalent to the LCM of absolute values).

Example:
<!-- verify -->
```cangjie
import std.math.numeric.*

main() {
    let i1: BigInt = BigInt(-36)
    let i2: BigInt = BigInt(48)
    let lcm = lcm(i1, i2)
    println(lcm)
}
```

Execution Result:

```text
144
```

## func round(Decimal, RoundingMode)

```cangjie
public func round(d: Decimal, roundingMode!: RoundingMode = RoundingMode.HalfEven): Decimal
```

Function: Rounds a [Decimal](math_numeric_package_structs.md#struct-decimal) value to the nearest integer according to the specified rounding mode.

Parameters:

- d: [Decimal](math_numeric_package_structs.md#struct-decimal) - The [Decimal](math_numeric_package_structs.md#struct-decimal) value to be rounded.
- roundingMode!: [RoundingMode](../../math/math_package_api/math_package_enums.md#enum-roundingmode) - The rounding rule.

Return Value:

- [Decimal](math_numeric_package_structs.md#struct-decimal) - Returns a new [Decimal](math_numeric_package_structs.md#struct-decimal) object resulting from the rounding operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when the scale value of the rounding result overflows.

## func sqrt(BigInt)

```cangjie
public func sqrt(i: BigInt): BigInt
```

Function: Calculates the integer square root (floor value) of a [BigInt](math_numeric_package_structs.md#struct-bigint). The input must be non-negative.

Parameters:

- i: [BigInt](math_numeric_package_structs.md#struct-bigint) - The non-negative [BigInt](math_numeric_package_structs.md#struct-bigint) whose square root is to be calculated.

Return Value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - Returns the integer square root (floor value) of the input [BigInt](math_numeric_package_structs.md#struct-bigint).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the input is negative.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.*

main() {
    let n: BigInt = BigInt(23)
    let sqrt = sqrt(n)
    println(sqrt)
}
```

Execution Result:

```text
4
```

## func sqrt(Decimal)

```cangjie
public func sqrt(d: Decimal): Decimal
```

Function: Calculates the square root of a [Decimal](math_numeric_package_structs.md#struct-decimal). For infinite decimal results, uses IEEE 754-2019 decimal128 rounding by default.

Parameters:

- d: [Decimal](math_numeric_package_structs.md#struct-decimal) - The non-negative [Decimal](math_numeric_package_structs.md#struct-decimal) whose square root is to be calculated.

Return Value:

- [Decimal](math_numeric_package_structs.md#struct-decimal) - Returns the square root of the input [Decimal](math_numeric_package_structs.md#struct-decimal).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the input is negative.
- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when the scale value of the square root result overflows.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.*

main() {
    let n: Decimal = Decimal.parse("36")
    let sqrt = sqrt(n)
    println(sqrt)
}
```

Execution Result:

```text
6
```

## func trailingZeros(BigInt)

```cangjie
public func trailingZeros(x: BigInt): Int64
```

Function: Counts the number of trailing zeros (least significant bits set to 0) in the binary representation of a `BigInt`. Returns 0 if the least significant bit is not 0.

Parameters:

- x: [BigInt](math_numeric_package_structs.md#struct-bigint) - The [BigInt](math_numeric_package_structs.md#struct-bigint) for which to count trailing zeros.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of trailing zero bits.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.{BigInt, trailingZeros}

main() {
    let x: BigInt = BigInt(0xC000_0000)
    let trailingZeros = trailingZeros(x)
    println(trailingZeros)
}
```

Execution Result:

```text
30
```