# 函数

## func all\<T>((T) -> Bool)

```cangjie
public func all<T>(predicate: (T) -> Bool): (Iterable<T>) -> Bool
```

功能：判断迭代器所有元素是否都满足条件。

参数：

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 返回一个判断全部满足条件的函数。

示例：

<!-- verify -->
```cangjie
import std.collection.*

func isPositive(x: Int64): Bool {
    return x > 0
}

main() {
    // 创建一个判断所有元素是否都大于0的函数
    let allPositive = all<Int64>(isPositive)
    
    // 测试所有元素都大于0的情况
    let list1 = ArrayList.of([1, 2, 3, 4, 5])
    let result1 = allPositive(list1)
    println("所有元素都大于0: ${result1}")
    
    // 测试有元素不大于0的情况
    let list2 = ArrayList.of([1, -2, 3, 4, 5])
    let result2 = allPositive(list2)
    println("所有元素都大于0: ${result2}")
    
    return 0
}
```

运行结果：

```text
所有元素都大于0: true
所有元素都大于0: false
```

## func any\<T>((T) -> Bool)

```cangjie
public func any<T>(predicate: (T) -> Bool): (Iterable<T>) -> Bool
```

功能：判断迭代器是否存在任意一个满足条件的元素。

参数：

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 返回一个判断存在任意一个满足条件的函数。

示例：

<!-- verify -->
```cangjie
import std.collection.*

func isNegative(x: Int64): Bool {
    return x < 0
}

main() {
    // 创建一个判断是否存在负数的函数
    let hasNegative = any<Int64>(isNegative)
    
    // 测试不存在负数的情况
    let list1 = ArrayList.of([1, 2, 3, 4, 5])
    let result1 = hasNegative(list1)
    println("存在负数: ${result1}")
    
    // 测试存在负数的情况
    let list2 = ArrayList.of([1, -2, 3, 4, 5])
    let result2 = hasNegative(list2)
    println("存在负数: ${result2}")
    
    return 0
}
```

运行结果：

```text
存在负数: false
存在负数: true
```

## func at\<T>(Int64)

```cangjie
public func at<T>(n: Int64): (Iterable<T>) -> Option<T>
```

功能：获取迭代器指定位置的元素。

参数：

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 给定的个数。

返回值：

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - 返回获取对应位置元素的函数，若迭代器为空则该函数返回 None。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个获取指定位置元素的函数
    let getElementAt = at<Int64>(2)
    
    // 测试获取存在的元素
    let list1 = ArrayList.of([10, 20, 30, 40, 50])
    let result1 = getElementAt(list1)
    match (result1) {
        case Some(value) => println("位置2的元素: ${value}")
        case None => println("位置2没有元素")
    }
    
    // 测试获取不存在的元素（超出范围）
    let list2 = ArrayList.of([10, 20])
    let result2 = getElementAt(list2)
    match (result2) {
        case Some(value) => println("位置2的元素: ${value}")
        case None => println("位置2没有元素")
    }
    
    return 0
}
```

运行结果：

```text
位置2的元素: 30
位置2没有元素
```

## func collectArrayList\<T>(Iterable\<T>)

```cangjie
public func collectArrayList<T>(it: Iterable<T>): ArrayList<T>
```

功能：将一个迭代器转换成 [ArrayList](collection_package_class.md#class-arraylistt) 类型。

参数：

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - 给定的迭代器。

返回值：

- [ArrayList](collection_package_class.md#class-arraylistt)\<T> - 返回一个 [ArrayList](collection_package_class.md#class-arraylistt)。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个数组
    let hashSet = [1, 2, 3, 4, 5]
    let iterator = hashSet.iterator()
    
    // 将迭代器转换为ArrayList
    let arrayList = collectArrayList<Int64>(iterator)
    println("ArrayList大小: ${arrayList.size}")
    println("ArrayList内容: ${arrayList}")
    
    return 0
}
```

运行结果：

```text
ArrayList大小: 5
ArrayList内容: [1, 2, 3, 4, 5]
```

## func collectArray\<T>(Iterable\<T>)

