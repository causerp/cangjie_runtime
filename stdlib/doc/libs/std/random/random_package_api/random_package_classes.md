# 类

## class Random

```cangjie
public class Random {
    public init()
    public init(seed: UInt64)
}
```

功能：提供生成伪随机数的相关功能。

### prop seed

```cangjie
public prop seed: UInt64
```

功能：获取随机数种子。

类型：[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)

示例：

<!-- run -->
```cangjie
import std.random.*

main(): Unit {
    // 使用默认构造函数创建Random对象
    let random = Random()

    let seed = random.seed
    println("种子: ${seed}")
}
```

可能的运行结果：

```text
种子: 1768631965497376828
```

### init()

```cangjie
public init()
```

功能：默认无参构造函数创建新的 [Random](random_package_classes.md#class-random) 对象。

示例：

<!-- run -->
```cangjie
import std.random.*

main(): Unit {
    // 使用默认构造函数创建Random对象
    let random = Random()

    // 生成一些随机数验证对象创建成功
    let value = random.nextInt32()
    println("生成的随机数: ${value}")
}
```

可能的运行结果：

```text
生成的随机数: 1234567890
```

### init(UInt64)

```cangjie
public init(seed: UInt64)
```

功能：使用随机数种子创建新的 [Random](random_package_classes.md#class-random) 对象。

参数：

- seed: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 随机数种子，如果设置相同随机种子，生成的伪随机数列表相同。

示例：

<!-- run -->
```cangjie
import std.random.*

main(): Unit {
    // 使用相同种子创建两个Random对象
    let seed: UInt64 = 12345
    let random1 = Random(seed)
    let random2 = Random(seed)

    // 验证相同种子产生相同的随机数序列
    let value1_1 = random1.nextInt32()
    let value2_1 = random2.nextInt32()
    println("random1的第一个随机数: ${value1_1}")
    println("random2的第一个随机数: ${value2_1}")
}
```

可能的运行结果：

```text
random1的第一个随机数: 1861434509
random2的第一个随机数: 1861434509
```

### func next(UInt64) <sup>(deprecated)</sup>

```cangjie
public func next(bits: UInt64): UInt64
```

功能：生成一个用户指定位长的随机整数。

> **注意：**
>
> 未来版本即将废弃，使用 [nextBits](#func-nextbitsuint64) 替代。

参数：

- bits: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 要生成的伪随机数的位数，取值范围 (0, 64]。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 用户指定位长的伪随机数。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果 `bits` 等于 0 ，或大于 64，超过所能截取的 [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) 长度，则抛出异常。

示例：

<!-- run -->
```cangjie
import std.random.*

main(): Unit {
    let random = Random()

    // 生成指定位长的随机数
    let randomValue = random.next(10)
    println("生成的10位随机数: ${randomValue}")
}
```

可能的运行结果：

```text
生成的10位随机数: 960
```

### func nextBits(UInt64)

```cangjie
public func nextBits(bits: UInt64): UInt64
```

功能：生成一个指定位长的随机整数。

参数：

- bits: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 要生成的伪随机数的位数，取值范围 (0, 64]。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 生成的用户指定位长的伪随机数。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果 `bits` 等于 0，或大于 64，超过所能截取的 [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) 长度，则抛出异常。

示例：

<!-- run -->
```cangjie
import std.random.*

main(): Unit {
    let random = Random()

    // 生成指定位长的随机数
    let randomValue = random.nextBits(10)
    println("生成的10位随机数: ${randomValue}")
}
```

可能的运行结果：

```text
生成的10位随机数: 512
```

### func nextBool()

```cangjie
public func nextBool(): Bool
```

功能：获取一个布尔类型的伪随机值。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 一个 [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) 类型的伪随机数。

示例：

<!-- run -->
```cangjie
import std.random.*

main() {
    // 创建一个随机数生成器
    let random = Random()

    // 生成一个布尔值
    let bool = random.nextBool()
    println("结果: ${bool}")
    return 0
}
```

可能的运行结果：

```text
结果: false
```

### func nextBytes(Array\<Byte>)

```cangjie
public func nextBytes(bytes: Array<Byte>): Unit
```

功能：生成随机数替换入参数组中的每个元素。

参数：

- bytes: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - 被替换的数组。

示例：

<!-- run -->
```cangjie
import std.random.*

main(): Unit {
    let random = Random()

    // 先创建一个字节数组
    let bytes = Array<UInt8>(5, repeat: 0)

    println("调用nextBytes前: ${bytes}")

    // 使用nextBytes重新填充数组
    random.nextBytes(bytes)

    println("调用nextBytes后: ${bytes}")
}
```

可能的运行结果：

```text
调用nextBytes前: [0, 0, 0, 0, 0]
调用nextBytes后: [138, 254, 94, 118, 164]
```

### func nextBytes(Int32)

```cangjie
public func nextBytes(length: Int32): Array<Byte>
```

功能：生成指定长度的随机数数组。

参数：

- length: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 生成的随机数数组长度，`length` 大于 0。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - 生成的随机数数组。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当参数 `length` 小于等于 0 时，抛出异常。

示例：

<!-- run -->
```cangjie
import std.random.*

main(): Unit {
    let random = Random()

    // 生成长度为5的随机字节数组
    let bytes = random.nextBytes(5)

    // 打印生成的随机字节
    println("生成的随机字节: ${bytes}")
}
```

可能的运行结果：

```text
生成的随机字节: [86, 205, 17, 142, 41]
```

### func nextFloat16()

```cangjie
public func nextFloat16(): Float16
```

功能：获取一个 [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) 类型的伪随机数，其范围为 [0.0, 1.0)。

返回值：

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - 一个 [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) 类型的伪随机数。

示例：

<!-- run -->
```cangjie
import std.random.*

main() {
    // 创建一个Random实例
    let rng = Random()

    // 生成一个Float16类型的随机数 [0.0, 1.0)
    let randomFloat16 = rng.nextFloat16()
    println("生成的Float16随机数: ${randomFloat16}")

    return 0
}
```

可能的运行结果：

```text
生成的Float16随机数: 0.286133
```

### func nextFloat32()

```cangjie
public func nextFloat32(): Float32
```

功能：获取一个 [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) 类型的伪随机数，其范围为 [0.0, 1.0)。

返回值：

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - 一个 [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) 类型的伪随机数。

示例：

<!-- run -->
```cangjie
import std.random.*

main() {
    // 创建一个Random实例
    let rng = Random()

    // 生成一个Float32类型的随机数 [0.0, 1.0)
    let randomFloat32 = rng.nextFloat32()
    println("生成的Float32随机数: ${randomFloat32}")

    return 0
}
```

可能的运行结果：

```text
生成的Float32随机数: 0.010008
```

### func nextFloat64()

```cangjie
public func nextFloat64(): Float64
```

功能：获取一个 [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) 类型的伪随机数，其范围为 [0.0, 1.0)。

返回值：

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - 一个 [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) 类型的伪随机数。

示例：

<!-- run -->
```cangjie
import std.random.*

main() {
    // 创建一个Random实例
    let rng = Random()

    // 生成一个Float64类型的随机数 [0.0, 1.0)
    let randomFloat64 = rng.nextFloat64()
    println("生成的Float64随机数: ${randomFloat64}")

    return 0
}
```

可能的运行结果：

```text
生成的Float64随机数: 0.510989
```

### func nextGaussianFloat16(Float16, Float16)

```cangjie
public func nextGaussianFloat16(mean!: Float16 = 0.0, sigma!: Float16 = 1.0): Float16
```

功能：获取一个 [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) 类型的符合指定均值与标准差的高斯分布的随机数。

默认获取一个 [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) 类型且符合均值为 0.0 标准差为 1.0 的高斯分布的随机数。其中均值是期望值，可解释为位置参数，决定了分布的位置，标准差可解释为尺度参数，决定了分布的幅度。

参数：

- mean!: [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - 均值，默认值 0.0。
- sigma!: [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - 标准差，默认值 1.0。

返回值：

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - 一个 [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) 类型的随机数。

示例：

<!-- run -->
```cangjie
import std.random.*

main() {
    // 创建一个Random实例
    let rng = Random()

    // 生成一个Float16类型的高斯分布随机数（均值0.0，标准差1.0）
    let gaussianFloat16 = rng.nextGaussianFloat16()
    println("生成的默认高斯分布Float16随机数: ${gaussianFloat16}")

    // 生成一个Float16类型的高斯分布随机数（均值2.0，标准差1.5）
    let gaussianFloat16Custom = rng.nextGaussianFloat16(mean: 2.0, sigma: 1.5)
    println("生成的自定义高斯分布Float16随机数: ${gaussianFloat16Custom}")

    return 0
}
```

可能的运行结果：

```text
生成的默认高斯分布Float16随机数: -1.596680
生成的自定义高斯分布Float16随机数: 3.708984
```

### func nextGaussianFloat32(Float32, Float32)

```cangjie
public func nextGaussianFloat32(mean!: Float32 = 0.0, sigma!: Float32 = 1.0): Float32
```

功能：获取一个 [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) 类型的符合指定均值与标准差的高斯分布的随机数。

默认获取一个 [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) 类型且符合均值为 0.0 标准差为 1.0 的高斯分布的随机数。其中均值是期望值，可解释为位置参数，决定了分布的位置，标准差可解释为尺度参数，决定了分布的幅度。

参数：

- mean!: [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - 均值，默认值 0.0。
- sigma!: [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - 标准差，默认值 1.0。

返回值：

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - 一个 [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) 类型的随机数。

示例：

<!-- run -->
```cangjie
import std.random.*

main() {
    // 创建一个Random实例
    let rng = Random()

    // 生成一个Float32类型的高斯分布随机数（均值0.0，标准差1.0）
    let gaussianFloat32 = rng.nextGaussianFloat32()
    println("生成的默认高斯分布Float32随机数: ${gaussianFloat32}")

    // 生成一个Float32类型的高斯分布随机数（均值2.0，标准差1.5）
    let gaussianFloat32Custom = rng.nextGaussianFloat32(mean: 2.0, sigma: 1.5)
    println("生成的自定义高斯分布Float32随机数: ${gaussianFloat32Custom}")

    return 0
}
```

可能的运行结果：

```text
生成的默认高斯分布Float32随机数: 0.666218
生成的自定义高斯分布Float32随机数: 3.623906
```

### func nextGaussianFloat64(Float64, Float64)

```cangjie
public func nextGaussianFloat64(mean!: Float64 = 0.0, sigma!: Float64 = 1.0): Float64
```

功能：获取一个 [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) 类型的符合指定均值与标准差的高斯分布的随机数。

默认获取一个 [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) 类型且符合均值为 0.0 标准差为 1.0 的高斯分布的随机数。其中均值是期望值，可解释为位置参数，决定了分布的位置，标准差可解释为尺度参数，决定了分布的幅度。

参数：

- mean!: [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - 均值，默认值 0.0。
- sigma!: [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - 标准差，默认值 1.0。

返回值：

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - 一个 [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) 类型的随机数。

示例：

<!-- run -->
```cangjie
import std.random.*

main() {
    // 创建一个Random实例
    let rng = Random()

    // 生成一个Float64类型的高斯分布随机数（均值0.0，标准差1.0）
    let gaussianFloat64 = rng.nextGaussianFloat64()
    println("生成的默认高斯分布Float64随机数: ${gaussianFloat64}")

    // 生成一个Float64类型的高斯分布随机数（均值2.0，标准差1.5）
    let gaussianFloat64Custom = rng.nextGaussianFloat64(mean: 2.0, sigma: 1.5)
    println("生成的自定义高斯分布Float64随机数: ${gaussianFloat64Custom}")

    return 0
}
```

可能的运行结果：

```text
生成的默认高斯分布Float64随机数: 0.461099
生成的自定义高斯分布Float64随机数: 3.610765
```

### func nextInt16()

```cangjie
public func nextInt16(): Int16
```

功能：获取一个 [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) 类型的伪随机数。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 一个 [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) 类型的伪随机数。

示例：

<!-- run -->
```cangjie
import std.random.*

main() {
    // 创建一个Random实例
    let rng = Random()

    // 生成一个Int16类型的随机数
    let randomInt16 = rng.nextInt16()
    println("生成的Int16随机数: ${randomInt16}")

    return 0
}
```

可能的运行结果：

```text
生成的Int16随机数: 23604
```

### func nextInt16(Int16)

```cangjie
public func nextInt16(upper: Int16): Int16
```

功能：获取一个范围在 [0, `upper`) 的 [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) 类型的伪随机数。

参数：

- upper: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 表示生成的伪随机数范围上界（不包括 `upper`），取值范围 (0, [Int16](../../core/core_package_api/core_package_intrinsics.md#int16).Max]。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 一个 [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) 类型的伪随机数。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果 `upper` 小于等于 0，抛出异常。

示例：

<!-- run -->
```cangjie
import std.random.*

main() {
    // 创建一个Random实例
    let rng = Random()

    // 生成一个范围在 [0, 100) 的Int16类型的随机数
    let randomInt16Upper = rng.nextInt16(100)
    println("生成的范围在[0, 100)的Int16随机数: ${randomInt16Upper}")
    return 0
}
```

可能的运行结果：

```text
生成的范围在[0, 100)的Int16随机数: 25
```

### func nextInt32()

```cangjie
public func nextInt32(): Int32
```

功能：获取一个 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 类型的伪随机数。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 一个 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 类型的伪随机数。

示例：

<!-- run -->
```cangjie
import std.random.*

main() {
    // 创建一个Random实例
    let rng = Random()

    // 生成一个Int32类型的随机数
    let randomInt32 = rng.nextInt32()
    println("生成的Int32随机数: ${randomInt32}")

    return 0
}
```

可能的运行结果：

```text
生成的Int32随机数: 1556266486
```

### func nextInt32(Int32)

```cangjie
public func nextInt32(upper: Int32): Int32
```

功能：获取一个范围在 [0, `upper`) 的 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 类型的伪随机数。

参数：

- upper: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 表示生成的伪随机数范围上界（不包括 `upper`），取值范围 (0, [Int32](../../core/core_package_api/core_package_intrinsics.md#int32).Max]。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 一个 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 类型的伪随机数。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果 `upper` 小于等于 0，抛出异常。

示例：

<!-- run -->
```cangjie
import std.random.*

main() {
    // 创建一个Random实例
    let rng = Random()

    // 生成一个范围在 [0, 1000) 的Int32类型的随机数
    let randomInt32Upper = rng.nextInt32(1000)
    println("生成的范围在[0, 1000)的Int32随机数: ${randomInt32Upper}")
    return 0
}
```

可能的运行结果：

```text
生成的范围在[0, 1000)的Int32随机数: 571
```

### func nextInt64()

```cangjie
public func nextInt64(): Int64
```

功能：获取一个 [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) 类型的伪随机数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 一个 [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) 类型的伪随机数。

示例：

<!-- run -->
```cangjie
import std.random.*

main() {
    // 创建一个Random实例
    let rng = Random()

    // 生成一个Int64类型的随机数
    let randomInt64 = rng.nextInt64()
    println("生成的Int64随机数: ${randomInt64}")

    return 0
}
```

可能的运行结果：

```text
生成的Int64随机数: -7311212217809863139
```

### func nextInt64(Int64)

```cangjie
public func nextInt64(upper: Int64): Int64
```

功能：获取一个范围在 [0, `upper`) 的 [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) 类型的伪随机数。

参数：

- upper: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 生成的伪随机数范围上界（不包括 `upper`），取值范围 (0, [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).Max]。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 一个 [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) 类型的伪随机数。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果 `upper` 小于等于 0，抛出异常。

示例：

<!-- run -->
```cangjie
import std.random.*

main() {
    // 创建一个Random实例
    let rng = Random()

    // 生成一个范围在 [0, 1000000) 的Int64类型的随机数
    let randomInt64Upper = rng.nextInt64(1000000)
    println("生成的范围在[0, 1000000)的Int64随机数: ${randomInt64Upper}")
    return 0
}
```

可能的运行结果：

```text
生成的范围在[0, 1000000)的Int64随机数: 917339
```

### func nextInt8()

```cangjie
public func nextInt8(): Int8
```

功能：获取一个 [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) 类型的伪随机数。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 一个 [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) 类型的伪随机数。

示例：

<!-- run -->
```cangjie
import std.random.*

main() {
    // 创建一个Random实例
    let rng = Random()

    // 生成一个Int8类型的随机数
    let randomInt8 = rng.nextInt8()
    println("生成的Int8随机数: ${randomInt8}")

    return 0
}
```

可能的运行结果：

```text
生成的Int8随机数: 2
```

### func nextInt8(Int8): Int8

```cangjie
public func nextInt8(upper: Int8): Int8
```

功能：获取一个范围在 [0, `upper`) 的 [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) 类型的伪随机数。

参数：

- upper: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 生成的伪随机数范围上界（不包括 `upper`），取值范围 (0, [Int8](../../core/core_package_api/core_package_intrinsics.md#int8).Max]。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 一个 [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) 类型的伪随机数。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果 `upper` 小于等于 0，抛出异常。

示例：

<!-- run -->
```cangjie
import std.random.*

main() {
    // 创建一个Random实例
    let rng = Random()

    // 生成一个范围在 [0, 100) 的Int8类型的随机数
    let randomInt8Upper = rng.nextInt8(100)
    println("生成的范围在[0, 100)的Int8随机数: ${randomInt8Upper}")
    return 0
}
```

可能的运行结果：

```text
生成的范围在[0, 100)的Int8随机数: 7
```

### func nextUInt16()

```cangjie
public func nextUInt16(): UInt16
```

功能：获取一个 [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) 类型的伪随机数。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 一个 [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) 类型的伪随机数。

示例：

<!-- run -->
```cangjie
import std.random.*

main() {
    // 创建一个Random实例
    let rng = Random()

    // 生成一个UInt16类型的随机数
    let randomUInt16 = rng.nextUInt16()
    println("生成的UInt16随机数: ${randomUInt16}")

    return 0
}
```

可能的运行结果：

```text
生成的UInt16随机数: 24058
```

### func nextUInt16(UInt16)

```cangjie
public func nextUInt16(upper: UInt16): UInt16
```

功能：获取一个范围在 [0, `upper`) 的 [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) 类型的伪随机数。

参数：

- upper: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 生成的伪随机数范围上界（不包括 `upper`），取值范围 (0, [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).Max]。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 一个 [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) 类型的伪随机数。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果 `upper` 等于 0，抛出异常。

示例：

<!-- run -->
```cangjie
import std.random.*

main() {
    // 创建一个Random实例
    let rng = Random()

    // 生成一个范围在 [0, 10000) 的UInt16类型的随机数
    let randomUInt16Upper = rng.nextUInt16(10000)
    println("生成的范围在[0, 10000)的UInt16随机数: ${randomUInt16Upper}")
    return 0
}
```

可能的运行结果：

```text
生成的范围在[0, 10000)的UInt16随机数: 4927
```

### func nextUInt32()

```cangjie
public func nextUInt32(): UInt32
```

功能：获取一个 [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) 类型的伪随机数。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 一个 [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) 类型的伪随机数。

示例：

<!-- run -->
```cangjie
import std.random.*

main() {
    // 创建一个Random实例
    let rng = Random()

    // 生成一个UInt32类型的随机数
    let randomUInt32 = rng.nextUInt32()
    println("生成的UInt32随机数: ${randomUInt32}")

    return 0
}
```

可能的运行结果：

```text
生成的UInt32随机数: 738971091
```

### func nextUInt32(UInt32)

```cangjie
public func nextUInt32(upper: UInt32): UInt32
```

功能：获取一个范围在 [0, `upper`) 的 [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) 类型的伪随机数。

参数：

- upper: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 生成的伪随机数范围上界（不包括 `upper`），取值范围 (0, [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).Max]。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 一个 [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) 类型的伪随机数。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果 `upper` 等于 0，抛出异常。

示例：

<!-- run -->
```cangjie
import std.random.*

main() {
    // 创建一个Random实例
    let rng = Random()

    // 生成一个范围在 [0, 1000000) 的UInt32类型的随机数
    let randomUInt32Upper = rng.nextUInt32(1000000)
    println("生成的范围在[0, 1000000)的UInt32随机数: ${randomUInt32Upper}")
    return 0
}
```

可能的运行结果：

```text
生成的范围在[0, 1000000)的UInt32随机数: 913641
```

### func nextUInt64()

```cangjie
public func nextUInt64(): UInt64
```

功能：获取一个 [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) 类型的伪随机数。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 一个 [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) 类型的伪随机数。

示例：

<!-- run -->
```cangjie
import std.random.*

main() {
    // 创建一个Random实例
    let rng = Random()

    // 生成一个UInt64类型的随机数
    let randomUInt64 = rng.nextUInt64()
    println("生成的UInt64随机数: ${randomUInt64}")

    return 0
}
```

可能的运行结果：

```text
生成的UInt64随机数: 9612265470820164117
```

### func nextUInt64(UInt64)

```cangjie
public func nextUInt64(upper: UInt64): UInt64
```

功能：获取一个范围在 [0, `upper`) 的 [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) 类型的伪随机数。

参数：

- upper: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 生成的伪随机数范围上界（不包括 `upper`），取值范围 (0, [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).Max]。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 一个 [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) 类型的伪随机数。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果 `upper` 等于 0，抛出异常。

示例：

<!-- run -->
```cangjie
import std.random.*

main() {
    // 创建一个Random实例
    let rng = Random()

    // 生成一个范围在 [0, 1000000000000) 的UInt64类型的随机数
    let randomUInt64Upper = rng.nextUInt64(1000000000000)
    println("生成的范围在[0, 1000000000000)的UInt64随机数: ${randomUInt64Upper}")
    return 0
}
```

可能的运行结果：

```text
生成的范围在[0, 1000000000000)的UInt64随机数: 48580775680
```

### func nextUInt8()

```cangjie
public func nextUInt8(): UInt8
```

功能：获取一个 [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) 类型的伪随机数。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 一个 [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) 类型的伪随机数。

示例：

<!-- run -->
```cangjie
import std.random.*

main() {
    // 创建一个Random实例
    let rng = Random()

    // 生成一个UInt8类型的随机数
    let randomUInt8 = rng.nextUInt8()
    println("生成的UInt8随机数: ${randomUInt8}")

    return 0
}
```

可能的运行结果：

```text
生成的UInt8随机数: 151
```

### func nextUInt8(UInt8)

```cangjie
public func nextUInt8(upper: UInt8): UInt8
```

功能：获取一个范围在 [0, `upper`) 的 [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) 类型的伪随机数。

参数：

- upper: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 生成的伪随机数范围上界（不包括 `upper`），取值范围 (0, [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).Max]。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 一个 [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) 类型的伪随机数。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果 `upper` 等于 0，抛出异常。

示例：

<!-- run -->
```cangjie
import std.random.*

main() {
    // 创建一个Random实例
    let rng = Random()

    // 生成一个范围在 [0, 100) 的UInt8类型的随机数
    let randomUInt8Upper = rng.nextUInt8(100)
    println("生成的范围在[0, 100)的UInt8随机数: ${randomUInt8Upper}")
    return 0
}
```

可能的运行结果：

```text
生成的范围在[0, 100)的UInt8随机数: 16
```

### func nextUInt8s(Array\<UInt8>) <sup>(deprecated)</sup>

```cangjie
public func nextUInt8s(array: Array<UInt8>): Array<UInt8>
```

功能：生成随机数替换入参数组中的每个元素。

> **注意：**
>
> 未来版本即将废弃，使用 [nextBytes](#func-nextbytesarraybyte) 替代。

参数：

- array: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - 被替换的数组。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - 返回替换后的 [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)。

示例：

<!-- run -->
```cangjie
import std.random.*

main(): Unit {
    let random = Random()

    // 先创建一个字节数组
    let bytes = Array<UInt8>(5, repeat: 0)

    println("调用nextUInt8s前: ${bytes}")

    // 使用nextUInt8s重新填充数组
    let result = random.nextUInt8s(bytes)

    println("调用nextUInt8s后: ${result}")
}
```

可能的运行结果：

```text
调用nextUInt8s前: [0, 0, 0, 0, 0]
调用nextUInt8s后: [237, 114, 163, 155, 228]
```
