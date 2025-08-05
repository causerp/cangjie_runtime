# Enumeration

## enum SocketNet

```cangjie
public enum SocketNet <: ToString & Equatable<SocketNet> {
    | TCP
    | UDP
    | UNIX
}
```

Function: Transport layer protocol types.

Parent types:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[SocketNet](#enum-socketnet)>

### TCP

```cangjie
TCP
```

Function: Represents TCP protocol.

### UDP

```cangjie
UDP
```

Function: Represents UDP protocol.

### UNIX

```cangjie
UNIX
```

Function: Represents UNIX protocol.

### func toString()

```cangjie
public func toString(): String
```

Function: Converts enum value to string.

Return value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The converted string.

### operator func !=(SocketNet)

```cangjie
public operator func !=(that: SocketNet): Bool
```

Function: Determines whether two [SocketNet](net_package_enums.md#enum-socketnet) values are not equal.

Parameters:

- that: [SocketNet](net_package_enums.md#enum-socketnet) - The input [SocketNet](net_package_enums.md#enum-socketnet).

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if not equal; otherwise, returns `false`.

### operator func ==(SocketNet)

```cangjie
public operator func ==(that: SocketNet): Bool
```

Function: Determines whether two [SocketNet](net_package_enums.md#enum-socketnet) values are equal.

Parameters:

- that: [SocketNet](net_package_enums.md#enum-socketnet) - The input [SocketNet](net_package_enums.md#enum-socketnet).

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if equal; otherwise, returns `false`.