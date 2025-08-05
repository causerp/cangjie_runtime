# Class

## class CurrentProcess <sup>(deprecated)</sup>

```cangjie
public class CurrentProcess <: Process
```

Functionality: This class represents the current process, inheriting from the [Process](process_package_classes.md#class-process) class, and provides functionalities related to current process operations.

The specific functionalities provided are as follows:

- Provides mechanisms to obtain the standard streams (`stdIn`, `stdOut`, `stdErr`) of the current process.
- Provides a mechanism to register callback functions upon current process exit.
- Provides a mechanism for current process exit, allowing setting of exit status codes.

> **Note:**
>
> This class will be deprecated in future versions.

Parent Type:

- [Process](../process_package_overview.md#class-process)

### prop arguments

```cangjie
public prop arguments: Array<String>
```

Functionality: Returns the argument list of the current process. For example, if the current process command line is `a.out ab cd ef`, where `a.out` is the program name, the returned list will contain three elements: ab, cd, ef.

> **Note:**
>
> - When using the C language to call the Cangjie dynamic library, the command line arguments set via `int SetCJCommandLineArgs(int argc, const char* argv[])` will have the first argument discarded when retrieved using the `arguments` property of the current process.

Type: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)>

### prop homeDirectory

```cangjie
public prop homeDirectory: Path
```

Functionality: Gets the path of the `home` directory.

Type: [Path](../../fs/fs_package_api/fs_package_structs.md#struct-path)

### prop stdErr

```cangjie
public prop stdErr: OutputStream
```

Functionality: Gets the standard error stream of the current process.

Type: [OutputStream](../../io/io_package_api/io_package_interfaces.md#interface-outputstream)

### prop stdIn

```cangjie
public prop stdIn: InputStream
```

Functionality: Gets the standard input stream of the current process.

Type: [InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream)

### prop stdOut

```cangjie
public prop stdOut: OutputStream
```

Functionality: Gets the standard output stream of the current process.

Type: [OutputStream](../../io/io_package_api/io_package_interfaces.md#interface-outputstream)

### prop tempDirectory

```cangjie
public prop tempDirectory: Path
```

Functionality: Gets the path of the temporary directory. Retrieves environment variables `TMPDIR`, `TMP`, `TEMP`, and `TEMPDIR`. If none of these variables exist in the environment, it defaults to returning the `/tmp` directory.

Type: [Path](../../fs/fs_package_api/fs_package_structs.md#struct-path)

### func atExit(() -> Unit)

```cangjie
public func atExit(callback: () -> Unit): Unit
```

Functionality: Registers a callback function to be executed upon current process exit.

> **Note:**
>
> Do not use the C language `atexit` function to avoid unexpected issues.

Parameters:

- callback: () ->[Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - The callback function to be registered.

### func exit(Int64)

```cangjie
public func exit(code: Int64): Nothing
```

Functionality: Process exit function. Execution of this function directly terminates the current process, with the exit status code set via the `code` parameter.

Parameters:

- code: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The exit status code of the current process.

### func getEnv(String)

```cangjie
public func getEnv(k: String): Option<String>
```

Functionality: Gets the value of the environment variable with the specified name.

Parameters:

- k: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the environment variable.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - The value of the environment variable corresponding to the specified name.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the function parameter `k` contains a null character.

### func removeEnv(String)

```cangjie
public func removeEnv(k: String): Unit
```

Functionality: Removes an environment variable by its specified name.

Parameters:

- k: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the environment variable.

Exceptions:- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the function parameter `k` contains null characters.

### func setEnv(String, String)

```cangjie
public func setEnv(k: String, v: String): Unit
```

Function: Used to set a pair of environment variables. If an environment variable with the same name already exists, its original value will be overwritten.

> **Note:**
>
> On Windows, if the parameter `v` is an empty string, the variable `k` will be removed from the environment.

Parameters:

- k: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the environment variable.
- v: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The value of the environment variable.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the function parameters `k` or `v` contain null characters.

## class Process

```cangjie
public open class Process
```

Function: This class represents a process and provides process-related operations.

> **Note:**
>
> The specific functionalities provided are as follows:
>
> - Provides the ability to obtain the current process instance.
> - Provides the ability to bind a process instance based on the process `id`.
> - Provides the ability to create child processes based on input information.
> - Provides the ability to retrieve process information.
> - Provides the ability to terminate a process, with the option to force termination.

### static prop current <sup>(deprecated)</sup>

```cangjie
public static prop current: CurrentProcess
```

Function: Gets the current process instance.

> **Warning:**
>
> This will be deprecated in future versions. Use the global functions in the [env](../../env/env_package_overview.md#functions) package as a replacement.

Type: [CurrentProcess](process_package_classes.md#class-currentprocess-deprecated)

### prop arguments <sup>(deprecated)</sup>

```cangjie
public open prop arguments: Array<String>
```

Function: Gets the process arguments. On the `Windows` platform, this property cannot be obtained under non-privileged `API` scenarios.

> **Warning:**
>
> This will be deprecated in future versions.

Type: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)>

Exceptions:

- [ProcessException](process_package_exceptions.md#class-processexception) - Throws an exception when the process does not exist, the corresponding process is a zombie process, or when process arguments cannot be obtained under unsupported scenarios on the `Windows` platform.

### prop command

```cangjie
public prop command: String
```

Function: Gets the process command.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

Exceptions:

- [ProcessException](process_package_exceptions.md#class-processexception) - Throws an exception when the process does not exist, the corresponding process is a zombie process, or the process command cannot be obtained.

### prop commandLine <sup>(deprecated)</sup>

```cangjie
public prop commandLine: Array<String>
```

Function: Gets the command line of the current process. On the Windows platform, only the command line of the current process can be obtained. In other scenarios, this property cannot be obtained under non-privileged API conditions.

> **Warning:**
>
> This will be deprecated in future versions. Use [getcommandline()](../../env/env_package_api/env_package_funcs.md#func-getcommandline) as a replacement.

Type: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)>

Exceptions:

- [ProcessException](process_package_exceptions.md#class-processexception) - Throws an exception when the process does not exist, the corresponding process is a zombie process, or the command line cannot be obtained under other unsupported scenarios.

### prop environment <sup>(deprecated)</sup>

```cangjie
public prop environment: Map<String, String>
```

Function: Gets the environment variables of the current process. On the Windows platform, only the environment variables of the current process can be obtained. In other scenarios, this property cannot be obtained under non-privileged API conditions.

> **Warning:**
>
> This will be deprecated in future versions. Use [getVariables()](../../env/env_package_api/env_package_funcs.md#func-getvariables) as a replacement.

Type: [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v)\<[String](../../core/core_package_api/core_package_structs.md#struct-string), [String](../../core/core_package_api/core_package_structs.md#struct-string)>

Exceptions:

- [ProcessException](process_package_exceptions.md#class-processexception) - Throws an exception when the process does not exist, the corresponding process is a zombie process, or the environment variables cannot be obtained under other unsupported scenarios.

### prop name

```cangjie
public prop name: String
```

Function: Gets the process name.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

Exceptions:

- [ProcessException](process_package_exceptions.md#class-processexception) - Throws an exception when the process does not exist, the corresponding process is a zombie process, or the process name cannot be obtained.

### prop pid

```cangjie
public prop pid: Int64
```

Function: Gets the process `id`.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop startTime

```cangjie
public prop startTime: DateTime
```

Function: Gets the process start time. Returns [DateTime.UnixEpoch](../../time/time_package_api/time_package_structs.md#static-prop-unixepoch) on failure.

Type: [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime)

### prop systemTime

```cangjie
public prop systemTime: Duration
```

Function: Gets the process system time. Returns -1ms on failure.

Type: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

### prop userTime

```cangjie
public prop userTime: Duration
```

Function: Gets the process user time. Returns -1ms on failure.

Type: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

### prop workingDirectory <sup>(deprecated)</sup>

```cangjie
public prop workingDirectory: Path
```

Function: Gets the process working directory. For the `Windows` platform, this property only takes effect for the current process. In other scenarios, this property cannot be obtained without privileged `API`.

> **Note:**
>
> This will be deprecated in future versions. Use [getHomeDirectory()](../../env/env_package_api/env_package_funcs.md#func-gethomedirectory) instead.

Type: [Path](../../fs/fs_package_api/fs_package_structs.md#struct-path)

Exceptions:

- [ProcessException](process_package_exceptions.md#class-processexception) - Thrown when the process does not exist, the corresponding process is a zombie process, or the working directory cannot be obtained in unsupported scenarios on the `Windows` platform.

### func isAlive()

```cangjie
public func isAlive(): Bool
```

Function: Checks whether the process is alive.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the process is alive, otherwise `false`.

### static func of(Int64) <sup>(deprecated)</sup>

```cangjie
public static func of(pid: Int64): Process
```

Function: Binds a process instance based on the input process `id`.

> **Note:**
>
> This will be deprecated in future versions. Use [findProcess](./process_package_funcs.md#func-findprocessint64) instead.

Parameters:

- pid: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The process `id`.

Return Value:

- [Process](process_package_classes.md#class-process) - Returns the process instance corresponding to the process `id`.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the input process `id` exceeds the maximum value of [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) or is less than `0`.
- [ProcessException](process_package_exceptions.md#class-processexception) - Thrown when memory allocation fails or the process corresponding to `pid` does not exist.

### static func run(String, Array\<String>, ?Path, ?Map\<String, String>, ProcessRedirect, ProcessRedirect, ProcessRedirect, ?Duration) <sup>(deprecated)</sup>

```cangjie
public static func run(command: String,
                      arguments: Array<String>,
                      workingDirectory!: ?Path = None,
                      environment!: ?Map<String, String> = None,
                      stdIn!: ProcessRedirect = Inherit,
                      stdOut!: ProcessRedirect = Inherit,
                      stdErr!: ProcessRedirect = Inherit,
                      timeout!: ?Duration = None): Int64
```

Function: Creates and runs a child process based on the input parameters, waits for the child process to complete, and returns the child process exit status.

> **Note:**
>
> - This will be deprecated in future versions. Use [execute](./process_package_funcs.md#func-executestring-arraystring-path-mapstring-string-processredirect-processredirectprocessredirect-duration) instead.
> - On the `Windows` platform, deleting the child process executable immediately after execution may fail with an `Access is denied` exception. If this occurs, retry the deletion after a short delay. For implementation details, refer to the example.

Parameters:

- command: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Specifies the child process command. `command` must not contain null characters.
- arguments: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - Specifies the child process arguments. `arguments` must not contain null characters in the array strings.
- workingDirectory!: ?[Path](../../fs/fs_package_api/fs_package_structs.md#struct-path) - Named optional parameter. Specifies the child process working directory. Defaults to inheriting the current process working directory. The path must be an existing directory and must not be empty or contain null characters.
- environment!: ?[Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v)\<[String](../../core/core_package_api/core_package_structs.md#struct-string), [String](../../core/core_package_api/core_package_structs.md#struct-string)> - Named optional parameter. Specifies the child process environment variables. Defaults to inheriting the current process environment variables. `key` must not contain null characters or `'='`, and `value` must not contain null characters.
- stdIn!: [ProcessRedirect](process_package_enums.md#enum-processredirect) - Named optional parameter. Specifies the child process standard input redirection. Defaults to inheriting the current process standard input.
- stdOut!: [ProcessRedirect](process_package_enums.md#enum-processredirect) - Named optional parameter. Specifies the child process standard output redirection. Defaults to inheriting the current process standard output.
- stdErr!: [ProcessRedirect](process_package_enums.md#enum-processredirect) - Named optional parameter. Specifies the child process standard error redirection. Defaults to inheriting the current process standard error.
- timeout!: ?[Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - Named optional parameter. Specifies the timeout for waiting for the child process. Defaults to no timeout. A `timeout` of `0` or negative value means no timeout.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Returns the child process exit status. If the child process exits normally, returns the exit code. If the child process is killed by a signal, returns the signal number that caused the termination.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when `command` contains null characters, `arguments` contains null characters in array strings, `workingDirectory` is not an existing directory or is empty or contains null characters, `environment` `key` contains null characters or `'='`, `value` contains null characters, or `stdIn`, `stdOut`, `stdErr` are in file mode and the input file is closed or deleted.
- [ProcessException](process_package_exceptions.md#class-processexception) - Thrown when memory allocation fails, the `command` does not exist, or the wait times out.

### static func runOutput(String, Array\<String>, ?Path, ?Map\<String, String>, ProcessRedirect, ProcessRedirect, ProcessRedirect) <sup>(deprecated)</sup>

```cangjie
public static func runOutput(command: String,
                            arguments: Array<String>,
                            workingDirectory!: ?Path = None,
                            environment!: ?Map<String, String> = None,
                            stdIn!: ProcessRedirect = Inherit,
                            stdOut!: ProcessRedirect = Pipe,
                            stdErr!: ProcessRedirect = Pipe): (Int64, Array<Byte>, Array<Byte>)
```

Function: Creates and runs a child process based on the input parameters, waits for the child process to complete, and returns the child process exit status, standard output, and standard error. This function is not suitable for scenarios with large output streams or error streams. For such cases, use the standard stream properties provided in [SubProcess](process_package_classes.md#class-subprocess) combined with the `wait` function for custom handling.

> **Note:**
>
> This will be deprecated in future versions. Use [executeWithOutput](./process_package_funcs.md#func-executewithoutputstring-arraystring-path-mapstring-string-processredirect-processredirect-processredirect) instead.

Parameters:

- command: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Specifies the child process command. `command` must not contain null characters.
- arguments: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - Specifies the child process arguments. `arguments` must not contain null characters in the array strings.
- workingDirectory!: ?[Path](../../fs/fs_package_api/fs_package_structs.md#struct-path) - Named optional parameter. Specifies the child process working directory. Defaults to inheriting the current process working directory. The path must be an existing directory and must not be empty or contain null characters.
- environment!: ?[Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v)\<[String](../../core/core_package_api/core_package_structs.md#struct-string), [String](../../core/core_package_api/core_package_structs.md#struct-string)> - Named optional parameter. Specifies the child process environment variables. Defaults to inheriting the current process environment variables. `key` must not contain null characters or `'='`, and `value` must not contain null characters.
- stdIn!: [ProcessRedirect](process_package_enums.md#enum-processredirect) - Named optional parameter. Specifies the child process standard input redirection. Defaults to inheriting the current process standard input.
- stdOut!: [ProcessRedirect](process_package_enums.md#enum-processredirect) - Named optional parameter. Specifies the child process standard output redirection. Defaults to inheriting the current process standard output.
- stdErr!: [ProcessRedirect](process_package_enums.md#enum-processredirect) - Named optional parameter. Specifies the child process standard error redirection. Defaults to inheriting the current process standard error.Return Value:

- ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64), [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>, [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>) - The execution result of the child process, including the child process exit status (if the child process exits normally, returns the exit code; if the child process is killed by a signal, returns the signal number that caused termination), the standard output result, and the error result of the process.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the input parameter `command` contains null characters, or strings in the `arguments` array contain null characters, or `workingDirectory` is not an existing directory or is an empty path or contains null characters, or the `key` string in the `environment` table contains null characters or `'='`, or the `value` string contains null characters, or when `stdIn`, `stdOut`, `stdErr` are in file mode and the input file has been closed or deleted.
- [ProcessException](process_package_exceptions.md#class-processexception) - Thrown when memory allocation fails, or the command corresponding to `command` does not exist, or the child process does not exist, or there is an exception in reading standard streams.

### static func start(String, Array\<String>, ?Path, ?Map\<String, String>, ProcessRedirect, ProcessRedirect, ProcessRedirect) <sup>(deprecated)</sup>

```cangjie
public static func start(command: String,
                        arguments: Array<String>,
                        workingDirectory!: ?Path = None,
                        environment!: ?Map<String, String> = None,
                        stdIn!: ProcessRedirect = Inherit,
                        stdOut!: ProcessRedirect = Inherit,
                        stdErr!: ProcessRedirect = Inherit): SubProcess
```

Function: Creates and runs a child process based on input parameters and returns a child process instance. After calling this function to create a child process, you must call the `wait` or `waitOutput` function; otherwise, the resources of the zombie process formed after the child process ends will not be reclaimed.

> **Note:**
>
> This function will be deprecated in future versions. Use [launch](./process_package_funcs.md#func-launchstring-arraystring-path-mapstring-string-processredirect-processredirect-processredirect) instead.

Parameters:

- command: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Specifies the child process command. `command` must not contain null characters.
- arguments: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - Specifies the child process arguments. Strings in the `arguments` array must not contain null characters.
- workingDirectory!: ?[Path](../../fs/fs_package_api/fs_package_structs.md#struct-path) - Named optional parameter specifying the working directory of the child process. Defaults to inheriting the current process's working directory. The path must be an existing directory and must not be an empty path or contain null characters.
- environment!: ?[Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v)\<[String](../../core/core_package_api/core_package_structs.md#struct-string), [String](../../core/core_package_api/core_package_structs.md#struct-string)> - Named optional parameter specifying the child process environment variables. Defaults to inheriting the current process's environment variables. The `key` string must not contain null characters or `'='`, and the `value` string must not contain null characters.
- stdIn!: [ProcessRedirect](process_package_enums.md#enum-processredirect) - Named optional parameter specifying the child process's standard input redirection. Defaults to inheriting the current process's standard input.
- stdOut!: [ProcessRedirect](process_package_enums.md#enum-processredirect) - Named optional parameter specifying the child process's standard output redirection. Defaults to inheriting the current process's standard output.
- stdErr!: [ProcessRedirect](process_package_enums.md#enum-processredirect) - Named optional parameter specifying the child process's standard error redirection. Defaults to inheriting the current process's standard error.

Return Value:

- [SubProcess](process_package_classes.md#class-subprocess) - Returns a child process instance.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the input parameter `command` contains null characters, or strings in the `arguments` array contain null characters, or `workingDirectory` is not an existing directory or is an empty path or contains null characters, or the `key` string in the `environment` table contains null characters or `'='`, or the `value` string contains null characters, or when `stdIn`, `stdOut`, `stdErr` are in file mode and the input file has been closed or deleted.
- [ProcessException](process_package_exceptions.md#class-processexception) - Thrown when memory allocation fails or the command corresponding to `command` does not exist.

### func terminate(Bool)

```cangjie
public func terminate(force!: Bool = false): Unit
```

Function: Terminates the process. The child process execution result includes the child process exit status (if the child process exits normally, returns the exit code; if the child process is killed by a signal, returns the signal number that caused termination), the standard output result, and the error result of the process.

Parameters:

- force!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Named optional parameter specifying whether to force-terminate the process. Defaults to `false`. If set to `false`, the process can end after releasing resources; if set to `true`, the process will be killed directly. On `Windows` platforms, this is implemented as force-terminating the process.

Exceptions:

- [ProcessException](process_package_exceptions.md#class-processexception) - Thrown if the process does not exist or termination is not allowed.

### func terminateAliveProcess(Int32, Bool)

```cangjie
protected open func terminateAliveProcess(pid: Int32, force: Bool): Unit
```

Function: Terminates the specified process. The child process execution result includes the child process exit status (if the child process exits normally, returns the exit code; if the child process is killed by a signal, returns the signal number that caused termination), the standard output result, and the error result of the process.

Parameters:

- pid: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The process `ID` to be terminated.

- force!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Named optional parameter specifying whether to force-terminate the process. Defaults to `false`. If set to `false`, the process can end after releasing resources; if set to `true`, the process will be killed directly. On `Windows` platforms, this is implemented as force-terminating the process.

Exceptions:

- [ProcessException](process_package_exceptions.md#class-processexception) - Thrown if the process does not exist or termination is not allowed.

## class SubProcess

```cangjie
public class SubProcess <: Process
```

Function: This class represents a child process, inheriting from the [Process](process_package_classes.md#class-process) class, and provides functionality related to child process operations.

> **Description:**
>
> The following functionalities are provided:
>
> - Provides mechanisms to obtain the standard streams (`stdIn`, `stdOut`, `stdErr`) of the child process.
> - Provides mechanisms to wait for the child process to return an exit status code, allowing setting a timeout for the wait.
> - Provides mechanisms to wait for the child process to return output results (including normal and abnormal execution results), allowing setting a timeout for the wait.

Parent Types:

- [Process](../process_package_overview.md#class-process)

### prop stdErr <sup>(deprecated)</sup>

```cangjie
public prop stdErr: InputStream
```

Function: Gets the input stream connected to the child process's standard error stream.

> **Note:**
>
> This property will be deprecated in future versions. Use [stdErrPipe](./process_package_classes.md#prop-stderrpipe) instead.

Type: [InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream)

### prop stdErrPipe

```cangjie
public prop stdErrPipe: InputStream
```

Function: Gets the input stream connected to the child process's standard error stream.

Type: [InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream)

### prop stdIn <sup>(deprecated)</sup>

```cangjie
public prop stdIn: OutputStream
```

Function: Gets the output stream connected to the child process's standard input stream.

> **Note:**
>
> This property will be deprecated in future versions. Use [stdInPipe](./process_package_classes.md#prop-stdinpipe) instead.

Type: [OutputStream](../../io/io_package_api/io_package_interfaces.md#interface-outputstream)

### prop stdInPipe

```cangjie
public prop stdInPipe: OutputStream
```

Function: Gets the output stream connected to the child process's standard input stream.

Type: [OutputStream](../../io/io_package_api/io_package_interfaces.md#interface-outputstream)

### prop stdOut <sup>(deprecated)</sup>

```cangjie
public prop stdOut: InputStream
```

Function: Obtains an input stream connected to the standard output stream of the child process.

> **Note:**
>
> This will be deprecated in future versions. Use [stdOutPipe](./process_package_classes.md#prop-stdoutpipe) instead.

Type: [InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream)

### prop stdOutPipe

```cangjie
public prop stdOutPipe: InputStream
```

Function: Obtains an input stream connected to the standard output stream of the child process.

Type: [InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream)

### func wait(?Duration)

```cangjie
public func wait(timeout!: ?Duration = None): Int64
```

Function: Blocks the current process to wait for the child process to complete execution and returns the child process exit status code, with an optional timeout parameter. For scenarios requiring standard stream operations (Pipe mode), users should prioritize handling standard streams to avoid deadlocks caused by full child process stream buffers when calling this function.

> **Description:**
>
> Timeout handling mechanism:
>
> - When no parameter is passed, `timeout` is `None`, or the value is less than or equal to [Duration](../../core/core_package_api/core_package_structs.md#struct-duration).Zero, blocks until the child process completes execution.
> - When `timeout` is greater than [Duration](../../core/core_package_api/core_package_structs.md#struct-duration).Zero, blocks until the child process completes execution or throws a timeout exception upon expiration.

Parameters:

- timeout!: ?[Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - Named optional parameter specifying the timeout duration for waiting on the child process. Defaults to `None`.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Returns the child process exit status. If the child process exits normally, returns the exit code; if terminated by a signal, returns the signal number that caused termination.

Exceptions:

- [TimeoutException](../../core/core_package_api/core_package_exceptions.md#class-timeoutexception) - Thrown when the wait times out before the child process exits.

### func waitOutput()

```cangjie
public func waitOutput(): (Int64, Array<Byte>, Array<Byte>)
```

Function: Blocks the current process to wait for the child process to complete execution and returns the child process exit status code along with the results (including standard output and error stream outputs). Not suitable for scenarios with large output volumes in standard/error streams. It is recommended to handle streams manually using the standard stream properties provided in [SubProcess](process_package_classes.md#class-subprocess) combined with the wait function.

Return Value:

- ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64), [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>, [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>) - Returns the child process execution result, including the exit status (exit code if normal termination, signal number if terminated by signal), standard output results, and error results.

Exceptions:

- [ProcessException](process_package_exceptions.md#class-processexception) - Thrown when the child process does not exist or standard stream reading fails.
