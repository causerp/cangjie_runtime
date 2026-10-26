# ConcurrentLinkedQueue 使用示例

示例：

<!-- verify -->
```cangjie
import std.collection.concurrent.*

main() {
    let threads = 8
    let total: Int64 = 128

    // 创建队列并初始化128个元素
    let queue = ConcurrentLinkedQueue<Int64>(Array<Int64>(total, {i => i}))
    println("初始大小: ${queue.size}")

    // 启动8个线程并发出队
    let jobs = Array<Future<Unit>>(threads, repeat: unsafe { zeroValue<Future<Unit>>() })
    for (t in 0..threads) {
        jobs[t] = spawn {
            for (i in t..total : threads) {
                queue.dequeue()
            }
        }
    }

    // 等待所有线程完成
    for (t in 0..threads) {
        jobs[t].get()
    }

    println("出队后大小: ${queue.size}")
}
```

运行结果：

```text
初始大小: 128
出队后大小: 0
```
