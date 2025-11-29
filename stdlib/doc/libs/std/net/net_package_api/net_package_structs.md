# 结构体

## struct AddressFamily

```cangjie
public struct AddressFamily <: ToString & Equatable<AddressFamily> {
    public static const INET = AddressFamily("INET", 2)
    public static const INET6: AddressFamily
    public static const NETLINK: AddressFamily
    public static const UNIX = AddressFamily("UNIX", 1)
    public static const UNSPEC = AddressFamily("UNSPEC", 0)
    public let name: String
    public let value: UInt16
    public const init(name: String, value: UInt16)
}
```

功能：[AddressFamily](net_package_structs.md#struct-addressfamily) 地址族用于指示 `Socket` 的寻址方案，常用的有 `INET` / `INET6` / `UNIX` 地址族。地址族标识符最初在 [RFC 2453](https://datatracker.ietf.org/doc/html/rfc2453) 中定义。

父类型：

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[AddressFamily](#struct-addressfamily)>

### static const INET

```cangjie
public static const INET: AddressFamily = AddressFamily("INET", 2)
```

功能：IPv4 地址族。

类型：[AddressFamily](net_package_structs.md#struct-addressfamily)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${AddressFamily.INET}")
    println("name: ${AddressFamily.INET.name}")
    println("value: ${AddressFamily.INET.value}")
    return 0
}
```

运行结果：

```text
toString: INET
name: INET
value: 2
```

### static const INET6

```cangjie
public static const INET6: AddressFamily
```

功能：IPv6 地址族。不同系统下的值分别为：

- macOS: AddressFamily("INET6", 30)
- Windows: AddressFamily("INET6", 23)
- 其他情况：AddressFamily("INET6", 10)

类型：[AddressFamily](net_package_structs.md#struct-addressfamily)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${AddressFamily.INET6}")
    println("name: ${AddressFamily.INET6.name}")
    println("value: ${AddressFamily.INET6.value}")
    return 0
}
```

运行结果：

```text
toString: INET6
name: INET6
value: 10
```

### static const NETLINK

```cangjie
public static const NETLINK: AddressFamily
```

功能：NetLink 地址族，其值为：

- Linux: AddressFamily("NETLINK", 16)

> **注意：**
>
> 不支持平台：Windows、macOS、iOS。

类型：[AddressFamily](net_package_structs.md#struct-addressfamily)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${AddressFamily.NETLINK}")
    println("name: ${AddressFamily.NETLINK.name}")
    println("value: ${AddressFamily.NETLINK.value}")
    return 0
}
```

运行结果：

```text
toString: NETLINK
name: NETLINK
value: 16
```

### static const UNIX

```cangjie
public static const UNIX: AddressFamily = AddressFamily("UNIX", 1)
```

功能：unix domain socket 地址族。

类型：[AddressFamily](net_package_structs.md#struct-addressfamily)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${AddressFamily.UNIX}")
    println("name: ${AddressFamily.UNIX.name}")
    println("value: ${AddressFamily.UNIX.value}")
    return 0
}
```

运行结果：

```text
toString: UNIX
name: UNIX
value: 1
```

### static const UNSPEC

```cangjie
public static const UNSPEC: AddressFamily = AddressFamily("UNSPEC", 0)
```

功能：未指定的地址族。

类型：[AddressFamily](net_package_structs.md#struct-addressfamily)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${AddressFamily.UNSPEC}")
    println("name: ${AddressFamily.UNSPEC.name}")
    println("value: ${AddressFamily.UNSPEC.value}")
    return 0
}
```

运行结果：

```text
toString: UNSPEC
name: UNSPEC
value: 0
```

### let name

```cangjie
public let name: String
```

功能：地址族名。

类型：[String](../../../std/core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 创建不同的AddressFamily实例
    let inet = AddressFamily.INET
    let unix = AddressFamily.UNIX
    let unspec = AddressFamily.UNSPEC
    
    // 访问name属性并打印结果
    println("INET name: ${inet.name}")
    println("UNIX name: ${unix.name}")
    println("UNSPEC name: ${unspec.name}")
    
    return 0
}
```

运行结果：

```text
INET name: INET
UNIX name: UNIX
UNSPEC name: UNSPEC
```

### let value

```cangjie
public let value: UInt16
```

功能：地址族值。

类型：[UInt16](../../../std/core/core_package_api/core_package_intrinsics.md#uint16)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 创建不同的AddressFamily实例
    let inet = AddressFamily.INET
    let unix = AddressFamily.UNIX
    let unspec = AddressFamily.UNSPEC
    
    // 访问value属性并打印结果
    println("INET value: ${inet.value}")
    println("UNIX value: ${unix.value}")
    println("UNSPEC value: ${unspec.value}")
    
    return 0
}
```

运行结果：

```text
INET value: 2
UNIX value: 1
UNSPEC value: 0
```

### init(String, UInt16)

```cangjie
public const init(name: String, value: UInt16)
```

功能：常量构造函数，创建 [AddressFamily](net_package_structs.md#struct-addressfamily) 对象。

参数：

- name: [String](../../../std/core/core_package_api/core_package_structs.md#struct-string) - 地址族名。
- value: [UInt16](../../../std/core/core_package_api/core_package_intrinsics.md#uint16) - 地址族值。

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 使用构造函数创建自定义的AddressFamily实例
    let customFamily = AddressFamily("CUSTOM", 100u16)
    
    // 访问属性并打印结果
    println("Custom family name: ${customFamily.name}")
    println("Custom family value: ${customFamily.value}")
    
    return 0
}
```

运行结果：

```text
Custom family name: CUSTOM
Custom family value: 100
```

### func toString()

```cangjie
public func toString(): String
```

功能：获取地址族对应的名称。

返回值：

- [String](../../../std/core/core_package_api/core_package_structs.md#struct-string) - 当前地址族的名称。

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 创建不同的AddressFamily实例
    let inet = AddressFamily.INET
    let unix = AddressFamily.UNIX
    let unspec = AddressFamily.UNSPEC
    let custom = AddressFamily("CUSTOM", 100u16)
    
    // 使用toString()方法并打印结果
    println("INET toString: ${inet.toString()}")
    println("UNIX toString: ${unix.toString()}")
    println("UNSPEC toString: ${unspec.toString()}")
    println("CUSTOM toString: ${custom.toString()}")
    
    return 0
}
```

运行结果：

```text
INET toString: INET
UNIX toString: UNIX
UNSPEC toString: UNSPEC
CUSTOM toString: CUSTOM
```

### operator func !=(AddressFamily)

```cangjie
public operator func !=(rhs: AddressFamily): Bool
```

功能：比较地址族值是否不等。

参数：

- rhs: [AddressFamily](net_package_structs.md#struct-addressfamily) - 参与比较的 [AddressFamily](net_package_structs.md#struct-addressfamily) 对象。

返回值：

- [Bool](../../../std/core/core_package_api/core_package_intrinsics.md#bool) - 如果两个 [AddressFamily](net_package_structs.md#struct-addressfamily) 对象不等，则返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 创建不同的AddressFamily实例
    let inet1 = AddressFamily.INET
    let inet2 = AddressFamily.INET
    let unix = AddressFamily.UNIX
    let custom1 = AddressFamily("CUSTOM", 100u16)
    let custom2 = AddressFamily("CUSTOM", 100u16)
    
    // 使用!=操作符比较它们
    let inetNotEqual = inet1 != inet2
    let unixNotEqual = unix != unix
    let customNotEqual = custom1 != custom2
    let inetUnixNotEqual = inet1 != unix
    
    println("INET1 != INET2: ${inetNotEqual}")
    println("UNIX != UNIX: ${unixNotEqual}")
    println("CUSTOM1 != CUSTOM2: ${customNotEqual}")
    println("INET != UNIX: ${inetUnixNotEqual}")
    
    return 0
}
```

运行结果：

```text
INET1 != INET2: false
UNIX != UNIX: false
CUSTOM1 != CUSTOM2: false
INET != UNIX: true
```

### operator func ==(AddressFamily)

```cangjie
public operator func ==(rhs: AddressFamily): Bool
```

功能：比较地址族值是否相等。

参数：

- rhs: [AddressFamily](net_package_structs.md#struct-addressfamily) - 参与比较的 [AddressFamily](net_package_structs.md#struct-addressfamily) 对象。

返回值：

- [Bool](../../../std/core/core_package_api/core_package_intrinsics.md#bool) - 如果两个 [AddressFamily](net_package_structs.md#struct-addressfamily) 对象相等，则返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 创建不同的AddressFamily实例
    let inet1 = AddressFamily.INET
    let inet2 = AddressFamily.INET
    let unix = AddressFamily.UNIX
    let custom1 = AddressFamily("CUSTOM", 100u16)
    let custom2 = AddressFamily("CUSTOM", 100u16)
    
    // 使用==操作符比较它们
    let inetEqual = inet1 == inet2
    let unixEqual = unix == unix
    let customEqual = custom1 == custom2
    let inetUnixEqual = inet1 == unix
    
    println("INET1 == INET2: ${inetEqual}")
    println("UNIX == UNIX: ${unixEqual}")
    println("CUSTOM1 == CUSTOM2: ${customEqual}")
    println("INET == UNIX: ${inetUnixEqual}")
    
    return 0
}
```

运行结果：

```text
INET1 == INET2: true
UNIX == UNIX: true
CUSTOM1 == CUSTOM2: true
INET == UNIX: false
```

## struct OptionLevel

```cangjie
public struct OptionLevel {
    public static const ICMP: Int32 = 1
    public static const IP: Int32 = 0
    public static const RAW: Int32 = 255
    public static const SOCKET: Int32
    public static const TCP: Int32 = 6
    public static const UDP: Int32 = 17
}
```

功能：提供了常用的套接字选项级别。

### static const ICMP

```cangjie
public static const ICMP: Int32 = 1
```

功能：控制 `ICMP` 协议行为的套接字选项级别。

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionLevel.ICMP}")
    return 0
}
```

运行结果：

```text
toString: 1
```

### static const IP

```cangjie
public static const IP: Int32 = 0
```

功能：控制 `IP` 协议行为的套接字选项级别。

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionLevel.IP}")
    return 0
}
```

运行结果：

```text
toString: 0
```

### static const RAW

```cangjie
public static const RAW: Int32 = 255
```

功能：控制 `RAW` 协议行为的套接字选项级别。

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionLevel.RAW}")
    return 0
}
```

运行结果：

```text
toString: 255
```

### static const SOCKET

```cangjie
public static const SOCKET: Int32
```

功能：控制基本套接字行为的套接字选项级别。不同系统下的值分别为：

- macOS: 0xFFFF
- Windows: 0xFFFF
- 其他情况：1

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionLevel.SOCKET}")
    return 0
}
```

运行结果：

```text
toString: 1
```

### static const TCP

```cangjie
public static const TCP: Int32 = 6
```

功能：控制 `TCP` 协议行为的套接字选项级别。

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionLevel.TCP}")
    return 0
}
```

