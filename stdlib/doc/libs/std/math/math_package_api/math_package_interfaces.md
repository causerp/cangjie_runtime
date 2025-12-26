# 接口

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

功能：本接口提供了浮点数相关的方法。

父类型：

- [Number](#interface-numbert)\<T>

### static func getE()

```cangjie
static func getE(): T
```

功能：获取 T 类型的自然常数。

返回值：

- T - 类型 T 的自然常数。

### static func getInf()

```cangjie
static func getInf(): T
```

功能：获取浮点数的无穷数。

返回值：

- T - 类型 T 的无穷数。

### static func getMinDenormal()

```cangjie
static func getMinDenormal(): T
```

功能：获取单精度浮点数的最小次正规数。

返回值：

- T - 类型 T 的最小次正规数。

### static func getMinNormal()

```cangjie
static func getMinNormal(): T
```

功能：获取单精度浮点数的最小正规数。

返回值：

- T - 类型 T 的最小正规数。

### static func getNaN()

```cangjie
static func getNaN(): T
```

功能：获取浮点数的非数。

返回值：

- T - 类型 T 的非数。

### static func getPI()

```cangjie
static func getPI(): T
```

功能：获取 T 类型的圆周率常数。

返回值：

- T - 类型 T 的圆周率常数。

### func isInf()

```cangjie
func isInf(): Bool
```

功能：判断浮点数是否为无穷数值。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果浮点数的值正无穷大或负无穷大，则返回 `true`；否则，返回 `false`。

### func isNaN()

```cangjie
func isNaN(): Bool
```

功能：判断浮点数是否为非数值。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果浮点数的值为非数值，则返回 `true`；否则，返回 `false`。

### func isNormal()

```cangjie
func isNormal(): Bool
```

功能：判断浮点数是否为常规数值。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果是正常的浮点数，返回 `true`；否则，返回 `false`。

### extend Float16 <: FloatingPoint\<Float16>

```cangjie
extend Float16 <: FloatingPoint<Float16>
```

功能：为 [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) 类型扩展 [FloatingPoint\<Float16>](#interface-floatingpointt) 接口。

父类型：

- [FloatingPoint](#interface-floatingpointt)\<[Float16](../../core/core_package_api/core_package_intrinsics.md#float16)>

#### static func getE()

```cangjie
public static func getE(): Float16
```

功能：获取半精度浮点数类型的自然常数。

返回值：

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - 半精度浮点数类型的自然常数。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取半精度浮点数类型的自然常数 */
    let e = Float16.getE()

    /* 打印自然常数 */
    println("Float16的自然常数E: ${e}")
}
```

运行结果：

```text
Float16的自然常数E: 2.718750
```

#### static func getInf()

```cangjie
public static func getInf(): Float16
```

功能：获取半精度浮点数类型的无穷数值。

返回值：

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - 半精度浮点数类型的无穷数值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取半精度浮点数类型的无穷数值 */
    let inf = Float16.getInf()

    /* 打印无穷数值 */
    println("Float16的无穷大值: ${inf}")
}
```

运行结果：

```text
Float16的无穷大值: inf
```

#### static func getMinDenormal()

```cangjie
public static func getMinDenormal(): Float16
```

功能：获取半精度浮点数类型的最小次正规数。

返回值：

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - 半精度浮点数类型的最小次正规数。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取半精度浮点数类型的最小次正规数 */
    let minDenormal = Float16.getMinDenormal()

    /* 打印最小次正规数 */
    println("Float16的最小次正规数: ${minDenormal}")
}
```

运行结果：

```text
Float16的最小次正规数: 0.000000
```

#### static func getMinNormal()

```cangjie
public static func getMinNormal(): Float16
```

功能：获取半精度浮点数类型的最小正规数。

返回值：

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - 半精度浮点数类型的最小正规数。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取半精度浮点数类型的最小正规数 */
    let minNormal = Float16.getMinNormal()

    /* 打印最小正规数 */
    println("Float16的最小正规数: ${minNormal}")
}
```

运行结果：

```text
Float16的最小正规数: 0.000061
```

#### static func getNaN()

```cangjie
public static func getNaN(): Float16
```

功能：获取半精度浮点数类型的非数。

返回值：

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - 半精度浮点数类型的非数。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取半精度浮点数类型的非数 */
    let nan = Float16.getNaN()

    /* 打印非数 */
    println("Float16的非数: ${nan}")

    /* 检查是否为非数 */
    println("是否为非数: ${nan.isNaN()}")
}
```

运行结果：

```text
Float16的非数: nan
是否为非数: true
```

#### static func getPI()

```cangjie
public static func getPI(): Float16
```

功能：获取半精度浮点数类型的圆周率常数。

返回值：

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - 半精度浮点数类型的圆周率常数。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取半精度浮点数类型的圆周率常数 */
    let pi = Float16.getPI()

    /* 打印圆周率 */
    println("Float16的圆周率PI: ${pi}")
}
```

运行结果：

```text
Float16的圆周率PI: 3.140625
```

### extend Float32 <: FloatingPoint\<Float32>

```cangjie
extend Float32 <: FloatingPoint<Float32>
```

