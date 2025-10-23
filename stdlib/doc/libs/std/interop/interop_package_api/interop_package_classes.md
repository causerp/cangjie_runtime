# 类

## class InteropContext

```cangjie
public abstract class InteropContext <: Equatable<InteropContext>
```

功能：此类封装了跨语言互操作场景下处理循环引用的函数。此类不具备任何公开的成员与接口，当前只被互操作库相关的 `API` 使用，开发者请勿随意继承此类。

> **注意：**
>
> 此类不具备任何公开的成员与接口，当前只被互操作库相关的 `API` 使用，开发者请勿随意继承此类。

## class ExportedRef

```cangjie
public abstract class ExportedRef
```

功能：此类用来包装跨语言互操作场景下需要被外部语言使用的类或函数，此类的实例对象可通过 [ExportTable](#class-exporttable) 使用类型为 [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) 的 `handle` 进行管理，外部语言亦可通过 `handle` 间接引用此对象。

> **注意：**
>
> 此类不具备任何公开的成员与接口，当前只被互操作库相关的 `API` 使用，开发者请勿随意继承此类。

## class ForeignProxy

```cangjie
public abstract class ForeignProxy
```

功能：此类用于代理跨语言互操作场景下外部语言的对象 `handle`。

> **注意：**
>
> 此类不具备任何公开的成员与接口，当前只被互操作库相关的 `API` 使用，开发者请勿随意继承此类。

## class ExportTable

```cangjie
public class ExportTable
```

功能：此类通过类型为 [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) 的 `handle` 管理 [ExportedRef](#class-exportedref) 的实例对象的生命周期，可实现为 [ExportedRef](#class-exportedref) 对象生成 `handle`，根据 `handle` 获取 [ExportedRef](#class-exportedref) 对象， 根据 `handle` 移除 [ExportedRef](#class-exportedref) 对象等操作。

### static func getExportedRef(UInt64)

```cangjie
public static func getExportedRef(handle: UInt64): ?ExportedRef
```

功能：根据 `handle` 返回 [ExportedRef](#class-exportedref) 对象，如果 `handle` 无效，返回 `None`。

参数:

 - handle: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - [createExportHandle](#static-func-createexporthandleexportedref) 的返回值。

 返回值：

  - ?[ExportedRef](#class-exportedref) - 如果 `handle` 有效，则返回 [ExportedRef](#class-exportedref) 对象，否则返回 `None`。

### static func removeExportedRef(UInt64)

```cangjie
public static func removeExportedRef(handle: UInt64): Unit
```

功能：根据 `handle` 移除 [ExportedRef](#class-exportedref) 对象。

参数：

 - handle: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - [createExportHandle](#static-func-createexporthandleexportedref) 的返回值。

### static func crossAccessBarrier(UInt64)

```cangjie
public static func crossAccessBarrier(handle: UInt64): Unit
```

功能：此接口用于外部语言通过 `handle` 间接访问 [ExportedRef](#class-exportedref) 对象的场景，当前只被互操作库相关的 `API` 使用，开发者请勿随意使用。

参数：

 - handle: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - [createExportHandle](#static-func-createexporthandleexportedref) 的返回值。

### static func createExportHandle(ExportedRef)

```cangjie
public static func createExportHandle(ref: ExportedRef): UInt64
```

功能：为 [ExportedRef](#class-exportedref) 生成 `handle`。

参数：

 - ref: [ExportedRef](#class-exportedref) - 需要生成 `handle` 的对象实例。

返回值：

 - [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - 为 [ExportedRef](#class-exportedref) 对象生成的 `handle`。