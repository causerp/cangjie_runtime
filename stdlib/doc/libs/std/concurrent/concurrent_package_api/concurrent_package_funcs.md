# 函数

## func threadScope\<T, R>((ThreadGroup\<T>) -> R)

```cangjie
public func threadScope<T, R>(fn: (ThreadGroup<T>) -> R): R
```

功能：引入一个受作用域约束的 [ThreadGroup\<T>](./concurrent_package_classes.md#class-threadgroupt)，并在返回前等待该组启动的所有任务完成。

`threadScope` 会创建一个 [ThreadGroup\<T>](./concurrent_package_classes.md#class-threadgroupt) 并将其传递给 `fn`。

如果 `fn` 正常返回，`threadScope` 会在返回 `fn` 的返回值之前，等待该组中每个未消费的任务结果。未在 `fn` 中消费的任务返回值会在作用域等待期间被消费并丢弃。如果任何未消费的任务抛出 [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) 或 [Error](../../core/core_package_api/core_package_exceptions.md#class-error)，该组的迭代器会在 `threadScope` 等待期间重新抛出该失败。只会重新抛出第一个 `Exception` 或 `Error`，其余失败会被静默丢弃。

如果 `fn` 抛出异常，或者在消费已启动任务的结果时抛出失败，且该失败未在 `fn` 内处理，`threadScope` 会向所有已启动任务发送取消请求，清空尚未处理的任务结果，并重新抛出原始失败。与上文相同，只会重新抛出第一个 `Exception` 或 `Error`，其余失败会被静默丢弃。

> **注意：**
>
> 取消机制是协作式的。希望在收到取消请求后提前停止的任务应检查 [Thread.currentThread.hasPendingCancellation](../../core/core_package_api/core_package_classes.md#prop-haspendingcancellation)。

参数：

- fn: ([ThreadGroup\<T>](./concurrent_package_classes.md#class-threadgroupt)) -> R - 接收线程组的作用域函数。

> **注意：**
>
> 不要允许 `ThreadGroup` 实例逃逸出其 `threadScope`。

返回值：

- R - `fn` 的返回值。

异常：

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - 当 `fn` 抛出异常，或者未处理的已启动任务结果为异常，则抛出。
- [Error](../../core/core_package_api/core_package_exceptions.md#class-error) - 当 `fn` 抛出错误，或者未处理的已启动任务结果为错误，则抛出。
