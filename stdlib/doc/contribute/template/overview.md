# 仓颉编程语言库API文档写作指导

## 库API文档说明

文档层级：

```text
libs // 库文档
  ├── std 
    ├── xxx // 包名
      ├── figures // 如果有图片，包目录下新建 figures 文件夹
      ├── xxx_package_api // 此包内各类型 API 文档
        ├── xxx_package_classes.md // 此包内 class 类型的 API 文档
        ├── xxx_package_funcs.md // 此包内 function 类型的 API 文档
        └── ...
      ├── xxx_samples // 此包内各场景示例教程
      └── xxx_package_overview.md // 包概述，API 汇总页面
    └── std_module_overview.md // 库概述，包汇总页面，展示标准库包含的所有包及各自的功能简介
  └── summary_xxx.md // 文档目录，所有文档需在该文件中“注册”才会最终呈现在构建包中
```

需重点关注 API 文档的**正确性、完备性、易用性、API 源码和文档一致性**，具体要求详见下述 [API 文档常见模块写作要点](#api文档常见模块写作要点)。

## 库概述模板

详见[库概述模板](./libs_template/std/std_module_overview.md)。

## 包文档模板

详见[xxx](./libs_template/std/xxx/xxx_package_overview.md)。

## API文档常见模块写作要点

### 标题（必写）

```text
## 声明关键字 name(param1, param2, ...)
```

- 给出**声明关键字**（`class/func/operator func/enum/interface/struct/extend/prop/let/var/const/type` 各类型，如果是静态需写上`static`）、**API 名称**、**入参类型**（只写参数类型，包括泛型；忽略参数名、默认值和输出等信息）。
- **声明关键字**、**API 名称**、**参数的类型&数量&顺序** 需与声明中完全一致。

### 声明（必写）

```cangjie
(API 定义/签名，与源码一致，用 cangjie 代码块包裹)
```

API 声明范围详见各类型 API 模板。

### 功能（必写）

```text
功能：xxx（一句话优秀地总结）。

（详细描述）
```

- 首先 **一句话总结** API 的功能，这是 API 文档最重要的部分！要求内容正确、简洁、功能完整。句式：

    - 使用一个 `动宾短语`（英文用从句）而不是完整句子，以句号结尾。避免用“该 API 实现了…”类似表达。
    - 描述API `干了什么`，会 `返回什么值`。省略无效影响和空返回值。
    - 用“`构造一个…对象`”（Creates…）句式描述 init 函数的作用。
- 然后写作 API 的 **详细功能描述**（业界常用的简单 API 可省略），该部分可介绍：

    - API 涉及的原理、使用场景和约束（API 间的依赖关系，如果有）等。
    - 对于使用方式较复杂的 API，使用超链接引导到文档中详细说明该 API 的使用方法和约束。
    - 特别是一些不常见术语，或者仓颉有别于其他语言的功能特性，需要展开详细介绍或提供超链接。

### 说明/注意/警告（可选）

```text
> **说明/注意/警告：**
>
> - 这是第一条内容
> - 这是第二条内容
```

格式要求：

- **必须严格按照上述格式**，每行 > 开头，留一个空格，说明字样用双星号包裹，留一个空行再写具体事项。
- 若有多条内容则使用无序列表 -（如上述示例），若只有一条内容则不使用 - 。
- 大段的说明不建议用该格式呈现。

内容按标准严格区分等级：

| 标识符 | 用途/含义 | 典型使用场景举例 |
| ----- | --------- | -------------- |
| 说明  | 用户使用接口过程中提供帮助或有用的参考信息 | - 支撑开发者做出决策的信息（参数选取原则、系统实现机制补充说明等）<br>- 可提升开发效率的信息<br>- 版本差异说明<br>- 依赖说明<br>- 相关参考信息 |
| 注意 | 如未按该注意事项操作，可能会导致任务中断或结果异常，但是可恢复。 | - 导致功能异常<br>- 导致测试失败<br>- 影响系统开销/系统性能<br>- 特性约束限制/版本要求<br>- 影响应用成功安装<br>- 导致进程攻击<br>- 导致内存访问错误或内存损坏<br>- 导致安全类问题（如数据安全/设备安全/帐号安全等）<br>- 导致稳定性问题<br>- 导致兼容性问题<br>- 影响应用分发<br>- 影响设备安全等级评估<br>- 影响用户体验（影响可用带宽、服务使用、电池续航、对应用信任度等） |
| 警告 | 如未按该警告内容操作，可能会导致结果错误或不可预测，且不可恢复。 | - 导致用户数据丢失<br>- 导致硬件损坏<br>- note、warning 的添加需要审核，谨慎添加（是否有必要添加、是否合适、代码支持能力问题/api使用正常限制）。|

### 不支持平台（涉及必写）

库概述里给全量支持的平台，如果涉及某个 API 不支持某些平台，在api功能最后使用说明格式给出不支持的平台。

> **注意：**
>
> 不支持平台：Windows

### 父类型（涉及必写）

若 API 声明中存在 <: ，则其后面的类型为父类型。

**示例1（单个父类型）：**

```cangjie
public class CompressInputStream <: InputStream {
    public init(inputStream: InputStream, wrap!: WrapType = DeflateFormat, compressLevel!: CompressLevel = DefaultCompression, bufLen!: Int64 = 512)
}
```

功能：xxx

父类型：

- [InputStream](link)

> 如果父类型未公开，不体现

**示例2（多个父类型）：**

```cangjie
abstract sealed class ConfigurationKey <: Equatable<ConfigurationKey> & Hashable {
    public override operator func !=(that: ConfigurationKey)
}
```

功能：配置项的键值对象。提供判等及 hashCode 方法。

父类型：

- [Equatable](link)\<[ConfigurationKey](link)>
- [Hashable](link)

### 参数（涉及必写）

```text
参数：

- param: [dtype](link) - 功能 + 使用场景 + 取值范围（如有） + 默认值（&含义）。
```

- 参数名称和顺序需与 API 声明中的参数名称及顺序保持完全一致。
- dtype 给出超链接。
- 参数功能说明必须有效，不能等同于没有解释（如只介绍取值范围、数据类型，而没有给出功能含义）。
- 参数范围不为类型全集时，需要说明取值范围。
- 参数的取值为某些特定的值。如果为某个类型枚举值，加超链接；否则在功能描述中给出每个取值的含义。例如：

  ```text
  xxx 参数取值情况：
  
  - mode1：xxx模式，表示xxx，推荐xxx情况下使用。
  - mode2：xxx模式，表示xxx，推荐xxx情况下使用。
  ```

> Option 和 ? 写法完全等价，与源码写法保持完全一致

### 返回值（涉及必写）

```text
返回值：

- [dtype](link) - xxx。
```

介绍返回值的类型和含义，确保内容正确。dtype 给出超链接。

> 如果返回值是 This、Unit、**Nothing？**，不用体现。

### 异常（涉及必写）

```text
异常：

- [xxxException](link) - 当...时，抛出异常。
- [xxxError](link) - 当...时，产生报错。
```

- 描述关键异常。
- 异常类型给出超链接。
- 异常的说明需符合前文的描述，不能前后矛盾。
- 【建议】将同类异常放在一起。

### 示例（必写）

示例：

```cangjie
import xxx
...
```

给出 API 使用示例，建议分两种情况：

1. 单个 API 强相关 —— 放在 **对应的 API 文档示例** 中；（必写）
2. 与包功能/特性强相关的组合示例或复杂场景示例—— 放在 **示例教程** 目录下，每个场景/特性单独一篇。

示例写作要求：

- 所有 cangjie 代码块示例上方需加上[示例看护标签](#示例看护标签说明)，AP签名除外。
- 示例代码需要典型、完整而且正确运行，避免出现伪代码，要展示输出结果或 size 等有效信息。
- 导入包：确保示例中 import 模块完整且路径正确。
- 传入的参数：示例入参的使用需和 API 中描述的一致。
- 输出结果：输出结果和返回描述的一致，确保正确。
- 注释：复杂/多情况的调用需要添加注释进行说明。**（中文文档使用中文注释）**
- 正例无 warning/error 信息，反例必须出现期望信息：示例代码在 API 所支持的后端上执行不能有报错。
- 参考其他：复用或参考其他的示例，需要在 API 描述或 Note 中指出。

#### 示例看护标签说明

为了检查资料中示例代码的可用性和正确性，所有 cangjie 代码块上方要求加上**形如\<!-- xxx -->的示例看护标签**，示例如下：

`<!-- compile -->`

```cangjie
cangjie code
```

添加标签的规则如下：

1. `<!-- compile -->`：期望编译成功。
2. `<!-- compile.error -->`：期望编译错误。
3. `<!-- run -->`：期望运成功。
4. `<!-- run.error -->`：期望运行错误。
5. `<!-- verify -->`：期望代码输出正确，输出使用`text`。示例：

    `<!-- verify -->`

    ```cangjie
    cangjie code
    ```

    ```text
    output
    ```

6. 使用 `-(name)` 添加自定义文件名，标识同一个示例。

    如果需要将多个代码块放至同一个用例，在各相关代码块标签中添加形如`-(name)`的指定用例名称。注意避免使用`test+数字`的格式，可能会和用例提取工具产生冲突。示例：

    `<!-- run -example -->`

    ```cangjie
    public func foo() {
      println("example")
    }
    ```

    `<!-- run -example -->`

    ```cangjie
    main(): Int64
    {
      foo()
      return 0
    }
    ```

7. 使用 `<!-- cfg="xxx" -->` 添加自定义编译选项。示例：

    `<!-- run -example -->`
    `<!-- cfg="-p a --output-type=staticlib" -->`

    ```cangjie
    cangjie code
    ```

### 扩展 (extend) API 的写法

- **情况1：直接扩展类型 A，扩展内容写在类型 A 中**

  ```text
  ## class A
  ### extend classA<T> where T <: Comparable
  #### func toString()     // 和成员函数文档格式一样
  #### func print()
  #### operator func <(dtype)
  #### operator func >(dtype)
  #### ...
  ```

  详见[class 扩展示例1](./libs_template/std/xxx/xxx_package_api/xxx_package_classes.md#extendt-class1t-where-t--comparable-直接对class1进行的扩展)。

- **情况2：为类型 A 扩展接口 B，A 在本包定义**

  ```text
  ## class A
  ### extend classA<T> <: B where T <: Comparable  
  #### func aa()
  #### func bb()
  #### func cc()        // 有默认实现时也要加上
  #### func dd()        // 有可能有比接口更多的方法
  #### ...
  ```

  详见[class 扩展示例2](./libs_template/std/xxx/xxx_package_api/xxx_package_classes.md#extend-class1--b-where-t--comparable-为class1扩展接口b且class1在本包定义)。
  ...
- **情况3：为类型 A 扩展接口 B，B 在本包 A 不在**

  ```text
  ## interface B
  ### func b()
  ### extend A <: B
  #### func b()
  #### func c()
  ```

  详见[interface 扩展示例](./libs_template/std/xxx/xxx_package_api/xxx_package_interfaces.md#extend-bigintegert--interface1)。

## 其他格式

1. 一篇 markdown 文档内的标题层级不宜过多，如果需要写作超出模板标题层级之外的自定义内容，请适当地使用无序列表：

   ```text
   - xx
   - xxx
   ```

2. 链接的用法：

   ```text
   [呈现文本](网址 or 仓内文档)
   ```

   - 如果链到网址：

     ```text
     [xx 使用指导](https://www.example.com/)。
     ```

   - 如果链到仓内文档：

     ```text
     [描述](./xx/xxx/example.md)
     ```

   **注意**：必须是英文括号。
3. 表格的用法：

   ```text
   | 第一列 | 第二列 | ... |
   | :----- | :------ | :--- |
   | ...   | ...    | ... |
   | ...   | ...    | ... |
   ```

   表格中内容想换行请使用 \<br> 隔开
4. 注意文中专有名词的正确书写。
5. 文中避免使用 html 写法，尽量使用 markdown 自带语法写作（表格中的\<br>和标题中的\<sup>除外）
6. 常用特殊字符标记：

   - 星号： 写法为： \*text\* 是强调 (斜体)，效果为：*text*
   - 双星号： 写法为：\*\*text\*\* 重点强调 (加粗)，效果为：**text**
   - 反引号： 写法为：\`\`text\`\` 代码样式，效果为：``text``

   标记需注意的一些限制：

   - 不能相互嵌套，例如：\`\`\* text\*\`\` 是错误的。
   - \`内容中间不能有空格： 这样写\`\`  text \`\` 是错误的。
   - 特殊字符标记的前后建议用空格隔开，例如：\`init\` 的值可以是 \`ones\` 或 \`zeros\` 等。
   - 如果内容需要特殊字符分隔，使用反斜杠转义。

## 特殊情况

### 默认值非公开，文档中如何写声明？

- 代码里**函数参数/变量的默认值是非公开常量**（基础数值类型）：文档用数值字面量作为初始值。

  代码：

  ```cangjie
  const NUMBER_ONE: Int64 = 1
  public var number: Int64 = NUMBER_ONE
  ```

  文档：

  ```cangjie
  public var number: Int64 = 1
  ```

- 代码里**公开变量的初始值是公开类型的非公开构造方式**：文档不写初始值，只写类型，文字说明其初始值含义。

  代码：

  ```cangjie
  public static let compact: WriteConfig = WriteConfig(_newline: "", _indent: "", ...)
  ```

  文档：

  ```cangjie
  public static let compact: WriteConfig
  （在功能里说明）初始值是一个 newline 为 "xx"、indentx 为 "xx"...的 WriteConfig 对象。
  ```

  ***总之：哪些信息是用户可感知的，就写到文档里，不感知的文档里就不出现！***

- 代码里**函数参数默认值是非公开构造方式**：代码加一个公开常量。

- 代码里**函数返回值非公开**：代码规范层面评审

## 参考

有关 markdown 的常用书写规则，请参考 [Markdown 语法笔记](https://zhuanlan.zhihu.com/p/517670740?utm_id=0)。
