# std.sync

## Function Overview

The sync package provides capabilities related to concurrent programming.

As more computers utilize multi-core processors, concurrent programming becomes increasingly important to fully leverage the advantages of multi-core architectures.

Different programming languages implement threads in various ways. Some languages create threads by calling operating system APIs, meaning each language thread corresponds to an OS thread, typically referred to as the 1:1 threading model. Other languages provide specialized thread implementations that allow multiple language threads to switch execution contexts across a varying number of OS threads, known as the M:N threading model—where M language threads are scheduled to execute on N OS threads (M and N may differ).

The Cangjie programming language aims to provide developers with a friendly, efficient, and unified concurrent programming interface, abstracting away conceptual differences such as OS threads and user-mode threads while shielding underlying implementation details. Thus, we introduce only the concept of a "Cangjie thread." Cangjie threads adopt the M:N threading model, making them lightweight user-mode threads that support preemption and consume fewer memory resources compared to OS threads.

When developers wish to execute a block of code concurrently, they simply need to create a Cangjie thread.

To create a new Cangjie thread, use the `spawn` keyword followed by a parameterless lambda expression, which contains the code to be executed in the new thread.

Example:

Creating a Cangjie thread using the `spawn` keyword:

<!-- run -->

```cangjie
main () {
    spawn {
        // Execute in the new thread
        println("Thread: ${Thread.currentThread.id}")
    }
    // Execute in the main thread
    println("Thread: ${Thread.currentThread.id}")
    sleep(Duration.second)
    0
}
```

Possible output:

```text
Thread: 1
Thread: 2
```

The sync package primarily provides various types of atomic operations, reentrant mutex locks and their interfaces, thread synchronization mechanisms using shared variables, and timer functionality.

Atomic operations include support for integer types, Bool types, and reference types.

Integer types include: Int8, Int16, Int32, Int64, UInt8, UInt16, UInt32, UInt64.

Atomic operations for integer types support basic read (`load`), write (`store`), exchange (`swap`/`compareAndSwap`), and arithmetic operations (`fetchAdd`/`fetchSub`). Note the following:

- The return value of exchange and arithmetic operations is the value before modification.
- `compareAndSwap` checks whether the current value of the atomic variable equals the specified value. If true, it replaces the value with another; otherwise, no replacement occurs.

Atomic operations for Bool and reference types only support read, write, and exchange operations. Note:

Atomic operations for reference types are only valid for reference types.

