# 类

## class ArrayDeque\<T>

```cangjie
public class ArrayDeque<T> <: Deque<T> {
    public init()
    public init(capacity: Int64)
}
```

功能：ArrayDeque 是双端队列（deque）实现类，可以在双端队列的两端进行元素的插入和删除操作。ArrayDeque 是根据可调整大小的数组实现的，其容量会在插入元素的过程中不断地增长，默认每次扩容 50% 大小。ArrayDeque 的实现采用了循环队列的方式，在没有扩容的情况下，其插入、删除、查看等操作的时间复杂度为 O(1)。

父类型：

- [Deque](./collection_package_interface.md#interface-dequet)\<T>

### prop capacity

```cangjie
public prop capacity: Int64
```

功能：获取此双端队列的容量。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let deque = ArrayDeque<Int64>()
    
    // 初始容量为8
    println("初始容量: ${deque.capacity}")  // 8
    
    // 指定容量构造
    let deque2 = ArrayDeque<Int64>(16)
    println("指定容量: ${deque2.capacity}")  // 16
    
    return 0
}
```

运行结果：

```text
初始容量: 8
指定容量: 16
```

### prop first

```cangjie
public prop first: ?T
```

功能：获取双端队列的头部元素。如果双端队列为空，返回 None。

类型：?T

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let deque = ArrayDeque<Int64>()
    deque.addLast(1)
    deque.addLast(2)
    
    let first = deque.first
    println("队列头部元素: ${first}")  // Some(1)
    
    let emptyDeque = ArrayDeque<String>()
    let noneFirst = emptyDeque.first
    println("空队列头部元素: ${noneFirst}")  // None
    
    return 0
}
```

运行结果：

```text
队列头部元素: Some(1)
空队列头部元素: None
```

### prop last

```cangjie
public prop last: ?T
```

功能：获取双端队列的尾部元素。如果双端队列为空，返回 None。

类型：?T

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let deque = ArrayDeque<Int64>()
    deque.addLast(1)
    deque.addLast(2)
    
    let last = deque.last
    println("队列尾部元素: ${last}")  // Some(2)
    
    let emptyDeque = ArrayDeque<String>()
    let noneLast = emptyDeque.last
    println("空队列尾部元素: ${noneLast}")  // None
    
    return 0
}
```

运行结果：

```text
队列尾部元素: Some(2)
空队列尾部元素: None
```

### prop size

```cangjie
public prop size: Int64
```

功能：返回此双端队列中的元素个数。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let deque = ArrayDeque<Int64>()
    println("初始大小: ${deque.size}")  // 0
    
    deque.addLast(1)
    deque.addLast(2)
    println("添加2个元素后大小: ${deque.size}")  // 2
    
    deque.removeFirst()
    println("删除1个元素后大小: ${deque.size}")  // 1
    
    return 0
}
```

运行结果：

```text
初始大小: 0
添加2个元素后大小: 2
删除1个元素后大小: 1
```

### init()

```cangjie
public init()
```

功能：构造一个空的双端队列，其容量大小为默认值 8。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let deque = ArrayDeque<Int64>()
    println("初始大小: ${deque.size}")      // 0
    println("初始容量: ${deque.capacity}")  // 8
    println("是否为空: ${deque.isEmpty()}") // true
    return 0
}
```

运行结果：

```text
初始大小: 0
初始容量: 8
是否为空: true
```

### init(Int64)

```cangjie
public init(capacity: Int64)
```

功能：构造一个具有指定容量的双端队列，当 capacity 小于默认容量 8 时，构造的 [ArrayDeque](#class-arraydequet) 初始容量为 8 。

参数：

- capacity: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 指定的初始容量。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果参数的大小小于 0 则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 指定容量大于默认容量
    let deque1 = ArrayDeque<Int64>(16)
    println("指定容量16的初始容量: ${deque1.capacity}")  // 16
    
    // 指定容量小于默认容量
    let deque2 = ArrayDeque<Int64>(4)
    println("指定容量4的初始容量: ${deque2.capacity}")   // 8
    
    return 0
}
```

运行结果：

```text
指定容量16的初始容量: 16
指定容量4的初始容量: 8
```

### func addFirst(T)

```cangjie
public func addFirst(element: T): Unit
```

功能：在此双端队列头部插入元素。

参数：

- element: T - 被插入到此双端队列的元素。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let deque = ArrayDeque<String>()
    
    // 在队列头部添加元素
    deque.addFirst("world")
    deque.addFirst("hello")
    
    println("队列内容: ${deque}")
    println("队列大小: ${deque.size}")
    println("队列头部元素: ${deque.first}")
    println("队列尾部元素: ${deque.last}")
    
    return 0
}
```

运行结果：

```text
队列内容: [hello, world]
队列大小: 2
队列头部元素: Some(hello)
队列尾部元素: Some(world)
```

### func addLast(T)

```cangjie
public func addLast(element: T): Unit
```

功能：在此双端队列尾部插入元素。

参数：

- element: T - 被插入到此双端队列的元素。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let deque = ArrayDeque<Int64>()
    deque.addLast(1)
    deque.addLast(2)
    println(deque)  // [1, 2]
    return 0
}
```

运行结果：

```text
[1, 2]
```

### func clear()

```cangjie
public func clear(): Unit
```

功能：清空此双端队列中的所有元素。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let deque = ArrayDeque<Int64>(4)
    deque.addLast(1)
    deque.addLast(2)
    deque.clear()
    println("队列是否为空: ${deque.isEmpty()}")  // true
    return 0
}
```

运行结果：

```text
队列是否为空: true
```

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

功能：判断此双端队列是否为空。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果为空，则返回 `true`，否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let deque1 = ArrayDeque<Int64>()
    let deque2 = ArrayDeque<Int64>()
    deque2.addLast(1)
    
    println("deque1是否为空: ${deque1.isEmpty()}")  // true
    println("deque2是否为空: ${deque2.isEmpty()}")  // false
    return 0
}
```

运行结果：

```text
deque1是否为空: true
deque2是否为空: false
```

### func iterator()

```cangjie
public func iterator(): Iterator<T>
```

功能：获取此双端队列中元素的迭代器，其顺序为从前到后的顺序。

返回值：

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - 元素的迭代器。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let deque = ArrayDeque<Int64>()
    deque.addLast(1)
    deque.addLast(2)
    deque.addLast(3)
    
    // 使用for循环遍历
    for (element in deque) {
        println(element)
    }
    return 0
}
```

运行结果：

```text
1
2
3
```

### func removeFirst()

```cangjie
public func removeFirst(): ?T
```

功能：删除双端队列中的头部元素并返回该值，如果此双端队列为空，返回 `None`。

返回值：

- ?T - 被删除的头部元素。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let deque = ArrayDeque<Int64>()
    deque.addLast(1)
    deque.addLast(2)
    
    let first = deque.removeFirst()
    println("删除的元素: ${first}")  // Some(1)
    println("删除后的队列: ${deque}")  // [2]
    
    let emptyDeque = ArrayDeque<Int64>()
    let noneElement = emptyDeque.removeFirst()
    println("从空队列删除的元素: ${noneElement}")  // None
    return 0
}
```

运行结果：

```text
删除的元素: Some(1)
删除后的队列: [2]
从空队列删除的元素: None
```

### func removeLast()

```cangjie
public func removeLast(): ?T
```

功能：删除双端队列中的尾部元素并返回该值，如果此双端队列为空，返回 `None`。

返回值：

- ?T - 被删除的尾部元素。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let deque = ArrayDeque<Int64>()
    deque.addLast(1)
    deque.addLast(2)
    
    let last = deque.removeLast()
    println("删除的元素: ${last}")  // Some(2)
    println("删除后的队列: ${deque}")  // [1]
    
    let emptyDeque = ArrayDeque<Int64>()
    let noneElement = emptyDeque.removeLast()
    println("从空队列删除的元素: ${noneElement}")  // None
    return 0
}
```

运行结果：

```text
删除的元素: Some(2)
删除后的队列: [1]
从空队列删除的元素: None
```

### func reserve(Int64)

```cangjie
public func reserve(additional: Int64): Unit
```

功能：增加此双端队列的容量。

将双端队列扩容 additional 大小，当 additional 小于等于零时，不发生扩容；当此双端队列剩余容量大于等于 additional 时，不发生扩容；当此双端队列剩余容量小于 additional 时，取（原始容量的1.5倍向下取整）与（additional + 已使用容量）两个值中的最大值进行扩容。

参数：

- additional: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 将要扩容的大小。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let deque = ArrayDeque<Int64>()
    
    // 初始容量为8
    println("初始容量: ${deque.capacity}")  // 8
    
    // 预留空间
    deque.reserve(10)
    println("预留10个元素后的容量: ${deque.capacity}")  // 12
    
    // 添加元素
    for (i in 0..5) {
        deque.addLast(i)
    }
    println("添加5个元素后容量: ${deque.capacity}")   // 12
    println("添加5个元素后大小: ${deque.size}")       // 5
    
    return 0
}
```

运行结果：

```text
初始容量: 8
预留10个元素后的容量: 12
添加5个元素后容量: 12
添加5个元素后大小: 5
```

### func toArray()

```cangjie
public func toArray(): Array<T>
```

功能：返回一个数组，其包含此双端队列中的所有元素，且顺序为从前到后的顺序。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - T 类型数组。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let deque = ArrayDeque<Int64>()
    deque.addLast(1)
    deque.addLast(2)
    deque.addLast(3)
    
    let array = deque.toArray()
    println(array)  // [1, 2, 3]
    return 0
}
```

运行结果：

```text
[1, 2, 3]
```

### extend\<T> ArrayDeque\<T> <: ToString where T <: ToString

```cangjie
extend<T> ArrayDeque<T> <: ToString where T <: ToString
```

功能：为 [ArrayDeque](./collection_package_class.md#class-arraydequet)\<T> 扩展 [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) 接口，支持转字符串操作。

父类型：

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

功能：获取当前[ArrayDeque](./collection_package_class.md#class-arraydequet)\<T>实例的字符串表示。

该字符串包含双端队列内每个元素的字符串表示，其顺序为从前到后的顺序，形如："[elem1, elem2, elem3]"。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 转换得到的字符串。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let deque = ArrayDeque<Int64>()
    deque.addLast(1)
    deque.addLast(2)
    deque.addLast(3)
    println(deque.toString())  // [1, 2, 3]
    return 0
}
```

运行结果：

```text
[1, 2, 3]
```

## class ArrayList\<T>

```cangjie
public class ArrayList<T> <: List<T> {
    public init()
    public init(capacity: Int64)
    public init(size: Int64, initElement: (Int64) -> T)
    public init(elements: Collection<T>)
}
```

功能：提供可变长度的数组的功能。

