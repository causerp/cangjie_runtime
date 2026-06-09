# std.concurrent

## 功能介绍

`concurrent` 包提供结构化并发相关 API。

使用 [threadScope\<T, R>](./concurrent_package_api/concurrent_package_funcs.md#func-threadscopet-rthreadgroupt---r) 可以为一组仓颉线程创建作用域。该作用域接收一个 [ThreadGroup\<T>](./concurrent_package_api/concurrent_package_classes.md#class-threadgroupt) 实例，通过该线程组启动线程，并且在该线程组启动的所有线程完成前不会返回，无论这些线程是正常完成还是异常完成。

`ThreadGroup<T>` 保存每个已启动线程的最终结果。该线程组实现 [Iterable\<T>](../core/core_package_api/core_package_interfaces.md#interface-iterablee)，线程结果通过迭代进行消费。结果会按线程完成的先后顺序产出；迭代顺序与线程完成顺序一致。

如果作用域自身抛出 [Exception](../core/core_package_api/core_package_exceptions.md#class-exception) 或 [Error](../core/core_package_api/core_package_exceptions.md#class-error)，或者在消费任务结果时抛出未处理的线程 `Exception` 或 `Error`，`threadScope` 会向该线程组中剩余的已启动线程发送取消请求，等待并清空尚未处理的线程结果，然后重新抛出该失败。
与 `Future<T>` 一样，取消机制是协作式的。希望响应取消请求的线程必须检查 [Thread.currentThread.hasPendingCancellation](../core/core_package_api/core_package_classes.md#prop-haspendingcancellation)。

该包提供以下结构化并发 API：

- [ThreadGroup\<T>](./concurrent_package_api/concurrent_package_classes.md#class-threadgroupt)：用于启动分组并发线程、向其发送取消请求，并收集其结果的线程组。

- [threadScope\<T, R>((ThreadGroup\<T>) -> R)](./concurrent_package_api/concurrent_package_funcs.md#func-threadscopet-rthreadgroupt---r)：在作用域中运行并发线程，并在所有已启动线程完成后返回。

## API 列表

### 函数

| 函数名 | 功能 |
| ------ | ---- |
| [threadScope\<T, R>((ThreadGroup\<T>) -> R)](./concurrent_package_api/concurrent_package_funcs.md#func-threadscopet-rthreadgroupt---r) | 在作用域中运行并发线程，并在所有已启动线程完成后返回。 |

### 类

| 类 | 功能 |
| --- | ---- |
| [ThreadGroup\<T>](./concurrent_package_api/concurrent_package_classes.md#class-threadgroupt) | 提供启动分组并发线程、向其发送取消请求，并收集其结果的 API。 |

## 示例

- [threadScope 使用示例](./concurrent_samples/thread_scope_sample.md)
- [threadScope 异常处理示例](./concurrent_samples/thread_scope_exception_sample.md)
- [threadScope 取消示例](./concurrent_samples/thread_scope_cancellation_sample.md)
