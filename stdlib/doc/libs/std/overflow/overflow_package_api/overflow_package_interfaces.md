# 接口

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

功能：提供返回整数运算是否发生了截断以及运算结果的接口。

### func carryingAdd(T)

```cangjie
func carryingAdd(y: T): (Bool, T)
```

功能：返回一个元组，元组的第一个元素表示加法运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

参数：

- y: T - 加数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), T) - 加法运算是否发生截断以及运算的结果。

### func carryingDec()

```cangjie
func carryingDec(): (Bool, T)
```

功能：返回一个元组，元组的第一个元素表示自减运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), T) - 自减运算是否发生截断以及运算的结果。

### func carryingDiv(T)

```cangjie
func carryingDiv(y: T): (Bool, T)
```

功能：返回一个元组，元组的第一个元素表示除法运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

参数：

- y: T - 除数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), T) - 除法运算是否发生截断以及运算的结果。

### func carryingInc()

```cangjie
func carryingInc(): (Bool, T)
```

功能：返回一个元组，元组的第一个元素表示自增运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), T) - 自增运算是否发生截断以及运算的结果。

### func carryingMod(T)

```cangjie
func carryingMod(y: T): (Bool, T)
```

功能：返回一个元组，元组的第一个元素表示取余运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

参数：

- y: T - 除数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), T) - 取余运算是否发生截断以及运算的结果。

### func carryingMul(T)

```cangjie
func carryingMul(y: T): (Bool, T)
```

功能：返回一个元组，元组的第一个元素表示乘法运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

参数：

- y: T - 乘数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), T) - 乘法运算是否发生截断以及运算的结果。

### func carryingNeg()

```cangjie
func carryingNeg(): (Bool, T)
```

功能：返回一个元组，元组的第一个元素表示负号运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), T) - 负号运算是否发生截断以及运算的结果。

### func carryingShl(UInt64)

```cangjie
func carryingShl(y: UInt64): (Bool, T)
```

功能：返回一个元组，元组的第一个元素表示左移运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), T) - 左移运算是否发生截断以及运算的结果。

### func carryingShr(UInt64)

```cangjie
func carryingShr(y: UInt64): (Bool, T)
```

功能：返回一个元组，元组的第一个元素表示右移运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), T) - 右移运算是否发生截断以及运算的结果。

### func carryingSub(T)

```cangjie
func carryingSub(y: T): (Bool, T)
```

功能：返回一个元组，元组的第一个元素表示减法运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

参数：

- y: T - 减数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), T) - 减法运算是否发生截断以及运算的结果。

### extend Int16 <: CarryingOp\<Int16>

```cangjie
extend Int16 <: CarryingOp<Int16>
```

功能：为 [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) 实现 [CarryingOp](./overflow_package_interfaces.md#interface-carryingopt) 接口。

父类型：

- [CarryingOp](./overflow_package_interfaces.md#interface-carryingopt)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)>

#### func carryingAdd(Int16)

```cangjie
public func carryingAdd(y: Int16): (Bool, Int16)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的加法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 加数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int16](../../core/core_package_api/core_package_intrinsics.md#int16)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int16值
    let a = 30000i16
    let b = 10000i16
    
    // 使用carryingAdd进行加法运算
    let (overflow, result) = a.carryingAdd(b)
    
    println("Carrying add result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying add result: -25536
Overflow occurred: true
```

#### func carryingDec()

```cangjie
public func carryingDec(): (Bool, Int16)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的自减运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int16](../../core/core_package_api/core_package_intrinsics.md#int16)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int16最小值
    let a = -32768i16
    
    // 使用carryingDec进行自减运算
    let (overflow, result) = a.carryingDec()
    
    println("Carrying dec result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying dec result: 32767
Overflow occurred: true
```

#### func carryingDiv(Int16)

```cangjie
public func carryingDiv(y: Int16): (Bool, Int16)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的除法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 除数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int16](../../core/core_package_api/core_package_intrinsics.md#int16)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int16值
    let a = -32768i16
    let b = -1i16
    
    // 使用carryingDiv进行除法运算
    let (overflow, result) = a.carryingDiv(b)
    
    println("Carrying div result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying div result: -32768
Overflow occurred: true
```

#### func carryingInc()

```cangjie
public func carryingInc(): (Bool, Int16)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的自增运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int16](../../core/core_package_api/core_package_intrinsics.md#int16)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int16最大值
    let a = 32767i16
    
    // 使用carryingInc进行自增运算
    let (overflow, result) = a.carryingInc()
    
    println("Carrying inc result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying inc result: -32768
Overflow occurred: true
```

#### func carryingMod(Int16)

```cangjie
public func carryingMod(y: Int16): (Bool, Int16)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的取余运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 除数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int16](../../core/core_package_api/core_package_intrinsics.md#int16)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int16值
    let a = -32768i16
    let b = -1i16
    
    // 使用carryingMod进行取余运算
    let (overflow, result) = a.carryingMod(b)
    
    println("Carrying mod result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying mod result: 0
Overflow occurred: true
```

#### func carryingMul(Int16)

```cangjie
public func carryingMul(y: Int16): (Bool, Int16)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的乘法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 乘数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int16](../../core/core_package_api/core_package_intrinsics.md#int16)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int16值
    let a = 200i16
    let b = 200i16
    
    // 使用carryingMul进行乘法运算
    let (overflow, result) = a.carryingMul(b)
    
    println("Carrying mul result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying mul result: -25536
Overflow occurred: true
```

#### func carryingNeg()

```cangjie
public func carryingNeg(): (Bool, Int16)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的负号运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int16](../../core/core_package_api/core_package_intrinsics.md#int16)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int16最小值
    let a = -32768i16
    
    // 使用carryingNeg进行负号运算
    let (overflow, result) = a.carryingNeg()
    
    println("Carrying neg result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying neg result: -32768
Overflow occurred: true
```

#### func carryingShl(UInt64)

```cangjie
public func carryingShl(y: UInt64): (Bool, Int16)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的左移运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int16](../../core/core_package_api/core_package_intrinsics.md#int16)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int16值
    let a = 10000i16
    
    // 使用carryingShl进行左移运算
    let (overflow, result) = a.carryingShl(5u64)
    
    println("Carrying shl result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying shl result: -7680
Overflow occurred: false
```

#### func carryingShr(UInt64)

```cangjie
public func carryingShr(y: UInt64): (Bool, Int16)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的右移运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int16](../../core/core_package_api/core_package_intrinsics.md#int16)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int16值
    let a = -32768i16
    
    // 使用carryingShr进行右移运算
    let (overflow, result) = a.carryingShr(5u64)
    
    println("Carrying shr result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying shr result: -1024
Overflow occurred: false
```

#### func carryingSub(Int16)

```cangjie
public func carryingSub(y: Int16): (Bool, Int16)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的减法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 减数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int16](../../core/core_package_api/core_package_intrinsics.md#int16)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int16值
    let a = -32768i16
    let b = 1i16
    
    // 使用carryingSub进行减法运算
    let (overflow, result) = a.carryingSub(b)
    
    println("Carrying sub result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying sub result: 32767
Overflow occurred: true
```

### extend Int32 <: CarryingOp\<Int32>

```cangjie
extend Int32 <: CarryingOp<Int32>
```

功能：为 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 实现 [CarryingOp](#interface-carryingopt) 接口。

父类型：

- [CarryingOp](#interface-carryingopt)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)>

#### func carryingAdd(Int32)

```cangjie
public func carryingAdd(y: Int32): (Bool, Int32)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的加法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 加数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int32值
    let a = 2000000000i32
    let b = 2000000000i32
    
    // 使用carryingAdd进行加法运算
    let (overflow, result) = a.carryingAdd(b)
    
    println("Carrying add result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying add result: -294967296
Overflow occurred: true
```

#### func carryingDec()

```cangjie
public func carryingDec(): (Bool, Int32)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的自减运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int32最小值
    let a = -2147483648i32
    
    // 使用carryingDec进行自减运算
    let (overflow, result) = a.carryingDec()
    
    println("Carrying dec result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying dec result: 2147483647
Overflow occurred: true
```

#### func carryingDiv(Int32)

```cangjie
public func carryingDiv(y: Int32): (Bool, Int32)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的除法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 除数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int32值
    let a = -2147483648i32
    let b = -1i32
    
    // 使用carryingDiv进行除法运算
    let (overflow, result) = a.carryingDiv(b)
    
    println("Carrying div result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying div result: -2147483648
Overflow occurred: true
```

#### func carryingInc()

```cangjie
public func carryingInc(): (Bool, Int32)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的自增运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int32最大值
    let a = 2147483647i32
    
    // 使用carryingInc进行自增运算
    let (overflow, result) = a.carryingInc()
    
    println("Carrying inc result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying inc result: -2147483648
Overflow occurred: true
```

#### func carryingMod(Int32)

```cangjie
public func carryingMod(y: Int32): (Bool, Int32)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的取余运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 除数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int32值
    let a = -2147483648i32
    let b = -1i32
    
    // 使用carryingMod进行取余运算
    let (overflow, result) = a.carryingMod(b)
    
    println("Carrying mod result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying mod result: 0
Overflow occurred: true
```

#### func carryingMul(Int32)

```cangjie
public func carryingMul(y: Int32): (Bool, Int32)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的乘法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 乘数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int32值
    let a = 1000000i32
    let b = 1000000i32
    
    // 使用carryingMul进行乘法运算
    let (overflow, result) = a.carryingMul(b)
    
    println("Carrying mul result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying mul result: -727379968
Overflow occurred: true
```

#### func carryingNeg()

```cangjie
public func carryingNeg(): (Bool, Int32)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的负号运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int32最小值
    let a = -2147483648i32
    
    // 使用carryingNeg进行负号运算
    let (overflow, result) = a.carryingNeg()
    
    println("Carrying neg result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying neg result: -2147483648
Overflow occurred: true
```

#### func carryingShl(UInt64)

```cangjie
public func carryingShl(y: UInt64): (Bool, Int32)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的左移运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int32值
    let a = 1000000000i32
    
    // 使用carryingShl进行左移运算
    let (overflow, result) = a.carryingShl(5u64)
    
    println("Carrying shl result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying shl result: 1935228928
Overflow occurred: false
```

#### func carryingShr(UInt64)

```cangjie
public func carryingShr(y: UInt64): (Bool, Int32)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的右移运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int32值
    let a = -2147483648i32
    
    // 使用carryingShr进行右移运算
    let (overflow, result) = a.carryingShr(5u64)
    
    println("Carrying shr result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying shr result: -67108864
Overflow occurred: false
```

#### func carryingSub(Int32)

```cangjie
public func carryingSub(y: Int32): (Bool, Int32)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的减法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 减数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int32值
    let a = -2147483648i32
    let b = 1i32
    
    // 使用carryingSub进行减法运算
    let (overflow, result) = a.carryingSub(b)
    
    println("Carrying sub result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying sub result: 2147483647
Overflow occurred: true
```

### extend Int64 <: CarryingOp\<Int64> & CarryingPow

```cangjie
extend Int64 <: CarryingOp<Int64> & CarryingPow
```

功能：为 [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) 实现 [CarryingOp](#interface-carryingopt) 接口和 [CarryingPow](#interface-carryingpow) 接口。

父类型：

- [CarryingOp](#interface-carryingopt)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>
- [CarryingPow](#interface-carryingpow)

#### func carryingAdd(Int64)

```cangjie
public func carryingAdd(y: Int64): (Bool, Int64)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的加法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 加数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int64值
    let a = 8000000000000000000i64
    let b = 2000000000000000000i64
    
    // 使用carryingAdd进行加法运算
    let (overflow, result) = a.carryingAdd(b)
    
    println("Carrying add result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying add result: -8446744073709551616
Overflow occurred: true
```

#### func carryingDec()

```cangjie
public func carryingDec(): (Bool, Int64)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的自减运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64最小值
    let a = -9223372036854775808i64
    
    // 使用carryingDec进行自减运算
    let (overflow, result) = a.carryingDec()
    
    println("Carrying dec result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying dec result: 9223372036854775807
Overflow occurred: true
```

#### func carryingDiv(Int64)

```cangjie
public func carryingDiv(y: Int64): (Bool, Int64)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的除法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 除数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int64值
    let a = -9223372036854775808i64
    let b = -1i64
    
    // 使用carryingDiv进行除法运算
    let (overflow, result) = a.carryingDiv(b)
    
    println("Carrying div result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying div result: -9223372036854775808
Overflow occurred: true
```

#### func carryingInc()

```cangjie
public func carryingInc(): (Bool, Int64)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的自增运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64最大值
    let a = 9223372036854775807i64
    
    // 使用carryingInc进行自增运算
    let (overflow, result) = a.carryingInc()
    
    println("Carrying inc result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying inc result: -9223372036854775808
Overflow occurred: true
```

#### func carryingMod(Int64)

```cangjie
public func carryingMod(y: Int64): (Bool, Int64)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的取余运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 除数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int64值
    let a = -9223372036854775808i64
    let b = -1i64
    
    // 使用carryingMod进行取余运算
    let (overflow, result) = a.carryingMod(b)
    
    println("Carrying mod result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying mod result: 0
Overflow occurred: true
```

#### func carryingMul(Int64)

```cangjie
public func carryingMul(y: Int64): (Bool, Int64)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的乘法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 乘数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int64值
    let a = 3000000000i64
    let b = 30000000000i64
    
    // 使用carryingMul进行乘法运算
    let (overflow, result) = a.carryingMul(b)
    
    println("Carrying mul result: ${result}")
    println("Overflow occurred: ${overflow}")
    return 0
}
```

运行结果：

```text
Carrying mul result: -2233720368547758080
Overflow occurred: true
```

#### func carryingNeg()

```cangjie
public func carryingNeg(): (Bool, Int64)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的负号运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64最小值
    let a = -9223372036854775808i64
    
    // 使用carryingNeg进行负号运算
    let (overflow, result) = a.carryingNeg()
    
    println("Carrying neg result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying neg result: -9223372036854775808
Overflow occurred: true
```

#### func carryingPow(UInt64)

```cangjie
public func carryingPow(y: UInt64): (Bool, Int64)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的幂运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 指数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值和一个UInt64指数
    let a = 2i64
    let b = 64u64
    
    // 使用carryingPow进行幂运算
    let (overflow, result) = a.carryingPow(b)
    
    println("Carrying pow result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying pow result: 0
Overflow occurred: true
```

#### func carryingShl(UInt64)

```cangjie
public func carryingShl(y: UInt64): (Bool, Int64)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的左移运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值
    let a = 1000000000000000000i64
    
    // 使用carryingShl进行左移运算
    let (overflow, result) = a.carryingShl(5u64)
    
    println("Carrying shl result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying shl result: -4893488147419103232
Overflow occurred: false
```

#### func carryingShr(UInt64)

```cangjie
public func carryingShr(y: UInt64): (Bool, Int64)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的右移运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值
    let a = -9223372036854775808i64
    
    // 使用carryingShr进行右移运算
    let (overflow, result) = a.carryingShr(5u64)
    
    println("Carrying shr result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying shr result: -288230376151711744
Overflow occurred: false
```

#### func carryingSub(Int64)

```cangjie
public func carryingSub(y: Int64): (Bool, Int64)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的减法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 减数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int64值
    let a = -9223372036854775808i64
    let b = 1i64
    
    // 使用carryingSub进行减法运算
    let (overflow, result) = a.carryingSub(b)
    
    println("Carrying sub result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying sub result: 9223372036854775807
Overflow occurred: true
```

### extend Int8 <: CarryingOp\<Int8>

```cangjie
extend Int8 <: CarryingOp<Int8>
```

功能：为 [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) 实现 [CarryingOp](#interface-carryingopt) 接口。

父类型：

- [CarryingOp](#interface-carryingopt)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)>

#### func carryingAdd(Int8)

```cangjie
public func carryingAdd(y: Int8): (Bool, Int8)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的加法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 加数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int8](../../core/core_package_api/core_package_intrinsics.md#int8)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int8值
    let a = 100i8
    let b = 50i8
    
    // 使用carryingAdd进行加法运算
    let (overflow, result) = a.carryingAdd(b)
    
    println("Carrying add result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying add result: -106
Overflow occurred: true
```

#### func carryingDec()

```cangjie
public func carryingDec(): (Bool, Int8)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的自减运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int8](../../core/core_package_api/core_package_intrinsics.md#int8)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int8最小值
    let a = -128i8
    
    // 使用carryingDec进行自减运算
    let (overflow, result) = a.carryingDec()
    
    println("Carrying dec result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying dec result: 127
Overflow occurred: true
```

#### func carryingDiv(Int8)

```cangjie
public func carryingDiv(y: Int8): (Bool, Int8)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的除法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 除数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int8](../../core/core_package_api/core_package_intrinsics.md#int8)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int8值
    let a = -128i8
    let b = -1i8
    
    // 使用carryingDiv进行除法运算
    let (overflow, result) = a.carryingDiv(b)
    
    println("Carrying div result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying div result: -128
Overflow occurred: true
```

#### func carryingInc()

```cangjie
public func carryingInc(): (Bool, Int8)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的自增运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int8](../../core/core_package_api/core_package_intrinsics.md#int8)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int8最大值
    let a = 127i8
    
    // 使用carryingInc进行自增运算
    let (overflow, result) = a.carryingInc()
    
    println("Carrying inc result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying inc result: -128
Overflow occurred: true
```

#### func carryingMod(Int8)

```cangjie
public func carryingMod(y: Int8): (Bool, Int8)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的取余运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 除数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int8](../../core/core_package_api/core_package_intrinsics.md#int8)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int8值
    let a = -128i8
    let b = -1i8
    
    // 使用carryingMod进行取余运算
    let (overflow, result) = a.carryingMod(b)
    
    println("Carrying mod result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying mod result: 0
Overflow occurred: true
```

#### func carryingMul(Int8)

```cangjie
public func carryingMul(y: Int8): (Bool, Int8)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的乘法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 乘数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int8](../../core/core_package_api/core_package_intrinsics.md#int8)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int8值
    let a = 10i8
    let b = 20i8
    
    // 使用carryingMul进行乘法运算
    let (overflow, result) = a.carryingMul(b)
    
    println("Carrying mul result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying mul result: -56
Overflow occurred: true
```

#### func carryingNeg()

```cangjie
public func carryingNeg(): (Bool, Int8)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的负号运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int8](../../core/core_package_api/core_package_intrinsics.md#int8)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int8最小值
    let a = -128i8
    
    // 使用carryingNeg进行负号运算
    let (overflow, result) = a.carryingNeg()
    
    println("Carrying neg result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying neg result: -128
Overflow occurred: true
```

#### func carryingShl(UInt64)

```cangjie
public func carryingShl(y: UInt64): (Bool, Int8)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的左移运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int8](../../core/core_package_api/core_package_intrinsics.md#int8)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int8值
    let a = 100i8
    
    // 使用carryingShl进行左移运算
    let (overflow, result) = a.carryingShl(3u64)
    
    println("Carrying shl result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying shl result: 32
Overflow occurred: false
```

#### func carryingShr(UInt64)

```cangjie
public func carryingShr(y: UInt64): (Bool, Int8)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的右移运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int8](../../core/core_package_api/core_package_intrinsics.md#int8)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int8值
    let a = -128i8
    
    // 使用carryingShr进行右移运算
    let (overflow, result) = a.carryingShr(3u64)
    
    println("Carrying shr result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying shr result: -16
Overflow occurred: false
```

#### func carryingSub(Int8)

```cangjie
public func carryingSub(y: Int8):(Bool, Int8)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的减法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 减数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int8](../../core/core_package_api/core_package_intrinsics.md#int8)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int8值
    let a = -128i8
    let b = 1i8
    
    // 使用carryingSub进行减法运算
    let (overflow, result) = a.carryingSub(b)
    
    println("Carrying sub result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying sub result: 127
Overflow occurred: true
```

### extend IntNative <: CarryingOp\<IntNative>

```cangjie
extend IntNative <: CarryingOp<IntNative>
```

功能：为 [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) 实现 [CarryingOp](#interface-carryingopt) 接口。

父类型：

- [CarryingOp](#interface-carryingopt)\<[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)>

#### func carryingAdd(IntNative)

```cangjie
public func carryingAdd(y: IntNative): (Bool, IntNative)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的加法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 加数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个IntNative值
    let a: IntNative = 9223372036854775807  // IntNative的最大值，假设为64位系统
    let b: IntNative = 1000000000000000000
    
    // 使用carryingAdd进行加法运算
    let (overflow, result) = a.carryingAdd(b)
    
    println("Carrying add result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying add result: -8223372036854775809
Overflow occurred: true
```

#### func carryingDec()

```cangjie
public func carryingDec(): (Bool, IntNative)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的自减运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个IntNative最小值
    let a: IntNative = -9223372036854775808  // IntNative的最小值，假设为64位系统
    
    // 使用carryingDec进行自减运算
    let (overflow, result) = a.carryingDec()
    
    println("Carrying dec result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying dec result: 9223372036854775807
Overflow occurred: true
```

#### func carryingDiv(IntNative)

```cangjie
public func carryingDiv(y: IntNative): (Bool, IntNative)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的除法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 除数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个IntNative值
    let a: IntNative = -9223372036854775808  // IntNative的最小值，假设为64位系统
    let b: IntNative = -1
    
    // 使用carryingDiv进行除法运算
    let (overflow, result) = a.carryingDiv(b)
    
    println("Carrying div result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying div result: -9223372036854775808
Overflow occurred: true
```

#### func carryingInc()

```cangjie
public func carryingInc(): (Bool, IntNative)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的自增运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个IntNative最大值
    let a: IntNative = 9223372036854775807  // IntNative的最大值，假设为64位系统
    
    // 使用carryingInc进行自增运算
    let (overflow, result) = a.carryingInc()
    
    println("Carrying inc result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying inc result: -9223372036854775808
Overflow occurred: true
```

#### func carryingMod(IntNative)

```cangjie
public func carryingMod(y: IntNative): (Bool, IntNative)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的取余运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 除数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个IntNative值
    let a: IntNative = -9223372036854775808  // IntNative的最小值，假设为64位系统
    let b: IntNative = -1
    
    // 使用carryingMod进行取余运算
    let (overflow, result) = a.carryingMod(b)
    
    println("Carrying mod result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying mod result: 0
Overflow occurred: true
```

#### func carryingMul(IntNative)

```cangjie
public func carryingMul(y: IntNative): (Bool, IntNative)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的乘法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 乘数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个IntNative值
    let a: IntNative = 3000000000
    let b: IntNative = 30000000000
    
    // 使用carryingMul进行乘法运算
    let (overflow, result) = a.carryingMul(b)
    
    println("Carrying mul result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying mul result: -2233720368547758080
Overflow occurred: true
```

#### func carryingNeg()

```cangjie
public func carryingNeg(): (Bool, IntNative)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的负号运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个IntNative最小值
    let a: IntNative = -9223372036854775808  // IntNative的最小值，假设为64位系统
    
    // 使用carryingNeg进行负号运算
    let (overflow, result) = a.carryingNeg()
    
    println("Carrying neg result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying neg result: -9223372036854775808
Overflow occurred: true
```

#### func carryingShl(UInt64)

```cangjie
public func carryingShl(y: UInt64): (Bool, IntNative)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的左移运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个IntNative值
    let a: IntNative = 1000000000000000000
    
    // 使用carryingShl进行左移运算
    let (overflow, result) = a.carryingShl(5u64)
    
    println("Carrying shl result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying shl result: -4893488147419103232
Overflow occurred: false
```

#### func carryingShr(UInt64)

```cangjie
public func carryingShr(y: UInt64): (Bool, IntNative)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的右移运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个IntNative值
    let a: IntNative = -9223372036854775808  // IntNative的最小值，假设为64位系统
    
    // 使用carryingShr进行右移运算
    let (overflow, result) = a.carryingShr(5u64)
    
    println("Carrying shr result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying shr result: -288230376151711744
Overflow occurred: false
```

#### func carryingSub(IntNative)

```cangjie
public func carryingSub(y: IntNative): (Bool, IntNative)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的减法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 减数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个IntNative值
    let a: IntNative = -9223372036854775808  // IntNative的最小值，假设为64位系统
    let b: IntNative = 1
    
    // 使用carryingSub进行减法运算
    let (overflow, result) = a.carryingSub(b)
    
    println("Carrying sub result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying sub result: 9223372036854775807
Overflow occurred: true
```

### extend UInt16 <: CarryingOp\<UInt16>

```cangjie
extend UInt16 <: CarryingOp<UInt16>
```

功能：为 [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) 实现 [CarryingOp](#interface-carryingopt) 接口。

父类型：

- [CarryingOp](#interface-carryingopt)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)>

#### func carryingAdd(UInt16)

```cangjie
public func carryingAdd(y: UInt16): (Bool, UInt16)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的加法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 加数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt16值
    let a = 65535u16  // UInt16的最大值
    let b = 1u16
    
    // 使用carryingAdd进行加法运算
    let (overflow, result) = a.carryingAdd(b)
    
    println("Carrying add result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying add result: 0
Overflow occurred: true
```

#### func carryingDec()

```cangjie
public func carryingDec(): (Bool, UInt16)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的自减运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt16值
    let a = 0u16  // UInt16的最小值
    
    // 使用carryingDec进行自减运算
    let (overflow, result) = a.carryingDec()
    
    println("Carrying dec result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying dec result: 65535
Overflow occurred: true
```

#### func carryingDiv(UInt16)

```cangjie
public func carryingDiv(y: UInt16): (Bool, UInt16)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的除法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 除数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt16值
    let a = 65535u16  // UInt16的最大值
    let b = 2u16
    
    // 使用carryingDiv进行除法运算
    let (overflow, result) = a.carryingDiv(b)
    
    println("Carrying div result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying div result: 32767
Overflow occurred: false
```

#### func carryingInc()

```cangjie
public func carryingInc(): (Bool, UInt16)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的自增运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt16值
    let a = 65535u16  // UInt16的最大值
    
    // 使用carryingInc进行自增运算
    let (overflow, result) = a.carryingInc()
    
    println("Carrying inc result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying inc result: 0
Overflow occurred: true
```

#### func carryingMod(UInt16)

```cangjie
public func carryingMod(y: UInt16): (Bool, UInt16)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的取余运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 除数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt16值
    let a = 65535u16  // UInt16的最大值
    let b = 2u16
    
    // 使用carryingMod进行取余运算
    let (overflow, result) = a.carryingMod(b)
    
    println("Carrying mod result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying mod result: 1
Overflow occurred: false
```

#### func carryingMul(UInt16)

```cangjie
public func carryingMul(y: UInt16): (Bool, UInt16)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的乘法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 乘数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt16值
    let a = 65535u16  // UInt16的最大值
    let b = 2u16
    
    // 使用carryingMul进行乘法运算
    let (overflow, result) = a.carryingMul(b)
    
    println("Carrying mul result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying mul result: 65534
Overflow occurred: true
```

#### func carryingNeg()

```cangjie
public func carryingNeg(): (Bool, UInt16)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的负号运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt16值
    let a = 65535u16  // UInt16的最大值
    
    // 使用carryingNeg进行负号运算
    let (overflow, result) = a.carryingNeg()
    
    println("Carrying neg result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying neg result: 1
Overflow occurred: true
```

#### func carryingShl(UInt64)

```cangjie
public func carryingShl(y: UInt64): (Bool, UInt16)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的左移运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt16值
    let a = 32768u16  // 2^15
    
    // 使用carryingShl进行左移运算
    let (overflow, result) = a.carryingShl(2u64)
    
    println("Carrying shl result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying shl result: 0
Overflow occurred: false
```

#### func carryingShr(UInt64)

```cangjie
public func carryingShr(y: UInt64): (Bool, UInt16)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的右移运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt16值
    let a = 65535u16  // UInt16的最大值
    
    // 使用carryingShr进行右移运算
    let (overflow, result) = a.carryingShr(2u64)
    
    println("Carrying shr result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying shr result: 16383
Overflow occurred: false
```

#### func carryingSub(UInt16)

```cangjie
public func carryingSub(y: UInt16): (Bool, UInt16)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的减法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 减数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt16值
    let a = 0u16
    let b = 1u16
    
    // 使用carryingSub进行减法运算
    let (overflow, result) = a.carryingSub(b)
    
    println("Carrying sub result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying sub result: 65535
Overflow occurred: true
```

### extend UInt32 <: CarryingOp\<UInt32>

```cangjie
extend UInt32 <: CarryingOp<UInt32>
```

功能：为 [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) 实现 [CarryingOp](#interface-carryingopt) 接口。

父类型：

- [CarryingOp](#interface-carryingopt)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)>

#### func carryingAdd(UInt32)

```cangjie
public func carryingAdd(y: UInt32): (Bool, UInt32)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的加法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 加数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt32值
    let a = 4294967295u32  // UInt32的最大值
    let b = 1u32
    
    // 使用carryingAdd进行加法运算
    let (overflow, result) = a.carryingAdd(b)
    
    println("Carrying add result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying add result: 0
Overflow occurred: true
```

#### func carryingDec()

```cangjie
public func carryingDec(): (Bool, UInt32)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的自减运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt32值
    let a = 0u32  // UInt32的最小值
    
    // 使用carryingDec进行自减运算
    let (overflow, result) = a.carryingDec()
    
    println("Carrying dec result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying dec result: 4294967295
Overflow occurred: true
```

#### func carryingDiv(UInt32)

```cangjie
public func carryingDiv(y: UInt32): (Bool, UInt32)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的除法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 除数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt32值
    let a = 4294967295u32  // UInt32的最大值
    let b = 2u32
    
    // 使用carryingDiv进行除法运算
    let (overflow, result) = a.carryingDiv(b)
    
    println("Carrying div result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying div result: 2147483647
Overflow occurred: false
```

#### func carryingInc()

```cangjie
public func carryingInc(): (Bool, UInt32)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的自增运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt32值
    let a = 4294967295u32  // UInt32的最大值
    
    // 使用carryingInc进行自增运算
    let (overflow, result) = a.carryingInc()
    
    println("Carrying inc result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying inc result: 0
Overflow occurred: true
```

#### func carryingMod(UInt32)

```cangjie
public func carryingMod(y: UInt32): (Bool, UInt32)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的取余运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 除数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt32值
    let a = 4294967295u32  // UInt32的最大值
    let b = 2u32
    
    // 使用carryingMod进行取余运算
    let (overflow, result) = a.carryingMod(b)
    
    println("Carrying mod result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying mod result: 1
Overflow occurred: false
```

#### func carryingMul(UInt32)

```cangjie
public func carryingMul(y: UInt32): (Bool, UInt32)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的乘法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 乘数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt32值
    let a = 4294967295u32  // UInt32的最大值
    let b = 2u32
    
    // 使用carryingMul进行乘法运算
    let (overflow, result) = a.carryingMul(b)
    
    println("Carrying mul result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying mul result: 4294967294
Overflow occurred: true
```

#### func carryingNeg()

```cangjie
public func carryingNeg(): (Bool, UInt32)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的负号运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt32值
    let a = 4294967295u32  // UInt32的最大值
    
    // 使用carryingNeg进行负号运算
    let (overflow, result) = a.carryingNeg()
    
    println("Carrying neg result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying neg result: 1
Overflow occurred: true
```

#### func carryingShl(UInt64)

```cangjie
public func carryingShl(y: UInt64): (Bool, UInt32)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的左移运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt32值
    let a = 2147483648u32  // 2^31
    
    // 使用carryingShl进行左移运算
    let (overflow, result) = a.carryingShl(2u64)
    
    println("Carrying shl result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying shl result: 0
Overflow occurred: false
```

#### func carryingShr(UInt64)

```cangjie
public func carryingShr(y: UInt64): (Bool, UInt32)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的右移运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt32值
    let a = 4294967295u32  // UInt32的最大值
    
    // 使用carryingShr进行右移运算
    let (overflow, result) = a.carryingShr(2u64)
    
    println("Carrying shr result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying shr result: 1073741823
Overflow occurred: false
```

#### func carryingSub(UInt32)

```cangjie
public func carryingSub(y: UInt32): (Bool, UInt32)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的减法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 减数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt32值
    let a = 0u32
    let b = 1u32
    
    // 使用carryingSub进行减法运算
    let (overflow, result) = a.carryingSub(b)
    
    println("Carrying sub result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying sub result: 4294967295
Overflow occurred: true
```

### extend UInt64 <: CarryingOp\<UInt64>

```cangjie
extend UInt64 <: CarryingOp<UInt64>
```

功能：为 [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) 实现 [CarryingOp](#interface-carryingopt) 接口。

父类型：

- [CarryingOp](#interface-carryingopt)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)>

#### func carryingAdd(UInt64)

```cangjie
public func carryingAdd(y: UInt64): (Bool, UInt64)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的加法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 加数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt64值
    let a = 18446744073709551615u64  // UInt64的最大值
    let b = 1u64
    
    // 使用carryingAdd进行加法运算
    let (overflow, result) = a.carryingAdd(b)
    
    println("Carrying add result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying add result: 0
Overflow occurred: true
```

#### func carryingDec()

```cangjie
public func carryingDec(): (Bool, UInt64)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的自减运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt64值
    let a = 0u64  // UInt64的最小值
    
    // 使用carryingDec进行自减运算
    let (overflow, result) = a.carryingDec()
    
    println("Carrying dec result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying dec result: 18446744073709551615
Overflow occurred: true
```

#### func carryingDiv(UInt64)

```cangjie
public func carryingDiv(y: UInt64): (Bool, UInt64)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的除法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 除数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt64值
    let a = 18446744073709551615u64  // UInt64的最大值
    let b = 2u64
    
    // 使用carryingDiv进行除法运算
    let (overflow, result) = a.carryingDiv(b)
    
    println("Carrying div result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying div result: 9223372036854775807
Overflow occurred: false
```

#### func carryingInc()

```cangjie
public func carryingInc(): (Bool, UInt64)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的自增运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt64值
    let a = 18446744073709551615u64  // UInt64的最大值
    
    // 使用carryingInc进行自增运算
    let (overflow, result) = a.carryingInc()
    
    println("Carrying inc result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying inc result: 0
Overflow occurred: true
```

#### func carryingMod(UInt64)

```cangjie
public func carryingMod(y: UInt64): (Bool, UInt64)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的取余运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 除数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt64值
    let a = 18446744073709551615u64  // UInt64的最大值
    let b = 2u64
    
    // 使用carryingMod进行取余运算
    let (overflow, result) = a.carryingMod(b)
    
    println("Carrying mod result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying mod result: 1
Overflow occurred: false
```

#### func carryingMul(UInt64)

```cangjie
public func carryingMul(y: UInt64): (Bool, UInt64)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的乘法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 乘数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt64值
    let a = 18446744073709551615u64  // UInt64的最大值
    let b = 2u64
    
    // 使用carryingMul进行乘法运算
    let (overflow, result) = a.carryingMul(b)
    
    println("Carrying mul result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying mul result: 18446744073709551614
Overflow occurred: true
```

#### func carryingNeg()

```cangjie
public func carryingNeg(): (Bool, UInt64)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的负号运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt64值
    let a = 18446744073709551615u64  // UInt64的最大值
    
    // 使用carryingNeg进行负号运算
    let (overflow, result) = a.carryingNeg()
    
    println("Carrying neg result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying neg result: 1
Overflow occurred: true
```

#### func carryingShl(UInt64)

```cangjie
public func carryingShl(y: UInt64): (Bool, UInt64)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的左移运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt64值
    let a = 9223372036854775808u64  // 2^63
    
    // 使用carryingShl进行左移运算
    let (overflow, result) = a.carryingShl(2u64)
    
    println("Carrying shl result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying shl result: 0
Overflow occurred: false
```

#### func carryingShr(UInt64)

```cangjie
public func carryingShr(y: UInt64): (Bool, UInt64)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的右移运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt64值
    let a = 18446744073709551615u64  // UInt64的最大值
    
    // 使用carryingShr进行右移运算
    let (overflow, result) = a.carryingShr(2u64)
    
    println("Carrying shr result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying shr result: 4611686018427387903
Overflow occurred: false
```

#### func carryingSub(UInt64)

```cangjie
public func carryingSub(y: UInt64): (Bool, UInt64)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的减法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 减数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt64值
    let a = 0u64
    let b = 1u64
    
    // 使用carryingSub进行减法运算
    let (overflow, result) = a.carryingSub(b)
    
    println("Carrying sub result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying sub result: 18446744073709551615
Overflow occurred: true
```

### extend UInt8 <: CarryingOp\<UInt8>

```cangjie
extend UInt8 <: CarryingOp<UInt8>
```

功能：为 [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) 实现 [CarryingOp](#interface-carryingopt) 接口。

父类型：

- [CarryingOp](#interface-carryingopt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)>

#### func carryingAdd(UInt8)

```cangjie
public func carryingAdd(y: UInt8): (Bool, UInt8)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的加法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 加数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt8值
    let a = 255u8  // UInt8的最大值
    let b = 1u8
    
    // 使用carryingAdd进行加法运算
    let (overflow, result) = a.carryingAdd(b)
    
    println("Carrying add result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying add result: 0
Overflow occurred: true
```

#### func carryingDec()

```cangjie
public func carryingDec(): (Bool, UInt8)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的自减运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt8值
    let a = 0u8  // UInt8的最小值
    
    // 使用carryingDec进行自减运算
    let (overflow, result) = a.carryingDec()
    
    println("Carrying dec result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying dec result: 255
Overflow occurred: true
```

#### func carryingDiv(UInt8)

```cangjie
public func carryingDiv(y: UInt8): (Bool, UInt8)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的除法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 除数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt8值
    let a = 255u8  // UInt8的最大值
    let b = 2u8
    
    // 使用carryingDiv进行除法运算
    let (overflow, result) = a.carryingDiv(b)
    
    println("Carrying div result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying div result: 127
Overflow occurred: false
```

#### func carryingInc()

```cangjie
public func carryingInc(): (Bool, UInt8)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的自增运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt8值
    let a = 255u8  // UInt8的最大值
    
    // 使用carryingInc进行自增运算
    let (overflow, result) = a.carryingInc()
    
    println("Carrying inc result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying inc result: 0
Overflow occurred: true
```

#### func carryingMod(UInt8)

```cangjie
public func carryingMod(y: UInt8): (Bool, UInt8)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的取余运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 除数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt8值
    let a = 255u8  // UInt8的最大值
    let b = 2u8
    
    // 使用carryingMod进行取余运算
    let (overflow, result) = a.carryingMod(b)
    
    println("Carrying mod result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying mod result: 1
Overflow occurred: false
```

#### func carryingMul(UInt8)

```cangjie
public func carryingMul(y: UInt8): (Bool, UInt8)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的乘法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 乘数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt8值
    let a = 255u8  // UInt8的最大值
    let b = 2u8
    
    // 使用carryingMul进行乘法运算
    let (overflow, result) = a.carryingMul(b)
    
    println("Carrying mul result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying mul result: 254
Overflow occurred: true
```

#### func carryingNeg()

```cangjie
public func carryingNeg(): (Bool, UInt8)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的负号运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt8值
    let a = 255u8  // UInt8的最大值
    
    // 使用carryingNeg进行负号运算
    let (overflow, result) = a.carryingNeg()
    
    println("Carrying neg result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying neg result: 1
Overflow occurred: true
```

#### func carryingShl(UInt64)

```cangjie
public func carryingShl(y: UInt64): (Bool, UInt8)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的左移运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt8值
    let a = 128u8  // 2^7
    
    // 使用carryingShl进行左移运算
    let (overflow, result) = a.carryingShl(2u64)
    
    println("Carrying shl result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying shl result: 0
Overflow occurred: false
```

#### func carryingShr(UInt64)

```cangjie
public func carryingShr(y: UInt64): (Bool, UInt8)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的右移运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt8值
    let a = 255u8  // UInt8的最大值
    
    // 使用carryingShr进行右移运算
    let (overflow, result) = a.carryingShr(2u64)
    
    println("Carrying shr result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying shr result: 63
Overflow occurred: false
```

#### func carryingSub(UInt8)

```cangjie
public func carryingSub(y: UInt8): (Bool, UInt8)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的减法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 减数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt8值
    let a = 0u8
    let b = 1u8
    
    // 使用carryingSub进行减法运算
    let (overflow, result) = a.carryingSub(b)
    
    println("Carrying sub result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying sub result: 255
Overflow occurred: true
```

### extend UIntNative <: CarryingOp\<UIntNative>

```cangjie
extend UIntNative <: CarryingOp<UIntNative>
```

功能：为 [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) 实现 [CarryingOp](#interface-carryingopt) 接口。

父类型：

- [CarryingOp](#interface-carryingopt)\<[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)>

#### func carryingAdd(UIntNative)

```cangjie
public func carryingAdd(y: UIntNative): (Bool, UIntNative)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的加法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 加数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UIntNative值
    let a = 18446744073709551615u64  // UIntNative的最大值 (假设为64位)
    let b = 1u64
    
    // 使用carryingAdd进行加法运算
    let (overflow, result) = a.carryingAdd(b)
    
    println("Carrying add result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying add result: 0
Overflow occurred: true
```

#### func carryingDec()

```cangjie
public func carryingDec(): (Bool, UIntNative)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的自减运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UIntNative值
    let a = 0u64  // UIntNative的最小值 (假设为64位)
    
    // 使用carryingDec进行自减运算
    let (overflow, result) = a.carryingDec()
    
    println("Carrying dec result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying dec result: 18446744073709551615
Overflow occurred: true
```

#### func carryingDiv(UIntNative)

```cangjie
public func carryingDiv(y: UIntNative): (Bool, UIntNative)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的除法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 除数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UIntNative值
    let a = 18446744073709551615u64  // UIntNative的最大值 (假设为64位)
    let b = 2u64
    
    // 使用carryingDiv进行除法运算
    let (overflow, result) = a.carryingDiv(b)
    
    println("Carrying div result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying div result: 9223372036854775807
Overflow occurred: false
```

#### func carryingInc()

```cangjie
public func carryingInc(): (Bool, UIntNative)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的自增运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UIntNative值
    let a = 18446744073709551615u64  // UIntNative的最大值 (假设为64位)
    
    // 使用carryingInc进行自增运算
    let (overflow, result) = a.carryingInc()
    
    println("Carrying inc result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying inc result: 0
Overflow occurred: true
```

#### func carryingMod(UIntNative)

```cangjie
public func carryingMod(y: UIntNative): (Bool, UIntNative)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的取余运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 除数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UIntNative值
    let a = 18446744073709551615u64  // UIntNative的最大值 (假设为64位)
    let b = 2u64
    
    // 使用carryingMod进行取余运算
    let (overflow, result) = a.carryingMod(b)
    
    println("Carrying mod result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying mod result: 1
Overflow occurred: false
```

#### func carryingMul(UIntNative)

```cangjie
public func carryingMul(y: UIntNative): (Bool, UIntNative)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的乘法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 乘数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UIntNative值
    let a = 18446744073709551615u64  // UIntNative的最大值 (假设为64位)
    let b = 2u64
    
    // 使用carryingMul进行乘法运算
    let (overflow, result) = a.carryingMul(b)
    
    println("Carrying mul result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying mul result: 18446744073709551614
Overflow occurred: true
```

#### func carryingNeg()

```cangjie
public func carryingNeg(): (Bool, UIntNative)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的负号运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UIntNative值
    let a = 18446744073709551615u64  // UIntNative的最大值 (假设为64位)
    
    // 使用carryingNeg进行负号运算
    let (overflow, result) = a.carryingNeg()
    
    println("Carrying neg result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying neg result: 1
Overflow occurred: true
```

#### func carryingShl(UInt64)

```cangjie
public func carryingShl(y: UInt64): (Bool, UIntNative)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的左移运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UIntNative值
    let a = 9223372036854775808u64  // 2^63 (假设为64位)
    
    // 使用carryingShl进行左移运算
    let (overflow, result) = a.carryingShl(2u64)
    
    println("Carrying shl result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying shl result: 0
Overflow occurred: false
```

#### func carryingShr(UInt64)

```cangjie
public func carryingShr(y: UInt64): (Bool, UIntNative)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的右移运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UIntNative值
    let a = 18446744073709551615u64  // UIntNative的最大值 (假设为64位)
    
    // 使用carryingShr进行右移运算
    let (overflow, result) = a.carryingShr(2u64)
    
    println("Carrying shr result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying shr result: 4611686018427387903
Overflow occurred: false
```

#### func carryingSub(UIntNative)

```cangjie
public func carryingSub(y: UIntNative): (Bool, UIntNative)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的减法运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 减数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UIntNative值
    let a = 0u64  // UIntNative的最小值 (假设为64位)
    let b = 1u64
    
    // 使用carryingSub进行减法运算
    let (overflow, result) = a.carryingSub(b)
    
    println("Carrying sub result: ${result}")
    println("Overflow occurred: ${overflow}")
    
    return 0
}
```

运行结果：

```text
Carrying sub result: 18446744073709551615
Overflow occurred: true
```

## interface CarryingPow

```cangjie
public interface CarryingPow {
  func carryingPow(y: UInt64): (Bool, Int64)
}
```

功能：提供使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的幂运算接口。

### func carryingPow(UInt64)

```cangjie
func carryingPow(y: UInt64): (Bool, Int64)
```

功能：使用 [wrapping](./overflow_package_interfaces.md#interface-wrappingopt) 策略的幂运算。

当运算出现溢出时，返回 `true` 和运算结果，否则返回 `false` 和运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 指数。

返回值：

- ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) - 返回一个元组，元组的第一个元素表示运算是否发生了截断，发生截断时为 `true`，元组的第二个元素是运算的结果。

## interface CheckedOp\<T>

```cangjie
public interface CheckedOp<T> {
    func checkedAdd(y: T): ?T
    func checkedDec(): ?T
    func checkedDiv(y: T): ?T
    func checkedInc(): ?T
    func checkedMod(y: T): ?T
    func checkedMul(y: T): ?T
    func checkedNeg(): ?T
    func checkedShl(y: UInt64): ?T
    func checkedShr(y: UInt64): ?T
    func checkedSub(y: T): ?T
}
```

功能：当整数运算出现溢出，返回 `None`。

### func checkedAdd(T)

```cangjie
func checkedAdd(y: T): ?T
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的加法运算。

当运算出现溢出时，返回 `?T.None`，否则返回运算结果。

参数：

- y: T - 加数。

返回值：

- ?T - 加法运算结果。

### func checkedDec()

```cangjie
func checkedDec(): ?T
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的自减运算。

当运算出现溢出时，返回 `?T.None`，否则返回运算结果。

返回值：

- ?T - 自减运算结果。

### func checkedDiv(T)

```cangjie
func checkedDiv(y: T): ?T
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的除法运算。

当运算出现溢出时，返回 `?T.None`，否则返回运算结果。

参数：

- y: T - 除数。

返回值：

- ?T - 除法运算结果。

### func checkedInc()

```cangjie
func checkedInc(): ?T
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的自增运算。

当运算出现溢出时，返回 `?T.None`，否则返回运算结果。

返回值：

- ?T - 自增运算结果。

### func checkedMod(T)

```cangjie
func checkedMod(y: T): ?T
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的取余运算。

当运算出现溢出时，返回 `?T.None`，否则返回运算结果。

参数：

- y: T - 除数。

返回值：

- ?T - 取余运算结果。

### func checkedMul(T)

```cangjie
func checkedMul(y: T): ?T
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的乘法运算。

当运算出现溢出时，返回 `?T.None`，否则返回运算结果。

参数：

- y: T - 乘数。

返回值：

- ?T - 乘法运算结果。

### func checkedNeg()

```cangjie
func checkedNeg(): ?T
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的负号运算。

当运算出现溢出时，返回 `?T.None`，否则返回运算结果。

返回值：

- ?T - 负号运算结果。

### func checkedShl(UInt64)

```cangjie
func checkedShl(y: UInt64): ?T
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的左移运算。

当移位位数大于等于操作数位数时，返回 `?T.None`，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ?T - 左移运算结果。

### func checkedShr(UInt64)

```cangjie
func checkedShr(y: UInt64): ?T
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的右移运算。

当移位位数大于等于操作数位数时，返回 `?T.None`，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ?T - 右移运算结果。

### func checkedSub(T)

```cangjie
func checkedSub(y: T): ?T
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的减法运算。

当运算出现溢出时，返回 `?T.None`，否则返回运算结果。

参数：

- y: T - 减数。

返回值：

- ?T - 减法运算结果。

### extend Int16 <: CheckedOp\<Int16>

```cangjie
extend Int16 <: CheckedOp<Int16>
```

功能：为 [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) 实现 [CheckedOp](#interface-checkedopt) 接口。

父类型：

- [CheckedOp](#interface-checkedopt)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)>

#### func checkedAdd(Int16)

```cangjie
public func checkedAdd(y: Int16): ?Int16
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的加法运算。

当运算出现溢出时，返回 ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16).None，否则返回运算结果。

参数：

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 加数。

返回值：

- ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int16值，使它们相加会发生溢出
    let a1 = 32767i16  // Int16的最大值
    let b1 = 1i16
    
    // 使用checkedAdd进行加法运算（溢出情况）
    let result1 = a1.checkedAdd(b1)
    
    // 直接打印结果
    println("Overflow case - Checked add result: ${result1}")
    
    // 创建两个Int16值，使它们相加不会发生溢出
    let a2 = 100i16
    let b2 = 200i16
    
    // 使用checkedAdd进行加法运算（正常情况）
    let result2 = a2.checkedAdd(b2)
    
    // 直接打印结果
    println("Normal case - Checked add result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked add result: None
Normal case - Checked add result: Some(300)
```

#### func checkedDec()

```cangjie
public func checkedDec(): ?Int16
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的自减运算。

当运算出现溢出时，返回 ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16).None，否则返回运算结果。

返回值：

- ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int16值，使其自减会发生溢出
    let a1 = -32768i16  // Int16的最小值
    
    // 使用checkedDec进行自减运算（溢出情况）
    let result1 = a1.checkedDec()
    
    // 直接打印结果
    println("Overflow case - Checked dec result: ${result1}")
    
    // 创建一个Int16值，使其自减不会发生溢出
    let a2 = 100i16
    
    // 使用checkedDec进行自减运算（正常情况）
    let result2 = a2.checkedDec()
    
    // 直接打印结果
    println("Normal case - Checked dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked dec result: None
Normal case - Checked dec result: Some(99)
```

#### func checkedDiv(Int16)

```cangjie
public func checkedDiv(y: Int16): ?Int16
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的除法运算。

当运算出现溢出时，返回 ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16).None，否则返回运算结果。

参数：

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 除数。

返回值：

- ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int16值，使除法运算会发生溢出
    let a1 = -32768i16  // Int16的最小值
    let b1 = -1i16      // 除数
    
    // 使用checkedDiv进行除法运算（溢出情况）
    let result1 = a1.checkedDiv(b1)
    
    // 直接打印结果
    println("Overflow case - Checked div result: ${result1}")
    
    // 创建两个Int16值，使除法运算不会发生溢出
    let a2 = 100i16
    let b2 = 2i16
    
    // 使用checkedDiv进行除法运算（正常情况）
    let result2 = a2.checkedDiv(b2)
    
    // 直接打印结果
    println("Normal case - Checked div result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked div result: None
Normal case - Checked div result: Some(50)
```

#### func checkedInc()

```cangjie
public func checkedInc(): ?Int16
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的自增运算。

当运算出现溢出时，返回 ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16).None，否则返回运算结果。

返回值：

- ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int16值，使其自增会发生溢出
    let a1 = 32767i16  // Int16的最大值
    
    // 使用checkedInc进行自增运算（溢出情况）
    let result1 = a1.checkedInc()
    
    // 直接打印结果
    println("Overflow case - Checked inc result: ${result1}")
    
    // 创建一个Int16值，使其自增不会发生溢出
    let a2 = 100i16
    
    // 使用checkedInc进行自增运算（正常情况）
    let result2 = a2.checkedInc()
    
    // 直接打印结果
    println("Normal case - Checked inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked inc result: None
Normal case - Checked inc result: Some(101)
```

#### func checkedMod(Int16)

```cangjie
public func checkedMod(y: Int16): ?Int16
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的取余运算。

当运算出现溢出时，返回 ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16).None，否则返回运算结果。

参数：

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 除数。

返回值：

- ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int16值，使取余运算会发生溢出
    let a1 = -32768i16  // Int16的最小值
    let b1 = -1i16      // 除数
    
    // 使用checkedMod进行取余运算（溢出情况）
    let result1 = a1.checkedMod(b1)
    
    // 直接打印结果
    println("Overflow case - Checked mod result: ${result1}")
    
    // 创建两个Int16值，使取余运算不会发生溢出
    let a2 = 100i16
    let b2 = 3i16
    
    // 使用checkedMod进行取余运算（正常情况）
    let result2 = a2.checkedMod(b2)
    
    // 直接打印结果
    println("Normal case - Checked mod result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked mod result: None
Normal case - Checked mod result: Some(1)
```

#### func checkedMul(Int16)

```cangjie
public func checkedMul(y: Int16): ?Int16
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的乘法运算。

当运算出现溢出时，返回 ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16).None，否则返回运算结果。

参数：

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 乘数。

返回值：

- ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int16值，使乘法运算会发生溢出
    let a1 = 32767i16   // Int16的最大值
    let b1 = 2i16       // 乘数
    
    // 使用checkedMul进行乘法运算（溢出情况）
    let result1 = a1.checkedMul(b1)
    
    // 直接打印结果
    println("Overflow case - Checked mul result: ${result1}")
    
    // 创建两个Int16值，使乘法运算不会发生溢出
    let a2 = 100i16
    let b2 = 3i16
    
    // 使用checkedMul进行乘法运算（正常情况）
    let result2 = a2.checkedMul(b2)
    
    // 直接打印结果
    println("Normal case - Checked mul result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked mul result: None
Normal case - Checked mul result: Some(300)
```

#### func checkedNeg()

```cangjie
public func checkedNeg(): ?Int16
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的负号运算。

当运算出现溢出时，返回 ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16).None，否则返回运算结果。

返回值：

- ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int16值，使其负号运算会发生溢出
    let a1 = -32768i16  // Int16的最小值
    
    // 使用checkedNeg进行负号运算（溢出情况）
    let result1 = a1.checkedNeg()
    
    // 直接打印结果
    println("Overflow case - Checked neg result: ${result1}")
    
    // 创建一个Int16值，使其负号运算不会发生溢出
    let a2 = 100i16
    
    // 使用checkedNeg进行负号运算（正常情况）
    let result2 = a2.checkedNeg()
    
    // 直接打印结果
    println("Normal case - Checked neg result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked neg result: None
Normal case - Checked neg result: Some(-100)
```

#### func checkedShl(UInt64)

```cangjie
public func checkedShl(y: UInt64): ?Int16
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的左移运算。

当移位位数大于等于操作数位数时，返回 ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int16值和移位位数，使左移运算会发生溢出
    let a1 = 1i16
    let b1 = 64u64  // 移位位数大于等于操作数位数
    
    // 使用checkedShl进行左移运算（溢出情况）
    let result1 = a1.checkedShl(b1)
    
    // 直接打印结果
    println("Overflow case - Checked shl result: ${result1}")
    
    // 创建一个Int16值和移位位数，使左移运算不会发生溢出
    let a2 = 1i16
    let b2 = 2u64   // 移位位数小于操作数位数
    
    // 使用checkedShl进行左移运算（正常情况）
    let result2 = a2.checkedShl(b2)
    
    // 直接打印结果
    println("Normal case - Checked shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked shl result: None
Normal case - Checked shl result: Some(4)
```

#### func checkedShr(UInt64)

```cangjie
public func checkedShr(y: UInt64): ?Int16
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的右移运算。

当移位位数大于等于操作数位数时，返回 ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int16值和移位位数，使右移运算会发生溢出
    let a1 = 1i16
    let b1 = 64u64  // 移位位数大于等于操作数位数
    
    // 使用checkedShr进行右移运算（溢出情况）
    let result1 = a1.checkedShr(b1)
    
    // 直接打印结果
    println("Overflow case - Checked shr result: ${result1}")
    
    // 创建一个Int16值和移位位数，使右移运算不会发生溢出
    let a2 = 8i16
    let b2 = 2u64   // 移位位数小于操作数位数
    
    // 使用checkedShr进行右移运算（正常情况）
    let result2 = a2.checkedShr(b2)
    
    // 直接打印结果
    println("Normal case - Checked shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked shr result: None
Normal case - Checked shr result: Some(2)
```

#### func checkedSub(Int16)

```cangjie
public func checkedSub(y: Int16): ?Int16
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的减法运算。

当运算出现溢出时，返回 ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16).None，否则返回运算结果。

参数：

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 减数。

返回值：

- ?[Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int16值，使减法运算会发生溢出
    let a1 = -32768i16  // Int16的最小值
    let b1 = 1i16       // 减数
    
    // 使用checkedSub进行减法运算（溢出情况）
    let result1 = a1.checkedSub(b1)
    
    // 直接打印结果
    println("Overflow case - Checked sub result: ${result1}")
    
    // 创建两个Int16值，使减法运算不会发生溢出
    let a2 = 100i16
    let b2 = 50i16
    
    // 使用checkedSub进行减法运算（正常情况）
    let result2 = a2.checkedSub(b2)
    
    // 直接打印结果
    println("Normal case - Checked sub result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked sub result: None
Normal case - Checked sub result: Some(50)
```

### extend Int32 <: CheckedOp\<Int32>

```cangjie
extend Int32 <: CheckedOp<Int32>
```

功能：为 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 实现 [CheckedOp](#interface-checkedopt) 接口。

父类型：

- [CheckedOp](#interface-checkedopt)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)>

#### func checkedAdd(Int32)

```cangjie
public func checkedAdd(y: Int32): ?Int32
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的加法运算。

当运算出现溢出时，返回 ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).None，否则返回运算结果。

参数：

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 加数。

返回值：

- ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int32值，使它们相加会发生溢出
    let a1 = 2147483647i32  // Int32的最大值
    let b1 = 1i32
    
    // 使用checkedAdd进行加法运算（溢出情况）
    let result1 = a1.checkedAdd(b1)
    
    // 直接打印结果
    println("Overflow case - Checked add result: ${result1}")
    
    // 创建两个Int32值，使它们相加不会发生溢出
    let a2 = 100i32
    let b2 = 200i32
    
    // 使用checkedAdd进行加法运算（正常情况）
    let result2 = a2.checkedAdd(b2)
    
    // 直接打印结果
    println("Normal case - Checked add result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked add result: None
Normal case - Checked add result: Some(300)
```

#### func checkedDec()

```cangjie
public func checkedDec(): ?Int32
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的自减运算。

当运算出现溢出时，返回 ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).None，否则返回运算结果。

返回值：

- ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int32值，使其自减会发生溢出
    let a1 = -2147483648i32  // Int32的最小值
    
    // 使用checkedDec进行自减运算（溢出情况）
    let result1 = a1.checkedDec()
    
    // 直接打印结果
    println("Overflow case - Checked dec result: ${result1}")
    
    // 创建一个Int32值，使其自减不会发生溢出
    let a2 = 100i32
    
    // 使用checkedDec进行自减运算（正常情况）
    let result2 = a2.checkedDec()
    
    // 直接打印结果
    println("Normal case - Checked dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked dec result: None
Normal case - Checked dec result: Some(99)
```

#### func checkedDiv(Int32)

```cangjie
public func checkedDiv(y: Int32): ?Int32
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的除法运算。

当运算出现溢出时，返回 ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).None，否则返回运算结果。

参数：

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 除数。

返回值：

- ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int32值，使除法运算会发生溢出
    let a1 = -2147483648i32  // Int32的最小值
    let b1 = -1i32           // 除数
    
    // 使用checkedDiv进行除法运算（溢出情况）
    let result1 = a1.checkedDiv(b1)
    
    // 直接打印结果
    println("Overflow case - Checked div result: ${result1}")
    
    // 创建两个Int32值，使除法运算不会发生溢出
    let a2 = 100i32
    let b2 = 2i32
    
    // 使用checkedDiv进行除法运算（正常情况）
    let result2 = a2.checkedDiv(b2)
    
    // 直接打印结果
    println("Normal case - Checked div result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked div result: None
Normal case - Checked div result: Some(50)
```

#### func checkedInc()

```cangjie
public func checkedInc(): ?Int32
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的自增运算。

当运算出现溢出时，返回 ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).None，否则返回运算结果。

返回值：

- ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int32值，使其自增会发生溢出
    let a1 = 2147483647i32  // Int32的最大值
    
    // 使用checkedInc进行自增运算（溢出情况）
    let result1 = a1.checkedInc()
    
    // 直接打印结果
    println("Overflow case - Checked inc result: ${result1}")
    
    // 创建一个Int32值，使其自增不会发生溢出
    let a2 = 100i32
    
    // 使用checkedInc进行自增运算（正常情况）
    let result2 = a2.checkedInc()
    
    // 直接打印结果
    println("Normal case - Checked inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked inc result: None
Normal case - Checked inc result: Some(101)
```

#### func checkedMod(Int32)

```cangjie
public func checkedMod(y: Int32): ?Int32
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的取余运算。

当运算出现溢出时，返回 ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).None，否则返回运算结果。

参数：

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 除数。

返回值：

- ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int32值，使取余运算会发生溢出
    let a1 = -2147483648i32  // Int32的最小值
    let b1 = -1i32           // 除数
    
    // 使用checkedMod进行取余运算（溢出情况）
    let result1 = a1.checkedMod(b1)
    
    // 直接打印结果
    println("Overflow case - Checked mod result: ${result1}")
    
    // 创建两个Int32值，使取余运算不会发生溢出
    let a2 = 100i32
    let b2 = 3i32
    
    // 使用checkedMod进行取余运算（正常情况）
    let result2 = a2.checkedMod(b2)
    
    // 直接打印结果
    println("Normal case - Checked mod result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked mod result: None
Normal case - Checked mod result: Some(1)
```

#### func checkedMul(Int32)

```cangjie
public func checkedMul(y: Int32): ?Int32
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的乘法运算。

当运算出现溢出时，返回 ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).None，否则返回运算结果。

参数：

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 乘数。

返回值：

- ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int32值，使乘法运算会发生溢出
    let a1 = 2147483647i32   // Int32的最大值
    let b1 = 2i32            // 乘数
    
    // 使用checkedMul进行乘法运算（溢出情况）
    let result1 = a1.checkedMul(b1)
    
    // 直接打印结果
    println("Overflow case - Checked mul result: ${result1}")
    
    // 创建两个Int32值，使乘法运算不会发生溢出
    let a2 = 100i32
    let b2 = 3i32
    
    // 使用checkedMul进行乘法运算（正常情况）
    let result2 = a2.checkedMul(b2)
    
    // 直接打印结果
    println("Normal case - Checked mul result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked mul result: None
Normal case - Checked mul result: Some(300)
```

#### func checkedNeg()

```cangjie
public func checkedNeg(): ?Int32
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的负号运算。

当运算出现溢出时，返回 ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).None，否则返回运算结果。

返回值：

- ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int32值，使其负号运算会发生溢出
    let a1 = -2147483648i32  // Int32的最小值
    
    // 使用checkedNeg进行负号运算（溢出情况）
    let result1 = a1.checkedNeg()
    
    // 直接打印结果
    println("Overflow case - Checked neg result: ${result1}")
    
    // 创建一个Int32值，使其负号运算不会发生溢出
    let a2 = 100i32
    
    // 使用checkedNeg进行负号运算（正常情况）
    let result2 = a2.checkedNeg()
    
    // 直接打印结果
    println("Normal case - Checked neg result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked neg result: None
Normal case - Checked neg result: Some(-100)
```

#### func checkedShl(UInt64)

```cangjie
public func checkedShl(y: UInt64): ?Int32
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的左移运算。

当移位位数大于等于操作数位数时，返回 ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int32值和移位位数，使左移运算会发生溢出
    let a1 = 1i32
    let b1 = 64u64  // 移位位数大于等于操作数位数
    
    // 使用checkedShl进行左移运算（溢出情况）
    let result1 = a1.checkedShl(b1)
    
    // 直接打印结果
    println("Overflow case - Checked shl result: ${result1}")
    
    // 创建一个Int32值和移位位数，使左移运算不会发生溢出
    let a2 = 1i32
    let b2 = 2u64   // 移位位数小于操作数位数
    
    // 使用checkedShl进行左移运算（正常情况）
    let result2 = a2.checkedShl(b2)
    
    // 直接打印结果
    println("Normal case - Checked shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked shl result: None
Normal case - Checked shl result: Some(4)
```

#### func checkedShr(UInt64)

```cangjie
public func checkedShr(y: UInt64): ?Int32
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的右移运算。

当移位位数大于等于操作数位数时，返回 ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int32值和移位位数，使右移运算会发生溢出
    let a1 = 1i32
    let b1 = 64u64  // 移位位数大于等于操作数位数
    
    // 使用checkedShr进行右移运算（溢出情况）
    let result1 = a1.checkedShr(b1)
    
    // 直接打印结果
    println("Overflow case - Checked shr result: ${result1}")
    
    // 创建一个Int32值和移位位数，使右移运算不会发生溢出
    let a2 = 8i32
    let b2 = 2u64   // 移位位数小于操作数位数
    
    // 使用checkedShr进行右移运算（正常情况）
    let result2 = a2.checkedShr(b2)
    
    // 直接打印结果
    println("Normal case - Checked shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked shr result: None
Normal case - Checked shr result: Some(2)
```

#### func checkedSub(Int32)

```cangjie
public func checkedSub(y: Int32): ?Int32
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的减法运算。

当运算出现溢出时，返回 ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32).None，否则返回运算结果。

参数：

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 减数。

返回值：

- ?[Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int32值，使减法运算会发生溢出
    let a1 = -2147483648i32  // Int32的最小值
    let b1 = 1i32            // 减数
    
    // 使用checkedSub进行减法运算（溢出情况）
    let result1 = a1.checkedSub(b1)
    
    // 直接打印结果
    println("Overflow case - Checked sub result: ${result1}")
    
    // 创建两个Int32值，使减法运算不会发生溢出
    let a2 = 100i32
    let b2 = 50i32
    
    // 使用checkedSub进行减法运算（正常情况）
    let result2 = a2.checkedSub(b2)
    
    // 直接打印结果
    println("Normal case - Checked sub result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked sub result: None
Normal case - Checked sub result: Some(50)
```

### extend Int64 <: CheckedOp\<Int64> & CheckedPow

```cangjie
extend Int64 <: CheckedOp<Int64> & CheckedPow
```

功能：为 [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) 实现 [CheckedOp](#interface-checkedopt) 和 [CheckedPow](#interface-checkedpow) 接口。

父类型：

- [CheckedOp](#interface-checkedopt)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>
- [CheckedPow](#interface-checkedpow)

#### func checkedAdd(Int64)

```cangjie
public func checkedAdd(y: Int64): ?Int64
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的加法运算。

当运算出现溢出时，返回 ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64).None，否则返回运算结果。

参数：

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 加数。

返回值：

- ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int64值，使它们相加会发生溢出
    let a1 = 9223372036854775807i64  // Int64的最大值
    let b1 = 1i64
    
    // 使用checkedAdd进行加法运算（溢出情况）
    let result1 = a1.checkedAdd(b1)
    
    // 直接打印结果
    println("Overflow case - Checked add result: ${result1}")
    
    // 创建两个Int64值，使它们相加不会发生溢出
    let a2 = 100i64
    let b2 = 200i64
    
    // 使用checkedAdd进行加法运算（正常情况）
    let result2 = a2.checkedAdd(b2)
    
    // 直接打印结果
    println("Normal case - Checked add result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked add result: None
Normal case - Checked add result: Some(300)
```

#### func checkedDec()

```cangjie
public func checkedDec(): ?Int64
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的自减运算。

当运算出现溢出时，返回 ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64).None，否则返回运算结果。

返回值：

- ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值，使其自减会发生溢出
    let a1 = -9223372036854775808i64  // Int64的最小值
    
    // 使用checkedDec进行自减运算（溢出情况）
    let result1 = a1.checkedDec()
    
    // 直接打印结果
    println("Overflow case - Checked dec result: ${result1}")
    
    // 创建一个Int64值，使其自减不会发生溢出
    let a2 = 100i64
    
    // 使用checkedDec进行自减运算（正常情况）
    let result2 = a2.checkedDec()
    
    // 直接打印结果
    println("Normal case - Checked dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked dec result: None
Normal case - Checked dec result: Some(99)
```

#### func checkedDiv(Int64)

```cangjie
public func checkedDiv(y: Int64): ?Int64
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的除法运算。

当运算出现溢出时，返回 ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64).None，否则返回运算结果。

参数：

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 除数。

返回值：

- ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int64值，使除法运算会发生溢出
    let a1 = -9223372036854775808i64  // Int64的最小值
    let b1 = -1i64                    // 除数
    
    // 使用checkedDiv进行除法运算（溢出情况）
    let result1 = a1.checkedDiv(b1)
    
    // 直接打印结果
    println("Overflow case - Checked div result: ${result1}")
    
    // 创建两个Int64值，使除法运算不会发生溢出
    let a2 = 100i64
    let b2 = 2i64
    
    // 使用checkedDiv进行除法运算（正常情况）
    let result2 = a2.checkedDiv(b2)
    
    // 直接打印结果
    println("Normal case - Checked div result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked div result: None
Normal case - Checked div result: Some(50)
```

#### func checkedInc()

```cangjie
public func checkedInc(): ?Int64
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的自增运算。

当运算出现溢出时，返回 ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64).None，否则返回运算结果。

返回值：

- ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值，使其自增会发生溢出
    let a1 = 9223372036854775807i64  // Int64的最大值
    
    // 使用checkedInc进行自增运算（溢出情况）
    let result1 = a1.checkedInc()
    
    // 直接打印结果
    println("Overflow case - Checked inc result: ${result1}")
    
    // 创建一个Int64值，使其自增不会发生溢出
    let a2 = 100i64
    
    // 使用checkedInc进行自增运算（正常情况）
    let result2 = a2.checkedInc()
    
    // 直接打印结果
    println("Normal case - Checked inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked inc result: None
Normal case - Checked inc result: Some(101)
```

#### func checkedMod(Int64)

```cangjie
public func checkedMod(y: Int64): ?Int64
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的取余运算。

当运算出现溢出时，返回 ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64).None，否则返回运算结果。

参数：

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 除数。

返回值：

- ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int64值，使取余运算会发生溢出
    let a1 = -9223372036854775808i64  // Int64的最小值
    let b1 = -1i64                    // 除数
    
    // 使用checkedMod进行取余运算（溢出情况）
    let result1 = a1.checkedMod(b1)
    
    // 直接打印结果
    println("Overflow case - Checked mod result: ${result1}")
    
    // 创建两个Int64值，使取余运算不会发生溢出
    let a2 = 100i64
    let b2 = 3i64
    
    // 使用checkedMod进行取余运算（正常情况）
    let result2 = a2.checkedMod(b2)
    
    // 直接打印结果
    println("Normal case - Checked mod result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked mod result: None
Normal case - Checked mod result: Some(1)
```

#### func checkedMul(Int64)

```cangjie
public func checkedMul(y: Int64): ?Int64
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的乘法运算。

当运算出现溢出时，返回 ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64).None，否则返回运算结果。

参数：

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 乘数。

返回值：

- ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int64值，使乘法运算会发生溢出
    let a1 = 9223372036854775807i64   // Int64的最大值
    let b1 = 2i64                      // 乘数
    
    // 使用checkedMul进行乘法运算（溢出情况）
    let result1 = a1.checkedMul(b1)
    
    // 直接打印结果
    println("Overflow case - Checked mul result: ${result1}")
    
    // 创建两个Int64值，使乘法运算不会发生溢出
    let a2 = 100i64
    let b2 = 3i64
    
    // 使用checkedMul进行乘法运算（正常情况）
    let result2 = a2.checkedMul(b2)
    
    // 直接打印结果
    println("Normal case - Checked mul result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked mul result: None
Normal case - Checked mul result: Some(300)
```

#### func checkedNeg()

```cangjie
public func checkedNeg(): ?Int64
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的负号运算。

当运算出现溢出时，返回 ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64).None，否则返回运算结果。

返回值：

- ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值，使其负号运算会发生溢出
    let a1 = -9223372036854775808i64  // Int64的最小值
    
    // 使用checkedNeg进行负号运算（溢出情况）
    let result1 = a1.checkedNeg()
    
    // 直接打印结果
    println("Overflow case - Checked neg result: ${result1}")
    
    // 创建一个Int64值，使其负号运算不会发生溢出
    let a2 = 100i64
    
    // 使用checkedNeg进行负号运算（正常情况）
    let result2 = a2.checkedNeg()
    
    // 直接打印结果
    println("Normal case - Checked neg result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked neg result: None
Normal case - Checked neg result: Some(-100)
```

#### func checkedPow(UInt64)

```cangjie
public func checkedPow(y: UInt64): ?Int64
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的幂运算。

当运算出现溢出时，返回 ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 指数。

返回值：

- ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 幂运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值和指数，使幂运算会发生溢出
    let a1 = 10i64
    let b1 = 64u64  // 指数过大导致溢出
    
    // 使用checkedPow进行幂运算（溢出情况）
    let result1 = a1.checkedPow(b1)
    
    // 直接打印结果
    println("Overflow case - Checked pow result: ${result1}")
    
    // 创建一个Int64值和指数，使幂运算不会发生溢出
    let a2 = 10i64
    let b2 = 2u64   // 指数较小不会溢出
    
    // 使用checkedPow进行幂运算（正常情况）
    let result2 = a2.checkedPow(b2)
    
    // 直接打印结果
    println("Normal case - Checked pow result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked pow result: None
Normal case - Checked pow result: Some(100)
```

#### func checkedShl(UInt64)

```cangjie
public func checkedShl(y: UInt64): ?Int64
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的左移运算。

当移位位数大于等于操作数位数时，返回 ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值和移位位数，使左移运算会发生溢出
    let a1 = 1i64
    let b1 = 64u64  // 移位位数大于等于操作数位数
    
    // 使用checkedShl进行左移运算（溢出情况）
    let result1 = a1.checkedShl(b1)
    
    // 直接打印结果
    println("Overflow case - Checked shl result: ${result1}")
    
    // 创建一个Int64值和移位位数，使左移运算不会发生溢出
    let a2 = 1i64
    let b2 = 2u64   // 移位位数小于操作数位数
    
    // 使用checkedShl进行左移运算（正常情况）
    let result2 = a2.checkedShl(b2)
    
    // 直接打印结果
    println("Normal case - Checked shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked shl result: None
Normal case - Checked shl result: Some(4)
```

#### func checkedShr(UInt64)

```cangjie
public func checkedShr(y: UInt64): ?Int64
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的右移运算。

当移位位数大于等于操作数位数时，返回 ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值和移位位数，使右移运算会发生溢出
    let a1 = 1i64
    let b1 = 64u64  // 移位位数大于等于操作数位数
    
    // 使用checkedShr进行右移运算（溢出情况）
    let result1 = a1.checkedShr(b1)
    
    // 直接打印结果
    println("Overflow case - Checked shr result: ${result1}")
    
    // 创建一个Int64值和移位位数，使右移运算不会发生溢出
    let a2 = 8i64
    let b2 = 2u64   // 移位位数小于操作数位数
    
    // 使用checkedShr进行右移运算（正常情况）
    let result2 = a2.checkedShr(b2)
    
    // 直接打印结果
    println("Normal case - Checked shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked shr result: None
Normal case - Checked shr result: Some(2)
```

#### func checkedSub(Int64)

```cangjie
public func checkedSub(y: Int64): ?Int64
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的减法运算。

当运算出现溢出时，返回 ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64).None，否则返回运算结果。

参数：

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 减数。

返回值：

- ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int64值，使减法运算会发生溢出
    let a1 = -9223372036854775808i64  // Int64的最小值
    let b1 = 1i64                     // 减数
    
    // 使用checkedSub进行减法运算（溢出情况）
    let result1 = a1.checkedSub(b1)
    
    // 直接打印结果
    println("Overflow case - Checked sub result: ${result1}")
    
    // 创建两个Int64值，使减法运算不会发生溢出
    let a2 = 100i64
    let b2 = 50i64
    
    // 使用checkedSub进行减法运算（正常情况）
    let result2 = a2.checkedSub(b2)
    
    // 直接打印结果
    println("Normal case - Checked sub result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked sub result: None
Normal case - Checked sub result: Some(50)
```

### extend Int8 <: CheckedOp\<Int8>

```cangjie
extend Int8 <: CheckedOp<Int8>
```

功能：为 [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) 实现 [CheckedOp](#interface-checkedopt) 接口。

父类型：

- [CheckedOp](#interface-checkedopt)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)>

#### func checkedAdd(Int8)

```cangjie
public func checkedAdd(y: Int8): ?Int8
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的加法运算。

当运算出现溢出时，返回 ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8).None，否则返回运算结果。

参数：

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 加数。

返回值：

- ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int8值，使它们相加会发生溢出
    let a1 = 127i8  // Int8的最大值
    let b1 = 1i8
    
    // 使用checkedAdd进行加法运算（溢出情况）
    let result1 = a1.checkedAdd(b1)
    
    // 直接打印结果
    println("Overflow case - Checked add result: ${result1}")
    
    // 创建两个Int8值，使它们相加不会发生溢出
    let a2 = 10i8
    let b2 = 20i8
    
    // 使用checkedAdd进行加法运算（正常情况）
    let result2 = a2.checkedAdd(b2)
    
    // 直接打印结果
    println("Normal case - Checked add result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked add result: None
Normal case - Checked add result: Some(30)
```

#### func checkedDec()

```cangjie
public func checkedDec(): ?Int8
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的自减运算。

当运算出现溢出时，返回 ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8).None，否则返回运算结果。

返回值：

- ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int8值，使其自减会发生溢出
    let a1 = -128i8  // Int8的最小值
    
    // 使用checkedDec进行自减运算（溢出情况）
    let result1 = a1.checkedDec()
    
    // 直接打印结果
    println("Overflow case - Checked dec result: ${result1}")
    
    // 创建一个Int8值，使其自减不会发生溢出
    let a2 = 10i8
    
    // 使用checkedDec进行自减运算（正常情况）
    let result2 = a2.checkedDec()
    
    // 直接打印结果
    println("Normal case - Checked dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked dec result: None
Normal case - Checked dec result: Some(9)
```

#### func checkedDiv(Int8)

```cangjie
public func checkedDiv(y: Int8): ?Int8
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的除法运算。

当运算出现溢出时，返回 ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8).None，否则返回运算结果。

参数：

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 除数。

返回值：

- ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int8值，使除法运算会发生溢出
    let a1 = -128i8  // Int8的最小值
    let b1 = -1i8    // 除数
    
    // 使用checkedDiv进行除法运算（溢出情况）
    let result1 = a1.checkedDiv(b1)
    
    // 直接打印结果
    println("Overflow case - Checked div result: ${result1}")
    
    // 创建两个Int8值，使除法运算不会发生溢出
    let a2 = 10i8
    let b2 = 2i8
    
    // 使用checkedDiv进行除法运算（正常情况）
    let result2 = a2.checkedDiv(b2)
    
    // 直接打印结果
    println("Normal case - Checked div result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked div result: None
Normal case - Checked div result: Some(5)
```

#### func checkedInc()

```cangjie
public func checkedInc(): ?Int8
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的自增运算。

当运算出现溢出时，返回 ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8).None，否则返回运算结果。

返回值：

- ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int8值，使其自增会发生溢出
    let a1 = 127i8  // Int8的最大值
    
    // 使用checkedInc进行自增运算（溢出情况）
    let result1 = a1.checkedInc()
    
    // 直接打印结果
    println("Overflow case - Checked inc result: ${result1}")
    
    // 创建一个Int8值，使其自增不会发生溢出
    let a2 = 10i8
    
    // 使用checkedInc进行自增运算（正常情况）
    let result2 = a2.checkedInc()
    
    // 直接打印结果
    println("Normal case - Checked inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked inc result: None
Normal case - Checked inc result: Some(11)
```

#### func checkedMod(Int8)

```cangjie
public func checkedMod(y: Int8): ?Int8
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的取余运算。

当运算出现溢出时，返回 ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8).None，否则返回运算结果。

参数：

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 除数。

返回值：

- ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int8值，使取余运算会发生溢出
    let a1 = -128i8  // Int8的最小值
    let b1 = -1i8    // 除数
    
    // 使用checkedMod进行取余运算（溢出情况）
    let result1 = a1.checkedMod(b1)
    
    // 直接打印结果
    println("Overflow case - Checked mod result: ${result1}")
    
    // 创建两个Int8值，使取余运算不会发生溢出
    let a2 = 10i8
    let b2 = 3i8
    
    // 使用checkedMod进行取余运算（正常情况）
    let result2 = a2.checkedMod(b2)
    
    // 直接打印结果
    println("Normal case - Checked mod result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked mod result: None
Normal case - Checked mod result: Some(1)
```

#### func checkedMul(Int8)

```cangjie
public func checkedMul(y: Int8): ?Int8
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的乘法运算。

当运算出现溢出时，返回 ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8).None，否则返回运算结果。

参数：

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 乘数。

返回值：

- ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int8值，使乘法运算会发生溢出
    let a1 = 127i8   // Int8的最大值
    let b1 = 2i8     // 乘数
    
    // 使用checkedMul进行乘法运算（溢出情况）
    let result1 = a1.checkedMul(b1)
    
    // 直接打印结果
    println("Overflow case - Checked mul result: ${result1}")
    
    // 创建两个Int8值，使乘法运算不会发生溢出
    let a2 = 10i8
    let b2 = 3i8
    
    // 使用checkedMul进行乘法运算（正常情况）
    let result2 = a2.checkedMul(b2)
    
    // 直接打印结果
    println("Normal case - Checked mul result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked mul result: None
Normal case - Checked mul result: Some(30)
```

#### func checkedNeg()

```cangjie
public func checkedNeg(): ?Int8
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的负号运算。

当运算出现溢出时，返回 ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8).None，否则返回运算结果。

返回值：

- ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int8值，使其负号运算会发生溢出
    let a1 = -128i8  // Int8的最小值
    
    // 使用checkedNeg进行负号运算（溢出情况）
    let result1 = a1.checkedNeg()
    
    // 直接打印结果
    println("Overflow case - Checked neg result: ${result1}")
    
    // 创建一个Int8值，使其负号运算不会发生溢出
    let a2 = 10i8
    
    // 使用checkedNeg进行负号运算（正常情况）
    let result2 = a2.checkedNeg()
    
    // 直接打印结果
    println("Normal case - Checked neg result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked neg result: None
Normal case - Checked neg result: Some(-10)
```

#### func checkedShl(UInt64)

```cangjie
public func checkedShl(y: UInt64): ?Int8
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的左移运算。

当移位位数大于等于操作数位数时，返回 ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int8值和移位位数，使左移运算会发生溢出
    let a1 = 1i8
    let b1 = 64u64  // 移位位数大于等于操作数位数
    
    // 使用checkedShl进行左移运算（溢出情况）
    let result1 = a1.checkedShl(b1)
    
    // 直接打印结果
    println("Overflow case - Checked shl result: ${result1}")
    
    // 创建一个Int8值和移位位数，使左移运算不会发生溢出
    let a2 = 1i8
    let b2 = 2u64   // 移位位数小于操作数位数
    
    // 使用checkedShl进行左移运算（正常情况）
    let result2 = a2.checkedShl(b2)
    
    // 直接打印结果
    println("Normal case - Checked shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked shl result: None
Normal case - Checked shl result: Some(4)
```

#### func checkedShr(UInt64)

```cangjie
public func checkedShr(y: UInt64): ?Int8
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的右移运算。

当移位位数大于等于操作数位数时，返回 ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int8值和移位位数，使右移运算会发生溢出
    let a1 = 1i8
    let b1 = 64u64  // 移位位数大于等于操作数位数
    
    // 使用checkedShr进行右移运算（溢出情况）
    let result1 = a1.checkedShr(b1)
    
    // 直接打印结果
    println("Overflow case - Checked shr result: ${result1}")
    
    // 创建一个Int8值和移位位数，使右移运算不会发生溢出
    let a2 = 8i8
    let b2 = 2u64   // 移位位数小于操作数位数
    
    // 使用checkedShr进行右移运算（正常情况）
    let result2 = a2.checkedShr(b2)
    
    // 直接打印结果
    println("Normal case - Checked shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked shr result: None
Normal case - Checked shr result: Some(2)
```

#### func checkedSub(Int8)

```cangjie
public func checkedSub(y: Int8): ?Int8
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的减法运算。

当运算出现溢出时，返回 ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8).None，否则返回运算结果。

参数：

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 减数。

返回值：

- ?[Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int8值，使减法运算会发生溢出
    let a1 = -128i8  // Int8的最小值
    let b1 = 1i8     // 减数
    
    // 使用checkedSub进行减法运算（溢出情况）
    let result1 = a1.checkedSub(b1)
    
    // 直接打印结果
    println("Overflow case - Checked sub result: ${result1}")
    
    // 创建两个Int8值，使减法运算不会发生溢出
    let a2 = 10i8
    let b2 = 5i8
    
    // 使用checkedSub进行减法运算（正常情况）
    let result2 = a2.checkedSub(b2)
    
    // 直接打印结果
    println("Normal case - Checked sub result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked sub result: None
Normal case - Checked sub result: Some(5)
```

### extend IntNative <: CheckedOp\<IntNative>

```cangjie
extend IntNative <: CheckedOp<IntNative>
```

功能：为 [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) 实现 [CheckedOp](#interface-checkedopt) 接口。

父类型：

- [CheckedOp](#interface-checkedopt)\<[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)>

#### func checkedAdd(IntNative)

```cangjie
public func checkedAdd(y: IntNative): ?IntNative
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的加法运算。

当运算出现溢出时，返回 ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).None，否则返回运算结果。

参数：

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 加数。

返回值：

- ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个IntNative值，使它们相加会发生溢出
    let a1: IntNative = 9223372036854775807  // IntNative的最大值
    let b1: IntNative = 1
    
    // 使用checkedAdd进行加法运算（溢出情况）
    let result1 = a1.checkedAdd(b1)
    
    // 直接打印结果
    println("Overflow case - Checked add result: ${result1}")
    
    // 创建两个IntNative值，使它们相加不会发生溢出
    let a2: IntNative = 100
    let b2: IntNative = 200
    
    // 使用checkedAdd进行加法运算（正常情况）
    let result2 = a2.checkedAdd(b2)
    
    // 直接打印结果
    println("Normal case - Checked add result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked add result: None
Normal case - Checked add result: Some(300)
```

#### func checkedDec()

```cangjie
public func checkedDec(): ?IntNative
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的自减运算。

当运算出现溢出时，返回 ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).None，否则返回运算结果。

返回值：

- ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个IntNative值，使其自减会发生溢出
    let a1: IntNative = -9223372036854775808  // IntNative的最小值
    
    // 使用checkedDec进行自减运算（溢出情况）
    let result1 = a1.checkedDec()
    
    // 直接打印结果
    println("Overflow case - Checked dec result: ${result1}")
    
    // 创建一个IntNative值，使其自减不会发生溢出
    let a2: IntNative = 100
    
    // 使用checkedDec进行自减运算（正常情况）
    let result2 = a2.checkedDec()
    
    // 直接打印结果
    println("Normal case - Checked dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked dec result: None
Normal case - Checked dec result: Some(99)
```

#### func checkedDiv(IntNative)

```cangjie
public func checkedDiv(y: IntNative): ?IntNative
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的除法运算。

当运算出现溢出时，返回 ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).None，否则返回运算结果。

参数：

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 除数。

返回值：

- ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个IntNative值，使除法运算会发生溢出
    let a1: IntNative = -9223372036854775808  // IntNative的最小值
    let b1: IntNative = -1    // 除数
    
    // 使用checkedDiv进行除法运算（溢出情况）
    let result1 = a1.checkedDiv(b1)
    
    // 直接打印结果
    println("Overflow case - Checked div result: ${result1}")
    
    // 创建两个IntNative值，使除法运算不会发生溢出
    let a2: IntNative = 100
    let b2: IntNative = 2
    
    // 使用checkedDiv进行除法运算（正常情况）
    let result2 = a2.checkedDiv(b2)
    
    // 直接打印结果
    println("Normal case - Checked div result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked div result: None
Normal case - Checked div result: Some(50)
```

#### func checkedInc()

```cangjie
public func checkedInc(): ?IntNative
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的自增运算。

当运算出现溢出时，返回 ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).None，否则返回运算结果。

返回值：

- ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个IntNative值，使其自增会发生溢出
    let a1: IntNative = 9223372036854775807  // IntNative的最大值
    
    // 使用checkedInc进行自增运算（溢出情况）
    let result1 = a1.checkedInc()
    
    // 直接打印结果
    println("Overflow case - Checked inc result: ${result1}")
    
    // 创建一个IntNative值，使其自增不会发生溢出
    let a2: IntNative = 100
    
    // 使用checkedInc进行自增运算（正常情况）
    let result2 = a2.checkedInc()
    
    // 直接打印结果
    println("Normal case - Checked inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked inc result: None
Normal case - Checked inc result: Some(101)
```

#### func checkedMod(IntNative)

```cangjie
public func checkedMod(y: IntNative): ?IntNative
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的取余运算。

当运算出现溢出时，返回 ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).None，否则返回运算结果。

参数：

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 除数。

返回值：

- ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个IntNative值，使取余运算会发生溢出
    let a1: IntNative = -9223372036854775808  // IntNative的最小值
    let b1: IntNative = -1    // 除数
    
    // 使用checkedMod进行取余运算（溢出情况）
    let result1 = a1.checkedMod(b1)
    
    // 直接打印结果
    println("Overflow case - Checked mod result: ${result1}")
    
    // 创建两个IntNative值，使取余运算不会发生溢出
    let a2: IntNative = 100
    let b2: IntNative = 3
    
    // 使用checkedMod进行取余运算（正常情况）
    let result2 = a2.checkedMod(b2)
    
    // 直接打印结果
    println("Normal case - Checked mod result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked mod result: None
Normal case - Checked mod result: Some(1)
```

#### func checkedMul(IntNative)

```cangjie
public func checkedMul(y: IntNative): ?IntNative
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的乘法运算。

当运算出现溢出时，返回 ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).None，否则返回运算结果。

参数：

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 乘数。

返回值：

- ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个IntNative值，使乘法运算会发生溢出
    let a1: IntNative = 9223372036854775807   // IntNative的最大值
    let b1: IntNative = 2     // 乘数
    
    // 使用checkedMul进行乘法运算（溢出情况）
    let result1 = a1.checkedMul(b1)
    
    // 直接打印结果
    println("Overflow case - Checked mul result: ${result1}")
    
    // 创建两个IntNative值，使乘法运算不会发生溢出
    let a2: IntNative = 100
    let b2: IntNative = 3
    
    // 使用checkedMul进行乘法运算（正常情况）
    let result2 = a2.checkedMul(b2)
    
    // 直接打印结果
    println("Normal case - Checked mul result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked mul result: None
Normal case - Checked mul result: Some(300)
```

#### func checkedNeg()

```cangjie
public func checkedNeg(): ?IntNative
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的负号运算。

当运算出现溢出时，返回 ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).None，否则返回运算结果。

返回值：

- ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个IntNative值，使其负号运算会发生溢出
    let a1: IntNative = -9223372036854775808  // IntNative的最小值
    
    // 使用checkedNeg进行负号运算（溢出情况）
    let result1 = a1.checkedNeg()
    
    // 直接打印结果
    println("Overflow case - Checked neg result: ${result1}")
    
    // 创建一个IntNative值，使其负号运算不会发生溢出
    let a2: IntNative = 100
    
    // 使用checkedNeg进行负号运算（正常情况）
    let result2 = a2.checkedNeg()
    
    // 直接打印结果
    println("Normal case - Checked neg result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked neg result: None
Normal case - Checked neg result: Some(-100)
```

#### func checkedShl(UInt64)

```cangjie
public func checkedShl(y: UInt64): ?IntNative
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的左移运算。

当移位位数大于等于操作数位数时，返回 ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个IntNative值和移位位数，使左移运算会发生溢出
    let a1: IntNative = 1
    let b1 = 64u64  // 移位位数大于等于操作数位数
    
    // 使用checkedShl进行左移运算（溢出情况）
    let result1 = a1.checkedShl(b1)
    
    // 直接打印结果
    println("Overflow case - Checked shl result: ${result1}")
    
    // 创建一个IntNative值和移位位数，使左移运算不会发生溢出
    let a2: IntNative = 1
    let b2 = 2u64   // 移位位数小于操作数位数
    
    // 使用checkedShl进行左移运算（正常情况）
    let result2 = a2.checkedShl(b2)
    
    // 直接打印结果
    println("Normal case - Checked shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked shl result: None
Normal case - Checked shl result: Some(4)
```

#### func checkedShr(UInt64)

```cangjie
public func checkedShr(y: UInt64): ?IntNative
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的右移运算。

当移位位数大于等于操作数位数时，返回 ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个IntNative值和移位位数，使右移运算会发生溢出
    let a1: IntNative = 1
    let b1 = 64u64  // 移位位数大于等于操作数位数
    
    // 使用checkedShr进行右移运算（溢出情况）
    let result1 = a1.checkedShr(b1)
    
    // 直接打印结果
    println("Overflow case - Checked shr result: ${result1}")
    
    // 创建一个IntNative值和移位位数，使右移运算不会发生溢出
    let a2: IntNative = 8
    let b2 = 2u64   // 移位位数小于操作数位数
    
    // 使用checkedShr进行右移运算（正常情况）
    let result2 = a2.checkedShr(b2)
    
    // 直接打印结果
    println("Normal case - Checked shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked shr result: None
Normal case - Checked shr result: Some(2)
```

#### func checkedSub(IntNative)

```cangjie
public func checkedSub(y: IntNative): ?IntNative
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的减法运算。

当运算出现溢出时，返回 ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative).None，否则返回运算结果。

参数：

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 减数。

返回值：

- ?[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个IntNative值，使减法运算会发生溢出
    let a1: IntNative = -9223372036854775808  // IntNative的最小值
    let b1: IntNative = 1     // 减数
    
    // 使用checkedSub进行减法运算（溢出情况）
    let result1 = a1.checkedSub(b1)
    
    // 直接打印结果
    println("Overflow case - Checked sub result: ${result1}")
    
    // 创建两个IntNative值，使减法运算不会发生溢出
    let a2: IntNative = 100
    let b2: IntNative = 50
    
    // 使用checkedSub进行减法运算（正常情况）
    let result2 = a2.checkedSub(b2)
    
    // 直接打印结果
    println("Normal case - Checked sub result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked sub result: None
Normal case - Checked sub result: Some(50)
```

### extend UInt16 <: CheckedOp\<UInt16>

```cangjie
extend UInt16 <: CheckedOp<UInt16>
```

功能：为 [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) 实现 [CheckedOp](#interface-checkedopt) 接口。

父类型：

- [CheckedOp](#interface-checkedopt)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)>

#### func checkedAdd(UInt16)

```cangjie
public func checkedAdd(y: UInt16): ?UInt16
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的加法运算。

当运算出现溢出时，返回 ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).None，否则返回运算结果。

参数：

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 加数。

返回值：

- ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt16值，使它们相加会发生溢出
    let a1 = 65535u16  // UInt16的最大值
    let b1 = 1u16
    
    // 使用checkedAdd进行加法运算（溢出情况）
    let result1 = a1.checkedAdd(b1)
    
    // 直接打印结果
    println("Overflow case - Checked add result: ${result1}")
    
    // 创建两个UInt16值，使它们相加不会发生溢出
    let a2 = 100u16
    let b2 = 200u16
    
    // 使用checkedAdd进行加法运算（正常情况）
    let result2 = a2.checkedAdd(b2)
    
    // 直接打印结果
    println("Normal case - Checked add result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked add result: None
Normal case - Checked add result: Some(300)
```

#### func checkedDec()

```cangjie
public func checkedDec(): ?UInt16
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的自减运算。

当运算出现溢出时，返回 ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).None，否则返回运算结果。

返回值：

- ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt16值，使其自减会发生溢出
    let a1 = 0u16  // UInt16的最小值
    
    // 使用checkedDec进行自减运算（溢出情况）
    let result1 = a1.checkedDec()
    
    // 直接打印结果
    println("Overflow case - Checked dec result: ${result1}")
    
    // 创建一个UInt16值，使其自减不会发生溢出
    let a2 = 100u16
    
    // 使用checkedDec进行自减运算（正常情况）
    let result2 = a2.checkedDec()
    
    // 直接打印结果
    println("Normal case - Checked dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked dec result: None
Normal case - Checked dec result: Some(99)
```

#### func checkedDiv(UInt16)

```cangjie
public func checkedDiv(y: UInt16): ?UInt16
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的除法运算。

当运算出现溢出时，返回 ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).None，否则返回运算结果。

参数：

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 除数。

返回值：

- ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt16值，使除法运算不会发生溢出
    let a = 100u16
    let b = 2u16
    
    // 使用checkedDiv进行除法运算（正常情况）
    let result = a.checkedDiv(b)
    
    // 直接打印结果
    println("Normal case - Checked div result: ${result}")
    
    return 0
}
```

运行结果：

```text
Normal case - Checked div result: Some(50)
```

#### func checkedInc()

```cangjie
public func checkedInc(): ?UInt16
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的自增运算。

当运算出现溢出时，返回 ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).None，否则返回运算结果。

返回值：

- ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt16值，使其自增会发生溢出
    let a1 = 65535u16  // UInt16的最大值
    
    // 使用checkedInc进行自增运算（溢出情况）
    let result1 = a1.checkedInc()
    
    // 直接打印结果
    println("Overflow case - Checked inc result: ${result1}")
    
    // 创建一个UInt16值，使其自增不会发生溢出
    let a2 = 100u16
    
    // 使用checkedInc进行自增运算（正常情况）
    let result2 = a2.checkedInc()
    
    // 直接打印结果
    println("Normal case - Checked inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked inc result: None
Normal case - Checked inc result: Some(101)
```

#### func checkedMod(UInt16)

```cangjie
public func checkedMod(y: UInt16): ?UInt16
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的取余运算。

当运算出现溢出时，返回 ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).None，否则返回运算结果。

参数：

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 除数。

返回值：

- ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt16值，使取余运算不会发生溢出
    let a = 100u16
    let b = 3u16
    
    // 使用checkedMod进行取余运算（正常情况）
    let result = a.checkedMod(b)
    
    // 直接打印结果
    println("Normal case - Checked mod result: ${result}")
    
    return 0
}
```

运行结果：

```text
Normal case - Checked mod result: Some(1)
```

#### func checkedMul(UInt16)

```cangjie
public func checkedMul(y: UInt16): ?UInt16
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的乘法运算。

当运算出现溢出时，返回 ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).None，否则返回运算结果。

参数：

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 乘数。

返回值：

- ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt16值，使它们相乘会发生溢出
    let a1 = 65535u16  // UInt16的最大值
    let b1 = 2u16
    
    // 使用checkedMul进行乘法运算（溢出情况）
    let result1 = a1.checkedMul(b1)
    
    // 直接打印结果
    println("Overflow case - Checked mul result: ${result1}")
    
    // 创建两个UInt16值，使它们相乘不会发生溢出
    let a2 = 100u16
    let b2 = 200u16
    
    // 使用checkedMul进行乘法运算（正常情况）
    let result2 = a2.checkedMul(b2)
    
    // 直接打印结果
    println("Normal case - Checked mul result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked mul result: None
Normal case - Checked mul result: Some(20000)
```

#### func checkedNeg()

```cangjie
public func checkedNeg(): ?UInt16
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的负号运算。

当运算出现溢出时，返回 ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).None，否则返回运算结果。

返回值：

- ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt16值，尝试进行取负运算
    // 注意：对于UInt16类型，取负操作可能会导致溢出
    let a1 = 100u16
    
    // 使用checkedNeg进行取负运算
    let result1 = a1.checkedNeg()
    
    // 直接打印结果
    println("Checked neg result: ${result1}")
    
    return 0
}
```

运行结果：

```text
Checked neg result: None
```

#### func checkedShl(UInt64)

```cangjie
public func checkedShl(y: UInt64): ?UInt16
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的左移运算。

当移位位数大于等于操作数位数时，返回 ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt16值和一个移位位数，使左移运算会发生溢出
    let a1 = 100u16
    let b1 = 16u64  // 移位位数大于等于操作数位数(16)
    
    // 使用checkedShl进行左移运算（溢出情况）
    let result1 = a1.checkedShl(b1)
    
    // 直接打印结果
    println("Overflow case - Checked shl result: ${result1}")
    
    // 创建一个UInt16值和一个移位位数，使左移运算不会发生溢出
    let a2 = 100u16
    let b2 = 2u64
    
    // 使用checkedShl进行左移运算（正常情况）
    let result2 = a2.checkedShl(b2)
    
    // 直接打印结果
    println("Normal case - Checked shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked shl result: None
Normal case - Checked shl result: Some(400)
```

#### func checkedShr(UInt64)

```cangjie
public func checkedShr(y: UInt64): ?UInt16
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的右移运算。

当移位位数大于等于操作数位数时，返回 ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt16值和一个移位位数，使右移运算会发生溢出
    let a1 = 100u16
    let b1 = 16u64  // 移位位数大于等于操作数位数(16)
    
    // 使用checkedShr进行右移运算（溢出情况）
    let result1 = a1.checkedShr(b1)
    
    // 直接打印结果
    println("Overflow case - Checked shr result: ${result1}")
    
    // 创建一个UInt16值和一个移位位数，使右移运算不会发生溢出
    let a2 = 100u16
    let b2 = 2u64
    
    // 使用checkedShr进行右移运算（正常情况）
    let result2 = a2.checkedShr(b2)
    
    // 直接打印结果
    println("Normal case - Checked shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked shr result: None
Normal case - Checked shr result: Some(25)
```

#### func checkedSub(UInt16)

```cangjie
public func checkedSub(y: UInt16): ?UInt16
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的减法运算。

当运算出现溢出时，返回 ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16).None，否则返回运算结果。

参数：

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 减数。

返回值：

- ?[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt16值，使减法运算会发生溢出
    let a1 = 100u16
    let b1 = 200u16  // 减数大于被减数
    
    // 使用checkedSub进行减法运算（溢出情况）
    let result1 = a1.checkedSub(b1)
    
    // 直接打印结果
    println("Overflow case - Checked sub result: ${result1}")
    
    // 创建两个UInt16值，使减法运算不会发生溢出
    let a2 = 200u16
    let b2 = 100u16
    
    // 使用checkedSub进行减法运算（正常情况）
    let result2 = a2.checkedSub(b2)
    
    // 直接打印结果
    println("Normal case - Checked sub result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked sub result: None
Normal case - Checked sub result: Some(100)
```

### extend UInt32 <: CheckedOp\<UInt32>

```cangjie
extend UInt32 <: CheckedOp<UInt32>
```

功能：为 [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) 实现 [CheckedOp](#interface-checkedopt) 接口。

父类型：

- [CheckedOp](#interface-checkedopt)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)>

#### func checkedAdd(UInt32)

```cangjie
public func checkedAdd(y: UInt32): ?UInt32
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的加法运算。

当运算出现溢出时，返回 ?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).None，否则返回运算结果。

参数：

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 加数。

返回值：

- ?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt32值，使它们相加会发生溢出
    let a1 = 4294967295u32  // UInt32的最大值
    let b1 = 1u32
    
    // 使用checkedAdd进行加法运算（溢出情况）
    let result1 = a1.checkedAdd(b1)
    
    // 直接打印结果
    println("Overflow case - Checked add result: ${result1}")
    
    // 创建两个UInt32值，使它们相加不会发生溢出
    let a2 = 100u32
    let b2 = 200u32
    
    // 使用checkedAdd进行加法运算（正常情况）
    let result2 = a2.checkedAdd(b2)
    
    // 直接打印结果
    println("Normal case - Checked add result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked add result: None
Normal case - Checked add result: Some(300)
```

#### func checkedDec()

```cangjie
public func checkedDec(): ?UInt32
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的自减运算。

当运算出现溢出时，返回 ?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).None，否则返回运算结果。

返回值：

- ?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt32值，使其自减会发生溢出
    let a1 = 0u32  // UInt32的最小值
    
    // 使用checkedDec进行自减运算（溢出情况）
    let result1 = a1.checkedDec()
    
    // 直接打印结果
    println("Overflow case - Checked dec result: ${result1}")
    
    // 创建一个UInt32值，使其自减不会发生溢出
    let a2 = 100u32
    
    // 使用checkedDec进行自减运算（正常情况）
    let result2 = a2.checkedDec()
    
    // 直接打印结果
    println("Normal case - Checked dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked dec result: None
Normal case - Checked dec result: Some(99)
```

#### func checkedDiv(UInt32)

```cangjie
public func checkedDiv(y: UInt32): ?UInt32
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的除法运算。

当运算出现溢出时，返回 ?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).None，否则返回运算结果。

参数：

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 除数。

返回值：

- ?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt32值，使除法运算不会发生溢出
    let a1 = 100u32
    let b1 = 2u32
    
    // 使用checkedDiv进行除法运算（正常情况）
    let result1 = a1.checkedDiv(b1)
    
    // 直接打印结果
    println("Normal case - Checked div result: ${result1}")
    
    // 创建另一个UInt32值对进行除法运算
    let a2 = 1000u32
    let b2 = 5u32
    
    // 使用checkedDiv进行除法运算（正常情况）
    let result2 = a2.checkedDiv(b2)
    
    // 直接打印结果
    println("Normal case - Checked div result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Checked div result: Some(50)
Normal case - Checked div result: Some(200)
```

#### func checkedInc()

```cangjie
public func checkedInc(): ?UInt32
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的自增运算。

当运算出现溢出时，返回 ?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).None，否则返回运算结果。

返回值：

- ?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt32值，使其自增会发生溢出
    let a1 = 4294967295u32  // UInt32的最大值
    
    // 使用checkedInc进行自增运算（溢出情况）
    let result1 = a1.checkedInc()
    
    // 直接打印结果
    println("Overflow case - Checked inc result: ${result1}")
    
    // 创建一个UInt32值，使其自增不会发生溢出
    let a2 = 100u32
    
    // 使用checkedInc进行自增运算（正常情况）
    let result2 = a2.checkedInc()
    
    // 直接打印结果
    println("Normal case - Checked inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked inc result: None
Normal case - Checked inc result: Some(101)
```

#### func checkedMod(UInt32)

```cangjie
public func checkedMod(y: UInt32): ?UInt32
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的取余运算。

当运算出现溢出时，返回 ?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).None，否则返回运算结果。

参数：

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 除数。

返回值：

- ?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt32值，使取余运算不会发生溢出
    let a1 = 100u32
    let b1 = 3u32
    
    // 使用checkedMod进行取余运算（正常情况）
    let result1 = a1.checkedMod(b1)
    
    // 直接打印结果
    println("Normal case - Checked mod result: ${result1}")
    
    // 创建另一个UInt32值对进行取余运算
    let a2 = 1000u32
    let b2 = 7u32
    
    // 使用checkedMod进行取余运算（正常情况）
    let result2 = a2.checkedMod(b2)
    
    // 直接打印结果
    println("Normal case - Checked mod result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Checked mod result: Some(1)
Normal case - Checked mod result: Some(6)
```

#### func checkedMul(UInt32)

```cangjie
public func checkedMul(y: UInt32): ?UInt32
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的乘法运算。

当运算出现溢出时，返回 ?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).None，否则返回运算结果。

参数：

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 乘数。

返回值：

- ?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt32值，使它们相乘会发生溢出
    let a1 = 4294967295u32  // UInt32的最大值
    let b1 = 2u32
    
    // 使用checkedMul进行乘法运算（溢出情况）
    let result1 = a1.checkedMul(b1)
    
    // 直接打印结果
    println("Overflow case - Checked mul result: ${result1}")
    
    // 创建两个UInt32值，使它们相乘不会发生溢出
    let a2 = 100u32
    let b2 = 200u32
    
    // 使用checkedMul进行乘法运算（正常情况）
    let result2 = a2.checkedMul(b2)
    
    // 直接打印结果
    println("Normal case - Checked mul result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked mul result: None
Normal case - Checked mul result: Some(20000)
```

#### func checkedNeg()

```cangjie
public func checkedNeg(): ?UInt32
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的负号运算。

当运算出现溢出时，返回 ?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).None，否则返回运算结果。

返回值：

- ?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt32值，尝试进行取负运算
    // 注意：对于UInt32类型，取负操作可能会导致溢出
    let a1 = 100u32
    
    // 使用checkedNeg进行取负运算
    let result1 = a1.checkedNeg()
    
    // 直接打印结果
    println("Checked neg result: ${result1}")
    
    return 0
}
```

运行结果：

```text
Checked neg result: None
```

#### func checkedShl(UInt64)

```cangjie
public func checkedShl(y: UInt64): ?UInt32
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的左移运算。

当移位位数大于等于操作数位数时，返回 ?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt32值和一个移位位数，使左移运算会发生溢出
    let a1 = 100u32
    let b1 = 32u64  // 移位位数大于等于操作数位数(32)
    
    // 使用checkedShl进行左移运算（溢出情况）
    let result1 = a1.checkedShl(b1)
    
    // 直接打印结果
    println("Overflow case - Checked shl result: ${result1}")
    
    // 创建一个UInt32值和一个移位位数，使左移运算不会发生溢出
    let a2 = 100u32
    let b2 = 2u64
    
    // 使用checkedShl进行左移运算（正常情况）
    let result2 = a2.checkedShl(b2)
    
    // 直接打印结果
    println("Normal case - Checked shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked shl result: None
Normal case - Checked shl result: Some(400)
```

#### func checkedShr(UInt64)

```cangjie
public func checkedShr(y: UInt64): ?UInt32
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的右移运算。

当移位位数大于等于操作数位数时，返回 ?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt32值和一个移位位数，使右移运算会发生溢出
    let a1 = 100u32
    let b1 = 32u64  // 移位位数大于等于操作数位数(32)
    
    // 使用checkedShr进行右移运算（溢出情况）
    let result1 = a1.checkedShr(b1)
    
    // 直接打印结果
    println("Overflow case - Checked shr result: ${result1}")
    
    // 创建一个UInt32值和一个移位位数，使右移运算不会发生溢出
    let a2 = 100u32
    let b2 = 2u64
    
    // 使用checkedShr进行右移运算（正常情况）
    let result2 = a2.checkedShr(b2)
    
    // 直接打印结果
    println("Normal case - Checked shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked shr result: None
Normal case - Checked shr result: Some(25)
```

#### func checkedSub(UInt32)

```cangjie
public func checkedSub(y: UInt32): ?UInt32
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的减法运算。

当运算出现溢出时，返回 ?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32).None，否则返回运算结果。

参数：

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 减数。

返回值：

- ?[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt32值，使减法运算会发生溢出
    let a1 = 100u32
    let b1 = 200u32  // 减数大于被减数
    
    // 使用checkedSub进行减法运算（溢出情况）
    let result1 = a1.checkedSub(b1)
    
    // 直接打印结果
    println("Overflow case - Checked sub result: ${result1}")
    
    // 创建两个UInt32值，使减法运算不会发生溢出
    let a2 = 200u32
    let b2 = 100u32
    
    // 使用checkedSub进行减法运算（正常情况）
    let result2 = a2.checkedSub(b2)
    
    // 直接打印结果
    println("Normal case - Checked sub result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked sub result: None
Normal case - Checked sub result: Some(100)
```

### extend UInt64 <: CheckedOp\<UInt64>

```cangjie
extend UInt64 <: CheckedOp<UInt64>
```

功能：为 [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) 实现 [CheckedOp](#interface-checkedopt) 接口。

父类型：

- [CheckedOp](#interface-checkedopt)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)>

#### func checkedAdd(UInt64)

```cangjie
public func checkedAdd(y: UInt64): ?UInt64
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的加法运算。

当运算出现溢出时，返回 ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 加数。

返回值：

- ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt64值，使它们相加会发生溢出
    let a1 = 18446744073709551615u64  // UInt64的最大值
    let b1 = 1u64
    
    // 使用checkedAdd进行加法运算（溢出情况）
    let result1 = a1.checkedAdd(b1)
    
    // 直接打印结果
    println("Overflow case - Checked add result: ${result1}")
    
    // 创建两个UInt64值，使它们相加不会发生溢出
    let a2 = 100u64
    let b2 = 200u64
    
    // 使用checkedAdd进行加法运算（正常情况）
    let result2 = a2.checkedAdd(b2)
    
    // 直接打印结果
    println("Normal case - Checked add result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked add result: None
Normal case - Checked add result: Some(300)
```

#### func checkedDec()

```cangjie
public func checkedDec(): ?UInt64
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的自减运算。

当运算出现溢出时，返回 ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).None，否则返回运算结果。

返回值：

- ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt64值，使其自减会发生溢出
    let a1 = 0u64  // UInt64的最小值
    
    // 使用checkedDec进行自减运算（溢出情况）
    let result1 = a1.checkedDec()
    
    // 直接打印结果
    println("Overflow case - Checked dec result: ${result1}")
    
    // 创建一个UInt64值，使其自减不会发生溢出
    let a2 = 100u64
    
    // 使用checkedDec进行自减运算（正常情况）
    let result2 = a2.checkedDec()
    
    // 直接打印结果
    println("Normal case - Checked dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked dec result: None
Normal case - Checked dec result: Some(99)
```

#### func checkedDiv(UInt64)

```cangjie
public func checkedDiv(y: UInt64): ?UInt64
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的除法运算。

当运算出现溢出时，返回 ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 除数。

返回值：

- ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt64值，使除法运算不会发生溢出
    let a1 = 100u64
    let b1 = 2u64
    
    // 使用checkedDiv进行除法运算（正常情况）
    let result1 = a1.checkedDiv(b1)
    
    // 直接打印结果
    println("Normal case - Checked div result: ${result1}")
    
    // 创建另一个UInt64值对进行除法运算
    let a2 = 1000u64
    let b2 = 5u64
    
    // 使用checkedDiv进行除法运算（正常情况）
    let result2 = a2.checkedDiv(b2)
    
    // 直接打印结果
    println("Normal case - Checked div result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Checked div result: Some(50)
Normal case - Checked div result: Some(200)
```

#### func checkedInc()

```cangjie
public func checkedInc(): ?UInt64
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的自增运算。

当运算出现溢出时，返回 ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).None，否则返回运算结果。

返回值：

- ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt64值，使其自增会发生溢出
    let a1 = 18446744073709551615u64  // UInt64的最大值
    
    // 使用checkedInc进行自增运算（溢出情况）
    let result1 = a1.checkedInc()
    
    // 直接打印结果
    println("Overflow case - Checked inc result: ${result1}")
    
    // 创建一个UInt64值，使其自增不会发生溢出
    let a2 = 100u64
    
    // 使用checkedInc进行自增运算（正常情况）
    let result2 = a2.checkedInc()
    
    // 直接打印结果
    println("Normal case - Checked inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked inc result: None
Normal case - Checked inc result: Some(101)
```

#### func checkedMod(UInt64)

```cangjie
public func checkedMod(y: UInt64): ?UInt64
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的取余运算。

当运算出现溢出时，返回 ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 除数。

返回值：

- ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt64值，使取余运算不会发生溢出
    let a1 = 100u64
    let b1 = 3u64
    
    // 使用checkedMod进行取余运算（正常情况）
    let result1 = a1.checkedMod(b1)
    
    // 直接打印结果
    println("Normal case - Checked mod result: ${result1}")
    
    // 创建另一个UInt64值对进行取余运算
    let a2 = 1000u64
    let b2 = 7u64
    
    // 使用checkedMod进行取余运算（正常情况）
    let result2 = a2.checkedMod(b2)
    
    // 直接打印结果
    println("Normal case - Checked mod result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Checked mod result: Some(1)
Normal case - Checked mod result: Some(6)
```

#### func checkedMul(UInt64)

```cangjie
public func checkedMul(y: UInt64): ?UInt64
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的乘法运算。

当运算出现溢出时，返回 ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 乘数。

返回值：

- ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt64值，使它们相乘会发生溢出
    let a1 = 18446744073709551615u64  // UInt64的最大值
    let b1 = 2u64
    
    // 使用checkedMul进行乘法运算（溢出情况）
    let result1 = a1.checkedMul(b1)
    
    // 直接打印结果
    println("Overflow case - Checked mul result: ${result1}")
    
    // 创建两个UInt64值，使它们相乘不会发生溢出
    let a2 = 100u64
    let b2 = 200u64
    
    // 使用checkedMul进行乘法运算（正常情况）
    let result2 = a2.checkedMul(b2)
    
    // 直接打印结果
    println("Normal case - Checked mul result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked mul result: None
Normal case - Checked mul result: Some(20000)
```

#### func checkedNeg()

```cangjie
public func checkedNeg(): ?UInt64
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的负号运算。

当运算出现溢出时，返回 ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).None，否则返回运算结果。

返回值：

- ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt64值，尝试进行取负运算
    // 注意：对于UInt64类型，取负操作可能会导致溢出
    let a1 = 100u64
    
    // 使用checkedNeg进行取负运算
    let result1 = a1.checkedNeg()
    
    // 直接打印结果
    println("Checked neg result: ${result1}")
    
    return 0
}
```

运行结果：

```text
Checked neg result: None
```

#### func checkedShl(UInt64)

```cangjie
public func checkedShl(y: UInt64): ?UInt64
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的左移运算。

当移位位数大于等于操作数位数时，返回 ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt64值和一个移位位数，使左移运算会发生溢出
    let a1 = 100u64
    let b1 = 64u64  // 移位位数大于等于操作数位数(64)
    
    // 使用checkedShl进行左移运算（溢出情况）
    let result1 = a1.checkedShl(b1)
    
    // 直接打印结果
    println("Overflow case - Checked shl result: ${result1}")
    
    // 创建一个UInt64值和一个移位位数，使左移运算不会发生溢出
    let a2 = 100u64
    let b2 = 2u64
    
    // 使用checkedShl进行左移运算（正常情况）
    let result2 = a2.checkedShl(b2)
    
    // 直接打印结果
    println("Normal case - Checked shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked shl result: None
Normal case - Checked shl result: Some(400)
```

#### func checkedShr(UInt64)

```cangjie
public func checkedShr(y: UInt64): ?UInt64
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的右移运算。

当移位位数大于等于操作数位数时，返回 ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt64值和一个移位位数，使右移运算会发生溢出
    let a1 = 100u64
    let b1 = 64u64  // 移位位数大于等于操作数位数(64)
    
    // 使用checkedShr进行右移运算（溢出情况）
    let result1 = a1.checkedShr(b1)
    
    // 直接打印结果
    println("Overflow case - Checked shr result: ${result1}")
    
    // 创建一个UInt64值和一个移位位数，使右移运算不会发生溢出
    let a2 = 100u64
    let b2 = 2u64
    
    // 使用checkedShr进行右移运算（正常情况）
    let result2 = a2.checkedShr(b2)
    
    // 直接打印结果
    println("Normal case - Checked shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked shr result: None
Normal case - Checked shr result: Some(25)
```

#### func checkedSub(UInt64)

```cangjie
public func checkedSub(y: UInt64): ?UInt64
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的减法运算。

当运算出现溢出时，返回 ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 减数。

返回值：

- ?[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt64值，使减法运算会发生溢出
    let a1 = 100u64
    let b1 = 200u64  // 减数大于被减数
    
    // 使用checkedSub进行减法运算（溢出情况）
    let result1 = a1.checkedSub(b1)
    
    // 直接打印结果
    println("Overflow case - Checked sub result: ${result1}")
    
    // 创建两个UInt64值，使减法运算不会发生溢出
    let a2 = 200u64
    let b2 = 100u64
    
    // 使用checkedSub进行减法运算（正常情况）
    let result2 = a2.checkedSub(b2)
    
    // 直接打印结果
    println("Normal case - Checked sub result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked sub result: None
Normal case - Checked sub result: Some(100)
```

### extend UInt8 <: CheckedOp\<UInt8>

```cangjie
extend UInt8 <: CheckedOp<UInt8>
```

功能：为 [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) 实现 [CheckedOp](#interface-checkedopt) 接口。

父类型：

- [CheckedOp](#interface-checkedopt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)>

#### func checkedAdd(UInt8)

```cangjie
public func checkedAdd(y: UInt8): ?UInt8
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的加法运算。

当运算出现溢出时，返回 ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).None，否则返回运算结果。

参数：

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 加数。

返回值：

- ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt8值，使它们相加会发生溢出
    let a1 = 255u8  // UInt8的最大值
    let b1 = 1u8
    
    // 使用checkedAdd进行加法运算（溢出情况）
    let result1 = a1.checkedAdd(b1)
    
    // 直接打印结果
    println("Overflow case - Checked add result: ${result1}")
    
    // 创建两个UInt8值，使它们相加不会发生溢出
    let a2 = 100u8
    let b2 = 50u8
    
    // 使用checkedAdd进行加法运算（正常情况）
    let result2 = a2.checkedAdd(b2)
    
    // 直接打印结果
    println("Normal case - Checked add result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked add result: None
Normal case - Checked add result: Some(150)
```

#### func checkedDec()

```cangjie
public func checkedDec(): ?UInt8
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的自减运算。

当运算出现溢出时，返回 ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).None，否则返回运算结果。

返回值：

- ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt8值，使其自减会发生溢出
    let a1 = 0u8  // UInt8的最小值
    
    // 使用checkedDec进行自减运算（溢出情况）
    let result1 = a1.checkedDec()
    
    // 直接打印结果
    println("Overflow case - Checked dec result: ${result1}")
    
    // 创建一个UInt8值，使其自减不会发生溢出
    let a2 = 100u8
    
    // 使用checkedDec进行自减运算（正常情况）
    let result2 = a2.checkedDec()
    
    // 直接打印结果
    println("Normal case - Checked dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked dec result: None
Normal case - Checked dec result: Some(99)
```

#### func checkedDiv(UInt8)

```cangjie
public func checkedDiv(y: UInt8): ?UInt8
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的除法运算。

当运算出现溢出时，返回 ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).None，否则返回运算结果。

参数：

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 除数。

返回值：

- ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt8值，使除法运算不会发生溢出
    let a1 = 100u8
    let b1 = 2u8
    
    // 使用checkedDiv进行除法运算（正常情况）
    let result1 = a1.checkedDiv(b1)
    
    // 直接打印结果
    println("Normal case - Checked div result: ${result1}")
    
    // 创建另一个UInt8值对进行除法运算
    let a2 = 200u8
    let b2 = 5u8
    
    // 使用checkedDiv进行除法运算（正常情况）
    let result2 = a2.checkedDiv(b2)
    
    // 直接打印结果
    println("Normal case - Checked div result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Checked div result: Some(50)
Normal case - Checked div result: Some(40)
```

#### func checkedInc()

```cangjie
public func checkedInc(): ?UInt8
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的自增运算。

当运算出现溢出时，返回 ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).None，否则返回运算结果。

返回值：

- ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt8值，使其自增会发生溢出
    let a1 = 255u8  // UInt8的最大值
    
    // 使用checkedInc进行自增运算（溢出情况）
    let result1 = a1.checkedInc()
    
    // 直接打印结果
    println("Overflow case - Checked inc result: ${result1}")
    
    // 创建一个UInt8值，使其自增不会发生溢出
    let a2 = 100u8
    
    // 使用checkedInc进行自增运算（正常情况）
    let result2 = a2.checkedInc()
    
    // 直接打印结果
    println("Normal case - Checked inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked inc result: None
Normal case - Checked inc result: Some(101)
```

#### func checkedMod(UInt8)

```cangjie
public func checkedMod(y: UInt8): ?UInt8
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的取余运算。

当运算出现溢出时，返回 ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).None，否则返回运算结果。

参数：

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 除数。

返回值：

- ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt8值，使取余运算不会发生溢出
    let a1 = 100u8
    let b1 = 3u8
    
    // 使用checkedMod进行取余运算（正常情况）
    let result1 = a1.checkedMod(b1)
    
    // 直接打印结果
    println("Normal case - Checked mod result: ${result1}")
    
    // 创建另一个UInt8值对进行取余运算
    let a2 = 200u8
    let b2 = 7u8
    
    // 使用checkedMod进行取余运算（正常情况）
    let result2 = a2.checkedMod(b2)
    
    // 直接打印结果
    println("Normal case - Checked mod result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Checked mod result: Some(1)
Normal case - Checked mod result: Some(4)
```

#### func checkedMul(UInt8)

```cangjie
public func checkedMul(y: UInt8): ?UInt8
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的乘法运算。

当运算出现溢出时，返回 ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).None，否则返回运算结果。

参数：

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 乘数。

返回值：

- ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt8值，使它们相乘会发生溢出
    let a1 = 255u8  // UInt8的最大值
    let b1 = 2u8
    
    // 使用checkedMul进行乘法运算（溢出情况）
    let result1 = a1.checkedMul(b1)
    
    // 直接打印结果
    println("Overflow case - Checked mul result: ${result1}")
    
    // 创建两个UInt8值，使它们相乘不会发生溢出
    let a2 = 100u8
    let b2 = 2u8
    
    // 使用checkedMul进行乘法运算（正常情况）
    let result2 = a2.checkedMul(b2)
    
    // 直接打印结果
    println("Normal case - Checked mul result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked mul result: None
Normal case - Checked mul result: Some(200)
```

#### func checkedNeg()

```cangjie
public func checkedNeg(): ?UInt8
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的负号运算。

当运算出现溢出时，返回 ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).None，否则返回运算结果。

返回值：

- ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt8值，尝试进行取负运算
    // 注意：对于UInt8类型，取负操作可能会导致溢出
    let a1 = 100u8
    
    // 使用checkedNeg进行取负运算
    let result1 = a1.checkedNeg()
    
    // 直接打印结果
    println("Checked neg result: ${result1}")
    
    return 0
}
```

运行结果：

```text
Checked neg result: None
```

#### func checkedShl(UInt64)

```cangjie
public func checkedShl(y: UInt64): ?UInt8
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的左移运算。

当移位位数大于等于操作数位数时，返回 ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt8值和一个移位位数，使左移运算会发生溢出
    let a1 = 100u8
    let b1 = 8u64  // 移位位数大于等于操作数位数(8)
    
    // 使用checkedShl进行左移运算（溢出情况）
    let result1 = a1.checkedShl(b1)
    
    // 直接打印结果
    println("Overflow case - Checked shl result: ${result1}")
    
    // 创建一个UInt8值和一个移位位数，使左移运算不会发生溢出
    let a2 = 100u8
    let b2 = 2u64
    
    // 使用checkedShl进行左移运算（正常情况）
    let result2 = a2.checkedShl(b2)
    
    // 直接打印结果
    println("Normal case - Checked shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked shl result: None
Normal case - Checked shl result: Some(144)
```

#### func checkedShr(UInt64)

```cangjie
public func checkedShr(y: UInt64): ?UInt8
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的右移运算。

当移位位数大于等于操作数位数时，返回 ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt8值和一个移位位数，使右移运算会发生溢出
    let a1 = 100u8
    let b1 = 8u64  // 移位位数大于等于操作数位数(8)
    
    // 使用checkedShr进行右移运算（溢出情况）
    let result1 = a1.checkedShr(b1)
    
    // 直接打印结果
    println("Overflow case - Checked shr result: ${result1}")
    
    // 创建一个UInt8值和一个移位位数，使右移运算不会发生溢出
    let a2 = 100u8
    let b2 = 2u64
    
    // 使用checkedShr进行右移运算（正常情况）
    let result2 = a2.checkedShr(b2)
    
    // 直接打印结果
    println("Normal case - Checked shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked shr result: None
Normal case - Checked shr result: Some(25)
```

#### func checkedSub(UInt8)

```cangjie
public func checkedSub(y: UInt8): ?UInt8
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的减法运算。

当运算出现溢出时，返回 ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8).None，否则返回运算结果。

参数：

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 减数。

返回值：

- ?[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt8值，使减法运算会发生溢出
    let a1 = 100u8
    let b1 = 200u8  // 减数大于被减数
    
    // 使用checkedSub进行减法运算（溢出情况）
    let result1 = a1.checkedSub(b1)
    
    // 直接打印结果
    println("Overflow case - Checked sub result: ${result1}")
    
    // 创建两个UInt8值，使减法运算不会发生溢出
    let a2 = 200u8
    let b2 = 100u8
    
    // 使用checkedSub进行减法运算（正常情况）
    let result2 = a2.checkedSub(b2)
    
    // 直接打印结果
    println("Normal case - Checked sub result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked sub result: None
Normal case - Checked sub result: Some(100)
```

### extend UIntNative <: CheckedOp\<UIntNative>

```cangjie
extend UIntNative <: CheckedOp<UIntNative>
```

功能：为 [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) 实现 [CheckedOp](#interface-checkedopt) 接口。

父类型：

- [CheckedOp](#interface-checkedopt)\<[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)>

#### func checkedAdd(UIntNative)

```cangjie
public func checkedAdd(y: UIntNative): ?UIntNative
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的加法运算。

当运算出现溢出时，返回 ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).None，否则返回运算结果。

参数：

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 加数。

返回值：

- ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UIntNative值，使它们相加会发生溢出
    let a1 = 18446744073709551615u64  // UIntNative的最大值（假设为64位）
    let b1 = 1u64
    
    // 使用checkedAdd进行加法运算（溢出情况）
    let result1 = a1.checkedAdd(b1)
    
    // 直接打印结果
    println("Overflow case - Checked add result: ${result1}")
    
    // 创建两个UIntNative值，使它们相加不会发生溢出
    let a2 = 100u64
    let b2 = 200u64
    
    // 使用checkedAdd进行加法运算（正常情况）
    let result2 = a2.checkedAdd(b2)
    
    // 直接打印结果
    println("Normal case - Checked add result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked add result: None
Normal case - Checked add result: Some(300)
```

#### func checkedDec()

```cangjie
public func checkedDec(): ?UIntNative
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的自减运算。

当运算出现溢出时，返回 ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).None，否则返回运算结果。

返回值：

- ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UIntNative值，使其自减会发生溢出
    let a1 = 0u64  // UIntNative的最小值
    
    // 使用checkedDec进行自减运算（溢出情况）
    let result1 = a1.checkedDec()
    
    // 直接打印结果
    println("Overflow case - Checked dec result: ${result1}")
    
    // 创建一个UIntNative值，使其自减不会发生溢出
    let a2 = 100u64
    
    // 使用checkedDec进行自减运算（正常情况）
    let result2 = a2.checkedDec()
    
    // 直接打印结果
    println("Normal case - Checked dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked dec result: None
Normal case - Checked dec result: Some(99)
```

#### func checkedDiv(UIntNative)

```cangjie
public func checkedDiv(y: UIntNative): ?UIntNative
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的除法运算。

当运算出现溢出时，返回 ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).None，否则返回运算结果。

参数：

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 除数。

返回值：

- ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UIntNative值，使除法运算不会发生溢出
    let a1 = 100u64
    let b1 = 2u64
    
    // 使用checkedDiv进行除法运算（正常情况）
    let result1 = a1.checkedDiv(b1)
    
    // 直接打印结果
    println("Normal case - Checked div result: ${result1}")
    
    // 创建另一个UIntNative值对进行除法运算
    let a2 = 1000u64
    let b2 = 5u64
    
    // 使用checkedDiv进行除法运算（正常情况）
    let result2 = a2.checkedDiv(b2)
    
    // 直接打印结果
    println("Normal case - Checked div result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Checked div result: Some(50)
Normal case - Checked div result: Some(200)
```

#### func checkedInc()

```cangjie
public func checkedInc(): ?UIntNative
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的自增运算。

当运算出现溢出时，返回 ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).None，否则返回运算结果。

返回值：

- ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UIntNative值，使其自增会发生溢出
    let a1 = 18446744073709551615u64  // UIntNative的最大值（假设为64位）
    
    // 使用checkedInc进行自增运算（溢出情况）
    let result1 = a1.checkedInc()
    
    // 直接打印结果
    println("Overflow case - Checked inc result: ${result1}")
    
    // 创建一个UIntNative值，使其自增不会发生溢出
    let a2 = 100u64
    
    // 使用checkedInc进行自增运算（正常情况）
    let result2 = a2.checkedInc()
    
    // 直接打印结果
    println("Normal case - Checked inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked inc result: None
Normal case - Checked inc result: Some(101)
```

#### func checkedMod(UIntNative)

```cangjie
public func checkedMod(y: UIntNative): ?UIntNative
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的取余运算。

当运算出现溢出时，返回 ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).None，否则返回运算结果。

参数：

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 除数。

返回值：

- ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UIntNative值，使取余运算不会发生溢出
    let a1 = 100u64
    let b1 = 3u64
    
    // 使用checkedMod进行取余运算（正常情况）
    let result1 = a1.checkedMod(b1)
    
    // 直接打印结果
    println("Normal case - Checked mod result: ${result1}")
    
    // 创建另一个UIntNative值对进行取余运算
    let a2 = 1000u64
    let b2 = 7u64
    
    // 使用checkedMod进行取余运算（正常情况）
    let result2 = a2.checkedMod(b2)
    
    // 直接打印结果
    println("Normal case - Checked mod result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Checked mod result: Some(1)
Normal case - Checked mod result: Some(6)
```

#### func checkedMul(UIntNative)

```cangjie
public func checkedMul(y: UIntNative): ?UIntNative
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的乘法运算。

当运算出现溢出时，返回 ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).None，否则返回运算结果。

参数：

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 乘数。

返回值：

- ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UIntNative值，使它们相乘会发生溢出
    let a1 = 18446744073709551615u64  // UIntNative的最大值（假设为64位）
    let b1 = 2u64
    
    // 使用checkedMul进行乘法运算（溢出情况）
    let result1 = a1.checkedMul(b1)
    
    // 直接打印结果
    println("Overflow case - Checked mul result: ${result1}")
    
    // 创建两个UIntNative值，使它们相乘不会发生溢出
    let a2 = 100u64
    let b2 = 200u64
    
    // 使用checkedMul进行乘法运算（正常情况）
    let result2 = a2.checkedMul(b2)
    
    // 直接打印结果
    println("Normal case - Checked mul result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked mul result: None
Normal case - Checked mul result: Some(20000)
```

#### func checkedNeg()

```cangjie
public func checkedNeg(): ?UIntNative
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的负号运算。

当运算出现溢出时，返回 ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).None，否则返回运算结果。

返回值：

- ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UIntNative值，尝试进行取负运算
    // 注意：对于UIntNative类型，取负操作可能会导致溢出
    let a1 = 100u64
    
    // 使用checkedNeg进行取负运算
    let result1 = a1.checkedNeg()
    
    // 直接打印结果
    println("Checked neg result: ${result1}")
    
    return 0
}
```

运行结果：

```text
Checked neg result: None
```

#### func checkedShl(UInt64)

```cangjie
public func checkedShl(y: UInt64): ?UIntNative
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的左移运算。

当移位位数大于等于操作数位数时，返回 ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UIntNative值和一个移位位数，使左移运算会发生溢出
    let a1 = 100u64
    let b1 = 64u64  // 移位位数大于等于操作数位数(64)
    
    // 使用checkedShl进行左移运算（溢出情况）
    let result1 = a1.checkedShl(b1)
    
    // 直接打印结果
    println("Overflow case - Checked shl result: ${result1}")
    
    // 创建一个UIntNative值和一个移位位数，使左移运算不会发生溢出
    let a2 = 100u64
    let b2 = 2u64
    
    // 使用checkedShl进行左移运算（正常情况）
    let result2 = a2.checkedShl(b2)
    
    // 直接打印结果
    println("Normal case - Checked shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked shl result: None
Normal case - Checked shl result: Some(400)
```

#### func checkedShr(UInt64)

```cangjie
public func checkedShr(y: UInt64): ?UIntNative
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的右移运算。

当移位位数大于等于操作数位数时，返回 ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UIntNative值和一个移位位数，使右移运算会发生溢出
    let a1 = 100u64
    let b1 = 64u64  // 移位位数大于等于操作数位数(64)
    
    // 使用checkedShr进行右移运算（溢出情况）
    let result1 = a1.checkedShr(b1)
    
    // 直接打印结果
    println("Overflow case - Checked shr result: ${result1}")
    
    // 创建一个UIntNative值和一个移位位数，使右移运算不会发生溢出
    let a2 = 100u64
    let b2 = 2u64
    
    // 使用checkedShr进行右移运算（正常情况）
    let result2 = a2.checkedShr(b2)
    
    // 直接打印结果
    println("Normal case - Checked shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked shr result: None
Normal case - Checked shr result: Some(25)
```

#### func checkedSub(UIntNative)

```cangjie
public func checkedSub(y: UIntNative): ?UIntNative
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的减法运算。

当运算出现溢出时，返回 ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative).None，否则返回运算结果。

参数：

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 减数。

返回值：

- ?[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UIntNative值，使减法运算会发生溢出
    let a1 = 100u64
    let b1 = 200u64  // 减数大于被减数
    
    // 使用checkedSub进行减法运算（溢出情况）
    let result1 = a1.checkedSub(b1)
    
    // 直接打印结果
    println("Overflow case - Checked sub result: ${result1}")
    
    // 创建两个UIntNative值，使减法运算不会发生溢出
    let a2 = 200u64
    let b2 = 100u64
    
    // 使用checkedSub进行减法运算（正常情况）
    let result2 = a2.checkedSub(b2)
    
    // 直接打印结果
    println("Normal case - Checked sub result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Checked sub result: None
Normal case - Checked sub result: Some(100)
```

## interface CheckedPow

```cangjie
public interface CheckedPow {
    func checkedPow(y: UInt64): ?Int64
}
```

功能：提供返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的幂运算接口。

### func checkedPow(UInt64)

```cangjie
func checkedPow(y: UInt64): ?Int64
```

功能：使用返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 策略的幂运算。

当运算出现溢出时，返回 ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64).None，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 指数。

返回值：

- ?[Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 幂运算结果。

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

功能：当整数运算出现溢出，饱和处理。

### func saturatingAdd(T)

```cangjie
func saturatingAdd(y: T): T
```

功能：使用饱和策略的加法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: T - 加数。

返回值：

- T - 加法运算结果。

### func saturatingDec()

```cangjie
func saturatingDec(): T
```

功能：使用饱和策略的自减运算。

当运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

返回值：

- T - 自减运算结果。

### func saturatingDiv(T)

```cangjie
func saturatingDiv(y: T): T
```

功能：使用饱和策略的除法运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

参数：

- y: T - 除数。

返回值：

- T - 除法运算结果。

### func saturatingInc()

```cangjie
func saturatingInc(): T
```

功能：使用饱和策略的自增运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

返回值：

- T - 自增运算结果。

### func saturatingMod(T)

```cangjie
func saturatingMod(y: T): T
```

功能：使用饱和策略的取余运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

参数：

- y: T - 除数。

返回值：

- T - 取余运算结果。

### func saturatingMul(T)

```cangjie
func saturatingMul(y: T): T
```

功能：使用饱和策略的乘法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: T - 乘数。

返回值：

- T - 乘法运算结果。

### func saturatingNeg()

```cangjie
func saturatingNeg(): T
```

功能：使用饱和策略的负号运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

返回值：

- T - 负号运算结果。

### func saturatingShl(UInt64)

```cangjie
func saturatingShl(y: UInt64): T
```

功能：使用饱和策略的左移运算。

当移位位数大于等于操作数位数时，将移位位数置为操作数位数 - 1，返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- T - 左移运算结果。

### func saturatingShr(UInt64)

```cangjie
func saturatingShr(y: UInt64): T
```

功能：使用饱和策略的右移运算。

当移位位数大于等于操作数位数时，将移位位数置为操作数位数 - 1，返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- T - 右移运算结果。

### func saturatingSub(T)

```cangjie
func saturatingSub(y: T): T
```

功能：使用饱和策略的减法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: T - 减数。

返回值：

- T - 减法运算结果。

### extend Int16 <: SaturatingOp\<Int16>

```cangjie
extend Int16 <: SaturatingOp<Int16>
```

功能：为 [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) 实现 [SaturatingOp](#interface-saturatingopt) 接口。

父类型：

- [SaturatingOp](#interface-saturatingopt)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)>

#### func saturatingAdd(Int16)

```cangjie
public func saturatingAdd(y: Int16): Int16
```

功能：使用饱和策略的加法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 加数。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int16值，使它们相加会发生上溢出
    let a1 = 32767i16  // Int16的最大值
    let b1 = 1i16
    
    // 使用saturatingAdd进行加法运算（上溢出情况）
    let result1 = a1.saturatingAdd(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating add result: ${result1}")
    
    // 创建两个Int16值，使它们相加会发生下溢出
    let a2 = -32768i16  // Int16的最小值
    let b2 = -1i16
    
    // 使用saturatingAdd进行加法运算（下溢出情况）
    let result2 = a2.saturatingAdd(b2)
    
    // 直接打印结果
    println("Underflow case - Saturating add result: ${result2}")
    
    // 创建两个Int16值，使它们相加不会发生溢出
    let a3 = 100i16
    let b3 = 200i16
    
    // 使用saturatingAdd进行加法运算（正常情况）
    let result3 = a3.saturatingAdd(b3)
    
    // 直接打印结果
    println("Normal case - Saturating add result: ${result3}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating add result: 32767
Underflow case - Saturating add result: -32768
Normal case - Saturating add result: 300
```

#### func saturatingDec()

```cangjie
public func saturatingDec(): Int16
```

功能：使用饱和策略的自减运算。

当运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int16值，使其自减会发生下溢出
    let a1 = -32768i16  // Int16的最小值
    
    // 使用saturatingDec进行自减运算（下溢出情况）
    let result1 = a1.saturatingDec()
    
    // 直接打印结果
    println("Underflow case - Saturating dec result: ${result1}")
    
    // 创建一个Int16值，使其自减不会发生溢出
    let a2 = 100i16
    
    // 使用saturatingDec进行自减运算（正常情况）
    let result2 = a2.saturatingDec()
    
    // 直接打印结果
    println("Normal case - Saturating dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Saturating dec result: -32768
Normal case - Saturating dec result: 99
```

#### func saturatingDiv(Int16)

```cangjie
public func saturatingDiv(y: Int16): Int16
```

功能：使用饱和策略的除法运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

参数：

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 除数。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int16值，使除法运算会发生上溢出
    let a1 = -32768i16  // Int16的最小值
    let b1 = -1i16
    
    // 使用saturatingDiv进行除法运算（上溢出情况）
    let result1 = a1.saturatingDiv(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating div result: ${result1}")
    
    // 创建两个Int16值，使除法运算不会发生溢出
    let a2 = 100i16
    let b2 = 2i16
    
    // 使用saturatingDiv进行除法运算（正常情况）
    let result2 = a2.saturatingDiv(b2)
    
    // 直接打印结果
    println("Normal case - Saturating div result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating div result: 32767
Normal case - Saturating div result: 50
```

#### func saturatingInc()

```cangjie
public func saturatingInc(): Int16
```

功能：使用饱和策略的自增运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int16值，使其自增会发生上溢出
    let a1 = 32767i16  // Int16的最大值
    
    // 使用saturatingInc进行自增运算（上溢出情况）
    let result1 = a1.saturatingInc()
    
    // 直接打印结果
    println("Overflow case - Saturating inc result: ${result1}")
    
    // 创建一个Int16值，使其自增不会发生溢出
    let a2 = 100i16
    
    // 使用saturatingInc进行自增运算（正常情况）
    let result2 = a2.saturatingInc()
    
    // 直接打印结果
    println("Normal case - Saturating inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating inc result: 32767
Normal case - Saturating inc result: 101
```

#### func saturatingMod(Int16)

```cangjie
public func saturatingMod(y: Int16): Int16
```

功能：使用饱和策略的取余运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

参数：

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 除数。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int16值，使取余运算会发生上溢出
    let a1 = -32768i16  // Int16的最小值
    let b1 = -1i16
    
    // 使用saturatingMod进行取余运算（上溢出情况）
    let result1 = a1.saturatingMod(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating mod result: ${result1}")
    
    // 创建两个Int16值，使取余运算不会发生溢出
    let a2 = 100i16
    let b2 = 3i16
    
    // 使用saturatingMod进行取余运算（正常情况）
    let result2 = a2.saturatingMod(b2)
    
    // 直接打印结果
    println("Normal case - Saturating mod result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating mod result: 0
Normal case - Saturating mod result: 1
```

#### func saturatingMul(Int16)

```cangjie
public func saturatingMul(y: Int16): Int16
```

功能：使用饱和策略的乘法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 乘数。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int16值，使它们相乘会发生上溢出
    let a1 = 32767i16  // Int16的最大值
    let b1 = 2i16
    
    // 使用saturatingMul进行乘法运算（上溢出情况）
    let result1 = a1.saturatingMul(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating mul result: ${result1}")
    
    // 创建两个Int16值，使它们相乘会发生下溢出
    let a2 = -32768i16  // Int16的最小值
    let b2 = 2i16
    
    // 使用saturatingMul进行乘法运算（下溢出情况）
    let result2 = a2.saturatingMul(b2)
    
    // 直接打印结果
    println("Underflow case - Saturating mul result: ${result2}")
    
    // 创建两个Int16值，使它们相乘不会发生溢出
    let a3 = 100i16
    let b3 = 200i16
    
    // 使用saturatingMul进行乘法运算（正常情况）
    let result3 = a3.saturatingMul(b3)
    
    // 直接打印结果
    println("Normal case - Saturating mul result: ${result3}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating mul result: 32767
Underflow case - Saturating mul result: -32768
Normal case - Saturating mul result: 20000
```

#### func saturatingNeg()

```cangjie
public func saturatingNeg(): Int16
```

功能：使用饱和策略的负号运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int16值，使其取负会发生上溢出
    let a1 = -32768i16  // Int16的最小值
    
    // 使用saturatingNeg进行取负运算（上溢出情况）
    let result1 = a1.saturatingNeg()
    
    // 直接打印结果
    println("Overflow case - Saturating neg result: ${result1}")
    
    // 创建一个Int16值，使其取负会发生下溢出
    let a2 = 32767i16  // Int16的最大值
    
    // 使用saturatingNeg进行取负运算（下溢出情况）
    let result2 = a2.saturatingNeg()
    
    // 直接打印结果
    println("Underflow case - Saturating neg result: ${result2}")
    
    // 创建一个Int16值，使其取负不会发生溢出
    let a3 = 100i16
    
    // 使用saturatingNeg进行取负运算（正常情况）
    let result3 = a3.saturatingNeg()
    
    // 直接打印结果
    println("Normal case - Saturating neg result: ${result3}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating neg result: 32767
Underflow case - Saturating neg result: -32767
Normal case - Saturating neg result: -100
```

#### func saturatingShl(UInt64)

```cangjie
public func saturatingShl(y: UInt64): Int16
```

功能：使用饱和策略的左移运算。

当移位位数大于等于操作数位数时，将移位位数置为操作数位数 - 1，返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int16值和一个移位位数，使左移运算会发生溢出
    let a1 = 100i16
    let b1 = 16u64  // 移位位数大于等于操作数位数(16)
    
    // 使用saturatingShl进行左移运算（溢出情况）
    let result1 = a1.saturatingShl(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating shl result: ${result1}")
    
    // 创建一个Int16值和一个移位位数，使左移运算不会发生溢出
    let a2 = 100i16
    let b2 = 2u64
    
    // 使用saturatingShl进行左移运算（正常情况）
    let result2 = a2.saturatingShl(b2)
    
    // 直接打印结果
    println("Normal case - Saturating shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating shl result: 0
Normal case - Saturating shl result: 400
```

#### func saturatingShr(UInt64)

```cangjie
public func saturatingShr(y: UInt64): Int16
```

功能：使用饱和策略的右移运算。

当移位位数大于等于操作数位数时，将移位位数置为操作数位数 - 1，返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int16值和一个移位位数，使右移运算会发生溢出
    let a1 = 100i16
    let b1 = 16u64  // 移位位数大于等于操作数位数(16)
    
    // 使用saturatingShr进行右移运算（溢出情况）
    let result1 = a1.saturatingShr(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating shr result: ${result1}")
    
    // 创建一个Int16值和一个移位位数，使右移运算不会发生溢出
    let a2 = 100i16
    let b2 = 2u64
    
    // 使用saturatingShr进行右移运算（正常情况）
    let result2 = a2.saturatingShr(b2)
    
    // 直接打印结果
    println("Normal case - Saturating shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating shr result: 0
Normal case - Saturating shr result: 25
```

#### func saturatingSub(Int16)

```cangjie
public func saturatingSub(y: Int16): Int16
```

功能：使用饱和策略的减法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 减数。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int16值，使它们相减会发生上溢出
    let a1 = 32767i16  // Int16的最大值
    let b1 = -1i16
    
    // 使用saturatingSub进行减法运算（上溢出情况）
    let result1 = a1.saturatingSub(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating sub result: ${result1}")
    
    // 创建两个Int16值，使它们相减会发生下溢出
    let a2 = -32768i16  // Int16的最小值
    let b2 = 1i16
    
    // 使用saturatingSub进行减法运算（下溢出情况）
    let result2 = a2.saturatingSub(b2)
    
    // 直接打印结果
    println("Underflow case - Saturating sub result: ${result2}")
    
    // 创建两个Int16值，使它们相减不会发生溢出
    let a3 = 100i16
    let b3 = 50i16
    
    // 使用saturatingSub进行减法运算（正常情况）
    let result3 = a3.saturatingSub(b3)
    
    // 直接打印结果
    println("Normal case - Saturating sub result: ${result3}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating sub result: 32767
Underflow case - Saturating sub result: -32768
Normal case - Saturating sub result: 50
```

### extend Int32 <: SaturatingOp\<Int32>

```cangjie
extend Int32 <: SaturatingOp<Int32>
```

功能：为 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 实现 [SaturatingOp](#interface-saturatingopt) 接口。

父类型：

- [SaturatingOp](#interface-saturatingopt)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)>

#### func saturatingAdd(Int32)

```cangjie
public func saturatingAdd(y: Int32): Int32
```

功能：使用饱和策略的加法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 加数。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int32值，使它们相加会发生上溢出
    let a1 = 2147483647i32  // Int32的最大值
    let b1 = 1i32
    
    // 使用saturatingAdd进行加法运算（上溢出情况）
    let result1 = a1.saturatingAdd(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating add result: ${result1}")
    
    // 创建两个Int32值，使它们相加会发生下溢出
    let a2 = -2147483648i32  // Int32的最小值
    let b2 = -1i32
    
    // 使用saturatingAdd进行加法运算（下溢出情况）
    let result2 = a2.saturatingAdd(b2)
    
    // 直接打印结果
    println("Underflow case - Saturating add result: ${result2}")
    
    // 创建两个Int32值，使它们相加不会发生溢出
    let a3 = 100i32
    let b3 = 200i32
    
    // 使用saturatingAdd进行加法运算（正常情况）
    let result3 = a3.saturatingAdd(b3)
    
    // 直接打印结果
    println("Normal case - Saturating add result: ${result3}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating add result: 2147483647
Underflow case - Saturating add result: -2147483648
Normal case - Saturating add result: 300
```

#### func saturatingDec()

```cangjie
public func saturatingDec(): Int32
```

功能：使用饱和策略的自减运算。

当运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int32值，使其自减会发生下溢出
    let a1 = -2147483648i32  // Int32的最小值
    
    // 使用saturatingDec进行自减运算（下溢出情况）
    let result1 = a1.saturatingDec()
    
    // 直接打印结果
    println("Underflow case - Saturating dec result: ${result1}")
    
    // 创建一个Int32值，使其自减不会发生溢出
    let a2 = 100i32
    
    // 使用saturatingDec进行自减运算（正常情况）
    let result2 = a2.saturatingDec()
    
    // 直接打印结果
    println("Normal case - Saturating dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Saturating dec result: -2147483648
Normal case - Saturating dec result: 99
```

#### func saturatingDiv(Int32)

```cangjie
public func saturatingDiv(y: Int32): Int32
```

功能：使用饱和策略的除法运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

参数：

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 除数。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int32值，使除法运算会发生上溢出
    let a1 = -2147483648i32  // Int32的最小值
    let b1 = -1i32
    
    // 使用saturatingDiv进行除法运算（上溢出情况）
    let result1 = a1.saturatingDiv(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating div result: ${result1}")
    
    // 创建两个Int32值，使除法运算不会发生溢出
    let a2 = 100i32
    let b2 = 2i32
    
    // 使用saturatingDiv进行除法运算（正常情况）
    let result2 = a2.saturatingDiv(b2)
    
    // 直接打印结果
    println("Normal case - Saturating div result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating div result: 2147483647
Normal case - Saturating div result: 50
```

#### func saturatingInc()

```cangjie
public func saturatingInc(): Int32
```

功能：使用饱和策略的自增运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int32值，使其自增会发生上溢出
    let a1 = 2147483647i32  // Int32的最大值
    
    // 使用saturatingInc进行自增运算（上溢出情况）
    let result1 = a1.saturatingInc()
    
    // 直接打印结果
    println("Overflow case - Saturating inc result: ${result1}")
    
    // 创建一个Int32值，使其自增不会发生溢出
    let a2 = 100i32
    
    // 使用saturatingInc进行自增运算（正常情况）
    let result2 = a2.saturatingInc()
    
    // 直接打印结果
    println("Normal case - Saturating inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating inc result: 2147483647
Normal case - Saturating inc result: 101
```

#### func saturatingMod(Int32)

```cangjie
public func saturatingMod(y: Int32): Int32
```

功能：使用饱和策略的取余运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

参数：

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 除数。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int32值，使取余运算会发生上溢出
    let a1 = -2147483648i32  // Int32的最小值
    let b1 = -1i32
    
    // 使用saturatingMod进行取余运算（上溢出情况）
    let result1 = a1.saturatingMod(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating mod result: ${result1}")
    
    // 创建两个Int32值，使取余运算不会发生溢出
    let a2 = 100i32
    let b2 = 3i32
    
    // 使用saturatingMod进行取余运算（正常情况）
    let result2 = a2.saturatingMod(b2)
    
    // 直接打印结果
    println("Normal case - Saturating mod result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating mod result: 0
Normal case - Saturating mod result: 1
```

#### func saturatingMul(Int32)

```cangjie
public func saturatingMul(y: Int32): Int32
```

功能：使用饱和策略的乘法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 乘数。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int32值，使它们相乘会发生上溢出
    let a1 = 2147483647i32  // Int32的最大值
    let b1 = 2i32
    
    // 使用saturatingMul进行乘法运算（上溢出情况）
    let result1 = a1.saturatingMul(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating mul result: ${result1}")
    
    // 创建两个Int32值，使它们相乘会发生下溢出
    let a2 = -2147483648i32  // Int32的最小值
    let b2 = 2i32
    
    // 使用saturatingMul进行乘法运算（下溢出情况）
    let result2 = a2.saturatingMul(b2)
    
    // 直接打印结果
    println("Underflow case - Saturating mul result: ${result2}")
    
    // 创建两个Int32值，使它们相乘不会发生溢出
    let a3 = 100i32
    let b3 = 200i32
    
    // 使用saturatingMul进行乘法运算（正常情况）
    let result3 = a3.saturatingMul(b3)
    
    // 直接打印结果
    println("Normal case - Saturating mul result: ${result3}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating mul result: 2147483647
Underflow case - Saturating mul result: -2147483648
Normal case - Saturating mul result: 20000
```

#### func saturatingNeg()

```cangjie
public func saturatingNeg(): Int32
```

功能：使用饱和策略的负号运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int32值，使其取负会发生上溢出
    let a1 = -2147483648i32  // Int32的最小值
    
    // 使用saturatingNeg进行取负运算（上溢出情况）
    let result1 = a1.saturatingNeg()
    
    // 直接打印结果
    println("Overflow case - Saturating neg result: ${result1}")
    
    // 创建一个Int32值，使其取负会发生下溢出
    let a2 = 2147483647i32  // Int32的最大值
    
    // 使用saturatingNeg进行取负运算（下溢出情况）
    let result2 = a2.saturatingNeg()
    
    // 直接打印结果
    println("Underflow case - Saturating neg result: ${result2}")
    
    // 创建一个Int32值，使其取负不会发生溢出
    let a3 = 100i32
    
    // 使用saturatingNeg进行取负运算（正常情况）
    let result3 = a3.saturatingNeg()
    
    // 直接打印结果
    println("Normal case - Saturating neg result: ${result3}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating neg result: 2147483647
Underflow case - Saturating neg result: -2147483647
Normal case - Saturating neg result: -100
```

#### func saturatingShl(UInt64)

```cangjie
public func saturatingShl(y: UInt64): Int32
```

功能：使用饱和策略的左移运算。

当移位位数大于等于操作数位数时，将移位位数置为操作数位数 - 1，返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int32值和一个移位位数，使左移运算会发生溢出
    let a1 = 100i32
    let b1 = 32u64  // 移位位数大于等于操作数位数(32)
    
    // 使用saturatingShl进行左移运算（溢出情况）
    let result1 = a1.saturatingShl(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating shl result: ${result1}")
    
    // 创建一个Int32值和一个移位位数，使左移运算不会发生溢出
    let a2 = 100i32
    let b2 = 2u64
    
    // 使用saturatingShl进行左移运算（正常情况）
    let result2 = a2.saturatingShl(b2)
    
    // 直接打印结果
    println("Normal case - Saturating shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating shl result: 0
Normal case - Saturating shl result: 400
```

#### func saturatingShr(UInt64)

```cangjie
public func saturatingShr(y: UInt64): Int32
```

功能：使用饱和策略的右移运算。

当移位位数大于等于操作数位数时，将移位位数置为操作数位数 - 1，返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int32值和一个移位位数，使右移运算会发生溢出
    let a1 = 100i32
    let b1 = 32u64  // 移位位数大于等于操作数位数(32)
    
    // 使用saturatingShr进行右移运算（溢出情况）
    let result1 = a1.saturatingShr(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating shr result: ${result1}")
    
    // 创建一个Int32值和一个移位位数，使右移运算不会发生溢出
    let a2 = 100i32
    let b2 = 2u64
    
    // 使用saturatingShr进行右移运算（正常情况）
    let result2 = a2.saturatingShr(b2)
    
    // 直接打印结果
    println("Normal case - Saturating shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating shr result: 0
Normal case - Saturating shr result: 25
```

#### func saturatingSub(Int32)

```cangjie
public func saturatingSub(y: Int32): Int32
```

功能：使用饱和策略的减法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 减数。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int32值，使它们相减会发生上溢出
    let a1 = 2147483647i32  // Int32的最大值
    let b1 = -1i32
    
    // 使用saturatingSub进行减法运算（上溢出情况）
    let result1 = a1.saturatingSub(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating sub result: ${result1}")
    
    // 创建两个Int32值，使它们相减会发生下溢出
    let a2 = -2147483648i32  // Int32的最小值
    let b2 = 1i32
    
    // 使用saturatingSub进行减法运算（下溢出情况）
    let result2 = a2.saturatingSub(b2)
    
    // 直接打印结果
    println("Underflow case - Saturating sub result: ${result2}")
    
    // 创建两个Int32值，使它们相减不会发生溢出
    let a3 = 100i32
    let b3 = 50i32
    
    // 使用saturatingSub进行减法运算（正常情况）
    let result3 = a3.saturatingSub(b3)
    
    // 直接打印结果
    println("Normal case - Saturating sub result: ${result3}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating sub result: 2147483647
Underflow case - Saturating sub result: -2147483648
Normal case - Saturating sub result: 50
```

### extend Int64 <: SaturatingOp\<Int64> & SaturatingPow

```cangjie
extend Int64 <: SaturatingOp<Int64> & SaturatingPow
```

功能：为 [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) 实现 [SaturatingOp](#interface-saturatingopt) 和 [SaturatingPow](#interface-saturatingpow) 接口。

父类型：

- [SaturatingOp](#interface-saturatingopt)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>
- [SaturatingPow](#interface-saturatingpow)

#### func saturatingAdd(Int64)

```cangjie
public func saturatingAdd(y: Int64): Int64
```

功能：使用饱和策略的加法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 加数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int64值，使它们相加会发生上溢出
    let a1 = 9223372036854775807i64  // Int64的最大值
    let b1 = 1i64
    
    // 使用saturatingAdd进行加法运算（上溢出情况）
    let result1 = a1.saturatingAdd(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating add result: ${result1}")
    
    // 创建两个Int64值，使它们相加会发生下溢出
    let a2 = -9223372036854775808i64  // Int64的最小值
    let b2 = -1i64
    
    // 使用saturatingAdd进行加法运算（下溢出情况）
    let result2 = a2.saturatingAdd(b2)
    
    // 直接打印结果
    println("Underflow case - Saturating add result: ${result2}")
    
    // 创建两个Int64值，使它们相加不会发生溢出
    let a3 = 100i64
    let b3 = 200i64
    
    // 使用saturatingAdd进行加法运算（正常情况）
    let result3 = a3.saturatingAdd(b3)
    
    // 直接打印结果
    println("Normal case - Saturating add result: ${result3}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating add result: 9223372036854775807
Underflow case - Saturating add result: -9223372036854775808
Normal case - Saturating add result: 300
```

#### func saturatingDec()

```cangjie
public func saturatingDec(): Int64
```

功能：使用饱和策略的自减运算。

当运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值，使其自减会发生下溢出
    let a1 = -9223372036854775808i64  // Int64的最小值
    
    // 使用saturatingDec进行自减运算（下溢出情况）
    let result1 = a1.saturatingDec()
    
    // 直接打印结果
    println("Underflow case - Saturating dec result: ${result1}")
    
    // 创建一个Int64值，使其自减不会发生溢出
    let a2 = 100i64
    
    // 使用saturatingDec进行自减运算（正常情况）
    let result2 = a2.saturatingDec()
    
    // 直接打印结果
    println("Normal case - Saturating dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Saturating dec result: -9223372036854775808
Normal case - Saturating dec result: 99
```

#### func saturatingDiv(Int64)

```cangjie
public func saturatingDiv(y: Int64): Int64
```

功能：使用饱和策略的除法运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

参数：

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 除数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int64值，使除法运算会发生上溢出
    let a1 = -9223372036854775808i64  // Int64的最小值
    let b1 = -1i64
    
    // 使用saturatingDiv进行除法运算（上溢出情况）
    let result1 = a1.saturatingDiv(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating div result: ${result1}")
    
    // 创建两个Int64值，使除法运算不会发生溢出
    let a2 = 100i64
    let b2 = 2i64
    
    // 使用saturatingDiv进行除法运算（正常情况）
    let result2 = a2.saturatingDiv(b2)
    
    // 直接打印结果
    println("Normal case - Saturating div result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating div result: 9223372036854775807
Normal case - Saturating div result: 50
```

#### func saturatingInc()

```cangjie
public func saturatingInc(): Int64
```

功能：使用饱和策略的自增运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值，使其自增会发生上溢出
    let a1 = 9223372036854775807i64  // Int64的最大值
    
    // 使用saturatingInc进行自增运算（上溢出情况）
    let result1 = a1.saturatingInc()
    
    // 直接打印结果
    println("Overflow case - Saturating inc result: ${result1}")
    
    // 创建一个Int64值，使其自增不会发生溢出
    let a2 = 100i64
    
    // 使用saturatingInc进行自增运算（正常情况）
    let result2 = a2.saturatingInc()
    
    // 直接打印结果
    println("Normal case - Saturating inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating inc result: 9223372036854775807
Normal case - Saturating inc result: 101
```

#### func saturatingMod(Int64)

```cangjie
public func saturatingMod(y: Int64): Int64
```

功能：使用饱和策略的取余运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

参数：

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 除数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int64值，使取余运算会发生上溢出
    let a1 = -9223372036854775808i64  // Int64的最小值
    let b1 = -1i64
    
    // 使用saturatingMod进行取余运算（上溢出情况）
    let result1 = a1.saturatingMod(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating mod result: ${result1}")
    
    // 创建两个Int64值，使取余运算不会发生溢出
    let a2 = 100i64
    let b2 = 3i64
    
    // 使用saturatingMod进行取余运算（正常情况）
    let result2 = a2.saturatingMod(b2)
    
    // 直接打印结果
    println("Normal case - Saturating mod result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating mod result: 0
Normal case - Saturating mod result: 1
```

#### func saturatingMul(Int64)

```cangjie
public func saturatingMul(y: Int64): Int64
```

功能：使用饱和策略的乘法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 乘数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int64值，使它们相乘会发生上溢出
    let a1 = 9223372036854775807i64  // Int64的最大值
    let b1 = 2i64
    
    // 使用saturatingMul进行乘法运算（上溢出情况）
    let result1 = a1.saturatingMul(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating mul result: ${result1}")
    
    // 创建两个Int64值，使它们相乘会发生下溢出
    let a2 = -9223372036854775808i64  // Int64的最小值
    let b2 = 2i64
    
    // 使用saturatingMul进行乘法运算（下溢出情况）
    let result2 = a2.saturatingMul(b2)
    
    // 直接打印结果
    println("Underflow case - Saturating mul result: ${result2}")
    
    // 创建两个Int64值，使它们相乘不会发生溢出
    let a3 = 100i64
    let b3 = 200i64
    
    // 使用saturatingMul进行乘法运算（正常情况）
    let result3 = a3.saturatingMul(b3)
    
    // 直接打印结果
    println("Normal case - Saturating mul result: ${result3}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating mul result: 9223372036854775807
Underflow case - Saturating mul result: -9223372036854775808
Normal case - Saturating mul result: 20000
```

#### func saturatingNeg()

```cangjie
public func saturatingNeg(): Int64
```

功能：使用饱和策略的负号运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值，使其取负会发生上溢出
    let a1 = -9223372036854775808i64  // Int64的最小值
    
    // 使用saturatingNeg进行取负运算（上溢出情况）
    let result1 = a1.saturatingNeg()
    
    // 直接打印结果
    println("Overflow case - Saturating neg result: ${result1}")
    
    // 创建一个Int64值，使其取负会发生下溢出
    let a2 = 9223372036854775807i64  // Int64的最大值
    
    // 使用saturatingNeg进行取负运算（下溢出情况）
    let result2 = a2.saturatingNeg()
    
    // 直接打印结果
    println("Underflow case - Saturating neg result: ${result2}")
    
    // 创建一个Int64值，使其取负不会发生溢出
    let a3 = 100i64
    
    // 使用saturatingNeg进行取负运算（正常情况）
    let result3 = a3.saturatingNeg()
    
    // 直接打印结果
    println("Normal case - Saturating neg result: ${result3}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating neg result: 9223372036854775807
Underflow case - Saturating neg result: -9223372036854775807
Normal case - Saturating neg result: -100
```

#### func saturatingPow(UInt64)

```cangjie
public func saturatingPow(y: UInt64): Int64
```

功能：使用饱和策略的幂运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 指数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 幂运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值和一个指数，使幂运算会发生上溢出
    let a1 = 10000000000i64  // 较大的Int64值
    let b1 = 10u64  // 较大的指数
    
    // 使用saturatingPow进行幂运算（上溢出情况）
    let result1 = a1.saturatingPow(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating pow result: ${result1}")
    
    // 创建一个Int64值和一个指数，使幂运算会发生下溢出
    let a2 = -10000000000i64  // 较大的负Int64值
    let b2 = 10u64  // 较大的指数
    
    // 使用saturatingPow进行幂运算（下溢出情况）
    let result2 = a2.saturatingPow(b2)
    
    // 直接打印结果
    println("Underflow case - Saturating pow result: ${result2}")
    
    // 创建一个Int64值和一个指数，使幂运算不会发生溢出
    let a3 = 10i64
    let b3 = 2u64
    
    // 使用saturatingPow进行幂运算（正常情况）
    let result3 = a3.saturatingPow(b3)
    
    // 直接打印结果
    println("Normal case - Saturating pow result: ${result3}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating pow result: 9223372036854775807
Underflow case - Saturating pow result: 9223372036854775807
Normal case - Saturating pow result: 100
```

#### func saturatingShl(UInt64)

```cangjie
public func saturatingShl(y: UInt64): Int64
```

功能：使用饱和策略的左移运算。

当移位位数大于等于操作数位数时，将移位位数置为操作数位数 - 1，返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值和一个移位位数，使左移运算会发生溢出
    let a1 = 100i64
    let b1 = 64u64  // 移位位数大于等于操作数位数(64)
    
    // 使用saturatingShl进行左移运算（溢出情况）
    let result1 = a1.saturatingShl(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating shl result: ${result1}")
    
    // 创建一个Int64值和一个移位位数，使左移运算不会发生溢出
    let a2 = 100i64
    let b2 = 2u64
    
    // 使用saturatingShl进行左移运算（正常情况）
    let result2 = a2.saturatingShl(b2)
    
    // 直接打印结果
    println("Normal case - Saturating shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating shl result: 0
Normal case - Saturating shl result: 400
```

#### func saturatingShr(UInt64)

```cangjie
public func saturatingShr(y: UInt64): Int64
```

功能：使用饱和策略的右移运算。

当移位位数大于等于操作数位数时，将移位位数置为操作数位数 - 1，返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值和一个移位位数，使右移运算会发生溢出
    let a1 = 100i64
    let b1 = 64u64  // 移位位数大于等于操作数位数(64)
    
    // 使用saturatingShr进行右移运算（溢出情况）
    let result1 = a1.saturatingShr(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating shr result: ${result1}")
    
    // 创建一个Int64值和一个移位位数，使右移运算不会发生溢出
    let a2 = 100i64
    let b2 = 2u64
    
    // 使用saturatingShr进行右移运算（正常情况）
    let result2 = a2.saturatingShr(b2)
    
    // 直接打印结果
    println("Normal case - Saturating shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating shr result: 0
Normal case - Saturating shr result: 25
```

#### func saturatingSub(Int64)

```cangjie
public func saturatingSub(y: Int64): Int64
```

功能：使用饱和策略的减法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 减数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int64值，使它们相减会发生上溢出
    let a1 = 9223372036854775807i64  // Int64的最大值
    let b1 = -1i64
    
    // 使用saturatingSub进行减法运算（上溢出情况）
    let result1 = a1.saturatingSub(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating sub result: ${result1}")
    
    // 创建两个Int64值，使它们相减会发生下溢出
    let a2 = -9223372036854775808i64  // Int64的最小值
    let b2 = 1i64
    
    // 使用saturatingSub进行减法运算（下溢出情况）
    let result2 = a2.saturatingSub(b2)
    
    // 直接打印结果
    println("Underflow case - Saturating sub result: ${result2}")
    
    // 创建两个Int64值，使它们相减不会发生溢出
    let a3 = 100i64
    let b3 = 50i64
    
    // 使用saturatingSub进行减法运算（正常情况）
    let result3 = a3.saturatingSub(b3)
    
    // 直接打印结果
    println("Normal case - Saturating sub result: ${result3}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating sub result: 9223372036854775807
Underflow case - Saturating sub result: -9223372036854775808
Normal case - Saturating sub result: 50
```

### extend Int8 <: SaturatingOp\<Int8>

```cangjie
extend Int8 <: SaturatingOp<Int8>
```

功能：为 [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) 实现 [SaturatingOp](#interface-saturatingopt) 接口。

父类型：

- [SaturatingOp](#interface-saturatingopt)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)>

#### func saturatingAdd(Int8)

```cangjie
public func saturatingAdd(y: Int8): Int8
```

功能：使用饱和策略的加法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 加数。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int8值，使它们相加会发生上溢出
    let a1 = 127i8  // Int8的最大值
    let b1 = 1i8
    
    // 使用saturatingAdd进行加法运算（上溢出情况）
    let result1 = a1.saturatingAdd(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating add result: ${result1}")
    
    // 创建两个Int8值，使它们相加会发生下溢出
    let a2 = -128i8  // Int8的最小值
    let b2 = -1i8
    
    // 使用saturatingAdd进行加法运算（下溢出情况）
    let result2 = a2.saturatingAdd(b2)
    
    // 直接打印结果
    println("Underflow case - Saturating add result: ${result2}")
    
    // 创建两个Int8值，使它们相加不会发生溢出
    let a3 = 10i8
    let b3 = 20i8
    
    // 使用saturatingAdd进行加法运算（正常情况）
    let result3 = a3.saturatingAdd(b3)
    
    // 直接打印结果
    println("Normal case - Saturating add result: ${result3}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating add result: 127
Underflow case - Saturating add result: -128
Normal case - Saturating add result: 30
```

#### func saturatingDec()

```cangjie
public func saturatingDec(): Int8
```

功能：使用饱和策略的自减运算。

当运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int8值，使其自减会发生下溢出
    let a1 = -128i8  // Int8的最小值
    
    // 使用saturatingDec进行自减运算（下溢出情况）
    let result1 = a1.saturatingDec()
    
    // 直接打印结果
    println("Underflow case - Saturating dec result: ${result1}")
    
    // 创建一个Int8值，使其自减不会发生溢出
    let a2 = 10i8
    
    // 使用saturatingDec进行自减运算（正常情况）
    let result2 = a2.saturatingDec()
    
    // 直接打印结果
    println("Normal case - Saturating dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Saturating dec result: -128
Normal case - Saturating dec result: 9
```

#### func saturatingDiv(Int8)

```cangjie
public func saturatingDiv(y: Int8): Int8
```

功能：使用饱和策略的除法运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

参数：

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 除数。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int8值，使除法运算会发生上溢出
    let a1 = -128i8  // Int8的最小值
    let b1 = -1i8
    
    // 使用saturatingDiv进行除法运算（上溢出情况）
    let result1 = a1.saturatingDiv(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating div result: ${result1}")
    
    // 创建两个Int8值，使除法运算不会发生溢出
    let a2 = 10i8
    let b2 = 2i8
    
    // 使用saturatingDiv进行除法运算（正常情况）
    let result2 = a2.saturatingDiv(b2)
    
    // 直接打印结果
    println("Normal case - Saturating div result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating div result: 127
Normal case - Saturating div result: 5
```

#### func saturatingInc()

```cangjie
public func saturatingInc(): Int8
```

功能：使用饱和策略的自增运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int8值，使其自增会发生上溢出
    let a1 = 127i8  // Int8的最大值
    
    // 使用saturatingInc进行自增运算（上溢出情况）
    let result1 = a1.saturatingInc()
    
    // 直接打印结果
    println("Overflow case - Saturating inc result: ${result1}")
    
    // 创建一个Int8值，使其自增不会发生溢出
    let a2 = 10i8
    
    // 使用saturatingInc进行自增运算（正常情况）
    let result2 = a2.saturatingInc()
    
    // 直接打印结果
    println("Normal case - Saturating inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating inc result: 127
Normal case - Saturating inc result: 11
```

#### func saturatingMod(Int8)

```cangjie
public func saturatingMod(y: Int8): Int8
```

功能：使用饱和策略的取余运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

参数：

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 除数。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int8值，使取余运算会发生上溢出
    let a1 = -128i8  // Int8的最小值
    let b1 = -1i8
    
    // 使用saturatingMod进行取余运算（上溢出情况）
    let result1 = a1.saturatingMod(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating mod result: ${result1}")
    
    // 创建两个Int8值，使取余运算不会发生溢出
    let a2 = 10i8
    let b2 = 3i8
    
    // 使用saturatingMod进行取余运算（正常情况）
    let result2 = a2.saturatingMod(b2)
    
    // 直接打印结果
    println("Normal case - Saturating mod result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating mod result: 0
Normal case - Saturating mod result: 1
```

#### func saturatingMul(Int8)

```cangjie
public func saturatingMul(y: Int8): Int8
```

功能：使用饱和策略的乘法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 乘数。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int8值，使它们相乘会发生上溢出
    let a1 = 127i8  // Int8的最大值
    let b1 = 2i8
    
    // 使用saturatingMul进行乘法运算（上溢出情况）
    let result1 = a1.saturatingMul(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating mul result: ${result1}")
    
    // 创建两个Int8值，使它们相乘会发生下溢出
    let a2 = -128i8  // Int8的最小值
    let b2 = 2i8
    
    // 使用saturatingMul进行乘法运算（下溢出情况）
    let result2 = a2.saturatingMul(b2)
    
    // 直接打印结果
    println("Underflow case - Saturating mul result: ${result2}")
    
    // 创建两个Int8值，使它们相乘不会发生溢出
    let a3 = 10i8
    let b3 = 2i8
    
    // 使用saturatingMul进行乘法运算（正常情况）
    let result3 = a3.saturatingMul(b3)
    
    // 直接打印结果
    println("Normal case - Saturating mul result: ${result3}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating mul result: 127
Underflow case - Saturating mul result: -128
Normal case - Saturating mul result: 20
```

#### func saturatingNeg()

```cangjie
public func saturatingNeg(): Int8
```

功能：使用饱和策略的负号运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int8值，使其取负会发生上溢出
    let a1 = -128i8  // Int8的最小值
    
    // 使用saturatingNeg进行取负运算（上溢出情况）
    let result1 = a1.saturatingNeg()
    
    // 直接打印结果
    println("Overflow case - Saturating neg result: ${result1}")
    
    // 创建一个Int8值，使其取负会发生下溢出
    let a2 = 127i8  // Int8的最大值
    
    // 使用saturatingNeg进行取负运算（下溢出情况）
    let result2 = a2.saturatingNeg()
    
    // 直接打印结果
    println("Underflow case - Saturating neg result: ${result2}")
    
    // 创建一个Int8值，使其取负不会发生溢出
    let a3 = 10i8
    
    // 使用saturatingNeg进行取负运算（正常情况）
    let result3 = a3.saturatingNeg()
    
    // 直接打印结果
    println("Normal case - Saturating neg result: ${result3}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating neg result: 127
Underflow case - Saturating neg result: -127
Normal case - Saturating neg result: -10
```

#### func saturatingShl(UInt64)

```cangjie
public func saturatingShl(y: UInt64): Int8
```

功能：使用饱和策略的左移运算。

当移位位数大于等于操作数位数时，将移位位数置为操作数位数 - 1，返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int8值和一个移位位数，使左移运算会发生溢出
    let a1 = 10i8
    let b1 = 8u64  // 移位位数大于等于操作数位数(8)
    
    // 使用saturatingShl进行左移运算（溢出情况）
    let result1 = a1.saturatingShl(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating shl result: ${result1}")
    
    // 创建一个Int8值和一个移位位数，使左移运算不会发生溢出
    let a2 = 10i8
    let b2 = 2u64
    
    // 使用saturatingShl进行左移运算（正常情况）
    let result2 = a2.saturatingShl(b2)
    
    // 直接打印结果
    println("Normal case - Saturating shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating shl result: 0
Normal case - Saturating shl result: 40
```

#### func saturatingShr(UInt64)

```cangjie
public func saturatingShr(y: UInt64): Int8
```

功能：使用饱和策略的右移运算。

当移位位数大于等于操作数位数时，将移位位数置为操作数位数 - 1，返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int8值和一个移位位数，使右移运算会发生溢出
    let a1 = 10i8
    let b1 = 8u64  // 移位位数大于等于操作数位数(8)
    
    // 使用saturatingShr进行右移运算（溢出情况）
    let result1 = a1.saturatingShr(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating shr result: ${result1}")
    
    // 创建一个Int8值和一个移位位数，使右移运算不会发生溢出
    let a2 = 10i8
    let b2 = 2u64
    
    // 使用saturatingShr进行右移运算（正常情况）
    let result2 = a2.saturatingShr(b2)
    
    // 直接打印结果
    println("Normal case - Saturating shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating shr result: 0
Normal case - Saturating shr result: 2
```

#### func saturatingSub(Int8)

```cangjie
public func saturatingSub(y: Int8): Int8
```

功能：使用饱和策略的减法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 减数。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int8值，使它们相减会发生上溢出
    let a1 = 127i8  // Int8的最大值
    let b1 = -1i8
    
    // 使用saturatingSub进行减法运算（上溢出情况）
    let result1 = a1.saturatingSub(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating sub result: ${result1}")
    
    // 创建两个Int8值，使它们相减会发生下溢出
    let a2 = -128i8  // Int8的最小值
    let b2 = 1i8
    
    // 使用saturatingSub进行减法运算（下溢出情况）
    let result2 = a2.saturatingSub(b2)
    
    // 直接打印结果
    println("Underflow case - Saturating sub result: ${result2}")
    
    // 创建两个Int8值，使它们相减不会发生溢出
    let a3 = 10i8
    let b3 = 5i8
    
    // 使用saturatingSub进行减法运算（正常情况）
    let result3 = a3.saturatingSub(b3)
    
    // 直接打印结果
    println("Normal case - Saturating sub result: ${result3}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating sub result: 127
Underflow case - Saturating sub result: -128
Normal case - Saturating sub result: 5
```

### extend IntNative <: SaturatingOp\<IntNative>

```cangjie
extend IntNative <: SaturatingOp<IntNative>
```

功能：为 [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) 实现 [SaturatingOp](#interface-saturatingopt) 接口。

父类型：

- [SaturatingOp](#interface-saturatingopt)\<[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)>

#### func saturatingAdd(IntNative)

```cangjie
public func saturatingAdd(y: IntNative): IntNative
```

功能：使用饱和策略的加法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 加数。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个IntNative值，使它们相加会发生上溢出
    let a1: IntNative = 9223372036854775807  // IntNative的最大值
    let b1: IntNative = 1
    
    // 使用saturatingAdd进行加法运算（上溢出情况）
    let result1 = a1.saturatingAdd(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating add result: ${result1}")
    
    // 创建两个IntNative值，使它们相加会发生下溢出
    let a2: IntNative = -9223372036854775808  // IntNative的最小值
    let b2: IntNative = -1
    
    // 使用saturatingAdd进行加法运算（下溢出情况）
    let result2 = a2.saturatingAdd(b2)
    
    // 直接打印结果
    println("Underflow case - Saturating add result: ${result2}")
    
    // 创建两个IntNative值，使它们相加不会发生溢出
    let a3 = 1000000
    let b3 = 2000000
    
    // 使用saturatingAdd进行加法运算（正常情况）
    let result3 = a3.saturatingAdd(b3)
    
    // 直接打印结果
    println("Normal case - Saturating add result: ${result3}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating add result: 9223372036854775807
Underflow case - Saturating add result: -9223372036854775808
Normal case - Saturating add result: 3000000
```

#### func saturatingDec()

```cangjie
public func saturatingDec(): IntNative
```

功能：使用饱和策略的自减运算。

当运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个IntNative值，使其自减会发生下溢出
    let a1: IntNative = -9223372036854775808  // IntNative的最小值
    
    // 使用saturatingDec进行自减运算（下溢出情况）
    let result1 = a1.saturatingDec()
    
    // 直接打印结果
    println("Underflow case - Saturating dec result: ${result1}")
    
    // 创建一个IntNative值，使其自减不会发生溢出
    let a2: IntNative = 1000000
    
    // 使用saturatingDec进行自减运算（正常情况）
    let result2 = a2.saturatingDec()
    
    // 直接打印结果
    println("Normal case - Saturating dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Saturating dec result: -9223372036854775808
Normal case - Saturating dec result: 999999
```

#### func saturatingDiv(IntNative)

```cangjie
public func saturatingDiv(y: IntNative): IntNative
```

功能：使用饱和策略的除法运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

参数：

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 除数。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个IntNative值，使除法运算会发生上溢出
    let a1: IntNative = -9223372036854775808  // IntNative的最小值
    let b1: IntNative = -1
    
    // 使用saturatingDiv进行除法运算（上溢出情况）
    let result1 = a1.saturatingDiv(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating div result: ${result1}")
    
    // 创建两个IntNative值，使除法运算不会发生溢出
    let a2: IntNative = 1000000
    let b2: IntNative = 2
    
    // 使用saturatingDiv进行除法运算（正常情况）
    let result2 = a2.saturatingDiv(b2)
    
    // 直接打印结果
    println("Normal case - Saturating div result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating div result: 9223372036854775807
Normal case - Saturating div result: 500000
```

#### func saturatingInc()

```cangjie
public func saturatingInc(): IntNative
```

功能：使用饱和策略的自增运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个IntNative值，使其自增会发生上溢出
    let a1: IntNative = 9223372036854775807  // IntNative的最大值
    
    // 使用saturatingInc进行自增运算（上溢出情况）
    let result1 = a1.saturatingInc()
    
    // 直接打印结果
    println("Overflow case - Saturating inc result: ${result1}")
    
    // 创建一个IntNative值，使其自增不会发生溢出
    let a2: IntNative = 1000000
    
    // 使用saturatingInc进行自增运算（正常情况）
    let result2 = a2.saturatingInc()
    
    // 直接打印结果
    println("Normal case - Saturating inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating inc result: 9223372036854775807
Normal case - Saturating inc result: 1000001
```

#### func saturatingMod(IntNative)

```cangjie
public func saturatingMod(y: IntNative): IntNative
```

功能：使用饱和策略的取余运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

参数：

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 除数。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个IntNative值，使取余运算会发生上溢出
    let a1: IntNative = -9223372036854775808  // IntNative的最小值
    let b1: IntNative = -1
    
    // 使用saturatingMod进行取余运算（上溢出情况）
    let result1 = a1.saturatingMod(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating mod result: ${result1}")
    
    // 创建两个IntNative值，使取余运算不会发生溢出
    let a2: IntNative = 1000000
    let b2: IntNative = 3
    
    // 使用saturatingMod进行取余运算（正常情况）
    let result2 = a2.saturatingMod(b2)
    
    // 直接打印结果
    println("Normal case - Saturating mod result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating mod result: 0
Normal case - Saturating mod result: 1
```

#### func saturatingMul(IntNative)

```cangjie
public func saturatingMul(y: IntNative): IntNative
```

功能：使用饱和策略的乘法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 乘数。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个IntNative值，使它们相乘会发生上溢出
    let a1: IntNative = 9223372036854775807  // IntNative的最大值
    let b1: IntNative = 2
    
    // 使用saturatingMul进行乘法运算（上溢出情况）
    let result1 = a1.saturatingMul(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating mul result: ${result1}")
    
    // 创建两个IntNative值，使它们相乘会发生下溢出
    let a2: IntNative = -9223372036854775808  // IntNative的最小值
    let b2: IntNative = 2
    
    // 使用saturatingMul进行乘法运算（下溢出情况）
    let result2 = a2.saturatingMul(b2)
    
    // 直接打印结果
    println("Underflow case - Saturating mul result: ${result2}")
    
    // 创建两个IntNative值，使它们相乘不会发生溢出
    let a3 = 1000000
    let b3 = 2000000
    
    // 使用saturatingMul进行乘法运算（正常情况）
    let result3 = a3.saturatingMul(b3)
    
    // 直接打印结果
    println("Normal case - Saturating mul result: ${result3}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating mul result: 9223372036854775807
Underflow case - Saturating mul result: -9223372036854775808
Normal case - Saturating mul result: 2000000000000
```

#### func saturatingNeg()

```cangjie
public func saturatingNeg(): IntNative
```

功能：使用饱和策略的负号运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个IntNative值，使其取负会发生上溢出
    let a1: IntNative = -9223372036854775808  // IntNative的最小值
    
    // 使用saturatingNeg进行取负运算（上溢出情况）
    let result1 = a1.saturatingNeg()
    
    // 直接打印结果
    println("Overflow case - Saturating neg result: ${result1}")
    
    // 创建一个IntNative值，使其取负会发生下溢出
    let a2: IntNative = 9223372036854775807  // IntNative的最大值
    
    // 使用saturatingNeg进行取负运算（下溢出情况）
    let result2 = a2.saturatingNeg()
    
    // 直接打印结果
    println("Underflow case - Saturating neg result: ${result2}")
    
    // 创建一个IntNative值，使其取负不会发生溢出
    let a3 = 1000000
    
    // 使用saturatingNeg进行取负运算（正常情况）
    let result3 = a3.saturatingNeg()
    
    // 直接打印结果
    println("Normal case - Saturating neg result: ${result3}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating neg result: 9223372036854775807
Underflow case - Saturating neg result: -9223372036854775807
Normal case - Saturating neg result: -1000000
```

#### func saturatingShl(UInt64)

```cangjie
public func saturatingShl(y: UInt64): IntNative
```

功能：使用饱和策略的左移运算。

当移位位数大于等于操作数位数时，将移位位数置为操作数位数 - 1，返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个IntNative值和一个移位位数，使左移运算会发生溢出
    let a1: IntNative = 1000000
    let b1 = 64u64  // 移位位数大于等于操作数位数(64)
    
    // 使用saturatingShl进行左移运算（溢出情况）
    let result1 = a1.saturatingShl(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating shl result: ${result1}")
    
    // 创建一个IntNative值和一个移位位数，使左移运算不会发生溢出
    let a2: IntNative = 1000000
    let b2 = 2u64
    
    // 使用saturatingShl进行左移运算（正常情况）
    let result2 = a2.saturatingShl(b2)
    
    // 直接打印结果
    println("Normal case - Saturating shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating shl result: 0
Normal case - Saturating shl result: 4000000
```

#### func saturatingShr(UInt64)

```cangjie
public func saturatingShr(y: UInt64): IntNative
```

功能：使用饱和策略的右移运算。

当移位位数大于等于操作数位数时，将移位位数置为操作数位数 - 1，返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个IntNative值和一个移位位数，使右移运算会发生溢出
    let a1: IntNative = 1000000
    let b1 = 64u64  // 移位位数大于等于操作数位数(64)
    
    // 使用saturatingShr进行右移运算（溢出情况）
    let result1 = a1.saturatingShr(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating shr result: ${result1}")
    
    // 创建一个IntNative值和一个移位位数，使右移运算不会发生溢出
    let a2: IntNative = 1000000
    let b2 = 2u64
    
    // 使用saturatingShr进行右移运算（正常情况）
    let result2 = a2.saturatingShr(b2)
    
    // 直接打印结果
    println("Normal case - Saturating shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating shr result: 0
Normal case - Saturating shr result: 250000
```

#### func saturatingSub(IntNative)

```cangjie
public func saturatingSub(y: IntNative): IntNative
```

功能：使用饱和策略的减法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 减数。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个IntNative值，使它们相减会发生上溢出
    let a1: IntNative = 9223372036854775807  // IntNative的最大值
    let b1: IntNative = -1
    
    // 使用saturatingSub进行减法运算（上溢出情况）
    let result1 = a1.saturatingSub(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating sub result: ${result1}")
    
    // 创建两个IntNative值，使它们相减会发生下溢出
    let a2: IntNative = -9223372036854775808  // IntNative的最小值
    let b2: IntNative = 1
    
    // 使用saturatingSub进行减法运算（下溢出情况）
    let result2 = a2.saturatingSub(b2)
    
    // 直接打印结果
    println("Underflow case - Saturating sub result: ${result2}")
    
    // 创建两个IntNative值，使它们相减不会发生溢出
    let a3 = 1000000
    let b3 = 500000
    
    // 使用saturatingSub进行减法运算（正常情况）
    let result3 = a3.saturatingSub(b3)
    
    // 直接打印结果
    println("Normal case - Saturating sub result: ${result3}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating sub result: 9223372036854775807
Underflow case - Saturating sub result: -9223372036854775808
Normal case - Saturating sub result: 500000
```

### extend UInt16 <: SaturatingOp\<UInt16>

```cangjie
extend UInt16 <: SaturatingOp<UInt16>
```

功能：为 [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) 实现 [SaturatingOp](#interface-saturatingopt) 接口。

父类型：

- [SaturatingOp](#interface-saturatingopt)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)>

#### func saturatingAdd(UInt16)

```cangjie
public func saturatingAdd(y: UInt16): UInt16
```

功能：使用饱和策略的加法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 加数。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt16值，使它们相加会发生上溢出
    let a1 = 65535u16  // UInt16的最大值
    let b1 = 1u16
    
    // 使用saturatingAdd进行加法运算（上溢出情况）
    let result1 = a1.saturatingAdd(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating add result: ${result1}")
    
    // 创建两个UInt16值，使它们相加不会发生溢出
    let a2 = 100u16
    let b2 = 200u16
    
    // 使用saturatingAdd进行加法运算（正常情况）
    let result2 = a2.saturatingAdd(b2)
    
    // 直接打印结果
    println("Normal case - Saturating add result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating add result: 65535
Normal case - Saturating add result: 300
```

#### func saturatingDec()

```cangjie
public func saturatingDec(): UInt16
```

功能：使用饱和策略的自减运算。

当运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt16值，使其自减会发生下溢出
    let a1 = 0u16  // UInt16的最小值
    
    // 使用saturatingDec进行自减运算（下溢出情况）
    let result1 = a1.saturatingDec()
    
    // 直接打印结果
    println("Underflow case - Saturating dec result: ${result1}")
    
    // 创建一个UInt16值，使其自减不会发生溢出
    let a2 = 100u16
    
    // 使用saturatingDec进行自减运算（正常情况）
    let result2 = a2.saturatingDec()
    
    // 直接打印结果
    println("Normal case - Saturating dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Saturating dec result: 0
Normal case - Saturating dec result: 99
```

#### func saturatingDiv(UInt16)

```cangjie
public func saturatingDiv(y: UInt16): UInt16
```

功能：使用饱和策略的除法运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

参数：

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 除数。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt16值，使除法运算不会发生溢出
    let a1 = 100u16
    let b1 = 2u16
    
    // 使用saturatingDiv进行除法运算（正常情况）
    let result1 = a1.saturatingDiv(b1)
    
    // 直接打印结果
    println("Normal case - Saturating div result: ${result1}")
    
    // 创建另一个UInt16值进行除法运算
    let a2 = 65535u16
    let b2 = 1u16
    
    // 使用saturatingDiv进行除法运算（正常情况）
    let result2 = a2.saturatingDiv(b2)
    
    // 直接打印结果
    println("Normal case 2 - Saturating div result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Saturating div result: 50
Normal case 2 - Saturating div result: 65535
```

#### func saturatingInc()

```cangjie
public func saturatingInc(): UInt16
```

功能：使用饱和策略的自增运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt16值，使其自增会发生上溢出
    let a1 = 65535u16  // UInt16的最大值
    
    // 使用saturatingInc进行自增运算（上溢出情况）
    let result1 = a1.saturatingInc()
    
    // 直接打印结果
    println("Overflow case - Saturating inc result: ${result1}")
    
    // 创建一个UInt16值，使其自增不会发生溢出
    let a2 = 100u16
    
    // 使用saturatingInc进行自增运算（正常情况）
    let result2 = a2.saturatingInc()
    
    // 直接打印结果
    println("Normal case - Saturating inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating inc result: 65535
Normal case - Saturating inc result: 101
```

#### func saturatingMod(UInt16)

```cangjie
public func saturatingMod(y: UInt16): UInt16
```

功能：使用饱和策略的取余运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

参数：

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 除数。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt16值，使取余运算不会发生溢出
    let a1 = 100u16
    let b1 = 3u16
    
    // 使用saturatingMod进行取余运算（正常情况）
    let result1 = a1.saturatingMod(b1)
    
    // 直接打印结果
    println("Normal case - Saturating mod result: ${result1}")
    
    // 创建另一个UInt16值进行取余运算
    let a2 = 65535u16
    let b2 = 1u16
    
    // 使用saturatingMod进行取余运算（正常情况）
    let result2 = a2.saturatingMod(b2)
    
    // 直接打印结果
    println("Normal case 2 - Saturating mod result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Saturating mod result: 1
Normal case 2 - Saturating mod result: 0
```

#### func saturatingMul(UInt16)

```cangjie
public func saturatingMul(y: UInt16): UInt16
```

功能：使用饱和策略的乘法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 乘数。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt16值，使它们相乘会发生上溢出
    let a1 = 65535u16  // UInt16的最大值
    let b1 = 2u16
    
    // 使用saturatingMul进行乘法运算（上溢出情况）
    let result1 = a1.saturatingMul(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating mul result: ${result1}")
    
    // 创建两个UInt16值，使它们相乘不会发生溢出
    let a2 = 100u16
    let b2 = 200u16
    
    // 使用saturatingMul进行乘法运算（正常情况）
    let result2 = a2.saturatingMul(b2)
    
    // 直接打印结果
    println("Normal case - Saturating mul result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating mul result: 65535
Normal case - Saturating mul result: 20000
```

#### func saturatingNeg()

```cangjie
public func saturatingNeg(): UInt16
```

功能：使用饱和策略的负号运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建几个UInt16值，测试saturatingNeg的行为
    let a1 = 0u16
    let a2 = 100u16
    let a3 = 65535u16
    
    // 使用saturatingNeg进行取负运算
    let result1 = a1.saturatingNeg()
    let result2 = a2.saturatingNeg()
    let result3 = a3.saturatingNeg()
    
    // 直接打印结果
    println("0u16 saturatingNeg result: ${result1}")
    println("100u16 saturatingNeg result: ${result2}")
    println("65535u16 saturatingNeg result: ${result3}")
    
    return 0
}
```

运行结果：

```text
0u16 saturatingNeg result: 0
100u16 saturatingNeg result: 0
65535u16 saturatingNeg result: 0
```

#### func saturatingShl(UInt64)

```cangjie
public func saturatingShl(y: UInt64): UInt16
```

功能：使用饱和策略的左移运算。

当移位位数大于等于操作数位数时，将移位位数置为操作数位数 - 1，返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt16值和一个移位位数，使左移运算会发生溢出
    let a1 = 100u16
    let b1 = 16u64  // 移位位数大于等于操作数位数(16)
    
    // 使用saturatingShl进行左移运算（溢出情况）
    let result1 = a1.saturatingShl(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating shl result: ${result1}")
    
    // 创建一个UInt16值和一个移位位数，使左移运算不会发生溢出
    let a2 = 100u16
    let b2 = 2u64
    
    // 使用saturatingShl进行左移运算（正常情况）
    let result2 = a2.saturatingShl(b2)
    
    // 直接打印结果
    println("Normal case - Saturating shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating shl result: 0
Normal case - Saturating shl result: 400
```

#### func saturatingShr(UInt64)

```cangjie
public func saturatingShr(y: UInt64): UInt16
```

功能：使用饱和策略的右移运算。

当移位位数大于等于操作数位数时，将移位位数置为操作数位数 - 1，返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt16值和一个移位位数，使右移运算会发生溢出
    let a1 = 100u16
    let b1 = 16u64  // 移位位数大于等于操作数位数(16)
    
    // 使用saturatingShr进行右移运算（溢出情况）
    let result1 = a1.saturatingShr(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating shr result: ${result1}")
    
    // 创建一个UInt16值和一个移位位数，使右移运算不会发生溢出
    let a2 = 100u16
    let b2 = 2u64
    
    // 使用saturatingShr进行右移运算（正常情况）
    let result2 = a2.saturatingShr(b2)
    
    // 直接打印结果
    println("Normal case - Saturating shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating shr result: 0
Normal case - Saturating shr result: 25
```

#### func saturatingSub(UInt16)

```cangjie
public func saturatingSub(y: UInt16): UInt16
```

功能：使用饱和策略的减法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 减数。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt16值，使它们相减会发生下溢出
    let a1 = 0u16  // UInt16的最小值
    let b1 = 1u16
    
    // 使用saturatingSub进行减法运算（下溢出情况）
    let result1 = a1.saturatingSub(b1)
    
    // 直接打印结果
    println("Underflow case - Saturating sub result: ${result1}")
    
    // 创建两个UInt16值，使它们相减不会发生溢出
    let a2 = 100u16
    let b2 = 50u16
    
    // 使用saturatingSub进行减法运算（正常情况）
    let result2 = a2.saturatingSub(b2)
    
    // 直接打印结果
    println("Normal case - Saturating sub result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Saturating sub result: 0
Normal case - Saturating sub result: 50
```

### extend UInt32 <: SaturatingOp\<UInt32>

```cangjie
extend UInt32 <: SaturatingOp<UInt32>
```

功能：为 [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) 实现 [SaturatingOp](#interface-saturatingopt) 接口。

父类型：

- [SaturatingOp](#interface-saturatingopt)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)>

#### func saturatingAdd(UInt32)

```cangjie
public func saturatingAdd(y: UInt32): UInt32
```

功能：使用饱和策略的加法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 加数。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt32值，使它们相加会发生上溢出
    let a1 = 4294967295u32  // UInt32的最大值
    let b1 = 1u32
    
    // 使用saturatingAdd进行加法运算（上溢出情况）
    let result1 = a1.saturatingAdd(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating add result: ${result1}")
    
    // 创建两个UInt32值，使它们相加不会发生溢出
    let a2 = 1000000u32
    let b2 = 2000000u32
    
    // 使用saturatingAdd进行加法运算（正常情况）
    let result2 = a2.saturatingAdd(b2)
    
    // 直接打印结果
    println("Normal case - Saturating add result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating add result: 4294967295
Normal case - Saturating add result: 3000000
```

#### func saturatingDec()

```cangjie
public func saturatingDec(): UInt32
```

功能：使用饱和策略的自减运算。

当运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt32值，使其自减会发生下溢出
    let a1 = 0u32  // UInt32的最小值
    
    // 使用saturatingDec进行自减运算（下溢出情况）
    let result1 = a1.saturatingDec()
    
    // 直接打印结果
    println("Underflow case - Saturating dec result: ${result1}")
    
    // 创建一个UInt32值，使其自减不会发生溢出
    let a2 = 1000000u32
    
    // 使用saturatingDec进行自减运算（正常情况）
    let result2 = a2.saturatingDec()
    
    // 直接打印结果
    println("Normal case - Saturating dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Saturating dec result: 0
Normal case - Saturating dec result: 999999
```

#### func saturatingDiv(UInt32)

```cangjie
public func saturatingDiv(y: UInt32): UInt32
```

功能：使用饱和策略的除法运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

参数：

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 除数。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt32值，使除法运算不会发生溢出
    let a1 = 1000000u32
    let b1 = 2u32
    
    // 使用saturatingDiv进行除法运算（正常情况）
    let result1 = a1.saturatingDiv(b1)
    
    // 直接打印结果
    println("Normal case - Saturating div result: ${result1}")
    
    // 创建另一个UInt32值进行除法运算
    let a2 = 4294967295u32
    let b2 = 1u32
    
    // 使用saturatingDiv进行除法运算（正常情况）
    let result2 = a2.saturatingDiv(b2)
    
    // 直接打印结果
    println("Normal case 2 - Saturating div result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Saturating div result: 500000
Normal case 2 - Saturating div result: 4294967295
```

#### func saturatingInc()

```cangjie
public func saturatingInc(): UInt32
```

功能：使用饱和策略的自增运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt32值，使其自增会发生上溢出
    let a1 = 4294967295u32  // UInt32的最大值
    
    // 使用saturatingInc进行自增运算（上溢出情况）
    let result1 = a1.saturatingInc()
    
    // 直接打印结果
    println("Overflow case - Saturating inc result: ${result1}")
    
    // 创建一个UInt32值，使其自增不会发生溢出
    let a2 = 1000000u32
    
    // 使用saturatingInc进行自增运算（正常情况）
    let result2 = a2.saturatingInc()
    
    // 直接打印结果
    println("Normal case - Saturating inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating inc result: 4294967295
Normal case - Saturating inc result: 1000001
```

#### func saturatingMod(UInt32)

```cangjie
public func saturatingMod(y: UInt32): UInt32
```

功能：使用饱和策略的取余运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

参数：

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 除数。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt32值，使取余运算不会发生溢出
    let a1 = 1000000u32
    let b1 = 3u32
    
    // 使用saturatingMod进行取余运算（正常情况）
    let result1 = a1.saturatingMod(b1)
    
    // 直接打印结果
    println("Normal case - Saturating mod result: ${result1}")
    
    // 创建另一个UInt32值进行取余运算
    let a2 = 4294967295u32
    let b2 = 1u32
    
    // 使用saturatingMod进行取余运算（正常情况）
    let result2 = a2.saturatingMod(b2)
    
    // 直接打印结果
    println("Normal case 2 - Saturating mod result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Saturating mod result: 1
Normal case 2 - Saturating mod result: 0
```

#### func saturatingMul(UInt32)

```cangjie
public func saturatingMul(y: UInt32): UInt32
```

功能：使用饱和策略的乘法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 乘数。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt32值，使它们相乘会发生上溢出
    let a1 = 4294967295u32  // UInt32的最大值
    let b1 = 2u32
    
    // 使用saturatingMul进行乘法运算（上溢出情况）
    let result1 = a1.saturatingMul(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating mul result: ${result1}")
    
    // 创建两个UInt32值，使它们相乘不会发生溢出
    let a2 = 1000000u32
    let b2 = 2000000u32
    
    // 使用saturatingMul进行乘法运算（正常情况）
    let result2 = a2.saturatingMul(b2)
    
    // 直接打印结果
    println("Normal case - Saturating mul result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating mul result: 4294967295
Normal case - Saturating mul result: 4294967295
```

#### func saturatingNeg()

```cangjie
public func saturatingNeg(): UInt32
```

功能：使用饱和策略的负号运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建几个UInt32值，测试saturatingNeg的行为
    let a1 = 0u32
    let a2 = 1000000u32
    let a3 = 4294967295u32
    
    // 使用saturatingNeg进行取负运算
    let result1 = a1.saturatingNeg()
    let result2 = a2.saturatingNeg()
    let result3 = a3.saturatingNeg()
    
    // 直接打印结果
    println("0u32 saturatingNeg result: ${result1}")
    println("1000000u32 saturatingNeg result: ${result2}")
    println("4294967295u32 saturatingNeg result: ${result3}")
    
    return 0
}
```

运行结果：

```text
0u32 saturatingNeg result: 0
1000000u32 saturatingNeg result: 0
4294967295u32 saturatingNeg result: 0
```

#### func saturatingShl(UInt64)

```cangjie
public func saturatingShl(y: UInt64): UInt32
```

功能：使用饱和策略的左移运算。

当移位位数大于等于操作数位数时，将移位位数置为操作数位数 - 1，返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt32值和一个移位位数，使左移运算会发生溢出
    let a1 = 1000000u32
    let b1 = 32u64  // 移位位数大于等于操作数位数(32)
    
    // 使用saturatingShl进行左移运算（溢出情况）
    let result1 = a1.saturatingShl(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating shl result: ${result1}")
    
    // 创建一个UInt32值和一个移位位数，使左移运算不会发生溢出
    let a2 = 1000000u32
    let b2 = 2u64
    
    // 使用saturatingShl进行左移运算（正常情况）
    let result2 = a2.saturatingShl(b2)
    
    // 直接打印结果
    println("Normal case - Saturating shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating shl result: 0
Normal case - Saturating shl result: 4000000
```

#### func saturatingShr(UInt64)

```cangjie
public func saturatingShr(y: UInt64): UInt32
```

功能：使用饱和策略的右移运算。

当移位位数大于等于操作数位数时，将移位位数置为操作数位数 - 1，返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt32值和一个移位位数，使右移运算会发生溢出
    let a1 = 1000000u32
    let b1 = 32u64  // 移位位数大于等于操作数位数(32)
    
    // 使用saturatingShr进行右移运算（溢出情况）
    let result1 = a1.saturatingShr(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating shr result: ${result1}")
    
    // 创建一个UInt32值和一个移位位数，使右移运算不会发生溢出
    let a2 = 1000000u32
    let b2 = 2u64
    
    // 使用saturatingShr进行右移运算（正常情况）
    let result2 = a2.saturatingShr(b2)
    
    // 直接打印结果
    println("Normal case - Saturating shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating shr result: 0
Normal case - Saturating shr result: 250000
```

#### func saturatingSub(UInt32)

```cangjie
public func saturatingSub(y: UInt32): UInt32
```

功能：使用饱和策略的减法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 减数。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt32值，使它们相减会发生下溢出
    let a1 = 0u32  // UInt32的最小值
    let b1 = 1u32
    
    // 使用saturatingSub进行减法运算（下溢出情况）
    let result1 = a1.saturatingSub(b1)
    
    // 直接打印结果
    println("Underflow case - Saturating sub result: ${result1}")
    
    // 创建两个UInt32值，使它们相减不会发生溢出
    let a2 = 1000000u32
    let b2 = 500000u32
    
    // 使用saturatingSub进行减法运算（正常情况）
    let result2 = a2.saturatingSub(b2)
    
    // 直接打印结果
    println("Normal case - Saturating sub result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Saturating sub result: 0
Normal case - Saturating sub result: 500000
```

### extend UInt64 <: SaturatingOp\<UInt64>

```cangjie
extend UInt64 <: SaturatingOp<UInt64>
```

功能：为 [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) 实现 [SaturatingOp](#interface-saturatingopt) 接口。

父类型：

- [SaturatingOp](#interface-saturatingopt)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)>

#### func saturatingAdd(UInt64)

```cangjie
public func saturatingAdd(y: UInt64): UInt64
```

功能：使用饱和策略的加法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 加数。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt64值，使它们相加会发生上溢出
    let a1 = 18446744073709551615u64  // UInt64的最大值
    let b1 = 1u64
    
    // 使用saturatingAdd进行加法运算（上溢出情况）
    let result1 = a1.saturatingAdd(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating add result: ${result1}")
    
    // 创建两个UInt64值，使它们相加不会发生溢出
    let a2 = 1000000000000u64
    let b2 = 2000000000000u64
    
    // 使用saturatingAdd进行加法运算（正常情况）
    let result2 = a2.saturatingAdd(b2)
    
    // 直接打印结果
    println("Normal case - Saturating add result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating add result: 18446744073709551615
Normal case - Saturating add result: 3000000000000
```

#### func saturatingDec()

```cangjie
public func saturatingDec(): UInt64
```

功能：使用饱和策略的自减运算。

当运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt64值，测试下溢情况（0减1应该饱和为0）
    let a1 = 0u64
    
    // 使用saturatingDec进行自减运算（下溢情况）
    let result1 = a1.saturatingDec()
    
    // 直接打印结果
    println("Underflow case - Saturating dec result: ${result1}")
    
    // 创建一个UInt64值，测试正常情况
    let a2 = 100u64
    
    // 使用saturatingDec进行自减运算（正常情况）
    let result2 = a2.saturatingDec()
    
    // 直接打印结果
    println("Normal case - Saturating dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Saturating dec result: 0
Normal case - Saturating dec result: 99
```

#### func saturatingDiv(UInt64)

```cangjie
public func saturatingDiv(y: UInt64): UInt64
```

功能：使用饱和策略的除法运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 除数。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt64值，测试正常除法情况
    let a1 = 1000000000000u64
    let b1 = 1000u64
    
    // 使用saturatingDiv进行除法运算（正常情况）
    let result1 = a1.saturatingDiv(b1)
    
    // 直接打印结果
    println("Normal case - Saturating div result: ${result1}")
    
    // 创建两个UInt64值，测试大数除法情况
    let a2 = 18446744073709551615u64  // UInt64的最大值
    let b2 = 1000000u64
    
    // 使用saturatingDiv进行除法运算（大数情况）
    let result2 = a2.saturatingDiv(b2)
    
    // 直接打印结果
    println("Large number case - Saturating div result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Saturating div result: 1000000000
Large number case - Saturating div result: 18446744073709
```

#### func saturatingInc()

```cangjie
public func saturatingInc(): UInt64
```

功能：使用饱和策略的自增运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt64值，测试上溢情况（最大值加1应该饱和为最大值）
    let a1 = 18446744073709551615u64  // UInt64的最大值
    
    // 使用saturatingInc进行自增运算（上溢情况）
    let result1 = a1.saturatingInc()
    
    // 直接打印结果
    println("Overflow case - Saturating inc result: ${result1}")
    
    // 创建一个UInt64值，测试正常情况
    let a2 = 100u64
    
    // 使用saturatingInc进行自增运算（正常情况）
    let result2 = a2.saturatingInc()
    
    // 直接打印结果
    println("Normal case - Saturating inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating inc result: 18446744073709551615
Normal case - Saturating inc result: 101
```

#### func saturatingMod(UInt64)

```cangjie
public func saturatingMod(y: UInt64): UInt64
```

功能：使用饱和策略的取余运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 除数。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt64值，测试正常取余情况
    let a1 = 1000000000005u64
    let b1 = 1000u64
    
    // 使用saturatingMod进行取余运算（正常情况）
    let result1 = a1.saturatingMod(b1)
    
    // 直接打印结果
    println("Normal case - Saturating mod result: ${result1}")
    
    // 创建两个UInt64值，测试大数取余情况
    let a2 = 18446744073709551615u64  // UInt64的最大值
    let b2 = 1000000u64
    
    // 使用saturatingMod进行取余运算（大数情况）
    let result2 = a2.saturatingMod(b2)
    
    // 直接打印结果
    println("Large number case - Saturating mod result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Saturating mod result: 5
Large number case - Saturating mod result: 551615
```

#### func saturatingMul(UInt64)

```cangjie
public func saturatingMul(y: UInt64): UInt64
```

功能：使用饱和策略的乘法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 乘数。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt64值，测试正常乘法情况
    let a1 = 1000000u64
    let b1 = 2000000u64
    
    // 使用saturatingMul进行乘法运算（正常情况）
    let result1 = a1.saturatingMul(b1)
    
    // 直接打印结果
    println("Normal case - Saturating mul result: ${result1}")
    
    // 创建两个UInt64值，测试上溢情况
    let a2 = 18446744073709551615u64  // UInt64的最大值
    let b2 = 2u64
    
    // 使用saturatingMul进行乘法运算（上溢情况）
    let result2 = a2.saturatingMul(b2)
    
    // 直接打印结果
    println("Overflow case - Saturating mul result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Saturating mul result: 2000000000000
Overflow case - Saturating mul result: 18446744073709551615
```

#### func saturatingNeg()

```cangjie
public func saturatingNeg(): UInt64
```

功能：使用饱和策略的负号运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt64值，测试负号运算
    let a1 = 1000000u64
    
    // 使用saturatingNeg进行负号运算
    let result1 = a1.saturatingNeg()
    
    // 直接打印结果
    println("Normal case - Saturating neg result: ${result1}")
    
    // 创建一个UInt64值0，测试边界情况
    let a2 = 0u64
    
    // 使用saturatingNeg进行负号运算
    let result2 = a2.saturatingNeg()
    
    // 直接打印结果
    println("Zero case - Saturating neg result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Saturating neg result: 0
Zero case - Saturating neg result: 0
```

#### func saturatingShl(UInt64)

```cangjie
public func saturatingShl(y: UInt64): UInt64
```

功能：使用饱和策略的左移运算。

当移位位数大于等于操作数位数时，将移位位数置为操作数位数 - 1，返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt64值和移位位数，测试正常左移情况
    let a1 = 1000000u64
    let b1 = 10u64
    
    // 使用saturatingShl进行左移运算（正常情况）
    let result1 = a1.saturatingShl(b1)
    
    // 直接打印结果
    println("Normal case - Saturating shl result: ${result1}")
    
    // 创建一个UInt64值和较大的移位位数，测试边界情况
    let a2 = 1000000u64
    let b2 = 100u64  // 大于64的移位位数
    
    // 使用saturatingShl进行左移运算（边界情况）
    let result2 = a2.saturatingShl(b2)
    
    // 直接打印结果
    println("Large shift case - Saturating shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Saturating shl result: 1024000000
Large shift case - Saturating shl result: 0
```

#### func saturatingShr(UInt64)

```cangjie
public func saturatingShr(y: UInt64): UInt64
```

功能：使用饱和策略的右移运算。

当移位位数大于等于操作数位数时，将移位位数置为操作数位数 - 1，返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt64值和移位位数，测试正常右移情况
    let a1 = 1000000000000u64
    let b1 = 10u64
    
    // 使用saturatingShr进行右移运算（正常情况）
    let result1 = a1.saturatingShr(b1)
    
    // 直接打印结果
    println("Normal case - Saturating shr result: ${result1}")
    
    // 创建一个UInt64值和较大的移位位数，测试边界情况
    let a2 = 1000000000000u64
    let b2 = 100u64  // 大于64的移位位数
    
    // 使用saturatingShr进行右移运算（边界情况）
    let result2 = a2.saturatingShr(b2)
    
    // 直接打印结果
    println("Large shift case - Saturating shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Saturating shr result: 976562500
Large shift case - Saturating shr result: 0
```

#### func saturatingSub(UInt64)

```cangjie
public func saturatingSub(y: UInt64): UInt64
```

功能：使用饱和策略的减法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 减数。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt64值，测试正常减法情况
    let a1 = 1000000000000u64
    let b1 = 500000000000u64
    
    // 使用saturatingSub进行减法运算（正常情况）
    let result1 = a1.saturatingSub(b1)
    
    // 直接打印结果
    println("Normal case - Saturating sub result: ${result1}")
    
    // 创建两个UInt64值，测试下溢情况（小数减大数应该饱和为0）
    let a2 = 100u64
    let b2 = 1000u64
    
    // 使用saturatingSub进行减法运算（下溢情况）
    let result2 = a2.saturatingSub(b2)
    
    // 直接打印结果
    println("Underflow case - Saturating sub result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Saturating sub result: 500000000000
Underflow case - Saturating sub result: 0
```

### extend UInt8 <: SaturatingOp\<UInt8>

```cangjie
extend UInt8 <: SaturatingOp<UInt8>
```

功能：为 [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) 实现 [SaturatingOp](#interface-saturatingopt) 接口。

父类型：

- [SaturatingOp](#interface-saturatingopt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)>

#### func saturatingAdd(UInt8)

```cangjie
public func saturatingAdd(y: UInt8): UInt8
```

功能：使用饱和策略的加法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 加数。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt8值，使它们相加会发生上溢出
    let a1 = 255u8  // UInt8的最大值
    let b1 = 1u8
    
    // 使用saturatingAdd进行加法运算（上溢出情况）
    let result1 = a1.saturatingAdd(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating add result: ${result1}")
    
    // 创建两个UInt8值，使它们相加不会发生溢出
    let a2 = 100u8
    let b2 = 50u8
    
    // 使用saturatingAdd进行加法运算（正常情况）
    let result2 = a2.saturatingAdd(b2)
    
    // 直接打印结果
    println("Normal case - Saturating add result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating add result: 255
Normal case - Saturating add result: 150
```

#### func saturatingDec()

```cangjie
public func saturatingDec(): UInt8
```

功能：使用饱和策略的自减运算。

当运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt8值，测试下溢情况（0减1应该饱和为0）
    let a1 = 0u8
    
    // 使用saturatingDec进行自减运算（下溢情况）
    let result1 = a1.saturatingDec()
    
    // 直接打印结果
    println("Underflow case - Saturating dec result: ${result1}")
    
    // 创建一个UInt8值，测试正常情况
    let a2 = 100u8
    
    // 使用saturatingDec进行自减运算（正常情况）
    let result2 = a2.saturatingDec()
    
    // 直接打印结果
    println("Normal case - Saturating dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Saturating dec result: 0
Normal case - Saturating dec result: 99
```

#### func saturatingDiv(UInt8)

```cangjie
public func saturatingDiv(y: UInt8): UInt8
```

功能：使用饱和策略的除法运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

参数：

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 除数。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt8值，测试正常除法情况
    let a1 = 200u8
    let b1 = 10u8
    
    // 使用saturatingDiv进行除法运算（正常情况）
    let result1 = a1.saturatingDiv(b1)
    
    // 直接打印结果
    println("Normal case - Saturating div result: ${result1}")
    
    // 创建两个UInt8值，测试大数除法情况
    let a2 = 255u8  // UInt8的最大值
    let b2 = 5u8
    
    // 使用saturatingDiv进行除法运算（大数情况）
    let result2 = a2.saturatingDiv(b2)
    
    // 直接打印结果
    println("Large number case - Saturating div result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Saturating div result: 20
Large number case - Saturating div result: 51
```

#### func saturatingInc()

```cangjie
public func saturatingInc(): UInt8
```

功能：使用饱和策略的自增运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt8值，测试上溢情况（最大值加1应该饱和为最大值）
    let a1 = 255u8  // UInt8的最大值
    
    // 使用saturatingInc进行自增运算（上溢情况）
    let result1 = a1.saturatingInc()
    
    // 直接打印结果
    println("Overflow case - Saturating inc result: ${result1}")
    
    // 创建一个UInt8值，测试正常情况
    let a2 = 100u8
    
    // 使用saturatingInc进行自增运算（正常情况）
    let result2 = a2.saturatingInc()
    
    // 直接打印结果
    println("Normal case - Saturating inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating inc result: 255
Normal case - Saturating inc result: 101
```

#### func saturatingMod(UInt8)

```cangjie
public func saturatingMod(y: UInt8): UInt8
```

功能：使用饱和策略的取余运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

参数：

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 除数。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt8值，测试正常取余情况
    let a1 = 205u8
    let b1 = 10u8
    
    // 使用saturatingMod进行取余运算（正常情况）
    let result1 = a1.saturatingMod(b1)
    
    // 直接打印结果
    println("Normal case - Saturating mod result: ${result1}")
    
    // 创建两个UInt8值，测试大数取余情况
    let a2 = 255u8  // UInt8的最大值
    let b2 = 50u8
    
    // 使用saturatingMod进行取余运算（大数情况）
    let result2 = a2.saturatingMod(b2)
    
    // 直接打印结果
    println("Large number case - Saturating mod result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Saturating mod result: 5
Large number case - Saturating mod result: 5
```

#### func saturatingMul(UInt8)

```cangjie
public func saturatingMul(y: UInt8): UInt8
```

功能：使用饱和策略的乘法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 乘数。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt8值，测试正常乘法情况
    let a1 = 100u8
    let b1 = 20u8
    
    // 使用saturatingMul进行乘法运算（正常情况）
    let result1 = a1.saturatingMul(b1)
    
    // 直接打印结果
    println("Normal case - Saturating mul result: ${result1}")
    
    // 创建两个UInt8值，测试上溢情况
    let a2 = 200u8
    let b2 = 2u8
    
    // 使用saturatingMul进行乘法运算（上溢情况）
    let result2 = a2.saturatingMul(b2)
    
    // 直接打印结果
    println("Overflow case - Saturating mul result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Saturating mul result: 255
Overflow case - Saturating mul result: 255
```

#### func saturatingNeg()

```cangjie
public func saturatingNeg(): UInt8
```

功能：使用饱和策略的负号运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溃时，返回操作数类型的最小值，否则返回运算结果。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt8值，测试负号运算
    let a1 = 100u8
    
    // 使用saturatingNeg进行负号运算
    let result1 = a1.saturatingNeg()
    
    // 直接打印结果
    println("Normal case - Saturating neg result: ${result1}")
    
    // 创建一个UInt8值0，测试边界情况
    let a2 = 0u8
    
    // 使用saturatingNeg进行负号运算
    let result2 = a2.saturatingNeg()
    
    // 直接打印结果
    println("Zero case - Saturating neg result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Saturating neg result: 0
Zero case - Saturating neg result: 0
```

#### func saturatingShl(UInt64)

```cangjie
public func saturatingShl(y: UInt64): UInt8
```

功能：使用饱和策略的左移运算。

当移位位数大于等于操作数位数时，将移位位数置为操作数位数 - 1，返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt8值和移位位数，测试正常左移情况
    let a1 = 100u8
    let b1 = 2u64
    
    // 使用saturatingShl进行左移运算（正常情况）
    let result1 = a1.saturatingShl(b1)
    
    // 直接打印结果
    println("Normal case - Saturating shl result: ${result1}")
    
    // 创建一个UInt8值和较大的移位位数，测试边界情况
    let a2 = 100u8
    let b2 = 100u64  // 大于8的移位位数
    
    // 使用saturatingShl进行左移运算（边界情况）
    let result2 = a2.saturatingShl(b2)
    
    // 直接打印结果
    println("Large shift case - Saturating shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Saturating shl result: 144
Large shift case - Saturating shl result: 0
```

#### func saturatingShr(UInt64)

```cangjie
public func saturatingShr(y: UInt64): UInt8
```

功能：使用饱和策略的右移运算。

当移位位数大于等于操作数位数时，将移位位数置为操作数位数 - 1，返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt8值和移位位数，测试正常右移情况
    let a1 = 200u8
    let b1 = 2u64
    
    // 使用saturatingShr进行右移运算（正常情况）
    let result1 = a1.saturatingShr(b1)
    
    // 直接打印结果
    println("Normal case - Saturating shr result: ${result1}")
    
    // 创建一个UInt8值和较大的移位位数，测试边界情况
    let a2 = 200u8
    let b2 = 100u64  // 大于8的移位位数
    
    // 使用saturatingShr进行右移运算（边界情况）
    let result2 = a2.saturatingShr(b2)
    
    // 直接打印结果
    println("Large shift case - Saturating shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Saturating shr result: 50
Large shift case - Saturating shr result: 1
```

#### func saturatingSub(UInt8)

```cangjie
public func saturatingSub(y: UInt8): UInt8
```

功能：使用饱和策略的减法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 减数。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt8值，测试正常减法情况
    let a1 = 200u8
    let b1 = 50u8
    
    // 使用saturatingSub进行减法运算（正常情况）
    let result1 = a1.saturatingSub(b1)
    
    // 直接打印结果
    println("Normal case - Saturating sub result: ${result1}")
    
    // 创建两个UInt8值，测试下溢情况（小数减大数应该饱和为0）
    let a2 = 10u8
    let b2 = 100u8
    
    // 使用saturatingSub进行减法运算（下溢情况）
    let result2 = a2.saturatingSub(b2)
    
    // 直接打印结果
    println("Underflow case - Saturating sub result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Saturating sub result: 150
Underflow case - Saturating sub result: 0
```

### extend UIntNative <: SaturatingOp\<UIntNative>

```cangjie
extend UIntNative <: SaturatingOp<UIntNative>
```

功能：为 [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) 实现 [SaturatingOp](#interface-saturatingopt) 接口。

父类型：

- [SaturatingOp](#interface-saturatingopt)\<[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)>

#### func saturatingAdd(UIntNative)

```cangjie
public func saturatingAdd(y: UIntNative): UIntNative
```

功能：使用饱和策略的加法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 加数。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UIntNative值，使它们相加会发生上溢出
    let a1 = 18446744073709551615u64  // UIntNative的最大值（在64位系统上）
    let b1 = 1u64
    
    // 使用saturatingAdd进行加法运算（上溢出情况）
    let result1 = a1.saturatingAdd(b1)
    
    // 直接打印结果
    println("Overflow case - Saturating add result: ${result1}")
    
    // 创建两个UIntNative值，使它们相加不会发生溢出
    let a2 = 1000000000000u64
    let b2 = 2000000000000u64
    
    // 使用saturatingAdd进行加法运算（正常情况）
    let result2 = a2.saturatingAdd(b2)
    
    // 直接打印结果
    println("Normal case - Saturating add result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating add result: 18446744073709551615
Normal case - Saturating add result: 3000000000000
```

#### func saturatingDec()

```cangjie
public func saturatingDec(): UIntNative
```

功能：使用饱和策略的自减运算。

当运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UIntNative值，测试下溢情况（0减1应该饱和为0）
    let a1 = 0u64
    
    // 使用saturatingDec进行自减运算（下溢情况）
    let result1 = a1.saturatingDec()
    
    // 直接打印结果
    println("Underflow case - Saturating dec result: ${result1}")
    
    // 创建一个UIntNative值，测试正常情况
    let a2 = 100u64
    
    // 使用saturatingDec进行自减运算（正常情况）
    let result2 = a2.saturatingDec()
    
    // 直接打印结果
    println("Normal case - Saturating dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Saturating dec result: 0
Normal case - Saturating dec result: 99
```

#### func saturatingDiv(UIntNative)

```cangjie
public func saturatingDiv(y: UIntNative): UIntNative
```

功能：使用饱和策略的除法运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

参数：

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 除数。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UIntNative值，测试正常除法情况
    let a1 = 1000000000000u64
    let b1 = 1000u64
    
    // 使用saturatingDiv进行除法运算（正常情况）
    let result1 = a1.saturatingDiv(b1)
    
    // 直接打印结果
    println("Normal case - Saturating div result: ${result1}")
    
    // 创建两个UIntNative值，测试大数除法情况
    let a2 = 18446744073709551615u64  // UIntNative的最大值
    let b2 = 1000000u64
    
    // 使用saturatingDiv进行除法运算（大数情况）
    let result2 = a2.saturatingDiv(b2)
    
    // 直接打印结果
    println("Large number case - Saturating div result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Saturating div result: 1000000000
Large number case - Saturating div result: 18446744073709
```

#### func saturatingInc()

```cangjie
public func saturatingInc(): UIntNative
```

功能：使用饱和策略的自增运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UIntNative值，测试上溢情况（最大值加1应该饱和为最大值）
    let a1 = 18446744073709551615u64  // UIntNative的最大值
    
    // 使用saturatingInc进行自增运算（上溢情况）
    let result1 = a1.saturatingInc()
    
    // 直接打印结果
    println("Overflow case - Saturating inc result: ${result1}")
    
    // 创建一个UIntNative值，测试正常情况
    let a2 = 100u64
    
    // 使用saturatingInc进行自增运算（正常情况）
    let result2 = a2.saturatingInc()
    
    // 直接打印结果
    println("Normal case - Saturating inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Saturating inc result: 18446744073709551615
Normal case - Saturating inc result: 101
```

#### func saturatingMod(UIntNative)

```cangjie
public func saturatingMod(y: UIntNative): UIntNative
```

功能：使用饱和策略的取余运算。

当运算出现上溢时，返回操作数类型的最大值，否则返回运算结果。

参数：

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 除数。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UIntNative值，测试正常取余情况
    let a1 = 1000000000005u64
    let b1 = 1000u64
    
    // 使用saturatingMod进行取余运算（正常情况）
    let result1 = a1.saturatingMod(b1)
    
    // 直接打印结果
    println("Normal case - Saturating mod result: ${result1}")
    
    // 创建两个UIntNative值，测试大数取余情况
    let a2 = 18446744073709551615u64  // UIntNative的最大值
    let b2 = 1000000u64
    
    // 使用saturatingMod进行取余运算（大数情况）
    let result2 = a2.saturatingMod(b2)
    
    // 直接打印结果
    println("Large number case - Saturating mod result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Saturating mod result: 5
Large number case - Saturating mod result: 551615
```

#### func saturatingMul(UIntNative)

```cangjie
public func saturatingMul(y: UIntNative): UIntNative
```

功能：使用饱和策略的乘法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 乘数。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UIntNative值，测试正常乘法情况
    let a1 = 1000000u64
    let b1 = 2000000u64
    
    // 使用saturatingMul进行乘法运算（正常情况）
    let result1 = a1.saturatingMul(b1)
    
    // 直接打印结果
    println("Normal case - Saturating mul result: ${result1}")
    
    // 创建两个UIntNative值，测试上溢情况
    let a2 = 18446744073709551615u64  // UIntNative的最大值
    let b2 = 2u64
    
    // 使用saturatingMul进行乘法运算（上溢情况）
    let result2 = a2.saturatingMul(b2)
    
    // 直接打印结果
    println("Overflow case - Saturating mul result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Saturating mul result: 2000000000000
Overflow case - Saturating mul result: 18446744073709551615
```

#### func saturatingNeg()

```cangjie
public func saturatingNeg(): UIntNative
```

功能：使用饱和策略的负号运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UIntNative值，测试负号运算
    let a1 = 1000000u64
    
    // 使用saturatingNeg进行负号运算
    let result1 = a1.saturatingNeg()
    
    // 直接打印结果
    println("Normal case - Saturating neg result: ${result1}")
    
    // 创建一个UIntNative值0，测试边界情况
    let a2 = 0u64
    
    // 使用saturatingNeg进行负号运算
    let result2 = a2.saturatingNeg()
    
    // 直接打印结果
    println("Zero case - Saturating neg result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Saturating neg result: 0
Zero case - Saturating neg result: 0
```

#### func saturatingShl(UInt64)

```cangjie
public func saturatingShl(y: UInt64): UIntNative
```

功能：使用饱和策略的左移运算。

当移位位数大于等于操作数位数时，将移位位数置为操作数位数 - 1，返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UIntNative值和移位位数，测试正常左移情况
    let a1 = 1000000u64
    let b1 = 10u64
    
    // 使用saturatingShl进行左移运算（正常情况）
    let result1 = a1.saturatingShl(b1)
    
    // 直接打印结果
    println("Normal case - Saturating shl result: ${result1}")
    
    // 创建一个UIntNative值和较大的移位位数，测试边界情况
    let a2 = 1000000u64
    let b2 = 100u64  // 大于64的移位位数
    
    // 使用saturatingShl进行左移运算（边界情况）
    let result2 = a2.saturatingShl(b2)
    
    // 直接打印结果
    println("Large shift case - Saturating shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Saturating shl result: 1024000000
Large shift case - Saturating shl result: 0
```

#### func saturatingShr(UInt64)

```cangjie
public func saturatingShr(y: UInt64): UIntNative
```

功能：使用饱和策略的右移运算。

当移位位数大于等于操作数位数时，将移位位数置为操作数位数 - 1，返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UIntNative值和移位位数，测试正常右移情况
    let a1 = 1000000000000u64
    let b1 = 10u64
    
    // 使用saturatingShr进行右移运算（正常情况）
    let result1 = a1.saturatingShr(b1)
    
    // 直接打印结果
    println("Normal case - Saturating shr result: ${result1}")
    
    // 创建一个UIntNative值和较大的移位位数，测试边界情况
    let a2 = 1000000000000u64
    let b2 = 100u64  // 大于64的移位位数
    
    // 使用saturatingShr进行右移运算（边界情况）
    let result2 = a2.saturatingShr(b2)
    
    // 直接打印结果
    println("Large shift case - Saturating shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Saturating shr result: 976562500
Large shift case - Saturating shr result: 0
```

#### func saturatingSub(UIntNative)

```cangjie
public func saturatingSub(y: UIntNative): UIntNative
```

功能：使用饱和策略的减法运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 减数。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UIntNative值，测试正常减法情况
    let a1 = 1000000000000u64
    let b1 = 500000000000u64
    
    // 使用saturatingSub进行减法运算（正常情况）
    let result1 = a1.saturatingSub(b1)
    
    // 直接打印结果
    println("Normal case - Saturating sub result: ${result1}")
    
    // 创建两个UIntNative值，测试下溢情况（小数减大数应该饱和为0）
    let a2 = 100u64
    let b2 = 1000u64
    
    // 使用saturatingSub进行减法运算（下溢情况）
    let result2 = a2.saturatingSub(b2)
    
    // 直接打印结果
    println("Underflow case - Saturating sub result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Normal case - Saturating sub result: 500000000000
Underflow case - Saturating sub result: 0
```

## interface SaturatingPow

```cangjie
public interface SaturatingPow {
    func saturatingPow(y: UInt64): Int64
}
```

功能：提供饱和策略的幂运算接口。

### func saturatingPow(UInt64)

```cangjie
func saturatingPow(y: UInt64): Int64
```

功能：使用饱和策略的幂运算。

当运算出现上溢时，返回操作数类型的最大值，运算出现下溢时，返回操作数类型的最小值，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 指数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 幂运算结果。

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

功能：当整数运算出现溢出，抛出异常。

### func throwingAdd(T)

```cangjie
func throwingAdd(y: T): T
```

功能：使用抛出异常策略的加法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: T - 加数。

返回值：

- T - 加法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当加法运算出现溢出时，抛出异常。

### func throwingDec()

```cangjie
func throwingDec(): T
```

功能：使用抛出异常策略的自减运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- T - 自减运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当自减运算出现溢出时，抛出异常。

### func throwingDiv(T)

```cangjie
func throwingDiv(y: T): T
```

功能：使用抛出异常策略的除法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: T - 除数。

返回值：

- T - 除法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当除法运算出现溢出时，抛出异常。

### func throwingInc()

```cangjie
func throwingInc(): T
```

功能：使用抛出异常策略的自增运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- T - 自增运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当自增运算出现溢出时，抛出异常。

### func throwingMod(T)

```cangjie
func throwingMod(y: T): T
```

功能：使用抛出异常策略的取余运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: T - 除数。

返回值：

- T - 取余运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当取余运算出现溢出时，抛出异常。

### func throwingMul(T)

```cangjie
func throwingMul(y: T): T
```

功能：使用抛出异常策略的乘法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: T - 乘数。

返回值：

- T - 乘法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当乘法运算出现溢出时，抛出异常。

### func throwingNeg()

```cangjie
func throwingNeg(): T
```

功能：使用抛出异常策略的负号运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- T - 负号运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当负号运算出现溢出时，抛出异常。

### func throwingShl(UInt64)

```cangjie
func throwingShl(y: UInt64): T
```

功能：使用抛出异常策略的左移运算。

当移位位数大于等于操作数位数时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- T - 左移运算结果。

异常：

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - 当移位位数大于等于操作数位数时，抛出异常。

### func throwingShr(UInt64)

```cangjie
func throwingShr(y: UInt64): T
```

功能：右移运算。

当移位位数大于等于操作数位数时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- T - 右移运算结果。

异常：

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - 当移位位数大于等于操作数位数时，抛出异常。

### func throwingSub(T)

```cangjie
func throwingSub(y: T): T
```

功能：使用抛出异常策略的减法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: T - 减数。

返回值：

- T - 减法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当减法运算出现溢出时，抛出异常。

### extend Int16 <: ThrowingOp\<Int16>

```cangjie
extend Int16 <: ThrowingOp<Int16>
```

功能：为 [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) 实现 [ThrowingOp](#interface-throwingopt) 接口。

父类型：

- [ThrowingOp](#interface-throwingopt)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)>

#### func throwingAdd(Int16)

```cangjie
public func throwingAdd(y: Int16): Int16
```

功能：使用抛出异常策略的加法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 加数。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 加法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当加法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int16值进行加法运算
    let a = 1000i16
    let b = 2000i16
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingAdd(b)
        println("Throwing add result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing add exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing add result: 3000
```

#### func throwingDec()

```cangjie
public func throwingDec(): Int16
```

功能：使用抛出异常策略的自减运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 自减运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当自减运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int16值进行自减运算
    let a = 1000i16
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingDec()
        println("Throwing dec result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing dec exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing dec result: 999
```

#### func throwingDiv(Int16)

```cangjie
public func throwingDiv(y: Int16): Int16
```

功能：使用抛出异常策略的除法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 除数。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 除法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当除法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int16值进行除法运算
    let a = 1000i16
    let b = 10i16
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingDiv(b)
        println("Throwing div result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing div exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing div result: 100
```

#### func throwingInc()

```cangjie
public func throwingInc(): Int16
```

功能：使用抛出异常策略的自增运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 自增运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当自增运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int16值进行自增运算
    let a = 1000i16
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingInc()
        println("Throwing inc result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing inc exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing inc result: 1001
```

#### func throwingMod(Int16)

```cangjie
public func throwingMod(y: Int16): Int16
```

功能：使用抛出异常策略的取余运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 除数。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 取余运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当取余运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int16值进行取余运算
    let a = 1005i16
    let b = 100i16
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingMod(b)
        println("Throwing mod result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing mod exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing mod result: 5
```

#### func throwingMul(Int16)

```cangjie
public func throwingMul(y: Int16): Int16
```

功能：使用抛出异常策略的乘法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 乘数。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 乘法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当乘法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int16值进行乘法运算
    let a = 100i16
    let b = 200i16
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingMul(b)
        println("Throwing mul result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing mul exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing mul result: 20000
```

#### func throwingNeg()

```cangjie
public func throwingNeg(): Int16
```

功能：使用抛出异常策略的负号运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 负号运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当负号运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int16值进行负号运算
    let a = 1000i16
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingNeg()
        println("Throwing neg result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing neg exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing neg result: -1000
```

#### func throwingShl(UInt64)

```cangjie
public func throwingShl(y: UInt64): Int16
```

功能：使用抛出异常策略的左移运算。

当移位位数大于等于操作数位数时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 左移运算结果。

异常：

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - 当移位位数大于等于操作数位数时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int16值和移位位数进行左移运算
    let a = 1000i16
    let b = 2u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingShl(b)
        println("Throwing shl result: ${result}")
    } catch (e: OvershiftException) {
        println("Throwing shl exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing shl result: 4000
```

#### func throwingShr(UInt64)

```cangjie
public func throwingShr(y: UInt64): Int16
```

功能：右移运算。

当移位位数大于等于操作数位数时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 右移运算结果。

异常：

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - 当移位位数大于等于操作数位数时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int16值和移位位数进行右移运算
    let a = 1000i16
    let b = 2u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingShr(b)
        println("Throwing shr result: ${result}")
    } catch (e: OvershiftException) {
        println("Throwing shr exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing shr result: 250
```

#### func throwingSub(Int16)

```cangjie
public func throwingSub(y: Int16): Int16
```

功能：使用抛出异常策略的减法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 减数。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 减法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当减法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int16值进行减法运算
    let a = 1000i16
    let b = 500i16
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingSub(b)
        println("Throwing sub result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing sub exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing sub result: 500
```

### extend Int32 <: ThrowingOp\<Int32>

```cangjie
extend Int32 <: ThrowingOp<Int32>
```

功能：为 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 实现 [ThrowingOp](#interface-throwingopt) 接口。

父类型：

- [ThrowingOp](#interface-throwingopt)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)>

#### func throwingAdd(Int32)

```cangjie
public func throwingAdd(y: Int32): Int32
```

功能：使用抛出异常策略的加法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 加数。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 加法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当加法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int32值进行加法运算
    let a = 1000000i32
    let b = 2000000i32
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingAdd(b)
        println("Throwing add result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing add exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing add result: 3000000
```

#### func throwingDec()

```cangjie
public func throwingDec(): Int32
```

功能：使用抛出异常策略的自减运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 自减运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当自减运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int32值进行自减运算
    let a = 1000000i32
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingDec()
        println("Throwing dec result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing dec exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing dec result: 999999
```

#### func throwingDiv(Int32)

```cangjie
public func throwingDiv(y: Int32): Int32
```

功能：使用抛出异常策略的除法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 除数。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 除法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当除法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int32值进行除法运算
    let a = 1000000i32
    let b = 10i32
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingDiv(b)
        println("Throwing div result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing div exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing div result: 100000
```

#### func throwingInc()

```cangjie
public func throwingInc(): Int32
```

功能：使用抛出异常策略的自增运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 自增运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当自增运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int32值进行自增运算
    let a = 1000000i32
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingInc()
        println("Throwing inc result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing inc exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing inc result: 1000001
```

#### func throwingMod(Int32)

```cangjie
public func throwingMod(y: Int32): Int32
```

功能：使用抛出异常策略的取余运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 除数。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 取余运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当取余运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int32值进行取余运算
    let a = 1000005i32
    let b = 1000i32
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingMod(b)
        println("Throwing mod result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing mod exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing mod result: 5
```

#### func throwingMul(Int32)

```cangjie
public func throwingMul(y: Int32): Int32
```

功能：使用抛出异常策略的乘法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 乘数。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 乘法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当乘法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int32值进行乘法运算
    let a = 1000i32
    let b = 2000i32
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingMul(b)
        println("Throwing mul result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing mul exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing mul result: 2000000
```

#### func throwingNeg()

```cangjie
public func throwingNeg(): Int32
```

功能：使用抛出异常策略的负号运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 负号运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当负号运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int32值进行负号运算
    let a = 1000000i32
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingNeg()
        println("Throwing neg result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing neg exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing neg result: -1000000
```

#### func throwingShl(UInt64)

```cangjie
public func throwingShl(y: UInt64): Int32
```

功能：使用抛出异常策略的左移运算。

当移位位数大于等于操作数位数时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 左移运算结果。

异常：

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - 当移位位数大于等于操作数位数时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int32值和移位位数进行左移运算
    let a = 1000000i32
    let b = 2u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingShl(b)
        println("Throwing shl result: ${result}")
    } catch (e: OvershiftException) {
        println("Throwing shl exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing shl result: 4000000
```

#### func throwingShr(UInt64)

```cangjie
public func throwingShr(y: UInt64): Int32
```

功能：右移运算。

当移位位数大于等于操作数位数时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 右移运算结果。

异常：

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - 当移位位数大于等于操作数位数时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int32值和移位位数进行右移运算
    let a = 1000000i32
    let b = 2u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingShr(b)
        println("Throwing shr result: ${result}")
    } catch (e: OvershiftException) {
        println("Throwing shr exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing shr result: 250000
```

#### func throwingSub(Int32)

```cangjie
public func throwingSub(y: Int32): Int32
```

功能：使用抛出异常策略的减法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 减数。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 减法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当减法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int32值进行减法运算
    let a = 1000000i32
    let b = 500000i32
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingSub(b)
        println("Throwing sub result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing sub exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing sub result: 500000
```

### extend Int64 <: ThrowingOp\<Int64> & ThrowingPow

```cangjie
extend Int64 <: ThrowingOp<Int64> & ThrowingPow
```

功能：为 [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) 实现 [ThrowingOp](#interface-throwingopt) 和 [ThrowingPow](#interface-throwingpow) 接口。

父类型：

- [ThrowingOp](#interface-throwingopt)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>
- [ThrowingPow](#interface-throwingpow)

#### func throwingAdd(Int64)

```cangjie
public func throwingAdd(y: Int64): Int64
```

功能：使用抛出异常策略的加法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 加数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 加法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当加法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int64值进行加法运算
    let a = 1000000000i64
    let b = 2000000000i64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingAdd(b)
        println("Throwing add result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing add exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing add result: 3000000000
```

#### func throwingDec()

```cangjie
public func throwingDec(): Int64
```

功能：使用抛出异常策略的自减运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 自减运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当自减运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值进行自减运算
    let a = 1000000000i64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingDec()
        println("Throwing dec result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing dec exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing dec result: 999999999
```

#### func throwingDiv(Int64)

```cangjie
public func throwingDiv(y: Int64): Int64
```

功能：使用抛出异常策略的除法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 除数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 除法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当除法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int64值进行除法运算
    let a = 1000000000i64
    let b = 10i64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingDiv(b)
        println("Throwing div result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing div exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing div result: 100000000
```

#### func throwingInc()

```cangjie
public func throwingInc(): Int64
```

功能：使用抛出异常策略的自增运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 自增运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当自增运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值进行自增运算
    let a = 1000000000i64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingInc()
        println("Throwing inc result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing inc exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing inc result: 1000000001
```

#### func throwingMod(Int64)

```cangjie
public func throwingMod(y: Int64): Int64
```

功能：使用抛出异常策略的取余运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 除数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 取余运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当取余运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int64值进行取余运算
    let a = 1000000005i64
    let b = 1000i64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingMod(b)
        println("Throwing mod result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing mod exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing mod result: 5
```

#### func throwingMul(Int64)

```cangjie
public func throwingMul(y: Int64): Int64
```

功能：使用抛出异常策略的乘法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 乘数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 乘法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当乘法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int64值进行乘法运算
    let a = 1000i64
    let b = 2000i64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingMul(b)
        println("Throwing mul result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing mul exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing mul result: 2000000
```

#### func throwingNeg()

```cangjie
public func throwingNeg(): Int64
```

功能：使用抛出异常策略的负号运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 负号运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当负号运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值进行负号运算
    let a = 1000000000i64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingNeg()
        println("Throwing neg result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing neg exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing neg result: -1000000000
```

#### func throwingPow(UInt64)

```cangjie
public func throwingPow(y: UInt64): Int64
```

功能：使用抛出异常策略的幂运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 指数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 幂运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当幂运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值和指数进行幂运算
    let a = 1000i64
    let b = 2u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingPow(b)
        println("Throwing pow result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing pow exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing pow result: 1000000
```

#### func throwingShl(UInt64)

```cangjie
public func throwingShl(y: UInt64): Int64
```

功能：使用抛出异常策略的左移运算。

当移位位数大于等于操作数位数时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 左移运算结果。

异常：

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - 当移位位数大于等于操作数位数时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值和移位位数进行左移运算
    let a = 1000000i64
    let b = 2u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingShl(b)
        println("Throwing shl result: ${result}")
    } catch (e: OvershiftException) {
        println("Throwing shl exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing shl result: 4000000
```

#### func throwingShr(UInt64)

```cangjie
public func throwingShr(y: UInt64): Int64
```

功能：右移运算。

当移位位数大于等于操作数位数时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 右移运算结果。

异常：

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - 当移位位数大于等于操作数位数时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值和移位位数进行右移运算
    let a = 1000000i64
    let b = 2u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingShr(b)
        println("Throwing shr result: ${result}")
    } catch (e: OvershiftException) {
        println("Throwing shr exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing shr result: 250000
```

#### func throwingSub(Int64)

```cangjie
public func throwingSub(y: Int64): Int64
```

功能：使用抛出异常策略的减法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 减数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 减法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当减法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int64值进行减法运算
    let a = 1000000000i64
    let b = 500000000i64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingSub(b)
        println("Throwing sub result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing sub exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing sub result: 500000000
```

### extend Int8 <: ThrowingOp\<Int8>

```cangjie
extend Int8 <: ThrowingOp<Int8>
```

功能：为 [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) 实现 [ThrowingOp](#interface-throwingopt) 接口。

父类型：

- [ThrowingOp](#interface-throwingopt)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)>

#### func throwingAdd(Int8)

```cangjie
public func throwingAdd(y: Int8): Int8
```

功能：使用抛出异常策略的加法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 加数。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 加法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当加法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int8值进行加法运算
    let a = 100i8
    let b = 20i8
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingAdd(b)
        println("Throwing add result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing add exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing add result: 120
```

#### func throwingDec()

```cangjie
public func throwingDec(): Int8
```

功能：使用抛出异常策略的自减运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 自减运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当自减运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int8值进行自减运算
    let a = 100i8
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingDec()
        println("Throwing dec result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing dec exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing dec result: 99
```

#### func throwingDiv(Int8)

```cangjie
public func throwingDiv(y: Int8): Int8
```

功能：使用抛出异常策略的除法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 除数。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 除法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当除法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int8值进行除法运算
    let a = 100i8
    let b = 10i8
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingDiv(b)
        println("Throwing div result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing div exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing div result: 10
```

#### func throwingInc()

```cangjie
public func throwingInc(): Int8
```

功能：使用抛出异常策略的自增运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 自增运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当自增运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int8值进行自增运算
    let a = 100i8
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingInc()
        println("Throwing inc result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing inc exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing inc result: 101
```

#### func throwingMod(Int8)

```cangjie
public func throwingMod(y: Int8): Int8
```

功能：使用抛出异常策略的取余运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 除数。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 取余运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当取余运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int8值进行取余运算
    let a = 105i8
    let b = 10i8
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingMod(b)
        println("Throwing mod result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing mod exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing mod result: 5
```

#### func throwingMul(Int8)

```cangjie
public func throwingMul(y: Int8): Int8
```

功能：使用抛出异常策略的乘法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 乘数。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 乘法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当乘法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int8值进行乘法运算
    let a = 5i8
    let b = 10i8
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingMul(b)
        println("Throwing mul result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing mul exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing mul result: 50
```

#### func throwingNeg()

```cangjie
public func throwingNeg(): Int8
```

功能：使用抛出异常策略的负号运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 负号运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当负号运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int8值进行负号运算
    let a = 100i8
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingNeg()
        println("Throwing neg result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing neg exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing neg result: -100
```

#### func throwingShl(UInt64)

```cangjie
public func throwingShl(y: UInt64): Int8
```

功能：使用抛出异常策略的左移运算。

当移位位数大于等于操作数位数时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 左移运算结果。

异常：

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - 当移位位数大于等于操作数位数时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int8值和移位位数进行左移运算
    let a = 100i8
    let b = 2u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingShl(b)
        println("Throwing shl result: ${result}")
    } catch (e: OvershiftException) {
        println("Throwing shl exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing shl result: -112
```

#### func throwingShr(UInt64)

```cangjie
public func throwingShr(y: UInt64): Int8
```

功能：右移运算。

当移位位数大于等于操作数位数时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 右移运算结果。

异常：

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - 当移位位数大于等于操作数位数时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int8值和移位位数进行右移运算
    let a = 100i8
    let b = 2u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingShr(b)
        println("Throwing shr result: ${result}")
    } catch (e: OvershiftException) {
        println("Throwing shr exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing shr result: 25
```

#### func throwingSub(Int8)

```cangjie
public func throwingSub(y: Int8): Int8
```

功能：使用抛出异常策略的减法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 减数。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 减法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当减法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int8值进行减法运算
    let a = 100i8
    let b = 50i8
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingSub(b)
        println("Throwing sub result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing sub exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing sub result: 50
```

### extend IntNative <: ThrowingOp\<IntNative>

```cangjie
extend IntNative <: ThrowingOp<IntNative>
```

功能：为 [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) 实现 [ThrowingOp](#interface-throwingopt) 接口。

父类型：

- [ThrowingOp](#interface-throwingopt)\<[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)>

#### func throwingAdd(IntNative)

```cangjie
public func throwingAdd(y: IntNative): IntNative
```

功能：使用抛出异常策略的加法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 加数。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 加法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当加法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): IntNative {
    // 创建两个IntNative值进行加法运算
    let a: IntNative = 1000000000
    let b: IntNative = 2000000000
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingAdd(b)
        println("Throwing add result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing add exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing add result: 3000000000
```

#### func throwingDec()

```cangjie
public func throwingDec(): IntNative
```

功能：使用抛出异常策略的自减运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 自减运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当自减运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): IntNative {
    // 创建一个IntNative值进行自减运算
    let a: IntNative = 1000000000
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingDec()
        println("Throwing dec result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing dec exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing dec result: 999999999
```

#### func throwingDiv(IntNative)

```cangjie
public func throwingDiv(y: IntNative): IntNative
```

功能：使用抛出异常策略的除法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 除数。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 除法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当除法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): IntNative {
    // 创建两个IntNative值进行除法运算
    let a: IntNative = 1000000000
    let b: IntNative = 10
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingDiv(b)
        println("Throwing div result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing div exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing div result: 100000000
```

#### func throwingInc()

```cangjie
public func throwingInc(): IntNative
```

功能：使用抛出异常策略的自增运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 自增运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当自增运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): IntNative {
    // 创建一个IntNative值进行自增运算
    let a: IntNative = 1000000000
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingInc()
        println("Throwing inc result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing inc exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing inc result: 1000000001
```

#### func throwingMod(IntNative)

```cangjie
public func throwingMod(y: IntNative): IntNative
```

功能：使用抛出异常策略的取余运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 除数。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 取余运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当取余运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): IntNative {
    // 创建两个IntNative值进行取余运算
    let a: IntNative = 1000000005
    let b: IntNative = 1000
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingMod(b)
        println("Throwing mod result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing mod exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing mod result: 5
```

#### func throwingMul(IntNative)

```cangjie
public func throwingMul(y: IntNative): IntNative
```

功能：使用抛出异常策略的乘法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 乘数。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 乘法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当乘法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): IntNative {
    // 创建两个IntNative值进行乘法运算
    let a: IntNative = 1000
    let b: IntNative = 2000
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingMul(b)
        println("Throwing mul result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing mul exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing mul result: 2000000
```

#### func throwingNeg()

```cangjie
public func throwingNeg(): IntNative
```

功能：使用抛出异常策略的负号运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 负号运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当负号运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): IntNative {
    // 创建一个IntNative值进行负号运算
    let a: IntNative = 1000000000
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingNeg()
        println("Throwing neg result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing neg exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing neg result: -1000000000
```

#### func throwingShl(UInt64)

```cangjie
public func throwingShl(y: UInt64): IntNative
```

功能：使用抛出异常策略的左移运算。

当移位位数大于等于操作数位数时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 左移运算结果。

异常：

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - 当移位位数大于等于操作数位数时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): IntNative {
    // 创建一个IntNative值和移位位数进行左移运算
    let a: IntNative = 1000000
    let b = 2u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingShl(b)
        println("Throwing shl result: ${result}")
    } catch (e: OvershiftException) {
        println("Throwing shl exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing shl result: 4000000
```

#### func throwingShr(UInt64)

```cangjie
public func throwingShr(y: UInt64): IntNative
```

功能：右移运算。

当移位位数大于等于操作数位数时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 右移运算结果。

异常：

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - 当移位位数大于等于操作数位数时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): IntNative {
    // 创建一个IntNative值和移位位数进行右移运算
    let a: IntNative = 1000000
    let b = 2u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingShr(b)
        println("Throwing shr result: ${result}")
    } catch (e: OvershiftException) {
        println("Throwing shr exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing shr result: 250000
```

#### func throwingSub(IntNative)

```cangjie
public func throwingSub(y: IntNative): IntNative
```

功能：使用抛出异常策略的减法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 减数。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 减法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当减法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): IntNative {
    // 创建两个IntNative值进行减法运算
    let a: IntNative = 1000000000
    let b: IntNative = 500000000
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingSub(b)
        println("Throwing sub result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing sub exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing sub result: 500000000
```

### extend UInt16 <: ThrowingOp\<UInt16>

```cangjie
extend UInt16 <: ThrowingOp<UInt16>
```

功能：为 [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) 实现 [ThrowingOp](#interface-throwingopt) 接口。

父类型：

- [ThrowingOp](#interface-throwingopt)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)>

#### func throwingAdd(UInt16)

```cangjie
public func throwingAdd(y: UInt16): UInt16
```

功能：使用抛出异常策略的加法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 加数。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 加法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当加法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt16值进行加法运算
    let a = 1000u16
    let b = 2000u16
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingAdd(b)
        println("Throwing add result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing add exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing add result: 3000
```

#### func throwingDec()

```cangjie
public func throwingDec(): UInt16
```

功能：使用抛出异常策略的自减运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 自减运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当自减运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt16值进行自减运算
    let a = 1000u16
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingDec()
        println("Throwing dec result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing dec exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing dec result: 999
```

#### func throwingDiv(UInt16)

```cangjie
public func throwingDiv(y: UInt16): UInt16
```

功能：使用抛出异常策略的除法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 除数。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 除法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当除法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt16值进行除法运算
    let a = 1000u16
    let b = 10u16
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingDiv(b)
        println("Throwing div result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing div exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing div result: 100
```

#### func throwingInc()

```cangjie
public func throwingInc(): UInt16
```

功能：使用抛出异常策略的自增运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 自增运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当自增运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt16值进行自增运算
    let a = 1000u16
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingInc()
        println("Throwing inc result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing inc exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing inc result: 1001
```

#### func throwingMod(UInt16)

```cangjie
public func throwingMod(y: UInt16): UInt16
```

功能：使用抛出异常策略的取余运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 除数。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 取余运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当取余运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt16值进行取余运算
    let a = 1005u16
    let b = 100u16
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingMod(b)
        println("Throwing mod result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing mod exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing mod result: 5
```

#### func throwingMul(UInt16)

```cangjie
public func throwingMul(y: UInt16): UInt16
```

功能：使用抛出异常策略的乘法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 乘数。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 乘法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当乘法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt16值进行乘法运算
    let a = 100u16
    let b = 200u16
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingMul(b)
        println("Throwing mul result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing mul exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing mul result: 20000
```

#### func throwingNeg()

```cangjie
public func throwingNeg(): UInt16
```

功能：使用抛出异常策略的负号运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 负号运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当负号运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt16值进行负号运算
    let a = 1000u16
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingNeg()
        println("Throwing neg result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing neg exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing neg exception: OverflowException: sub
```

#### func throwingShl(UInt64)

```cangjie
public func throwingShl(y: UInt64): UInt16
```

功能：使用抛出异常策略的左移运算。

当移位位数大于等于操作数位数时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 左移运算结果。

异常：

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - 当移位位数大于等于操作数位数时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt16值和移位位数进行左移运算
    let a = 1000u16
    let b = 2u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingShl(b)
        println("Throwing shl result: ${result}")
    } catch (e: OvershiftException) {
        println("Throwing shl exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing shl result: 4000
```

#### func throwingShr(UInt64)

```cangjie
public func throwingShr(y: UInt64): UInt16
```

功能：右移运算。

当移位位数大于等于操作数位数时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 右移运算结果。

异常：

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - 当移位位数大于等于操作数位数时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt16值和移位位数进行右移运算
    let a = 1000u16
    let b = 2u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingShr(b)
        println("Throwing shr result: ${result}")
    } catch (e: OvershiftException) {
        println("Throwing shr exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing shr result: 250
```

#### func throwingSub(UInt16)

```cangjie
public func throwingSub(y: UInt16): UInt16
```

功能：使用抛出异常策略的减法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 减数。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 减法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当减法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt16值进行减法运算
    let a = 1000u16
    let b = 500u16
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingSub(b)
        println("Throwing sub result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing sub exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing sub result: 500
```

### extend UInt32 <: ThrowingOp\<UInt32>

```cangjie
extend UInt32 <: ThrowingOp<UInt32>
```

功能：为 [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) 实现 [ThrowingOp](#interface-throwingopt) 接口。

父类型：

- [ThrowingOp](#interface-throwingopt)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)>

#### func throwingAdd(UInt32)

```cangjie
public func throwingAdd(y: UInt32): UInt32
```

功能：使用抛出异常策略的加法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 加数。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 加法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当加法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt32值进行加法运算
    let a = 1000u32
    let b = 2000u32
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingAdd(b)
        println("Throwing add result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing add exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing add result: 3000
```

#### func throwingDec()

```cangjie
public func throwingDec(): UInt32
```

功能：使用抛出异常策略的自减运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 自减运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当自减运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt32值进行自减运算
    let a = 1000u32
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingDec()
        println("Throwing dec result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing dec exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing dec result: 999
```

#### func throwingDiv(UInt32)

```cangjie
public func throwingDiv(y: UInt32): UInt32
```

功能：使用抛出异常策略的除法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 除数。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 除法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当除法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt32值进行除法运算
    let a = 1000u32
    let b = 10u32
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingDiv(b)
        println("Throwing div result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing div exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing div result: 100
```

#### func throwingInc()

```cangjie
public func throwingInc(): UInt32
```

功能：使用抛出异常策略的自增运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 自增运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当自增运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt32值进行自增运算
    let a = 1000u32
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingInc()
        println("Throwing inc result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing inc exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing inc result: 1001
```

#### func throwingMod(UInt32)

```cangjie
public func throwingMod(y: UInt32): UInt32
```

功能：使用抛出异常策略的取余运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 除数。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 取余运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当取余运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt32值进行取余运算
    let a = 1005u32
    let b = 100u32
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingMod(b)
        println("Throwing mod result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing mod exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing mod result: 5
```

#### func throwingMul(UInt32)

```cangjie
public func throwingMul(y: UInt32): UInt32
```

功能：使用抛出异常策略的乘法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 乘数。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 乘法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当乘法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt32值进行乘法运算
    let a = 100u32
    let b = 200u32
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingMul(b)
        println("Throwing mul result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing mul exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing mul result: 20000
```

#### func throwingNeg()

```cangjie
public func throwingNeg(): UInt32
```

功能：使用抛出异常策略的负号运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 负号运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当负号运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt32值进行负号运算
    let a = 1000u32
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingNeg()
        println("Throwing neg result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing neg exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing neg exception: OverflowException: sub
```

#### func throwingShl(UInt64)

```cangjie
public func throwingShl(y: UInt64): UInt32
```

功能：使用抛出异常策略的左移运算。

当移位位数大于等于操作数位数时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 左移运算结果。

异常：

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - 当移位位数大于等于操作数位数时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt32值和移位位数进行左移运算
    let a = 1000u32
    let b = 2u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingShl(b)
        println("Throwing shl result: ${result}")
    } catch (e: OvershiftException) {
        println("Throwing shl exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing shl result: 4000
```

#### func throwingShr(UInt64)

```cangjie
public func throwingShr(y: UInt64): UInt32
```

功能：右移运算。

当移位位数大于等于操作数位数时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 右移运算结果。

异常：

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - 当移位位数大于等于操作数位数时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt32值和移位位数进行右移运算
    let a = 1000u32
    let b = 2u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingShr(b)
        println("Throwing shr result: ${result}")
    } catch (e: OvershiftException) {
        println("Throwing shr exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing shr result: 250
```

#### func throwingSub(UInt32)

```cangjie
public func throwingSub(y: UInt32): UInt32
```

功能：使用抛出异常策略的减法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 减数。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 减法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当减法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt32值进行减法运算
    let a = 1000u32
    let b = 500u32
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingSub(b)
        println("Throwing sub result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing sub exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing sub result: 500
```

### extend UInt64 <: ThrowingOp\<UInt64>

```cangjie
extend UInt64 <: ThrowingOp<UInt64>
```

功能：为 [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) 实现 [ThrowingOp](#interface-throwingopt) 接口。

父类型：

- [ThrowingOp](#interface-throwingopt)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)>

#### func throwingAdd(UInt64)

```cangjie
public func throwingAdd(y: UInt64): UInt64
```

功能：使用抛出异常策略的加法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 加数。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 加法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当加法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt64值进行加法运算
    let a = 1000u64
    let b = 2000u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingAdd(b)
        println("Throwing add result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing add exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing add result: 3000
```

#### func throwingDec()

```cangjie
public func throwingDec(): UInt64
```

功能：使用抛出异常策略的自减运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 自减运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当自减运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt64值进行自减运算
    let a = 1000u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingDec()
        println("Throwing dec result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing dec exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing dec result: 999
```

#### func throwingDiv(UInt64)

```cangjie
public func throwingDiv(y: UInt64): UInt64
```

功能：使用抛出异常策略的除法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 除数。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 除法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当除法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt64值进行除法运算
    let a = 1000u64
    let b = 10u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingDiv(b)
        println("Throwing div result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing div exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing div result: 100
```

#### func throwingInc()

```cangjie
public func throwingInc(): UInt64
```

功能：使用抛出异常策略的自增运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 自增运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当自增运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt64值进行自增运算
    let a = 1000u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingInc()
        println("Throwing inc result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing inc exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing inc result: 1001
```

#### func throwingMod(UInt64)

```cangjie
public func throwingMod(y: UInt64): UInt64
```

功能：使用抛出异常策略的取余运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 除数。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 取余运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当取余运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt64值进行取余运算
    let a = 1005u64
    let b = 100u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingMod(b)
        println("Throwing mod result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing mod exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing mod result: 5
```

#### func throwingMul(UInt64)

```cangjie
public func throwingMul(y: UInt64): UInt64
```

功能：使用抛出异常策略的乘法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 乘数。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 乘法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当乘法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt64值进行乘法运算
    let a = 100u64
    let b = 200u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingMul(b)
        println("Throwing mul result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing mul exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing mul result: 20000
```

#### func throwingNeg()

```cangjie
public func throwingNeg(): UInt64
```

功能：使用抛出异常策略的负号运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 负号运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当负号运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt64值进行负号运算
    let a = 1000u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingNeg()
        println("Throwing neg result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing neg exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing neg exception: OverflowException: sub
```

#### func throwingShl(UInt64)

```cangjie
public func throwingShl(y: UInt64): UInt64
```

功能：使用抛出异常策略的左移运算。

当移位位数大于等于操作数位数时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 左移运算结果。

异常：

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - 当移位位数大于等于操作数位数时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt64值和移位位数进行左移运算
    let a = 1000u64
    let b = 2u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingShl(b)
        println("Throwing shl result: ${result}")
    } catch (e: OvershiftException) {
        println("Throwing shl exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing shl result: 4000
```

#### func throwingShr(UInt64)

```cangjie
public func throwingShr(y: UInt64): UInt64
```

功能：右移运算。

当移位位数大于等于操作数位数时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 右移运算结果。

异常：

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - 当移位位数大于等于操作数位数时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt64值和移位位数进行右移运算
    let a = 1000u64
    let b = 2u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingShr(b)
        println("Throwing shr result: ${result}")
    } catch (e: OvershiftException) {
        println("Throwing shr exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing shr result: 250
```

#### func throwingSub(UInt64)

```cangjie
public func throwingSub(y: UInt64): UInt64
```

功能：使用抛出异常策略的减法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 减数。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 减法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当减法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt64值进行减法运算
    let a = 1000u64
    let b = 500u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingSub(b)
        println("Throwing sub result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing sub exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing sub result: 500
```

### extend UInt8 <: ThrowingOp\<UInt8>

```cangjie
extend UInt8 <: ThrowingOp<UInt8>
```

功能：为 [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) 实现 [ThrowingOp](#interface-throwingopt) 接口。

父类型：

- [ThrowingOp](#interface-throwingopt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)>

#### func throwingAdd(UInt8)

```cangjie
public func throwingAdd(y: UInt8): UInt8
```

功能：使用抛出异常策略的加法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 加数。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 加法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当加法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt8值进行加法运算
    let a = 100u8
    let b = 20u8
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingAdd(b)
        println("Throwing add result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing add exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing add result: 120
```

#### func throwingDec()

```cangjie
public func throwingDec(): UInt8
```

功能：使用抛出异常策略的自减运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 自减运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当自减运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt8值进行自减运算
    let a = 100u8
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingDec()
        println("Throwing dec result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing dec exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing dec result: 99
```

#### func throwingDiv(UInt8)

```cangjie
public func throwingDiv(y: UInt8): UInt8
```

功能：使用抛出异常策略的除法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 除数。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 除法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当除法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt8值进行除法运算
    let a = 100u8
    let b = 10u8
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingDiv(b)
        println("Throwing div result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing div exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing div result: 10
```

#### func throwingInc()

```cangjie
public func throwingInc(): UInt8
```

功能：使用抛出异常策略的自增运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 自增运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当自增运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt8值进行自增运算
    let a = 100u8
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingInc()
        println("Throwing inc result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing inc exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing inc result: 101
```

#### func throwingMod(UInt8)

```cangjie
public func throwingMod(y: UInt8): UInt8
```

功能：使用抛出异常策略的取余运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 除数。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 取余运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当取余运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt8值进行取余运算
    let a = 105u8
    let b = 10u8
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingMod(b)
        println("Throwing mod result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing mod exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing mod result: 5
```

#### func throwingMul(UInt8)

```cangjie
public func throwingMul(y: UInt8): UInt8
```

功能：使用抛出异常策略的乘法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 乘数。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 乘法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当乘法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt8值进行乘法运算
    let a = 5u8
    let b = 10u8
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingMul(b)
        println("Throwing mul result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing mul exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing mul result: 50
```

#### func throwingNeg()

```cangjie
public func throwingNeg(): UInt8
```

功能：使用抛出异常策略的负号运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 负号运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当负号运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt8值进行负号运算
    let a = 100u8
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingNeg()
        println("Throwing neg result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing neg exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing neg exception: OverflowException: sub
```

#### func throwingShl(UInt64)

```cangjie
public func throwingShl(y: UInt64): UInt8
```

功能：使用抛出异常策略的左移运算。

当移位位数大于等于操作数位数时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 左移运算结果。

异常：

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - 当移位位数大于等于操作数位数时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt8值和移位位数进行左移运算
    let a = 100u8
    let b = 2u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingShl(b)
        println("Throwing shl result: ${result}")
    } catch (e: OvershiftException) {
        println("Throwing shl exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing shl result: 144
```

#### func throwingShr(UInt64)

```cangjie
public func throwingShr(y: UInt64): UInt8
```

功能：右移运算。

当移位位数大于等于操作数位数时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 右移运算结果。

异常：

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - 当移位位数大于等于操作数位数时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt8值和移位位数进行右移运算
    let a = 100u8
    let b = 2u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingShr(b)
        println("Throwing shr result: ${result}")
    } catch (e: OvershiftException) {
        println("Throwing shr exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing shr result: 25
```

#### func throwingSub(UInt8)

```cangjie
public func throwingSub(y: UInt8): UInt8
```

功能：使用抛出异常策略的减法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 减数。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 减法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当减法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt8值进行减法运算
    let a = 100u8
    let b = 50u8
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingSub(b)
        println("Throwing sub result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing sub exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing sub result: 50
```

### extend UIntNative <: ThrowingOp\<UIntNative>

```cangjie
extend UIntNative <: ThrowingOp<UIntNative>
```

功能：为 [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) 实现 [ThrowingOp](#interface-throwingopt) 接口。

父类型：

- [ThrowingOp](#interface-throwingopt)\<[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)>

#### func throwingAdd(UIntNative)

```cangjie
public func throwingAdd(y: UIntNative): UIntNative
```

功能：使用抛出异常策略的加法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 加数。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 加法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当加法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UIntNative值进行加法运算
    let a: UIntNative = 1000
    let b: UIntNative = 2000
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingAdd(b)
        println("Throwing add result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing add exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing add result: 3000
```

#### func throwingDec()

```cangjie
public func throwingDec(): UIntNative
```

功能：使用抛出异常策略的自减运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 自减运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当自减运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UIntNative值进行自减运算
    let a: UIntNative = 1000
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingDec()
        println("Throwing dec result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing dec exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing dec result: 999
```

#### func throwingDiv(UIntNative)

```cangjie
public func throwingDiv(y: UIntNative): UIntNative
```

功能：使用抛出异常策略的除法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 除数。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 除法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当除法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UIntNative值进行除法运算
    let a: UIntNative = 1000
    let b: UIntNative = 10
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingDiv(b)
        println("Throwing div result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing div exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing div result: 100
```

#### func throwingInc()

```cangjie
public func throwingInc(): UIntNative
```

功能：使用抛出异常策略的自增运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 自增运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当自增运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UIntNative值进行自增运算
    let a: UIntNative = 1000
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingInc()
        println("Throwing inc result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing inc exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing inc result: 1001
```

#### func throwingMod(UIntNative)

```cangjie
public func throwingMod(y: UIntNative): UIntNative
```

功能：使用抛出异常策略的取余运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 除数。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 取余运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当取余运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UIntNative值进行取余运算
    let a: UIntNative = 1005
    let b: UIntNative = 100
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingMod(b)
        println("Throwing mod result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing mod exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing mod result: 5
```

#### func throwingMul(UIntNative)

```cangjie
public func throwingMul(y: UIntNative): UIntNative
```

功能：使用抛出异常策略的乘法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 乘数。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 乘法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当乘法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UIntNative值进行乘法运算
    let a: UIntNative = 100
    let b: UIntNative = 200
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingMul(b)
        println("Throwing mul result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing mul exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing mul result: 20000
```

#### func throwingNeg()

```cangjie
public func throwingNeg(): UIntNative
```

功能：使用抛出异常策略的负号运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 负号运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当负号运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UIntNative值进行负号运算
    let a: UIntNative = 1000
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingNeg()
        println("Throwing neg result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing neg exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing neg exception: OverflowException: sub
```

#### func throwingShl(UInt64)

```cangjie
public func throwingShl(y: UInt64): UIntNative
```

功能：使用抛出异常策略的左移运算。

当移位位数大于等于操作数位数时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 左移运算结果。

异常：

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - 当移位位数大于等于操作数位数时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UIntNative值和移位位数进行左移运算
    let a: UIntNative = 1000
    let b = 2u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingShl(b)
        println("Throwing shl result: ${result}")
    } catch (e: OvershiftException) {
        println("Throwing shl exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing shl result: 4000
```

#### func throwingShr(UInt64)

```cangjie
public func throwingShr(y: UInt64): UIntNative
```

功能：右移运算。

当移位位数大于等于操作数位数时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 右移运算结果。

异常：

- [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) - 当移位位数大于等于操作数位数时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UIntNative值和移位位数进行右移运算
    let a: UIntNative = 1000
    let b = 2u64
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingShr(b)
        println("Throwing shr result: ${result}")
    } catch (e: OvershiftException) {
        println("Throwing shr exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing shr result: 250
```

#### func throwingSub(UIntNative)

```cangjie
public func throwingSub(y: UIntNative): UIntNative
```

功能：使用抛出异常策略的减法运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 减数。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 减法运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当减法运算出现溢出时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UIntNative值进行减法运算
    let a: UIntNative = 1000
    let b: UIntNative = 500
    
    // 使用try-catch处理可能的异常
    try {
        let result = a.throwingSub(b)
        println("Throwing sub result: ${result}")
    } catch (e: OverflowException) {
        println("Throwing sub exception: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
Throwing sub result: 500
```

## interface ThrowingPow

```cangjie
public interface ThrowingPow {
    func throwingPow(y: UInt64): Int64
}
```

功能：提供使用抛出异常策略的幂运算接口。

### func throwingPow(UInt64)

```cangjie
func throwingPow(y: UInt64): Int64
```

功能：使用抛出异常策略的幂运算。

当运算出现溢出时，抛出异常，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 指数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 幂运算结果。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当幂运算出现溢出时，抛出异常。

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

功能：当整数运算出现溢出，高位截断。

### func wrappingAdd(T)

```cangjie
func wrappingAdd(y: T): T
```

功能：使用高位截断策略的加法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: T - 加数。

返回值：

- T - 加法运算结果。

### func wrappingDec()

```cangjie
func wrappingDec(): T
```

功能：使用高位截断策略的自减运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- T - 自减运算结果。

### func wrappingDiv(T)

```cangjie
func wrappingDiv(y: T): T
```

功能：使用高位截断策略的除法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: T - 除数。

返回值：

- T - 除法运算结果。

### func wrappingInc()

```cangjie
func wrappingInc(): T
```

功能：使用高位截断策略的自增运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- T - 自增运算结果。

### func wrappingMod(T)

```cangjie
func wrappingMod(y: T): T
```

功能：使用高位截断策略的取余运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: T - 除数。

返回值：

- T - 取余运算结果。

### func wrappingMul(T)

```cangjie
func wrappingMul(y: T): T
```

功能：使用高位截断策略的乘法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: T - 乘数。

返回值：

- T - 乘法运算结果。

### func wrappingNeg()

```cangjie
func wrappingNeg(): T
```

功能：使用高位截断策略的负号运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- T - 负号运算结果。

### func wrappingShl(UInt64)

```cangjie
func wrappingShl(y: UInt64): T
```

功能：使用高位截断策略的左移运算。

当移位位数大于等于操作数位数时，高位截断。例如，对 [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) 类型的数进行移位，当 y (移位位数)超大于等于 8时，仅取 y 的低 3 位作为移位位数，以此保证移位位数在 0 到 7 之间。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- T - 左移运算结果。

### func wrappingShr(UInt64)

```cangjie
func wrappingShr(y: UInt64): T
```

功能：使用高位截断策略的右移运算。

当移位位数大于等于操作数位数时，高位截断。例如，对 [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) 类型的数进行移位，当 y (移位位数)超大于等于 8时，仅取 y 的低 3 位作为移位位数，以此保证移位位数在 0 到 7 之间。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- T - 右移运算结果。

### func wrappingSub(T)

```cangjie
func wrappingSub(y: T): T
```

功能：使用高位截断策略的减法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: T - 减数。

返回值：

- T - 减法运算结果。

### extend Int16 <: WrappingOp\<Int16>

```cangjie
extend Int16 <: WrappingOp<Int16>
```

功能：为 [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) 实现 [WrappingOp](#interface-wrappingopt) 接口。

父类型：

- [WrappingOp](#interface-wrappingopt)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)>

#### func wrappingAdd(Int16)

```cangjie
public func wrappingAdd(y: Int16): Int16
```

功能：使用高位截断策略的加法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 加数。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int16值，使它们相加会发生溢出
    let a1 = 32767i16  // Int16的最大值
    let b1 = 1i16
    
    let result1 = a1.wrappingAdd(b1)
    println("Overflow case - Wrapping add result: ${result1}")
    
    // 创建两个Int16值，使它们相加不会发生溢出
    let a2 = 10000i16
    let b2 = 20000i16
    
    let result2 = a2.wrappingAdd(b2)
    println("Normal case - Wrapping add result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping add result: -32768
Normal case - Wrapping add result: 30000
```

#### func wrappingDec()

```cangjie
public func wrappingDec(): Int16
```

功能：使用高位截断策略的自减运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int16值，使其自减会发生下溢
    let a1 = -32768i16  // Int16的最小值
    
    let result1 = a1.wrappingDec()
    println("Underflow case - Wrapping dec result: ${result1}")
    
    // 创建一个Int16值，使其自减不会发生溢出
    let a2 = 1000i16
    
    let result2 = a2.wrappingDec()
    println("Normal case - Wrapping dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Wrapping dec result: 32767
Normal case - Wrapping dec result: 999
```

#### func wrappingDiv(Int16)

```cangjie
public func wrappingDiv(y: Int16): Int16
```

功能：使用高位截断策略的除法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 除数。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int16值，使除法运算会发生溢出
    let a1 = -32768i16  // Int16的最小值
    let b1 = -1i16
    
    let result1 = a1.wrappingDiv(b1)
    println("Overflow case - Wrapping div result: ${result1}")
    
    // 创建两个Int16值，使除法运算不会发生溢出
    let a2 = 10000i16
    let b2 = 10i16
    
    let result2 = a2.wrappingDiv(b2)
    println("Normal case - Wrapping div result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping div result: -32768
Normal case - Wrapping div result: 1000
```

#### func wrappingInc()

```cangjie
public func wrappingInc(): Int16
```

功能：使用高位截断策略的自增运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int16值，使其自增会发生上溢
    let a1 = 32767i16  // Int16的最大值
    
    let result1 = a1.wrappingInc()
    println("Overflow case - Wrapping inc result: ${result1}")
    
    // 创建一个Int16值，使其自增不会发生溢出
    let a2 = 1000i16
    
    let result2 = a2.wrappingInc()
    println("Normal case - Wrapping inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping inc result: -32768
Normal case - Wrapping inc result: 1001
```

#### func wrappingMod(Int16)

```cangjie
public func wrappingMod(y: Int16): Int16
```

功能：使用高位截断策略的取余运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 除数。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int16值进行取余运算
    let a1 = 1000i16
    let b1 = 3i16
    
    let result1 = a1.wrappingMod(b1)
    println("Normal case - Wrapping mod result: ${result1}")
    
    return 0
}
```

运行结果：

```text
Normal case - Wrapping mod result: 1
```

#### func wrappingMul(Int16)

```cangjie
public func wrappingMul(y: Int16): Int16
```

功能：使用高位截断策略的乘法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 乘数。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int16值，使乘法运算会发生溢出
    let a1 = 20000i16
    let b1 = 20000i16
    
    let result1 = a1.wrappingMul(b1)
    println("Overflow case - Wrapping mul result: ${result1}")
    
    // 创建两个Int16值，使乘法运算不会发生溢出
    let a2 = 100i16
    let b2 = 200i16
    
    let result2 = a2.wrappingMul(b2)
    println("Normal case - Wrapping mul result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping mul result: -31744
Normal case - Wrapping mul result: 20000
```

#### func wrappingNeg()

```cangjie
public func wrappingNeg(): Int16
```

功能：使用高位截断策略的负号运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int16值，使其负号运算会发生溢出
    let a1 = -32768i16  // Int16的最小值
    
    let result1 = a1.wrappingNeg()
    println("Overflow case - Wrapping neg result: ${result1}")
    
    // 创建一个Int16值，使其负号运算不会发生溢出
    let a2 = 1000i16
    
    let result2 = a2.wrappingNeg()
    println("Normal case - Wrapping neg result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping neg result: -32768
Normal case - Wrapping neg result: -1000
```

#### func wrappingShl(UInt64)

```cangjie
public func wrappingShl(y: UInt64): Int16
```

功能：使用高位截断策略的左移运算。

当右操作数大于等于左操作数位数时，取右操作数的低 4 位作为移位位数。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int16值和移位位数，使左移运算会发生截断
    let a1 = 1000i16
    let b1 = 20u64  // 大于16的移位位数会被截断
    
    let result1 = a1.wrappingShl(b1)
    println("Truncation case - Wrapping shl result: ${result1}")
    
    // 创建一个Int16值和移位位数，使左移运算不会发生截断
    let a2 = 1000i16
    let b2 = 3u64
    
    let result2 = a2.wrappingShl(b2)
    println("Normal case - Wrapping shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Truncation case - Wrapping shl result: 16000
Normal case - Wrapping shl result: 8000
```

#### func wrappingShr(UInt64)

```cangjie
public func wrappingShr(y: UInt64): Int16
```

功能：使用高位截断策略的右移运算。

当右操作数大于等于左操作数位数时，取右操作数的低 4 位作为移位位数。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int16值和移位位数，使右移运算会发生截断
    let a1 = 1000i16
    let b1 = 20u64  // 大于16的移位位数会被截断
    
    let result1 = a1.wrappingShr(b1)
    println("Truncation case - Wrapping shr result: ${result1}")
    
    // 创建一个Int16值和移位位数，使右移运算不会发生截断
    let a2 = 1000i16
    let b2 = 3u64
    
    let result2 = a2.wrappingShr(b2)
    println("Normal case - Wrapping shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Truncation case - Wrapping shr result: 62
Normal case - Wrapping shr result: 125
```

#### func wrappingSub(Int16)

```cangjie
public func wrappingSub(y: Int16): Int16
```

功能：使用高位截断策略的减法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 减数。

返回值：

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int16值，使减法运算会发生溢出
    let a1 = -32768i16  // Int16的最小值
    let b1 = 1i16
    
    let result1 = a1.wrappingSub(b1)
    println("Overflow case - Wrapping sub result: ${result1}")
    
    // 创建两个Int16值，使减法运算不会发生溢出
    let a2 = 1000i16
    let b2 = 500i16
    
    let result2 = a2.wrappingSub(b2)
    println("Normal case - Wrapping sub result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping sub result: 32767
Normal case - Wrapping sub result: 500
```

### extend Int32 <: WrappingOp\<Int32>

```cangjie
extend Int32 <: WrappingOp<Int32>
```

功能：为 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 实现 [WrappingOp](#interface-wrappingopt) 接口。

父类型：

- [WrappingOp](#interface-wrappingopt)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)>

#### func wrappingAdd(Int32)

```cangjie
public func wrappingAdd(y: Int32): Int32
```

功能：使用高位截断策略的加法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 加数。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int32值，使它们相加会发生溢出
    let a1 = 2147483647i32  // Int32的最大值
    let b1 = 1i32
    
    let result1 = a1.wrappingAdd(b1)
    println("Overflow case - Wrapping add result: ${result1}")
    
    // 创建两个Int32值，使它们相加不会发生溢出
    let a2 = 1000000000i32
    let b2 = 2000000000i32
    
    let result2 = a2.wrappingAdd(b2)
    println("Normal case - Wrapping add result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping add result: -2147483648
Normal case - Wrapping add result: -1294967296
```

#### func wrappingDec()

```cangjie
public func wrappingDec(): Int32
```

功能：使用高位截断策略的自减运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int32值，使其自减会发生下溢
    let a1 = -2147483648i32  // Int32的最小值
    
    let result1 = a1.wrappingDec()
    println("Underflow case - Wrapping dec result: ${result1}")
    
    // 创建一个Int32值，使其自减不会发生溢出
    let a2 = 1000i32
    
    let result2 = a2.wrappingDec()
    println("Normal case - Wrapping dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Wrapping dec result: 2147483647
Normal case - Wrapping dec result: 999
```

#### func wrappingDiv(Int32)

```cangjie
public func wrappingDiv(y: Int32): Int32
```

功能：使用高位截断策略的除法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 除数。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int32值，使除法运算会发生溢出
    let a1 = -2147483648i32  // Int32的最小值
    let b1 = -1i32
    
    let result1 = a1.wrappingDiv(b1)
    println("Overflow case - Wrapping div result: ${result1}")
    
    // 创建两个Int32值，使除法运算不会发生溢出
    let a2 = 1000000000i32
    let b2 = 10i32
    
    let result2 = a2.wrappingDiv(b2)
    println("Normal case - Wrapping div result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping div result: -2147483648
Normal case - Wrapping div result: 100000000
```

#### func wrappingInc()

```cangjie
public func wrappingInc(): Int32
```

功能：使用高位截断策略的自增运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int32值，使其自增会发生上溢
    let a1 = 2147483647i32  // Int32的最大值
    
    let result1 = a1.wrappingInc()
    println("Overflow case - Wrapping inc result: ${result1}")
    
    // 创建一个Int32值，使其自增不会发生溢出
    let a2 = 1000i32
    
    let result2 = a2.wrappingInc()
    println("Normal case - Wrapping inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping inc result: -2147483648
Normal case - Wrapping inc result: 1001
```

#### func wrappingMod(Int32)

```cangjie
public func wrappingMod(y: Int32): Int32
```

功能：使用高位截断策略的取余运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 除数。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int32值进行取余运算
    let a1 = 1000000i32
    let b1 = 3i32
    
    let result1 = a1.wrappingMod(b1)
    println("Wrapping mod result: ${result1}")
    
    return 0
}
```

运行结果：

```text
Wrapping mod result: 1
```

#### func wrappingMul(Int32)

```cangjie
public func wrappingMul(y: Int32): Int32
```

功能：使用高位截断策略的乘法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 乘数。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int32值，使乘法运算会发生溢出
    let a1 = 1000000i32
    let b1 = 1000000i32
    
    let result1 = a1.wrappingMul(b1)
    println("Overflow case - Wrapping mul result: ${result1}")
    
    // 创建两个Int32值，使乘法运算不会发生溢出
    let a2 = 100i32
    let b2 = 200i32
    
    let result2 = a2.wrappingMul(b2)
    println("Normal case - Wrapping mul result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping mul result: -727379968
Normal case - Wrapping mul result: 20000
```

#### func wrappingNeg()

```cangjie
public func wrappingNeg(): Int32
```

功能：使用高位截断策略的负号运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int32值，使其负号运算会发生溢出
    let a1 = -2147483648i32  // Int32的最小值
    
    let result1 = a1.wrappingNeg()
    println("Overflow case - Wrapping neg result: ${result1}")
    
    // 创建一个Int32值，使其负号运算不会发生溢出
    let a2 = 1000i32
    
    let result2 = a2.wrappingNeg()
    println("Normal case - Wrapping neg result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping neg result: -2147483648
Normal case - Wrapping neg result: -1000
```

#### func wrappingShl(UInt64)

```cangjie
public func wrappingShl(y: UInt64): Int32
```

功能：使用高位截断策略的左移运算。

当右操作数大于等于左操作数位数时，取右操作数的低 5 位作为移位位数。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int32值和移位位数，使左移运算会发生截断
    let a1 = 1000000i32
    let b1 = 35u64  // 大于32的移位位数会被截断
    
    let result1 = a1.wrappingShl(b1)
    println("Truncation case - Wrapping shl result: ${result1}")
    
    // 创建一个Int32值和移位位数，使左移运算不会发生截断
    let a2 = 1000000i32
    let b2 = 3u64
    
    let result2 = a2.wrappingShl(b2)
    println("Normal case - Wrapping shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Truncation case - Wrapping shl result: 8000000
Normal case - Wrapping shl result: 8000000
```

#### func wrappingShr(UInt64)

```cangjie
public func wrappingShr(y: UInt64): Int32
```

功能：使用高位截断策略的右移运算。

当右操作数大于等于左操作数位数时，取右操作数的低 5 位作为移位位数。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int32值和移位位数，使右移运算会发生截断
    let a1 = 1000000i32
    let b1 = 35u64  // 大于32的移位位数会被截断
    
    let result1 = a1.wrappingShr(b1)
    println("Truncation case - Wrapping shr result: ${result1}")
    
    // 创建一个Int32值和移位位数，使右移运算不会发生截断
    let a2 = 1000000i32
    let b2 = 3u64
    
    let result2 = a2.wrappingShr(b2)
    println("Normal case - Wrapping shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Truncation case - Wrapping shr result: 125000
Normal case - Wrapping shr result: 125000
```

#### func wrappingSub(Int32)

```cangjie
public func wrappingSub(y: Int32): Int32
```

功能：使用高位截断策略的减法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 减数。

返回值：

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int32值，使减法运算会发生溢出
    let a1 = -2147483648i32  // Int32的最小值
    let b1 = 1i32
    
    let result1 = a1.wrappingSub(b1)
    println("Overflow case - Wrapping sub result: ${result1}")
    
    // 创建两个Int32值，使减法运算不会发生溢出
    let a2 = 1000i32
    let b2 = 500i32
    
    let result2 = a2.wrappingSub(b2)
    println("Normal case - Wrapping sub result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping sub result: 2147483647
Normal case - Wrapping sub result: 500
```

### extend Int64 <: WrappingOp\<Int64> & WrappingPow

```cangjie
extend Int64 <: WrappingOp<Int64> & WrappingPow
```

功能：为 [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) 实现 [WrappingOp](#interface-wrappingopt) 和 [WrappingPow](#interface-wrappingpow) 接口。

父类型：

- [WrappingOp](#interface-wrappingopt)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>
- [WrappingPow](#interface-wrappingpow)

#### func wrappingAdd(Int64)

```cangjie
public func wrappingAdd(y: Int64): Int64
```

功能：使用高位截断策略的加法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 加数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int64值，使它们相加会发生溢出
    let a1 = 9223372036854775807i64  // Int64的最大值
    let b1 = 1i64
    
    let result1 = a1.wrappingAdd(b1)
    println("Overflow case - Wrapping add result: ${result1}")
    
    // 创建两个Int64值，使它们相加不会发生溢出
    let a2 = 1000000000000000000i64
    let b2 = 2000000000000000000i64
    
    let result2 = a2.wrappingAdd(b2)
    println("Normal case - Wrapping add result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping add result: -9223372036854775808
Normal case - Wrapping add result: 3000000000000000000
```

#### func wrappingDec()

```cangjie
public func wrappingDec(): Int64
```

功能：使用高位截断策略的自减运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值，使其自减会发生下溢
    let a1 = -9223372036854775808i64  // Int64的最小值
    
    let result1 = a1.wrappingDec()
    println("Underflow case - Wrapping dec result: ${result1}")
    
    // 创建一个Int64值，使其自减不会发生溢出
    let a2 = 1000i64
    
    let result2 = a2.wrappingDec()
    println("Normal case - Wrapping dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Wrapping dec result: 9223372036854775807
Normal case - Wrapping dec result: 999
```

#### func wrappingDiv(Int64)

```cangjie
public func wrappingDiv(y: Int64): Int64
```

功能：使用高位截断策略的除法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 除数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int64值，使除法运算会发生溢出
    let a1 = -9223372036854775808i64  // Int64的最小值
    let b1 = -1i64
    
    let result1 = a1.wrappingDiv(b1)
    println("Overflow case - Wrapping div result: ${result1}")
    
    // 创建两个Int64值，使除法运算不会发生溢出
    let a2 = 1000000000000000000i64
    let b2 = 10i64
    
    let result2 = a2.wrappingDiv(b2)
    println("Normal case - Wrapping div result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping div result: -9223372036854775808
Normal case - Wrapping div result: 100000000000000000
```

#### func wrappingInc()

```cangjie
public func wrappingInc(): Int64
```

功能：使用高位截断策略的自增运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值，使其自增会发生上溢
    let a1 = 9223372036854775807i64  // Int64的最大值
    
    let result1 = a1.wrappingInc()
    println("Overflow case - Wrapping inc result: ${result1}")
    
    // 创建一个Int64值，使其自增不会发生溢出
    let a2 = 1000i64
    
    let result2 = a2.wrappingInc()
    println("Normal case - Wrapping inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping inc result: -9223372036854775808
Normal case - Wrapping inc result: 1001
```

#### func wrappingMod(Int64)

```cangjie
public func wrappingMod(y: Int64): Int64
```

功能：使用高位截断策略的取余运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 除数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int64值进行取余运算
    let a1 = 1000000000000000000i64
    let b1 = 3i64
    
    let result1 = a1.wrappingMod(b1)
    println("Wrapping mod result: ${result1}")
    
    // 创建另一个普通情况
    let a2 = 9000000000000000000i64
    let b2 = 7i64
    
    let result2 = a2.wrappingMod(b2)
    println("Wrapping mod result 2: ${result2}")
    
    return 0
}
```

运行结果：

```text
Wrapping mod result: 1
Wrapping mod result 2: 2
```

#### func wrappingMul(Int64)

```cangjie
public func wrappingMul(y: Int64): Int64
```

功能：使用高位截断策略的乘法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 乘数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int64值，使乘法运算会发生溢出
    let a1 = 1000000000000000000i64
    let b1 = 1000000000000000000i64
    
    let result1 = a1.wrappingMul(b1)
    println("Overflow case - Wrapping mul result: ${result1}")
    
    // 创建两个Int64值，使乘法运算不会发生溢出
    let a2 = 100i64
    let b2 = 200i64
    
    let result2 = a2.wrappingMul(b2)
    println("Normal case - Wrapping mul result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping mul result: -5527149226598858752
Normal case - Wrapping mul result: 20000
```

#### func wrappingNeg()

```cangjie
public func wrappingNeg(): Int64
```

功能：使用高位截断策略的负号运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值，使其负号运算会发生溢出
    let a1 = -9223372036854775808i64  // Int64的最小值
    
    let result1 = a1.wrappingNeg()
    println("Overflow case - Wrapping neg result: ${result1}")
    
    // 创建一个Int64值，使其负号运算不会发生溢出
    let a2 = 1000i64
    
    let result2 = a2.wrappingNeg()
    println("Normal case - Wrapping neg result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping neg result: -9223372036854775808
Normal case - Wrapping neg result: -1000
```

#### func wrappingPow(UInt64)

```cangjie
public func wrappingPow(y: UInt64): Int64
```

功能：使用高位截断策略的幂运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 指数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 幂运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值和指数，使幂运算会发生溢出
    let a1 = 1000000000000000000i64
    let b1 = 10u64
    
    let result1 = a1.wrappingPow(b1)
    println("Overflow case - Wrapping pow result: ${result1}")
    
    // 创建一个Int64值和指数，使幂运算不会发生溢出
    let a2 = 10i64
    let b2 = 3u64
    
    let result2 = a2.wrappingPow(b2)
    println("Normal case - Wrapping pow result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping pow result: 0
Normal case - Wrapping pow result: 1000
```

#### func wrappingShl(UInt64)

```cangjie
public func wrappingShl(y: UInt64): Int64
```

功能：使用高位截断策略的左移运算。

当右操作数大于等于左操作数位数时，取右操作数的低 6 位作为移位位数。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值和移位位数，使左移运算会发生截断
    let a1 = 1000000000000000000i64
    let b1 = 65u64  // 大于64的移位位数会被截断
    
    let result1 = a1.wrappingShl(b1)
    println("Truncation case - Wrapping shl result: ${result1}")
    
    // 创建一个Int64值和移位位数，使左移运算不会发生截断
    let a2 = 1000000000000000000i64
    let b2 = 3u64
    
    let result2 = a2.wrappingShl(b2)
    println("Normal case - Wrapping shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Truncation case - Wrapping shl result: 2000000000000000000
Normal case - Wrapping shl result: 8000000000000000000
```

#### func wrappingShr(UInt64)

```cangjie
public func wrappingShr(y: UInt64): Int64
```

功能：使用高位截断策略的右移运算。

当右操作数大于等于左操作数位数时，取右操作数的低 6 位作为移位位数。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int64值和移位位数，使右移运算会发生截断
    let a1 = 1000000000000000000i64
    let b1 = 65u64  // 大于64的移位位数会被截断
    
    let result1 = a1.wrappingShr(b1)
    println("Truncation case - Wrapping shr result: ${result1}")
    
    // 创建一个Int64值和移位位数，使右移运算不会发生截断
    let a2 = 1000000000000000000i64
    let b2 = 3u64
    
    let result2 = a2.wrappingShr(b2)
    println("Normal case - Wrapping shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Truncation case - Wrapping shr result: 500000000000000000
Normal case - Wrapping shr result: 125000000000000000
```

#### func wrappingSub(Int64)

```cangjie
public func wrappingSub(y: Int64): Int64
```

功能：使用高位截断策略的减法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 减数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int64值，使减法运算会发生溢出
    let a1 = -9223372036854775808i64  // Int64的最小值
    let b1 = 1i64
    
    let result1 = a1.wrappingSub(b1)
    println("Overflow case - Wrapping sub result: ${result1}")
    
    // 创建两个Int64值，使减法运算不会发生溢出
    let a2 = 1000i64
    let b2 = 500i64
    
    let result2 = a2.wrappingSub(b2)
    println("Normal case - Wrapping sub result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping sub result: 9223372036854775807
Normal case - Wrapping sub result: 500
```

### extend Int8 <: WrappingOp\<Int8>

```cangjie
extend Int8 <: WrappingOp<Int8>
```

功能：为 [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) 实现 [WrappingOp](#interface-wrappingopt) 接口。

父类型：

- [WrappingOp](#interface-wrappingopt)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)>

#### func wrappingAdd(Int8)

```cangjie
public func wrappingAdd(y: Int8): Int8
```

功能：使用高位截断策略的加法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 加数。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int8值，使它们相加会发生溢出
    let a1 = 127i8  // Int8的最大值
    let b1 = 1i8
    
    let result1 = a1.wrappingAdd(b1)
    println("Overflow case - Wrapping add result: ${result1}")
    
    // 创建两个Int8值，使它们相加不会发生溢出
    let a2 = 50i8
    let b2 = 60i8
    
    let result2 = a2.wrappingAdd(b2)
    println("Normal case - Wrapping add result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping add result: -128
Normal case - Wrapping add result: 110
```

#### func wrappingDec()

```cangjie
public func wrappingDec(): Int8
```

功能：使用高位截断策略的自减运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int8值，使其自减会发生下溢
    let a1 = -128i8  // Int8的最小值
    
    let result1 = a1.wrappingDec()
    println("Underflow case - Wrapping dec result: ${result1}")
    
    // 创建一个Int8值，使其自减不会发生溢出
    let a2 = 100i8
    
    let result2 = a2.wrappingDec()
    println("Normal case - Wrapping dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Wrapping dec result: 127
Normal case - Wrapping dec result: 99
```

#### func wrappingDiv(Int8)

```cangjie
public func wrappingDiv(y: Int8): Int8
```

功能：使用高位截断策略的除法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 除数。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int8值，使除法运算会发生溢出
    let a1 = -128i8  // Int8的最小值
    let b1 = -1i8
    
    let result1 = a1.wrappingDiv(b1)
    println("Overflow case - Wrapping div result: ${result1}")
    
    // 创建两个Int8值，使除法运算不会发生溢出
    let a2 = 100i8
    let b2 = 10i8
    
    let result2 = a2.wrappingDiv(b2)
    println("Normal case - Wrapping div result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping div result: -128
Normal case - Wrapping div result: 10
```

#### func wrappingInc()

```cangjie
public func wrappingInc(): Int8
```

功能：使用高位截断策略的自增运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int8值，使其自增会发生上溢
    let a1 = 127i8  // Int8的最大值
    
    let result1 = a1.wrappingInc()
    println("Overflow case - Wrapping inc result: ${result1}")
    
    // 创建一个Int8值，使其自增不会发生溢出
    let a2 = 100i8
    
    let result2 = a2.wrappingInc()
    println("Normal case - Wrapping inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping inc result: -128
Normal case - Wrapping inc result: 101
```

#### func wrappingMod(Int8)

```cangjie
public func wrappingMod(y: Int8): Int8
```

功能：使用高位截断策略的取余运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 除数。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int8值进行取余运算
    let a1 = 100i8
    let b1 = 3i8
    
    let result1 = a1.wrappingMod(b1)
    println("Wrapping mod result: ${result1}")
    
    // 创建另一个普通情况
    let a2 = 120i8
    let b2 = 7i8
    
    let result2 = a2.wrappingMod(b2)
    println("Wrapping mod result 2: ${result2}")
    
    return 0
}
```

运行结果：

```text
Wrapping mod result: 1
Wrapping mod result 2: 1
```

#### func wrappingMul(Int8)

```cangjie
public func wrappingMul(y: Int8): Int8
```

功能：使用高位截断策略的乘法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 乘数。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int8值，使乘法运算会发生溢出
    let a1 = 50i8
    let b1 = 50i8
    
    let result1 = a1.wrappingMul(b1)
    println("Overflow case - Wrapping mul result: ${result1}")
    
    // 创建两个Int8值，使乘法运算不会发生溢出
    let a2 = 10i8
    let b2 = 20i8
    
    let result2 = a2.wrappingMul(b2)
    println("Normal case - Wrapping mul result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping mul result: -60
Normal case - Wrapping mul result: -56
```

#### func wrappingNeg()

```cangjie
public func wrappingNeg(): Int8
```

功能：使用高位截断策略的负号运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int8值，使其负号运算会发生溢出
    let a1 = -128i8  // Int8的最小值
    
    let result1 = a1.wrappingNeg()
    println("Overflow case - Wrapping neg result: ${result1}")
    
    // 创建一个Int8值，使其负号运算不会发生溢出
    let a2 = 100i8
    
    let result2 = a2.wrappingNeg()
    println("Normal case - Wrapping neg result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping neg result: -128
Normal case - Wrapping neg result: -100
```

#### func wrappingShl(UInt64)

```cangjie
public func wrappingShl(y: UInt64): Int8
```

功能：使用高位截断策略的左移运算。

当右操作数大于等于左操作数位数时，取右操作数的低 3 位作为移位位数。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int8值和移位位数，使左移运算会发生截断
    let a1 = 100i8
    let b1 = 10u64  // 大于8的移位位数会被截断
    
    let result1 = a1.wrappingShl(b1)
    println("Truncation case - Wrapping shl result: ${result1}")
    
    // 创建一个Int8值和移位位数，使左移运算不会发生截断
    let a2 = 100i8
    let b2 = 3u64
    
    let result2 = a2.wrappingShl(b2)
    println("Normal case - Wrapping shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Truncation case - Wrapping shl result: -112
Normal case - Wrapping shl result: 32
```

#### func wrappingShr(UInt64)

```cangjie
public func wrappingShr(y: UInt64): Int8
```

功能：使用高位截断策略的右移运算。

当右操作数大于等于左操作数位数时，取右操作数的低 3 位作为移位位数。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个Int8值和移位位数，使右移运算会发生截断
    let a1 = 100i8
    let b1 = 10u64  // 大于8的移位位数会被截断
    
    let result1 = a1.wrappingShr(b1)
    println("Truncation case - Wrapping shr result: ${result1}")
    
    // 创建一个Int8值和移位位数，使右移运算不会发生截断
    let a2 = 100i8
    let b2 = 3u64
    
    let result2 = a2.wrappingShr(b2)
    println("Normal case - Wrapping shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Truncation case - Wrapping shr result: 25
Normal case - Wrapping shr result: 12
```

#### func wrappingSub(Int8)

```cangjie
public func wrappingSub(y: Int8): Int8
```

功能：使用高位截断策略的减法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 减数。

返回值：

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个Int8值，使减法运算会发生溢出
    let a1 = -128i8  // Int8的最小值
    let b1 = 1i8
    
    let result1 = a1.wrappingSub(b1)
    println("Overflow case - Wrapping sub result: ${result1}")
    
    // 创建两个Int8值，使减法运算不会发生溢出
    let a2 = 100i8
    let b2 = 50i8
    
    let result2 = a2.wrappingSub(b2)
    println("Normal case - Wrapping sub result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping sub result: 127
Normal case - Wrapping sub result: 50
```

### extend IntNative <: WrappingOp\<IntNative>

```cangjie
extend IntNative <: WrappingOp<IntNative>
```

功能：为 [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) 实现 [WrappingOp](#interface-wrappingopt) 接口。

父类型：

- [WrappingOp](#interface-wrappingopt)\<[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)>

#### func wrappingAdd(IntNative)

```cangjie
public func wrappingAdd(y: IntNative): IntNative
```

功能：使用高位截断策略的加法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 加数。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): IntNative {
    // 创建两个IntNative值，使它们相加会发生溢出
    let a1: IntNative = 9223372036854775807  // IntNative的最大值
    let b1: IntNative = 1
    
    let result1 = a1.wrappingAdd(b1)
    println("Overflow case - Wrapping add result: ${result1}")
    
    // 创建两个IntNative值，使它们相加不会发生溢出
    let a2: IntNative = 1000000000000000000
    let b2: IntNative = 2000000000000000000
    
    let result2 = a2.wrappingAdd(b2)
    println("Normal case - Wrapping add result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping add result: -9223372036854775808
Normal case - Wrapping add result: 3000000000000000000
```

#### func wrappingDec()

```cangjie
public func wrappingDec(): IntNative
```

功能：使用高位截断策略的自减运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): IntNative {
    // 创建一个IntNative值，使其自减会发生下溢
    let a1: IntNative = -9223372036854775808  // IntNative的最小值
    
    let result1 = a1.wrappingDec()
    println("Underflow case - Wrapping dec result: ${result1}")
    
    // 创建一个IntNative值，使其自减不会发生溢出
    let a2: IntNative = 1000
    
    let result2 = a2.wrappingDec()
    println("Normal case - Wrapping dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Wrapping dec result: 9223372036854775807
Normal case - Wrapping dec result: 999
```

#### func wrappingDiv(IntNative)

```cangjie
public func wrappingDiv(y: IntNative): IntNative
```

功能：使用高位截断策略的除法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 除数。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): IntNative {
    // 创建两个IntNative值，使除法运算会发生溢出
    let a1: IntNative = -9223372036854775808  // IntNative的最小值
    let b1: IntNative = -1
    
    let result1 = a1.wrappingDiv(b1)
    println("Overflow case - Wrapping div result: ${result1}")
    
    // 创建两个IntNative值，使除法运算不会发生溢出
    let a2: IntNative = 1000000000000000000
    let b2: IntNative = 10
    
    let result2 = a2.wrappingDiv(b2)
    println("Normal case - Wrapping div result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping div result: -9223372036854775808
Normal case - Wrapping div result: 100000000000000000
```

#### func wrappingInc()

```cangjie
public func wrappingInc(): IntNative
```

功能：使用高位截断策略的自增运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): IntNative {
    // 创建一个IntNative值，使其自增会发生上溢
    let a1: IntNative = 9223372036854775807  // IntNative的最大值
    
    let result1 = a1.wrappingInc()
    println("Overflow case - Wrapping inc result: ${result1}")
    
    // 创建一个IntNative值，使其自增不会发生溢出
    let a2: IntNative = 1000
    
    let result2 = a2.wrappingInc()
    println("Normal case - Wrapping inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping inc result: -9223372036854775808
Normal case - Wrapping inc result: 1001
```

#### func wrappingMod(IntNative)

```cangjie
public func wrappingMod(y: IntNative): IntNative
```

功能：使用高位截断策略的取余运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 除数。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): IntNative {
    // 创建两个IntNative值进行取余运算
    let a1: IntNative = 1000000000000000000
    let b1: IntNative = 3
    
    let result1 = a1.wrappingMod(b1)
    println("Wrapping mod result: ${result1}")
    
    // 创建另一个普通情况
    let a2: IntNative = 9000000000000000000
    let b2: IntNative = 7
    
    let result2 = a2.wrappingMod(b2)
    println("Wrapping mod result 2: ${result2}")
    
    return 0
}
```

运行结果：

```text
Wrapping mod result: 1
Wrapping mod result 2: 2
```

#### func wrappingMul(IntNative)

```cangjie
public func wrappingMul(y: IntNative): IntNative
```

功能：使用高位截断策略的乘法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 乘数。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): IntNative {
    // 创建两个IntNative值，使乘法运算会发生溢出
    let a1: IntNative = 1000000000000000000
    let b1: IntNative = 1000000000000000000
    
    let result1 = a1.wrappingMul(b1)
    println("Overflow case - Wrapping mul result: ${result1}")
    
    // 创建两个IntNative值，使乘法运算不会发生溢出
    let a2: IntNative = 100
    let b2: IntNative = 200
    
    let result2 = a2.wrappingMul(b2)
    println("Normal case - Wrapping mul result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping mul result: -5527149226598858752
Normal case - Wrapping mul result: 20000
```

#### func wrappingNeg()

```cangjie
public func wrappingNeg(): IntNative
```

功能：使用高位截断策略的负号运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): IntNative {
    // 创建一个IntNative值，使其负号运算会发生溢出
    let a1: IntNative = -9223372036854775808  // IntNative的最小值
    
    let result1 = a1.wrappingNeg()
    println("Overflow case - Wrapping neg result: ${result1}")
    
    // 创建一个IntNative值，使其负号运算不会发生溢出
    let a2: IntNative = 1000
    
    let result2 = a2.wrappingNeg()
    println("Normal case - Wrapping neg result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping neg result: -9223372036854775808
Normal case - Wrapping neg result: -1000
```

#### func wrappingShl(UInt64)

```cangjie
public func wrappingShl(y: UInt64): IntNative
```

功能：使用高位截断策略的左移运算。

当右操作数大于等于左操作数位数时，取右操作数的低位作为移位位数，具体取的位数取决于当前系统下 [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) 的位数。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): IntNative {
    // 创建一个IntNative值和移位位数，使左移运算会发生截断
    let a1: IntNative = 1000000000000000000
    let b1 = 65u64  // 大于64的移位位数会被截断
    
    let result1 = a1.wrappingShl(b1)
    println("Truncation case - Wrapping shl result: ${result1}")
    
    // 创建一个IntNative值和移位位数，使左移运算不会发生截断
    let a2: IntNative = 1000000000000000000
    let b2 = 3u64
    
    let result2 = a2.wrappingShl(b2)
    println("Normal case - Wrapping shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Truncation case - Wrapping shl result: 2000000000000000000
Normal case - Wrapping shl result: 8000000000000000000
```

#### func wrappingShr(UInt64)

```cangjie
public func wrappingShr(y: UInt64): IntNative
```

功能：使用高位截断策略的右移运算。

当右操作数大于等于左操作数位数时，取右操作数的低位作为移位位数，具体取的位数取决于当前系统下 [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) 的位数。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): IntNative {
    // 创建一个IntNative值和移位位数，使右移运算会发生截断
    let a1: IntNative = 1000000000000000000
    let b1 = 65u64  // 大于64的移位位数会被截断
    
    let result1 = a1.wrappingShr(b1)
    println("Truncation case - Wrapping shr result: ${result1}")
    
    // 创建一个IntNative值和移位位数，使右移运算不会发生截断
    let a2: IntNative = 1000000000000000000
    let b2 = 3u64
    
    let result2 = a2.wrappingShr(b2)
    println("Normal case - Wrapping shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Truncation case - Wrapping shr result: 500000000000000000
Normal case - Wrapping shr result: 125000000000000000
```

#### func wrappingSub(IntNative)

```cangjie
public func wrappingSub(y: IntNative): IntNative
```

功能：使用高位截断策略的减法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 减数。

返回值：

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): IntNative {
    // 创建两个IntNative值，使减法运算会发生溢出
    let a1: IntNative = -9223372036854775808  // IntNative的最小值
    let b1: IntNative = 1
    
    let result1 = a1.wrappingSub(b1)
    println("Overflow case - Wrapping sub result: ${result1}")
    
    // 创建两个IntNative值，使减法运算不会发生溢出
    let a2: IntNative = 1000
    let b2: IntNative = 500
    
    let result2 = a2.wrappingSub(b2)
    println("Normal case - Wrapping sub result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping sub result: 9223372036854775807
Normal case - Wrapping sub result: 500
```

### extend UInt16 <: WrappingOp\<UInt16>

```cangjie
extend UInt16 <: WrappingOp<UInt16>
```

功能：为 [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) 实现 [WrappingOp](#interface-wrappingopt) 接口。

父类型：

- [WrappingOp](#interface-wrappingopt)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)>

#### func wrappingAdd(UInt16)

```cangjie
public func wrappingAdd(y: UInt16): UInt16
```

功能：使用高位截断策略的加法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 加数。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt16值，使它们相加会发生溢出
    let a1 = 65535u16  // UInt16的最大值
    let b1 = 1u16
    
    let result1 = a1.wrappingAdd(b1)
    println("Overflow case - Wrapping add result: ${result1}")
    
    // 创建两个UInt16值，使它们相加不会发生溢出
    let a2 = 50000u16
    let b2 = 10000u16
    
    let result2 = a2.wrappingAdd(b2)
    println("Normal case - Wrapping add result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping add result: 0
Normal case - Wrapping add result: 60000
```

#### func wrappingDec()

```cangjie
public func wrappingDec(): UInt16
```

功能：使用高位截断策略的自减运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt16值，使其自减会发生下溢
    let a1 = 0u16  // UInt16的最小值
    
    let result1 = a1.wrappingDec()
    println("Underflow case - Wrapping dec result: ${result1}")
    
    // 创建一个UInt16值，使其自减不会发生溢出
    let a2 = 100u16
    
    let result2 = a2.wrappingDec()
    println("Normal case - Wrapping dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Wrapping dec result: 65535
Normal case - Wrapping dec result: 99
```

#### func wrappingDiv(UInt16)

```cangjie
public func wrappingDiv(y: UInt16): UInt16
```

功能：使用高位截断策略的除法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 除数。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 对于UInt16的除法运算，通常不会发生溢出，所以只提供正常情况的示例
    let a1 = 10000u16
    let b1 = 10u16
    
    let result1 = a1.wrappingDiv(b1)
    println("Normal case - Wrapping div result: ${result1}")
    
    return 0
}
```

运行结果：

```text
Normal case - Wrapping div result: 1000
```

#### func wrappingInc()

```cangjie
public func wrappingInc(): UInt16
```

功能：使用高位截断策略的自增运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt16值，使其自增会发生上溢
    let a1 = 65535u16  // UInt16的最大值
    
    let result1 = a1.wrappingInc()
    println("Overflow case - Wrapping inc result: ${result1}")
    
    // 创建一个UInt16值，使其自增不会发生溢出
    let a2 = 100u16
    
    let result2 = a2.wrappingInc()
    println("Normal case - Wrapping inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping inc result: 0
Normal case - Wrapping inc result: 101
```

#### func wrappingMod(UInt16)

```cangjie
public func wrappingMod(y: UInt16): UInt16
```

功能：使用高位截断策略的取余运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 除数。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt16值进行取余运算
    let a1 = 10000u16
    let b1 = 3u16
    
    let result1 = a1.wrappingMod(b1)
    println("Wrapping mod result: ${result1}")
    
    return 0
}
```

运行结果：

```text
Wrapping mod result: 1
```

#### func wrappingMul(UInt16)

```cangjie
public func wrappingMul(y: UInt16): UInt16
```

功能：使用高位截断策略的乘法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 乘数。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt16值，使它们相乘会发生溢出
    let a1 = 65535u16  // UInt16的最大值
    let b1 = 2u16
    
    let result1 = a1.wrappingMul(b1)
    println("Overflow case - Wrapping mul result: ${result1}")
    
    // 创建两个UInt16值，使它们相乘不会发生溢出
    let a2 = 100u16
    let b2 = 200u16
    
    let result2 = a2.wrappingMul(b2)
    println("Normal case - Wrapping mul result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping mul result: 65534
Normal case - Wrapping mul result: 20000
```

#### func wrappingNeg()

```cangjie
public func wrappingNeg(): UInt16
```

功能：使用高位截断策略的负号运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt16值进行负号运算
    let a1 = 100u16
    
    let result1 = a1.wrappingNeg()
    println("Wrapping neg result: ${result1}")
    
    // 创建另一个值进行负号运算
    let a2 = 65535u16
    
    let result2 = a2.wrappingNeg()
    println("Wrapping neg result 2: ${result2}")
    
    return 0
}
```

运行结果：

```text
Wrapping neg result: 65436
Wrapping neg result 2: 1
```

#### func wrappingShl(UInt64)

```cangjie
public func wrappingShl(y: UInt64): UInt16
```

功能：使用高位截断策略的左移运算。

当右操作数大于等于左操作数位数时，取右操作数的低 4 位作为移位位数。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt16值和一个较大的移位位数，会发生溢出
    let a1 = 1000u16
    let b1 = 20u64  // 大于16的移位位数
    
    let result1 = a1.wrappingShl(b1)
    println("Overflow case - Wrapping shl result: ${result1}")
    
    // 创建一个UInt16值和一个正常的移位位数
    let a2 = 1000u16
    let b2 = 3u64
    
    let result2 = a2.wrappingShl(b2)
    println("Normal case - Wrapping shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping shl result: 16000
Normal case - Wrapping shl result: 8000
```

#### func wrappingShr(UInt64)

```cangjie
public func wrappingShr(y: UInt64): UInt16
```

功能：使用高位截断策略的右移运算。

当右操作数大于等于左操作数位数时，取右操作数的低 4 位作为移位位数。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt16值和一个较大的移位位数，会发生截断
    let a1 = 1000u16
    let b1 = 20u64  // 大于16的移位位数
    
    let result1 = a1.wrappingShr(b1)
    println("Truncation case - Wrapping shr result: ${result1}")
    
    // 创建一个UInt16值和一个正常的移位位数
    let a2 = 1000u16
    let b2 = 3u64
    
    let result2 = a2.wrappingShr(b2)
    println("Normal case - Wrapping shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Truncation case - Wrapping shr result: 62
Normal case - Wrapping shr result: 125
```

#### func wrappingSub(UInt16)

```cangjie
public func wrappingSub(y: UInt16): UInt16
```

功能：使用高位截断策略的减法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 减数。

返回值：

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt16值，使减法运算会发生下溢
    let a1 = 0u16
    let b1 = 1u16
    
    let result1 = a1.wrappingSub(b1)
    println("Underflow case - Wrapping sub result: ${result1}")
    
    // 创建两个UInt16值，使减法运算不会发生溢出
    let a2 = 1000u16
    let b2 = 100u16
    
    let result2 = a2.wrappingSub(b2)
    println("Normal case - Wrapping sub result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Wrapping sub result: 65535
Normal case - Wrapping sub result: 900
```

### extend UInt32 <: WrappingOp\<UInt32>

```cangjie
extend UInt32 <: WrappingOp<UInt32>
```

功能：为 [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) 实现 [WrappingOp](#interface-wrappingopt) 接口。

父类型：

- [WrappingOp](#interface-wrappingopt)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)>

#### func wrappingAdd(UInt32)

```cangjie
public func wrappingAdd(y: UInt32): UInt32
```

功能：使用高位截断策略的加法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 加数。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt32值，使它们相加会发生溢出
    let a1 = 4294967295u32  // UInt32的最大值
    let b1 = 1u32
    
    let result1 = a1.wrappingAdd(b1)
    println("Overflow case - Wrapping add result: ${result1}")
    
    // 创建两个UInt32值，使它们相加不会发生溢出
    let a2 = 1000000000u32
    let b2 = 2000000000u32
    
    let result2 = a2.wrappingAdd(b2)
    println("Normal case - Wrapping add result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping add result: 0
Normal case - Wrapping add result: 3000000000
```

#### func wrappingDec()

```cangjie
public func wrappingDec(): UInt32
```

功能：使用高位截断策略的自减运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt32值，使其自减会发生下溢
    let a1 = 0u32  // UInt32的最小值
    
    let result1 = a1.wrappingDec()
    println("Underflow case - Wrapping dec result: ${result1}")
    
    // 创建一个UInt32值，使其自减不会发生溢出
    let a2 = 1000000000u32
    
    let result2 = a2.wrappingDec()
    println("Normal case - Wrapping dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Wrapping dec result: 4294967295
Normal case - Wrapping dec result: 999999999
```

#### func wrappingDiv(UInt32)

```cangjie
public func wrappingDiv(y: UInt32): UInt32
```

功能：使用高位截断策略的除法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 除数。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 对于UInt32的除法运算，通常不会发生溢出，所以只提供正常情况的示例
    let a1 = 1000000000u32
    let b1 = 10u32
    
    let result1 = a1.wrappingDiv(b1)
    println("Normal case - Wrapping div result: ${result1}")
    
    return 0
}
```

运行结果：

```text
Normal case - Wrapping div result: 100000000
```

#### func wrappingInc()

```cangjie
public func wrappingInc(): UInt32
```

功能：使用高位截断策略的自增运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt32值，使其自增会发生上溢
    let a1 = 4294967295u32  // UInt32的最大值
    
    let result1 = a1.wrappingInc()
    println("Overflow case - Wrapping inc result: ${result1}")
    
    // 创建一个UInt32值，使其自增不会发生溢出
    let a2 = 1000000000u32
    
    let result2 = a2.wrappingInc()
    println("Normal case - Wrapping inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping inc result: 0
Normal case - Wrapping inc result: 1000000001
```

#### func wrappingMod(UInt32)

```cangjie
public func wrappingMod(y: UInt32): UInt32
```

功能：使用高位截断策略的取余运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 除数。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt32值进行取余运算
    let a1 = 1000000000u32
    let b1 = 3u32
    
    let result1 = a1.wrappingMod(b1)
    println("Wrapping mod result: ${result1}")
    
    return 0
}
```

运行结果：

```text
Wrapping mod result: 1
```

#### func wrappingMul(UInt32)

```cangjie
public func wrappingMul(y: UInt32): UInt32
```

功能：使用高位截断策略的乘法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 乘数。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt32值，使它们相乘会发生溢出
    let a1 = 4294967295u32  // UInt32的最大值
    let b1 = 2u32
    
    let result1 = a1.wrappingMul(b1)
    println("Overflow case - Wrapping mul result: ${result1}")
    
    // 创建两个UInt32值，使它们相乘不会发生溢出
    let a2 = 100000u32
    let b2 = 200000u32
    
    let result2 = a2.wrappingMul(b2)
    println("Normal case - Wrapping mul result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping mul result: 4294967294
Normal case - Wrapping mul result: 2820130816
```

#### func wrappingNeg()

```cangjie
public func wrappingNeg(): UInt32
```

功能：使用高位截断策略的负号运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt32值进行负号运算
    let a1 = 1000000000u32
    
    let result1 = a1.wrappingNeg()
    println("Wrapping neg result: ${result1}")
    
    // 创建另一个值进行负号运算
    let a2 = 4294967295u32
    
    let result2 = a2.wrappingNeg()
    println("Wrapping neg result 2: ${result2}")
    
    return 0
}
```

运行结果：

```text
Wrapping neg result: 3294967296
Wrapping neg result 2: 1
```

#### func wrappingShl(UInt64)

```cangjie
public func wrappingShl(y: UInt64): UInt32
```

功能：使用高位截断策略的左移运算。

当右操作数大于等于左操作数位数时，取右操作数的低 5 位作为移位位数。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt32值和一个较大的移位位数，会发生截断
    let a1 = 1000000000u32
    let b1 = 40u64  // 大于32的移位位数
    
    let result1 = a1.wrappingShl(b1)
    println("Truncation case - Wrapping shl result: ${result1}")
    
    // 创建一个UInt32值和一个正常的移位位数
    let a2 = 1000000000u32
    let b2 = 3u64
    
    let result2 = a2.wrappingShl(b2)
    println("Normal case - Wrapping shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Truncation case - Wrapping shl result: 2596929536
Normal case - Wrapping shl result: 3705032704
```

#### func wrappingShr(UInt64)

```cangjie
public func wrappingShr(y: UInt64): UInt32
```

功能：使用高位截断策略的右移运算。

当右操作数大于等于左操作数位数时，取右操作数的低 5 位作为移位位数。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt32值和一个较大的移位位数，会发生截断
    let a1 = 1000000000u32
    let b1 = 40u64  // 大于32的移位位数
    
    let result1 = a1.wrappingShr(b1)
    println("Truncation case - Wrapping shr result: ${result1}")
    
    // 创建一个UInt32值和一个正常的移位位数
    let a2 = 1000000000u32
    let b2 = 3u64
    
    let result2 = a2.wrappingShr(b2)
    println("Normal case - Wrapping shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Truncation case - Wrapping shr result: 3906250
Normal case - Wrapping shr result: 125000000
```

#### func wrappingSub(UInt32)

```cangjie
public func wrappingSub(y: UInt32): UInt32
```

功能：使用高位截断策略的减法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 减数。

返回值：

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt32值，使减法运算会发生下溢
    let a1 = 0u32
    let b1 = 1u32
    
    let result1 = a1.wrappingSub(b1)
    println("Underflow case - Wrapping sub result: ${result1}")
    
    // 创建两个UInt32值，使减法运算不会发生溢出
    let a2 = 1000000000u32
    let b2 = 100000000u32
    
    let result2 = a2.wrappingSub(b2)
    println("Normal case - Wrapping sub result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Wrapping sub result: 4294967295
Normal case - Wrapping sub result: 900000000
```

### extend UInt64 <: WrappingOp\<UInt64>

```cangjie
extend UInt64 <: WrappingOp<UInt64>
```

功能：为 [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) 实现 [WrappingOp](#interface-wrappingopt) 接口。

父类型：

- [WrappingOp](#interface-wrappingopt)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)>

#### func wrappingAdd(UInt64)

```cangjie
public func wrappingAdd(y: UInt64): UInt64
```

功能：使用高位截断策略的加法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 加数。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt64值，使它们相加会发生溢出
    let a1 = 18446744073709551615u64  // UInt64的最大值
    let b1 = 1u64
    
    let result1 = a1.wrappingAdd(b1)
    println("Overflow case - Wrapping add result: ${result1}")
    
    // 创建两个UInt64值，使它们相加不会发生溢出
    let a2 = 1000000000000000000u64
    let b2 = 2000000000000000000u64
    
    let result2 = a2.wrappingAdd(b2)
    println("Normal case - Wrapping add result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping add result: 0
Normal case - Wrapping add result: 3000000000000000000
```

#### func wrappingDec()

```cangjie
public func wrappingDec(): UInt64
```

功能：使用高位截断策略的自减运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt64值，使其自减会发生下溢
    let a1 = 0u64  // UInt64的最小值
    
    let result1 = a1.wrappingDec()
    println("Underflow case - Wrapping dec result: ${result1}")
    
    // 创建一个UInt64值，使其自减不会发生溢出
    let a2 = 1000000000000000000u64
    
    let result2 = a2.wrappingDec()
    println("Normal case - Wrapping dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Wrapping dec result: 18446744073709551615
Normal case - Wrapping dec result: 999999999999999999
```

#### func wrappingDiv(UInt64)

```cangjie
public func wrappingDiv(y: UInt64): UInt64
```

功能：使用高位截断策略的除法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 除数。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 对于UInt64的除法运算，通常不会发生溢出，所以只提供正常情况的示例
    let a1 = 1000000000000000000u64
    let b1 = 10u64
    
    let result1 = a1.wrappingDiv(b1)
    println("Normal case - Wrapping div result: ${result1}")

    return 0
}
```

运行结果：

```text
Normal case - Wrapping div result: 100000000000000000
```

#### func wrappingInc()

```cangjie
public func wrappingInc(): UInt64
```

功能：使用高位截断策略的自增运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt64值，使其自增会发生上溢
    let a1 = 18446744073709551615u64  // UInt64的最大值
    
    let result1 = a1.wrappingInc()
    println("Overflow case - Wrapping inc result: ${result1}")
    
    // 创建一个UInt64值，使其自增不会发生溢出
    let a2 = 1000000000000000000u64
    
    let result2 = a2.wrappingInc()
    println("Normal case - Wrapping inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping inc result: 0
Normal case - Wrapping inc result: 1000000000000000001
```

#### func wrappingMod(UInt64)

```cangjie
public func wrappingMod(y: UInt64): UInt64
```

功能：使用高位截断策略的取余运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 除数。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt64值进行取余运算
    let a1 = 1000000000000000000u64
    let b1 = 3u64
    
    let result1 = a1.wrappingMod(b1)
    println("Wrapping mod result: ${result1}")
    
    return 0
}
```

运行结果：

```text
Wrapping mod result: 1
```

#### func wrappingMul(UInt64)

```cangjie
public func wrappingMul(y: UInt64): UInt64
```

功能：使用高位截断策略的乘法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 乘数。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt64值，使它们相乘会发生溢出
    let a1 = 18446744073709551615u64  // UInt64的最大值
    let b1 = 2u64
    
    let result1 = a1.wrappingMul(b1)
    println("Overflow case - Wrapping mul result: ${result1}")
    
    // 创建两个UInt64值，使它们相乘不会发生溢出
    let a2 = 1000000000000000000u64
    let b2 = 2000000000000000000u64
    
    let result2 = a2.wrappingMul(b2)
    println("Normal case - Wrapping mul result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping mul result: 18446744073709551614
Normal case - Wrapping mul result: 7392445620511834112
```

#### func wrappingNeg()

```cangjie
public func wrappingNeg(): UInt64
```

功能：使用高位截断策略的负号运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt64值进行负号运算
    let a1 = 1000000000000000000u64
    
    let result1 = a1.wrappingNeg()
    println("Wrapping neg result: ${result1}")
    
    // 创建另一个值进行负号运算
    let a2 = 18446744073709551615u64
    
    let result2 = a2.wrappingNeg()
    println("Wrapping neg result 2: ${result2}")
    
    return 0
}
```

运行结果：

```text
Wrapping neg result: 17446744073709551616
Wrapping neg result 2: 1
```

#### func wrappingShl(UInt64)

```cangjie
public func wrappingShl(y: UInt64): UInt64
```

功能：使用高位截断策略的左移运算。

当右操作数大于等于左操作数位数时，取右操作数的低 6 位作为移位位数。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt64值和一个较大的移位位数，会发生截断
    let a1 = 1000000000000000000u64
    let b1 = 70u64  // 大于64的移位位数
    
    let result1 = a1.wrappingShl(b1)
    println("Truncation case - Wrapping shl result: ${result1}")
    
    // 创建一个UInt64值和一个正常的移位位数
    let a2 = 1000000000000000000u64
    let b2 = 3u64
    
    let result2 = a2.wrappingShl(b2)
    println("Normal case - Wrapping shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Truncation case - Wrapping shl result: 8659767778871345152
Normal case - Wrapping shl result: 8000000000000000000
```

#### func wrappingShr(UInt64)

```cangjie
public func wrappingShr(y: UInt64): UInt64
```

功能：使用高位截断策略的右移运算。

当右操作数大于等于左操作数位数时，取右操作数的低 6 位作为移位位数。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt64值和一个较大的移位位数，会发生截断
    let a1 = 1000000000000000000u64
    let b1 = 70u64  // 大于64的移位位数
    
    let result1 = a1.wrappingShr(b1)
    println("Truncation case - Wrapping shr result: ${result1}")
    
    // 创建一个UInt64值和一个正常的移位位数
    let a2 = 1000000000000000000u64
    let b2 = 3u64
    
    let result2 = a2.wrappingShr(b2)
    println("Normal case - Wrapping shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Truncation case - Wrapping shr result: 15625000000000000
Normal case - Wrapping shr result: 125000000000000000
```

#### func wrappingSub(UInt64)

```cangjie
public func wrappingSub(y: UInt64): UInt64
```

功能：使用高位截断策略的减法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 减数。

返回值：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt64值，使减法运算会发生下溢
    let a1 = 0u64
    let b1 = 1u64
    
    let result1 = a1.wrappingSub(b1)
    println("Underflow case - Wrapping sub result: ${result1}")
    
    // 创建两个UInt64值，使减法运算不会发生溢出
    let a2 = 1000000000000000000u64
    let b2 = 100000000000000000u64
    
    let result2 = a2.wrappingSub(b2)
    println("Normal case - Wrapping sub result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Wrapping sub result: 18446744073709551615
Normal case - Wrapping sub result: 900000000000000000
```

### extend UInt8 <: WrappingOp\<UInt8>

```cangjie
extend UInt8 <: WrappingOp<UInt8>
```

功能：为 [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) 实现 [WrappingOp](#interface-wrappingopt) 接口。

父类型：

- [WrappingOp](#interface-wrappingopt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)>

#### func wrappingAdd(UInt8)

```cangjie
public func wrappingAdd(y: UInt8): UInt8
```

功能：使用高位截断策略的加法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 加数。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt8值，使它们相加会发生溢出
    let a1 = 255u8  // UInt8的最大值
    let b1 = 1u8
    
    let result1 = a1.wrappingAdd(b1)
    println("Overflow case - Wrapping add result: ${result1}")
    
    // 创建两个UInt8值，使它们相加不会发生溢出
    let a2 = 100u8
    let b2 = 50u8
    
    let result2 = a2.wrappingAdd(b2)
    println("Normal case - Wrapping add result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping add result: 0
Normal case - Wrapping add result: 150
```

#### func wrappingDec()

```cangjie
public func wrappingDec(): UInt8
```

功能：使用高位截断策略的自减运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt8值，使其自减会发生下溢
    let a1 = 0u8  // UInt8的最小值
    
    let result1 = a1.wrappingDec()
    println("Underflow case - Wrapping dec result: ${result1}")
    
    // 创建一个UInt8值，使其自减不会发生溢出
    let a2 = 100u8
    
    let result2 = a2.wrappingDec()
    println("Normal case - Wrapping dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Wrapping dec result: 255
Normal case - Wrapping dec result: 99
```

#### func wrappingDiv(UInt8)

```cangjie
public func wrappingDiv(y: UInt8): UInt8
```

功能：使用高位截断策略的除法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 除数。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 对于UInt8的除法运算，通常不会发生溢出，所以只提供正常情况的示例
    let a1 = 100u8
    let b1 = 10u8
    
    let result1 = a1.wrappingDiv(b1)
    println("Normal case - Wrapping div result: ${result1}")
    
    return 0
}
```

运行结果：

```text
Normal case - Wrapping div result: 10
```

#### func wrappingInc()

```cangjie
public func wrappingInc(): UInt8
```

功能：使用高位截断策略的自增运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt8值，使其自增会发生上溢
    let a1 = 255u8  // UInt8的最大值
    
    let result1 = a1.wrappingInc()
    println("Overflow case - Wrapping inc result: ${result1}")
    
    // 创建一个UInt8值，使其自增不会发生溢出
    let a2 = 100u8
    
    let result2 = a2.wrappingInc()
    println("Normal case - Wrapping inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping inc result: 0
Normal case - Wrapping inc result: 101
```

#### func wrappingMod(UInt8)

```cangjie
public func wrappingMod(y: UInt8): UInt8
```

功能：使用高位截断策略的取余运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 除数。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt8值进行取余运算
    let a1 = 100u8
    let b1 = 3u8
    
    let result1 = a1.wrappingMod(b1)
    println("Wrapping mod result: ${result1}")
    
    return 0
}
```

运行结果：

```text
Wrapping mod result: 1
```

#### func wrappingMul(UInt8)

```cangjie
public func wrappingMul(y: UInt8): UInt8
```

功能：使用高位截断策略的乘法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 乘数。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt8值，使它们相乘会发生溢出
    let a1 = 255u8  // UInt8的最大值
    let b1 = 2u8
    
    let result1 = a1.wrappingMul(b1)
    println("Overflow case - Wrapping mul result: ${result1}")
    
    // 创建两个UInt8值，使它们相乘不会发生溢出
    let a2 = 10u8
    let b2 = 20u8
    
    let result2 = a2.wrappingMul(b2)
    println("Normal case - Wrapping mul result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping mul result: 254
Normal case - Wrapping mul result: 200
```

#### func wrappingNeg()

```cangjie
public func wrappingNeg(): UInt8
```

功能：使用高位截断策略的负号运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt8值进行负号运算
    let a1 = 100u8
    
    let result1 = a1.wrappingNeg()
    println("Wrapping neg result: ${result1}")
    
    // 创建另一个值进行负号运算
    let a2 = 255u8
    
    let result2 = a2.wrappingNeg()
    println("Wrapping neg result 2: ${result2}")
    
    return 0
}
```

运行结果：

```text
Wrapping neg result: 156
Wrapping neg result 2: 1
```

#### func wrappingShl(UInt64)

```cangjie
public func wrappingShl(y: UInt64): UInt8
```

功能：使用高位截断策略的左移运算。

当右操作数大于等于左操作数位数时，取右操作数的低 3 位作为移位位数。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt8值和一个较大的移位位数，会发生截断
    let a1 = 100u8
    let b1 = 10u64  // 大于8的移位位数会被截断
    
    let result1 = a1.wrappingShl(b1)
    println("Truncation case - Wrapping shl result: ${result1}")
    
    // 创建一个UInt8值和一个正常的移位位数
    let a2 = 100u8
    let b2 = 3u64
    
    let result2 = a2.wrappingShl(b2)
    println("Normal case - Wrapping shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Truncation case - Wrapping shl result: 144
Normal case - Wrapping shl result: 32
```

#### func wrappingShr(UInt64)

```cangjie
public func wrappingShr(y: UInt64): UInt8
```

功能：使用高位截断策略的右移运算。

当右操作数大于等于左操作数位数时，取右操作数的低 3 位作为移位位数。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UInt8值和一个较大的移位位数，会发生截断
    let a1 = 100u8
    let b1 = 10u64  // 大于8的移位位数会被截断
    
    let result1 = a1.wrappingShr(b1)
    println("Truncation case - Wrapping shr result: ${result1}")
    
    // 创建一个UInt8值和一个正常的移位位数
    let a2 = 100u8
    let b2 = 3u64
    
    let result2 = a2.wrappingShr(b2)
    println("Normal case - Wrapping shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Truncation case - Wrapping shr result: 25
Normal case - Wrapping shr result: 12
```

#### func wrappingSub(UInt8)

```cangjie
public func wrappingSub(y: UInt8): UInt8
```

功能：使用高位截断策略的减法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 减数。

返回值：

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UInt8值，使减法运算会发生下溢
    let a1 = 0u8
    let b1 = 1u8
    
    let result1 = a1.wrappingSub(b1)
    println("Underflow case - Wrapping sub result: ${result1}")
    
    // 创建两个UInt8值，使减法运算不会发生溢出
    let a2 = 100u8
    let b2 = 50u8
    
    let result2 = a2.wrappingSub(b2)
    println("Normal case - Wrapping sub result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Wrapping sub result: 255
Normal case - Wrapping sub result: 50
```

### extend UIntNative <: WrappingOp\<UIntNative>

```cangjie
extend UIntNative <: WrappingOp<UIntNative>
```

功能：为 [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) 实现 [WrappingOp](#interface-wrappingopt) 接口。

父类型：

- [WrappingOp](#interface-wrappingopt)\<[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)>

#### func wrappingAdd(UIntNative)

```cangjie
public func wrappingAdd(y: UIntNative): UIntNative
```

功能：使用高位截断策略的加法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 加数。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 加法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UIntNative值，使它们相加会发生溢出
    let a1: UIntNative = 18446744073709551615  // UIntNative的最大值
    let b1: UIntNative = 1
    
    let result1 = a1.wrappingAdd(b1)
    println("Overflow case - Wrapping add result: ${result1}")
    
    // 创建两个UIntNative值，使它们相加不会发生溢出
    let a2: UIntNative = 1000000000000000000
    let b2: UIntNative = 2000000000000000000
    
    let result2 = a2.wrappingAdd(b2)
    println("Normal case - Wrapping add result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping add result: 0
Normal case - Wrapping add result: 3000000000000000000
```

#### func wrappingDec()

```cangjie
public func wrappingDec(): UIntNative
```

功能：使用高位截断策略的自减运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 自减运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UIntNative值，使其自减会发生下溢
    let a1: UIntNative = 0  // UIntNative的最小值
    
    let result1 = a1.wrappingDec()
    println("Underflow case - Wrapping dec result: ${result1}")
    
    // 创建一个UIntNative值，使其自减不会发生溢出
    let a2: UIntNative = 1000000000000000000
    
    let result2 = a2.wrappingDec()
    println("Normal case - Wrapping dec result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Wrapping dec result: 18446744073709551615
Normal case - Wrapping dec result: 999999999999999999
```

#### func wrappingDiv(UIntNative)

```cangjie
public func wrappingDiv(y: UIntNative): UIntNative
```

功能：使用高位截断策略的除法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 除数。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 除法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 对于UIntNative的除法运算，通常不会发生溢出，所以只提供正常情况的示例
    let a1: UIntNative = 1000000000000000000
    let b1: UIntNative = 10
    
    let result1 = a1.wrappingDiv(b1)
    println("Normal case - Wrapping div result: ${result1}")

    return 0
}
```

运行结果：

```text
Normal case - Wrapping div result: 100000000000000000
```

#### func wrappingInc()

```cangjie
public func wrappingInc(): UIntNative
```

功能：使用高位截断策略的自增运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 自增运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UIntNative值，使其自增会发生上溢
    let a1: UIntNative = 18446744073709551615  // UIntNative的最大值
    
    let result1 = a1.wrappingInc()
    println("Overflow case - Wrapping inc result: ${result1}")
    
    // 创建一个UIntNative值，使其自增不会发生溢出
    let a2: UIntNative = 1000000000000000000
    
    let result2 = a2.wrappingInc()
    println("Normal case - Wrapping inc result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping inc result: 0
Normal case - Wrapping inc result: 1000000000000000001
```

#### func wrappingMod(UIntNative)

```cangjie
public func wrappingMod(y: UIntNative): UIntNative
```

功能：使用高位截断策略的取余运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 除数。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 取余运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UIntNative值进行取余运算
    let a1: UIntNative = 1000000000000000000
    let b1: UIntNative = 3
    
    let result1 = a1.wrappingMod(b1)
    println("Wrapping mod result: ${result1}")
    
    return 0
}
```

运行结果：

```text
Wrapping mod result: 1
```

#### func wrappingMul(UIntNative)

```cangjie
public func wrappingMul(y: UIntNative): UIntNative
```

功能：使用高位截断策略的乘法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 乘数。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 乘法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UIntNative值，使它们相乘会发生溢出
    let a1: UIntNative = 18446744073709551615  // UIntNative的最大值
    let b1: UIntNative = 2
    
    let result1 = a1.wrappingMul(b1)
    println("Overflow case - Wrapping mul result: ${result1}")
    
    // 创建两个UIntNative值，使它们相乘不会发生溢出
    let a2: UIntNative = 1000000000000000000
    let b2: UIntNative = 2000000000000000000
    
    let result2 = a2.wrappingMul(b2)
    println("Normal case - Wrapping mul result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Overflow case - Wrapping mul result: 18446744073709551614
Normal case - Wrapping mul result: 7392445620511834112
```

#### func wrappingNeg()

```cangjie
public func wrappingNeg(): UIntNative
```

功能：使用高位截断策略的负号运算。

当运算出现溢出时，高位截断，否则返回运算结果。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 负号运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UIntNative值进行负号运算
    let a1: UIntNative = 1000000000000000000
    
    let result1 = a1.wrappingNeg()
    println("Wrapping neg result: ${result1}")
    
    // 创建另一个值进行负号运算
    let a2: UIntNative = 18446744073709551615
    
    let result2 = a2.wrappingNeg()
    println("Wrapping neg result 2: ${result2}")
    
    return 0
}
```

运行结果：

```text
Wrapping neg result: 17446744073709551616
Wrapping neg result 2: 1
```

#### func wrappingShl(UInt64)

```cangjie
public func wrappingShl(y: UInt64): UIntNative
```

功能：使用高位截断策略的左移运算。

当右操作数大于等于左操作数位数时，取右操作数的低位作为移位位数，具体取的位数取决于当前系统下 UIntNative 的位数。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 左移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UIntNative值和一个较大的移位位数，会发生截断
    let a1: UIntNative = 1000000000000000000
    let b1 = 70u64  // 大于64的移位位数
    
    let result1 = a1.wrappingShl(b1)
    println("Truncation case - Wrapping shl result: ${result1}")
    
    // 创建一个UIntNative值和一个正常的移位位数
    let a2: UIntNative = 1000000000000000000
    let b2 = 3u64
    
    let result2 = a2.wrappingShl(b2)
    println("Normal case - Wrapping shl result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Truncation case - Wrapping shl result: 8659767778871345152
Normal case - Wrapping shl result: 8000000000000000000
```

#### func wrappingShr(UInt64)

```cangjie
public func wrappingShr(y: UInt64): UIntNative
```

功能：使用高位截断策略的右移运算。

当右操作数大于等于左操作数位数时，取右操作数的低位作为移位位数，具体取的位数取决于当前系统下 UIntNative 的位数。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 移位位数。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 右移运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建一个UIntNative值和一个较大的移位位数，会发生截断
    let a1: UIntNative = 1000000000000000000
    let b1 = 70u64  // 大于64的移位位数
    
    let result1 = a1.wrappingShr(b1)
    println("Truncation case - Wrapping shr result: ${result1}")
    
    // 创建一个UIntNative值和一个正常的移位位数
    let a2: UIntNative = 1000000000000000000
    let b2 = 3u64
    
    let result2 = a2.wrappingShr(b2)
    println("Normal case - Wrapping shr result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Truncation case - Wrapping shr result: 15625000000000000
Normal case - Wrapping shr result: 125000000000000000
```

#### func wrappingSub(UIntNative)

```cangjie
public func wrappingSub(y: UIntNative): UIntNative
```

功能：使用高位截断策略的减法运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 减数。

返回值：

- [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - 减法运算结果。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    // 创建两个UIntNative值，使减法运算会发生下溢
    let a1: UIntNative = 0
    let b1: UIntNative = 1
    
    let result1 = a1.wrappingSub(b1)
    println("Underflow case - Wrapping sub result: ${result1}")
    
    // 创建两个UIntNative值，使减法运算不会发生溢出
    let a2: UIntNative = 1000000000000000000
    let b2: UIntNative = 100000000000000000
    
    let result2 = a2.wrappingSub(b2)
    println("Normal case - Wrapping sub result: ${result2}")
    
    return 0
}
```

运行结果：

```text
Underflow case - Wrapping sub result: 18446744073709551615
Normal case - Wrapping sub result: 900000000000000000
```

## interface WrappingPow

```cangjie
public interface WrappingPow {
    func wrappingPow(y: UInt64): Int64
}
```

功能：提供使用高位截断策略的幂运算接口。

### func wrappingPow(UInt64)

```cangjie
func wrappingPow(y: UInt64): Int64
```

功能：使用高位截断策略的幂运算。

当运算出现溢出时，高位截断，否则返回运算结果。

参数：

- y: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 指数。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 幂运算结果。
