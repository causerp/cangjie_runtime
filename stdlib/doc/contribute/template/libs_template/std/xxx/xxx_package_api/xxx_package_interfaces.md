# 接口

> **说明：**
>
> 1. 接口(interface)按 **字母顺序** 展示。
> 2. 对于interface内的子API，按 **属性(prop)、函数(func)、操作符函数(operator func)** 的类型顺序展示。
> 3. interface的各子类型内部，子API按 **字母顺序** 排列。
> 4. 若子类型中重写了父类型的函数，需要在文档中体现该function。
> 5. 在文档中提到其他的API都需要使用超链接的方式链过去，例：
>
>    ```text
>    [ArrayList](./xx/xxx.md#class-arraylist)
>    ```

## interface Interface1

【必写】（定义声明，每个接口的声明代码中应包含所有属性和函数）

```cangjie
public interface Interface1 {
    prop property1: dtype
    func function1()
    operator func ==(Ordering)
}
```

【必写】功能，参考 [功能模块写作规范](../../../../overview.md#功能必写)。

【必写】示例，参考 [示例代码规范及格式要求](../../../../overview.md#示例必写)。

### prop property1

参考 [属性模板](./xxx_package_classes.md#prop-property1)

### func function1()

参考 [函数内容模板](./xxx_package_funcs.md)

### operator func ==(Ordering)

参考 [函数内容模板](./xxx_package_funcs.md)

### extend BigInteger\<T> <: Interface1

【必写】（定义声明）

```cangjie
...
```

【必写】功能：xxx。

【涉及必写】父类型：

- [Interface1](#interface-interface1)

#### func a()

...

#### xxx

### extend Time <: Interface1

【必写】（定义声明）

```cangjie
...
```

【必写】功能：xxx。

【涉及必写】父类型：

- [Interface1](#interface-interface1)

#### func b()

...

#### ... （参考 库文档写作指导及注意事项 libs/api_docs_guide.md）

## interface Interface2

模板同 Interface1