功能：为 [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) 类型扩展 [FloatingPoint\<Float32>](#interface-floatingpointt) 接口。

父类型：

- [FloatingPoint](#interface-floatingpointt)\<[Float32](../../core/core_package_api/core_package_intrinsics.md#float32)>

#### static func getE()

```cangjie
public static func getE(): Float32
```

功能：获取单精度浮点数类型的自然常数。

返回值：

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - 单精度浮点数类型的自然常数。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取单精度浮点数类型的自然常数 */
    let e = Float32.getE()

    /* 打印自然常数 */
    println("Float32的自然常数E: ${e}")
}
```

运行结果：

```text
Float32的自然常数E: 2.718282
```

#### static func getInf()

```cangjie
public static func getInf(): Float32
```

功能：获取单精度浮点数类型的无穷数值。

返回值：

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - 单精度浮点数类型的无穷数值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取单精度浮点数类型的无穷数值 */
    let inf = Float32.getInf()

    /* 打印无穷数值 */
    println("Float32的无穷大值: ${inf}")
}
```

运行结果：

```text
Float32的无穷大值: inf
```

#### static func getMinDenormal()

```cangjie
public static func getMinDenormal(): Float32
```

功能：获取单精度浮点数类型的最小次正规数。

返回值：

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - 单精度浮点数类型的最小次正规数。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取单精度浮点数类型的最小次正规数 */
    let minDenormal = Float32.getMinDenormal()

    /* 打印最小次正规数 */
    println("Float32的最小次正规数: ${minDenormal}")
}
```

运行结果：

```text
Float32的最小次正规数: 0.000000
```

#### static func getMinNormal()

```cangjie
public static func getMinNormal(): Float32
```

功能：获取单精度浮点数类型的最小正规数。

返回值：

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - 单精度浮点数类型的最小正规数。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取单精度浮点数类型的最小正规数 */
    let minNormal = Float32.getMinNormal()

    /* 打印最小正规数 */
    println("Float32的最小正规数: ${minNormal}")
}
```

运行结果：

```text
Float32的最小正规数: 0.000000
```

#### static func getNaN()

```cangjie
public static func getNaN(): Float32
```

功能：获取单精度浮点数类型的非数。

返回值：

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - 单精度浮点数类型的非数。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取单精度浮点数类型的非数 */
    let nan = Float32.getNaN()

    /* 打印非数 */
    println("Float32的非数: ${nan}")

    /* 检查是否为非数 */
    println("是否为非数: ${nan.isNaN()}")
}
```

运行结果：

```text
Float32的非数: nan
是否为非数: true
```

#### static func getPI()

```cangjie
public static func getPI(): Float32
```

功能：获取单精度浮点数类型的圆周率常数。

返回值：

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - 单精度浮点数类型的圆周率常数。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取单精度浮点数类型的圆周率常数 */
    let pi = Float32.getPI()

    /* 打印圆周率 */
    println("Float32的圆周率PI: ${pi}")
}
```

运行结果：

```text
Float32的圆周率PI: 3.141593
```

### extend Float64 <: FloatingPoint\<Float64>

```cangjie
extend Float64 <: FloatingPoint<Float64>
```

功能：为 [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) 类型扩展 [FloatingPoint\<Float64>](#interface-floatingpointt) 接口。

父类型：

- [FloatingPoint](#interface-floatingpointt)\<[Float64](../../core/core_package_api/core_package_intrinsics.md#float64)>

#### static func getE()

```cangjie
public static func getE(): Float64
```

功能：获取双精度浮点数类型的自然常数。

返回值：

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - 双精度浮点数类型的自然常数。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取双精度浮点数类型的自然常数 */
    let e = Float64.getE()

    /* 打印自然常数 */
    println("Float64的自然常数E: ${e}")
}
```

运行结果：

```text
Float64的自然常数E: 2.718282
```

#### static func getInf()

```cangjie
public static func getInf(): Float64
```

功能：获取双精度浮点数类型的无穷数值。

返回值：

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - 双精度浮点数类型的无穷数值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取双精度浮点数类型的无穷数值 */
    let inf = Float64.getInf()

    /* 打印无穷数值 */
    println("Float64的无穷大值: ${inf}")
}
```

运行结果：

```text
Float64的无穷大值: inf
```

#### static func getMinDenormal()

```cangjie
public static func getMinDenormal(): Float64
```

功能：获取双精度浮点数类型的最小次正规数。

返回值：

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - 双精度浮点数类型的最小次正规数。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取双精度浮点数类型的最小次正规数 */
    let minDenormal = Float64.getMinDenormal()

    /* 打印最小次正规数 */
    println("Float64的最小次正规数: ${minDenormal}")
}
```

运行结果：

```text
Float64的最小次正规数: 0.000000
```

#### static func getMinNormal()

```cangjie
public static func getMinNormal(): Float64
```

功能：获取双精度浮点数类型的最小正规数。

返回值：

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - 双精度浮点数类型的最小正规数。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取双精度浮点数类型的最小正规数 */
    let minNormal = Float64.getMinNormal()

    /* 打印最小正规数 */
    println("Float64的最小正规数: ${minNormal}")
}
```

运行结果：

```text
Float64的最小正规数: 0.000000
```

#### static func getNaN()

```cangjie
public static func getNaN(): Float64
```

功能：获取双精度浮点数类型的非数。

返回值：

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - 双精度浮点数类型的非数。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取双精度浮点数类型的非数 */
    let nan = Float64.getNaN()

    /* 打印非数 */
    println("Float64的非数: ${nan}")

    /* 检查是否为非数 */
    println("是否为非数: ${nan.isNaN()}")
}
```

运行结果：

```text
Float64的非数: nan
是否为非数: true
```

#### static func getPI()

```cangjie
public static func getPI(): Float64
```

功能：获取双精度浮点数类型的圆周率常数。

返回值：

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - 双精度浮点数类型的圆周率常数。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取双精度浮点数类型的圆周率常数 */
    let pi = Float64.getPI()

    /* 打印圆周率 */
    println("Float64的圆周率PI: ${pi}")
}
```