```cangjie
public func collectArray<T>(it: Iterable<T>): Array<T>
```

功能：将一个迭代器转换成 [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt) 类型。

参数：

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - 给定的迭代器。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - 返回一个数组。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个ArrayList
    let hashSet = [1, 2, 3, 4, 5]
    let iterator = hashSet.iterator()
    
    // 将迭代器转换为数组
    let array = collectArray<Int64>(iterator)
    println("数组大小: ${array.size}")
    println("数组内容: ${array}")
    
    return 0
}
```

运行结果：

```text
数组大小: 5
数组内容: [1, 2, 3, 4, 5]
```

## func collectHashMap\<K, V>(Iterable\<(K, V)>) where K <: Hashable & Equatable\<K>

```cangjie
public func collectHashMap<K, V>(it: Iterable<(K, V)>): HashMap<K, V> where K <: Hashable & Equatable<K>
```

功能：将一个迭代器转换成 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 类型。

参数：

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<(K, V)> - 给定的迭代器。

返回值：

- [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, V> - 返回一个 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个包含键值对的数组
    let pairs = [(1, "one"), (2, "two"), (3, "three")]
    let iterator = pairs.iterator()
    
    // 将迭代器转换为HashMap
    let hashMap = collectHashMap<Int64, String>(iterator)
    println("HashMap大小: ${hashMap.size}")
    println("HashMap内容: ${hashMap}")
    
    return 0
}
```

运行结果：

```text
HashMap大小: 3
HashMap内容: [(1, one), (2, two), (3, three)]
```

## func collectHashSet\<T>(Iterable\<T>) where T <: Hashable & Equatable\<T>

```cangjie
public func collectHashSet<T>(it: Iterable<T>): HashSet<T> where T <: Hashable & Equatable<T>
```

功能：将一个迭代器转换成 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 类型。

参数：

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - 给定的迭代器。

返回值：

- [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> - 返回一个 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个包含重复元素的数组
    let array = [1, 2, 2, 3, 3, 4, 5, 5]
    let iterator = array.iterator()
    
    // 将迭代器转换为HashSet（自动去重）
    let hashSet = collectHashSet<Int64>(iterator)
    println("HashSet大小: ${hashSet.size}")
    println("HashSet内容: ${hashSet}")
    
    return 0
}
```

运行结果：

```text
HashSet大小: 5
HashSet内容: [1, 2, 3, 4, 5]
```

## func collectString\<T>(String) where T <: ToString

```cangjie
public func collectString<T>(delimiter!: String = ""): (Iterable<T>) -> String where T <: ToString
```

功能：将一个对应元素实现了 [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) 接口的迭代器转换成 [String](../../core/core_package_api/core_package_structs.md#struct-string) 类型。

参数：

- delimiter!: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 字符串拼接分隔符。

返回值：

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [String](../../core/core_package_api/core_package_structs.md#struct-string) - 返回一个转换函数。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个将元素用逗号连接的函数
    let joinWithComma = collectString<Int64>(delimiter: ", ")
    
    // 创建一个数组
    let array = [1, 2, 3, 4, 5]
    let iterator = array.iterator()
    
    // 将迭代器转换为字符串
    let result = joinWithComma(iterator)
    println("连接结果: ${result}")
    
    // 创建另一个数组用于无分隔符连接
    let array2 = [1, 2, 3, 4, 5]
    let iterator2 = array2.iterator()
    
    // 创建一个无分隔符的连接函数
    let joinWithoutDelimiter = collectString<Int64>()
    let result2 = joinWithoutDelimiter(iterator2)
    println("无分隔符连接结果: ${result2}")
    
    return 0
}
```

运行结果：

```text
连接结果: 1, 2, 3, 4, 5
无分隔符连接结果: 12345
```

## func concat\<T>(Iterable\<T>)

```cangjie
public func concat<T>(other: Iterable<T>): (Iterable<T>) -> Iterator<T>
```

功能：串联两个迭代器。

参数：

- other: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - 要串联在后面的迭代器。

