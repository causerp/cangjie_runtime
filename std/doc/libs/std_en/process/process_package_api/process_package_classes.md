# Classes

## class CurrentProcess <sup>(deprecated)</sup>

```cangjie
public class CurrentProcess <: Process
```

Functionality: This class represents the current process, inheriting from the [Process](process_package_classes.md#class-process) class, providing operations related to the current process.

Features include:

- Provides mechanisms to obtain standard streams (`stdIn`, `stdOut`, `stdErr`) of the current process.
- Provides a mechanism to register callback functions upon process exit.
- Provides a process exit mechanism allowing setting of exit status codes.

> **Note:**
>
> This class will be deprecated in future versions.

Parent Type:

- [Process](../process_package_overview.md#class-process)

### prop arguments

```cangjie
public prop arguments: Array<String>
```

Functionality: Returns the argument list of the current process. For example, if the command line is `a.out ab cd ef` where `a.out` is the program name, the returned list contains three elements: ab, cd, ef.

> **Note:**
>
> - When using C language to call the Cangjie dynamic library, command line arguments set via `int SetCJCommandLineArgs(int argc, const char* argv[])` will discard the first argument when retrieved using `arguments`.

Type: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)>

### prop homeDirectory

```cangjie
public prop homeDirectory: Path
```

Functionality: Gets the path to the home directory.

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

Functionality: Gets the path to the temporary directory. Retrieves environment variables `TMPDIR`, `TMP`, `TEMP`, and `TEMPDIR`. If none exist, defaults to `/tmp`.

Type: [Path](../../fs/fs_package_api/fs_package_structs.md#struct-path)

### func atExit(() -> Unit)

```cangjie
public func atExit(callback: () -> Unit): Unit
```

Functionality: Registers a callback function to be executed upon process exit.

> **Note:**
>
> Do not use the C language `atexit` function to avoid unexpected issues.

Parameters:

- callback: () ->[Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - The callback function to register.

### func exit(Int64)

```cangjie
public func exit(code: Int64): Nothing
```

Functionality: Terminates the current process immediately with the specified exit status code.

Parameters:

- code: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The exit status code for the current process.

### func getEnv(String)

```cangjie
public func getEnv(k: String): Option<String>
```

Functionality: Gets the value of the specified environment variable.

Parameters:

- k: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the environment variable.

Returns:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - The value corresponding to the specified name.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if parameter `k` contains a null character.

### func removeEnv(String)

```cangjie
public func removeEnv(k: String): Unit
```

Functionality: Removes the specified environment variable by name.

Parameters:

- k: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the environment variable.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if parameter `k` contains a null character.

### func setEnv(String, String)

```cangjie
public func setEnv(k: String, v: String): Unit
```

Functionality: Sets an environment variable pair. If an existing variable with the same name exists, its value will be overwritten.

> **Note:**
>
> On Windows, if parameter `v` is an empty string, variable `k` will be removed from the environment.

Parameters:

- k: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the environment variable.
- v: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The value of the environment variable.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if parameters `k` or `v` contain null characters.

## class Process

```cangjie
public open class Process
```

Functionality: This class represents a process, providing process-related operations.

> **Note:**
>
> Features include:
>
> - Provides functionality to get the current process instance.
> - Provides functionality to bind a process instance by process `id`.
> - Provides functionality to create child processes based on input parameters.
> - Provides functionality to get process information.
> - Provides functionality to terminate processes, allowing specification of forced termination.

### static prop current <sup>(deprecated)</sup>

```cangjie
public static prop current: CurrentProcess
```

Functionality: Gets the current process instance.

> **Note:**
>
> Will be deprecated in future versions. Use global functions from the [env](../../env/env_package_overview.md#functions) package instead.

Type: [CurrentProcess](process_package_classes.md#class-currentprocess-deprecated)

### prop arguments <sup>(deprecated)</sup>

```cangjie
public open prop arguments: Array<String>
```

Functionality: Gets process arguments. On Windows, this property cannot be retrieved without privileged API access.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)>

Exceptions:

- [ProcessException](process_package_exceptions.md#class-processexception) - Thrown if the process does not exist, is a zombie process, or cannot be accessed without privileged API on Windows.

### prop command

```cangjie
public prop command: String
```

Functionality: Gets the process command.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

Exceptions:

- [ProcessException](process_package_exceptions.md#class-processexception) - Thrown if the process does not exist or is a zombie process.

### prop commandLine <sup>(deprecated)</sup>

```cangjie
public prop commandLine: Array<String>
```

Functionality: Gets the command line of the current process. On Windows, only the current process command line can be retrieved; other scenarios require privileged API access.

> **Note:**
>
> Will be deprecated in future versions. Use [getcommandline()](../../env/env_package_api/env_package_funcs.md#func-getcommandline) instead.

Type: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)>

Exceptions:

- [ProcessException](process_package_exceptions.md#class-processexception) - Thrown if the process does not exist, is a zombie process, or cannot be accessed without privileged API.

### prop environment <sup>(deprecated)</sup>

```cangjie
public prop environment: Map<String, String>
```

Functionality: Gets the environment variables of the current process. On Windows, only the current process environment variables can be retrieved; other scenarios require privileged API access.

> **Note:**
>
> Will be deprecated in future versions. Use [getVariables()](../../env/env_package_api/env_package_funcs.md#func-getvariables) instead.

Type: [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v)\<[String](../../core/core_package_api/core_package_structs.md#struct-string), [String](../../core/core_package_api/core_package_structs.md#struct-string)>

Exceptions:

- [ProcessException](process_package_exceptions.md#class-processexception) - Thrown if the process does not exist, is a zombie process, or cannot be accessed without privileged API.

### prop name

```cangjie
public prop name: String
```

Functionality: Gets the process name.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

Exceptions:

- [ProcessException](process_package_exceptions.md#class-processexception) - Thrown if the process does not exist or is a zombie process.

### prop pid

```cangjie
public prop pid: Int64
```

Functionality: Gets the process ID.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop startTime

```cangjie
public prop startTime: DateTime
```

Functionality: Gets the process start time. Returns [DateTime.UnixEpoch](../../time/time_package_api/time_package_structs.md#static-prop-unixepoch) on failure.

Type: [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime)

### prop systemTime

```cangjie
public prop systemTime: Duration
```

Functionality: Gets the process system time. Returns -1ms on failure.

Type: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

### prop userTime

```cangjie
public prop userTime: Duration
```

Functionality: Gets the process user time. Returns -1ms on failure.

Type: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

### prop workingDirectory <sup>(deprecated)</sup>

```cangjie
public prop workingDirectory: Path
```

Functionality: Gets the working directory of the process. On Windows, this only applies to the current process; other scenarios require privileged API access.

> **Note:**
>
> Will be deprecated in future versions. Use [getHomeDirectory()](../../env/env_package_api/env_package_funcs.md#func-gethomedirectory) instead.

Type: [Path](../../fs/fs_package_api/fs_package_structs.md#struct-path)

Exceptions:

- [ProcessException](process_package_exceptions.md#class-processexception) - Thrown if the process does not exist, is a zombie process, or cannot be accessed without privileged API on Windows.

### func isAlive()

```cangjie
public func isAlive(): Bool
```

Functionality: Checks if the process is alive.

Returns:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` if alive, otherwise `false`.

### static func of(Int64) <sup>(deprecated)</sup>

```cangjie
public static func of(pid: Int64): Process
```

Functionality: Binds a process instance by process ID.

> **Note:**
>
> Will be deprecated in future versions. Use [findProcess](./process_package_funcs.md#func-findprocessint64) instead.

Parameters:

- pid: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The process ID.

Returns:

- [Process](process_package_classes.md#class-process) - The process instance corresponding to the process ID.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the process ID exceeds [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) maximum or is negative.
- [ProcessException](process_package_exceptions.md#class-processexception) - Thrown if memory allocation fails or the process does not exist.

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

Functionality: Creates and runs a child process based on input parameters, waits for completion, and returns the exit status.

> **Note:**
>
> - Will be deprecated in future versions. Use [execute](./process_package_funcs.md#func-executestring-arraystring-path-mapstring-string-processredirect-processredirectprocessredirect-duration) instead.
> - On Windows, deleting the child process executable immediately after completion may fail with `Access is denied`. Retry after a short delay if needed.

Parameters:

- command: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The child process command (cannot contain null characters).
- arguments: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - Child process arguments (cannot contain null characters).
- workingDirectory!: ?[Path](../../fs/fs_package_api/fs_package_structs.md#struct-path) - Optional named parameter for the working directory (default: inherits current process).
- environment!: ?[Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v)\<[String](../../core/core_package_api/core_package_structs.md#struct-string), [String](../../core/core_package_api/core_package_structs.md#struct-string)> - Optional named parameter for environment variables (default: inherits current process).
- stdIn!: [ProcessRedirect](process_package_enums.md#enum-processredirect) - Optional named parameter for stdin redirection (default: inherits current process).
- stdOut!: [ProcessRedirect](process_package_enums.md#enum-processredirect) - Optional named parameter for stdout redirection (default: inherits current process).
- stdErr!: [ProcessRedirect](process_package_enums.md#enum-processredirect) - Optional named parameter for stderr redirection (default: inherits current process).
- timeout!: ?[Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - Optional named parameter for timeout (default: no timeout).

Returns:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Exit status (exit code if normal termination, signal number if killed).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown for invalid parameters.
- [ProcessException](process_package_exceptions.md#class-processexception) - Thrown if memory allocation fails, command does not exist, or timeout occurs.

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

Functionality: Creates and runs a child process, waits for completion, and returns exit status, stdout, and stderr. Not suitable for large outputs—use [SubProcess](process_package_classes.md#class-subprocess) with `wait` instead.

> **Note:**
>
> Will be deprecated in future versions. Use [executeWithOutput](./process_package_funcs.md#func-executewithoutputstring-arraystring-path-mapstring-string-processredirect-processredirect-processredirect) instead.

Parameters: (Same as `run` function)

Returns:

- ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64), [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>, [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>) - Tuple containing exit status, stdout, and stderr.

Exceptions: (Same as `run` function)

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

Functionality: Creates and runs a child process, returning a child process instance. Call `wait` or `waitOutput` to avoid zombie processes.

> **Note:**
>
> Will be deprecated in future versions. Use [launch](./process_package_funcs.md#func-launchstring-arraystring-path-mapstring-string-processredirect-processredirect-processredirect) instead.

Parameters: (Same as `run` function)

Returns:

- [SubProcess](process_package_classes.md#class-subprocess) - The child process instance.

Exceptions: (Same as `run` function)

### func terminate(Bool)

```cangjie
public func terminate(force!: Bool = false): Unit
```

Functionality: Terminates the process.

Parameters:

- force!: [Bool](../../core/core_package_api/core_package_intrinsics.md## class SubProcess

```cangjie
public class SubProcess <: Process
```

Functionality: This class represents a subprocess, inheriting from the [Process](process_package_classes.md#class-process) class, providing operations related to subprocess management.

> **Note:**
>
> The specific functionalities provided are as follows:
>
> - Mechanism to obtain subprocess standard streams (`stdIn`, `stdOut`, `stdErr`).
> - Mechanism to wait for subprocess execution and return exit status code, with configurable timeout duration.
> - Mechanism to wait for subprocess execution and return output results (including normal and error outputs), with configurable timeout duration.

Parent Type:

- [Process](../process_package_overview.md#class-process)

### prop stdErr <sup>(deprecated)</sup>

```cangjie
public prop stdErr: InputStream
```

Functionality: Gets the input stream connected to the subprocess's standard error stream.

> **Warning:**
>
> This property will be deprecated in future versions. Use [stdErrPipe](./process_package_classes.md#prop-stderrpipe) instead.

Type: [InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream)

### prop stdErrPipe

```cangjie
public prop stdErrPipe: InputStream
```

Functionality: Gets the input stream connected to the subprocess's standard error stream.

Type: [InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream)

### prop stdIn <sup>(deprecated)</sup>

```cangjie
public prop stdIn: OutputStream
```

Functionality: Gets the output stream connected to the subprocess's standard input stream.

> **Warning:**
>
> This property will be deprecated in future versions. Use [stdInPipe](./process_package_classes.md#prop-stdinpipe) instead.

Type: [OutputStream](../../io/io_package_api/io_package_interfaces.md#interface-outputstream)

### prop stdInPipe

```cangjie
public prop stdInPipe: OutputStream
```

Functionality: Gets the output stream connected to the subprocess's standard input stream.

Type: [OutputStream](../../io/io_package_api/io_package_interfaces.md#interface-outputstream)

### prop stdOut <sup>(deprecated)</sup>

```cangjie
public prop stdOut: InputStream
```

Functionality: Gets the input stream connected to the subprocess's standard output stream.

> **Warning:**
>
> This property will be deprecated in future versions. Use [stdOutPipe](./process_package_classes.md#prop-stdoutpipe) instead.

Type: [InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream)

### prop stdOutPipe

```cangjie
public prop stdOutPipe: InputStream
```

Functionality: Gets the input stream connected to the subprocess's standard output stream.

Type: [InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream)

### func wait(?Duration)

```cangjie
public func wait(timeout!: ?Duration = None): Int64
```

Functionality: Blocks the current process to wait for the subprocess task to complete and returns the subprocess exit status code, with configurable timeout duration. For scenarios requiring standard stream operations (Pipe mode), users should prioritize handling standard streams to avoid deadlocks when the subprocess's stream buffer becomes full before calling this function.

> **Note:**
>
> Timeout handling mechanism:
>
> - When no parameter is passed, `timeout` is `None`, or the value is less than or equal to [Duration](../../core/core_package_api/core_package_structs.md#struct-duration).Zero, it blocks until the subprocess completes.
> - When `timeout` is greater than [Duration](../../core/core_package_api/core_package_structs.md#struct-duration).Zero, it blocks until the subprocess completes or throws a timeout exception if the wait times out.

Parameters:

- timeout!: ?[Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - Named optional parameter specifying the timeout duration for waiting on the subprocess. Defaults to `None`.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Returns the subprocess exit status. If the subprocess exits normally, returns the exit code; if terminated by a signal, returns the signal number that caused termination.

Exceptions:

- [TimeoutException](../../core/core_package_api/core_package_exceptions.md#class-timeoutexception) - Thrown when the wait times out before the subprocess exits.

### func waitOutput()

```cangjie
public func waitOutput(): (Int64, Array<Byte>, Array<Byte>)
```

Functionality: Blocks the current process to wait for the subprocess task to complete and returns the subprocess exit status code along with output results (including standard output and error streams). This function is not suitable for scenarios with large output volumes in standard/error streams. It's recommended to use the standard stream properties provided in [SubProcess](process_package_classes.md#class-subprocess) combined with the wait function for custom handling.

Return Value:

- ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64), [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>, [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>) - Subprocess execution results, including exit status (exit code if normal termination, signal number if terminated by signal), standard output results, and error output results.

Exceptions:

- [ProcessException](process_package_exceptions.md#class-processexception) - Thrown when the subprocess does not exist or standard stream reading fails.