# 并发工具类的使用

## Atomic 的使用

示例：

在多线程程序中，使用原子操作实现计数：

<!-- verify -->
```cangjie
import std.sync.*
import std.collection.*

let count = AtomicInt64(0)

main(): Int64 {
    let futures = ArrayList<Future<Int64>>()

    // 创建 1000 个线程，各自将计数加 1
    for (_ in 0..1000) {
        let task = spawn {
            sleep(Duration.millisecond)
            count.fetchAdd(1)
        }
        futures.add(task)
    }

    // 等待所有线程完成
    for (f in futures) {
        f.get()
    }

    let value = count.load()
    println("计数结果: ${value}")
    return 0
}
```

运行结果：

```text
计数结果: 1000
```

## Monitor <sup>(deprecated)</sup> 的使用

> **注意：**
>
> 未来版本即将废弃，使用 [Condition](../sync_package_api/sync_package_interfaces.md#interface-condition) 替代。

示例：

在不同线程中，使用 `Monitor` 实现挂起和唤醒线程：

<!-- verify -->
```cangjie
import std.sync.*

var monitor = Monitor()
var flag: Bool = true

main(): Int64 {
    let workerFuture = spawn {
        monitor.lock()
        while (flag) {
            println("新线程: 等待前")
            monitor.wait()
            println("新线程: 等待后")
        }
        monitor.unlock()
    }

    // 睡眠 10 毫秒，以确保新线程可以先执行到 wait
    sleep(10 * Duration.millisecond)

    monitor.lock()
    println("主线程: 设置 flag")
    flag = false
    monitor.unlock()

    println("主线程: 通知")
    monitor.lock()
    monitor.notifyAll()
    monitor.unlock()

    // 等待新线程完成
    workerFuture.get()
    return 0
}
```

运行结果：

```text
新线程: 等待前
主线程: 设置 flag
主线程: 通知
新线程: 等待后
```

## Mutex 的使用

示例：

在不同线程中，使用 `Mutex` 加锁和解锁：

<!-- verify -->
```cangjie
import std.sync.*

var mutex = Mutex()
var condition = synchronized(mutex) {
    mutex.condition()
}
var flag: Bool = true

main(): Int64 {
    let workerFuture = spawn {
        mutex.lock()
        while (flag) {
            println("新线程: 等待前")
            condition.wait()
            println("新线程: 等待后")
        }
        mutex.unlock()
    }

    // 睡眠 10 毫秒，以确保新线程可以先执行到 wait
    sleep(10 * Duration.millisecond)

    mutex.lock()
    println("主线程: 设置 flag")
    flag = false
    mutex.unlock()

    println("主线程: 通知")
    mutex.lock()
    condition.notifyAll()
    mutex.unlock()

    // 等待新线程完成
    workerFuture.get()
    return 0
}
```

运行结果：

```text
新线程: 等待前
主线程: 设置 flag
主线程: 通知
新线程: 等待后
```

## Condition 的使用

示例：

使用 `Condition` 实现挂起和唤醒线程：

<!-- verify -->
```cangjie
import std.sync.{Mutex, Condition, AtomicBool}

var mutex = Mutex()
var flag = AtomicBool(true)

main(): Int64 {
    let condition: Condition

    // 在持有锁的情况下生成 Condition 实例
    synchronized(mutex) {
        condition = mutex.condition()
    }

    let workerFuture = spawn {
        synchronized(mutex) {
            println("新线程: 等待前")

            // 挂起当前线程，等待直到 flag 变为 false
            condition.waitUntil {=> !flag.load()}

            println("新线程: 等待后")
        }
    }

    // 睡眠 10 毫秒，以确保新线程可以先执行到 waitUntil
    sleep(10 * Duration.millisecond)

    // 修改 flag 值并唤醒等待中的子线程
    synchronized(mutex) {
        println("主线程: 设置 flag")
        flag.store(false)
        println("主线程: 通知")
        condition.notifyAll()
    }

    // 等待新线程完成
    workerFuture.get()
    return 0
}
```

运行结果：

```text
新线程: 等待前
主线程: 设置 flag
主线程: 通知
新线程: 等待后
```

## Timer 的使用

示例：

使用 `Timer` 创建一次性和重复性任务：

<!-- verify -->
```cangjie
import std.sync.*

main(): Int64 {
    let count = AtomicInt8(0)

    // 创建 50 毫秒后执行一次的任务
    Timer.once(50 * Duration.millisecond) {
        =>
            println("一次性任务执行")
            count.fetchAdd(1)
    }

    // 创建延迟 100 毫秒后开始、每 200 毫秒重复执行的任务
    let timer = Timer.repeat(
        100 * Duration.millisecond,
        200 * Duration.millisecond,
        {
            =>
                println("重复任务执行")
                count.fetchAdd(10)
        }
    )

    sleep(Duration.second)

    // 取消重复任务，再等待 500 毫秒确认不再执行
    timer.cancel()
    sleep(500 * Duration.millisecond)
    println("计数结果: ${count.load()}")
    0
}
```

运行结果：

```text
一次性任务执行
重复任务执行
重复任务执行
重复任务执行
重复任务执行
重复任务执行
计数结果: 51
```