返回值：

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - 返回一个串联函数。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建两个数组
    let array1 = [1, 2, 3]
    let array2 = [4, 5, 6]
    
    // 获取第一个数组的迭代器
    let iterator1 = array1.iterator()
    
    // 创建一个串联函数
    let concatFunc = concat<Int64>(array2)
    
    // 串联两个迭代器
    let concatenated = concatFunc(iterator1)
    
    // 遍历串联后的迭代器
    var result = ""
    for (value in concatenated) {
        result = result + "${value} "
    }
    println("串联结果: ${result}")
    
    return 0
}
```

运行结果：

```text
串联结果: 1 2 3 4 5 6 
```

## func contains\<T>(T) where T <: Equatable\<T>

```cangjie
public func contains<T>(element: T): (Iterable<T>) -> Bool where T <: Equatable<T>
```

功能：获得一个针对特定元素的查找函数。

参数：

- element: T - 要查找的元素。

返回值：

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 返回一个查找函数。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    var searchFunc = contains<Int64>(6) // 获得查找元素 6 的函数
    let arr = ArrayList.of([1, 2, 3, 4, 5, 6])
    let i = arr.iterator()
    var result = searchFunc(i) // 调用函数
    println(result)
    searchFunc = contains<Int64>(7) // 获得查找元素 7 的函数
    result = searchFunc(i) // 调用函数
    println(result)
    return 0
}
```

运行结果：

```text
true
false
```

## func count\<T>(Iterable\<T>)

```cangjie
public func count<T>(it: Iterable<T>): Int64
```

功能：统计迭代器包含元素数量。

参数：

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - 给定的迭代器。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 返回迭代器包含元素数量。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个数组
    let array = [1, 2, 3, 4, 5]
    
    // 统计数组元素数量
    let countResult = count<Int64>(array)
    println("数组元素数量: ${countResult}")
    
    // 创建一个空数组
    let emptyArray: Array<Int64> = []
    
    // 统计空数组元素数量
    let emptyCount = count<Int64>(emptyArray)
    println("空数组元素数量: ${emptyCount}")
    
    return 0
}
```

运行结果：

```text
数组元素数量: 5
空数组元素数量: 0
```

## func enumerate\<T>(Iterable\<T>)

```cangjie
public func enumerate<T>(it: Iterable<T>): Iterator<(Int64, T)>
```

功能：用于获取带索引的迭代器。

参数：

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - 给定的迭代器。

返回值：

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<([Int64](../../core/core_package_api/core_package_intrinsics.md#int64), T)> - 返回一个带索引的迭代器。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个数组
    let array = ["a", "b", "c", "d"]
    
    // 获取带索引的迭代器
    let enumIterator = enumerate<String>(array)
    
    // 遍历带索引的迭代器
    println("带索引的元素:")
    for ((index, value) in enumIterator) {
        println("索引: ${index}, 值: ${value}")
    }
    
    return 0
}
```

运行结果：

```text
带索引的元素:
索引: 0, 值: a
索引: 1, 值: b
索引: 2, 值: c
索引: 3, 值: d
```

## func filter\<T>((T) -> Bool)

```cangjie
public func filter<T>(predicate: (T) -> Bool): (Iterable<T>) -> Iterator<T>
```

功能：筛选出满足条件的元素。

参数：

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - 返回一个筛选函数。

示例：

<!-- verify -->
```cangjie
import std.collection.*

func isEven(x: Int64): Bool {
    return x % 2 == 0
}

main() {
    // 创建一个数组
    let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    let iterator = array.iterator()
    
    // 创建一个筛选偶数的函数
    let filterEven = filter<Int64>(isEven)
    
    // 筛选出偶数
    let evenIterator = filterEven(iterator)
    
    // 遍历筛选后的结果
    var result = "偶数: "
    for (value in evenIterator) {
        result = result + "${value} "
    }
    println(result)
    
    return 0
}
```

运行结果：

```text
偶数: 2 4 6 8 10 
```

## func filterMap\<T, R>((T) -> ?R)

```cangjie
public func filterMap<T, R>(transform: (T) -> ?R): (Iterable<T>) -> Iterator<R>
```

