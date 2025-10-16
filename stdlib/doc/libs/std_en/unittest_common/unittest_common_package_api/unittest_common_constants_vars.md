# Constants & Variables

## let optionsInfo

```cangjie
public let optionsInfo: HashMap<String, OptionInfo> = HashMap()
```

Function: A registry storing information about unit test options. For internal framework use only, not recommended for user access.

Type: [HashMap](../../collection/collection_package_api/collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<[String](../../core/core_package_api/core_package_structs.md#struct-string), [OptionInfo](../unittest_common_package_api/unittest_common_package_structs.md#struct-optioninfo)>

## var unittestOptionsRegistryClosed

```cangjie
public var unittestOptionsRegistryClosed = false
```

Function: An internal flag indicating whether option registration is permitted. For internal framework use only, not recommended for user access.

Type: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool)