# std.concurrent

## Feature Overview

The `concurrent` package provides APIs for structured concurrency.

Use [threadScope\<T, R>](./concurrent_package_api/concurrent_package_funcs.md#func-threadscopet-rthreadgroupt---r) to create a scope for groups of Cangjie threads. The scope receives a [ThreadGroup\<T>](./concurrent_package_api/concurrent_package_classes.md#class-threadgroupt) instance, launches threads through the group, and does not return until all threads launched in the group have completed, successfully or otherwise.

`ThreadGroup<T>` stores the eventual result of each launched thread. The group implements [Iterable\<T>](../core/core_package_api/core_package_interfaces.md#interface-iterablee), and thread results are consumed by iteration. Results are yielded as threads complete; the iteration order is the same as the order that the threads complete.

If the scope itself throws an [Exception](../core/core_package_api/core_package_exceptions.md#class-exception) or [Error](../core/core_package_api/core_package_exceptions.md#class-error), or if an unhandled thread `Exception` or `Error` is thrown while consuming task results, `threadScope` sends cancellation requests to the remaining threads launched in the group, waits for outstanding thread results to be drained, and then rethrows the failure.
As with `Future<T>`, cancellation is cooperative. A thread that wishes to respond to cancellation requests must check [Thread.currentThread.hasPendingCancellation](../core/core_package_api/core_package_classes.md#prop-haspendingcancellation). 

This package provides the following structured concurrency API:

- [ThreadGroup\<T>](./concurrent_package_api/concurrent_package_classes.md#class-threadgroupt): A group used to launch, cancel, and collect results from grouped concurrent threads.

- [threadScope\<T, R>((ThreadGroup\<T>) -> R)](./concurrent_package_api/concurrent_package_funcs.md#func-threadscopet-rthreadgroupt---r): Runs concurrent threads in a scope and waits for all launched threads to complete before returning.

## API List

### Functions

| Function Name | Description |
| ------------- | ----------- |
| [threadScope\<T, R>((ThreadGroup\<T>) -> R)](./concurrent_package_api/concurrent_package_funcs.md#func-threadscopet-rthreadgroupt---r) | Runs concurrent threads in a scope and waits for all launched threads before returning. |

### Classes

| Class | Description |
| ----- | ----------- |
| [ThreadGroup\<T>](./concurrent_package_api/concurrent_package_classes.md#class-threadgroupt) | Provides API to launch, cancel, and collect results from grouped concurrent threads. |

## Examples

- [threadScope Usage Example](./concurrent_samples/thread_scope_sample.md)
- [threadScope Exception Handling Example](./concurrent_samples/thread_scope_exception_sample.md)
- [threadScope Cancellation Example](./concurrent_samples/thread_scope_cancellation_sample.md)
