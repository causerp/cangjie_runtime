# WeakRef for Caching

The following demonstrates a cache implementation using `WeakRef`. Suppose a certain computation is very time-consuming, and we want to cache its results while avoiding excessive caching that could lead to OOM (Out of Memory). In such cases, weak references can be employed.

<!-- verify -->
```cangjie
import std.ref.{WeakRef, CleanupPolicy}

public interface Cacheable<T> {
    static func reCalculate() : T
}

public class Data <: Cacheable<Data> {
    public var number: Int64

    init(n : Int64) {
                number = n
    }

    public static func reCalculate(): Data {
        // Simulate computation
        println("re-calculations!")
        let data = Data(321)
        return data
    }
}

public class Cache<T> where T <: Object & Cacheable<T> {
    private var cache : WeakRef<T>

    public init(data: T) {
        cache = WeakRef<T>(data, CleanupPolicy.DEFERRED) // Here we choose the DEFERRED policy because we want Data to persist as long as possible.
    }

    public func getData(): T {
        match(cache.value) {
            case Some(x) => x
            case None =>
                // If GC has cleared the cached data, recompute
                let data = T.reCalculate()
                cache = WeakRef<T>(data, CleanupPolicy.DEFERRED)
                data
        }
    }

    public func clear() : Unit {
        cache.clear()
    }
}

main () {
    let data = Data(123)
    var c = Cache<Data>(data)
    println(c.getData().number) // Directly read from cache, no recomputation needed
    println(c.getData().number) // Directly read from cache, no recomputation needed
    c.clear()                   // Clear cache
    println(c.getData().number) // Recompute
    return 0
}
```

Execution results:

```text
123
123
re-calculations!
321
```