运行结果：

```text
toString: 6
```

### static const UDP

```cangjie
public static const UDP: Int32 = 17
```

功能：控制 `UDP` 协议行为的套接字选项级别。

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionLevel.UDP}")
    return 0
}
```

运行结果：

```text
toString: 17
```

## struct OptionName

```cangjie
public struct OptionName {
    public static const IP_HDRINCL: Int32
    public static const IP_TOS: Int32
    public static const IP_TTL: Int32
    public static const SO_ACCEPTCONN: Int32
    public static const SO_BROADCAST: Int32
    public static const SO_DEBUG: Int32 = 0x0001
    public static const SO_DONTROUTE: Int32
    public static const SO_ERROR: Int32
    public static const SO_KEEPALIVE: Int32
    public static const SO_LINGER: Int32
    public static const SO_OOBINLINE: Int32
    public static const SO_RCVBUF: Int32
    public static const SO_RCVTIMEO: Int32
    public static const SO_REUSEADDR: Int32
    public static const SO_SNDBUF: Int32
    public static const SO_SNDTIMEO: Int32
    public static const TCP_KEEPCNT: Int32
    public static const TCP_KEEPIDLE: Int32
    public static const TCP_KEEPINTVL: Int32
    public static const TCP_NODELAY: Int32 = 0x0001
}
```

功能：提供了常用的套接字选项。

### static const IP_HDRINCL

```cangjie
public static const IP_HDRINCL: Int32
```

功能：用于在发送数据包时指定 `IP` 头部是否由应用程序提供的套接字选项。不同系统下的值分别为：

- macOS: 0x0002
- Windows: 0x0002
- 其他情况：0x0003

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionName.IP_HDRINCL}")
    return 0
}
```

运行结果：

```text
toString: 3
```

### static const IP_TOS

```cangjie
public static const IP_TOS: Int32
```

功能：用于指定数据包服务类型和优先级的套接字选项。不同系统下的值分别为：

- macOS: 0x0003
- Windows: 0x0003
- 其他情况：0x0001

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionName.IP_TOS}")
    return 0
}
```

运行结果：

```text
toString: 1
```

### static const IP_TTL

```cangjie
public static const IP_TTL: Int32
```

功能：用于限制`IP`数据包在网络中传输最大跳数的套接字选项。不同系统下的值分别为：

- macOS: 0x0004
- Windows: 0x0004
- 其他情况：0x0002

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionName.IP_TTL}")
    return 0
}
```

运行结果：

```text
toString: 2
```

### static const SO_ACCEPTCONN

```cangjie
public static const SO_ACCEPTCONN: Int32
```

功能：用于查询套接字是否处于监听状态的套接字选项。不同系统下的值分别为：

- macOS: 0x0002
- Windows: 0x0002
- 其他情况：0x001E

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionName.SO_ACCEPTCONN}")
    return 0
}
```

运行结果：

```text
toString: 30
```

### static const SO_BROADCAST

```cangjie
public static const SO_BROADCAST: Int32
```

功能：用于设置套接字是否允许发送广播消息的套接字选项。不同系统下的值分别为：

- macOS: 0x0020
- Windows: 0x0020
- 其他情况：0x0006

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionName.SO_BROADCAST}")
    return 0
}
```

