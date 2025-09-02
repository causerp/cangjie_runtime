# 仓颉运行时与仓颉编程语言标准库

在仓颉编程语言中，程序执行依赖于运行时和标准库的能力。​仓颉运行时作为轻量高效的基础引擎，负责程序运行时的内存、线程等核心资源管理；标准库提供了常用的功能和工具，为开发者构建应用功能奠定了坚实基础。

## 仓颉运行时

### 简介

仓颉运行时是仓颉 Native 后端（CJNative）的核心组件之一，以高性能和轻量化为设计目标，为仓颉语言在全场景下的高性能表现提供有力支持。仓颉运行时作为仓颉程序运行的基础引擎，提供了自动内存管理、线程管理、包管理等基础驱动功能。

![](runtime/figures/cangjie_runtime_zh.png)

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

### 目录

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

### 约束

支持在 Ubuntu/MacOS(x86_64,aarch64) 环境中对仓颉运行时进行构建。更详细的环境及工具依赖请参阅[构建依赖工具](https://gitcode.com/Cangjie/cangjie_build/blob/dev/docs/env_zh.md)。

### 编译构建

#### 构建准备

构建前需要根据目标产物完成编译环境的搭建，详情请查看[仓颉SDK集成构建指导书](https://gitcode.com/Cangjie/cangjie_build/blob/dev/README_zh.md)。

#### 构建步骤

独立构建请执行 `build.py` 脚本，脚本支持构建、安装和清理三个功能。

##### 构建命令

`build` 用于独立构建仓颉运行时，有多个可配置项：

- `--target <value>` 用于指定构建目标。`value` 默认值为 `native`。`value` 的所有可选项为：
  - `natvie` -- 指 Linux/macOS 平台到 native 平台编译构建；
  - `windows-x86_64` -- 指 Linux 平台到 Windows-x86_64 平台的交叉编译构建；
  - `ohos-aarch64` -- 指 Linux 平台到 ohos-aarch64 平台的交叉编译构建；
  - `ohos-x86_64` -- 指 Linux 平台到 ohos-x86_64 平台的交叉编译构建。
- `-t, --build-type <value>` 用于指定构建模式。`value` 的取值包括：`release、debug、relwithdebinfo`，区分大小写，默认值为 `release`。
- `-v, --version <value>` 用于指定仓颉运行时的版本，`value` 默认值为 `0.0.1`。
- `--prefix <value>` 可用于指定构建产物的安装路径，默认安装到 runtime 目录下的 output/common 目录。当 `build` 和 `install` 同时指定了安装路径，后者生效。
- `-hwasan` 用于使能 Hardware-Assisted Address Sanitizer (HWASAN)。
- `--target-toolchain <value>` 用于指定交叉编译的工具链，**交叉编译构建时为必选参数**。工具链配置请参见[构建准备](#构建准备)。

示例：

``` shell
$ python3 build.py build --target native --build-type release -v 0.0.1
```

##### 安装命令

`install` 为安装命令。有一个可选参数：

- `--prefix <value>` 可用于指定构建产物的安装路径。如果不指定安装路径，则根据 `build` 中指定的路径安装编译产物。否则安装到该参数指定的路径。

示例：

``` shell
$ python3 build.py install
```

##### 清理命令

`clean` 为清理命令。会删除所有构建产物及中间产物。

示例：

``` shell
$ python3 build.py clean
```

#### 构建产物
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

### 使用说明

运行时独立构建产物需要配合cjc编译器及标准库等使用，具体集成方式请查看[仓颉SDK集成构建指导书](https://gitcode.com/Cangjie/cangjie_build/blob/dev/README_zh.md)。

##### 下载源码：

``` shell
$ git clone https://gitcode.com/Cangjie/cangjie_runtime.git;
```

## 仓颉编程语言标准库

### 简介

仓颉编程语言标准库（std）是安装仓颉 SDK 时默认自带的库。标准库预先定义了一组函数、类、结构体等，旨在提供常用的功能和工具，以便开发者能够更快速、更高效地编写程序。

仓颉标准库有其三项特点和追求：

- 使用方便：标准库随编译器、工具链一起发布，不需要用户另外下载，开箱即用。
- 功能通用：标准库提供了开发者最常使用的一些库能力，旨在为开发者解决大部分基础问题。
- 质量标杆：标准库追求在性能、代码风格等方面为其他仓颉库树立范例和标杆。

标准库的详细介绍和使用可以参见[仓颉编程语言标准库 API](./std/doc/libs/summary_cjnative.md)。

![](std/figures/cangjie_std_zh.png)

### 目录

主要目录如下：

```
std/libs/std
├── argopt                  #命令行参数字符串解析
├── ast 				    #语法解析器
├── binary 					#提供了基础数据类型和二进制字节数组的不同端序转换接口，以及端序反转接口
├── collection              #常见数据结构的实现、相关抽象的接口的定义以及在集合类型中常用的函数功能
├── console  				#提供和标准输入、标准输出、标准错误进行交互的方法。
├── convert 				#提供从字符串转到特定类型的 Convert 系列函数以及提供格式化能力
├── core 					#标准库的核心包
├── crypto 					#对称加解密和常用摘要算法能力
├── database 				#仓颉访问数据库能力
├── deriving 				#提供一组宏来自动生成接口实现
├── env  					#提供当前进程的相关信息与功能
├── fs 						#文件库
├── io 						#提供程序与外部设备进行数据交换的能力
├── math 				    #数学库
├── net 					#网络通信
├── objectpool 			    #对象缓存
├── overflow 				#溢出处理
├── posix 					#适配 POSIX 系统调用，提供跨平台的系统操作接口
├── process 				#进程库
├── random 					#提供生成伪随机数的能力
├── ref 					#提供了弱引用相关的能力
├── reflect  				#反射功能
├── regex 					#正则库
├── runtime 				#运行时交互
├── sort 					#排序
├── sync 					#并发编程
├── time 					#时间库
├── unicode 				#字符处理
└── unittest 				#用于编写仓颉项目单元测试代码
```

### 约束

支持在 Ubuntu/MacOS(x86_64, aarch64) 环境中对仓颉编译语言标准库进行构建。更详细的环境及工具依赖请参阅[构建依赖工具](https://gitcode.com/Cangjie/cangjie_build/blob/dev/docs/env_zh.md)。

### 编译构建

#### 构建准备

构建前需要完成编译环境的搭建，详情请查看[构建依赖工具](https://gitcode.com/Cangjie/cangjie_build/blob/dev/docs/env_zh.md)

#### 构建步骤

构建标准库之前需要先源码构建本仓的 runtime 和 [cangjie_compiler](https://gitcode.com/Cangjie/cangjie_compiler)，runtime 和 cangjie_compiler 的构建详细见其项目的构建指导。

1. 配置 cjc

   ```
   source <源码构建的cjc路径，如..../output/envsetup.sh>
   ```

   可以通过下面的命令验证cjc是否配置成功，若出现版本信息，证明cjc配置成功

   ```
   cjc -v
   ```

2. 构建命令

   下载源码

   ```
   git clone https://gitcode.com/Cangjie/cangjie_runtime.git
   ```

   进入 std 目录，对标准库源码进行编译，执行 `build.py` 脚本，脚本支持构建、清理、和安装三个功能

   ```
   cd std
   python3 build.py clean
   python3 build.py build -t release --target-lib=<runtime构建产物路径> --target-lib=<openssl lib路径>
   python3 build.py install
   ```

   1. `build.py clean` 命令用于清空工作区临时文件；
   2. `build.py build` 命令开始执行编译：
      - `-t` 即 `--build-type`，指定编译产物类型，可以是 `release` 或 `debug`；
      - `--target-lib` 指定openssl lib目录和runtime二进制产物output目录(默认在项目的runtime/output)
   3. `build.py install` 命令将编译产物安装到 `output` 目录下。
      - `--prefix` 指定安装路径（可选），默认安装在std/output目录

output 目录结构如下：

```
output
├── lib     #标准库static lib
├── modules #标准库cjo文件
└── runtime #标准库dynamic lib
```

#### 使用说明

标准库构建产物需要配合 cjc 编译器及运行时等使用，具体集成方式请查看[仓颉SDK集成构建指导书](https://gitcode.com/Cangjie/cangjie_build/blob/dev/README_zh.md)。

#### 更多构建选项

`build.py` 的 `build` 功能提供如下额外选项：

- `--target`：指定构建平台，默认为native，支持的target如下所示（交叉编译请参考[仓颉SDK集成构建指导书](https://gitcode.com/Cangjie/cangjie_build/blob/dev/README_zh.md)）：
  - `native`（默认值）
  - `ohos-aarch64` ： 交叉编译ohos(aarch64)
  - `ohos-x86_64` ：交叉编译ohos(x86_64)
  - `windows-x86_64` ： linux交叉编译windows
- `--target-toolchain` ：指定编译工具所在路径（交叉编译需要指定）
- `--target-sysroot` ：指定编译目标系统库所在目录（交叉编译需要指定）
- `--build-args` ：cjc构建选项（可选）
- `--jobs(-j)` : 并发构建任务最大数量
- `--hwasan` ：构建hwasan版本std（OHOS交叉编译使用）

`build.py` 的 `install` 功能提供如下额外选项：

- `--prefix`：指定安装目录
- `--host`：指定为哪个target平台安装

您也可以参阅 [build.py](https://gitcode.com/Cangjie/cangjie_runtime/blob/dev/std/build.py) 或通过 `--help` 选项了解更多编译选项：

```
python3 build.py --help
python3 build.py build --help
python3 build.py install --help
```

#### 集成构建指导

集成构建请参阅 [仓颉 SDK 集成构建指导书](https://gitcode.com/Cangjie/cangjie_build/blob/main/README_zh.md)。

## 相关仓

[cangjie_compiler](https://gitcode.com/Cangjie/cangjie_compiler)

[cangjie_runtime](https://gitcode.com/Cangjie/cangjie_runtime)

[cangjie_tools](https://gitcode.com/Cangjie/cangjie_tools)

[cangjie_stdx](https://gitcode.com/Cangjie/cangjie_stdx)

[cangjie_docs](https://gitcode.com/Cangjie/cangjie_docs)

[cangjie_build](https://gitcode.com/Cangjie/cangjie_build)

[cangjie_test](https://gitcode.com/Cangjie/cangjie_test)

## 开源协议

本项目基于 [Apache-2.0 with Runtime Library Exception](./LICENSE)，请自由地享受和参与开源。

## 参与贡献

欢迎广大开发者贡献代码、文档等，具体的贡献流程和方式请参见[参与贡献](https://gitcode.com/openharmony/docs/blob/master/zh-cn/contribute/%E5%8F%82%E4%B8%8E%E8%B4%A1%E7%8C%AE.md)
