# Struct

## struct BigInt

```cangjie
public struct BigInt <: Comparable<BigInt> & Hashable & ToString {
    public init(bytes: Array<Byte>)
    public init(sign: Bool, magnitude: Array<Byte>)
    public init(n: Int8)
    public init(n: Int16)
    public init(n: Int32)
    public init(n: Int64)
    public init(n: UInt8)
    public init(n: UInt16)
    public init(n: UInt32)
    public init(n: UInt64)
    public init(n: UIntNative)
    public init(n: IntNative)
    public init(n: Float16)
    public init(n: Float32)
    public init(n: Float64)
    public init(sign: Bool, bitLen: Int64, rand!: Random = Random())
    public init(s: String, base!: Int64 = 10)
}
```

Functionality: [BigInt](math_numeric_package_structs.md#struct-bigint) is defined as an arbitrary-precision (binary) signed integer. The Cangjie struct [BigInt](math_numeric_package_structs.md#struct-bigint) is used for arbitrary-precision signed integer calculations, type conversions, etc.

Parent Types:

- [Comparable](../../core/core_package_api/core_package_interfaces.md#interface-comparablet)\<[BigInt](#struct-bigint)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop bitLen

```cangjie
public prop bitLen: Int64
```

Functionality: Gets the minimum bit length of this [BigInt](math_numeric_package_structs.md#struct-bigint). For example, -3 (101) returns 3, -1 (11) returns 2, and 0 (0) returns 1.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt1 = BigInt(-3)
    let bitLen1 = bigInt1.bitLen
    println(bitLen1)

    let bigInt2 = BigInt(-1)
    let bitLen2 = bigInt2.bitLen
    println(bitLen2)

    let bigInt3 = BigInt(0)
    let bitLen3 = bigInt3.bitLen
    println(bitLen3)
}
```

Execution Result:

```text
3
2
1
```

### prop sign

```cangjie
public prop sign: Int64
```

Functionality: Gets the sign of this [BigInt](math_numeric_package_structs.md#struct-bigint). Returns 1 for positive numbers, 0 for zero, and -1 for negative numbers.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt1 = BigInt(-3)
    let sign1 = bigInt1.sign
    println(sign1)

    let bigInt2 = BigInt(3)
    let sign2 = bigInt2.sign
    println(sign2)

    let bigInt3 = BigInt(0)
    let sign3 = bigInt3.sign
    println(sign3)
}
```

Execution Result:

```text
-1
1
0
```

### init(Array\<Byte>)

```cangjie
public init(bytes: Array<Byte>)
```

Functionality: Constructs a [BigInt](math_numeric_package_structs.md#struct-bigint) struct using a big-endian [Byte](../../core/core_package_api/core_package_types.md#type-byte) array in two's complement form.

> **Note:**
>
> There are two data storage methods:
>
> - Big-endian: The most significant byte is stored at the lowest memory address.
> - Little-endian: The least significant byte is stored at the highest memory address.

Parameters:

- bytes: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - A big-endian two's complement byte array. The array length cannot be empty.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when an empty array is passed.

Example:

<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt([1, 2, 3])
    println(bigInt)
}
```

Execution Result:

```text
66051
```

### init(Bool, Array\<Byte>)

```cangjie
public init(sign: Bool, magnitude: Array<Byte>)
```

Function: Constructs a [BigInt](math_numeric_package_structs.md#struct-bigint) structure using a sign bit and the absolute value of the true value. Treats an empty array as 0.

Parameters:

- sign: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Sign bit. true indicates non-negative, false indicates negative.
- magnitude: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - Binary true form of the absolute value of the true value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when `sign` is false and the input array represents 0.

Example:

<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt(false, [1, 2, 3])
    println(bigInt)
}
```

Output:

```text
-66051
```

### init(Bool, Int64, Random)

```cangjie
public init(sign: Bool, bitLen: Int64, rand!: Random = Random())
```

Function: Constructs a random [BigInt](math_numeric_package_structs.md#struct-bigint) structure by specifying sign, bit length, and random seed. Bit length must be greater than 0.

Parameters:

- sign: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Specifies the sign of the random [BigInt](math_numeric_package_structs.md#struct-bigint).
- bitLen: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Specifies the upper limit of the bit length for the random [BigInt](math_numeric_package_structs.md#struct-bigint).
- rand!: [Random](../../random/random_package_api/random_package_classes.md#class-random) - Specified random seed.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the specified bit length is less than or equal to 0.

Example:

<!-- verify -->
```cangjie
import std.math.numeric.BigInt
import std.random.*

main() {
    let random = Random(2)
    let bigInt = BigInt(false, 3, rand: random)
    println(bigInt)
}
```

Output:

```text
-4
```

### init(Float16)

```cangjie
public init(n: Float16)
```

Function: Constructs a [BigInt](math_numeric_package_structs.md#struct-bigint) structure from a half-precision floating-point number.

Discards the fractional part of the floating-point number, i.e., rounds towards zero.

Parameters:

- n: [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - Half-precision floating-point number.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if n is `Inf` or `NaN`.

Example:

<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let float16: Float16 = 24.8
    let bigInt = BigInt(float16)
    println(bigInt)
}
```

Output:

```text
24
```

### init(Float32)

```cangjie
public init(n: Float32)
```

Function: Constructs a [BigInt](math_numeric_package_structs.md#struct-bigint) structure from a single-precision floating-point number.

Discards the fractional part of the floating-point number, i.e., rounds towards zero.

Parameters:

- n: [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - Single-precision floating-point number.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if n is `Inf` or `NaN`.

Example:

<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let float32: Float32 = 24.8
    let bigInt = BigInt(float32)
    println(bigInt)
}
```

Output:

```text
24
```

### init(Float64)

```cangjie
public init(n: Float64)
```

Function: Constructs a [BigInt](math_numeric_package_structs.md#struct-bigint) structure from a double-precision floating-point number.

The fractional part of the floating-point number will be discarded, i.e., rounded towards zero.

Parameters:

- n: [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - A double-precision floating-point number.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if n is `Inf` or `NaN`.

Example:

<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let float64: Float64 = 24.8
    let bigInt = BigInt(float64)
    println(bigInt)
}
```

Output:

```text
24
```

### init(Int16)

```cangjie
public init(n: Int16)
```

Function: Constructs a [BigInt](math_numeric_package_structs.md#struct-bigint) structure from a 16-bit signed integer.

Parameters:

- n: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - A 16-bit signed integer.

Example:

<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let int16: Int16 = 24
    let bigInt = BigInt(int16)
    println(bigInt)
}
```

Output:

```text
24
```

### init(Int32)

```cangjie
public init(n: Int32)
```

Function: Constructs a [BigInt](math_numeric_package_structs.md#struct-bigint) structure from a 32-bit signed integer.

Parameters:

- n: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - A 32-bit signed integer.

Example:

<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let int32: Int32 = 24
    let bigInt = BigInt(int32)
    println(bigInt)
}
```

Output:

```text
24
```

### init(Int64)

```cangjie
public init(n: Int64)
```

Function: Constructs a [BigInt](math_numeric_package_structs.md#struct-bigint) structure from a 64-bit signed integer.

Parameters:

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - A 64-bit signed integer.

Example:

<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let int64: Int64 = 24
    let bigInt = BigInt(int64)
    println(bigInt)
}
```

Output:

```text
24
```

### init(Int8)

```cangjie
public init(n: Int8)
```

Function: Constructs a [BigInt](math_numeric_package_structs.md#struct-bigint) structure from an 8-bit signed integer.

Parameters:

- n: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - An 8-bit signed integer.

Example:

<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let int8: Int8 = 24
    let bigInt = BigInt(int8)
    println(bigInt)
}
```

Execution Result:

```text
24
```

### init(IntNative)

```cangjie
public init(n: IntNative)
```

Function: Constructs a [BigInt](math_numeric_package_structs.md#struct-bigint) structure using a platform-dependent signed integer.

Parameters:

- n: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - A platform-dependent signed integer.

Example:

<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let intNative: IntNative = 24
    let bigInt = BigInt(intNative)
    println(bigInt)
}
```

Execution Result:

```text
24
```

### init(String, Int64) <sup>(deprecated)<sup>

```cangjie
public init(s: String, base!: Int64 = 10)
```

Function: Constructs a [BigInt](math_numeric_package_structs.md#struct-bigint) structure from a string and a base, supporting bases from 2 to 36.

The string must adhere to the following rules: it may start with an optional sign (positive or negative), followed by a sequence of digits representing the number:

IntegerString : (SignString)? ValueString

- SignString    : + | -

- ValueString   : Digits

  - Digits: Digit | Digit Digits

    - Digit         : '0' ~ '9' | 'A' ~ 'Z' | 'a' ~ 'z'

      - If the Digit is between '0' ~ '9', it must satisfy (Digit - '0') < base;

      - If the Digit is between 'A' ~ 'Z', it must satisfy (Digit - 'A') + 10 < base;

      - If the Digit is between 'a' ~ 'z', it must satisfy (Digit - 'A') + 10 < base.

> **Note:**
>
> This method will be deprecated in future versions. Use [parse(String, Int64)](./math_numeric_package_structs.md#static-func-parsestring-int64) instead.

Parameters:

- s: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string used to construct the [BigInt](math_numeric_package_structs.md#struct-bigint) structure. The string must start with an optional positive (+) or negative (-) sign, followed by a non-empty sequence of Arabic numerals or Latin letters (case-insensitive). 'a' and 'A' represent 10 in decimal, 'b' and 'B' represent 11, and so on. The value of each character in the sequence must be less than the base.
- base!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The base of the numeral system. Must be in the range [2, 36].

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the string `s` does not conform to the above rules or if `base` is not within the range [2, 36].

### init(UInt16)

```cangjie
public init(n: UInt16)
```

Function: Constructs a [BigInt](math_numeric_package_structs.md#struct-bigint) structure using a 16-bit unsigned integer.

Parameters:

- n: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - A 16-bit unsigned integer.

Example:

<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let uint16: UInt16 = 24
    let bigInt = BigInt(uint16)
    println(bigInt)
}
```

Execution Result:

```text
24
```

### init(UInt32)

```cangjie
public init(n: UInt32)
```

Function: Constructs a [BigInt](math_numeric_package_structs.md#struct-bigint) structure using a 32-bit unsigned integer.

Parameters:

- n: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - A 32-bit unsigned integer.

Example:

<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let uint32: UInt32 = 24
    let bigInt = BigInt(uint32)
    println(bigInt)
}
```

Execution Result:

```text
24
```

### init(UInt64)

```cangjie
public init(n: UInt64)
```

Function: Constructs a [BigInt](math_numeric_package_structs.md#struct-bigint) structure using a 64-bit unsigned integer.

Parameters:

- n: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 64-bit unsigned integer.

Example:

<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let uint64: UInt64 = 24
    let bigInt = BigInt(uint64)
    println(bigInt)
}
```

Execution Result:

```text
24
```

### init(UInt8)

```cangjie
public init(n: UInt8)
```

Function: Constructs a [BigInt](math_numeric_package_structs.md#struct-bigint) structure from an 8-bit unsigned integer.

Parameters:

- n: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 8-bit unsigned integer.

Example:

<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let uint8: UInt8 = 24
    let bigInt = BigInt(uint8)
    println(bigInt)
}
```

Execution Result:

```text
24
```

### init(UIntNative)

```cangjie
public init(n: UIntNative)
```

Function: Constructs a [BigInt](math_numeric_package_structs.md#struct-bigint) structure from a platform-dependent unsigned integer.

Parameters:

- n: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Platform-dependent unsigned integer.

Example:

<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let uintnative: UIntNative = 24
    let bigInt = BigInt(uintnative)
    println(bigInt)
}
```

Execution Result:

```text
24
```

### static func randomProbablePrime(Int64, UInt64, Random)

```cangjie
public static func randomProbablePrime(bitLen: Int64, certainty: UInt64, rand!: Random = Random()): BigInt
```

Function: Constructs a random [BigInt](math_numeric_package_structs.md#struct-bigint) prime number using an optional random seed, where the bit length of the prime does not exceed the input parameter `bitLen`.

Clearly, a prime number must be an integer greater than or equal to 2, so `bitLen` must be greater than or equal to 2. Prime number detection uses the Miller-Rabin primality test algorithm. The Miller-Rabin test has a probability of incorrectly identifying a composite number as prime, with the error probability decreasing as the input parameter `certainty` increases.

Parameters:

- bitLen: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The upper limit of the bit length for the generated random prime number.
- certainty: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The number of times the generated random prime must pass the Miller-Rabin primality test. The more times it passes, the lower the probability of incorrectly identifying a composite number as prime.
- rand!: [Random](../../random/random_package_api/random_package_classes.md#class-random) - The specified random seed.

Return Value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - Returns the generated random prime number.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the specified bit length is less than or equal to 1.

Example:
<!-- run -->
```cangjie
import std.math.numeric.BigInt

main() {
    let randomProbablePrime = BigInt.randomProbablePrime(6, 3)
    println(randomProbablePrime)
}
```

### func clearBit(Int64)

```cangjie
public func clearBit(index: Int64): BigInt
```

Function: Constructs a new [BigInt](math_numeric_package_structs.md#struct-bigint) by setting the bit at the specified index position to 0.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index of the bit position to be set. `index` must be greater than or equal to 0.

Return Value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - A new [BigInt](math_numeric_package_structs.md#struct-bigint) resulting from setting the bit at `index` of the original [BigInt](math_numeric_package_structs.md#struct-bigint) to 0.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the input parameter `index` is less than 0.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt(1024)
    let clearBit = bigInt.clearBit(10)
    println(clearBit)
}
```Execution Result:

```text
0
```

### func compare(BigInt)

```cangjie
public func compare(that: BigInt): Ordering
```

Function: Determines the relationship between [BigInt](math_numeric_package_structs.md#struct-bigint) and another [BigInt](math_numeric_package_structs.md#struct-bigint).

Parameters:

- that: [BigInt](math_numeric_package_structs.md#struct-bigint) - Another [BigInt](math_numeric_package_structs.md#struct-bigint).

Return Value:

- [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) - Returns the relationship between this [BigInt](math_numeric_package_structs.md#struct-bigint) and another [BigInt](math_numeric_package_structs.md#struct-bigint). If equal, returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).EQ; if less than, returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).LT; if greater than, returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).GT.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt(1024)
    let that1 = BigInt(512)
    let that2 = BigInt(2048)
    let that3 = BigInt(1024)

    let compare1 = bigInt.compare(that1)
    println(compare1)

    let compare2 = bigInt.compare(that2)
    println(compare2)

    let compare3 = bigInt.compare(that3)
    println(compare3)
}
```

Execution Result:

```text
Ordering.GT
Ordering.LT
Ordering.EQ
```

### func divAndMod(BigInt)

```cangjie
public func divAndMod(that: BigInt): (BigInt, BigInt)
```

Function: Division operation for [BigInt](math_numeric_package_structs.md#struct-bigint).

Divides by another [BigInt](math_numeric_package_structs.md#struct-bigint) and returns the quotient and modulus. This division operation behaves consistently with the underlying type, i.e., the quotient is rounded towards zero, and the modulus has the same sign as the dividend.

Parameters:

- that: [BigInt](math_numeric_package_structs.md#struct-bigint) - The divisor. The divisor must not be 0.

Return Value:

- ([BigInt](math_numeric_package_structs.md#struct-bigint), [BigInt](math_numeric_package_structs.md#struct-bigint)) - The quotient and modulus.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown if the divisor is 0.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt(1025)
    let that = BigInt(512)
    let (div, mod) = bigInt.divAndMod(that)
    println(div)
    println(mod)
}
```

Execution Result:

```text
2
1
```

### func flipBit(Int64)

```cangjie
public func flipBit(index: Int64): BigInt
```

Function: Constructs a new [BigInt](math_numeric_package_structs.md#struct-bigint) by flipping the bit at the specified index.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index of the bit position to flip. `index` must be greater than or equal to 0.

Return Value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - A new [BigInt](math_numeric_package_structs.md#struct-bigint) resulting from flipping the bit at `index` of the original [BigInt](math_numeric_package_structs.md#struct-bigint).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the input `index` is less than 0.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt(1024)
    let flipBit = bigInt.flipBit(10)
    println(flipBit)
}
```

Execution Result:

```text
0
```

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Computes and returns the hash code of this [BigInt](math_numeric_package_structs.md#struct-bigint).

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Returns the hash code of this [BigInt](math_numeric_package_structs.md#struct-bigint).

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt
main() {
    let bigInt = BigInt(1024)
    let hashCode = bigInt.hashCode()
    println(hashCode)
}
```

Execution Result:

```text
1024
```

### func isProbablePrime(UInt64)

```cangjie
public func isProbablePrime(certainty: UInt64): Bool
```

Function: Determines whether a number is prime.

> **Note:**
>
> This function employs the Miller-Rabin primality test algorithm. The accuracy of this algorithm increases with higher values of the `certainty` parameter. If the number is prime, the Miller-Rabin test will always return true; if the number is composite (expected to return false), there is a probability lower than 1/4<sup>certainty</sup> that it may return true. Primality is only meaningful for positive integers greater than or equal to 2, meaning negative numbers, 0, and 1 are not considered prime.

Parameters:

- certainty: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The number of times the Miller-Rabin test should be executed. Note that if the test count is 0 (indicating no test), the function will always return true (i.e., non-prime numbers will also return true).

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the number is determined to be prime using this function; otherwise, returns false.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt(1024)
    let isProbablePrime = bigInt.isProbablePrime(10)
    println(isProbablePrime)
}
```

Execution Result:

```text
false
```

### func lowestOneBit() <sup>(deprecated)<sup>

```cangjie
public func lowestOneBit(): Int64
```

Function: Determines the position of the lowest-order bit that is set to 1.

> **Note:**
>
> This method will be deprecated in future versions. Use [trailingZeros(BigInt)](./math_numeric_package_funcs.md#func-trailingzerosbigint) instead.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Returns the position of the lowest-order bit set to 1. If all bits are 0, returns -1.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt(-1)
    let lowestOneBit = bigInt.lowestOneBit()
    println(lowestOneBit)
}
```

Execution Result:

```text
0
```

### func modInverse(BigInt)

```cangjie
public func modInverse(that: BigInt): BigInt
```

Function: Computes the modular multiplicative inverse.

The modular inverse `r` satisfies $(this * r) \% that == 1$. Clearly, `this` and `that` must be coprime. When `that` is ±1, the result is always 0.

Parameters:

- that: [BigInt](math_numeric_package_structs.md#struct-bigint) - Another [BigInt](math_numeric_package_structs.md#struct-bigint). The input must not be 0 and must be coprime with `this`.

Return Value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - Returns the modular multiplicative inverse.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when `this` and `that` are not coprime or when `that` is 0.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt(1025)
    let that = BigInt(512)
    let modInverse = bigInt.modInverse(that)
    println(modInverse)
}
```

Execution Result:

```text
1
```

### func modPow(BigInt, ?BigInt)

```cangjie
public func modPow(n: BigInt, m!: ?BigInt = None): BigInt
```

Function: Computes the result of raising this [BigInt](math_numeric_package_structs.md#struct-bigint) to the power of `n` modulo `m` and returns it.

The modulo operation follows the same rules as basic types, meaning the sign of the result matches the dividend.

Parameters:

- n: [BigInt](math_numeric_package_structs.md#struct-bigint) - The exponent, which must be non-negative.
- m!: ?[BigInt](math_numeric_package_structs.md#struct-bigint) - The divisor. This parameter must not be 0.

Return Value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - The result of the exponentiation followed by the modulo operation.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the divisor is 0.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the exponent is negative.

Example:

<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt(2)
    let n = BigInt(10)
    let modPow = bigInt.modPow(n)
    println(modPow)
}
```

Execution result:

```text
1024
```

### func quo(BigInt) <sup>(deprecated)<sup>

```cangjie
public func quo(that: BigInt): BigInt
```

Function: Division operation for [BigInt](math_numeric_package_structs.md#struct-bigint).

Divides by another [BigInt](math_numeric_package_structs.md#struct-bigint) and returns the result. This division operation differs from the [operator overloading function](#operator-func-bigint-10) in that when the dividend is negative, the result of this function rounds away from zero, ensuring the remainder is always non-negative.

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- that: [BigInt](math_numeric_package_structs.md#struct-bigint) - The divisor. The divisor must not be zero.

Return Value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - A new [BigInt](math_numeric_package_structs.md#struct-bigint) representing the result of dividing this [BigInt](math_numeric_package_structs.md#struct-bigint) by another [BigInt](math_numeric_package_structs.md#struct-bigint).

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the divisor is zero.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt(1025)
    let that = BigInt(512)
    let quo = bigInt.quo(that)
    println(quo)
}
```

Execution Result:

```text
2
```

### func quoAndRem(BigInt) <sup>(deprecated)<sup>

```cangjie
public func quoAndRem(that: BigInt): (BigInt, BigInt)
```

Function: Division operation for [BigInt](math_numeric_package_structs.md#struct-bigint).

Divides by another [BigInt](math_numeric_package_structs.md#struct-bigint) and returns both the quotient and remainder. This division operation differs from the [divAndMod](#func-divandmodbigint) function in that when the dividend is negative, the result rounds away from zero, ensuring the remainder is always non-negative.

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- that: [BigInt](math_numeric_package_structs.md#struct-bigint) - The divisor. The divisor must not be zero.

Return Value:

- ([BigInt](math_numeric_package_structs.md#struct-bigint), [BigInt](math_numeric_package_structs.md#struct-bigint)) - The quotient and remainder.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the divisor is zero.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt(1025)
    let that = BigInt(512)
    let (quo, rem) = bigInt.quoAndRem(that)
    println(quo)
    println(rem)
}
```

Execution Result:

```text
2
1
```

### func rem(BigInt) <sup>(deprecated)<sup>

```cangjie
public func rem(that: BigInt): BigInt
```

Function: Modulus operation for [BigInt](math_numeric_package_structs.md#struct-bigint).

Divides by another [BigInt](math_numeric_package_structs.md#struct-bigint) and returns the remainder. The remainder is always non-negative.

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- that: [BigInt](math_numeric_package_structs.md#struct-bigint) - The divisor. The divisor must not be zero.

Return Value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - A new [BigInt](math_numeric_package_structs.md#struct-bigint) representing the remainder of dividing this [BigInt](math_numeric_package_structs.md#struct-bigint) by another [BigInt](math_numeric_package_structs.md#struct-bigint).

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the divisor is zero.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt(1025)
    let that = BigInt(512)
    let rem = bigInt.rem(that)
    println(rem)
}
```

Execution Result:

```text
1
```

### func setBit(Int64)

```cangjie
public func setBit(index: Int64): BigInt
```

Function: Constructs a new [BigInt](math_numeric_package_structs.md#struct-bigint) by modifying the bit at the specified index position to 1.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index of the bit position to be set. `index` must be greater than or equal to 0.

Return Value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - A new [BigInt](math_numeric_package_structs.md#struct-bigint) resulting from changing the bit at `index` of the original [BigInt](math_numeric_package_structs.md#struct-bigint) to 1.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the input parameter `index` is less than 0.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt(0)
    let setBit = bigInt.setBit(10)
    println(setBit)
}
```

Execution Result:

```text
1024
```

### func testBit(Int64)

```cangjie
public func testBit(index: Int64): Bool
```

Function: Determines the bit information at the specified position. Returns false if the bit at the specified position is 0; returns true if it is 1.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index of the bit to be queried. `index` must be greater than or equal to 0.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The bit information at the specified position.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the input parameter `index` is less than 0.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt(-1)
    let testBit = bigInt.testBit(100)
    println(testBit)
}
```

Execution Result:

```text
true
```

### func toBytes()

```cangjie
public func toBytes(): Array<Byte>
```

Function: Computes and returns the big-endian two's complement byte array of this [BigInt](math_numeric_package_structs.md#struct-bigint).

The least significant bit of the lowest index in the byte array is the sign bit. For example, 128 returns [0, 128] (sign bit is 0), and -128 returns [128] (sign bit is 1).

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - The big-endian two's complement byte array of this [BigInt](math_numeric_package_structs.md#struct-bigint).

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt(0x400)
    let toBytes = bigInt.toBytes()
    println(toBytes)
}
```

Execution Result:

```text
[4, 0]
```

### func toFloat16()

```cangjie
public func toFloat16(): Float16
```

Function: Converts the current [BigInt](math_numeric_package_structs.md#struct-bigint) object to a [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) type.

Return Value:

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - The converted [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) value. In case of overflow, if the current value is positive, returns `inf`; if negative, returns `-inf`.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt(32)
    let toFloat16 = bigInt.toFloat16()
    println(toFloat16)
}
```

Execution Result:

```text
32.000000
```

### func toFloat32()

```cangjie
public func toFloat32(): Float32
```

Function: Converts the current [BigInt](math_numeric_package_structs.md#struct-bigint) object to [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) type.

Return Value:

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - The converted [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) value. On overflow, returns `inf` for positive values and `-inf` for negative values.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt(32)
    let toFloat32 = bigInt.toFloat32()
    println(toFloat32)
}
```

Execution Result:

```text
32.000000
```

### func toFloat64()

```cangjie
public func toFloat64(): Float64
```

Function: Converts the current [BigInt](math_numeric_package_structs.md#struct-bigint) object to [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) type.

Return Value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The converted [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) value. On overflow, returns `inf` for positive values and `-inf` for negative values.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt(32)
    let toFloat64 = bigInt.toFloat64()
    println(toFloat64)
}
```

Execution Result:

```text
32.000000
```

### func toInt16(OverflowStrategy)

```cangjie
public func toInt16(overflowHandling!: OverflowStrategy = Throwing): Int16
```

Function: Converts the current [BigInt](math_numeric_package_structs.md#struct-bigint) object to [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) type, supporting custom overflow strategies.

Parameters:

- overflowHandling!: [OverflowStrategy](math_numeric_package_enums.md#enum-overflowstrategy) - The overflow handling strategy during conversion.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Returns the converted [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) value.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Throws this exception when no overflow strategy is specified or when the overflow strategy is `throwing` and overflow occurs.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt
import std.math.numeric.OverflowStrategy

main() {
    let bigInt = BigInt(0x8000_0000_0000)
    let toInt16 = bigInt.toInt16(overflowHandling: Saturating)
    println(toInt16)
}
```

Execution Result:

```text
32767
```

### func toInt32(OverflowStrategy)

```cangjie
public func toInt32(overflowHandling!: OverflowStrategy = Throwing): Int32
```

Function: Converts the current [BigInt](math_numeric_package_structs.md#struct-bigint) object to [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) type, supporting custom overflow strategies.

Parameters:

- overflowHandling!: [OverflowStrategy](math_numeric_package_enums.md#enum-overflowstrategy) - The overflow handling strategy during conversion.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns the converted [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) value.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Throws this exception when no overflow strategy is specified or when the overflow strategy is `throwing` and overflow occurs.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt
import std.math.numeric.OverflowStrategy

main() {
    let bigInt = BigInt(0x8000_0000_00FF)
    let toInt32 = bigInt.toInt32(overflowHandling: Wrapping)
    println(toInt32)
}
```

Execution Result:

```text
255
```

### func toInt64(OverflowStrategy)

```cangjie
public func toInt64(overflowHandling!: OverflowStrategy = Throwing): Int64
```

Function: Converts the current [BigInt](math_numeric_package_structs.md#struct-bigint) object to [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) type, supporting custom overflow strategies.

Parameters:

- overflowHandling!: [OverflowStrategy](math_numeric_package_enums.md#enum-overflowstrategy) - The overflow handling strategy during conversion.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Returns the converted [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) value.

Exceptions:- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Throws this exception when overflow occurs during conversion without specifying an overflow strategy or when the strategy is set to `throwing`.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt
import std.math.numeric.OverflowStrategy

main() {
    let bigInt = BigInt.parse("800000000000000000", radix: 16)
    let toInt64 = bigInt.toInt64(overflowHandling: Wrapping)
    println(toInt64)
}
```

Execution result:

```text
0
```

### func toInt8(OverflowStrategy)

```cangjie
public func toInt8(overflowHandling!: OverflowStrategy = Throwing): Int8
```

Function: Converts the current [BigInt](math_numeric_package_structs.md#struct-bigint) object to an [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) type, supporting customizable overflow strategies.

Parameters:

- overflowHandling!: [OverflowStrategy](math_numeric_package_enums.md#enum-overflowstrategy) - Overflow handling strategy for conversion.

Return value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - Returns the converted [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) value.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Throws this exception when overflow occurs during conversion without specifying an overflow strategy or when the strategy is set to `throwing`.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt
import std.math.numeric.OverflowStrategy

main() {
    let bigInt = BigInt(1024)
    let toInt8 = bigInt.toInt8(overflowHandling: Saturating)
    println(toInt8)
}
```

Execution result:

```text
127
```

### func toIntNative(OverflowStrategy)

```cangjie
public func toIntNative(overflowHandling!: OverflowStrategy = Throwing): IntNative
```

Function: Converts the current [BigInt](math_numeric_package_structs.md#struct-bigint) object to an [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) type, supporting customizable overflow strategies.

Parameters:

- overflowHandling!: [OverflowStrategy](math_numeric_package_enums.md#enum-overflowstrategy) - Overflow handling strategy for conversion.

Return value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Returns the converted [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) value.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Throws this exception when overflow occurs during conversion without specifying an overflow strategy or when the strategy is set to `throwing`.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt
import std.math.numeric.OverflowStrategy

main() {
    let bigInt = BigInt.parse("800000000000000000", radix: 16)
    let toIntNative = bigInt.toIntNative(overflowHandling: Wrapping)
    println(toIntNative)
}
```

Execution result:

```text
0
```

### func toString()

```cangjie
public func toString(): String
```

Function: Computes and returns the decimal string representation of this [BigInt](math_numeric_package_structs.md#struct-bigint).

Return value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - Returns the decimal string representation of this [BigInt](math_numeric_package_structs.md#struct-bigint).

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt(0x400)
    let toString = bigInt.toString()
    println(toString)
}
```

Execution result:

```text
1024
```

### func toUInt16(OverflowStrategy)

```cangjie
public func toUInt16(overflowHandling!: OverflowStrategy = Throwing): UInt16
```

Function: Converts the current [BigInt](math_numeric_package_structs.md#struct-bigint) object to a [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) type, supporting customizable overflow strategies.

Parameters:

- overflowHandling!: [OverflowStrategy](math_numeric_package_enums.md#enum-overflowstrategy) - Overflow handling strategy for conversion.

Return value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - Returns the converted [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) value.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Throws this exception when overflow occurs during conversion without specifying an overflow strategy or when the strategy is set to `throwing`.

Example:<!-- verify -->

```cangjie
import std.math.numeric.BigInt
import std.math.numeric.OverflowStrategy

main() {
    let bigInt = BigInt.parse("800000000000000000", radix: 16)
    let toUInt16 = bigInt.toUInt16(overflowHandling: Wrapping)
    println(toUInt16)
}
```

Execution result:

```text
0
```

### func toUInt32(OverflowStrategy)

```cangjie
public func toUInt32(overflowHandling!: OverflowStrategy = Throwing): UInt32
```

Function: Converts the current [BigInt](math_numeric_package_structs.md#struct-bigint) object to a [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) type, supporting custom overflow handling strategies.

Parameters:

- overflowHandling!: [OverflowStrategy](math_numeric_package_enums.md#enum-overflowstrategy) - The overflow handling strategy for conversion.

Return value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Returns the converted [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) value.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when no overflow strategy is specified or when the overflow strategy is `throwing` and overflow occurs during conversion.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt
import std.math.numeric.OverflowStrategy

main() {
    let bigInt = BigInt.parse("800000000000000000", radix: 16)
    let toUInt32 = bigInt.toUInt32(overflowHandling: Wrapping)
    println(toUInt32)
}
```

Execution result:

```text
0
```

### func toUInt64(OverflowStrategy)

```cangjie
public func toUInt64(overflowHandling!: OverflowStrategy = Throwing): UInt64
```

Function: Converts the current [BigInt](math_numeric_package_structs.md#struct-bigint) object to a [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) type, supporting custom overflow handling strategies.

Parameters:

- overflowHandling!: [OverflowStrategy](math_numeric_package_enums.md#enum-overflowstrategy) - The overflow handling strategy for conversion.

Return value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Returns the converted [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) value.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when no overflow strategy is specified or when the overflow strategy is `throwing` and overflow occurs during conversion.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt
import std.math.numeric.OverflowStrategy

main() {
    let bigInt = BigInt.parse("-800000000000000000", radix: 16)
    let toUInt64 = bigInt.toUInt64(overflowHandling: Saturating)
    println(toUInt64)
}
```

Execution result:

```text
0
```

### func toUInt8(OverflowStrategy)

```cangjie
public func toUInt8(overflowHandling!: OverflowStrategy = Throwing): UInt8
```

Function: Converts the current [BigInt](math_numeric_package_structs.md#struct-bigint) object to a [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) type, supporting custom overflow handling strategies.

Parameters:

- overflowHandling!: [OverflowStrategy](math_numeric_package_enums.md#enum-overflowstrategy) - The overflow handling strategy for conversion.

Return value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - Returns the converted [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) value.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when no overflow strategy is specified or when the overflow strategy is `throwing` and overflow occurs during conversion.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt
import std.math.numeric.OverflowStrategy

main() {
    let bigInt = BigInt.parse("800000000000000000", radix: 16)
    try {
        bigInt.toUInt8(overflowHandling: Throwing)
    } catch (e: OverflowException) {
        println(e.message)
    }
    return
}
```

Execution result:

```text
Out of range of the UInt8.
```

### func toUIntNative(OverflowStrategy)

```cangjie
public func toUIntNative(overflowHandling!: OverflowStrategy = Throwing): UIntNative
```

Function: Converts the current [BigInt](math_numeric_package_structs.md#struct-bigint) object to a [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) type, supporting custom overflow handling strategies.

Parameters:

- overflowHandling!: [OverflowStrategy](math_numeric_package_enums.md#enum-overflowstrategy) - The overflow handling strategy for conversion.Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Returns the converted [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) value.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when the conversion overflows without specifying an overflow strategy or when the overflow strategy is set to `throwing`.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt
import std.math.numeric.OverflowStrategy

main() {
    let bigInt = BigInt.parse("-800000000000000000", radix: 16)
    let toUIntNative = bigInt.toUIntNative(overflowHandling: Saturating)
    println(toUIntNative)
}
```

Output:

```text
0
```

### operator func !()

```cangjie
public operator func !(): BigInt
```

Function: Bitwise NOT. Inverts all binary bits of the operand (0 becomes 1, and 1 becomes 0).

Return Value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - Returns the result of the bitwise NOT operation on this [BigInt](math_numeric_package_structs.md#struct-bigint).

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt.parse("-1")
    let no = !bigInt
    println(no)
}
```

Output:

```text
0
```

### operator func !=(BigInt)

```cangjie
public operator func !=(that: BigInt): Bool
```

Function: Inequality operator.

Parameters:

- that: [BigInt](math_numeric_package_structs.md#struct-bigint) - Another [BigInt](math_numeric_package_structs.md#struct-bigint) for the inequality comparison.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The result of the inequality comparison. Returns `true` if not equal, otherwise `false`.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt.parse("-1")
    let that = BigInt.parse("-2")
    println(bigInt != that)
}
```

Output:

```text
true
```

### operator func %(BigInt)

```cangjie
public operator func %(that: BigInt): BigInt
```

Function: Modulus operation for [BigInt](math_numeric_package_structs.md#struct-bigint).

The behavior of the modulus operation aligns with the base type, meaning the sign matches the dividend.

Parameters:

- that: [BigInt](math_numeric_package_structs.md#struct-bigint) - The divisor. The divisor must not be 0.

Return Value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - A new [BigInt](math_numeric_package_structs.md#struct-bigint) representing the result of the modulus operation between this [BigInt](math_numeric_package_structs.md#struct-bigint) and another [BigInt](math_numeric_package_structs.md#struct-bigint).

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the divisor is 0.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt.parse("-23456789123456789")
    let that = BigInt.parse("-23456789123456789")
    let mod = bigInt % that
    println(mod)
}
```

Output:

```text
0
```

### operator func &(BigInt)

```cangjie
public operator func &(that: BigInt): BigInt
```

Function: Bitwise AND. Performs a bitwise AND operation where each corresponding bit of the operands is compared. The result bit is 1 only if both corresponding bits are 1.

Parameters:

- that: [BigInt](math_numeric_package_structs.md#struct-bigint) - Another [BigInt](math_numeric_package_structs.md#struct-bigint) for the bitwise AND operation.

Return Value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - Returns the result of the bitwise AND operation with another [BigInt](math_numeric_package_structs.md#struct-bigint).

Example:<!-- verify -->

```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt.parse("8")
    let that = BigInt.parse("7")
    let and = bigInt & that
    println(and)
}
```

Execution result:

```text
0
```

### operator func *(BigInt)

```cangjie
public operator func *(that: BigInt): BigInt
```

Function: [BigInt](math_numeric_package_structs.md#struct-bigint) multiplication.

Parameters:

- that: [BigInt](math_numeric_package_structs.md#struct-bigint) - The multiplier.

Return value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - A new [BigInt](math_numeric_package_structs.md#struct-bigint) representing the product of this [BigInt](math_numeric_package_structs.md#struct-bigint) multiplied by another [BigInt](math_numeric_package_structs.md#struct-bigint).

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt.parse("-1")
    let that = BigInt.parse("-23456789123456789")
    let mul = bigInt * that
    println(mul)
}
```

Execution result:

```text
23456789123456789
```

### operator func **(UInt64)

```cangjie
public operator func **(n: UInt64): BigInt
```

Function: Raises a [BigInt](math_numeric_package_structs.md#struct-bigint) to the power of n.

Parameters:

- n: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The exponent.

Return value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - The result of the exponentiation operation.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt.parse("-2")
    let power = bigInt ** 64
    println(power.toString(radix: 16))
}
```

Execution result:

```text
10000000000000000
```

### operator func +(BigInt)

```cangjie
public operator func +(that: BigInt): BigInt
```

Function: [BigInt](math_numeric_package_structs.md#struct-bigint) addition.

Parameters:

- that: [BigInt](math_numeric_package_structs.md#struct-bigint) - The addend.

Return value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - A new [BigInt](math_numeric_package_structs.md#struct-bigint) representing the sum of this [BigInt](math_numeric_package_structs.md#struct-bigint) added to another [BigInt](math_numeric_package_structs.md#struct-bigint).

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt.parse("123456789123456789")
    let that = BigInt.parse("-23456789123456789")
    let plus = bigInt + that
    println(plus)
}
```

Execution result:

```text
100000000000000000
```

### operator func -()

```cangjie
public operator func -(): BigInt
```

Function: Computes the negation of a [BigInt](math_numeric_package_structs.md#struct-bigint).

Return value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - Returns the negation of this [BigInt](math_numeric_package_structs.md#struct-bigint).

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt.parse("-23456789123456789")
    let opposite = -bigInt
    println(opposite)
}
```

Execution result:

```text
23456789123456789
```

### operator func -(BigInt)

```cangjie
public operator func -(that: BigInt): BigInt
```

Function: [BigInt](math_numeric_package_structs.md#struct-bigint) subtraction.

Parameters:

- that: [BigInt](math_numeric_package_structs.md#struct-bigint) - The subtrahend.

Return Value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - A new [BigInt](math_numeric_package_structs.md#struct-bigint) representing the result of subtracting another [BigInt](math_numeric_package_structs.md#struct-bigint) from this [BigInt](math_numeric_package_structs.md#struct-bigint).

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt.parse("100000000000000000")
    let that = BigInt.parse("-23456789123456789")
    let sub = bigInt - that
    println(sub)
}
```

Output:

```text
123456789123456789
```

### operator func <(BigInt)

```cangjie
public operator func <(that: BigInt): Bool
```

Function: Less-than comparison operation.

Parameters:

- that: [BigInt](math_numeric_package_structs.md#struct-bigint) - Another [BigInt](math_numeric_package_structs.md#struct-bigint) for comparison.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The comparison result. Returns true if less than, otherwise false.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt.parse("-1")
    let that = BigInt.parse("-2")
    println(bigInt < that)
}
```

Output:

```text
false
```

### operator func <<(Int64)

```cangjie
public operator func <<(n: Int64): BigInt
```

Function: Left shift operation.

Parameters:

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Number of bits to shift left (must be greater than or equal to 0).

Return Value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - The result of left-shifting this [BigInt](math_numeric_package_structs.md#struct-bigint) by n bits.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the input parameter is less than 0.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt.parse("-1")
    let leftShift = bigInt << 64
    println(leftShift.toString(radix: 16))
}
```

Output:

```text
-10000000000000000
```

### operator func <=(BigInt)

```cangjie
public operator func <=(that: BigInt): Bool
```

Function: Less-than-or-equal comparison operation.

Parameters:

- that: [BigInt](math_numeric_package_structs.md#struct-bigint) - Another [BigInt](math_numeric_package_structs.md#struct-bigint) for comparison.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The comparison result. Returns true if less than or equal, otherwise false.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt.parse("-1")
    let that = BigInt.parse("-2")
    println(bigInt <= that)
}
```

Output:

```text
false
```

### operator func ==(BigInt)

```cangjie
public operator func ==(that: BigInt): Bool
```

Function: Equality comparison operation.Parameters:

- that: [BigInt](math_numeric_package_structs.md#struct-bigint) - Another [BigInt](math_numeric_package_structs.md#struct-bigint) for equality comparison.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The result of equality comparison. Returns true if equal, false otherwise.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt.parse("-1")
    let that = BigInt.parse("-2")
    println(bigInt == that)
}
```

Execution Result:

```text
false
```

### operator func >(BigInt)

```cangjie
public operator func >(that: BigInt): Bool
```

Function: Greater-than comparison operation.

Parameters:

- that: [BigInt](math_numeric_package_structs.md#struct-bigint) - Another [BigInt](math_numeric_package_structs.md#struct-bigint) for greater-than comparison.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The comparison result. Returns true if greater than, false otherwise.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt.parse("-1")
    let that = BigInt.parse("-2")
    println(bigInt > that)
}
```

Execution Result:

```text
true
```

### operator func >=(BigInt)

```cangjie
public operator func >=(that: BigInt): Bool
```

Function: Greater-than-or-equal comparison operation.

Parameters:

- that: [BigInt](math_numeric_package_structs.md#struct-bigint) - Another [BigInt](math_numeric_package_structs.md#struct-bigint) for greater-than-or-equal comparison.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The comparison result. Returns true if greater than or equal, false otherwise.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt.parse("-1")
    let that = BigInt.parse("-2")
    println(bigInt >= that)
}
```

Execution Result:

```text
true
```

### operator func >>(Int64)

```cangjie
public operator func >>(n: Int64): BigInt
```

Function: Right-shift operation.

Parameters:

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Number of bits to right-shift. Must be greater than or equal to 0.

Return Value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - The result of right-shifting this [BigInt](math_numeric_package_structs.md#struct-bigint) by n bits.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the input parameter is less than 0.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt.parse("-1")
    let rightShift = bigInt >> 10000
    println(rightShift)
}
```

Execution Result:

```text
-1
```

### operator func /(BigInt)

```cangjie
public operator func /(that: BigInt): BigInt
```

Function: [BigInt](math_numeric_package_structs.md#struct-bigint) division.

The division behavior is consistent with primitive types, where the result is rounded towards zero.

Parameters:

- that: [BigInt](math_numeric_package_structs.md#struct-bigint) - The divisor. Must not be zero.

Return Value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - A new [BigInt](math_numeric_package_structs.md#struct-bigint) representing the result of dividing this [BigInt](math_numeric_package_structs.md#struct-bigint) by another [BigInt](math_numeric_package_structs.md#struct-bigint).Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when division by zero occurs.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt.parse("-23456789123456789")
    let that = BigInt.parse("-23456789123456789")
    let div = bigInt / that
    println(div)
}
```

Execution Result:

```text
1
```

### operator func ^(BigInt)

```cangjie
public operator func ^(that: BigInt): BigInt
```

Function: Bitwise XOR operation. Performs an exclusive OR operation where the corresponding bits of two numbers are compared. The result bit is 1 if the input bits differ, and 0 if they are the same.

Parameters:

- that: [BigInt](math_numeric_package_structs.md#struct-bigint) - Another [BigInt](math_numeric_package_structs.md#struct-bigint) for the bitwise XOR operation.

Return Value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - Returns the result of the bitwise XOR operation with another [BigInt](math_numeric_package_structs.md#struct-bigint).

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt.parse("-1")
    let that = BigInt.parse("7")
    let xor = bigInt ^ that
    println(xor)
}
```

Execution Result:

```text
-8
```

### operator func |(BigInt)

```cangjie
public operator func |(that: BigInt): BigInt
```

Function: Bitwise OR operation. Performs an inclusive OR operation where the corresponding bits of two numbers are compared. The result bit is 0 only if both input bits are 0.

Parameters:

- that: [BigInt](math_numeric_package_structs.md#struct-bigint) - Another [BigInt](math_numeric_package_structs.md#struct-bigint) for the bitwise OR operation.

Return Value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - Returns the result of the bitwise OR operation with another [BigInt](math_numeric_package_structs.md#struct-bigint).

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt.parse("8")
    let that = BigInt.parse("7")
    let or = bigInt | that
    println(or)
}
```

Execution Result:

```text
15
```

### extend BigInt <: Integer\<BigInt>

```cangjie
extend BigInt <: Integer<BigInt>
```

Function: Extends the [Integer\<T>](../../math/math_package_api/math_package_interfaces.md#interface-integert) interface for the [BigInt](#struct-bigint) type.

Parent Type:

- [Integer](../../math/math_package_api/math_package_interfaces.md#interface-integert)\<[BigInt](#struct-bigint)>

#### static func isSigned()

```cangjie
public static func isSigned(): Bool
```

Function: Determines whether the [BigInt](#struct-bigint) type is signed.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Always returns `true`.

### extend BigInt <: Formattable

```cangjie
extend BigInt <: Formattable
```

Function: Extends the [Formattable](../../convert/convert_package_api/convert_package_interfaces.md#interface-formattable) interface for [BigInt](#struct-bigint) to enable formatting of [BigInt](#struct-bigint) instances into strings.

Parent Type:

- [Formattable](../../convert/convert_package_api/convert_package_interfaces.md#interface-formattable)

#### func format(String)

```cangjie
public func format(fmt: String): String
```

Function: Formats the current [BigInt](#struct-bigint) instance into a string according to the specified format parameters.

Parameters:

- fmt: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Formatting parameters.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The formatted string representation of the current [BigInt](#struct-bigint) instance.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the fmt parameter is invalid.

### extend BigInt <: Number\<BigInt>

```cangjie
extend BigInt <: Number<BigInt> {}
```

Function: Extends the [Number\<T>](../../math/math_package_api/math_package_interfaces.md#interface-numbert) interface for the [BigInt](#struct-bigint) type.

Parent Types:

- [Number](../../math/math_package_api/math_package_interfaces.md#interface-numbert)\<[BigInt](#struct-bigint)>

### extend BigInt <: Parsable\<BigInt>

```cangjie
extend BigInt <: Parsable<BigInt>
```

Function: This extension primarily implements operations for converting string literals of the [BigInt](#struct-bigint) type into [BigInt](#struct-bigint) structs.

Parent Types:

- [Parsable](../../convert/convert_package_api/convert_package_interfaces.md#interface-parsablet)\<[BigInt](#struct-bigint)>

#### static func parse(String)

```cangjie
public static func parse(value: String): BigInt
```

Function: Parses a string into a [BigInt](math_numeric_package_structs.md#struct-bigint) struct.

The string follows these rules: an optional sign (positive or negative) at the beginning, followed by a base prefix, and then a sequence of digits:

IntegerString : SignString? BaseString? ValueString

- SignString : + | -

- BaseString : "0b" | "0B" | "0o" | "0O" | "0x" | "0X" | ""

- ValueString : Digits

  - Digits: Digit | Digit Digits

    - Digit : '0' ~ '9' | 'A' ~ 'Z' | 'a' ~ 'z'

      - If the base prefix is "0b" or "0B", Digit must be in the range '0' ~ '1';

      - If the base prefix is "0o" or "0O", Digit must be in the range '0' ~ '7';

      - If the base prefix is "0x" or "0X", Digit must be in the range '0' ~ '9', 'a' ~ 'z', or 'A' ~ 'Z';

      - If the base prefix is empty, Digit must be in the range '0' ~ '9'.

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string used to construct the [BigInt](math_numeric_package_structs.md#struct-bigint) struct. The string rules are: an optional positive (+) or negative (-) sign at the beginning, followed by an optional base prefix (default is decimal). Use "0b" or "0B" for binary, "0o" or "0O" for octal, and "0x" or "0X" for hexadecimal. This is followed by a mandatory non-empty sequence of Arabic numerals or Latin letters (case-insensitive, where 'a' and 'A' equal decimal 10, 'b' and 'B' equal decimal 11, etc.). The characters in the sequence must comply with the character set requirements of the corresponding base.

Return Value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - The parsed [BigInt](math_numeric_package_structs.md#struct-bigint) struct.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the string `value` does not conform to the above rules.

#### static func tryParse(String)

```cangjie
public static func tryParse(value: String): ?BigInt
```

Function: Attempts to parse a string into a [BigInt](math_numeric_package_structs.md#struct-bigint) struct.

The string follows these rules: an optional sign (positive or negative) at the beginning, followed by a base prefix, and then a sequence of digits:

IntegerString : SignString? BaseString? ValueString

- SignString : + | -

- BaseString : "0b" | "0B" | "0o" | "0O" | "0x" | "0X" | ""

- ValueString : Digits

  - Digits: Digit | Digit Digits

    - Digit : '0' ~ '9' | 'A' ~ 'Z' | 'a' ~ 'z'

      - If the base prefix is "0b" or "0B", Digit must be in the range '0' ~ '1';

      - If the base prefix is "0o" or "0O", Digit must be in the range '0' ~ '7';

      - If the base prefix is "0x" or "0X", Digit must be in the range '0' ~ '9', 'a' ~ 'z', or 'A' ~ 'Z';

      - If the base prefix is empty, Digit must be in the range '0' ~ '9'.

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string used to construct the [BigInt](math_numeric_package_structs.md#struct-bigint) struct. The string rules are: an optional positive (+) or negative (-) sign at the beginning, followed by an optional base prefix (default is decimal). Use "0b" or "0B" for binary, "0o" or "0O" for octal, and "0x" or "0X" for hexadecimal. This is followed by a mandatory non-empty sequence of Arabic numerals or Latin letters (case-insensitive, where 'a' and 'A' equal decimal 10, 'b' and 'B' equal decimal 11, etc.). The characters in the sequence must comply with the character set requirements of the corresponding base.

Return Value:

- ?[BigInt](math_numeric_package_structs.md#struct-bigint) - The parsed [BigInt](math_numeric_package_structs.md#struct-bigint) struct, or `None` if parsing fails.

### extend BigInt <: RadixConvertible\<BigInt>

```cangjie
extend BigInt <: RadixConvertible<BigInt>
```

Function: This extension primarily implements operations for converting string literals of the [BigInt](#struct-bigint) type into [BigInt](#struct-bigint) structs.

Parent Types:

- [RadixConvertible](../../convert/convert_package_api/convert_package_interfaces.md#interface-radixconvertiblet)\<[BigInt](#struct-bigint)>

#### static func parse(String, Int64)

```cangjie
public static func parse(value: String, radix!: Int64): BigInt
```

Function: Parses a string into a [BigInt](math_numeric_package_structs.md#struct-bigint) struct based on the specified radix, supporting bases from 2 to 36.

The string follows these rules: an optional sign (positive or negative) at the beginning, followed by a sequence of digits:

IntegerString : SignString? ValueString

- SignString : + | -

- ValueString : Digits

  - Digits: Digit | Digit Digits

    - Digit : '0' ~ '9' | 'A' ~ 'Z' | 'a' ~ 'z'

      - If Digit is in '0' ~ '9', it must satisfy (Digit - '0') < radix;

      - If Digit is in 'A' ~ 'Z', it must satisfy (Digit - 'A') + 10 < radix;

      - If Digit is in 'a' ~ 'z', it must satisfy (Digit - 'A') + 10 < radix.

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string used to construct the [BigInt](math_numeric_package_structs.md#struct-bigint) struct. The string rules are: an optional positive (+) or negative (-) sign at the beginning, followed by a mandatory non-empty sequence of Arabic numerals or Latin letters (case-insensitive, where 'a' and 'A' equal decimal 10, 'b' and 'B' equal decimal 11, etc.). The value of each character must not exceed the radix.
- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The radix. The base of the string representation, ranging from [2, 36].

Return Value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - The parsed [BigInt](math_numeric_package_structs.md#struct-bigint) struct.Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the string `value` does not conform to the specified rules, or if the `radix` is not within the range [2, 36].

#### static func tryParse(String, Int64)

```cangjie
public static func tryParse(value: String, radix!: Int64): ?BigInt
```

Function: Attempts to parse a string into a [BigInt](math_numeric_package_structs.md#struct-bigint) structure based on the specified radix, supporting bases from 2 to 36.

The string must adhere to the following rules, starting with an optional sign (positive or negative) followed by a sequence of digits:

IntegerString : SignString? ValueString

- SignString : + | -

- ValueString : Digits

  - Digits: Digit | Digit Digits

    - Digit : '0' ~ '9' | 'A' ~ 'Z' | 'a' ~ 'z'

      - If Digit is within '0' ~ '9', it must satisfy (Digit - '0') < radix;

      - If Digit is within 'A' ~ 'Z', it must satisfy (Digit - 'A') + 10 < radix;

      - If Digit is within 'a' ~ 'z', it must satisfy (Digit - 'A') + 10 < radix.

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string used to construct the [BigInt](math_numeric_package_structs.md#struct-bigint) structure. The string must start with an optional positive (+) or negative (-) sign, followed by a non-empty sequence of Arabic numerals or Latin letters (case-insensitive). The letters 'a' and 'A' represent the decimal value 10, 'b' and 'B' represent 11, and so on. The value of each character in the sequence must be less than the radix.
- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The radix (base) of the string representation, which must be within the range [2, 36].

Return Value:

- ?[BigInt](math_numeric_package_structs.md#struct-bigint) - The parsed [BigInt](math_numeric_package_structs.md#struct-bigint) structure, or `None` if parsing fails.

#### func toString(Int64)

```cangjie
public func toString(radix!: Int64): String
```

Function: Computes and returns the string representation of this [BigInt](math_numeric_package_structs.md#struct-bigint) in the specified radix.

Parameters:

- radix!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The radix (base) for the string representation, which must be within the range [2, 36].

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of this [BigInt](math_numeric_package_structs.md#struct-bigint) in the specified `radix`.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the input `radix` is not within the range [2, 36].

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt

main() {
    let bigInt = BigInt(0x400)
    let toString = bigInt.toString(radix: 2)
    println(toString)
}
```

Output:

```text
10000000000
```

## struct Decimal

```cangjie
public struct Decimal <: Comparable<Decimal> & Hashable & ToString {
    public init(val: String)
    public init(val: BigInt, scale: Int32)
    public init(val: BigInt)
    public init(val: Int8)
    public init(val: Int16)
    public init(val: Int32)
    public init(val: IntNative)
    public init(val: Int64)
    public init(val: UInt8)
    public init(val: UInt16)
    public init(val: UInt32)
    public init(val: UIntNative)
    public init(val: UInt64)
    public init(val: Float16)
    public init(val: Float32)
    public init(val: Float64)
}
```

Function: [Decimal](math_numeric_package_structs.md#struct-decimal) represents a signed decimal number of arbitrary precision. It allows specifying precision and rounding rules during operations. It provides conversion capabilities between primitive types (Int, UInt, [String](../../core/core_package_api/core_package_structs.md#struct-string), Float, etc.) and [BigInt](math_numeric_package_structs.md#struct-bigint), supports basic property queries for [Decimal](math_numeric_package_structs.md#struct-decimal) objects, basic mathematical operations, and fundamental capabilities such as comparison, hashing, and string representation.

Parent Types:

- [Comparable](../../core/core_package_api/core_package_interfaces.md#interface-comparablet)\<[Decimal](#struct-decimal)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop precision

```cangjie
public prop precision: Int64
```

Function: Gets the precision value of the [Decimal](math_numeric_package_structs.md#struct-decimal), which is the number of significant digits in the unscaled integer part (a non-negative value). A precision value of 0 indicates unlimited precision.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop scale

```cangjie
public prop scale: Int32
```

Function: Gets the scale value of the [Decimal](math_numeric_package_structs.md#struct-decimal).

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### prop sign

```cangjie
public prop sign: Int64
```

Function: Gets the sign value of the [Decimal](math_numeric_package_structs.md#struct-decimal) instance.

- Returns 1 if the [Decimal](math_numeric_package_structs.md#struct-decimal) value is greater than 0;
- Returns 0 if the [Decimal](math_numeric_package_structs.md#struct-decimal) value is equal to 0;
- Returns -1 if the [Decimal](math_numeric_package_structs.md#struct-decimal) value is less than 0.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop value

```cangjie
public prop value: BigInt
```

Function: Gets the unscaled integer value of the [Decimal](math_numeric_package_structs.md#struct-decimal), represented by a [BigInt](math_numeric_package_structs.md#struct-bigint).Type: [BigInt](math_numeric_package_structs.md#struct-bigint)

### init(BigInt)

```cangjie
public init(val: BigInt)
```

Function: Constructs a `Decimal` struct from a signed big integer [BigInt](math_numeric_package_structs.md#struct-bigint). By default, it uses a precision value of 0, meaning infinite precision for construction.

Parameters:

- val: [BigInt](math_numeric_package_structs.md#struct-bigint) - The signed big integer value.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt
import std.math.numeric.Decimal

main() {
    let bigInt = BigInt(24)
    let decimal = Decimal(bigInt)
    println(decimal)
}
```

Output:

```text
24
```

### init(BigInt, Int32)

```cangjie
public init(val: BigInt, scale: Int32)
```

Function: Constructs a `Decimal` struct from a signed big integer [BigInt](math_numeric_package_structs.md#struct-bigint) and a scale value. By default, it uses a precision value of 0, meaning infinite precision for construction.

Parameters:

- val: [BigInt](math_numeric_package_structs.md#struct-bigint) - The signed big integer value.
- scale: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The scale value.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.BigInt
import std.math.numeric.Decimal

main() {
    let bigInt = BigInt(24)
    let decimal = Decimal(bigInt, 4)
    println(decimal)
}
```

Output:

```text
0.0024
```

### init(Float16)

```cangjie
public init(val: Float16)
```

Function: Constructs a [Decimal](math_numeric_package_structs.md#struct-decimal) object from a 16-bit signed floating-point number. By default, it uses a precision value of 0, meaning infinite precision for construction.

> **Note:**
>
> Since some decimal fractions cannot be precisely represented by binary floating-point numbers, this constructor builds the [Decimal](math_numeric_package_structs.md#struct-decimal) object with the exact value. The input floating-point value may not match the final string representation of the constructed [Decimal](math_numeric_package_structs.md#struct-decimal) object.

Parameters:

- val: [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - A 16-bit signed binary floating-point number.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the input is `inf`, `-inf`, or `nan`.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main() {
    let float16: Float16 = 0.8
    let decimal = Decimal(float16)
    println(decimal)
}
```

Output:

```text
0.7998046875
```

### init(Float32)

```cangjie
public init(val: Float32)
```

Function: Constructs a [Decimal](math_numeric_package_structs.md#struct-decimal) object from a 32-bit signed floating-point number. By default, it uses a precision value of 0, meaning infinite precision for construction.

> **Note:**
>
> Since some decimal fractions cannot be precisely represented by binary floating-point numbers, this constructor builds the [Decimal](math_numeric_package_structs.md#struct-decimal) object with the exact value. The input floating-point value may not match the final string representation of the constructed [Decimal](math_numeric_package_structs.md#struct-decimal) object.

Parameters:

- val: [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - A 32-bit signed binary floating-point number.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the input is `inf`, `-inf`, or `nan`.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main() {
    let float32: Float32 = 0.8
    let decimal = Decimal(float32)
    println(decimal)
}
```

Output:

```text
0.800000011920928955078125
```

### init(Float64)

```cangjie
public init(val: Float64)
```

Function: Constructs a [Decimal](math_numeric_package_structs.md#struct-decimal) object from a 64-bit signed floating-point number. By default, it uses a precision value of 0, meaning infinite precision for construction.> **Note:**
>
> Due to the inability of some decimal fractions to be precisely represented by binary floating-point numbers, this constructor builds a [Decimal](math_numeric_package_structs.md#struct-decimal) object with exact values. The passed floating-point value may not match the final string representation of the constructed [Decimal](math_numeric_package_structs.md#struct-decimal) object.

Parameters:

- val: [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - A 64-bit signed binary floating-point number.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the input parameter is `inf`, `-inf`, or `nan`.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main() {
    let float64: Float64 = 0.8
    let decimal = Decimal(float64)
    println(decimal)
}
```

Execution Result:

```text
0.8000000000000000444089209850062616169452667236328125
```

### init(Int16)

```cangjie
public init(val: Int16)
```

Function: Constructs a [Decimal](math_numeric_package_structs.md#struct-decimal) structure using a 16-bit signed integer. By default, it is built with a precision value of 0, meaning infinite precision.

Parameters:

- val: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - A 16-bit signed integer.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main() {
    let int16: Int16 = 24
    let decimal = Decimal(int16)
    println(decimal)
}
```

Execution Result:

```text
24
```

### init(Int32)

```cangjie
public init(val: Int32)
```

Function: Constructs a [Decimal](math_numeric_package_structs.md#struct-decimal) object using a 32-bit signed integer. By default, it is built with a precision value of 0, meaning infinite precision.

Parameters:

- val: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - A 32-bit signed integer.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main() {
    let int32: Int32 = 24
    let decimal = Decimal(int32)
    println(decimal)
}
```

Execution Result:

```text
24
```

### init(Int64)

```cangjie
public init(val: Int64)
```

Function: Constructs a [Decimal](math_numeric_package_structs.md#struct-decimal) object using a 64-bit signed integer. By default, it is built with a precision value of 0, meaning infinite precision.

Parameters:

- val: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - A 64-bit signed integer.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main() {
    let int64: Int64 = 24
    let decimal = Decimal(int64)
    println(decimal)
}
```

Execution Result:

```text
24
```

### init(Int8)

```cangjie
public init(val: Int8)
```

Function: Constructs a [Decimal](math_numeric_package_structs.md#struct-decimal) structure using an 8-bit signed integer. By default, it is built with a precision value of 0, meaning infinite precision.

Parameters:

- val: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - An 8-bit signed integer.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main() {
    let int8: Int8 = 24
    let decimal = Decimal(int8)
    println(decimal)
}
```

Execution Result:

```text
24
```

### init(IntNative)

```cangjie
public init(val: IntNative)
```

Function: Constructs a [Decimal](math_numeric_package_structs.md#struct-decimal) object using a 32-bit or 64-bit (platform-dependent) signed integer. By default, it uses a precision value of 0, which means infinite precision during construction.

Parameters:

- val: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - A 32-bit or 64-bit signed integer.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main() {
    let intnative: IntNative = 24
    let decimal = Decimal(intnative)
    println(decimal)
}
```

Output:

```text
24
```

### init(String) <sup>(deprecated)<sup>

```cangjie
public init(val: String)
```

Function: Constructs a [Decimal](math_numeric_package_structs.md#struct-decimal) struct using a formatted string. By default, it uses a precision value of 0, which means infinite precision during construction. The string must conform to the following format: an optional sign (positive or negative) at the beginning, followed by a ValueString, and then an optional ExponentString:

[Decimal](math_numeric_package_structs.md#struct-decimal) string: (SignString)? ValueString (ExponentString)?

- SignString: + | -

- ValueString: IntegerPart.(FractionPart)? | .FractionPart | IntegerPart

  - IntegerPart: Digits

  - FractionPart: Digits

  - Digits: Digit | Digit Digits

    - Digit: '0' ~ '9'

- ExponentString: ExponentIndicator (SignString)? IntegerPart

  - ExponentIndicator: e | E

> **Note:**
>
> This method will be deprecated in future versions. Use [parse(String)](#static-func-parsestring) instead.

Parameters:

- val: [String](../../core/core_package_api/core_package_structs.md#struct-string) - A formatted string.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the input string does not conform to the specified format.
- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when the constructed value scale overflows.

### init(UInt16)

```cangjie
public init(val: UInt16)
```

Function: Constructs a [Decimal](math_numeric_package_structs.md#struct-decimal) object using a 16-bit unsigned integer. By default, it uses a precision value of 0, which means infinite precision during construction.

Parameters:

- val: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - A 16-bit unsigned integer.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main() {
    let uint16: UInt16 = 24
    let decimal = Decimal(uint16)
    println(decimal)
}
```

Output:

```text
24
```

### init(UInt32)

```cangjie
public init(val: UInt32)
```

Function: Constructs a [Decimal](math_numeric_package_structs.md#struct-decimal) object using a 32-bit unsigned integer. By default, it uses a precision value of 0, which means infinite precision during construction.

Parameters:

- val: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - A 32-bit unsigned integer.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main() {
    let uint32: UInt32 = 24
    let decimal = Decimal(uint32)
    println(decimal)
}
```

Output:

```text
24
```

### init(UInt64)

```cangjie
public init(val: UInt64)
```

Function: Constructs a [Decimal](math_numeric_package_structs.md#struct-decimal) object using a 64-bit unsigned integer. By default, it uses a precision value of 0, which means infinite precision during construction.

Parameters:

- val: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - A 64-bit unsigned integer.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main() {
    let uint64: UInt64 = 24
    let decimal = Decimal(uint64)
    println(decimal)
}
```

Execution result:

```text
24
```

### init(UInt8)

```cangjie
public init(val: UInt8)
```

Function: Constructs a [Decimal](math_numeric_package_structs.md#struct-decimal) object using an 8-bit unsigned integer. By default, it is constructed with precision value 0, indicating infinite precision.

Parameters:

- val: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 8-bit unsigned integer.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main() {
    let uint8: UInt8 = 24
    let decimal = Decimal(uint8)
    println(decimal)
}
```

Running result:

```text
24
```

### init(UIntNative)

```cangjie
public init(val: UIntNative)
```

Function: Constructs a [Decimal](math_numeric_package_structs.md#struct-decimal) object using a 32-bit or 64-bit (platform-dependent) unsigned integer. By default, it is constructed with precision value 0, indicating infinite precision.

Parameters:

- val: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 32-bit or 64-bit unsigned integer.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main() {
    let uintnative: UIntNative = 24
    let decimal = Decimal(uintnative)
    println(decimal)
}
```

Running result:

```text
24
```

### func compare(Decimal)

```cangjie
public func compare(d: Decimal): Ordering
```

Function: Compares the current object with the input [Decimal](math_numeric_package_structs.md#struct-decimal) object and returns the comparison result.

Parameters:

- d: [Decimal](math_numeric_package_structs.md#struct-decimal) - The [Decimal](math_numeric_package_structs.md#struct-decimal) object to be compared.

Return value:

- [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) - Returns the comparison result. If the current object is less than the input, returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).LT; if greater, returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).GT; otherwise, returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).EQ.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main(): Unit {
    let A = Decimal(-5)
    let B = Decimal(3)

    let C = A.compare(B)
    println(C)
}
```

Running result:

```text
Ordering.LT
```

### func divWithPrecision(Decimal, Int64, RoundingMode)

```cangjie
public func divWithPrecision(d: Decimal, precision: Int64, roundingMode!: RoundingMode = HalfEven): Decimal
```

Function: Division operation supporting custom precision and rounding mode. Divides by the input [Decimal](math_numeric_package_structs.md#struct-decimal) object and returns the result. If the result precision exceeds the specified `precision`, the division result is rounded according to the specified precision.

Parameters:

- d: [Decimal](math_numeric_package_structs.md#struct-decimal) - The [Decimal](math_numeric_package_structs.md#struct-decimal) divisor object.
- precision: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Precision value.
- roundingMode!: [RoundingMode](../../math/math_package_api/math_package_enums.md#enum-roundingmode) - Rounding rule.

Return value:

- [Decimal](math_numeric_package_structs.md#struct-decimal) - Returns a new [Decimal](math_numeric_package_structs.md#struct-decimal) object storing the division result.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-ArithmeticException) - Thrown when the divisor is 0.
- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when the division result exceeds the range [-(maxValue(precision) *(10 <sup>[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).MAX</sup>)), maxValue(precision)* (10 <sup>[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).MAX</sup>)].

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main(): Unit {
    let A = Decimal(2)
    let B = Decimal(3)
    let C = A.divWithPrecision(B, 0)
    println("C = ${C}")
}
```

Running result:

```text
C = 0.6666666666666666666666666666666667
```

### func divAndRem(Decimal) <sup>(deprecated)<sup>

```cangjie
public func divAndRem(d: Decimal): (BigInt, Decimal)
```

Function: Performs division to obtain quotient and remainder operations. Divides by the input [Decimal](math_numeric_package_structs.md#struct-decimal) object and returns the integer quotient value and remainder value. The result retains actual precision values.

> **Note:**
>
> This method will be deprecated in future versions. Use [divAndMod(Decimal)](#func-divandmoddecimal) instead.

Parameters:

- d: [Decimal](math_numeric_package_structs.md#struct-decimal) - The [Decimal](math_numeric_package_structs.md#struct-decimal) divisor object.

Return Value:

- ([BigInt](math_numeric_package_structs.md#struct-bigint), [Decimal](math_numeric_package_structs.md#struct-decimal)) - Returns a tuple object containing the integer quotient result and remainder result values.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the divisor is 0.
- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when the division result exceeds the range [-(maxValue(precision) *(10 <sup>[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).MAX</sup>)), maxValue(precision)* (10 <sup>[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).MAX</sup>)].

### func divAndMod(Decimal)

```cangjie
public func divAndMod(d: Decimal): (BigInt, Decimal)
```

Function: Performs division to obtain quotient and remainder operations. Divides by the input [Decimal](math_numeric_package_structs.md#struct-decimal) object and returns the integer quotient value and remainder value. The result retains actual precision values.

Parameters:

- d: [Decimal](math_numeric_package_structs.md#struct-decimal) - The [Decimal](math_numeric_package_structs.md#struct-decimal) divisor object.

Return Value:

- ([BigInt](math_numeric_package_structs.md#struct-bigint), [Decimal](math_numeric_package_structs.md#struct-decimal)) - Returns a tuple object containing the integer quotient result and remainder result values.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the divisor is 0.
- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when the division result exceeds the range [-(maxValue(precision) *(10 <sup>[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).MAX</sup>)), maxValue(precision)* (10 <sup>[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).MAX</sup>)].

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Retrieves the hash code of the current object.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Returns the hash code of the current object.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main() {
    let decimal = Decimal(24)
    let hashcode = decimal.hashCode()
    println(hashcode)
}
```

Output:

```text
744
```

### func isInteger()

```cangjie
public func isInteger(): Bool
```

Function: Determines whether the current [Decimal](math_numeric_package_structs.md#struct-decimal) object is an integer.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns the determination result of whether the current object is an integer. Returns true if the current object is an integer, otherwise returns false.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main(): Unit {
    let A = Decimal(100)
    println("${A}.isInteger() = ${A.isInteger()}")
}
```

Output:

```text
100.isInteger() = true
```

### func powWithPrecision(Int64, Int64, RoundingMode)

```cangjie
public func powWithPrecision(n: Int64, precision: Int64, roundingMode!: RoundingMode = RoundingMode.HalfEven): Decimal
```

Function: Performs exponentiation operation with customizable precision and rounding mode. Takes the current object as the base and the input [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) as the exponent. If the result exceeds the precision specified by `precision`, the exponentiation result is rounded according to the specified precision.

Parameters:

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The exponent value for the exponentiation operation.
- precision: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The precision value.
- roundingMode!: [RoundingMode](../../math/math_package_api/math_package_enums.md#enum-roundingmode) - The rounding rule.

Return Value:

- [Decimal](math_numeric_package_structs.md#struct-decimal) - Returns a new [Decimal](math_numeric_package_structs.md#struct-decimal) object containing the exponentiation result value.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when the exponentiation result scale value overflows.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.*
import std.math.*

main(): Unit {
    let A = Decimal(2.5)
    println("A.powWithPrecision(3, 0) = ${A.powWithPrecision(3, 0, roundingMode: HalfEven)}")
}
```

Output:

```text
A.powWithPrecision(3, 0) = 15.625
```

### func reScale(Int32, RoundingMode)

```cangjie
public func reScale(newScale: Int32, roundingMode!: RoundingMode = HalfEven): Decimal
```

Function: Adjusts the scale value of the [Decimal](math_numeric_package_structs.md#struct-decimal) object, allowing specification of rounding rules. Returns a new [Decimal](math_numeric_package_structs.md#struct-decimal) object with the adjusted scale.Parameters:

- newScale: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The new scale value.
- roundingMode!: [RoundingMode](../../math/math_package_api/math_package_enums.md#enum-roundingmode) - The rounding rule.

Return Value:

- [Decimal](math_numeric_package_structs.md#struct-decimal) - A new [Decimal](math_numeric_package_structs.md#struct-decimal) object with the new scale value.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main(): Unit {
    let A = Decimal(1.234568)
    println("A.reScale(3) = ${A.reScale(3)}")
}
```

Execution Result:

```text
A.reScale(3) = 1.235
```

### func removeTrailingZeros()

```cangjie
public func removeTrailingZeros(): Decimal
```

Function: Removes trailing zeros from the current [Decimal](math_numeric_package_structs.md#struct-decimal) object without changing its numerical value.

Return Value:

- [Decimal](math_numeric_package_structs.md#struct-decimal) - A new [Decimal](math_numeric_package_structs.md#struct-decimal) object without trailing zeros.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main(): Unit {
    let A = Decimal(1.00)
    println("A.removeTrailingZeros() = ${A.removeTrailingZeros()}")
}
```

Execution Result:

```text
A.removeTrailingZeros() = 1
```

### func roundWithPrecision(Int64, RoundingMode)

```cangjie
public func roundWithPrecision(precision: Int64, roundingMode!: RoundingMode = RoundingMode.HalfEven): Decimal
```

Function: Performs a rounding operation on the current [Decimal](math_numeric_package_structs.md#struct-decimal) object according to the specified precision and rounding rule.

Parameters:

- precision: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The precision value.
- roundingMode!: [RoundingMode](../../math/math_package_api/math_package_enums.md#enum-roundingmode) - The rounding rule.

Return Value:

- [Decimal](math_numeric_package_structs.md#struct-decimal) - A new [Decimal](math_numeric_package_structs.md#struct-decimal) object generated by the rounding operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when the scale value of the rounding operation result overflows.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal
import std.math.*

main(): Unit {
    let A = Decimal(1.0)
    println("A.roundWithPrecision(1.0) = ${A.roundWithPrecision(0, roundingMode: HalfEven)}")
    let B = Decimal(0.1f16).roundWithPrecision(5, roundingMode: Up)
    println("B = ${B}")
}
```

Execution Result:

```text
A.roundWithPrecision(1.0) = 1
B = 0.099976
```

### func scaleUnit()

```cangjie
public func scaleUnit(): Decimal
```

Function: Returns the scale unit for the current [Decimal](math_numeric_package_structs.md#struct-decimal) object, which is a [Decimal](math_numeric_package_structs.md#struct-decimal) object with a numerical value of 1 and the same scale as the current object.

Return Value:

- [Decimal](math_numeric_package_structs.md#struct-decimal) - The scale unit [Decimal](math_numeric_package_structs.md#struct-decimal) object.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main(): Unit {
    let A = Decimal(100)
    println("A.scaleUnit() = ${A.scaleUnit()}")
}
```

Execution Result:

```text
A.scaleUnit() = 1
```

### func shiftPoint(Int32)

```cangjie
public func shiftPoint(n: Int32): Decimal
```

Function: Moves the decimal point of the current [Decimal](math_numeric_package_structs.md#struct-decimal) object by `abs(n)` positions and returns the resulting object. When n is positive, the decimal point is moved to the left; when n is negative, it is moved to the right; when n is zero, the current object is returned.

Parameters:

- n: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Specifies the number of positions and direction to move the decimal point.

Return Value:

- [Decimal](math_numeric_package_structs.md#struct-decimal) - A new [Decimal](math_numeric_package_structs.md#struct-decimal) object generated by moving the decimal point of the current object by the specified number of positions.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main(): Unit {
    let A = Decimal(25)
    println("A.shiftPoint(1) = ${A.shiftPoint(1)}")
}
```

Execution Result:

```text
A.shiftPoint(1) = 2.5
```

### func sqrtWithPrecision(Int64, RoundingMode)

```cangjie
public func sqrtWithPrecision(precision: Int64, roundingMode!: RoundingMode = RoundingMode.HalfEven): Decimal
```

Function: Square root operation with customizable precision and rounding mode. Returns the square root of the current object. If the result exceeds the specified `precision`, it will be rounded according to the given precision.

Parameters:

- precision: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Precision value.
- roundingMode!: [RoundingMode](../../math/math_package_api/math_package_enums.md#enum-roundingmode) - Rounding rule.

Return Value:

- [Decimal](math_numeric_package_structs.md#struct-decimal) - Returns the arithmetic square root of the input [Decimal](math_numeric_package_structs.md#struct-decimal), rounded according to the specified precision and rounding mode.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the object for which the square root is being calculated is negative.
- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when the scale value of the square root operation result overflows.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.*

main() {
    let n: Decimal = Decimal.parse("2")
    let s = n.sqrtWithPrecision(2)
    println(s)
}
```

Execution Result:

```text
1.4
```

### func toBigInt()

```cangjie
public func toBigInt(): BigInt
```

Function: Converts the current [Decimal](math_numeric_package_structs.md#struct-decimal) object to [BigInt](math_numeric_package_structs.md#struct-bigint) type.

Return Value:

- [BigInt](math_numeric_package_structs.md#struct-bigint) - The converted [BigInt](math_numeric_package_structs.md#struct-bigint) value.

### func toEngString()

```cangjie
public func toEngString(): String
```

Function: Prints the [Decimal](math_numeric_package_structs.md#struct-decimal) object in engineering notation, where the exponent is a multiple of 3. When the value is less than 0, it starts with "-" followed by decimal digits. When the value is greater than or equal to 0, it directly prints the digits without an additional "+". The same rules apply when the exponent is less than 0.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The [Decimal](math_numeric_package_structs.md#struct-decimal) string in engineering notation.

### func toSciString()

```cangjie
public func toSciString(): String
```

Function: Prints the [Decimal](math_numeric_package_structs.md#struct-decimal) object in scientific notation. When the value is less than 0, it starts with "-" followed by decimal digits. When the value is greater than or equal to 0, it directly prints the digits without an additional "+". The same rules apply when the exponent is less than 0.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The [Decimal](math_numeric_package_structs.md#struct-decimal) string in scientific notation.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main(): Unit {
    let A = Decimal(6.25)
    println("A.toFloat16() = ${A.toFloat16()}")
    println("A.toFloat32() = ${A.toFloat32()}")
    println("A.toFloat64() = ${A.toFloat64()}")
    println("A.toBigInt() = ${A.toBigInt()}")
    println("A.toEngString() = ${A.toEngString()}")
    println("A.toSciString() = ${A.toSciString()}")
}
```

Execution Result:

```text
A.toFloat16() = 6.250000
A.toFloat32() = 6.250000
A.toFloat64() = 6.250000
A.toBigInt() = 6
A.toEngString() = 6.25E0
A.toSciString() = 6.25E0
```

### func toFloat16()

```cangjie
public func toFloat16(): Float16
```

Function: Converts the current [Decimal](math_numeric_package_structs.md#struct-decimal) object to [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) type.

Return Value:

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - The converted [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) value. On overflow, returns `inf` if the current value is positive, or `-inf` if negative.

### func toFloat32()

```cangjie
public func toFloat32(): Float32
```

Function: Converts the current [Decimal](math_numeric_package_structs.md#struct-decimal) object to [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) type.

Return Value:

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - The converted [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) value. On overflow, returns `inf` if the current value is positive, or `-inf` if negative.

### func toFloat64()

```cangjie
public func toFloat64(): Float64
```

Function: Converts the current [Decimal](math_numeric_package_structs.md#struct-decimal) object to [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) type.

Return Value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The converted [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) value. On overflow, returns `inf` if the current value is positive, or `-inf` if negative.

### func toInt16(OverflowStrategy)

```cangjie
public func toInt16(overflowHandling!: OverflowStrategy = Throwing): Int16
```

Function: Converts the current [Decimal](math_numeric_package_structs.md#struct-decimal) object to an [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) type, supporting customizable overflow strategies.

Parameters:

- overflowHandling!: [OverflowStrategy](math_numeric_package_enums.md#enum-overflowstrategy) - The overflow strategy for conversion.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The converted [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) value.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when no overflow strategy is specified or when the overflow strategy is `throwing` and overflow occurs during conversion.

### func toInt32(OverflowStrategy)

```cangjie
public func toInt32(overflowHandling!: OverflowStrategy = Throwing): Int32
```

Function: Converts the current [Decimal](math_numeric_package_structs.md#struct-decimal) object to an [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) type, supporting customizable overflow strategies.

Parameters:

- overflowHandling!: [OverflowStrategy](math_numeric_package_enums.md#enum-overflowstrategy) - The overflow strategy for conversion.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The converted [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) value.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when no overflow strategy is specified or when the overflow strategy is `throwing` and overflow occurs during conversion.

### func toInt64(OverflowStrategy)

```cangjie
public func toInt64(overflowHandling!: OverflowStrategy = Throwing): Int64
```

Function: Converts the current [Decimal](math_numeric_package_structs.md#struct-decimal) object to an [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) type, supporting customizable overflow strategies.

Parameters:

- overflowHandling!: [OverflowStrategy](math_numeric_package_enums.md#enum-overflowstrategy) - The overflow strategy for conversion.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The converted [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) value.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when no overflow strategy is specified or when the overflow strategy is `throwing` and overflow occurs during conversion.

### func toInt8(OverflowStrategy)

```cangjie
public func toInt8(overflowHandling!: OverflowStrategy = Throwing): Int8
```

Function: Converts the current [Decimal](math_numeric_package_structs.md#struct-decimal) object to an [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) type, supporting customizable overflow strategies.

Parameters:

- overflowHandling!: [OverflowStrategy](math_numeric_package_enums.md#enum-overflowstrategy) - The overflow strategy for conversion.

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The converted [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) value.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when no overflow strategy is specified or when the overflow strategy is `throwing` and overflow occurs during conversion.

### func toIntNative(OverflowStrategy)

```cangjie
public func toIntNative(overflowHandling!: OverflowStrategy = Throwing): IntNative
```

Function: Converts the current [Decimal](math_numeric_package_structs.md#struct-decimal) object to an [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) type, supporting customizable overflow strategies.

Parameters:

- overflowHandling!: [OverflowStrategy](math_numeric_package_enums.md#enum-overflowstrategy) - The overflow strategy for conversion.

Return Value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - The converted [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) value.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when no overflow strategy is specified or when the overflow strategy is `throwing` and overflow occurs during conversion.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main(): Unit {
    let A = Decimal(6.25)
    println("A.toInt8() = ${A.toInt8()}")
    println("A.toInt16() = ${A.toInt16()}")
    println("A.toInt32() = ${A.toInt32()}")
    println("A.toInt64() = ${A.toInt64()}")
    println("A.toIntNative() = ${A.toIntNative()}")
}
```

Execution Result:

```text
A.toInt8() = 6
A.toInt16() = 6
A.toInt32() = 6
A.toInt64() = 6
A.toIntNative() = 6
```

### func toString()

```cangjie
public func toString(): String
```

Function: Prints the [Decimal](math_numeric_package_structs.md#struct-decimal) object in non-exponential form. For values less than 0, it starts with "-" followed by decimal digits. For values greater than or equal to 0, it directly prints the digits without an additional "+".

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The [Decimal](math_numeric_package_structs.md#struct-decimal) string in non-exponential form.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main(): Unit {
    let A = Decimal(-5)
    let B = Decimal(3 ** 5)

    println("A.hashCode() = ${A.hashCode()}")
    println("B.toString() = ${B.toString()}")
}
```

Execution Result:

```text
A.hashCode() = 155
B.toString() = 243
```

### func toUInt16(OverflowStrategy)

```cangjie
public func toUInt16(overflowHandling!: OverflowStrategy = Throwing): UInt16
```

Function: Converts the current [Decimal](math_numeric_package_structs.md#struct-decimal) object to [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) type, supporting customizable overflow strategies.

Parameters:

- overflowHandling!: [OverflowStrategy](math_numeric_package_enums.md#enum-overflowstrategy) - Overflow handling strategy for conversion.

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The converted [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) value.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when no overflow strategy is specified or the overflow strategy is `throwing` and overflow occurs during conversion.

### func toUInt32(OverflowStrategy)

```cangjie
public func toUInt32(overflowHandling!: OverflowStrategy = Throwing): UInt32
```

Function: Converts the current [Decimal](math_numeric_package_structs.md#struct-decimal) object to [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) type, supporting customizable overflow strategies.

Parameters:

- overflowHandling!: [OverflowStrategy](math_numeric_package_enums.md#enum-overflowstrategy) - Overflow handling strategy for conversion.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The converted [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) value.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when no overflow strategy is specified or the overflow strategy is `throwing` and overflow occurs during conversion.

### func toUInt64(OverflowStrategy)

```cangjie
public func toUInt64(overflowHandling!: OverflowStrategy = Throwing): UInt64
```

Function: Converts the current [Decimal](math_numeric_package_structs.md#struct-decimal) object to [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) type, supporting customizable overflow strategies.

Parameters:

- overflowHandling!: [OverflowStrategy](math_numeric_package_enums.md#enum-overflowstrategy) - Overflow handling strategy for conversion.

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The converted [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) value.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when no overflow strategy is specified or the overflow strategy is `throwing` and overflow occurs during conversion.

### func toUInt8(OverflowStrategy)

```cangjie
public func toUInt8(overflowHandling!: OverflowStrategy = Throwing): UInt8
```

Function: Converts the current [Decimal](math_numeric_package_structs.md#struct-decimal) object to [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) type, supporting customizable overflow strategies.

Parameters:

- overflowHandling!: [OverflowStrategy](math_numeric_package_enums.md#enum-overflowstrategy) - Overflow handling strategy for conversion.

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The converted [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) value.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when no overflow strategy is specified or the overflow strategy is `throwing` and overflow occurs during conversion.

### func toUIntNative(OverflowStrategy)

```cangjie
public func toUIntNative(overflowHandling!: OverflowStrategy = Throwing): UIntNative
```

Function: Converts the current [Decimal](math_numeric_package_structs.md#struct-decimal) object to [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) type, supporting customizable overflow strategies.

Parameters:

- overflowHandling!: [OverflowStrategy](math_numeric_package_enums.md#enum-overflowstrategy) - Overflow handling strategy for conversion.

Return Value:

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - The converted [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) value.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when no overflow strategy is specified or the overflow strategy is `throwing` and overflow occurs during conversion.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main(): Unit {
    let A = Decimal(6.25)
    println("A.toUInt8() = ${A.toUInt8()}")
    println("A.toUInt16() = ${A.toUInt16()}")
    println("A.toUInt32() = ${A.toUInt32()}")
    println("A.toUInt64() = ${A.toUInt64()}")
    println("A.toUIntNative() = ${A.toUIntNative()}")
}
```

Execution Result:

```text
A.toUInt8() = 6
A.toUInt16() = 6
A.toUInt32() = 6
A.toUInt64() = 6
A.toUIntNative() = 6
```

### operator func !=(Decimal)

```cangjie
public operator func !=(d: Decimal): Bool
```

Function: Inequality comparison operation, overloading the inequality operator to determine whether the input [Decimal](math_numeric_package_structs.md#struct-decimal) object is not equal to the current object, returning the comparison result.

Parameters:

- d: [Decimal](math_numeric_package_structs.md#struct-decimal) - The [Decimal](math_numeric_package_structs.md#struct-decimal) object to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns the result of the inequality comparison. Returns true if the current object is not equal to the input parameter, otherwise returns false.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main(): Unit {
    let A = Decimal(-5)
    let B = Decimal(3)

    println("-A = ${-A}")
    println("A <= B = ${A <= B}")
    println("A != B = ${A != B}")
}
```

Execution result:

```text
-A = 5
A <= B = true
A != B = true
```

### operator func *(Decimal)

```cangjie
public operator func *(d: Decimal): Decimal
```

Function: Multiplication operation, overloading the multiplication operator to multiply by the input [Decimal](math_numeric_package_structs.md#struct-decimal) object, returning the result value. Preserves the actual precision of the multiplication result.

Parameters:

- d: [Decimal](math_numeric_package_structs.md#struct-decimal) - The [Decimal](math_numeric_package_structs.md#struct-decimal) multiplier object.

Return value:

- [Decimal](math_numeric_package_structs.md#struct-decimal) - Creates a new [Decimal](math_numeric_package_structs.md#struct-decimal) object to store the multiplication result.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when the sum of the scale values of the two multipliers overflows.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main(): Unit {
    let A = Decimal(2)
    let B = Decimal(3)
    let C = A * B
    println("C = ${C}")
}
```

Execution result:

```text
C = 6
```

### operator func **(Int64)

```cangjie
public operator func **(n: Int64): Decimal
```

Function: Exponentiation operation, overloading the exponentiation operator to compute the result of raising the current object (as base) to the power of the input [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) exponent, where the exponent is the integer part of the input [Decimal](math_numeric_package_structs.md#struct-decimal) object.

> **Note:**
>
> When the exponent is negative and the result is an infinite decimal, IEEE 754-2019 decimal128 rounding is applied by default.

Parameters:

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The exponent value for the exponentiation operation.

Return value:

- [Decimal](math_numeric_package_structs.md#struct-decimal) - Creates a new [Decimal](math_numeric_package_structs.md#struct-decimal) object to store the exponentiation result.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when the scale value of the exponentiation result overflows.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main(): Unit {
    let A = Decimal(2.5)
    println("A ** 3 = ${A ** 3}")
}
```

Execution result:

```text
A ** 3 = 15.625
```

### operator func +(Decimal)

```cangjie
public operator func +(d: Decimal): Decimal
```

Function: Addition operation, overloading the addition operator to add the input [Decimal](math_numeric_package_structs.md#struct-decimal) object, returning the result value. Preserves the actual precision of the result.

Parameters:

- d: [Decimal](math_numeric_package_structs.md#struct-decimal) - The [Decimal](math_numeric_package_structs.md#struct-decimal) addend object.

Return value:

- [Decimal](math_numeric_package_structs.md#struct-decimal) - Creates a new [Decimal](math_numeric_package_structs.md#struct-decimal) object to store the addition result.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when the difference between the scale values of the two addends overflows.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main(): Unit {
    let A = Decimal(2)
    let B = Decimal(3)
    let C = A + B
    println("C = ${C}")
}
```

Execution result:

```text
C = 5
```

### operator func -()

```cangjie
public operator func -(): Decimal
```

Function: Negation operation, overloading the unary minus operator to negate the current [Decimal](math_numeric_package_structs.md#struct-decimal) object, returning the result value. Preserves the actual precision of the negation result.

Return value:

- [Decimal](math_numeric_package_structs.md#struct-decimal) - Creates a new [Decimal](math_numeric_package_structs.md#struct-decimal) object to store the negation result.

### operator func -(Decimal)

```cangjie
public operator func -(d: Decimal): Decimal
```

Function: Subtraction operation, overloads the subtraction operator to subtract the input [Decimal](math_numeric_package_structs.md#struct-decimal) object and returns the result. Preserves the actual precision value of the subtraction result.

Parameters:

- d: [Decimal](math_numeric_package_structs.md#struct-decimal) - The subtrahend [Decimal](math_numeric_package_structs.md#struct-decimal) object.

Return Value:

- [Decimal](math_numeric_package_structs.md#struct-decimal) - Returns a new [Decimal](math_numeric_package_structs.md#struct-decimal) object storing the result of the subtraction operation.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when the subtraction of the minuend and subtrahend scale values overflows.

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal

main(): Unit {
    let A = Decimal(2)
    let B = Decimal(3)
    let C = A - B
    println("C = ${C}")
}
```

Execution Result:

```text
C = -1
```

### operator func <(Decimal)

```cangjie
public operator func <(d: Decimal): Bool
```

Function: Less-than comparison operation, overloads the less-than operator to determine if the input [Decimal](math_numeric_package_structs.md#struct-decimal) object is less than the current object, returning the comparison result.

Parameters:

- d: [Decimal](math_numeric_package_structs.md#struct-decimal) - The [Decimal](math_numeric_package_structs.md#struct-decimal) object to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns the result of the less-than comparison. Returns true if the current object is less than the input, otherwise returns false.

### operator func <=(Decimal)

```cangjie
public operator func <=(d: Decimal): Bool
```

Function: Less-than-or-equal comparison operation, overloads the less-than-or-equal operator to determine if the input [Decimal](math_numeric_package_structs.md#struct-decimal) object is less than or equal to the current object, returning the comparison result.

Parameters:

- d: [Decimal](math_numeric_package_structs.md#struct-decimal) - The [Decimal](math_numeric_package_structs.md#struct-decimal) object to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns the result of the less-than-or-equal comparison. Returns true if the current object is less than or equal to the input, otherwise returns false.

### operator func ==(Decimal)

```cangjie
public operator func ==(d: Decimal): Bool
```

Function: Equality comparison operation, overloads the equality operator to determine if the input [Decimal](math_numeric_package_structs.md#struct-decimal) object is equal to the current object, returning the comparison result.

Parameters:

- d: [Decimal](math_numeric_package_structs.md#struct-decimal) - The [Decimal](math_numeric_package_structs.md#struct-decimal) object to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns the result of the equality comparison. Returns true if the current object is equal to the input, otherwise returns false.

### operator func >(Decimal)

```cangjie
public operator func >(d: Decimal): Bool
```

Function: Greater-than comparison operation, overloads the greater-than operator to determine if the input [Decimal](math_numeric_package_structs.md#struct-decimal) object is greater than the current object, returning the comparison result.

Parameters:

- d: [Decimal](math_numeric_package_structs.md#struct-decimal) - The [Decimal](math_numeric_package_structs.md#struct-decimal) object to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns the result of the greater-than comparison. Returns true if the current object is greater than the input, otherwise returns false.

### operator func >=(Decimal)

```cangjie
public operator func >=(d: Decimal): Bool
```

Function: Greater-than-or-equal comparison operation, overloads the greater-than-or-equal operator to determine if the input [Decimal](math_numeric_package_structs.md#struct-decimal) object is greater than or equal to the current object, returning the comparison result.

Parameters:

- d: [Decimal](math_numeric_package_structs.md#struct-decimal) - The [Decimal](math_numeric_package_structs.md#struct-decimal) object to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns the result of the greater-than-or-equal comparison. Returns true if the current object is greater than or equal to the input, otherwise returns false.

### operator func /(Decimal)

```cangjie
public operator func /(d: Decimal): Decimal
```

Function: Division operation, overloads the division operator to divide by the input [Decimal](math_numeric_package_structs.md#struct-decimal) object and returns the result.

> **Note:**
>
> For scenarios where the result is an infinite decimal, the default behavior is to round the result using IEEE 754-2019 decimal128.

Parameters:

- d: [Decimal](math_numeric_package_structs.md#struct-decimal) - The divisor [Decimal](math_numeric_package_structs.md#struct-decimal) object.

Return Value:

- [Decimal](math_numeric_package_structs.md#struct-decimal) - Returns a new [Decimal](math_numeric_package_structs.md#struct-decimal) object storing the result of the division operation.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the divisor is 0.
- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when the division result exceeds the range [-(maxValue(precision) *(10 <sup>[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).MAX</sup>)), maxValue(precision)* (10 <sup>[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).MAX</sup>)].

Example:
<!-- verify -->
```cangjie
import std.math.numeric.Decimal
main(): Unit {
    let A = Decimal(2)
    let B = Decimal(3)
    let C = A / B
    println("C = ${C}")
}
```

Execution Result:

```text
C = 0.6666666666666666666666666666666667
```

### extend Decimal <: Formattable

```cangjie
extend Decimal <: Formattable
```

Function: Extends the [Decimal](#struct-decimal) type with the [Formattable](../../convert/convert_package_api/convert_package_interfaces.md#interface-formattable) interface to enable formatting [Decimal](#struct-decimal) instances into strings.

Parent Types:

- [Formattable](../../convert/convert_package_api/convert_package_interfaces.md#interface-formattable)

#### func format(String)

```cangjie
public func format(fmt: String): String
```

Function: Formats the current [Decimal](#struct-decimal) instance into a string according to the specified format parameters.

Parameters:

- fmt: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Formatting parameters.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The formatted string representation of the current [Decimal](#struct-decimal) instance.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the format parameter `fmt` is invalid.

### extend Decimal <: Number\<Decimal>

```cangjie
extend Decimal <: Number<Decimal> {}
```

Function: Extends the [Decimal](#struct-decimal) type with the [Number\<T>](../../math/math_package_api/math_package_interfaces.md#interface-numbert) interface.

Parent Types:

- [Number](../../math/math_package_api/math_package_interfaces.md#interface-numbert)\<[Decimal](#struct-decimal)>

### extend Decimal <: Parsable\<Decimal>

```cangjie
extend Decimal <: Parsable<Decimal>
```

Function: This extension primarily implements operations for converting string literals of the [Decimal](#struct-decimal) type into [Decimal](#struct-decimal) struct instances.

Parent Types:

- [Parsable](../../convert/convert_package_api/convert_package_interfaces.md#interface-parsablet)\<[Decimal](#struct-decimal)>

#### static func parse(String)

```cangjie
public static func parse(value: String): Decimal
```

Function: Constructs a [Decimal](math_numeric_package_structs.md#struct-decimal) struct from a formatted string. By default, it uses a precision value of 0 (infinite precision). The string must adhere to the following format: an optional sign (positive or negative) at the beginning, followed by a ValueString, and an optional ExponentString:

[Decimal](math_numeric_package_structs.md#struct-decimal) String: SignString? ValueString ExponentString?

- SignString: + | -

- ValueString: IntegerPart.(FractionPart)? | .FractionPart | IntegerPart

  - IntegerPart: Digits

  - FractionPart: Digits

  - Digits: Digit | Digit Digits

    - Digit: '0' ~ '9'

- ExponentString: ExponentIndicator (SignString)? IntegerPart

  - ExponentIndicator: e | E

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The formatted string.

Return Value:

- [Decimal](math_numeric_package_structs.md#struct-decimal) - The parsed [Decimal](math_numeric_package_structs.md#struct-decimal) struct.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the input string does not conform to the specified format.
- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when the scale of the constructed value overflows.

#### static func tryParse(String)

```cangjie
public static func tryParse(value: String): ?Decimal
```

Function: Attempts to construct a [Decimal](math_numeric_package_structs.md#struct-decimal) struct from a formatted string. By default, it uses a precision value of 0 (infinite precision). The string must adhere to the following format: an optional sign (positive or negative) at the beginning, followed by a ValueString, and an optional ExponentString:

[Decimal](math_numeric_package_structs.md#struct-decimal) String: SignString? ValueString ExponentString?

- SignString: + | -

- ValueString: IntegerPart.(FractionPart)? | .FractionPart | IntegerPart

  - IntegerPart: Digits

  - FractionPart: Digits

  - Digits: Digit | Digit Digits

    - Digit: '0' ~ '9'

- ExponentString: ExponentIndicator (SignString)? IntegerPart

  - ExponentIndicator: e | E

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The formatted string.

Return Value:

- ?[Decimal](math_numeric_package_structs.md#struct-decimal) - The parsed [Decimal](math_numeric_package_structs.md#struct-decimal) struct, or `None` if parsing fails.