功能：同时进行筛选操作和映射操作，返回一个新的迭代器。

参数：

- transform: (T) -> ?R - 给定的映射函数。函数返回值为 Some 对应 filter 的 predicate 为 true，反之表示 false。

返回值：

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<R> - 返回一个筛选和映射的函数。

示例：

<!-- verify -->
```cangjie
import std.collection.*

func parseInt(str: String): ?Int64 {
    // 简化的字符串转整数函数，只处理纯数字字符串
    if (str == "1") {
        return Some(1)
    }
    if (str == "2") {
        return Some(2)
    }
    if (str == "3") {
        return Some(3)
    }
    if (str == "4") {
        return Some(4)
    }
    if (str == "5") {
        return Some(5)
    }
    return None
}

main() {
    // 创建一个字符串数组
    let array = ["1", "2", "a", "3", "b", "4", "c", "5"]
    let iterator = array.iterator()
    
    // 创建一个筛选并转换的函数
    let parseAndFilter = filterMap<String, Int64>(parseInt)
    
    // 筛选并转换字符串为整数
    let parsedIterator = parseAndFilter(iterator)
    
    // 遍历筛选并转换后的结果
    var result = "解析的整数: "
    for (value in parsedIterator) {
        result = result + "${value} "
    }
    println(result)
    
    return 0
}
```

运行结果：

```text
解析的整数: 1 2 3 4 5 
```

## func first\<T>(Iterable\<T>)

```cangjie
public func first<T>(it: Iterable<T>): Option<T>
```

功能：获取头部元素。

参数：

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - 给定的迭代器。

返回值：

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - 返回头部元素，若为空则返回 None。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个数组
    let array = [10, 20, 30, 40, 50]
    
    // 获取第一个元素
    let firstElement = first<Int64>(array)
    match (firstElement) {
        case Some(value) => println("第一个元素: ${value}")
        case None => println("数组为空")
    }
    
    // 创建一个空数组
    let emptyArray: Array<Int64> = []
    
    // 尝试获取空数组的第一个元素
    let emptyFirst = first<Int64>(emptyArray)
    match (emptyFirst) {
        case Some(value) => println("第一个元素: ${value}")
        case None => println("数组为空")
    }
    
    return 0
}
```

运行结果：

```text
第一个元素: 10
数组为空
```

## func flatMap\<T, R>((T) -> Iterable\<R>)

```cangjie
public func flatMap<T, R>(transform: (T) -> Iterable<R>): (Iterable<T>) -> Iterator<R>
```

功能：创建一个带 [flatten](collection_package_function.md#func-flattent-riterablet-where-t--iterabler) 功能的映射。

参数：

- transform: (T) -> [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<R> - 给定的映射函数。

返回值：

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<R> - 返回一个带 [flatten](collection_package_function.md#func-flattent-riterablet-where-t--iterabler) 功能的映射函数。

示例：

<!-- verify -->
```cangjie
import std.collection.*

func getDivisors(n: Int64): ArrayList<Int64> {
    // 获取一个数的所有因数（简化实现）
    let result = ArrayList<Int64>()
    if (n == 1) {
        result.add(1)
        return result
    }
    if (n == 2) {
        result.add(1)
        result.add(2)
        return result
    }
    if (n == 3) {
        result.add(1)
        result.add(3)
        return result
    }
    if (n == 4) {
        result.add(1)
        result.add(2)
        result.add(4)
        return result
    }
    if (n == 5) {
        result.add(1)
        result.add(5)
        return result
    }
    if (n == 6) {
        result.add(1)
        result.add(2)
        result.add(3)
        result.add(6)
        return result
    }
    return result
}

