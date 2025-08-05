# Structures

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

Functionality: [AddressFamily](net_package_structs.md#struct-addressfamily) is used to indicate the addressing scheme of a `Socket`, with commonly used families being `INET` / `INET6` / `UNIX`. The address family identifiers were originally defined in [RFC 2453](https://datatracker.ietf.org/doc/html/rfc2453).

Parent Types:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[AddressFamily](#struct-addressfamily)>

### static const INET

```cangjie
public static const INET = AddressFamily("INET", 2)
```

Functionality: IPv4 address family.

Type: [AddressFamily](net_package_structs.md#struct-addressfamily)

### static const INET6

```cangjie
public static const INET6: AddressFamily
```

Functionality: IPv6 address family. Values vary by system:

- macOS: AddressFamily("INET6", 30)
- Windows: AddressFamily("INET6", 23)
- Others: AddressFamily("INET6", 10)

Type: [AddressFamily](net_package_structs.md#struct-addressfamily)

### static const NETLINK

```cangjie
public static const NETLINK: AddressFamily
```

Functionality: NetLink address family, supported only on Linux:

- Linux: AddressFamily("NETLINK", 16)

Type: [AddressFamily](net_package_structs.md#struct-addressfamily)

### static const UNIX

```cangjie
public static const UNIX = AddressFamily("UNIX", 1)
```

Functionality: Unix domain socket address family.

Type: [AddressFamily](net_package_structs.md#struct-addressfamily)

### static const UNSPEC

```cangjie
public static const UNSPEC = AddressFamily("UNSPEC", 0)
```

Functionality: Unspecified address family.

Type: [AddressFamily](net_package_structs.md#struct-addressfamily)

### let name

```cangjie
public let name: String
```

Functionality: Address family name.

Type: [String](../../../std_en/core/core_package_api/core_package_structs.md#struct-string)

### let value

```cangjie
public let value: UInt16
```

Functionality: Address family value.

Type: [UInt16](../../../std_en/core/core_package_api/core_package_intrinsics.md#uint16)

### init(String, UInt16)

```cangjie
public const init(name: String, value: UInt16)
```

Functionality: Constant constructor for creating [AddressFamily](net_package_structs.md#struct-addressfamily) objects.

Parameters:

- name: [String](../../../std_en/core/core_package_api/core_package_structs.md#struct-string) - Address family name.
- value: [UInt16](../../../std_en/core/core_package_api/core_package_intrinsics.md#uint16) - Address family value.

### func toString()

```cangjie
public func toString(): String
```

Functionality: Gets the name corresponding to the address family.

Return Value:

- [String](../../../std_en/core/core_package_api/core_package_structs.md#struct-string) - Name of the current address family.

### operator func ==(AddressFamily)

```cangjie
public operator func ==(rhs: AddressFamily): Bool
```

Functionality: Compares whether address family values are equal.

Parameters:

- rhs: [AddressFamily](net_package_structs.md#struct-addressfamily) - The [AddressFamily](net_package_structs.md#struct-addressfamily) object to compare.

Return Value:

- [Bool](../../../std_en/core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the two [AddressFamily](net_package_structs.md#struct-addressfamily) objects are equal; otherwise, returns `false`.

### operator func !=(AddressFamily)

```cangjie
public operator func !=(rhs: AddressFamily): Bool
```

Functionality: Compares whether address family values are unequal.

Parameters:

- rhs: [AddressFamily](net_package_structs.md#struct-addressfamily) - The [AddressFamily](net_package_structs.md#struct-addressfamily) object to compare.

Return Value:

- [Bool](../../../std_en/core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the two [AddressFamily](net_package_structs.md#struct-addressfamily) objects are unequal; otherwise, returns `false`.

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

Functionality: Provides commonly used socket option levels.

### static const ICMP

```cangjie
public static const ICMP: Int32 = 1
```

Functionality: Socket option level for controlling `ICMP` protocol behavior.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### static const IP

```cangjie
public static const IP: Int32 = 0
```

Functionality: Socket option level for controlling [IP]() protocol behavior.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### static const RAW

```cangjie
public static const RAW: Int32 = 255
```

Functionality: Socket option level for controlling `RAW` protocol behavior.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### static const SOCKET

```cangjie
public static const SOCKET: Int32
```

Functionality: Socket option level for controlling basic socket behavior. Values vary by system:

- macOS: 0xFFFF
- Windows: 0xFFFF
- Others: 1

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### static const TCP

```cangjie
public static const TCP: Int32 = 6
```

Functionality: Socket option level for controlling `TCP` protocol behavior.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### static const UDP

```cangjie
public static const UDP: Int32 = 17
```

Functionality: Socket option level for controlling `UDP` protocol behavior.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

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

Functionality: Provides commonly used socket options.

### static const IP_HDRINCL

```cangjie
public static const IP_HDRINCL: Int32
```

Functionality: Socket option for specifying whether the [IP]() header is provided by the application when sending packets. Values vary by system:

- macOS: 0x0002
- Windows: 0x0002
- Others: 0x0003

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### static const IP_TOS

```cangjie
public static const IP_TOS: Int32
```

Functionality: Socket option for specifying packet service type and priority. Values vary by system:

- macOS: 0x0003
- Windows: 0x0003
- Others: 0x0001

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### static const IP_TTL

```cangjie
public static const IP_TTL: Int32
```

Functionality: Socket option for limiting the maximum number of hops an [IP]() packet can traverse in the network. Values vary by system:- macOS: 0x0004
- Windows: 0x0004
- Other cases: 0x0002

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### static const SO_ACCEPTCONN

```cangjie
public static const SO_ACCEPTCONN: Int32
```

Function: A socket option used to query whether a socket is in listening state. Values across different systems are:

- macOS: 0x0002
- Windows: 0x0002
- Other cases: 0x001E

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### static const SO_BROADCAST

```cangjie
public static const SO_BROADCAST: Int32
```

Function: A socket option to enable/disable broadcast message transmission. Values across different systems are:

- macOS: 0x0020
- Windows: 0x0020
- Other cases: 0x0006

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### static const SO_DEBUG

```cangjie
public static const SO_DEBUG: Int32 = 0x0001
```

Function: A socket option to enable/disable debug mode.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### static const SO_DONTROUTE

```cangjie
public static const SO_DONTROUTE: Int32
```

Function: A socket option to bypass routing when sending socket packets. Values across different systems are:

- macOS: 0x0010
- Windows: 0x0010
- Other cases: 0x0005

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### static const SO_ERROR

```cangjie
public static const SO_ERROR: Int32
```

Function: A socket option to get and clear error status on a socket. Values across different systems are:

- macOS: 0x1007
- Windows: 0x1007
- Other cases: 0x0004

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### static const SO_KEEPALIVE

```cangjie
public static const SO_KEEPALIVE: Int32
```

Function: A socket option to detect whether a `TCP` connection remains active. Values across different systems are:

- macOS: 0x0008
- Windows: 0x0008
- Other cases: 0x0009

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### static const SO_LINGER

```cangjie
public static const SO_LINGER: Int32
```

Function: A socket option to configure socket behavior upon closure. Values across different systems are:

- macOS: 0x0080
- Windows: 0x0080
- Other cases: 0x000D

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### static const SO_OOBINLINE

```cangjie
public static const SO_OOBINLINE: Int32
```

Function: A socket option to control out-of-band data reception. Values across different systems are:

- macOS: 0x0100
- Windows: 0x0100
- Other cases: 0x000A

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### static const SO_RCVBUF

```cangjie
public static const SO_RCVBUF: Int32
```

Function: A socket option to set receive buffer size. Values across different systems are:

- macOS: 0x1002
- Windows: 0x1002
- Other cases: 0x0008

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### static const SO_RCVTIMEO

```cangjie
public static const SO_RCVTIMEO: Int32
```

Function: A socket option to set receive timeout. Values across different systems are:

- macOS: 0x1006
- Windows: 0x1006
- Other cases: 0x0014

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### static const SO_REUSEADDR

```cangjie
public static const SO_REUSEADDR: Int32
```

Function: A socket option to immediately release a bound port after socket closure for reuse. Values across different systems are:

- macOS: 0x0004
- Windows: 0x0004
- Other cases: 0x0002

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### static const SO_SNDBUF

```cangjie
public static const SO_SNDBUF: Int32
```

Function: A socket option to set send buffer size. Values across different systems are:

- macOS: 0x1001
- Windows: 0x1001
- Other cases: 0x0007

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### static const SO_SNDTIMEO

```cangjie
public static const SO_SNDTIMEO: Int32
```

Function: A socket option to set send timeout. Values across different systems are:

- macOS: 0x1005
- Windows: 0x1005
- Other cases: 0x0015

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### static const TCP_KEEPCNT

```cangjie
public static const TCP_KEEPCNT: Int32
```

Function: A socket option to control the number of TCP keepalive probes. Values across different systems are:

- macOS: 0x0102
- Windows: 0x0010
- Other cases: 0x0006

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### static const TCP_KEEPIDLE

```cangjie
public static const TCP_KEEPIDLE: Int32
```

Function: A socket option to set the maximum number of `TCP` keepalive attempts without peer acknowledgment. Values across different systems are:

- macOS: 0x0010
- Windows: 0x0003
- Other cases: 0x0004

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### static const TCP_KEEPINTVL

```cangjie
public static const TCP_KEEPINTVL: Int32
```

Function: A socket option to set the interval between `TCP` keepalive probes. Values across different systems are:

- macOS: 0x0101
- Windows: 0x0011
- Other cases: 0x0005

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### static const TCP_NODELAY

```cangjie
public static const TCP_NODELAY: Int32 = 0x0001
```

Function: A socket option to control `TCP` protocol delay behavior.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

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

Function: Provides common socket protocols and the ability to construct socket protocols by specifying [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) values.

Parent types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[ProtocolType](#struct-protocoltype)>
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)

### static let ICMP

```cangjie
public static let ICMP: ProtocolType = ProtocolType(1)
```

Function: Specifies protocol type as `ICMP`.

Type: [ProtocolType](net_package_structs.md#struct-protocoltype)

### static let IPV4

```cangjie
public static let IPV4: ProtocolType = ProtocolType(4)
```

Function: Specifies protocol type as `IPv4`.

Type: [ProtocolType](net_package_structs.md#struct-protocoltype)

### static let IPV6

```cangjie
public static let IPV6: ProtocolType = ProtocolType(41)
```

Function: Specifies protocol type as `IPv6`.

Type: [ProtocolType](net_package_structs.md#struct-protocoltype)

### static let RAW

```cangjie
public static let RAW: ProtocolType = ProtocolType(255)
```

Function: Specifies protocol type as `RAW`.

Type: [ProtocolType](net_package_structs.md#struct-protocoltype)### static let TCP

```cangjie
public static let TCP: ProtocolType = ProtocolType(6)
```

Function: Specifies the protocol type as `TCP`.

Type: [ProtocolType](net_package_structs.md#struct-protocoltype)

### static let UDP

```cangjie
public static let UDP: ProtocolType = ProtocolType(17)
```

Function: Specifies the protocol type as `UDP`.

Type: [ProtocolType](net_package_structs.md#struct-protocoltype)

### static let Unspecified

```cangjie
public static let Unspecified: ProtocolType = ProtocolType(0)
```

Function: Does not specify a protocol type.

Type: [ProtocolType](net_package_structs.md#struct-protocoltype)

### init(Int32)

```cangjie
public init(protocol: Int32)
```

Function: Creates a protocol by specifying a socket protocol value.

Parameters:

- protocol: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The socket protocol value.

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Returns the hash value of the current [ProtocolType](net_package_structs.md#struct-protocoltype) instance.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The hash value of the current [ProtocolType](net_package_structs.md#struct-protocoltype) instance.

### func toString()

```cangjie
public func toString(): String
```

Function: Returns the string representation of the current [ProtocolType](net_package_structs.md#struct-protocoltype) instance.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of the current [ProtocolType](net_package_structs.md#struct-protocoltype) instance.

### operator func !=(ProtocolType)

```cangjie
public operator func !=(r: ProtocolType): Bool
```

Function: Determines whether two [ProtocolType](net_package_structs.md#struct-protocoltype) instances are not equal.

Parameters:

- r: [ProtocolType](net_package_structs.md#struct-protocoltype) - The [ProtocolType](net_package_structs.md#struct-protocoltype) instance to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) values they represent are not equal; otherwise, returns `false`.

### operator func ==(ProtocolType)

```cangjie
public operator func ==(r: ProtocolType): Bool
```

Function: Determines whether two [ProtocolType](net_package_structs.md#struct-protocoltype) instances are equal.

Parameters:

- r: [ProtocolType](net_package_structs.md#struct-protocoltype) - The [ProtocolType](net_package_structs.md#struct-protocoltype) instance to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) values they represent are equal; otherwise, returns `false`.

## struct RawAddress

```cangjie
public struct RawAddress {
    public init(addr: Array<Byte>)
}
```

Function: Provides functionality for creating and retrieving communication addresses for [RawSocket](net_package_classes.md#class-rawsocket).

### prop addr

```cangjie
public prop addr: Array<Byte>
```

Function: Retrieves the address.

Type: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>

### init(Array\<Byte>)

```cangjie
public init(addr: Array<Byte>)
```

Function: Creates an address from a byte array.

Parameters:

- addr: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - The byte array storing the address.

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

Function: Provides commonly used socket communication domains and the ability to construct socket communication domains by specifying an [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) value.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[SocketDomain](#struct-socketdomain)>
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)

### static let IPV4

```cangjie
public static let IPV4: SocketDomain = SocketDomain(2)
```

Function: `IPv4` communication domain.

Type: [SocketDomain](net_package_structs.md#struct-socketdomain)

### static let IPV6

```cangjie
public static let IPV6: SocketDomain
```

Function: `IPv6` communication domain. Values vary by system:

- macOS: SocketDomain(30)
- Windows: SocketDomain(23)
- Other cases: SocketDomain(10)

Type: [SocketDomain](net_package_structs.md#struct-socketdomain)

### static let NETLINK

```cangjie
public static let NETLINK: SocketDomain = SocketDomain(16)
```

Function: Communication between the kernel and user-space processes.

> **Note:**
>
> This constant is not available on Windows and macOS platforms.

Type: [SocketDomain](net_package_structs.md#struct-socketdomain)

### static let PACKET

```cangjie
public static let PACKET: SocketDomain = SocketDomain(17)
```

Function: Allows user-space programs to directly access network packets.

> **Note:**
>
> This constant is not available on Windows and macOS platforms.

Type: [SocketDomain](net_package_structs.md#struct-socketdomain)

### static let UNIX

```cangjie
public static let UNIX: SocketDomain
```

Function: Local communication. Values vary by system:

- Windows: SocketDomain(0)
- Other cases: SocketDomain(1)

Type: [SocketDomain](net_package_structs.md#struct-socketdomain)

### init(Int32)

```cangjie
public init(domain: Int32)
```

Function: Creates a socket communication domain by specifying a domain value.

Parameters:

- domain: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The domain value.

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Returns the hash value of the current [SocketDomain](net_package_structs.md#struct-socketdomain) instance.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The hash value of the current [SocketDomain](net_package_structs.md#struct-socketdomain) instance.

### func toString()

```cangjie
public func toString(): String
```

Function: Returns the string representation of the current [SocketDomain](net_package_structs.md#struct-socketdomain) instance.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of the current [SocketDomain](net_package_structs.md#struct-socketdomain) instance.

### operator func !=(SocketDomain)

```cangjie
public operator func !=(r: SocketDomain): Bool
```

Function: Determines whether two [SocketDomain](net_package_structs.md#struct-socketdomain) instances are not equal.

Parameters:

- r: [SocketDomain](net_package_structs.md#struct-socketdomain) - The [SocketDomain](net_package_structs.md#struct-socketdomain) instance to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) values they represent are not equal; otherwise, returns `false`.

### operator func ==(SocketDomain)

```cangjie
public operator func ==(r: SocketDomain): Bool
```

Function: Determines whether two [SocketDomain](net_package_structs.md#struct-socketdomain) instances are equal.

Parameters:

- r: [SocketDomain](net_package_structs.md#struct-socketdomain) - The [SocketDomain](net_package_structs.md#struct-socketdomain) instance to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) values they represent are equal; otherwise, returns `false`.

## struct SocketKeepAliveConfig

```cangjie
public struct SocketKeepAliveConfig <: ToString & Equatable<SocketKeepAliveConfig> {
    public let count: UInt32
    public let idle: Duration
    public let interval: Duration
    public init(idle!: Duration = Duration.second * 45, interval!: Duration = Duration.second * 5, count!: UInt32 = 5)
}
```

Function: TCP KeepAlive property configuration.

Parent Types:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[SocketKeepAliveConfig](#struct-socketkeepaliveconfig)>

### let count

```cangjie
public let count: UInt32
```

Function: Number of probe packets to check if the connection is invalid.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

### let idle

```cangjie
public let idle: Duration
```

Function: Maximum allowed idle duration before closing the connection.

Type: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

### let interval

```cangjie
public let interval: Duration
```

Function: Keep-alive packet transmission interval.

Type: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

### init(Duration, Duration, UInt32)

```cangjie
public init(idle!: Duration = Duration.second * 45, interval!: Duration = Duration.second * 5, count!: UInt32 = 5)
```

Function: Initializes a [SocketKeepAliveConfig](net_package_structs.md#struct-socketkeepaliveconfig) instance.

Parameters:

- idle!: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - Allowed idle duration, default 45 seconds.
- interval!: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - Keep-alive packet transmission interval, default 5 seconds.
- count!: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Number of probe packets, default 5.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when idle configuration is null or interval is set to less than 0.

### func toString()

```cangjie
public override func toString(): String
```

Function: Converts TCP KeepAlive configuration properties to a string.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The converted string.

### operator func !=(SocketKeepAliveConfig)

```cangjie
public override operator func !=(other: SocketKeepAliveConfig): Bool
```

Function: Determines if two [SocketKeepAliveConfig](net_package_structs.md#struct-socketkeepaliveconfig) instances are unequal.

Parameters:

- other: [SocketKeepAliveConfig](net_package_structs.md#struct-socketkeepaliveconfig) - The instance to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if unequal, otherwise `false`.

### operator func ==(SocketKeepAliveConfig)

```cangjie
public override operator func ==(other: SocketKeepAliveConfig): Bool
```

Function: Determines if two [SocketKeepAliveConfig](net_package_structs.md#struct-socketkeepaliveconfig) instances are equal.

Parameters:

- other: [SocketKeepAliveConfig](net_package_structs.md#struct-socketkeepaliveconfig) - The instance to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if equal, otherwise `false`.

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

Function: [SocketOptions](net_package_structs.md#struct-socketoptions) stores constant parameters for socket options configuration.

### const IPPROTO_TCP <sup>(deprecated)</sup>

```cangjie
public static const IPPROTO_TCP: Int32 = 6
```

Function: Constant for setting socket option `level` to `IPPROTO_TCP`.

> **Note:**
>
> Will be deprecated in future versions. Use [OptionLevel.TCP](#static-const-tcp) instead.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### const IPPROTO_UDP <sup>(deprecated)</sup>

```cangjie
public static const IPPROTO_UDP: Int32 = 17
```

Function: Constant for setting socket option `level` to `IPPROTO_UDP`.

> **Note:**
>
> Will be deprecated in future versions. Use [OptionLevel.UDP](#static-const-udp) instead.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### const SOL_SOCKET <sup>(deprecated)</sup>

```cangjie
public static const SOL_SOCKET: Int32
```

Function: Constant for setting socket option `level` to `SOL_SOCKET`. Values vary by system:

- macOS: 0xFFFF
- Windows: 0xFFFF
- Others: 1

> **Note:**
>
> Will be deprecated in future versions. Use [OptionLevel.SOCKET](#static-const-socket) instead.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### const SO_BINDTODEVICE

```cangjie
public static const SO_BINDTODEVICE: Int32
```

Function: Constant for setting socket option `optname` to `SO_BINDTODEVICE`. Values vary by system:

- macOS: 0xFFFF
- Windows: 0xFFFF
- Others: 0x0019

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### const SO_KEEPALIVE

```cangjie
public static const SO_KEEPALIVE: Int32
```

Function: Constant for setting socket option `optname` to `SO_KEEPALIVE`. Values vary by system:

- macOS: 0x0008
- Windows: 0x0008
- Others: 0x0009

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### const SO_LINGER

```cangjie
public static const SO_LINGER: Int32
```

Function: Constant for setting socket option `optname` to `SO_LINGER`. Values vary by system:

- macOS: 0x0080
- Windows: 0x0080
- Others: 0x000D

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### const SO_RCVBUF

```cangjie
public static const SO_RCVBUF: Int32
```

Function: Constant for setting socket option `optname` to `SO_RCVBUF`. Values vary by system:

- macOS: 0x1002
- Windows: 0x1002
- Others: 0x0008

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### const SO_REUSEADDR

```cangjie
public static const SO_REUSEADDR: Int32
```

Function: Constant for setting socket option `optname` to `SO_REUSEADDR`. Values vary by system:

- macOS: 0x0004
- Windows: 0x0004
- Others: 0x0002

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### const SO_REUSEPORT

```cangjie
public static const SO_REUSEPORT: Int32
```

Function: Constant for setting socket option `optname` to `SO_REUSEPORT`. Values vary by system:

- macOS: 0x0200
- Windows: 0xFFFF
- Others: 0x000F

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### const SO_SNDBUF

```cangjie
public static const SO_SNDBUF: Int32
```

Function: Constant for setting socket option `optname` to `SO_SNDBUF`. Values vary by system:

- macOS: 0x1001
- Windows: 0x1001
- Others: 0x0007

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### const TCP_NODELAY

```cangjie
public static const TCP_NODELAY: Int32 = 0x0001
```

Function: Constant for setting socket option `optname` to `TCP_NODELAY`.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

### const TCP_QUICKACK

```cangjie
public static const TCP_QUICKACK: Int32
```

Function: Constant for setting socket option `optname` to `TCP_QUICKACK`. Values vary by system:

- macOS: 0xFFFF
- Windows: 0xFFFF
- Others: 0x000C

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

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

Function: Provides common socket types and the ability to construct socket types by specifying [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) values.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[SocketType](#struct-sockettype)>- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)

### static let DATAGRAM

```cangjie
public static let DATAGRAM: SocketType = SocketType(2)
```

Function: Datagram socket type.

Type: [SocketType](net_package_structs.md#struct-sockettype)

### static let RAW

```cangjie
public static let RAW: SocketType = SocketType(3)
```

Function: Raw socket type.

Type: [SocketType](net_package_structs.md#struct-sockettype)

### static let SEQPACKET

```cangjie
public static let SEQPACKET: SocketType = SocketType(5)
```

Function: Sequenced packet socket type.

Type: [SocketType](net_package_structs.md#struct-sockettype)

### static let STREAM

```cangjie
public static let STREAM: SocketType = SocketType(1)
```

Function: Stream socket type.

Type: [SocketType](net_package_structs.md#struct-sockettype)

### init(Int32)

```cangjie
public init(`type`: Int32)
```

Function: Creates a socket type by specifying the socket type value.

Parameters:

- \`type`: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The socket type value.

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Returns the hash value of the current [SocketType](net_package_structs.md#struct-sockettype) instance.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The hash value of the current [SocketType](net_package_structs.md#struct-sockettype) instance.

### func toString()

```cangjie
public func toString(): String
```

Function: Returns the string representation of the current [SocketType](net_package_structs.md#struct-sockettype) instance.

Return value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of the current [SocketType](net_package_structs.md#struct-sockettype) instance.

### operator func !=(SocketType)

```cangjie
public operator func !=(r: SocketType): Bool
```

Function: Determines whether two [SocketType](net_package_structs.md#struct-sockettype) instances are not equal.

Parameters:

- r: [SocketType](net_package_structs.md#struct-sockettype) - The [SocketType](net_package_structs.md#struct-sockettype) instance to compare.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` when the represented [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) values are not equal; otherwise, returns `false`.

### operator func ==(SocketType)

```cangjie
public operator func ==(r: SocketType): Bool
```

Function: Determines whether two [SocketType](net_package_structs.md#struct-sockettype) instances are equal.

Parameters:

- r: [SocketType](net_package_structs.md#struct-sockettype) - The [SocketType](net_package_structs.md#struct-sockettype) instance to compare.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` when the represented [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) values are equal; otherwise, returns `false`.