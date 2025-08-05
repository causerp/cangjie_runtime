# Cangjie Concurrent Programming Examples

## Usage of spawn

The main thread and a new thread attempt to print some text simultaneously.

Code example:

<!-- run -->
```cangjie
main(): Int64 {
    spawn {
        => for (i in 0..10) {
            println("New thread, number = ${i}")
            sleep(100 * Duration.millisecond) /* Sleep for 100 milliseconds */
        }
    }

    for (i in 0..5) {
        println("Main thread, number = ${i}")
        sleep(100 * Duration.millisecond) /* Sleep for 100 milliseconds */
    }
    return 0
}
```

Execution result:

```text
Main thread, number = 0
New thread, number = 0
Main thread, number = 1
New thread, number = 1
Main thread, number = 2
New thread, number = 2
Main thread, number = 3
New thread, number = 3
Main thread, number = 4
New thread, number = 4
New thread, number = 5
```

> **Note:**
>
> The above output is for reference only. Actual results may vary due to runtime scheduling randomness.
>
> Since the main thread doesn't wait for the new thread to complete, the program exits before the new thread finishes execution.

## Usage of Future's get

The main thread waits for the spawned thread to complete before proceeding.

Code example:

<!-- verify -->
```cangjie
main(): Int64 {
    let fut: Future<Unit> = spawn {
        => for (i in 0..10) {
            println("New thread, number = ${i}")
            /* Sleep for 100 milliseconds */
            sleep(100 * Duration.millisecond)
        }
    }

    /* Wait for thread completion */
    fut.get()

    for (i in 0..5) {
        println("Main thread, number = ${i}")
        /* Sleep for 100 milliseconds */
        sleep(100 * Duration.millisecond)
    }
    return 0
}
```

Execution result:

```text
New thread, number = 0
New thread, number = 1
New thread, number = 2
New thread, number = 3
New thread, number = 4
New thread, number = 5
New thread, number = 6
New thread, number = 7
New thread, number = 8
New thread, number = 9
Main thread, number = 0
Main thread, number = 1
Main thread, number = 2
Main thread, number = 3
Main thread, number = 4
```

## Canceling Cangjie Threads

Child thread receives cancellation request from main thread.

<!-- verify -->
```cangjie
main(): Unit {
    /* Create thread */
    let future = spawn {
        while (true) {
            if (Thread.currentThread.hasPendingCancellation) {
                return 0
            }
        }
        return 1
    }
    /* Initiate thread cancellation */
    future.cancel()
    let res = future.get()
    println(res)
}
```

Execution result:

```text
0
```