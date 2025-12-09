# 枚举

> **说明：**
>
> 1. 枚举(enum)按 **字母顺序** 展示。
> 2. 对于enum内的子API文档，按 **构造器、表达式、属性(prop)、函数(func)、操作符函数(operator func)** 的类型顺序展示。
> 3. enum的各子类型内部，子API按 **字母顺序** 排列。
> 4. 在文档中提到其他的API都需要使用超链接的方式链过去，例：
>
>    ```text
>    [ArrayList](./xx/xxx.md#class-arraylist)
>    ```

## enum enum1

【必写】（定义声明，每个枚举的声明代码中应包含所有对外的构造器，并按字母序展示）

```cangjie
public enum enum1 {
    | Format1
    | Format2
}
```

【必写】功能：表示xxx枚举类型，支持 `Format1` 和 `Format2` 两种格式。

参考 [功能模块写作规范](../../../../overview.md#功能必写)。

### Format1

【必写】（定义声明）

```cangjie
Format1
```

【必写】功能：构造一个表示 XXX 的枚举实例。

### Format2

```cangjie
Format2
```

【必写】功能：构造一个表示 XXX 的枚举实例。

## enum enum2

【必写】（定义声明）

```cangjie
public enum enum2 {
    | xx
    | xxx
}
```

功能：表示xxx枚举类型，支持 `Format1` 和 `Format2` 两种格式。(*一句话概述API功能*)

【可选】（*功能描述，详细介绍API功能、原理、使用场景等信息*）

【可选】示例：

```cangjie
import xx
...
```

### xx

参考[构造器format1](#format1)

### xxx

参考[构造器format2](#format2)

### func function1(dtype)

参考 [函数内容模板](./xxx_package_funcs.md)
