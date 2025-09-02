# cangjie_runtime

仓颉运行时是仓颉 Native 后端（CJNative）的核心组件之一，以高性能和轻量化为设计目标，为仓颉语言在全场景下的高性能表现提供有力支持。

## 目录结构

```
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

## OpenHarmony 如何使用 cangjie_runtime

OpenHarmony 编译使用 cangjie_runtime 目录下的 `src` 源码。仓颉运行时作为仓颉程序运行的基础引擎，提供了自动内存管理、线程管理、包管理等基础驱动功能。

## OpenHarmony 如何集成 cangjie_runtime

仓颉运行时独立构建产物需要配合cjc编译器及标准库等使用，具体集成方式请查看[仓颉SDK集成构建指导书](https://gitcode.com/Cangjie/cangjie_build/blob/dev/README_zh.md)。

## cangjie_runtime 相关内容

[cangjie_runtime 主页](https://gitcode.com/Cangjie/cangjie_runtime)
[cangjie_runtime 文档](https://gitcode.com/Cangjie/cangjie_runtime/blob/dev/README_zh.md)

## License

基于 Apache-2.0 with Runtime Library Exception 协议。

## 风险提示

**cangjie_runtime 是 Apache-2.0 with Runtime Library Exception 协议类型的三方开源软件，使用时需履行相应的开源义务。**
