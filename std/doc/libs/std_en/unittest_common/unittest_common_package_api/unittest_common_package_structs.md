# Structure

## struct OptionInfo

```cangjie
public struct OptionInfo {
    public let description: ?String
    public let name: String
    public let types!: HashMap<String, ?String> = HashMap()
    public let userDefined: Bool
}
```

Function: Information about options that can be used when printing help pages.

### let description

```cangjie
public let description: ?String
```

Function: Description of the option.

Type: ?[String](../../../std_en/core/core_package_api/core_package_structs.md#struct-string)

### let name

```cangjie
public let name: String
```

Function: Name of the option.

Type: [String](../../../std_en/core/core_package_api/core_package_structs.md#struct-string)

### let types

```cangjie
public let types!: HashMap<String, ?String> = HashMap()
```

Function: Maps option type names to their value meanings.

Type: HashMap<[String](../../../std_en/core/core_package_api/core_package_structs.md#struct-string), ?[String](../../../std_en/core/core_package_api/core_package_structs.md#struct-string)>

### let userDefined

```cangjie
public let userDefined: Bool
```

Function: Whether the option has been defined.

Type: [Bool](../../../std_en/core/core_package_api/core_package_intrinsics.md#bool)