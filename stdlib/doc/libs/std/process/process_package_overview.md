# std.process

## 功能介绍

process 包主要提供 Process 进程操作接口，主要包括进程创建，标准流获取，进程等待，进程信息查询等。

## API 列表

### 函数

|  函数名 | 功能  |
| ------------ | ------------ |
| [execute](./process_package_api/process_package_funcs.md#func-executestring-arraystring-path-mapstring-string-processredirect-processredirectprocessredirect-duration) | 根据输入参数创建并运行一个子进程，等待该子进程运行完毕并返回子进程退出状态。 |
| [executeWithOutput](./process_package_api/process_package_funcs.md#func-executewithoutputstring-arraystring-path-mapstring-string-processredirect-processredirect-processredirect) | 根据输入参数创建并运行一个子进程，等待该子进程运行完毕并返回子进程退出状态、标准输出和标准错误。 |
| [findProcess](./process_package_api/process_package_funcs.md#func-findprocessint64) | 根据输入进程 id 绑定一个进程实例。 |
| [launch](./process_package_api/process_package_funcs.md#func-launchstring-arraystring-path-mapstring-string-processredirect-processredirect-processredirect) | 根据输入参数创建并运行一个子进程，并返回一个子进程实例。 |

### 类

|  类名 | 功能  |
| ------------ | ------------ |
| [CurrentProcess <sup>(deprecated)</sup>](./process_package_api/process_package_classes.md#class-currentprocess-deprecated) | 此类为当前进程类，继承 `Process` 类，提供对当前进程操作相关功能。 |
| [Process](./process_package_api/process_package_classes.md#class-process) | 此类为进程类，提供进程操作相关功能。 |
| [SubProcess](./process_package_api/process_package_classes.md#class-subprocess) | 此类为子进程类，继承 `Process` 类，提供对子进程操作相关功能。 |

### 枚举

| 枚举名 | 功能 |
| --------------------------- | ------------------------ |
| [ProcessRedirect](./process_package_api/process_package_enums.md#enum-processredirect) | 用于在创建进程时设置子进程标准流的重定向模式。 |

### 异常类

| 异常类名 | 功能 |
| --------------------------- | ------------------------ |
| [ProcessException](./process_package_api/process_package_exceptions.md#class-processexception) | `process` 包的异常类。 |