# Path Examples

## Displaying Property Information of Different Path Instances

Print the directory part, full filename (with extension), extension, filename (without extension) of a Path instance, and determine whether the Path instance is an absolute or relative path.

Code:
<!-- verify -->

```cangjie
import std.fs.Path

main() {
    let pathStrArr: Array<String> = [
        // Absolute paths
        "/a/b/c",
        "/a/b/",
        "/a/b/c.cj",
        "/a",
        "/",
        // Relative paths
        "./a/b/c",
        "./a/b/",
        "./a/b/c.cj",
        "./",
        ".",
        "123."
    ]

    for (i in 0..pathStrArr.size) {
        let path: Path = Path(pathStrArr[i])
        // Print the complete path string
        println("Path${i}: ${path.toString()}")
        // Print the directory path
        println("Path.parent: ${path.parent}")
        // Print the full filename (with extension)
        println("Path.fileName: ${path.fileName}")
        // Print the extension
        println("Path.extensionName: ${path.extensionName}")
        // Print the filename (without extension)
        println("Path.fileNameWithoutExtension: ${path.fileNameWithoutExtension}")
        // Print whether the path is absolute or relative
        println("Path.isAbsolute: ${path.isAbsolute()}; Path.isRelative: ${path.isRelative()}")
        println()
    }

    return 0
}
```

Execution Result:

```text
Path0: /a/b/c
Path.parent: /a/b
Path.fileName: c
Path.extensionName:
Path.fileNameWithoutExtension: c
Path.isAbsolute: true; Path.isRelative: false

Path1: /a/b/
Path.parent: /a
Path.fileName: b
Path.extensionName:
Path.fileNameWithoutExtension: b
Path.isAbsolute: true; Path.isRelative: false

Path2: /a/b/c.cj
Path.parent: /a/b
Path.fileName: c.cj
Path.extensionName: cj
Path.fileNameWithoutExtension: c
Path.isAbsolute: true; Path.isRelative: false

Path3: /a
Path.parent: /
Path.fileName: a
Path.extensionName:
Path.fileNameWithoutExtension: a
Path.isAbsolute: true; Path.isRelative: false

Path4: /
Path.parent: /
Path.fileName:
Path.extensionName:
Path.fileNameWithoutExtension:
Path.isAbsolute: true; Path.isRelative: false

Path5: ./a/b/c
Path.parent: ./a/b
Path.fileName: c
Path.extensionName:
Path.fileNameWithoutExtension: c
Path.isAbsolute: false; Path.isRelative: true

Path6: ./a/b/
Path.parent: ./a
Path.fileName: b
Path.extensionName:
Path.fileNameWithoutExtension: b
Path.isAbsolute: false; Path.isRelative: true

Path7: ./a/b/c.cj
Path.parent: ./a/b
Path.fileName: c.cj
Path.extensionName: cj
Path.fileNameWithoutExtension: c
Path.isAbsolute: false; Path.isRelative: true

Path8: ./
Path.parent:
Path.fileName: .
Path.extensionName:
Path.fileNameWithoutExtension:
Path.isAbsolute: false; Path.isRelative: true

Path9: .
Path.parent:
Path.fileName: .
Path.extensionName:
Path.fileNameWithoutExtension:
Path.isAbsolute: false; Path.isRelative: true

Path10: 123.
Path.parent:
Path.fileName: 123.
Path.extensionName:
Path.fileNameWithoutExtension: 123
Path.isAbsolute: false; Path.isRelative: true
```

## Path Operations: Concatenation, Equality Check, and Canonicalization

Code:
<!-- verify -->

```cangjie
import std.fs.*

main() {
    let dirPath: Path = Path("./a/b/c")
    if (!exists(dirPath)) {
        Directory.create(dirPath, recursive: true)
    }

    let filePath: Path = dirPath.join("d.cj") // ./a/b/c/d.cj
    if (filePath == Path("./a/b/c/d.cj")) {
        println("filePath.join: success")
    }
    if (!exists(filePath)) {
        File.create(filePath).close()
    }

    let curCanonicalizedPath: Path = canonicalize(Path("."))
    let fileCanonicalizedPath: Path = canonicalize(Path("././././a/./../a/b/../../a/b/c/.././../../a/b/c/d.cj"))
    if (fileCanonicalizedPath == canonicalize(filePath) && fileCanonicalizedPath.toString() ==
        curCanonicalizedPath.toString() + "/a/b/c/d.cj") {
        println("canonicalize filePath: success")
    }

    remove(dirPath, recursive: true)
    return 0
}
```

Execution Result:

```text
filePath.join: success
canonicalize filePath: success
```

## Creating Files and Directories Using Path

Code:
<!-- verify -->

```cangjie
import std.fs.*

main() {
    let curPath: Path = Path("./")
    let dirPath: Path = curPath.join("tempDir")
    let filePath: Path = dirPath.join("tempFile.txt")
    if (exists(dirPath)) {
        remove(dirPath, recursive: true)
    }

    Directory.create(dirPath)
    if (exists(dirPath)) {
        println("Directory 'tempDir' is created successfully.")
    }

    File.create(filePath).close()
    if (exists(filePath)) {
        println("File 'tempFile.txt' is created successfully in directory 'tempDir'.")
    }

    remove(dirPath, recursive: true)
    return 0
}
```

Execution Result:

```text
Directory 'tempDir' is created successfully.
File 'tempFile.txt' is created successfully in directory 'tempDir'.
```