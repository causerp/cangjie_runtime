# 类型别名

## type Annotation = Object

```cangjie
public type Annotation = Object
```

功能：[Object](../../core/core_package_api/core_package_classes.md#class-object) 的别名。

> **说明：**
> 
> 该类型别名用于表达“反射返回的注解实例”的语义，类型上等价于 `Object`。
它与 `@Annotation` 语言内置元注解无关，使用 `@Annotation` 不需要导入 `std.reflect`。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

main(): Unit {
    println(Annotation() is Object)
    println(Annotation() is Annotation)
    println(Object() is Object)
    println(Object() is Annotation)
}
```

运行结果：

```text
true
true
true
true
```