[ArrayList](collection_package_class.md#class-arraylistt) 是一种线性的动态数组，与 [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt) 不同，它可以根据需要自动调整大小，并且在创建时不需要指定大小。

> **说明：**
>
> - 当向动态数组中添加元素时，如果数组已满，则会重新分配更大的内存空间，并将原有的元素复制到新的内存空间中。
>
> - 动态数组的优点是可以节省内存空间，并且可以根据需要自动调整大小，因此非常适合需要频繁添加或删除元素的情况。但是，动态数组的缺点是在重新分配内存空间时可能会导致性能下降，因此在使用动态数组时需要考虑这一点。

父类型：

- [List](./collection_package_interface.md#interface-listt)\<T>

### prop capacity

```cangjie
public prop capacity: Int64
```

功能：返回此 [ArrayList](collection_package_class.md#class-arraylistt) 的容量大小。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    println("初始容量: ${list.capacity}")  // 16
    
    // 添加元素直到扩容
    for (i in 0..17) {
        list.add(i)
    }
    println("添加17个元素后容量: ${list.capacity}")  // 24
    
    return 0
}
```

运行结果：

```text
初始容量: 16
添加17个元素后容量: 24
```

### prop first

```cangjie
public prop first: ?T
```

功能：返回此 [ArrayList](collection_package_class.md#class-arraylistt) 中的第一个元素，如果没有则返回 None。

类型：?T

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    list.add(1)
    list.add(2)
    
    let first = list.first
    println("第一个元素: ${first}")  // Some(1)
    
    let emptyList = ArrayList<String>()
    let noneFirst = emptyList.first
    println("空列表第一个元素: ${noneFirst}")  // None
    
    return 0
}
```

运行结果：

```text
第一个元素: Some(1)
空列表第一个元素: None
```

### prop last

```cangjie
public prop last: ?T
```

功能：返回此 [ArrayList](collection_package_class.md#class-arraylistt) 中的最后一个元素，如果没有则返回 None。

类型：?T

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    list.add(1)
    list.add(2)
    
    let last = list.last
    println("最后一个元素: ${last}")  // Some(2)
    
    let emptyList = ArrayList<String>()
    let noneLast = emptyList.last
    println("空列表最后一个元素: ${noneLast}")  // None
    
    return 0
}
```

运行结果：

```text
最后一个元素: Some(2)
空列表最后一个元素: None
```

### prop size

```cangjie
public prop size: Int64
```

功能：返回此 [ArrayList](collection_package_class.md#class-arraylistt) 中的元素个数。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    println("初始大小: ${list.size}")  // 0
    
    list.add(1)
    list.add(2)
    println("添加2个元素后大小: ${list.size}")  // 2
    
    return 0
}
```

运行结果：

```text
初始大小: 0
添加2个元素后大小: 2
```

### init()

```cangjie
public init()
```

功能：构造一个初始容量大小为默认值`16`的[ArrayList](collection_package_class.md#class-arraylistt)。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    println("初始大小: ${list.size}")      // 0
    println("初始容量: ${list.capacity}")  // 16
    println("是否为空: ${list.isEmpty()}") // true
    return 0
}
```

运行结果：

```text
初始大小: 0
初始容量: 16
是否为空: true
```

### init(Collection\<T>)

```cangjie
public init(elements: Collection<T>)
```

功能：构造一个包含指定集合中所有元素的 [ArrayList](collection_package_class.md#class-arraylistt)。这些元素按照集合的迭代器返回的顺序排列。

参数：

- elements: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - 传入集合。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let array = [1, 2, 3]
    let list = ArrayList<Int64>(array)
    println("列表内容: ${list}")  // [1, 2, 3]
    println("列表大小: ${list.size}")  // 3
    return 0
}
```

运行结果：

```text
列表内容: [1, 2, 3]
列表大小: 3
```

### init(Int64)

```cangjie
public init(capacity: Int64)
```

功能：构造一个初始容量为指定大小的 [ArrayList](collection_package_class.md#class-arraylistt)。

参数：

- capacity: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 指定的初始容量大小。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果参数的大小小于 0 则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 指定容量大于默认容量
    let list1 = ArrayList<Int64>(32)
    println("指定容量32的初始容量: ${list1.capacity}")  // 32
    
    // 指定容量小于默认容量
    let list2 = ArrayList<Int64>(8)
    println("指定容量8的初始容量: ${list2.capacity}")   // 8
    
    return 0
}
```

运行结果：

```text
指定容量32的初始容量: 32
指定容量8的初始容量: 8
```

### init(Int64, (Int64) -> T)

```cangjie
public init(size: Int64, initElement: (Int64) -> T)
```

功能：构造具有指定初始元素个数和指定规则函数的 [ArrayList](collection_package_class.md#class-arraylistt)。该构造函数根据参数 size 设置 [ArrayList](collection_package_class.md#class-arraylistt) 的容量。

参数：

- size: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 初始化函数元素个数。
- initElement: ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) ->T - 传入初始化函数。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果 size 小于 0 则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个包含5个元素的列表，每个元素的值为其索引的平方
    let list = ArrayList<Int64>(5, {
        index: Int64 => 
        index * index
    })
    
    println("列表内容: ${list}")  // [0, 1, 4, 9, 16]
    println("列表大小: ${list.size}")  // 5
    
    return 0
}
```

运行结果：

```text
列表内容: [0, 1, 4, 9, 16]
列表大小: 5
```

### static func of(Array\<T>)

```cangjie
public static func of(elements: Array<T>): ArrayList<T>
```

功能：构造一个包含指定数组中所有元素的 [ArrayList](collection_package_class.md#class-arraylistt)。

参数：

- elements: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - 传入数组，变长参数语法支持参数省略数组字面量的 `[]` 。

返回值：

- [ArrayList](#class-arraylistt)\<T> - 元素为 T 类型的 ArrayList。

> **说明：**
>
> 此函数的参数可使用变长参数方式提供，例如： `ArrayList.of(1, 2, 3)` 等价于 `ArrayList.of([1, 2, 3])` 。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let array = [1, 2, 3, 4, 5]
    let list = ArrayList<Int64>.of(array)
    
    println("数组: ${array}")      // [1, 2, 3, 4, 5]
    println("列表: ${list}")       // [1, 2, 3, 4, 5]
    println("列表大小: ${list.size}")  // 5
    
    return 0
}
```

运行结果：

```text
数组: [1, 2, 3, 4, 5]
列表: [1, 2, 3, 4, 5]
列表大小: 5
```

### func add(Collection\<T>)

```cangjie
public func add(all!: Collection<T>): Unit
```

功能：将指定集合中的所有元素附加到此 [ArrayList](collection_package_class.md#class-arraylistt) 的末尾。

函数会按照迭代器顺序遍历入参中的集合，并且将所有元素插入到此 [ArrayList](collection_package_class.md#class-arraylistt) 的尾部。

参数：

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - 需要插入的元素的集合。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    list.add(1)
    list.add(2)
    
    // 创建另一个列表作为Collection使用
    let newElements = ArrayList<Int64>()
    newElements.add(3)
    newElements.add(4)
    newElements.add(5)
    
    // 将新元素添加到原列表末尾
    list.add(all: newElements)
    
    println("列表内容: ${list}")  // [1, 2, 3, 4, 5]
    println("列表大小: ${list.size}")  // 5
    
    return 0
}
```

运行结果：

```text
列表内容: [1, 2, 3, 4, 5]
列表大小: 5
```

### func add(Collection\<T>, Int64)

```cangjie
public func add(all!: Collection<T>, at!: Int64): Unit
```

功能：从指定位置开始，将指定集合中的所有元素插入此 [ArrayList](collection_package_class.md#class-arraylistt)。

函数会按照迭代器顺序遍历入参中的集合，并且将所有元素插入到指定位置，原先在指定位置及其后的元素会后移。

参数：

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - 要插入的 T 类型元素集合。
- at!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 插入集合的目标索引。

异常：

- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - 当 at 超出范围时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    list.add(1)
    list.add(5)
    
    // 在索引1处插入集合[2, 3, 4]
    let elements = ArrayList<Int64>()
    elements.add(2)
    elements.add(3)
    elements.add(4)
    list.add(all: elements, at: 1)
    
    println("列表内容: ${list}")  // [1, 2, 3, 4, 5]
    println("列表大小: ${list.size}")  // 5
    
    return 0
}
```

运行结果：

```text
列表内容: [1, 2, 3, 4, 5]
列表大小: 5
```

### func add(T)

```cangjie
public func add(element: T): Unit
```

功能：将指定的元素附加到此 [ArrayList](collection_package_class.md#class-arraylistt) 的末尾。

参数：

- element: T - 插入的元素，类型为 T。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    list.add(1)
    list.add(2)
    list.add(3)
    
    println("列表内容: ${list}")  // [1, 2, 3]
    println("列表大小: ${list.size}")  // 3
    
    return 0
}
```

运行结果：

```text
列表内容: [1, 2, 3]
列表大小: 3
```

### func add(T, Int64)

```cangjie
public func add(element: T, at!: Int64): Unit
```

功能：在此 [ArrayList](collection_package_class.md#class-arraylistt) 中的指定位置插入指定元素。

参数：

- element: T - 要插入的 T 类型元素。
- at!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 插入元素的目标索引。

异常：

- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - 当 at 超出范围时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    list.add(1)
    list.add(3)
    
    // 在索引1处插入元素2
    list.add(2, at: 1)
    
    println("列表内容: ${list}")  // [1, 2, 3]
    println("列表大小: ${list.size}")  // 3
    
    return 0
}
```

运行结果：

```text
列表内容: [1, 2, 3]
列表大小: 3
```

### func all((T) -> Bool)

```cangjie
public func all(predicate: (T) -> Bool): Bool
```

功能：判断 [ArrayList](collection_package_class.md#class-arraylistt) 中所有元素是否都满足条件。

参数：

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果 [ArrayList](collection_package_class.md#class-arraylistt) 中所有元素都满足条件，返回 true，否则返回 false

### func any((T) -> Bool)

```cangjie
public func any(predicate: (T) -> Bool): Bool
```

功能：判断 [ArrayList](collection_package_class.md#class-arraylistt) 是否存在任意一个满足条件的元素。

参数：

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 是否存在任意满足条件的元素。

### func clear()

```cangjie
public func clear(): Unit
```

功能：从此 [ArrayList](collection_package_class.md#class-arraylistt) 中删除所有元素。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    list.add(1)
    list.add(2)
    list.add(3)
    
    println("清空前列表内容: ${list}")  // [1, 2, 3]
    println("清空前列表大小: ${list.size}")  // 3
    
    list.clear()
    
    println("清空后列表内容: ${list}")  // []
    println("清空后列表大小: ${list.size}")  // 0
    println("列表是否为空: ${list.isEmpty()}")  // true
    
    return 0
}
```

运行结果：

```text
清空前列表内容: [1, 2, 3]
清空前列表大小: 3
清空后列表内容: []
清空后列表大小: 0
列表是否为空: true
```

### func clone()

```cangjie
public func clone(): ArrayList<T>
```

功能：返回此 [ArrayList](collection_package_class.md#class-arraylistt) 实例的拷贝（浅拷贝）。

返回值：

- [ArrayList](collection_package_class.md#class-arraylistt)\<T> - 返回新 [ArrayList](collection_package_class.md#class-arraylistt)\<T>。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let originalList = ArrayList<Int64>()
    originalList.add(1)
    originalList.add(2)
    originalList.add(3)
    
    // 克隆列表
    let clonedList = originalList.clone()
    
    println("原始列表: ${originalList}")  // [1, 2, 3]
    println("克隆列表: ${clonedList}")    // [1, 2, 3]
    
    // 修改原始列表不会影响克隆列表
    originalList.add(4)
    println("修改后的原始列表: ${originalList}")  // [1, 2, 3, 4]
    println("克隆列表保持不变: ${clonedList}")    // [1, 2, 3]
    
    return 0
}
```

运行结果：

```text
原始列表: [1, 2, 3]
克隆列表: [1, 2, 3]
修改后的原始列表: [1, 2, 3, 4]
克隆列表保持不变: [1, 2, 3]
```

### func filter((T) -> Bool)
```cangjie
public func filter(predicate: (T) -> Bool): ArrayList<T>
```

功能： 返回一个满足筛选条件的元素的新 [ArrayList](collection_package_class.md#class-arraylistt)\<T>。

参数：

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- [ArrayList](collection_package_class.md#class-arraylistt)\<T> - 返回一个满足筛选条件的元素的新集合。

### func filterMap\<R>((T) -> ?R)

```cangjie
public func filterMap<R>(transform: (T) -> ?R): ArrayList<R>
```

功能：同时进行筛选操作和映射操作，返回一个新 [ArrayList](collection_package_class.md#class-arraylistt)。

参数：

- transform: (T) -> ?R - 给定的映射函数。函数返回值为 Some 对应 filter 的 predicate 为 true，反之表示 false。

返回值：

- [ArrayList](collection_package_class.md#class-arraylistt)\<R> - 返回一个筛选和映射后的新[ArrayList](collection_package_class.md#class-arraylistt)。

### func flatMap\<R>((T) -> ArrayList\<R>)

```cangjie
public func flatMap<R>(transform: (T) -> ArrayList<R>): ArrayList<R>
```

功能：对 [ArrayList](collection_package_class.md#class-arraylistt) 中的每个元素应用一个转换闭包（transform），该闭包返回一个新的 [ArrayList](collection_package_class.md#class-arraylistt)，然后将所有返回的 [ArrayList](collection_package_class.md#class-arraylistt)“压平”（flatten）并连接成一个单一的结果 [ArrayList](collection_package_class.md#class-arraylistt)。

参数：

- transform: (T) -> [ArrayList](collection_package_class.md#class-arraylistt)\<R> - 给定的映射函数。

返回值：

- [ArrayList](collection_package_class.md#class-arraylistt)\<R> -  被“映射（map）”和“压平（flatten）”后的新 [ArrayList](collection_package_class.md#class-arraylistt)。

### func fold\<R>(R, (R, T) -> R)

```cangjie
public func fold<R>(initial: R, operation: (R, T) -> R): R
```

功能：使用指定初始值，从左向右计算。

参数：

- initial: R - 给定的 R 类型的初始值。
- operation: (R, T) -> R - 给定的计算函数。

返回值：

- R - 返回最终计算得到的值。

### func forEach((T) -> Unit)

```cangjie
public func forEach(action: (T) -> Unit): Unit
```

功能：遍历所有元素，执行给定的操作。

参数：

- action: (T) -> [Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - 给定的操作函数。

### func get(Int64)

```cangjie
public func get(index: Int64): ?T
```

功能：返回此 [ArrayList](collection_package_class.md#class-arraylistt) 中指定位置的元素。

参数：

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 要返回的元素的索引。

返回值：

- ?T - 返回指定位置的元素，如果 index 大小小于 0 或者大于等于 [ArrayList](collection_package_class.md#class-arraylistt) 中的元素数量，返回 None。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    list.add(10)
    list.add(20)
    list.add(30)
    
    // 获取有效索引的元素
    let element = list.get(1)
    println("索引1处的元素: ${element}")  // Some(20)
    
    // 获取无效索引的元素
    let noneElement = list.get(5)
    println("索引5处的元素: ${noneElement}")  // None
    
    return 0
}
```

运行结果：

```text
索引1处的元素: Some(20)
索引5处的元素: None
```

### func getRawArray()

```cangjie
public unsafe func getRawArray(): Array<T>
```

功能：返回 [ArrayList](collection_package_class.md#class-arraylistt) 的原始数据。

> **注意：**
>
> 这是一个 unsafe 的接口，使用处需要在 unsafe 上下文中。
>
> 原始数据是指 [ArrayList](collection_package_class.md#class-arraylistt) 底层实现的数组，其大小大于等于 [ArrayList](collection_package_class.md#class-arraylistt) 中的元素数量，且索引大于等于 [ArrayList](collection_package_class.md#class-arraylistt) 大小的位置中可能包含有未初始化的元素，对其进行访问可能会产生未定义的行为。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - [ArrayList](collection_package_class.md#class-arraylistt) 的底层原始数据。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    list.add(1)
    list.add(2)
    list.add(3)
    
    // 获取原始数组
    unsafe {
        let rawArray = list.getRawArray()
        println("原始数组: ${rawArray}")
        println("原始数组大小: ${rawArray.size}")  // 可能大于列表大小
    }
    
    return 0
}
```

运行结果：

```text
原始数组: [1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
原始数组大小: 16
```

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    list.add(1)
    list.add(2)
    list.add(3)
    
    // 获取原始数组
    unsafe {
        let rawArray = list.getRawArray()
        println("原始数组: ${rawArray}")
        println("原始数组大小: ${rawArray.size}")  // 可能大于列表大小
    }
    
    return 0
}
```

运行结果：

```text
原始数组: [1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
原始数组大小: 16
```

### func intersperse(T)

```cangjie
public func intersperse(separator: T): ArrayList<T> 
```

功能：返回每两个元素之间插入一个给定的新元素后的新 [ArrayList](collection_package_class.md#class-arraylistt) 。

参数：

- separator: T - 给定的元素。

返回值：

- [ArrayList](collection_package_class.md#class-arraylistt)\<T> - 返回一个新 [ArrayList](collection_package_class.md#class-arraylistt)。

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

功能：判断 [ArrayList](collection_package_class.md#class-arraylistt) 是否为空。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果为空，则返回 `true`，否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let emptyList = ArrayList<Int64>()
    let nonEmptyList = ArrayList<Int64>()
    nonEmptyList.add(1)
    
    println("空列表是否为空: ${emptyList.isEmpty()}")      // true
    println("非空列表是否为空: ${nonEmptyList.isEmpty()}")  // false
    
    return 0
}
```

运行结果：

```text
空列表是否为空: true
非空列表是否为空: false
```

### func iterator()

```cangjie
public func iterator(): Iterator<T>
```

功能：返回此 [ArrayList](collection_package_class.md#class-arraylistt) 中元素的迭代器。

返回值：

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - [ArrayList](collection_package_class.md#class-arraylistt) 中元素的迭代器。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    list.add(1)
    list.add(2)
    list.add(3)
    
    // 使用迭代器遍历列表
    let iter = list.iterator()
    println(iter.next().getOrThrow())
    println(iter.next().getOrThrow())
    println(iter.next().getOrThrow())
    
    return 0
}
```

运行结果：

```text
1
2
3
```

### func map\<R>((T) -> R)

```cangjie
public func map<R>(transform: (T) -> R): ArrayList<R>
```

功能：对此 [ArrayList](collection_package_class.md#class-arraylistt) 进行映射并返回一个新 [ArrayList](collection_package_class.md#class-arraylistt)。

参数：

- transform: (T) ->R - 给定的映射函数。

返回值：

- [ArrayList](collection_package_class.md#class-arraylistt)\<R> - 返回一个新的 [ArrayList](collection_package_class.md#class-arraylistt)。

### func none((T) -> Bool)

```cangjie
public func none(predicate: (T) -> Bool): Bool
```

功能：判断 [ArrayList](collection_package_class.md#class-arraylistt) 中所有元素是否都不满足条件。

参数：

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 当前 [ArrayList](collection_package_class.md#class-arraylistt) 中元素是否都不满足条件。

### func reduce((T, T) -> T)

```cangjie
public func reduce(operation: (T, T) -> T): Option<T>
```

功能：使用第一个元素作为初始值，从左向右计算。

参数：

- operation: (T, T) -> T - 给定的计算函数。

返回值：

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - 返回计算结果。

### func remove(Int64)

```cangjie
public func remove(at!: Int64): T
```

功能：删除此 [ArrayList](collection_package_class.md#class-arraylistt) 中指定位置的元素。

参数：

- at!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 被删除元素的索引。

返回值：

- T - 被移除的元素。

异常：

- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - 当 at 超出范围时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    list.add(1)
    list.add(2)
    list.add(3)
    
    // 删除索引为1的元素
    let removedElement = list.remove(at: 1)
    
    println("删除的元素: ${removedElement}")  // 2
    println("删除后的列表: ${list}")         // [1, 3]
    println("删除后的列表大小: ${list.size}") // 2
    
    return 0
}
```

运行结果：

```text
删除的元素: 2
删除后的列表: [1, 3]
删除后的列表大小: 2
```

### func remove(Range\<Int64>)

```cangjie
public func remove(range: Range<Int64>): Unit
```

功能：删除此 [ArrayList](collection_package_class.md#class-arraylistt) 中 [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) 范围所包含的所有元素。

> **注意：**
>
> 如果参数 range 是使用 [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) 构造函数构造的 [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) 实例，hasEnd 为 false 时，end 值不生效，且不受构造时传入的 isClosed 的值的影响，数组切片取到原数组最后一个元素。

参数：

- range: [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)> - 需要被删除的元素的范围。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当 range 的 [step](collection_package_function.md#func-steptint64) 不等于 1 时抛出异常。
- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - 当 range 的 start 或 end 小于 0，或 end 大于 [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt) 的长度时抛出。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    for (i in 0..6) {
        list.add(i)
    }
    // list现在是[0, 1, 2, 3, 4, 5, 6]
    
    // 删除索引1到3的元素(不包括3)
    list.remove(1..3)
    
    println("删除元素后的列表: ${list}")      // [0, 3, 4, 5]
    println("删除后的列表大小: ${list.size}") // 4
    
    return 0
}
```

运行结果：

```text
删除元素后的列表: [0, 3, 4, 5]
删除后的列表大小: 4
```

### func removeIf((T) -> Bool)

```cangjie
public func removeIf(predicate: (T) -> Bool): Unit
```

功能：删除此 [ArrayList](collection_package_class.md#class-arraylistt) 中满足给定 lambda 表达式或函数的所有元素。

参数：

- predicate: (T) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 传递判断删除的条件。

异常：

- [ConcurrentModificationException](./collection_package_exception.md#class-concurrentmodificationexception) - 当 `predicate` 中增删或者修改 [ArrayList](collection_package_class.md#class-arraylistt) 内元素时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    for (i in 0..6) {
        list.add(i)
    }
    // list现在是[0, 1, 2, 3, 4, 5, 6]
    
    // 删除所有偶数元素
    list.removeIf({element: Int64 =>
        element % 2 == 0
    })
    
    println("删除偶数后的列表: ${list}")      // [1, 3, 5]
    println("删除后的列表大小: ${list.size}") // 3
    
    return 0
}
```

运行结果：

```text
删除偶数后的列表: [1, 3, 5]
删除后的列表大小: 3
```

### func reserve(Int64)

```cangjie
public func reserve(additional: Int64): Unit
```

功能：增加此 [ArrayList](collection_package_class.md#class-arraylistt) 实例的容量。

将 [ArrayList](collection_package_class.md#class-arraylistt) 扩容 additional 大小，当 additional 小于等于零时，不发生扩容；当 [ArrayList](collection_package_class.md#class-arraylistt) 剩余容量大于等于 additional 时，不发生扩容；当 [ArrayList](collection_package_class.md#class-arraylistt) 剩余容量小于 additional 时，取（原始容量的1.5倍向下取整）与（additional + 已使用容量）两个值中的最大值进行扩容。

参数：

- additional: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 将要扩容的大小。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当additional + 已使用容量超过Int64.Max时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    
    // 初始容量为16
    println("初始容量: ${list.capacity}")  // 16
    
    // 预留额外空间
    list.reserve(20)
    println("预留20个元素后的容量: ${list.capacity}")  // 24
    
    // 添加元素
    for (i in 0..10) {
        list.add(i)
    }
    println("添加10个元素后容量: ${list.capacity}")   // 24
    println("添加10个元素后大小: ${list.size}")       // 10
    
    return 0
}
```

运行结果：

```text
初始容量: 16
预留20个元素后的容量: 24
添加10个元素后容量: 24
添加10个元素后大小: 10
```

### func reverse()

```cangjie
public func reverse(): Unit
```

功能：反转此 [ArrayList](collection_package_class.md#class-arraylistt) 中元素的顺序。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    for (i in 0..4) {
        list.add(i)
    }
    // list现在是[0, 1, 2, 3]
    println("反转前: ${list}")  // [0, 1, 2, 3]
    
    // 反转列表
    list.reverse()
    
    println("反转后: ${list}")  // [3, 2, 1, 0]
    
    return 0
}
```

运行结果：

```text
反转前: [0, 1, 2, 3]
反转后: [3, 2, 1, 0]
```

### func skip(Int64)

```cangjie
public func skip(count: Int64): ArrayList<T>
```

功能： 跳过特定个数元素并返回一个新 [ArrayList](collection_package_class.md#class-arraylistt)。

当 count 小于等于 0 时，抛出异常。当 count 等于 0 时，相当没有跳过任何元素，返回包含源 [ArrayList](collection_package_class.md#class-arraylistt) 所有元素的新 [ArrayList](collection_package_class.md#class-arraylistt) 。当 count 大于 0 小于源 [ArrayList](collection_package_class.md#class-arraylistt) 的大小时，跳过前 count 个元素，返回包含剩下的元素的新 [ArrayList](collection_package_class.md#class-arraylistt)。当 count 大于等于 [ArrayList](collection_package_class.md#class-arraylistt) 的大小时，返回空 [ArrayList](collection_package_class.md#class-arraylistt)。

参数：

- count: [Int64](core_package_intrinsics.md#int64) - 要跳过的个数。

返回值：

- [ArrayList](collection_package_class.md#class-arraylistt)\<T> - 返回一个跳过指定数量元素的新 [ArrayList](collection_package_class.md#class-arraylistt)。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当 count < 0 时，抛出异常。

### func slice(Range\<Int64>)

```cangjie
public func slice(range: Range<Int64>): ArrayList<T>
```

功能：以传入参数 range 作为索引，返回索引对应的 [ArrayList](collection_package_class.md#class-arraylistt)\<T>。

> **注意：**
>
> 如果参数 range 是使用 [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) 构造函数构造的 [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) 实例，有如下行为：
>
> 1. start 的值就是构造函数传入的值本身，不受构造时传入的 hasStart 的值的影响。
> 2. hasEnd 为 false 时，end 值不生效，且不受构造时传入的 isClosed 的值的影响，该数组切片取到原数组最后一个元素。

参数：

- range: [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)> - 传递切片的范围。

返回值：

- [ArrayList](collection_package_class.md#class-arraylistt)\<T> - 切片所得的数组。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当 range.[step](collection_package_function.md#func-steptint64) 不等于 1 时，抛出异常。
- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - 当 range 无效时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    for (i in 0..6) {
        list.add(i)
    }
    // list现在是[0, 1, 2, 3, 4, 5]
    
    println("原列表: ${list}")  // [0, 1, 2, 3, 4, 5]
    
    // 通过范围操作符切片
    let sliceList = list[1..4]
    
    println("切片列表: ${sliceList}")     // [1, 2, 3]
    println("切片列表大小: ${sliceList.size}") // 3
    
    return 0
}
```

运行结果：

```text
原列表: [0, 1, 2, 3, 4, 5]
切片列表: [1, 2, 3]
切片列表大小: 3
```

### func sortBy((T, T) -> Ordering) <sup>(deprecated)</sup>

```cangjie
public func sortBy(comparator!: (T, T) -> Ordering): Unit
```

功能：对数组中的元素进行非稳定排序。

通过传入的比较函数，根据其返回值 [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) 类型的结果，可对数组进行自定义排序comparator: (t1: T, t2: T) -> [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering)，如果 comparator 的返回值为 [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).GT，排序后 t1 在 t2后；如果 comparator 的返回值为 [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).LT，排序后 t1 在t2 前；如果 comparator 的返回值为 [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).EQ，且为稳定排序，那么 t1 在 t2 之前； 如果 comparator 的返回值为 [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).EQ，且为不稳定排序，那么 t1，t2 顺序不确定。

> **注意：**
>
> 未来版本即将废弃，使用 [sort](../../sort/sort_package_api/sort_package_funcs.md#func-sorttlistt-bool-bool-where-t--comparablet) 替代。

参数：

- comparator!: (T, T) -> [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) - (T, T) -> [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) 类型。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    list.add(3)
    list.add(1)
    list.add(4)
    list.add(2)
    // list现在是[3, 1, 4, 2]
    println("排序前: ${list}")  // [3, 1, 4, 2]
    
    // 按降序排序
    list.sortBy(comparator: {a: Int64, b: Int64 => 
        if (a > b) {
            return Ordering.GT
        } else if (a < b) {
            return Ordering.LT
        } else {
            return Ordering.EQ
        }
    })
    
    println("排序后: ${list}")  // [4, 3, 2, 1]
    
    return 0
}
```

运行结果：

```text
排序前: [3, 1, 4, 2]
排序后: [1, 2, 3, 4]
```

### func sortBy(Bool, (T, T) -> Ordering) <sup>(deprecated)</sup>

```cangjie
public func sortBy(stable!: Bool, comparator!: (T, T) -> Ordering): Unit
```

功能：对数组中的元素进行排序。

通过传入的比较函数，根据其返回值 [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) 类型的结果，可对数组进行自定义排序comparator: (t1: T, t2: T) -> [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering)，如果 comparator 的返回值为 [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).GT，排序后 t1 在 t2后；如果 comparator 的返回值为 [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).LT，排序后 t1 在t2 前；如果 comparator 的返回值为 [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).EQ，且为稳定排序，那么 t1 在 t2 之前； 如果 comparator 的返回值为 [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).EQ，且为不稳定排序，那么 t1，t2 顺序不确定。

> **注意：**
>
> 未来版本即将废弃，使用 [sort](../../sort/sort_package_api/sort_package_funcs.md#func-sorttlistt-bool-bool-where-t--comparablet) 替代。

参数：

- stable!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 是否使用稳定排序。
- comparator!: (T, T) -> [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) - (T, T) -> [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) 类型。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    list.add(3)
    list.add(1)
    list.add(4)
    list.add(2)
    // list现在是[3, 1, 4, 2]
    println("排序前: ${list}")  // [3, 1, 4, 2]
    
    // 使用稳定排序按降序排序
    list.sortBy(stable: true, comparator: {a: Int64, b: Int64 =>
        if (a < b) {
            return Ordering.GT
        } else if (a > b) {
            return Ordering.LT
        } else {
            return Ordering.EQ
        }
    })
    
    println("稳定排序后: ${list}")  // [4, 3, 2, 1]
    
    return 0
}
```

运行结果：

```text
排序前: [3, 1, 4, 2]
稳定排序后: [4, 3, 2, 1]
```

### func step(Int64)
```cangjie
public func step(count: Int64): ArrayList<T>
```

功能：以指定的间隔从 [ArrayList](collection_package_class.md#class-arraylistt) 中提取元素，并返回一个新 [ArrayList](collection_package_class.md#class-arraylistt)。

当 count 小于等于 0 时，抛出异常

参数：

- count: [Int64](core_package_intrinsics.md#int64) - 选取的间隔

返回值：

- [ArrayList](collection_package_class.md#class-arraylistt)\<T> - 一个新的 [ArrayList](collection_package_class.md#class-arraylistt)，包含了按间隔从源 [ArrayList](collection_package_class.md#class-arraylistt) 中提取出的所有元素。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当 count <= 0 时，抛出异常。

### func take(Int64)
```cangjie
public func take(count: Int64): ArrayList<T>
```

功能： 从数组取出特定个数元素并返回一个新数组。

当 count 小于等于 0 时，抛出异常。当 count 等于 0 时，不取元素，返回空数组。当 count 大于 0 小于源数组的大小时，取前 count 个元素，返回新数组。当 count 大于等于数组的大小时，取所有元素，返回新数组。

参数：

- count: [Int64](core_package_intrinsics.md#int64) - 要取出的个数。

返回值：

- [ArrayList](collection_package_class.md#class-arraylistt)\<T> - 返回一个取出指定数量元素的新 [ArrayList](collection_package_class.md#class-arraylistt)。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当 count < 0 时，抛出异常。

### func toArray()

```cangjie
public func toArray(): Array<T>
```

功能：返回一个数组，其中包含此列表中按正确顺序排列的所有元素。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - T 类型数组。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    for (i in 0..4) {
        list.add(i)
    }
    // list现在是[0, 1, 2, 3]
    println("列表: ${list}")  // [0, 1, 2, 3]
    
    // 转换为数组
    let array = list.toArray()
    
    println("数组: ${array}")      // [0, 1, 2, 3]
    println("数组大小: ${array.size}") // 4
    
    return 0
}
```

运行结果：

```text
列表: [0, 1, 2, 3]
数组: [0, 1, 2, 3]
数组大小: 4
```

### operator func \[](Int64)

```cangjie
public operator func [](index: Int64): T
```

功能：操作符重载 - get。

参数：

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 表示 get 接口的索引。

返回值：

- T - 索引位置的元素的值。

异常：

- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - 当 index 超出范围时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    list.add(10)
    list.add(20)
    list.add(30)
    
    // 通过索引访问元素
    let element = list[1]
    println("索引1处的元素: ${element}")  // 20
    
    // 修改索引处的元素
    list[1] = 25
    println("修改后索引1处的元素: ${list[1]}")  // 25
    println("修改后的列表: ${list}")           // [10, 25, 30]
    
    return 0
}
```

运行结果：

```text
索引1处的元素: 20
修改后索引1处的元素: 25
修改后的列表: [10, 25, 30]
```

### operator func \[](Int64, T)

```cangjie
public operator func [](index: Int64, value!: T): Unit
```

功能：操作符重载，通过下标运算符用指定的元素替换此列表中指定位置的元素。

参数：

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 要设置的索引值。
- value!: T - 要设置的 T 类型的值。

异常：

- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - 当 index 超出范围时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    list.add(10)
    list.add(20)
    list.add(30)
    
    println("修改前的列表: ${list}")  // [10, 20, 30]
    
    // 通过索引修改元素
    list[1] = 25
    
    println("修改后的列表: ${list}")  // [10, 25, 30]
    println("索引1处的元素: ${list[1]}") // 25
    
    return 0
}
```

运行结果：

```text
修改前的列表: [10, 20, 30]
修改后的列表: [10, 25, 30]
索引1处的元素: 25
```

### operator func \[](Range\<Int64>)

```cangjie
public operator func [](range: Range<Int64>): ArrayList<T>
```

功能：运算符重载 - 切片。

> **注意：**
>
> - 如果参数 range 是使用 [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) 构造函数构造的 [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) 实例，有如下行为：
>     - start 的值就是构造函数传入的值本身，不受构造时传入的 hasStart 的值的影响。
>     - hasEnd 为 false 时，end 值不生效，且不受构造时传入的 isClosed 的值的影响，数组切片取到原数组最后一个元素。
>
> - 切片操作返回的 [ArrayList](collection_package_class.md#class-arraylistt) 为全新的对象，与原 [ArrayList](collection_package_class.md#class-arraylistt) 无引用关系。

参数：

- range: [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)> - 传递切片的范围。

返回值：

- [ArrayList](collection_package_class.md#class-arraylistt)\<T> - 切片所得的数组。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当 range.[step](collection_package_function.md#func-steptint64) 不等于 1 时，抛出异常。
- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - 当 range 无效时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    for (i in 0..5) {
        list.add(i)
    }
    // list现在是[0, 1, 2, 3, 4]
    
    println("原列表: ${list}")  // [0, 1, 2, 3, 4]
    
    // 通过范围操作符切片
    let sliceList = list[1..4]
    
    println("切片列表: ${sliceList}")        // [1, 2, 3]
    println("切片列表大小: ${sliceList.size}") // 3
    
    return 0
}
```

运行结果：

```text
原列表: [0, 1, 2, 3, 4]
切片列表: [1, 2, 3]
切片列表大小: 3
```

### extend\<T> ArrayList\<T>

```cangjie
extend<T> ArrayList<T>
```

功能：为 [ArrayList](collection_package_class.md#class-arraylistt)\<T> 类型进行拓展

#### func enumerate()

```cangjie
public func enumerate(): ArrayList<(Int64, T)>
```

功能：用于获取带索引的 [ArrayList](collection_package_class.md#class-arraylistt) 。

返回值：

- [ArrayList](collection_package_class.md#class-arraylistt)\<([Int64](../../core/core_package_api/core_package_intrinsics.md#int64), T)> - 返回一个带索引的新 [ArrayList](collection_package_class.md#class-arraylistt)。

#### func zip\<R>(ArrayList\<R>)

```cangjie
public func zip<R>(other: ArrayList<R>): ArrayList<(T, R)>
```

功能：将两个 [ArrayList](collection_package_class.md#class-arraylistt) 合并成一个新 [ArrayList](collection_package_class.md#class-arraylistt)（长度取决于短的那个 [ArrayList](collection_package_class.md#class-arraylistt)）。

参数：

- other: [ArrayList](collection_package_class.md#class-arraylistt)\<R> - 要合并的其中一个 [ArrayList](collection_package_class.md#class-arraylistt)。

返回值：

- [ArrayList](collection_package_class.md#class-arraylistt)\<(T, R)> - 返回一个新 [ArrayList](collection_package_class.md#class-arraylistt) 。

### extend\<T> ArrayList\<T> <: Equatable\<ArrayList\<T>> where T <: Equatable\<T>

```cangjie
extend<T> ArrayList<T> <: Equatable<ArrayList<T>> where T <: Equatable<T>
```

功能：为 [ArrayList](./collection_package_class.md#class-arraylistt)\<T> 类型扩展 [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[ArrayList](./collection_package_class.md#class-arraylistt)\<T>> 接口，支持判等操作。

父类型：

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[ArrayList](#class-arraylistt)\<T>>

#### func contains(T)

```cangjie
public func contains(element: T): Bool
```

功能：判断当前数组中是否含有指定元素 `element`。

参数：

- element: T - 待寻找的元素。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果数组中包含指定元素，返回 true，否则返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    list.add(1)
    list.add(2)
    list.add(3)
    
    println("列表包含元素2: ${list.contains(2)}")  // true
    println("列表包含元素5: ${list.contains(5)}")  // false
    
    return 0
}
```

运行结果：

```text
列表包含元素2: true
列表包含元素5: false
```

#### operator func !=(ArrayList\<T>)

```cangjie
public operator func !=(that: ArrayList<T>): Bool
```

功能：判断当前实例与参数指向的 [ArrayList](./collection_package_class.md#class-arraylistt) 实例是否不等。

参数：

- that: [ArrayList](./collection_package_class.md#class-arraylistt)\<T> - 被比较的对象。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果不等，则返回 true，否则返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list1 = ArrayList<Int64>()
    list1.add(1)
    list1.add(2)
    list1.add(3)
    
    let list2 = ArrayList<Int64>()
    list2.add(1)
    list2.add(2)
    
    let list3 = ArrayList<Int64>()
    list3.add(1)
    list3.add(2)
    list3.add(3)
    
    println("list1 != list2: ${list1 != list2}")  // true
    println("list1 != list3: ${list1 != list3}")  // false
    
    return 0
}
```

运行结果：

```text
list1 != list2: true
list1 != list3: false
```

#### operator func ==(ArrayList\<T>)

```cangjie
public operator func ==(that: ArrayList<T>): Bool
```

功能：判断当前实例与参数指向的 [ArrayList](./collection_package_class.md#class-arraylistt) 实例是否相等。

两个数组相等指的是两者对应位置的元素分别相等。

参数：

- that: [ArrayList](./collection_package_class.md#class-arraylistt)\<T> - 被比较的对象。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果相等，则返回 true，否则返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list1 = ArrayList<Int64>()
    list1.add(1)
    list1.add(2)
    list1.add(3)
    
    let list2 = ArrayList<Int64>()
    list2.add(1)
    list2.add(2)
    list2.add(3)
    
    let list3 = ArrayList<Int64>()
    list3.add(1)
    list3.add(2)
    
    println("list1 == list2: ${list1 == list2}")  // true
    println("list1 == list3: ${list1 == list3}")  // false
    
    return 0
}
```

运行结果：

```text
list1 == list2: true
list1 == list3: false
```

### extend\<T> ArrayList\<T> <: SortExtension where T <: Comparable\<T> <sup>(deprecated)</sup>

```cangjie
extend<T> ArrayList<T> where T <: Comparable<T>
```

功能：为 [ArrayList](./collection_package_class.md#class-arraylistt)\<T> 扩展 [SortExtension](../../sort/sort_package_api/sort_package_interfaces.md#interface-sortextension-deprecated) 接口，支持数组排序。

> **注意：**
>
> 未来版本即将废弃。

父类型：

- [SortExtension](../../sort/sort_package_api/sort_package_interfaces.md#interface-sortextension-deprecated)

#### func sort() <sup>(deprecated)</sup>

```cangjie
public func sort(): Unit
```

功能：将当前数组内元素以升序的方式非稳定排序。

> **注意：**
>
> 未来版本即将废弃，使用 [sort](../../sort/sort_package_api/sort_package_funcs.md#func-sorttlistt-bool-bool-where-t--comparablet) 替代。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    list.add(3)
    list.add(1)
    list.add(4)
    list.add(2)
    // list现在是[3, 1, 4, 2]
    println("排序前: ${list}")  // [3, 1, 4, 2]
    
    // 升序排序
    list.sort()
    
    println("排序后: ${list}")  // [1, 2, 3, 4]
    
    return 0
}
```

运行结果：

```text
排序前: [3, 1, 4, 2]
排序后: [1, 2, 3, 4]
```

#### func sort(Bool) <sup>(deprecated)</sup>

```cangjie
public func sort(stable!: Bool): Unit
```

功能：将当前数组内元素以升序的方式排序。

参数：

- stable!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 是否使用稳定排序。

> **注意：**
>
> 未来版本即将废弃，使用 [sort](../../sort/sort_package_api/sort_package_funcs.md#func-sorttlistt-bool-bool-where-t--comparablet) 替代。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    list.add(3)
    list.add(1)
    list.add(4)
    list.add(2)
    // list现在是[3, 1, 4, 2]
    println("排序前: ${list}")  // [3, 1, 4, 2]
    
    // 使用稳定排序升序排序
    list.sort(stable: true)
    
    println("稳定排序后: ${list}")  // [1, 2, 3, 4]
    
    return 0
}
```

运行结果：

```text
排序前: [3, 1, 4, 2]
稳定排序后: [1, 2, 3, 4]
```

#### func sortDescending() <sup>(deprecated)</sup>

```cangjie
public func sortDescending(): Unit
```

功能：将当前数组内元素以降序的方式非稳定排序。

> **注意：**
>
> 未来版本即将废弃，使用 [sort](../../sort/sort_package_api/sort_package_funcs.md#func-sorttlistt-bool-bool-where-t--comparablet) 替代。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    list.add(3)
    list.add(1)
    list.add(4)
    list.add(2)
    // list现在是[3, 1, 4, 2]
    println("排序前: ${list}")  // [3, 1, 4, 2]
    
    // 降序排序
    list.sortDescending()
    
    println("降序排序后: ${list}")  // [4, 3, 2, 1]
    
    return 0
}
```

运行结果：

```text
排序前: [3, 1, 4, 2]
降序排序后: [4, 3, 2, 1]
```

#### func sortDescending(Bool) <sup>(deprecated)</sup>

```cangjie
public func sortDescending(stable!: Bool): Unit
```

功能：将当前数组内元素以降序的方式排序。

参数：

- stable!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 是否使用稳定排序。

> **注意：**
>
> 未来版本即将废弃，使用 [sort](../../sort/sort_package_api/sort_package_funcs.md#func-sorttlistt-bool-bool-where-t--comparablet) 替代。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    list.add(3)
    list.add(1)
    list.add(4)
    list.add(2)
    // list现在是[3, 1, 4, 2]
    println("排序前: ${list}")  // [3, 1, 4, 2]
    
    // 使用稳定排序降序排序
    list.sortDescending(stable: true)
    
    println("稳定降序排序后: ${list}")  // [4, 3, 2, 1]
    
    return 0
}
```

运行结果：

```text
排序前: [3, 1, 4, 2]
稳定降序排序后: [4, 3, 2, 1]
```

### extend\<T> ArrayList\<T> <: ToString where T <: ToString

```cangjie
extend<T> ArrayList<T> <: ToString where T <: ToString
```

功能：为 [ArrayList](./collection_package_class.md#class-arraylistt)\<T> 扩展 [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) 接口，支持转字符串操作。

父类型：

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

功能：将当前数组转换为字符串。

该字符串包含数组内每个元素的字符串表示，形如："[elem1, elem2, elem3]"。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 转换得到的字符串。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = ArrayList<Int64>()
    list.add(1)
    list.add(2)
    list.add(3)
    
    let str = list.toString()
    
    println("列表: ${list}")     // [1, 2, 3]
    println("字符串: ${str}")    // [1, 2, 3]
    println("字符串长度: ${str.size}") // 9
    
    return 0
}
```

运行结果：

```text
列表: [1, 2, 3]
字符串: [1, 2, 3]
字符串长度: 9
```

## class ArrayQueue\<T>

```cangjie
public class ArrayQueue<T> <: Queue<T> {
    public init()
    public init(capacity: Int64)
}
```

功能：基于数组实现的循环队列数据结构。

父类型：

- [Queue](./collection_package_interface.md#interface-queuet)\<T>

### prop capacity

```cangjie
public prop capacity: Int64
```

功能：获取此队列的容量。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let queue = ArrayQueue<Int64>()
    
    // 初始容量为8
    println("初始容量: ${queue.capacity}")  // 8
    
    // 指定容量构造
    let queue2 = ArrayQueue<Int64>(16)
    println("指定容量: ${queue2.capacity}")  // 16
    
    return 0
}
```

运行结果：

```text
初始容量: 8
指定容量: 16
```

### prop size

```cangjie
public prop size: Int64
```

功能：返回此队列中的元素个数。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let queue = ArrayQueue<Int64>()
    
    // 初始大小为0
    println("初始大小: ${queue.size}")  // 0
    
    // 添加元素后大小变化
    queue.add(1)
    queue.add(2)
    println("添加元素后大小: ${queue.size}")  // 2
    
    return 0
}
```

运行结果：

```text
初始大小: 0
添加元素后大小: 2
```

### init()

```cangjie
public init()
```

功能：构造一个空的队列，其容量大小为默认值 8。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 使用默认构造函数创建队列
    let queue = ArrayQueue<Int64>()
    
    println("初始大小: ${queue.size}")      // 0
    println("初始容量: ${queue.capacity}")  // 8
    println("是否为空: ${queue.isEmpty()}") // true
    
    return 0
}
```

运行结果：

```text
初始大小: 0
初始容量: 8
是否为空: true
```

### init(Int64)

```cangjie
public init(capacity: Int64)
```

功能：构造一个具有指定容量的队列，当 capacity 小于默认容量 8 时，构造的 [ArrayQueue](#class-arrayqueuet) 初始容量为 8 。

参数：

- capacity: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 指定的初始容量。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果参数的大小小于 0 则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 指定容量大于默认容量
    let queue1 = ArrayQueue<Int64>(16)
    println("指定容量16的队列容量: ${queue1.capacity}")  // 16
    
    // 指定容量小于默认容量
    let queue2 = ArrayQueue<Int64>(4)
    println("指定容量4的队列容量: ${queue2.capacity}")   // 8
    
    // 添加元素测试
    queue2.add(1)
    queue2.add(2)
    println("添加元素后大小: ${queue2.size}")  // 2
    
    return 0
}
```

运行结果：

```text
指定容量16的队列容量: 16
指定容量4的队列容量: 8
添加元素后大小: 2
```

### func add(T)

```cangjie
public func add(element: T): Unit
```

功能：在此队列尾部插入元素。

参数：

- element: T - 被插入到此双端队列的元素。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let queue = ArrayQueue<Int64>()
    
    // 添加元素到队列尾部
    queue.add(1)
    queue.add(2)
    queue.add(3)
    
    println("队列大小: ${queue.size}")      // 3
    println("队列容量: ${queue.capacity}")  // 8
    
    // 查看队列头部元素
    let head = queue.peek()
    println("队列头部元素: ${head}")  // Some(1)
    
    return 0
}
```

运行结果：

```text
队列大小: 3
队列容量: 8
队列头部元素: Some(1)
```

### func clear()

```cangjie
public func clear(): Unit
```

功能：清空此队列中的所有元素。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let queue = ArrayQueue<Int64>()
    
    // 添加一些元素
    queue.add(1)
    queue.add(2)
    queue.add(3)
    
    println("清空前大小: ${queue.size}")      // 3
    println("清空前是否为空: ${queue.isEmpty()}") // false
    
    // 清空队列
    queue.clear()
    
    println("清空后大小: ${queue.size}")      // 0
    println("清空后是否为空: ${queue.isEmpty()}") // true
    
    return 0
}
```

运行结果：

```text
清空前大小: 3
清空前是否为空: false
清空后大小: 0
清空后是否为空: true
```

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

功能：判断此队列是否为空。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果为空，则返回 `true`，否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let queue = ArrayQueue<Int64>()
    
    // 空队列
    println("空队列是否为空: ${queue.isEmpty()}")  // true
    
    // 添加元素后
    queue.add(1)
    println("添加元素后是否为空: ${queue.isEmpty()}")  // false
    
    // 移除所有元素后
    queue.remove()
    println("移除元素后是否为空: ${queue.isEmpty()}")  // true
    
    return 0
}
```

运行结果：

```text
空队列是否为空: true
添加元素后是否为空: false
移除元素后是否为空: true
```

### func iterator()

```cangjie
public func iterator(): Iterator<T>
```

功能：获取此队列中元素的迭代器，其顺序为从前到后的顺序。

返回值：

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - 元素的迭代器。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let queue = ArrayQueue<Int64>()
    
    // 添加元素
    queue.add(1)
    queue.add(2)
    queue.add(3)
    
    // 使用迭代器遍历队列
    let iter = queue.iterator()
    println(iter.next())
    println(iter.next())
    println(iter.next())
    
    return 0
}
```

运行结果：

```text
Some(1)
Some(2)
Some(3)
```

### func peek()

```cangjie
public func peek():?T
```

功能：查看此队列头部元素。此操作不会删除元素。

返回值：

- ?T - 队列的头部元素，如果队列为空，返回`None`。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let queue = ArrayQueue<Int64>()
    
    // 查看空队列的头部元素
    let emptyPeek = queue.peek()
    println("空队列头部元素: ${emptyPeek}")  // None
    
    // 添加元素后查看头部元素
    queue.add(10)
    queue.add(20)
    let peekValue = queue.peek()
    println("队列头部元素: ${peekValue}")  // Some(10)
    
    // 查看头部元素不会移除元素
    println("查看后队列大小: ${queue.size}")  // 2
    
    return 0
}
```

运行结果：

```text
空队列头部元素: None
队列头部元素: Some(10)
查看后队列大小: 2
```

### func remove()

```cangjie
public func remove(): ?T
```

功能：删除队列中的头部元素并返回该值，如果此队列为空，返回 `None`。

返回值：

- ?T - 被删除的头部元素。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let queue = ArrayQueue<Int64>()
    
    // 从空队列移除元素
    let emptyRemove = queue.remove()
    println("从空队列移除元素: ${emptyRemove}")  // None
    
    // 添加元素后移除
    queue.add(10)
    queue.add(20)
    queue.add(30)
    
    let removedElement = queue.remove()
    println("移除的元素: ${removedElement}")  // Some(10)
    println("移除后队列大小: ${queue.size}")   // 2
    
    return 0
}
```

运行结果：

```text
从空队列移除元素: None
移除的元素: Some(10)
移除后队列大小: 2
```

### func reserve(Int64)

```cangjie
public func reserve(additional: Int64): Unit
```

功能：增加此队列的容量。

将队列扩容 additional 大小，当 additional 小于等于零时，不发生扩容；当此队列剩余容量大于等于 additional 时，不发生扩容；当此队列剩余容量小于 additional 时，取（原始容量的 1.5 倍向下取整）与（additional + 已使用容量）两个值中的最大值进行扩容。

参数：

- additional: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 将要扩容的大小。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let queue = ArrayQueue<Int64>()
    
    // 初始容量
    println("初始容量: ${queue.capacity}")  // 8
    
    // 预留额外空间
    queue.reserve(10)
    println("预留空间后容量: ${queue.capacity}")  // 16 (扩容到接近18的合适大小)
    
    // 添加元素测试
    for (i in 0..15) {
        queue.add(i)
    }
    println("添加16个元素后容量: ${queue.capacity}")  // 16
    println("添加16个元素后大小: ${queue.size}")    // 16
    
    return 0
}
```

运行结果：

```text
初始容量: 8
预留空间后容量: 12
添加16个元素后容量: 18
添加16个元素后大小: 15
```

### func toArray()

```cangjie
public func toArray(): Array<T>
```

功能：返回一个数组，其包含此队列中的所有元素，且顺序为从前到后的顺序。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - T 类型数组。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let queue = ArrayQueue<Int64>()
    
    // 添加元素
    queue.add(1)
    queue.add(2)
    queue.add(3)
    
    println("队列: ${queue}")  // [1, 2, 3]
    
    // 转换为数组
    let array = queue.toArray()
    
    println("数组: ${array}")      // [1, 2, 3]
    println("数组大小: ${array.size}") // 3
    
    return 0
}
```

运行结果：

```text
队列: [1, 2, 3]
数组: [1, 2, 3]
数组大小: 3
```

### extend\<T> ArrayQueue\<T> <: ToString where T <: ToString

```cangjie
extend<T> ArrayQueue<T> <: ToString where T <: ToString
```

功能：为 [ArrayQueue](./collection_package_class.md#class-arrayqueuet)\<T> 扩展 [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) 接口，支持转字符串操作。

父类型：

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

功能：获取当前[ArrayQueue](./collection_package_class.md#class-arrayqueuet)\<T>实例的字符串表示。

该字符串包含双端队列内每个元素的字符串表示，其顺序为从前到后的顺序，形如："[elem1, elem2, elem3]"。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 转换得到的字符串。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let queue = ArrayQueue<Int64>()
    
    // 空队列转字符串
    let emptyStr = queue.toString()
    println("空队列字符串: ${emptyStr}")  // []
    
    // 添加元素后转字符串
    queue.add(1)
    queue.add(2)
    queue.add(3)
    
    let str = queue.toString()
    println("队列字符串: ${str}")      // [1, 2, 3]
    println("字符串长度: ${str.size}")  // 9
    
    return 0
}
```

运行结果：

```text
空队列字符串: []
队列字符串: [1, 2, 3]
字符串长度: 9
```

## class ArrayStack\<T>

```cangjie
public class ArrayStack<T> <: Stack<T> {
    public init(capacity: Int64)
    public init()
}
```

功能：[ArrayStack](#class-arraystackt) 是一种基于数组 [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt) 实现的栈 [Stack](./collection_package_interface.md#interface-stackt) 数据结构。ArrayStack 的实现方式是使用一个数组来存储栈中的元素，同时使用一个指针来指向栈顶元素的位置。

[ArrayStack](#class-arraystackt) 只支持后进先出（Last In First Out，LIFO），只能在头部进行插入删除操作，并且 [ArrayStack](#class-arraystackt) 会根据实际需要进行扩容。

父类型：

- [Stack](./collection_package_interface.md#interface-stackt)\<T>

### prop capacity

```cangjie
public prop capacity: Int64
```

功能：栈的容量大小。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let stack = ArrayStack<Int64>()
    
    // 初始容量为8
    println("初始容量: ${stack.capacity}")  // 8
    
    // 指定容量构造
    let stack2 = ArrayStack<Int64>(16)
    println("指定容量: ${stack2.capacity}")  // 16
    
    return 0
}
```

运行结果：

```text
初始容量: 8
指定容量: 16
```

### prop size

```cangjie
public prop size: Int64
```

功能：栈中元素的数量。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let stack = ArrayStack<Int64>()
    
    // 初始大小为0
    println("初始大小: ${stack.size}")  // 0
    
    // 添加元素后大小变化
    stack.add(1)
    stack.add(2)
    println("添加元素后大小: ${stack.size}")  // 2
    
    return 0
}
```

运行结果：

```text
初始大小: 0
添加元素后大小: 2
```

### func init()

```cangjie
public init()
```

功能：构造一个空的 [ArrayStack](#class-arraystackt)，其初始容量为 8。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 使用默认构造函数创建栈
    let stack = ArrayStack<Int64>()
    
    println("初始大小: ${stack.size}")      // 0
    println("初始容量: ${stack.capacity}")  // 8
    println("是否为空: ${stack.isEmpty()}") // true
    
    return 0
}
```

运行结果：

```text
初始大小: 0
初始容量: 8
是否为空: true
```

### func init(Int64)

```cangjie
public init(capacity: Int64)
```

功能：构造一个空的 [ArrayStack](#class-arraystackt)，其初始容量为指定的值。当 capacity 小于默认容量 8 时，构造的 [ArrayStack](#class-arraystackt) 初始容量为 8。

参数：

- capacity: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 初始容量大小。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当入参为负数时，抛出此异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 指定容量大于默认容量
    let stack1 = ArrayStack<Int64>(16)
    println("指定容量16的栈容量: ${stack1.capacity}")  // 16
    
    // 指定容量小于默认容量
    let stack2 = ArrayStack<Int64>(4)
    println("指定容量4的栈容量: ${stack2.capacity}")   // 8
    
    // 添加元素测试
    stack2.add(1)
    stack2.add(2)
    println("添加元素后大小: ${stack2.size}")  // 2
    
    return 0
}
```

运行结果：

```text
指定容量16的栈容量: 16
指定容量4的栈容量: 8
添加元素后大小: 2
```

### func add(T)

```cangjie
public func add(element: T): Unit
```

功能：在栈顶添加元素。

参数：

- element: T - 添加的元素。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let stack = ArrayStack<Int64>()
    
    // 添加元素到栈顶
    stack.add(1)
    stack.add(2)
    stack.add(3)
    
    println("栈大小: ${stack.size}")      // 3
    println("栈容量: ${stack.capacity}")  // 8
    
    // 查看栈顶元素
    let top = stack.peek()
    println("栈顶元素: ${top}")  // Some(3)
    
    return 0
}
```

运行结果：

```text
栈大小: 3
栈容量: 8
栈顶元素: Some(3)
```

### func clear()

```cangjie
public func clear(): Unit
```

功能：清空当前的 [ArrayStack](#class-arraystackt)。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let stack = ArrayStack<Int64>()
    
    // 添加一些元素
    stack.add(1)
    stack.add(2)
    stack.add(3)
    
    println("清空前大小: ${stack.size}")      // 3
    println("清空前是否为空: ${stack.isEmpty()}") // false
    
    // 清空栈
    stack.clear()
    
    println("清空后大小: ${stack.size}")      // 0
    println("清空后是否为空: ${stack.isEmpty()}") // true
    
    return 0
}
```

运行结果：

```text
清空前大小: 3
清空前是否为空: false
清空后大小: 0
清空后是否为空: true
```

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

功能：判断此 [ArrayStack](#class-arraystackt) 是否为空。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果为空，返回 true，否则返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let stack = ArrayStack<Int64>()
    
    // 空栈
    println("空栈是否为空: ${stack.isEmpty()}")  // true
    
    // 添加元素后
    stack.add(1)
    println("添加元素后是否为空: ${stack.isEmpty()}")  // false
    
    // 移除所有元素后
    stack.remove()
    println("移除元素后是否为空: ${stack.isEmpty()}")  // true
    
    return 0
}
```

运行结果：

```text
空栈是否为空: true
添加元素后是否为空: false
移除元素后是否为空: true
```

### func iterator()

```cangjie
public func iterator(): Iterator<T>
```

功能：返回此 [ArrayStack](#class-arraystackt) 中元素的迭代器，其顺序为出栈的顺序。

返回值：

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - 栈中元素的迭代器。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let stack = ArrayStack<Int64>()
    
    // 添加元素
    stack.add(1)
    stack.add(2)
    stack.add(3)
    
    // 使用迭代器遍历栈
    let iter = stack.iterator()
    println(iter.next())
    println(iter.next())
    println(iter.next())
    
    return 0
}
```

运行结果：

```text
Some(3)
Some(2)
Some(1)
```

### func peek()

```cangjie
public func peek(): ?T
```

功能：获取栈顶的元素，该操作不会做出栈操作，只查看栈顶的元素。当栈为空时，返回 `None`。

返回值：

- ?T - 栈顶的元素。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let stack = ArrayStack<Int64>()
    
    // 查看空栈的栈顶元素
    let emptyPeek = stack.peek()
    println("空栈栈顶元素: ${emptyPeek}")  // None
    
    // 添加元素后查看栈顶元素
    stack.add(10)
    stack.add(20)
    let peekValue = stack.peek()
    println("栈顶元素: ${peekValue}")  // Some(20)
    
    // 查看栈顶元素不会移除元素
    println("查看后栈大小: ${stack.size}")  // 2
    
    return 0
}
```

运行结果：

```text
空栈栈顶元素: None
栈顶元素: Some(20)
查看后栈大小: 2
```

### func remove()

```cangjie
public func remove(): ?T
```

功能：出栈操作，删除栈顶的元素并且返回这个元素。当栈为空时，返回 `None`。

返回值：

- ?T - 被删除的栈顶元素。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let stack = ArrayStack<Int64>()
    
    // 从空栈移除元素
    let emptyRemove = stack.remove()
    println("从空栈移除元素: ${emptyRemove}")  // None
    
    // 添加元素后移除
    stack.add(10)
    stack.add(20)
    stack.add(30)
    
    let removedElement = stack.remove()
    println("移除的元素: ${removedElement}")  // Some(30)
    println("移除后栈大小: ${stack.size}")   // 2
    
    return 0
}
```

运行结果：

```text
从空栈移除元素: None
移除的元素: Some(30)
移除后栈大小: 2
```

### func reserve(Int64)

```cangjie
public func reserve(additional: Int64): Unit
```

功能：为当前 [ArrayStack](#class-arraystackt) 扩容相应的空间。当 additional 小于等于零时，不发生扩容；如果当前剩余空间大小大于等于 additional，不进行扩容操作，否则当前 [ArrayStack](#class-arraystackt) 会扩容至 size + additional 大小。

参数：

- additional: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 将要扩容的大小。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let stack = ArrayStack<Int64>()
    
    // 初始容量
    println("初始容量: ${stack.capacity}")  // 8
    
    // 预留额外空间
    stack.reserve(10)
    println("预留空间后容量: ${stack.capacity}")  // 12 (扩容到接近18的合适大小)
    
    // 添加元素测试
    for (i in 0..15) {
        stack.add(i)
    }
    println("添加16个元素后容量: ${stack.capacity}")  // 18
    println("添加16个元素后大小: ${stack.size}")    // 16
    
    return 0
}
```

运行结果：

```text
初始容量: 8
预留空间后容量: 12
添加16个元素后容量: 18
添加16个元素后大小: 15
```

### func toArray()

```cangjie
public func toArray(): Array<T>
```

功能：返回一个数组，其中元素为栈中的元素，顺序为栈的出栈顺序。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - T 类型数组。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let stack = ArrayStack<Int64>()
    
    // 添加元素
    stack.add(1)
    stack.add(2)
    stack.add(3)
    
    println("栈: ${stack}")  // [3, 2, 1]
    
    // 转换为数组
    let array = stack.toArray()
    
    println("数组: ${array}")      // [3, 2, 1]
    println("数组大小: ${array.size}") // 3
    
    return 0
}
```

运行结果：

```text
栈: [3, 2, 1]
数组: [3, 2, 1]
数组大小: 3
```

### extend\<T> ArrayStack\<T> <: ToString where T <: ToString

```cangjie
extend<T> ArrayStack<T> <: ToString where T <: ToString
```

功能：为 ArrayStack 扩展 [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) 接口，支持转字符串操作。

父类型：

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

功能：获取当前 [ArrayStack](./collection_package_class.md#class-arraystackt)\<T> 实例的字符串表示。

该字符串包含栈内每个元素的字符串表示，其顺序为从后到前的顺序。形如："[elem1, elem2, elem3]"。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 当前栈的字符串表示。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let stack = ArrayStack<Int64>()
    
    // 空栈转字符串
    let emptyStr = stack.toString()
    println("空栈字符串: ${emptyStr}")  // []
    
    // 添加元素后转字符串
    stack.add(1)
    stack.add(2)
    stack.add(3)
    
    let str = stack.toString()
    println("栈字符串: ${str}")      // [3, 2, 1]
    println("字符串长度: ${str.size}")  // 9
    
    return 0
}
```

运行结果：

```text
空栈字符串: []
栈字符串: [3, 2, 1]
字符串长度: 9
```


## class HashMap\<K, V> where K <: Hashable & Equatable\<K>

```cangjie
public class HashMap<K, V> <: Map<K, V> where K <: Hashable & Equatable<K> {
    public init()
    public init(elements: Array<(K, V)>)
    public init(elements: Collection<(K, V)>)
    public init(capacity: Int64)
    public init(size: Int64, initElement: (Int64) -> (K, V))
}
```

功能：[Map](collection_package_interface.md#interface-mapk-v) 接口的哈希表实现。

哈希表是一种常用的数据结构，它可以用来快速地查找、插入和删除数据。哈希表的基本原理是将数据映射到一个数组中，这个数组称为哈希表。每个数据元素都有一个对应的哈希值，这个哈希值可以用来确定该元素在哈希表中的位置。

哈希表的特点是快速的查找、插入和删除操作，时间复杂度通常是O(1)。由于哈希表底层的数组大小是动态的，所以哈希表不能保证元素的顺序不可变。

父类型：

- [Map](collection_package_interface.md#interface-mapk-v)\<K, V>

### prop capacity

```cangjie
public prop capacity: Int64
```

功能：返回 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 的容量。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个默认HashMap
    let map = HashMap<String, Int64>()
    
    // 查看初始容量
    println("初始容量: ${map.capacity}")  // 16
    
    // 创建指定容量的HashMap
    let map2 = HashMap<String, Int64>(32)
    println("指定容量: ${map2.capacity}")  // 32
    
    return 0
}
```

运行结果：

```text
初始容量: 16
指定容量: 32
```

### prop size

```cangjie
public prop size: Int64
```

功能：返回键值对的个数。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个HashMap
    let map = HashMap<String, Int64>()
    
    // 查看初始大小
    println("初始大小: ${map.size}")  // 0
    
    // 添加元素后查看大小
    map["one"] = 1
    map["two"] = 2
    println("添加元素后大小: ${map.size}")  // 2
    
    return 0
}
```

运行结果：

```text
初始大小: 0
添加元素后大小: 2
```

### init()

```cangjie
public init()
```

功能：构造一个具有默认初始容量为16和默认负载因子为空的 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 使用默认构造函数创建HashMap
    let map = HashMap<String, Int64>()
    
    println("初始大小: ${map.size}")      // 0
    println("初始容量: ${map.capacity}")  // 16
    println("是否为空: ${map.isEmpty()}") // true
    
    return 0
}
```

运行结果：

```text
初始大小: 0
初始容量: 16
是否为空: true
```

### init(Array\<(K, V)>)

```cangjie
public init(elements: Array<(K, V)>)
```

功能：通过传入的键值对数组构造一个 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)。

该构造函数根据传入数组的 size 设置 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 的容量。由于[HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 内部不允许键重复，当 [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt) 中存在重复的键时，按照迭代器顺序，出现在后面的键值对将会覆盖前面的键值对。

参数：

- elements: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<(K, V)> - 初始化该 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 的键值对数组。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 通过数组创建HashMap
    let elements = [("one", 1), ("two", 2), ("three", 3)]
    let map = HashMap<String, Int64>(elements)
    
    println("HashMap大小: ${map.size}")      // 3
    println("HashMap容量: ${map.capacity}")  // 3
    
    // 检查元素是否存在
    if (map.contains("one")) {
        println("包含键 'one'")
    }
    
    return 0
}
```

运行结果：

```text
HashMap大小: 3
HashMap容量: 3
包含键 'one'
```

### init(Collection\<(K, V)>)

```cangjie
public init(elements: Collection<(K, V)>)
```

功能：通过传入的键值对集合构造一个 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)。

该构造函数根据传入集合 elements 的 size 设置 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 的容量。由于[HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 内部不允许键重复，当 [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt) 中存在重复的键时，按照迭代器顺序，出现在后面的键值对将会覆盖前面的键值对。

参数：

- elements: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<(K, V)> - 初始化该 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 的键值对集合。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 通过集合创建HashMap
    let list = ArrayList<(String, Int64)>([("a", 1), ("b", 2), ("c", 3)])
    let map = HashMap<String, Int64>(list)
    
    println("HashMap大小: ${map.size}")  // 3
    
    // 检查元素
    let value = map.get("b")
    if (value.isSome()) {
        println("键 'b' 对应的值: ${value.getOrThrow()}")  // 2
    }
    
    return 0
}
```

运行结果：

```text
HashMap大小: 3
键 'b' 对应的值: 2
```

### init(Int64)

```cangjie
public init(capacity: Int64)
```

功能：构造一个带有传入容量大小的 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)。

参数：

- capacity: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 初始化容量大小。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果 capacity 小于 0 则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建指定容量的HashMap
    let map = HashMap<String, Int64>(32)
    
    println("HashMap容量: ${map.capacity}")  // 32
    println("HashMap大小: ${map.size}")      // 0
    
    // 添加元素
    map["key1"] = 100
    map["key2"] = 200
    println("添加元素后大小: ${map.size}")    // 2
    
    return 0
}
```

运行结果：

```text
HashMap容量: 32
HashMap大小: 0
添加元素后大小: 2
```

### init(Int64, (Int64) -> (K, V))

```cangjie
public init(size: Int64, initElement: (Int64) -> (K, V))
```

功能：通过传入的元素个数 size 和函数规则来构造 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)。

构造出的 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 的容量受 size 大小影响。由于[HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 内部不允许键重复，当函数 initElement 生成相同的键时，后构造的键值对将会覆盖之前出现的键值对。

参数：

- size: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 初始化该 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 的函数规则。
- initElement: ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) -> (K, V) - 初始化该 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 的函数规则。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果 size 小于 0 则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 使用size和函数规则创建HashMap
    let map = HashMap<String, Int64>(3, {index => 
        let keys = ["first", "second", "third"]
        return (keys[index], index * 10)
    })
    
    println("HashMap大小: ${map.size}")  // 3
    
    // 检查元素
    let value = map.get("second")
    if (value.isSome()) {
        println("键 'second' 对应的值: ${value.getOrThrow()}")  // 10
    }
    
    return 0
}
```

运行结果：

```text
HashMap大小: 3
键 'second' 对应的值: 10
```

### func add(Collection\<(K, V)>)

```cangjie
public func add(all!: Collection<(K, V)>): Unit
```

功能：按照 elements 的迭代器顺序将新的键值对集合放入 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 中。

对于 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 中已有的键，该键的值将被新值替换。

参数：

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<(K, V)> - 需要添加进 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 的键值对集合。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashMap
    let map = HashMap<String, Int64>()
    map["a"] = 1
    
    // 创建要添加的键值对集合
    let newElements = ArrayList<(String, Int64)>([("b", 2), ("c", 3), ("a", 10)])
    
    println("添加集合前大小: ${map.size}")  // 1
    println("添加集合前 'a' 的值: ${map["a"]}")  // 1
    
    // 添加键值对集合
    map.add(all: newElements)
    
    println("添加集合后大小: ${map.size}")  // 3
    println("添加集合后 'a' 的值: ${map["a"]}")  // 10
    
    return 0
}
```

运行结果：

```text
添加集合前大小: 1
添加集合前 'a' 的值: 1
添加集合后大小: 3
添加集合后 'a' 的值: 10
```

### func add(K, V)

```cangjie
public func add(key: K, value: V): Option<V>
```

功能：将键值对放入 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 中。

对于 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 中已有的键，该键的值将被新值替换，并且返回旧的值。

参数：

- key: K - 要放置的键。
- value: V - 要分配的值。

返回值：

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V> - 如果赋值之前 key 存在，旧的 value 用 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 封装；否则，返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V>.None。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashMap
    let map = HashMap<String, Int64>()
    
    // 添加新键值对
    let result1 = map.add("first", 100)
    println("添加新键 'first' 的返回值: ${result1.isSome()}")  // false
    
    // 替换已存在的键
    let result2 = map.add("first", 200)
    if (result2.isSome()) {
        println("替换键 'first' 的旧值: ${result2.getOrThrow()}")  // 100
    }
    
    println("当前 'first' 的值: ${map["first"]}")  // 200
    
    return 0
}
```

运行结果：

```text
添加新键 'first' 的返回值: false
替换键 'first' 的旧值: 100
当前 'first' 的值: 200
```

### func all((K, V) -> Bool)

```cangjie
public func all(predicate: (K, V) -> Bool): Bool
```

功能：判断 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 中所有键值对是否都满足条件。

参数：

- predicate: (K, V) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 中所有键值对都满足条件，返回 true，否则返回 false

### func any((K, V) -> Bool)

```cangjie
public func any(predicate: (K, V) -> Bool): Bool
```

功能：判断 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 是否存在任意一个满足条件的键值对。

参数：

- predicate: (K, V) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 是否存在任意满足条件的键值对。

### func clear()

```cangjie
public func clear(): Unit
```

功能：清除所有键值对。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashMap并添加元素
    let map = HashMap<String, Int64>()
    map["a"] = 1
    map["b"] = 2
    map["c"] = 3
    
    println("清除前大小: ${map.size}")  // 3
    println("清除前是否为空: ${map.isEmpty()}")  // false
    
    // 清除所有键值对
    map.clear()
    
    println("清除后大小: ${map.size}")  // 0
    println("清除后是否为空: ${map.isEmpty()}")  // true
    
    return 0
}
```

运行结果：

```text
清除前大小: 3
清除前是否为空: false
清除后大小: 0
清除后是否为空: true
```

### func clone()

```cangjie
public func clone(): HashMap<K, V>
```

功能：克隆 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)。

返回值：

- [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, V> - 返回一个 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建原始HashMap
    let originalMap = HashMap<String, Int64>()
    originalMap["a"] = 1
    originalMap["b"] = 2
    
    // 克隆HashMap
    let clonedMap = originalMap.clone()
    
    println("原始HashMap大小: ${originalMap.size}")  // 2
    println("克隆HashMap大小: ${clonedMap.size}")    // 2
    
    // 修改克隆的HashMap
    clonedMap["c"] = 3
    println("修改后原始HashMap大小: ${originalMap.size}")  // 2
    println("修改后克隆HashMap大小: ${clonedMap.size}")    // 3
    
    return 0
}
```

运行结果：

```text
原始HashMap大小: 2
克隆HashMap大小: 2
修改后原始HashMap大小: 2
修改后克隆HashMap大小: 3
```

### func contains(Collection\<K>)

```cangjie
public func contains(all!: Collection<K>): Bool
```

功能：判断是否包含指定集合中所有键的映射。

参数：

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<K> - 键传递待判断的 keys。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果都包含，则返回 true；否则，返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashMap
    let map = HashMap<String, Int64>()
    map["a"] = 1
    map["b"] = 2
    map["c"] = 3
    
    // 检查是否包含指定键集合
    let keys1 = ArrayList<String>(["a", "b"])
    let result1 = map.contains(all: keys1)
    println("是否包含键[a, b]: ${result1}")  // true
    
    let keys2 = ArrayList<String>(["a", "d"])
    let result2 = map.contains(all: keys2)
    println("是否包含键[a, d]: ${result2}")  // false
    
    return 0
}
```

运行结果：

```text
是否包含键[a, b]: true
是否包含键[a, d]: false
```

### func contains(K)

```cangjie
public func contains(key: K): Bool
```

功能：判断是否包含指定键的映射。

参数：

- key: K - 传递要判断的 key。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果存在，则返回 true；否则，返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashMap
    let map = HashMap<String, Int64>()
    map["apple"] = 1
    map["banana"] = 2
    
    // 检查是否包含指定键
    let hasApple = map.contains("apple")
    let hasOrange = map.contains("orange")
    
    println("是否包含键 'apple': ${hasApple}")  // true
    println("是否包含键 'orange': ${hasOrange}")  // false
    
    return 0
}
```

运行结果：

```text
是否包含键 'apple': true
是否包含键 'orange': false
```

### func entryView(K)

```cangjie
public func entryView(key: K): MapEntryView<K, V>
```

功能：如果不包含特定键，返回一个空的引用视图。如果包含特定键，则返回该键对应的元素的引用视图。

参数：

- key: K - 要添加的键值对的键。

返回值：

- [MapEntryView](./collection_package_interface.md#interface-mapentryviewk-v)\<K, V> - 一个引用视图。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashMap
    let map = HashMap<String, Int64>()
    map["key1"] = 100
    
    // 获取存在的键的引用视图
    let view1 = map.entryView("key1")
    if (view1.value.isSome()) {
        println("找到键 'key1'，值为: ${view1.value.getOrThrow()}")  // 100
    }
    
    // 通过entryView设置值
    view1.value = Some(150)
    println("修改后键 'key1' 的值为: ${map["key1"]}")  // 150
    
    return 0
}
```

运行结果：

```text
找到键 'key1'，值为: 100
修改后键 'key1' 的值为: 150
```

### func filter((K, V) -> Bool)
```cangjie
public func filter(predicate: (K, V) -> Bool): HashMap<K, V>
```

功能： 返回一个满足筛选条件的键值对的新 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, V>。

参数：

- predicate: (K, V) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, V> - 返回一个满足筛选条件的键值对的新集合。

### func fold\<R>(R, (R, K, V) -> R)

```cangjie
public func fold<R>(initial: R, operation: (R, K, V) -> R): R
```

功能：使用指定初始值，从左向右计算。

参数：

- initial: R - 给定的 R 类型的初始值。
- operation: (R, K, V) -> R - 给定的计算函数。

返回值：

- R - 返回最终计算得到的值。

### func forEach((K, V) -> Unit)

```cangjie
public func forEach(action: (K, V) -> Unit): Unit
```

功能：遍历所有键值对，执行给定的操作。

参数：

- action: (K, V) -> [Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - 给定的操作函数。

### func get(K)

```cangjie
public func get(key: K): ?V
```

功能：返回指定键映射到的值，如果 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 不包含指定键的映射，则返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V>.None。

参数：

- key: K - 传入的键。

返回值：

- ?V - 键对应的值。用 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 封装。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashMap
    let map = HashMap<String, Int64>()
    map["name"] = 100
    map["age"] = 25
    
    // 获取存在的键
    let nameValue = map.get("name")
    if (nameValue.isSome()) {
        println("键 'name' 的值: ${nameValue.getOrThrow()}")  // 100
    }
    
    // 获取不存在的键
    let heightValue = map.get("height")
    if (heightValue.isNone()) {
        println("键 'height' 不存在")
    }
    
    return 0
}
```

运行结果：

```text
键 'name' 的值: 100
键 'height' 不存在
```

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

功能：判断 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 是否为空，如果是，则返回 true；否则，返回 false。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 是否为空。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建空HashMap
    let map = HashMap<String, Int64>()
    
    // 检查是否为空
    println("空HashMap是否为空: ${map.isEmpty()}")  // true
    
    // 添加元素后检查
    map["key"] = 100
    println("添加元素后是否为空: ${map.isEmpty()}")  // false
    
    // 清空后检查
    map.clear()
    println("清空后是否为空: ${map.isEmpty()}")  // true
    
    return 0
}
```

运行结果：

```text
空HashMap是否为空: true
添加元素后是否为空: false
清空后是否为空: true
```

### func iterator()

```cangjie
public func iterator(): HashMapIterator<K, V>
```

功能：返回 HashMap 的迭代器。

返回值：

- [HashMapIterator](collection_package_class.md#class-hashmapiteratork-v-where-k--hashable--equatablek)\<K, V> - 返回 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 的迭代器。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashMap
    let map = HashMap<String, Int64>()
    map["a"] = 1
    map["b"] = 2
    map["c"] = 3
    
    // 获取迭代器
    let iterator = map.iterator()
    
    // 遍历元素
    var count = 0
    while (true) {
        let element = iterator.next()
        if (element.isNone()) {
            break
        }
        count += 1
    }
    
    println("迭代器遍历元素个数: ${count}")  // 3
    
    return 0
}
```

运行结果：

```text
迭代器遍历元素个数: 3
```

### func keys()

```cangjie
public func keys(): EquatableCollection<K>
```

功能：返回 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 中所有的 key，并将所有 key 存储在一个 Keys 容器中。

返回值：

- [EquatableCollection](collection_package_interface.md#interface-equatablecollectiont)\<K> - 保存所有返回的 key。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashMap
    let map = HashMap<String, Int64>()
    map["a"] = 1
    map["b"] = 2
    map["c"] = 3
    
    // 获取所有键
    let keys = map.keys()
    
    println("键的数量: ${keys.size}")  // 3
    
    // 检查是否包含特定键
    if (keys.contains("b")) {
        println("包含键 'b'")  // 包含键 'b'
    }
    
    return 0
}
```

运行结果：

```text
键的数量: 3
包含键 'b'
```

### func mapValues\<R>((K, V) -> R)

```cangjie
public func mapValues<R>(transform: (K, V) -> R): HashMap<K, R>
```

功能：对此 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 进行映射并返回一个新 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)。

参数：

- transform: (K, V) -> R - 给定的映射函数。

返回值：

- [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, R> - 返回一个新的 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)。

### func mapValues\<R>((V) -> R)

```cangjie
public func mapValues<R>(transform: (V) -> R): HashMap<K, R>
```

功能：对此 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 进行映射并返回一个新 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)。

参数：

- transform: (V) -> R - 给定的映射函数。

返回值：

- [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, R> - 返回一个新的 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)。

### func none((K, V) -> Bool)

```cangjie
public func none(predicate: (K, V) -> Bool): Bool
```

功能：判断 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 中所有键值对是否都不满足条件。

参数：

- predicate: (K, V) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 当前 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 中键值对是否都不满足条件。

### func reduce((V, V) -> V)

```cangjie
public func reduce(operation: (V, V) -> V): Option<V>
```

功能：使用第一个值作为初始值，从左向右计算。

参数：

- operation: (V, V) -> V - 给定的计算函数。

返回值：

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V> - 返回计算结果。

### func remove(Collection\<K>)

```cangjie
public func remove(all!: Collection<K>): Unit
```

功能：从此 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 中删除指定集合中键的映射（如果存在）。

参数：

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<K> - 传入要删除的键的集合。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashMap
    let map = HashMap<String, Int64>()
    map["a"] = 1
    map["b"] = 2
    map["c"] = 3
    map["d"] = 4
    
    println("删除前大小: ${map.size}")  // 4
    
    // 创建要删除的键集合
    let keysToRemove = ArrayList<String>(["a", "c", "e"])
    
    // 删除指定键集合
    map.remove(all: keysToRemove)
    
    println("删除后大小: ${map.size}")  // 2
    println("是否包含 'b': ${map.contains("b")}")  // true
    println("是否包含 'a': ${map.contains("a")}")  // false
    
    return 0
}
```

运行结果：

```text
删除前大小: 4
删除后大小: 2
是否包含 'b': true
是否包含 'a': false
```

### func remove(K)

```cangjie
public func remove(key: K): Option<V>
```

功能：从此 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 中删除指定键的映射（如果存在）。

参数：

- key: K - 传入要删除的 key。

返回值：

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V> - 被从 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 中移除的键对应的值，用 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 封装，如果 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)中不存该键，返回 None 。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashMap
    let map = HashMap<String, Int64>()
    map["x"] = 10
    map["y"] = 20
    map["z"] = 30
    
    println("删除前大小: ${map.size}")  // 3
    
    // 删除存在的键
    let removedValue = map.remove("y")
    if (removedValue.isSome()) {
        println("删除键 'y'，返回值: ${removedValue.getOrThrow()}")  // 20
    }
    
    // 删除不存在的键
    let nonExistValue = map.remove("w")
    if (nonExistValue.isNone()) {
        println("键 'w' 不存在，返回 None")
    }
    
    println("删除后大小: ${map.size}")  // 2
    
    return 0
}
```

运行结果：

```text
删除前大小: 3
删除键 'y'，返回值: 20
键 'w' 不存在，返回 None
删除后大小: 2
```

### func removeIf((K, V) -> Bool)

```cangjie
public func removeIf(predicate: (K, V) -> Bool): Unit
```

功能：传入 lambda 表达式，如果满足条件，则删除对应的键值对。

该函数会遍历整个[HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)，所以满足 `predicate(K, V) == true` 的键值对都会被删除。

参数：

- predicate: (K, V) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 传递一个 lambda 表达式进行判断。

异常：

- [ConcurrentModificationException](./collection_package_exception.md#class-concurrentmodificationexception) - 当 `predicate` 中增删或者修改 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 内键值对时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashMap
    let map = HashMap<String, Int64>()
    map["a"] = 1
    map["b"] = 2
    map["c"] = 3
    map["d"] = 4
    
    println("删除前大小: ${map.size}")  // 4
    
    // 删除值大于2的键值对
    map.removeIf({_: String, value: Int64 => value > 2})
    
    println("删除后大小: ${map.size}")  // 2
    
    // 检查剩余元素
    let remaining = map.get("b")
    if (remaining.isSome()) {
        println("键 'b' 仍存在，值为: ${remaining.getOrThrow()}")  // 2
    }
    
    return 0
}
```

运行结果：

```text
删除前大小: 4
删除后大小: 2
键 'b' 仍存在，值为: 2
```

### func reserve(Int64)

```cangjie
public func reserve(additional: Int64): Unit
```

功能：扩容当前的[HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)。

将 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 扩容 additional 大小当 additional 小于等于零时，不发生扩容；当 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 剩余容量大于等于 additional 时，不发生扩容；当 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 剩余容量小于 additional 时，取（原始容量的1.5倍向下取整）与（additional + 已使用容量）中的最大值进行扩容。

参数：

- additional: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 将要扩容的大小。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当additional + 已使用容量超过Int64.Max时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashMap
    let map = HashMap<String, Int64>()
    
    println("初始容量: ${map.capacity}")  // 16
    
    // 预留额外空间
    map.reserve(20)
    
    println("预留空间后容量: ${map.capacity}")  // 24 (扩容到合适的大小)
    
    // 添加元素测试
    for (i in 0..30) {
        map["key${i}"] = i
    }
    
    println("添加元素后容量: ${map.capacity}")  // 36
    println("添加元素后大小: ${map.size}")    // 30
    
    return 0
}
```

运行结果：

```text
初始容量: 16
预留空间后容量: 24
添加元素后容量: 36
添加元素后大小: 30
```

### func toArray()

```cangjie
public func toArray(): Array<(K, V)>
```

功能：构造一个包含 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 内键值对的数组，并返回。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<(K, V)> - 包含容器内所有键值对的数组。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashMap
    let map = HashMap<String, Int64>()
    map["a"] = 1
    map["b"] = 2
    map["c"] = 3
    
    // 转换为数组
    let array = map.toArray()
    
    println("数组大小: ${array.size}")  // 3
    
    // 遍历数组元素
    for (i in 0..array.size) {
        let (key, value) = array[i]
        println("键: ${key}, 值: ${value}")
    }
    
    return 0
}
```

运行结果：

```text
数组大小: 3
键: a, 值: 1
键: b, 值: 2
键: c, 值: 3
```

### func values()

```cangjie
public func values(): Collection<V>
```

功能：返回 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 中包含的值，并将所有的 value 存储在一个 Values 容器中。

返回值：

- [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<V> - 保存所有返回的 value。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashMap
    let map = HashMap<String, Int64>()
    map["apple"] = 10
    map["banana"] = 20
    map["orange"] = 30
    
    // 获取所有值
    let values = map.values()
    
    println("值的数量: ${values.size}")  // 3
    
    // 遍历所有值
    println("所有值: ")
    for (i in values) {
        println(i)
    }
    return 0
}
```

运行结果：

```text
值的数量: 3
所有值: 
10
20
30
```

### operator func \[](K)

```cangjie
public operator func [](key: K): V
```

功能：运算符重载 get 方法，如果键存在，返回键对应的值。

参数：

- key: K - 传递值进行判断。

返回值：

- V - 与键对应的值。

异常：

- [NoneValueException](../../core/core_package_api/core_package_exceptions.md#class-nonevalueexception) - 如果该 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 不存在该键，抛此异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashMap
    let map = HashMap<String, Int64>()
    map["data1"] = 100
    map["data2"] = 200
    
    // 使用[]运算符获取值
    let value1 = map["data1"]
    let value2 = map["data2"]
    
    println("键 'data1' 的值: ${value1}")  // 100
    println("键 'data2' 的值: ${value2}")  // 200
    
    return 0
}
```

运行结果：

```text
键 'data1' 的值: 100
键 'data2' 的值: 200
```

### operator func \[](K, V)

```cangjie
public operator func [](key: K, value!: V): Unit
```

功能：运算符重载 add 方法，如果键存在，新 value 覆盖旧 value，如果键不存在，添加此键值对。

参数：

- key: K - 传递值进行判断。
- value!: V - 传递要设置的值。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashMap
    let map = HashMap<String, Int64>()
    
    // 使用[]运算符设置键值对
    map["first"] = 100
    map["second"] = 200
    
    println("设置后大小: ${map.size}")  // 2
    
    // 覆盖已存在的键
    map["first"] = 150
    
    println("覆盖后 'first' 的值: ${map["first"]}")  // 150
    println("'second' 的值: ${map["second"]}")  // 200
    
    return 0
}
```

运行结果：

```text
设置后大小: 2
覆盖后 'first' 的值: 150
'second' 的值: 200
```

### extend\<K, V> HashMap\<K, V> <: Equatable\<HashMap\<K, V>> where V <: Equatable\<V>

```cangjie
extend<K, V> HashMap<K, V> <: Equatable<HashMap<K, V>> where V <: Equatable<V>
```

功能：为 [HashMap](./collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, V> 类型扩展 [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[HashMap](./collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, V>> 接口，支持判等操作。

父类型：

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[HashMap](./collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, V>>

#### operator func !=(HashMap\<K, V>)

```cangjie
public operator func !=(right: HashMap<K, V>): Bool
```

功能：判断当前实例与参数指向的 [HashMap](./collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, V> 实例是否不等。

参数：

- right: [HashMap](./collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, V> - 被比较的对象。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果不等，则返回 true，否则返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建两个HashMap
    let map1 = HashMap<String, Int64>()
    map1["x"] = 10
    map1["y"] = 20
    
    let map2 = HashMap<String, Int64>()
    map2["x"] = 10
    map2["y"] = 30
    
    let map3 = HashMap<String, Int64>()
    map3["y"] = 20
    map3["x"] = 10
    
    // 比较不相等的HashMap
    println("map1 != map2: ${map1 != map2}")  // true
    
    // 比较相等的HashMap
    println("map1 != map3: ${map1 != map3}")  // false
    
    return 0
}
```

运行结果：

```text
map1 != map2: true
map1 != map3: false
```

#### operator func ==(HashMap\<K, V>)

```cangjie
public operator func ==(right: HashMap<K, V>): Bool
```

功能：判断当前实例与参数指向的 [HashMap](./collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, V> 实例是否相等。

两个 [HashMap](./collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, V> 相等指的是其中包含的键值对完全相等。

参数：

- right: [HashMap](./collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, V> - 被比较的对象。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果相等，则返回 true，否则返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建两个HashMap
    let map1 = HashMap<String, Int64>()
    map1["a"] = 1
    map1["b"] = 2
    
    let map2 = HashMap<String, Int64>()
    map2["b"] = 2
    map2["a"] = 1
    
    let map3 = HashMap<String, Int64>()
    map3["a"] = 1
    map3["b"] = 3
    
    // 比较相等的HashMap
    println("map1 == map2: ${map1 == map2}")  // true
    
    // 比较不相等的HashMap
    println("map1 == map3: ${map1 == map3}")  // false
    
    return 0
}
```

运行结果：

```text
map1 == map2: true
map1 == map3: false
```

### extend\<K, V> HashMap\<K, V> <: ToString where V <: ToString, K <: ToString

```cangjie
extend<K, V> HashMap<K, V> <: ToString where V <: ToString, K <: ToString
```

功能：为 [HashMap](./collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, V> 扩展 [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) 接口，支持转字符串操作。

父类型：

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

功能：将当前 [HashMap](./collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, V> 实例转换为字符串。

该字符串包含 [HashMap](./collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, V> 内每个键值对的字符串表示，形如："[(k1, v1), (k2, v2), (k3, v3)]"。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 转换得到的字符串。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashMap
    let map = HashMap<String, Int64>()
    map["apple"] = 5
    map["banana"] = 3
    map["orange"] = 8
    
    // 转换为字符串
    let mapString = map.toString()
    
    println("空集合的字符串: ${HashMap<String, Int64>().toString()}")  // []
    println("HashMap的字符串表示: ${mapString}")
    
    return 0
}
```

运行结果：

```text
空集合的字符串: []
HashMap的字符串表示: [(apple, 5), (banana, 3), (orange, 8)]
```

## class HashMapIterator\<K, V> where K <: Hashable & Equatable\<K>

```cangjie
public class HashMapIterator<K, V> <: Iterator<(K, V)> where K <: Hashable & Equatable<K> {
    public init(map: HashMap<K, V>)
}
```

功能：此类主要实现 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 的迭代器功能。

父类型：

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<(K, V)>

### init(HashMap\<K, V>)

```cangjie
public init(map: HashMap<K, V>)
```

功能：创建 [HashMapIterator](collection_package_class.md#class-hashmapiteratork-v-where-k--hashable--equatablek)\<K, V> 实例。

参数：

- map: [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, V> - 传入 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, V>。

示例：

<!-- run -->
```cangjie
import std.collection.*

main() {
    // 创建一个HashMap
    let map = HashMap<String, Int64>()
    map["one"] = 1
    map["two"] = 2
    map["three"] = 3
    
    // 使用HashMap创建HashMapIterator
    let iterator = HashMapIterator<String, Int64>(map)
    return 0
}
```

### func next()

```cangjie
public func next(): ?(K, V)
```

功能：返回迭代器中的下一个元素。

返回值：

- ?(K, V) - 迭代器中的下一个元素，用 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 封装。

异常：

- [ConcurrentModificationException](collection_package_exception.md#class-concurrentmodificationexception) - 当函数检测到不同步的并发修改，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个HashMap
    let map = HashMap<String, Int64>()
    map["one"] = 1
    map["two"] = 2
    map["three"] = 3
    
    // 创建迭代器并获取第一个元素
    let iterator = HashMapIterator<String, Int64>(map)
    let firstElement = iterator.next()
    
    if (firstElement.isSome()) {
        println("成功获取到元素")
    } else {
        println("没有元素")
    }
    return 0
}
```

运行结果：

```text
成功获取到元素
```

### func remove()

```cangjie
public func remove(): Option<(K, V)>
```

功能：删除此 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 迭代器的 next 函数返回的元素，此函数只能在 next 函数调用时调用一次。

返回值：

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<(K, V)> - 返回被删除的元素。

异常：

- [ConcurrentModificationException](collection_package_exception.md#class-concurrentmodificationexception) - 当函数检测到不同步的并发修改，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个HashMap
    let map = HashMap<String, Int64>()
    map["one"] = 1
    map["two"] = 2
    
    // 创建迭代器，获取并删除元素
    let iterator = HashMapIterator<String, Int64>(map)
    let element = iterator.next()  // 先调用next获取元素
    let removed = iterator.remove()  // 然后调用remove删除元素
    
    if (element.isSome()) {
        println("成功获取到元素")
    }
    
    if (removed.isSome()) {
        println("成功删除元素")
    }
    return 0
}
```

运行结果：

```text
成功获取到元素
成功删除元素
```

## class HashSet\<T> where T <: Hashable & Equatable\<T>

```cangjie
public class HashSet<T> <: Set<T> where T <: Hashable & Equatable<T> {
    public init()
    public init(elements: Collection<T>)
    public init(elements: Array<T>)
    public init(capacity: Int64)
    public init(size: Int64, initElement: (Int64) -> T)
}
```

功能：基于 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 实现的 [Set](collection_package_interface.md#interface-sett) 接口的实例。

[HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)中的元素是无序的，不允许有重复元素。当我们向[HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)中添加元素时，[HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)会根据元素的哈希值来确定该元素在哈希表中的位置。

> **提示：**
>
> [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 是基于 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 实现的，因此 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 的容量、内存布局、时间性能等都和 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 相同。

父类型：

- [Set](collection_package_interface.md#interface-sett)\<T>

### prop capacity

```cangjie
public prop capacity: Int64
```

功能：返回此 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 的内部数组容量大小。

> **注意：**
>
> 容量大小不一定等于 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 的 size。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建默认HashSet
    let set = HashSet<String>()
    println("默认容量: ${set.capacity}")  // 16
    
    // 创建指定容量的HashSet
    let set2 = HashSet<String>(32)
    println("指定容量: ${set2.capacity}")  // 32
    
    // 添加元素后容量不变
    set.add("test")
    println("添加元素后容量: ${set.capacity}")  // 16
    
    return 0
}
```

运行结果：

```text
默认容量: 16
指定容量: 32
添加元素后容量: 16
```

### prop size

```cangjie
public prop size: Int64
```

功能：返回此 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 的元素个数。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建空HashSet
    let set = HashSet<String>()
    
    println("初始大小: ${set.size}")  // 0
    
    // 添加元素后查看大小
    set.add("apple")
    set.add("banana")
    set.add("apple")  // 重复元素，不会被添加
    
    println("添加元素后大小: ${set.size}")  // 2
    
    return 0
}
```

运行结果：

```text
初始大小: 0
添加元素后大小: 2
```

### init()

```cangjie
public init()
```

功能：构造一个空的 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)，初始容量为 16。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 使用默认构造函数创建HashSet
    let set = HashSet<String>()
    
    println("初始大小: ${set.size}")      // 0
    println("初始容量: ${set.capacity}")  // 16
    println("是否为空: ${set.isEmpty()}") // true
    
    return 0
}
```

运行结果：

```text
初始大小: 0
初始容量: 16
是否为空: true
```

### init(Array\<T>)

```cangjie
public init(elements: Array<T>)
```

功能：使用传入的数组构造 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)。该构造函数根据传入数组 elements 的 size 设置 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 的容量。

参数：

- elements: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - 初始化 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 的数组。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 通过数组创建HashSet
    let elements = ["apple", "banana", "orange", "apple"]  // 包含重复元素
    let set = HashSet<String>(elements)
    
    println("HashSet大小: ${set.size}")      // 3无重复元素）
    println("HashSet容量: ${set.capacity}")  // 4（根据数组大小设置）
    
    // 检查元素是否存在
    if (set.contains("apple")) {
        println("包含 'apple'")
    }
    
    return 0
}
```

运行结果：

```text
HashSet大小: 3
HashSet容量: 4
包含 'apple'
```

### init(Collection\<T>)

```cangjie
public init(elements: Collection<T>)
```

功能：使用传入的集合构造 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)。该构造函数根据传入集合 elements 的 size 设置 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 的容量。

参数：

- elements: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - 初始化 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 的集合。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 通过集合创建HashSet
    let list = ArrayList<String>(["red", "green", "blue", "red"])
    let set = HashSet<String>(list)
    
    println("HashSet大小: ${set.size}")  // 3
    
    // 检查元素
    if (set.contains("green")) {
        println("包含 'green'")
    }
    
    return 0
}
```

运行结果：

```text
HashSet大小: 3
包含 'green'
```

### init(Int64)

```cangjie
public init(capacity: Int64)
```

功能：使用传入的容量构造一个 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)。

参数：

- capacity: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 初始化容量大小。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果 capacity 小于 0，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 使用指定容量创建HashSet
    let set = HashSet<String>(32)
    
    println("初始容量: ${set.capacity}")  // 32
    println("初始大小: ${set.size}")      // 0
    println("是否为空: ${set.isEmpty()}") // true
    
    // 添加一些元素
    set.add("apple")
    set.add("banana")
    set.add("orange")
    
    println("\n添加元素后:")
    println("容量: ${set.capacity}")      // 32
    println("大小: ${set.size}")          // 3
    println("是否为空: ${set.isEmpty()}") // false
    
    // 对比默认容量的HashSet
    let defaultSet = HashSet<String>()
    println("\n默认容量HashSet: ${defaultSet.capacity}") // 16
    
    return 0
}
```

运行结果：

```text
初始容量: 32
初始大小: 0
是否为空: true

添加元素后:
容量: 32
大小: 3
是否为空: false

默认容量HashSet: 16
```

### init(Int64, (Int64) -> T)

```cangjie
public init(size: Int64, initElement: (Int64) -> T)
```

功能：通过传入的函数元素个数 size 和函数规则来构造 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)。构造出的 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 的容量受 size 大小影响。

参数：

- size: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 初始化函数中元素的个数。
- initElement: ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) ->T - 初始化函数规则。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果 size 小于 0，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 使用size和函数规则创建HashSet
    let set = HashSet<String>(3, {index => 
        let fruits = ["apple", "banana", "orange"]
        return fruits[index]
    })
    
    println("HashSet大小: ${set.size}")  // 3
    
    // 检查元素是否存在
    if (set.contains("banana")) {
        println("包含 'banana'")
    }
    
    return 0
}
```

运行结果：

```text
HashSet大小: 3
包含 'banana'
```

### func add(Collection\<T>)

```cangjie
public func add(all!: Collection<T>): Unit
```

功能：添加 [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont) 中的所有元素至此 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 中，如果元素存在，则不添加。

参数：

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - 需要被添加的元素的集合。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashSet
    let set = HashSet<String>()
    set.add("existing")
    
    // 创建要添加的元素集合
    let newElements = ArrayList<String>(["apple", "banana", "existing", "orange"])
    
    println("添加集合前大小: ${set.size}")  // 1
    
    // 添加元素集合
    set.add(all: newElements)
    
    println("添加集合后大小: ${set.size}")  // 4
    
    return 0
}
```

运行结果：

```text
添加集合前大小: 1
添加集合后大小: 4
```

### func add(T)

```cangjie
public func add(element: T): Bool
```

功能：将指定的元素添加到 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 中, 若添加的元素在 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 中存在, 则添加失败。

参数：

- element: T - 指定的元素。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果添加成功，则返回 true；否则，返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashSet
    let set = HashSet<String>()
    
    // 添加新元素
    let result1 = set.add("apple")
    println("添加 'apple' 的结果: ${result1}")  // true
    
    // 添加重复元素
    let result2 = set.add("apple")
    println("再次添加 'apple' 的结果: ${result2}")  // false
    
    println("集合大小: ${set.size}")  // 1
    
    return 0
}
```

运行结果：

```text
添加 'apple' 的结果: true
再次添加 'apple' 的结果: false
集合大小: 1
```

### func all((T) -> Bool)

```cangjie
public func all(predicate: (T) -> Bool): Bool
```

功能：判断 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 中所有元素是否都满足条件。

参数：

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 中所有元素都满足条件，返回 true，否则返回 false

### func any((T) -> Bool)

```cangjie
public func any(predicate: (T) -> Bool): Bool
```

功能：判断 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 是否存在任意一个满足条件的元素。

参数：

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 是否存在任意满足条件的元素。

### func clear()

```cangjie
public func clear(): Unit
```

功能：从此 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 中移除所有元素。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashSet并添加元素
    let set = HashSet<String>()
    set.add("apple")
    set.add("banana")
    set.add("orange")
    
    println("清除前大小: ${set.size}")  // 3
    println("清除前是否为空: ${set.isEmpty()}")  // false
    
    // 清除所有元素
    set.clear()
    
    println("清除后大小: ${set.size}")  // 0
    println("清除后是否为空: ${set.isEmpty()}")  // true
    
    return 0
}
```

运行结果：

```text
清除前大小: 3
清除前是否为空: false
清除后大小: 0
清除后是否为空: true
```

### func clone()

```cangjie
public func clone(): HashSet<T>
```

功能：克隆 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)。

返回值：

- [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> - 返回克隆到的 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建原始HashSet
    let originalSet = HashSet<String>()
    originalSet.add("apple")
    originalSet.add("banana")
    
    // 克隆HashSet
    let clonedSet = originalSet.clone()
    
    println("原始HashSet大小: ${originalSet.size}")  // 2
    println("克隆HashSet大小: ${clonedSet.size}")    // 2
    
    // 修改克隆的HashSet
    clonedSet.add("orange")
    println("修改后原始HashSet大小: ${originalSet.size}")  // 2
    println("修改后克隆HashSet大小: ${clonedSet.size}")    // 3
    
    return 0
}
```

运行结果：

```text
原始HashSet大小: 2
克隆HashSet大小: 2
修改后原始HashSet大小: 2
修改后克隆HashSet大小: 3
```

### func contains(Collection\<T>)

```cangjie
public func contains(all!: Collection<T>): Bool
```

功能：判断 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 是否包含指定 [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont) 中的所有元素。

参数：

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - 指定的元素集合。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果此 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 包含 [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont) 中的所有元素，则返回 true；否则，返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashSet并添加元素
    let set = HashSet<String>()
    set.add("apple")
    set.add("banana")
    set.add("orange")
    set.add("grape")
    
    // 检查集合中的部分元素
    let subset1 = ["apple", "banana"]
    if (set.contains(all: subset1)) {
        println("包含所有元素: ${subset1}")
    }
    
    // 检查包含不存在元素的集合
    let subset2 = ["apple", "cantaloupe"]
    if (!set.contains(all: subset2)) {
        println("不包含所有元素: ${subset2}")
    }
    
    // 检查空集合
    let emptyList = Array<String>()
    if (set.contains(all: emptyList)) {
        println("包含空集合")
    }
    
    // 使用另一个HashSet作为检查集合
    let otherSet = HashSet<String>()
    otherSet.add("orange")
    otherSet.add("grape")
    if (set.contains(all: otherSet)) {
        println("包含其他HashSet的所有元素")
    }
    
    return 0
}
```

运行结果：

```text
包含所有元素: [apple, banana]
不包含所有元素: [apple, cantaloupe]
包含空集合
包含其他HashSet的所有元素
```

### func contains(T)

```cangjie
public func contains(element: T): Bool
```

功能：判断 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 是否包含指定元素。

参数：

- element: T - 指定的元素。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果包含指定元素，则返回 true；否则，返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashSet并添加元素
    let set = HashSet<String>()
    set.add("apple")
    set.add("banana")
    set.add("orange")
    
    // 检查存在的元素
    if (set.contains("apple")) {
        println("包含 'apple'")
    }
    
    // 检查不存在的元素
    if (!set.contains("grape")) {
        println("不包含 'grape'")
    }
    
    // 使用contains检查多个元素
    let elements = ["apple", "grape", "banana"]
    for (element in elements) {
        let exists = set.contains(element)
        println("'${element}': ${exists}")
    }
    
    return 0
}
```

运行结果：

```text
包含 'apple'
不包含 'grape'
'apple': true
'grape': false
'banana': true
```

### func filter((T) -> Bool)
```cangjie
public func filter(predicate: (T) -> Bool): HashSet<T>
```

功能： 返回一个满足筛选条件的元素的新 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T>。

参数：

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> - 返回一个满足筛选条件的元素的新 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)。

### func filterMap\<R>((T) -> ?R)

```cangjie
public func filterMap<R>(transform: (T) -> ?R): HashSet<R>
```

功能：同时进行筛选操作和映射操作，返回一个新 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)。

参数：

- transform: (T) -> ?R - 给定的映射函数。函数返回值为 Some 对应 filter 的 predicate 为 true，反之表示 false。

返回值：

- [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<R> - 返回一个筛选和映射后的新 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)。

### func fold\<R>(R, (R, T) -> R)

```cangjie
public func fold<R>(initial: R, operation: (R, T) -> R): R
```

功能：使用指定初始值，从左向右计算。

参数：

- initial: R - 给定的 R 类型的初始值。
- operation: (R, T) -> R - 给定的计算函数。

返回值：

- R - 返回最终计算得到的值。

### func forEach((T) -> Unit)

```cangjie
public func forEach(action: (T) -> Unit): Unit
```

功能：遍历所有元素，执行给定的操作。

参数：

- action: (T) -> [Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - 给定的操作函数。

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

功能：判断 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 是否为空。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果为空，则返回 true；否则，返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建空HashSet
    let set = HashSet<String>()
    
    // 检查初始状态
    println("初始是否为空: ${set.isEmpty()}")
    println("初始大小: ${set.size}")
    
    // 添加元素后检查
    set.add("apple")
    set.add("banana")
    println("添加元素后是否为空: ${set.isEmpty()}")
    println("添加元素后大小: ${set.size}")
    
    // 清空后检查
    set.clear()
    println("清空后是否为空: ${set.isEmpty()}")
    println("清空后大小: ${set.size}")
    
    return 0
}
```

运行结果：

```text
初始是否为空: true
初始大小: 0
添加元素后是否为空: false
添加元素后大小: 2
清空后是否为空: true
清空后大小: 0
```

### func iterator()

```cangjie
public func iterator(): Iterator<T>
```

功能：返回此 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 的迭代器。

返回值：

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - 返回此 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 的迭代器。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashSet并添加元素
    let set = HashSet<String>()
    set.add("apple")
    set.add("banana")
    set.add("orange")
    
    // 使用iterator遍历元素
    println("使用iterator遍历:")
    let iter = set.iterator()
    while (true) {
        match (iter.next()) {
            case Some(element) => println("- ${element}")
            case None => break
        }
    }
    
    // 使用for-in循环遍历（内部使用iterator）
    println("\n使用for-in循环遍历:")
    for (element in set) {
        println("- ${element}")
    }
    
    return 0
}
```

运行结果：

```text
使用iterator遍历:
- apple
- banana
- orange

使用for-in循环遍历:
- apple
- banana
- orange
```

### func map\<R>((T)->R)

```cangjie
public func map<R>(transform: (T) -> R): HashSet<R> where R <: Hashable & Equatable<R>
```

功能：将当前 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 内所有 T 类型元素根据 transform 映射为 R 类型的元素，组成新的 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)。

参数：

- transform: (T)->R - 映射函数。

返回值：

- [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<R> - 原 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 中所有元素映射后得到的元素组成的新 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)。

### func none((T) -> Bool)

```cangjie
public func none(predicate: (T) -> Bool): Bool
```

功能：判断 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 中所有元素是否都不满足条件。

参数：

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 当前 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 中元素是否都不满足条件。

### func reduce((T, T) -> T)

```cangjie
public func reduce(operation: (T, T) -> T): Option<T>
```

功能：使用第一个元素作为初始值，从左向右计算。

参数：

- operation: (T, T) -> T - 给定的计算函数。

返回值：

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - 返回计算结果。

### func remove(Collection\<T>)

```cangjie
public func remove(all!: Collection<T>): Unit
```

功能：移除此 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 中那些也包含在指定 [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont) 中的所有元素。

参数：

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - 需要从此 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 中移除的元素的集合。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashSet并添加元素
    let set = HashSet<String>()
    set.add("apple")
    set.add("banana")
    set.add("orange")
    set.add("grape")
    set.add("cantaloupe")
    
    println("初始大小: ${set.size}")
    println("初始元素:")
    for (element in set) {
        println("- ${element}")
    }
    
    // 移除数组中的元素
    let toRemove = ["apple", "grape", "mango"]  // 包含不存在的元素
    set.remove(all: toRemove)
    
    println("\n移除 ${toRemove} 后:")
    println("移除后大小: ${set.size}")
    println("剩余元素:")
    for (element in set) {
        println("- ${element}")
    }
    
    // 使用另一个HashSet移除元素
    let otherSet = HashSet<String>()
    otherSet.add("banana")
    otherSet.add("cantaloupe")
    
    set.remove(all: otherSet)
    
    println("\n继续移除 ${otherSet} 后:")
    println("最终大小: ${set.size}")
    println("最终元素:")
    for (element in set) {
        println("- ${element}")
    }
    
    return 0
}
```

运行结果：

```text
初始大小: 5
初始元素:
- apple
- banana
- orange
- grape
- cantaloupe

