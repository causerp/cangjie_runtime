# std.convert

## 功能介绍

convert 包提供从字符串转到特定类型的 Convert 系列函数。

例如字符串 "true" 到布尔类型 `true` 的转换以及字符串 "123" 到整数类型 `123` 的转换等。

convert 包提供格式化能力，主要为将仓颉类型实例转换为格式化字符串。

定义了接口 Formattable，用于规定统一的格式化方法，并为 Int8、Int16 等一系列仓颉类型实现了该接口，用户也可以自行为其他类型实现该接口以获取格式化功能。

将仓颉类型转换为字符串时，可根据格式化参数规定字符串格式，如宽度、对齐方式等。（在 Formattable 接口定义的方法中，格式化参数将作为函数入参。）

格式化参数的详细语法说明如下：

```text
format_spec := [flags][width][.precision][specifier]
flags := '-' | '+' | '#' | '0'
width := integer
precision := integer
specifier := 'b' | 'B' | 'o' | 'O' | 'x' | 'X' | 'e' | 'E' | 'g' | 'G'
```

参数 flags：

- '-' 适用于 Int，UInt，Rune 和 Float，表示左对齐。见[参数示例 flag1](./convert_samples/convert_samples.md#convert-参数-flag-的语法-1)。
- '+' 适用于 Int，UInt 和 Float，如果数值为正数则打出 '+' 符号，如果数值为负数则忽略。见[参数示例 flag2](./convert_samples/convert_samples.md#convert-参数-flag-的语法-2)。
- '#' 是针对进制打印的，对于二进制打印会补充一个 '0b' 或者 '0B'，对于八进制打印会补充一个 '0o' 或者 '0O'，对于十六进制会补充 '0x' 或者 '0X'。见[参数示例 flag3](./convert_samples/convert_samples.md#convert-参数-flag-的语法-3)。
- '0' 适用于 Int，UInt 和 Float，在空位补充 0。见[参数示例 flag4](./convert_samples/convert_samples.md#convert-参数-flag-的语法-4)。

参数 width 宽度：

- 宽度为正整数，适用于 Int，UInt，Rune 和 Float。见[参数示例 width](./convert_samples/convert_samples.md#convert-参数-width-的语法)。
- 宽度前有负号则表示左对齐，没有负号则是右对齐，如果数值小于数值本身的长度，不会发生截断。
- 如果前缀有 `+` 或 `-` 符号会占用一个字符位，如果前缀有 `0x` 或 `0o` 等会占用两个字符位。

参数 precision 精度:

- 精度为正整数，适用于 Int，UInt 和 Float。见[参数示例 precision](./convert_samples/convert_samples.md#convert-参数-precision-的语法)。
- 对于浮点数表示小数点后的有效数字位数，如果不指定，那么则打印六位小数，如果小于数值本身有效数字的长度，那就四舍五入，如果大于就补全，补全的不一定是 0。
- 对于整数类型，不指定或者指定的数字小于数值本身的长度，则无效果，如果大于数值本身的长度，则在前面补全'0'。

参数 specifier:

- 'b' | 'B' | 'o' | 'O' | 'x' | 'X' 适用于 Int 和 UInt 类型。见[参数示例 specifier1](./convert_samples/convert_samples.md#convert-参数-specifier-的语法-1)。

  'b' | 'B' : 表示二进制格式打印

  'o' | 'O' : 表示八进制格式打印

  'x' | 'X' : 表示十六进制格式打印

- 'e' | 'E' | 'g' | 'G' 适用于 Float 类型。见[参数示例 specifier2](./convert_samples/convert_samples.md#convert-参数-specifier-的语法-2)。

  'e' | 'E' : 科学计数法，小写和大写

  'g' | 'G' : general，用十进制或者科学计数法表示，会选择精简的表示方式进行打印

## API 列表

### 接口

|              接口名          |           功能           |
| --------------------------- | ------------------------ |
| [Formattable](./convert_package_api/convert_package_interfaces.md#interface-formattable) | 该接口定义了格式化函数，即根据格式化参数将指定类型实例转换为对应格式的字符串。 |
| [Parsable\<T>](./convert_package_api/convert_package_interfaces.md#interface-parsablet) | 将字符串解析为特定类型的接口。 |
| [RadixConvertible\<T>](./convert_package_api/convert_package_interfaces.md#interface-radixconvertiblet) | 将指定字符串解析为特定类型的接口。 |
