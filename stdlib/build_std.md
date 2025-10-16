#### Build Preparation

The Cangjie standard library can be built in Ubuntu/MacOS (x86_64, aarch64) environments. Before building, you need to set up the compilation environment. For details, please check the [Build dependency tool](https://gitcode.com/Cangjie/cangjie_build/blob/dev/docs/env_zh.md).

#### Build Steps

Before building the standard library, you need to first build the runtime in this repository and [cangjie_compiler](https://gitcode.com/Cangjie/cangjie_compiler). For detailed build instructions for runtime and cangjie_compiler, please refer to their respective project build guides.

1. Configure cjc

   ```
   source <path to the source-built cjc, e.g., ..../output/envsetup.sh>
   ```

   You can verify if cjc is configured successfully using the command below. If version information appears, it indicates that cjc is configured successfully.


   ```
   cjc -v
   ```

2. Build Commands

   Download the source code

   ```
   git clone https://gitcode.com/Cangjie/cangjie_runtime.git
   ```

   Enter the std directory, compile the standard library source code by executing the `build.py` script, which supports three functions: build, clean, and install.


   ```
   cd std
   python3 build.py clean
   python3 build.py build -t release --target-lib=<path to runtime build output directory> --target-lib=<path to openssl lib>
   python3 build.py install
   ```

   1. `build.py clean` command is used to clear temporary files in the workspace;
   2. `build.py build` command starts the compilation：
      - `-t` or `--build-type`，specifies the type of build artifact, which can be either `release` or `debug`;
      - `--target-lib` specifies the openssl lib directory and the output directory for runtime binary artifacts(By default, it is under runtime/output)
   3. `build.py install` ommand installs the build artifacts to the `output` directory.
      - `--prefix` specifies the installation path (optional), by default it installs in the std/output directory

The output directory structure is as follows:

```
output
├── lib     #std static lib
├── modules #std cjo file
└── runtime #std dynamic lib
```

#### More Build Options

The build functionality of build.py provides the following additional options:

- `--target`: Specifies the build platform, defaults to native build, supported targets are shown below(For cross-compilation, please refer to [Cangjie SDK Integration Build Guide](https://gitcode.com/Cangjie/cangjie_build/blob/dev/README_zh.md)):
  - `native` (default value)
  - `ohos-aarch64`: Cross-compile for ohos(ohos-aarch64)
  - `ohos-x86_64`: Cross-compile for ohos(ohos-x86_64)
  - `windows-x86_64`: Cross-compile Windows from Linux
- `--target-toolchain`: Specifies the path to compilation tools (required for cross-compilation)
- `--target-sysroot`: Specifies the directory of target system libraries (required for cross-compilation)
- `--build-args`: cjc build options (optional)
- `--jobs(-j)`: maximum number of concurrent build tasks
- `--hwasan`：Building the HWASAN version of std (for OHOS cross-compilation)

The install functionality of build.py provides the following additional options:

- `--prefix`: Specifies the installation directory
- `--host`: Specifies which target platform to install for

You can also refer to [build.py](https://gitcode.com/Cangjie/cangjie_runtime/blob/dev/std/build.py) or use the `--help` option to learn more about compilation options:

```
python3 build.py --help
python3 build.py build --help
python3 build.py install --help
```