运行结果：

```text
toString: 6
```

### static const SO_DEBUG

```cangjie
public static const SO_DEBUG: Int32 = 0x0001
```

功能：用于启用或禁用调试模式的套接字选项。

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionName.SO_DEBUG}")
    return 0
}
```

运行结果：

```text
toString: 1
```

### static const SO_DONTROUTE

```cangjie
public static const SO_DONTROUTE: Int32
```

功能：用于在连接套接字时，不路由套接字数据包的套接字选项。不同系统下的值分别为：

- macOS: 0x0010
- Windows: 0x0010
- 其他情况：0x0005

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionName.SO_DONTROUTE}")
    return 0
}
```

运行结果：

```text
toString: 5
```

### static const SO_ERROR

```cangjie
public static const SO_ERROR: Int32
```

功能：获取和清除套接字上错误状态的套接字选项。不同系统下的值分别为：

- macOS: 0x1007
- Windows: 0x1007
- 其他情况：0x0004

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionName.SO_ERROR}")
    return 0
}
```

运行结果：

```text
toString: 4
```

### static const SO_KEEPALIVE

```cangjie
public static const SO_KEEPALIVE: Int32
```

功能：用于检测 `TCP` 连接是否仍然处于活动状态的套接字选项。不同系统下的值分别为：

- macOS: 0x0008
- Windows: 0x0008
- 其他情况：0x0009

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionName.SO_KEEPALIVE}")
    return 0
}
```

运行结果：

```text
toString: 9
```

### static const SO_LINGER

```cangjie
public static const SO_LINGER: Int32
```

功能：用于设置套接字关闭时行为的套接字选项。不同系统下的值分别为：

- macOS: 0x0080
- Windows: 0x0080
- 其他情况：0x000D

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionName.SO_LINGER}")
    return 0
}
```

运行结果：

```text
toString: 13
```

### static const SO_OOBINLINE

```cangjie
public static const SO_OOBINLINE: Int32
```

功能：用于控制接收带外数据方式的套接字选项。不同系统下的值分别为：

- macOS: 0x0100
- Windows: 0x0100
- 其他情况：0x000A

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionName.SO_OOBINLINE}")
    return 0
}
```

运行结果：

```text
toString: 10
```

### static const SO_RCVBUF

```cangjie
public static const SO_RCVBUF: Int32
```

功能：用于设置套接字接收缓冲区大小的套接字选项。不同系统下的值分别为：

- macOS: 0x1002
- Windows: 0x1002
- 其他情况：0x0008

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionName.SO_RCVBUF}")
    return 0
}
```

运行结果：

```text
toString: 8
```

### static const SO_RCVTIMEO

```cangjie
public static const SO_RCVTIMEO: Int32
```

功能：用于设置套接字接收数据超时时间的套接字选项。不同系统下的值分别为：

- macOS: 0x1006
- Windows: 0x1006
- 其他情况：0x0014

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionName.SO_RCVTIMEO}")
    return 0
}
```

运行结果：

```text
toString: 20
```

### static const SO_REUSEADDR

```cangjie
public static const SO_REUSEADDR: Int32
```

功能：用于在套接字关闭后立即释放其绑定端口，以便其他套接字可以立即绑定该端口的套接字选项。不同系统下的值分别为：

- macOS: 0x0004
- Windows: 0x0004
- 其他情况：0x0002

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionName.SO_REUSEADDR}")
    return 0
}
```

运行结果：

```text
toString: 2
```

### static const SO_SNDBUF

```cangjie
public static const SO_SNDBUF: Int32
```

功能：用于设置套接字发送缓冲区大小的套接字选项。不同系统下的值分别为：

- macOS: 0x1001
- Windows: 0x1001
- 其他情况：0x0007

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionName.SO_SNDBUF}")
    return 0
}
```

运行结果：

```text
toString: 7
```

### static const SO_SNDTIMEO

```cangjie
public static const SO_SNDTIMEO: Int32
```

功能：用于设置套接字发送数据超时时间的套接字选项。不同系统下的值分别为：

- macOS: 0x1005
- Windows: 0x1005
- 其他情况：0x0015

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionName.SO_SNDTIMEO}")
    return 0
}
```

运行结果：

```text
toString: 21
```

### static const TCP_KEEPCNT

```cangjie
public static const TCP_KEEPCNT: Int32
```

功能：用于控制 TCP 连接中发送保持存活探测报文次数的套接字选项。不同系统下的值分别为：

- macOS: 0x0102
- Windows: 0x0010
- 其他情况：0x0006

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionName.TCP_KEEPCNT}")
    return 0
}
```

运行结果：

```text
toString: 6
```

### static const TCP_KEEPIDLE

```cangjie
public static const TCP_KEEPIDLE: Int32
```

功能：用于设置在没有收到对端确认的情况下，`TCP` 保持连接最大次数的套接字选项。不同系统下的值分别为：

- macOS: 0x0010
- Windows: 0x0003
- 其他情况：0x0004

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionName.TCP_KEEPIDLE}")
    return 0
}
```

运行结果：

```text
toString: 4
```

### static const TCP_KEEPINTVL

```cangjie
public static const TCP_KEEPINTVL: Int32
```

功能：用于设置 `TCP` 保持连接时发送探测报文时间间隔的套接字选项。不同系统下的值分别为：

- macOS: 0x0101
- Windows: 0x0011
- 其他情况：0x0005

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionName.TCP_KEEPINTVL}")
    return 0
}
```

运行结果：

```text
toString: 5
```

### static const TCP_NODELAY

```cangjie
public static const TCP_NODELAY: Int32 = 0x0001
```

功能：用于控制 `TCP` 协议延迟行为的套接字选项。

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${OptionName.TCP_NODELAY}")
    return 0
}
```

运行结果：

```text
toString: 1
```

## struct ProtocolType

```cangjie
public struct ProtocolType <: Equatable<ProtocolType> & ToString & Hashable {
    public static let ICMP: ProtocolType = ProtocolType(1)
    public static let IPV4: ProtocolType = ProtocolType(4)
    public static let IPV6: ProtocolType = ProtocolType(41)
    public static let RAW: ProtocolType = ProtocolType(255)
    public static let TCP: ProtocolType = ProtocolType(6)
    public static let UDP: ProtocolType = ProtocolType(17)
    public static let Unspecified: ProtocolType = ProtocolType(0)
    public init(protocol: Int32)
}
```

功能：提供了常用的套接字协议，以及通过指定 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 值来构建套接字协议的功能。

父类型：

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[ProtocolType](#struct-protocoltype)>
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)

### static let ICMP

```cangjie
public static let ICMP: ProtocolType = ProtocolType(1)
```

功能：指定协议类型为 `ICMP`。

类型：[ProtocolType](net_package_structs.md#struct-protocoltype)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${ProtocolType.ICMP}")
    return 0
}
```

运行结果：

```text
toString: ICMP
```

### static let IPV4

```cangjie
public static let IPV4: ProtocolType = ProtocolType(4)
```

