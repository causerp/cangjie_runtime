# std.interop

## Functionality Overview

The `interop` package provides base classes needed for developing cross-language interoperability libraries. Developers can inherit from these base classes and combine features from other languages ​​to create more functional interoperability libraries. Currently, a library interoperating with `ArkTS` has been implemented, and the capabilities of Cangjie's `GC` have been extended. Using Cangjie's `GC`, scenarios with circular dependencies between objects in two languages ​​can be analyzed and handled.

> **Warning:**
>
> The `interop` package is suitable for development scenarios using the Cangjie interoperability framework. Currently, it is only used for the internal implementation of interoperability library-related APIs. Developers should not use this package indiscriminately.

## API List

### Classes

|               Class Name             |                Functionality                 |
| -------------------------------- | ---------------------------------- |
| [ExportedRef](./interop_package_api/interop_package_classes.md#class-exportedref) | This type of class is used to wrap classes or functions that need to be used by external languages ​​in cross-language interoperability scenarios. |
| [ExportTable](./interop_package_api/interop_package_classes.md#class-exporttable) | This class manages the lifecycle of instance objects of [ExportedRef](./interop_package_api/interop_package_intrinsics.md#class-exportedref) through a `handle` of type [UInt64](../core/core_package_api/core_package_intrinsics.md#uint64). |
| [ForeignProxy](./interop_package_api/interop_package_classes.md#class-foreignproxy) | This type of object, `handle`, is used to proxy external languages ​​in cross-language interoperability scenarios.|
| [InteropContext](./interop_package_api/interop_package_classes.md#class-interopcontext) | This class encapsulates functions for handling circular references in cross-language interoperability scenarios. |