# 数学基础运算示例

<!-- verify -->
```cangjie
import std.math.clamp
import std.math.gcd
import std.math.lcm
import std.math.rotate

// 范围截断：将值限制在 [min, max] 范围内
func clampTest() {
    let min: Float16 = -0.123
    let max: Float16 = 0.123

    // 值在范围内，保持不变
    let inRange: Float16 = 0.121
    println("值在范围内: ${clamp(inRange, min, max)}")

    // 值超过上界，被截断为上界
    let aboveMax: Float16 = 11.121
    println("值超过上界: ${clamp(aboveMax, min, max)}")

    // 值低于下界，被截断为下界
    let belowMin: Float16 = -1.121
    println("值低于下界: ${clamp(belowMin, min, max)}")
}

// 求两个数的最大公约数
func gcdTest() {
    println("gcd(0, -60) = ${gcd(0, -60)}")
    println("gcd(-33, 27) = ${gcd(-33, 27)}")
}

// 求两个数的最小公倍数
func lcmTest() {
    let result: Int8 = lcm(Int8(-3), Int8(5))
    println("lcm(-3, 5) = ${result}")
}

// 整数按二进制位旋转
func rotateTest() {
    let rotated1: Int8 = rotate(Int8(92), Int8(4))
    println("rotate(92, 4) = ${rotated1}")

    let rotated2: Int32 = rotate(Int32(1), Int8(4))
    println("rotate(1, 4) = ${rotated2}")
}

main(): Unit {
    println("---- 范围截断 clamp ----")
    clampTest()
    println("---- 最大公约数 gcd ----")
    gcdTest()
    println("---- 最小公倍数 lcm ----")
    lcmTest()
    println("---- 二进制位旋转 rotate ----")
    rotateTest()
}
```

运行结果：

```text
---- 范围截断 clamp ----
值在范围内: 0.120972
值超过上界: 0.122986
值低于下界: -0.122986
---- 最大公约数 gcd ----
gcd(0, -60) = 60
gcd(-33, 27) = 3
---- 最小公倍数 lcm ----
lcm(-3, 5) = 15
---- 二进制位旋转 rotate ----
rotate(92, 4) = -59
rotate(1, 4) = 16
```