功能：指定协议类型为 `IPv4` 。

类型：[ProtocolType](net_package_structs.md#struct-protocoltype)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${ProtocolType.IPV4}")
    return 0
}
```

运行结果：

```text
toString: IPv4
```

### static let IPV6

```cangjie
public static let IPV6: ProtocolType = ProtocolType(41)
```

功能：指定协议类型为 `IPv6`。

类型：[ProtocolType](net_package_structs.md#struct-protocoltype)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${ProtocolType.IPV6}")
    return 0
}
```

运行结果：

```text
toString: IPv6
```

### static let RAW

```cangjie
public static let RAW: ProtocolType = ProtocolType(255)
```

功能：指定协议类型为 `RAW`。

类型：[ProtocolType](net_package_structs.md#struct-protocoltype)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${ProtocolType.RAW}")
    return 0
}
```

运行结果：

```text
toString: RAW
```

### static let TCP

```cangjie
public static let TCP: ProtocolType = ProtocolType(6)
```

功能：指定协议类型为 `TCP`。

类型：[ProtocolType](net_package_structs.md#struct-protocoltype)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${ProtocolType.TCP}")
    return 0
}
```

运行结果：

```text
toString: TCP
```

### static let UDP

```cangjie
public static let UDP: ProtocolType = ProtocolType(17)
```

功能：指定协议类型为 `UDP`。

类型：[ProtocolType](net_package_structs.md#struct-protocoltype)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${ProtocolType.UDP}")
    return 0
}
```

运行结果：

```text
toString: UDP
```

### static let Unspecified

```cangjie
public static let Unspecified: ProtocolType = ProtocolType(0)
```

功能：不指定协议类型。

类型：[ProtocolType](net_package_structs.md#struct-protocoltype)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${ProtocolType.Unspecified}")
    return 0
}
```

运行结果：

```text
toString: Unspecified
```

### init(Int32)

```cangjie
public init(protocol: Int32)
```

功能：通过指定套接字协议值创建协议。

参数：

- protocol: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 套接字协议值。

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 使用构造函数创建自定义的ProtocolType实例
    let customProtocol = ProtocolType(100)
    
    // 打印结果
    println("toString: ${customProtocol}")
    println("hashCode: ${customProtocol.hashCode()}")
    
    return 0
}
```

运行结果：

```text
toString: Protocol(100)
hashCode: 100
```

### func hashCode()

```cangjie
public func hashCode(): Int64
```

功能：返回当前 [ProtocolType](net_package_structs.md#struct-protocoltype) 实例的哈希值。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 当前 [ProtocolType](net_package_structs.md#struct-protocoltype) 实例的哈希值。

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 创建不同的ProtocolType实例
    let tcp = ProtocolType.TCP
    let udp = ProtocolType.UDP
    let custom = ProtocolType(100)
    
    // 获取并打印它们的哈希码
    println("TCP hashCode: ${tcp.hashCode()}")
    println("UDP hashCode: ${udp.hashCode()}")
    println("Custom hashCode: ${custom.hashCode()}")
    
    return 0
}
```

运行结果：

```text
TCP hashCode: 6
UDP hashCode: 17
Custom hashCode: 100
```

### func toString()

```cangjie
public func toString(): String
```

功能：返回当前 [ProtocolType](net_package_structs.md#struct-protocoltype) 实例的字符串表示。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 当前 [ProtocolType](net_package_structs.md#struct-protocoltype) 实例的字符串表示。

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 创建不同的ProtocolType实例
    let tcp = ProtocolType.TCP
    let udp = ProtocolType.UDP
    let custom = ProtocolType(100)
    
    // 获取并打印它们的字符串表示
    println("TCP toString: ${tcp.toString()}")
    println("UDP toString: ${udp.toString()}")
    println("Custom toString: ${custom.toString()}")
    
    return 0
}
```

运行结果：

```text
TCP toString: TCP
UDP toString: UDP
Custom toString: Protocol(100)
```

### operator func !=(ProtocolType)

```cangjie
public operator func !=(r: ProtocolType): Bool
```

功能：判断两个 [ProtocolType](net_package_structs.md#struct-protocoltype) 实例是否不等。

参数：

- r: [ProtocolType](net_package_structs.md#struct-protocoltype) - 参与比较的 [ProtocolType](net_package_structs.md#struct-protocoltype) 实例。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 当二者代表的 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 值不等时，返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 创建不同的ProtocolType实例
    let tcp = ProtocolType.TCP
    let udp = ProtocolType.UDP
    let custom1 = ProtocolType(100)
    let custom2 = ProtocolType(100)
    
    // 使用!=操作符比较它们
    let tcpNotUdp = tcp != udp
    let customNotTcp = custom1 != tcp
    let custom1NotCustom2 = custom1 != custom2
    
    println("TCP != UDP: ${tcpNotUdp}")
    println("Custom != TCP: ${customNotTcp}")
    println("Custom1 != Custom2: ${custom1NotCustom2}")
    
    return 0
}
```

运行结果：

```text
TCP != UDP: true
Custom != TCP: true
Custom1 != Custom2: false
```

### operator func ==(ProtocolType)

```cangjie
public operator func ==(r: ProtocolType): Bool
```

功能：判断两个 [ProtocolType](net_package_structs.md#struct-protocoltype) 实例是否相等。

参数：

- r: [ProtocolType](net_package_structs.md#struct-protocoltype) - 参与比较的 [ProtocolType](net_package_structs.md#struct-protocoltype) 实例。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 当二者代表的 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 值相等时，返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 创建不同的ProtocolType实例
    let tcp1 = ProtocolType.TCP
    let tcp2 = ProtocolType.TCP
    let udp = ProtocolType.UDP
    let custom1 = ProtocolType(100)
    let custom2 = ProtocolType(100)
    
    // 使用==操作符比较它们
    let tcp1EqualsTcp2 = tcp1 == tcp2
    let tcpEqualsUdp = tcp1 == udp
    let custom1EqualsCustom2 = custom1 == custom2
    
    println("TCP1 == TCP2: ${tcp1EqualsTcp2}")
    println("TCP == UDP: ${tcpEqualsUdp}")
    println("Custom1 == Custom2: ${custom1EqualsCustom2}")
    
    return 0
}
```

运行结果：

```text
TCP1 == TCP2: true
TCP == UDP: false
Custom1 == Custom2: true
```

## struct RawAddress

```cangjie
public struct RawAddress {
    public init(addr: Array<Byte>)
}
```

功能：提供了 [RawSocket](net_package_classes.md#class-rawsocket) 的通信地址创建和获取功能。

### prop addr

```cangjie
public prop addr: Array<Byte>
```

功能：获取地址。

类型：[Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 创建一个字节数组作为地址
    let addressBytes: Array<Byte> = [192, 168, 1, 1]
    
    // 使用字节数组创建RawAddress实例
    let rawAddress = RawAddress(addressBytes)
    
    // 获取并打印地址
    println("Address bytes: ${rawAddress.addr}")
    
    return 0
}
```

运行结果：

```text
Address bytes: [192, 168, 1, 1]
```

### init(Array\<Byte>)

```cangjie
public init(addr: Array<Byte>)
```

功能：根据字节数组创建地址。

参数：

- addr: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - 存储地址的字节数组。

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 创建一个字节数组作为地址
    let addressBytes: Array<Byte> = [10, 0, 0, 1]
    
    // 使用字节数组创建RawAddress实例
    let rawAddress = RawAddress(addressBytes)
    
    // 打印地址信息
    println("RawAddress created with bytes: ${rawAddress.addr}")
    
    return 0
}
```

运行结果：

```text
RawAddress created with bytes: [10, 0, 0, 1]
```

## struct SocketDomain

```cangjie
public struct SocketDomain <: Equatable<SocketDomain> & ToString & Hashable {
    public static let IPV4: SocketDomain = SocketDomain(2)
    public static let IPV6: SocketDomain
    public static let NETLINK: SocketDomain = SocketDomain(16)
    public static let PACKET: SocketDomain = SocketDomain(17)
    public static let UNIX: SocketDomain
    public init(domain: Int32)
}
```

功能：提供了常用的套接字通信域，以及通过指定 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 值来构建套接字通信域的功能。

父类型：

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[SocketDomain](#struct-socketdomain)>
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)

### static let IPV4

```cangjie
public static let IPV4: SocketDomain = SocketDomain(2)
```

功能：`IPv4` 通信域。

类型：[SocketDomain](net_package_structs.md#struct-socketdomain)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${SocketDomain.IPV4}")
    println("hashCode: ${SocketDomain.IPV4.hashCode()}")
    return 0
}
```

