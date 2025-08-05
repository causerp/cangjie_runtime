# Class

## class Argopt <sup>(deprecated)</sup>

```cangjie
public class ArgOpt {
    public init(shortArgFormat: String)
    public init(longArgList: Array<String>)
    public init(shortArgFormat: String, longArgList: Array<String>)
    public init(args: Array<String>, shortArgFormat: String, longArgList: Array<String>)
}
```

Function: Used for parsing command-line arguments and provides functionality to retrieve parsing results.

A command-line argument consists of a prefix symbol, argument name, and argument value.

Where "-" denotes the prefix for short arguments (short command-line arguments), and "--" denotes the prefix for long arguments (long command-line arguments). Parsable short argument names must be alphabetic characters, while long argument name strings must satisfy: starting with a letter and not containing "=".

For example: "-a123" and "--target=abc.txt" are two command-line arguments, where "a" is the short argument name and "target" is the long argument name. Whereas "-123" and "--tar=get=abc.txt" are invalid command-line arguments.

This class allows users to specify argument names and argument strings, and provides methods to parse strings based on argument names.

When users specify short and long argument names, the formats are as follows:

- For short argument name strings, the format is: "a:", with the specification being: a combination of a single letter and ":", e.g., "ab:" will only parse "b" as the short argument name.
- For long argument name string array parameters, the string format is: "--testA=" or "testA=", with the specification being: "--" + long argument name + "=" (the prefix "--" can be omitted).

When parsing command-line arguments based on argument names, if the command-line argument format is correct and has a corresponding argument name, it will be correctly parsed and can be retrieved by the user; otherwise, it will not be parsed.

For example: If the argument name is "a:b:" and the command-line argument is "-a123 -cofo", it will parse out the command-line argument with the argument name "a" and argument value "123". "-cofo" will not be parsed.

> **Note:**
>
> This will be deprecated in future versions. Use [parseArguments](./argopt_package_function.md#func-parseargumentsarraystring-arrayargumentspec) instead.

### init(Array\<String>)

```cangjie
public init(longArgList: Array<String>)
```

Function: Constructs an `ArgOpt` instance and parses long argument names from the string list.

Parameters:

- longArgList: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - An array of strings containing long argument names.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the long argument name strings in the array do not conform to the specification, or the strings are not UTF-8 encoded, or the Unicode character does not exist.

### init(Array\<String>, String, Array\<String>)

```cangjie
public init(args: Array<String>, shortArgFormat: String, longArgList: Array<String>)
```

Function: Constructs an `ArgOpt` instance, parses short argument names from the short argument name string, and long argument names from the string list. If parsing succeeds, it then parses the corresponding values for the argument names from the command-line arguments specified by the `args` parameter.

Parameters:

- args: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - The array of command-line argument strings to be parsed.
- shortArgFormat: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string containing short argument names.
- longArgList: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - The array of strings containing long argument names.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the short argument name string does not conform to the specification, or the long argument name strings in the array do not conform to the specification, or the strings are not UTF-8 encoded, or the Unicode character does not exist.

### init(String)

```cangjie
public init(shortArgFormat: String)
```

Function: Constructs an `ArgOpt` instance and parses short argument names from the short argument name string.

Parameters:

- shortArgFormat: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string containing short argument names.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the short argument name string does not conform to the specification, or the string is not UTF-8 encoded, or the Unicode character does not exist.

### init(String, Array\<String>)

```cangjie
public init(shortArgFormat: String, longArgList: Array<String>)
```

Function: Constructs an `ArgOpt` instance, parses short argument names from the short argument name string, and long argument names from the string list.

Parameters:

- shortArgFormat: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string containing short argument names.
- longArgList: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - The array of strings containing long argument names.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the short argument name string does not conform to the specification, or the long argument name strings in the array do not conform to the specification, or the strings are not UTF-8 encoded, or the Unicode character does not exist.

### func getArg(String)

```cangjie
public func getArg(arg: String): Option<String>
```

Function: Returns the parsed value of the argument specified by the `arg` parameter.

Parameters:

- arg: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string consisting of the prefix and argument name (the prefix can be omitted).

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - The parsed argument value.

### func getArgumentsMap()

```cangjie
public func getArgumentsMap(): HashMap<String, String>
```

Function: Retrieves all parsed argument names and their values, returned as a hash map.

Return Value:

- [HashMap](../../collection/collection_package_api/collection_package_class.md#class-hashmapk-v)\<[String](../../core/core_package_api/core_package_structs.md#struct-string), [String](../../core/core_package_api/core_package_structs.md#struct-string)> - A hash map with parsed argument names as keys and their values as values.

### func getUnparseArgs()

```cangjie
public func getUnparseArgs(): Array<String>
```

Function: Returns the unparsed command-line arguments.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - An array containing the strings that were not parsed.