移除 [apple, grape, mango] 后:
移除后大小: 3
剩余元素:
- banana
- orange
- cantaloupe

继续移除 [banana, cantaloupe] 后:
最终大小: 1
最终元素:
- orange
```

### func remove(T)

```cangjie
public func remove(element: T): Bool
```

功能：如果指定元素存在于此 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 中，则将其移除。

参数：

- element: T - 需要被移除的元素。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true，表示移除成功；false，表示移除失败。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashSet并添加元素
    let set = HashSet<String>()
    set.add("apple")
    set.add("banana")
    set.add("orange")
    
    println("初始大小: ${set.size}")
    
    // 移除存在的元素
    let result1 = set.remove("banana")
    println("移除 'banana' 的结果: ${result1}")
    println("移除后大小: ${set.size}")
    
    // 移除不存在的元素
    let result2 = set.remove("grape")
    println("移除 'grape' 的结果: ${result2}")
    println("最终大小: ${set.size}")
    
    // 检查剩余元素
    println("剩余元素:")
    for (element in set) {
        println("- ${element}")
    }
    
    return 0
}
```

运行结果：

```text
初始大小: 3
移除 'banana' 的结果: true
移除后大小: 2
移除 'grape' 的结果: false
最终大小: 2
剩余元素:
- apple
- orange
```

