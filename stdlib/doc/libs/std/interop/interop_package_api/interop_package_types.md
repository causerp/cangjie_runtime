# 类型别名

## type CrossReferenceHandler

```cangjie
type CrossReferenceHandler = (ExportedRef, ForeignProxy) -> Unit
```

功能：定义一个跨堆循环引用的处理函数类型，其参数类型分别为 [ExportedRef](./interop_package_classes.md#class-exportedref) 和 [ForeignProxy](./interop_package_classes.md#class-foreignproxy) 此函数与语言内部实现强相关，用来辅助自动内存管理分析跨语言循环引用中的垃圾内存。