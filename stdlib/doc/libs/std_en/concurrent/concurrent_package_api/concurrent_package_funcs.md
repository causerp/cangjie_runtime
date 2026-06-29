# Functions

## func threadScope\<T, R>((ThreadGroup\<T>) -> R)

```cangjie
public func threadScope<T, R>(fn: (ThreadGroup<T>) -> R): R
```

Introduces a scoped [ThreadGroup\<T>](./concurrent_package_classes.md#class-threadgroupt) and waits for all tasks launched by the group to complete before returning.

`threadScope` creates a [ThreadGroup\<T>](./concurrent_package_classes.md#class-threadgroupt) and passes it to `fn`.

If `fn` returns normally, `threadScope` waits for every unconsumed task result in the group before returning the value returned by `fn`. Task values that have not been consumed inside `fn` are consumed and discarded while the scope is waiting. If any unconsumed task throws an [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) or [Error](../../core/core_package_api/core_package_exceptions.md#class-error), the group iterator rethrows that failure while `threadScope` is waiting. Only the first `Exception` or `Error` is rethrown; the rest are silently discarded.

If `fn` throws, or if consuming a launched task result throws and the failure is not handled inside `fn`, `threadScope` sends cancellation requests to all launched tasks, drains outstanding task results, and rethrows the original failure. As above, only the first `Exception` or `Error` is rethrown; the rest are silently discarded.

> **Note:**
>
> Cancellation is cooperative. A task that should stop early after cancellation should check [Thread.currentThread.hasPendingCancellation](../../core/core_package_api/core_package_classes.md#prop-haspendingcancellation).


Parameters:

- fn: ([ThreadGroup\<T>](./concurrent_package_classes.md#class-threadgroupt)) -> R - The scoped function that receives a thread group.

> **Note:**
>
> The `ThreadGroup` instance must not escape its `threadScope`

Returns:

- R - The return value of `fn`.

Exceptions:

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - Thrown if `fn` throws an exception or if an unhandled launched task result is an exception.
- [Error](../../core/core_package_api/core_package_exceptions.md#class-error) - Thrown if `fn` throws an error or if an unhandled launched task result is an error.