main() {
    // 创建一个数组
    let array = [1, 2, 3, 4, 5, 6]
    
    // 创建一个flatMap函数
    let flatMapFunc = flatMap<Int64, Int64>(getDivisors)
    
    // 应用flatMap函数
    let flatIterator = flatMapFunc(array)
    
    // 遍历结果
    var result = "所有因数: "
    for (value in flatIterator) {
        result = result + "${value} "
    }
    println(result)
    
    return 0
}
```

运行结果：

```text
所有因数: 1 1 2 1 3 1 2 4 1 5 1 2 3 6 
```

## func flatten\<T, R>(Iterable\<T>) where T <: Iterable\<R>

```cangjie
public func flatten<T, R>(it: Iterable<T>): Iterator<R> where T <: Iterable<R>
```

功能：将嵌套的迭代器展开一层。

参数：

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - 给定的迭代器。

返回值：

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<R> - 返回展开一层后的迭代器。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个嵌套数组
    let nestedArray = [[1, 2], [3, 4], [5, 6]]
    
    // 展开嵌套数组
    let flattenedIterator = flatten<Array<Int64>, Int64>(nestedArray)
    
    // 遍历展开后的结果
    var result = "展开后的元素: "
    for (value in flattenedIterator) {
        result = result + "${value} "
    }
    println(result)
    
    return 0
}
```

运行结果：

```text
展开后的元素: 1 2 3 4 5 6 
```

## func fold\<T, R>(R, (R, T) -> R)

```cangjie
public func fold<T, R>(initial: R, operation: (R, T) -> R): (Iterable<T>) -> R
```

功能：使用指定初始值，从左向右计算。

参数：

- initial: R - 给定的 R 类型的初始值。
- operation: (R, T) -> R - 给定的计算函数。

返回值：

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> R - 返回一个折叠函数。

示例：

<!-- verify -->
```cangjie
import std.collection.*

func sumOperation(acc: Int64, value: Int64): Int64 {
    return acc + value
}

func concatOperation(acc: String, value: String): String {
    return acc + value
}

main() {
    // 创建一个数组
    let array = [1, 2, 3, 4, 5]
    
    // 创建一个求和的折叠函数
    let sumFold = fold<Int64, Int64>(0, sumOperation)
    
    // 计算数组元素的和
    let sumResult = sumFold(array)
    println("数组元素的和: ${sumResult}")
    
    // 创建一个连接字符串的折叠函数
    let stringArray = ["Hello", " ", "World", "!"]
    let concatFold = fold<String, String>("", concatOperation)
    
    // 连接字符串
    let concatResult = concatFold(stringArray)
    println("连接后的字符串: ${concatResult}")
    
    return 0
}
```

运行结果：

```text
数组元素的和: 15
连接后的字符串: Hello World!
```

## func forEach\<T>((T) -> Unit)

```cangjie
public func forEach<T>(action: (T) -> Unit): (Iterable<T>) -> Unit
```

功能：遍历所有元素，指定给定的操作。

参数：

