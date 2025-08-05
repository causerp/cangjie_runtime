# std.sync

## Functionality Overview

The sync package provides capabilities related to concurrent programming.

As an increasing number of computers utilize multi-core processors, concurrent programming has become increasingly important to fully leverage the advantages of multi-core architectures.

Different programming languages implement threads in various ways. Some languages create threads by calling operating system APIs, meaning each language thread corresponds to an OS thread, typically referred to as the 1:1 threading model. Other languages provide specialized thread implementations that allow multiple language threads to switch execution contexts across a varying number of OS threads, known as the M:N threading model—where M language threads are scheduled across N OS threads, with M and N not necessarily equal.

The Cangjie programming language aims to provide developers with a friendly, efficient, and unified interface for concurrent programming, abstracting away conceptual differences such as OS threads and user-mode threads while shielding underlying implementation details. Thus, we introduce only the concept of a "Cangjie thread." Cangjie threads are implemented using the M:N threading model, making them essentially lightweight user-mode threads that support preemption and consume fewer memory resources compared to OS threads.

When developers wish to execute a block of code concurrently, they simply need to create a Cangjie thread.

To create a new Cangjie thread, use the `spawn` keyword followed by a parameterless lambda expression, which contains the code to be executed in the new thread.

Example:

Creating a Cangjie thread using the `spawn` keyword:

```cangjie
main () {
    spawn {
        // Executed in the new thread
        println("Thread: ${Thread.currentThread.id}")
    }
    // Executed in the main thread
    println("Thread: ${Thread.currentThread.id}")
    sleep(Duration.second)

    0
}
```

The sync package primarily offers various types of atomic operations, reentrant mutexes and their interfaces, thread synchronization mechanisms using shared variables, and timer functionality.

Atomic operations include those for integer types, Bool types, and reference types.

Integer types include: Int8, Int16, Int32, Int64, UInt8, UInt16, UInt32, UInt64.

Atomic operations for integer types support basic read (`load`), write (`store`), exchange (`swap`/`compareAndSwap`), and arithmetic operations (`fetchAdd`/`fetchSub`). Note the following:

- The return value of exchange and arithmetic operations is the value before modification.
- `compareAndSwap` checks whether the current value of the atomic variable equals the specified value. If true, it replaces the value; otherwise, no replacement occurs.

Atomic operations for Bool and reference types only provide read, write, and exchange operations. Note:

Reference-type atomic operations are only valid for reference types.

