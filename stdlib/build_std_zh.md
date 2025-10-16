# 仓颉编程语言 - 标准库编译构建

## 构建准备

构建前需要完成编译环境的搭建，详情请查看[构建依赖工具](https://gitcode.com/Cangjie/cangjie_build/blob/dev/docs/env_zh.md)

## 构建步骤

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

## 更多构建选项

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