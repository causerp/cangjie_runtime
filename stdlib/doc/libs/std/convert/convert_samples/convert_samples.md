# convert 使用示例

## 使用 format 格式化数值

### 格式化整型

下面是格式化整型示例。

示例：

<!-- verify -->
```cangjie
import std.convert.*

main(): Int64 {
    var num: Int32 = -20

    // 左对齐，宽度为10
    var result1 = num.format("-10")
    println("左对齐: \"${result1}\"")

    // 右对齐，宽度为10，显示正负号
    var result2 = num.format("+10")
    println("右对齐: \"${result2}\"")

    // 右对齐，宽度为10
    var result3 = (-20).format("10")
    println("右对齐: \"${result3}\"")

    // 只指定对齐方式
    var result4 = num.format("-")
    println("仅左对齐: \"${result4}\"")

    return 0
}
```

运行结果：

```text
左对齐: "-20       "
右对齐: "       -20"
右对齐: "       -20"
仅左对齐: "-20"
```

### 格式化浮点型

下面是格式化浮点型示例。

示例：

<!-- verify -->
```cangjie
import std.convert.*

main(): Int64 {
    var num1: Float16 = -0.34
    var num2: Float32 = .34
    var num3: Float64 = 3_0.3__4_
    var num4: Float64 = 20.00

    // 左对齐，宽度为20
    var result1 = num1.format("-20")
    println("左对齐: \"${result1}\"")

    // 右对齐，宽度为20，显示正负号
    var result2 = num2.format("+20")
    println("右对齐: \"${result2}\"")

    // 右对齐，宽度为10
    var result3 = num3.format("10")
    println("右对齐: \"${result3}\"")

    // 左对齐，宽度为10
    var result4 = num4.format("-10")
    println("左对齐: \"${result4}\"")

    // 仅指定对齐方式
    var result5 = num4.format("-")
    println("仅左对齐: \"${result5}\"")

    return 0
}
```

运行结果：

```text
左对齐: "-0.340088           "
右对齐: "           +0.340000"
右对齐: " 30.340000"
左对齐: "20.000000 "
仅左对齐: "20.000000"
```

### 格式化字符型

下面是格式化字符型示例。

示例：

<!-- verify -->
```cangjie
import std.convert.*

main(): Int64 {
    var char1: Rune = 'a'
    var char2: Rune = '-'

    // 左对齐，宽度为10
    var result1 = char1.format("-10")
    println("左对齐: \"${result1}\"")

    var result2 = char2.format("-10")
    println("左对齐: \"${result2}\"")

    // 右对齐，宽度为10
    var result3 = char1.format("10")
    println("右对齐: \"${result3}\"")

    var result4 = char2.format("10")
    println("右对齐: \"${result4}\"")

    return 0
}
```

运行结果：

```text
左对齐: "a         "
左对齐: "-         "
右对齐: "         a"
右对齐: "         -"
```

## 使用 parse/tryParse 转换字符串

示例：

<!-- verify -->
```cangjie
import std.convert.*

main(): Int64 {
    // Bool类型转换
    println("Bool.parse(\"true\"): ${Bool.parse("true")}")
    println("Bool.tryParse(\"false\"): ${Bool.tryParse("false")}")

    // Rune类型转换
    println("Rune.parse(\"'a'\"): ${Rune.parse("'a'")}")
    println("Rune.tryParse(\"'\\u{00e2}'\"): ${Rune.tryParse("'\u{00e2}'")}")

    // Int16类型转换
    println("Int16.parse(\"-32768\"): ${Int16.parse("-32768")}")
    println("Int16.tryParse(\"32767\"): ${Int16.tryParse("32767")}")

    // Float64类型转换
    println("Float64.parse(\"-3.1415926\"): ${Float64.parse("-3.1415926")}")
    println("Float64.tryParse(\"3.1415926\"): ${Float64.tryParse("3.1415926")}")
    return 0
}
```

运行结果：

```text
Bool.parse("true"): true
Bool.tryParse("false"): Some(false)
Rune.parse("'a'"): a
Rune.tryParse("'\u{00e2}'"): Some(â)
Int16.parse("-32768"): -32768
Int16.tryParse("32767"): Some(32767)
Float64.parse("-3.1415926"): -3.141593
Float64.tryParse("3.1415926"): Some(3.141593)
```

## format 函数参数详解

### convert 参数 flag 的语法 1

