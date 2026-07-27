# WeakRef 用于缓存

以下使用 `WeakRef` 实现了一个缓存，假设某个数据的计算非常耗时，我们希望将其计算结果缓存起来，但又不希望过量缓存导致 OOM ，那么我们可以使用弱引用。

示例：

<!-- verify -->
```cangjie
import std.ref.{WeakRef, CleanupPolicy}

public interface Cacheable<T> {
    static func reCalculate(): T
}

public class Data <: Cacheable<Data> {
    public var number: Int64

    init(number: Int64) {
        this.number = number
    }

    public static func reCalculate(): Data {
        // 模拟重新运算
        println("re-calculations!")
        let data = Data(321)
        return data
    }
}

public class Cache<T> where T <: Object & Cacheable<T> {
    private var cache: WeakRef<T>

    public init(data: T) {
        // 选用 DEFERRED 策略，让缓存的数据尽量保存得更久
        cache = WeakRef<T>(data, CleanupPolicy.DEFERRED)
    }

    public func getData(): T {
        match (cache.value) {
            case Some(x) => x
            case None =>
                // 如果 GC 释放了缓存中的数据则重新运算
                let data = T.reCalculate()
                cache = WeakRef<T>(data, CleanupPolicy.DEFERRED)
                data
        }
    }

    public func clear(): Unit {
        cache.clear()
    }
}

main() {
    let data = Data(123)
    var cache = Cache<Data>(data)

    // 直接从缓存中读取数据，不需要重新运算
    println("第一次读取: ${cache.getData().number}")

    // 直接从缓存中读取数据，不需要重新运算
    println("第二次读取: ${cache.getData().number}")

    // 清空缓存
    cache.clear()

    // 缓存被清空后需要重新运算
    println("清空后读取: ${cache.getData().number}")
    return 0
}
```

运行结果：

```text
第一次读取: 123
第二次读取: 123
re-calculations!
清空后读取: 321
```