- action: (T) -> [Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - 给定的操作函数。

返回值：

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - 返回一个执行遍历操作的函数。

示例：

<!-- verify -->
```cangjie
import std.collection.*

func printElement(element: Int64): Unit {
    println("元素: ${element}")
}

main() {
    // 创建一个数组
    let array = [1, 2, 3, 4, 5]
    let iterator = array.iterator()
    
    // 创建一个遍历并打印元素的函数
    let printFunc = forEach<Int64>(printElement)
    
    // 遍历并打印所有元素
    println("遍历数组元素:")
    printFunc(iterator)
    
    return 0
}
```

运行结果：

```text
遍历数组元素:
元素: 1
元素: 2
元素: 3
元素: 4
元素: 5
```

## func inspect\<T>((T) -> Unit)

```cangjie
public func inspect<T>(action: (T) -> Unit): (Iterable<T>) -> Iterator<T>
```

功能：迭代器每次调用 next() 对当前元素执行额外操作（不会消耗迭代器中元素）。

参数：

- action: (T) -> [Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - 给定的操作函数。

返回值：

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - 返回一个能对迭代器每个元素执行额外操作的函数。

示例：

<!-- verify -->
```cangjie
import std.collection.*

var inspectionCount: Int64 = 0

func inspectElement(element: Int64): Unit {
    inspectionCount = inspectionCount + 1
    println("检查元素: ${element} (检查次数: ${inspectionCount})")
}

main() {
    // 创建一个数组
    let array = [10, 20, 30, 40, 50]
    let iterator = array.iterator()
    
    // 创建一个检查函数
    let inspectFunc = inspect<Int64>(inspectElement)
    
    // 应用检查函数
    let inspectedIterator = inspectFunc(iterator)
    
    // 遍历迭代器（检查函数会在每次调用next()时执行）
    println("遍历并检查元素:")
    for (value in inspectedIterator) {
        println("处理元素: ${value}")
    }
    
    return 0
}
```

运行结果：

```text
遍历并检查元素:
检查元素: 10 (检查次数: 1)
处理元素: 10
检查元素: 20 (检查次数: 2)
处理元素: 20
检查元素: 30 (检查次数: 3)
处理元素: 30
检查元素: 40 (检查次数: 4)
处理元素: 40
检查元素: 50 (检查次数: 5)
处理元素: 50
```

## func isEmpty\<T>(Iterable\<T>)

```cangjie
public func isEmpty<T>(it: Iterable<T>): Bool
```

功能：判断迭代器是否为空。

参数：

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - 给定的迭代器。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 返回迭代器是否为空。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个非空数组
    let array = [1, 2, 3, 4, 5]
    
    // 检查数组是否为空
    let isEmptyResult = isEmpty<Int64>(array)
    println("数组是否为空: ${isEmptyResult}")
    
    // 创建一个空数组
    let emptyArray: Array<Int64> = []
    
    // 检查空数组是否为空
    let isEmptyEmpty = isEmpty<Int64>(emptyArray)
    println("空数组是否为空: ${isEmptyEmpty}")
    
    return 0
}
```

运行结果：

```text
数组是否为空: false
空数组是否为空: true
```

## func last\<T>(Iterable\<T>)

```cangjie
public func last<T>(it: Iterable<T>): Option<T>
```

功能：获取尾部元素。

参数：

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - 给定的迭代器。

返回值：

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - 返回尾部元素，若为空则返回 None。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个数组
    let array = [10, 20, 30, 40, 50]
    
    // 获取最后一个元素
    let lastElement = last<Int64>(array)
    match (lastElement) {
        case Some(value) => println("最后一个元素: ${value}")
        case None => println("数组为空")
    }
    
    // 创建一个空数组
    let emptyArray: Array<Int64> = []
    
    // 尝试获取空数组的最后一个元素
    let emptyLast = last<Int64>(emptyArray)
    match (emptyLast) {
        case Some(value) => println("最后一个元素: ${value}")
        case None => println("数组为空")
    }
    
    return 0
}
```

运行结果：

```text
最后一个元素: 50
数组为空
```

## func map\<T, R>((T) -> R)

```cangjie
public func map<T, R>(transform: (T) -> R): (Iterable<T>) -> Iterator<R>
```

功能：创建一个映射。

参数：

- transform: (T) ->R - 给定的映射函数。

返回值：

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<R> - 返回一个映射函数。

示例：

<!-- verify -->
```cangjie
import std.collection.*

func square(x: Int64): Int64 {
    return x * x
}

main() {
    // 创建一个数组
    let array = [1, 2, 3, 4, 5]
    let iterator = array.iterator()
    
    // 创建一个映射函数（计算平方）
    let squareMap = map<Int64, Int64>(square)
    
    // 应用映射函数
    let squaredIterator = squareMap(iterator)
    
    // 遍历映射后的结果
    var result = "平方值: "
    for (value in squaredIterator) {
        result = result + "${value} "
    }
    println(result)
    
    return 0
}
```

运行结果：

```text
平方值: 1 4 9 16 25 
```

## func max\<T>(Iterable\<T>) where T <: Comparable\<T>

```cangjie
public func max<T>(it: Iterable<T>): Option<T> where T <: Comparable<T>
```

功能：筛选最大的元素。

参数：

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - 给定的迭代器。

返回值：

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - 返回最大的元素，若为空则返回 None。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个数组
    let array = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3]
    
    // 获取最大元素
    let maxElement = max<Int64>(array)
    match (maxElement) {
        case Some(value) => println("最大元素: ${value}")
        case None => println("数组为空")
    }
    
    // 创建一个空数组
    let emptyArray: Array<Int64> = []
    
    // 尝试获取空数组的最大元素
    let emptyMax = max<Int64>(emptyArray)
    match (emptyMax) {
        case Some(value) => println("最大元素: ${value}")
        case None => println("数组为空")
    }
    
    return 0
}
```

运行结果：

```text
最大元素: 9
数组为空
```

## func min\<T>(Iterable\<T>) where T <: Comparable\<T>

```cangjie
public func min<T>(it: Iterable<T>): Option<T> where T <: Comparable<T>
```

功能：筛选最小的元素。

参数：

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - 给定的迭代器。

返回值：

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - 返回最小的元素，若为空则返回 None。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个数组
    let array = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3]
    
    // 获取最小元素
    let minElement = min<Int64>(array)
    match (minElement) {
        case Some(value) => println("最小元素: ${value}")
        case None => println("数组为空")
    }
    
    // 创建一个空数组
    let emptyArray: Array<Int64> = []
    
    // 尝试获取空数组的最小元素
    let emptyMin = min<Int64>(emptyArray)
    match (emptyMin) {
        case Some(value) => println("最小元素: ${value}")
        case None => println("数组为空")
    }
    
    return 0
}
```

