# Enumeration

## enum CatchupStyle

```cangjie
public enum CatchupStyle {
    | Delay
    | Burst
    | Skip
}
```

Function: Represents different catch-up strategies to be used by recurring task timers.

When task execution takes too long, subsequent task execution time points may be delayed. Different catch-up strategies are suitable for different scenarios:

- `Delay`: Suitable for scenarios where the exact start time of tasks is not critical, but fixed intervals between task executions are required.
- `Burst`: Suitable for scenarios where scheduled tasks have sequential dependencies and need to be executed in order.
- `Skip`: Suitable for scenarios where scheduled tasks are independent and intermediate tasks can be skipped.

Example:

This example creates a `Timer` that executes a task 3 times, starting 1 second after creation with 1-second intervals between executions, using the `Delay` catch-up strategy.

```cangjie
import std.sync.{Timer, CatchupStyle}
import std.time.{MonoTime}

main() {
    let start = MonoTime.now()
    Timer.repeatTimes(3, Duration.second, Duration.second, {=>
        println("Tick at: ${MonoTime.now() - start}")
    }, style: Delay)

    sleep(Duration.second * 4)
    0
}
```

### Burst

```cangjie
Burst
```

Function: Under this strategy, the interval between task start times remains fixed. When task execution time exceeds the scheduled interval, missed tasks will be executed sequentially until caught up.

### Delay

```cangjie
Delay
```

Function: Under this strategy, the interval between the end of the previous task and the start of the next task remains fixed. The next task's start time = previous task's end time + scheduled interval.

### Skip

```cangjie
Skip
```

Function: Under this strategy, the interval between task start times remains fixed. When task execution time exceeds the scheduled interval, subsequent missed tasks will be skipped to catch up as quickly as possible.

## enum MemoryOrder <sup>(deprecated)</sup>

```cangjie
public enum MemoryOrder {
    | SeqCst
}
```

Function: Enumeration for memory ordering types.

Memory ordering primarily refers to the sequence of memory load/store operations. Compilers or CPUs may reorder instructions for performance optimization. This enumeration represents different ordering strategies.

> **Note:**
>
> Will be deprecated in future versions.

### SeqCst

```cangjie
SeqCst
```

Function: Represents sequentially consistent ordering, which prohibits instruction reordering and ensures all atomic operations before this operation complete before any atomic operations after it.

## enum ReadWriteMutexMode <sup>(deprecated)<sup>

```cangjie
public enum ReadWriteMutexMode {
    | Unfair
    | Fair
}
```

Function: Enumeration for read-write lock fairness modes.

Lock fairness refers to whether multiple threads waiting for the same lock acquire it in their waiting order.

> **Note:**
>
> Will be deprecated in future versions.

### Fair

```cangjie
Fair
```

Function: Represents fair mode for read-write locks. When the lock is released, the thread that has been waiting longest acquires it first.

### Unfair

```cangjie
Unfair
```

Function: Represents unfair mode for read-write locks. When the lock is released, any waiting thread may acquire it.