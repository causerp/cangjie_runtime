# Classes

## class ExportedRef

```cangjie
public abstract class ExportedRef {
    protected var handle: UInt64 = 0
    protected let ref: Any
    protected let interopContext: InteropContext
    protected init(exportedRef: Any, context: InteropContext)
}
```

Function：This class is used to wrap classes or functions that need to be used by external languages ​​in cross-language interoperability scenarios. Instances of this class can be managed using a `handle` of type [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) via [ExportTable](#class-exporttable). External languages ​​can also indirectly reference this object through the `handle`.

> **Warning:**
>
> This class does not have any `public` members or interfaces, and is currently only used by interop library-related `APIs`. Developers should not inherit from this class.

### var handle

```cangjie
protected var handle: UInt64 = 0
```

Function: Used to represent the handle of an instance of this type. This value can only be the return value of [validateHandle](#func-validatehandle).

Type：[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)

### let interopContext

```cangjie
protected let interopContext: InteropContext
```

Function: Used to represent a certain cross-language interoperability context. This member also has a specific value when interoperating with a specific language.

Type：[InteropContext](#class-interopcontext)

### let ref

```cangjie
protected let ref: Any
```

Function: The actual function or object that is externally dependent and wrapped by this type.

Type：[Any](../../core/core_package_api/core_package_interfaces.md#interface-any)

### init(Any, InteropContext)

```cangjie
protected init(exportedRef: Any, context: InteropContext)
```

Function: An instance whose type is [ExportedRef](#class-exportedref) is constructed based on the object or function instance to be wrapped and the interoperability context.

Parameters:

- exportedRef: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The actual function or object that is externally dependent and wrapped by this type.

- context: [InteropContext](#class-interopcontext) - This is used to indicate the type of interoperability context.

### func validateHandle()

```cangjie
protected func validateHandle(): Unit
```

Function: Generate a valid handle for this type.

## class ExportTable

```cangjie
public class ExportTable {}
```

Function: This type manages the lifecycle of instances of [ExportedRef](#class-exportedref) through a `handle` of type [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64). It can implement operations such as generating a `handle` for an [ExportedRef](#class-exportedref) object, retrieving an [ExportedRef](#class-exportedref) object based on the `handle`, and removing an [ExportedRef](#class-exportedref) object based on the `handle`.

### static func createExportHandle(ExportedRef)

```cangjie
public static func createExportHandle(ref: ExportedRef): UInt64
```

Function: Generating the `handle` for [ExportedRef](#class-exportedref).

Parameter:

- ref: [ExportedRef](#class-exportedref) - The object instance that needs `handle`.

Return：

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The `handle` generated for the [ExportedRef](#class-exportedref) object.

### static func crossAccessBarrier(UInt64)

```cangjie
public static func crossAccessBarrier(handle: UInt64): Unit
```

Function: This interface is intended for scenarios where external languages ​​indirectly access [ExportedRef](#class-exportedref) objects via `handle`. Currently, it is only used by interop library-related `APIs`. Developers should not use it arbitrarily.

Parameter:

- handle: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The return value of [createExportHandle](#static-func-createexporthandleexportedref).

### static func getExportedRef(UInt64)

```cangjie
public static func getExportedRef(handle: UInt64): ?ExportedRef
```

Function: Returns an [ExportedRef](#class-exportedref) object based on `handle`, or [None](../../core/core_package_api/core_package_enums.md#none) if `handle` is invalid.

Parameter:

- handle: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The return value of [createExportHandle](#static-func-createexporthandleexportedref).

Return:

- ?[ExportedRef](#class-exportedref) - If `handle` is valid, it returns an [ExportedRef](#class-exportedref) object, otherwise, it returns `None`.

### static func removeExportedRef(UInt64)

```cangjie
public static func removeExportedRef(handle: UInt64): Unit
```

Function: Removes the [ExportedRef](#class-exportedref) object according to `handle`.

Parameter:

- handle: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The return value of [createExportHandle](#static-func-createexporthandleexportedref).

## class ForeignProxy

```cangjie
public abstract class ForeignProxy {
    protected init(context: InteropContext)
}
```

Function: This class is used to proxy the `handle` of external language's object ​​in cross-language interoperability scenarios.

> **Warning:**
>
> This class does not have any `public` members or interfaces, and is currently only used by interop library-related `APIs`. Developers should not inherit from this class.

### init(InteropContext)

```cangjie
protected init(context: InteropContext)
```

Function: A [ForeignProxy](#class-foreignproxy) instance is constructed based on the interoperability `context`.

Parameter:

- context: [InteropContext](#class-interopcontext) - This is used to indicate the type of interoperability context.

## class InteropContext

```cangjie
public abstract class InteropContext <: Equatable<InteropContext> {
    protected init(handler: (ExportedRef, ForeignProxy) -> Unit)
}
```

Function: This class encapsulates functions for handling circular references in cross-language interoperability scenarios. This class has no `public` members or interfaces and is currently only used by interoperability library-related `APIs`. Developers should not inherit from this class.

> **Warning:**
>
> This class does not have any `public` members or interfaces, and is currently only used by interop library-related `APIs`. Developers should not inherit from this class.

Parent type:

- [Equatable](../../../std/core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[InteropContext](#class-InteropContext)>

### init((ExportedRef, ForeignProxy) -> Unit)

```cangjie
protected init(handler: (ExportedRef, ForeignProxy) -> Unit)
```

Function: Used to construct an instance of [InteropContext](#class-interopcontext).

Parameter:

- handler: ([ExportedRef](#class-exportedref), [ForeignProxy](#class-foreignproxy)) -> [Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - A Function used to handle garbage memory in cross-language circular references in specific interoperability scenarios.