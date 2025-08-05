# Usage of Atomic, Monitor, and Timer

## Usage of Atomic

Example:

Implementing a counter using atomic operations in a multithreaded program:

<!-- verify -->
```cangjie
import std.sync.*
import std.time.*
import std.collection.*

let count = AtomicInt64(0)

main(): Int64 {
    let list = ArrayList<Future<Int64>>()

    /* Create 1000 threads */
    for (_ in 0..1000) {
        let fut = spawn {
            sleep(Duration.millisecond) /* Sleep for 1 millisecond */
            count.fetchAdd(1)
        }
        list.add(fut)
    }

    /* Wait for all threads to complete */
    for (f in list) {
        f.get()
    }

    var val = count.load()
    println("count = ${val}")
    return 0
}
```

Execution result:

```text
count = 1000
```

## Usage of Monitor <sup>(deprecated)<sup>

> **Note:**
>
> Will be deprecated in future versions. Use [Condition](../sync_package_api/sync_package_interfaces.md#interface-condition) instead.

Example:

Using `Monitor` to suspend and wake threads in different threads:

<!-- verify -->
```cangjie
import std.sync.*

var mon = Monitor()
var flag: Bool = true

main(): Int64 {
    let fut = spawn {
        mon.lock()
        while (flag) {
            println("New thread: before wait")
            mon.wait()
            println("New thread: after wait")
        }
        mon.unlock()
    }

    /* Sleep for 10 milliseconds to ensure the new thread can execute */
    sleep(10 * Duration.millisecond)

    mon.lock()
    println("Main thread: set flag")
    flag = false
    mon.unlock()

    println("Main thread: notify")
    mon.lock()
    mon.notifyAll()
    mon.unlock()

    /* Wait for the new thread to complete */
    fut.get()
    return 0
}
```

Execution result:

```text
New thread: before wait
Main thread: set flag
Main thread: notify
New thread: after wait
```

## Usage of Mutex

Example:

Using `Mutex` for locking and unlocking in different threads:

<!-- verify -->
```cangjie
import std.sync.*

var mt = Mutex()
var con = synchronized(mt) { mt.condition() }
var flag: Bool = true

main(): Int64 {
    let fut = spawn {
        mt.lock()
        while (flag) {
            println("New thread: before wait")
            con.wait()
            println("New thread: after wait")
        }
        mt.unlock()
    }
    /* Sleep for 10 milliseconds to ensure the new thread can execute */
    sleep(10 * Duration.millisecond)
    mt.lock()
    println("Main thread: set flag")
    flag = false
    mt.unlock()

    println("Main thread: notify")
    mt.lock()
    con.notifyAll()
    mt.unlock()

    /* Wait for the new thread to complete */
    fut.get()
    return 0
}
```

Execution result:

```text
New thread: before wait
Main thread: set flag
Main thread: notify
New thread: after wait
```

## Usage of Condition

Example:

Using `Condition` to suspend and wake threads:

<!-- verify -->
```cangjie
import std.sync.{Mutex, Condition, AtomicBool}

var mutex = Mutex()
var flag = AtomicBool(true)

main(): Int64 {
    let condition: Condition
    synchronized(mutex) {
        condition = mutex.condition() // Generate Condition instance while holding the lock
    }

    let fut = spawn {
        synchronized(mutex) {
            println("New thread: before wait")
            condition.waitUntil {=> !flag.load()} // Suspend current thread until flag becomes true
            println("New thread: after wait")
        }
    }

    /* Sleep for 10 milliseconds to ensure the new thread can execute */
    sleep(10 * Duration.millisecond)

    synchronized(mutex) { // Wait for child thread to suspend
        println("Main thread: set flag")
        flag.store(false) // Modify flag value
        println("Main thread: notify")
        condition.notifyAll() // Wake up waiting child thread
    }

    /* Wait for the new thread to complete */
    fut.get()
    return 0
}
```

Execution result:

```text
New thread: before wait
Main thread: set flag
Main thread: notify
New thread: after wait
```

## Usage of Timer

Example:

Using `Timer` to create one-time and repetitive tasks:

<!-- verify -->
```cangjie
import std.sync.*

main(): Int64 {
    let count = AtomicInt8(0)

    Timer.once(50 * Duration.millisecond) {
        =>
        println("run only once")
        count.fetchAdd(1)
    }

    let timer = Timer.repeat(
        100 * Duration.millisecond,
        200 * Duration.millisecond,
        {
            =>
            println("run repetitively")
            count.fetchAdd(10)
        }
    )

    sleep(Duration.second)
    timer.cancel()
    sleep(500 * Duration.millisecond)
    println("count = ${count.load()}")
    0
}
```

Execution result:

```text
run only once
run repetitively
run repetitively
run repetitively
run repetitively
run repetitively
count = 51
```