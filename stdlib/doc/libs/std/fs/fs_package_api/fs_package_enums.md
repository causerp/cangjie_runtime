# 枚举

## enum OpenMode

```cangjie
public enum OpenMode <: ToString & Equatable<OpenMode> {
    | Read
    | Write
    | Append
    | ReadWrite
}
```

功能：表示不同的文件打开模式。

父类型：

- [ToString](../../../std/core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Equatable](../../../std/core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[OpenMode](./fs_package_enums.md#enum-openmode)>

### Read

```cangjie
Read
```

功能：构造一个 [OpenMode](fs_package_enums.md#enum-openmode) 实例，指定以只读的方式打开文件。如果文件不存在，则将引发 [FSException](fs_package_exceptions.md#class-fsexception) 异常。

### Write

```cangjie
Write
```

功能：构造一个 [OpenMode](fs_package_enums.md#enum-openmode) 实例，指定以只写的方式打开文件，即文件存在时会将该文件截断为零字节大小，文件不存在则将创建文件。

### Append

```cangjie
Append
```

功能：构造一个 [OpenMode](fs_package_enums.md#enum-openmode) 实例，指定以追加写入的方式打开文件。如果文件不存在，则将创建文件。

### ReadWrite

```cangjie
ReadWrite
```

功能：构造一个 [OpenMode](fs_package_enums.md#enum-openmode) 实例，指定以可读可写的方式打开文件。如果文件不存在，则将创建文件。

> **注意：**
>
> ReadWrite 模式不会使文件被截断为零字节大小。

### func toString()

```cangjie
public func toString(): String
```

功能：文件打开模式的字符串表示。

返回值：

- [String](../../../std/core/core_package_api/core_package_structs.md#struct-string) - 文件打开模式名称。

示例：

<!-- verify -->
```cangjie
import std.fs.*

main(): Unit {
    // 创建不同的OpenMode实例
    let readMode = OpenMode.Read
    let writeMode = OpenMode.Write
    let appendMode = OpenMode.Append
    let readWriteMode = OpenMode.ReadWrite
    
    // 获取它们的字符串表示
    println("Read mode: ${readMode.toString()}")
    println("Write mode: ${writeMode.toString()}")
    println("Append mode: ${appendMode.toString()}")
    println("ReadWrite mode: ${readWriteMode.toString()}")
}
```

运行结果：

```text
Read mode: Read
Write mode: Write
Append mode: Append
ReadWrite mode: ReadWrite
```

### operator func ==(OpenMode)

```cangjie
public operator func ==(that: OpenMode): Bool
```

功能：比较 [OpenMode](fs_package_enums.md#enum-openmode) 实例是否相等。

参数：

- that: [OpenMode](fs_package_enums.md#enum-openmode) - 待比较的 [OpenMode](fs_package_enums.md#enum-openmode) 实例。

返回值：

- [Bool](../../../std/core/core_package_api/core_package_intrinsics.md#bool) - 如果相等，则返回 true，否则返回 false。

示例：

<!-- verify -->
```cangjie
import std.fs.*

main(): Unit {
    // 创建相同的OpenMode实例
    let readMode1 = OpenMode.Read
    let readMode2 = OpenMode.Read
    let writeMode = OpenMode.Write
    
    // 比较相等的实例
    let equalResult = (readMode1 == readMode2)
    println("Read mode 1 equals Read mode 2: ${equalResult}")
    
    // 比较不等的实例
    let notEqualResult = (readMode1 == writeMode)
    println("Read mode equals Write mode: ${notEqualResult}")
}
```

运行结果：

```text
Read mode 1 equals Read mode 2: true
Read mode equals Write mode: false
```

### operator func !=(OpenMode)

```cangjie
public operator func !=(that: OpenMode): Bool
```

功能：比较 [OpenMode](fs_package_enums.md#enum-openmode) 实例是否不等。

参数：

- that: [OpenMode](fs_package_enums.md#enum-openmode) - 待比较的 [OpenMode](fs_package_enums.md#enum-openmode) 实例。

返回值：

- [Bool](../../../std/core/core_package_api/core_package_intrinsics.md#bool) - 如果不相等，则返回 true，否则返回 false。

示例：

<!-- verify -->
```cangjie
import std.fs.*

main(): Unit {
    // 创建不同的OpenMode实例
    let readMode = OpenMode.Read
    let writeMode = OpenMode.Write
    
    // 比较不等的实例
    let notEqualResult = (readMode != writeMode)
    println("Read mode not equals Write mode: ${notEqualResult}")
    
    // 比较相等的实例
    let equalResult = (readMode != readMode)
    println("Read mode not equals Read mode: ${equalResult}")
}
```

运行结果：

```text
Read mode not equals Write mode: true
Read mode not equals Read mode: false
```
