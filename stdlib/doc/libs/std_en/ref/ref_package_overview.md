# std.ref

## Function Description

The `ref` package provides capabilities related to weak references. A weak reference is a concept relative to "strong references." For strong references, if the reference is not null and runtime reachability analysis holds, the GC will not reclaim it. However, for weak references, even if reachability holds, the GC may still reclaim the reference under certain circumstances.

Weak references are commonly used in scenarios such as caching, object pools, thread pools, and event listeners. For example, we can use weak references to cache large objects for reuse purposes. Unlike strong references, when memory is insufficient, objects pointed to by weak references can be automatically reclaimed by the GC, thereby reducing memory pressure. In contrast, objects pointed to by strong references cannot be automatically reclaimed by the GC, which may lead to OOM (Out of Memory) errors.

This package provides the `WeakRef` class, which supports encapsulating any `Object` instance into a weak reference instance. If the original `Object` instance has no other references besides the weak reference, it may be reclaimed by the GC at some point.

Additionally, this package supports two reclamation policies: the eager reclamation policy (where the GC reclaims objects pointed to by weak references as soon as possible) and the deferred reclamation policy (where the GC delays reclaiming objects pointed to by weak references, such as reclaiming them only when memory is insufficient).

## API List

### Classes

|                 Class Name                |                Function                |
| ---------------------------------------- | ------------------------------------- |
| [WeakRef](./ref_package_api/ref_package_classes.md#class-weakreft-where-t--object) | This class provides functionality related to weak references. If an object's reference is marked as a weak reference, even if the reference is not null and the object's reachability holds, the GC can reclaim it according to the specified reclamation policy. |
| [WeakRefBase](./ref_package_api/ref_package_classes.md#class-weakrefbase) | This class does not contain any public members or functions and cannot be inherited or extended. It serves solely as the base class for `WeakRef`. |

### Enums

|                 Enum Name                |                Function                |
| ---------------------------------------- | ------------------------------------- |
| [CleanupPolicy](./ref_package_api/ref_package_enums.md#enum-cleanuppolicy) | This enum represents different cleanup policies, namely `EAGER` and `DEFERRED`. |