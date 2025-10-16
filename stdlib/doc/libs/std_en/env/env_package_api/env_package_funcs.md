# Functions

## func atExit(() -> Unit)

```cangjie
public func atExit(callback: () -> Unit): Unit
```

Function: Registers a callback function to be executed when the current process exits.

> **Note:**
>
> Do not use the C language `atexit` function to avoid unexpected issues.

Parameters:

- callback: () ->[Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - The callback function to be registered.

## func exit(Int64)

```cangjie
public func exit(code: Int64): Nothing
```

Function: Immediately terminates the current process and returns the specified exit status code.

Parameters:

- code: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The exit status code for the current process.

## func getCommand()

```cangjie
public func getCommand(): String
```

Function: Retrieves the process command.

Return value:

- [String](../../../std_en/core/core_package_api/core_package_structs.md#struct-string) - The command of the current process.

Exceptions:

- [EnvException](./env_package_exceptions.md#class-envexception) - Thrown when the process does not exist or the corresponding process is a zombie process, making it impossible to retrieve the process name.

## func getCommandLine()

```cangjie
public func getCommandLine(): Array<String>
```

Function: Retrieves the command line of the current process. On Windows platforms, only the command line of the current process can be retrieved. In other scenarios, this property cannot be obtained without privileged APIs.

Return value:

- [Array](../../../std_en/core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../../std_en/core/core_package_api/core_package_structs.md#struct-string)> - The command line of the current process.

Exceptions:

- [EnvException](./env_package_exceptions.md#class-envexception) - Thrown when the process does not exist, the corresponding process is a zombie process, or the command line cannot be retrieved in other unsupported scenarios.

## func getHomeDirectory()

```cangjie
public func getHomeDirectory(): Path
```

Function: Retrieves the home directory path of the current process.

Return value:

- [Path](../../fs/fs_package_api/fs_package_structs.md#struct-path) - The home directory path of the current process.

## func getProcessId()

```cangjie
public func getProcessId(): Int64
```

Function: Retrieves the current process ID.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The current process ID.

## func getStdErr()

```cangjie
public func getStdErr(): ConsoleWriter
```

Function: Retrieves the standard error stream of the current process.

Return value:

- [ConsoleWriter](./env_package_classes.md#class-consolewriter) - The standard error stream of the process.

## func getStdIn()

```cangjie
public func getStdIn(): ConsoleReader
```

Function: Retrieves the standard input stream of the current process.

Return value:

- [ConsoleReader](./env_package_classes.md#class-consolereader) - The standard input stream of the process.

## func getStdOut()

```cangjie
public func getStdOut(): ConsoleWriter
```

Function: Retrieves the standard output stream of the current process.

Return value:

- [ConsoleWriter](./env_package_classes.md#class-consolewriter) - The standard output stream of the process.

## func getTempDirectory()

```cangjie
public func getTempDirectory(): Path
```

Function: Retrieves the temporary directory path of the current process. Obtains environment variables TMPDIR, TMP, TEMP, and TEMPDIR. If none of these variables exist, defaults to returning the `/tmp` directory.

Return value:

- [Path](../../fs/fs_package_api/fs_package_structs.md#struct-path) - The temporary directory path of the current process.

## func getVariable(String)

```cangjie
public func getVariable(key: String): ?String
```

Function: Retrieves the value of the environment variable with the specified name for the current process.

Parameters:

- key: [String](../../../std_en/core/core_package_api/core_package_structs.md#struct-string) - The specified name.

Return value:

- ?[String](../../../std_en/core/core_package_api/core_package_structs.md#struct-string) - The value of the specified environment variable for the current process.

Exceptions:

- [IllegalArgumentException](../../../std_en/core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the function parameter `key` contains a null character.

## func getVariables()

```cangjie
public func getVariables(): Array<(String, String)>
```

Function: Retrieves the environment variables of the current process. On Windows platforms, only the environment variables of the current process can be retrieved. In other scenarios, this property cannot be obtained without privileged APIs.

Return value:

- [Array](../../../std_en/core/core_package_api/core_package_structs.md#struct-arrayt)\<([String](../../../std_en/core/core_package_api/core_package_structs.md#struct-string), [String](../../../std_en/core/core_package_api/core_package_structs.md#struct-string))> - The environment variables of the current process.

Exceptions:

- [EnvException](./env_package_exceptions.md#class-envexception) - Thrown when the process does not exist, the corresponding process is a zombie process, or the environment variables cannot be retrieved in other unsupported scenarios.

## func getWorkingDirectory()

```cangjie
public func getWorkingDirectory(): Path
```

Function: Retrieves the working directory path of the current process. On Windows platforms, only the working directory path of the current process can be retrieved. In other scenarios, this property cannot be obtained without privileged APIs.

Return value:

- [Path](../../fs/fs_package_api/fs_package_structs.md#struct-path) - The working directory path of the current process.

Exceptions:

- [EnvException](./env_package_exceptions.md#class-envexception) - Thrown when the process does not exist, the corresponding process is a zombie process, or the working directory path cannot be retrieved in other unsupported scenarios.

## func removeVariable(String)

```cangjie
public func removeVariable(key: String): Unit
```

Function: Removes an environment variable by its specified name.

Parameters:

- key: [String](../../../std_en/core/core_package_api/core_package_structs.md#struct-string) - The name of the environment variable.

Exceptions:

- [IllegalArgumentException](../../../std_en/core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the function parameter `key` contains a null character.

## func setVariable(String, String)

```cangjie
public func setVariable(key: String, value: String): Unit
```

Function: Sets a pair of environment variables. If an environment variable with the same name already exists, its original value will be overwritten.

> **Note:**
>
> On Windows, if the parameter `value` is an empty string, the variable `key` will be removed from the environment.

Parameters:

- key: [String](../../../std_en/core/core_package_api/core_package_structs.md#struct-string) - The name of the environment variable.
- value: [String](../../../std_en/core/core_package_api/core_package_structs.md#struct-string) - The value of the environment variable.

Exceptions:

- [IllegalArgumentException](../../../std_en/core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the function parameters `key` or `value` contain null characters.