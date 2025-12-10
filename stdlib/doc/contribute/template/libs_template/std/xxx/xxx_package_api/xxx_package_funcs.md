# 函数

> **说明：**
>
> 1. 函数API按 **字母顺序** 排列。
> 2. 在文档中提到其他的API都需要使用超链接的方式链过去，例：
>
>    ```text
>    [ArrayList](./xx/xxx.md#class-arraylist)
>    ```

## func func1(dtype1, dtype2)（参考 [API标题写作规范](../../../../overview.md#标题必写)）

【必写】（定义声明）

```cangjie
public func func1(param1: dtype1, param2: dtype2)
```

【必写】功能，参考 [功能模块写作规范](../../../../overview.md#功能必写)。

【可选】说明/注意/警告事项，参考 [说明/注意/警告写作规范](../../../../overview.md#说明注意警告可选)。

【涉及必写】参数：

- param1: [dtype](link) - 功能 + 取值范围(如有) + 默认值&含义(如有)。
- param2: [dtype](link) - ...

参考 [参数模块写作规范](../../../../overview.md#参数涉及必写)。

【涉及必写】返回值：

- [dtype](link) - xxx。

参考 [返回模块写作规范](../../../../overview.md#返回值涉及必写)。

【可选】异常：

- [xxxException](link) - 当...时，抛出异常。
- [xxxError](link) - 当...时，产生报错。

参考 [异常模块写作规范](../../../../overview.md#异常涉及必写)。

【必写】示例，参考 [示例代码规范及格式要求](../../../../overview.md#示例必写)。

## func func2(dtype1)

模板同 func1
