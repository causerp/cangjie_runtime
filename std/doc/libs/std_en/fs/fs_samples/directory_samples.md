# Directory Example

## Basic Directory Operations Demonstration

Code example:
<!-- verify -->

```cangjie
import std.fs.*

main() {
    let testDirPath: Path = Path("./testDir")
    let subDirPath: Path = Path("./testDir/subDir")
    if (exists(testDirPath)) {
        remove(testDirPath, recursive: true)
    }

    /* Recursively create directories including "./testDir/subDir" */
    Directory.create(subDirPath, recursive: true)
    if (exists(subDirPath)) {
        println("The directory './testDir/subDir' is successfully created recursively in current directory.")
    }

    /* Create temporary directory under "./testDir" */
    let tempDirPath: Path = Directory.createTemp(testDirPath)
    if (exists(tempDirPath)) {
        println("The temporary directory is created successfully in directory './testDir'.")
    }

    /* Move "subDir" to temporary directory and rename it to "subDir_new" */
    let newSubDirPath: Path = tempDirPath.join("subDir_new")
    rename(subDirPath, to: newSubDirPath)
    if (exists(newSubDirPath) && !exists(subDirPath)) {
        println(
            "The directory './testDir/subDir' is moved successfully to the temporary directory and renamed 'subDir_new'."
        )
    }

    /* Copy "subDir_new" to "./testDir" and rename it to "subDir" */
    copy(newSubDirPath, to: subDirPath, overwrite: false)
    if (exists(subDirPath) && exists(newSubDirPath)) {
        println("The directory 'subDir_new' is copied successfully to directory './testDir' and renamed 'subDir'.")
    }

    remove(testDirPath, recursive: true)
    return 0
}
```

Execution results:

```text
The directory './testDir/subDir' is successfully created recursively in current directory.
The temporary directory is created successfully in directory './testDir'.
The directory './testDir/subDir' is moved successfully to the temporary directory and renamed 'subDir_new'.
The directory 'subDir_new' is copied successfully to directory './testDir' and renamed 'subDir'.
```