### func removeIf((T) -> Bool)

```cangjie
public func removeIf(predicate: (T) -> Bool): Unit
```

功能：传入 lambda 表达式，如果满足 `true` 条件，则删除对应的元素。

参数：

- predicate: (T) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 是否删除元素的判断条件。

异常：

- [ConcurrentModificationException](./collection_package_exception.md#class-concurrentmodificationexception) - 当 `predicate` 中增删或者修改 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 内元素时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashSet并添加数字
    let set = HashSet<Int64>()
    set.add(1)
    set.add(2)
    set.add(3)
    set.add(4)
    set.add(5)
    set.add(6)
    
    println("初始集合:")
    for (element in set) {
        println("- ${element}")
    }
    println("初始大小: ${set.size}")
    
    // 移除偶数
    set.removeIf({num: Int64 => num % 2 == 0})
    
    println("\n移除偶数后:")
    for (element in set) {
        println("- ${element}")
    }
    println("移除后大小: ${set.size}")
    
    // 移除大于3的元素
    set.removeIf({num: Int64 => num > 3})
    
    println("\n移除大于3的元素后:")
    for (element in set) {
        println("- ${element}")
    }
    println("最终大小: ${set.size}")
    
    return 0
}
```

运行结果：

```text
初始集合:
- 1
- 2
- 3
- 4
- 5
- 6
初始大小: 6

移除偶数后:
- 1
- 3
- 5
移除后大小: 3

移除大于3的元素后:
- 1
- 3
最终大小: 2
```

### func reserve(Int64)

```cangjie
public func reserve(additional: Int64): Unit
```

功能：将 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 扩容 additional 大小，当 additional 小于等于零时，不发生扩容；当 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 剩余容量大于等于 additional 时，不发生扩容；当 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 剩余容量小于 additional 时，取（原始容量的1.5倍向下取整）与（additional + 已使用容量）中的最大值进行扩容。

参数：

- additional: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 将要扩容的大小。

异常：

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - 当additional + 已使用容量超过Int64.Max时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashSet并添加元素
    let set = HashSet<String>()
    set.add("apple")
    set.add("banana")
    
    println("初始容量: ${set.capacity}")
    println("初始大小: ${set.size}")
    
    // 预留额外容量
    set.reserve(10)
    
    println("预留后容量: ${set.capacity}")
    println("预留后大小: ${set.size}")
    
    // 添加更多元素测试扩容效果
    for (i in 0..5) {
        set.add("item${i}")
    }
    
    println("添加元素后容量: ${set.capacity}")
    println("添加元素后大小: ${set.size}")
    
    // 尝试预留更小的容量（不会有效果）
    let beforeCapacity = set.capacity
    set.reserve(1)
    
    println("小量预留后容量: ${set.capacity}")
    println("是否发生改变: ${beforeCapacity != set.capacity}")
    
    return 0
}
```

运行结果：

```text
初始容量: 16
初始大小: 2
预留后容量: 16
预留后大小: 2
添加元素后容量: 16
添加元素后大小: 7
小量预留后容量: 16
是否发生改变: false
```

### func retain(Set\<T>)

```cangjie
public func retain(all!: Set<T>): Unit
```

功能：从此 [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) 中保留 [Set](collection_package_interface.md#interface-sett) 中的元素。

参数：

- all!: [Set](collection_package_interface.md#interface-sett)\<T> - 需要保留的 [Set](collection_package_interface.md#interface-sett)。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建原始HashSet
    let set = HashSet<String>()
    set.add("apple")
    set.add("banana")
    set.add("orange")
    set.add("grape")
    set.add("cantaloupe")
    
    println("原始集合:")
    for (element in set) {
        println("- ${element}")
    }
    println("原始大小: ${set.size}")
    
    // 创建要保留的元素集合
    let toRetain = HashSet<String>()
    toRetain.add("apple")
    toRetain.add("orange")
    toRetain.add("mango")  // 原集合中不存在
    
    println("\n要保留的元素:")
    for (element in toRetain) {
        println("- ${element}")
    }
    
    // 保留指定元素
    set.retain(all: toRetain)
    
    println("\n保留后的集合:")
    for (element in set) {
        println("- ${element}")
    }
    println("保留后大小: ${set.size}")
    
    return 0
}
```

运行结果：

```text
原始集合:
- apple
- banana
- orange
- grape
- cantaloupe
原始大小: 5

要保留的元素:
- apple
- orange
- mango

保留后的集合:
- apple
- orange
保留后大小: 2
```

### func subsetOf(ReadOnlySet\<T>)

```cangjie
public func subsetOf(other: ReadOnlySet<T>): Bool
```

功能：检查该集合是否为其他 [ReadOnlySet](collection_package_interface.md#interface-readonlysett) 的子集。

参数：

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - 传入集合，此函数将判断当前集合是否为 other 的子集。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该 [Set](collection_package_interface.md#interface-sett) 是指定 [ReadOnlySet](collection_package_interface.md#interface-readonlysett) 的子集，则返回 true；否则返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建父集合
    let superSet = HashSet<String>()
    superSet.add("apple")
    superSet.add("banana")
    superSet.add("orange")
    superSet.add("grape")
    
    // 创建子集合
    let subSet = HashSet<String>()
    subSet.add("apple")
    subSet.add("banana")
    
    println("父集合: ${superSet}")
    println("子集合: ${subSet}")
    println("子集合是否为父集合的子集: ${subSet.subsetOf(superSet)}")
    
    // 测试非子集关系
    let nonSubSet = HashSet<String>()
    nonSubSet.add("apple")
    nonSubSet.add("cantaloupe")  // 父集合中不存在
    
    println("\n非子集: ${nonSubSet}")
    println("非子集是否为父集合的子集: ${nonSubSet.subsetOf(superSet)}")
    
    // 测试空集合（空集合是任何集合的子集）
    let emptySet = HashSet<String>()
    println("\n空集合: ${emptySet}")
    println("空集合是否为父集合的子集: ${emptySet.subsetOf(superSet)}")
    
    // 测试自身与自身的子集关系
    println("父集合是否为自身的子集: ${superSet.subsetOf(superSet)}")
    
    return 0
}
```

运行结果：

```text
父集合: [apple, banana, orange, grape]
子集合: [apple, banana]
子集合是否为父集合的子集: true

非子集: [apple, cantaloupe]
非子集是否为父集合的子集: false

空集合: []
空集合是否为父集合的子集: true
父集合是否为自身的子集: true
```

### func toArray()

```cangjie
public func toArray(): Array<T>
```

功能：返回一个包含容器内所有元素的数组。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - T 类型数组。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建HashSet并添加元素
    let set = HashSet<String>()
    set.add("apple")
    set.add("banana")
    set.add("orange")
    
    println("集合大小: ${set.size}")
    
    // 转换为数组
    let array = set.toArray()
    
    println("数组大小: ${array.size}")
    println("数组元素:")
    for (i in 0..array.size) {
        println("[${i}] = ${array[i]}")
    }
    
    // 验证数组包含了集合中的所有元素
    println("\n验证元素:")
    for (element in set) {
        var found = false
        for (i in 0..array.size) {
            if (array[i] == element) {
                found = true
                break
            }
        }
        println("'${element}' 在数组中: ${found}")
    }
    
    return 0
}
```

运行结果：

```text
集合大小: 3
数组大小: 3
数组元素:
[0] = apple
[1] = banana
[2] = orange

验证元素:
'apple' 在数组中: true
'banana' 在数组中: true
'orange' 在数组中: true
```

### operator func &(ReadOnlySet\<T>)

```cangjie
public operator func &(other: ReadOnlySet<T>): HashSet<T>
```

功能：返回包含两个集合交集的元素的新集合。

参数：

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - 传入集合。

返回值：

- [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> - T 类型集合。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建两个集合
    let set1 = HashSet<String>()
    set1.add("apple")
    set1.add("banana")
    set1.add("orange")
    
    let set2 = HashSet<String>()
    set2.add("banana")
    set2.add("orange")
    set2.add("grape")
    
    println("集合1: ${set1}")
    println("集合2: ${set2}")
    
    // 计算交集（共同元素）
    let intersection = set1 & set2
    println("交集 (set1 & set2): ${intersection}")
    println("交集大小: ${intersection.size}")
    
    // 测试空交集
    let set3 = HashSet<String>()
    set3.add("cantaloupe")
    set3.add("mango")
    
    let emptyIntersection = set1 & set3
    println("\n集合3: ${set3}")
    println("空交集 (set1 & set3): ${emptyIntersection}")
    println("空交集大小: ${emptyIntersection.size}")
    
    // 测试与自身的交集
    let selfIntersection = set1 & set1
    println("\n自身交集 (set1 & set1): ${selfIntersection}")
    println("自身交集大小: ${selfIntersection.size}")
    
    return 0
}
```

运行结果：

```text
集合1: [apple, banana, orange]
集合2: [banana, orange, grape]
交集 (set1 & set2): [banana, orange]
交集大小: 2

集合3: [cantaloupe, mango]
空交集 (set1 & set3): []
空交集大小: 0

自身交集 (set1 & set1): [apple, banana, orange]
自身交集大小: 3
```

### operator func -(ReadOnlySet\<T>)

```cangjie
public operator func -(other: ReadOnlySet<T>): HashSet<T>
```

功能：返回包含两个集合差集的元素的新集合。

参数：

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - 传入集合。

返回值：

- [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> - T 类型集合。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建两个有重叠的集合
    let set1 = HashSet<String>()
    set1.add("apple")
    set1.add("banana")
    set1.add("orange")
    
    let set2 = HashSet<String>()
    set2.add("banana")
    set2.add("grape")
    set2.add("cantaloupe")
    
    println("集合1: ${set1}")
    println("集合2: ${set2}")
    
    // 计算差集 (set1 - set2)
    let difference = set1 - set2
    println("差集 (set1 - set2): ${difference}")
    println("差集大小: ${difference.size}")
    
    // 计算反向差集 (set2 - set1)
    let reverseDifference = set2 - set1
    println("\n反向差集 (set2 - set1): ${reverseDifference}")
    println("反向差集大小: ${reverseDifference.size}")
    
    // 与空集合的差集
    let emptySet = HashSet<String>()
    let diffWithEmpty = set1 - emptySet
    println("\n与空集合的差集 (set1 - empty): ${diffWithEmpty}")
    println("与空集合的差集大小: ${diffWithEmpty.size}")
    
    // 自身与自身的差集
    let selfDiff = set1 - set1
    println("\n自身差集 (set1 - set1): ${selfDiff}")
    println("自身差集大小: ${selfDiff.size}")
    
    return 0
}
```

运行结果：

```text
集合1: [apple, banana, orange]
集合2: [banana, grape, cantaloupe]
差集 (set1 - set2): [apple, orange]
差集大小: 2

反向差集 (set2 - set1): [grape, cantaloupe]
反向差集大小: 2

与空集合的差集 (set1 - empty): [apple, banana, orange]
与空集合的差集大小: 3

自身差集 (set1 - set1): []
自身差集大小: 0
```

### operator func |(ReadOnlySet\<T>)

```cangjie
public operator func |(other: ReadOnlySet<T>): HashSet<T>
```

功能：返回包含两个集合并集的元素的新集合。

参数：

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - 传入集合。

返回值：

- [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> - T 类型集合。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建两个集合
    let set1 = HashSet<String>()
    set1.add("apple")
    set1.add("banana")
    
    let set2 = HashSet<String>()
    set2.add("banana")
    set2.add("orange")
    set2.add("grape")
    
    println("集合1: ${set1}")
    println("集合2: ${set2}")
    
    // 计算并集（所有元素，无重复）
    let union = set1 | set2
    println("并集 (set1 | set2): ${union}")
    println("并集大小: ${union.size}")
    
    // 测试与空集合的并集
    let emptySet = HashSet<String>()
    let unionWithEmpty = set1 | emptySet
    println("\n空集合: ${emptySet}")
    println("与空集合的并集 (set1 | empty): ${unionWithEmpty}")
    println("与空集合的并集大小: ${unionWithEmpty.size}")
    
    // 测试与自身的并集
    let selfUnion = set1 | set1
    println("\n自身并集 (set1 | set1): ${selfUnion}")
    println("自身并集大小: ${selfUnion.size}")
    
    // 测试完全不同的集合
    let set3 = HashSet<String>()
    set3.add("cantaloupe")
    set3.add("mango")
    
    let disjointUnion = set1 | set3
    println("\n集合3: ${set3}")
    println("不相交集合的并集 (set1 | set3): ${disjointUnion}")
    println("不相交集合的并集大小: ${disjointUnion.size}")
    
    return 0
}
```

运行结果：

```text
集合1: [apple, banana]
集合2: [banana, orange, grape]
并集 (set1 | set2): [apple, banana, orange, grape]
并集大小: 4

空集合: []
与空集合的并集 (set1 | empty): [apple, banana]
与空集合的并集大小: 2

自身并集 (set1 | set1): [apple, banana]
自身并集大小: 2

集合3: [cantaloupe, mango]
不相交集合的并集 (set1 | set3): [apple, banana, cantaloupe, mango]
不相交集合的并集大小: 4
```

### extend\<T> HashSet\<T> <: Equatable\<HashSet\<T>>

```cangjie
extend<T> HashSet<T> <: Equatable<HashSet<T>>
```