运行结果：

```text
最小元素: 1
数组为空
```

## func none\<T>((T) -> Bool)

```cangjie
public func none<T>(predicate: (T) -> Bool): (Iterable<T>) -> Bool
```

功能：判断迭代器中所有元素是否都不满足条件。

参数：

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 返回一个判断都不满足条件的函数。

示例：

<!-- verify -->
```cangjie
import std.collection.*

func isNegative(x: Int64): Bool {
    return x < 0
}

main() {
    // 创建一个判断是否都不为负数的函数
    let allNonNegative = none<Int64>(isNegative)
    
    // 测试所有元素都不为负数的情况
    let list1 = ArrayList.of([1, 2, 3, 4, 5])
    let result1 = allNonNegative(list1)
    println("所有元素都不为负数: ${result1}")
    
    // 测试有负数元素的情况
    let list2 = ArrayList.of([1, -2, 3, 4, 5])
    let result2 = allNonNegative(list2)
    println("所有元素都不为负数: ${result2}")
    
    return 0
}
```

运行结果：

```text
所有元素都不为负数: true
所有元素都不为负数: false
```

## func reduce\<T>((T, T) -> T)

```cangjie
public func reduce<T>(operation: (T, T) -> T): (Iterable<T>) -> Option<T>
```

功能：使用第一个元素作为初始值，从左向右计算。

参数：

- operation: (T, T) -> T - 给定的操作函数。

返回值：

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - 返回一个归并函数。

示例：

<!-- verify -->
```cangjie
import std.collection.*

func sumOperation(x: Int64, y: Int64): Int64 {
    return x + y
}

main() {
    // 创建一个数组
    let array = [1, 2, 3, 4, 5]
    
    // 创建一个求和的归并函数
    let sumReduce = reduce<Int64>(sumOperation)
    
    // 计算数组元素的和
    let sumResult = sumReduce(array)
    match (sumResult) {
        case Some(value) => println("数组元素的和: ${value}")
        case None => println("数组为空")
    }
    
    // 创建一个空数组
    let emptyArray: Array<Int64> = []
    
    // 尝试计算空数组的和
    let emptySum = sumReduce(emptyArray)
    match (emptySum) {
        case Some(value) => println("数组元素的和: ${value}")
        case None => println("数组为空")
    }
    
    return 0
}
```

运行结果：

```text
数组元素的和: 15
数组为空
```

## func skip\<T>(Int64)

```cangjie
public func skip<T>(count: Int64): (Iterable<T>) -> Iterator<T>
```

功能：从迭代器跳过特定个数。

当 count 小于 0 时，抛出异常。当 count 等于 0 时，相当没有跳过任何元素，返回原迭代器。当 count 大于0并且count小于迭代器的大小时，跳过 count 个元素后，返回含有剩下的元素的新迭代器。当 count 大于等于迭代器的大小时，跳过所有元素，返回空迭代器。

