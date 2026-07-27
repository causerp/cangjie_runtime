# 注解的使用

通过反射获取实例上注解的值。

示例：
<!-- verify -->
```cangjie
import std.reflect.*

main() {
    // 获取实例的类型信息，并查找类型上的注解
    let typeInfo = TypeInfo.of(Test())
    let annotation = typeInfo.findAnnotation<MyAnnotation>()
    if (let Some(anno) <- annotation) {
        println("注解 name 的值: ${anno.name}")
    }
}

@MyAnnotation["Annotation"]
public class Test {}

@Annotation
public class MyAnnotation {
    const MyAnnotation(let name: String) {}
}
```

运行结果：

```text
注解 name 的值: Annotation
```
