# std.console<sup>(deprecated)</sup>

> **Note:**
>
> This package will be deprecated in future versions. Consider using the env package as an alternative.

## Functionality Overview

The `console` package provides methods for interacting with standard input, standard output, and standard error streams.

This package offers the [Console](console_package_api/console_package_class.md#class-console-deprecated) class for accessing these three standard streams.

- [ConsoleReader](console_package_api/console_package_class.md#class-consolereader-deprecated) encapsulates functionality related to standard input stream, providing various `read` methods for retrieving data from stdin.
- [ConsoleWriter](console_package_api/console_package_class.md#class-consolewriter-deprecated) encapsulates functionality related to standard output and standard error streams, offering a series of `write` methods for outputting data to stdout and stderr.

Standard input (stdin), standard output (stdout), and standard error (stderr) are three common streams in computer operating systems.

Standard input is the stream through which programs receive user input, typically from keyboard. Standard output is the stream for program output results, usually displayed on screen. Standard error is the stream for error messages when programs encounter issues, also typically displayed on screen.

In Unix/Linux systems, standard input, output, and error correspond to file descriptors 0, 1, and 2 respectively. Programs can use these file descriptors for reading and writing data. For example, redirection symbols can be used to redirect stdout to a file or pipe stderr to another program's stdin.

## API List

### Classes

| Class Name | Functionality |
| :------------ | :------------ |
| [Console](console_package_api/console_package_class.md#class-console-deprecated)   | Provides interfaces for accessing standard input, output, and error Streams.  |
| [ConsoleReader](console_package_api/console_package_class.md#class-consolereader-deprecated)  |  Provides functionality for reading characters or strings from standard input. |
| [ConsoleWriter](console_package_api/console_package_class.md#class-consolewriter-deprecated)  |  Provides functionality for writing characters or strings to standard output or standard error streams. |