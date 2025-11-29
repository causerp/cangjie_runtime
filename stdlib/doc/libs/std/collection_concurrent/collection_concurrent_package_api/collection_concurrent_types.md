# 类型别名

## type BlockingQueue\<E> <sup>(deprecated)</sup>

```cangjie
public type BlockingQueue<E> = LinkedBlockingQueue<E>
```

功能：[LinkedBlockingQueue](../collection_concurrent_package_api/collection_concurrent_class.md#class-linkedblockingqueuee)\<E> 的别名。

> **注意：**
>
> 未来版本即将废弃，使用 [LinkedBlockingQueue](./collection_concurrent_class.md#class-linkedblockingqueuee)\<E> 替代。

示例：

<!-- verify -->
```cangjie
import std.collection.concurrent.*

main() {
    let bq: BlockingQueue<Int64> = BlockingQueue<Int64>(5)
    println("队列容量: ${bq.capacity}")
}
```

运行结果：

```text
队列容量: 5
```

## type NonBlockingQueue\<E> <sup>(deprecated)</sup>

```cangjie
public type NonBlockingQueue<E> = ConcurrentLinkedQueue<E>
```

功能：[ConcurrentLinkedQueue](../collection_concurrent_package_api/collection_concurrent_class.md#class-concurrentlinkedqueuee)\<E> 的别名。

> **注意：**
>
> 未来版本即将废弃，使用 [ConcurrentLinkedQueue](../collection_concurrent_package_api/collection_concurrent_class.md#class-concurrentlinkedqueuee)\<E> 替代。

示例：

<!-- verify -->
```cangjie
import std.collection.concurrent.*

main() {
    let nbq: NonBlockingQueue<Int64> = NonBlockingQueue<Int64>()
    println("队列size: ${nbq.size}")
}
```

运行结果：

```text
队列size: 0
```
