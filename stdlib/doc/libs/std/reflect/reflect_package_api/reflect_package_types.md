# 类型别名

## type Annotation = Object

```cangjie
public type Annotation = Object
```

功能：[Object](../../core/core_package_api/core_package_classes.md#class-object) 的别名。

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