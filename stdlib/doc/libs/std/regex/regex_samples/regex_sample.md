# Regex 示例

## Regex 匹配大小写

示例：

<!-- verify -->
```cangjie
import std.regex.*

main(): Unit {
    // 默认区分大小写
    let caseRegex = Regex("ab")

    // 指定 IgnoreCase 选项后忽略大小写
    let ignoreCaseRegex = Regex("ab", IgnoreCase)

    match (caseRegex.find("aB")) {
        case Some(r) => println("区分大小写的匹配结果: ${r.matchString()}")
        case None => println("区分大小写的匹配结果: None")
    }
    match (ignoreCaseRegex.find("aB")) {
        case Some(r) => println("忽略大小写的匹配结果: ${r.matchString()}")
        case None => println("忽略大小写的匹配结果: None")
    }
}
```

运行结果：

```text
区分大小写的匹配结果: None
忽略大小写的匹配结果: aB
```

## Regex 匹配多行

示例：

<!-- verify -->
```cangjie
import std.regex.*

main(): Unit {
    let pattern = ##"^(\w+)\s(\d+)*$"##
    let input: String = """
Joe 164
Sam 208
Allison 211
Gwen 171
"""

    // 指定 MultiLine 选项后，^ 和 $ 按行匹配
    let regex = Regex(pattern, MultiLine)
    for (md in regex.findAll(input)) {
        println(md.matchString())
    }
}
```

运行结果：

```text
Joe 164
Sam 208
Allison 211
Gwen 171
```

## Regex 匹配 Unicode

示例：

<!-- verify -->
```cangjie
import std.regex.*

main(): Unit {
    // 打印匹配结果及其位置区间
    let printMatchData: (MatchData) -> Unit = {
        md =>
            println("匹配到: `${md.matchString()}`")
            let position = md.matchPosition()
            println("位置: [${position.start}, ${position.end})")
    }

    let unicodePattern = "(?:[\u{2460}\u{2461}\u{2462}\u{2463}\u{2464}\u{2465}\u{2466}\u{2467}\u{2468}]{2,4})"
    let unicodeInput = "\u{2460}\u{2461}  \u{2464}\u{2465}"

    // 未启用 Unicode 选项时，遇到非 ASCII 字符会抛出异常
    println("#未启用 Unicode: ")
    try {
        for (md in Regex(unicodePattern).lazyFindAll(unicodeInput)) {
            printMatchData(md)
        }
    } catch (e: IllegalArgumentException) {
        println(e)
    }

    // 启用 Unicode 选项后可以正常匹配
    println("\n#启用 Unicode: ")
    for (md in Regex(unicodePattern, Unicode).lazyFindAll(unicodeInput)) {
        printMatchData(md)
    }

    // 启用 Unicode 选项后，也可以在模式串中直接使用 Unicode 字面量
    println("\n#启用 Unicode 并直接使用字面量: ")
    let unicodeLiteralPattern = "(?:[①②③④⑤⑥⑦⑧⑨]{2,4})"
    let unicodeLiteralInput = "①②  ⑤⑥"
    for (md in Regex(unicodeLiteralPattern, Unicode).lazyFindAll(unicodeLiteralInput)) {
        printMatchData(md)
    }
}
```

运行结果：

```text
#未启用 Unicode: 
IllegalArgumentException: Invalid UTF-8 byte sequence: index '4' is not a code point boundary.

#启用 Unicode: 
匹配到: `①②`
位置: [0, 6)
匹配到: `⑤⑥`
位置: [8, 14)

#启用 Unicode 并直接使用字面量: 
匹配到: `①②`
位置: [0, 6)
匹配到: `⑤⑥`
位置: [8, 14)
```

## Regex 和 MatchData 的使用

示例：

<!-- verify -->
```cangjie
import std.regex.*

main(): Unit {
    let regex = Regex(#"a\wa"#)
    for (md in regex.findAll("1aba12ada555")) {
        println("匹配到: ${md.matchString()}")
        let position = md.matchPosition()
        println("位置: [${position.start}, ${position.end})")
    }
}
```

运行结果：

```text
匹配到: aba
位置: [1, 4)
匹配到: ada
位置: [6, 9)
```

## Regex 中 replace/replaceAll 函数

示例：

<!-- verify -->
```cangjie
import std.regex.*

main(): Unit {
    let regex = Regex("\\d")

    // 用 X 替换第一个数字
    println("替换第一个数字: ${regex.replace("a1b1c2d3f4", "X")}")

    // 用 X 替换 index 为 2 之后出现的第一个数字
    println("从 index 2 开始替换第一个数字: ${regex.replace("a1b1c2d3f4", "X", 2)}")

    // 用 X 替换所有数字
    println("替换所有数字: ${regex.replaceAll("a1b1c2d3f4", "X")}")

    // 用 X 替换 index 为 2 之后出现的所有数字
    println("从 index 2 开始替换所有数字: ${regex.replaceAll("a1b1c2d3f4", "X", 2)}")

    // start 传 -1 与不传 start 等价，即从头开始替换
    println("替换所有数字（start 为 -1）: ${regex.replaceAll("a1b1c2d3f4", "X", -1)}")
}
```

运行结果：

```text
替换第一个数字: aXb1c2d3f4
从 index 2 开始替换第一个数字: a1bXc2d3f4
替换所有数字: aXbXcXdXfX
从 index 2 开始替换所有数字: aXbXc2d3f4
替换所有数字（start 为 -1）: aXbXcXdXfX
```

## MatchData 中捕获组的使用

示例：

<!-- verify -->
```cangjie
import std.regex.*

main(): Unit {
    let regex = Regex(#"(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})"#)
    for (md in regex.lazyFindAll("2024-10-24&2025-01-01", group: true)) {
        println("# 匹配到: `${md.matchString()}`，捕获组数量: ${md.groupCount()}")
        if (md.groupCount() > 0) {
            // 按索引遍历各捕获组
            for (i in 0..=md.groupCount()) {
                println("group[${i}] : ${md.matchString(i)}")
                let position = md.matchPosition(i)
                println("位置: [${position.start}, ${position.end})")
            }
        }

        // 按名称遍历各捕获组
        for ((name, index) in regex.getNamedGroups()) {
            let position = md.matchPosition(name)
            println(
                "${name} 是第 ${index} 组, 位置: [${position.start}, ${position.end}), 捕获: ${md.matchString(name)}")
        }
    }
}
```

运行结果：

```text
# 匹配到: `2024-10-24`，捕获组数量: 3
group[0] : 2024-10-24
位置: [0, 10)
group[1] : 2024
位置: [0, 4)
group[2] : 10
位置: [5, 7)
group[3] : 24
位置: [8, 10)
day 是第 3 组, 位置: [8, 10), 捕获: 24
month 是第 2 组, 位置: [5, 7), 捕获: 10
year 是第 1 组, 位置: [0, 4), 捕获: 2024
# 匹配到: `2025-01-01`，捕获组数量: 3
group[0] : 2025-01-01
位置: [11, 21)
group[1] : 2025
位置: [11, 15)
group[2] : 01
位置: [16, 18)
group[3] : 01
位置: [19, 21)
day 是第 3 组, 位置: [19, 21), 捕获: 01
month 是第 2 组, 位置: [16, 18), 捕获: 01
year 是第 1 组, 位置: [11, 15), 捕获: 2025
```
