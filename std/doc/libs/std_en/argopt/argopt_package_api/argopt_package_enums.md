# Enumeration

## enum ArgumentMode

```cangjie
public enum ArgumentMode <: ToString & Equatable<ArgumentMode> {
    | NoValue
    | RequiredValue
    | OptionalValue
}
```

Function: Describes the argument mode of an option.

Parent types:

- [ToString](../../../std_en/core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Equatable](../../../std_en/core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[ArgumentMode](#enum-argumentmode)>

### NoValue

```cangjie
NoValue
```

Function: Indicates that the option has no value.

### OptionalValue

```cangjie
OptionalValue
```

Function: Indicates that the option's value is optional.

### RequiredValue

```cangjie
RequiredValue
```

Function: Indicates that the option's value is required.

### func toString()

```cangjie
public func toString(): String
```

Function: Gets the argument mode string.

Return value:

- [String](../../../std_en/core/core_package_api/core_package_structs.md#struct-string) - The argument mode string.

### operator func ==(ArgumentMode)

```cangjie
public operator func ==(that: ArgumentMode): Bool
```

Function: Compares whether argument modes are identical.

Parameters:

- that: [ArgumentMode](./argopt_package_enums.md#enum-argumentmode) - The argument mode to compare.

Return value:

- [Bool](../../../std_en/core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if identical, otherwise `false`.

## enum ArgumentSpec

```cangjie
public enum ArgumentSpec {
    | Short(Rune, ArgumentMode)
    | Short(Rune, ArgumentMode, (String) -> Unit)
    | Long(String, ArgumentMode)
    | Long(String, ArgumentMode, (String) -> Unit)
    | Full(String, Rune, ArgumentMode)
    | Full(String, Rune, ArgumentMode, (String) -> Unit)
    | NonOptions((Array<String>) -> Unit)
}
```

Function: Describes the specification of arguments.

### Full(String, Rune, ArgumentMode)

```cangjie
Full(String, Rune, ArgumentMode)
```

Function: Indicates the presence of both long and short options.

### Full(String, Rune, ArgumentMode, (String) -> Unit)

```cangjie
Full(String, Rune, ArgumentMode, (String) -> Unit)
```

Function: Indicates the presence of both long and short options with a `lambda` callback function.

### Long(String, ArgumentMode)

```cangjie
Long(String, ArgumentMode)
```

Function: Represents a long option specification.

### Long(String, ArgumentMode, (String) -> Unit)

```cangjie
Long(String, ArgumentMode, (String) -> Unit)
```

Function: Represents a long option with a `lambda` callback function.

### NonOptions((Array\<String>) -> Unit)

```cangjie
NonOptions((Array<String>) -> Unit)
```

Function: Represents a non-option argument.

### Short(Rune, ArgumentMode)

```cangjie
Short(Rune, ArgumentMode)
```

Function: Represents a short option.

### Short(Rune, ArgumentMode, (String) -> Unit)

```cangjie
Short(Rune, ArgumentMode, (String) -> Unit)
```

Function: Represents a short option with a `lambda` callback function.