运行结果：

```text
toString: IPv4
hashCode: 2
```

### static let IPV6

```cangjie
public static let IPV6: SocketDomain
```

功能：`IPv6` 通信域。不同系统下的值分别为：

- macOS: SocketDomain(30)
- Windows: SocketDomain(23)
- 其他情况：SocketDomain(10)

类型：[SocketDomain](net_package_structs.md#struct-socketdomain)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${SocketDomain.IPV6}")
    println("hashCode: ${SocketDomain.IPV6.hashCode()}")
    return 0
}
```

运行结果：

```text
toString: IPv6
hashCode: 10
```

### static let NETLINK

```cangjie
public static let NETLINK: SocketDomain = SocketDomain(16)
```

功能：内核和用户空间进程之间通信。

> **注意：**
>
> 不支持平台：Windows、macOS、iOS。

类型：[SocketDomain](net_package_structs.md#struct-socketdomain)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${SocketDomain.NETLINK}")
    println("hashCode: ${SocketDomain.NETLINK.hashCode()}")
    return 0
}
```

运行结果：

```text
toString: netlink
hashCode: 16
```

### static let PACKET

```cangjie
public static let PACKET: SocketDomain = SocketDomain(17)
```

功能：允许用户空间程序直接访问网络数据包。

> **注意：**
>
> 不支持平台：Windows、macOS、iOS。

类型：[SocketDomain](net_package_structs.md#struct-socketdomain)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${SocketDomain.PACKET}")
    println("hashCode: ${SocketDomain.PACKET.hashCode()}")
    return 0
}
```

运行结果：

```text
toString: packet
hashCode: 17
```

### static let UNIX

```cangjie
public static let UNIX: SocketDomain
```

功能：本机通信。不同系统下的值分别为：

- Windows: SocketDomain(0)
- 其他情况：SocketDomain(1)

类型：[SocketDomain](net_package_structs.md#struct-socketdomain)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("toString: ${SocketDomain.UNIX}")
    println("hashCode: ${SocketDomain.UNIX.hashCode()}")
    return 0
}
```

运行结果：

```text
toString: unix
hashCode: 1
```

### init(Int32)

```cangjie
public init(domain: Int32)
```

功能：根据指定通信域值创建套接字通信域。

参数：

- domain: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 通信域值。

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 使用构造函数创建自定义的SocketDomain实例
    let customDomain = SocketDomain(100)
    
    // 打印结果
    println("toString: ${customDomain}")
    println("hashCode: ${customDomain.hashCode()}")
    
    return 0
}
```

运行结果：

```text
toString: Domain(100)
hashCode: 100
```

### func hashCode()

```cangjie
public func hashCode(): Int64
```

功能：返回当前 [SocketDomain](net_package_structs.md#struct-socketdomain) 实例的哈希值。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 当前 [SocketDomain](net_package_structs.md#struct-socketdomain) 实例的哈希值。

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 创建不同的SocketDomain实例
    let ipv4 = SocketDomain.IPV4
    let ipv6 = SocketDomain.IPV6
    let unix = SocketDomain.UNIX
    let custom = SocketDomain(100)
    
    // 获取并打印它们的哈希码
    println("IPv4 hashCode: ${ipv4.hashCode()}")
    println("IPv6 hashCode: ${ipv6.hashCode()}")
    println("UNIX hashCode: ${unix.hashCode()}")
    println("Custom hashCode: ${custom.hashCode()}")
    
    return 0
}
```

运行结果：

```text
IPv4 hashCode: 2
IPv6 hashCode: 10
UNIX hashCode: 1
Custom hashCode: 100
```

### func toString()

```cangjie
public func toString(): String
```

功能：返回当前 [SocketDomain](net_package_structs.md#struct-socketdomain) 实例的字符串表示。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 当前 [SocketDomain](net_package_structs.md#struct-socketdomain) 实例的字符串表示。

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 创建不同的SocketDomain实例
    let ipv4 = SocketDomain.IPV4
    let ipv6 = SocketDomain.IPV6
    let unix = SocketDomain.UNIX
    let custom = SocketDomain(100)
    
    // 获取并打印它们的字符串表示
    println("IPv4 toString: ${ipv4.toString()}")
    println("IPv6 toString: ${ipv6.toString()}")
    println("UNIX toString: ${unix.toString()}")
    println("Custom toString: ${custom.toString()}")
    
    return 0
}
```

运行结果：

```text
IPv4 toString: IPv4
IPv6 toString: IPv6
UNIX toString: unix
Custom toString: Domain(100)
```

### operator func !=(SocketDomain)

```cangjie
public operator func !=(r: SocketDomain): Bool
```

功能：比较两个 [SocketDomain](net_package_structs.md#struct-socketdomain) 实例是否不等。

参数：

- r: [SocketDomain](net_package_structs.md#struct-socketdomain) - 参与比较的 [SocketDomain](net_package_structs.md#struct-socketdomain) 实例。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 当二者代表的 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 值不等时，返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 创建不同的SocketDomain实例
    let ipv4 = SocketDomain.IPV4
    let ipv6 = SocketDomain.IPV6
    let unix = SocketDomain.UNIX
    let custom1 = SocketDomain(100)
    let custom2 = SocketDomain(100)
    
    // 使用!=操作符比较它们
    let ipv4NotIpv6 = ipv4 != ipv6
    let unixNotIpv4 = unix != ipv4
    let custom1NotCustom2 = custom1 != custom2
    
    println("IPv4 != IPv6: ${ipv4NotIpv6}")
    println("UNIX != IPv4: ${unixNotIpv4}")
    println("Custom1 != Custom2: ${custom1NotCustom2}")
    
    return 0
}
```

