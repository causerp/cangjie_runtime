# std.interop

## 功能介绍

interop 包提供了开发跨语言互操作库需要的一些基类，互操作库的开发者可以在继承这些基类的基础上，结合其他语言的特点，开发具有更多功能的互操作库。当前已实现了与 `ArkTS` 进行互操作的库，并扩展了仓颉 `GC` 的能力，使用仓颉的 `GC` 能够分析并处理两种语言间对象循环依赖的场景。

> **注意：**
>
> interop 包适用于仓颉互操作框架开发场景，当前仅用于互操作库相关 API 的内部实现，开发者请勿随意使用此包。

## API列表

### 类

|                 类名             |                功能                 |
| -------------------------------- | ---------------------------------- |
| [InteropContext](./interop_package_api/interop_package_classes.md#class-interopcontext) | 此类封装了跨语言互操作场景下处理循环引用的函数。 |
| [ExportedRef](./interop_package_api/interop_package_classes.md#class-exportedref) | 此类用来包装跨语言互操作场景下需要被外部语言使用的类或函数。 |
| [ForeignProxy](./interop_package_api/interop_package_classes.md#class-foreignproxy) | 此类用于代理跨语言互操作场景下外部语言的对象 `handle`。 |
| [ExportTable](./interop_package_api/interop_package_classes.md#class-exporttable) | 此类通过类型为 [UInt64](../core/core_package_api/core_package_intrinsics.md#uint64) 的 `handle` 管理 [ExportedRef](./interop_package_api/interop_package_classes.md#class-exportedref) 的实例对象的生命周期。 |