The [Lock](./sync_package_api/sync_package_interfaces.md#interface-lock) interface can be cumbersome to use—for example, it's easy to forget to unlock or fail to release the lock when an exception occurs while holding it. To address such issues, the Cangjie programming language provides the `synchronized` keyword to be used alongside [Lock](./sync_package_api/sync_package_interfaces.md#interface-lock).

By placing a mutex instance after `synchronized`, the subsequent code block is protected, ensuring that at most one thread can execute the protected code at any time:

- Before entering a `synchronized` block, a thread automatically acquires the lock associated with the `Lock` instance. If the lock cannot be acquired, the thread is blocked.
- Before exiting a `synchronized` block (including via control transfer expressions like `break`, `continue`, `return`, or `throw`), the thread automatically releases the lock associated with the `Lock` instance.

Example:

Before each thread in the `for` loop enters the `synchronized` block, it automatically acquires the lock associated with the `mtx` instance. Before exiting the block, it releases the lock.

```cangjie
import std.sync.Mutex

main () {
    let mtx = Mutex()
    let cnt = Box<Int64>(0)

    for (_ in 0..10) {
        spawn {
            synchronized(mtx) {
                cnt.value ++
                println("count: ${cnt.value}")
            }
        }
    }

    sleep(Duration.second)
    0
}
```

## API List

### Constants & Variables

|  Name | Description  |
| ------------ | ------------ |
| [DefaultMemoryOrder <sup>(deprecated)</sup>](./sync_package_api/sync_package_constants_vars.md#let-defaultmemoryorder-deprecated) | Default memory order. See enum [MemoryOrder <sup>(deprecated)</sup>](./sync_package_api/sync_package_enums.md#enum-memoryorder-deprecated). |

### Interfaces

|  Interface Name | Description  |
| ------------ | ------------ |
| [Condition](./sync_package_api/sync_package_interfaces.md#interface-condition) | Interface providing functionality for threads to block and wait for signals from other threads to resume execution. |
| [IReentrantMutex <sup>(deprecated)<sup>](./sync_package_api/sync_package_interfaces.md#interface-ireentrantmutex-deprecated) | Interface for reentrant mutexes. |
| [Lock](./sync_package_api/sync_package_interfaces.md#interface-lock) | Interface for implementing reentrant mutexes. |
| [UniqueLock](./sync_package_api/sync_package_interfaces.md#interface-uniquelock) | Interface for implementing exclusive locks. |

### Classes

|  Class Name | Description  |
| ------------ | ------------ |
| [AtomicBool](./sync_package_api/sync_package_classes.md#class-atomicbool) | Provides atomic operations for Bool types. |
| [AtomicInt16](./sync_package_api/sync_package_classes.md#class-atomicint16) | Provides atomic operations for Int16 types. |
| [AtomicInt32](./sync_package_api/sync_package_classes.md#class-atomicint32) | Provides atomic operations for Int32 types. |
| [AtomicInt64](./sync_package_api/sync_package_classes.md#class-atomicint64) | Provides atomic operations for Int64 types. |
| [AtomicInt8](./sync_package_api/sync_package_classes.md#class-atomicint8) | Provides atomic operations for Int8 types. |
| [AtomicOptionReference](./sync_package_api/sync_package_classes.md#class-atomicoptionreferencet-where-t--object) | Provides atomic operations for reference types. |
| [AtomicReference](./sync_package_api/sync_package_classes.md#class-atomicreferencet-where-t--object) | Provides atomic operations for reference types. |
| [AtomicUInt16](./sync_package_api/sync_package_classes.md#class-atomicuint16) | Provides atomic operations for UInt16 types. |
| [AtomicUInt32](./sync_package_api/sync_package_classes.md#class-atomicuint32) | Provides atomic operations for UInt32 types. |
| [AtomicUInt64](./sync_package_api/sync_package_classes.md#class-atomicuint64) | Provides atomic operations for UInt64 types. |
| [AtomicUInt8](./sync_package_api/sync_package_classes.md#class-atomicuint8) | Provides atomic operations for UInt8 types. |
| [Barrier](./sync_package_api/sync_package_classes.md#class-barrier) | Provides functionality to coordinate multiple threads to reach a specific program point. |
| [Monitor <sup>(deprecated)<sup>](./sync_package_api/sync_package_classes.md#class-monitor-deprecated) | Provides functionality for threads to block and wait for signals from other threads to resume execution. |
| [MultiConditionMonitor <sup>(deprecated)<sup>](./sync_package_api/sync_package_classes.md#class-multiconditionmonitor-deprecated) | Provides functionality to bind multiple condition variables to the same mutex. |
| [Mutex](./sync_package_api/sync_package_classes.md#class-mutex) | Provides reentrant lock functionality. |
| [ReadWriteLock](./sync_package_api/sync_package_classes.md#class-readwritelock) | Provides reentrant read-write lock functionality. |
| [ReentrantMutex <sup>(deprecated)<sup>](./sync_package_api/sync_package_classes.md#class-reentrantmutex-deprecated) | Provides reentrant lock functionality. |
| [ReentrantReadMutex <sup>(deprecated)<sup>](./sync_package_api/sync_package_classes.md#class-reentrantreadmutex-deprecated) | Provides read lock functionality for reentrant read-write locks. |
| [ReentrantReadWriteMutex <sup>(deprecated)<sup>](./sync_package_api/sync_package_classes.md#class-reentrantreadwritemutex-deprecated) | Provides reentrant read-write lock functionality. |
| [ReentrantWriteMutex <sup>(deprecated)<sup>](./sync_package_api/sync_package_classes.md#class-reentrantwritemutex-deprecated) | Provides write lock functionality for reentrant read-write locks. |
| [Semaphore](./sync_package_api/sync_package_classes.md#class-semaphore) | Provides semaphore functionality. |
| [SyncCounter](./sync_package_api/sync_package_classes.md#class-synccounter) | Provides countdown counter functionality. |
| [Timer](./sync_package_api/sync_package_classes.md#class-timer) | Provides timer functionality. |

### Enums

|  Enum Type | Description  |
| ------------ | ------------ |
| [MemoryOrder <sup>(deprecated)</sup>](./sync_package_api/sync_package_enums.md#enum-memoryorder-deprecated) | Enum for memory order types. |
| [ReadWriteMutexMode <sup>(deprecated)<sup>](./sync_package_api/sync_package_enums.md#enum-readwritemutexmode-deprecated) | Enum for read-write lock fairness modes. |
| [CatchupStyle](./sync_package_api/sync_package_enums.md#enum-catchupstyle) | Enum for catch-up strategies used by repetitive task timers. |

### Structs

|  Struct Name | Description  |
| ------------ | ------------ |
| [ConditionID <sup>(deprecated)<sup>](./sync_package_api/sync_package_structs.md#struct-conditionid-deprecated) | Represents a condition variable for mutexes. See [MultiConditionMonitor](./sync_package_api/sync_package_classes.md#class-multiconditionmonitor-deprecated). |

### Exception Classes

|  Exception Class Name | Description  |
| ------------ | ------------ |
| [IllegalSynchronizationStateException](./sync_package_api/sync_package_exceptions.md#class-illegalsynchronizationstateexception) | Exception for illegal synchronization states. |