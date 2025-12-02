# 类

## class ClassTypeInfo

```cangjie
public class ClassTypeInfo <: TypeInfo
```

功能：描述 `class` 类型的类型信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

父类型：

- [TypeInfo](#class-typeinfo)

### prop constructors

```cangjie
public prop constructors: Collection<ConstructorInfo>
```

功能：获取该 [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) 对应的 `class` 的所有 `public` 构造函数信息，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果该 `class` 类型无任何 `public` 构造函数，则返回空集合。
> - 该集合不保证遍历顺序恒定。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[ConstructorInfo](reflect_package_classes.md#class-constructorinfo)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public var myName = ""
    public init() {}
    public init(name: String) {
        myName = name
    }
}

main(): Unit {
    // 此处是通过 Rectangular 的类型的限定名称获取 ClassTypeInfo，也可以通过实例获取 ClassTypeInfo
    let ty = ClassTypeInfo.get("test.Rectangular")
    // 获取 constructors
    for (i in ty.constructors) {
        println(i)
    }
    return
}
```

运行结果：

```text
init()
init(String)
```

### prop instanceVariables

```cangjie
public prop instanceVariables: Collection<InstanceVariableInfo>
```

功能：获取该 [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) 对应的 `class` 的所有 `public` 实例成员变量信息，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果该 `class` 类型无任何 `public` 实例成员变量，则返回空集合。
> - 该集合不保证遍历顺序恒定。
> - 该集合不包含任何继承而来的 `public` 实例成员变量。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public var length = 4
    public var width = 5
    public var myName = ""
    public init() {}
}

main(): Unit {
    // 此处是通过 Rectangular 的类型的限定名称获取 ClassTypeInfo，也可以通过实例获取 ClassTypeInfo
    let ty = ClassTypeInfo.get("test.Rectangular")
    // 获取 instanceVariables
    for (i in ty.instanceVariables) {
        println(i)
    }
    return
}
```

运行结果：

```text
length: Int64
width: Int64
myName: String
```

### prop sealedSubclasses

```cangjie
public prop sealedSubclasses: Collection<ClassTypeInfo>
```

功能：如果该 [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) 对应的 `class` 类型拥有 `sealed` 语义，则获取该 `class` 类型所在包内的所有子类的类型信息，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果该 `class` 类型不拥有 `sealed` 语义，则返回空集合。
> - 如果该 `class` 类型拥有 `sealed` 语义，那么获得的集合必不可能是空集合，因为该 `class` 类型本身就是自己的子类。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public abstract sealed class Shape {}
public class Circle <: Shape {}
public class Rectangle <: Shape {}

main(): Unit {
    // 获取 Shape 类型信息
    let ty = ClassTypeInfo.get("test.Shape")
    
    // 获取 sealed 子类
    for (subclass in ty.sealedSubclasses) {
        println(subclass)
    }
    
    return
}
```

运行结果：

```text
test.Shape
test.Circle
test.Rectangle
```

### prop staticVariables

```cangjie
public prop staticVariables: Collection<StaticVariableInfo>
```

功能：获取该 [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) 对应的 `class` 的所有 `public` 静态成员变量信息，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果该 `class` 类型无任何 `public` 静态成员变量，则返回空集合。
> - 该集合不保证遍历顺序恒定。
> - 该集合不包含任何继承而来的 `public` 静态成员变量。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public static var count: Int64 = 0
    public static var name: String = "Rectangle"
    public var length: Int64 = 0
    public var width: Int64 = 0
    
    public init() {
        Rectangular.count += 1
    }
}

main(): Unit {
    // 获取 Rectangular 类型信息
    let ty = ClassTypeInfo.get("test.Rectangular")
    
    // 获取静态成员变量
    for (variable in ty.staticVariables) {
        println(variable)
    }
    
    return
}
```

运行结果：

```text
static count: Int64
static name: String
```

### prop superClass

```cangjie
public prop superClass: Option<ClassTypeInfo>
```

功能：获取该 `class` 类型信息所对应的 `class` 类型的直接父类。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 理论上只有 class [Object](../../core/core_package_api/core_package_classes.md#class-object) 没有直接父类。

类型：[Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public open class Animal {
    public var name: String = ""
    public init() {}
}

public class Dog <: Animal {
    public init() {
        super()
    }
}

main(): Unit {
    // 获取 Dog 类型信息
    let ty = ClassTypeInfo.get("test.Dog")
    
    // 获取父类信息
    if (ty.superClass.isSome()) {
        // Dog 有父类
        println("Dog 有父类")
    } else {
        println("Dog 没有父类")
    }
    
    // 同时也获取 Object 类型信息作为对比
    let objTy = ClassTypeInfo.get("std.core.Object")
    if (objTy.superClass.isNone()) {
        println("Object 没有父类")
    }
    
    return
}
```

运行结果：

```text
Dog 有父类
Object 没有父类
```

### static func get(String)

```cangjie
public redef static func get(qualifiedName: String): ClassTypeInfo
```

功能：获取给定限定名称所对应类型的 [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo)。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- qualifiedName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 类型的限定名称。

返回值：

- [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) - 类型的限定名称 `qualifiedName` 所对应的类型的类型信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果无法获取与给定类型的限定名称 `qualifiedName` 匹配的类型所对应的类型信息，则抛出异常。
- [IllegalTypeException](./reflect_package_exceptions.md#class-illegaltypeexception) - 如果获取到的类型信息不是 [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo)， 则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class Rectangular {}

main(): Unit {
    let ty = ClassTypeInfo.get("default.Rectangular")
    println(ty)
    return
}
```

运行结果：

```text
default.Rectangular
```

### static func of(Any)

```cangjie
public redef static func of(a: Any): ClassTypeInfo
```

功能：获取给定的任意类型的实例的运行时类型所对应的类型信息。

运行时类型是指在程序运行时，通过动态绑定确定的类型，运行时类型与实例对象相绑定。在继承等场景下运行时类型和静态类型可能不一致。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- a: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 任意类型的实例。

返回值：

- [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) - 实例 `a` 的运行时类型所对应的类型信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果无法获得实例 `a` 的运行时类型所对应的类型信息，则抛出异常。
- [IllegalTypeException](./reflect_package_exceptions.md#class-illegaltypeexception) - 如果获取到的类型信息不是 [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo)， 则抛出异常。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {}

main(): Unit {
    var r = Rectangular()
    let ty = ClassTypeInfo.of(r)
    println(ty)
    return
}
```

运行结果：

```text
test.Rectangular
```

### static func of(Object)

```cangjie
public static func of(a: Object): ClassTypeInfo
```

功能：获取给定的 `class` 类型的实例的运行时类型所对应的 `class` 类型信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- a: [Object](../../core/core_package_api/core_package_classes.md#class-object) - `class` 类型的实例。

返回值：

- [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) - `class` 类型的实例 `a` 的运行时类型所对应的 `class` 类型信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果无法获得实例 `a` 的运行时类型所对应的 `class` 类型信息，则抛出异常。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {}

main(): Unit {
    var r = Rectangular()
    let ty = ClassTypeInfo.of(r)
    println(ty)
    return
}
```

运行结果：

```text
test.Rectangular
```

### static func of\<T>()

```cangjie
public redef static func of<T>(): ClassTypeInfo
```

功能：获取给定类型 `T` 对应的类型信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) - `T` 类型对应的类型信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果无法获得类型 T 所对应的类型信息，抛出异常。
- [IllegalTypeException](./reflect_package_exceptions.md#class-illegaltypeexception) - 如果获取到的类型信息不是 [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo)， 则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class Rectangular {}

main(): Unit {
    let ty = ClassTypeInfo.of<Rectangular>()
    println(ty)
    return
}
```

运行结果：

```text
default.Rectangular
```

### func construct(Array\<Any>)

```cangjie
public func construct(args: Array<Any>): Any
```

功能：在该 [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) 对应的 `class` 类型中根据实参列表搜索匹配的构造函数并调用，传入实参列表，返回调用结果。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- args: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Any](../../core/core_package_api/core_package_interfaces.md#interface-any)> - 实参列表。

返回值：

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 该 `class` 类型的实例。

异常：

- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - 如果该 `class` 类型拥有 `abstract` 语义，调用 `construct` 则抛出异常，因为抽象类不可被实例化。
- [MisMatchException](reflect_package_exceptions.md#class-mismatchexception) - 如果 `args` 未能成功匹配任何该 `class` 类型的可见性为 `public` 的构造函数，则抛出异常。
- [InvocationTargetException](reflect_package_exceptions.md#class-invocationtargetexception) - 在被调用的构造函数内部抛出的任何异常均将被封装为 [InvocationTargetException](reflect_package_exceptions.md#class-invocationtargetexception) 异常并抛出。

示例：

<!-- run -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public var length = 4
    public var width = 5
    public var myName = ""
    public init() {}
    public init(name: String) {
        myName = name
    }
    public init(name: String, length: Int64, width: Int64) {
        myName = name
        this.length = length
        this.width = width
    }
}

main(): Unit {
    // 此处是通过 Rectangular 的类型的限定名称获取 ClassTypeInfo，也可以通过实例获取 ClassTypeInfo
    let ty = ClassTypeInfo.get("test.Rectangular")

    // 通过不同入参构造实例
    ty.construct()
    ty.construct("Small rectangular")
    ty.construct("Big rectangular", 1, 1)
    return
}
```

### func getConstructor(Array\<TypeInfo>)

```cangjie
public func getConstructor(parameterTypes: Array<TypeInfo>): ConstructorInfo
```

功能：尝试在该 [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) 对应的 `class` 类型中获取与给定形参类型信息列表匹配的 `public` 构造函数的信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- parameterTypes: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[TypeInfo](reflect_package_classes.md#class-typeinfo)> - 形参类型信息列表。

返回值：

- [ConstructorInfo](reflect_package_classes.md#class-constructorinfo) - 如果成功匹配则返回该 `public` 构造函数的信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果没找到对应 `public` 构造函数，则抛出异常。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public var length = 4
    public var width = 5
    public var myName = ""
    public init() {}
    public init(name: String) {
        myName = name
    }
    public init(name: String, length: Int64, width: Int64) {
        myName = name
        this.length = length
        this.width = width
    }
}

main(): Unit {
    // 此处是通过 Rectangular 的类型的限定名称获取 ClassTypeInfo，也可以通过实例获取 ClassTypeInfo
    let ty = ClassTypeInfo.get("test.Rectangular")

    // 获取指定构造函数信息
    let ci01 = ty.getConstructor(StructTypeInfo.get("String"))
    println(ci01)

    // 获取指定构造函数信息
    let ci02 = ty.getConstructor(StructTypeInfo.get("String"), PrimitiveTypeInfo.get("Int64"),
        PrimitiveTypeInfo.get("Int64"))
    println(ci02)
    return
}
```

运行结果：

```text
init(String)
init(String, Int64, Int64)
```

### func getInstanceVariable(String)

```cangjie
public func getInstanceVariable(name: String): InstanceVariableInfo
```

功能：给定变量名称，尝试获取该 [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) 所对应的 `class` 类型中匹配的实例成员变量的信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 变量名称。

返回值：

- [InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo) - 如果成功匹配则返回该实例成员变量的信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果没找到对应实例成员变量，则抛出异常。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public var length = 4
    public var width = 5
    public var myName = ""
    public init() {}
}

main(): Unit {
    // 此处是通过 Rectangular 的类型的限定名称获取 ClassTypeInfo，也可以通过实例获取 ClassTypeInfo
    let ty = ClassTypeInfo.get("test.Rectangular")

    // 获取类实例成员信息
    let ivi = ty.getInstanceVariable("myName")
    println(ivi)
    return
}
```

运行结果：

```text
myName: String
```

### func getStaticVariable(String)

```cangjie
public func getStaticVariable(name: String): StaticVariableInfo
```

功能：给定变量名称，尝试获取该 [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) 所对应的 `class` 类型中匹配的静态成员变量的信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 变量名称。

返回值：

- [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo) - 如果成功匹配则返回该静态成员变量的信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果没找到对应静态成员变量，则抛出异常。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public static var area: Int64 = 10
}

main(): Unit {
    // 此处是通过 Rectangular 的类型的限定名称获取 ClassTypeInfo，也可以通过实例获取 ClassTypeInfo
    let ty = ClassTypeInfo.get("test.Rectangular")

    // 获取静态变量
    let sv = ty.getStaticVariable("area")
    println(sv)
    return
}
```

运行结果：

```text
static area: Int64
```

### func isAbstract()

```cangjie
public func isAbstract(): Bool
```

功能：判断该 [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) 对应的 `class` 类型是否是抽象类。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该 [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) 对应的 `class` 类型是抽象类则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public abstract class Shape {
    public init() {}
}

public class Circle <: Shape {
    public init() {
        super()
    }
}

main(): Unit {
    // 获取 Shape 类型信息
    let shapeTy = ClassTypeInfo.get("test.Shape")
    println("Shape 是抽象类: ${shapeTy.isAbstract()}")
    
    // 获取 Circle 类型信息
    let circleTy = ClassTypeInfo.get("test.Circle")
    println("Circle 是抽象类: ${circleTy.isAbstract()}")
    
    return
}
```

运行结果：

```text
Shape 是抽象类: true
Circle 是抽象类: false
```

### func isOpen()

```cangjie
public func isOpen(): Bool
```

功能：判断该 [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) 对应的 `class` 类型是否拥有 `open` 语义。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 并不是只有被 `open` 修饰符所修饰的 `class` 类型定义才拥有 `open` 语义，如: `abstract class` 无论是否被 `open` 修饰符修饰都会拥有 `open` 语义。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该 [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) 对应的 `class` 类型拥有 `open` 语义则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public open class OpenClass {
    public init() {}
}

public class RegularClass {
    public init() {}
}

main(): Unit {
    // 获取 OpenClass 类型信息
    let openTy = ClassTypeInfo.get("test.OpenClass")
    println("OpenClass 拥有 open 语义: ${openTy.isOpen()}")
    
    // 获取 RegularClass 类型信息
    let regularTy = ClassTypeInfo.get("test.RegularClass")
    println("RegularClass 拥有 open 语义: ${regularTy.isOpen()}")
    
    return
}
```

运行结果：

```text
OpenClass 拥有 open 语义: true
RegularClass 拥有 open 语义: false
```

### func isSealed()

```cangjie
public func isSealed(): Bool
```

功能：判断该 [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) 对应的 `class` 类型是否拥有 `sealed` 语义。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该 [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) 对应的 `class` 类型拥有 `sealed` 语义则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public abstract sealed class SealedClass {
    public init() {}
}

public class RegularClass {
    public init() {}
}

main(): Unit {
    // 获取 SealedClass 类型信息
    let sealedTy = ClassTypeInfo.get("test.SealedClass")
    println("SealedClass 拥有 sealed 语义: ${sealedTy.isSealed()}")
    
    // 获取 RegularClass 类型信息
    let regularTy = ClassTypeInfo.get("test.RegularClass")
    println("RegularClass 拥有 sealed 语义: ${regularTy.isSealed()}")
    
    return
}
```

运行结果：

```text
SealedClass 拥有 sealed 语义: true
RegularClass 拥有 sealed 语义: false
```

## class ConstructorInfo

```cangjie
public class ConstructorInfo <: Equatable<ConstructorInfo> & Hashable & ToString
```

功能：描述构造函数信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

父类型：

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[ConstructorInfo](#class-constructorinfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop annotations

```cangjie
public prop annotations: Collection<Annotation>
```

功能：获取所有作用于该 [ConstructorInfo](reflect_package_classes.md#class-constructorinfo) 对应的构造函数的自定义注解，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果无任何注解作用于该构造函数信息所对应的构造函数，则返回空集合。
> - 该集合不保证遍历顺序恒定。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[Annotation](../../ast/ast_package_api/ast_package_classes.md#class-annotation)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

@Annotation
public class MyAnnotation {
    public let data: String
    public const init() {
        this.data = "MyAnnotation's data"
    }
}

@MyAnnotation
public class Rectangular {
    public var length = 4
    public var width = 5
    public var myName = ""
    
    @MyAnnotation
    public init() {}
    
    @MyAnnotation
    public init(name: String) {
        myName = name
    }
}

main(): Unit {
    // 获取 Rectangular 类型信息
    let ty = ClassTypeInfo.get("test.Rectangular")
    
    // 遍历所有构造函数
    for (constructor in ty.constructors) {
        // 获取构造函数上的注解
        let annotations = constructor.annotations
        for (annotation in annotations) {
            let myAnnotation = (annotation as MyAnnotation).getOrThrow()
            println("构造函数 ${constructor} 上的注解数据: ${myAnnotation.data}")
        }
    }
    return
}
```

运行结果：

```text
构造函数 init() 上的注解数据: MyAnnotation's data
构造函数 init(String) 上的注解数据: MyAnnotation's data
```

### prop parameters

```cangjie
public prop parameters: ReadOnlyList<ParameterInfo>
```

功能：获取该 [ConstructorInfo](reflect_package_classes.md#class-constructorinfo) 所对应的构造函数的参数类型列表。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 不保证参数顺序，可根据 `ParameterInfo`的 `index` 属性确定参数实际位置。

类型：[ReadOnlyList](../../collection/collection_package_api/collection_package_interface.md#interface-readonlylistt)\<[ParameterInfo](reflect_package_classes.md#class-parameterinfo)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public var length = 4
    public var width = 5
    public var myName = ""
    public init() {}
    public init(name: String) {
        myName = name
    }
    public init(name: String, length: Int64, width: Int64) {
        myName = name
        this.length = length
        this.width = width
    }
}

main(): Unit {
    // 此处是通过 Rectangular 的类型的限定名称获取 ClassTypeInfo，也可以通过实例获取 ClassTypeInfo
    let ty = ClassTypeInfo.get("test.Rectangular")
    // 获取 constructors
    for (i in ty.constructors) {
        // 获取 parameters
        for (j in i.parameters) {
            println("${i} 的入参有 ${j}")
        }
    }
    return
}
```

运行结果：

```text
init(String) 的入参有 String
init(String, Int64, Int64) 的入参有 String
init(String, Int64, Int64) 的入参有 Int64
init(String, Int64, Int64) 的入参有 Int64
```

### func apply(Array\<Any>)

```cangjie
public func apply(args: Array<Any>): Any
```

功能：调用该 [ConstructorInfo](reflect_package_classes.md#class-constructorinfo) 对应的构造函数，传入实参列表，并返回调用结果。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- args: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Any](../../core/core_package_api/core_package_interfaces.md#interface-any)> - 实参列表。

返回值：

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 由该构造函数构造得到的类型实例。

异常：

- [InvocationTargetException](reflect_package_exceptions.md#class-invocationtargetexception) - 如果该构造函数信息所对应的构造函数所属的类型是抽象类，则会抛出异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果实参列表 `args` 中的实参的数目与该构造函数信息所对应的构造函数的形参列表中的形参的数目不等，则抛出异常。
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - 如果实参列表 `args` 中的任何一个实参的运行时类型不是该构造函数信息所对应的构造函数的对应形参的声明类型的子类型，则抛出异常。
- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - 如果被调用的构造函数信息所对应的构造函数内部抛出异常，则该异常将被封装为 [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) 异常并抛出。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public var length = 4
    public var width = 5
    public var myName = ""
    
    public init() {
        println("调用了无参构造函数")
    }
    
    public init(name: String) {
        println("调用了有参构造函数")
        myName = name
    }
}

main(): Unit {
    // 获取 Rectangular 类型信息
    let ty = ClassTypeInfo.get("test.Rectangular")
    
    // 遍历构造函数
    for (constructor in ty.constructors) {
        // 找到无参构造函数
        if (constructor.parameters.size == 0) {
            // 创建空参数数组
            let args: Array<Any> = []
            
            // 调用构造函数
            let instance = constructor.apply(args)
            // 将实例转换为 Rectangular 类型
            let rect = (instance as Rectangular).getOrThrow()
            println("无参构造实例的长度是: ${rect.length}, 宽度是: ${rect.width}, 名称是: ${rect.myName}")
        }
        // 找到有参构造函数
        if (constructor.parameters.size == 1) {
            // 创建有参数数组
            let args: Array<Any> = ["MyRectangular"]
            
            // 调用构造函数
            let instance = constructor.apply(args)
            // 将实例转换为 Rectangular 类型
            let rect = (instance as Rectangular).getOrThrow()
            println("有参构造实例的长度是: ${rect.length}, 宽度是: ${rect.width}, 名称是: ${rect.myName}")
        }
    }
    
    return
}
```

运行结果：

```text
调用了无参构造函数
无参构造实例的长度是: 4, 宽度是: 5, 名称是: 
调用了有参构造函数
有参构造实例的长度是: 4, 宽度是: 5, 名称是: MyRectangular
```

### func findAllAnnotations\<T>() where T <: Annotation

```cangjie
public func findAllAnnotations<T>(): Array<T> where T <: Annotation
```

功能：获取所有指定注解名称的自定义注解（通过泛型筛选）。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - 若无指定T类型的注解时，返回空数组；若有相关注解时，将所有该类型注解对象构成的数组返回。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

@Annotation
public class MyAnnotation01 {
    public let data: String
    public const init() {
        this.data = "MyAnnotation01's data"
    }
}

@Annotation
public class MyAnnotation02 {
    public let data: String
    public const init() {
        this.data = "MyAnnotation02's data"
    }
}

public class Rectangular {
    public var length = 4
    public var width = 5
    public var myName = ""
    
    @MyAnnotation01
    @MyAnnotation02
    public init() {}
    
    @MyAnnotation01
    @MyAnnotation01
    @MyAnnotation02
    public init(name: String) {
        myName = name
    }
}

main(): Unit {
    // 获取 Rectangular 类型信息
    let ty = ClassTypeInfo.get("test.Rectangular")
    
    // 遍历所有构造函数
    for (constructor in ty.constructors) {
        // 获取构造函数上所有 MyAnnotation01 注解
        let annotations = constructor.findAllAnnotations<MyAnnotation01>()
        for (myAnnotation in annotations) {
            println("构造函数 ${constructor} 上的注解数据: ${myAnnotation.data}")
        }
    }
    return
}
```

运行结果：

```text
构造函数 init() 上的注解数据: MyAnnotation01's data
构造函数 init(String) 上的注解数据: MyAnnotation01's data
构造函数 init(String) 上的注解数据: MyAnnotation01's data
```

### func findAnnotation\<T>() where T <: Annotation

```cangjie
public func findAnnotation<T>(): ?T where T <: Annotation
```

功能：尝试获取指定注解名称的自定义注解（通过泛型筛选）。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- ?T - 如果成功匹配则返回该注解，重复标注或者无法匹配时返回 `None`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

@Annotation
public class MyAnnotation01 {
    public let data: String
    public const init() {
        this.data = "MyAnnotation01's data"
    }
}

@Annotation
public class MyAnnotation02 {
    public let data: String
    public const init() {
        this.data = "MyAnnotation02's data"
    }
}

public class Rectangular {
    public var length = 4
    public var width = 5
    public var myName = ""
    
    @MyAnnotation01
    @MyAnnotation02
    public init() {}
    
    @MyAnnotation01
    public init(name: String) {
        myName = name
    }
}

main(): Unit {
    // 获取 Rectangular 类型信息
    let ty = ClassTypeInfo.get("test.Rectangular")
    
    // 遍历所有构造函数
    for (constructor in ty.constructors) {
        // 尝试获取构造函数上 MyAnnotation01 注解
        let annotation = constructor.findAnnotation<MyAnnotation01>().getOrThrow()
        println("构造函数 ${constructor} 上的注解数据: ${annotation.data}")
    }
    return
}
```

运行结果：

```text
构造函数 init() 上的注解数据: MyAnnotation01's data
构造函数 init(String) 上的注解数据: MyAnnotation01's data
```

### func getAllAnnotations()

```cangjie
public func getAllAnnotations(): Array<Annotation>
```

功能：获取作用于该构造函数的所有自定义注解。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Annotation](./reflect_package_types.md#type-annotation--object)> - 作用于该对象的所有注解。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

@Annotation
public class MyAnnotation01 {
    public let data: String
    public const init() {
        this.data = "MyAnnotation01's data"
    }
}

@Annotation
public class MyAnnotation02 {
    public let data: String
    public const init() {
        this.data = "MyAnnotation02's data"
    }
}

public class Rectangular {
    public var length = 4
    public var width = 5
    public var myName = ""
    
    @MyAnnotation01
    @MyAnnotation02
    public init() {}
    
    @MyAnnotation01
    @MyAnnotation02
    public init(name: String) {
        myName = name
    }
}

main(): Unit {
    // 获取 Rectangular 类型信息
    let ty = ClassTypeInfo.get("test.Rectangular")
    
    // 遍历所有构造函数
    for (constructor in ty.constructors) {
        // 尝试获取构造函数上所有注解
        let annotations = constructor.getAllAnnotations()
        for (annotation in annotations) {
            if (annotation is MyAnnotation01) {
                let myAnnotation = (annotation as MyAnnotation01).getOrThrow()
                println("构造函数 ${constructor} 上的注解数据: ${myAnnotation.data}")
            } else if (annotation is MyAnnotation02) {
                let myAnnotation = (annotation as MyAnnotation02).getOrThrow()
                println("构造函数 ${constructor} 上的注解数据: ${myAnnotation.data}")
            }
        }
    }
    return
}
```

运行结果：

```text
构造函数 init() 上的注解数据: MyAnnotation01's data
构造函数 init() 上的注解数据: MyAnnotation02's data
构造函数 init(String) 上的注解数据: MyAnnotation01's data
构造函数 init(String) 上的注解数据: MyAnnotation02's data
```

### func hashCode()

```cangjie
public func hashCode(): Int64
```

功能：获取该构造器信息的哈希值。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 该构造器信息的哈希值。

示例：

<!-- run -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public var length = 4
    public var width = 5
    public var myName = ""
    
    public init() {}
    
    public init(name: String) {
        myName = name
    }
}

main(): Unit {
    // 获取 Rectangular 类型信息
    let ty = ClassTypeInfo.get("test.Rectangular")
    
    // 遍历所有构造函数并获取哈希值
    for (constructor in ty.constructors) {
        let hash = constructor.hashCode()
        println("构造函数 ${constructor} 的哈希值: ${hash}")
    }
    
    return
}
```

可能的运行结果：

```text
构造函数 init() 的哈希值: 93932258392112
构造函数 init(String) 的哈希值: 93932258392208
```

### func toString()

```cangjie
public func toString(): String
```

功能：获取字符串形式的该构造函数信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 字符串形式的该构造函数信息。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public var length = 4
    public var width = 5
    public var myName = ""
    
    public init() {}
    
    public init(name: String) {
        myName = name
    }
}

main(): Unit {
    // 获取 Rectangular 类型信息
    let ty = ClassTypeInfo.get("test.Rectangular")
    
    // 遍历所有构造函数并获取字符串表示
    for (constructor in ty.constructors) {
        let str = constructor.toString()
        println("构造函数的字符串表示: ${str}")
    }
    
    return
}
```

运行结果：

```text
构造函数的字符串表示: init()
构造函数的字符串表示: init(String)
```

### operator func !=(ConstructorInfo)

```cangjie
public operator func !=(that: ConstructorInfo): Bool
```

功能：判断该构造器信息与给定的另一个构造器信息是否不等。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- that: [ConstructorInfo](reflect_package_classes.md#class-constructorinfo) - 被比较相等性的另一个构造器信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该构造器信息与 `that` 不等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public var length = 4
    public var width = 5
    public var myName = ""
    
    public init() {}
    
    public init(name: String) {
        myName = name
    }
}

main(): Unit {
    // 获取 Rectangular 类型信息
    let ty = ClassTypeInfo.get("test.Rectangular")
    
    // 获取所有构造函数
    let constructors = ty.constructors.toArray()

    // 收集两个构造函数
    let firstConstructor: ConstructorInfo = constructors[0]
    let secondConstructor: ConstructorInfo = constructors[1]
    
    // 比较不同的构造函数
    let result = firstConstructor != secondConstructor
    println("两个不同构造函数不等: ${result}")
        
    // 比较相同的构造函数
    let firstConstructor1: ConstructorInfo = ClassTypeInfo.get("test.Rectangular").constructors.toArray()[0]
    let result2 = firstConstructor != firstConstructor1
    println("相同构造函数不等: ${result2}")
    
    return
}
```

运行结果：

```text
两个不同构造函数不等: true
相同构造函数不等: false
```

### operator func ==(ConstructorInfo)

```cangjie
public operator func ==(that: ConstructorInfo): Bool
```

功能：判断该构造器信息与给定的另一个构造器信息是否相等。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- that: [ConstructorInfo](reflect_package_classes.md#class-constructorinfo) - 被比较相等性的另一个构造器信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该构造器信息与 `that` 相等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public var length = 4
    public var width = 5
    public var myName = ""
    
    public init() {}
    
    public init(name: String) {
        myName = name
    }
}

main(): Unit {
    // 获取 Rectangular 类型信息
    let ty = ClassTypeInfo.get("test.Rectangular")
    
    // 获取所有构造函数
    let constructors = ty.constructors.toArray()

    // 收集两个构造函数
    let firstConstructor: ConstructorInfo = constructors[0]
    let secondConstructor: ConstructorInfo = constructors[1]
    
    // 比较不同的构造函数
    let result = firstConstructor == secondConstructor
    println("两个不同构造函数相等: ${result}")
        
    // 比较相同的构造函数
    let firstConstructor1: ConstructorInfo = ClassTypeInfo.get("test.Rectangular").constructors.toArray()[0]
    let result2 = firstConstructor == firstConstructor1
    println("相同构造函数相等: ${result2}")
    
    return
}
```

运行结果：

```text
两个不同构造函数相等: false
相同构造函数相等: true
```

## class GenericTypeInfo

```cangjie
public class GenericTypeInfo <: TypeInfo & Equatable<GenericTypeInfo>
```

功能：描述泛型类型信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

父类型：

- [TypeInfo](./reflect_package_classes.md#class-typeinfo)
- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[GenericTypeInfo](./reflect_package_classes.md#class-generictypeinfo)>

### operator func ==(GenericTypeInfo)

```cangjie
public operator func ==(that: GenericTypeInfo): Bool
```

功能：判断该泛型类型信息与给定的另一个泛型类型信息是否相等。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- that: [GenericTypeInfo](reflect_package_classes.md#class-generictypeinfo) - 被比较相等性的另一个泛型类型信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该泛型类型信息与 `that` 相等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public func myFunc<T>(str: String, toStr: T): Unit where T <: ToString {
    println("${str}: ${toStr}")
}

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")

    // 获取包中的第一个全局函数信息
    let globalFunctionInfo = ty.functions.toArray()[0]

    // 获取全局函数的泛型参数信息
    let genericTypeInfo = globalFunctionInfo.genericParams.toArray()[0]

    // 用另一种方式获取泛型参数信息
    let arr: Array<TypeInfo> = [TypeInfo.get("std.core.String"), genericTypeInfo]
    let globalFunctionInfoOtherWay = ty.getFunction("myFunc", arr)
    let genericTypeInfoOtherWay = globalFunctionInfoOtherWay.genericParams.toArray()[0]
    println("泛型类型信息是否相等: ${genericTypeInfo == genericTypeInfoOtherWay}")
    return
}
```

运行结果：

```text
泛型类型信息是否相等: true
```

## class GlobalFunctionInfo

```cangjie
public class GlobalFunctionInfo <: Equatable<GlobalFunctionInfo> & Hashable & ToString
```

功能：描述全局函数信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

父类型：

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[GlobalFunctionInfo](#class-globalfunctioninfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop annotations

```cangjie
public prop annotations: Collection<Annotation>
```

功能：获取所有[GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo) 对应的全局函数的自定义注解，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果无任何注解作用于该全局函数信息所对应全局函数，则返回空集合。
> - 该集合不保证遍历顺序恒定。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[Annotation](./reflect_package_types.md#type-annotation--object)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

@MyAnnotation
public func myFunc<T>(str: String, toStr: T): Unit where T <: ToString {
    println("${str}: ${toStr}")
}

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")

    // 获取包中的第一个全局函数信息
    let globalFunctionInfo = ty.functions.toArray()[0]

    // 获取全局函数的注解信息
    let annotations = globalFunctionInfo.annotations

    // 遍历注解信息
    for (annotation in annotations) {
        let anno = (annotation as MyAnnotation).getOrThrow()
        println("Annotation: ${anno.data}")
    }
    return
}

@Annotation
public class MyAnnotation {
    public let data: String
    public const init() {
        this.data = "MyAnnotation's data"
    }
}
```

运行结果：

```text
Annotation: MyAnnotation's data
```

### prop genericParams

```cangjie
public prop genericParams: Collection<GenericTypeInfo>
```

功能：获取该 [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo) 对应的全局函数的泛型参数信息列表。

> **注意：**
>
> 不支持平台：macOS、iOS。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[GenericTypeInfo](reflect_package_classes.md#class-generictypeinfo)>

异常：

- [InfoNotFoundException](./reflect_package_exceptions.md#class-infonotfoundexception) - [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo) 没有泛型参数时抛出异常。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个带泛型参数的全局函数
public func genericFunc<T>(value: T): T {
    return value
}

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的第一个全局函数信息
    let globalFunctionInfo = ty.functions.toArray()[0]
    
    // 获取全局函数的泛型参数信息
    let genericParams = globalFunctionInfo.genericParams
    println("泛型参数数量: ${genericParams.size}")
    
    // 遍历泛型参数
    for (param in genericParams) {
        println("泛型参数名称: ${param.name}")
    }
    
    return
}
```

运行结果：

```text
泛型参数数量: 1
泛型参数名称: T
```

### prop name

```cangjie
public prop name: String
```

功能：获取该 [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo) 对应的全局函数的名称。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 构成重载的所有全局函数将拥有相同的名称。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个全局函数
public func myFunction(value: Int64): Int64 {
    return value + 1
}

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的第一个全局函数信息
    let globalFunctionInfo = ty.functions.toArray()[0]
    
    // 获取全局函数的名称
    let name = globalFunctionInfo.name
    println("全局函数名称: ${name}")
    
    return
}
```

运行结果：

```text
全局函数名称: myFunction
```

### prop parameters

```cangjie
public prop parameters: ReadOnlyList<ParameterInfo>
```

功能：获取该 [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo) 对应的全局函数的参数信息列表。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 不保证参数顺序，可根据 `ParameterInfo`的 `index` 属性确定参数实际位置。

类型：[ReadOnlyList](../../collection/collection_package_api/collection_package_interface.md#interface-readonlylistt)\<[ParameterInfo](reflect_package_classes.md#class-parameterinfo)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个带多个参数的全局函数
public func myFunction(str: String, num: Int64): Unit {
    println("String: ${str}, Int64: ${num}")
}

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的第一个全局函数信息
    let globalFunctionInfo = ty.functions.toArray()[0]
    
    // 获取全局函数的参数信息列表
    let parameters = globalFunctionInfo.parameters
    println("参数数量: ${parameters.size}")
    
    // 遍历参数信息
    for (param in parameters) {
        println("参数名称: ${param.name}")
    }
    
    return
}
```

运行结果：

```text
参数数量: 2
参数名称: str
参数名称: num
```

### prop returnType

```cangjie
public prop returnType: TypeInfo
```

功能：获取该 [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo) 对应的全局函数的返回类型的类型信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

类型：[TypeInfo](reflect_package_classes.md#class-typeinfo)

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个有返回值的全局函数
public func myFunction(value: Int64): String {
    return "Value is ${value}"
}

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的第一个全局函数信息
    let globalFunctionInfo = ty.functions.toArray()[0]
    
    // 获取全局函数的返回类型信息
    let returnType = globalFunctionInfo.returnType
    println("返回类型名称: ${returnType.name}")
    
    return
}
```

运行结果：

```text
返回类型名称: String
```

### func apply(Array\<Any>)

```cangjie
public func apply(args: Array<Any>): Any
```

功能：调用该 [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo) 对应的全局函数，传入实参列表，返回调用结果。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - `args` 的类型确保和函数入参类型完全一致，否则会导致参数检查失败。

参数：

- args: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Any](../../core/core_package_api/core_package_interfaces.md#interface-any)> - 实参列表。

返回值：

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 该全局函数的调用结果。

异常：

- [InvocationTargetException](../reflect_package_api/reflect_package_exceptions.md#class-invocationtargetexception) - 如果存在泛型参数的函数调用了该方法，则抛出异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果实参列表 `args` 中的实参的数目与该全局函数信息 `GlobalFunctionInfo` 所对应的全局函数的形参列表中的形参的数目不等，则抛出异常。
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - 如果实参列表 `args` 中的任何一个实参的运行时类型不是该全局函数信息所对应的全局函数的对应形参的声明类型的子类型，则抛出异常。
- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - 如果被调用的全局函数信息所对应全局函数内部抛出异常，则该异常将被封装为 [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) 异常并抛出。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个简单的全局函数
public func add(a: Int64, b: Int64): Int64 {
    return a + b
}

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的第一个全局函数信息
    let globalFunctionInfo = ty.functions.toArray()[0]
    
    // 准备参数
    let args: Array<Any> = [10, 20]
    
    // 调用全局函数
    let result = globalFunctionInfo.apply(args)
    
    // 将结果转换为 Int64 类型
    let intResult = result as Int64
    println("调用结果: ${intResult}")
    
    return
}
```

运行结果：

```text
调用结果: Some(30)
```

### func apply(Array\<TypeInfo>, Array\<Any>)

```cangjie
public func apply(genericTypeArgs: Array<TypeInfo>, args: Array<Any>): Any
```

功能：调用该 [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo) 对应的全局泛型函数，传入泛型参数类型列表和实参列表，返回调用结果。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - `args` 的类型确保和函数入参类型完全一致，否则会导致参数检查失败。

参数：

- genericTypeArgs: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[TypeInfo](./reflect_package_classes.md#class-typeinfo)> - 泛型参数类型列表。
- args: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Any](../../core/core_package_api/core_package_interfaces.md#interface-any)> - 实参列表。

返回值：

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 该全局函数的调用结果。

异常：

- [InvocationTargetException](../reflect_package_api/reflect_package_exceptions.md#class-invocationtargetexception) - 如果非泛型函数调用了该方法，则抛出异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果实参列表 `args` 中的实参的数目与该全局函数信息 `GlobalFunctionInfo` 所对应的全局函数的形参列表中的形参的数目不等，则抛出异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果函数泛型参数列表 `genericTypeArgs` 中的参数数目与该全局函数信息所对应的全局函数的泛型参数列表 `genericParams` 中的参数数目不等，则抛出异常。
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - 如果实参列表 `args` 中的任何一个实参的运行时类型不是该全局函数信息所对应的全局函数的对应形参的声明类型的子类型，则抛出异常。
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - 如果传入的参数列表 `args` 和泛型参数类型列表 `genericTypeArgs` 不满足该全局函数信息所对应的全局函数的参数的类型约束，则抛出异常。
- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - 如果被调用的全局函数信息所对应全局函数内部抛出异常，则该异常将被封装为 [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) 异常并抛出。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个泛型全局函数
public func genericFunc<T>(value: T): T {
    return value
}

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的第一个全局函数信息
    let globalFunctionInfo = ty.functions.toArray()[0]
    
    // 准备泛型参数类型列表
    let genericTypeArgs: Array<TypeInfo> = [PrimitiveTypeInfo.get("Int64")]
    
    // 准备参数
    let args: Array<Any> = [42]
    
    // 调用泛型全局函数
    let result = globalFunctionInfo.apply(genericTypeArgs, args)
    
    // 将结果转换为 Int64 类型
    let intResult = result as Int64
    println("调用结果: ${intResult}")
    
    return
}
```

运行结果：

```text
调用结果: Some(42)
```

### func findAllAnnotations\<T>() where T <: Annotation

```cangjie
public func findAllAnnotations<T>(): Array<T> where T <: Annotation
```

功能：获取所有指定注解名称的自定义注解（通过泛型筛选）。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - 若无指定T类型的注解时，返回空数组；若有相关注解时，将所有该类型注解对象构成的数组返回。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

@MyAnnotation
public func myFunction(): Unit {
    println("Hello, World!")
}

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的第一个全局函数信息
    let globalFunctionInfo = ty.functions.toArray()[0]
    
    // 查找所有 MyAnnotation 类型的注解
    let annotations = globalFunctionInfo.findAllAnnotations<MyAnnotation>()
    println("找到的注解数量: ${annotations.size}")
    
    return
}

@Annotation
public class MyAnnotation {
    public const init() {}
}
```

运行结果：

```text
找到的注解数量: 1
```

### func findAnnotation\<T>() where T <: Annotation

```cangjie
public func findAnnotation<T>(): ?T where T <: Annotation
```

功能：尝试获取指定注解名称的自定义注解（通过泛型筛选）。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- ?T - 如果成功匹配则返回该注解，重复标注或者无法匹配时返回 `None`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

@MyAnnotation
public func myFunction(): Unit {
    println("Hello, World!")
}

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的第一个全局函数信息
    let globalFunctionInfo = ty.functions.toArray()[0]
    
    // 查找 MyAnnotation 类型的注解
    let annotation = globalFunctionInfo.findAnnotation<MyAnnotation>()
    
    // 检查是否找到了注解
    if (annotation.isSome()) {
        println("找到了 MyAnnotation 注解")
    } else {
        println("未找到 MyAnnotation 注解")
    }
    
    return
}

@Annotation
public class MyAnnotation {
    public const init() {}
}
```

运行结果：

```text
找到了 MyAnnotation 注解
```

### func getAllAnnotations()

```cangjie
public func getAllAnnotations(): Array<Annotation>
```

功能：获取作用于该全局函数的所有自定义注解。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Annotation](./reflect_package_types.md#type-annotation--object)> - 作用于该对象的所有注解。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

@MyAnnotation
public func myFunction(): Unit {
    println("Hello, World!")
}

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的第一个全局函数信息
    let globalFunctionInfo = ty.functions.toArray()[0]
    
    // 获取所有注解
    let allAnnotations = globalFunctionInfo.getAllAnnotations()
    println("注解总数: ${allAnnotations.size}")
    
    return
}

@Annotation
public class MyAnnotation {
    public const init() {}
}
```

运行结果：

```text
注解总数: 1
```

### func hashCode()

```cangjie
public func hashCode(): Int64
```

功能：获取该全局函数信息的哈希值。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 该全局函数信息的哈希值。

示例：

<!-- run -->
```cangjie
package test

import std.reflect.*

public func myFunction(): Unit {
    println("Hello, World!")
}

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的第一个全局函数信息
    let globalFunctionInfo = ty.functions.toArray()[0]
    
    // 获取全局函数信息的哈希值
    let hashCode = globalFunctionInfo.hashCode()
    println("哈希值: ${hashCode}")
    
    return
}
```

可能的运行结果：

```text
哈希值: 93955636542272
```

### func toString()

```cangjie
public func toString(): String
```

功能：获取字符串形式的该全局函数信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 字符串形式的该全局函数信息。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public func myFunction(): Unit {
    println("Hello, World!")
}

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的第一个全局函数信息
    let globalFunctionInfo = ty.functions.toArray()[0]
    
    // 获取全局函数信息的字符串表示
    let str = globalFunctionInfo.toString()
    println("字符串表示: ${str}")
    
    return
}
```

运行结果：

```text
字符串表示: func myFunction(): Unit
```

### operator func !=(GlobalFunctionInfo)

```cangjie
public operator func !=(that: GlobalFunctionInfo): Bool
```

功能：判断该全局函数信息与给定的另一个全局函数信息是否不等。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- that: [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo) - 被比较相等性的另一个全局函数信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该全局函数信息与 `that` 不等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public func function1(): Unit {
    println("Function 1")
}

public func function2(): Unit {
    println("Function 2")
}

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的前两个全局函数信息
    let globalFunctionInfos = ty.functions.toArray()
    let function1Info = globalFunctionInfos[0]
    let function2Info = globalFunctionInfos[1]
    
    // 比较两个不同的全局函数信息
    let result = function1Info != function2Info
    println("两个不同的全局函数信息不相等: ${result}")
    
    // 比较相同的全局函数信息
    let result2 = function1Info != function1Info
    println("相同的全局函数信息不相等: ${result2}")
    
    return
}
```

运行结果：

```text
两个不同的全局函数信息不相等: true
相同的全局函数信息不相等: false
```

### operator func ==(GlobalFunctionInfo)

```cangjie
public operator func ==(that: GlobalFunctionInfo): Bool
```

功能：判断该全局函数信息与给定的另一个全局函数信息是否相等。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- that: [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo) - 被比较相等性的另一个全局函数信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该全局函数信息与 `that` 相等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public func function1(): Unit {
    println("Function 1")
}

public func function2(): Unit {
    println("Function 2")
}

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的前两个全局函数信息
    let globalFunctionInfos = ty.functions.toArray()
    let function1Info = globalFunctionInfos[0]
    let function2Info = globalFunctionInfos[1]
    
    // 比较两个不同的全局函数信息
    let result = function1Info == function2Info
    println("两个不同的全局函数信息相等: ${result}")
    
    // 比较相同的全局函数信息
    let result2 = function1Info == function1Info
    println("相同的全局函数信息相等: ${result2}")
    
    return
}
```

运行结果：

```text
两个不同的全局函数信息相等: false
相同的全局函数信息相等: true
```

## class GlobalVariableInfo

```cangjie
public class GlobalVariableInfo <: Equatable<GlobalVariableInfo> & Hashable & ToString
```

功能：描述全局变量信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

父类型：

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[GlobalVariableInfo](#class-globalvariableinfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop annotations

```cangjie
public prop annotations: Collection<Annotation>
```

功能：获取所有作用于该 [GlobalVariableInfo](reflect_package_classes.md#class-globalvariableinfo) 对应的全局变量的自定义注解，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果无任何注解作用于该全局变量信息所对应的全局变量，则返回空集合。
> - 该集合不保证遍历顺序恒定。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[Annotation](./reflect_package_types.md#type-annotation--object)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

@MyAnnotation
public var myGlobalVar: Int64 = 42

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的全局变量信息
    let globalVariables = ty.variables
    println("全局变量数量: ${globalVariables.size}")
    
    // 获取第一个全局变量信息
    let globalVariableInfo = globalVariables.toArray()[0]
    
    // 获取全局变量的注解信息
    let annotations = globalVariableInfo.annotations
    println("注解数量: ${annotations.size}")
    
    return
}

@Annotation
public class MyAnnotation {
    public const init() {}
}
```

运行结果：

```text
全局变量数量: 1
注解数量: 1
```

### prop name

```cangjie
public prop name: String
```

功能：获取该 [GlobalVariableInfo](reflect_package_classes.md#class-globalvariableinfo) 对应的全局变量的名称。

> **注意：**
>
> 不支持平台：macOS、iOS。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public var myGlobalVar: Int64 = 42

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的全局变量信息
    let globalVariables = ty.variables
    println("全局变量数量: ${globalVariables.size}")
    
    // 获取第一个全局变量信息
    let globalVariableInfo = globalVariables.toArray()[0]
    
    // 获取全局变量的名称
    let name = globalVariableInfo.name
    println("全局变量名称: ${name}")
    
    return
}
```

运行结果：

```text
全局变量数量: 1
全局变量名称: myGlobalVar
```

### prop typeInfo

```cangjie
public prop typeInfo: TypeInfo
```

功能：获取该 [GlobalVariableInfo](reflect_package_classes.md#class-globalvariableinfo) 对应的全局变量的声明类型的类型信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

类型：[TypeInfo](reflect_package_classes.md#class-typeinfo)

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public var myGlobalVar: Int64 = 42

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的全局变量信息
    let globalVariables = ty.variables
    println("全局变量数量: ${globalVariables.size}")
    
    // 获取第一个全局变量信息
    let globalVariableInfo = globalVariables.toArray()[0]
    
    // 获取全局变量的类型信息
    let typeInfo = globalVariableInfo.typeInfo
    println("全局变量类型名称: ${typeInfo.name}")
    
    return
}
```

运行结果：

```text
全局变量数量: 1
全局变量类型名称: Int64
```

### func findAllAnnotations\<T>() where T <: Annotation

```cangjie
public func findAllAnnotations<T>(): Array<T> where T <: Annotation
```

功能：获取所有指定注解名称的自定义注解（通过泛型筛选）。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - 若无指定T类型的注解时，返回空数组；若有相关注解时，将所有该类型注解对象构成的数组返回。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

@MyAnnotation
public var myGlobalVar: Int64 = 42

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的全局变量信息
    let globalVariables = ty.variables
    println("全局变量数量: ${globalVariables.size}")
    
    // 获取第一个全局变量信息
    let globalVariableInfo = globalVariables.toArray()[0]
    
    // 查找所有 MyAnnotation 类型的注解
    let annotations = globalVariableInfo.findAllAnnotations<MyAnnotation>()
    println("找到的注解数量: ${annotations.size}")
    
    return
}

@Annotation
public class MyAnnotation {
    public const init() {}
}
```

运行结果：

```text
全局变量数量: 1
找到的注解数量: 1
```

### func findAnnotation\<T>() where T <: Annotation

```cangjie
public func findAnnotation<T>(): ?T where T <: Annotation
```

功能：尝试获取指定注解名称的自定义注解（通过泛型筛选）。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- ?T - 如果成功匹配则返回该注解，重复标注或者无法匹配时返回 `None`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

@MyAnnotation
public var myGlobalVar: Int64 = 42

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的全局变量信息
    let globalVariables = ty.variables
    println("全局变量数量: ${globalVariables.size}")
    
    // 获取第一个全局变量信息
    let globalVariableInfo = globalVariables.toArray()[0]
    
    // 查找 MyAnnotation 类型的注解
    let annotation = globalVariableInfo.findAnnotation<MyAnnotation>()
    
    // 检查是否找到了注解
    if (annotation.isSome()) {
        println("找到了 MyAnnotation 注解")
    } else {
        println("未找到 MyAnnotation 注解")
    }
    
    return
}

@Annotation
public class MyAnnotation {
    public const init() {}
}
```

运行结果：

```text
全局变量数量: 1
找到了 MyAnnotation 注解
```

### func getAllAnnotations()

```cangjie
public func getAllAnnotations(): Array<Annotation>
```

功能：获取作用于该对象的所有自定义注解。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Annotation](./reflect_package_types.md#type-annotation--object)> - 作用于该对象的所有注解。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

@MyAnnotation
public var myGlobalVar: Int64 = 42

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的全局变量信息
    let globalVariables = ty.variables
    println("全局变量数量: ${globalVariables.size}")
    
    // 获取第一个全局变量信息
    let globalVariableInfo = globalVariables.toArray()[0]
    
    // 获取所有注解
    let allAnnotations = globalVariableInfo.getAllAnnotations()
    println("注解总数: ${allAnnotations.size}")
    
    return
}

@Annotation
public class MyAnnotation {
    public const init() {}
}
```

运行结果：

```text
全局变量数量: 1
注解总数: 1
```

### func getValue()

```cangjie
public func getValue(): Any
```

功能：获取该 [GlobalVariableInfo](reflect_package_classes.md#class-globalvariableinfo) 对应的全局变量的值。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 该全局变量的值。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public var myGlobalVar: Int64 = 42

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的全局变量信息
    let globalVariables = ty.variables
    println("全局变量数量: ${globalVariables.size}")
    
    // 获取第一个全局变量信息
    let globalVariableInfo = globalVariables.toArray()[0]
    
    // 获取全局变量的值
    let value = globalVariableInfo.getValue()
    
    // 将值转换为 Int64 类型
    let intValue = value as Int64
    println("全局变量的值: ${intValue}")
    
    return
}
```

运行结果：

```text
全局变量数量: 1
全局变量的值: Some(42)
```

### func hashCode()

```cangjie
public func hashCode(): Int64
```

功能：获取该全局变量信息的哈希值。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 该全局变量信息的哈希值。

示例：

<!-- run -->
```cangjie
package test

import std.reflect.*

public var myGlobalVar: Int64 = 42

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的全局变量信息
    let globalVariables = ty.variables
    println("全局变量数量: ${globalVariables.size}")
    
    // 获取第一个全局变量信息
    let globalVariableInfo = globalVariables.toArray()[0]
    
    // 获取全局变量信息的哈希值
    let hashCode = globalVariableInfo.hashCode()
    println("哈希值: ${hashCode}")
    
    return
}
```

可能的运行结果：

```text
全局变量数量: 1
哈希值: 94726377908864
```

### func isMutable()

```cangjie
public func isMutable(): Bool
```

功能：判断该 [GlobalVariableInfo](reflect_package_classes.md#class-globalvariableinfo) 对应的全局变量是否可修改。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果实例成员变量被 `var` 修饰符所修饰，则该全局变量可被修改。
> - 如果实例成员变量被 `let` 修饰符所修饰，则该全局变量不可被修改。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该全局变量可被修改则返回 `true` ，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public var mutableVar: Int64 = 42
public let immutableVar: Int64 = 42

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的全局变量信息
    let globalVariables = ty.variables
    println("全局变量数量: ${globalVariables.size}")
    
    // 获取全局变量信息
    let globalVariableInfos = globalVariables.toArray()
    let mutableVarInfo = globalVariableInfos[0]
    let immutableVarInfo = globalVariableInfos[1]
    
    // 检查全局变量是否可变
    let isMutable1 = mutableVarInfo.isMutable()
    println("mutableVar 是否可变: ${isMutable1}")
    
    let isMutable2 = immutableVarInfo.isMutable()
    println("immutableVar 是否可变: ${isMutable2}")
    
    return
}
```

运行结果：

```text
全局变量数量: 2
mutableVar 是否可变: true
immutableVar 是否可变: false
```

### func setValue(Any)

```cangjie
public func setValue(newValue: Any): Unit
```

功能：设置该 [GlobalVariableInfo](reflect_package_classes.md#class-globalvariableinfo) 对应的全局变量的值。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- newValue: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 新的值。

异常：

- [IllegalSetException](reflect_package_exceptions.md#class-illegalsetexception) - 如果该全局变量信息所对应的全局变量不可修改，则抛出异常。
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - 如果新值 `newValue` 的运行时类型不是全局变量信息所对应的全局变量的声明类型的子类型，则抛出异常。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public var myGlobalVar: Int64 = 42

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的全局变量信息
    let globalVariables = ty.variables
    println("全局变量数量: ${globalVariables.size}")
    
    // 获取第一个全局变量信息
    let globalVariableInfo = globalVariables.toArray()[0]
    
    // 获取全局变量的当前值
    let currentValue = globalVariableInfo.getValue() as Int64
    println("全局变量的当前值: ${currentValue}")
    
    // 设置全局变量的新值
    globalVariableInfo.setValue(100)
    
    // 获取全局变量的新值
    let newValue = globalVariableInfo.getValue() as Int64
    println("全局变量的新值: ${newValue}")
    
    return
}
```

运行结果：

```text
全局变量数量: 1
全局变量的当前值: Some(42)
全局变量的新值: Some(100)
```

### func toString()

```cangjie
public func toString(): String
```

功能：获取字符串形式的该全局变量信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 字符串形式的该全局变量信息。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public var myGlobalVar: Int64 = 42

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的全局变量信息
    let globalVariables = ty.variables
    println("全局变量数量: ${globalVariables.size}")
    
    // 获取第一个全局变量信息
    let globalVariableInfo = globalVariables.toArray()[0]
    
    // 获取全局变量信息的字符串表示
    let str = globalVariableInfo.toString()
    println("字符串表示: ${str}")
    
    return
}
```

运行结果：

```text
全局变量数量: 1
字符串表示: myGlobalVar: Int64
```

### operator func !=(GlobalVariableInfo)

```cangjie
public operator func !=(that: GlobalVariableInfo): Bool
```

功能：判断该全局变量信息与给定的另一个全局变量信息是否不等。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- that: [GlobalVariableInfo](reflect_package_classes.md#class-globalvariableinfo) - 被比较相等性的另一个全局变量信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该全局变量信息与 `that` 不等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public var globalVar1: Int64 = 42
public var globalVar2: Int64 = 100

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的全局变量信息
    let globalVariables = ty.variables
    println("全局变量数量: ${globalVariables.size}")
    
    // 获取全局变量信息
    let globalVariableInfos = globalVariables.toArray()
    let var1Info = globalVariableInfos[0]
    let var2Info = globalVariableInfos[1]
    
    // 比较两个不同的全局变量信息
    let result = var1Info != var2Info
    println("两个不同的全局变量信息不相等: ${result}")
    
    // 比较相同的全局变量信息
    let result2 = var1Info != var1Info
    println("相同的全局变量信息不相等: ${result2}")
    
    return
}
```

运行结果：

```text
全局变量数量: 2
两个不同的全局变量信息不相等: true
相同的全局变量信息不相等: false
```

### operator func ==(GlobalVariableInfo)

```cangjie
public operator func ==(that: GlobalVariableInfo): Bool
```

功能：判断该全局变量信息与给定的另一个全局变量信息是否相等。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- that: [GlobalVariableInfo](reflect_package_classes.md#class-globalvariableinfo) - 被比较相等性的另一个全局变量信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该全局变量信息与 `that` 相等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public var globalVar1: Int64 = 42
public var globalVar2: Int64 = 100

main(): Unit {
    // 获取 test 包的信息
    let ty = PackageInfo.get("test")
    
    // 获取包中的全局变量信息
    let globalVariables = ty.variables
    println("全局变量数量: ${globalVariables.size}")
    
    // 获取全局变量信息
    let globalVariableInfos = globalVariables.toArray()
    let var1Info = globalVariableInfos[0]
    let var2Info = globalVariableInfos[1]
    
    // 比较两个不同的全局变量信息
    let result = var1Info == var2Info
    println("两个不同的全局变量信息相等: ${result}")
    
    // 比较相同的全局变量信息
    let result2 = var1Info == var1Info
    println("相同的全局变量信息相等: ${result2}")
    
    return
}
```

运行结果：

```text
全局变量数量: 2
两个不同的全局变量信息相等: false
相同的全局变量信息相等: true
```

## class InstanceFunctionInfo

```cangjie
public class InstanceFunctionInfo <: Equatable<InstanceFunctionInfo> & Hashable & ToString
```

功能：描述实例成员函数信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

父类型：

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[InstanceFunctionInfo](#class-instancefunctioninfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop annotations

```cangjie
public prop annotations: Collection<Annotation>
```

功能：获取所有作用于该 [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo) 对应的实例成员函数的自定义注解，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果无任何注解作用于该实例成员函数信息所对应的实例成员函数，则返回空集合。
> - 该集合不保证遍历顺序恒定。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[Annotation](./reflect_package_types.md#type-annotation--object)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class MyClass {
    @MyAnnotation
    public func myMethod(): Int64 {
        return 42
    }
}

main(): Unit {
    // 获取 MyClass 类型信息
    let classInfo = ClassTypeInfo.get("test.MyClass")
    
    // 获取实例成员函数信息
    let instanceFunctionInfo = classInfo.getInstanceFunction("myMethod")
    
    // 获取注解信息
    let annotations = instanceFunctionInfo.annotations
    println("注解数量: ${annotations.size}")
    
    return
}

@Annotation
public class MyAnnotation {
    public const init() {}
}
```

运行结果：

```text
注解数量: 1
```

### prop genericParams

```cangjie
public prop genericParams: Collection<GenericTypeInfo>
```

功能：获取该 [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo) 对应的实例成员函数的泛型参数信息列表。

> **注意：**
>
> 不支持平台：macOS、iOS。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[GenericTypeInfo](reflect_package_classes.md#class-generictypeinfo)>

异常：

- [InfoNotFoundException](./reflect_package_exceptions.md#class-infonotfoundexception) - [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo) 没有泛型参数时抛出异常。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class MyClass {
    public func genericMethod<T>(value: T): T {
        return value
    }
}

main(): Unit {
    // 获取 MyClass 类型信息
    let classInfo = ClassTypeInfo.get("test.MyClass")
    
    // 获取所有实例成员函数信息
    let functions = classInfo.instanceFunctions
    println("实例成员函数数量: ${functions.size}")
    
    // 遍历所有实例成员函数
    for (funcInfo in functions) {
        println("函数名称: ${funcInfo.name}")
        // 尝试获取泛型参数信息
        try {
            let genericParams = funcInfo.genericParams
            println("泛型参数数量: ${genericParams.size}")
            
            // 遍历泛型参数
            for (param in genericParams) {
                println("泛型参数名称: ${param.name}")
            }
        } catch (e: InfoNotFoundException) {
            println("该函数没有泛型参数")
        }
    }
    
    return
}
```

运行结果：

```text
实例成员函数数量: 1
函数名称: genericMethod
泛型参数数量: 1
泛型参数名称: T
```

### prop modifiers

```cangjie
public prop modifiers: Collection<ModifierInfo>
```

功能：获取该 [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo) 对应的实例成员函数所拥有的所有修饰符的信息，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果该实例成员函数无任何修饰符，则返回空集合。
> - 该集合不保证遍历顺序恒定。
> - 即便未被某修饰符修饰，如果拥有该修饰符的语义，该修饰符信息也将被包括在该集合中。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[ModifierInfo](reflect_package_enums.md#enum-modifierinfo)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public open class MyClass {
    public open func publicMethod(): Int64 {
        return 42
    }
}

main(): Unit {
    // 获取 MyClass 类型信息
    let classInfo = ClassTypeInfo.get("test.MyClass")
    
    // 获取实例成员函数信息
    let instanceFunctionInfo = classInfo.getInstanceFunction("publicMethod")
    
    // 获取修饰符信息
    let modifiers = instanceFunctionInfo.modifiers
    println("修饰符数量: ${modifiers.size}")
    
    return
}
```

运行结果：

```text
修饰符数量: 1
```

### prop name

```cangjie
public prop name: String
```

功能：获取该 [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo) 对应的实例成员函数的名称。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 构成重载的所有实例成员函数将拥有相同的名称。
> - 操作符重载函数的名称就是该操作符本身的符号内容，如"`+`"，"`*`"，"`[]`"。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class MyClass {
    public func myMethod(): Int64 {
        return 42
    }
}

main(): Unit {
    // 获取 MyClass 类型信息
    let classInfo = ClassTypeInfo.get("test.MyClass")
    
    // 获取实例成员函数信息
    let instanceFunctionInfo = classInfo.getInstanceFunction("myMethod")
    
    // 获取函数名称
    let name = instanceFunctionInfo.name
    println("函数名称: ${name}")
    
    return
}
```

运行结果：

```text
函数名称: myMethod
```

### prop parameters

```cangjie
public prop parameters: ReadOnlyList<ParameterInfo>
```

功能：获取该 [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo) 对应的实例成员函数的参数信息列表。

> **注意：**
>
> 不支持平台：macOS、iOS。

> **说明：**
>
> 不保证参数顺序，可根据 `ParameterInfo`的 `index` 属性确定参数实际位置。

类型：[ReadOnlyList](../../collection/collection_package_api/collection_package_interface.md#interface-readonlylistt)\<[ParameterInfo](reflect_package_classes.md#class-parameterinfo)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class MyClass {
    public func myMethod(a: Int64, b: String): Int64 {
        return a
    }
}

main(): Unit {
    // 获取 MyClass 类型信息
    let classInfo = ClassTypeInfo.get("test.MyClass")
    
    // 获取所有实例成员函数
    let functions = classInfo.instanceFunctions
    println("实例成员函数数量: ${functions.size}")
    
    // 遍历所有实例成员函数
    for (funcInfo in functions) {
        println("函数名称: ${funcInfo.name}")
        
        // 获取参数信息
        let parameters = funcInfo.parameters
        println("参数数量: ${parameters.size}")
        
        // 遍历参数
        for (param in parameters) {
            println("参数名称: ${param.name}")
        }
    }
    
    return
}
```

运行结果：

```text
实例成员函数数量: 1
函数名称: myMethod
参数数量: 2
参数名称: a
参数名称: b
```

### prop returnType

```cangjie
public prop returnType: TypeInfo
```

功能：获取该 [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo) 对应的实例成员函数的返回值类型的类型信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

类型：[TypeInfo](reflect_package_classes.md#class-typeinfo)

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class MyClass {
    public func myMethod(a: Int64, b: String): Int64 {
        return a
    }
}

main(): Unit {
    // 获取 MyClass 类型信息
    let classInfo = ClassTypeInfo.get("test.MyClass")
    
    // 获取所有实例成员函数
    let functions = classInfo.instanceFunctions
    println("实例成员函数数量: ${functions.size}")
    
    // 遍历所有实例成员函数
    for (funcInfo in functions) {
        println("函数名称: ${funcInfo.name}")
        
        // 获取返回值类型信息
        let returnType = funcInfo.returnType
        println("返回值类型: ${returnType.name}")
    }
    
    return
}
```

运行结果：

```text
实例成员函数数量: 1
函数名称: myMethod
返回值类型: Int64
```

### func apply(Any, Array\<Any>)

```cangjie
public func apply(instance: Any, args: Array<Any>): Any
```

功能：调用该 [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo) 对应实例成员函数，指定实例并传入实参列表，返回调用结果。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - `args` 的类型确保和函数入参类型完全一致。

参数：

- instance: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 实例。
- args: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Any](../../core/core_package_api/core_package_interfaces.md#interface-any)> - 实参列表。

返回值：

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 该实例成员函数的调用结果。

异常：

- [InvocationTargetException](../reflect_package_api/reflect_package_exceptions.md#class-invocationtargetexception) - 如果存在泛型参数的函数调用了该方法，则抛出异常。
- [InvocationTargetException](reflect_package_exceptions.md#class-invocationtargetexception) - 如果该实例成员函数信息所对应的实例成员函数是抽象的，或不存在相应的函数实现，则抛出异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果实参列表 `args` 中的实参的数目与该实例成员函数信息所对应的实例成员函数的形参列表中的形参的数目不等，则抛出异常。
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - 如果实例 `instance` 的运行时类型与该实例成员函数信息所对应的实例成员函数所属的类型不相同，则抛出异常。
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - 如果实参列表 `args` 中的任何一个实参的运行时类型不是该实例成员函数信息所对应的实例成员函数的对应形参的声明类型的子类型，则抛出异常。
- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - 如果被调用的实例成员函数信息所对应的实例成员函数内部抛出异常，则该异常将被封装为 [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) 异常并抛出。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class MyClass {
    public var value: Int64 = 0
    
    public func setValue(newValue: Int64): Unit {
        this.value = newValue
    }
    
    public func getValue(): Int64 {
        return this.value
    }
}

main(): Unit {
    // 获取 MyClass 类型信息
    let classInfo = ClassTypeInfo.get("test.MyClass")
    
    // 创建实例
    let instance = MyClass()
    
    // 获取实例成员函数
    let setValueFunc = classInfo.getInstanceFunction("setValue", [PrimitiveTypeInfo.get("Int64")])
    let getValueFunc = classInfo.getInstanceFunction("getValue", [])
    
    // 准备参数
    let args: Array<Any> = [42]
    
    // 调用 setValue 函数
    setValueFunc.apply(instance, args)
    println("setValue 函数调用成功")
    
    // 调用 getValue 函数
    let result = getValueFunc.apply(instance, [])
        
    // 将结果转换为 Int64 类型
    let intResult = result as Int64
    println("getValue 函数调用结果: ${intResult}")
    
    return
}
```

运行结果：

```text
setValue 函数调用成功
getValue 函数调用结果: Some(42)
```

### func apply(Any, Array\<TypeInfo>, Array\<Any>)

```cangjie
public func apply(instance: Any, genericTypeArgs: Array<TypeInfo>, args: Array<Any>): Any
```

功能：调用该 [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo) 对应泛型成员函数，指定实例并传入泛型参数的类型列表和参数列表，返回调用结果。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - `args` 的类型确保和函数入参类型完全一致。

参数：

- instance: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 实例。
- genericTypeArgs: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[TypeInfo](./reflect_package_classes.md#class-typeinfo)> - 泛型参数类型信息列表。
- args: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Any](../../core/core_package_api/core_package_interfaces.md#interface-any)> - 泛型参数列表。

返回值：

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 该实例泛型函数的调用结果。

异常：

- [InvocationTargetException](reflect_package_exceptions.md#class-invocationtargetexception) - 如果该函数信息对应的成员函数是 `abstract` 或不存在函数体，则会抛出异常。
- [InvacationTargetException](reflect_package_exceptions.md#class-invocationtargetexception) - 如果非泛型函数调用了此方法，则抛出异常。
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - 如果实例 `instance` 的运行时类型与该成员函数信息所对应的成员函数所属的类型不相同，则抛出异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果实参列表 `args` 中的实参的数目与该成员函数信息所对应的成员函数的形参列表中的形参的数目不等，则抛出异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果函数泛型参数列表 `genericTypeArgs` 中的参数数目与该成员函数信息所对应的成员函数的泛型参数列表 `genericParams` 中的参数数目不等，则抛出异常。
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - 如果参数列表 `args` 中的任何一个参数的运行时类型不是该实例成员函数信息所对应的实例成员函数的对应形参的声明类型的子类型，则抛出异常。
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - 如果传入的参数列表 `args` 和泛型参数类型列表 `genericTypeArgs` 不满足该成员函数信息所对应的成员函数的参数的类型约束，则抛出异常。
- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - 如果被调用的实例成员函数信息所对应的实例成员函数内部抛出异常，则该异常将被封装为 [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) 异常并抛出。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class MyClass {
    public func genericMethod<T>(value: T): T {
        return value
    }
}

main(): Unit {
    // 获取 MyClass 类型信息
    let classInfo = ClassTypeInfo.get("test.MyClass")
    
    // 创建实例
    let instance = MyClass()
    
    // 获取所有实例成员函数
    let functions = classInfo.instanceFunctions
    
    // 查找 genericMethod 函数
    var genericFuncOpt: Option<InstanceFunctionInfo> = None
    
    for (funcInfo in functions) {
        if (funcInfo.name == "genericMethod") {
            genericFuncOpt = Some(funcInfo)
        }
    }
    
    // 准备泛型参数类型列表
    let genericTypeArgs: Array<TypeInfo> = [PrimitiveTypeInfo.get("Int64")]
    
    // 准备参数
    let args: Array<Any> = [42]
    
    // 调用 genericMethod 函数
    if (let Some(genericFunc) <- genericFuncOpt) {
        let result = genericFunc.apply(instance, genericTypeArgs, args)
        
        // 将结果转换为 Int64 类型
        let intResult = result as Int64
        println("genericMethod 函数调用结果: ${intResult}")
    }
    
    return
}
```

运行结果：

```text
genericMethod 函数调用结果: Some(42)
```

### func findAllAnnotations\<T>() where T <: Annotation

```cangjie
public func findAllAnnotations<T>(): Array<T> where T <: Annotation
```

功能：获取所有指定注解名称的自定义注解（通过泛型筛选）。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - 若无指定T类型的注解时，返回空数组；若有相关注解时，将所有该类型注解对象构成的数组返回。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class MyClass {
    @MyAnnotation
    @AnotherAnnotation
    public func myMethod(): Int64 {
        return 42
    }
}

main(): Unit {
    // 获取 MyClass 类型信息
    let classInfo = ClassTypeInfo.get("test.MyClass")
    
    // 获取实例成员函数信息
    let instanceFunctionInfo = classInfo.getInstanceFunction("myMethod")
    
    // 查找所有 MyAnnotation 注解
    let myAnnotations = instanceFunctionInfo.findAllAnnotations<MyAnnotation>()
    println("MyAnnotation 注解数量: ${myAnnotations.size}")
    
    // 查找所有 AnotherAnnotation 注解
    let anotherAnnotations = instanceFunctionInfo.findAllAnnotations<AnotherAnnotation>()
    println("AnotherAnnotation 注解数量: ${anotherAnnotations.size}")
    
    return
}

@Annotation
public class MyAnnotation {
    public const init() {}
}

@Annotation
public class AnotherAnnotation {
    public const init() {}
}
```

运行结果：

```text
MyAnnotation 注解数量: 1
AnotherAnnotation 注解数量: 1
```

### func findAnnotation\<T>() where T <: Annotation

```cangjie
public func findAnnotation<T>(): ?T where T <: Annotation
```

功能：尝试获取指定注解名称的自定义注解（通过泛型筛选）。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- ?T - 如果成功匹配则返回该注解，重复标注或者无法匹配时返回 `None`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class MyClass {
    @MyAnnotation
    public func myMethod(): Int64 {
        return 42
    }
}

main(): Unit {
    // 获取 MyClass 类型信息
    let classInfo = ClassTypeInfo.get("test.MyClass")
    
    // 获取实例成员函数信息
    let instanceFunctionInfo = classInfo.getInstanceFunction("myMethod")
    
    // 查找 MyAnnotation 注解
    let myAnnotation = instanceFunctionInfo.findAnnotation<MyAnnotation>()
    
    match (myAnnotation) {
        case Some(annotation) => println("找到了 MyAnnotation 注解")
        case None => println("未找到 MyAnnotation 注解")
    }
    
    // 尝试查找不存在的注解
    let anotherAnnotation = instanceFunctionInfo.findAnnotation<AnotherAnnotation>()
    
    match (anotherAnnotation) {
        case Some(annotation) => println("找到了 AnotherAnnotation 注解")
        case None => println("未找到 AnotherAnnotation 注解")
    }
    
    return
}

@Annotation
public class MyAnnotation {
    public const init() {}
}

@Annotation
public class AnotherAnnotation {
    public const init() {}
}
```

运行结果：

```text
找到了 MyAnnotation 注解
未找到 AnotherAnnotation 注解
```

### func getAllAnnotations()

```cangjie
public func getAllAnnotations(): Array<Annotation>
```

功能：获取作用于该对象的所有自定义注解。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Annotation](./reflect_package_types.md#type-annotation--object)> - 作用于该对象的所有注解。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class MyClass {
    @MyAnnotation
    @AnotherAnnotation
    public func myMethod(): Int64 {
        return 42
    }
}

main(): Unit {
    // 获取 MyClass 类型信息
    let classInfo = ClassTypeInfo.get("test.MyClass")
    
    // 获取实例成员函数信息
    let instanceFunctionInfo = classInfo.getInstanceFunction("myMethod")
    
    // 获取所有注解
    let allAnnotations = instanceFunctionInfo.getAllAnnotations()
    println("注解总数: ${allAnnotations.size}")
    
    return
}

@Annotation
public class MyAnnotation {
    public const init() {}
}

@Annotation
public class AnotherAnnotation {
    public const init() {}
}
```

运行结果：

```text
注解总数: 2
```

### func hashCode()

```cangjie
public func hashCode(): Int64
```

功能：获取该实例成员函数信息的哈希值。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 该实例成员函数信息的哈希值。

示例：

<!-- run -->
```cangjie
package test

import std.reflect.*

public class MyClass {
    public func myMethod(): Int64 {
        return 42
    }
}

main(): Unit {
    // 获取 MyClass 类型信息
    let classInfo = ClassTypeInfo.get("test.MyClass")
    
    // 获取实例成员函数信息
    let instanceFunctionInfo = classInfo.getInstanceFunction("myMethod")
    
    // 获取哈希值
    let hashCode = instanceFunctionInfo.hashCode()
    println("哈希值: ${hashCode}")
    
    return
}
```

可能的运行结果：

```text
哈希值: 93832974760528
```

### func isAbstract()

```cangjie
public func isAbstract(): Bool
```

功能：判断 [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo) 所对应的实例成员函数是否拥有 `abstract` 语义。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该实例成员函数拥有 `abstract` 语义则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public abstract class MyClass {
    public func method1(): Int64 {
        return 42
    }
    
    public func method2(): Int64
}

main(): Unit {
    // 获取 MyClass 类型信息
    let classInfo = ClassTypeInfo.get("test.MyClass")
    
    // 获取方法信息
    let func1 = classInfo.getInstanceFunction("method1")
    let func2 = classInfo.getInstanceFunction("method2")
    
    // 检查是否为抽象方法
    let isAbstract1 = func1.isAbstract()
    let isAbstract2 = func2.isAbstract()
    
    println("method1 是否为抽象方法: ${isAbstract1}")
    println("method2 是否为抽象方法: ${isAbstract2}")
    
    return
}
```

运行结果：

```text
method1 是否为抽象方法: false
method2 是否为抽象方法: true
```

### func isOpen()

```cangjie
public func isOpen(): Bool
```

功能：判断该 [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo) 对应的实例成员函数是否拥有 `open` 语义。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该实例成员函数拥有 `open` 语义则返回 `true`，否则返回 `false`。

> **注意：**
>
> `interface` 类型中的实例成员函数默认均拥有 `open` 语义。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public open class MyClass {
    public func method1(): Int64 {
        return 42
    }

    public open func method2(): Int64 {
        return 42
    }
}

main(): Unit {
    // 获取 MyClass 类型信息
    let classInfo = ClassTypeInfo.get("test.MyClass")
    
    // 获取方法信息
    let methodFunc1 = classInfo.getInstanceFunction("method1")
    let methodFunc2 = classInfo.getInstanceFunction("method2")
    
    // 检查是否为开放方法
    let isOpen1 = methodFunc1.isOpen()
    let isOpen2 = methodFunc2.isOpen()
    
    println("method1 是否为开放方法: ${isOpen1}")
    println("method2 是否为开放方法: ${isOpen2}")
    
    return
}
```

运行结果：

```text
method1 是否为开放方法: false
method2 是否为开放方法: true
```

### func toString()

```cangjie
public func toString(): String
```

功能：获取字符串形式的该实例成员函数信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 字符串形式的该实例成员函数信息。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class MyClass {
    public func myMethod(a: Int64, b: String): Int64 {
        return a
    }
}

main(): Unit {
    // 获取 MyClass 类型信息
    let classInfo = ClassTypeInfo.get("test.MyClass")
    
    // 获取所有实例成员函数
    let functions = classInfo.instanceFunctions
    
    // 遍历所有实例成员函数
    for (funcInfo in functions) {
        println("函数名称: ${funcInfo.name}")
        
        // 获取字符串表示
        let str = funcInfo.toString()
        println("字符串表示: ${str}")
    }
    
    return
}
```

运行结果：

```text
函数名称: myMethod
字符串表示: func myMethod(Int64, String): Int64
```

### operator func !=(InstanceFunctionInfo)

```cangjie
public operator func !=(that: InstanceFunctionInfo): Bool
```

功能：判断该实例成员函数信息与给定的另一个实例成员函数信息是否不等。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- that: [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo) - 被比较相等性的另一个实例成员函数信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该实例成员函数信息与 `that` 不等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class MyClass {
    public func method1(): Int64 {
        return 42
    }
    
    public func method2(): Int64 {
        return 42
    }
}

main(): Unit {
    // 获取 MyClass 类型信息
    let classInfo = ClassTypeInfo.get("test.MyClass")
    
    // 获取所有实例成员函数
    let functions = classInfo.instanceFunctions
    let funcArray = functions.toArray()
    
    // 获取两个不同的函数信息
    let func1 = funcArray[0]
    let func2 = funcArray[1]
    
    // 比较两个不同的函数信息
    let result1 = func1 != func2
    println("两个不同的函数信息不相等: ${result1}")
    
    // 比较相同的函数信息
    let result2 = func1 != func1
    println("相同的函数信息不相等: ${result2}")
    
    return
}
```

运行结果：

```text
两个不同的函数信息不相等: true
相同的函数信息不相等: false
```

### operator func ==(InstanceFunctionInfo)

```cangjie
public operator func ==(that: InstanceFunctionInfo): Bool
```

功能：判断该实例成员函数信息与给定的另一个实例成员函数信息是否相等。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- that: [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo) - 被比较相等性的另一个实例成员函数信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该实例成员函数信息与 `that` 相等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class MyClass {
    public func method1(): Int64 {
        return 42
    }
    
    public func method2(): Int64 {
        return 42
    }
}

main(): Unit {
    // 获取 MyClass 类型信息
    let classInfo = ClassTypeInfo.get("test.MyClass")
    
    // 获取所有实例成员函数
    let functions = classInfo.instanceFunctions
    let funcArray = functions.toArray()
    
    // 获取两个不同的函数信息
    let func1 = funcArray[0]
    let func2 = funcArray[1]
    
    // 比较两个不同的函数信息
    let result1 = func1 == func2
    println("两个不同的函数信息相等: ${result1}")
    
    // 比较相同的函数信息
    let result2 = func1 == func1
    println("相同的函数信息相等: ${result2}")
    
    return
}
```

运行结果：

```text
两个不同的函数信息相等: false
相同的函数信息相等: true
```

## class InstancePropertyInfo

```cangjie
public class InstancePropertyInfo <: Equatable<InstancePropertyInfo> & Hashable & ToString
```

功能：描述实例成员属性信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

父类型：

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[InstancePropertyInfo](#class-instancepropertyinfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop annotations

```cangjie
public prop annotations: Collection<Annotation>
```

功能：获取所有作用于该 [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo) 对应的实例成员属性的自定义注解，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果无任何注解作用于该实例成员属性信息所对应的实例成员属性，则返回空集合。
> - 该集合不保证遍历顺序恒定。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[Annotation](./reflect_package_types.md#type-annotation--object)>

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class MyTestClass {
    @MyCustomAnnotation
    public prop myProperty: Int64 {
        get() {
            42
        }
    }
}

main(): Unit {
    // 获取 MyTestClass 类型信息
    let classInfo = ClassTypeInfo.get("default.MyTestClass")
    
    // 获取实例成员属性信息
    let propertyInfo = classInfo.getInstanceProperty("myProperty")
    
    // 获取注解信息
    let annotations = propertyInfo.annotations
    println("注解数量: ${annotations.size}")
    
    return
}

@Annotation
public class MyCustomAnnotation {
    public const init() {}
}
```

运行结果：

```text
注解数量: 1
```

### prop modifiers

```cangjie
public prop modifiers: Collection<ModifierInfo>
```

功能：获取该 [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo) 对应的实例成员属性所拥有的所有修饰符的信息，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果该实例成员属性无任何修饰符，则返回空集合。
> - 该集合不保证遍历顺序恒定。
> - 即便未被某修饰符修饰，如果拥有该修饰符的语义，该修饰符信息也将被包括在该集合中。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[ModifierInfo](reflect_package_enums.md#enum-modifierinfo)>

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public open class MyTestClass {
    public open prop myProperty: Int64 {
        get() {
            42
        }
    }
}

main(): Unit {
    // 获取 MyTestClass 类型信息
    let classInfo = ClassTypeInfo.get("default.MyTestClass")
    
    // 获取实例成员属性信息
    let propertyInfo = classInfo.getInstanceProperty("myProperty")
    
    // 获取修饰符信息
    let modifiers = propertyInfo.modifiers
    println("修饰符数量: ${modifiers.size}")
    
    return
}
```

运行结果：

```text
修饰符数量: 1
```

### prop name

```cangjie
public prop name: String
```

功能：获取该 [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo) 对应的实例成员属性的名称。

> **注意：**
>
> 不支持平台：macOS、iOS。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class MyTestClass {
    public prop myProperty: Int64 {
        get() {
            42
        }
    }
}

main(): Unit {
    // 获取 MyTestClass 类型信息
    let classInfo = ClassTypeInfo.get("default.MyTestClass")
    
    // 获取实例成员属性信息
    let propertyInfo = classInfo.getInstanceProperty("myProperty")
    
    // 获取属性名称
    let name = propertyInfo.name
    println("属性名称: ${name}")
    
    return
}
```

运行结果：

```text
属性名称: myProperty
```

### prop typeInfo

```cangjie
public prop typeInfo: TypeInfo
```

功能：获取该 [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo) 对应的实例成员属性的声明类型的类型信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

类型：[TypeInfo](reflect_package_classes.md#class-typeinfo)

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class MyTestClass {
    public prop myProperty: Int64 {
        get() {
            42
        }
    }
}

main(): Unit {
    // 获取 MyTestClass 类型信息
    let classInfo = ClassTypeInfo.get("default.MyTestClass")
    
    // 获取实例成员属性信息
    let propertyInfo = classInfo.getInstanceProperty("myProperty")
    
    // 获取类型信息
    let typeInfo = propertyInfo.typeInfo
    println("属性类型: ${typeInfo.name}")
    
    return
}
```

运行结果：

```text
属性类型: Int64
```

### func findAllAnnotations\<T>() where T <: Annotation

```cangjie
public func findAllAnnotations<T>(): Array<T> where T <: Annotation
```

功能：获取所有指定注解名称的自定义注解（通过泛型筛选）。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - 若无指定T类型的注解时，返回空数组；若有相关注解时，将所有该类型注解对象构成的数组返回。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class MyTestClass {
    @MyCustomAnnotation
    @AnotherAnnotation
    public prop myProperty: Int64 {
        get() {
            42
        }
    }
}

main(): Unit {
    // 获取 MyTestClass 类型信息
    let classInfo = ClassTypeInfo.get("default.MyTestClass")
    
    // 获取实例成员属性信息
    let propertyInfo = classInfo.getInstanceProperty("myProperty")
    
    // 查找所有 MyCustomAnnotation 注解
    let myAnnotations = propertyInfo.findAllAnnotations<MyCustomAnnotation>()
    println("MyCustomAnnotation 注解数量: ${myAnnotations.size}")
    
    // 查找所有 AnotherAnnotation 注解
    let anotherAnnotations = propertyInfo.findAllAnnotations<AnotherAnnotation>()
    println("AnotherAnnotation 注解数量: ${anotherAnnotations.size}")
    
    return
}

@Annotation
public class MyCustomAnnotation {
    public const init() {}
}

@Annotation
public class AnotherAnnotation {
    public const init() {}
}
```

运行结果：

```text
MyCustomAnnotation 注解数量: 1
AnotherAnnotation 注解数量: 1
```

### func findAnnotation\<T>() where T <: Annotation

```cangjie
public func findAnnotation<T>(): ?T where T <: Annotation
```

功能：尝试获取指定注解名称的自定义注解（通过泛型筛选）。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- ?T - 如果成功匹配则返回该注解，重复标注或者无法匹配时返回 `None`。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class TestClassB {
    @CustomAnnotationA
    public prop myProperty: Int64 {
        get() {
            42
        }
    }
}

main(): Unit {
    // 获取 TestClassB 类型信息
    let classInfo = ClassTypeInfo.get("default.TestClassB")
    
    // 获取实例成员属性信息
    let propertyInfo = classInfo.getInstanceProperty("myProperty")
    
    // 查找 CustomAnnotationA 注解
    let myAnnotation = propertyInfo.findAnnotation<CustomAnnotationA>()
    
    match (myAnnotation) {
        case Some(_) => println("找到了 CustomAnnotationA 注解")
        case None => println("未找到 CustomAnnotationA 注解")
    }
    
    // 尝试查找不存在的注解
    let anotherAnnotation = propertyInfo.findAnnotation<CustomAnnotationB>()
    
    match (anotherAnnotation) {
        case Some(_) => println("找到了 CustomAnnotationB 注解")
        case None => println("未找到 CustomAnnotationB 注解")
    }
    
    return
}

@Annotation
public class CustomAnnotationA {
    public const init() {}
}

@Annotation
public class CustomAnnotationB {
    public const init() {}
}
```

运行结果：

```text
找到了 CustomAnnotationA 注解
未找到 CustomAnnotationB 注解
```

### func getAllAnnotations()

```cangjie
public func getAllAnnotations(): Array<Annotation>
```

功能：获取作用于该对象的所有自定义注解。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Annotation](./reflect_package_types.md#type-annotation--object)> - 作用于该对象的所有注解。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class TestClassC {
    @CustomAnnotationA
    @CustomAnnotationB
    public prop myProperty: Int64 {
        get() {
            42
        }
    }
}

main(): Unit {
    // 获取 TestClassC 类型信息
    let classInfo = ClassTypeInfo.get("default.TestClassC")
    
    // 获取实例成员属性信息
    let propertyInfo = classInfo.getInstanceProperty("myProperty")
    
    // 获取所有注解
    let allAnnotations = propertyInfo.getAllAnnotations()
    println("注解总数: ${allAnnotations.size}")
    
    return
}

@Annotation
public class CustomAnnotationA {
    public const init() {}
}

@Annotation
public class CustomAnnotationB {
    public const init() {}
}
```

运行结果：

```text
注解总数: 2
```

### func getValue(Any)

```cangjie
public func getValue(instance: Any): Any
```

功能：获取该 [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo) 对应的实例成员属性在给定实例中的值。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- instance: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 实例。

返回值：

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 该实例成员属性在实例 `instance` 中的值。

异常：

- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - 如果实例 `instance` 的运行时类型与该实例成员属性信息所对应的实例成员属性所属的类型不严格相同，则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class Rectangular {
    public var length = 4
    public prop width: Int64 {
        get() {
            5
        }
    }
}

main(): Unit {
    // 此处是通过 Rectangular 的类型的限定名称获取 ClassTypeInfo，也可以通过实例获取 ClassTypeInfo
    let ty = ClassTypeInfo.get("default.Rectangular")
    // 获取 InstancePropertyInfo
    var gip = ty.getInstanceProperty("width")

    // 获取实例值
    var r = Rectangular()
    var result = gip.getValue(r) as Int64
    println(result)
    return
}
```

运行结果：

```text
Some(5)
```

### func hashCode()

```cangjie
public func hashCode(): Int64
```

功能：获取该实例成员属性信息的哈希值。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 该实例成员属性信息的哈希值。

示例：

<!-- run -->
```cangjie
import std.reflect.*

public class MyTestClass {
    public prop myProperty: Int64 {
        get() {
            42
        }
    }
}

main(): Unit {
    // 获取 MyTestClass 类型信息
    let classInfo = ClassTypeInfo.get("default.MyTestClass")
    
    // 获取实例成员属性信息
    let propertyInfo = classInfo.getInstanceProperty("myProperty")
    
    // 获取哈希值
    let hashCode = propertyInfo.hashCode()
    println("哈希值: ${hashCode}")
    
    return
}
```

可能的运行结果：

```text
哈希值: 94842408817472
```

### func isAbstract()

```cangjie
public func isAbstract(): Bool
```

功能：判断该 [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo) 对应的实例成员属性是否是抽象的。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该 [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo) 对应的实例成员属性是抽象的，则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public abstract class TestClassD {
    public prop property1: Int64 {
        get() {
            42
        }
    }
    public prop property2: Int64
}

main(): Unit {
    // 获取 TestClassD 类型信息
    let classInfo = ClassTypeInfo.get("default.TestClassD")
    
    // 获取属性信息
    let prop1 = classInfo.getInstanceProperty("property1")
    let prop2 = classInfo.getInstanceProperty("property2")
    
    // 检查是否为抽象属性
    let isAbstract1 = prop1.isAbstract()
    let isAbstract2 = prop2.isAbstract()
    
    println("property1 是否为抽象属性: ${isAbstract1}")
    println("property2 是否为抽象属性: ${isAbstract2}")
    
    return
}
```

运行结果：

```text
property1 是否为抽象属性: false
property2 是否为抽象属性: true
```

### func isMutable()

```cangjie
public func isMutable(): Bool
```

功能：判断该 [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo) 对应的实例成员属性是否可修改。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果实例成员属性被 `mut` 修饰符所修饰，则该实例成员属性可被修改，否则不可被修改。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该实例成员属性信息所对应的实例成员属性可被修改则返回 `true` ，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class TestClassE {
    public prop myProperty1: Int64 {
        get() {
            42
        }
    }
    public mut prop myProperty2: Int64 {
        get() {
            42
        }
        set(v) {}
    }
}

main(): Unit {
    // 获取 TestClassE 类型信息
    let classInfo = ClassTypeInfo.get("default.TestClassE")

    // 获取属性信息
    let myProp1 = classInfo.getInstanceProperty("myProperty1")
    let myProp2 = classInfo.getInstanceProperty("myProperty2")

    // 检查是否可修改
    let isMutable1 = myProp1.isMutable()
    let isMutable2 = myProp2.isMutable()

    println("myProperty1 是否可修改: ${isMutable1}")
    println("myProperty2 是否可修改: ${isMutable2}")

    return
}
```

运行结果：

```text
myProperty1 是否可修改: false
myProperty2 是否可修改: true
```

### func isOpen()

```cangjie
public func isOpen(): Bool
```

功能：判断该 [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo) 对应的实例成员属性是否拥有 `open` 语义。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该 [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo) 对应的实例成员属性拥有 `open` 语义则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public open class TestClassF {
    public prop property1: Int64 {
        get() {
            42
        }
    }
    
    public open prop property2: Int64 {
        get() {
            42
        }
    }
}

main(): Unit {
    // 获取 TestClassF 类型信息
    let classInfo = ClassTypeInfo.get("default.TestClassF")
    
    // 获取属性信息
    let prop1 = classInfo.getInstanceProperty("property1")
    let prop2 = classInfo.getInstanceProperty("property2")
    
    // 检查是否为开放属性
    let isOpen1 = prop1.isOpen()
    let isOpen2 = prop2.isOpen()
    
    println("property1 是否为开放属性: ${isOpen1}")
    println("property2 是否为开放属性: ${isOpen2}")
    
    return
}
```

运行结果：

```text
property1 是否为开放属性: false
property2 是否为开放属性: true
```

### func setValue(Any, Any)

```cangjie
public func setValue(instance: Any, newValue: Any): Unit
```

功能：设置该 [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo) 对应的实例成员属性在给定实例中的值。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- instance: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 实例。
- newValue: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 新值。

异常：

- [IllegalSetException](reflect_package_exceptions.md#class-illegalsetexception) - 如果该实例成员属性信息所对应的实例成员属性不可修改，则抛出异常。
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - 如果实例 `instance` 的运行时类型与该实例成员属性信息所对应的实例成员属性所属的类型不严格相同，则抛出异常。
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - 如果新值 `newValue` 的运行时类型不是该实例成员属性信息所对应的实例成员属性的声明类型的子类型，则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class TestClassG {
    private var _myProperty: Int64 = 0
    public mut prop myProperty: Int64 {
        get() {
            _myProperty
        }
        set(v) {
            _myProperty = v
        }
    }
}

main(): Unit {
    // 创建实例
    let instance = TestClassG()
    
    // 获取 TestClassG 类型信息
    let classInfo = ClassTypeInfo.get("default.TestClassG")
    
    // 获取实例成员属性信息
    let propertyInfo = classInfo.getInstanceProperty("myProperty")
    
    // 设置新值
    propertyInfo.setValue(instance, 100)
    
    // 验证值是否设置成功
    let currentValue = propertyInfo.getValue(instance) as Int64
    println("当前值: ${currentValue}")
    
    return
}
```

运行结果：

```text
当前值: Some(100)
```

### func toString()

```cangjie
public func toString(): String
```

功能：获取字符串形式的该实例成员属性信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 字符串形式的该实例成员属性信息。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class TestClassH {
    public prop myProperty: Int64 {
        get() {
            42
        }
    }
}

main(): Unit {
    // 获取 TestClassH 类型信息
    let classInfo = ClassTypeInfo.get("default.TestClassH")
    
    // 获取实例成员属性信息
    let propertyInfo = classInfo.getInstanceProperty("myProperty")
    
    // 获取字符串表示
    let str = propertyInfo.toString()
    println("字符串表示: ${str}")
    
    return
}
```

运行结果：

```text
字符串表示: prop myProperty: Int64
```

### operator func !=(InstancePropertyInfo)

```cangjie
public operator func !=(that: InstancePropertyInfo): Bool
```

功能：判断该实例成员属性信息与给定的另一个实例成员属性信息是否不等。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- that: [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo) - 被比较相等性的另一个实例成员属性信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该实例成员属性信息与 `that` 不等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class TestClassI {
    public prop property1: Int64 {
        get() {
            42
        }
    }
    
    public prop property2: Int64 {
        get() {
            42
        }
    }
}

main(): Unit {
    // 获取 TestClassI 类型信息
    let classInfo = ClassTypeInfo.get("default.TestClassI")
    
    // 获取实例成员属性信息
    let prop1 = classInfo.getInstanceProperty("property1")
    let prop2 = classInfo.getInstanceProperty("property2")
    
    // 比较两个不同的属性信息
    let result1 = prop1 != prop2
    println("两个不同的属性信息不相等: ${result1}")
    
    // 比较相同的属性信息
    let result2 = prop1 != prop1
    println("相同的属性信息不相等: ${result2}")
    
    return
}
```

运行结果：

```text
两个不同的属性信息不相等: true
相同的属性信息不相等: false
```

### operator func ==(InstancePropertyInfo)

```cangjie
public operator func ==(that: InstancePropertyInfo): Bool
```

功能：判断该实例成员属性信息与给定的另一个实例成员属性信息是否相等。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- that: [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo) - 被比较相等性的另一个实例成员属性信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该实例成员属性信息与 `that` 相等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class TestClassJ {
    public prop property1: Int64 {
        get() {
            42
        }
    }
    
    public prop property2: Int64 {
        get() {
            42
        }
    }
}

main(): Unit {
    // 获取 TestClassJ 类型信息
    let classInfo = ClassTypeInfo.get("default.TestClassJ")
    
    // 获取实例成员属性信息
    let prop1 = classInfo.getInstanceProperty("property1")
    let prop2 = classInfo.getInstanceProperty("property2")
    
    // 比较两个不同的属性信息
    let result1 = prop1 == prop2
    println("两个不同的属性信息相等: ${result1}")
    
    // 比较相同的属性信息
    let result2 = prop1 == prop1
    println("相同的属性信息相等: ${result2}")
    
    return
}
```

运行结果：

```text
两个不同的属性信息相等: false
相同的属性信息相等: true
```

## class InstanceVariableInfo

```cangjie
public class InstanceVariableInfo <: Equatable<InstanceVariableInfo> & Hashable & ToString
```

功能：描述实例成员变量信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

父类型：

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[InstanceVariableInfo](#class-instancevariableinfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop annotations

```cangjie
public prop annotations: Collection<Annotation>
```

功能：获取所有作用于该 [InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo) 对应的实例成员变量的自定义注解，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果无任何注解作用于该实例成员变量信息所对应的实例成员变量，则返回空集合。
> - 该集合不保证遍历顺序恒定。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[Annotation](./reflect_package_types.md#type-annotation--object)>

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class MyClass {
    @MyCustomAnnotation
    public var myVariable: Int64 = 42
}

main(): Unit {
    // 获取 MyClass 类型信息
    let classInfo = ClassTypeInfo.get("default.MyClass")
    
    // 获取实例成员变量信息
    let variableInfo = classInfo.getInstanceVariable("myVariable")
    
    // 获取注解信息
    let annotations = variableInfo.annotations
    println("注解数量: ${annotations.size}")
    
    return
}

@Annotation
public class MyCustomAnnotation {
    public const init() {}
}
```

运行结果：

```text
注解数量: 1
```

### prop modifiers

```cangjie
public prop modifiers: Collection<ModifierInfo>
```

功能：获取该 [InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo) 对应的实例成员变量所拥有的所有修饰符的信息，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果该实例成员变量无任何修饰符，则返回空集合。
> - 该集合不保证遍历顺序恒定。
> - 即便未被某修饰符修饰，如果拥有该修饰符的语义，该修饰符信息也将被包括在该集合中。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[ModifierInfo](reflect_package_enums.md#enum-modifierinfo)>

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class MyClass {
    public var myVariable: Int64 = 42
}

main(): Unit {
    // 获取 MyClass 类型信息
    let classInfo = ClassTypeInfo.get("default.MyClass")
    
    // 获取实例成员变量信息
    let variableInfo = classInfo.getInstanceVariable("myVariable")
    
    // 获取修饰符信息
    let modifiers = variableInfo.modifiers
    println("修饰符数量: ${modifiers.size}")
    
    return
}
```

运行结果：

```text
修饰符数量: 0
```

### prop name

```cangjie
public prop name: String
```

功能：获取该 [InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo) 对应的实例成员变量的名称。

> **注意：**
>
> 不支持平台：macOS、iOS。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class MyClass {
    public var myVariable: Int64 = 42
}

main(): Unit {
    // 获取 MyClass 类型信息
    let classInfo = ClassTypeInfo.get("default.MyClass")
    
    // 获取实例成员变量信息
    let variableInfo = classInfo.getInstanceVariable("myVariable")
    
    // 获取变量名称
    let name = variableInfo.name
    println("变量名称: ${name}")
    
    return
}
```

运行结果：

```text
变量名称: myVariable
```

### prop typeInfo

```cangjie
public prop typeInfo: TypeInfo
```

功能：获取该 [InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo) 对应的实例成员变量的声明类型的类型信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

类型：[TypeInfo](reflect_package_classes.md#class-typeinfo)

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class MyClass {
    public var myVariable: Int64 = 42
}

main(): Unit {
    // 获取 MyClass 类型信息
    let classInfo = ClassTypeInfo.get("default.MyClass")
    
    // 获取实例成员变量信息
    let variableInfo = classInfo.getInstanceVariable("myVariable")
    
    // 获取类型信息
    let typeInfo = variableInfo.typeInfo
    println("变量类型: ${typeInfo.name}")
    
    return
}
```

运行结果：

```text
变量类型: Int64
```

### func findAllAnnotations\<T>() where T <: Annotation

```cangjie
public func findAllAnnotations<T>(): Array<T> where T <: Annotation
```

功能：获取所有指定注解名称的自定义注解（通过泛型筛选）。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - 若无指定T类型的注解时，返回空数组；若有相关注解时，将所有该类型注解对象构成的数组返回。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class TestClassA {
    @CustomAnnotationA
    @CustomAnnotationB
    public var myVariable: Int64 = 42
}

main(): Unit {
    // 获取 TestClassA 类型信息
    let classInfo = ClassTypeInfo.get("default.TestClassA")
    
    // 获取实例成员变量信息
    let variableInfo = classInfo.getInstanceVariable("myVariable")
    
    // 查找所有 CustomAnnotationA 注解
    let annotationsA = variableInfo.findAllAnnotations<CustomAnnotationA>()
    println("CustomAnnotationA 注解数量: ${annotationsA.size}")
    
    // 查找所有 CustomAnnotationB 注解
    let annotationsB = variableInfo.findAllAnnotations<CustomAnnotationB>()
    println("CustomAnnotationB 注解数量: ${annotationsB.size}")
    
    return
}

@Annotation
public class CustomAnnotationA {
    public const init() {}
}

@Annotation
public class CustomAnnotationB {
    public const init() {}
}
```

运行结果：

```text
CustomAnnotationA 注解数量: 1
CustomAnnotationB 注解数量: 1
```

### func findAnnotation\<T>() where T <: Annotation

```cangjie
public func findAnnotation<T>(): ?T where T <: Annotation
```

功能：尝试获取指定注解名称的自定义注解（通过泛型筛选）。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- ?T - 如果成功匹配则返回该注解，重复标注或者无法匹配时返回 `None`。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class TestClassB {
    @AnnotationX
    public var myVariable: Int64 = 42
}

main(): Unit {
    // 获取 TestClassB 类型信息
    let classInfo = ClassTypeInfo.get("default.TestClassB")
    
    // 获取实例成员变量信息
    let variableInfo = classInfo.getInstanceVariable("myVariable")
    
    // 查找 AnnotationX 注解
    let annotationX = variableInfo.findAnnotation<AnnotationX>()
    
    match (annotationX) {
        case Some(_) => println("找到了 AnnotationX 注解")
        case None => println("未找到 AnnotationX 注解")
    }
    
    // 尝试查找不存在的注解
    let annotationY = variableInfo.findAnnotation<AnnotationY>()
    
    match (annotationY) {
        case Some(_) => println("找到了 AnnotationY 注解")
        case None => println("未找到 AnnotationY 注解")
    }
    
    return
}

@Annotation
public class AnnotationX {
    public const init() {}
}

@Annotation
public class AnnotationY {
    public const init() {}
}
```

运行结果：

```text
找到了 AnnotationX 注解
未找到 AnnotationY 注解
```

### func getAllAnnotations()

```cangjie
public func getAllAnnotations(): Array<Annotation>
```

功能：获取作用于该对象的所有自定义注解。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Annotation](./reflect_package_types.md#type-annotation--object)> - 作用于该对象的所有注解。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class TestClassC {
    @AnnotationX
    @AnnotationY
    public var myVariable: Int64 = 42
}

main(): Unit {
    // 获取 TestClassC 类型信息
    let classInfo = ClassTypeInfo.get("default.TestClassC")
    
    // 获取实例成员变量信息
    let variableInfo = classInfo.getInstanceVariable("myVariable")
    
    // 获取所有注解
    let allAnnotations = variableInfo.getAllAnnotations()
    println("注解总数: ${allAnnotations.size}")
    
    return
}

@Annotation
public class AnnotationX {
    public const init() {}
}

@Annotation
public class AnnotationY {
    public const init() {}
}
```

运行结果：

```text
注解总数: 2
```

### func getValue(Any)

```cangjie
public func getValue(instance: Any): Any
```

功能：获取该 [InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo) 对应的实例成员变量在给定实例中的值。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- instance: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 实例。

返回值：

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 该实例成员变量在实例 `instance` 中的值。

异常：

- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - 如果实例 `instance` 的运行时类型与该实例成员变量信息所对应的实例成员变量所属的类型不严格相同，则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class TestClassGetValue {
    public var myVariable: Int64 = 42
    public let immutableVar: String = "Hello"
}

main(): Unit {
    // 创建实例
    let instance = TestClassGetValue()
    
    // 获取 TestClassGetValue 类型信息
    let classInfo = ClassTypeInfo.get("default.TestClassGetValue")
    
    // 获取实例成员变量信息
    let variableInfo = classInfo.getInstanceVariable("myVariable")
    let immutableVarInfo = classInfo.getInstanceVariable("immutableVar")
    
    // 获取变量值
    let value = variableInfo.getValue(instance) as Int64
    let immutableValue = immutableVarInfo.getValue(instance) as String
    
    println("myVariable 的值: ${value}")
    println("immutableVar 的值: ${immutableValue}")
    
    return
}
```

运行结果：

```text
myVariable 的值: Some(42)
immutableVar 的值: Some(Hello)
```

### func hashCode()

```cangjie
public func hashCode(): Int64
```

功能：获取该实例成员变量信息的哈希值。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 该实例成员变量信息的哈希值。

示例：

<!-- run -->
```cangjie
import std.reflect.*

public class TestClassD {
    public var myVariable: Int64 = 42
}

main(): Unit {
    // 获取 TestClassD 类型信息
    let classInfo = ClassTypeInfo.get("default.TestClassD")
    
    // 获取实例成员变量信息
    let variableInfo = classInfo.getInstanceVariable("myVariable")
    
    // 获取哈希值
    let hashCode = variableInfo.hashCode()
    println("哈希值: ${hashCode}")
    
    return
}
```

可能的运行结果：

```text
哈希值: 94484935947016
```

### func isMutable()

```cangjie
public func isMutable(): Bool
```

功能：判断该 [InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo) 对应的实例成员变量是否可修改。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果实例成员变量被 `var` 修饰符所修饰，则该实例成员变量可被修改。
> - 如果实例成员变量被 `let` 修饰符所修饰，则该实例成员变量不可被修改。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该实例成员变量信息所对应的实例成员变量可被修改则返回 `true` ，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class TestClassE {
    public var mutableVariable: Int64 = 42
    public let immutableVariable: Int64 = 42
}

main(): Unit {
    // 获取 TestClassE 类型信息
    let classInfo = ClassTypeInfo.get("default.TestClassE")
    
    // 获取变量信息
    let mutableVar = classInfo.getInstanceVariable("mutableVariable")
    let immutableVar = classInfo.getInstanceVariable("immutableVariable")
    
    // 检查是否可修改
    let isMutable1 = mutableVar.isMutable()
    let isMutable2 = immutableVar.isMutable()
    
    println("mutableVariable 是否可修改: ${isMutable1}")
    println("immutableVariable 是否可修改: ${isMutable2}")
    
    return
}
```

运行结果：

```text
mutableVariable 是否可修改: true
immutableVariable 是否可修改: false
```

### func setValue(Any, Any)

```cangjie
public func setValue(instance: Any, newValue: Any): Unit
```

功能：设置该 [InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo) 对应的实例成员变量在给定实例中的值。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- instance: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 实例。
- newValue: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 新值。

异常：

- [IllegalSetException](reflect_package_exceptions.md#class-illegalsetexception) - 如果该实例成员变量信息所对应的实例成员变量不可修改，则抛出异常。
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - 如果实例 `instance` 的运行时类型与该实例成员变量信息所对应的实例成员变量所属的类型不严格相同，则抛出异常。
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - 如果新值 `newValue` 的运行时类型不是该实例成员变量信息所对应的实例成员变量的声明类型的子类型，则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class TestClassF {
    public var myVariable: Int64 = 42
}

main(): Unit {
    // 创建实例
    let instance = TestClassF()
    
    // 获取 TestClassF 类型信息
    let classInfo = ClassTypeInfo.get("default.TestClassF")
    
    // 获取实例成员变量信息
    let variableInfo = classInfo.getInstanceVariable("myVariable")
    
    // 设置新值
    variableInfo.setValue(instance, 100)
    
    // 验证值是否设置成功
    let currentValue = variableInfo.getValue(instance) as Int64
    println("当前值: ${currentValue}")
    
    return
}
```

运行结果：

```text
当前值: Some(100)
```

### func toString()

```cangjie
public func toString(): String
```

功能：获取字符串形式的该实例成员变量信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 字符串形式的该实例成员变量信息。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class TestClassG {
    public var myVariable: Int64 = 42
}

main(): Unit {
    // 获取 TestClassG 类型信息
    let classInfo = ClassTypeInfo.get("default.TestClassG")
    
    // 获取实例成员变量信息
    let variableInfo = classInfo.getInstanceVariable("myVariable")
    
    // 获取字符串表示
    let str = variableInfo.toString()
    println("字符串表示: ${str}")
    
    return
}
```

运行结果：

```text
字符串表示: myVariable: Int64
```

### operator func !=(InstanceVariableInfo)

```cangjie
public operator func !=(that: InstanceVariableInfo): Bool
```

功能：判断该实例成员变量信息与给定的另一个实例成员变量信息是否不等。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- that: [InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo) - 被比较相等性的另一个实例成员变量信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该实例成员变量信息与 `that` 不等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class TestClassH {
    public var variable1: Int64 = 42
    public var variable2: Int64 = 42
}

main(): Unit {
    // 获取 TestClassH 类型信息
    let classInfo = ClassTypeInfo.get("default.TestClassH")
    
    // 获取实例成员变量信息
    let var1 = classInfo.getInstanceVariable("variable1")
    let var2 = classInfo.getInstanceVariable("variable2")
    
    // 比较两个不同的变量信息
    let result1 = var1 != var2
    println("两个不同的变量信息不相等: ${result1}")
    
    // 比较相同的变量信息
    let result2 = var1 != var1
    println("相同的变量信息不相等: ${result2}")
    
    return
}
```

运行结果：

```text
两个不同的变量信息不相等: true
相同的变量信息不相等: false
```

### operator func ==(InstanceVariableInfo)

```cangjie
public operator func ==(that: InstanceVariableInfo): Bool
```

功能：判断该实例成员变量信息与给定的另一个实例成员变量信息是否相等。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- that: [InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo) - 被比较相等性的另一个实例成员变量信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该实例成员变量信息与 `that` 相等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class TestClassI {
    public var variable1: Int64 = 42
    public var variable2: Int64 = 42
}

main(): Unit {
    // 获取 TestClassI 类型信息
    let classInfo = ClassTypeInfo.get("default.TestClassI")
    
    // 获取实例成员变量信息
    let var1 = classInfo.getInstanceVariable("variable1")
    let var2 = classInfo.getInstanceVariable("variable2")
    
    // 比较两个不同的变量信息
    let result1 = var1 == var2
    println("两个不同的变量信息相等: ${result1}")
    
    // 比较相同的变量信息
    let result2 = var1 == var1
    println("相同的变量信息相等: ${result2}")
    
    return
}
```

运行结果：

```text
两个不同的变量信息相等: false
相同的变量信息相等: true
```

## class InterfaceTypeInfo

```cangjie
public class InterfaceTypeInfo <: TypeInfo
```

功能：`interface` 类型的类型信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

父类型：

- [TypeInfo](#class-typeinfo)

### prop sealedSubtypes

```cangjie
public prop sealedSubtypes: Collection<TypeInfo>
```

功能：如果该 [InterfaceTypeInfo](reflect_package_classes.md#class-interfacetypeinfo) 所对应的 `interface` 类型拥有 `sealed` 语义，则获取该 `interface` 类型所在包内的所有子类型的类型信息，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果该 `interface` 类型不拥有 `sealed` 语义，则返回空集合。
> - 如果该 `interface` 类型拥有 `sealed` 语义，那么获得的集合必不可能是空集合，因为该 `interface` 类型本身就是自己的子类型。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[TypeInfo](reflect_package_classes.md#class-typeinfo)>

示例：

<!-- verify -->
```cangjie
import std.reflect.*

// 创建一个sealed接口
public sealed interface Shape {}

// 创建实现该接口的类
public class Circle <: Shape {
    public var radius: Int64 = 5
}

public class Square <: Shape {
    public var side: Int64 = 4
}

main(): Unit {
    // 获取接口类型信息
    let shapeType = InterfaceTypeInfo.get("default.Shape")
    
    // 获取sealed子类型信息
    let subtypes = shapeType.sealedSubtypes
    println("sealed子类型数量: ${subtypes.size}")
    
    // 遍历并打印所有sealed子类型
    for (subtype in subtypes) {
        println("子类型: ${subtype.name}")
    }
    
    return
}
```

运行结果：

```text
sealed子类型数量: 3
子类型: Shape
子类型: Circle
子类型: Square
```
### static func get(String)

```cangjie
public redef static func get(qualifiedName: String): InterfaceTypeInfo
```

功能：获取给定 `qualifiedName` 所对应的类型的 [InterfaceTypeInfo](reflect_package_classes.md#class-interfacetypeinfo)。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- qualifiedName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 类型的限定名称。

返回值：

- [InterfaceTypeInfo](reflect_package_classes.md#class-interfacetypeinfo) - 类型的限定名称 `qualifiedName` 所对应的 `Interface` 类型的类型信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果无法获取与给定类型的限定名称 `qualifiedName` 匹配的类型所对应的类型信息，则抛出异常。
- [IllegalTypeException](./reflect_package_exceptions.md#class-illegaltypeexception) - 如果获取到的类型信息不是 [InterfaceTypeInfo](reflect_package_classes.md#class-interfacetypeinfo)， 则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public interface Rectangular {}

main(): Unit {
    let ty = InterfaceTypeInfo.get("default.Rectangular")
    println(ty)
    return
}
```

运行结果：

```text
default.Rectangular
```

### static func of(Any)

```cangjie
public redef static func of(a: Any): InterfaceTypeInfo
```

功能：获取给定的任意类型实例的运行时类型所对应的类型信息。

运行时类型是指在程序运行时，通过动态绑定确定的类型，运行时类型与实例对象相绑定。在继承等场景下运行时类型和静态类型可能不一致。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- a: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 任意类型的实例。

返回值：

- [InterfaceTypeInfo](reflect_package_classes.md#class-interfacetypeinfo) - 实例 `a` 的运行时类型所对应的类型信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果无法获得实例 `a` 的运行时类型所对应的类型信息，则抛出异常。
- [IllegalTypeException](./reflect_package_exceptions.md#class-illegaltypeexception) - 如果获取到的类型信息不是 [InterfaceTypeInfo](reflect_package_classes.md#class-interfacetypeinfo)， 则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public open class Drawable {}

public class Point <: Drawable {
    public var x: Int64 = 0
    public var y: Int64 = 0
}

main(): Unit {
    // 创建实例
    let point: Drawable = Point()
    
    // 获取实例的运行时类型信息
    let runtimeType = InterfaceTypeInfo.of(point)
    println("运行时类型: ${runtimeType.name}")
    
    return
}
```

运行结果：

```text
运行时类型: Point
```

### static func of\<T>()

```cangjie
public redef static func of<T>(): InterfaceTypeInfo
```

功能：获取给定 `T` 类型对应的类型信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [InterfaceTypeInfo](reflect_package_classes.md#class-interfacetypeinfo) - `T` 类型对应的类型信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果无法获得类型 T 所对应的类型信息，抛出异常。
- [IllegalTypeException](./reflect_package_exceptions.md#class-illegaltypeexception) - 如果获取到的类型信息不是 [InterfaceTypeInfo](reflect_package_classes.md#class-interfacetypeinfo)， 则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public interface Drawable {}

main(): Unit {
    // 通过泛型获取接口类型信息
    let drawableType = InterfaceTypeInfo.of<Drawable>()
    println("Drawable接口的类型信息: ${drawableType.name}")
    
    return
}
```

运行结果：

```text
Drawable接口的类型信息: Drawable
```

### func isSealed()

```cangjie
public func isSealed(): Bool
```

功能：判断该 [InterfaceTypeInfo](reflect_package_classes.md#class-interfacetypeinfo) 所对应的 `interface` 类型是否拥有 `sealed` 语义。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该 `interface` 类型拥有 `sealed` 语义则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

// 创建一个sealed接口
public sealed interface Shape {}

main(): Unit {
    // 获取接口类型信息
    let shapeType = InterfaceTypeInfo.get("default.Shape")
    
    // 检查是否为sealed接口
    let isSealed = shapeType.isSealed()
    println("Shape接口是否为sealed: ${isSealed}")
    
    return
}
```

运行结果：

```text
Shape接口是否为sealed: true
```

## class PackageInfo

```cangjie
public class PackageInfo <: Equatable<PackageInfo> & Hashable & ToString
```

功能：描述包信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

父类型：

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[PackageInfo](#class-packageinfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop variables

```cangjie
public prop variables: Collection<GlobalVariableInfo>
```

功能：获取该 [PackageInfo](reflect_package_classes.md#class-packageinfo) 对应的包中所有 `public` 全局变量的信息所组成的列表。

> **注意：**
>
> 不支持平台：macOS、iOS。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[GlobalVariableInfo](reflect_package_classes.md#class-globalvariableinfo)>

示例：

<!-- verify -->
```cangjie
package abc.test

import std.reflect.*

// 定义一些公共全局变量用于演示
public var testVariable1: Int64 = 42
public var testVariable2: String = "Hello"

main(): Unit {
    // 获取当前包的信息
    let packageInfo = PackageInfo.get("abc.test")
    
    // 获取包中的全局变量信息
    let variables = packageInfo.variables
    println("全局变量数量: ${variables.size}")
    
    return
}
```

运行结果：

```text
全局变量数量: 2
```
### prop functions

```cangjie
public prop functions: Collection<GlobalFunctionInfo>
```

功能：获取该 [PackageInfo](reflect_package_classes.md#class-packageinfo) 对应的包中所有 `public` 全局函数的信息所组成的列表。

> **注意：**
>
> 不支持平台：macOS、iOS。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo)>

示例：

<!-- verify -->
```cangjie
package abc.test

import std.reflect.*

// 定义一些公共全局函数用于演示
public func testFunction1(): String {
    return "Hello from testFunction1"
}

public func testFunction2(x: Int64): Int64 {
    return x * 2
}

main(): Unit {
    // 获取当前包的信息
    let packageInfo = PackageInfo.get("abc.test")
    
    // 获取包中的全局函数信息
    let functions = packageInfo.functions
    println("全局函数数量: ${functions.size}")
    
    return
}
```

运行结果：

```text
全局函数数量: 2
```
### prop name

```cangjie
public prop name: String
```

功能：获取该包信息所对应的包的名称。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 包的名称不包含其所在的模块名称和其父包的名称，例如限定名称为 `a/b.c.d` 的包的名称是 `d` 。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
package abc.test

import std.reflect.*

main(): Unit {
    // 获取当前包的信息
    let packageInfo = PackageInfo.get("abc.test")
    
    // 获取包名称
    let name = packageInfo.name
    println("包名称: ${name}")
    
    return
}
```

运行结果：

```text
包名称: test
```

### prop organizationName

```cangjie
public prop organizationName: String
```

功能：获取该包信息所对应的包的组织名称。

> **注意：**
>
> 不支持平台：macOS、iOS。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
package abc.test

import std.reflect.*

main(): Unit {
    // 获取当前包的信息
    let packageInfo = PackageInfo.get("abc.test")
    
    // 获取包的组织名称
    let orgName = packageInfo.organizationName
    println("组织名称: '${orgName}'")
    
    return
}
```

运行结果：

```text
组织名称: ''
```

### prop parentPackage

```cangjie
public prop parentPackage: PackageInfo
```

功能：获取该 [PackageInfo](reflect_package_classes.md#class-packageinfo) 对应的父包的 [PackageInfo](reflect_package_classes.md#class-packageinfo)。

> **注意：**
>
> 不支持平台：macOS、iOS。

类型：[PackageInfo](reflect_package_classes.md#class-packageinfo)

示例：

<!-- verify -->
```cangjie
import std.reflect.*

main(): Unit {
    // 获取当前包的信息
    let packageInfo = PackageInfo.get("default")
    
    // 获取父包信息
    let parentPackage = packageInfo.parentPackage
    println("父包名称: ${parentPackage.name}")
    
    return
}
```

运行结果：

```text
父包名称: default
```

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果父包未被加载，则会抛出异常。

### prop qualifiedName

```cangjie
public prop qualifiedName: String
```

功能：获取该 [PackageInfo](reflect_package_classes.md#class-packageinfo) 对应的包的限定名称。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 包的限定名称的格式是 `(module_name/)?(default|package_name)(.package_name)*`，例如限定名称为 `a/b.c.d` 的包位于模块 `a` 下的 `b` 包里的 `c` 包里。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
package abc.test

import std.reflect.*

main(): Unit {
    // 获取当前包的信息
    let packageInfo = PackageInfo.get("abc.test")
    
    // 获取包限定名称
    let qualifiedName = packageInfo.qualifiedName
    println("包限定名称: ${qualifiedName}")
    
    return
}
```

运行结果：

```text
包限定名称: abc.test
```

### prop rootPackage

```cangjie
public prop rootPackage: PackageInfo
```

功能：获取该 [PackageInfo](reflect_package_classes.md#class-packageinfo) 对应的 `root` 包的 [PackageInfo](reflect_package_classes.md#class-packageinfo)。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果包本身就是 `root` 包，那么其 `rootPackage` 属性返回的是其本身。例如，限定名称为 `a.b.c` 的包，`rootPackage` 返回的是 `a`; 限定名称为 `a` 的包，`rootpackage` 返回的是 `a`。

类型：[PackageInfo](reflect_package_classes.md#class-packageinfo)

示例：

<!-- verify -->
```cangjie
import std.reflect.*

main(): Unit {
    // 获取当前包的信息
    let packageInfo = PackageInfo.get("default")
    
    // 获取根包信息
    let rootPackage = packageInfo.rootPackage
    println("根包名称: ${rootPackage.name}")
    
    return
}
```

运行结果：

```text
根包名称: default
```

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果 `root` 包未被加载，则会抛出异常。

### prop subPackages

```cangjie
public prop subPackages: Collection<PackageInfo>
```

功能：获取该 [PackageInfo](reflect_package_classes.md#class-packageinfo) 对应的所有子包的 [PackageInfo](reflect_package_classes.md#class-packageinfo) 集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 该属性只会返回已被加载的子包。
> - 不保证返回结果的顺序。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[PackageInfo](reflect_package_classes.md#class-packageinfo)>

示例：

<!-- verify -->
```cangjie
import std.reflect.*

main(): Unit {
    // 获取当前包的信息
    let packageInfo = PackageInfo.get("default")
    
    // 获取子包信息
    let subPackages = packageInfo.subPackages
    println("子包数量: ${subPackages.size}")
    
    return
}
```

运行结果：

```text
子包数量: 0
```
### prop typeInfos

```cangjie
public prop typeInfos: Collection<TypeInfo>
```

功能：获取该 [PackageInfo](reflect_package_classes.md#class-packageinfo) 对应的包中所有全局定义的 `public` 类型的类型信息，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 目前该列表不包含所有反射尚未支持的类型。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[TypeInfo](reflect_package_classes.md#class-typeinfo)>

示例：

<!-- verify -->
```cangjie
package abc.test

import std.reflect.*

public class A {}
public interface B {}
public struct C {}

main(): Unit {
    // 获取当前包的信息
    let packageInfo = PackageInfo.get("abc.test")
    
    // 获取类型信息
    let typeInfos = packageInfo.typeInfos
    println("类型数量: ${typeInfos.size}")
    
    return
}

```

运行结果：

```text
类型数量: 3
```
### prop version

```cangjie
public prop version: String
```

功能：获取该 [PackageInfo](reflect_package_classes.md#class-packageinfo) 对应的包的版本号。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 由于目前动态库中尚无版本信息，获取到的版本号总是空字符串。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.reflect.*

main(): Unit {
    // 获取当前包的信息
    let packageInfo = PackageInfo.get("default")
    
    // 获取版本信息
    let version = packageInfo.version
    println("版本: '${version}'")
    
    return
}
```

运行结果：

```text
版本: ''
```

### static func get(String)

```cangjie
public static func get(qualifiedName: String): PackageInfo
```

功能：获取给定 `qualifiedName` 所对应的 [PackageInfo](./reflect_package_classes.md#class-packageinfo)。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- qualifiedName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 类型的限定名称。

返回值：

- [PackageInfo](./reflect_package_classes.md#class-packageinfo) - 类型的限定名称 `qualifiedName` 所对应的包信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果无法获取与给定类型的限定名称 `qualifiedName` 所对应的类型信息，则抛出异常。

示例：

<!-- verify -->
```cangjie
package abc.test

import std.reflect.*

main(): Unit {
    // 获取当前包的信息
    let packageInfo = PackageInfo.get("abc.test")
    println("包名称: ${packageInfo.name}")
    println("包限定名称: ${packageInfo.qualifiedName}")
    
    return
}
```

运行结果：

```text
包名称: test
包限定名称: abc.test
```

### static func load(String)

```cangjie
public static func load(path: String): PackageInfo
```

功能：运行时动态加载指定路径下的一个仓颉动态库模块并获得该模块的信息。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 为了提升兼容性，路径 `path` 中的共享库文件名不需要后缀名（如 `.so` 和 `.dll` 等）。
> - 如果某个 `package` 通过静态加载方式（如：`import`）已经导入过，那么动态加载该 `package` 会抛出异常。

参数：

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 共享库文件的绝对路径或相对路径。

返回值：

- [PackageInfo](reflect_package_classes.md#class-packageinfo) - 指定仓颉动态库的包信息。

异常：

- [ReflectException](reflect_package_exceptions.md#class-reflectexception) - 如果共享库加载失败，则会抛出异常。
- [ReflectException](reflect_package_exceptions.md#class-reflectexception) - 如果具有相同包名称或相同文件名的共享库被重复加载，则会抛出异常。
- [ReflectException](reflect_package_exceptions.md#class-reflectexception) - 如果动态库内部存在多个Package，则抛出异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当路径不合法时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

main(): Unit {
    // 注意：load方法需要一个有效的动态库路径
    try {
        let packageInfo = PackageInfo.load("/path/to/library")
        println("加载的包名称: ${packageInfo.name}")
    } catch (e: IllegalArgumentException) {
        println("加载失败: ${e.message}")
    }
    
    println("这里仅展示使用方法")
    return
}
```

运行结果：

```text
加载失败: Failed to load `/path/to/library` because of illegal path.
这里仅展示使用方法
```

### func getFunction(String, Array\<TypeInfo>)

```cangjie
public func getFunction(name: String, parameterTypes: Array<TypeInfo>): GlobalFunctionInfo
```

功能：尝试在该 [PackageInfo](reflect_package_classes.md#class-packageinfo) 对应的包中获取拥有给定函数名称且与给定形参类型信息列表匹配的 `public` 全局函数的信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 全局函数的名称。
- parameterTypes: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[TypeInfo](reflect_package_classes.md#class-typeinfo)> - 形参类型信息列表。

返回值：

- [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo) - 如果成功匹配则返回该全局定义的 `public` 类型的函数信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果没找到对应全局定义的 `public` 全局函数，则抛出异常。

示例：

<!-- verify -->
```cangjie
package abc.test

import std.reflect.*

public func addNumbers(a: Int64, b: Int64): Int64 {
    return a + b
}

main(): Unit {
    // 获取当前包的信息
    let packageInfo = PackageInfo.get("abc.test")
    
    let intType: TypeInfo = PrimitiveTypeInfo.get("Int64")
    let paramTypes = [intType, intType]
    let functionInfo = packageInfo.getFunction("addNumbers", paramTypes)
    println("函数: ${functionInfo}")
    
    return
}
```

运行结果：

```text
函数: func addNumbers(Int64, Int64): Int64
```

### func getFunctions(String)

```cangjie
public func getFunctions(name: String): Array<GlobalFunctionInfo>
```

功能：尝试在该 [PackageInfo](reflect_package_classes.md#class-packageinfo) 对应的包中获取拥有给定函数名称的所有 `public` 全局函数的信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 全局函数的名称。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo)> - 拥有给定函数名称的所有 `public` 全局函数的信息数组。

示例：

<!-- verify -->
```cangjie
package abc.test

import std.reflect.*

// 定义一些同名但参数不同的函数用于演示
public func process(x: Int64): Int64 {
    return x * 2
}

public func process(x: String): String {
    return "Processed: ${x}"
}

main(): Unit {
    // 获取当前包的信息
    let packageInfo = PackageInfo.get("abc.test")
    
    // 获取所有名为process的函数
    let functions = packageInfo.getFunctions("process")
    println("名为process的函数数量: ${functions.size}")
    
    return
}
```

运行结果：

```text
名为process的函数数量: 2
```

### func getSubPackage(String)

```cangjie
public func getSubPackage(qualifiedName: String): PackageInfo
```

功能：尝试获取该 [PackageInfo](reflect_package_classes.md#class-packageinfo) 对应限定名称为 `qualifiedName` 的子包的信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- qualifiedName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 子包的限定名称。

返回值：

- [PackageInfo](reflect_package_classes.md#class-packageinfo) - 该子包的包信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果该子包不存在或者未加载，则会抛出异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果 `qualifiedName` 不符合规范，则抛出异常。

示例：

<!-- verify -->
```cangjie
package abc.parent

import std.reflect.*

main(): Unit {
    // 获取当前包的信息
    let packageInfo = PackageInfo.get("abc.parent")
    
    // 尝试获取子包（这里会抛出异常，因为我们没有创建子包）
    try {
        let subPackage = packageInfo.getSubPackage("child")
        println("子包名称: ${subPackage.name}")
    } catch (e: InfoNotFoundException) {
        println("子包未找到")
    }
    
    return
}
```

运行结果：

```text
子包未找到
```

### func getTypeInfo(String)

```cangjie
public func getTypeInfo(qualifiedTypeName: String): TypeInfo
```

功能：尝试在该 [PackageInfo](reflect_package_classes.md#class-packageinfo) 对应的包中获取拥有给定类型名称的全局定义的 `public` 类型的类型信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- qualifiedTypeName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 类型的限定名称

返回值：

- [TypeInfo](reflect_package_classes.md#class-typeinfo) - 如果成功匹配则返回该全局定义的 `public` 类型的类型信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果没找到对应全局定义的 `public` 类型，则抛出异常。

示例：

<!-- verify -->
```cangjie
package abc.test

import std.reflect.*

// 定义一个类用于演示
public class TestClass {
    public var value: Int64 = 0
}

main(): Unit {
    // 获取当前包的信息
    let packageInfo = PackageInfo.get("abc.test")
    
    // 获取类型信息
    let typeInfo = packageInfo.getTypeInfo("abc.test.TestClass")
    println("类型名称: ${typeInfo.name}")
    
    return
}
```

运行结果：

```text
类型名称: TestClass
```

### func getVariable(String)

```cangjie
public func getVariable(name: String): GlobalVariableInfo
```

功能：尝试在该 [PackageInfo](reflect_package_classes.md#class-packageinfo) 对应的包中获取拥有给定变量名称的 `public` 全局变量的信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 全局变量的名称。

返回值：

- [GlobalVariableInfo](reflect_package_classes.md#class-globalvariableinfo) - 如果成功匹配则返回该全局定义的 `public` 类型的变量信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果没找到对应全局定义的 `public` 全局变量，则抛出异常。

示例：

<!-- verify -->
```cangjie
package abc.test

import std.reflect.*

// 定义一些公共全局变量用于演示
public var testVariable: Int64 = 42

main(): Unit {
    // 获取当前包的信息
    let packageInfo = PackageInfo.get("abc.test")
    
    // 获取特定变量的信息
    let variableInfo = packageInfo.getVariable("testVariable")
    println("变量名称: ${variableInfo.name}")
    
    return
}
```

运行结果：

```text
变量名称: testVariable
```

### func hashCode()

```cangjie
public func hashCode(): Int64
```

功能：获取该包信息的哈希值。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 该包信息的哈希值。

示例：

<!-- run -->
```cangjie
import std.reflect.*

main(): Unit {
    // 获取当前包的信息
    let packageInfo = PackageInfo.get("default")
    
    // 获取包信息的哈希值
    let hashCode = packageInfo.hashCode()
    println("包信息的哈希值: ${hashCode}")
    
    return
}
```

可能的运行结果：

```text
包信息的哈希值: 94165683034880
```

### func toString()

```cangjie
public func toString(): String
```

功能：获取字符串形式的该包信息。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 内部实现为该包信息的限定名称字符串。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 字符串形式的该包信息。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

main(): Unit {
    // 获取当前包的信息
    let packageInfo = PackageInfo.get("default")
    
    // 获取包信息的字符串表示
    let str = packageInfo.toString()
    println("包信息的字符串表示: ${str}")
    
    return
}
```

运行结果：

```text
包信息的字符串表示: default
```

### operator func !=(PackageInfo)

```cangjie
public operator func !=(that: PackageInfo): Bool
```

功能：判断该包信息与给定的另一个包信息是否不等。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 内部实现为比较两个包信息的限定名称是否相等。

参数：

- that: [PackageInfo](reflect_package_classes.md#class-packageinfo) - 被比较相等性的另一个包信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该包信息与 `that` 不等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

main(): Unit {
    // 获取当前包的信息
    let packageInfo1 = PackageInfo.get("default")
    let packageInfo2 = PackageInfo.get("default")
    
    // 比较两个包信息是否不等
    let result = packageInfo1 != packageInfo2
    println("两个包信息不等: ${result}")
    
    return
}
```

运行结果：

```text
两个包信息不等: false
```

### operator func ==(PackageInfo)

```cangjie
public operator func ==(that: PackageInfo): Bool
```

功能：判断该包信息与给定的另一个包信息是否相等。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 内部实现为比较两个包信息的限定名称是否相等。

参数：

- that: [PackageInfo](reflect_package_classes.md#class-packageinfo) - 被比较相等性的另一个包信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该包信息与 `that` 相等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

main(): Unit {
    // 获取当前包的信息
    let packageInfo1 = PackageInfo.get("default")
    let packageInfo2 = PackageInfo.get("default")
    
    // 比较两个包信息是否相等
    let result = packageInfo1 == packageInfo2
    println("两个包信息相等: ${result}")
    
    return
}
```

运行结果：

```text
两个包信息相等: true
```

## class ParameterInfo

```cangjie
public class ParameterInfo <: Equatable<ParameterInfo> & Hashable & ToString
```

功能：描述函数形参信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

父类型：

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[ParameterInfo](#class-parameterinfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop annotations

```cangjie
public prop annotations: Collection<Annotation>
```

功能：获取所有作用于该 [ParameterInfo](reflect_package_classes.md#class-parameterinfo) 对应的函数形参的自定义注解，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果无任何注解作用于该函数形参信息所对应的函数形参，则返回空集合。
> - 该集合不保证遍历顺序恒定。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[Annotation](./reflect_package_types.md#type-annotation--object)>

示例：

<!-- verify -->
```cangjie
import std.reflect.*

// 定义一个注解用于演示
@Annotation
public class MyAnnotation {
    public const init() {}
}

// 定义一个带注解的函数用于演示
public func testFunction(@MyAnnotation param: Int64): Int64 {
    return param * 2
}

main(): Unit {
    // 获取函数信息
    let packageInfo = PackageInfo.get("default")
    let functions = packageInfo.getFunctions("testFunction")
    
    if (functions.size > 0) {
        let functionInfo = functions[0]
        let parameters = functionInfo.parameters
        
        if (parameters.size > 0) {
            let paramInfo = parameters[0]
            let annotations = paramInfo.annotations
            println("参数注解数量: ${annotations.size}")
        }
    }
    
    return
}
```

运行结果：

```text
参数注解数量: 1
```

### prop index

```cangjie
public prop index: Int64
```

功能：获知该 [ParameterInfo](reflect_package_classes.md#class-parameterinfo) 对应的形参是其所在函数的第几个形参。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - `index` 从0开始计数。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.reflect.*

// 定义一个带多个参数的函数用于演示
public func testFunction(first: Int64, second: String, third: Bool): Int64 {
    return first
}

main(): Unit {
    // 获取函数信息
    let packageInfo = PackageInfo.get("default")
    let functions = packageInfo.getFunctions("testFunction")
    
    if (functions.size > 0) {
        let functionInfo = functions[0]
        let parameters = functionInfo.parameters
        
        for (param in parameters) {
            println("参数名称: ${param.name}, 索引: ${param.index}")
        }
    }
    
    return
}
```

运行结果：

```text
参数名称: first, 索引: 0
参数名称: second, 索引: 1
参数名称: third, 索引: 2
```

### prop name

```cangjie
public prop name: String
```

功能：获取该 [ParameterInfo](reflect_package_classes.md#class-parameterinfo) 对应的形参的名称。

> **注意：**
>
> 不支持平台：macOS、iOS。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.reflect.*

// 定义一个带参数的函数用于演示
public func calculateSum(x: Int64, y: Int64): Int64 {
    return x + y
}

main(): Unit {
    // 获取函数信息
    let packageInfo = PackageInfo.get("default")
    let functions = packageInfo.getFunctions("calculateSum")
    
    if (functions.size > 0) {
        let functionInfo = functions[0]
        let parameters = functionInfo.parameters
        
        for (param in parameters) {
            println("参数名称: ${param.name}")
        }
    }
    
    return
}
```

运行结果：

```text
参数名称: x
参数名称: y
```

### prop typeInfo

```cangjie
public prop typeInfo: TypeInfo
```

功能：获取该 [ParameterInfo](reflect_package_classes.md#class-parameterinfo) 对应的函数形参的声明类型所对应的类型信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

类型：[TypeInfo](reflect_package_classes.md#class-typeinfo)

示例：

<!-- verify -->
```cangjie
import std.reflect.*

// 定义一个带不同类型的参数的函数用于演示
public func processData(count: Int64, name: String, isActive: Bool): Int64 {
    return count
}

main(): Unit {
    // 获取函数信息
    let packageInfo = PackageInfo.get("default")
    let functions = packageInfo.getFunctions("processData")
    
    if (functions.size > 0) {
        let functionInfo = functions[0]
        let parameters = functionInfo.parameters
        
        for (param in parameters) {
            println("参数名称: ${param.name}, 类型: ${param.typeInfo.name}")
        }
    }
    
    return
}
```

运行结果：

```text
参数名称: count, 类型: Int64
参数名称: name, 类型: String
参数名称: isActive, 类型: Bool
```

### func findAllAnnotations\<T>() where T <: Annotation

```cangjie
public func findAllAnnotations<T>(): Array<T> where T <: Annotation
```

功能：获取所有指定注解名称的自定义注解（通过泛型筛选）。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - 若无指定T类型的注解时，返回空数组；若有相关注解时，将所有该类型注解对象构成的数组返回。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

// 定义注解用于演示
@Annotation
public class FirstAnnotation {
    public const init() {}
}

@Annotation
public class SecondAnnotation {
    public const init() {}
}

// 定义一个带多个注解的函数参数用于演示
public func testFunction(@FirstAnnotation @SecondAnnotation value: Int64): Int64 {
    return value
}

main(): Unit {
    // 获取函数信息
    let packageInfo = PackageInfo.get("default")
    let functions = packageInfo.getFunctions("testFunction")
    
    if (functions.size > 0) {
        let functionInfo = functions[0]
        let parameters = functionInfo.parameters
        
        if (parameters.size > 0) {
            let paramInfo = parameters[0]
            let firstAnnotations = paramInfo.findAllAnnotations<FirstAnnotation>()
            let secondAnnotations = paramInfo.findAllAnnotations<SecondAnnotation>()
            
            println("FirstAnnotation注解数量: ${firstAnnotations.size}")
            println("SecondAnnotation注解数量: ${secondAnnotations.size}")
        }
    }
    
    return
}
```

运行结果：

```text
FirstAnnotation注解数量: 1
SecondAnnotation注解数量: 1
```

### func findAnnotation\<T>() where T <: Annotation

```cangjie
public func findAnnotation<T>(): ?T where T <: Annotation
```

功能：尝试获取指定注解名称的自定义注解（通过泛型筛选）。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- ?T - 如果成功匹配则返回该注解，重复标注或者无法匹配时返回 `None`。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

// 定义注解用于演示
@Annotation
public class MyAnnotation {
    public const init() {}
}

// 定义一个带注解的函数参数用于演示
public func testFunction(@MyAnnotation value: Int64): Int64 {
    return value
}

main(): Unit {
    // 获取函数信息
    let packageInfo = PackageInfo.get("default")
    let functions = packageInfo.getFunctions("testFunction")
    
    if (functions.size > 0) {
        let functionInfo = functions[0]
        let parameters = functionInfo.parameters
        
        if (parameters.size > 0) {
            let paramInfo = parameters[0]
            let annotation = paramInfo.findAnnotation<MyAnnotation>()
            
            match (annotation) {
                case Some(_) => println("找到了MyAnnotation注解")
                case None => println("未找到MyAnnotation注解")
            }
        }
    }
    
    return
}
```

运行结果：

```text
找到了MyAnnotation注解
```

### func getAllAnnotations()

```cangjie
public func getAllAnnotations(): Array<Annotation>
```

功能：获取作用于该对象的所有自定义注解。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Annotation](./reflect_package_types.md#type-annotation--object)> - 作用于该对象的所有注解。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

// 定义注解用于演示
@Annotation
public class FirstAnnotation {
    public const init() {}
}

@Annotation
public class SecondAnnotation {
    public const init() {}
}

// 定义一个带多个注解的函数参数用于演示
public func testFunction(@FirstAnnotation @SecondAnnotation value: Int64): Int64 {
    return value
}

main(): Unit {
    // 获取函数信息
    let packageInfo = PackageInfo.get("default")
    let functions = packageInfo.getFunctions("testFunction")
    
    if (functions.size > 0) {
        let functionInfo = functions[0]
        let parameters = functionInfo.parameters
        
        if (parameters.size > 0) {
            let paramInfo = parameters[0]
            let allAnnotations = paramInfo.getAllAnnotations()
            
            println("总注解数量: ${allAnnotations.size}")
            println("成功获取所有注解")
        }
    }
    
    return
}
```

运行结果：

```text
总注解数量: 2
成功获取所有注解
```

### func hashCode()

```cangjie
public func hashCode(): Int64
```

功能：获取该函数形参信息的哈希值。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 该函数形参信息的哈希值。

示例：

<!-- run -->
```cangjie
import std.reflect.*

// 定义一个函数用于演示
public func calculate(x: Int64): Int64 {
    return x * 2
}

main(): Unit {
    // 获取函数信息
    let packageInfo = PackageInfo.get("default")
    let functions = packageInfo.getFunctions("calculate")
    
    if (functions.size > 0) {
        let functionInfo = functions[0]
        let parameters = functionInfo.parameters
        
        if (parameters.size > 0) {
            let paramInfo = parameters[0]
            let hashCode = paramInfo.hashCode()
            
            println("参数信息的哈希值: ${hashCode}")
        }
    }
    
    return
}
```

可能的运行结果：

```text
参数信息的哈希值: 93836504484944
```

### func toString()

```cangjie
public func toString(): String
```

功能：获取字符串形式的该函数形参信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 字符串形式的该函数形参信息。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

// 定义一个函数用于演示
public func calculate(x: Int64): Int64 {
    return x * 2
}

main(): Unit {
    // 获取函数信息
    let packageInfo = PackageInfo.get("default")
    let functions = packageInfo.getFunctions("calculate")
    
    if (functions.size > 0) {
        let functionInfo = functions[0]
        let parameters = functionInfo.parameters
        
        if (parameters.size > 0) {
            let paramInfo = parameters[0]
            let str = paramInfo.toString()
            
            println("参数信息的字符串表示: ${str}")
        }
    }
    
    return
}
```

运行结果：

```text
参数信息的字符串表示: Int64
```

### operator func !=(ParameterInfo)

```cangjie
public operator func !=(that: ParameterInfo): Bool
```

功能：判断该函数形参信息与给定的另一个函数形参信息是否不等。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- that: [ParameterInfo](reflect_package_classes.md#class-parameterinfo) - 被比较相等性的另一个函数形参信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该函数形参信息与 `that` 不等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

// 定义一个函数用于演示
public func calculate(x: Int64, y: Int64): Int64 {
    return x + y
}

main(): Unit {
    // 获取函数信息
    let packageInfo = PackageInfo.get("default")
    let functions = packageInfo.getFunctions("calculate")
    
    if (functions.size > 0) {
        let functionInfo = functions[0]
        let parameters = functionInfo.parameters
        
        if (parameters.size >= 2) {
            let param1 = parameters[0]
            let param2 = parameters[1]
            let result = param1 != param2
            
            println("两个参数不等: ${result}")
        }
    }
    
    return
}
```

运行结果：

```text
两个参数不等: true
```

### operator func ==(ParameterInfo)

```cangjie
public operator func ==(that: ParameterInfo): Bool
```

功能：判断该函数形参信息与给定的另一个函数形参信息是否相等。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- that: [ParameterInfo](reflect_package_classes.md#class-parameterinfo) - 被比较相等性的另一个函数形参信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该函数形参信息与 `that` 相等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

// 定义一个函数用于演示
public func calculate(x: Int64): Int64 {
    return x * 2
}

main(): Unit {
    // 获取函数信息
    let packageInfo = PackageInfo.get("default")
    let functions = packageInfo.getFunctions("calculate")
    
    if (functions.size > 0) {
        let functionInfo = functions[0]
        let parameters = functionInfo.parameters
        
        if (parameters.size > 0) {
            let param1 = parameters[0]
            let param2 = parameters[0]
            let result = param1 == param2
            
            println("两个参数相等: ${result}")
        }
    }
    
    return
}
```

运行结果：

```text
两个参数相等: true
```

## class PrimitiveTypeInfo

```cangjie
public class PrimitiveTypeInfo <: TypeInfo
```

功能：描述原始数据类型的类型信息。

原始数据类型包括无类型（`Nothing`）、单元类型（[Unit](../../core/core_package_api/core_package_intrinsics.md#unit)）、字符类型（[Rune](../../../std/core/core_package_api/core_package_intrinsics.md#rune)）、布尔类型（[Bool](../../core/core_package_api/core_package_intrinsics.md#bool)），整形类型（[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)，[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)，[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)，[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)，[IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative)，[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)，[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)，[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)，[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)，[UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)）和浮点类型（[Float16](../../core/core_package_api/core_package_intrinsics.md#float16)，[Float32](../../core/core_package_api/core_package_intrinsics.md#float32)，[Float64](../../core/core_package_api/core_package_intrinsics.md#float64)）。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 目前尚不支持 `Nothing` 原始数据类型。

父类型：

- [TypeInfo](#class-typeinfo)

### static func get(String)

```cangjie
public static redef func get(qualifiedName: String): PrimitiveTypeInfo
```

功能：获取给定的类型的限定名称所对应类型的 [PrimitiveTypeInfo](reflect_package_classes.md#class-primitivetypeinfo)。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- qualifiedName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 类型的限定名称。

返回值：

- [PrimitiveTypeInfo](reflect_package_classes.md#class-primitivetypeinfo) - 类型的限定名称 `qualifiedName` 所对应的类型的类型信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果无法获取与给定类型的限定名称 `qualifiedName` 匹配的类型所对应的类型信息，则抛出异常。
- [IllegalTypeException](./reflect_package_exceptions.md#class-illegaltypeexception) - 如果获取到的类型信息不是 [PrimitiveTypeInfo](reflect_package_classes.md#class-primitivetypeinfo)， 则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

main(): Unit {
    var pti = PrimitiveTypeInfo.get("Int64")
    println(pti)
    return
}
```

运行结果：

```text
Int64
```

### static func of(Any)

```cangjie
public static redef func of(a: Any): PrimitiveTypeInfo
```

功能：获取给定的任意类型实例的运行时类型所对应的类型信息。

运行时类型是指在程序运行时，通过动态绑定确定的类型，运行时类型与实例对象相绑定。在继承等场景下运行时类型和静态类型可能不一致。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- a: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 任意类型的实例。

返回值：

- [PrimitiveTypeInfo](reflect_package_classes.md#class-primitivetypeinfo) - 实例 `a` 的运行时类型所对应的类型信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果无法获得实例 `a` 的运行时类型所对应的类型信息，则抛出异常。
- [IllegalTypeException](./reflect_package_exceptions.md#class-illegaltypeexception) - 如果获取到的类型信息不是 [PrimitiveTypeInfo](reflect_package_classes.md#class-primitivetypeinfo)， 则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

main(): Unit {
    var a = 10
    var pti = PrimitiveTypeInfo.of(a)
    println(pti)
    return
}
```

运行结果：

```text
Int64
```

### static func of\<T>()

```cangjie
public static redef func of<T>(): PrimitiveTypeInfo
```

功能：获取给定 `T` 类型对应的类型信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [PrimitiveTypeInfo](reflect_package_classes.md#class-primitivetypeinfo) - `T` 类型对应的类型信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果无法获得类型 T 所对应的类型信息，抛出异常。
- [IllegalTypeException](./reflect_package_exceptions.md#class-illegaltypeexception) - 如果获取到的类型信息不是 [PrimitiveTypeInfo](reflect_package_classes.md#class-primitivetypeinfo)， 则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

main(): Unit {
    var pti = PrimitiveTypeInfo.of<Int64>()
    println(pti)
    return
}
```

运行结果：

```text
Int64
```

## class StaticFunctionInfo

```cangjie
public class StaticFunctionInfo <: Equatable<StaticFunctionInfo> & Hashable & ToString
```

功能：描述静态成员函数信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

父类型：

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[StaticFunctionInfo](#class-staticfunctioninfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop annotations

```cangjie
public prop annotations: Collection<Annotation>
```

功能：获取所有作用于该 [StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo) 对应的静态成员函数的自定义注解，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果无任何注解作用于该 [StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo) 对应的静态成员函数，则返回空集合。
> - 该集合不保证遍历顺序恒定。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[Annotation](./reflect_package_types.md#type-annotation--object)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个注解用于演示
@Annotation
public class MyAnnotation {
    public const init() {}
}

// 定义一个带注解的类和静态函数用于演示
public class TestClass {
    @MyAnnotation
    public static func testFunction(): String {
        return "Hello from test function"
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态函数信息
    let staticFunctions = classInfo.staticFunctions
    for (staticFunction in staticFunctions) {
        let annotations = staticFunction.annotations
        println("静态函数注解数量: ${annotations.size}")
    }
    
    return
}
```

运行结果：

```text
静态函数注解数量: 1
```

### prop genericParams

```cangjie
public prop genericParams: Collection<GenericTypeInfo>
```

功能：获取该 [StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo) 对应的实例成员函数的泛型参数信息列表。

> **注意：**
>
> 不支持平台：macOS、iOS。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[GenericTypeInfo](reflect_package_classes.md#class-generictypeinfo)>

异常：

- [InfoNotFoundException](./reflect_package_exceptions.md#class-infonotfoundexception) - [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo) 没有泛型参数时抛出异常。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个带泛型参数的类和静态函数用于演示
public class TestClass {
    public static func genericFunction<T>(value: T): T {
        return value
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态函数信息
    let staticFunctions = classInfo.staticFunctions
    for (staticFunction in staticFunctions) {
        if (staticFunction.name == "genericFunction") {
            try {
                let genericParams = staticFunction.genericParams
                println("泛型参数数量: ${genericParams.size}")
            } catch (e: InfoNotFoundException) {
                println("该函数没有泛型参数")
            }
            break
        }
    }
    
    return
}
```

运行结果：

```text
泛型参数数量: 1
```

### prop modifiers

```cangjie
public prop modifiers: Collection<ModifierInfo>
```

功能：获取该 [StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo) 对应的静态成员函数所拥有的所有修饰符的信息，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果该静态成员函数无任何修饰符，则返回空集合。
> - 该集合不保证遍历顺序恒定。
> - 即便未被某修饰符修饰，如果拥有该修饰符的语义，该修饰符信息也将被包括在该集合中。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[ModifierInfo](reflect_package_enums.md#enum-modifierinfo)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个带修饰符的类和静态函数用于演示
public class TestClass {
    public static func publicFunction(): String {
        return "This is a public function"
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态函数信息
    let staticFunctions = classInfo.staticFunctions
    for (staticFunction in staticFunctions) {
        if (staticFunction.name == "publicFunction") {
            let modifiers = staticFunction.modifiers
            println("函数修饰符数量: ${modifiers.size}")
            break
        }
    }
    
    return
}
```

运行结果：

```text
函数修饰符数量: 1
```

### prop name

```cangjie
public prop name: String
```

功能：获取该 [StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo) 对应的静态成员函数的名称。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 构成重载的所有静态成员函数将拥有相同的名称。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个类和静态函数用于演示
public class TestClass {
    public static func calculateSum(x: Int64, y: Int64): Int64 {
        return x + y
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态函数信息
    let staticFunctions = classInfo.staticFunctions
    for (staticFunction in staticFunctions) {
        println("静态函数名称: ${staticFunction.name}")
    }
    
    return
}
```

运行结果：

```text
静态函数名称: calculateSum
```

### prop parameters

```cangjie
public prop parameters: ReadOnlyList<ParameterInfo>
```

功能：获取该 [StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo) 对应的静态成员函数的参数信息列表。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 不保证参数顺序，可根据 `ParameterInfo`的 `index` 属性确定参数实际位置。

类型：[ReadOnlyList](../../collection/collection_package_api/collection_package_interface.md#interface-readonlylistt)\<[ParameterInfo](reflect_package_classes.md#class-parameterinfo)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个带参数的类和静态函数用于演示
public class TestClass {
    public static func processData(name: String, age: Int64): String {
        return "Name: ${name}, Age: ${age}"
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态函数信息
    let staticFunctions = classInfo.staticFunctions
    for (staticFunction in staticFunctions) {
        if (staticFunction.name == "processData") {
            let parameters = staticFunction.parameters
            println("参数数量: ${parameters.size}")
            
            for (param in parameters) {
                println("参数名称: ${param.name}, 类型: ${param.typeInfo.name}")
            }
            break
        }
    }
    
    return
}
```

运行结果：

```text
参数数量: 2
参数名称: name, 类型: String
参数名称: age, 类型: Int64
```

### prop returnType

```cangjie
public prop returnType: TypeInfo
```

功能：获取该 [StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo) 对应的静态成员函数的返回值类型的类型信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

类型：[TypeInfo](reflect_package_classes.md#class-typeinfo)

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个带返回类型的类和静态函数用于演示
public class TestClass {
    public static func getString(): String {
        return "Hello"
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态函数信息
    let staticFunctions = classInfo.staticFunctions
    for (staticFunction in staticFunctions) {
        if (staticFunction.name == "getString") {
            let returnType = staticFunction.returnType
            println("返回类型: ${returnType.name}")
            break
        }
    }
    
    return
}
```

运行结果：

```text
返回类型: String
```

### func apply(TypeInfo, Array\<Any>)

```cangjie
public func apply(thisType: TypeInfo, args: Array<Any>): Any
```

功能：调用该 [StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo) 对应静态成员函数，传入方法所属的类型信息和实参列表并返回调用结果。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - `args` 的类型确保和函数入参类型完全一致，否则会导致参数检查失败。

参数：

- thisType: [TypeInfo](./reflect_package_classes.md#class-typeinfo) - 该方法所属的类。
- args: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Any](../../core/core_package_api/core_package_interfaces.md#interface-any)> - 实参列表。

返回值：

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 该静态成员函数的调用结果。

异常：

- [InvocationTargetException](reflect_package_exceptions.md#class-invocationtargetexception) - 如果该函数信息对应的静态成员函数存在泛型参数，则会抛出异常。
- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果该函数信息对应的静态成员函数的函数体未实现，则会抛出异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果实参列表 `args` 中的实参的数目与该静态成员函数信息所对应的静态成员函数的形参列表中的形参的数目不等，则抛出异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果 `thisType` 和该静态函数的函数签名不一致，则抛出异常。
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - 如果实参列表 `args` 中的任何一个实参的运行时类型不是该静态成员函数信息所对应的静态成员函数的对应形参的声明类型的子类型，则抛出异常。
- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - 如果被调用的静态成员函数信息所对应的静态成员函数内部抛出异常，则该异常将被封装为 [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) 异常并抛出。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public static func myName(): String {
        "my name is Rectangular"
    }
}

main(): Unit {
    // 此处是通过 Rectangular 的类型的限定名称获取 ClassTypeInfo，也可以通过实例获取 ClassTypeInfo
    let ty = ClassTypeInfo.get("test.Rectangular")

    // 获取静态函数
    let sf = ty.getStaticFunction("myName")

    let result = sf.apply(ty) as String
    println(result)
    return
}
```

运行结果：

```text
Some(my name is Rectangular)
```

### func apply(TypeInfo, Array\<TypeInfo>, Array\<Any>)

```cangjie
public func apply(thisType: TypeInfo, genericTypeArgs: Array<TypeInfo>, args: Array<Any>): Any
```

功能：调用该 [StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo) 对应静态成员函数，传入方法所属的类型信息和实参列表并返回调用结果。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - `args` 的类型确保和函数入参类型完全一致，否则会导致参数检查失败。

参数：

- thisType: [TypeInfo](./reflect_package_classes.md#class-typeinfo) - 该方法所属的类。
- genericTypeArgs: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[TypeInfo](./reflect_package_classes.md#class-typeinfo)> - 泛型参数类型列表。
- args: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Any](../../core/core_package_api/core_package_interfaces.md#interface-any)> - 实参列表。

返回值：

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 该静态成员函数的调用结果。

异常：

- [InvocationTargetException](reflect_package_exceptions.md#class-invocationtargetexception) -  如果该函数信息对应的静态成员函数是非泛型函数，则抛出异常。
- [InfoNotFoundException](../reflect_package_api/reflect_package_exceptions.md#class-infonotfoundexception) - 如果该函数信息对应的静态成员函数的函数体未实现，则会抛出异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果实参列表 `args` 中的实参的数目与该静态成员函数信息所对应的静态成员函数的形参列表中的形参的数目不等，则抛出异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果实参列表 `args` 中的泛型参数的数目与该静态成员函数信息所对应的泛型参数的数目不等，则抛出异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 如果 `thisType` 和该静态函数的函数签名不一致，则抛出异常。
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - 如果实参列表 `args` 中的任何一个实参的运行时类型不是该静态成员函数信息所对应的静态成员函数的对应形参的声明类型的子类型，则抛出异常。
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - 如果传入的参数列表 `args` 和泛型参数类型列表 `genericTypeArgs` 不满足该静态成员函数信息所对应的静态成员函数的参数的类型约束，则抛出异常。
- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - 如果被调用的静态成员函数信息所对应的静态成员函数内部抛出异常，则该异常将被封装为 [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) 异常并抛出。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class GenericClass {
    public static func process<T>(value: T): T {
        return value
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.GenericClass")
    
    // 获取静态函数信息
    let staticFunctions = classInfo.staticFunctions
    var staticFunction: ?StaticFunctionInfo = None
    
    for (sf in staticFunctions) {
        if (sf.name == "process") {
            staticFunction = sf
            break
        }
    }
    
    // 准备参数
    let stringTypeInfo = TypeInfo.get("std.core.String")
    
    // 调用带有泛型参数的函数
    try {
        let genericClass = GenericClass()
        let sf = staticFunction.getOrThrow()
        let result = sf.apply(classInfo, [stringTypeInfo], ["Hello World"]) as String
        println("调用结果: ${result}")
    } catch (e: Exception) {
        println("调用失败: ${e.message}")
    }
    
    return
}
```

运行结果：

```text
调用结果: Some(Hello World)
```

### func findAllAnnotations\<T>() where T <: Annotation

```cangjie
public func findAllAnnotations<T>(): Array<T> where T <: Annotation
```

功能：获取所有指定注解名称的自定义注解（通过泛型筛选）。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - 若无指定T类型的注解时，返回空数组；若有相关注解时，将所有该类型注解对象构成的数组返回。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个注解用于演示
@Annotation
public class MyAnnotation {
    public const init() {}
}

// 定义另一个注解用于演示
@Annotation
public class AnotherAnnotation {
    public const init() {}
}

// 定义一个带注解的类和静态函数用于演示
public class TestClass {
    @MyAnnotation
    @AnotherAnnotation
    public static func annotatedFunction(): String {
        return "This function has annotations"
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态函数信息
    let staticFunctions = classInfo.staticFunctions
    for (staticFunction in staticFunctions) {
        if (staticFunction.name == "annotatedFunction") {
            let myAnnotations = staticFunction.findAllAnnotations<MyAnnotation>()
            println("MyAnnotation注解数量: ${myAnnotations.size}")
            break
        }
    }
    
    return
}
```

运行结果：

```text
MyAnnotation注解数量: 1
```

### func findAnnotation\<T>() where T <: Annotation

```cangjie
public func findAnnotation<T>(): ?T where T <: Annotation
```

功能：尝试获取指定注解名称的自定义注解（通过泛型筛选）。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- ?T - 如果成功匹配则返回该注解，重复标注或者无法匹配时返回 `None`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个注解用于演示
@Annotation
public class MyAnnotation {
    public const init() {}
}

// 定义一个带注解的类和静态函数用于演示
public class TestClass {
    @MyAnnotation
    public static func annotatedFunction(): String {
        return "This function has annotations"
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态函数信息
    let staticFunctions = classInfo.staticFunctions
    for (staticFunction in staticFunctions) {
        if (staticFunction.name == "annotatedFunction") {
            let annotation = staticFunction.findAnnotation<MyAnnotation>()
            if (annotation.isSome()) {
                println("找到了MyAnnotation注解")
            } else {
                println("未找到MyAnnotation注解")
            }
            break
        }
    }
    
    return
}
```

运行结果：

```text
找到了MyAnnotation注解
```

### func getAllAnnotations()

```cangjie
public func getAllAnnotations(): Array<Annotation>
```

功能：获取作用于该对象的所有自定义注解。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Annotation](./reflect_package_types.md#type-annotation--object)> - 作用于该对象的所有注解。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个注解用于演示
@Annotation
public class MyAnnotation {
    public const init() {}
}

// 定义另一个注解用于演示
@Annotation
public class AnotherAnnotation {
    public const init() {}
}

// 定义一个带注解的类和静态函数用于演示
public class TestClass {
    @MyAnnotation
    @AnotherAnnotation
    public static func annotatedFunction(): String {
        return "This function has annotations"
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态函数信息
    let staticFunctions = classInfo.staticFunctions
    for (staticFunction in staticFunctions) {
        if (staticFunction.name == "annotatedFunction") {
            let allAnnotations = staticFunction.getAllAnnotations()
            println("总注解数量: ${allAnnotations.size}")
            break
        }
    }
    
    return
}
```

运行结果：

```text
总注解数量: 2
```

### func hashCode()

```cangjie
public func hashCode(): Int64
```

功能：获取该静态成员函数信息的哈希值。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 该静态成员函数信息的哈希值。

示例：

<!-- run -->
```cangjie
package test

import std.reflect.*

// 定义一个类和静态函数用于演示
public class TestClass {
    public static func processData(): String {
        return "Processing data"
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态函数信息
    let staticFunctions = classInfo.staticFunctions
    for (staticFunction in staticFunctions) {
        if (staticFunction.name == "processData") {
            let hash = staticFunction.hashCode()
            println("静态函数哈希值: ${hash}")
            break
        }
    }
    
    return
}
```

可能的运行结果：

```text
静态函数哈希值: 94660305794880
```

### func toString()

```cangjie
public func toString(): String
```

功能：获取字符串形式的该静态成员函数信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 字符串形式的该静态成员函数信息。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个类和静态函数用于演示
public class TestClass {
    public static func processData(): String {
        return "Processing data"
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态函数信息
    let staticFunctions = classInfo.staticFunctions
    for (staticFunction in staticFunctions) {
        if (staticFunction.name == "processData") {
            let str = staticFunction.toString()
            println("静态函数字符串表示: ${str}")
            break
        }
    }
    
    return
}
```

运行结果：

```text
静态函数字符串表示: static func processData(): String
```

### operator func !=(StaticFunctionInfo)

```cangjie
public operator func !=(that: StaticFunctionInfo): Bool
```

功能：判断该静态成员函数信息与给定的另一个静态成员函数信息是否不等。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- that: [StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo) - 被比较相等性的另一个静态成员函数信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该静态成员函数信息与 `that` 不等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个类和静态函数用于演示
public class TestClass {
    public static func func1(): String {
        return "Function 1"
    }
    
    public static func func2(): Int64 {
        return 42
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态函数信息
    let staticFunctions = classInfo.staticFunctions.toArray()

    println("两个StaticFunctionInfo对象不相等: ${staticFunctions[0] != staticFunctions[1]}")
    
    return
}
```

运行结果：

```text
两个StaticFunctionInfo对象不相等: true
```

### operator func ==(StaticFunctionInfo)

```cangjie
public operator func ==(that: StaticFunctionInfo): Bool
```

功能：判断该静态成员函数信息与给定的另一个静态成员函数信息是否相等。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- that: [StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo) - 被比较相等性的另一个静态成员函数信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该静态成员函数信息与 `that` 相等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个类和静态函数用于演示
public class TestClass {
    public static func processData(): String {
        return "Processing data"
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态函数信息
    let staticFunctions = classInfo.staticFunctions.toArray()

    println("两个StaticFunctionInfo对象相等: ${staticFunctions[0] == staticFunctions[0]}")
    
    return
}
```

运行结果：

```text
两个StaticFunctionInfo对象相等: true
```

## class StaticPropertyInfo

```cangjie
public class StaticPropertyInfo <: Equatable<StaticPropertyInfo> & Hashable & ToString
```

功能：描述静态成员属性信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

父类型：

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[StaticPropertyInfo](#class-staticpropertyinfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop annotations

```cangjie
public prop annotations: Collection<Annotation>
```

功能：获取所有作用于该 [StaticPropertyInfo](reflect_package_classes.md#class-staticpropertyinfo) 所对应的静态成员属性的注解所组成的集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果无任何注解作用于该静态成员属性信息所对应的静态成员属性，则返回空集合。
> - 该集合不保证遍历顺序恒定。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[Annotation](./reflect_package_types.md#type-annotation--object)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个注解用于演示
@Annotation
public class MyAnnotation {
    public const init() {}
}

// 定义一个带注解的类和静态属性用于演示
public class TestClass {
    @MyAnnotation
    public static prop testProperty: String {
        get() { "test value" }
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态属性信息
    let staticProperty = classInfo.getStaticProperty("testProperty")
    
    // 获取注解数量
    let annotations = staticProperty.annotations
    println("静态属性注解数量: ${annotations.size}")
    
    return
}
```

运行结果：

```text
静态属性注解数量: 1
```

### prop modifiers

```cangjie
public prop modifiers: Collection<ModifierInfo>
```

功能：获取该 [StaticPropertyInfo](reflect_package_classes.md#class-staticpropertyinfo) 对应的静态成员属性所拥有的所有修饰符的信息，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果该静态成员属性无任何修饰符，则返回空集合。
> - 该集合不保证遍历顺序恒定。
> - 目前获取到的修饰符集合内容较为混乱，尚未统一。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[ModifierInfo](reflect_package_enums.md#enum-modifierinfo)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个带修饰符的类和静态属性用于演示
public class TestClass {
    public static prop publicProperty: String {
        get() { "public value" }
    }
    
    private static prop privateProperty: String {
        get() { "private value" }
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态属性信息
    let staticProperty = classInfo.getStaticProperty("publicProperty")
    
    // 获取修饰符数量
    let modifiers = staticProperty.modifiers
    println("公共静态属性修饰符数量: ${modifiers.size}")
    
    return
}
```

运行结果：

```text
公共静态属性修饰符数量: 1
```

### prop name

```cangjie
public prop name: String
```

功能：获取该 [StaticPropertyInfo](reflect_package_classes.md#class-staticpropertyinfo) 对应的静态成员属性的名称。

> **注意：**
>
> 不支持平台：macOS、iOS。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个类和静态属性用于演示
public class TestClass {
    public static prop propertyName: String {
        get() { "property value" }
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态属性信息
    let staticProperty = classInfo.getStaticProperty("propertyName")
    
    // 获取属性名称
    println("静态属性名称: ${staticProperty.name}")
    
    return
}
```

运行结果：

```text
静态属性名称: propertyName
```

### prop typeInfo

```cangjie
public prop typeInfo: TypeInfo
```

功能：获取该 [StaticPropertyInfo](reflect_package_classes.md#class-staticpropertyinfo) 对应的静态成员属性的声明类型的类型信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

类型：[TypeInfo](reflect_package_classes.md#class-typeinfo)

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个类和静态属性用于演示
public class TestClass {
    public static prop stringValue: String {
        get() { "string value" }
    }
    
    public static prop intValue: Int64 {
        get() { 42 }
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态属性信息
    let staticProperty = classInfo.getStaticProperty("stringValue")
    
    // 获取属性类型信息
    let typeInfo = staticProperty.typeInfo
    println("静态属性类型: ${typeInfo.name}")
    
    return
}
```

运行结果：

```text
静态属性类型: String
```

### func findAllAnnotations\<T>() where T <: Annotation

```cangjie
public func findAllAnnotations<T>(): Array<T> where T <: Annotation
```

功能：获取所有指定注解名称的自定义注解（通过泛型筛选）。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - 若无指定T类型的注解时，返回空数组；若有相关注解时，将所有该类型注解对象构成的数组返回。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义注解用于演示
@Annotation
public class MyAnnotation {
    public const init() {}
}

@Annotation
public class AnotherAnnotation {
    public const init() {}
}

// 定义一个带注解的类和静态属性用于演示
public class TestClass {
    @MyAnnotation
    @AnotherAnnotation
    public static prop annotatedProperty: String {
        get() { "annotated value" }
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态属性信息
    let staticProperty = classInfo.getStaticProperty("annotatedProperty")
    
    // 查找所有指定类型的注解
    let myAnnotations = staticProperty.findAllAnnotations<MyAnnotation>()
    println("MyAnnotation注解数量: ${myAnnotations.size}")
    
    return
}
```

运行结果：

```text
MyAnnotation注解数量: 1
```

### func findAnnotation\<T>() where T <: Annotation

```cangjie
public func findAnnotation<T>(): ?T where T <: Annotation
```

功能：尝试获取指定注解名称的自定义注解（通过泛型筛选）。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- ?T - 如果成功匹配则返回该注解，重复标注或者无法匹配时返回 `None`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义注解用于演示
@Annotation
public class MyAnnotation {
    public const init() {}
}

// 定义一个带注解的类和静态属性用于演示
public class TestClass {
    @MyAnnotation
    public static prop annotatedProperty: String {
        get() { "annotated value" }
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态属性信息
    let staticProperty = classInfo.getStaticProperty("annotatedProperty")
    
    // 查找指定类型的注解
    let annotation = staticProperty.findAnnotation<MyAnnotation>()
    if (annotation.isSome()) {
        println("找到了MyAnnotation注解")
    } else {
        println("未找到MyAnnotation注解")
    }
    
    return
}
```

运行结果：

```text
找到了MyAnnotation注解
```

### func getAllAnnotations()

```cangjie
public func getAllAnnotations(): Array<Annotation>
```

功能：获取作用于该对象的所有自定义注解。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Annotation](./reflect_package_types.md#type-annotation--object)> - 作用于该对象的所有注解。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义注解用于演示
@Annotation
public class MyAnnotation {
    public const init() {}
}

@Annotation
public class AnotherAnnotation {
    public const init() {}
}

// 定义一个带注解的类和静态属性用于演示
public class TestClass {
    @MyAnnotation
    @AnotherAnnotation
    public static prop annotatedProperty: String {
        get() { "annotated value" }
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态属性信息
    let staticProperty = classInfo.getStaticProperty("annotatedProperty")
    
    // 获取所有注解
    let allAnnotations = staticProperty.getAllAnnotations()
    println("总注解数量: ${allAnnotations.size}")
    
    return
}
```

运行结果：

```text
总注解数量: 2
```

### func getValue()

```cangjie
public func getValue(): Any
```

功能：获取该 [StaticPropertyInfo](reflect_package_classes.md#class-staticpropertyinfo) 对应的静态成员属性的值。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果该静态成员属性缺少合法实现，如 `interface` 类型中的抽象静态成员属性，则应抛出 [UnsupportedException](../../core/core_package_api/core_package_exceptions.md#class-unsupportedexception) 异常，但由于后端尚未支持，故尚未实现。

返回值：

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 该静态成员属性的值。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public static prop sides: Int64 {
        get() { 4 }
    }
    public static prop angles: Int64 {
        get() { 4 }
    }
}

main(): Unit {
    // 此处是通过 Rectangular 的类型的限定名称获取 ClassTypeInfo，也可以通过实例获取 ClassTypeInfo
    let ty = ClassTypeInfo.get("test.Rectangular")

    // 获取静态属性
    let sp = ty.getStaticProperty("sides")

    let result = sp.getValue() as Int64
    println(result)
    return
}
```

运行结果：

```text
Some(4)
```

### func hashCode()

```cangjie
public func hashCode(): Int64
```

功能：获取该静态成员属性信息的哈希值。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 该静态成员属性信息的哈希值。

示例：

<!-- run -->
```cangjie
package test

import std.reflect.*

// 定义一个类和静态属性用于演示
public class TestClass {
    public static prop testProperty: String {
        get() { "test value" }
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态属性信息
    let staticProperty = classInfo.getStaticProperty("testProperty")
    
    // 获取哈希值
    let hash = staticProperty.hashCode()
    println("静态属性哈希值: ${hash}")
    
    return
}
```

可能的运行结果：

```text
静态属性哈希值: 94756514624640
```

### func isMutable()

```cangjie
public func isMutable(): Bool
```

功能：判断该静态成员属性信息所对应的静态成员属性是否可修改。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该静态成员属性信息所对应的静态成员属性可被修改则返回 `true` ，否则返回 `false`。

> **注意：**
>
> 如果静态成员属性被 `mut` 修饰符所修饰，则该静态成员属性可被修改，否则不可被修改。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个类和静态属性用于演示
public class TestClass {
    public static prop immutableProperty: String {
        get() { "immutable value" }
    }
    
    public static mut prop mutableProperty: String {
        get() { "mutable value" }
        set(v) {  }
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取不可变静态属性信息
    let immutableProperty = classInfo.getStaticProperty("immutableProperty")
    let isImmutableMutable = immutableProperty.isMutable()
    println("不可变属性是否可修改: ${isImmutableMutable}")
    
    // 获取可变静态属性信息
    let mutableProperty = classInfo.getStaticProperty("mutableProperty")
    let isMutableMutable = mutableProperty.isMutable()
    println("可变属性是否可修改: ${isMutableMutable}")
    
    return
}
```

运行结果：

```text
不可变属性是否可修改: false
可变属性是否可修改: true
```

### func setValue(Any)

```cangjie
public func setValue(newValue: Any): Unit
```

功能：设置该 [StaticPropertyInfo](reflect_package_classes.md#class-staticpropertyinfo) 对应的静态成员属性的值。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果该静态成员属性缺少合法实现，如 `interface` 类型中的抽象静态成员属性，则应抛出 [UnsupportedException](../../core/core_package_api/core_package_exceptions.md#class-unsupportedexception) 异常，但由于后端尚未支持，故尚未实现。

参数：

- newValue: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 新值。

异常：

- [IllegalSetException](reflect_package_exceptions.md#class-illegalsetexception) - 如果该静态成员属性信息所对应的静态成员属性不可修改，则抛出异常。
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - 如果新值 `newValue` 的运行时类型不是该静态成员属性信息所对应的静态成员属性的声明类型的子类型，则抛出异常。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    private static var valueArea = 0
    public static mut prop area: Int64 {
        get() { valueArea }
        set(v) { valueArea = v }
    }
}

main(): Unit {
    // 此处是通过 Rectangular 的类型的限定名称获取 ClassTypeInfo，也可以通过实例获取 ClassTypeInfo
    let ty = ClassTypeInfo.get("test.Rectangular")

    // 获取静态属性
    let sp = ty.getStaticProperty("area")

    // 设置静态成员属性的值
    sp.setValue(10)
    let result = sp.getValue() as Int64
    println(result)
    return
}
```

运行结果：

```text
Some(10)
```

### func toString()

```cangjie
public func toString(): String
```

功能：获取字符串形式的该静态成员属性信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 字符串形式的该静态成员属性信息。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个类和静态属性用于演示
public class TestClass {
    public static prop testProperty: String {
        get() { "test value" }
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态属性信息
    let staticProperty = classInfo.getStaticProperty("testProperty")
    
    // 获取字符串表示
    let str = staticProperty.toString()
    println("静态属性字符串表示: ${str}")
    
    return
}
```

运行结果：

```text
静态属性字符串表示: static prop testProperty: String
```

### operator func !=(StaticPropertyInfo)

```cangjie
public operator func !=(that: StaticPropertyInfo): Bool
```

功能：判断该静态成员属性信息与给定的另一个静态成员属性信息是否不等。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- that: [StaticPropertyInfo](reflect_package_classes.md#class-staticpropertyinfo) - 被比较相等性的另一个静态成员属性信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该静态成员属性信息与 `that` 不等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个类和静态属性用于演示
public class TestClass {
    public static prop property1: String {
        get() { "value1" }
    }
    
    public static prop property2: Int64 {
        get() { 42 }
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态属性信息
    let property1 = classInfo.getStaticProperty("property1")
    let property2 = classInfo.getStaticProperty("property2")
    
    // 比较两个静态属性信息是否不相等
    let result = property1 != property2
    println("两个静态属性不相等: ${result}")
    
    return
}
```

运行结果：

```text
两个静态属性不相等: true
```

### operator func ==(StaticPropertyInfo)

```cangjie
public operator func ==(that: StaticPropertyInfo): Bool
```

功能：判断该静态成员属性信息与给定的另一个静态成员属性信息是否相等。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- that: [StaticPropertyInfo](reflect_package_classes.md#class-staticpropertyinfo) - 被比较相等性的另一个静态成员属性信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该静态成员属性信息与 `that` 相等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个类和静态属性用于演示
public class TestClass {
    public static prop property1: String {
        get() { "value1" }
    }
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态属性信息
    let property1 = classInfo.getStaticProperty("property1")
    
    // 比较两个静态属性信息是否相等
    let result = property1 == property1
    println("同一个静态属性相等: ${result}")
    
    return
}
```

运行结果：

```text
同一个静态属性相等: true
```

## class StaticVariableInfo

```cangjie
public class StaticVariableInfo <: Equatable<StaticVariableInfo> & Hashable & ToString
```

功能：描述静态成员变量信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

父类型：

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[StaticVariableInfo](#class-staticvariableinfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop annotations

```cangjie
public prop annotations: Collection<Annotation>
```

功能：获取所有作用于该 [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo) 对应的静态成员变量的自定义注解，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果无任何注解作用于该 [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo) 对应的静态成员变量，则返回空集合。
> - 该集合不保证遍历顺序恒定。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[Annotation](./reflect_package_types.md#type-annotation--object)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个注解用于演示
@Annotation
public class MyAnnotation {
    public const init() {}
}

// 定义一个带注解的类和静态变量用于演示
public class TestClass {
    @MyAnnotation
    public static var testVariable: String = "test value"
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态变量信息
    let staticVariable = classInfo.getStaticVariable("testVariable")
    
    // 获取注解数量
    let annotations = staticVariable.annotations
    println("静态变量注解数量: ${annotations.size}")
    
    return
}
```

运行结果：

```text
静态变量注解数量: 1
```

### prop modifiers

```cangjie
public prop modifiers: Collection<ModifierInfo>
```

功能：获取该 [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo) 对应的静态成员变量所拥有的所有修饰符的信息，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果该静态成员变量无任何修饰符，则返回空集合。
> - 该集合不保证遍历顺序恒定。
> - 目前获取到的修饰符集合内容较为混乱，尚未统一。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[ModifierInfo](reflect_package_enums.md#enum-modifierinfo)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个带修饰符的类和静态变量用于演示
public class TestClass {
    public static var publicVariable: String = "public value"
    
    private static var privateVariable: String = "private value"
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态变量信息
    let staticVariable = classInfo.getStaticVariable("publicVariable")
    
    // 获取修饰符数量
    let modifiers = staticVariable.modifiers
    println("公共静态变量修饰符数量: ${modifiers.size}")
    
    return
}
```

运行结果：

```text
公共静态变量修饰符数量: 1
```

### prop name

```cangjie
public prop name: String
```

功能：获取该 [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo) 对应的静态成员变量的名称。

> **注意：**
>
> 不支持平台：macOS、iOS。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个类和静态变量用于演示
public class TestClass {
    public static var variableName: String = "variable value"
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态变量信息
    let staticVariable = classInfo.getStaticVariable("variableName")
    
    // 获取变量名称
    println("静态变量名称: ${staticVariable.name}")
    
    return
}
```

运行结果：

```text
静态变量名称: variableName
```

### prop typeInfo

```cangjie
public prop typeInfo: TypeInfo
```

功能：获取该 [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo) 对应的静态成员变量的声明类型的类型信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

类型：[TypeInfo](reflect_package_classes.md#class-typeinfo)

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个类和静态变量用于演示
public class TestClass {
    public static var stringValue: String = "string value"
    
    public static var intValue: Int64 = 42
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态变量信息
    let staticVariable = classInfo.getStaticVariable("stringValue")
    
    // 获取变量类型信息
    let typeInfo = staticVariable.typeInfo
    println("静态变量类型: ${typeInfo.name}")
    
    return
}
```

运行结果：

```text
静态变量类型: String
```

### func findAllAnnotations\<T>() where T <: Annotation

```cangjie
public func findAllAnnotations<T>(): Array<T> where T <: Annotation
```

功能：获取所有指定注解名称的自定义注解（通过泛型筛选）。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - 若无指定T类型的注解时，返回空数组；若有相关注解时，将所有该类型注解对象构成的数组返回。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义注解用于演示
@Annotation
public class MyAnnotation {
    public const init() {}
}

@Annotation
public class AnotherAnnotation {
    public const init() {}
}

// 定义一个带注解的类和静态变量用于演示
public class TestClass {
    @MyAnnotation
    @AnotherAnnotation
    public static var annotatedVariable: String = "annotated value"
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态变量信息
    let staticVariable = classInfo.getStaticVariable("annotatedVariable")
    
    // 查找所有指定类型的注解
    let myAnnotations = staticVariable.findAllAnnotations<MyAnnotation>()
    println("MyAnnotation注解数量: ${myAnnotations.size}")
    
    return
}
```

运行结果：

```text
MyAnnotation注解数量: 1
```

### func findAnnotation\<T>() where T <: Annotation

```cangjie
public func findAnnotation<T>(): ?T where T <: Annotation
```

功能：尝试获取指定注解名称的自定义注解（通过泛型筛选）。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- ?T - 如果成功匹配则返回该注解，重复标注或者无法匹配时返回 `None`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义注解用于演示
@Annotation
public class MyAnnotation {
    public const init() {}
}

// 定义一个带注解的类和静态变量用于演示
public class TestClass {
    @MyAnnotation
    public static var annotatedVariable: String = "annotated value"
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态变量信息
    let staticVariable = classInfo.getStaticVariable("annotatedVariable")
    
    // 查找指定类型的注解
    let annotation = staticVariable.findAnnotation<MyAnnotation>()
    match (annotation) {
        case Some(_) => println("找到了MyAnnotation注解")
        case None => println("未找到MyAnnotation注解")
    }
    
    return
}
```

运行结果：

```text
找到了MyAnnotation注解
```

### func getAllAnnotations()

```cangjie
public func getAllAnnotations(): Array<Annotation>
```

功能：获取作用于该对象的所有自定义注解。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Annotation](./reflect_package_types.md#type-annotation--object)> - 作用于该对象的所有注解。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义注解用于演示
@Annotation
public class MyAnnotation {
    public const init() {}
}

@Annotation
public class AnotherAnnotation {
    public const init() {}
}

// 定义一个带注解的类和静态变量用于演示
public class TestClass {
    @MyAnnotation
    @AnotherAnnotation
    public static var annotatedVariable: String = "annotated value"
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态变量信息
    let staticVariable = classInfo.getStaticVariable("annotatedVariable")
    
    // 获取所有注解
    let allAnnotations = staticVariable.getAllAnnotations()
    println("所有注解数量: ${allAnnotations.size}")
    
    return
}
```

运行结果：

```text
所有注解数量: 2
```

### func getValue()

```cangjie
public func getValue(): Any
```

功能：获取该 [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo) 对应的静态成员变量的值。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 该静态成员变量的值。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public static var area: Int64 = 10
}

main(): Unit {
    // 此处是通过 Rectangular 的类型的限定名称获取 ClassTypeInfo，也可以通过实例获取 ClassTypeInfo
    let ty = ClassTypeInfo.get("test.Rectangular")

    // 获取静态变量
    let sv = ty.getStaticVariable("area")
    // 获取值
    println(sv.getValue() as Int64)
    return
}
```

运行结果：

```text
Some(10)
```

### func hashCode()

```cangjie
public func hashCode(): Int64
```

功能：获取该静态成员变量信息的哈希值。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 该静态成员变量信息的哈希值。

示例：

<!-- run -->
```cangjie
package test

import std.reflect.*

// 定义一个类和静态变量用于演示
public class TestClass {
    public static var testVariable: String = "test value"
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态变量信息
    let staticVariable = classInfo.getStaticVariable("testVariable")
    
    // 获取哈希值
    let hashValue = staticVariable.hashCode()
    println("静态变量信息的哈希值: ${hashValue}")
    
    return
}
```

可能的运行结果：

```text
静态变量信息的哈希值: 94532229551216
```

### func isMutable()

```cangjie
public func isMutable(): Bool
```

功能：判断该 [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo) 对应的静态成员变量是否可修改。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果静态成员变量被 `var` 修饰符所修饰，则该静态成员变量可被修改。
> - 如果静态成员变量被 `let` 修饰符所修饰，则该静态成员变量不可被修改。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该静态成员变量信息所对应的静态成员变量可被修改则返回 `true` ，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个类和静态变量用于演示
public class TestClass {
    public static var mutableVariable: String = "mutable value"
    
    public static let immutableVariable: String = "immutable value"
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取可变静态变量信息
    let mutableStaticVariable = classInfo.getStaticVariable("mutableVariable")
    let isMutable = mutableStaticVariable.isMutable()
    println("可变静态变量: ${isMutable}")
    
    // 获取不可变静态变量信息
    let immutableStaticVariable = classInfo.getStaticVariable("immutableVariable")
    let isImmutableMutable = immutableStaticVariable.isMutable()
    println("不可变静态变量: ${isImmutableMutable}")
    
    return
}
```

运行结果：

```text
可变静态变量: true
不可变静态变量: false
```

### func setValue(Any)

```cangjie
public func setValue(newValue: Any): Unit
```

功能：设置该 [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo) 对应的静态成员变量的值。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- newValue: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 新值。

异常：

- [IllegalSetException](reflect_package_exceptions.md#class-illegalsetexception) - 如果该 [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo) 对应的静态成员变量不可修改，则抛出异常。
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - 如果新值 `newValue` 的运行时类型不是该静态成员变量信息所对应的静态成员变量的声明类型的子类型，则抛出异常。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public static var area: Int64 = 10
}

main(): Unit {
    // 此处是通过 Rectangular 的类型的限定名称获取 ClassTypeInfo，也可以通过实例获取 ClassTypeInfo
    let ty = ClassTypeInfo.get("test.Rectangular")

    // 获取静态变量
    let sv = ty.getStaticVariable("area")

    // 设置值
    sv.setValue(20)
    println(sv.getValue() as Int64)
    return
}
```

运行结果：

```text
Some(20)
```

### func toString()

```cangjie
public func toString(): String
```

功能：获取字符串形式的该静态成员变量信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 字符串形式的该静态成员变量信息。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个类和静态变量用于演示
public class TestClass {
    public static var testVariable: String = "test value"
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态变量信息
    let staticVariable = classInfo.getStaticVariable("testVariable")
    
    // 获取字符串表示
    let strRepresentation = staticVariable.toString()
    println("静态变量信息的字符串表示: ${strRepresentation}")
    
    return
}
```

运行结果：

```text
静态变量信息的字符串表示: static testVariable: String
```

### operator func !=(StaticVariableInfo)

```cangjie
public operator func !=(that: StaticVariableInfo): Bool
```

功能：判断该静态成员变量信息与给定的另一个静态成员变量信息是否不等。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- that: [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo) - 被比较相等性的另一个静态成员变量信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该静态成员变量信息与 `that` 不等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个类和静态变量用于演示
public class TestClass {
    public static var variable1: String = "value1"
    
    public static var variable2: String = "value2"
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态变量信息
    let staticVariable1 = classInfo.getStaticVariable("variable1")
    let staticVariable2 = classInfo.getStaticVariable("variable2")
    
    // 比较两个静态变量信息是否不等
    let result = staticVariable1 != staticVariable2
    println("两个静态变量不相等: ${result}")
    
    // 比较同一个静态变量信息
    let sameResult = staticVariable1 != staticVariable1
    println("同一个静态变量不相等: ${sameResult}")
    
    return
}
```

运行结果：

```text
两个静态变量不相等: true
同一个静态变量不相等: false
```

### operator func ==(StaticVariableInfo)

```cangjie
public operator func ==(that: StaticVariableInfo): Bool
```

功能：判断该静态成员变量信息与给定的另一个静态成员变量信息是否相等。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- that: [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo) - 被比较相等性的另一个静态成员变量信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该静态成员变量信息与 `that` 相等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个类和静态变量用于演示
public class TestClass {
    public static var variable1: String = "value1"
    
    public static var variable2: String = "value2"
}

main(): Unit {
    // 获取类信息
    let classInfo = ClassTypeInfo.get("test.TestClass")
    
    // 获取静态变量信息
    let staticVariable1 = classInfo.getStaticVariable("variable1")
    let staticVariable2 = classInfo.getStaticVariable("variable2")
    
    // 比较两个静态变量信息是否相等
    let result = staticVariable1 == staticVariable2
    println("两个静态变量相等: ${result}")
    
    // 比较同一个静态变量信息
    let sameResult = staticVariable1 == staticVariable1
    println("同一个静态变量相等: ${sameResult}")
    
    return
}
```

运行结果：

```text
两个静态变量相等: false
同一个静态变量相等: true
```

## class StructTypeInfo

```cangjie
public class StructTypeInfo <: TypeInfo
```

功能：描述 `struct` 类型的类型信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

父类型：

- [TypeInfo](#class-typeinfo)

由于实现限制，目前 `Struct` 类型的变量/属性修改需要参考如下代码手动 box/unbox。

示例：

<!-- run -->
```cangjie
import std.reflect.*

public struct SA {
    public var v1 = 11
}

main() {
    var sa = SA()

    // 通过这行先包装成Any，否则无法修改v1的值
    let saObj: Any = sa
    StructTypeInfo.of<SA>().getInstanceVariable("v1").setValue(saObj, 22)
    sa = (saObj as SA).getOrThrow()
    println(sa.v1) // should be 22
}
```

### prop constructors

```cangjie
public prop constructors: Collection<ConstructorInfo>
```

功能：获取该 [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo) 对应的 `struct` 的所有 `public` 构造函数信息，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果该 `struct` 类型无任何 `public` 构造函数，则返回空集合。
> - 该集合不保证遍历顺序恒定。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[ConstructorInfo](reflect_package_classes.md#class-constructorinfo)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public struct TestStruct {
    public var value: Int64 = 0
    
    public init() {}
    
    public init(value: Int64) {
        this.value = value
    }
}

main(): Unit {
    // 获取结构体类型信息
    let structTypeInfo = StructTypeInfo.of<TestStruct>()
    
    // 获取构造函数信息
    let constructors = structTypeInfo.constructors
    println("构造函数数量: ${constructors.size}")
    
    return
}
```

运行结果：

```text
构造函数数量: 2
```

### prop instanceVariables

```cangjie
public prop instanceVariables: Collection<InstanceVariableInfo>
```

功能：获取该 [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo) 对应的 `struct` 的所有 `public` 实例成员变量信息，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果该 `struct` 类型无任何 `public` 实例成员变量，则返回空集合。
> - 该集合不保证遍历顺序恒定。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public struct TestStruct {
    public var publicVar: Int64 = 0
    var privateVar: Int64 = 1
    public let publicLet: String = "public"
}

main(): Unit {
    // 获取结构体类型信息
    let structTypeInfo = StructTypeInfo.of<TestStruct>()
    
    // 获取实例成员变量信息
    let instanceVariables = structTypeInfo.instanceVariables
    println("实例成员变量数量: ${instanceVariables.size}")
    
    return
}
```

运行结果：

```text
实例成员变量数量: 2
```

### prop staticVariables

```cangjie
public prop staticVariables: Collection<StaticVariableInfo>
```

功能：获取该 [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo) 对应的 `struct` 的所有 `public` 静态成员变量信息，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果该 `struct` 类型无任何 `public` 静态成员变量，则返回空集合。
> - 该集合不保证遍历顺序恒定。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public struct TestStruct {
    public static var staticVar: Int64 = 10
    public static let staticLet: String = "static"
    var instanceVar: Int64 = 5
}

main(): Unit {
    // 获取结构体类型信息
    let structTypeInfo = StructTypeInfo.of<TestStruct>()
    
    // 获取静态成员变量信息
    let staticVariables = structTypeInfo.staticVariables
    println("静态成员变量数量: ${staticVariables.size}")
    
    return
}
```

运行结果：

```text
静态成员变量数量: 2
```

### static func get(String)

```cangjie
public static redef func get(qualifiedName: String): StructTypeInfo
```

功能：获取给定 `qualifiedName` 所对应的类型的 [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo)。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- qualifiedName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 类型的限定名称。

返回值：

- [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo) - 类型的限定名称 `qualifiedName` 所对应的 `Struct` 类型的类型信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果无法获取与给定类型的限定名称 `qualifiedName` 匹配的类型所对应的类型信息，则抛出异常。
- [IllegalTypeException](./reflect_package_exceptions.md#class-illegaltypeexception) - 如果获取到的类型信息不是 [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo)， 则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public struct Rectangular {}

main(): Unit {
    let ty = StructTypeInfo.get("default.Rectangular")
    println(ty)
    return
}
```

运行结果：

```text
default.Rectangular
```

### static func of(Any)

```cangjie
public static redef func of(a: Any): StructTypeInfo
```

功能：获取给定的任意类型实例的运行时类型所对应的类型信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

运行时类型是指在程序运行时，通过动态绑定确定的类型，运行时类型与实例对象相绑定。在继承等场景下运行时类型和静态类型可能不一致。

参数：

- a: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 任意类型的实例。

返回值：

- [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo) - 实例 `a` 的运行时类型所对应的类型信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果无法获得实例 `a` 的运行时类型所对应的类型信息，则抛出异常。
- [IllegalTypeException](./reflect_package_exceptions.md#class-illegaltypeexception) - 如果获取到的类型信息不是 [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo)， 则抛出异常。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public struct Rectangular {}

main(): Unit {
    var r = Rectangular()
    let ty = StructTypeInfo.of(r)
    println(ty)
    return
}
```

运行结果：

```text
test.Rectangular
```

### static func of\<T>()

```cangjie
public static redef func of<T>(): StructTypeInfo
```

功能：获取给定 `T` 类型对应的类型信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo) - `T` 类型对应的类型信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果无法获得类型 T 所对应的类型信息，抛出异常。
- [IllegalTypeException](./reflect_package_exceptions.md#class-illegaltypeexception) - 如果获取到的类型信息不是 [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo)， 则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public struct Rectangular {}

main(): Unit {
    let ty = StructTypeInfo.of<Rectangular>()
    println(ty)
    return
}
```

运行结果：

```text
default.Rectangular
```

### func construct(Array\<Any>)

```cangjie
public func construct(args: Array<Any>): Any
```

功能：在该 [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo) 对应的 `struct` 类型中根据实参列表搜索匹配的构造函数并调用，传入实参列表，返回调用结果。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- args: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Any](../../core/core_package_api/core_package_interfaces.md#interface-any)> - 实参列表。

返回值：

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 该 `struct` 类型的实例。

异常：

- [MisMatchException](reflect_package_exceptions.md#class-mismatchexception) - 如果 `args` 未能成功匹配任何该 `struct` 类型的 `public` 构造函数，则抛出异常
- [InvocationTargetException](reflect_package_exceptions.md#class-invocationtargetexception) - 在被调用的构造函数内部抛出的任何异常均将被封装为 [InvocationTargetException](reflect_package_exceptions.md#class-invocationtargetexception) 异常并抛出。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public struct Rectangular {
    public var length = 4
    public var width = 5
    public init() {}
    public init(length: Int64, width: Int64) {
        this.length = length
        this.width = width
    }
}

main(): Unit {
    // 此处是通过 Rectangular 的类型的限定名称获取 StructTypeInfo，也可以通过实例获取 StructTypeInfo
    let ty = StructTypeInfo.get("default.Rectangular")
    // 匹配构造函数并调用
    let v = ty.construct(2, 3) as Rectangular
    println(v.getOrThrow().length)
    return
}
```

运行结果：

```text
2
```

### func getConstructor(Array\<TypeInfo>)

```cangjie
public func getConstructor(parameterTypes: Array<TypeInfo>): ConstructorInfo
```

功能：尝试在该 [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo) 对应的 `struct` 类型中获取与给定形参类型信息列表匹配的 `public` 构造函数的信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- parameterTypes: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[TypeInfo](reflect_package_classes.md#class-typeinfo)> - 形参类型信息列表。

返回值：

- [ConstructorInfo](reflect_package_classes.md#class-constructorinfo) - 如果成功匹配则返回该 `public` 构造函数的信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果没找到对应 `public` 构造函数，则抛出异常。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public struct TestStruct {
    public var value: Int64 = 0
    
    public init() {}
    
    public init(value: Int64) {
        this.value = value
    }
}

main(): Unit {
    // 获取结构体类型信息
    let structTypeInfo = StructTypeInfo.of<TestStruct>()
    
    // 获取构造函数信息
    let int64TypeInfo = PrimitiveTypeInfo.get("Int64")
    let constructor = structTypeInfo.getConstructor([int64TypeInfo])
    println(constructor)
    
    return
}
```

运行结果：

```text
init(Int64)
```

### func getInstanceVariable(String)

```cangjie
public func getInstanceVariable(name: String): InstanceVariableInfo
```

功能：给定变量名称，尝试获取该 [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo) 对应的 `struct` 类型中匹配的实例成员变量的信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 变量名称。

返回值：

- [InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo) - 如果成功匹配则返回该实例成员变量的信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果没找到对应 `public` 实例成员变量，则抛出异常。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public var length = 4
    public var width = 5
    public var myName = ""
    public init() {}
}

main(): Unit {
    // 此处是通过 Rectangular 的类型的限定名称获取 ClassTypeInfo，也可以通过实例获取 ClassTypeInfo
    let ty = ClassTypeInfo.get("test.Rectangular")

    // 获取结构实例成员变量信息
    let ivi = ty.getInstanceVariable("myName")
    println(ivi)
    return
}
```

运行结果：

```text
myName: String
```

### func getStaticVariable(String)

```cangjie
public func getStaticVariable(name: String): StaticVariableInfo
```

功能：给定变量名称，尝试获取该 [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo) 对应的 `struct` 类型中匹配的静态成员变量的信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 变量名称。

返回值：

- [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo) - 如果成功匹配则返回该静态成员变量的信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果没找到对应 `public` 静态成员变量，则抛出异常。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public struct Rectangular {
    public static var area: Int64 = 10
}

main(): Unit {
    // 此处是通过 Rectangular 的类型的限定名称获取 StructTypeInfo，也可以通过实例获取 StructTypeInfo
    let ty = StructTypeInfo.get("test.Rectangular")

    // 获取静态变量
    let sv = ty.getStaticVariable("area")
    println(sv)
    return
}
```

运行结果：

```text
static area: Int64
```

## class TypeInfo

```cangjie
sealed abstract class TypeInfo <: Equatable<TypeInfo> & Hashable & ToString
```

功能：[TypeInfo](reflect_package_classes.md#class-typeinfo) 提供了所有数据类型通用的操作接口。开发者通常无需向下转型为更具体的数据类型，如 [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) 等，就能进行反射操作。

> **注意：**
>
> 不支持平台：macOS、iOS。

[TypeInfo](reflect_package_classes.md#class-typeinfo) 的子类包括 [PrimitiveTypeInfo](reflect_package_classes.md#class-primitivetypeinfo)、[StructTypeInfo](reflect_package_classes.md#class-structtypeinfo)、[ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) 和 [InterfaceTypeInfo](reflect_package_classes.md#class-interfacetypeinfo)，分别对应基本数据类型，`struct` 数据类型，`class` 数据类型和 `interface` 数据类型的类型信息。

> **说明：**
>
> 类型的限定名称为`(module_name/)?(default|package_name)(.package_name)*.(type_name)`。

父类型：

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TypeInfo](#class-typeinfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop annotations

```cangjie
public prop annotations: Collection<Annotation>
```

功能：获取所有作用于该 [TypeInfo](reflect_package_classes.md#class-typeinfo) 对应的类型的自定义注解，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果无任何注解作用于该类型信息所对应的类型，则返回空集合。
> - 该集合不保证遍历顺序恒定。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[Annotation](./reflect_package_types.md#type-annotation--object)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义一个注解
@Annotation
public class MyAnnotation {
    public const init() {}
}

// 定义一个带注解的类
@MyAnnotation
public class TestClass {}

main(): Unit {
    // 获取类型信息
    let typeInfo = TypeInfo.of<TestClass>()
    
    // 获取注解信息
    let annotations = typeInfo.annotations
    println("注解数量: ${annotations.size}")
    
    return
}
```

运行结果：

```text
注解数量: 1
```

### prop instanceFunctions

```cangjie
public prop instanceFunctions: Collection<InstanceFunctionInfo>
```

功能：获取该 [TypeInfo](reflect_package_classes.md#class-typeinfo) 对应类型的所有 `public` 实例成员函数信息，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果该 [TypeInfo](reflect_package_classes.md#class-typeinfo) 对应的类型无任何 `public` 实例成员函数，则返回空集合。
> - 该集合不保证遍历顺序恒定。
> - 如果该类型信息所对应的类型是 `struct` 或 `class` 类型，则该集合不包含继承而来的实例成员函数的信息。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class TestClass {
    public func publicMethod(): Int64 {
        return 42
    }
    
    private func privateMethod(): Int64 {
        return 24
    }
}

main(): Unit {
    // 获取类型信息
    let typeInfo = TypeInfo.of<TestClass>()
    
    // 获取实例函数信息
    let instanceFunctions = typeInfo.instanceFunctions
    println("公共实例函数数量: ${instanceFunctions.size}")
    
    return
}
```

运行结果：

```text
公共实例函数数量: 1
```

### prop instanceProperties

```cangjie
public prop instanceProperties: Collection<InstancePropertyInfo>
```

功能：获取该 [TypeInfo](reflect_package_classes.md#class-typeinfo) 对应类型的所有 `public` 实例成员属性信息，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果该 [TypeInfo](reflect_package_classes.md#class-typeinfo) 对应的类型无任何 `public` 实例成员属性，则返回空集合。
> - 该集合不保证遍历顺序恒定。
> - 如果该类型信息所对应的类型是 `struct` 或 `class` 类型，则该集合不包含继承而来的实例成员属性的信息。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class TestClass {
    public var publicVar: Int64 = 10
    public prop publicProp: Int64 {
        get() { 20 }
    }
    
    private var privateVar: Int64 = 30
}

main(): Unit {
    // 获取类型信息
    let typeInfo = TypeInfo.of<TestClass>()
    
    // 获取实例属性信息
    let instanceProperties = typeInfo.instanceProperties
    println("公共实例属性数量: ${instanceProperties.size}")
    
    return
}
```

运行结果：

```text
公共实例属性数量: 1
```

### prop modifiers

```cangjie
public prop modifiers: Collection<ModifierInfo>
```

功能：获取该 [TypeInfo](reflect_package_classes.md#class-typeinfo) 对应的类型拥有的所有修饰符的信息，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果该类型无任何修饰符，则返回空集合。
> - 该集合不保证遍历顺序恒定。
> - `interface` 类型默认拥有 `open` 语义，故返回的集合总是包含 `open` 修饰符。
> - 由于反射功能只能对所有被 `public` 访问控制修饰符所修饰的类型进行操作，故将忽略所有访问控制修饰符。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[ModifierInfo](reflect_package_enums.md#enum-modifierinfo)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public open class TestClass {
    public var publicVar: Int64 = 10
}

main(): Unit {
    // 获取类型信息
    let typeInfo = TypeInfo.of<TestClass>()
    
    // 获取修饰符信息
    let modifiers = typeInfo.modifiers
    println("修饰符数量: ${modifiers.size}")
    
    return
}
```

运行结果：

```text
修饰符数量: 1
```

### prop name

```cangjie
public prop name: String
```

功能：获取该 [TypeInfo](reflect_package_classes.md#class-typeinfo) 对应的类型的名称。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 该名称不包含任何模块名和包名前缀。
> - 类型别名的类型信息就是实际类型其本身的类型信息，所以该函数并不会返回类型别名本身的名称而是实际类型的名称，如类型别名 [Byte](../../core/core_package_api/core_package_types.md#type-byte) 的类型信息的名称是 [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) 而不是 [Byte](../../core/core_package_api/core_package_types.md#type-byte)。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class TestClass {
    public var publicVar: Int64 = 10
}

main(): Unit {
    // 获取类型信息
    let typeInfo = TypeInfo.of<TestClass>()
    
    // 获取类型名称
    let name = typeInfo.name
    println("类型名称: ${name}")
    
    return
}
```

运行结果：

```text
类型名称: TestClass
```

### prop qualifiedName

```cangjie
public prop qualifiedName: String
```

功能：获取该 [TypeInfo](reflect_package_classes.md#class-typeinfo) 对应的类型的限定名称。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 限定名称包含模块名和包名前缀。
> - 特别的，仓颉内置数据类型，以及位于 `std` 模块 `core` 包下的所有类型的限定名称都是不带有任何模块名和包名前缀的。
> - 在缺省模块名和包名的上下文中定义的所有类型，均无模块名前缀，但拥有包名前缀"`default`"，如："`default.MyType`"。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class TestClass {
    public var publicVar: Int64 = 10
}

main(): Unit {
    // 获取类型信息
    let typeInfo = TypeInfo.of<TestClass>()
    
    // 获取限定名称
    let qualifiedName = typeInfo.qualifiedName
    println("限定名称: ${qualifiedName}")
    
    return
}
```

运行结果：

```text
限定名称: test.TestClass
```

### prop staticFunctions

```cangjie
public prop staticFunctions: Collection<StaticFunctionInfo>
```

功能：获取该 [TypeInfo](reflect_package_classes.md#class-typeinfo) 对应类型的所有 `public` 静态成员函数信息，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果该 [TypeInfo](reflect_package_classes.md#class-typeinfo) 对应的类型无任何 `public` 静态成员函数，则返回空集合。
> - 该集合不保证遍历顺序恒定。
> - 如果该类型信息所对应的类型是 `struct` 、`class` 或 `interface` 类型，则该集合不包含继承而来的静态成员函数的信息。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class TestClass {
    public static func publicStaticMethod(): Int64 {
        return 42
    }
    
    private static func privateStaticMethod(): Int64 {
        return 24
    }
}

main(): Unit {
    // 获取类型信息
    let typeInfo = TypeInfo.of<TestClass>()
    
    // 获取静态函数信息
    let staticFunctions = typeInfo.staticFunctions
    println("公共静态函数数量: ${staticFunctions.size}")
    
    return
}
```

运行结果：

```text
公共静态函数数量: 1
```

### prop staticProperties

```cangjie
public prop staticProperties: Collection<StaticPropertyInfo>
```

功能：获取该 [TypeInfo](reflect_package_classes.md#class-typeinfo) 对应类型的所有 `public` 静态成员属性信息，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 如果该 [TypeInfo](reflect_package_classes.md#class-typeinfo) 对应的类型无任何 `public` 静态成员属性，则返回空集合。
> - 该集合不保证遍历顺序恒定。
> - 如果该类型信息所对应的类型是 `struct` 、`class` 或 `interface` 类型，则该集合不包含继承而来的静态成员属性的信息。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[StaticPropertyInfo](reflect_package_classes.md#class-staticpropertyinfo)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class TestClass {
    public static var publicStaticVar: Int64 = 10
    public static prop publicStaticProp: Int64 {
        get() { 20 }
    }
    
    private static var privateStaticVar: Int64 = 30
}

main(): Unit {
    // 获取类型信息
    let typeInfo = TypeInfo.of<TestClass>()
    
    // 获取静态属性信息
    let staticProperties = typeInfo.staticProperties
    println("公共静态属性数量: ${staticProperties.size}")
    
    return
}
```

运行结果：

```text
公共静态属性数量: 1
```

### prop superInterfaces

```cangjie
public prop superInterfaces: Collection<InterfaceTypeInfo>
```

功能：获取该 [TypeInfo](reflect_package_classes.md#class-typeinfo) 对应的类型直接实现的所有 `interface` 类型的信息，返回对应集合。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 所有类型均默认直接实现 interface [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) 类型。
> - 该集合不保证遍历顺序恒定。
> - 目前， `struct` 类型只支持获取到 interface [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) 类型。

类型：[Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[InterfaceTypeInfo](reflect_package_classes.md#class-interfacetypeinfo)>

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public interface MyInterface {}

public class TestClass <: MyInterface {}

main(): Unit {
    // 获取类型信息
    let typeInfo = TypeInfo.of<TestClass>()
    
    // 获取父接口信息
    let superInterfaces = typeInfo.superInterfaces.toArray()
    for (superInterface in superInterfaces) {
        println("父接口名称: ${superInterface.name}")
    }
    return
}
```

运行结果：

```text
父接口名称: MyInterface
父接口名称: Any
```

### static func get(String)

```cangjie
public static func get(qualifiedName: String): TypeInfo
```

功能：获取给定 `qualifiedName` 所对应的类型的 [TypeInfo](reflect_package_classes.md#class-typeinfo)。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 目前， 类型的限定名称 `qualifiedName` 不支持 `Nothing` 类型、函数类型、元组类型和`enum` 类型的限定名称。

参数：

- qualifiedName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 类型的限定名称。

返回值：

- [TypeInfo](reflect_package_classes.md#class-typeinfo) - 类型的限定名称 `qualifiedName` 所对应的类型的类型信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果无法获取与给定类型的限定名称 `qualifiedName` 匹配的类型所对应的类型信息，则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class Rectangular {}

main(): Unit {
    let ty = TypeInfo.get("default.Rectangular")
    println(ty)
    return
}
```

运行结果：

```text
default.Rectangular
```

### static func of(Any)

```cangjie
public static func of(a: Any): TypeInfo
```

功能：获取给定的任意类型实例的运行时类型所对应的类型信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

运行时类型是指在程序运行时，通过动态绑定确定的类型，运行时类型与实例对象相绑定。在继承等场景下运行时类型和静态类型可能不一致。

> **注意：**
>
> 目前，实例 `a` 不支持运行时类型为函数类型、元组类型、`enum` 类型。

参数：

- a: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - 任意类型的实例。

返回值：

- [TypeInfo](reflect_package_classes.md#class-typeinfo) - 实例 `a` 的运行时类型所对应的类型信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果无法获得实例 `a` 的运行时类型所对应的类型信息，则抛出异常。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {}

main(): Unit {
    var r: Any = Rectangular()
    let ty = TypeInfo.of(r)
    println(ty)
    return
}
```

运行结果：

```text
test.Rectangular
```

### static func of(Object) <sup>(deprecated)</sup>

```cangjie
public static func of(a: Object): ClassTypeInfo
```

功能：获取给定的 `class` 类型的实例的运行时类型所对应的 `class` 类型信息。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 未来版本即将废弃，使用 [ClassTypeInfo](#class-classtypeinfo) 的 [static func of(Object)](#static-func-ofobject) 函数替代。

参数：

- a: [Object](../../core/core_package_api/core_package_classes.md#class-object) - `class` 类型的实例。

返回值：

- [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) - `class` 类型的实例 `a` 的运行时类型所对应的 `class` 类型信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果无法获得实例 `a` 的运行时类型所对应的 `class` 类型信息，则抛出异常。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {}

main(): Unit {
    var r: Object = Rectangular()
    let ty = TypeInfo.of(r)
    println(ty)
    return
}
```

运行结果：

```text
test.Rectangular
```

### static func of\<T>()

```cangjie
public static func of<T>(): TypeInfo
```

功能：获取给定 `T` 类型对应的类型信息。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 目前，泛型 `T` 不支持 `Nothing` 类型、函数类型、元组类型和`enum` 类型。
> - `T` 支持传入类型别名，包括内置类型别名（如 [Int](../../core/core_package_api/core_package_types.md#type-int)、[UInt](../../core/core_package_api/core_package_types.md#type-uint) 和 `Rune` 等）与用户自定义类型别名。

返回值：

- [TypeInfo](reflect_package_classes.md#class-typeinfo) - `T` 类型对应的类型信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果无法获得类型 T 所对应的类型信息，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class Rectangular {}

main(): Unit {
    let ty = TypeInfo.of<Rectangular>()
    println(ty)
    return
}
```

运行结果：

```text
default.Rectangular
```

### func findAllAnnotations\<T>() where T <: Annotation

```cangjie
public func findAllAnnotations<T>(): Array<T> where T <: Annotation
```

功能：获取所有指定注解名称的自定义注解（通过泛型筛选）。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - 若无指定T类型的注解时，返回空数组；若有相关注解时，将所有该类型注解对象构成的数组返回。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义注解
@Annotation
public class MyAnnotation {
    public const init() {}
}

@Annotation
public class AnotherAnnotation {
    public const init() {}
}

// 定义一个带注解的类
@MyAnnotation
@AnotherAnnotation
public class TestClass {}

main(): Unit {
    // 获取类型信息
    let typeInfo = TypeInfo.of<TestClass>()
    
    // 查找所有指定类型的注解
    let myAnnotations = typeInfo.findAllAnnotations<MyAnnotation>()
    println("MyAnnotation注解数量: ${myAnnotations.size}")
    
    return
}
```

运行结果：

```text
MyAnnotation注解数量: 1
```

### func findAnnotation\<T>() where T <: Annotation

```cangjie
public func findAnnotation<T>(): ?T where T <: Annotation
```

功能：尝试获取指定注解名称的自定义注解（通过泛型筛选）。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值： 

- ?T - 如果成功匹配则返回该注解，重复标注或者无法匹配时返回 `None`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义注解
@Annotation
public class MyAnnotation {
    public const init() {}
}

// 定义一个带注解的类
@MyAnnotation
public class TestClass {}

main(): Unit {
    // 获取类型信息
    let typeInfo = TypeInfo.of<TestClass>()
    
    // 查找指定类型的注解
    let annotation: ?MyAnnotation = typeInfo.findAnnotation<MyAnnotation>()
    match (annotation) {
        case Some(_) => println("找到了MyAnnotation注解")
        case None => println("未找到MyAnnotation注解")
    }
    
    return
}
```

运行结果：

```text
找到了MyAnnotation注解
```

### func getAllAnnotations()

```cangjie
public func getAllAnnotations(): Array<Annotation>
```

功能：获取作用于该对象的所有自定义注解。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Annotation](./reflect_package_types.md#type-annotation--object)> - 作用于该对象的所有注解。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

// 定义注解
@Annotation
public class MyAnnotation {
    public const init() {}
}

@Annotation
public class AnotherAnnotation {
    public const init() {}
}

// 定义一个带注解的类
@MyAnnotation
@AnotherAnnotation
public class TestClass {}

main(): Unit {
    // 获取类型信息
    let typeInfo = TypeInfo.of<TestClass>()
    
    // 获取所有注解
    let allAnnotations = typeInfo.getAllAnnotations()
    println("所有注解数量: ${allAnnotations.size}")
    
    return
}
```

运行结果：

```text
所有注解数量: 2
```

### func getInstanceFunction(String, Array\<TypeInfo>)

```cangjie
public func getInstanceFunction(name: String, parameterTypes: Array<TypeInfo>): InstanceFunctionInfo
```

功能：给定函数名称与函数形参类型列表所对应的类型信息列表，尝试获取该类型中匹配的实例成员函数的信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 函数名称。
- parameterTypes: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[TypeInfo](reflect_package_classes.md#class-typeinfo)> - 函数形参类型列表所对应的类型信息列表。

返回值：

- [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo) - 如果成功匹配则返回该实例成员函数的信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果没找到对应 `public` 实例成员函数，则抛出异常。

示例：

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
    // 此处是通过 Rectangular 的类型的限定名称获取 TypeInfo，也可以通过实例获取 TypeInfo
    let ty = TypeInfo.get("default.Rectangular")
    // 获取 InstanceFunctionInfo
    var gif = ty.getInstanceFunction("area")

    println(gif)
    return
}
```

运行结果：

```text
func area(): Int64
```

### func getInstanceFunctions(String)

```cangjie
public func getInstanceFunctions(name: String): Array<InstanceFunctionInfo>
```

功能：给定函数名称，尝试获取该类型中所有匹配的实例成员函数的信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 函数名称。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo)> - 如果成功匹配则返回所有匹配到的实例成员函数信息。

示例：

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
    // 此处是通过 Rectangular 的类型的限定名称获取 TypeInfo，也可以通过实例获取 TypeInfo
    let ty = TypeInfo.get("default.Rectangular")
    // 获取 InstanceFunctionInfo
    var gif = ty.getInstanceFunctions("area")

    println(gif)
    return
}
```

运行结果：

```text
[func area(): Int64]
```

### func getInstanceProperty(String)

```cangjie
public func getInstanceProperty(name: String): InstancePropertyInfo
```

功能：尝试获取该类型中与给定属性名称匹配的实例成员属性的信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 属性名称。

返回值：

- [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo) - 如果成功匹配则返回该实例成员属性的信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果没找到对应 `public` 实例成员属性，则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

public class Rectangular {
    public var length = 4
    public prop width: Int64 {
        get() {
            5
        }
    }
}

main(): Unit {
    // 此处是通过 Rectangular 的类型的限定名称获取 TypeInfo，也可以通过实例获取 TypeInfo
    let ty = TypeInfo.get("default.Rectangular")
    // 获取 InstancePropertyInfo
    var gip = ty.getInstanceProperty("width")

    println(gip)
    return
}
```

运行结果：

```text
prop width: Int64
```

### func getStaticFunction(String, Array\<TypeInfo>)

```cangjie
public func getStaticFunction(name: String, parameterTypes: Array<TypeInfo>): StaticFunctionInfo
```

功能：通过给定函数名称与函数形参类型列表所对应的类型信息列表，尝试获取该类型中匹配的静态成员函数的信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 函数名称。
- parameterTypes: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[TypeInfo](reflect_package_classes.md#class-typeinfo)> - 函数形参类型列表所对应的类型信息列表。

返回值：

- [StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo) - 如果成功匹配则返回该静态成员函数的信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果没找到对应 `public` 静态成员函数，则抛出异常。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class MyClass {
    public static func myFunc(): String { 
        "Hello World" 
    }
    
    public static func myFuncWithParam(value: Int64): String { 
        "Hello ${value}" 
    }
}

main(): Unit {
    // 获取类型信息
    let typeInfo = TypeInfo.get("test.MyClass")
    
    // 获取带参数静态函数信息
    // 通过已有函数的参数类型来获取类型信息
    let function = typeInfo.getStaticFunction("myFuncWithParam", [PrimitiveTypeInfo.get("Int64")])
    println(function)
    return
}
```

运行结果：

```text
static func myFuncWithParam(Int64): String
```

### func getStaticFunctions(String)

```cangjie
public func getStaticFunctions(name: String): Array<StaticFunctionInfo>
```

功能：给定函数名称，尝试获取该类型中所有匹配的静态成员函数的信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 函数名称。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo)> - 如果成功匹配则返回所有匹配到的静态成员函数信息。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public static func myName(): String { "" }
}

main(): Unit {
    // 此处是通过 Rectangular 的类型的限定名称获取 TypeInfo，也可以通过实例获取 TypeInfo
    let ty = TypeInfo.get("test.Rectangular")

    // 获取静态函数
    let sf = ty.getStaticFunctions("myName")

    println(sf)
    return
}
```

运行结果：

```text
[static func myName(): String]
```

### func getStaticProperty(String)

```cangjie
public func getStaticProperty(name: String): StaticPropertyInfo
```

功能：尝试获取该类型中与给定属性名称匹配的静态成员属性的信息。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 属性名称。

返回值：

- [StaticPropertyInfo](reflect_package_classes.md#class-staticpropertyinfo) - 如果成功匹配则返回该静态成员属性的信息。

异常：

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果没找到对应 `public` 静态成员属性，则抛出异常。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    private static var valueArea = 0
    public static mut prop area: Int64 {
        get() { valueArea }
        set(v) { valueArea = v }
    }
}

main(): Unit {
    // 此处是通过 Rectangular 的类型的限定名称获取 TypeInfo，也可以通过实例获取 TypeInfo
    let ty = TypeInfo.get("test.Rectangular")

    // 获取静态属性
    let sp = ty.getStaticProperty("area")

    println(sp)
    return
}
```

运行结果：

```text
static mut prop area: Int64
```

### func hashCode()

```cangjie
public func hashCode(): Int64
```

功能：获取该类型信息的哈希值。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 内部实现为该类型信息的限定名称字符串的哈希值。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 该类型信息的哈希值。

示例：

<!-- run -->
```cangjie
package test

import std.reflect.*

public class TestClass {
    public var publicVar: Int64 = 10
}

main(): Unit {
    // 获取类型信息
    let typeInfo = TypeInfo.of<TestClass>()
    
    // 获取哈希值
    let hashCode = typeInfo.hashCode()
    println("哈希值: ${hashCode}")
    
    return
}
```

可能的运行结果：

```text
哈希值: 93845398479248
```

### func isSubtypeOf(TypeInfo)

```cangjie
public func isSubtypeOf(supertype: TypeInfo): Bool
```

功能：判断当前 [TypeInfo](reflect_package_classes.md#class-typeinfo) 实例对应的类型是否是参数中指定的 [TypeInfo](reflect_package_classes.md#class-typeinfo) 实例表示的类型的子类型。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- supertype: [TypeInfo](reflect_package_classes.md#class-typeinfo) - 目标类型的类型信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该 [TypeInfo](reflect_package_classes.md#class-typeinfo) 对应的类型是 `supertype` 所对应的类型的子类型则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public abstract class Rectangular {}

public class Square <: Rectangular {}

main(): Unit {
    // 此处是通过 Rectangular 的类型的限定名称获取 TypeInfo，也可以通过实例获取 TypeInfo
    let tyr = ClassTypeInfo.get("test.Rectangular")
    let tys = ClassTypeInfo.get("test.Square")
    println(tys.isSubtypeOf(tyr))
    return
}
```

运行结果：

```text
true
```

### func toString()

```cangjie
public func toString(): String
```

功能：获取字符串形式的该类型信息。

> **注意：**
>
> - 不支持平台：macOS、iOS。
> - 内部实现为该类型信息的限定名称字符串。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 字符串形式的该类型信息。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class TestClass {
    public var publicVar: Int64 = 10
}

main(): Unit {
    // 获取类型信息
    let typeInfo = TypeInfo.of<TestClass>()
    
    // 获取字符串表示
    let strRepresentation = typeInfo.toString()
    println("字符串表示: ${strRepresentation}")
    
    return
}
```

运行结果：

```text
字符串表示: test.TestClass
```

### operator func !=(TypeInfo)

```cangjie
public operator func !=(that: TypeInfo): Bool
```

功能：判断该类型信息与给定的另一个类型信息是否不等。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- that: [TypeInfo](reflect_package_classes.md#class-typeinfo) - 被比较相等性的另一个类型信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该类型信息的限定名称与 `that` 不等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class TestClass1 {
    public var publicVar: Int64 = 10
}

public class TestClass2 {
    public var publicVar: Int64 = 20
}

main(): Unit {
    // 获取类型信息
    let typeInfo1 = TypeInfo.of<TestClass1>()
    let typeInfo2 = TypeInfo.of<TestClass2>()
    
    // 比较两个类型信息是否不等
    let result = typeInfo1 != typeInfo2
    println("两个类型信息不等: ${result}")
    
    // 比较同一个类型信息
    let sameResult = typeInfo1 != typeInfo1
    println("同一个类型信息不等: ${sameResult}")
    
    return
}
```

运行结果：

```text
两个类型信息不等: true
同一个类型信息不等: false
```

### operator func ==(TypeInfo)

```cangjie
public operator func ==(that: TypeInfo): Bool
```

功能：判断该类型信息与给定的另一个类型信息是否相等。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- that: [TypeInfo](reflect_package_classes.md#class-typeinfo) - 被比较相等性的另一个类型信息。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 如果该类型信息的限定名称与 `that` 相等则返回 `true`，否则返回 `false`。

示例：

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class TestClass1 {
    public var publicVar: Int64 = 10
}

public class TestClass2 {
    public var publicVar: Int64 = 20
}

main(): Unit {
    // 获取类型信息
    let typeInfo1 = TypeInfo.of<TestClass1>()
    let typeInfo2 = TypeInfo.of<TestClass2>()
    
    // 比较两个类型信息是否相等
    let result = typeInfo1 == typeInfo2
    println("两个类型信息相等: ${result}")
    
    // 比较同一个类型信息
    let sameResult = typeInfo1 == typeInfo1
    println("同一个类型信息相等: ${sameResult}")
    
    return
}
```

运行结果：

```text
两个类型信息相等: false
同一个类型信息相等: true
```
