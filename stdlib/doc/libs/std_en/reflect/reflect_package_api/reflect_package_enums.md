# Enums

## enum ModifierInfo

```cangjie
public enum ModifierInfo <: Equatable<ModifierInfo> & Hashable & ToString  {
    | Open
    | Override
    | Redef
    | Abstract
    | Sealed
    | Mut
    | Static
}
```

Function: Describes modifier information.

> **Note:**
>
> Since the type information obtained by developers through reflection functionality all comes from `public` types, which inherently possess `public` access control semantics, the modifier information does not include any access control-related modifiers.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[ModifierInfo](#enum-modifierinfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### Abstract

```cangjie
Abstract
```

Function: Represents the abstract modifier.

### Mut

```cangjie
Mut
```

Function: Represents the mut modifier.

### Open

```cangjie
Open
```

Function: Represents the open modifier.

### Override

```cangjie
Override
```

Function: Represents the override modifier.

### Redef

```cangjie
Redef
```

Function: Represents the redef modifier.

### Sealed

```cangjie
Sealed
```

Function: Represents the sealed modifier.

### Static

```cangjie
Static
```

Function: Represents the static modifier.

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Gets the hash value of this modifier information.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The hash value of this modifier information.

> **Note:**
>
> The internal implementation uses the hash value of the modifier keyword string.

### func toString()

```cangjie
public override func toString(): String
```

Function: Gets the string representation of this modifier information.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of this modifier information.

> **Note:**
>
> The string representation of modifier information is the identifier of the modifier keyword.

### operator func ==(ModifierInfo)

```cangjie
public override operator func ==(that: ModifierInfo): Bool
```

Function: Determines whether this modifier information is equal to another given modifier information.

Parameters:

- that: [ModifierInfo](reflect_package_enums.md#enum-modifierinfo) - Another modifier information to compare for equality.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this modifier information is equal to `that`, otherwise returns `false`.

> **Note:**
>
> The equality semantics of modifier information are equivalent to the equality semantics of `enum` type instances.

### operator func !=(ModifierInfo)

```cangjie
public override operator func !=(that: ModifierInfo): Bool
```

Function: Determines whether this modifier information is not equal to another given modifier information.

> **Note:**
>
> The equality semantics of modifier information are equivalent to the equality semantics of `enum` type instances.

Parameters:

- that: [ModifierInfo](reflect_package_enums.md#enum-modifierinfo) - Another modifier information to compare for equality.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this modifier information is not equal to `that`, otherwise returns `false`.