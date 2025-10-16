# Enums

## enum CleanupPolicy

```cangjie
public enum CleanupPolicy <: Equatable<CleanupPolicy> {
    | EAGER
    | DEFERRED
}
```

Function: This enum represents different weak reference cleanup policies, namely `EAGER` and `DEFERRED`.

The cleanup policy can be specified in the [WeakRef](ref_package_classes#class-weakreft-where-t--object) class.

### EAGER

```cangjie
EAGER
```

Function: Specifies the cleanup policy of a [WeakRef](ref_package_classes#class-weakreft-where-t--object) instance as `EAGER`. Under this policy, the GC will attempt to reclaim the object referenced by [WeakRef](ref_package_classes#class-weakreft-where-t--object) as soon as possible, but does not guarantee immediate or definite reclamation.

### DEFERRED

```cangjie
DEFERRED
```

Function: Specifies the cleanup policy of a [WeakRef](ref_package_classes#class-weakreft-where-t--object) instance as `DEFERRED`. Under this policy, the GC will try to keep the object in [WeakRef](ref_package_classes#class-weakreft-where-t--object) alive as long as possible, only reclaiming it when available memory is insufficient.

### operator func ==(CleanupPolicy)

```cangjie
public operator func ==(that: CleanupPolicy): Bool
```

Function: Compares equality for `Enum CleanupPolicy`.

Parameters:

- that: [CleanupPolicy](ref_package_enums.md#enum-cleanuppolicy) - The enum instance to compare with.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the current cleanup policy is the same as `that` cleanup policy, otherwise returns `false`.

### operator func !=(CleanupPolicy)

```cangjie
public operator func !=(that: CleanupPolicy): Bool
```

Function: Compares inequality for `Enum CleanupPolicy`.

Parameters:

- CleanupPolicy: [CleanupPolicy](ref_package_enums.md#enum-cleanuppolicy) - The enum instance to compare with.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the current cleanup policy differs from `that` cleanup policy, otherwise returns `false`.