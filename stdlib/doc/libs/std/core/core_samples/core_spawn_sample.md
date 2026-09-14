# 仓颉并发编程示例

## spawn 的使用

主线程和新线程同时尝试打印一些文本。

示例：

<!-- run -->
```cangjie
main(): Int64 {
    // 创建新线程，循环打印 10 次
    spawn {
        for (i in 0..10) {
            println("新线程: ${i}")
            sleep(100 * Duration.millisecond)
        }
    }

    // 主线程同时循环打印 5 次，与子线程交替执行
    for (i in 0..5) {
        println("主线程: ${i}")
        sleep(100 * Duration.millisecond)
    }
    return 0
}
```

可能的运行结果：

```text
主线程: 0
新线程: 0
主线程: 1
新线程: 1
新线程: 2
主线程: 2
主线程: 3
新线程: 3
新线程: 4
主线程: 4
新线程: 5
```

## Future 的 get 的使用

主线程等待创建线程执行完再执行。

示例：

<!-- verify -->
```cangjie
main(): Int64 {
    // 启动新线程，打印 0 到 9
    let future: Future<Unit> = spawn {
        for (i in 0..10) {
            println("新线程: ${i}")
            sleep(100 * Duration.millisecond)
        }
    }

    // 阻塞等待新线程执行完毕
    future.get()

    // 新线程结束后，主线程才开始打印
    for (i in 0..5) {
        println("主线程: ${i}")
        sleep(100 * Duration.millisecond)
    }
    return 0
}
```

运行结果：

```text
新线程: 0
新线程: 1
新线程: 2
新线程: 3
新线程: 4
新线程: 5
新线程: 6
新线程: 7
新线程: 8
新线程: 9
主线程: 0
主线程: 1
主线程: 2
主线程: 3
主线程: 4
```

## 取消仓颉线程

子线程接收主线程发送的取消请求。

<!-- verify -->
```cangjie
main(): Unit {
    // 创建子线程，循环检查是否有取消请求
    let future = spawn {
        while (true) {
            if (Thread.currentThread.hasPendingCancellation) {
                // 收到取消请求后返回 0
                return 0
            }
        }
        return 1
    }

    // 向子线程发起取消请求
    future.cancel()

    // 等待子线程结束并获取返回值
    let result = future.get()
    println("子线程返回值: ${result}")
}
```

运行结果：

```text
子线程返回值: 0
```
