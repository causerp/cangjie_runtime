# 类

## class Signal

```cangjie
public class Signal {
    public static const SIGHUP = Signal(0x1, "hangup")
    public static const SIGINT = Signal(0x2, "interrupt")
    public static const SIGQUIT = Signal(0x3, "quit")
    public static const SIGTRAP = Signal(0x5, "trace/breakpoint trap")
    public static const SIGALRM = Signal(0xe, "alarm clock")
    public static const SIGTERM = Signal(0xf, "terminated")
    public const init(value: Int32, comment: String)
}
```

功能：信号类，用于向操作系统、其他进程或进程自身传递事件的通知。

父类型：

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

> **注意：**
>
> 不支持平台：Windows。

### static const SIGALRM

```cangjie
public static const SIGALRM = Signal(0xe, "alarm clock")
```

功能：SIGALRM 信号，定时器超时。

类型：[Signal](./runtime_package_class.md#class-signal)

> **注意：**
>
> 不支持平台：Windows。

示例：

<!-- verify -->
```cangjie
import std.runtime.*

main() {
    // 使用预定义的SIGALRM信号
    println("SIGALRM信号值: ${Signal.SIGALRM.value}")
    return 0
}
```

运行结果：

```text
SIGALRM信号值: 14
```

### static const SIGHUP

```cangjie
public static const SIGHUP = Signal(0x1, "hangup")
```

功能：SIGHUP 信号，终端挂起或进程父进程退出。

类型：[Signal](./runtime_package_class.md#class-signal)

> **注意：**
>
> 不支持平台：Windows。

示例：

<!-- verify -->
```cangjie
import std.runtime.*

main() {
    // 使用预定义的SIGHUP信号
    println("SIGHUP信号值: ${Signal.SIGHUP.value}")
    return 0
}
```

运行结果：

```text
SIGHUP信号值: 1
```

### static const SIGINT

```cangjie
public static const SIGINT = Signal(0x2, "interrupt")
```

功能：SIGINT 信号，表示用户中断。

类型：[Signal](./runtime_package_class.md#class-signal)

> **注意：**
>
> 不支持平台：Windows。

示例：

<!-- verify -->
```cangjie
import std.runtime.*

main() {
    // 使用预定义的SIGINT信号
    println("SIGINT信号值: ${Signal.SIGINT.value}")
    return 0
}
```

运行结果：

```text
SIGINT信号值: 2
```

### static const SIGQUIT

```cangjie
public static const SIGQUIT = Signal(0x3, "quit")
```

功能：SIGQUIT 信号，表示用户退出。

类型：[Signal](./runtime_package_class.md#class-signal)

> **注意：**
>
> 不支持平台：Windows。

示例：

<!-- verify -->
```cangjie
import std.runtime.*

main() {
    // 使用预定义的SIGQUIT信号
    println("SIGQUIT信号值: ${Signal.SIGQUIT.value}")
    return 0
}
```

运行结果：

```text
SIGQUIT信号值: 3
```

### static const SIGTERM

```cangjie
public static const SIGTERM = Signal(0xf, "terminated")
```

功能：SIGTERM 信号，终止请求。

类型：[Signal](./runtime_package_class.md#class-signal)

> **注意：**
>
> 不支持平台：Windows。

示例：

<!-- verify -->
```cangjie
import std.runtime.*

main() {
    // 使用预定义的SIGTERM信号
    println("SIGTERM信号值: ${Signal.SIGTERM.value}")
    return 0
}
```

运行结果：

```text
SIGTERM信号值: 15
```

### static const SIGTRAP

```cangjie
public static const SIGTRAP = Signal(0x5, "trace/breakpoint trap")
```

功能：SIGTRAP 信号，调试断点触发。

类型：[Signal](./runtime_package_class.md#class-signal)

> **注意：**
>
> 不支持平台：Windows。

示例：

<!-- verify -->
```cangjie
import std.runtime.*

main() {
    // 使用预定义的SIGTRAP信号
    println("SIGTRAP信号值: ${Signal.SIGTRAP.value}")
    return 0
}
```

运行结果：

```text
SIGTRAP信号值: 5
```

### prop value

```cangjie
public prop value: Int32
```

功能：获取信号的值。

> **注意：**
>
> 不支持平台：Windows。

示例：

<!-- verify -->
```cangjie
import std.runtime.*

main() {
    // 获取预定义信号的值
    let signalValue = Signal.SIGTERM.value
    println("SIGTERM信号的值: ${signalValue}")

    // 创建自定义信号并获取值
    let customSignal = Signal(15, "my custom signal")
    println("自定义信号的值: ${customSignal.value}")

    return 0
}
```

运行结果：

```text
SIGTERM信号的值: 15
自定义信号的值: 15
```

### init(Int32, String)

```cangjie
public const init(value: Int32, comment: String)
```

功能：创建信号。

参数：

- value: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 信号值。
- comment: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 信号描述。

> **注意：**
>
> 不支持平台：Windows。

示例：

<!-- verify -->
```cangjie
import std.runtime.*

main() {
    // 创建一个自定义信号
    let customSignal = Signal(10, "custom signal")
    println("创建的信号值: ${customSignal.value}")
    return 0
}
```

运行结果：

```text
创建的信号值: 10
```
