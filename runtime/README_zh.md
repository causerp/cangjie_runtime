# 仓颉运行时

## 简介

仓颉运行时是仓颉 Native 后端（CJNative）的核心组件之一，以高性能和轻量化为设计目标，为仓颉语言在全场景下的高性能表现提供有力支持。仓颉运行时作为仓颉程序运行的基础引擎，提供了自动内存管理、线程管理、包管理等基础驱动功能。

![](figures/cangjie_runtime_zh.png)

**仓颉运行时架构图说明**

- **自动内存管理**使用了低时延的全并发内存整理算法，其核心目标是追求更低的业务时延与更低的内存开销，帮助开发者更好地聚焦业务本身。
    - 全并发垃圾回收：消除全局暂停（Stop-The-World, STW），优化执行时延。
    - 内存整理：通过对象搬移整理堆内存，提高内存利用率，支持应用长时在线。
    - 指针标记：在引用对象处对指针加上标记，以区分指针是垃圾内存还是被复用的新内存，保证全并发垃圾回收的正确性。

- **线程管理**提供了更轻量，更具弹性能力的线程管理方案，能更好地应对各种体量的并发场景。
    - 仓颉线程调度：包含了执行线程、监视器、处理器、调度器等基本模块。各个模块承担不同的任务，使得仓颉进程可以在充分利用多核心硬件资源的基础上进一步扩展并发能力。
    - 仓颉栈扩缩容：仓颉栈采用连续栈，当使用达到上限之后，自动扩容至 2 倍大小。

- **异常管理**提供了两类异常处理方式。从严重程度可分为 `Exception` 和 `Error` ：
    - `Exception` 类描述的是程序运行时的逻辑错误或者 `IO` 错误导致的异常，例如数组越界或者试图打开一个不存在的文件等。这类异常需要在程序中捕获处理。
    - `Error` 类描述仓颉语言运行时，系统内部错误和资源耗尽错误，应用程序不应该抛出这种类型的错误，如果出现内部错误，只能通知给用户，尽快安全终止程序。

- **回栈**使用了基于 `frame pointer` 的栈回溯方式。即使用 `rbp` 寄存器保存栈帧地址，`rsp` 寄存器保存栈顶指针，在过程调用时将上一个栈帧地址入栈保存。

- **包管理**支持以仓颉包为粒度加载和管理仓颉代码，支持反射特性。

- **仓颉对象模型**包含仓颉对象元数据、成员信息、方法信息和方法表。为仓颉对象的创建、管理、调用和释放提供支持。

- **跨语言调用**通过外部函数接口实现仓颉语言和 `C`、`ArkTs` 之间的函数调用和数据交互。

- **DFX**提供日志打印、`CPU` 采集、堆快照导出等调试调优功能，支持运行时状态检测和故障排查。

## 目录

``` text
/runtime
├─ src                  # 仓颉运行时，包括内存管理模块、异常处理模块等
|   ├─ arch_os          # 硬件平台适配代码
|   ├─ Base             # 日志等基础能力模块
|   ├─ CJThread         # 仓颉线程管理模块
|   ├─ Common           # 通用模块
|   ├─ Concurrency      # 并发管理模块
|   ├─ CpuProfiler      # CPU 采集工具
|   ├─ Demangler        # 符号去混淆工具
|   ├─ Exception        # 异常处理模块
|   ├─ Heap             # 内存管理模块
|   ├─ Inspector        # DFX 工具
|   ├─ Loader           # 加载器
|   ├─ Mutator          # GC 与业务线程状态同步模块
|   ├─ ObjectModel      # 对象模型
|   ├─ os               # 软件平台适配代码
|   ├─ Signal           # 信号管理模块
|   ├─ StackMap         # 回栈元数据分析模块
|   ├─ Sync             # 同步原语实现模块
|   ├─ UnwindStack      # 回栈模块
|   ├─ Utils            # 工具类
└─ build                # 编译构建工具、脚本等
```

## 编译构建

### 构建准备

构建前需要根据目标产物完成编译环境的搭建，详情请查看[仓颉SDK集成构建指导书](https://gitcode.com/Cangjie/cangjie_build)

### 构建步骤

独立构建请执行 `build.py` 脚本，脚本支持构建、安装和清理三个功能。

#### 构建命令

`build` 用于独立构建仓颉运行时，有多个可配置项：

- `--target <value>` 用于指定构建目标。`value` 默认值为 `native`。`value` 的所有可选项为：
  - `natvie` -- 指 Linux/macOS 平台到 native 平台编译构建；
  - `windows-x86_64` -- 指 Linux 平台到 Windows-x86_64 平台的交叉编译构建；
  - `ohos-aarch64` -- 指 Linux 平台到 ohos-aarch64 平台的交叉编译构建；
  - `ohos-x86_64` -- 指 Linux 平台到 ohos-x86_64 平台的交叉编译构建。
- `-t, --build-type <value>` 用于指定构建模式。`value` 的取值包括：`release、debug、relwithdebinfo`，区分大小写，默认值为 `release`。
- `-v, --version <value>` 用于指定仓颉运行时的版本，`value` 默认值为 `0.0.1`
- `--prefix <value>` 可用于指定构建产物的安装路径，默认安装到 runtime 目录下的 output/common 目录。当 `build` 和 `install` 同时指定了安装路径，后者生效。
- `-hwasan` 用于使能 Hardware-Assisted Address Sanitizer (HWASAN)。
- `--target-toolchain <value>` 用于指定交叉编译的工具链，**交叉编译构建时为必选参数**。工具链配置请参见[构建准备](#构建准备)。

示例：

``` shell
$ python3 build.py build --target native --build-type release -v 0.0.1
```

#### 安装命令

`install` 为安装命令。有一个可选参数：

- `--prefix <value>` 可用于指定构建产物的安装路径。如果不指定安装路径，则根据 `build` 中指定的路径安装编译产物。否则安装到该参数指定的路径。

示例：

``` shell
$ python3 build.py install
```

#### 清理命令

`clean` 为清理命令。会删除所有构建产物及中间产物。

示例：

``` shell
$ python3 build.py clean
```

### 构建产物
```
/runtime
└─ output
    ├─ common           # 编译产物默认安装路径
    |    └─ <target_platform>_<build_type>_<target_arch>  # 产物描述
    |       ├─ bin      # 可执行文件
    |       ├─ include  # 头文件
    |       ├─ lib      # 静态库等
    |       └─ runtime  # 动态库等
    └─ temp             # 临时产物路径
```

## 使用说明

运行时独立构建产物需要配合cjc编译器及标准库等使用，具体集成方式请查看[仓颉SDK集成构建指导书](https://gitcode.com/Cangjie/cangjie_build)

#### 下载源码：

``` shell
$ git clone https://gitcode.com/Cangjie/cangjie_runtime.git;
```

## 相关仓

[cangjie_compiler](https://gitcode.com/Cangjie/cangjie_compiler)

[**cangjie_runtime**](https://gitcode.com/Cangjie/cangjie_runtime)

[cangjie_tools](https://gitcode.com/Cangjie/cangjie_tools)

[cangjie_stdx](https://gitcode.com/Cangjie/cangjie_stdx)

[cangjie_docs](https://gitcode.com/Cangjie/cangjie_docs)

[cangjie_build](https://gitcode.com/Cangjie/cangjie_build)

[cangjie_test](https://gitcode.com/Cangjie/cangjie_test)