参数：

- count: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 要跳过的个数。

返回值：

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - 返回一个跳过指定数量元素的函数。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当 count < 0 时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个数组
    let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    let iterator = array.iterator()
    
    // 创建一个跳过前3个元素的函数
    let skipFunc = skip<Int64>(3)
    
    // 跳过前3个元素
    let skippedIterator = skipFunc(iterator)
    
    // 遍历剩余元素
    var result = "跳过前3个元素后: "
    for (value in skippedIterator) {
        result = result + "${value} "
    }
    println(result)
    
    return 0
}
```

运行结果：

```text
跳过前3个元素后: 4 5 6 7 8 9 10 
```

## func step\<T>(Int64)

```cangjie
public func step<T>(count: Int64): (Iterable<T>) -> Iterator<T>
```

功能：迭代器每次调用 next() 指针移动的个数。例如：如果为 1，每次迭代器指针向后移动 1 位（即 next() 原本行为），如果为 2， 每次迭代器指针向后移动 2 位。

当 count 小于等于 0 时，抛出异常。当 count 大于 0 时，每次调用 next() 跳过 count 次，直到迭代器为空。

参数：

- count: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 每次调用 next() 指针移动的个数。

返回值：

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - 返回一个指针移动个数经过改变的迭代器。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当 count <= 0 时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个数组
    let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    let iterator = array.iterator()
    
    // 创建一个指针移动2个元素的函数
    let stepFunc = step<Int64>(2)
    
    // 应用函数
    let steppedIterator = stepFunc(iterator)
    
    // 遍历步进后的元素
    var result = "隔1个元素取一个: "
    for (value in steppedIterator) {
        result = result + "${value} "
    }
    println(result)
    
    return 0
}
```

运行结果：

```text
隔1个元素取一个: 1 3 5 7 9 
```

## func take\<T>(Int64)

```cangjie
public func take<T>(count: Int64): (Iterable<T>) -> Iterator<T>
```

功能：从迭代器取出特定个数。

当 count 小于 0 时，抛出异常。当 count 等于 0 时，不取元素，返回空迭代器。当 count 大于 0 小于迭代器的大小时，取前 count 个元素，返回新迭代器。当 count 大于等于迭代器的大小时，取所有元素，返回原迭代器。

参数：

- count: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 要取出的个数。

返回值：

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - 返回一个取出指定数量元素的函数。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当 count < 0 时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个数组
    let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    let iterator = array.iterator()
    
    // 创建一个取出前5个元素的函数
    let takeFunc = take<Int64>(5)
    
    // 取出前5个元素
    let takenIterator = takeFunc(iterator)
    
    // 遍历取出的元素
    var result = "前5个元素: "
    for (value in takenIterator) {
        result = result + "${value} "
    }
    println(result)
    
    return 0
}
```

运行结果：

```text
前5个元素: 1 2 3 4 5 
```

## func zip\<T, R>(Iterable\<R>)

```cangjie
public func zip<T, R>(other: Iterable<R>): (Iterable<T>) -> Iterator<(T, R)>
```

功能：将两个迭代器合并成一个（长度取决于短的那个迭代器）。

参数：

- other: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<R> - 要合并的其中一个迭代器。

返回值：

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<(T, R)> - 返回一个合并函数。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建两个数组
    let numbers = [1, 2, 3, 4, 5]
    let letters = ["a", "b", "c", "d", "e"]
    
    // 获取第一个数组的迭代器
    let numberIterator = numbers.iterator()
    
    // 创建一个合并函数
    let zipFunc = zip<Int64, String>(letters)
    
    // 合并两个迭代器
    let zippedIterator = zipFunc(numberIterator)
    
    // 遍历合并后的元素
    println("合并后的元素:")
    for ((num, letter) in zippedIterator) {
        println("${num}: ${letter}")
    }
    
    return 0
}
```

运行结果：

```text
合并后的元素:
1: a
2: b
3: c
4: d
5: e
```