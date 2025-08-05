# Enumeration

## enum Color

```cangjie
public enum Color <: Equatable<Color> {
    | RED
    | GREEN
    | YELLOW
    | BLUE
    | CYAN
    | MAGENTA
    | GRAY
    | DEFAULT_COLOR;
}
```

Function: Specifies colors.

Parent Type:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[Color](#enum-color)>

### RED

```cangjie
RED
```

Function: Red color.

### GREEN

```cangjie
GREEN
```

Function: Green color.

### YELLOW

```cangjie
YELLOW
```

Function: Yellow color.

### BLUE

```cangjie
BLUE
```

Function: Blue color.

### CYAN

```cangjie
CYAN
```

Function: Cyan color.

### MAGENTA

```cangjie
MAGENTA
```

Function: Magenta color.

### GRAY

```cangjie
GRAY
```

Function: Gray color.

### DEFAULT_COLOR

```cangjie
DEFAULT_COLOR
```

Function: Default color.

### operator func ==(Color)

```cangjie
public operator func ==(that: Color): Bool
```

Function: Determines whether colors are equal.

Parameters:

- that: [Color](#enum-color) - The color to compare with.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if equal, otherwise returns `false`.

### operator func !=(Color)

```cangjie
public operator func !=(that: Color): Bool
```

Function: Determines whether colors are not equal.

Parameters:

- that: [Color](#enum-color) - The color to compare with.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if not equal, otherwise returns `false`.

## enum OptionValidity

```cangjie
public enum OptionValidity {
    | UnknownOptionType
    | InvalidOption(String)
    | ValidOption(ConfigurationKey)
}
```

Function: Represents the result of option value validation.

### UnknownOptionType

```cangjie
UnknownOptionType
```

Function: Unknown state, only occurs when internal validation errors happen.

### InvalidOption(String)

```cangjie
InvalidOption(String)
```

Function: Option validation failed, containing the reason for invalidity.

### ValidOption(ConfigurationKey)

```cangjie
ValidOption(ConfigurationKey)
```

Function: Option value is valid, containing the key name of the corresponding key-value pair in the configuration.