The [Lock](./sync_package_api/sync_package_interfaces.md#interface-lock) interface can be cumbersome to use—for example, it's easy to forget to unlock, or an exception might be thrown while holding the lock without automatic release. To address such issues, the Cangjie programming language provides the `synchronized` keyword, used in conjunction with [Lock](./sync_package_api/sync_package_interfaces.md#interface-lock).

By placing a mutex instance after `synchronized`, the subsequent code block is protected, ensuring that only one thread can execute the protected code at any given time:

- Before entering a `synchronized` block, a thread automatically acquires the lock associated with the `Lock` instance. If the lock cannot be acquired, the thread is blocked.
- Before exiting a `synchronized` block (including via control transfer expressions like `break`, `continue`, `return`, or `throw`), the thread automatically releases the lock associated with the `Lock` instance.

Example:

Before each thread in the `for` loop enters the `synchronized` block, it automatically acquires the lock associated with the `mtx` instance. Before exiting the block, it releases the lock.

<!-- verify -->

```cangjie
import std.sync.Mutex

main () {
    let mtx = Mutex()
    let cnt = Box<Int64>(0)

    for (_ in 0..5) {
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

Possible output:

```text
count: 1
count: 2
count: 3
count: 4
count: 5
```

## API List

### Constants & Variables

|  Name | Function  |
| ------------ | ------------ |
| [DefaultMemoryOrder <sup>(deprecated)</sup>](./sync_package_api/sync_package_constants_vars.md#let-defaultmemoryorder-deprecated) | Default memory order. See enum [MemoryOrder <sup>(deprecated)</sup>](./sync_package_api/sync_package_enums.md#enum-memoryorder-deprecated). |

### Interfaces

|  Interface | Function  |
| ------------ | ------------ |
| [Condition](./sync_package_api/sync_package_interfaces.md#interface-condition) | Provides functionality for blocking threads and waiting for signals from other threads to resume execution. |
| [IReentrantMutex <sup>(deprecated)</sup>](./sync_package_api/sync_package_interfaces.md#interface-ireentrantmutex-deprecated) | Provides a reentrant mutex interface. |
| [Lock](./sync_package_api/sync_package_interfaces.md#interface-lock) | Provides an interface for implementing reentrant mutex locks. |
| [UniqueLock](./sync_package_api/sync_package_interfaces.md#interface-uniquelock) | Provides an interface for implementing exclusive locks. |

### Classes

|  Class | Function  |
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
| [Barrier](./sync_package_api/sync_package_classes.md#class-barrier) | Coordinates multiple threads to reach a specific program point together. |
| [Monitor <sup>(deprecated)</sup>](./sync_package_api/sync_package_classes.md#class-monitor-deprecated) | Provides functionality for blocking threads and waiting for signals from other threads to resume execution. |
| [MultiConditionMonitor <sup>(deprecated)</sup>](./sync_package_api/sync_package_classes.md#class-multiconditionmonitor-deprecated) | Binds multiple condition variables to the same mutex. |
| [Mutex](./sync_package_api/sync_package_classes.md#class-mutex) | Provides reentrant lock functionality. |
| [ReadWriteLock](./sync_package_api/sync_package_classes.md#class-readwritelock) | Provides reentrant read-write lock functionality. |
| [ReentrantMutex <sup>(deprecated)</sup>](./sync_package_api/sync_package_classes.md#class-reentrantmutex-deprecated) | Provides reentrant lock functionality. |
| [ReentrantReadMutex <sup>(deprecated)</sup>](./sync_package_api/sync_package_classes.md#class-reentrantreadmutex-deprecated) | Provides the read lock type in reentrant read-write locks. |
| [ReentrantReadWriteMutex <sup>(deprecated)</sup>](./sync_package_api/sync_package_classes.md#class-reentrantreadwritemutex-deprecated) | Provides reentrant read-write lock functionality. |
| [ReentrantWriteMutex <sup>(deprecated)</sup>](./sync_package_api/sync_package_classes.md#class-reentrantwritemutex-deprecated) | Provides the write lock type in reentrant read-write locks. |
| [Semaphore](./sync_package_api/sync_package_classes.md#class-semaphore) | Provides semaphore functionality. |
| [SyncCounter](./sync_package_api/sync_package_classes.md#class-synccounter) | Provides countdown counter functionality. |
| [Timer](./sync_package_api/sync_package_classes.md#class-timer) | Provides timer functionality. |

### Enums

|  Enum | Function  |
| ------------ | ------------ |
| [MemoryOrder <sup>(deprecated)</sup>](./sync_package_api/sync_package_enums.md#enum-memoryorder-deprecated) | Enumeration for memory order types. |
| [ReadWriteMutexMode <sup>(deprecated)</sup>](./sync_package_api/sync_package_enums.md#enum-readwritemutexmode-deprecated) | Enumeration for read-write lock fairness modes. |
| [CatchupStyle](./sync_package_api/sync_package_enums.md#enum-catchupstyle) | Enumeration for catch-up strategies used by repetitive task timers. |

### Structs

|  Struct | Function  |
| ------------ | ------------ |
| [ConditionID <sup>(deprecated)</sup>](./sync_package_api/sync_package_structs.md#struct-conditionid-deprecated) | Represents a condition variable for mutex locks. See [MultiConditionMonitor](./sync_package_api/sync_package_classes.md#class-multiconditionmonitor-deprecated). |

### Exception Classes

|  Exception | Function  |
| ------------ | ------------ |
| [IllegalSynchronizationStateException](./sync_package_api/sync_package_exceptions.md#class-illegalsynchronizationstateexception) | Represents an illegal synchronization state exception. |