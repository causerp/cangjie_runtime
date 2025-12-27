# 结构体

## struct ConditionID <sup>(deprecated)</sup>

```cangjie
public struct ConditionID
```

功能：用于表示互斥锁的条件变量，详见 [MultiConditionMonitor <sup>(deprecated)</sup>](sync_package_classes.md#class-multiconditionmonitor-deprecated)。

> **注意：**
>
> 未来版本即将废弃，使用 [Condition](./sync_package_interfaces.md#interface-condition) 替代。

示例：

<!-- verify -->
```cangjie
import std.sync.*

var monitor = MultiConditionMonitor()
var flag: Bool = true

main(): Int64 {
    // 创建一个互斥锁的条件变量
    monitor.lock()
    let conditionID = monitor.newCondition()
    monitor.unlock()

    let fut = spawn {
        monitor.lock()
        while (flag) {
            println("New thread: before wait")
            monitor.wait(conditionID)
            println("New thread: after wait")
        }
        monitor.unlock()
    }

    /* 睡眠 10 毫秒，以确保新线程可以执行 */
    sleep(10 * Duration.millisecond)

    monitor.lock()
    println("Main thread: set flag")
    flag = false
    monitor.unlock()

    println("Main thread: notify")
    monitor.lock()
    monitor.notify(conditionID) // 唤醒指定条件变量上的一个线程
    monitor.unlock()

    /* 等待新线程完成 */
    fut.get()
    return 0
}
```

运行结果：

```text
New thread: before wait
Main thread: set flag
Main thread: notify
New thread: after wait
```