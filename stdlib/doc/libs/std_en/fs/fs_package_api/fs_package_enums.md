# Enumerations

## enum OpenMode

```cangjie
public enum OpenMode <: ToString & Equatable<OpenMode> {
    | Read
    | Write
    | Append
    | ReadWrite
}
```

Function: Represents different file opening modes.

Parent types:

- [ToString](../../../std_en/core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Equatable](../../../std_en/core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[OpenMode](./fs_package_enums.md#enum-openmode)>

### Read

```cangjie
Read
```

Function: Constructs an [OpenMode](fs_package_enums.md#enum-openmode) instance specifying read-only file opening. If the file doesn't exist, it will raise an [FSException](fs_package_exceptions.md#class-fsexception).

### Write

```cangjie
Write
```

Function: Constructs an [OpenMode](fs_package_enums.md#enum-openmode) instance specifying write-only file opening. If the file exists, it will be truncated to zero bytes; if not, a new file will be created.

### Append

```cangjie
Append
```

Function: Constructs an [OpenMode](fs_package_enums.md#enum-openmode) instance specifying append mode for file opening. If the file doesn't exist, it will be created.

### ReadWrite

```cangjie
ReadWrite
```

Function: Constructs an [OpenMode](fs_package_enums.md#enum-openmode) instance specifying read-write file opening. If the file doesn't exist, it will be created.

> **Note:**
>
> ReadWrite mode does not truncate the file to zero bytes.

### func toString()

```cangjie
public func toString(): String
```

Function: String representation of the file opening mode.

Return value:

- [String](../../../std_en/core/core_package_api/core_package_structs.md#struct-string) - The name of the file opening mode.

### func operator func ==(OpenMode)

```cangjie
public operator func ==(that: OpenMode): Bool
```

Function: Compares whether two [OpenMode](fs_package_enums.md#enum-openmode) instances are equal.

Parameters:

- that: [OpenMode](fs_package_enums.md#enum-openmode) - The [OpenMode](fs_package_enums.md#enum-openmode) instance to compare.

Return value:

- [Bool](../../../std_en/core/core_package_api/core_package_intrinsics.md#bool) - Returns true if equal, otherwise false.

### func operator func !=(OpenMode)

```cangjie
public operator func !=(that: OpenMode): Bool
```

Function: Compares whether two [OpenMode](fs_package_enums.md#enum-openmode) instances are not equal.

Parameters:

- that: [OpenMode](fs_package_enums.md#enum-openmode) - The [OpenMode](fs_package_enums.md#enum-openmode) instance to compare.

Return value:

- [Bool](../../../std_en/core/core_package_api/core_package_intrinsics.md#bool) - Returns true if not equal, otherwise false.