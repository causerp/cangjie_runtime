# 类

> **说明：**
>
> 1. 类(class)按 **字母顺序** 展示。
> 2. 对于class内的子API，按 **成员变量(static let/let/var)、属性(static prop/prop)、主构造函数、const构造函数(const init)、构造函数(init)、函数(static func/func)、操作符函数(operator func)、扩展(extend)** 的类型顺序展示。
> 3. class的各子类型内部，子API按 **字母顺序** 排列。
> 4. 若子类中重写了父类的函数，需要在文档中体现该function。
> 5. public open/abstract class 的 protected 子成员需给出文档。
> 6. 在文档中提到其他的API都需要使用超链接的方式链过去，例：
>
>    ```text
>    [ArrayList](./xx/xxx.md#class-arraylist)
>    ```

## class Class1

【必写】（定义声明，每个类的声明代码中应包含 public filed（const/let/var 常量变量）、构造函数）

```cangjie
public class Class1 {
    public static let aaa: xxx
    public let aaa: xxx
    public Class1(let param1: dtype1, public let param2: dtype2)
    public const init(param: dtype)
    public init()
}
```

【必写】功能：提供xxx功能。(*一句话概述API功能*)

【可选】（*功能描述，详细介绍API功能、原理、使用场景等信息*）

【例】

> **说明：**
>
> 不支持平台：Windows

【可选】说明/注意事项，参考 [说明注意格式要求](../../../../overview.md#说明注意警告可选)。

【必写】示例，参考 [示例代码规范及格式要求](../../../../overview.md#示例必写)。

### static let aab

【必写】（定义声明）

```cangjie
public static let aab: dtype
```

【必写】功能：表示xxx。

【必写】类型：[dtype](link)

### let param2

同上

### static prop property1

同上

### prop property1

同上

### Class1(dtype1, dtype2)（主构造函数）

...

### const init(dtype)

参考 [函数模板](./xxx_package_funcs.md)

（*注意：功能说明使用 “构造了一个xxx对象”*）

### init()

同上

### init(int, int)

同上

### func function1()

参考 [函数模板](./xxx_package_funcs.md)

### operator func ==(Ordering)

同上

### extend\<T> Class1\<T> where T <: Comparable （直接对Class1进行的扩展）

【必写】（定义声明）

```cangjie
...
```

【必写】功能：xxx。

#### func func1()

...

#### ... （给出所有的子API文档，包括成员变量、函数等；顺序和格式与对应API文档一样，包含声明、功能、参数、返回等）

### extend Class1<T> <: B where T <: Comparable （为Class1扩展接口B，且Class1在本包定义）

【必写】（定义声明）

```cangjie
...
```

【必写】功能：xxx。

【涉及必写】父类型：

- [B](link)

#### func aa()

...

#### ... （给出所有实现的子API文档，有默认实现时也要加上，包含比Class1更多的子API）

## class class2

模板同 Class1
