# std.objectpool

## Functionality Overview

The objectpool package provides object caching and reuse capabilities.

In object-oriented languages, object allocation and deallocation are generally complex and time-consuming operations, which can easily become performance bottlenecks in applications. Cangjie objects face the same challenges. The object pool improves program performance by caching and reusing objects, thereby reducing frequent allocation and deallocation.

The `ObjectPool` class in this package implements caching and reuse functionality for specified object types. The `put` method stores used objects back into the pool for caching, while the `get` method retrieves available objects from the pool.

Furthermore, to minimize contention and enhance object access efficiency, `ObjectPool` implements thread-specific storage by maintaining separate arrays based on the current Cangjie thread's `id`.

> **Note:**
>
> 1. Since `ObjectPool` performs storage and retrieval based on Cangjie thread `id`, objects stored in one thread may be difficult to retrieve from another thread. Therefore, this object pool should be used in scenarios where storage and retrieval operations are evenly distributed across Cangjie threads.
>
> 2. Automatic capacity reduction is currently not supported.

## API List

### Classes

|                 Class Name                |               Functionality               |
| ----------------------------------------- | ---------------------------------------- |
| [ObjectPool <sup>(deprecated)</sup>](./objectpool_package_api/objectpool_package_classes.md#class-objectpoolt-where-t--object-deprecated) | This class provides a thread-safe object cache type that can store allocated but unused objects. |