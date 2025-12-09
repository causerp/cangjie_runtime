# 仓颉编程语言库概述

*整体介绍什么是仓颉编程语言库，使用编程语言库对用户有哪些好处或者优势，编程语言库的组织形式（按照模块划分，一个模板包含多个软件包，不同的包提供不同的功能？）*

## 平台支持说明

【例】

标准库提供的 API 支持在如下操作系统上运行：

> **注意：**
>
> 部分 API 不支持在特定的操作系统运行，详情请参见对应 API 描述。

| 操作系统       | CPU 架构  | 环境及其版本要求 |
| ------------- | --------- | --------------- |
| Linux         | x86_64    | glibc 2.22；Linux Kernel 4.12 或更高版本；系统安装 libstdc++ 6.0.24 或更高版本 |
| Linux         | aarch64   | glibc 2.27；Linux Kernel 4.15 或更高版本；系统安装 libstdc++ 6.0.24 或更高版本 |
| Windows       | x86_64    | Windows 10 或更高版本 |
| macOS         | aarch64   | macOS 12.0 或更高版本 |
| OpenHarmony   | aarch64   | OpenHarmony 5.1 或更高版本 |
| OpenHarmony   | arm32     | OpenHarmony 5.1 或更高版本 |
| HarmonyOS     | aarch64   | HarmonyOS 5.1 或更高版本 |
| iOS           | aarch64   | iOS 11 或更高版本（ast 库需要 iOS 12 或更高版本） |
| Android       | aarch64   | Android API 26 或更高版本 |
| ...           | ...       | ... |

## 使用指导

介绍如何使用编程语言库，包括模块、包的使用，例如通过在代码xxx位置导入模块、导入包。

整体流程（如果有的话，比如在xx阶段导入，然后调用里面的接口、类等）、导入格式

编程语言库中的包，提供了函数、类、xx、xx等接口。导入包后，在代码中可以调用包提供的接口，导入包的格式如下（其中 *package_name* 为实际的模块名称 ）：

```cangjie
import package_name
```

## 包列表

当前仓颉编程语言xx库提供了如下模块：

| 模块名                                                     | 功能      |
| --------------------------------------------------------- | --------- |
| [std.core](./xxx/xxx_package_overview.md)        | ......... |
| [std.xxx](./xxx/xxx_package_overview.md)         | ......... |
| ...                                                       | ......... |
