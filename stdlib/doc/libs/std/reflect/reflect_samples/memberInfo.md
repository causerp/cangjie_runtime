# 成员信息的使用

<!-- verify -->
```cangjie
import std.reflect.*

public class Rectangular {
    public var length = 4
    public var width = 5
    public func area(): Int64 {
        return length * width
    }
}

main(): Unit {
    let rect = Rectangular()
    let typeInfo = TypeInfo.of(rect)
    const sideLength = 3

    // 通过反射读取实例变量的值
    let members = typeInfo.instanceVariables.toArray()
    println("初始 length: ${(members[0].getValue(rect) as Int64).getOrThrow()}")
    println("初始 width: ${(members[1].getValue(rect) as Int64).getOrThrow()}")

    // 通过反射修改实例变量的值
    members[0].setValue(rect, sideLength)
    members[1].setValue(rect, sideLength)
    println("修改后 length: ${(members[0].getValue(rect) as Int64).getOrThrow()}")
    println("修改后 width: ${(members[1].getValue(rect) as Int64).getOrThrow()}")
    println("面积: ${rect.area()}")

    // 通过反射获取实例函数的返回类型信息
    let functions = typeInfo.instanceFunctions.toArray()
    if (functions[0].returnType.name == "Int64") {
        println("正方形的面积为 ${sideLength ** 2}")
    }
    return
}
```

运行结果：

```text
初始 length: 4
初始 width: 5
修改后 length: 3
修改后 width: 3
面积: 9
正方形的面积为 9
```
