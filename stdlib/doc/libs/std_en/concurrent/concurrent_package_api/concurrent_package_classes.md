# Classes

## class ThreadGroup\<T>

```cangjie
public class ThreadGroup<T> <: Iterable<T> {}
```

Description：Allows launching of concurrent threads, request cancellation for all launched threads, and consumption of thread results.

A `ThreadGroup<T>` records one result for every thread launched by [launch(() -> T)](#func-launch---t). The result is the thread return value. The group implements [Iterable\<T>](../../core/core_package_api/core_package_interfaces.md#interface-iterablee), and iteration is the mechanism for waiting on and consuming thread results.


> **Note:**
>
> 1. There is no public constructor for `ThreadGroup<T>`. [threadScope](./concurrent_package_funcs.md#func-threadscopet-rthreadgroupt---r) is the only supported means of creating an instance.
> 2. Results are yielded as threads complete. 

> **Warning:**
>
> The API of `ThreadGroup` itself is not thread-safe. In particular, concurrent iteration over a single `ThreadGroup` is explicitly not supported. `spawn` should not be used inside a `threadScope`.

Parent types:
- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)

### func cancelAll()

```cangjie
public func cancelAll(): Unit
```

Function: Sends a cancellation request to every thread launched by this [ThreadGroup](./concurrent_package_classes.md#class-threadgroupt).

This function requests cancellation through each thread's underlying [Future](../../core/core_package_api/core_package_classes.md#class-futuret). It does not immediately stop task execution. A thread can observe the request through [Thread.currentThread.hasPendingCancellation](../../core/core_package_api/core_package_classes.md#prop-haspendingcancellation) and decide how and if to stop. A thread is free to ignore cancellation requests.


### func iterator()

```cangjie
public func iterator(): Iterator<T>
```

Function: Gets an iterator used to consume results from tasks launched by this [ThreadGroup](./concurrent_package_classes.md#class-threadgroupt).

Calling `next` on the iterator returns the next completed task result. If no completed result is available but launched tasks are still pending, the current thread blocks until a result is available. If the task completed by throwing an [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) or [Error](../../core/core_package_api/core_package_exceptions.md#class-error), `next` rethrows that failure. If no unconsumed task results remain, `next` returns `None`.

Returns:

- [Iterator\<T>](../../core/core_package_api/core_package_classes.md#class-iteratort) - An iterator over task results.

Exceptions:

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - Thrown if the consumed task result is an exception.
- [Error](../../core/core_package_api/core_package_exceptions.md#class-error) - Thrown if the consumed task result is an error.

### func launch(() -> T)

```cangjie
public func launch(task: () -> T): Unit
```

Launches a concurrent task in this [ThreadGroup](./concurrent_package_classes.md#class-threadgroupt).

The task runs in a new Cangjie thread. When the task returns normally, its value is stored as a result of this group. When the task throws an [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) or [Error](../../core/core_package_api/core_package_exceptions.md#class-error), that failure is stored and rethrown when the result is consumed through the group iterator.

**Parameters**:

- task: () -> T - The task to launch.
