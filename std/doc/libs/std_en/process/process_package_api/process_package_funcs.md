# Functions

## func execute(String, Array\<String>, ?Path, ?Map\<String, String>, ProcessRedirect, ProcessRedirect, ProcessRedirect, ?Duration)

```cangjie
public func execute(command: String,
                      arguments: Array<String>,
                      workingDirectory!: ?Path = None,
                      environment!: ?Map<String, String> = None,
                      stdIn!: ProcessRedirect = Inherit,
                      stdOut!: ProcessRedirect = Inherit,
                      stdErr!: ProcessRedirect = Inherit,
                      timeout!: ?Duration = None): Int64
```

Function: Creates and runs a child process based on input parameters, waits for the child process to complete, and returns the child process exit status.

> **Note:**
>
> On the `Windows` platform, immediately deleting the executable file of the child process after execution may fail and throw an exception with the message `Access is denied`. If this issue occurs, you can retry deleting the file after a short delay. For implementation details, please refer to the example.

Parameters:

- command: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Specifies the child process command. The `command` must not contain null characters.
- arguments: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - Specifies the child process arguments. Strings in the `arguments` array must not contain null characters.
- workingDirectory!: ?[Path](../../fs/fs_package_api/fs_package_structs.md#struct-path) - Named optional parameter specifying the working directory of the child process. Defaults to inheriting the current process's working directory. The path must be an existing directory and cannot be an empty path or contain null characters.
- environment!: ?[Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v)\<[String](../../core/core_package_api/core_package_structs.md#struct-string), [String](../../core/core_package_api/core_package_structs.md#struct-string)> - Named optional parameter specifying the child process environment variables. Defaults to inheriting the current process's environment variables. The `key` must not contain null characters or `'='`, and the `value` must not contain null characters.
- stdIn!: [ProcessRedirect](process_package_enums.md#enum-processredirect) - Named optional parameter specifying the standard input redirection for the child process. Defaults to inheriting the current process's standard input.
- stdOut!: [ProcessRedirect](process_package_enums.md#enum-processredirect) - Named optional parameter specifying the standard output redirection for the child process. Defaults to inheriting the current process's standard output.
- stdErr!: [ProcessRedirect](process_package_enums.md#enum-processredirect) - Named optional parameter specifying the standard error redirection for the child process. Defaults to inheriting the current process's standard error.
- timeout!: ?[Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - Named optional parameter specifying the timeout for waiting for the child process. Defaults to no timeout. If `timeout` is set to `0` or a negative value, it indicates no timeout.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Returns the child process exit status. If the child process exits normally, returns the exit code. If the child process is killed by a signal, returns the signal number that caused the termination.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception)

    - Thrown when:
        - The input parameter `command` contains null characters
        - Or strings in the `arguments` array contain null characters
        - Or `workingDirectory` is not an existing directory or is an empty path or contains null characters
        - Or `key` in the `environment` map contains null characters or `'='`
        - Or `value` in the `environment` map contains null characters
        - Or `stdIn`, `stdOut`, or `stdErr` is in file mode and the input file is closed or deleted.

- [ProcessException](process_package_exceptions.md#class-processexception) - Thrown when memory allocation fails, the `command` does not exist, or a timeout occurs while waiting.

## func executeWithOutput(String, Array\<String>, ?Path, ?Map\<String, String>, ProcessRedirect, ProcessRedirect, ProcessRedirect)

```cangjie
public func executeWithOutput(command: String,
                            arguments: Array<String>,
                            workingDirectory!: ?Path = None,
                            environment!: ?Map<String, String> = None,
                            stdIn!: ProcessRedirect = Inherit,
                            stdOut!: ProcessRedirect = Pipe,
                            stdErr!: ProcessRedirect = Pipe): (Int64, Array<Byte>, Array<Byte>)
```

Function: Creates and runs a child process based on input parameters, waits for the child process to complete, and returns the child process exit status, standard output, and standard error. This function is not suitable for scenarios where the output or error streams contain large amounts of data. It is recommended to use the standard stream properties provided by [SubProcess](process_package_classes.md#class-subprocess) in combination with the `wait` function for custom handling.

Parameters:

- command: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Specifies the child process command. The `command` must not contain null characters.
- arguments: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - Specifies the child process arguments. Strings in the `arguments` array must not contain null characters.
- workingDirectory!: ?[Path](../../fs/fs_package_api/fs_package_structs.md#struct-path) - Named optional parameter specifying the working directory of the child process. Defaults to inheriting the current process's working directory. The path must be an existing directory and cannot be an empty path or contain null characters.
- environment!: ?[Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v)\<[String](../../core/core_package_api/core_package_structs.md#struct-string), [String](../../core/core_package_api/core_package_structs.md#struct-string)> - Named optional parameter specifying the child process environment variables. Defaults to inheriting the current process's environment variables. The `key` must not contain null characters or `'='`, and the `value` must not contain null characters.
- stdIn!: [ProcessRedirect](process_package_enums.md#enum-processredirect) - Named optional parameter specifying the standard input redirection for the child process. Defaults to inheriting the current process's standard input.
- stdOut!: [ProcessRedirect](process_package_enums.md#enum-processredirect) - Named optional parameter specifying the standard output redirection for the child process. Defaults to inheriting the current process's standard output.
- stdErr!: [ProcessRedirect](process_package_enums.md#enum-processredirect) - Named optional parameter specifying the standard error redirection for the child process. Defaults to inheriting the current process's standard error.

Return Value:

- ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64), [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>, [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>) - The execution result of the child process, including the exit status (if the child process exits normally, returns the exit code; if killed by a signal, returns the signal number), standard output, and standard error.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception)
    - Thrown when:
        - The input parameter `command` contains null characters
        - Or strings in the `arguments` array contain null characters
        - Or `workingDirectory` is not an existing directory or is an empty path or contains null characters
        - Or `key` in the `environment` map contains null characters or `'='`
        - Or `value` in the `environment` map contains null characters
        - Or `stdIn`, `stdOut`, or `stdErr` is in file mode and the input file is closed or deleted.

- [ProcessException](process_package_exceptions.md#class-processexception)
    - Thrown when memory allocation fails
    - Or the `command` does not exist
    - Or the child process does not exist
    - Or there is an exception reading the standard streams.

## func findProcess(Int64)

```cangjie
public func findProcess(pid: Int64): Process
```

Function: Binds a process instance based on the input process `id`.

Parameters:

- pid: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The process `id`.

Return Value:

- [Process](process_package_classes.md#class-process) - Returns the process instance corresponding to the process `id`.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the input process `id` is greater than the maximum value of [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) or less than `0`.
- [ProcessException](process_package_exceptions.md#class-processexception) - Thrown when memory allocation fails or the process corresponding to `pid` does not exist.

## func launch(String, Array\<String>, ?Path, ?Map\<String, String>, ProcessRedirect, ProcessRedirect, ProcessRedirect)

```cangjie
public func launch(command: String,
                        arguments: Array<String>,
                        workingDirectory!: ?Path = None,
                        environment!: ?Map<String, String> = None,
                        stdIn!: ProcessRedirect = Inherit,
                        stdOut!: ProcessRedirect = Inherit,
                        stdErr!: ProcessRedirect = Inherit): SubProcess
```

Function: Creates and runs a child process based on input parameters and returns a child process instance. After calling this function to create a child process, you must call the `wait` or `waitOutput` function; otherwise, the resources of the zombie process created after the child process ends will not be reclaimed.

Parameters:

- command: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Specifies the child process command. The `command` must not contain null characters.
- arguments: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - Specifies the child process arguments. Strings in the `arguments` array must not contain null characters.
- workingDirectory!: ?[Path](../../fs/fs_package_api/fs_package_structs.md#struct-path) - Named optional parameter specifying the working directory of the child process. Defaults to inheriting the current process's working directory. The path must be an existing directory and cannot be an empty path or contain null characters.
- environment!: ?[Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v)\<[String](../../core/core_package_api/core_package_structs.md#struct-string), [String](../../core/core_package_api/core_package_structs.md#struct-string)> - Named optional parameter specifying the child process environment variables. Defaults to inheriting the current process's environment variables. The `key` must not contain null characters or `'='`, and the `value` must not contain null characters.
- stdIn!: [ProcessRedirect](process_package_enums.md#enum-processredirect) - Named optional parameter specifying the standard input redirection for the child process. Defaults to inheriting the current process's standard input.
- stdOut!: [ProcessRedirect](process_package_enums.md#enum-processredirect) - Named optional parameter specifying the standard output redirection for the child process. Defaults to inheriting the current process's standard output.
- stdErr!: [ProcessRedirect](process_package_enums.md#enum-processredirect) - Named optional parameter specifying the standard error redirection for the child process. Defaults to inheriting the current process's standard error.

Return Value:

- [SubProcess](process_package_classes.md#class-subprocess) - Returns a child process instance.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception)
    - Thrown when:
        - The input parameter `command` contains null characters
        - Or strings in the `arguments` array contain null characters
        - Or `workingDirectory` is not an existing directory or is an empty path or contains null characters
        - Or `key` in the `environment` map contains null characters or `'='`
        - Or `value` in the `environment` map contains null characters
        - Or `stdIn`, `stdOut`, or `stdErr` is in file mode and the input file is closed or deleted.

- [ProcessException](process_package_exceptions.md#class-processexception) - Thrown when memory allocation fails or the `command` does not exist.