# Class

## class WeakRef\<T> where T <: Object

```cangjie
public class WeakRef<T> <: WeakRefBase where T <: Object {
    public init(value: T, cleanupPolicy: CleanupPolicy)
}
```

Functionality: This class provides weak reference related capabilities. If an object's reference is marked as a weak reference, the GC can reclaim it according to the specified cleanup policy even when the reference is non-null and the object's reachability holds.

Parent Type:

- [WeakRefBase](ref_package_classes#class-weakrefbase)

### prop cleanupPolicy

```cangjie
public prop cleanupPolicy: CleanupPolicy
```

Functionality: Gets the cleanup policy of this weak reference.

Type: [CleanupPolicy](ref_package_enums.md#enum-cleanuppolicy)

### prop value

```cangjie
public prop value: Option<T>
```

Functionality: Reads the object referenced by the weak reference. Returns `None` if the weak reference is null or the referenced object has been cleaned up.

Type: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T>

### init(T, CleanupPolicy)

```cangjie
public init(value: T, cleanupPolicy: CleanupPolicy)
```

Functionality: Creates a weak reference for the `value` object with the specified cleanup policy.

Parameters:

- value: T - The object referenced by the weak reference.
- cleanupPolicy: [CleanupPolicy](ref_package_enums.md#enum-cleanuppolicy) - The cleanup policy for the `value` object.

### func clear()

```cangjie
public func clear(): Unit
```

Functionality: Forces cleanup of the object referenced by the weak reference. Subsequent accesses to `value` will return `None`.

## class WeakRefBase

```cangjie
sealed abstract class WeakRefBase
```

Functionality: This class contains no public members or functions, and cannot be inherited or extended. It serves solely as the base class for [WeakRef](ref_package_classes#class-weakreft-where-t--object).