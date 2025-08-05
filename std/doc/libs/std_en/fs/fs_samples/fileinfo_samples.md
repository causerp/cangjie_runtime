# FileInfo Example

## Basic Operations Demonstration of FileInfo

Code example:
<!-- verify -->

```cangjie
import std.fs.*
import std.time.DateTime

main() {
    // Create a temporary file in the current directory for FileInfo demonstration
    let curDirPath: Path = canonicalize(Path("./"))
    let file: File = File.createTemp(curDirPath)
    file.write("123456789\n".toArray())
    let fileInfo: FileInfo = file.info

    file.close()

    /* Get the FileInfo of the parent directory (which is the current directory) */
    let parentDirectory: Option<FileInfo> = fileInfo.parentDirectory
    checkResult(parentDirectory == Some(FileInfo(curDirPath)), "The 'parentFileInfo' is obtained successfully.")

    /* Get the file path */
    /*
    let filePath: Path = fileInfo.path
     */

    /* Get the file's creation time, last access time, and last modification time */
    /*
    let creationTime: DateTime = fileInfo.creationTime
    let lastAccessTime: DateTime = fileInfo.lastAccessTime
    let lastModificationTime: DateTime = fileInfo.lastModificationTime
     */

    /*
     * Get the file's length
     * For files: represents the disk space occupied by this file
     * For directories: represents the disk space occupied by all files in this directory (excluding subdirectories)
     */
    /*
    let length: Int64 = fileInfo.size
     */

    /* Check if the file is a symbolic link, regular file, or directory */
    checkResult(fileInfo.isSymbolicLink(), "The file is a symbolic link.")
    checkResult(fileInfo.isRegular(), "The file is a regular file.")
    checkResult(fileInfo.isDirectory(), "The file is a directory.")

    /* Check file permissions for current user: read-only, hidden, executable, readable, writable */
    checkResult(fileInfo.isReadOnly(), "This file is read-only.")
    checkResult(fileInfo.isHidden(), "The file is hidden.")
    checkResult(fileInfo.canExecute(), "The file is executable.")
    checkResult(fileInfo.canRead(), "The file is readable.")
    checkResult(fileInfo.canWrite(), "The file is writable.")

    /* Modify file permissions for current user (set to read-only here) */
    checkResult(fileInfo.setExecutable(false), "The file was successfully set to executable.")
    checkResult(fileInfo.setReadable(true), "The file was successfully set to readable.")
    checkResult(fileInfo.setWritable(false), "The file was successfully set to writable.")
    checkResult(fileInfo.isReadOnly(), "This file is now read-only.")

    return 0
}

func checkResult(result: Bool, message: String): Unit {
    if (result) {
        println(message)
    }
}
```

Execution result:

```text
The 'parentFileInfo' is obtained successfully.
The file is a regular file.
The file is readable.
The file is writable.
The file was successfully set to executable.
The file was successfully set to readable.
The file was successfully set to writable.
This file is now read-only.
```