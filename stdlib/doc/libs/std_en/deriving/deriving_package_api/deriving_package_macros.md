# Macros

## `@Derive` Macro

Functionality: `Derive` is a core macro that can only decorate declarations such as structs, classes, or enums. It [automatically extends interfaces](../deriving_samples/deriving_user_guide.md) for the decorated declarations.

Example:

See [Deriving](../deriving_samples/deriving_user_guide.md#deriving).

## `@DeriveExclude` Macro

Functionality: `DeriveExclude` can [exclude fields that do not require processing](../deriving_samples/deriving_user_guide.md#inclusion-and-exclusion) for declarations already decorated by the [`@Derive` Macro](#derive-macro). By default, fields are processed by Deriving.

Example:

See [Inclusion and Exclusion](../deriving_samples/deriving_user_guide.md#inclusion-and-exclusion).

## `@DeriveInclude` Macro

Functionality: `DeriveInclude` can [add attributes that require processing](../deriving_samples/deriving_user_guide.md#inclusion-and-exclusion) for declarations already decorated by the [`@Derive` Macro](#derive-macro). By default, attributes are not processed by Deriving.

Example:

See [Inclusion and Exclusion](../deriving_samples/deriving_user_guide.md#inclusion-and-exclusion).

## `@DeriveOrder` Macro

Functionality: `DeriveOrder` can [specify the processing order of fields and attributes](../deriving_samples/deriving_user_guide.md#changing-order) for declarations already decorated by the [`@Derive` Macro](#derive-macro). This is typically meaningful for the `Comparable` interface.

Example:

See [Changing Order](../deriving_samples/deriving_user_guide.md#changing-order).
