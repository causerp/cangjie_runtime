# Functions

## func registerOptionValidator(String, (Any) -> OptionValidity)

```cangjie
public func registerOptionValidator(name: String, validator: (Any) -> OptionValidity): Unit
```

Function: Used to register custom option validators. In most cases, users should use the [@UnittestOption](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#UnittestOption-macro) macro instead of calling this function directly.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The option name.
- validator: ([Any](../../core/core_package_api/core_package_interfaces.md#interface-any)) -> [OptionValidity](./unittest_common_package_enums.md#enum-optionvalidity) - A function that checks whether the option is valid.

## func setOptionInfo(String, Array\<String\>, ?String)

```cangjie
public func setOptionInfo(
    name: String,
    types: Array<String>,
    description!: ?String = None
): Unit
```

Function: Used to set the description of an option.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The option name.
- types: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - Valid types that can represent the option value.
- description: ?[String](../../core/core_package_api/core_package_structs.md#struct-string) - The option description.

## func setOrUpdateOptionInfo(String, ?String, String, String)

```cangjie
public func setOrUpdateOptionInfo(
    name: String,
    description: ?String,
    ty: String,
    typeDescription: String
): Unit
```

Function: Used to set the description for an option of a specific type.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The option name.
- description: ?[String](../../core/core_package_api/core_package_structs.md#struct-string) - The option description. If the value is not None, it will overwrite the previous value.
- ty: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of the type.
- typeDescription: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The type description of the option.