运行结果：

```text
IPv4 != IPv6: true
UNIX != IPv4: true
Custom1 != Custom2: false
```

### operator func ==(SocketDomain)

```cangjie
public operator func ==(r: SocketDomain): Bool
```

功能：比较两个 [SocketDomain](net_package_structs.md#struct-socketdomain) 实例是否相等。

参数：

- r: [SocketDomain](net_package_structs.md#struct-socketdomain) - 参与比较的 [SocketDomain](net_package_structs.md#struct-socketdomain) 实例。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 当二者代表的 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 值相等时，返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 创建不同的SocketDomain实例
    let ipv4a = SocketDomain.IPV4
    let ipv4b = SocketDomain.IPV4
    let ipv6 = SocketDomain.IPV6
    let custom1 = SocketDomain(100)
    let custom2 = SocketDomain(100)
    
    // 使用==操作符比较它们
    let ipv4aEqualsIpv4b = ipv4a == ipv4b
    let ipv4EqualsIpv6 = ipv4a == ipv6
    let custom1EqualsCustom2 = custom1 == custom2
    
    println("IPv4a == IPv4b: ${ipv4aEqualsIpv4b}")
    println("IPv4 == IPv6: ${ipv4EqualsIpv6}")
    println("Custom1 == Custom2: ${custom1EqualsCustom2}")
    
    return 0
}
```

运行结果：

```text
IPv4a == IPv4b: true
IPv4 == IPv6: false
Custom1 == Custom2: true
```

## struct SocketKeepAliveConfig

```cangjie
public struct SocketKeepAliveConfig <: ToString & Equatable<SocketKeepAliveConfig> {
    public let count: UInt32
    public let idle: Duration
    public let interval: Duration
    public init(idle!: Duration = Duration.second * 45, interval!: Duration = Duration.second * 5, count!: UInt32 = 5)
}
```

功能：TCP KeepAlive 属性配置。

父类型：

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[SocketKeepAliveConfig](#struct-socketkeepaliveconfig)>

### let count

```cangjie
public let count: UInt32
```

功能：查询连接是否失效的报文个数。

类型：[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 创建一个SocketKeepAliveConfig实例
    let config = SocketKeepAliveConfig()
    
    // 获取并打印count属性
    println("Count: ${config.count}")
    
    return 0
}
```

运行结果：

```text
Count: 5
```

### let idle

```cangjie
public let idle: Duration
```

功能：允许连接空闲的时长，空闲超长将关闭连接。

类型：[Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 创建一个SocketKeepAliveConfig实例
    let config = SocketKeepAliveConfig()
    
    // 获取并打印idle属性
    println("Idle duration: ${config.idle}")
    
    return 0
}
```

运行结果：

```text
Idle duration: 45s
```

### let interval

```cangjie
public let interval: Duration
```

功能：保活报文发送周期。

类型：[Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 创建一个SocketKeepAliveConfig实例
    let config = SocketKeepAliveConfig()
    
    // 获取并打印interval属性
    println("Interval duration: ${config.interval}")
    
    return 0
}
```

运行结果：

```text
Interval duration: 5s
```

### init(Duration, Duration, UInt32)

```cangjie
public init(idle!: Duration = Duration.second * 45, interval!: Duration = Duration.second * 5, count!: UInt32 = 5)
```

功能：初始化 [SocketKeepAliveConfig](net_package_structs.md#struct-socketkeepaliveconfig) 实例对象。

参数：

- idle!: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - 允许空闲的时长，默认 45 秒。
- interval!: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - 保活报文发送周期，默认 45 秒。
- count!: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - 查询连接是否失效的报文个数， 默认 5 个。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当配置为空闲状态或设置间隔小于 0 时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 使用自定义参数创建SocketKeepAliveConfig实例
    let config = SocketKeepAliveConfig(
        idle: Duration.second * 30,
        interval: Duration.second * 10,
        count: 3
    )
    
    // 打印配置信息
    println("Idle: ${config.idle}")
    println("Interval: ${config.interval}")
    println("Count: ${config.count}")
    
    return 0
}
```

运行结果：

```text
Idle: 30s
Interval: 10s
Count: 3
```

### func toString()

```cangjie
public override func toString(): String
```

功能：将 TCP KeepAlive 属性配置转换为字符串。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 转换后的字符串。

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 创建一个SocketKeepAliveConfig实例
    let config = SocketKeepAliveConfig(
        idle: Duration.second * 30,
        interval: Duration.second * 10,
        count: 3
    )
    
    // 获取并打印toString结果
    println("ToString: ${config.toString()}")
    
    return 0
}
```

运行结果：

```text
ToString: SocketKeepAliveConfig(idle: 30s, interval: 10s, count: 3)
```

### operator func !=(SocketKeepAliveConfig)

```cangjie
public override operator func !=(other: SocketKeepAliveConfig): Bool
```

功能：判断两个 [SocketKeepAliveConfig](net_package_structs.md#struct-socketkeepaliveconfig) 实例是否不等。

参数：

- other: [SocketKeepAliveConfig](net_package_structs.md#struct-socketkeepaliveconfig) - 参与比较的 [SocketKeepAliveConfig](net_package_structs.md#struct-socketkeepaliveconfig) 实例。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果不等，则返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 创建两个相同的SocketKeepAliveConfig实例
    let config1 = SocketKeepAliveConfig(
        idle: Duration.second * 30,
        interval: Duration.second * 10,
        count: 3
    )
    
    let config2 = SocketKeepAliveConfig(
        idle: Duration.second * 30,
        interval: Duration.second * 10,
        count: 3
    )
    
    // 创建一个不同的SocketKeepAliveConfig实例
    let config3 = SocketKeepAliveConfig(
        idle: Duration.second * 60,
        interval: Duration.second * 10,
        count: 3
    )
    
    // 使用!=操作符比较它们
    let notEqual1 = config1 != config2
    let notEqual2 = config1 != config3
    
    println("Config1 != Config2: ${notEqual1}")
    println("Config1 != Config3: ${notEqual2}")
    
    return 0
}
```

运行结果：

```text
Config1 != Config2: false
Config1 != Config3: true
```

### operator func ==(SocketKeepAliveConfig)

```cangjie
public override operator func ==(other: SocketKeepAliveConfig): Bool
```

功能：判断两个 [SocketKeepAliveConfig](net_package_structs.md#struct-socketkeepaliveconfig) 实例是否相等。

参数：

- other: [SocketKeepAliveConfig](net_package_structs.md#struct-socketkeepaliveconfig) - 参与比较的 [SocketKeepAliveConfig](net_package_structs.md#struct-socketkeepaliveconfig) 实例。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果相等，则返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 创建两个相同的SocketKeepAliveConfig实例
    let config1 = SocketKeepAliveConfig(
        idle: Duration.second * 30,
        interval: Duration.second * 10,
        count: 3
    )
    
    let config2 = SocketKeepAliveConfig(
        idle: Duration.second * 30,
        interval: Duration.second * 10,
        count: 3
    )
    
    // 创建一个不同的SocketKeepAliveConfig实例
    let config3 = SocketKeepAliveConfig(
        idle: Duration.second * 60,
        interval: Duration.second * 10,
        count: 3
    )
    
    // 使用==操作符比较它们
    let equal1 = config1 == config2
    let equal2 = config1 == config3
    
    println("Config1 == Config2: ${equal1}")
    println("Config1 == Config3: ${equal2}")
    
    return 0
}
```

运行结果：

```text
Config1 == Config2: true
Config1 == Config3: false
```

## struct SocketOptions

```cangjie
public struct SocketOptions {
    public static const IPPROTO_TCP: Int32 = 6
    public static const IPPROTO_UDP: Int32 = 17
    public static const SOL_SOCKET: Int32
    public static const SO_BINDTODEVICE: Int32
    public static const SO_KEEPALIVE: Int32
    public static const SO_LINGER: Int32
    public static const SO_RCVBUF: Int32
    public static const SO_REUSEADDR: Int32
    public static const SO_REUSEPORT: Int32
    public static const SO_SNDBUF: Int32
    public static const TCP_NODELAY: Int32 = 0x0001
    public static const TCP_QUICKACK: Int32
}
```

功能：[SocketOptions](net_package_structs.md#struct-socketoptions) 存储了设置套接字选项的一些参数常量方便后续调用。

### static const IPPROTO_TCP <sup>(deprecated)</sup>

```cangjie
public static const IPPROTO_TCP: Int32 = 6
```

功能：常数，用于将套接字选项的 `level` 层级设为 `IPPROTO_TCP`。

> **注意：**
>
> 未来版本即将废弃不再使用，使用 [OptionLevel.TCP](#static-const-tcp) 替代。

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("IPPROTO_TCP: ${SocketOptions.IPPROTO_TCP}")
    
    return 0
}
```

运行结果：

```text
IPPROTO_TCP: 6
```

### static const IPPROTO_UDP <sup>(deprecated)</sup>

```cangjie
public static const IPPROTO_UDP: Int32 = 17
```

功能：常数，用于将套接字选项的 `level` 层级设为 `IPPROTO_UDP`。

> **注意：**
>
> 未来版本即将废弃不再使用，使用 [OptionLevel.UDP](#static-const-udp) 替代。

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("IPPROTO_UDP: ${SocketOptions.IPPROTO_UDP}")
    
    return 0
}
```

运行结果：

```text
IPPROTO_UDP: 17
```

### static const SO_BINDTODEVICE

```cangjie
public static const SO_BINDTODEVICE: Int32
```

功能：常数，用于将套接字选项的 `optname` 设为 `SO_BINDTODEVICE`。不同系统下的值分别为：

- macOS: 0xFFFF
- Windows: 0xFFFF
- 其他情况：0x0019

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("SO_BINDTODEVICE: ${SocketOptions.SO_BINDTODEVICE}")
    
    return 0
}
```

运行结果：

```text
SO_BINDTODEVICE: 25
```

### static const SO_KEEPALIVE

```cangjie
public static const SO_KEEPALIVE: Int32
```

功能：常数，用于将套接字选项的 `optname` 设为 `SO_KEEPALIVE`。不同系统下的值分别为：

- macOS: 0x0008
- Windows: 0x0008
- 其他情况：0x0009

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("SO_KEEPALIVE: ${SocketOptions.SO_KEEPALIVE}")
    
    return 0
}
```

运行结果：

```text
SO_KEEPALIVE: 9
```

### static const SO_LINGER

```cangjie
public static const SO_LINGER: Int32
```

功能：常数，用于将套接字选项的 `optname` 设为 `SO_LINGER`。不同系统下的值分别为：

- macOS: 0x0080
- Windows: 0x0080
- 其他情况：0x000D

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("SO_LINGER: ${SocketOptions.SO_LINGER}")
    
    return 0
}
```

运行结果：

```text
SO_LINGER: 13
```

### static const SO_RCVBUF

```cangjie
public static const SO_RCVBUF: Int32
```

功能：常数，用于将套接字选项的 `optname` 设为 `SO_RCVBUF`。不同系统下的值分别为：

- macOS: 0x1002
- Windows: 0x1002
- 其他情况：0x0008

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("SO_RCVBUF: ${SocketOptions.SO_RCVBUF}")
    
    return 0
}
```

运行结果：

```text
SO_RCVBUF: 8
```

### static const SO_REUSEADDR

```cangjie
public static const SO_REUSEADDR: Int32
```

功能：常数，用于将套接字选项的 `optname` 设为 `SO_REUSEADDR`。不同系统下的值分别为：

- macOS: 0x0004
- Windows: 0x0004
- 其他情况：0x0002

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("SO_REUSEADDR: ${SocketOptions.SO_REUSEADDR}")
    
    return 0
}
```

运行结果：

```text
SO_REUSEADDR: 2
```

### static const SO_REUSEPORT

```cangjie
public static const SO_REUSEPORT: Int32
```

功能：常数，用于将套接字选项的 `optname` 设为 `SO_REUSEPORT`。不同系统下的值分别为：

- macOS: 0x0200
- Windows: 0xFFFF
- 其他情况：0x000F

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("SO_REUSEPORT: ${SocketOptions.SO_REUSEPORT}")
    
    return 0
}
```

