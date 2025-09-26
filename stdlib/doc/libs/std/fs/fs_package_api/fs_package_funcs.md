# 函数

## func canonicalize(Path)

```cangjie
public func canonicalize(path: Path): Path
```

功能：将 [Path](fs_package_structs.md#struct-path) 实例规范化，获取绝对路径形式的规范化路径。

所有的中间引用和软链接都会处理（UNC 路径下的软链接无法被规范化），例如，对于路径 "/foo/test/../test/bar.txt"，该函数会返回 "/foo/test/bar.txt"。

参数：

- path: [Path](./fs_package_structs.md#struct-path) - 待规范化的 [Path](fs_package_structs.md#struct-path) 实例。

返回值：

- [Path](fs_package_structs.md#struct-path) - 规范化后的 [Path](fs_package_structs.md#struct-path) 实例。

异常：

- [FSException](fs_package_exceptions.md#class-fsexception) - 路径不存在或无法规范化时抛出异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 路径为空或包含字符串结束符时抛出异常。

示例：

<!-- run -->
```cangjie
import std.fs.*

main(): Unit {
    // 创建前先删除，以防创建失败
    removeIfExists("./test/../test_canonicalize_path.txt", recursive: true)
    
    // 创建一个测试路径
    let testPath = Path("./test/../test_canonicalize_path.txt")

    // 打开文件
    Directory.create(testPath, recursive: true)

    // 规范化路径
    let canonicalPath = canonicalize(testPath)
    
    // 验证结果
    println("Original path: ${testPath}")
    println("Canonical path: ${canonicalPath}")

    // 删除测试路径，如果想保留目录就注释下面这行代码
    removeIfExists("./test/../test_canonicalize_path.txt", recursive: true)
}
```

可能的运行结果：

```text
Original path: ./test/../test_canonicalize_path.txt
Canonical path: /home/user/test/test_canonicalize_path.txt
```

## func canonicalize(String)

```cangjie
public func canonicalize(path: String): Path
```

功能：用 path 字符串构造 [Path](fs_package_structs.md#struct-path) 实例，并进行规范化，获取绝对路径形式的规范化路径。

所有的中间引用和软链接都会处理 （UNC 路径下的软链接无法被规范化），例如，对于路径 "/foo/test/../test/bar.txt"，该函数会返回 "/foo/test/bar.txt"。

参数：

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 待规范化的路径字符串。

返回值：

- [Path](fs_package_structs.md#struct-path) - 规范化后的 [Path](fs_package_structs.md#struct-path) 实例。

异常：

- [FSException](fs_package_exceptions.md#class-fsexception) - 路径不存在或无法规范化时抛出异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 路径为空或包含字符串结束符时抛出异常。

示例：

<!-- run -->
```cangjie
import std.fs.*

main(): Unit {
    // 创建前先删除，以防创建失败
    removeIfExists("./test/../test_canonicalize_string.txt", recursive: true)
    
    // 创建一个测试路径字符串
    let testPath = "./test/../test_canonicalize_string.txt"

    // 创建目录
    Directory.create(testPath, recursive: true)

    // 规范化路径
    let canonicalPath = canonicalize(testPath)
    
    // 验证结果
    println("Original path: ${testPath}")
    println("Canonical path: ${canonicalPath}")

    // 删除测试路径，如果想保留目录就注释下面这行代码
    removeIfExists("./test/../test_canonicalize_string.txt", recursive: true)
}
```

可能的运行结果：

```text
Original path: ./test/../test_canonicalize_path.txt
Canonical path: /home/user/test/test_canonicalize_path.txt
```

## func copy(Path, Path, Bool)

```cangjie
public func copy(sourcePath: Path, to!: Path, overwrite!: Bool = false): Unit
```

功能：实现文件系统的拷贝功能，用于复制文件或目录。

当目标位置存在且 `overwrite` 为 `true` 时，该函数要求 `sourcePath` 的类型与 `to` 的类型一致，比如，`sourcePath` 的类型是 `Directory`，`to` 的类型也应该是 `Directory`，否则函数会抛出异常 FSException。当前支持的文件类型有文件夹（Directory），常规文件（Regular file），符号链接（SymbolicLink）。

参数：

- sourcePath: [Path](./fs_package_structs.md#struct-path) - 待拷贝的文件地址。
- to!: [Path](./fs_package_structs.md#struct-path) - 目标地址。
- overwrite!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 是否覆盖目标地址，默认值为 `false`。

异常：

- [FSException](fs_package_exceptions.md#class-fsexception) - 如果源文件类型和目标文件类型不一致会抛出异常或者 `overwrite` 为 `false` 并且目标地址存在时抛出异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 路径为空或包含字符串结束符时抛出异常。

示例：

<!-- verify -->
```cangjie
import std.fs.*

main(): Unit {
    // 创建前先删除，以防创建失败
    removeIfExists("./test_copy_source.txt", recursive: true)
    removeIfExists("./test_copy_target.txt", recursive: true)

    // 创建源文件
    var data: Array<Byte> = [67, 111, 112, 121]  // "Copy"
    File.writeTo("./test_copy_source.txt", data)
    
    // 复制文件
    copy(Path("./test_copy_source.txt"), to: Path("./test_copy_target.txt"), overwrite: false)
    
    // 验证复制结果
    if (exists("./test_copy_target.txt")) {
        let content = File.readFrom("./test_copy_target.txt")
        println("File copied successfully, content: ${content}")
    } else {
        println("File copy failed")
    }
    
    // 清理测试文件
    removeIfExists("./test_copy_source.txt", recursive: true)
    removeIfExists("./test_copy_target.txt", recursive: true)
}
```

运行结果：

```text
File copied successfully, content: [67, 111, 112, 121]
```

## func copy(String, String, Bool)

```cangjie
public func copy(sourcePath: String, to!: String, overwrite!: Bool = false): Unit
```

功能：实现文件系统的拷贝功能，用于复制文件或目录。

当目标位置存在且 `overwrite` 为 `true` 时，该函数要求 `sourcePath` 的类型与 `to` 的类型一致，比如，`sourcePath` 的类型是 `Directory`，`to` 的类型也应该是 `Directory`，否则函数会抛出异常 FSException。当前支持的文件类型有文件夹（Directory），常规文件（Regular file），符号链接（SymbolicLink）。

参数：

- sourcePath: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 待拷贝的文件地址。
- to!: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 目标地址。
- overwrite!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 是否覆盖目标地址，默认值为 `false`。

异常：

- [FSException](fs_package_exceptions.md#class-fsexception) - 如果源文件类型和目标文件类型不一致会抛出异常或者 `overwrite` 为 `false` 并且目标地址存在时抛出异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 路径为空或包含字符串结束符时抛出异常。

示例：

<!-- verify -->
```cangjie
import std.fs.*

main(): Unit {
    // 创建前先删除，以防创建失败
    removeIfExists("./test_copy_source.txt", recursive: true)
    removeIfExists("./test_copy_target.txt", recursive: true)

    // 创建源文件
    var data: Array<Byte> = [67, 111, 112, 121]  // "Copy"
    File.writeTo("./test_copy_source.txt", data)
    
    // 复制文件
    copy("./test_copy_source.txt", to: "./test_copy_target.txt", overwrite: false)
    
    // 验证复制结果
    if (exists("./test_copy_target.txt")) {
        let content = File.readFrom("./test_copy_target.txt")
        println("File copied successfully, content: ${content}")
    } else {
        println("File copy failed")
    }
    
    // 清理测试文件
    removeIfExists("./test_copy_source.txt", recursive: true)
    removeIfExists("./test_copy_target.txt", recursive: true)
}
```

运行结果：

```text
File copied successfully, content: [67, 111, 112, 121]
```

## func exists(Path)

```cangjie
public func exists(path: Path): Bool
```

功能：判断目标地址是否存在。

参数：

- path: [Path](./fs_package_structs.md#struct-path) - 待判断的目标地址。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 目标地址是否存在。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 路径为空或包含字符串结束符时抛出异常。

示例：

<!-- verify -->
```cangjie
import std.fs.*

main(): Unit {
    // 创建前先删除，以防创建失败
    removeIfExists("./test_exists_path.txt", recursive: true)

    // 检查不存在的文件
    let notExist = exists(Path("./test_exists_path.txt"))
    println("File exists before creation: ${notExist}")
    
    // 创建文件
    var data: Array<Byte> = [69, 120, 105, 115, 116, 115]  // "Exists"
    File.writeTo("./test_exists_path.txt", data)
    
    // 检查存在的文件
    let exist = exists(Path("./test_exists_path.txt"))
    println("File exists after creation: ${exist}")
    
    // 清理测试文件
    removeIfExists("./test_exists_path.txt", recursive: true)
}
```

运行结果：

```text
File exists before creation: false
File exists after creation: true
```

## func exists(String)

```cangjie
public func exists(path: String): Bool
```

功能：判断目标地址是否存在。

参数：

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 待判断的目标地址。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 目标地址是否存在。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 路径为空或包含字符串结束符时抛出异常。

示例：

<!-- verify -->
```cangjie
import std.fs.*

main(): Unit {
    // 创建前先删除，以防创建失败
    removeIfExists("./test_exists_string.txt", recursive: true)

    // 检查不存在的文件
    let notExist = exists("./test_exists_string.txt")
    println("File exists before creation: ${notExist}")
    
    // 创建文件
    var data: Array<Byte> = [69, 120, 105, 115, 116, 115]  // "Exists"
    File.writeTo("./test_exists_string.txt", data)
    
    // 检查存在的文件
    let exist = exists("./test_exists_string.txt")
    println("File exists after creation: ${exist}")
    
    // 清理测试文件
    removeIfExists("./test_exists_string.txt", recursive: true)
}
```

运行结果：

```text
File exists before creation: false
File exists after creation: true
```

## func rename(Path, Path, Bool)

```cangjie
public func rename(sourcePath: Path, to!: Path, overwrite!: Bool = false): Unit
```

功能：将 `sourcePath` 指定的文件或者目录重命名为由 `to` 给定的名称，`sourcePath` 必须是现有文件或者目录的路径，如果 `to` 是现有文件或者目录的路径时，其具体行为由 `overwrite` 指定， 如果 `overwrite` 为 `true`，将会删除现有的文件或者目录，再执行重命名操作，否则会抛出异常。

> **注意：**
>
> 当`overwrite` 为 `true`时，`rename`的一个隐含行为是删除目标位置的原有文件或者目录，如果目标位置是目录，将会递归删除目录内的所有内容，需要谨慎使用。

参数：

- sourcePath: [Path](./fs_package_structs.md#struct-path) - 待重命名的地址。
- to!: [Path](./fs_package_structs.md#struct-path) - 目标地址。
- overwrite!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 是否覆盖目标地址，默认值为 `false`。

异常：

- [FSException](fs_package_exceptions.md#class-fsexception) - 操作系统执行rename方法失败时抛出异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 路径为空或包含字符串结束符时抛出异常。

示例：

<!-- verify -->
```cangjie
import std.fs.*

main(): Unit {
    // 创建前先删除，以防创建失败
    removeIfExists("./test_rename_source.txt", recursive: true)
    removeIfExists("./test_rename_target.txt", recursive: true)

    // 创建源文件
    var data: Array<Byte> = [82, 101, 110, 97, 109, 101]  // "Rename"
    File.writeTo("./test_rename_source.txt", data)
    
    // 重命名文件
    rename(Path("./test_rename_source.txt"), to: Path("./test_rename_target.txt"), overwrite: false)
    
    // 验证重命名结果
    let sourceExists = exists("./test_rename_source.txt")
    let targetExists = exists("./test_rename_target.txt")
    println("Source file exists after rename: ${sourceExists}")
    println("Target file exists after rename: ${targetExists}")
    
    if (targetExists) {
        let content = File.readFrom("./test_rename_target.txt")
        println("Renamed file content: ${content}")
    }
    
    // 清理测试文件
    removeIfExists("./test_rename_target.txt", recursive: true)
}
```

运行结果：

```text
Source file exists after rename: false
Target file exists after rename: true
Renamed file content: [82, 101, 110, 97, 109, 101]
```

## func rename(String, String, Bool)

```cangjie
public func rename(sourcePath: String, to!: String, overwrite!: Bool = false): Unit
```

功能：将 `sourcePath` 指定的文件或者目录重命名为由 `to` 给定的名称，`sourcePath` 必须是现有文件或者目录的路径，如果 `to` 是现有文件或者目录的路径时，其具体行为由 `overwrite` 指定， 如果 `overwrite` 为 `true`，将会删除现有的文件或者目录，再执行重命名操作，`overwrite` 为 `false` 会抛出异常。

> **注意：**
>
> 当`overwrite` 为 `true`时，`rename`的一个隐含行为是删除目标位置的原有文件或者目录，如果目标位置是目录，将会递归删除目录内的所有内容，需要谨慎使用。

参数：

- sourcePath: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 待重命名的地址。
- to!: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 目标地址。
- overwrite!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 是否覆盖目标地址，默认值为 `false`。

异常：

- [FSException](fs_package_exceptions.md#class-fsexception) - 操作系统执行rename方法失败时抛出异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 路径为空或包含字符串结束符时抛出异常。

示例：

<!-- verify -->
```cangjie
import std.fs.*

main(): Unit {
    // 创建前先删除，以防创建失败
    removeIfExists("./test_rename_source.txt", recursive: true)
    removeIfExists("./test_rename_target.txt", recursive: true)

    // 创建源文件
    var data: Array<Byte> = [82, 101, 110, 97, 109, 101]  // "Rename"
    File.writeTo("./test_rename_source.txt", data)
    
    // 重命名文件
    rename("./test_rename_source.txt", to: "./test_rename_target.txt", overwrite: false)
    
    // 验证重命名结果
    let sourceExists = exists("./test_rename_source.txt")
    let targetExists = exists("./test_rename_target.txt")
    println("Source file exists after rename: ${sourceExists}")
    println("Target file exists after rename: ${targetExists}")
    
    if (targetExists) {
        let content = File.readFrom("./test_rename_target.txt")
        println("Renamed file content: ${content}")
    }
    
    // 清理测试文件
    removeIfExists("./test_rename_target.txt", recursive: true)
}
```

运行结果：

```text
Source file exists after rename: false
Target file exists after rename: true
Renamed file content: [82, 101, 110, 97, 109, 101]
```

## func remove(Path, Bool)

```cangjie
public func remove(path: Path, recursive!: Bool = false): Unit
```

功能：删除文件或目录。

当目标是文件夹时，可选择是否递归删除文件夹。

参数：

- path: [Path](./fs_package_structs.md#struct-path) - 目标路径。
- recursive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 是否递归删除文件夹，默认值为 `false`。

异常：

- [FSException](fs_package_exceptions.md#class-fsexception) - 如果指定目录不存在或删除失败，则抛出异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 路径为空或包含字符串结束符时抛出异常。

示例：

<!-- verify -->
```cangjie
import std.fs.*

main(): Unit {
    // 创建前先删除，以防创建失败
    removeIfExists(Path("./test_remove_file.txt"), recursive: true)

    // 创建测试文件
    var data: Array<Byte> = [82, 101, 109, 111, 118, 101]  // "Remove"
    File.writeTo(Path("./test_remove_file.txt"), data)
    
    // 验证文件存在
    let fileExistsBefore = exists(Path("./test_remove_file.txt"))
    println("File exists before remove: ${fileExistsBefore}")
    
    // 删除文件
    remove(Path("./test_remove_file.txt"), recursive: false)
    
    // 验证文件已删除
    let fileExistsAfter = exists(Path("./test_remove_file.txt"))
    println("File exists after remove: ${fileExistsAfter}")
}
```

运行结果：

```text
File exists before remove: true
File exists after remove: false
```

## func remove(String, Bool)

```cangjie
public func remove(path: String, recursive!: Bool = false): Unit
```

功能：删除文件或目录。

当目标是文件夹时，可选择是否递归删除文件夹。

参数：

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 目标路径。
- recursive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 是否递归删除文件夹，默认值为 `false`。

异常：

- [FSException](fs_package_exceptions.md#class-fsexception) - 如果指定目录不存在或删除失败，则抛出异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 路径为空或包含字符串结束符时抛出异常。

示例：

<!-- verify -->
```cangjie
import std.fs.*

main(): Unit {
    // 创建前先删除，以防创建失败
    removeIfExists("./test_remove_file.txt", recursive: true)

    // 创建测试文件
    var data: Array<Byte> = [82, 101, 109, 111, 118, 101]  // "Remove"
    File.writeTo("./test_remove_file.txt", data)
    
    // 验证文件存在
    let fileExistsBefore = exists("./test_remove_file.txt")
    println("File exists before remove: ${fileExistsBefore}")
    
    // 删除文件
    remove("./test_remove_file.txt", recursive: false)
    
    // 验证文件已删除
    let fileExistsAfter = exists("./test_remove_file.txt")
    println("File exists after remove: ${fileExistsAfter}")
}
```

运行结果：

```text
File exists before remove: true
File exists after remove: false
```

## func removeIfExists(Path, Bool)

```cangjie
public func removeIfExists(path: Path, recursive!: Bool = false): Bool
```

功能：判断目标是否存在，如果存在则执行[remove](#func-removepath-bool)方法，并返回 `true`。

参数：

- path: [Path](./fs_package_structs.md#struct-path) - 目标路径。
- recursive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 是否递归删除文件夹，默认值为 `false`。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 目标地址是否存在。

异常：

- [FSException](fs_package_exceptions.md#class-fsexception) - 如果删除失败，抛出此异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 路径为空或包含字符串结束符时抛出异常。

示例：

<!-- verify -->
```cangjie
import std.fs.*

main(): Unit {
    // 创建前先删除，以防创建失败
    removeIfExists("./test_removeifexists_file.txt", recursive: true)

    // 创建测试文件
    var data: Array<Byte> = [82, 101, 109, 111, 118, 101, 73, 102, 69, 120, 105, 115, 116, 115]  // "RemoveIfExists"
    File.writeTo("./test_removeifexists_file.txt", data)
    
    // 验证文件存在
    let fileExistsBefore = exists("./test_removeifexists_file.txt")
    println("File exists before removeIfExists: ${fileExistsBefore}")
    
    // 删除文件
    let result1 = removeIfExists(Path("./test_removeifexists_file.txt"), recursive: false)
    println("removeIfExists result for existing file: ${result1}")
    
    // 再次尝试删除不存在的文件
    let result2 = removeIfExists(Path("./test_removeifexists_file.txt"), recursive: false)
    println("removeIfExists result for non-existing file: ${result2}")
}
```

运行结果：

```text
File exists before removeIfExists: true
removeIfExists result for existing file: true
removeIfExists result for non-existing file: false
```

## func removeIfExists(String, Bool)

```cangjie
public func removeIfExists(path: String, recursive!: Bool = false): Bool
```

功能：判断目标是否存在，如果存在则执行 [remove](#func-removestring-bool) 方法，并返回 `true`。

参数：

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 目标路径。
- recursive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 是否递归删除文件夹，默认值为 `false`。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 目标地址是否存在。

异常：

- [FSException](fs_package_exceptions.md#class-fsexception) - 如果删除失败，抛出此异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 路径为空或包含字符串结束符时抛出异常。

示例：

<!-- verify -->
```cangjie
import std.fs.*

main(): Unit {
    // 创建前先删除，以防创建失败
    removeIfExists("./test_removeifexists_file.txt", recursive: true)

    // 创建测试文件
    var data: Array<Byte> = [82, 101, 109, 111, 118, 101, 73, 102, 69, 120, 105, 115, 116, 115]  // "RemoveIfExists"
    File.writeTo("./test_removeifexists_file.txt", data)
    
    // 验证文件存在
    let fileExistsBefore = exists("./test_removeifexists_file.txt")
    println("File exists before removeIfExists: ${fileExistsBefore}")
    
    // 删除文件
    let result1 = removeIfExists("./test_removeifexists_file.txt", recursive: false)
    println("removeIfExists result for existing file: ${result1}")
    
    // 再次尝试删除不存在的文件
    let result2 = removeIfExists("./test_removeifexists_file.txt", recursive: false)
    println("removeIfExists result for non-existing file: ${result2}")
}
```

运行结果：

```text
File exists before removeIfExists: true
removeIfExists result for existing file: true
removeIfExists result for non-existing file: false
```
