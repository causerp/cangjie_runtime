# Functions

## func parseArguments(Array\<String>, Array\<ArgumentSpec>)

```cangjie
public func parseArguments(args: Array<String>, specs: Array<ArgumentSpec>): ParsedArguments
```

Function: Parses command-line arguments `args` according to the provided argument specifications `specs`, returning a structured object containing the parsed options and non-option arguments.

This function matches each argument in `args` with the options defined in `specs`. For successfully matched options, it adds the option name and corresponding value to [options](./argopt_package_struct.md#prop-options). Unmatched arguments are treated as non-option arguments and added to [nonOptions](./argopt_package_struct.md#prop-nonoptions). Additionally, when encountering `--`, option scanning terminates early, and all subsequent arguments are treated as `non-option` arguments.

The function supports parsing and handling of:
- Short options
- Long options
- Short-prefixed long options
- Combined short options
- Non-option arguments
- Illegal options

The [ArgumentMode](./argopt_package_enums.md#enum-argumentmode) held by each [ArgumentSpec](./argopt_package_enums.md#enum-argumentspec) in `specs` determines how arguments are processed.

- For long options, only the following formats can be processed based on different [ArgumentMode](./argopt_package_enums.md#enum-argumentmode):
    - [RequiredValue](./argopt_package_enums.md#requiredvalue): `--option=value` or `--option value`
    - [OptionalValue](./argopt_package_enums.md#optionalvalue): `--option=value` or `--option`
    - [NoValue](./argopt_package_enums.md#novalue): `--option`

- For short options, only the following formats can be processed based on different [ArgumentMode](./argopt_package_enums.md#enum-argumentmode):
    - [RequiredValue](./argopt_package_enums.md#requiredvalue): `-ov` or `-o v`
    - [OptionalValue](./argopt_package_enums.md#optionalvalue): `-ov` or `-o`
    - [NoValue](./argopt_package_enums.md#novalue): `-o`

For combined short options scenarios:

- When encountering the first non-[NoValue](./argopt_package_enums.md#novalue) option:
    - If the option is [OptionalValue](./argopt_package_enums.md#optionalvalue), any following content will be parsed as the option's value if present.
    - If the option is [RequiredValue](./argopt_package_enums.md#requiredvalue), the following content will be parsed as the option's value.
- If a group of short options can form the literal value of a long option, it will be treated as a long option rather than combined short options. For example, if `-abc` is encountered while both the long option `abc` and short options `a`, `b`, `c` are defined, it will be parsed as a long option.

If an [ArgumentSpec](./argopt_package_enums.md#enum-argumentspec) provides a `lambda` callback function, this callback will be invoked after successful parsing to process the parsed argument value.

If the same option is assigned multiple times in `args`, the last value will be taken as the option's value.

Parameters:

- args: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - The arguments to be parsed.

- specs: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[ArgumentSpec](./argopt_package_enums.md#enum-argumentspec)> - The specifications for the arguments.

Return Value:

- [ParsedArguments](./argopt_package_struct.md#struct-parsedarguments) - The result of argument parsing.

Exceptions:

- [ArgumentParseException](./argopt_package_exception.md#class-argumentparseexception) - Thrown when argument parsing fails or an `illegal option` is encountered.

- [IllegalArgumentException](../../../std_en/core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when [ArgumentSpec](./argopt_package_enums.md#enum-argumentspec) with duplicate `name` is defined.