运行结果：

```text
SO_REUSEPORT: 15
```

### static const SO_SNDBUF

```cangjie
public static const SO_SNDBUF: Int32
```

功能：常数，用于将套接字选项的 `optname` 设为 `SO_SNDBUF`。不同系统下的值分别为：

- macOS: 0x1001
- Windows: 0x1001
- 其他情况：0x0007

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("SO_SNDBUF: ${SocketOptions.SO_SNDBUF}")
    
    return 0
}
```

运行结果：

```text
SO_SNDBUF: 7
```

### static const SOL_SOCKET <sup>(deprecated)</sup>

```cangjie
public static const SOL_SOCKET: Int32
```

功能：常数，用于将套接字选项的 `level` 层级设为 `SOL_SOCKET`。不同系统下的值分别为：

- macOS: 0xFFFF
- Windows: 0xFFFF
- 其他情况：1

> **注意：**
>
> 未来版本即将废弃不再使用，使用 [OptionLevel.SOCKET](#static-const-socket) 替代。

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("SOL_SOCKET: ${SocketOptions.SOL_SOCKET}")
    
    return 0
}
```

运行结果：

```text
SOL_SOCKET: 1
```

### static const TCP_NODELAY

```cangjie
public static const TCP_NODELAY: Int32 = 0x0001
```

功能：常数，用于将套接字选项的 `optname` 设为 `TCP_NODELAY`。

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("TCP_NODELAY: ${SocketOptions.TCP_NODELAY}")
    
    return 0
}
```

运行结果：

```text
TCP_NODELAY: 1
```

### static const TCP_QUICKACK

```cangjie
public static const TCP_QUICKACK: Int32
```

功能：常数，用于将套接字选项的 `optname` 设为 `TCP_QUICKACK`。不同系统下的值分别为：

- macOS: 0xFFFF
- Windows: 0xFFFF
- 其他情况：0x000C

类型：[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("TCP_QUICKACK: ${SocketOptions.TCP_QUICKACK}")
    
    return 0
}
```

