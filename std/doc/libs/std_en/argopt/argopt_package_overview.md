# std.argopt

## Feature Description

The argopt package provides capabilities for parsing parameter names and values from command-line argument strings.

Command-line arguments are parameters passed to a program via the command line, used to specify configurations or behaviors of the program. For example, a command-line program may have an argument to specify the name of the file it should process, or an argument to designate the database to use. These arguments are typically parsed and passed to the program's code so that it can execute its functions correctly based on these parameters.

Command-line arguments: Generally distinguished by whether they are prefixed with `-`, they can be categorized into options and non-options.

- Options: Prefixed with `-`.
    - Short options: Options prefixed with a single `-` and consisting of only a single character.
    - Long options: Options prefixed with `--`, usually containing multiple characters.
    - Short-prefixed long options: Options prefixed with a single `-` but containing multiple characters.
    - Short option combinations: Options prefixed with `-`, combining multiple short options in any order.
- Non-options: Not prefixed with `-`.

> **Note:**
>
> All arguments following a standalone "--" are also treated as non-options. For example, in "-f -- a -b --cde", "a", "-b", and "--cde" are all non-options.

## API List

### Functions

| Function Name | Functionality |
| ------------ | ------------ |
| [parseArguments](./argopt_package_api/argopt_package_function.md#func-parseargumentsarraystring-arrayargumentspec) | Parses corresponding arguments based on the given input and specifications. |

### Classes

| Class Name | Functionality |
| --------------------------------- | ---------------------------------- |
| [ArgOpt <sup>(deprecated)</sup>](./argopt_package_api/argopt_package_classes.md#class-argopt-deprecated) | `ArgOpt` is used to parse command-line arguments and provides functionality to retrieve the parsing results. |

### Enums

| Enum Name | Functionality |
| --------------------------------- | ---------------------------------- |
| [ArgumentMode](./argopt_package_api/argopt_package_enums.md#enum-argumentmode) | Argument mode. |
| [ArgumentSpec](./argopt_package_api/argopt_package_enums.md#enum-argumentspec) | Argument specification. |

### Structs

| Struct Name | Functionality |
|------------------------------------------------------------------------------------- | ------------------------ |
| [ParsedArguments](./argopt_package_api/argopt_package_struct.md#struct-parsedarguments) | Argument parsing results. |

### Exception Classes

| Exception Class Name | Functionality |
| --------------------------------- | ---------------------------------- |
| [ArgumentParseException](./argopt_package_api/argopt_package_exception.md#class-argumentparseexception) | This exception is thrown when parsing fails. |