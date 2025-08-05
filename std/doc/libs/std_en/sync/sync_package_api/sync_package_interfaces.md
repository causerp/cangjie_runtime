# Interfaces

## interface Condition

```cangjie
public interface Condition {
    func notify(): Unit
    func notifyAll(): Unit
    func wait(): Unit
    func wait(timeout!: Duration): Bool
    func waitUntil(predicate: ()->Bool): Unit
    func waitUntil(predicate: ()->Bool, timeout!: Duration): Bool
}
```

Functionality: Provides an interface for thread blocking and waiting for signals from other threads to resume execution.

This mechanism utilizes shared variables for thread synchronization. When some threads are suspended while waiting for certain conditions on shared variables to be met, other threads modify the shared variables to satisfy those conditions and then perform wake-up operations. This allows suspended threads to be awakened and continue execution.

### func notify()

```cangjie
func notify(): Unit
```

Functionality: Wakes up one thread waiting on the associated mutex.

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold the mutex.

### func notifyAll()

```cangjie
func notifyAll(): Unit
```

Functionality: Wakes up all threads waiting on the associated mutex.

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold the mutex.

### func wait()

```cangjie
func wait(): Unit
```

Functionality: Suspends the current thread until the corresponding `notify` function is called.

> **Note:**
>
> The thread releases the associated mutex lock when entering the wait state and reacquires it upon being awakened.

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold the mutex.

### func wait(Duration)

```cangjie
func wait(timeout!: Duration): Bool
```

Functionality: Suspends the current thread until the corresponding `notify` function is called or the suspension time exceeds `timeout`.

> **Note:**
>
> The thread releases the associated mutex lock when entering the wait state and reacquires it upon being awakened.

Parameters:

- timeout!: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - Suspension duration, with a default value of [Duration.Max](../../core/core_package_api/core_package_structs.md#static-const-max).

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the [Monitor <sup>(deprecated)<sup>](sync_package_classes.md#class-monitor-deprecated) is awakened by another thread; returns `false` if timeout occurs.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if `timeout` is less than or equal to [Duration.Zero](../../core/core_package_api/core_package_structs.md#static-const-zero).
- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold the mutex.

### func waitUntil(()->Bool)

```cangjie
func waitUntil(predicate: ()->Bool): Unit
```

Functionality: Suspends the current thread until the corresponding `notify` function is called and the `predicate` evaluates to `true`.

> **Note:**
>
> - The thread releases the associated mutex lock when entering the wait state and reacquires it upon being awakened.
> - This method first checks if the `predicate` evaluates to `true`; if so, it returns immediately; otherwise, it suspends the current thread.

Parameters:

- predicate: ()->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The condition to wait for.

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold the mutex.

### func waitUntil(()->Bool,Duration)

```cangjie
func waitUntil(predicate: ()->Bool, timeout!: Duration): Bool
```

Functionality: Suspends the current thread until the corresponding `notify` function is called and the `predicate` evaluates to `true`, or the suspension time exceeds `timeout`.

> **Note:**
>
> - The thread releases the associated mutex lock when entering the wait state and reacquires it upon being awakened.
> - This method first checks if the `predicate` evaluates to `true`; if so, it returns `true` immediately; otherwise, it suspends the current thread.

Parameters:

- predicate: ()->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The condition to wait for.
- timeout!: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - Suspension duration, with a default value of [Duration.Max](../../core/core_package_api/core_package_structs.md#static-const-max).

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the [Monitor <sup>(deprecated)<sup>](sync_package_classes.md#class-monitor-deprecated) is awakened by another thread and the `predicate` evaluates to `true`; returns `false` if timeout occurs.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if `timeout` is less than or equal to [Duration.Zero](../../core/core_package_api/core_package_structs.md#static-const-zero).
- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold the mutex.

## interface IReentrantMutex <sup>(deprecated)<sup>

```cangjie
public interface IReentrantMutex {
    func lock(): Unit
    func tryLock(): Bool
    func unlock(): Unit
}
```

Functionality: Provides an interface for implementing reentrant mutex locks.

> **Note:**
>
> - This will be deprecated in future versions; use [Lock](#interface-lock) instead.
> - Implementers must ensure the underlying mutex supports nested locking; otherwise, deadlocks may occur during nested usage.

### func lock()

```cangjie
func lock(): Unit
```

Functionality: Locks the mutex.

If the mutex is already locked, the current thread is blocked.

### func tryLock()

```cangjie
func tryLock(): Bool
```

Functionality: Attempts to lock the mutex.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `false` if the mutex is already locked; otherwise, locks the mutex and returns `true`.

### func unlock()

```cangjie
func unlock(): Unit
```

Functionality: Unlocks the mutex.

If the mutex has been locked N times recursively, this function must be called N times to fully unlock it. Once fully unlocked, if other threads are blocked on this lock, one of them is awakened.

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold the mutex.

## interface Lock

```cangjie
public interface Lock {
    func lock(): Unit
    func tryLock(): Bool
    func unlock(): Unit
}
```

Functionality: Provides an interface for implementing reentrant mutex locks.

> **Note:**
>
> Implementers must ensure the underlying mutex supports nested locking; otherwise, deadlocks may occur during nested usage.

### func lock()

```cangjie
func lock(): Unit
```

Functionality: Locks the mutex.

If the mutex is already locked, the current thread is blocked.

### func tryLock()

```cangjie
func tryLock(): Bool
```

Functionality: Attempts to lock the mutex.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `false` if the mutex is already locked; otherwise, locks the mutex and returns `true`.

### func unlock()

```cangjie
func unlock(): Unit
```

Functionality: Unlocks the mutex.

If the mutex has been locked N times recursively, this function must be called N times to fully unlock it. Once fully unlocked, if other threads are blocked on this lock, one of them is awakened.

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold the mutex.

## interface UniqueLock

```cangjie
public interface UniqueLock <: Lock {
    func condition(): Condition
}
```

Functionality: Provides an interface for implementing exclusive locks.

Parent Type:

- [Lock](#interface-lock)

### func condition()

```cangjie
func condition(): Condition
```

Functionality: Creates a [Condition](#interface-condition) associated with this [Lock](#interface-lock).

Can be used to implement concurrency primitives with "single Lock, multiple wait queues".

Return Value:

- [Condition](#interface-condition) - The created [Condition](#interface-condition) instance associated with this [Lock](#interface-lock).

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold the mutex.