运行结果：

```text
Float64的圆周率PI: 3.141593
```

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

功能：本接口提供了整数类型相关的方法。

父类型：

- [Number\<T>](#interface-numbert)

### static func isSigned()

```cangjie
static func isSigned(): Bool
```

功能：判断类型是否是有符号的。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果类型是有符号的，返回 `true`；否则返回 `false`。

### operator func !()

```cangjie
operator func !(): T
```

功能：位运算符，按位取反。

返回值：

- T - 计算所得结果。

### operator func %(T)

```cangjie
operator func %(rhs: T): T
```

功能：算术运算符，计算余数。

参数：

- rhs: T - 运算符右边的数，表示除数。

返回值：

- T - 计算所得余数。

### operator func &(T)

```cangjie
operator func &(rhs: T): T
```

功能：位运算符，按位与。

参数：

- rhs: T - 运算符右边的数。

返回值：

- T - 计算所得结果。

### operator func <<(Int64)

```cangjie
operator func <<(n: Int64): T
```

功能：位运算符，按位左移。

参数：

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 运算符右边的数，表示左移的位数。

返回值：

- T - 计算所得结果。

### operator func >>(Int64)

```cangjie
operator func >>(n: Int64): T
```

功能：位运算符，按位右移。

参数：

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 运算符右边的数，表示右移的位数。

返回值：

- T - 计算所得结果。

### operator func ^(T)

```cangjie
operator func ^(rhs: T): T
```

功能：位运算符，按位异或。

参数：

- rhs: T - 运算符右边的数。

返回值：

- T - 计算所得结果。

### operator func |(T)

```cangjie
operator func |(rhs: T): T
```

功能：位运算符，按位或。

参数：

- rhs: T - 运算符右边的数。

返回值：

- T - 计算所得结果。

### extend Int16 <: Integer\<Int16>

```cangjie
extend Int16 <: Integer<Int16>
```

功能：为 [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) 类型扩展 [Integer\<T>](#interface-integert) 接口。

父类型：

- [Integer](#interface-integert)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)>

#### static func isSigned()

```cangjie
public static func isSigned(): Bool
```

功能：判断 [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) 类型是否是有符号类型。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 总是返回 `true`。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 判断 Int16 类型是否是有符号类型 */
    let signed = Int16.isSigned()

    /* 打印结果 */
    println("Int16 是有符号类型: ${signed}")
}
```

运行结果：

```text
Int16 是有符号类型: true
```

### extend Int32 <: Integer\<Int32>

```cangjie
extend Int32 <: Integer<Int32>
```

功能：为 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 类型扩展 [Integer\<T>](#interface-integert) 接口。

父类型：

- [Integer](#interface-integert)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)>

#### static func isSigned()

```cangjie
public static func isSigned(): Bool
```

功能：判断 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 类型是否是有符号类型。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 总是返回 `true`。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 判断 Int32 类型是否是有符号类型 */
    let signed = Int32.isSigned()

    /* 打印结果 */
    println("Int32 是有符号类型: ${signed}")
}
```

运行结果：

```text
Int32 是有符号类型: true
```

### extend Int64 <: Integer\<Int64>

```cangjie
extend Int64 <: Integer<Int64>
```

功能：为 [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) 类型扩展 [Integer\<T>](#interface-integert) 接口。

父类型：

- [Integer](#interface-integert)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>

#### static func isSigned()

```cangjie
public static func isSigned(): Bool
```

功能：判断 [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) 类型是否是有符号类型。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 总是返回 `true`。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 判断 Int64 类型是否是有符号类型 */
    let signed = Int64.isSigned()

    /* 打印结果 */
    println("Int64 是有符号类型: ${signed}")
}
```

运行结果：

```text
Int64 是有符号类型: true
```

### extend Int8 <: Integer\<Int8>

```cangjie
extend Int8 <: Integer<Int8>
```

功能：为 [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) 类型扩展 [Integer\<T>](#interface-integert) 接口。

父类型：

- [Integer](#interface-integert)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)>

#### static func isSigned()

```cangjie
public static func isSigned(): Bool
```

功能：判断 [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) 类型是否是有符号类型。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 总是返回 `true`。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 判断 Int8 类型是否是有符号类型 */
    let signed = Int8.isSigned()

    /* 打印结果 */
    println("Int8 是有符号类型: ${signed}")
}
```

运行结果：

```text
Int8 是有符号类型: true
```

### extend IntNative <: Integer\<IntNative>

```cangjie
extend IntNative <: Integer<IntNative>
```

功能：为 [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) 类型扩展 [Integer\<T>](#interface-integert) 接口。

父类型：

- [Integer](#interface-integert)\<[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)>

#### static func isSigned()

```cangjie
public static func isSigned(): Bool
```

功能：判断 [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) 类型是否是有符号类型。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 总是返回 `true`。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 判断 IntNative 类型是否是有符号类型 */
    let signed = IntNative.isSigned()

    /* 打印结果 */
    println("IntNative 是有符号类型: ${signed}")
}
```

运行结果：

```text
IntNative 是有符号类型: true
```

### extend UInt16 <: Integer\<UInt16>

```cangjie
extend UInt16 <: Integer<UInt16>
```

功能：为 [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) 类型扩展 [Integer\<T>](#interface-integert) 接口。

父类型：

- [Integer](#interface-integert)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)>

#### static func isSigned()

```cangjie
public static func isSigned(): Bool
```

功能：判断 [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) 类型是否是有符号类型。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 总是返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 判断 UInt16 类型是否是有符号类型 */
    let signed = UInt16.isSigned()

    /* 打印结果 */
    println("UInt16 是有符号类型: ${signed}")
}
```

运行结果：

```text
UInt16 是有符号类型: false
```

### extend UInt32 <: Integer\<UInt32>

```cangjie
extend UInt32 <: Integer<UInt32>
```

功能：为 [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) 类型扩展 [Integer\<T>](#interface-integert) 接口。

父类型：

- [Integer](#interface-integert)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)>

#### static func isSigned()

```cangjie
public static func isSigned(): Bool
```

功能：判断 [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) 类型是否是有符号类型。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 总是返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 判断 UInt32 类型是否是有符号类型 */
    let signed = UInt32.isSigned()

    /* 打印结果 */
    println("UInt32 是有符号类型: ${signed}")
}
```

运行结果：

```text
UInt32 是有符号类型: false
```

### extend UInt64 <: Integer\<UInt64>

```cangjie
extend UInt64 <: Integer<UInt64>
```

功能：为 [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) 类型扩展 [Integer\<T>](#interface-integert) 接口。

父类型：

- [Integer](#interface-integert)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)>

#### static func isSigned()

```cangjie
public static func isSigned(): Bool
```

功能：判断 [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) 类型是否是有符号类型。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 总是返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 判断 UInt64 类型是否是有符号类型 */
    let signed = UInt64.isSigned()

    /* 打印结果 */
    println("UInt64 是有符号类型: ${signed}")
}
```

运行结果：

```text
UInt64 是有符号类型: false
```

### extend UInt8 <: Integer\<UInt8>

```cangjie
extend UInt8 <: Integer<UInt8>
```

功能：为 [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) 类型扩展 [Integer\<T>](#interface-integert) 接口。

父类型：

- [Integer](#interface-integert)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)>

#### static func isSigned()

```cangjie
public static func isSigned(): Bool
```

功能：判断 [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) 类型是否是有符号类型。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 总是返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 判断 UInt8 类型是否是有符号类型 */
    let signed = UInt8.isSigned()

    /* 打印结果 */
    println("UInt8 是有符号类型: ${signed}")
}
```

运行结果：

```text
UInt8 是有符号类型: false
```

### extend UIntNative <: Integer\<UIntNative>

```cangjie
extend UIntNative <: Integer<UIntNative>
```

功能：为 [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) 类型扩展 [Integer\<T>](#interface-integert) 接口。

父类型：

- [Integer](#interface-integert)\<[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)>

#### static func isSigned()

```cangjie
public static func isSigned(): Bool
```

功能：判断 [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) 类型是否是有符号类型。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 总是返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 判断 UIntNative 类型是否是有符号类型 */
    let signed = UIntNative.isSigned()

    /* 打印结果 */
    println("UIntNative 是有符号类型: ${signed}")
}
```

运行结果：

```text
UIntNative 是有符号类型: false
```

## interface MathExtension\<T> <sup>(deprecated)</sup>

```cangjie
public interface MathExtension<T> {
    static func GetPI(): T
    static func GetE(): T
}
```

功能：本接口提供了统一的方法获取一些数学常数。

> **注意：**
>
> 未来版本即将废弃，使用 [FloatingPoint\<T>](#interface-floatingpointt) 替代。

### static func GetE()

```cangjie
static func GetE(): T
```

功能：获取 T 类型的自然常数。

返回值：

- T - 类型 T 的自然常数。

### static func GetPI()

```cangjie
static func GetPI(): T
```

功能：获取 T 类型的圆周率常数。

返回值：

- T - 类型 T 的圆周率常数。

### extend Float16 <: MathExtension\<Float16>

```cangjie
extend Float16 <: MathExtension<Float16>
```

功能：拓展半精度浮点数以支持一些数学常数。

父类型：

- [MathExtension <sup>(deprecated)</sup>](#interface-mathextensiont-deprecated)\<[Float16](../../../std/core/core_package_api/core_package_intrinsics.md#float16)>

#### static func GetE()

```cangjie
public static func GetE(): Float16
```

功能：获取半精度浮点数的自然常数。

返回值：

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - 类型的自然常数

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取半精度浮点数的自然常数 */
    let e = Float16.GetE()

    /* 打印自然常数 */
    println("Float16的自然常数: ${e}")
}
```

运行结果：

```text
Float16的自然常数: 2.718750
```

#### static func GetPI()

```cangjie
public static func GetPI(): Float16
```

功能：获取半精度浮点数的圆周率常数。

返回值：

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - 类型的圆周率常数

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取半精度浮点数的圆周率常数 */
    let pi = Float16.GetPI()

    /* 打印圆周率 */
    println("Float16的圆周率: ${pi}")
}
```

运行结果：

```text
Float16的圆周率: 3.140625
```

### extend Float32 <: MathExtension\<Float32>

```cangjie
extend Float32 <: MathExtension<Float32>
```

功能：拓展单精度浮点数以支持一些数学常数。

父类型：

- [MathExtension <sup>(deprecated)</sup>](#interface-mathextensiont-deprecated)\<[Float32](../../../std/core/core_package_api/core_package_intrinsics.md#float32)>

#### static func GetE()

```cangjie
public static func GetE(): Float32
```

功能：获取单精度浮点数的自然常数。

返回值：

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - 类型的自然常数

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取单精度浮点数的自然常数 */
    let e = Float32.GetE()

    /* 打印自然常数 */
    println("Float32的自然常数: ${e}")
}
```

运行结果：

```text
Float32的自然常数: 2.718282
```

#### static func GetPI()

```cangjie
public static func GetPI(): Float32
```

功能：获取单精度浮点数的圆周率常数。

返回值：

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - 类型的圆周率常数

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取单精度浮点数的圆周率常数 */
    let pi = Float32.GetPI()

    /* 打印圆周率 */
    println("Float32的圆周率: ${pi}")
}
```

运行结果：

```text
Float32的圆周率: 3.141593
```

### extend Float64 <: MathExtension\<Float64>

```cangjie
extend Float64 <: MathExtension<Float64>
```

功能：拓展双精度浮点数以支持一些数学常数。

父类型：

- [MathExtension <sup>(deprecated)</sup>](#interface-mathextensiont-deprecated)\<[Float64](../../../std/core/core_package_api/core_package_intrinsics.md#float64)>

#### static func GetE()

```cangjie
public static func GetE(): Float64
```

功能：获取双精度浮点数的自然常数。

返回值：

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - 类型的自然常数

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取双精度浮点数的自然常数 */
    let e = Float64.GetE()

    /* 打印自然常数 */
    println("Float64的自然常数: ${e}")
}
```

运行结果：

```text
Float64的自然常数: 2.718282
```

#### static func GetPI()

```cangjie
public static func GetPI(): Float64
```

功能：获取双精度浮点数的圆周率常数。

返回值：

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - 类型的圆周率常数

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取双精度浮点数的圆周率常数 */
    let pi = Float64.GetPI()

    /* 打印圆周率 */
    println("Float64的圆周率: ${pi}")
}
```

运行结果：

```text
Float64的圆周率: 3.141593
```

## interface MaxMinValue\<T>

```cangjie
public interface MaxMinValue<T> {
    static func getMax(): T
    static func getMin(): T
}
```

功能：提供获取最大值和最小值的方法。

### static func getMax()

```cangjie
static func getMax(): T
```

功能：获取最大值。

返回值：

- T - 最大值。

### static func getMin()

```cangjie
static func getMin(): T
```

功能：获取最小值。

返回值：

- T - 最小值。

### extend Float16 <: MaxMinValue\<Float16>

```cangjie
extend Float16 <: MaxMinValue<Float16>
```

功能：为 [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) 类型扩展 [MaxMinValue](#interface-maxminvaluet) 接口。

父类型：

- [MaxMinValue](#interface-maxminvaluet)\<[Float16](../../core/core_package_api/core_package_intrinsics.md#float16)>

#### static func getMax()

```cangjie
public static func getMax(): Float16
```

功能：获取 [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) 类型的最大值。

返回值：

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - 半精度浮点数类型的最大值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 Float16 类型的最大值 */
    let max = Float16.getMax()

    /* 打印最大值 */
    println("Float16的最大值: ${max}")
}
```

运行结果：

```text
Float16的最大值: 65504.000000
```

#### static func getMin()

```cangjie
public static func getMin(): Float16
```

功能：获取 [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) 类型的最小值。

返回值：

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - 半精度浮点数类型的最小值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 Float16 类型的最小值 */
    let min = Float16.getMin()

    /* 打印最小值 */
    println("Float16的最小值: ${min}")
}
```

运行结果：

```text
Float16的最小值: -65504.000000
```

### extend Float32 <: MaxMinValue\<Float32>

```cangjie
extend Float32 <: MaxMinValue<Float32>
```

功能：为 [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) 类型扩展 [MaxMinValue](#interface-maxminvaluet) 接口。

父类型：

- [MaxMinValue](#interface-maxminvaluet)\<[Float32](../../core/core_package_api/core_package_intrinsics.md#float32)>

#### static func getMax()

```cangjie
public static func getMax(): Float32
```

功能：获取 [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) 类型的最大值。

返回值：

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - 单精度浮点数类型的最大值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 Float32 类型的最大值 */
    let max = Float32.getMax()

    /* 打印最大值 */
    println("Float32的最大值: ${max}")
}
```

运行结果：

```text
Float32的最大值: 340282346638528859811704183484516925440.000000
```

#### static func getMin()

```cangjie
public static func getMin(): Float32
```

功能：获取 [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) 类型的最小值。

返回值：

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - 单精度浮点数类型的最小值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 Float32 类型的最小值 */
    let min = Float32.getMin()

    /* 打印最小值 */
    println("Float32的最小值: ${min}")
}
```

运行结果：

```text
Float32的最小值: -340282346638528859811704183484516925440.000000
```

### extend Float64 <: MaxMinValue\<Float64>

```cangjie
extend Float64 <: MaxMinValue<Float64>
```

功能：为 [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) 类型扩展 [MaxMinValue](#interface-maxminvaluet) 接口。

父类型：

- [MaxMinValue](#interface-maxminvaluet)\<[Float64](../../core/core_package_api/core_package_intrinsics.md#float64)>

#### static func getMax()

```cangjie
public static func getMax(): Float64
```

功能：获取 [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) 类型的最大值。

返回值：

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - 双精度浮点数类型的最大值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 Float64 类型的最大值 */
    let max = Float64.getMax()

    /* 打印最大值 */
    println("Float64的最大值: ${max}")
}
```

运行结果：

```text
Float64的最大值: 179769313486231570814527423731704356798070567525844996598917476803157260780028538760589558632766878171540458953514382464234321326889464182768467546703537516986049910576551282076245490090389328944075868508455133942304583236903222948165808559332123348274797826204144723168738177180919299881250404026184124858368.000000
```

#### static func getMin()

```cangjie
public static func getMin(): Float64
```

功能：获取 [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) 类型的最小值。

返回值：

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - 双精度浮点数类型的最小值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 Float64 类型的最小值 */
    let min = Float64.getMin()

    /* 打印最小值 */
    println("Float64的最小值: ${min}")
}
```

运行结果：

```text
Float64的最小值: -179769313486231570814527423731704356798070567525844996598917476803157260780028538760589558632766878171540458953514382464234321326889464182768467546703537516986049910576551282076245490090389328944075868508455133942304583236903222948165808559332123348274797826204144723168738177180919299881250404026184124858368.000000
```

### extend Int16 <: MaxMinValue\<Int16>

```cangjie
extend Int16 <: MaxMinValue<Int16>
```

功能：为 [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) 类型扩展 [MaxMinValue](#interface-maxminvaluet) 接口。

父类型：

- [MaxMinValue](#interface-maxminvaluet)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)>

#### static func getMax()

```cangjie
public static func getMax(): Int16
```

功能：获取 [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) 类型的最大值。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) 类型的最大值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 Int16 类型的最大值 */
    let max = Int16.getMax()

    /* 打印最大值 */
    println("Int16的最大值: ${max}")
}
```

运行结果：

```text
Int16的最大值: 32767
```

#### static func getMin()

```cangjie
public static func getMin(): Int16
```

功能：获取 [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) 类型的最小值。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) 类型的最小值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 Int16 类型的最小值 */
    let min = Int16.getMin()

    /* 打印最小值 */
    println("Int16的最小值: ${min}")
}
```

运行结果：

```text
Int16的最小值: -32768
```

### extend Int32 <: MaxMinValue\<Int32>

```cangjie
extend Int32 <: MaxMinValue<Int32>
```

功能：为 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 类型扩展 [MaxMinValue](#interface-maxminvaluet) 接口。

父类型：

- [MaxMinValue](#interface-maxminvaluet)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)>

#### static func getMax()

```cangjie
public static func getMax(): Int32
```

功能：获取 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 类型的最大值。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 类型的最大值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 Int32 类型的最大值 */
    let max = Int32.getMax()

    /* 打印最大值 */
    println("Int32的最大值: ${max}")
}
```

运行结果：

```text
Int32的最大值: 2147483647
```

#### static func getMin()

```cangjie
public static func getMin(): Int32
```

功能：获取 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 类型的最小值。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 类型的最小值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 Int32 类型的最小值 */
    let min = Int32.getMin()

    /* 打印最小值 */
    println("Int32的最小值: ${min}")
}
```

运行结果：

```text
Int32的最小值: -2147483648
```

### extend Int64 <: MaxMinValue\<Int64>

```cangjie
extend Int64 <: MaxMinValue<Int64>
```

功能：为 [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) 类型扩展 [MaxMinValue](#interface-maxminvaluet) 接口。

父类型：

- [MaxMinValue](#interface-maxminvaluet)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>

#### static func getMax()

```cangjie
public static func getMax(): Int64
```

功能：获取 [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) 类型的最大值。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) 类型的最大值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 Int64 类型的最大值 */
    let max = Int64.getMax()

    /* 打印最大值 */
    println("Int64的最大值: ${max}")
}
```

运行结果：

```text
Int64的最大值: 9223372036854775807
```

#### static func getMin()

```cangjie
public static func getMin(): Int64
```

功能：获取 [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) 类型的最小值。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) 类型的最小值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 Int64 类型的最小值 */
    let min = Int64.getMin()

    /* 打印最小值 */
    println("Int64的最小值: ${min}")
}
```

运行结果：

```text
Int64的最小值: -9223372036854775808
```

### extend Int8 <: MaxMinValue\<Int8>

```cangjie
extend Int8 <: MaxMinValue<Int8>
```

功能：为 [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) 类型扩展 [MaxMinValue](#interface-maxminvaluet) 接口。

父类型：

- [MaxMinValue](#interface-maxminvaluet)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)>

#### static func getMax()

```cangjie
public static func getMax(): Int8
```

功能：获取 [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) 类型的最大值。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) 类型的最大值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 Int8 类型的最大值 */
    let max = Int8.getMax()

    /* 打印最大值 */
    println("Int8的最大值: ${max}")
}
```

运行结果：

```text
Int8的最大值: 127
```

#### static func getMin()

```cangjie
public static func getMin(): Int8
```

功能：获取 [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) 类型的最小值。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) 类型的最小值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 Int8 类型的最小值 */
    let min = Int8.getMin()

    /* 打印最小值 */
    println("Int8的最小值: ${min}")
}
```

运行结果：

```text
Int8的最小值: -128
```

### extend IntNative <: MaxMinValue\<IntNative>

```cangjie
extend IntNative <: MaxMinValue<IntNative>
```

功能：为 [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) 类型扩展 [MaxMinValue](#interface-maxminvaluet) 接口。

父类型：

- [MaxMinValue](#interface-maxminvaluet)\<[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)>

#### static func getMax()

```cangjie
public static func getMax(): IntNative
```

功能：获取 [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) 类型的最大值。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) 类型的最大值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 IntNative 类型的最大值 */
    let max = IntNative.getMax()

    /* 打印最大值 */
    println("IntNative的最大值: ${max}")
}
```

可能的运行结果：

```text
IntNative的最大值: 9223372036854775807
```

#### static func getMin()

```cangjie
public static func getMin(): IntNative
```

功能：获取 [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) 类型的最小值。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) 类型的最小值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 IntNative 类型的最小值 */
    let min = IntNative.getMin()

    /* 打印最小值 */
    println("IntNative的最小值: ${min}")
}
```

可能的运行结果：

```text
IntNative的最小值: -9223372036854775808
```

### extend UInt16 <: MaxMinValue\<UInt16>

```cangjie
extend UInt16 <: MaxMinValue<UInt16>
```

功能：为 [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) 类型扩展 [MaxMinValue](#interface-maxminvaluet) 接口。

父类型：

- [MaxMinValue](#interface-maxminvaluet)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)>

#### static func getMax()

```cangjie
public static func getMax(): UInt16
```

功能：获取 [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) 类型的最大值。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) 类型的最大值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 UInt16 类型的最大值 */
    let max = UInt16.getMax()

    /* 打印最大值 */
    println("UInt16的最大值: ${max}")
}
```

运行结果：

```text
UInt16的最大值: 65535
```

#### static func getMin()

```cangjie
public static func getMin(): UInt16
```

功能：获取 [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) 类型的最小值。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) 类型的最小值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 UInt16 类型的最小值 */
    let min = UInt16.getMin()

    /* 打印最小值 */
    println("UInt16的最小值: ${min}")
}
```

运行结果：

```text
UInt16的最小值: 0
```

### extend UInt32 <: MaxMinValue\<UInt32>

```cangjie
extend UInt32 <: MaxMinValue<UInt32>
```

功能：为 [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) 类型扩展 [MaxMinValue](#interface-maxminvaluet) 接口。

父类型：

- [MaxMinValue](#interface-maxminvaluet)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)>

#### static func getMax()

```cangjie
public static func getMax(): UInt32
```

功能：获取 [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) 类型的最大值。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) 类型的最大值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 UInt32 类型的最大值 */
    let max = UInt32.getMax()

    /* 打印最大值 */
    println("UInt32的最大值: ${max}")
}
```

运行结果：

```text
UInt32的最大值: 4294967295
```

#### static func getMin()

```cangjie
public static func getMin(): UInt32
```

功能：获取 [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) 类型的最小值。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) 类型的最小值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 UInt32 类型的最小值 */
    let min = UInt32.getMin()

    /* 打印最小值 */
    println("UInt32的最小值: ${min}")
}
```

运行结果：

```text
UInt32的最小值: 0
```

### extend UInt64 <: MaxMinValue\<UInt64>

```cangjie
extend UInt64 <: MaxMinValue<UInt64>
```

功能：为 [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) 类型扩展 [MaxMinValue](#interface-maxminvaluet) 接口。

父类型：

- [MaxMinValue](#interface-maxminvaluet)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)>

#### static func getMax()

```cangjie
public static func getMax(): UInt64
```

功能：获取 [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) 类型的最大值。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) 类型的最大值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 UInt64 类型的最大值 */
    let max = UInt64.getMax()

    /* 打印最大值 */
    println("UInt64的最大值: ${max}")
}
```

运行结果：

```text
UInt64的最大值: 18446744073709551615
```

#### static func getMin()

```cangjie
public static func getMin(): UInt64
```

功能：获取 [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) 类型的最小值。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) 类型的最小值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 UInt64 类型的最小值 */
    let min = UInt64.getMin()

    /* 打印最小值 */
    println("UInt64的最小值: ${min}")
}
```

运行结果：

```text
UInt64的最小值: 0
```

### extend UInt8 <: MaxMinValue\<UInt8>

```cangjie
extend UInt8 <: MaxMinValue<UInt8>
```

功能：为 [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) 类型扩展 [MaxMinValue](#interface-maxminvaluet) 接口。

父类型：

- [MaxMinValue](#interface-maxminvaluet)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)>

#### static func getMax()

```cangjie
public static func getMax(): UInt8
```

功能：获取 [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) 类型的最大值。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) 类型的最大值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 UInt8 类型的最大值 */
    let max = UInt8.getMax()

    /* 打印最大值 */
    println("UInt8的最大值: ${max}")
}
```

运行结果：

```text
UInt8的最大值: 255
```

#### static func getMin()

```cangjie
public static func getMin(): UInt8
```

功能：获取 [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) 类型的最小值。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) 类型的最小值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 UInt8 类型的最小值 */
    let min = UInt8.getMin()

    /* 打印最小值 */
    println("UInt8的最小值: ${min}")
}
```

运行结果：

```text
UInt8的最小值: 0
```

### extend UIntNative <: MaxMinValue\<UIntNative>

```cangjie
extend UIntNative <: MaxMinValue<UIntNative>
```

功能：为 [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) 类型扩展 [MaxMinValue](#interface-maxminvaluet) 接口。

父类型：

- [MaxMinValue](#interface-maxminvaluet)\<[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)>

#### static func getMax()

```cangjie
public static func getMax(): UIntNative
```

功能：获取 [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) 类型的最大值。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) 类型的最大值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 UIntNative 类型的最大值 */
    let max = UIntNative.getMax()

    /* 打印最大值 */
    println("UIntNative的最大值: ${max}")
}
```

运行结果：

```text
UIntNative的最大值: 18446744073709551615
```

#### static func getMin()

```cangjie
public static func getMin(): UIntNative
```

功能：获取 [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) 类型的最小值。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) 类型的最小值。

示例：

<!-- verify -->
```cangjie
import std.math.*

main(): Unit {
    /* 获取 UIntNative 类型的最小值 */
    let min = UIntNative.getMin()

    /* 打印最小值 */
    println("UIntNative的最小值: ${min}")
}
```

运行结果：

```text
UIntNative的最小值: 0
```

## interface Number\<T>

```cangjie
public interface Number<T> {
    operator func +(rhs: T): T
    operator func -(rhs: T): T
    operator func *(rhs: T): T
    operator func /(rhs: T): T
    operator func -(): T
}
```

功能：提供数值类型相关的方法。

### operator func *(T)

```cangjie
operator func *(rhs: T): T
```

功能：算术运算符，计算乘法。

参数：

- rhs: T - 运算符右边的数，表示另一个乘数。

返回值：

- T - 计算所得积。

### operator func +(T)

```cangjie
operator func +(rhs: T): T
```

功能：算术运算符，计算加法。

参数：

- rhs: T - 运算符右边的数，表示另一个加数。

返回值：

- T - 计算所得和。

### operator func -()

```cangjie
operator func -(): T
```

功能：算术运算符，计算取负的值。

返回值：

- T - 取负的值。

### operator func -(T)

```cangjie
operator func -(rhs: T): T
```

功能：算术运算符，计算减法。

参数：

- rhs: T - 运算符右边的数，表示减数。

返回值：

- T - 计算所得差。

### operator func /(T)

```cangjie
operator func /(rhs: T): T
```

功能：算术运算符，计算除法。

参数：

- rhs: T - 运算符右边的数，表示除数。

返回值：

- T - 计算所得商。

### extend Float16 <: Number\<Float16>

```cangjie
extend Float16 <: Number<Float16> {}
```

功能：为 [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) 类型扩展 [Number\<T>](#interface-numbert) 接口。

父类型：

- [Number](#interface-numbert)\<[Float16](../../core/core_package_api/core_package_intrinsics.md#float16)>

### extend Float32 <: Number\<Float32>

```cangjie
extend Float32 <: Number<Float32> {}
```

功能：为 [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) 类型扩展 [Number\<T>](#interface-numbert) 接口。

父类型：

- [Number](#interface-numbert)\<[Float32](../../core/core_package_api/core_package_intrinsics.md#float32)>

### extend Float64 <: Number\<Float64>

```cangjie
extend Float64 <: Number<Float64> {}
```

功能：为 [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) 类型扩展 [Number\<T>](#interface-numbert) 接口。

父类型：

- [Number](#interface-numbert)\<[Float64](../../core/core_package_api/core_package_intrinsics.md#float64)>

### extend Int16 <: Number\<Int16>

```cangjie
extend Int16 <: Number<Int16> {}
```

功能：为 [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) 类型扩展 [Number\<T>](#interface-numbert) 接口。

父类型：

- [Number](#interface-numbert)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)>

### extend Int32 <: Number\<Int32>

```cangjie
extend Int32 <: Number<Int32> {}
```

功能：为 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 类型扩展 [Number\<T>](#interface-numbert) 接口。

父类型：

- [Number](#interface-numbert)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)>

### extend Int64 <: Number\<Int64>

```cangjie
extend Int64 <: Number<Int64> {}
```

功能：为 [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) 类型扩展 [Number\<T>](#interface-numbert) 接口。

父类型：

- [Number](#interface-numbert)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>

### extend Int8 <: Number\<Int8>

```cangjie
extend Int8 <: Number<Int8> {}
```

功能：为 [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) 类型扩展 [Number\<T>](#interface-numbert) 接口。

父类型：

- [Number](#interface-numbert)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)>

### extend IntNative <: Number\<IntNative>

```cangjie
extend IntNative <: Number<IntNative> {}
```

功能：为 [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) 类型扩展 [Number\<T>](#interface-numbert) 接口。

父类型：

- [Number](#interface-numbert)\<[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)>

### extend UInt16 <: Number\<UInt16>

```cangjie
extend UInt16 <: Number<UInt16> {}
```

功能：为 [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) 类型扩展 [Number\<T>](#interface-numbert) 接口。

父类型：

- [Number](#interface-numbert)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)>

### extend UInt32 <: Number\<UInt32>

```cangjie
extend UInt32 <: Number<UInt32> {}
```

功能：为 [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) 类型扩展 [Number\<T>](#interface-numbert) 接口。

父类型：

- [Number](#interface-numbert)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)>

### extend UInt64 <: Number\<UInt64>

```cangjie
extend UInt64 <: Number<UInt64> {}
```

功能：为 [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) 类型扩展 [Number\<T>](#interface-numbert) 接口。

父类型：

- [Number](#interface-numbert)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)>

### extend UInt8 <: Number\<UInt8>

```cangjie
extend UInt8 <: Number<UInt8> {}
```

功能：为 [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) 类型扩展 [Number\<T>](#interface-numbert) 接口。

父类型：

- [Number](#interface-numbert)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)>

### extend UIntNative <: Number\<UIntNative>

```cangjie
extend UIntNative <: Number<UIntNative> {}
```

功能：为 [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) 类型扩展 [Number\<T>](#interface-numbert) 接口。

父类型：

- [Number](#interface-numbert)\<[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)>
