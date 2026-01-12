# 类

## class Signal

```cangjie
public class Signal <: ToString {
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

### static const SIGHUP

```cangjie
public static const SIGHUP = Signal(0x1, "hangup")
```

功能：SIGHUP 信号，终端挂起或进程父进程退出。

类型：[Signal](./runtime_package_class.md#class-signal)

### static const SIGINT

```cangjie
public static const SIGINT = Signal(0x2, "interrupt")
```

功能：SIGINT 信号，表示用户中断。

类型：[Signal](./runtime_package_class.md#class-signal)

### static const SIGQUIT

```cangjie
public static const SIGQUIT = Signal(0x3, "quit")
```

功能：SIGQUIT 信号，表示用户退出。

类型：[Signal](./runtime_package_class.md#class-signal)

### static const SIGTERM

```cangjie
public static const SIGTERM = Signal(0xf, "terminated")
```

功能：SIGTERM 信号，终止请求。

类型：[Signal](./runtime_package_class.md#class-signal)

#### prop value

```cangjie
public prop value: Int32
```

功能：获取信号的值。

#### init(Int32, String)

```cangjie
public const init(value: Int32, comment: String)
```

功能：创建信号。

参数：

- value: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 信号值。
- comment: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 信号描述。

### static const SIGTRAP

```cangjie
public static const SIGTRAP = Signal(0x5, "trace/breakpoint trap")
```

功能：SIGTRAP 信号，调试断点触发。

类型：[Signal](./runtime_package_class.md#class-signal)

### func toString()

```cangjie
public func toString(): String
```

功能：打印信号值。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 信号值字符串。
