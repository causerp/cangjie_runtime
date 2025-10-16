# std.deriving

`std.deriving` provides a method to automatically generate interface implementations based on fields, properties, etc. of classes, structs, and enum types.

Currently supports automatic generation of implementations for the following interfaces:

- [ToString](../core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Hashable](../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [Equatable](../core/core_package_api/core_package_interfaces.md#interface-equatablet)
- [Comparable](../core/core_package_api/core_package_interfaces.md#interface-comparablet)

For more examples, see the [Deriving User Guide](./deriving_samples/deriving_user_guide.md).

## API List

### Macros

| Macro Name | Functionality |
| ---------- | ------------- |
| [Derive](./deriving_package_api/deriving_package_macros.md#derive-macro) | `Derive` is a core macro that can only modify declarations such as structs, classes, or enums, and [automatically extends interfaces](./deriving_samples/deriving_user_guide.md) for the modified declarations. |
| [DeriveExclude](./deriving_package_api/deriving_package_macros.md#deriveexclude-macro) | `DeriveExclude` can [exclude fields that do not need processing](./deriving_samples/deriving_user_guide.md#inclusion-and-exclusion) for declarations already modified by the [@Derive macro](./deriving_package_api/deriving_package_macros.md#derive-macro). Fields are processed by Deriving by default. |
| [DeriveInclude](./deriving_package_api/deriving_package_macros.md#deriveinclude-macro) | `DeriveInclude` can [add properties that need processing](./deriving_samples/deriving_user_guide.md#inclusion-and-exclusion) for declarations already modified by the [@Derive macro](./deriving_package_api/deriving_package_macros.md#derive-macro). Properties are not processed by Deriving by default. |
| [DeriveOrder](./deriving_package_api/deriving_package_macros.md#deriveorder-macro) | `DeriveOrder` can [specify the order of processing fields and properties](./deriving_samples/deriving_user_guide.md#changing-order) for declarations already modified by the [@Derive macro](./deriving_package_api/deriving_package_macros.md#derive-macro), which is typically meaningful for the `Comparable` interface. |