'-' 适用于 Int，UInt，Rune 和 Float，表示左对齐。来自[概述](./../convert_package_overview.md#功能介绍)。

示例：

<!-- verify -->
```cangjie
import std.convert.*

main() {
    var num: Int32 = -20
    println("\"${num.format("-10")}\"")
}
```

运行结果：

```text
"-20       "
```

### convert 参数 flag 的语法 2

'+' 适用于 Int，UInt 和 Float，如果数值为正数则打出 '+' 符号，如果数值为负数则忽略。来自[概述](./../convert_package_overview.md#功能介绍)。

示例：

<!-- verify -->
```cangjie
import std.convert.*

main() {
    var num: Int32 = 20
    println("\"${num.format("+10")}\"")
}
```

运行结果：

```text
"       +20"
```

### convert 参数 flag 的语法 3

'#' 是针对进制打印的，对于二进制打印会补充一个 '0b' 或者 '0B'，对于八进制打印会补充一个 '0o' 或者 '0O'，对于十六进制会补充 '0x' 或者 '0X'。来自[概述](./../convert_package_overview.md#功能介绍)。

示例：

<!-- verify -->
```cangjie
import std.convert.*

main() {
    var num: Int32 = 1
    println("\"${num.format("#10x")}\"")
}
```

运行结果：

```text
"       0x1"
```

### convert 参数 flag 的语法 4

'0' 适用于 Int，UInt 和 Float，在空位补充 0。来自[概述](./../convert_package_overview.md#功能介绍)。

示例：

<!-- verify -->
```cangjie
import std.convert.*

main() {
    var num: Int32 = -20
    println("\"${num.format("010")}\"")
}
```

运行结果：

```text
"-000000020"
```

### convert 参数 width 的语法

- 宽度为正整数，适用于 Int，UInt，Rune 和 Float。
- 宽度前有负号则表示左对齐，没有负号则是右对齐，如果宽度小于数值本身的长度，不会发生截断。
- 如果前缀有 `+` 或 `-` 符号会占用一个字符位，如果前缀有 `0x` 或 `0o` 等会占用两个字符位。

来自[概述](./../convert_package_overview.md#功能介绍)。

示例：

<!-- verify -->
```cangjie
import std.convert.*

main() {
    var num: Int32 = 20
    println("\"${num.format("1")}\"") // 不会发生截断
    println("\"${num.format("3")}\"")
    println("\"${num.format("+4")}\"")
}
```

运行结果：

```text
"20"
" 20"
" +20"
```

### convert 参数 precision 的语法

- 精度为正整数，适用于 Int，UInt 和 Float。
- 对于浮点数表示小数点后的有效数字位数，如果不指定，那么则打印六位小数，如果小于数值本身有效数字的长度，那就四舍五入，如果大于就补全，补全的不一定是 0。
- 对于整数类型，不指定或者指定的数字小于数值本身的长度，则无效果，如果大于数值本身的长度，则在前面补全'0'。

来自[概述](./../convert_package_overview.md#功能介绍)。

示例：

<!-- verify -->
```cangjie
import std.convert.*

main() {
    var floatNum: Float32 = 1234.1
    println("\"${floatNum.format("20.20")}\"")
    var intNum: Int32 = -20
    println("\"${intNum.format("10.8")}\"")
}
```

运行结果：

```text
"1234.09997558593750000000"
" -00000020"
```

### convert 参数 specifier 的语法 1

'b' | 'B' | 'o' | 'O' | 'x' | 'X' 适用于 Int 和 UInt 类型。来自[概述](./../convert_package_overview.md#功能介绍)。

示例：

<!-- verify -->
```cangjie
import std.convert.*

main() {
    var num = 20
    println("\"${num.format("b")}\"")
    println("\"${num.format("o")}\"")
    println("\"${num.format("x")}\"")
    println("\"${num.format("X")}\"")
    println("\"${num.format("#X")}\"")
}
```

运行结果：

```text
"10100"
"24"
"14"
"14"
"0X14"
```

### convert 参数 specifier 的语法 2

'e' | 'E' | 'g' | 'G' 适用于 Float 类型。来自[概述](./../convert_package_overview.md#功能介绍)。

示例：

<!-- verify -->
```cangjie
import std.convert.*

main() {
    var num1: Float32 = 1234.1
    var num2: Float32 = 123412341234.1
    println("\"${num1.format("20.2e")}\"")
    println("\"${num1.format("20G")}\"")
    println("\"${num2.format("20G")}\"")
    println("\"${num1.format("20")}\"")
    println("\"${num2.format("20")}\"")
}
```

运行结果：

```text
"            1.23e+03"
"              1234.1"
"         1.23412E+11"
"         1234.099976"
" 123412340736.000000"
```