运行结果：

```text
TCP_QUICKACK: 12
```

## struct SocketType

```cangjie
public struct SocketType <: Equatable<SocketType> & ToString & Hashable {
    public static let DATAGRAM: SocketType = SocketType(2)
    public static let RAW: SocketType = SocketType(3)
    public static let SEQPACKET: SocketType = SocketType(5)
    public static let STREAM: SocketType = SocketType(1)
    public init(`type`: Int32)
}
```

功能：提供了常用的套接字类型，以及通过指定 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 值来构建套接字类型的功能。

父类型：

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[SocketType](#struct-sockettype)>
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)

### static let DATAGRAM

```cangjie
public static let DATAGRAM: SocketType = SocketType(2)
```

功能：数据报套接字类型。

类型：[SocketType](net_package_structs.md#struct-sockettype)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("DATAGRAM: ${SocketType.DATAGRAM}")
    println("DATAGRAM hashCode: ${SocketType.DATAGRAM.hashCode()}")
    
    return 0
}
```

运行结果：

```text
DATAGRAM: DATAGRAM
DATAGRAM hashCode: 2
```

### static let RAW

```cangjie
public static let RAW: SocketType = SocketType(3)
```

功能：原始套接字类型。

类型：[SocketType](net_package_structs.md#struct-sockettype)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("RAW: ${SocketType.RAW}")
    println("RAW hashCode: ${SocketType.RAW.hashCode()}")
    
    return 0
}
```

运行结果：

```text
RAW: RAW
RAW hashCode: 3
```

### static let SEQPACKET

```cangjie
public static let SEQPACKET: SocketType = SocketType(5)
```

功能：有序数据包套接字类型。

类型：[SocketType](net_package_structs.md#struct-sockettype)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("SEQPACKET: ${SocketType.SEQPACKET}")
    println("SEQPACKET hashCode: ${SocketType.SEQPACKET.hashCode()}")
    
    return 0
}
```

运行结果：

```text
SEQPACKET: SEQPACKET
SEQPACKET hashCode: 5
```

### static let STREAM

```cangjie
public static let STREAM: SocketType = SocketType(1)
```

功能：流式套接字类型。

类型：[SocketType](net_package_structs.md#struct-sockettype)

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    println("STREAM: ${SocketType.STREAM}")
    println("STREAM hashCode: ${SocketType.STREAM.hashCode()}")
    
    return 0
}
```

运行结果：

```text
STREAM: STREAM
STREAM hashCode: 1
```

### init(Int32)

```cangjie
public init(`type`: Int32)
```

功能：通过指定套接字类型值创建套接字类型。

参数：

- \`type`: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - 套接字类型值。

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 使用构造函数创建自定义的SocketType实例
    let customSocketType = SocketType(100)
    
    // 打印结果
    println("Custom SocketType: ${customSocketType}")
    println("Custom SocketType hashCode: ${customSocketType.hashCode()}")
    
    return 0
}
```

运行结果：

```text
Custom SocketType: Type(100)
Custom SocketType hashCode: 100
```

### func hashCode()

```cangjie
public func hashCode(): Int64
```

功能：返回当前 [SocketType](net_package_structs.md#struct-sockettype) 实例的哈希值。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 当前 [SocketType](net_package_structs.md#struct-sockettype) 实例的哈希值。

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 创建不同的SocketType实例
    let datagram = SocketType.DATAGRAM
    let stream = SocketType.STREAM
    let custom = SocketType(100)
    
    // 获取并打印它们的哈希码
    println("DATAGRAM hashCode: ${datagram.hashCode()}")
    println("STREAM hashCode: ${stream.hashCode()}")
    println("Custom hashCode: ${custom.hashCode()}")
    
    return 0
}
```

运行结果：

```text
DATAGRAM hashCode: 2
STREAM hashCode: 1
Custom hashCode: 100
```

### func toString()

```cangjie
public func toString(): String
```

功能：返回当前 [SocketType](net_package_structs.md#struct-sockettype) 实例的字符串表示。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 当前 [SocketType](net_package_structs.md#struct-sockettype) 实例的字符串表示。

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 创建不同的SocketType实例
    let datagram = SocketType.DATAGRAM
    let stream = SocketType.STREAM
    let custom = SocketType(100)
    
    // 获取并打印它们的字符串表示
    println("DATAGRAM toString: ${datagram.toString()}")
    println("STREAM toString: ${stream.toString()}")
    println("Custom toString: ${custom.toString()}")
    
    return 0
}
```

运行结果：

```text
DATAGRAM toString: DATAGRAM
STREAM toString: STREAM
Custom toString: Type(100)
```

### operator func !=(SocketType)

```cangjie
public operator func !=(r: SocketType): Bool
```

功能：判断两个 [SocketType](net_package_structs.md#struct-sockettype) 实例是否不等。

参数：

- r: [SocketType](net_package_structs.md#struct-sockettype) - 参与比较的 [SocketType](net_package_structs.md#struct-sockettype) 实例。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 当二者代表的 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 值不等时，返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 创建不同的SocketType实例
    let datagram = SocketType.DATAGRAM
    let stream = SocketType.STREAM
    let custom1 = SocketType(100)
    let custom2 = SocketType(100)
    
    // 使用!=操作符比较它们
    let datagramNotStream = datagram != stream
    let custom1NotCustom2 = custom1 != custom2
    
    println("DATAGRAM != STREAM: ${datagramNotStream}")
    println("Custom1 != Custom2: ${custom1NotCustom2}")
    
    return 0
}
```

运行结果：

```text
DATAGRAM != STREAM: true
Custom1 != Custom2: false
```

### operator func ==(SocketType)

```cangjie
public operator func ==(r: SocketType): Bool
```

功能：判断两个 [SocketType](net_package_structs.md#struct-sockettype) 实例是否相等。

参数：

- r: [SocketType](net_package_structs.md#struct-sockettype) - 参与比较的 [SocketType](net_package_structs.md#struct-sockettype) 实例。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 当二者代表的 [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) 值相等时，返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.net.*

main(): Int64 {
    // 创建不同的SocketType实例
    let datagram1 = SocketType.DATAGRAM
    let datagram2 = SocketType.DATAGRAM
    let stream = SocketType.STREAM
    let custom1 = SocketType(100)
    let custom2 = SocketType(100)
    
    // 使用==操作符比较它们
    let datagram1EqualsDatagram2 = datagram1 == datagram2
    let datagramEqualsStream = datagram1 == stream
    let custom1EqualsCustom2 = custom1 == custom2
    
    println("DATAGRAM1 == DATAGRAM2: ${datagram1EqualsDatagram2}")
    println("DATAGRAM == STREAM: ${datagramEqualsStream}")
    println("Custom1 == Custom2: ${custom1EqualsCustom2}")
    
    return 0
}
```

运行结果：

```text
DATAGRAM1 == DATAGRAM2: true
DATAGRAM == STREAM: false
Custom1 == Custom2: true
```
