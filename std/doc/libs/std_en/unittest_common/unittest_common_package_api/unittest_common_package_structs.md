# Structs

## struct KeyTags

```cangjie
public struct KeyTags <: KeyFor<Array<String>> {}
```

Function: Used for configuration keys in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration).

Parent Type:

- [KeyFor](../unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop tags

```cangjie
public static prop tags: KeyTags
```

Function: The key value of the configuration item.

Type: [KeyTags](#struct-keytags)

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

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

Function: Option description information.

Type: ?[String](../../../std/core/core_package_api/core_package_structs.md#struct-string)

### let name

```cangjie
public let name: String
```

Function: Option name.

Type: [String](../../../std/core/core_package_api/core_package_structs.md#struct-string)

### let types

```cangjie
public let types!: HashMap<String, ?String> = HashMap()
```

Function: Maps from option type names to their meanings.

Type: HashMap<[String](../../../std/core/core_package_api/core_package_structs.md#struct-string), ?[String](../../../std/core/core_package_api/core_package_structs.md#struct-string)>

### let userDefined

```cangjie
public let userDefined: Bool
```

Function: Whether the option has been defined.

Type: [Bool](../../../std/core/core_package_api/core_package_intrinsics.md#bool)