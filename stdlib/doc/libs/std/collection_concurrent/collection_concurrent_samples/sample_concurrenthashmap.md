# ConcurrentHashMap 使用示例

示例：

<!-- verify -->
```cangjie
import std.collection.concurrent.*

main() {
    let threads = 8
    let M = 1024

    // 创建并发映射，并发级别为64
    let map = ConcurrentHashMap<Int64, Int64>(concurrencyLevel: 64)

    // 启动8个线程并发写入
    let jobs = Array<Future<Unit>>(threads, repeat: unsafe { zeroValue<Future<Unit>>() })
    for (t in 0..threads) {
        jobs[t] = spawn {
            for (i in t..M : threads) {
                map.put(i, i + 3)
            }
        }
    }

    for (t in 0..threads) {
        jobs[t].get()
    }

    println("写入后大小: ${map.size}")

    // 启动8个线程并发条件删除（删除值为偶数的键值对）
    for (t in 0..threads) {
        jobs[t] = spawn {
            for (i in t..M : threads) {
                map.remove(i, {v => v % 2 == 0})
            }
        }
    }

    for (t in 0..threads) {
        jobs[t].get()
    }

    println("条件删除后大小: ${map.size}")

    // 启动8个线程并发删除所有元素
    for (t in 0..threads) {
        jobs[t] = spawn {
            for (i in t..M : threads) {
                map.remove(i)
            }
        }
    }

    for (t in 0..threads) {
        jobs[t].get()
    }

    println("全部删除后大小: ${map.size}")
}
```

运行结果：

```text
写入后大小: 1024
条件删除后大小: 512
全部删除后大小: 0
```
