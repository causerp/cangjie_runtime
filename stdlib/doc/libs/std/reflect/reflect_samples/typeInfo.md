# TypeInfo 的使用

<!-- verify -->
```cangjie
package Demo

import std.reflect.*

public class Foo {
    public let item = 0

    public func f() {}
}

main() {
    // 获取实例的类型信息
    let foo = Foo()
    let typeInfo: TypeInfo = TypeInfo.of(foo)
    println("类名: ${typeInfo.name}")
    println("全限定名: ${typeInfo.qualifiedName}")
    println("实例函数数量: ${typeInfo.instanceFunctions.size}")
}
```

运行结果：

```text
类名: Foo
全限定名: Demo.Foo
实例函数数量: 1
```
