# 类

## class ThreadGroup\<T>

```cangjie
public class ThreadGroup<T> <: Iterable<T> {}
```

功能：支持启动并发线程、向所有已启动线程发送取消请求，以及消费线程结果。

`ThreadGroup<T>` 会为每个通过 [launch(() -> T)](#func-launch---t) 启动的线程记录一个结果。该结果为线程的返回值。该组实现 [Iterable\<T>](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)，迭代是等待并消费线程结果的机制。


> **注意：**
>
> 1. `ThreadGroup<T>` 没有公开构造函数。[threadScope](./concurrent_package_funcs.md#func-threadscopet-rthreadgroupt---r) 是唯一支持的实例创建方式。
> 2. 结果按线程完成的先后顺序产出。

> **警告：**
> `ThreadGroup` 自身的 API 不是线程安全的。特别是，明确不支持对同一个 `ThreadGroup` 进行并发迭代。通常不要在 `threadScope` 内调用 `spawn`。

父类型：
- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)

### func cancelAll()

```cangjie
public func cancelAll(): Unit
```

功能：向此 [ThreadGroup](./concurrent_package_classes.md#class-threadgroupt) 启动的每个线程发送取消请求。

该函数通过每个线程底层的 [Future](../../core/core_package_api/core_package_classes.md#class-futuret) 请求取消。它不会立即停止任务执行。线程可以通过 [Thread.currentThread.hasPendingCancellation](../../core/core_package_api/core_package_classes.md#prop-haspendingcancellation) 观察取消请求，并决定是否停止以及如何停止。线程可以忽略取消请求。

### func iterator()

```cangjie
public func iterator(): Iterator<T>
```

功能：获取用于消费此 [ThreadGroup](./concurrent_package_classes.md#class-threadgroupt) 启动的任务结果的迭代器。

调用迭代器的 `next` 会返回下一个已完成任务的结果。如果没有可用的已完成结果，但仍有已启动的任务未完成，当前线程会阻塞，直到有结果可用。如果该任务因抛出 [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) 或 [Error](../../core/core_package_api/core_package_exceptions.md#class-error) 而完成，`next` 会重新抛出该失败。如果没有剩余的未消费任务结果，`next` 返回 `None`。

返回值：

- [Iterator\<T>](../../core/core_package_api/core_package_classes.md#class-iteratort) - 任务结果的迭代器。

异常：

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - 如果消费到的任务结果为异常，则抛出。
- [Error](../../core/core_package_api/core_package_exceptions.md#class-error) - 如果消费到的任务结果为错误，则抛出。

### func launch(() -> T)

```cangjie
public func launch(task: () -> T): Unit
```

功能：在此 [ThreadGroup](./concurrent_package_classes.md#class-threadgroupt) 中启动一个并发任务。

该任务运行在新的仓颉线程中。当任务正常返回时，其值会作为该组的结果被记录。当任务抛出 [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) 或 [Error](../../core/core_package_api/core_package_exceptions.md#class-error) 时，该失败会被记录，并在通过组迭代器消费该结果时重新抛出。

**参数：**

- task: () -> T - 要启动的任务。
