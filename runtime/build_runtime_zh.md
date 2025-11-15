# 构建仓颉运行时

## 构建准备

构建前需要根据目标产物完成编译环境的搭建，详情请查看[仓颉SDK集成构建指导书](https://gitcode.com/Cangjie/cangjie_build/blob/dev/README_zh.md)。

## 构建步骤

独立构建请执行 `build.py` 脚本，脚本支持构建、安装和清理三个功能。

## 构建命令

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