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

Function: Provides an interface for thread blocking and waiting for signals from other threads to resume execution.

This is a thread synchronization mechanism using shared variables. When some threads are suspended waiting for certain conditions on shared variables to be met, other threads modify the shared variables to satisfy the conditions and then perform wake-up operations. This allows suspended threads to continue execution after being awakened.

### func notify()

```cangjie
func notify(): Unit
```

Function: Wakes up one thread waiting on the associated mutex.

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold the mutex.

### func notifyAll()

```cangjie
func notifyAll(): Unit
```

Function: Wakes up all threads waiting on the associated mutex.

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold the mutex.

### func wait()

```cangjie
func wait(): Unit
```

Function: Suspends the current thread until the corresponding `notify` function is called.

> **Note:**
>
> The thread releases the associated mutex lock when entering wait state, and reacquires it upon being awakened.

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold the mutex.

### func wait(Duration)

```cangjie
func wait(timeout!: Duration): Bool
```

Function: Suspends the current thread until the corresponding `notify` function is called or the suspension time exceeds `timeout`.

> **Note:**
>
> The thread releases the associated mutex lock when entering wait state, and reacquires it upon being awakened.

Parameters:

- timeout!: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - Suspension time, default value is [Duration.Max](../../core/core_package_api/core_package_structs.md#static-const-max).

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if awakened by another thread's [Monitor <sup>(deprecated)</sup>](sync_package_classes.md#class-monitor-deprecated); returns `false` if timeout occurs.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if `timeout` is less than or equal to [Duration.Zero](../../core/core_package_api/core_package_structs.md#static-const-zero).
- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold the mutex.

### func waitUntil(()->Bool)

```cangjie
func waitUntil(predicate: ()->Bool): Unit
```

Function: Suspends the current thread until the corresponding `notify` function is called and `predicate` evaluates to `true`.

> **Note:**
>
> - The thread releases the associated mutex lock when entering wait state, and reacquires it upon being awakened.
> - This method first checks if `predicate` evaluates to `true`; if so, it returns immediately, otherwise suspends the current thread.

Parameters:

- predicate: ()->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Condition to wait for becoming true.

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold the mutex.

### func waitUntil(()->Bool,Duration)

```cangjie
func waitUntil(predicate: ()->Bool, timeout!: Duration): Bool
```

Function: Suspends the current thread until the corresponding `notify` function is called and `predicate` evaluates to `true`, or the suspension time exceeds `timeout`.

> **Note:**
>
> - The thread releases the associated mutex lock when entering wait state, and reacquires it upon being awakened.
> - This method first checks if `predicate` evaluates to `true`; if so, it returns `true` immediately, otherwise suspends the current thread.

Parameters:

- predicate: ()->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Condition to wait for becoming true.
- timeout!: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - Suspension time, default value is [Duration.Max](../../core/core_package_api/core_package_structs.md#static-const-max).

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if awakened by another thread's [Monitor <sup>(deprecated)</sup>](sync_package_classes.md#class-monitor-deprecated) and `predicate` evaluates to `true`; returns `false` if timeout occurs.

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

Function: Provides an interface for implementing reentrant mutex locks.

> **Warning:**
>
> - Will be deprecated in future versions, use [Lock](#interface-lock) instead.
> - Implementers must ensure the underlying mutex supports nested locking, otherwise deadlocks may occur during nested usage.

### func lock()

```cangjie
func lock(): Unit
```

Function: Locks the mutex.

If the mutex is already locked, blocks the current thread.

### func tryLock()

```cangjie
func tryLock(): Bool
```

Function: Attempts to lock the mutex.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns false if the mutex is already locked; otherwise locks the mutex and returns true.

### func unlock()

```cangjie
func unlock(): Unit
```

Function: Unlocks the mutex.

If the mutex has been locked N times recursively, this function needs to be called N times to fully unlock it. Once fully unlocked, if other threads are blocked on this lock, one of them will be awakened.

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

Function: Provides an interface for implementing reentrant mutex locks.

> **Warning:**
>
> Implementers must ensure the underlying mutex supports nested locking, otherwise deadlocks may occur during nested usage.

### func lock()

```cangjie
func lock(): Unit
```

Function: Locks the mutex.

If the mutex is already locked, blocks the current thread.

### func tryLock()

```cangjie
func tryLock(): Bool
```

Function: Attempts to lock the mutex.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns false if the mutex is already locked; otherwise locks the mutex and returns true.

### func unlock()

```cangjie
func unlock(): Unit
```

Function: Unlocks the mutex.

If the mutex has been locked N times recursively, this function needs to be called N times to fully unlock it. Once fully unlocked, if other threads are blocked on this lock, one of them will be awakened.

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold the mutex.

## interface UniqueLock

```cangjie
public interface UniqueLock <: Lock {
    func condition(): Condition
}
```

Function: Provides an interface for implementing exclusive locks.

Parent Type:

- [Lock](#interface-lock)

### func condition()

```cangjie
func condition(): Condition
```

Function: Creates a [Condition](#interface-condition) associated with this [Lock](#interface-lock).

Can be used to implement "single Lock with multiple wait queues" concurrency primitives.

Return Value:

- [Condition](#interface-condition) - The created [Condition](#interface-condition) instance associated with this [Lock](#interface-lock).

Exceptions:

- [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) - Thrown if the current thread does not hold the mutex.