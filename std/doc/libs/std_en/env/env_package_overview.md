# std.env

## Functionality Overview

The env package provides information and functionalities related to the current process, including environment variables, command-line arguments, standard streams, and process termination. It also offers methods to interact with standard input, standard output, and standard error.

This package delivers cross-platform unified control capabilities, currently supporting Linux, macOS, and Windows platforms.

The package provides [getStdErr()](./env_package_api/env_package_funcs.md#func-getStdErr), [getStdIn()](./env_package_api/env_package_funcs.md#func-getStdIn), and [getStdOut()](./env_package_api/env_package_funcs.md#func-getStdOut) for accessing these three standard streams.

- [ConsoleReader](./env_package_api/env_package_classes.md#class-consolereader) encapsulates functionalities related to the standard input stream, allowing data to be read from standard input through its `read` methods.
- [ConsoleWriter](./env_package_api/env_package_classes.md#class-consolewriter) encapsulates functionalities related to standard output and standard error streams. [ConsoleWriter](./env_package_api/env_package_classes.md#class-consolewriter) provides a series of `write` methods for writing data to standard output and standard error.

Standard input (stdin), standard output (stdout), and standard error (stderr) are three common streams in computer operating systems.

Standard input is the stream through which programs receive input data from users, typically from keyboard input. Standard output is the stream through which programs output results to users, usually displayed on screen. Standard error is the stream through which programs output error messages when errors occur, also typically displayed on screen.

In Unix/Linux systems, standard input, standard output, and standard error correspond to file descriptors 0, 1, and 2 respectively. Programs can use these file descriptors to read and write data. For example, redirection symbols can be used to redirect standard output to files or pipe standard error to another program's standard input.

## API List

### Classes

| Class Name | Functionality |
| :------------ | :------------ |
| [ConsoleReader](./env_package_api/env_package_classes.md#class-consolereader) | Provides functionality to read characters or strings from standard input. |
| [ConsoleWriter](./env_package_api/env_package_classes.md#class-consolewriter) | Provides functionality to write characters or strings to standard output or standard error streams. |

### Functions

| Function | Functionality |
| ------------ | ------------ |
| [atExit()](./env_package_api/env_package_funcs.md#func-atexit---unit) | Registers a callback function to be executed when the current process exits. |
| [exit()](./env_package_api/env_package_funcs.md#func-exitint64) | Terminates the process. |
| [getCommand()](./env_package_api/env_package_funcs.md#func-getCommand) | Retrieves the current process command. |
| [getCommandLine()](./env_package_api/env_package_funcs.md#func-getCommandLine) | Retrieves the current process command line. |
| [getHomeDirectory()](./env_package_api/env_package_funcs.md#func-getHomeDirectory) | Retrieves the path of the current process's home directory. |
| [getProcessId()](./env_package_api/env_package_funcs.md#func-getProcessId) | Retrieves the current process ID. |
| [getStdErr()](./env_package_api/env_package_funcs.md#func-getStdErr) | Retrieves the standard error stream of the current process. |
| [getStdIn()](./env_package_api/env_package_funcs.md#func-getStdIn) | Retrieves the standard input stream of the current process. |
| [getStdOut()](./env_package_api/env_package_funcs.md#func-getStdOut) | Retrieves the standard output stream of the current process. |
| [getTempDirectory()](./env_package_api/env_package_funcs.md#func-getTempDirectory) | Retrieves the path of the current process's temporary directory. |
| [getVariable()](./env_package_api/env_package_funcs.md#func-getvariablestring) | Retrieves the value of a specified environment variable for the current process. |
| [getVariables()](./env_package_api/env_package_funcs.md#func-getvariables) | Retrieves all environment variables of the current process. |
| [getWorkingDirectory()](./env_package_api/env_package_funcs.md#func-getWorkingDirectory) | Retrieves the working directory path of the current process. |
| [removeVariable()](./env_package_api/env_package_funcs.md#func-removevariablestring) | Removes an environment variable by its specified name. |
| [setVariable()](./env_package_api/env_package_funcs.md#func-setvariablestring-string) | Sets an environment variable pair for the current process. |

### Exception Classes

| Exception Class | Functionality |
| --------------------------- | ------------------------ |
| [EnvException](./env_package_api/env_package_exceptions.md#class-envexception) | The exception class for the `env` package. |