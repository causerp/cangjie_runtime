# Build Cangjie Runtime

To build the Cangjie Runtime, please refer to [Build Cangjie Runtime](https://gitcode.com/Cangjie/cangjie_build/blob/dev/docs/build_runtime_zh.md).

## Build Preparation

Before building, you need to set up the compilation environment according to the target output. For details, please refer to the [Cangjie SDK Integration and Build Guide](https://gitcode.com/Cangjie/cangjie_build).

## Download the source code:

``` shell
$ git clone https://gitcode.com/Cangjie/cangjie_runtime.git;
```

## Build Steps

For standalone builds, please run the `build.py` script, which supports three functions: build, install, and clean.

## Build Command

The `build` command is used to independently construct the Cangjie runtime environment and supports multiple configurable options:

- `--target <value>` specifies the build target. Default `value`: `native`. Available options:
  - `native` -- refers to compiling and building from Linux/macOS to the native   platform;
  - `windows-x86_64` -- refers to cross-compiling and building from Linux to the   Windows-x86_64 platform;
  - `ohos-aarch64` -- refers to cross-compiling and building from Linux to the   ohos-aarch64 platform;
  - `ohos-x86_64` -- refers to cross-compiling and building from Linux to the ohos-x86_64 platform.
- `-t, --build-type <value>` specifies the build configuration. Valid values: `release, debug, relwithdebinfo`. Default: `release`.
- `-v, --version <value>` sets the version number for the Cangjie runtime. Default: `0.0.1`.
- `--prefix <value>` defines the installation path for build outputs. Defaults to `runtime/output/common`. If both `build` and `install` specify paths, install takes precedence.
- `-hwasan` enables Hardware-Assisted Address Sanitizer (HWASAN).
- `--target-toolchain <value>` specifies the toolchain for cross-compilation. **Required for cross-compilation builds**. See [Build Preparation](#build-preparation) for toolchain configuration details.

Example:

``` shell
$ python3 build.py build --target native --build-type release -v 0.0.1
```

## Install Command
The `install` command can install the compiled output to the desired location. There is an optional parameter:

- `--prefix <value>` specifies the installation path for build outputs. If not provided, outputs will be installed to the path specified by the `build` command. Otherwise, they will be installed to the path specified by this parameter.

Example:

``` shell
$ python3 build.py install
```

## Clean Command
The `clean` command can be executed to remove all build outputs and intermediate files.

Example:

``` shell
$ python3 build.py clean
```

## Build Output
```
/runtime
└─ output
    ├─ common           # Default installation path for compiled outputs
    |    └─ <target_platform><build_type><target_arch>  # outputs descriptor
    |       ├─ bin      # Executable files
    |       ├─ include  # Header files
    |       ├─ lib      # Static libraries, etc.
    |       └─ runtime  # Dynamic libraries, etc.
    └─ temp             # Temporary outputs path
```