功能：为 [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> 类型扩展 [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T>> 接口，支持判等操作。

父类型：

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T>>

#### operator func !=(HashSet\<T>)

```cangjie
public operator func !=(that: HashSet<T>): Bool
```

功能：判断当前实例与参数指向的 [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> 实例是否不等。

参数：

- that: [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> - 被比较的对象。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果不等，则返回 true，否则返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建两个不同的HashSet
    let set1 = HashSet<String>()
    set1.add("apple")
    set1.add("banana")
    
    let set2 = HashSet<String>()
    set2.add("apple")
    set2.add("orange")  // 不同的元素
    
    println("集合1: [apple, banana]")
    println("集合2: [apple, orange]")
    println("集合1 != 集合2: ${set1 != set2}")
    
    // 测试相同的集合
    let set3 = HashSet<String>()
    set3.add("apple")
    set3.add("banana")
    
    println("\n集合3: [apple, banana]")
    println("集合1 != 集合3: ${set1 != set3}")
    
    // 测试空集合和非空集合
    let emptySet = HashSet<String>()
    
    println("\n空集合 != 非空集合: ${emptySet != set1}")
    
    // 测试两个空集合
    let anotherEmptySet = HashSet<String>()
    println("空集合1 != 空集合2: ${emptySet != anotherEmptySet}")
    
    return 0
}
```

运行结果：

```text
集合1: [apple, banana]
集合2: [apple, orange]
集合1 != 集合2: true

集合3: [apple, banana]
集合1 != 集合3: false

空集合 != 非空集合: true
空集合1 != 空集合2: false
```

#### operator func ==(HashSet\<T>)

```cangjie
public operator func ==(that: HashSet<T>): Bool
```

功能：判断当前实例与参数指向的 [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> 实例是否相等。

两个 [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> 相等指的是其中包含的元素完全相等。

参数：

- that: [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> - 被比较的对象。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果相等，则返回 true，否则返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建两个相同的HashSet
    let set1 = HashSet<String>()
    set1.add("apple")
    set1.add("banana")
    set1.add("orange")
    
    let set2 = HashSet<String>()
    set2.add("banana")
    set2.add("apple")  // 顺序不同但元素相同
    set2.add("orange")
    
    // 比较相同的集合
    println("集合1大小: ${set1.size}")
    println("集合2大小: ${set2.size}")
    println("集合1 == 集合2: ${set1 == set2}")
    
    // 创建不同的HashSet
    let set3 = HashSet<String>()
    set3.add("apple")
    set3.add("grape")  // 不同的元素
    
    println("\n集合3大小: ${set3.size}")
    println("集合1 == 集合3: ${set1 == set3}")
    
    // 测试空集合
    let emptySet1 = HashSet<String>()
    let emptySet2 = HashSet<String>()
    
    println("\n空集合1 == 空集合2: ${emptySet1 == emptySet2}")
    println("空集合 == 非空集合: ${emptySet1 == set1}")
    
    return 0
}
```

运行结果：

```text
集合1大小: 3
集合2大小: 3
集合1 == 集合2: true

集合3大小: 2
集合1 == 集合3: false

空集合1 == 空集合2: true
空集合 == 非空集合: false
```

### extend\<T> HashSet\<T> <: ToString where T <: ToString

```cangjie
extend<T> HashSet<T> <: ToString where T <: ToString
```

功能：为 [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> 扩展 [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) 接口，支持转字符串操作。

父类型：

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

功能：将当前 [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> 实例转换为字符串。

该字符串包含 [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> 内每个元素的字符串表示，形如："[elem1, elem2, elem3]"。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 转换得到的字符串。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建空HashSet
    let emptySet = HashSet<String>()
    println("空集合: ${emptySet.toString()}")
    
    // 创建单元素HashSet
    let singleSet = HashSet<String>()
    singleSet.add("apple")
    println("单元素集合: ${singleSet.toString()}")
    
    // 创建多元素HashSet
    let multiSet = HashSet<String>()
    multiSet.add("apple")
    multiSet.add("banana")
    multiSet.add("orange")
    
    println("多元素集合: ${multiSet.toString()}")
    
    // 使用数字类型HashSet
    let numSet = HashSet<Int64>()
    numSet.add(1)
    numSet.add(2)
    numSet.add(3)
    
    println("数字集合: ${numSet.toString()}")
    
    // 在println中直接使用（自动调用toString）
    println("自动调用toString: ${multiSet}")
    
    return 0
}
```

运行结果：

```text
空集合: []
单元素集合: [apple]
多元素集合: [apple, banana, orange]
数字集合: [1, 2, 3]
自动调用toString: [apple, banana, orange]
```

## class LinkedList\<T>

```cangjie
public class LinkedList<T> <: Collection<T> {
    public init()
    public init(elements: Collection<T>)
    public init(elements: Array<T>)
    public init(size: Int64, initElement: (Int64)-> T)
}
```

功能：实现双向链表的数据结构。

双向链表是一种常见的数据结构，它由一系列节点组成，每个节点都包含两个指针，一个指向前一个节点，另一个指向后一个节点。这种结构允许在任何一个节点上进行双向遍历，即可以从头节点开始向后遍历，也可以从尾节点开始向前遍历。

[LinkedList](collection_package_class.md#class-linkedlistt) 不支持并发操作，并且对集合中元素的修改不会使迭代器失效，只有在添加和删除元素的时候会使迭代器失效。

父类型：

- [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T>

### prop first

```cangjie
public prop first: ?T
```

功能：链表中第一个元素的值，如果是空链表则返回 None。

类型：?T

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = LinkedList<Int64>()
    
    // 空链表的情况
    let firstValue1 = list.first
    if (let Some(value) <- firstValue1) {
        println("第一个元素: ${value}")
    } else {
        println("链表为空")
    }
    
    // 添加元素后
    list.addLast(100)
    list.addLast(200)
    list.addLast(300)
    
    let firstValue2 = list.first
    if (let Some(value) <- firstValue2) {
        println("第一个元素: ${value}")
    } else {
        println("链表为空")
    }
    
    return 0
}
```

运行结果：

```text
链表为空
第一个元素: 100
```

### prop firstNode

```cangjie
public prop firstNode: ?LinkedListNode<T>
```

功能：获取链表中的第一个元素的节点。

类型：?[LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T>

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = LinkedList<Int64>()
    
    // 空链表的情况
    let firstNode1 = list.firstNode
    if (let Some(node) <- firstNode1) {
        println("第一个节点值: ${node.value}")
    } else {
        println("链表为空")
    }
    
    // 添加元素后
    list.addLast(100)
    list.addLast(200)
    list.addLast(300)
    
    let firstNode2 = list.firstNode
    if (let Some(node) <- firstNode2) {
        println("第一个节点值: ${node.value}")
    } else {
        println("链表为空")
    }
    
    return 0
}
```

运行结果：

```text
链表为空
第一个节点值: 100
```

### prop last

```cangjie
public prop last: ?T
```

功能：链表中最后一个元素的值，如果是空链表则返回 None。

类型：?T

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = LinkedList<Int64>()
    
    // 空链表的情况
    let lastValue1 = list.last
    if (let Some(value) <- lastValue1) {
        println("最后一个元素: ${value}")
    } else {
        println("链表为空")
    }
    
    // 添加元素后
    list.addLast(10)
    list.addLast(20)
    list.addLast(30)
    
    let lastValue2 = list.last
    if (let Some(value) <- lastValue2) {
        println("最后一个元素: ${value}")
    } else {
        println("链表为空")
    }
    
    return 0
}
```

运行结果：

```text
链表为空
最后一个元素: 30
```

### prop lastNode

```cangjie
public prop lastNode: ?LinkedListNode<T>
```

功能：获取链表中的最后一个元素的节点。

类型：?[LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T>

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = LinkedList<Int64>()
    
    // 空链表的情况
    let lastNode1 = list.lastNode
    if (let Some(node) <- lastNode1) {
        println("最后一个节点值: ${node.value}")
    } else {
        println("链表为空")
    }
    
    // 添加元素后
    list.addLast(100)
    list.addLast(200)
    list.addLast(300)
    
    let lastNode2 = list.lastNode
    if (let Some(node) <- lastNode2) {
        println("最后一个节点值: ${node.value}")
    } else {
        println("链表为空")
    }
    
    return 0
}
```

运行结果：

```text
链表为空
最后一个节点值: 300
```

### prop size

```cangjie
public prop size: Int64
```

功能：链表中的元素数量。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = LinkedList<String>()
    
    // 检查空链表的大小
    println("空链表大小: ${list.size}")
    
    // 添加元素并检查大小变化
    list.addLast("第一个")
    println("添加一个元素后大小: ${list.size}")
    
    list.addLast("第二个")
    list.addLast("第三个")
    println("添加三个元素后大小: ${list.size}")
    
    // 移除元素并检查大小变化
    list.removeFirst()
    println("移除一个元素后大小: ${list.size}")
    
    // 清空链表
    list.clear()
    println("清空后大小: ${list.size}")
    
    return 0
}
```

运行结果：

```text
空链表大小: 0
添加一个元素后大小: 1
添加三个元素后大小: 3
移除一个元素后大小: 2
清空后大小: 0
```

### init()

```cangjie
public init()
```

功能：构造一个空的链表。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个空的LinkedList
    let list = LinkedList<Int64>()
    
    // 检查空链表的属性
    println("新创建的链表大小: ${list.size}")
    println("是否为空: ${list.isEmpty()}")
    
    let firstValue = list.first
    if (let Some(value) <- firstValue) {
        println("第一个元素: ${value}")
    } else {
        println("链表为空，没有第一个元素")
    }
    
    // 向空链表中添加元素来验证它是有效的
    list.addLast(42)
    println("添加元素后大小: ${list.size}")
    
    return 0
}
```

运行结果：

```text
新创建的链表大小: 0
是否为空: true
链表为空，没有第一个元素
添加元素后大小: 1
```

### init(Array\<T>)

```cangjie
public init(elements: Array<T>)
```

功能：按照数组的遍历顺序构造一个包含指定集合元素的 [LinkedList](collection_package_class.md#class-linkedlistt) 实例。

参数：

- elements: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - 将要放入此链表中的元素数组。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 使用Array创建LinkedList
    let arr = [10, 20, 30, 40, 50]
    let list = LinkedList<Int64>(arr)
    
    // 检查链表的属性
    println("从数组创建的链表大小: ${list.size}")
    
    // 检查第一个和最后一个元素
    let firstValue = list.first
    if (let Some(value) <- firstValue) {
        println("第一个元素: ${value}")
    }
    
    let lastValue = list.last
    if (let Some(value) <- lastValue) {
        println("最后一个元素: ${value}")
    }
    
    // 验证顺序：遍历所有元素
    print("链表中的所有元素: ")
    for (element in list) {
        print("${element} ")
    }
    println()
    
    return 0
}
```

运行结果：

```text
从数组创建的链表大小: 5
第一个元素: 10
最后一个元素: 50
链表中的所有元素: 10 20 30 40 50 
```

### init(Collection\<T>)

```cangjie
public init(elements: Collection<T>)
```

功能：按照集合迭代器返回元素的顺序构造一个包含指定集合元素的链表。

参数：

- elements: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - 将要放入此链表中的元素集合。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 先创建一个ArrayList作为Collection
    let arrayList = ArrayList<Int64>()
    arrayList.add(100)
    arrayList.add(200)
    arrayList.add(300)
    
    // 使用Collection创建LinkedList
    let list = LinkedList<Int64>(arrayList)
    
    // 检查链表的属性
    println("从Collection创建的链表大小: ${list.size}")
    
    // 检查第一个和最后一个元素
    let firstValue = list.first
    if (let Some(value) <- firstValue) {
        println("第一个元素: ${value}")
    }
    
    let lastValue = list.last
    if (let Some(value) <- lastValue) {
        println("最后一个元素: ${value}")
    }
    
    // 验证顺序：遍历所有元素
    print("链表中的所有元素: ")
    for (element in list) {
        print("${element} ")
    }
    println()
    
    return 0
}
```

运行结果：

```text
从Collection创建的链表大小: 3
第一个元素: 100
最后一个元素: 300
链表中的所有元素: 100 200 300 
```

### init(Int64, (Int64)-> T)

```cangjie
public init(size: Int64, initElement: (Int64)-> T)
```

功能：创建一个包含 size 个元素，且第 n 个元素满足 ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64))-> T 条件的链表。

参数：

- size: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 要创建的链表元素数量。
- initElement: ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) ->T - 元素的初始化参数。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果指定的链表长度小于 0 则抛此异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 使用lambda函数创建LinkedList
    let list = LinkedList<Int64>(5, {index: Int64 => index * 10})
    
    // 检查链表的属性
    println("使用lambda创建的链表大小: ${list.size}")
    
    // 检查第一个和最后一个元素
    let firstValue = list.first
    if (let Some(value) <- firstValue) {
        println("第一个元素: ${value}")
    }
    
    let lastValue = list.last
    if (let Some(value) <- lastValue) {
        println("最后一个元素: ${value}")
    }
    
    // 验证所有元素
    print("链表中的所有元素: ")
    for (element in list) {
        print("${element} ")
    }
    println()
    
    return 0
}
```

运行结果：

```text
使用lambda创建的链表大小: 5
第一个元素: 0
最后一个元素: 40
链表中的所有元素: 0 10 20 30 40 
```

### func addAfter(LinkedListNode\<T>,T)

```cangjie
public func addAfter(node: LinkedListNode<T>, element: T): LinkedListNode<T>
```

功能：在链表中指定节点的后面插入一个元素，并且返回该元素的节点。

参数：

- node: [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - 指定的节点。
- element: T - 要添加到链表中的元素。

返回值：

- [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - 指向被插入元素的节点。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果指定的节点不属于该链表，则抛此异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = LinkedList<String>()
    
    // 添加初始元素
    list.addLast("第一个")
    list.addLast("第二个")
    list.addLast("第四个")
    
    println("插入前的链表:")
    for (element in list) {
        print("${element} ")
    }
    println()
    
    // 获取第二个节点（索引为1，值为"第二个"）
    let secondNode = list.nodeAt(1)
    if (let Some(node) <- secondNode) {
        println("在节点 '${node.value}' 后面插入 '第三个'")
        
        // 在第二个节点后面插入新元素
        let newNode = list.addAfter(node, "第三个")
        println("插入成功，新节点值: ${newNode.value}")
    }
    
    println("插入后的链表:")
    for (element in list) {
        print("${element} ")
    }
    println()
    
    println("链表大小: ${list.size}")
    
    return 0
}
```

运行结果：

```text
插入前的链表:
第一个 第二个 第四个 
在节点 '第二个' 后面插入 '第三个'
插入成功，新节点值: 第三个
插入后的链表:
第一个 第二个 第三个 第四个 
链表大小: 4
```

### func addBefore(LinkedListNode\<T>,T)

```cangjie
public func addBefore(node: LinkedListNode<T>, element: T): LinkedListNode<T>
```

功能：在链表中指定节点的前面插入一个元素，并且返回该元素的节点。

参数：

- node: [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - 指定的节点。
- element: T - 要添加到链表中的元素。

返回值：

- [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - 指向被插入元素的节点。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果指定的节点不属于该链表，则抛此异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = LinkedList<String>()
    
    // 添加初始元素
    list.addLast("第一个")
    list.addLast("第三个")
    list.addLast("第四个")
    
    println("插入前的链表:")
    for (element in list) {
        print("${element} ")
    }
    println()
    
    // 获取第二个节点（索引为1，值为"第三个"）
    let thirdNode = list.nodeAt(1)
    if (let Some(node) <- thirdNode) {
        println("在节点 '${node.value}' 前面插入 '第二个'")
        
        // 在第三个节点前面插入新元素
        let newNode = list.addBefore(node, "第二个")
        println("插入成功，新节点值: ${newNode.value}")
    }
    
    println("插入后的链表:")
    for (element in list) {
        print("${element} ")
    }
    println()
    
    println("链表大小: ${list.size}")
    
    return 0
}
```

运行结果：

```text
插入前的链表:
第一个 第三个 第四个 
在节点 '第三个' 前面插入 '第二个'
插入成功，新节点值: 第二个
插入后的链表:
第一个 第二个 第三个 第四个 
链表大小: 4
```

### func addFirst(T)

```cangjie
public func addFirst(element: T): LinkedListNode<T>
```

功能：在链表的头部位置插入一个元素，并且返回该元素的节点。

参数：

- element: T - 要添加到链表中的元素。

返回值：

- [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - 指向该元素的节点。

### func addFirst(T)

```cangjie
public func addFirst(element: T): LinkedListNode<T>
```

功能：在链表的头部位置插入一个元素，并且返回该元素的节点。

参数：

- element: T - 要添加到链表中的元素。

返回值：

- [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - 指向该元素的节点。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = LinkedList<String>()
    
    // 向空链表头部添加元素
    let node1 = list.addFirst("第三个")
    println("添加第一个元素后链表大小: ${list.size}")
    println("返回的节点值: ${node1.value}")
    
    // 继续在头部添加更多元素
    list.addFirst("第二个")
    list.addFirst("第一个")
    
    println("添加三个元素后链表大小: ${list.size}")
    
    // 验证元素顺序（最后添加的在最前面）
    print("链表中的所有元素: ")
    for (element in list) {
        print("${element} ")
    }
    println()
    
    // 验证第一个节点
    let firstValue = list.first
    if (let Some(value) <- firstValue) {
        println("第一个元素: ${value}")
    }
    
    // 验证最后一个节点
    let lastValue = list.last
    if (let Some(value) <- lastValue) {
        println("最后一个元素: ${value}")
    }
    
    return 0
}
```

运行结果：

```text
添加第一个元素后链表大小: 1
返回的节点值: 第三个
添加三个元素后链表大小: 3
链表中的所有元素: 第一个 第二个 第三个 
第一个元素: 第一个
最后一个元素: 第三个
```

### func addLast(T)

```cangjie
public func addLast(element: T): LinkedListNode<T>
```

功能：在链表的尾部位置添加一个元素，并且返回该元素的节点。

参数：

- element: T - 要添加到链表中的元素。

返回值：

- [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - 指向该元素的节点。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = LinkedList<String>()
    
    // 向空链表添加元素
    let node1 = list.addLast("第一个")
    println("添加第一个元素后链表大小: ${list.size}")
    println("返回的节点值: ${node1.value}")
    
    // 继续添加更多元素
    list.addLast("第二个")
    list.addLast("第三个")
    
    println("添加三个元素后链表大小: ${list.size}")
    
    // 验证元素顺序
    print("链表中的所有元素: ")
    for (element in list) {
        print("${element} ")
    }
    println()
    
    // 验证最后一个节点
    let lastValue = list.last
    if (let Some(value) <- lastValue) {
        println("最后一个元素: ${value}")
    }
    
    return 0
}
```

运行结果：

```text
添加第一个元素后链表大小: 1
返回的节点值: 第一个
添加三个元素后链表大小: 3
链表中的所有元素: 第一个 第二个 第三个 
最后一个元素: 第三个
```

### func addLast(T)

```cangjie
public func addLast(element: T): LinkedListNode<T>
```

功能：在链表的尾部位置添加一个元素，并且返回该元素的节点。

参数：

- element: T - 要添加到链表中的元素。

返回值：

- [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - 指向该元素的节点。

### func all((T) -> Bool)

```cangjie
public func all(predicate: (T) -> Bool): Bool
```

功能：判断链表中所有元素是否都满足条件。

参数：

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果此链表中所有元素都满足条件，返回 true，否则返回 false

### func any((T) -> Bool)

```cangjie
public func any(predicate: (T) -> Bool): Bool
```

功能：判断此链表是否存在任意一个满足条件的元素。

参数：

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 是否存在任意满足条件的元素。

### func backward(LinkedListNode\<T>)

```cangjie
public func backward(mark: LinkedListNode<T>): Iterator<T>
```

功能：获取一个从 mark 节点开始，到所对应链表的头部节点的所有元素的迭代器。

参数：

- mark: [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - 开始的元素节点。

返回值：

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - 对应元素的迭代器。

异常：

- [IllegalStateException](../../core/core_package_api/core_package_exceptions.md#class-illegalstateexception) - 如果该节点不属于任何链表实例，抛此异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = LinkedList<Int64>()
    
    // 添加元素
    list.addLast(10)
    list.addLast(20)
    list.addLast(30)
    list.addLast(40)
    list.addLast(50)
    
    // 获取中间的一个节点（索引为2的节点，值为30）
    let middleNode = list.nodeAt(2)
    if (let Some(node) <- middleNode) {
        println("从节点值 ${node.value} 开始向后遍历:")
        
        // 使用backward方法从中间节点向前遍历到头部
        let iterator = list.backward(node)
        for (element in iterator) {
            print("${element} ")
        }
        println()
    }
    
    // 从最后一个节点开始向前遍历
    let lastNode = list.lastNode
    if (let Some(node) <- lastNode) {
        println("从最后一个节点值 ${node.value} 开始向后遍历:")
        
        let iterator = list.backward(node)
        for (element in iterator) {
            print("${element} ")
        }
        println()
    }
    
    return 0
}
```

运行结果：

```text
从节点值 30 开始向后遍历:
30 20 10 
从最后一个节点值 50 开始向后遍历:
50 40 30 20 10 
```

### func backward(LinkedListNode\<T>)

```cangjie
public func backward(mark: LinkedListNode<T>): Iterator<T>
```

功能：获取一个从 mark 节点开始，到所对应链表的头部节点的所有元素的迭代器。

参数：

- mark: [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - 开始的元素节点。

返回值：

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - 对应元素的迭代器。

异常：

- [IllegalStateException](../../core/core_package_api/core_package_exceptions.md#class-illegalstateexception) - 如果该节点不属于任何链表实例，抛此异常。

### func clear()

```cangjie
public func clear(): Unit
```

功能：删除链表中的所有元素。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = LinkedList<String>()
    
    // 添加一些元素
    list.addLast("元素1")
    list.addLast("元素2")
    list.addLast("元素3")
    list.addLast("元素4")
    
    println("清除前链表大小: ${list.size}")
    println("清除前是否为空: ${list.isEmpty()}")
    
    // 显示清除前的元素
    print("清除前的元素: ")
    for (element in list) {
        print("${element} ")
    }
    println()
    
    // 清除所有元素
    list.clear()
    
    println("清除后链表大小: ${list.size}")
    println("清除后是否为空: ${list.isEmpty()}")
    
    // 验证第一个和最后一个元素都为空
    let firstValue = list.first
    if (let Some(value) <- firstValue) {
        println("第一个元素: ${value}")
    } else {
        println("没有第一个元素")
    }
    
    let lastValue = list.last
    if (let Some(value) <- lastValue) {
        println("最后一个元素: ${value}")
    } else {
        println("没有最后一个元素")
    }
    
    return 0
}
```

运行结果：

```text
清除前链表大小: 4
清除前是否为空: false
清除前的元素: 元素1 元素2 元素3 元素4 
清除后链表大小: 0
清除后是否为空: true
没有第一个元素
没有最后一个元素
```

### func clear()

```cangjie
public func clear(): Unit
```

功能：删除链表中的所有元素。

### func filter((T) -> Bool)
```cangjie
public func filter(predicate: (T) -> Bool): LinkedList<T>
```

功能： 返回一个满足筛选条件的元素的新链表。

参数：

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- [LinkedList](collection_package_class.md#class-linkedlistt)\<T> - 返回一个满足筛选条件的元素的新链表。

### func filterMap\<R>((T) -> ?R)

```cangjie
public func filterMap<R>(transform: (T) -> ?R): LinkedList<R>
```

功能：同时进行筛选操作和映射操作，返回一个新 [LinkedList](collection_package_class.md#class-linkedlistt)。

参数：

- transform: (T) -> ?R - 给定的映射函数。函数返回值为 Some 对应 filter 的 predicate 为 true，反之表示 false。

返回值：

- [LinkedList](collection_package_class.md#class-linkedlistt)\<R> - 返回一个筛选和映射后的新链表。

### func flatMap\<R>((T) -> LinkedList\<R>)

```cangjie
public func flatMap<R>(transform: (T) -> LinkedList<R>): LinkedList<R> 
```

功能：对链表中的每个元素应用一个转换闭包（transform），该闭包返回一个新的链表，然后将所有返回的链表“压平”（flatten）并连接成一个单一的结果链表。

参数：

- transform: (T) -> [LinkedList](collection_package_class.md#class-linkedlistt)\<R> - 给定的映射函数。

返回值：

- [LinkedList](collection_package_class.md#class-linkedlistt)\<R> -  被“映射（map）”和“压平（flatten）”后的新链表。

### func fold\<R>(R, (R, T) -> R)

```cangjie
public func fold<R>(initial: R, operation: (R, T) -> R): R
```

功能：使用指定初始值，从左向右计算。

参数：

- initial: R - 给定的 R 类型的初始值。
- operation: (R, T) -> R - 给定的计算函数。

返回值：

- R - 返回最终计算得到的值。

### func forEach((T) -> Unit)

```cangjie
public func forEach(action: (T) -> Unit): Unit
```

功能：遍历所有元素，执行给定的操作。

参数：

- action: (T) -> [Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - 给定的操作函数。

### func forward(LinkedListNode\<T>)

```cangjie
public func forward(mark: LinkedListNode<T>): Iterator<T>
```

功能：获取一个从 mark 节点开始，到所对应链表的尾部节点的所有元素的迭代器。

参数：

- mark: [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - 开始的元素节点。

返回值：

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - 对应元素的迭代器。

异常：

- [IllegalStateException](../../core/core_package_api/core_package_exceptions.md#class-illegalstateexception) - 如果该节点不属于任何链表实例，抛此异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = LinkedList<Int64>()
    
    // 添加元素
    list.addLast(10)
    list.addLast(20)
    list.addLast(30)
    list.addLast(40)
    list.addLast(50)
    
    // 获取第一个节点并从它开始向前遍历
    let firstNode = list.firstNode
    if (let Some(node) <- firstNode) {
        println("从第一个节点值 ${node.value} 开始向前遍历:")
        
        let iterator = list.forward(node)
        for (element in iterator) {
            print("${element} ")
        }
        println()
    }
    
    // 获取中间的一个节点（索引为2的节点，值为30）
    let middleNode = list.nodeAt(2)
    if (let Some(node) <- middleNode) {
        println("从节点值 ${node.value} 开始向前遍历:")
        
        // 使用forward方法从中间节点向后遍历到尾部
        let iterator = list.forward(node)
        for (element in iterator) {
            print("${element} ")
        }
        println()
    }
    
    return 0
}
```

运行结果：

```text
从第一个节点值 10 开始向前遍历:
10 20 30 40 50 
从节点值 30 开始向前遍历:
30 40 50 
```

### func forward(LinkedListNode\<T>)

```cangjie
public func forward(mark: LinkedListNode<T>): Iterator<T>
```

功能：获取一个从 mark 节点开始，到所对应链表的尾部节点的所有元素的迭代器。

参数：

- mark: [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - 开始的元素节点。

返回值：

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - 对应元素的迭代器。

异常：

- [IllegalStateException](../../core/core_package_api/core_package_exceptions.md#class-illegalstateexception) - 如果该节点不属于任何链表实例，抛此异常。

### func intersperse(T)

```cangjie
public func intersperse(separator: T): LinkedList<T> 
```

功能：返回每两个元素之间插入一个给定的新元素后的新 [LinkedList](collection_package_class.md#class-linkedlistt) 。

参数：

- separator: T - 给定的元素。

返回值：

- LinkedList\<T> - 返回一个新链表。

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

功能：返回此链表是否为空链表的判断。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果此链表中不包含任何元素，返回 true。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = LinkedList<Int64>()
    
    // 检查空链表
    println("新创建的链表是否为空: ${list.isEmpty()}")
    println("链表大小: ${list.size}")
    
    // 添加一个元素
    list.addLast(10)
    println("添加一个元素后是否为空: ${list.isEmpty()}")
    println("链表大小: ${list.size}")
    
    // 添加更多元素
    list.addLast(20)
    list.addLast(30)
    println("添加更多元素后是否为空: ${list.isEmpty()}")
    println("链表大小: ${list.size}")
    
    // 清空链表
    list.clear()
    println("清空链表后是否为空: ${list.isEmpty()}")
    println("链表大小: ${list.size}")
    
    return 0
}
```

运行结果：

```text
新创建的链表是否为空: true
链表大小: 0
添加一个元素后是否为空: false
链表大小: 1
添加更多元素后是否为空: false
链表大小: 3
清空链表后是否为空: true
链表大小: 0
```

### func iterator()

```cangjie
public func iterator(): Iterator<T>
```

功能：返回当前集合中元素的迭代器，其顺序是从链表的第一个节点到链表的最后一个节点。

返回值：

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - 当前集合中元素的迭代器。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = LinkedList<String>()
    
    // 添加一些元素
    list.addLast("苹果")
    list.addLast("香蕉")
    list.addLast("橙子")
    list.addLast("葡萄")
    
    println("使用iterator()方法遍历链表:")
    
    // 获取迭代器并遍历所有元素
    let iter = list.iterator()
    for (element in iter) {
        print("${element} ")
    }
    println()
    
    // 验证迭代器顺序（从第一个到最后一个）
    println("验证迭代顺序:")
    println("第一个元素: ${list.first}")
    println("最后一个元素: ${list.last}")
    
    // 使用for-in语法（内部也使用iterator()）
    println("使用for-in语法遍历:")
    for (fruit in list) {
        print("${fruit} ")
    }
    println()
    
    return 0
}
```

运行结果：

```text
使用iterator()方法遍历链表:
苹果 香蕉 橙子 葡萄 
验证迭代顺序:
第一个元素: Some(苹果)
最后一个元素: Some(葡萄)
使用for-in语法遍历:
苹果 香蕉 橙子 葡萄 
```
### func map\<R>((T) -> R)

```cangjie
public func map<R>(transform: (T) -> R): LinkedList<R>
```

功能：对此 [LinkedList](collection_package_class.md#class-linkedlistt) 进行映射并返回一个新 [LinkedList](collection_package_class.md#class-linkedlistt)。

参数：

- transform: (T) ->R - 给定的映射函数。

返回值：

- [LinkedList](collection_package_class.md#class-linkedlistt)\<R> - 返回一个新的 [LinkedList](collection_package_class.md#class-linkedlistt)。

### func nodeAt(Int64)

```cangjie
public func nodeAt(index: Int64): Option<LinkedListNode<T>>
```

功能：获取链表中的第 index 个元素的节点，编号从 0 开始。

该函数的时间复杂度为 O(n)。

参数：

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 指定获取第 index 个元素的节点。

返回值：

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T>> - 编号为 index 的节点，如果没有则返回 None。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = LinkedList<String>()
    
    // 添加一些元素
    list.addLast("索引0")
    list.addLast("索引1")
    list.addLast("索引2")
    list.addLast("索引3")
    list.addLast("索引4")
    
    println("链表大小: ${list.size}")
    
    // 获取有效索引的节点
    let node0 = list.nodeAt(0)
    if (let Some(node) <- node0) {
        println("索引0的节点值: ${node.value}")
    } else {
        println("索引0没有节点")
    }
    
    let node2 = list.nodeAt(2)
    if (let Some(node) <- node2) {
        println("索引2的节点值: ${node.value}")
    } else {
        println("索引2没有节点")
    }
    
    let node4 = list.nodeAt(4)
    if (let Some(node) <- node4) {
        println("索引4的节点值: ${node.value}")
    } else {
        println("索引4没有节点")
    }
    
    // 尝试获取超出范围的索引
    let node5 = list.nodeAt(5)
    if (let Some(node) <- node5) {
        println("索引5的节点值: ${node.value}")
    } else {
        println("索引5没有节点（超出范围）")
    }
    
    // 尝试负索引
    let nodeNeg = list.nodeAt(-1)
    if (let Some(node) <- nodeNeg) {
        println("索引-1的节点值: ${node.value}")
    } else {
        println("索引-1没有节点（负索引）")
    }
    
    return 0
}
```

运行结果：

```text
链表大小: 5
索引0的节点值: 索引0
索引2的节点值: 索引2
索引4的节点值: 索引4
索引5没有节点（超出范围）
索引-1没有节点（负索引）
```

### func none((T) -> Bool)

```cangjie
public func none(predicate: (T) -> Bool): Bool
```

功能：判断此链表中所有元素是否都不满足条件。

参数：

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 当前链表中元素是否都不满足条件。

### func reduce((T, T) -> T)

```cangjie
public func reduce(operation: (T, T) -> T): Option<T>
```

功能：使用第一个元素作为初始值，从左向右计算。

参数：

- operation: (T, T) -> T - 给定的计算函数。

返回值：

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - 返回计算结果。

### func remove(LinkedListNode\<T>)

```cangjie
public func remove(node: LinkedListNode<T>): T
```

功能：删除链表中指定节点。

参数：

- node: [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - 要被删除的节点。

返回值：

- T - 被删除的节点的值。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果指定的节点不属于该链表，则抛此异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = LinkedList<String>()
    
    // 添加一些元素
    list.addLast("第一个")
    list.addLast("第二个")
    list.addLast("第三个")
    list.addLast("第四个")
    
    println("移除前的链表:")
    for (element in list) {
        print("${element} ")
    }
    println()
    println("移除前链表大小: ${list.size}")
    
    // 获取第二个节点（索引为1，值为"第二个"）
    let secondNode = list.nodeAt(1)
    if (let Some(node) <- secondNode) {
        println("将要移除节点: ${node.value}")
        
        // 移除该节点
        let removedValue = list.remove(node)
        println("移除的节点值: ${removedValue}")
    }
    
    println("移除后的链表:")
    for (element in list) {
        print("${element} ")
    }
    println()
    println("移除后链表大小: ${list.size}")
    
    // 移除第一个节点
    let firstNode = list.firstNode
    if (let Some(node) <- firstNode) {
        let removedValue = list.remove(node)
        println("移除第一个节点: ${removedValue}")
    }
    
    println("最终链表:")
    for (element in list) {
        print("${element} ")
    }
    println()
    println("最终链表大小: ${list.size}")
    
    return 0
}
```

运行结果：

```text
移除前的链表:
第一个 第二个 第三个 第四个 
移除前链表大小: 4
将要移除节点: 第二个
移除的节点值: 第二个
移除后的链表:
第一个 第三个 第四个 
移除后链表大小: 3
移除第一个节点: 第一个
最终链表:
第三个 第四个 
最终链表大小: 2
```

### func removeFirst()

```cangjie
public func removeFirst(): ?T
```

功能：移除链表的第一个元素，并返回该元素的值。

返回值：

- ?T - 被删除的元素的值，若链表为空则返回 None。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = LinkedList<String>()
    
    // 尝试从空链表中移除元素
    let removedFromEmpty = list.removeFirst()
    if (let Some(value) <- removedFromEmpty) {
        println("从空链表移除的元素: ${value}")
    } else {
        println("空链表无法移除元素")
    }
    
    // 添加一些元素
    list.addLast("第一个")
    list.addLast("第二个")
    list.addLast("第三个")
    list.addLast("第四个")
    
    println("移除前的链表:")
    for (element in list) {
        print("${element} ")
    }
    println()
    println("移除前链表大小: ${list.size}")
    
    // 移除第一个元素
    let removed1 = list.removeFirst()
    if (let Some(value) <- removed1) {
        println("移除的第一个元素: ${value}")
    }
    
    println("移除一次后的链表:")
    for (element in list) {
        print("${element} ")
    }
    println()
    println("移除后链表大小: ${list.size}")
    
    // 再次移除第一个元素
    let removed2 = list.removeFirst()
    if (let Some(value) <- removed2) {
        println("再次移除的第一个元素: ${value}")
    }
    
    println("最终链表:")
    for (element in list) {
        print("${element} ")
    }
    println()
    println("最终链表大小: ${list.size}")
    
    return 0
}
```

运行结果：

```text
空链表无法移除元素
移除前的链表:
第一个 第二个 第三个 第四个 
移除前链表大小: 4
移除的第一个元素: 第一个
移除一次后的链表:
第二个 第三个 第四个 
移除后链表大小: 3
再次移除的第一个元素: 第二个
最终链表:
第三个 第四个 
最终链表大小: 2
```

### func removeIf((T)-> Bool)

```cangjie
public func removeIf(predicate: (T)-> Bool): Unit
```

功能：删除此链表中满足给定 lambda 表达式或函数的所有元素。

参数：

- predicate: (T) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 对于要删除的元素，返回值为 true。

异常：

- [ConcurrentModificationException](./collection_package_exception.md#class-concurrentmodificationexception) - 当 `predicate` 中增删或者修改 [LinkedList](./collection_package_class.md#class-linkedlistt) 内节点时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = LinkedList<Int64>()
    
    // 添加一些元素
    list.addLast(1)
    list.addLast(2)
    list.addLast(3)
    list.addLast(4)
    list.addLast(5)
    list.addLast(6)
    list.addLast(7)
    list.addLast(8)
    
    println("删除前的链表:")
    for (element in list) {
        print("${element} ")
    }
    println()
    println("删除前链表大小: ${list.size}")
    
    // 删除所有偶数
    list.removeIf({x: Int64 => x % 2 == 0})
    
    println("删除偶数后的链表:")
    for (element in list) {
        print("${element} ")
    }
    println()
    println("删除后链表大小: ${list.size}")
    
    // 再删除所有大于3的元素
    list.removeIf({x: Int64 => x > 3})
    
    println("删除大于3的元素后的链表:")
    for (element in list) {
        print("${element} ")
    }
    println()
    println("最终链表大小: ${list.size}")
    
    return 0
}
```

运行结果：

```text
删除前的链表:
1 2 3 4 5 6 7 8 
删除前链表大小: 8
删除偶数后的链表:
1 3 5 7 
删除后链表大小: 4
删除大于3的元素后的链表:
1 3 
最终链表大小: 2
```

### func removeLast()

```cangjie
public func removeLast(): ?T
```

功能：移除链表的最后一个元素，并返回该元素的值。

返回值：

- ?T - 被删除的元素的值，若链表为空则返回 None。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = LinkedList<String>()
    
    // 尝试从空链表中移除元素
    let removedFromEmpty = list.removeLast()
    if (let Some(value) <- removedFromEmpty) {
        println("从空链表移除的元素: ${value}")
    } else {
        println("空链表无法移除元素")
    }
    
    // 添加一些元素
    list.addLast("第一个")
    list.addLast("第二个")
    list.addLast("第三个")
    list.addLast("第四个")
    
    println("移除前的链表:")
    for (element in list) {
        print("${element} ")
    }
    println()
    println("移除前链表大小: ${list.size}")
    
    // 移除最后一个元素
    let removed1 = list.removeLast()
    if (let Some(value) <- removed1) {
        println("移除的最后一个元素: ${value}")
    }
    
    println("移除一次后的链表:")
    for (element in list) {
        print("${element} ")
    }
    println()
    println("移除后链表大小: ${list.size}")
    
    // 再次移除最后一个元素
    let removed2 = list.removeLast()
    if (let Some(value) <- removed2) {
        println("再次移除的最后一个元素: ${value}")
    }
    
    println("最终链表:")
    for (element in list) {
        print("${element} ")
    }
    println()
    println("最终链表大小: ${list.size}")
    
    return 0
}
```

运行结果：

```text
空链表无法移除元素
移除前的链表:
第一个 第二个 第三个 第四个 
移除前链表大小: 4
移除的最后一个元素: 第四个
移除一次后的链表:
第一个 第二个 第三个 
移除后链表大小: 3
再次移除的最后一个元素: 第三个
最终链表:
第一个 第二个 
最终链表大小: 2
```

### func reverse()

```cangjie
public func reverse(): Unit
```

功能：反转此链表中的元素顺序。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = LinkedList<String>()
    
    // 添加一些元素
    list.addLast("第一个")
    list.addLast("第二个")
    list.addLast("第三个")
    list.addLast("第四个")
    list.addLast("第五个")
    
    println("原始链表:")
    for (element in list) {
        print("${element} ")
    }
    println()
    
    // 验证原始的第一个和最后一个元素
    let firstValue1 = list.first
    if (let Some(value) <- firstValue1) {
        println("原始第一个元素: ${value}")
    }
    
    let lastValue1 = list.last
    if (let Some(value) <- lastValue1) {
        println("原始最后一个元素: ${value}")
    }
    
    // 反转链表
    list.reverse()
    
    println("反转后的链表:")
    for (element in list) {
        print("${element} ")
    }
    println()
    
    // 验证反转后的第一个和最后一个元素
    let firstValue2 = list.first
    if (let Some(value) <- firstValue2) {
        println("反转后第一个元素: ${value}")
    }
    
    let lastValue2 = list.last
    if (let Some(value) <- lastValue2) {
        println("反转后最后一个元素: ${value}")
    }
    
    println("链表大小保持不变: ${list.size}")
    
    return 0
}
```

运行结果：

```text
原始链表:
第一个 第二个 第三个 第四个 第五个 
原始第一个元素: 第一个
原始最后一个元素: 第五个
反转后的链表:
第五个 第四个 第三个 第二个 第一个 
反转后第一个元素: 第五个
反转后最后一个元素: 第一个
链表大小保持不变: 5
```

### func skip(Int64)

```cangjie
public func skip(count: Int64): LinkedList<T>
```

功能： 跳过特定个数元素并返回一个新链表。

当 count 小于等于 0 时，抛出异常。当 count 等于 0 时，相当没有跳过任何元素，返回包含源链表所有元素的新链表。当 count 大于 0 小于源链表的大小时，跳过前 count 个元素，返回包含剩下的元素的新链表。当 count 大于等于源链表的大小时，返回空链表。

参数：

- count: [Int64](core_package_intrinsics.md#int64) - 要跳过的个数。

返回值：

- [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> - 返回一个跳过指定数量元素的新链表。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当 count < 0 时，抛出异常。

### func splitOff(LinkedListNode\<T>)

```cangjie
public func splitOff(node: LinkedListNode<T>): LinkedList<T>
```

功能：从指定的节点 node 开始，将链表分割为两个链表，如果分割成功，node 不在当前的链表内，而是作为首个节点存在于新的链表内部。

参数：

- node: [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - 要分割的位置。

返回值：

- [LinkedList](collection_package_class.md#class-linkedlistt)\<T> - 原链表分割后新产生的链表。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果指定的节点不属于该链表，则抛此异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = LinkedList<Int64>()
    
    // 添加一些元素
    list.addLast(1)
    list.addLast(2)
    list.addLast(3)
    list.addLast(4)
    list.addLast(5)
    list.addLast(6)
    
    println("分割前的原始链表:")
    for (element in list) {
        print("${element} ")
    }
    println()
    println("原始链表大小: ${list.size}")
    
    // 获取第三个节点（索引为2，值为3）作为分割点
    let thirdNode = list.nodeAt(2)
    if (let Some(node) <- thirdNode) {
        println("在节点 ${node.value} 处分割链表")
        
        // 分割链表
        let newList = list.splitOff(node)
        
        println("分割后的原链表:")
        for (element in list) {
            print("${element} ")
        }
        println()
        println("原链表大小: ${list.size}")
        
        println("新的链表:")
        for (element in newList) {
            print("${element} ")
        }
        println()
        println("新链表大小: ${newList.size}")
        
        // 验证新链表的第一个元素
        let newFirstValue = newList.first
        if (let Some(value) <- newFirstValue) {
            println("新链表的第一个元素: ${value}")
        }
        
        // 验证原链表的最后一个元素
        let originalLastValue = list.last
        if (let Some(value) <- originalLastValue) {
            println("原链表的最后一个元素: ${value}")
        }
    }
    
    return 0
}
```

运行结果：

```text
分割前的原始链表:
1 2 3 4 5 6 
原始链表大小: 6
在节点 3 处分割链表
分割后的原链表:
1 2 
原链表大小: 2
新的链表:
3 4 5 6 
新链表大小: 4
新链表的第一个元素: 3
原链表的最后一个元素: 2
```

### func step(Int64)
```cangjie
public func step(count: Int64): LinkedList<T>
```

功能：以指定的间隔从链表中提取元素，并返回一个新链表。

当 count 小于等于 0 时，抛出异常

参数：

- count: [Int64](core_package_intrinsics.md#int64) - 选取的间隔

返回值：

- [LinkedList](collection_package_class.md#class-linkedlistt)\<T> - 一个新的 [LinkedList](collection_package_class.md#class-linkedlistt)，包含了按间隔从源 [LinkedList](collection_package_class.md#class-linkedlistt) 中提取出的所有元素。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当 count <= 0 时，抛出异常。

### func take(Int64)
```cangjie
public func take(count: Int64): LinkedList<T>
```

功能： 从链表取出特定个数元素并返回一个新链表。

当 count 小于等于 0 时，抛出异常。当 count 等于 0 时，不取元素，返回空链表。当 count 大于 0 小于源链表的大小时，取前 count 个元素，返回新链表。当 count 大于等于源链表的大小时，取所有元素，返回新链表。

参数：

- count: [Int64](core_package_intrinsics.md#int64) - 要取出的个数。

返回值：

- [LinkedList](collection_package_class.md#class-linkedlistt)\<T> - 返回一个取出指定数量元素的新链表。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当 count < 0 时，抛出异常。

### func toArray()

```cangjie
public func toArray(): Array<T>
```

功能：返回一个数组，数组包含该链表中的所有元素，并且顺序与链表的顺序相同。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - T 类型数组。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = LinkedList<String>()
    
    // 添加一些元素
    list.addLast("苹果")
    list.addLast("香蕉")
    list.addLast("橙子")
    list.addLast("葡萄")
    list.addLast("草莓")
    
    println("原始链表:")
    for (element in list) {
        print("${element} ")
    }
    println()
    println("链表大小: ${list.size}")
    
    // 将链表转换为数组
    let array = list.toArray()
    println("转换后的数组大小: ${array.size}")
    
    // 验证数组内容和顺序
    println("数组内容:")
    for (i in 0..array.size) {
        print("[${i}]: ${array[i]} ")
    }
    println()
    
    // 验证第一个和最后一个元素
    println("数组第一个元素: ${array[0]}")
    println("数组最后一个元素: ${array[array.size - 1]}")
    
    // 验证与链表的一致性
    let listFirst = list.first
    if (let Some(value) <- listFirst) {
        println("链表第一个元素: ${value}")
    }
    
    let listLast = list.last
    if (let Some(value) <- listLast) {
        println("链表最后一个元素: ${value}")
    }
    
    return 0
}
```

运行结果：

```text
原始链表:
苹果 香蕉 橙子 葡萄 草莓 
链表大小: 5
转换后的数组大小: 5
数组内容:
[0]: 苹果 [1]: 香蕉 [2]: 橙子 [3]: 葡萄 [4]: 草莓 
数组第一个元素: 苹果
数组最后一个元素: 草莓
链表第一个元素: 苹果
链表最后一个元素: 草莓
```

### extend\<T> LinkedList\<T>

```cangjie
extend<T> LinkedList<T>
```

功能：为 [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> 类型进行拓展

#### func enumerate()

```cangjie
public func enumerate(): LinkedList<(Int64, T)>
```

功能：用于获取带索引的链表。

返回值：

- [LinkedList](./collection_package_class.md#class-linkedlistt)\<([Int64](../../core/core_package_api/core_package_intrinsics.md#int64), T)> - 返回一个带索引的新 [LinkedList](./collection_package_class.md#class-linkedlistt)。

#### func zip\<R>(LinkedList\<R>)

```cangjie
public func zip<R>(other: LinkedList<R>): LinkedList<(T, R)>
```

功能：将两个 [LinkedList](./collection_package_class.md#class-linkedlistt) 合并成一个新 [LinkedList](./collection_package_class.md#class-linkedlistt)（长度取决于短的那个链表）。

参数：

- other: [LinkedList](./collection_package_class.md#class-linkedlistt)\<R> - 要合并的其中一个链表。

返回值：

- [LinkedList](./collection_package_class.md#class-linkedlistt)\<(T, R)> - 返回一个新链表。

### extend\<T> LinkedList\<T> <: Equatable\<LinkedList\<T>> where T <: Equatable\<T>

```cangjie
extend<T> LinkedList<T> <: Equatable<LinkedList<T>> where T <: Equatable<T>
```

功能：为 [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> 类型扩展 [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[LinkedList](./collection_package_class.md#class-linkedlistt)\<T>> 接口，支持判等操作。

父类型：

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[LinkedList](#class-linkedlistt)\<T>>

#### operator func !=(LinkedList\<T>)

```cangjie
public operator func !=(right: LinkedList<T>): Bool
```

功能：判断当前实例与参数指向的 [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> 实例是否不等。

参数：

- right: [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> - 被比较的对象。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果不等，则返回 true，否则返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list1 = LinkedList<String>()
    let list2 = LinkedList<String>()
    
    // 测试空链表的不等性
    println("两个空链表不等: ${list1 != list2}")
    
    // 向list1添加元素
    list1.addLast("第一个")
    list1.addLast("第二个")
    
    // 测试不同大小的链表
    println("不同大小的链表不等: ${list1 != list2}")
    
    // 向list2添加相同的元素
    list2.addLast("第一个")
    list2.addLast("第二个")
    
    println("具有相同元素的链表不等: ${list1 != list2}")
    
    // 创建一个具有不同元素的链表
    let list3 = LinkedList<String>()
    list3.addLast("第一个")
    list3.addLast("第三个") // 不同的元素
    
    println("具有不同元素的链表不等: ${list1 != list3}")
    
    // 创建一个具有相同元素但不同顺序的链表
    let list4 = LinkedList<String>()
    list4.addLast("第二个")
    list4.addLast("第一个")
    
    println("相同元素但不同顺序的链表不等: ${list1 != list4}")
    
    // 显示所有链表内容以供验证
    print("list1: ")
    for (element in list1) {
        print("${element} ")
    }
    println()
    
    print("list2: ")
    for (element in list2) {
        print("${element} ")
    }
    println()
    
    print("list3: ")
    for (element in list3) {
        print("${element} ")
    }
    println()
    
    print("list4: ")
    for (element in list4) {
        print("${element} ")
    }
    println()
    
    return 0
}
```

运行结果：

```text
两个空链表不等: false
不同大小的链表不等: true
具有相同元素的链表不等: false
具有不同元素的链表不等: true
相同元素但不同顺序的链表不等: true
list1: 第一个 第二个 
list2: 第一个 第二个 
list3: 第一个 第三个 
list4: 第二个 第一个 
```

#### operator func ==(LinkedList\<T>)

```cangjie
public operator func ==(right: LinkedList<T>): Bool
```

功能：判断当前实例与参数指向的 [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> 实例是否相等。

两个 [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> 相等指的是其中包含的元素完全相等。

参数：

- right: [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> - 被比较的对象。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果相等，则返回 true，否则返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list1 = LinkedList<Int64>()
    let list2 = LinkedList<Int64>()
    let list3 = LinkedList<Int64>()
    
    // 测试空链表的相等性
    println("两个空链表相等: ${list1 == list2}")
    
    // 向list1和list2添加相同的元素
    list1.addLast(1)
    list1.addLast(2)
    list1.addLast(3)
    
    list2.addLast(1)
    list2.addLast(2)
    list2.addLast(3)
    
    println("具有相同元素的链表相等: ${list1 == list2}")
    
    // 向list3添加不同的元素
    list3.addLast(1)
    list3.addLast(2)
    list3.addLast(4) // 不同的元素
    
    println("具有不同元素的链表不相等: ${list1 == list3}")
    
    // 测试不同大小的链表
    let list4 = LinkedList<Int64>()
    list4.addLast(1)
    list4.addLast(2)
    
    println("不同大小的链表不相等: ${list1 == list4}")
    
    // 测试相同元素但不同顺序
    let list5 = LinkedList<Int64>()
    list5.addLast(3)
    list5.addLast(2)
    list5.addLast(1)
    
    println("相同元素但不同顺序的链表不相等: ${list1 == list5}")
    
    // 显示链表内容以供验证
    print("list1: ")
    for (element in list1) {
        print("${element} ")
    }
    println()
    
    print("list5: ")
    for (element in list5) {
        print("${element} ")
    }
    println()
    
    return 0
}
```

运行结果：

```text
两个空链表相等: true
具有相同元素的链表相等: true
具有不同元素的链表不相等: false
不同大小的链表不相等: false
相同元素但不同顺序的链表不相等: false
list1: 1 2 3 
list5: 3 2 1 
```

### extend\<T> LinkedList\<T> <: ToString where T <: ToString

```cangjie
extend<T> LinkedList<T> <: ToString where T <: ToString
```

功能：为 [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> 扩展 [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) 接口，支持转字符串操作。

父类型：

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

功能：将当前 [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> 实例转换为字符串。

该字符串包含 [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> 内每个元素的字符串表示，形如："[elem1, elem2, elem3]"。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 转换得到的字符串。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 测试空链表
    let emptyList = LinkedList<Int64>()
    println("空链表的toString: ${emptyList.toString()}")
    
    // 测试单个元素的链表
    let singleList = LinkedList<String>()
    singleList.addLast("单个元素")
    println("单个元素链表的toString: ${singleList.toString()}")
    
    // 测试多个元素的链表
    let numberList = LinkedList<Int64>()
    numberList.addLast(10)
    numberList.addLast(20)
    numberList.addLast(30)
    numberList.addLast(40)
    println("数字链表的toString: ${numberList.toString()}")
    
    // 测试字符串链表
    let stringList = LinkedList<String>()
    stringList.addLast("苹果")
    stringList.addLast("香蕉")
    stringList.addLast("橙子")
    println("字符串链表的toString: ${stringList.toString()}")
    
    // 验证toString的结果与手动构建的字符串一致
    print("手动遍历数字链表: [")
    var isFirst = true
    for (element in numberList) {
        if (!isFirst) {
            print(", ")
        }
        print("${element}")
        isFirst = false
    }
    println("]")
    
    // 测试修改后的toString
    numberList.addFirst(5)
    numberList.addLast(50)
    println("修改后的数字链表toString: ${numberList.toString()}")
    
    return 0
}
```

运行结果：

```text
空链表的toString: []
单个元素链表的toString: [单个元素]
数字链表的toString: [10, 20, 30, 40]
字符串链表的toString: [苹果, 香蕉, 橙子]
手动遍历数字链表: [10, 20, 30, 40]
修改后的数字链表toString: [5, 10, 20, 30, 40, 50]
```

## class LinkedListNode\<T>

```cangjie
public class LinkedListNode<T>
```

功能：[LinkedListNode](collection_package_class.md#class-linkedlistnodet) 是 [LinkedList](collection_package_class.md#class-linkedlistt) 上的节点。

可以通过 [LinkedListNode](collection_package_class.md#class-linkedlistnodet) 对 [LinkedList](collection_package_class.md#class-linkedlistt) 进行前向后向遍历操作，也可以访问和修改元素的值。

[LinkedListNode](collection_package_class.md#class-linkedlistnodet) 只能通过对应 [LinkedList](collection_package_class.md#class-linkedlistt) 的 'nodeAt'、'firstNode'、'lastNode' 获得，当 [LinkedList](collection_package_class.md#class-linkedlistt) 删除掉对应的节点时，会造成一个悬空的节点，对悬空的节点进行任何操作都会抛 '[IllegalStateException](../../core/core_package_api/core_package_exceptions.md#class-illegalstateexception)' 异常。

### prop next

```cangjie
public prop next: Option<LinkedListNode<T>>
```

功能：获取当前节点的下一个节点，如果没有则返回 None。

类型：[Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T>>

异常：

- [IllegalStateException](../../core/core_package_api/core_package_exceptions.md#class-illegalstateexception) - 如果该节点不属于任何链表实例，抛此异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = LinkedList<Int64>()
    
    // 添加元素
    list.addLast(10)
    list.addLast(20)
    list.addLast(30)
    
    // 获取第一个节点并检查其next属性
    let firstNode = list.firstNode
    if (let Some(node) <- firstNode) {
        let nextNode = node.next
        if (let Some(next) <- nextNode) {
            println("下一个节点值: ${next.value}")
        } else {
            println("没有下一个节点")
        }
    } else {
        println("链表为空")
    }
    
    // 获取最后一个节点并检查其next属性
    let lastNode = list.lastNode
    if (let Some(node) <- lastNode) {
        let nextNode = node.next
        if (let Some(next) <- nextNode) {
            println("下一个节点值: ${next.value}")
        } else {
            println("没有下一个节点")
        }
    } else {
        println("链表为空")
    }
    
    return 0
}
```

运行结果：

```text
下一个节点值: 20
没有下一个节点
```

### prop prev

```cangjie
public prop prev: Option<LinkedListNode<T>>
```

功能：获取当前节点的前一个节点，如果没有则返回 None。

类型：[Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T>>

异常：

- [IllegalStateException](../../core/core_package_api/core_package_exceptions.md#class-illegalstateexception) - 如果该节点不属于任何链表实例，抛此异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = LinkedList<Int64>()
    
    // 添加元素
    list.addLast(10)
    list.addLast(20)
    list.addLast(30)
    
    // 获取最后一个节点并检查其prev属性
    let lastNode = list.lastNode
    if (let Some(node) <- lastNode) {
        let prevNode = node.prev
        if (let Some(prev) <- prevNode) {
            println("前一个节点值: ${prev.value}")
        } else {
            println("没有前一个节点")
        }
    } else {
        println("链表为空")
    }
    
    // 获取第一个节点并检查其prev属性
    let firstNode = list.firstNode
    if (let Some(node) <- firstNode) {
        let prevNode = node.prev
        if (let Some(prev) <- prevNode) {
            println("前一个节点值: ${prev.value}")
        } else {
            println("没有前一个节点")
        }
    } else {
        println("链表为空")
    }
    
    return 0
}
```

运行结果：

```text
前一个节点值: 20
没有前一个节点
```

### prop value

```cangjie
public mut prop value: T
```

功能：获取或者修改元素的值。

类型：T

异常：

- [IllegalStateException](../../core/core_package_api/core_package_exceptions.md#class-illegalstateexception) - 如果该节点不属于任何链表实例，抛此异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let list = LinkedList<Int64>()
    
    // 添加元素
    list.addLast(10)
    list.addLast(20)
    list.addLast(30)
    
    // 获取第一个节点并访问其value属性
    let firstNode = list.firstNode
    if (let Some(node) <- firstNode) {
        println("第一个节点值: ${node.value}")
        
        // 修改节点的值
        node.value = 100
        println("修改后第一个节点值: ${node.value}")
    } else {
        println("链表为空")
    }
    
    // 再次确认第一个节点的值已被修改
    if (let Some(node) <- list.firstNode) {
        println("确认第一个节点值: ${node.value}")
    }
    
    return 0
}
```

运行结果：

```text
第一个节点值: 10
修改后第一个节点值: 100
确认第一个节点值: 100
```

## class TreeMap\<K, V> where K <: Comparable\<K>

```cangjie
public class TreeMap<K, V> <: OrderedMap<K, V> where K <: Comparable<K> {
    public init()
    public init(elements: Collection<(K, V)>)
    public init(elements: Array<(K,V)>)
    public init(size: Int64, initElement: (Int64) -> (K, V))
}
```

功能：基于平衡二叉搜索树实现的 [OrderedMap](collection_package_interface.md#interface-orderedmapk-v) 接口实例。

这个类的主要目的是提供一个有序的 key-value 存储结构，它可以快速地插入、删除、查找元素。

[TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 可以用于任何需要有序键值对存储的场景，例如数据库、缓存、查找表等。

父类型：

- [OrderedMap](collection_package_interface.md#interface-orderedmapk-v)\<K, V>

### prop first

```cangjie
public prop first: ?(K, V)
```

功能：获取 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 的第一个键值对。

类型：?(K, V)

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let map = TreeMap<String, Int64>()
    
    // 空TreeMap的情况
    let firstValue1 = map.first
    if (let Some((key, value)) <- firstValue1) {
        println("第一个元素: (${key}, ${value})")
    } else {
        println("TreeMap为空")
    }
    
    // 添加一些元素
    map.add("apple", 10)
    map.add("banana", 20)
    map.add("cherry", 30)
    
    // 获取第一个元素（按键的字典序）
    let firstValue2 = map.first
    if (let Some((key, value)) <- firstValue2) {
        println("第一个元素: (${key}, ${value})")
    } else {
        println("TreeMap为空")
    }
    
    return 0
}
```

运行结果：

```text
TreeMap为空
第一个元素: (apple, 10)
```

### prop last

```cangjie
public prop last: ?(K, V)
```

功能：获取 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 的最后一个键值对。

类型：?(K, V)

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let map = TreeMap<String, Int64>()
    
    // 空TreeMap的情况
    let lastValue1 = map.last
    if (let Some((key, value)) <- lastValue1) {
        println("最后一个元素: (${key}, ${value})")
    } else {
        println("TreeMap为空")
    }
    
    // 添加一些元素
    map.add("apple", 10)
    map.add("banana", 20)
    map.add("cherry", 30)
    
    // 获取最后一个元素（按键的字典序）
    let lastValue2 = map.last
    if (let Some((key, value)) <- lastValue2) {
        println("最后一个元素: (${key}, ${value})")
    } else {
        println("TreeMap为空")
    }
    
    return 0
}
```

运行结果：

```text
TreeMap为空
最后一个元素: (cherry, 30)
```

### prop size

```cangjie
public prop size: Int64
```

功能：返回键值的个数。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let map = TreeMap<String, Int64>()
    
    // 空TreeMap的大小
    println("空TreeMap大小: ${map.size}")
    
    // 添加一些元素
    map.add("apple", 10)
    println("添加1个元素后大小: ${map.size}")
    
    map.add("banana", 20)
    map.add("cherry", 30)
    println("添加3个元素后大小: ${map.size}")
    
    // 覆盖现有键不会增加大小
    map.add("apple", 15)
    println("覆盖元素后大小: ${map.size}")
    
    return 0
}
```

运行结果：

```text
空TreeMap大小: 0
添加1个元素后大小: 1
添加3个元素后大小: 3
覆盖元素后大小: 3
```

### init()

```cangjie
public init()
```

功能：构造一个空的 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek)。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个空的TreeMap
    let map = TreeMap<String, Int64>()
    
    println("初始大小: ${map.size}")
    println("是否为空: ${map.isEmpty()}")
    
    // 添加一些元素
    map.add("key1", 100)
    map.add("key2", 200)
    
    println("添加元素后大小: ${map.size}")
    println("添加元素后是否为空: ${map.isEmpty()}")
    
    return 0
}
```

运行结果：

```text
初始大小: 0
是否为空: true
添加元素后大小: 2
添加元素后是否为空: false
```

### init(Array\<(K,V)>)

```cangjie
public init(elements: Array<(K,V)>)
```

功能：通过传入的键值对数组构造一个 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek)。

按照 elements 的先后顺序将元素插入到 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 内，由于 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 中不允许出现相同的键，如果 elements 中有相同的键时，后出现的键值对将会覆盖先出现的键值对。

参数：

- elements: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<(K, V)> - 初始化该 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 的键值对数组。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 使用数组初始化TreeMap
    let array: Array<(String, Int64)> = [("banana", 20), ("apple", 10), ("cherry", 30)]
    let map = TreeMap<String, Int64>(array)
    
    println("初始化后大小: ${map.size}")
    
    // 遍历元素（TreeMap会按键的字典序排列）
    for ((key, value) in map) {
        println("${key}: ${value}")
    }
    
    // 测试覆盖情况
    let arrayWithDup: Array<(String, Int64)> = [("apple", 5), ("apple", 15), ("banana", 25)]
    let mapWithDup = TreeMap<String, Int64>(arrayWithDup)
    
    println("\n包含重复键的数组初始化:")
    for ((key, value) in mapWithDup) {
        println("${key}: ${value}")
    }
    
    return 0
}
```

运行结果：

```text
初始化后大小: 3
apple: 10
banana: 20
cherry: 30

包含重复键的数组初始化:
apple: 15
banana: 25
```

### init(Collection\<(K, V)>)

```cangjie
public init(elements: Collection<(K, V)>)
```

功能：通过传入的键值对集合构造一个 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek)。

按照 elements 的迭代器顺序将元素插入到 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 内，由于 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 中不允许出现相同的键，如果 elements 中有相同的键时，后出现(迭代器顺序)的键值对将会覆盖先出现的键值对。

参数：

- elements: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<(K, V)> - 初始化该 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 的键值对集合。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 使用ArrayList作为集合初始化TreeMap
    let list = ArrayList<(String, Int64)>()
    list.add(("dog", 40))
    list.add(("cat", 30))
    list.add(("bird", 50))
    
    let map = TreeMap<String, Int64>(list)
    println("使用ArrayList初始化的TreeMap大小: ${map.size}")
    
    for ((key, value) in map) {
        println("${key}: ${value}")
    }
    
    // 使用另一个TreeMap初始化
    let originalMap = TreeMap<String, Int64>()
    originalMap.add("x", 100)
    originalMap.add("y", 200)
    originalMap.add("z", 300)
    
    let newMap = TreeMap<String, Int64>(originalMap)
    println("\n使用TreeMap初始化的新TreeMap大小: ${newMap.size}")
    
    for ((key, value) in newMap) {
        println("${key}: ${value}")
    }
    
    return 0
}
```

运行结果：

```text
使用ArrayList初始化的TreeMap大小: 3
bird: 50
cat: 30
dog: 40

使用TreeMap初始化的新TreeMap大小: 3
x: 100
y: 200
z: 300
```

### init(Int64, (Int64) -> (K, V))

```cangjie
public init(size: Int64, initElement: (Int64) -> (K, V))
```

功能：通过传入的元素个数 size 和函数规则来构造 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek)。

参数：

- size: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 传入的元素个数。
- initElement: ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) -> (K, V) - 初始化该 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 的函数规则。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果 size 小于 0 则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 使用函数规则初始化TreeMap。函数接受索引参数，返回键值对
    let map = TreeMap<String, Int64>(3, {i: Int64 => ("key${i}", i * 10)})
    
    println("初始化后大小: ${map.size}")
    
    // 遍历所有元素
    for ((key, value) in map) {
        println("${key}: ${value}")
    }
    
    // 使用更复杂的函数规则
    let map2 = TreeMap<String, Int64>(4, {i: Int64 => 
        let alphabet = ["A", "B", "C", "D"]
        (alphabet[i], (i + 1) * (i + 1))
    })
    
    println("\n第二个映射:")
    for ((key, value) in map2) {
        println("${key}: ${value}")
    }
    
    return 0
}
```

运行结果：

```text
初始化后大小: 3
key0: 0
key1: 10
key2: 20

第二个映射:
A: 1
B: 4
C: 9
D: 16
```

### func add(Collection\<(K, V)>)

```cangjie
public func add(all!: Collection<(K, V)>): Unit
```

功能：将新的键值对集合放入 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 中。对于 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 中已有的键，该键的值将被新值替换。

参数：

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<(K, V)> - 需要添加进 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 的键值对集合。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let map = TreeMap<String, Int64>()
    
    // 初始添加一个元素
    map.add("a", 1)
    println("初始状态: 大小=${map.size}")
    
    // 使用ArrayList添加多个键值对
    let list = ArrayList<(String, Int64)>()
    list.add(("b", 2))
    list.add(("c", 3))
    list.add(("d", 4))
    
    map.add(all: list)
    println("添加ArrayList后: 大小=${map.size}")
    
    // 使用另一个TreeMap添加元素
    let anotherMap = TreeMap<String, Int64>()
    anotherMap.add("a", 10)  // 覆盖现有键
    anotherMap.add("e", 5)   // 新键
    
    map.add(all: anotherMap)
    println("添加TreeMap后: 大小=${map.size}")
    
    println("\n最终的TreeMap:")
    for ((key, value) in map) {
        println("${key}: ${value}")
    }
    
    return 0
}
```

运行结果：

```text
初始状态: 大小=1
添加ArrayList后: 大小=4
添加TreeMap后: 大小=5

最终的TreeMap:
a: 10
b: 2
c: 3
d: 4
e: 5
```

### func add(K, V)

```cangjie
public func add(key: K, value: V): Option<V>
```

功能：将新的键值对放入 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 中。对于 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 中已有的键，该键的值将被新值替换。

参数：

- key: K - 要放置的键。
- value: V - 要分配的值。

返回值：

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V> - 如果赋值之前 key 存在，旧的 value 用 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 封装并返回；否则，返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V>.None。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let map = TreeMap<String, Int64>()
    
    // 添加新的键值对
    let result1 = map.add("apple", 10)
    if (let Some(oldValue) <- result1) {
        println("覆盖了旧值: ${oldValue}")
    } else {
        println("添加了新键: apple")
    }
    
    let result2 = map.add("banana", 20)
    if (let Some(oldValue) <- result2) {
        println("覆盖了旧值: ${oldValue}")
    } else {
        println("添加了新键: banana")
    }
    
    // 覆盖现有的键
    let result3 = map.add("apple", 15)
    if (let Some(oldValue) <- result3) {
        println("覆盖了旧值: ${oldValue}")
    } else {
        println("添加了新键: apple")
    }
    
    println("\n最终的TreeMap:")
    for ((key, value) in map) {
        println("${key}: ${value}")
    }
    
    return 0
}
```

运行结果：

```text
添加了新键: apple
添加了新键: banana
覆盖了旧值: 10

最终的TreeMap:
apple: 15
banana: 20
```

### func all((K, V) -> Bool)

```cangjie
public func all(predicate: (K, V) -> Bool): Bool
```

功能：判断 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 中所有键值对是否都满足条件。

参数：

- predicate: (K, V) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 中所有键值对都满足条件，返回 true，否则返回 false

### func any((K, V) -> Bool)

```cangjie
public func any(predicate: (K, V) -> Bool): Bool
```

功能：判断 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 是否存在任意一个满足条件的键值对。

参数：

- predicate: (K, V) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 是否存在任意满足条件的键值对。

### func backward(K, Bool)

```cangjie
public func backward(mark: K, inclusive!: Bool = true): Iterator<(K, V)>
```

功能：获取从第一个键小于等于 mark 的节点按降序遍历到 [first](./collection_package_class.md#prop-first-3) 的迭代器。如果该节点的键等于 mark ，那么根据 `inclusive!` 确定是否包含该键对应的节点。

参数：

- mark: K - 用于确定从哪里开始的键。
- inclusive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 当 `mark` 是迭代器的首个元素的 key 时，指定是否包含 mark 作为起始点，默认为 `true`。

返回值：

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<(K, V)> - 对应元素的迭代器。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let map = TreeMap<String, Int64>()
    map.add("apple", 10)
    map.add("banana", 20)
    map.add("cherry", 30)
    map.add("date", 40)
    map.add("elderberry", 50)
    map.add("fig", 60)
    map.add("grape", 70)
    
    println("TreeMap内容: ${map}")
    
    // 从"elderberry"开始按降序遍历（包含elderberry）
    println("\n从'elderberry'开始按降序遍历（包含elderberry）:")
    let backwardIter1 = map.backward("elderberry", inclusive: true)
    for ((key, value) in backwardIter1) {
        println("${key}: ${value}")
    }
    
    // 从"elderberry"开始按降序遍历（不包含elderberry）
    println("\n从'elderberry'开始按降序遍历（不包含elderberry）:")
    let backwardIter2 = map.backward("elderberry", inclusive: false)
    for ((key, value) in backwardIter2) {
        println("${key}: ${value}")
    }
    
    // 从"fig"开始按降序遍历（默认包含）
    println("\n从'fig'开始按降序遍历（默认包含）:")
    let backwardIter3 = map.backward("fig")
    for ((key, value) in backwardIter3) {
        println("${key}: ${value}")
    }
    
    // 从不存在的键"coconut"开始遍历
    println("\n从不存在的键'coconut'开始按降序遍历:")
    let backwardIter4 = map.backward("coconut")
    for ((key, value) in backwardIter4) {
        println("${key}: ${value}")
    }
    
    return 0
}
```

运行结果：

```text
TreeMap内容: [(apple, 10), (banana, 20), (cherry, 30), (date, 40), (elderberry, 50), (fig, 60), (grape, 70)]

从'elderberry'开始按降序遍历（包含elderberry）:
elderberry: 50
date: 40
cherry: 30
banana: 20
apple: 10

从'elderberry'开始按降序遍历（不包含elderberry）:
date: 40
cherry: 30
banana: 20
apple: 10

从'fig'开始按降序遍历（默认包含）:
fig: 60
elderberry: 50
date: 40
cherry: 30
banana: 20
apple: 10

从不存在的键'coconut'开始按降序遍历:
cherry: 30
banana: 20
apple: 10
```

### func clear()

```cangjie
public func clear(): Unit
```

功能：清除所有键值对。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let map = TreeMap<String, Int64>()
    
    // 添加一些元素
    map.add("apple", 10)
    map.add("banana", 20)
    map.add("cherry", 30)
    
    println("清理前的大小: ${map.size}")
    println("清理前是否为空: ${map.isEmpty()}")
    
    // 清理所有元素
    map.clear()
    
    println("清理后的大小: ${map.size}")
    println("清理后是否为空: ${map.isEmpty()}")
    
    // 验证可以再次添加元素
    map.add("new_key", 100)
    println("重新添加元素后的大小: ${map.size}")
    
    return 0
}
```

运行结果：

```text
清理前的大小: 3
清理前是否为空: false
清理后的大小: 0
清理后是否为空: true
重新添加元素后的大小: 1
```

### func clone()

```cangjie
public func clone(): TreeMap<K, V>
```

功能：克隆 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek)。

返回值：

- [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V> - 返回一个 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 实例。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建原始TreeMap
    let originalMap = TreeMap<String, Int64>()
    originalMap.add("apple", 10)
    originalMap.add("banana", 20)
    originalMap.add("cherry", 30)
    
    println("原始映射大小: ${originalMap.size}")
    
    // 克隆TreeMap
    let clonedMap = originalMap.clone()
    
    println("克隆映射大小: ${clonedMap.size}")
    
    // 验证克隆后的数据独立性
    clonedMap.add("date", 40)
    originalMap.add("elderberry", 50)
    
    println("\n修改后的原始映射:")
    for ((key, value) in originalMap) {
        println("${key}: ${value}")
    }
    
    println("\n修改后的克隆映射:")
    for ((key, value) in clonedMap) {
        println("${key}: ${value}")
    }
    
    return 0
}
```

运行结果：

```text
原始映射大小: 3
克隆映射大小: 3

修改后的原始映射:
apple: 10
banana: 20
cherry: 30
elderberry: 50

修改后的克隆映射:
apple: 10
banana: 20
cherry: 30
date: 40
```

### func contains(Collection\<K>)

```cangjie
public func contains(all!: Collection<K>): Bool
```

功能：判断是否包含指定集合键的映射。

参数：

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<K> - 键的集合。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果存在，则返回 true；否则，返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let map = TreeMap<String, Int64>()
    map.add("apple", 10)
    map.add("banana", 20)
    map.add("cherry", 30)
    map.add("date", 40)
    map.add("elderberry", 50)
    
    println("TreeMap内容: ${map}")
    
    // 使用ArrayList创建要检查的键集合
    let keysToCheck1 = ArrayList<String>()
    keysToCheck1.add("apple")
    keysToCheck1.add("banana")
    keysToCheck1.add("cherry")
    
    println("\n检查集合1: [apple, banana, cherry]")
    let contains1 = map.contains(all: keysToCheck1)
    println("是否包含所有键: ${contains1}")
    
    // 检查包含部分不存在键的集合
    let keysToCheck2 = ArrayList<String>()
    keysToCheck2.add("apple")
    keysToCheck2.add("grape")  // 不存在的键
    keysToCheck2.add("cherry")
    
    println("\n检查集合 2: [apple, grape, cherry]")
    let contains2 = map.contains(all: keysToCheck2)
    println("是否包含所有键: ${contains2}")
    
    // 检查全部不存在的键集合
    let keysToCheck3 = ArrayList<String>()
    keysToCheck3.add("grape")
    keysToCheck3.add("orange")
    keysToCheck3.add("peach")
    
    println("\n检查集合 3: [grape, orange, peach]")
    let contains3 = map.contains(all: keysToCheck3)
    println("是否包含所有键: ${contains3}")
    
    // 检查空集合
    let emptyKeys = ArrayList<String>()
    println("\n检查空集合: []")
    let contains4 = map.contains(all: emptyKeys)
    println("是否包含所有键: ${contains4}")
    
    return 0
}
```

运行结果：

```text
TreeMap内容: [(apple, 10), (banana, 20), (cherry, 30), (date, 40), (elderberry, 50)]

检查集合1: [apple, banana, cherry]
是否包含所有键: true

检查集合 2: [apple, grape, cherry]
是否包含所有键: false

检查集合 3: [grape, orange, peach]
是否包含所有键: false

检查空集合: []
是否包含所有键: true
```

### func contains(K)

```cangjie
public func contains(key: K): Bool
```

功能：判断是否包含指定键的映射。

参数：

- key: K - 传递要判断的 key。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果存在，则返回 true；否则，返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let map = TreeMap<String, Int64>()
    map.add("apple", 10)
    map.add("banana", 20)
    map.add("cherry", 30)
    
    // 检查存在的键
    println("contains 'apple': ${map.contains("apple")}")
    println("contains 'banana': ${map.contains("banana")}")
    
    // 检查不存在的键
    println("contains 'grape': ${map.contains("grape")}")
    println("contains 'orange': ${map.contains("orange")}")
    
    return 0
}
```

运行结果：

```text
contains 'apple': true
contains 'banana': true
contains 'grape': false
contains 'orange': false
```

### func entryView(K)

```cangjie
public func entryView(k: K): MapEntryView<K, V>
```

功能：如果不包含特定键，返回一个空的引用视图。如果包含特定键，则返回该键对应的元素的引用视图。

参数：

- k: K - 要添加的键值对的键。

返回值：

- [MapEntryView](./collection_package_interface.md#interface-mapentryviewk-v)\<K, V> - 一个引用视图。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let map = TreeMap<String, Int64>()
    map.add("apple", 10)
    map.add("banana", 20)
    map.add("cherry", 30)
    
    println("TreeMap内容: ${map}")
    
    // 获取存在键的引用视图
    let entryView1 = map.entryView("apple")
    println("获取到apple的引用视图")
    
    // 获取不存在键的引用视图
    let entryView2 = map.entryView("grape")
    println("获取到grape的引用视图")
    
    // 注意：MapEntryView是一个引用视图接口
    // 它提供了对特定键值对的视图访问
    // 如果键存在，视图包含该键值对；如果不存在，则为空视图
    
    println("\nentryView用于提供对TreeMap中特定键值对的引用视图访问")
    
    return 0
}
```

运行结果：

```text
TreeMap内容: [(apple, 10), (banana, 20), (cherry, 30)]
获取到apple的引用视图
获取到grape的引用视图

entryView用于提供对TreeMap中特定键值对的引用视图访问
```

### func filter((K, V) -> Bool)
```cangjie
public func filter(predicate: (K, V) -> Bool): TreeMap<K, V>
```

功能： 返回一个满足筛选条件的键值对的新 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V>。

参数：

- predicate: (K, V) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V> - 返回一个满足筛选条件的键值对的新集合。

### func fold\<R>(R, (R, K, V) -> R)

```cangjie
public func fold<R>(initial: R, operation: (R, K, V) -> R): R
```

功能：使用指定初始值，从左向右计算。

参数：

- initial: R - 给定的 R 类型的初始值。
- operation: (R, K, V) -> R - 给定的计算函数。

返回值：

- R - 返回最终计算得到的值。

### func forEach((K, V) -> Unit)

```cangjie
public func forEach(action: (K, V) -> Unit): Unit
```

功能：遍历所有键值对，执行给定的操作。

参数：

- action: (K, V) -> [Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - 给定的操作函数。

### func forward(K, Bool)

```cangjie
public func forward(mark: K, inclusive!: Bool = true): Iterator<(K, V)>
```

功能：获取从第一个键大于等于 mark 的节点按升序遍历到 [last](./collection_package_class.md#prop-last-3) 结束的一个迭代器。如果该节点的键等于 mark ，那么根据 `inclusive!` 确定是否包含该键对应的节点。

参数：

- mark: K - 用于确定从哪里开始的键。
- inclusive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 当 `mark` 是迭代器的首个元素的 key 时，指定是否包含 mark 作为起始点，默认为 `true`。

返回值：

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<(K, V)> - 对应元素的迭代器。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let map = TreeMap<String, Int64>()
    map.add("apple", 10)
    map.add("banana", 20)
    map.add("cherry", 30)
    map.add("date", 40)
    map.add("elderberry", 50)
    map.add("fig", 60)
    map.add("grape", 70)
    
    println("TreeMap内容: ${map}")
    
    // 从"cherry"开始按升序遍历（包含cherry）
    println("\n从'cherry'开始按升序遍历（包含cherry）:")
    let forwardIter1 = map.forward("cherry", inclusive: true)
    for ((key, value) in forwardIter1) {
        println("${key}: ${value}")
    }
    
    // 从"cherry"开始按升序遍历（不包含cherry）
    println("\n从'cherry'开始按升序遍历（不包含cherry）:")
    let forwardIter2 = map.forward("cherry", inclusive: false)
    for ((key, value) in forwardIter2) {
        println("${key}: ${value}")
    }
    
    // 从"banana"开始按升序遍历（默认包含）
    println("\n从'banana'开始按升序遍历（默认包含）:")
    let forwardIter3 = map.forward("banana")
    for ((key, value) in forwardIter3) {
        println("${key}: ${value}")
    }
    
    // 从不存在的键"coconut"开始遍历
    println("\n从不存在的键'coconut'开始按升序遍历:")
    let forwardIter4 = map.forward("coconut")
    for ((key, value) in forwardIter4) {
        println("${key}: ${value}")
    }
    
    return 0
}
```

运行结果：

```text
TreeMap内容: [(apple, 10), (banana, 20), (cherry, 30), (date, 40), (elderberry, 50), (fig, 60), (grape, 70)]

从'cherry'开始按升序遍历（包含cherry）:
cherry: 30
date: 40
elderberry: 50
fig: 60
grape: 70

从'cherry'开始按升序遍历（不包含cherry）:
date: 40
elderberry: 50
fig: 60
grape: 70

从'banana'开始按升序遍历（默认包含）:
banana: 20
cherry: 30
date: 40
elderberry: 50
fig: 60
grape: 70

从不存在的键'coconut'开始按升序遍历:
date: 40
elderberry: 50
fig: 60
grape: 70
```

### func get(K)

```cangjie
public func get(key: K): ?V
```

功能：返回指定键映射的值。

参数：

- key: K - 指定的键。

返回值：

- ?V - 如果存在这样一个值，用 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 封装该值并返回；否则，返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V>.None。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let map = TreeMap<String, Int64>()
    map.add("apple", 10)
    map.add("banana", 20)
    map.add("cherry", 30)
    
    // 获取存在的键的值
    let value1 = map.get("apple")
    if (let Some(val) <- value1) {
        println("apple的值: ${val}")
    } else {
        println("未找到apple")
    }
    
    let value2 = map.get("banana")
    if (let Some(val) <- value2) {
        println("banana的值: ${val}")
    } else {
        println("未找到banana")
    }
    
    // 获取不存在的键的值
    let value3 = map.get("grape")
    if (let Some(val) <- value3) {
        println("grape的值: ${val}")
    } else {
        println("未找到grape")
    }
    
    return 0
}
```

运行结果：

```text
apple的值: 10
banana的值: 20
未找到grape
```

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

功能：判断 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 是否为空。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果为空，返回 true，否则返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let map = TreeMap<String, Int64>()
    
    // 初始状态下的空映射
    println("初始状态下是否为空: ${map.isEmpty()}")
    println("初始状态下的大小: ${map.size}")
    
    // 添加元素后
    map.add("apple", 10)
    map.add("banana", 20)
    
    println("添加元素后是否为空: ${map.isEmpty()}")
    println("添加元素后的大小: ${map.size}")
    
    // 清空后
    map.clear()
    
    println("清空后是否为空: ${map.isEmpty()}")
    println("清空后的大小: ${map.size}")
    
    return 0
}
```

运行结果：

```text
初始状态下是否为空: true
初始状态下的大小: 0
添加元素后是否为空: false
添加元素后的大小: 2
清空后是否为空: true
清空后的大小: 0
```

### func iterator()

```cangjie
public func iterator(): Iterator<(K, V)>
```

功能：返回 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 的迭代器，迭代器按 Key 值从小到大的顺序迭代。

返回值：

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<(K, V)> - [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 的迭代器。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let map = TreeMap<String, Int64>()
    map.add("cherry", 30)
    map.add("apple", 10)
    map.add("banana", 20)
    map.add("date", 40)
    
    // 使用迭代器手动遍历
    let iter = map.iterator()
    
    println("使用迭代器手动遍历:")
    for (entry in iter) {
        let (key, value) = entry
        println("${key}: ${value}")
    }
    
    // 使用for-in循环自动遍历（内部使用iterator）
    println("\n使用for-in循环遍历:")
    for ((key, value) in map) {
        println("${key}: ${value}")
    }
    
    return 0
}
```

运行结果：

```text
使用迭代器手动遍历:
apple: 10
banana: 20
cherry: 30
date: 40

使用for-in循环遍历:
apple: 10
banana: 20
cherry: 30
date: 40
```

### func keys()

```cangjie
public func keys(): EquatableCollection<K>
```

功能：返回 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 中所有的 key，并将所有 key 存储在一个容器中。

返回值：

- [EquatableCollection](collection_package_interface.md#interface-equatablecollectiont)\<K> - 包含所有键的集合。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let map = TreeMap<String, Int64>()
    map.add("cherry", 30)
    map.add("apple", 10)
    map.add("banana", 20)
    map.add("date", 40)
    
    // 获取所有的键
    let keyCollection = map.keys()
    
    println("所有的键:")
    for (key in keyCollection) {
        println("Key: ${key}")
    }
    
    // 验证键的数量
    println("\n键的数量: ${keyCollection.size}")
    println("TreeMap的大小: ${map.size}")
    
    return 0
}
```

运行结果：

```text
所有的键:
Key: apple
Key: banana
Key: cherry
Key: date

键的数量: 4
TreeMap的大小: 4
```

### func mapValues\<R>((K, V) -> R)

```cangjie
public func mapValues<R>(transform: (K, V) -> R): TreeMap<K, R>
```

功能：对此 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 进行映射并返回一个新 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek)。

参数：

- transform: (K, V) -> R - 给定的映射函数。

返回值：

- [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, R> - 返回一个新的 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek)。

### func mapValues\<R>((V) -> R)

```cangjie
public func mapValues<R>(transform: (V) -> R): TreeMap<K, R>
```

功能：对此 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, R> 进行映射并返回一个新 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, R>。

参数：

- transform: (V) -> R - 给定的映射函数。

返回值：

- [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, R> - 返回一个新的 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, R>。

### func none((K, V) -> Bool)

```cangjie
public func none(predicate: (K, V) -> Bool): Bool
```

功能：判断 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 中所有键值对是否都不满足条件。

参数：

- predicate: (K, V) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 当前 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 中键值对是否都不满足条件。

### func reduce((V, V) -> V)

```cangjie
public func reduce(operation: (V, V) -> V): Option<V>
```

功能：使用第一个值作为初始值，从左向右计算。

参数：

- operation: (V, V) -> V - 给定的计算函数。

返回值：

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V> - 返回计算结果。

### func remove(Collection\<K>)

```cangjie
public func remove(all!: Collection<K>): Unit
```

功能：从此映射中删除指定集合的映射（如果存在）。

参数：

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<K> - 传入要删除的键的集合。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let map = TreeMap<String, Int64>()
    
    // 添加一些元素
    map.add("apple", 10)
    map.add("banana", 20)
    map.add("cherry", 30)
    map.add("date", 40)
    map.add("elderberry", 50)
    
    println("删除前的TreeMap: ${map}")
    println("删除前的大小: ${map.size}")
    
    // 使用ArrayList创建要删除的键集合
    let keysToRemove = ArrayList<String>()
    keysToRemove.add("banana")
    keysToRemove.add("date")
    keysToRemove.add("nonexistent")  // 不存在的键
    
    println("\n要删除的键:")
    for (key in keysToRemove) {
        println("  ${key}")
    }
    
    // 删除集合中的键
    map.remove(all: keysToRemove)
    
    println("\n删除后的TreeMap: ${map}")
    println("删除后的大小: ${map.size}")
    
    // 使用另一个TreeMap的键来删除
    let anotherMap = TreeMap<String, Int64>()
    anotherMap.add("apple", 100)
    anotherMap.add("cherry", 300)
    anotherMap.add("grape", 600)  // 这个键在原map中不存在
    
    let keysFromAnotherMap = anotherMap.keys()
    println("\n从另一个TreeMap获取的键:")
    for (key in keysFromAnotherMap) {
        println("  ${key}")
    }
    
    map.remove(all: keysFromAnotherMap)
    
    println("\n最终的TreeMap: ${map}")
    println("最终的大小: ${map.size}")
    
    return 0
}
```

运行结果：

```text
删除前的TreeMap: [(apple, 10), (banana, 20), (cherry, 30), (date, 40), (elderberry, 50)]
删除前的大小: 5

要删除的键:
  banana
  date
  nonexistent

删除后的TreeMap: [(apple, 10), (cherry, 30), (elderberry, 50)]
删除后的大小: 3

从另一个TreeMap获取的键:
  apple
  cherry
  grape

最终的TreeMap: [(elderberry, 50)]
最终的大小: 1
```

### func remove(K)

```cangjie
public func remove(key: K): Option<V>
```

功能：从此映射中删除指定键的映射（如果存在）。

参数：

- key: K - 传入要删除的 key。

返回值：

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V> - 被移除映射的值用 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 封装，如果 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 中不存在指定的键，返回 None。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let map = TreeMap<String, Int64>()
    
    // 在空TreeMap中删除元素
    let result1 = map.remove("nonexistent")
    if (let Some(value) <- result1) {
        println("删除了元素，值为: ${value}")
    } else {
        println("没有找到要删除的键: nonexistent")
    }
    
    // 添加一些元素
    map.add("apple", 10)
    map.add("banana", 20)
    map.add("cherry", 30)
    map.add("date", 40)
    
    println("\n删除前的TreeMap: ${map}")
    println("删除前的大小: ${map.size}")
    
    // 删除存在的键
    let result2 = map.remove("banana")
    if (let Some(value) <- result2) {
        println("删除了键'banana'，值为: ${value}")
    } else {
        println("没有找到要删除的键: banana")
    }
    
    println("删除后的TreeMap: ${map}")
    println("删除后的大小: ${map.size}")
    
    // 尝试删除不存在的键
    let result3 = map.remove("grape")
    if (let Some(value) <- result3) {
        println("删除了键'grape'，值为: ${value}")
    } else {
        println("没有找到要删除的键: grape")
    }
    
    // 再删除一个存在的键
    let result4 = map.remove("apple")
    if (let Some(value) <- result4) {
        println("删除了键'apple'，值为: ${value}")
    }
    
    println("最终的TreeMap: ${map}")
    println("最终的大小: ${map.size}")
    
    return 0
}
```

运行结果：

```text
没有找到要删除的键: nonexistent

删除前的TreeMap: [(apple, 10), (banana, 20), (cherry, 30), (date, 40)]
删除前的大小: 4
删除了键'banana'，值为: 20
删除后的TreeMap: [(apple, 10), (cherry, 30), (date, 40)]
删除后的大小: 3
没有找到要删除的键: grape
删除了键'apple'，值为: 10
最终的TreeMap: [(cherry, 30), (date, 40)]
最终的大小: 2
```

### func removeFirst()

```cangjie
public func removeFirst(): ?(K, V)
```

功能：删除 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 的第一个元素。

返回值：

- ?(K, V) - 如果存在第一个元素，那么删除该元素，用 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 封装该元素并返回；否则返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<(K, V)>.None。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let map = TreeMap<String, Int64>()
    
    // 空TreeMap删除第一个元素
    let result1 = map.removeFirst()
    if (let Some((key, value)) <- result1) {
        println("删除了第一个元素: (${key}, ${value})")
    } else {
        println("TreeMap为空，无法删除")
    }
    
    // 添加一些元素
    map.add("cherry", 30)
    map.add("apple", 10)
    map.add("banana", 20)
    map.add("date", 40)
    
    println("\n删除前的TreeMap: ${map}")
    println("删除前的大小: ${map.size}")
    
    // 删除第一个元素（按字典序排列的第一个）
    let result2 = map.removeFirst()
    if (let Some((key, value)) <- result2) {
        println("删除了第一个元素: (${key}, ${value})")
    }
    
    println("删除后的TreeMap: ${map}")
    println("删除后的大小: ${map.size}")
    
    // 再次删除第一个元素
    let result3 = map.removeFirst()
    if (let Some((key, value)) <- result3) {
        println("再次删除了第一个元素: (${key}, ${value})")
    }
    
    println("最终的TreeMap: ${map}")
    
    return 0
}
```

运行结果：

```text
TreeMap为空，无法删除

删除前的TreeMap: [(apple, 10), (banana, 20), (cherry, 30), (date, 40)]
删除前的大小: 4
删除了第一个元素: (apple, 10)
删除后的TreeMap: [(banana, 20), (cherry, 30), (date, 40)]
删除后的大小: 3
再次删除了第一个元素: (banana, 20)
最终的TreeMap: [(cherry, 30), (date, 40)]
```

### func removeIf((K, V) -> Bool)

```cangjie
public func removeIf(predicate: (K, V) -> Bool): Unit
```

功能：传入 lambda 表达式，如果满足条件，则删除对应的键值。

参数：

- predicate: (K, V) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 传递一个 lambda 表达式进行判断。

异常：

- [ConcurrentModificationException](./collection_package_exception.md#class-concurrentmodificationexception) - 当 `predicate` 中增删或者修改 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 内键值对时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let map = TreeMap<String, Int64>()
    
    // 添加一些元素
    map.add("apple", 10)
    map.add("banana", 20)
    map.add("cherry", 30)
    map.add("date", 40)
    map.add("elderberry", 50)
    map.add("fig", 60)
    
    println("删除前的TreeMap: ${map}")
    println("删除前的大小: ${map.size}")
    
    // 删除值大于30的键值对
    map.removeIf({_: String, value: Int64 => value > 30})
    
    println("\n删除值大于30的元素后:")
    println("TreeMap: ${map}")
    println("大小: ${map.size}")
    
    // 删除键长度小于等于5的键值对
    map.removeIf({key: String, _: Int64 => key.size <= 5})
    
    println("\n删除键长度小于等于5的元素后:")
    println("TreeMap: ${map}")
    println("大小: ${map.size}")
    
    // 添加更多元素用于演示
    map.add("avocado", 15)
    map.add("blueberry", 25)
    map.add("coconut", 35)
    
    println("\n添加新元素后:")
    println("TreeMap: ${map}")
    println("大小: ${map.size}")
    
    // 删除键以'b'开头的键值对
    map.removeIf({key: String, _: Int64 => key.startsWith("b")})
    
    println("\n删除键以'b'开头的元素后:")
    println("TreeMap: ${map}")
    println("大小: ${map.size}")
    
    return 0
}
```

运行结果：

```text
删除前的TreeMap: [(apple, 10), (banana, 20), (cherry, 30), (date, 40), (elderberry, 50), (fig, 60)]
删除前的大小: 6

删除值大于30的元素后:
TreeMap: [(apple, 10), (banana, 20), (cherry, 30)]
大小: 3

删除键长度小于等于5的元素后:
TreeMap: [(banana, 20), (cherry, 30)]
大小: 2

添加新元素后:
TreeMap: [(avocado, 15), (banana, 20), (blueberry, 25), (cherry, 30), (coconut, 35)]
大小: 5

删除键以'b'开头的元素后:
TreeMap: [(avocado, 15), (cherry, 30), (coconut, 35)]
大小: 3
```

### func removeLast()

```cangjie
public func removeLast(): ?(K, V)
```

功能：删除 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 的最后一个元素。

返回值：

- ?(K, V) - 如果存在最后一个元素，那么删除该元素，用 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 封装该元素并返回；否则返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<(K, V)>.None。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let map = TreeMap<String, Int64>()
    
    // 空TreeMap删除最后一个元素
    let result1 = map.removeLast()
    if (let Some((key, value)) <- result1) {
        println("删除了最后一个元素: (${key}, ${value})")
    } else {
        println("TreeMap为空，无法删除")
    }
    
    // 添加一些元素
    map.add("cherry", 30)
    map.add("apple", 10)
    map.add("banana", 20)
    map.add("date", 40)
    
    println("\n删除前的TreeMap: ${map}")
    println("删除前的大小: ${map.size}")
    
    // 删除最后一个元素（按字典序排列的最后一个）
    let result2 = map.removeLast()
    if (let Some((key, value)) <- result2) {
        println("删除了最后一个元素: (${key}, ${value})")
    }
    
    println("删除后的TreeMap: ${map}")
    println("删除后的大小: ${map.size}")
    
    // 再次删除最后一个元素
    let result3 = map.removeLast()
    if (let Some((key, value)) <- result3) {
        println("再次删除了最后一个元素: (${key}, ${value})")
    }
    
    println("最终的TreeMap: ${map}")
    
    return 0
}
```

运行结果：

```text
TreeMap为空，无法删除

删除前的TreeMap: [(apple, 10), (banana, 20), (cherry, 30), (date, 40)]
删除前的大小: 4
删除了最后一个元素: (date, 40)
删除后的TreeMap: [(apple, 10), (banana, 20), (cherry, 30)]
删除后的大小: 3
再次删除了最后一个元素: (cherry, 30)
最终的TreeMap: [(apple, 10), (banana, 20)]
```

### func values()

```cangjie
public func values(): Collection<V>
```

功能：返回 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 中包含的值，并将所有的 value 存储在一个容器中。

返回值：

- [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<V> - 包含所有值的集合。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let map = TreeMap<String, Int64>()
    map.add("cherry", 30)
    map.add("apple", 10)
    map.add("banana", 20)
    map.add("date", 40)
    
    // 获取所有的值
    let valueCollection = map.values()
    
    println("所有的值:")
    for (value in valueCollection) {
        println("Value: ${value}")
    }
    
    // 验证值的数量
    println("\n值的数量: ${valueCollection.size}")
    println("TreeMap的大小: ${map.size}")
    
    return 0
}
```

运行结果：

```text
所有的值:
Value: 10
Value: 20
Value: 30
Value: 40

值的数量: 4
TreeMap的大小: 4
```

### operator func \[](K)

```cangjie
public operator func [](key: K): V
```

功能：运算符重载集合，如果键存在，返回键对应的值。

参数：

- key: K - 传递值进行判断。

返回值：

- V - 与键对应的值。

异常：

- [NoneValueException](../../core/core_package_api/core_package_exceptions.md#class-nonevalueexception) - 如果该 [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) 不存在该键，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let map = TreeMap<String, Int64>()
    
    // 先添加一些键值对
    map.add("apple", 10)
    map.add("banana", 20)
    map.add("cherry", 30)
    map.add("date", 40)
    
    println("TreeMap内容: ${map}")
    
    // 使用运算符重载获取值
    let appleValue = map["apple"]
    let bananaValue = map["banana"]
    let cherryValue = map["cherry"]
    
    println("\n使用[]运算符获取值:")
    println("apple的值: ${appleValue}")
    println("banana的值: ${bananaValue}")
    println("cherry的值: ${cherryValue}")
    
    // 获取所有值并计算总和
    let total = map["apple"] + map["banana"] + map["cherry"] + map["date"]
    println("\n所有值的总和: ${total}")
    
    // 尝试访问不存在的键（会抛出异常）
    println("\n尝试访问不存在的键:")
    try {
        let value = map["nonexistent"]
        println("获取到值: ${value}")
    } catch (e: Exception) {
        println("捕获异常: ${e}")
    }
    
    return 0
}
```

运行结果：

```text
TreeMap内容: [(apple, 10), (banana, 20), (cherry, 30), (date, 40)]

使用[]运算符获取值:
apple的值: 10
banana的值: 20
cherry的值: 30

所有值的总和: 100

尝试访问不存在的键:
捕获异常: NoneValueException: Value does not exist!
```

### operator func \[](K, V)

```cangjie
public operator func [](key: K, value!: V): Unit
```

功能：运算符重载集合，如果键存在，新 value 覆盖旧 value，如果键不存在，添加此键值对。

参数：

- key: K - 传递值进行判断。
- value!: V - 传递要设置的值。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let map = TreeMap<String, Int64>()
    
    // 使用运算符重载设置键值对
    map["apple"] = 10
    map["banana"] = 20
    map["cherry"] = 30
    
    println("设置后的TreeMap: ${map}")
    println("大小: ${map.size}")
    
    // 覆盖现有键的值
    map["apple"] = 15  // 覆盖原来的值10
    
    println("\n覆盖apple的值后:")
    println("TreeMap: ${map}")
    
    // 添加新的键值对
    map["date"] = 40
    map["elderberry"] = 50
    
    println("\n添加更多键值对后:")
    println("TreeMap: ${map}")
    println("大小: ${map.size}")
    
    // 再次覆盖
    map["banana"] = 25
    map["cherry"] = 35
    
    println("\n再次修改值后:")
    println("TreeMap: ${map}")
    
    return 0
}
```

运行结果：

```text
设置后的TreeMap: [(apple, 10), (banana, 20), (cherry, 30)]
大小: 3

覆盖apple的值后:
TreeMap: [(apple, 15), (banana, 20), (cherry, 30)]

添加更多键值对后:
TreeMap: [(apple, 15), (banana, 20), (cherry, 30), (date, 40), (elderberry, 50)]
大小: 5

再次修改值后:
TreeMap: [(apple, 15), (banana, 25), (cherry, 35), (date, 40), (elderberry, 50)]
```

### extend\<K, V> TreeMap\<K, V> <: Equatable\<TreeMap\<K, V>> where V <: Equatable\<V>

```cangjie
extend<K, V> TreeMap<K, V> <: Equatable<TreeMap<K, V>> where V <: Equatable<V>
```

功能：为 [TreeMap](./collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V> 类型扩展 [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TreeMap](./collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V>> 接口，支持判等操作。

父类型：

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TreeMap](./collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V>>

#### operator func !=(TreeMap\<K, V>)

```cangjie
public operator func !=(right: TreeMap<K, V>): Bool
```

功能：判断当前实例与参数指向的 [TreeMap](./collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V> 实例是否不等。

参数：

- right: [TreeMap](./collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V> - 被比较的对象。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果不等，则返回 true，否则返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建两个相同的TreeMap
    let map1 = TreeMap<String, Int64>()
    map1.add("apple", 10)
    map1.add("banana", 20)
    map1.add("cherry", 30)
    
    let map2 = TreeMap<String, Int64>()
    map2.add("apple", 10)
    map2.add("banana", 20)
    map2.add("cherry", 30)
    
    println("map1: ${map1}")
    println("map2: ${map2}")
    println("map1 != map2: ${map1 != map2}")
    
    // 创建一个不同的TreeMap
    let map3 = TreeMap<String, Int64>()
    map3.add("apple", 10)
    map3.add("banana", 20)
    map3.add("date", 40)  // 不同的键值对
    
    println("\nmap3: ${map3}")
    println("map1 != map3: ${map1 != map3}")
    
    // 创建一个键相同但值不同的TreeMap
    let map4 = TreeMap<String, Int64>()
    map4.add("apple", 15)  // 不同的值
    map4.add("banana", 20)
    map4.add("cherry", 30)
    
    println("\nmap4: ${map4}")
    println("map1 != map4: ${map1 != map4}")
    
    // 空映射与非空映射的比較
    let emptyMap = TreeMap<String, Int64>()
    println("\nemptyMap: ${emptyMap}")
    println("map1 != emptyMap: ${map1 != emptyMap}")
    
    // 两个空映射的比较
    let anotherEmptyMap = TreeMap<String, Int64>()
    println("emptyMap != anotherEmptyMap: ${emptyMap != anotherEmptyMap}")
    
    return 0
}
```

运行结果：

```text
map1: [(apple, 10), (banana, 20), (cherry, 30)]
map2: [(apple, 10), (banana, 20), (cherry, 30)]
map1 != map2: false

map3: [(apple, 10), (banana, 20), (date, 40)]
map1 != map3: true

map4: [(apple, 15), (banana, 20), (cherry, 30)]
map1 != map4: true

emptyMap: []
map1 != emptyMap: true
emptyMap != anotherEmptyMap: false
```

#### operator func ==(TreeMap\<K, V>)

```cangjie
public operator func ==(right: TreeMap<K, V>): Bool
```

功能：判断当前实例与参数指向的 [TreeMap](./collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V> 实例是否相等。

两个 [TreeMap](./collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V> 相等指的是其中包含的键值对完全相等。

参数：

- right: [TreeMap](./collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V> - 被比较的对象。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果相等，则返回 true，否则返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建两个相同的TreeMap
    let map1 = TreeMap<String, Int64>()
    map1.add("apple", 10)
    map1.add("banana", 20)
    map1.add("cherry", 30)
    
    let map2 = TreeMap<String, Int64>()
    map2.add("apple", 10)
    map2.add("banana", 20)
    map2.add("cherry", 30)
    
    println("map1: ${map1}")
    println("map2: ${map2}")
    println("map1 == map2: ${map1 == map2}")
    
    // 创建一个不同的TreeMap
    let map3 = TreeMap<String, Int64>()
    map3.add("apple", 10)
    map3.add("banana", 20)
    map3.add("date", 40)  // 不同的键值对
    
    println("\nmap3: ${map3}")
    println("map1 == map3: ${map1 == map3}")
    
    // 创建一个键相同但值不同的TreeMap
    let map4 = TreeMap<String, Int64>()
    map4.add("apple", 15)  // 不同的值
    map4.add("banana", 20)
    map4.add("cherry", 30)
    
    println("\nmap4: ${map4}")
    println("map1 == map4: ${map1 == map4}")
    
    // 创建一个空的TreeMap进行比较
    let emptyMap1 = TreeMap<String, Int64>()
    let emptyMap2 = TreeMap<String, Int64>()
    
    println("\nemptyMap1: ${emptyMap1}")
    println("emptyMap2: ${emptyMap2}")
    println("emptyMap1 == emptyMap2: ${emptyMap1 == emptyMap2}")
    println("map1 == emptyMap1: ${map1 == emptyMap1}")
    
    return 0
}
```

运行结果：

```text
map1: [(apple, 10), (banana, 20), (cherry, 30)]
map2: [(apple, 10), (banana, 20), (cherry, 30)]
map1 == map2: true

map3: [(apple, 10), (banana, 20), (date, 40)]
map1 == map3: false

map4: [(apple, 15), (banana, 20), (cherry, 30)]
map1 == map4: false

emptyMap1: []
emptyMap2: []
emptyMap1 == emptyMap2: true
map1 == emptyMap1: false
```

### extend\<K, V> TreeMap\<K, V> <: ToString where V <: ToString, K <: ToString & Comparable\<K>

```cangjie
extend<K, V> TreeMap<K, V> <: ToString where V <: ToString, K <: ToString & Comparable<K>
```

功能：为 [TreeMap](./collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V> 扩展 [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) 接口，支持转字符串操作。

父类型：

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

功能：将当前 [TreeMap](./collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V> 实例转换为字符串。

该字符串包含 [TreeMap](./collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V> 内每个键值对的字符串表示，形如："[(k1, v1), (k2, v2), (k3, v3)]"。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 转换得到的字符串。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 空映射的字符串表示
    let emptyMap = TreeMap<String, Int64>()
    println("空映射: ${emptyMap.toString()}")
    
    // 非空映射的字符串表示
    let map = TreeMap<String, Int64>()
    map.add("cherry", 30)
    map.add("apple", 10)
    map.add("banana", 20)
    
    println("非空映射: ${map.toString()}")
    
    // 直接打印（自动调用toString）
    println("直接打印: ${map}")
    
    return 0
}
```

运行结果：

```text
空映射: []
非空映射: [(apple, 10), (banana, 20), (cherry, 30)]
直接打印: [(apple, 10), (banana, 20), (cherry, 30)]
```

## class TreeSet\<T> where T <: Comparable\<T>

```cangjie
public class TreeSet<T> <: OrderedSet<T> where T <: Comparable<T> {
    public init()
    public init(elements: Collection<T>)
    public init(size: Int64, initElement: (Int64) -> T)
}
```

功能：基于 [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) 实现的 [Set](collection_package_interface.md#interface-sett) 接口的实例。

这个类的主要目的是提供一个有序的元素存储结构，它可以快速地插入、删除、查找元素。

[TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 可以用于任何需要有序元素存储的场景，例如数据库、缓存、查找表等。

父类型：

- [OrderedSet](collection_package_interface.md#interface-orderedsett)\<T>

### prop first

```cangjie
public prop first: ?T
```

功能：获取 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 的第一个元素。

类型：?T

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个空的TreeSet
    let emptySet = TreeSet<String>()
    println("空集合的first: ${emptySet.first}")
    
    // 创建一个有元素的TreeSet
    let set = TreeSet<String>()
    set.add("banana")
    set.add("apple") 
    set.add("cherry")
    
    println("有元素集合的first: ${set.first}")
    
    return 0
}
```

运行结果：

```text
空集合的first: None
有元素集合的first: Some(apple)
```

### prop last

```cangjie
public prop last: ?T
```

功能：获取 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 的最后一个元素。

类型：?T

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个空的TreeSet
    let emptySet = TreeSet<String>()
    println("空集合的last: ${emptySet.last}")
    
    // 创建一个有元素的TreeSet
    let set = TreeSet<String>()
    set.add("banana")
    set.add("apple") 
    set.add("cherry")
    
    println("有元素集合的last: ${set.last}")
    
    return 0
}
```

运行结果：

```text
空集合的last: None
有元素集合的last: Some(cherry)
```

### prop size

```cangjie
public prop size: Int64
```

功能：返回元素的个数。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个空的TreeSet
    let emptySet = TreeSet<String>()
    println("空集合的size: ${emptySet.size}")
    
    // 创建一个有元素的TreeSet
    let set = TreeSet<String>()
    set.add("banana")
    set.add("apple") 
    set.add("cherry")
    
    println("有元素集合的size: ${set.size}")
    
    return 0
}
```

运行结果：

```text
空集合的size: 0
有元素集合的size: 3
```

### init()

```cangjie
public init()
```

功能：构造一个空的 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 使用无参构造函数创建空的TreeSet
    let set = TreeSet<String>()
    println("初始化后的size: ${set.size}")
    
    // 添加元素
    set.add("hello")
    set.add("world")
    println("添加元素后的size: ${set.size}")
    
    return 0
}
```

运行结果：

```text
初始化后的size: 0
添加元素后的size: 2
```

### init(Collection\<T>)

```cangjie
public init(elements: Collection<T>)
```

功能：通过传入的元素集合构造一个 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)。

按照 elements 的迭代器顺序将元素插入到 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 内，由于 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 中不允许出现相同的元素，如果 elements 中有多个相同的元素时，[TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 只会保留一个元素。

参数：

- elements: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - 初始化该 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 的元素集合。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建一个数组作为初始化元素
    let arr = ["apple", "banana", "cherry", "apple", "banana"] // 包含重复元素
    
    // 使用Collection构造函数创建集合
    let set = TreeSet<String>(arr)
    println("集合的size: ${set.size}")
    println("集合的内容: ${set}")
    
    return 0
}
```

运行结果：

```text
集合的size: 3
集合的内容: [apple, banana, cherry]
```

### init(Int64, (Int64) -> T)

```cangjie
public init(size: Int64, initElement: (Int64) -> T)
```

功能：通过传入的元素个数 size 和函数规则来构造 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)。

参数：

- size: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 传入的元素个数。
- initElement: ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) -> T - 初始化该 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 的函数规则。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果 size 小于 0 则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 使用size和函数规则构造TreeSet
    let set = TreeSet<String>(5, {i => "item${i}"})
    println("TreeSet的size: ${set.size}")
    println("TreeSet的内容: ${set}")
    
    return 0
}
```

运行结果：

```text
TreeSet的size: 5
TreeSet的内容: [item0, item1, item2, item3, item4]
```

### static func of(Array\<T>)

```cangjie
public static func of(elements: Array<T>): TreeSet<T>
```

功能：构造一个包含指定数组中所有元素的 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)。

按照 elements 的先后顺序将元素插入到 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 内，由于 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 中不允许出现相同的元素，如果 elements 中有多个相同的元素时，[TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 只会保留一个元素。

参数：

- elements: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - 传入数组，变长参数语法支持参数省略数组字面量的 `[]` 。

返回值：

- [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> - 元素为 T 类型的 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)。

> **说明：**
>
> 此函数的参数可使用变长参数方式提供，例如： `TreeSet.of(1, 2, 3)` 等价于 `TreeSet.of([1, 2, 3])` 。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 使用静态方法of创建集合
    let arr = ["banana", "apple", "cherry", "apple", "banana"] // 包含重复元素
    let set = TreeSet.of(arr)
    
    println("原数组长度: ${arr.size}")
    println("集合的size: ${set.size}")
    println("集合的内容: ${set}")
    
    return 0
}
```

运行结果：

```text
原数组长度: 5
集合的size: 3
集合的内容: [apple, banana, cherry]
```

### func add(Collection\<T>)

```cangjie
public func add(all!: Collection<T>): Unit
```

功能：添加 [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont) 中的所有元素至此 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 中，如果元素存在，则不添加。

参数：

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - 需要被添加的元素的集合。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let set = TreeSet<String>()
    set.add("apple")
    println("初始集合: ${set}")
    
    // 创建一个要添加的集合
    let toAdd = ["banana", "cherry", "apple", "date"]
    set.add(all: toAdd)
    
    println("添加集合后: ${set}")
    println("集合大小: ${set.size}")
    
    return 0
}
```

运行结果：

```text
初始集合: [apple]
添加集合后: [apple, banana, cherry, date]
集合大小: 4
```

### func add(T)

```cangjie
public func add(element: T): Bool
```

功能：将新的元素放入 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 中。若添加的元素在 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 中存在, 则添加失败。

参数：

- element: T - 指定的元素。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果添加成功，则返回 true；否则，返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let set = TreeSet<String>()
    
    // 添加新元素，返回true
    let result1 = set.add("apple")
    println("添加'apple': ${result1}")
    println("当前集合: ${set}")
    
    // 尝试添加已存在的元素，返回false
    let result2 = set.add("apple")
    println("再次添加'apple': ${result2}")
    println("当前集合: ${set}")
    
    // 添加更多元素
    set.add("banana")
    set.add("cherry")
    println("最终集合: ${set}")
    
    return 0
}
```

运行结果：

```text
添加'apple': true
当前集合: [apple]
再次添加'apple': false
当前集合: [apple]
最终集合: [apple, banana, cherry]
```

### func all((T) -> Bool)

```cangjie
public func all(predicate: (T) -> Bool): Bool
```

功能：判断 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 中所有元素是否都满足条件。

参数：

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 中所有元素都满足条件，返回 true，否则返回 false

### func any((T) -> Bool)

```cangjie
public func any(predicate: (T) -> Bool): Bool
```

功能：判断 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 是否存在任意一个满足条件的元素。

参数：

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 是否存在任意满足条件的元素。

### func backward(T, Bool)

```cangjie
public func backward(mark: T, inclusive!: Bool = true): Iterator<T>
```

功能：获取从第一个键小于等于 mark 的节点按降序遍历到 [first](./collection_package_class.md#prop-first-4) 的迭代器。如果该节点的键等于 mark ，那么根据 `inclusive!` 确定是否包含该键对应的节点。

参数：

- mark: T - 用于确定从哪里开始的元素。
- inclusive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 当 `mark` 是迭代器的首个元素时，指定是否包含 mark 作为起始点，默认为 `true`。

返回值：

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - 对应元素的迭代器。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let set = TreeSet<String>()
    set.add("apple")
    set.add("banana") 
    set.add("cherry")
    set.add("date")
    set.add("elderberry")
    
    println("完整集合: ${set}")
    
    // 从"cherry"开始向前遍历（包含cherry）
    println("从cherry开始反向遍历（包含）:")
    for (item in set.backward("cherry", inclusive: true)) {
        println("  ${item}")
    }
    
    // 从"cherry"开始向前遍历（不包含cherry）
    println("从cherry开始反向遍历（不包含）:")
    for (item in set.backward("cherry", inclusive: false)) {
        println("  ${item}")
    }
    
    return 0
}
```

运行结果：

```text
完整集合: [apple, banana, cherry, date, elderberry]
从cherry开始反向遍历（包含）:
  cherry
  banana
  apple
从cherry开始反向遍历（不包含）:
  banana
  apple
```

### func clear()

```cangjie
public func clear(): Unit
```

功能：清除所有元素。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let set = TreeSet<String>()
    set.add("apple")
    set.add("banana") 
    set.add("cherry")
    
    println("清除前的集合: ${set}")
    println("清除前的size: ${set.size}")
    
    // 清除所有元素
    set.clear()
    
    println("清除后的集合: ${set}")
    println("清除后的size: ${set.size}")
    println("集合是否为空: ${set.isEmpty()}")
    
    return 0
}
```

运行结果：

```text
清除前的集合: [apple, banana, cherry]
清除前的size: 3
清除后的集合: []
清除后的size: 0
集合是否为空: true
```

### func clone()

```cangjie
public func clone(): TreeSet<T>
```

功能：克隆 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)。

返回值：

- [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> - 返回一个 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 实例。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let originalSet = TreeSet<String>()
    originalSet.add("apple")
    originalSet.add("banana") 
    originalSet.add("cherry")
    
    println("原集合: ${originalSet}")
    
    // 克隆集合
    let clonedSet = originalSet.clone()
    println("克隆的集合: ${clonedSet}")
    
    // 修改原集合，验证克隆的独立性
    originalSet.add("date")
    clonedSet.add("elderberry")
    
    println("修改后的原集合: ${originalSet}")
    println("修改后的克隆集合: ${clonedSet}")
    
    return 0
}
```

运行结果：

```text
原集合: [apple, banana, cherry]
克隆的集合: [apple, banana, cherry]
修改后的原集合: [apple, banana, cherry, date]
修改后的克隆集合: [apple, banana, cherry, elderberry]
```

### func contains(Collection\<T>)

```cangjie
public func contains(all!: Collection<T>): Bool
```

功能：判断 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 是否包含指定 [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont) 中的所有元素。

参数：

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - 指定的元素集合。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果此 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 包含 [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont) 中的所有元素，则返回 true；否则，返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let set = TreeSet<String>()
    set.add("apple")
    set.add("banana") 
    set.add("cherry")
    set.add("date")
    
    println("主集合: ${set}")
    
    // 创建要检查的集合
    let checkSet1 = ["apple", "banana"]
    let checkSet2 = ["apple", "elderberry"]
    let checkSet3 = ["fig", "grape"]
    
    println("包含所有['apple', 'banana']: ${set.contains(all: checkSet1)}")
    println("包含所有['apple', 'elderberry']: ${set.contains(all: checkSet2)}")
    println("包含所有['fig', 'grape']: ${set.contains(all: checkSet3)}")
    
    return 0
}
```

运行结果：

```text
主集合: [apple, banana, cherry, date]
包含所有['apple', 'banana']: true
包含所有['apple', 'elderberry']: false
包含所有['fig', 'grape']: false
```

### func contains(T)

```cangjie
public func contains(element: T): Bool
```

功能：判断是否包含指定元素。

参数：

- element: T - 指定的元素。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果包含指定元素，则返回 true；否则，返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let set = TreeSet<String>()
    set.add("apple")
    set.add("banana") 
    set.add("cherry")
    
    println("集合内容: ${set}")
    
    // 检查存在的元素
    println("包含'apple': ${set.contains("apple")}")
    println("包含'banana': ${set.contains("banana")}")
    
    // 检查不存在的元素
    println("包含'date': ${set.contains("date")}")
    println("包含'elderberry': ${set.contains("elderberry")}")
    
    return 0
}
```

运行结果：

```text
集合内容: [apple, banana, cherry]
包含'apple': true
包含'banana': true
包含'date': false
包含'elderberry': false
```

### func filter((T) -> Bool)
```cangjie
public func filter(predicate: (T) -> Bool): TreeSet<T>
```

功能： 返回一个满足筛选条件的元素的新 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T>。

参数：

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> - 返回一个满足筛选条件的元素的新集合。

### func filterMap\<R>((T) -> Option<R>)

```cangjie
public func filterMap<R>(transform: (T) -> Option<R>): TreeSet<R> where R <: Comparable<R>
```

功能：同时进行筛选操作和映射操作，返回一个新 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)。

参数：

- transform: (T) -> Option<R> - 给定的映射函数。函数返回值为 Some 对应 filter 的 predicate 为 true，反之表示 false。

返回值：

- [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<R> - 返回一个筛选和映射后的新 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)。

### func fold\<R>(R, (R, T) -> R)

```cangjie
public func fold<R>(initial: R, operation: (R, T) -> R): R
```

功能：使用指定初始值，从左向右计算。

参数：

- initial: R - 给定的 R 类型的初始值。
- operation: (R, T) -> R - 给定的计算函数。

返回值：

- R - 返回最终计算得到的值。

### func forEach((T) -> Unit)

```cangjie
public func forEach(action: (T) -> Unit): Unit
```

功能：遍历所有元素，执行给定的操作。

参数：

- action: (T) -> [Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - 给定的操作函数。

### func forward(T, Bool)

```cangjie
public func forward(mark: T, inclusive!: Bool = true): Iterator<T>
```

功能：获取从第一个元素大于等于 mark 的节点按升序遍历到 [last](./collection_package_class.md#prop-last-3) 结束的一个迭代器。如果该节点的元素等于 mark ，那么根据 `inclusive!` 确定是否包含该元素对应的节点。

参数：

- mark: T - 用于确定从哪里开始的元素。
- inclusive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 当 `mark` 是迭代器的首个元素时，指定是否包含 mark 作为起始点，默认为 `true`。

返回值：

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - 对应元素的迭代器。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let set = TreeSet<String>()
    set.add("apple")
    set.add("banana") 
    set.add("cherry")
    set.add("date")
    set.add("elderberry")
    
    println("完整集合: ${set}")
    
    // 从"cherry"开始向后遍历（包含cherry）
    println("从cherry开始正向遍历（包含）:")
    for (item in set.forward("cherry", inclusive: true)) {
        println("  ${item}")
    }
    
    // 从"cherry"开始向后遍历（不包含cherry）
    println("从cherry开始正向遍历（不包含）:")
    for (item in set.forward("cherry", inclusive: false)) {
        println("  ${item}")
    }
    
    return 0
}
```

运行结果：

```text
完整集合: [apple, banana, cherry, date, elderberry]
从cherry开始正向遍历（包含）:
  cherry
  date
  elderberry
从cherry开始正向遍历（不包含）:
  date
  elderberry
```

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

功能：判断 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 是否为空。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果为空，返回 true，否则返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    // 创建空集合
    let emptySet = TreeSet<String>()
    println("空集合是否为空: ${emptySet.isEmpty()}")
    
    // 创建非空集合
    let nonEmptySet = TreeSet<String>()
    nonEmptySet.add("apple")
    println("非空集合是否为空: ${nonEmptySet.isEmpty()}")
    
    // 清空集合后再检查
    nonEmptySet.clear()
    println("清空后集合是否为空: ${nonEmptySet.isEmpty()}")
    
    return 0
}
```

运行结果：

```text
空集合是否为空: true
非空集合是否为空: false
清空后集合是否为空: true
```

### func iterator()

```cangjie
public func iterator(): Iterator<T>
```

功能：返回 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 的迭代器，迭代器按元素值从小到大的顺序迭代。

返回值：

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 的迭代器。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let set = TreeSet<String>()
    set.add("cherry")
    set.add("apple") 
    set.add("banana")
    set.add("date")
    
    println("集合内容: ${set}")
    println("使用iterator遍历:")
    
    // 使用iterator遍历
    for (item in set.iterator()) {
        println("  ${item}")
    }
    
    return 0
}
```

运行结果：

```text
集合内容: [apple, banana, cherry, date]
使用iterator遍历:
  apple
  banana
  cherry
  date
```

### func map\<R>((T)->R)

```cangjie
public func map<R>(transform: (T) -> R): TreeSet<R> where R <: Comparable<R>
```

功能：将当前 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 内所有 T 类型元素根据 transform 映射为 R 类型的元素，组成新的 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)。

参数：

- transform: (T)->R - 映射函数。

返回值：

- [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<R> - 原 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 中所有元素映射后得到的元素组成的新 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)。

### func none((T) -> Bool)

```cangjie
public func none(predicate: (T) -> Bool): Bool
```

功能：判断 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 中所有元素是否都不满足条件。

参数：

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 给定的条件。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 当前 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 中元素是否都不满足条件。

### func reduce((T, T) -> T)

```cangjie
public func reduce(operation: (T, T) -> T): Option<T>
```

功能：使用第一个元素作为初始值，从左向右计算。

参数：

- operation: (T, T) -> T - 给定的计算函数。

返回值：

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - 返回计算结果。

### func remove(Collection\<T>)

```cangjie
public func remove(all!: Collection<T>): Unit
```

功能：移除此 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 中那些也包含在指定 [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont) 中的所有元素。

参数：

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - 需要从此[TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 中移除的元素的集合。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let set = TreeSet<String>()
    set.add("apple")
    set.add("banana")
    set.add("cherry")
    set.add("date")
    set.add("elderberry")
    
    println("初始集合: ${set}")
    
    // 创建要删除的元素集合
    let toRemove = ["banana", "date", "fig"] // "fig"不存在于原集合中
    
    // 删除集合中的元素
    set.remove(all: toRemove)
    
    println("删除元素后的集合: ${set}")
    
    return 0
}
```

运行结果：

```text
初始集合: [apple, banana, cherry, date, elderberry]
删除元素后的集合: [apple, cherry, elderberry]
```

### func remove(T)

```cangjie
public func remove(element: T): Bool
```

功能：如果指定元素存在于此 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 中，则将其移除。

参数：

- element: T - 需要被移除的元素。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true，表示移除成功；false，表示移除失败。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let set = TreeSet<String>()
    set.add("apple")
    set.add("banana")
    set.add("cherry")
    
    println("初始集合: ${set}")
    
    // 删除存在的元素，返回true
    let result1 = set.remove("banana")
    println("删除'banana': ${result1}")
    println("删除后的集合: ${set}")
    
    // 删除不存在的元素，返回false
    let result2 = set.remove("date")
    println("删除'date': ${result2}")
    println("删除后的集合: ${set}")
    
    return 0
}
```

运行结果：

```text
初始集合: [apple, banana, cherry]
删除'banana': true
删除后的集合: [apple, cherry]
删除'date': false
删除后的集合: [apple, cherry]
```

### func removeFirst()

```cangjie
public func removeFirst(): ?T
```

功能：删除 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 的第一个元素。

返回值：

- ?T - 如果存在第一个元素，那么删除该元素，用 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 封装该元素并返回；否则返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T>.None。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let set = TreeSet<String>()
    set.add("cherry")
    set.add("apple") 
    set.add("banana")
    set.add("date")
    
    println("原始集合: ${set}")
    
    // 删除第一个元素
    let first = set.removeFirst()
    println("删除的第一个元素: ${first}")
    println("删除后的集合: ${set}")
    
    // 再次删除第一个元素
    let second = set.removeFirst()
    println("删除的第二个元素: ${second}")
    println("再次删除后的集合: ${set}")
    
    return 0
}
```

运行结果：

```text
原始集合: [apple, banana, cherry, date]
删除的第一个元素: Some(apple)
删除后的集合: [banana, cherry, date]
删除的第二个元素: Some(banana)
再次删除后的集合: [cherry, date]
```

### func removeIf((T) -> Bool)

```cangjie
public func removeIf(predicate: (T) -> Bool): Unit
```

功能：传入 lambda 表达式，如果满足 `true` 条件，则删除对应的元素。

参数：

- predicate: (T) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 是否删除元素的判断条件。

异常：

- [ConcurrentModificationException](./collection_package_exception.md#class-concurrentmodificationexception) - 当 `predicate` 中增删或者修改 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 内元素时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let set = TreeSet<String>()
    set.add("apple")
    set.add("banana")
    set.add("cherry")
    set.add("date")
    set.add("elderberry")
    
    println("初始集合: ${set}")
    
    // 删除长度大于5的元素
    set.removeIf({s => s.size > 5})
    
    println("删除长度大于5的元素后: ${set}")
    
    return 0
}
```

运行结果：

```text
初始集合: [apple, banana, cherry, date, elderberry]
删除长度大于5的元素后: [apple, date]
```

### func removeLast()

```cangjie
public func removeLast(): ?T
```

功能：删除 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 的最后一个元素。

返回值：

- ?T - 如果存在最后一个元素，那么删除该元素，用 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) 封装该元素并返回；否则返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T>.None。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let set = TreeSet<String>()
    set.add("cherry")
    set.add("apple") 
    set.add("banana")
    set.add("date")
    
    println("原始集合: ${set}")
    
    // 删除最后一个元素
    let last = set.removeLast()
    println("删除的最后一个元素: ${last}")
    println("删除后的集合: ${set}")
    
    // 再次删除最后一个元素
    let secondLast = set.removeLast()
    println("删除的倒数第二个元素: ${secondLast}")
    println("再次删除后的集合: ${set}")
    
    return 0
}
```

运行结果：

```text
原始集合: [apple, banana, cherry, date]
删除的最后一个元素: Some(date)
删除后的集合: [apple, banana, cherry]
删除的倒数第二个元素: Some(cherry)
再次删除后的集合: [apple, banana]
```

### func retain(Set\<T>)

```cangjie
public func retain(all!: Set<T>): Unit
```

功能：从此 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 中保留 [Set](collection_package_interface.md#interface-sett) 中的元素，其他元素将被移除。

参数：

- all!: [Set](collection_package_interface.md#interface-sett)\<T> - 需要保留的 [Set](collection_package_interface.md#interface-sett)。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let set = TreeSet<String>()
    set.add("apple")
    set.add("banana")
    set.add("cherry")
    set.add("date")
    set.add("elderberry")
    
    println("初始集合: ${set}")
    
    // 创建要保留的元素集合
    let toRetain = TreeSet.of(["banana", "date", "fig"]) // "fig"不存在于原集合中
    
    // 保留指定集合中的元素
    set.retain(all: toRetain)
    
    println("保留元素后的集合: ${set}")
    
    return 0
}
```

运行结果：

```text
初始集合: [apple, banana, cherry, date, elderberry]
保留元素后的集合: [banana, date]
```

### func subsetOf(ReadOnlySet\<T>)

```cangjie
public func subsetOf(other: ReadOnlySet<T>): Bool
```

功能：检查该集合是否为其他 [ReadOnlySet](collection_package_interface.md#interface-readonlysett) 的子集。

参数：

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - 传入集合，此函数将判断当前集合是否为 other 的子集。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) 是指定 [ReadOnlySet](collection_package_interface.md#interface-readonlysett) 的子集，则返回 true；否则返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let set1 = TreeSet<String>()
    set1.add("apple")
    set1.add("banana")
    
    let set2 = TreeSet<String>()
    set2.add("apple")
    set2.add("banana")
    set2.add("cherry")
    set2.add("date")
    
    println("集合1: ${set1}")
    println("集合2: ${set2}")
    
    // 检查set1是否为set2的子集
    let result1 = set1.subsetOf(set2)
    println("set1是set2的子集: ${result1}")
    
    // 检查set2是否为set1的子集
    let result2 = set2.subsetOf(set1)
    println("set2是set1的子集: ${result2}")
    
    // 检查空集是否为set1的子集
    let emptySet = TreeSet<String>()
    let result3 = emptySet.subsetOf(set1)
    println("空集是set1的子集: ${result3}")
    
    return 0
}
```

运行结果：

```text
集合1: [apple, banana]
集合2: [apple, banana, cherry, date]
set1是set2的子集: true
set2是set1的子集: false
空集是set1的子集: true
```

### func toArray()

```cangjie
public func toArray(): Array<T>
```

功能：返回一个包含容器内所有元素的数组。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - T 类型数组。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let set = TreeSet<String>()
    set.add("apple")
    set.add("banana")
    set.add("cherry")
    set.add("date")
    
    println("TreeSet内容: ${set}")
    
    // 转换为数组
    let array = set.toArray()
    
    println("转换后的数组: ${array}")
    println("数组长度: ${array.size}")
    
    // 遍历数组
    println("数组元素:")
    for (item in array) {
        println("  ${item}")
    }
    
    return 0
}
```

运行结果：

```text
TreeSet内容: [apple, banana, cherry, date]
转换后的数组: [apple, banana, cherry, date]
数组长度: 4
数组元素:
  apple
  banana
  cherry
  date
```

### operator func &(ReadOnlySet\<T>)

```cangjie
public operator func &(other: ReadOnlySet<T>): TreeSet<T>
```

功能：返回包含两个集合交集的元素的新集合。

参数：

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - 传入集合。

返回值：

- [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> - T 类型集合。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let set1 = TreeSet<String>()
    set1.add("apple")
    set1.add("banana")
    set1.add("cherry")
    
    let set2 = TreeSet<String>()
    set2.add("banana")
    set2.add("cherry")
    set2.add("date")
    set2.add("elderberry")
    
    println("集合1: ${set1}")
    println("集合2: ${set2}")
    
    // 计算两个集合的交集
    let intersection = set1 & set2
    
    println("交集结果: ${intersection}")
    
    return 0
}
```

运行结果：

```text
集合1: [apple, banana, cherry]
集合2: [banana, cherry, date, elderberry]
交集结果: [banana, cherry]
```

### operator func -(ReadOnlySet\<T>)

```cangjie
public operator func -(other: ReadOnlySet<T>): TreeSet<T>
```

功能：返回包含两个集合差集的元素的新集合。

参数：

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - 传入集合。

返回值：

- [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> - T 类型集合。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let set1 = TreeSet<String>()
    set1.add("apple")
    set1.add("banana")
    set1.add("cherry")
    
    let set2 = TreeSet<String>()
    set2.add("banana")
    set2.add("cherry")
    set2.add("date")
    set2.add("elderberry")
    
    println("集合1: ${set1}")
    println("集合2: ${set2}")
    
    // 计算两个集合的差集 (set1 - set2)
    let difference = set1 - set2
    
    println("差集结果 (set1 - set2): ${difference}")
    
    // 计算两个集合的差集 (set2 - set1)
    let difference2 = set2 - set1
    
    println("差集结果 (set2 - set1): ${difference2}")
    
    return 0
}
```

运行结果：

```text
集合1: [apple, banana, cherry]
集合2: [banana, cherry, date, elderberry]
差集结果 (set1 - set2): [apple]
差集结果 (set2 - set1): [date, elderberry]
```

### operator func |(ReadOnlySet\<T>)

```cangjie
public operator func |(other: ReadOnlySet<T>): TreeSet<T>
```

功能：返回包含两个集合并集的元素的新集合。

参数：

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - 传入集合。

返回值：

- [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> - T 类型集合。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let set1 = TreeSet<String>()
    set1.add("apple")
    set1.add("banana")
    set1.add("cherry")
    
    let set2 = TreeSet<String>()
    set2.add("banana")
    set2.add("cherry")
    set2.add("date")
    set2.add("elderberry")
    
    println("集合1: ${set1}")
    println("集合2: ${set2}")
    
    // 计算两个集合的并集
    let union = set1 | set2
    
    println("并集结果: ${union}")
    
    return 0
}
```

运行结果：

```text
集合1: [apple, banana, cherry]
集合2: [banana, cherry, date, elderberry]
并集结果: [apple, banana, cherry, date, elderberry]
```

### extend\<T> TreeSet\<T> <: Equatable\<TreeSet\<T>>

```cangjie
extend<T> TreeSet<T> <: Equatable<TreeSet<T>>
```

功能：为 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> 类型扩展 [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T>> 接口，支持判等操作。

父类型：

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T>>

#### operator func !=(TreeSet\<T>)

```cangjie
public operator func !=(that: TreeSet<T>): Bool
```

功能：判断当前实例与参数指向的 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> 实例是否不等。

参数：

- that: [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> - 被比较的对象。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果不等，则返回 true，否则返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let set1 = TreeSet<String>()
    set1.add("apple")
    set1.add("banana")
    set1.add("cherry")
    
    let set2 = TreeSet<String>()
    set2.add("apple")
    set2.add("banana")
    set2.add("cherry")
    
    let set3 = TreeSet<String>()
    set3.add("apple")
    set3.add("banana")
    set3.add("date")
    
    println("集合1: ${set1}")
    println("集合2: ${set2}")
    println("集合3: ${set3}")
    
    // 比较不相等的集合
    let result1 = set1 != set3
    println("set1 != set3: ${result1}")
    
    // 比较相等的集合
    let result2 = set1 != set2
    println("set1 != set2: ${result2}")
    
    // 比较自身
    let result3 = set1 != set1
    println("set1 != set1: ${result3}")
    
    return 0
}
```

运行结果：

```text
集合1: [apple, banana, cherry]
集合2: [apple, banana, cherry]
集合3: [apple, banana, date]
set1 != set3: true
set1 != set2: false
set1 != set1: false
```

#### operator func ==(TreeSet\<T>)

```cangjie
public operator func ==(that: TreeSet<T>): Bool
```

功能：判断当前实例与参数指向的 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> 实例是否相等。

两个 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> 相等指的是其中包含的元素完全相等。

参数：

- that: [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> - 被比较的对象。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果相等，则返回 true，否则返回 false。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let set1 = TreeSet<String>()
    set1.add("apple")
    set1.add("banana")
    set1.add("cherry")
    
    let set2 = TreeSet<String>()
    set2.add("apple")
    set2.add("banana")
    set2.add("cherry")
    
    let set3 = TreeSet<String>()
    set3.add("apple")
    set3.add("banana")
    set3.add("date")
    
    println("集合1: ${set1}")
    println("集合2: ${set2}")
    println("集合3: ${set3}")
    
    // 比较相等的集合
    let result1 = set1 == set2
    println("set1 == set2: ${result1}")
    
    // 比较不相等的集合
    let result2 = set1 == set3
    println("set1 == set3: ${result2}")
    
    // 比较自身
    let result3 = set1 == set1
    println("set1 == set1: ${result3}")
    
    return 0
}
```

运行结果：

```text
集合1: [apple, banana, cherry]
集合2: [apple, banana, cherry]
集合3: [apple, banana, date]
set1 == set2: true
set1 == set3: false
set1 == set1: true
```

### extend\<T> TreeSet\<T> <: ToString where T <: ToString

```cangjie
extend<T> TreeSet<T> <: ToString where T <: ToString
```

功能：为 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> 扩展 [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) 接口，支持转字符串操作。

父类型：

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

功能：将当前 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> 实例转换为字符串。

该字符串包含 [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> 内每个元素的字符串表示，形如："[elem1, elem2, elem3]"。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 转换得到的字符串。

示例：

<!-- verify -->
```cangjie
import std.collection.*

main() {
    let set = TreeSet<String>()
    set.add("apple")
    set.add("banana")
    set.add("cherry")
    
    println("TreeSet内容: ${set}")
    
    // 转换为字符串
    let str = set.toString()
    
    println("转换后的字符串: ${str}")
    
    // 空集合的字符串表示
    let emptySet = TreeSet<String>()
    let emptyStr = emptySet.toString()
    
    println("空集合的字符串: ${emptyStr}")
    
    return 0
}
```

运行结果：

```text
TreeSet内容: [apple, banana, cherry]
转换后的字符串: [apple, banana, cherry]
空集合的字符串: []
```
