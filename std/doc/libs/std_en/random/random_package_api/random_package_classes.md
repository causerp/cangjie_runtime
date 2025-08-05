# Class

## class Random

```cangjie
public class Random {
    public init()
    public init(seed: UInt64)
}
```

Functionality: Provides capabilities for generating pseudo-random numbers.

Example:
<!-- verify -->
```cangjie
import std.random.*

main() {
    /* Create a Random object with seed to obtain random values */
    let m: Random = Random(3)
    let b: Bool = m.nextBool()
    let c: Int8 = m.nextInt8()
    print("b=${b is Bool},") /* The object can also be of Bool type */
    println("c=${c is Int8}")
    return 0
}
```

Execution Result:

```text
b=true,c=true
```

### prop seed

```cangjie
public prop seed: UInt64
```

Functionality: Gets the random number seed.

Type: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)

### init()

```cangjie
public init()
```

Functionality: Default parameterless constructor creates a new [Random](random_package_classes.md#class-random) object.

### init(UInt64)

```cangjie
public init(seed: UInt64)
```

Functionality: Creates a new [Random](random_package_classes.md#class-random) object using a random number seed.

Parameters:

- seed: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The random number seed. Identical seeds will generate identical pseudo-random number sequences.

### func next(UInt64) <sup>(deprecated)</sup>

```cangjie
public func next(bits: UInt64): UInt64
```

Functionality: Generates a random integer with user-specified bit length.

> **Note:**
>
> This method will be deprecated in future versions. Use [nextBits](#func-nextbitsuint64) instead.

Parameters:

- bits: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits for the pseudo-random number (range: (0, 64]).

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - A pseudo-random number with the specified bit length.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if `bits` equals 0 or exceeds 64 (beyond the maximum length of [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)).

### func nextBits(UInt64)

```cangjie
public func nextBits(bits: UInt64): UInt64
```

Functionality: Generates a random integer with specified bit length.

Parameters:

- bits: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - Number of bits for the pseudo-random number (range: (0, 64]).

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - A pseudo-random number with the specified bit length.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if `bits` equals 0 or exceeds 64 (beyond the maximum length of [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)).

### func nextBool()

```cangjie
public func nextBool(): Bool
```

Functionality: Gets a pseudo-random boolean value.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - A pseudo-random boolean value.

Example:
<!-- verify -->
```cangjie
import std.random.*

main() {
    let m: Random = Random()
    let n: Bool = m.nextBool()
    println("n=${n is Bool}")
    return 0
}
```

Execution Result:

```text
n=true
```

### func nextFloat16()

```cangjie
public func nextFloat16(): Float16
```

Functionality: Gets a [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) type pseudo-random number in range [0.0, 1.0).

Return Value:- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - A [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) type pseudo-random number.

Example:
<!-- verify -->
```cangjie
import std.random.*

main() {
    let m: Random = Random()
    let n: Float16 = m.nextFloat16()
    if (n is Float16) {
        println("n is Float16")
    }
    return 0
}
```

Execution Result:

```text
n is Float16
```

### func nextFloat32()

```cangjie
public func nextFloat32(): Float32
```

Functionality: Generates a [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) type pseudo-random number in the range [0.0, 1.0).

Return Value:

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - A [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) type pseudo-random number.

Example:
<!-- verify -->
```cangjie
import std.random.*

main() {
    let m: Random = Random()
    let n: Float32 = m.nextFloat32()
    if (n is Float32) {
        println("n is Float32")
    }
    return 0
}
```

Execution Result:

```text
n is Float32
```

### func nextFloat64()

```cangjie
public func nextFloat64(): Float64
```

Functionality: Generates a [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) type pseudo-random number in the range [0.0, 1.0).

Return Value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - A [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) type pseudo-random number.

Example:
<!-- verify -->
```cangjie
import std.random.*

main() {
    let m: Random = Random()
    let n: Float64 = m.nextFloat64()
    if (n is Float64) {
        println("n is Float64")
    }
    return 0
}
```

Execution Result:

```text
n is Float64
```

### func nextGaussianFloat16(Float16, Float16)

```cangjie
public func nextGaussianFloat16(mean!: Float16 = 0.0, sigma!: Float16 = 1.0): Float16
```

Functionality: Generates a [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) type random number following Gaussian distribution with specified mean and standard deviation.

By default, returns a [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) type random number following standard normal distribution (mean=0.0, standard deviation=1.0). The mean parameter determines the distribution's central location, while sigma controls the distribution's spread.

Parameters:

- mean!: [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - Mean value (default: 0.0).
- sigma!: [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - Standard deviation (default: 1.0).

Return Value:

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - A [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) type random number.

Example:
<!-- verify -->
```cangjie
import std.random.*

main() {
    let m: Random = Random()
    let n: Float16 = m.nextGaussianFloat16(mean: 0.0, sigma: 1.0)
    if (n is Float16) {
        println("n is Float16")
    }
    return 0
}
```

Execution Result:

```text
n is Float16
```

### func nextGaussianFloat32(Float32, Float32)

```cangjie
public func nextGaussianFloat32(mean!: Float32 = 0.0, sigma!: Float32 = 1.0): Float32
```

Functionality: Generates a [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) type random number following Gaussian distribution with specified mean and standard deviation.

By default, returns a [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) type random number following standard normal distribution (mean=0.0, standard deviation=1.0). The mean parameter determines the distribution's central location, while sigma controls the distribution's spread.

Parameters:

- mean!: [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - Mean value (default: 0.0).
- sigma!: [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - Standard deviation (default: 1.0).

Return Value:

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - A [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) type random number.

Example:
<!-- verify -->
```cangjie
import std.random.*

main() {
    let m: Random = Random()
    let n: Float32 = m.nextGaussianFloat32(mean: 0.0, sigma: 1.0)
    if (n is Float32) {
        println("n is Float32")
    }
    return 0
}
```

Execution Result:

```text
n is Float32
```

### func nextGaussianFloat64(Float64, Float64)

```cangjie
public func nextGaussianFloat64(mean!: Float64 = 0.0, sigma!: Float64 = 1.0): Float64
```

Function: Obtains a [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) type random number following a Gaussian distribution with specified mean and standard deviation.

By default, obtains a [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) type random number following a Gaussian distribution with mean 0.0 and standard deviation 1.0. The mean represents the expected value (location parameter) that determines the distribution's position, while the standard deviation (scale parameter) determines the distribution's amplitude.

Parameters:

- mean!: [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - Mean value, default 0.0.
- sigma!: [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - Standard deviation, default 1.0.

Return Value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - A [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) type random number.

Example:
<!-- verify -->
```cangjie
import std.random.*

main() {
    let m: Random = Random()
    let n: Float64 = m.nextGaussianFloat64(mean: 0.0, sigma: 1.0)
    if (n is Float64) {
        println("n is Float64")
    }
    return 0
}
```

Execution Result:

```text
n is Float64
```

### func nextInt16()

```cangjie
public func nextInt16(): Int16
```

Function: Obtains a pseudo-random number of type [Int16](../../core/core_package_api/core_package_intrinsics.md#int16).

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - A pseudo-random number of type [Int16](../../core/core_package_api/core_package_intrinsics.md#int16).

Example:
<!-- verify -->
```cangjie
import std.random.*

main() {
    let m: Random = Random()
    let n: Int16 = m.nextInt16()
    if (n is Int16) {
        println("n is Int16")
    }
    return 0
}
```

Execution Result:

```text
n is Int16
```

### func nextInt16(Int16)

```cangjie
public func nextInt16(upper: Int16): Int16
```

Function: Obtains a pseudo-random number of type [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) within the range [0, `upper`).

Parameters:

- upper: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - Upper bound (exclusive) for the generated pseudo-random number, valid range (0, [Int16](../../core/core_package_api/core_package_intrinsics.md#int16).Max].

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - A pseudo-random number of type [Int16](../../core/core_package_api/core_package_intrinsics.md#int16).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if `upper` is less than or equal to 0.

Example:
<!-- verify -->
```cangjie
import std.random.*

main() {
    let m: Random = Random()
    let n: Int16 = m.nextInt16(5)
    if (n is Int16) {
        println("n is Int16")
    }
    try {
        let p: Int16 = m.nextInt16(-1)
        println(p)
    } catch (e: IllegalArgumentException) {
        println("Parameter exception: upper is less than or equal to 0")
    }
    return 0
}
```

Execution Result:

```text
n is Int16
Parameter exception: upper is less than or equal to 0
```

### func nextInt32()

```cangjie
public func nextInt32(): Int32
```

Function: Obtains a pseudo-random number of type [Int32](../../core/core_package_api/core_package_intrinsics.md#int32).

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - A pseudo-random number of type [Int32](../../core/core_package_api/core_package_intrinsics.md#int32).

Example:
<!-- verify -->
```cangjie
import std.random.*

main() {
    let m: Random = Random()
    let n: Int32 = m.nextInt32()
    if (n is Int32) {
        println("n is Int32")
    }
    return 0
}
```

Execution Result:

```text
n is Int32
```

### func nextInt32(Int32)

```cangjie
public func nextInt32(upper: Int32): Int32
```

Function: Obtains a pseudo-random number of type [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) within the range [0, `upper`).

Parameters:

- upper: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Upper bound (exclusive) for the generated pseudo-random number, valid range (0, [Int32](../../core/core_package_api/core_package_intrinsics.md#int32).Max].

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - A pseudo-random number of type [Int32](../../core/core_package_api/core_package_intrinsics.md#int32).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if `upper` is less than or equal to 0.

Example:
<!-- verify -->
```cangjie
import std.random.*

main() {
    let m: Random = Random()
    let n: Int32 = m.nextInt32(5)
    if (n is Int32) {
        println("n is Int32")
    }
    try {
        let p: Int32 = m.nextInt32(-1)
        println(p)
    } catch (e: IllegalArgumentException) {
        println("Parameter exception: upper is less than or equal to 0")
    }
    return 0
}
```

Execution Result:

```text
n is Int32
Parameter exception: upper is less than or equal to 0
```

### func nextInt64()

```cangjie
public func nextInt64(): Int64
```

Function: Obtains a pseudo-random number of type [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - A pseudo-random number of type [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).

Example:
<!-- verify -->
```cangjie
import std.random.*

main() {
    let m: Random = Random()
    let n: Int64 = m.nextInt64()
    if (n is Int64) {
        println("n is Int64")
    }
    return 0
}
```

Execution Result:

```text
n is Int64
```

### func nextInt64(Int64)

```cangjie
public func nextInt64(upper: Int64): Int64
```

Function: Obtains a pseudo-random number of type [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) within the range [0, `upper`).

Parameters:

- upper: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Upper bound (exclusive) for the generated pseudo-random number, valid range (0, [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).Max].

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - A pseudo-random number of type [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if `upper` is less than or equal to 0.

Example:
<!-- verify -->
```cangjie
import std.random.*

main() {
    let m: Random = Random()
    let n: Int64 = m.nextInt64(5)
    if (n is Int64) {
        println("n is Int64")
    }
    try {
        let p: Int64 = m.nextInt64(-1)
        println(p)
    } catch (e: IllegalArgumentException) {
        println("Parameter exception: upper is less than or equal to 0")
    }
    return 0
}
```

Execution Result:

```text
n is Int64
Parameter exception: upper is less than or equal to 0
```

### func nextInt8()

```cangjie
public func nextInt8(): Int8
```

Function: Retrieves a pseudo-random number of type [Int8](../../core/core_package_api/core_package_intrinsics.md#int8).

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - A pseudo-random number of type [Int8](../../core/core_package_api/core_package_intrinsics.md#int8).

Example:
<!-- verify -->
```cangjie
import std.random.*

main() {
    let m: Random = Random()
    let n: Int8 = m.nextInt8()
    if (n is Int8) {
        println("n is Int8")
    }
    return 0
}
```

Execution Result:

```text
n is Int8
```

### func nextInt8(Int8): Int8

```cangjie
public func nextInt8(upper: Int8): Int8
```

Function: Retrieves a pseudo-random number of type [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) within the range [0, `upper`).

Parameters:

- upper: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The upper bound (exclusive) for the generated pseudo-random number range, with valid values in (0, [Int8](../../core/core_package_api/core_package_intrinsics.md#int8).Max].

Return Value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - A pseudo-random number of type [Int8](../../core/core_package_api/core_package_intrinsics.md#int8).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if `upper` is less than or equal to 0.

Example:
<!-- verify -->
```cangjie
import std.random.*

main() {
    let m: Random = Random()
    let n: Int8 = m.nextInt8(5)
    if (n is Int8) {
        println("n is Int8")
    }
    try {
        let p: Int8 = m.nextInt8(-1)
        println(p)
    } catch (e: IllegalArgumentException) {
        println("Parameter error: upper is less than or equal to 0")
    }
    return 0
}
```

Execution Result:

```text
n is Int8
Parameter error: upper is less than or equal to 0
```

### func nextUInt16()

```cangjie
public func nextUInt16(): UInt16
```

Function: Retrieves a pseudo-random number of type [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - A pseudo-random number of type [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).

Example:
<!-- verify -->
```cangjie
import std.random.*

main() {
    let m: Random = Random()
    let n: UInt16 = m.nextUInt16()
    if (n is UInt16) {
        println("n is UInt16")
    }
    return 0
}
```

Execution Result:

```text
n is UInt16
```

### func nextUInt16(UInt16)

```cangjie
public func nextUInt16(upper: UInt16): UInt16
```

Function: Retrieves a pseudo-random number of type [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) within the range [0, `upper`).

Parameters:

- upper: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The upper bound (exclusive) for the generated pseudo-random number range, with valid values in (0, [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).Max].

Return Value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - A pseudo-random number of type [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if `upper` equals 0.

Example:
<!-- verify -->
```cangjie
import std.random.*

main() {
    let m: Random = Random()
    let n: UInt16 = m.nextUInt16(5)
    if (n is UInt16) {
        println("n is UInt16")
    }
    try {
        let p: UInt16 = m.nextUInt16(0)
        println(p)
    } catch (e: IllegalArgumentException) {
        println("Parameter error: upper equals 0")
    }
    return 0
}
```

Execution Result:

```text
n is UInt16
Parameter error: upper equals 0
```

### func nextUInt32()

```cangjie
public func nextUInt32(): UInt32
```

Function: Obtains a pseudo-random number of type [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - A pseudo-random number of type [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).

Example:
<!-- verify -->
```cangjie
import std.random.*

main() {
    let m: Random = Random()
    let n: UInt32 = m.nextUInt32()
    if (n is UInt32) {
        println("n is UInt32")
    }
    return 0
}
```

Execution Result:

```text
n is UInt32
```

### func nextUInt32(UInt32)

```cangjie
public func nextUInt32(upper: UInt32): UInt32
```

Function: Obtains a pseudo-random number of type [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) within the range [0, `upper`).

Parameters:

- upper: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The upper bound (exclusive) for the generated pseudo-random number range, with valid values in (0, [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).Max].

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - A pseudo-random number of type [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if `upper` equals 0.

Example:
<!-- verify -->
```cangjie
import std.random.*

main() {
    let m: Random = Random()
    let n: UInt32 = m.nextUInt32(5)
    if (n is UInt32) {
        println("n is UInt32")
    }
    try {
        let p: UInt32 = m.nextUInt32(0)
        println(p)
    } catch (e: IllegalArgumentException) {
        println("Parameter error: upper equals 0")
    }
    return 0
}
```

Execution Result:

```text
n is UInt32
Parameter error: upper equals 0
```

### func nextUInt64()

```cangjie
public func nextUInt64(): UInt64
```

Function: Obtains a pseudo-random number of type [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - A pseudo-random number of type [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).

Example:
<!-- verify -->
```cangjie
import std.random.*

main() {
    let m: Random = Random()
    let n: UInt64 = m.nextUInt64()
    if (n is UInt64) {
        println("n is UInt64")
    }
    return 0
}
```

Execution Result:

```text
n is UInt64
```

### func nextUInt64(UInt64)

```cangjie
public func nextUInt64(upper: UInt64): UInt64
```

Function: Obtains a pseudo-random number of type [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) within the range [0, `upper`).

Parameters:

- upper: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The upper bound (exclusive) for the generated pseudo-random number range, with valid values in (0, [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).Max].

Return Value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - A pseudo-random number of type [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if `upper` equals 0.

Example:
<!-- verify -->
```cangjie
import std.random.*

main() {
    let m: Random = Random()
    let n: UInt64 = m.nextUInt64(5)
    if (n is UInt64) {
        println("n is UInt64")
    }
    try {
        let p: UInt64 = m.nextUInt64(0)
        println(p)
    } catch (e: IllegalArgumentException) {
        println("Parameter error: upper equals 0")
    }
    return 0
}
```

Execution Result:

```text
n is UInt64
Parameter error: upper equals 0
```

### func nextUInt8()

```cangjie
public func nextUInt8(): UInt8
```

Function: Obtains a pseudo-random number of type [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - A pseudo-random number of type [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).

Example:
<!-- verify -->
```cangjie
import std.random.*

main() {
    let m: Random = Random()
    let n: UInt8 = m.nextUInt8()
    if (n is UInt8) {
        println("n is UInt8")
    }
    return 0
}
```

Execution Result:

```text
n is UInt8
```

### func nextUInt8(UInt8)

```cangjie
public func nextUInt8(upper: UInt8): UInt8
```

Function: Obtains a pseudo-random number of type [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) within the range [0, `upper`).

Parameters:

- upper: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The upper bound of the generated pseudo-random number range (excluding `upper`), with valid range (0, [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).Max].

Return Value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - A pseudo-random number of type [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if `upper` equals 0.

Example:
<!-- verify -->
```cangjie
import std.random.*

main() {
    let m: Random = Random()
    let n: UInt8 = m.nextUInt8(5)
    if (n is UInt8) {
        println("n is UInt8")
    }
    try {
        let p: UInt8 = m.nextUInt8(0)
        println(p)
    } catch (e: IllegalArgumentException) {
        println("Parameter error: upper equals 0")
    }
    return 0
}
```

Execution Result:

```text
n is UInt8
Parameter error: upper equals 0
```

### func nextUInt8s(Array\<UInt8>) <sup>(deprecated)</sup>

```cangjie
public func nextUInt8s(array: Array<UInt8>): Array<UInt8>
```

Function: Generates random numbers to replace each element in the input array.

> **Note:**
>
> This method will be deprecated in future versions. Use [nextBytes](#func-nextbytesarraybyte) instead.

Parameters:

- array: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - The array to be replaced.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - Returns the replaced [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt).

### func nextBytes(Array\<Byte>)

```cangjie
public func nextBytes(bytes: Array<Byte>): Unit
```

Function: Generates random numbers to replace each element in the input array.

Parameters:

- bytes: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - The array to be replaced.

### func nextBytes(Int32)

```cangjie
public func nextBytes(length: Int32): Array<Byte>
```

Function: Generates a random number array of specified length.

Parameters:

- length: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The length of the generated random number array, where `length` is greater than 0.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - The generated random number array.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when parameter `length` is less than or equal to 0.