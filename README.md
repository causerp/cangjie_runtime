# Cangjie Runtime and Cangjie Standard Library

In the Cangjie programming language, program execution relies on the capabilities of both the runtime and the standard library. The ​​Cangjie runtime​​ serves as a lightweight and efficient foundational engine, managing core resources like memory and threads during program execution; while the Cangjie programming language library​​ provides common functions and tools, laying a solid groundwork for developers to build application features.

## Cangjie Runtime

### Introduction

The Cangjie runtime is one of the core components of the Cangjie Native backend (CJNative), designed with high performance and lightweight as its goals, and provides strong support for the high performance of the Cangjie language in all scenarios. As the fundamental engine for running Cangjie programs, the Cangjie runtime provides basic driving functions such as garbage collection (GC), CJThread, and loader.

The Cangjie standard library (std) is built on a lower layer based on compiler frontend, middle-end, backend, and runtime, as shown in the figure.

![](runtime/figures/cangjie_runtime.png)

**Cangjie Runtime Architecture**

- **Garbage Collection** uses a low-latency, fully concurrent memory compact algorithm, with the core goal of achieving lower latency and lower memory overhead, helping developers focus better on the programming itself.
    - Fully Concurrent GC：Eliminate Stop-The-World (STW) pauses and optimize execution latency.
    - Sweep：Defragment heap memory through object relocation to improve memory utilization and support long-running applications.
    - Pointer Tag：Apply pointer tagging at reference to distinguish between garbage memory and newly reused memory, ensuring correctness of fully concurrent GC.

- **CJThread** provides a lighter and more flexible thread management solution, capable of better handling various scales of concurrent scenarios.
    - Schedule：The Schedule encompasses fundamental modules such as thread, monitor, processor, and schmon. Each module undertakes distinct responsibilities, enabling the Cangjie runtime to fully leverage multi-core hardware resources and further scale its concurrency capabilities.
    - Stack Grow：CJThread employs a contiguous stack that automatically doubles in size once it reaches its capacity limit.

- **Exception** provides Two types of exception handling mechanisms, categorized by severity into `Exceptions` and `Errors`:
    - `Exception` represents exceptions caused by runtime logical errors or `IO` failures, such as array index out of bounds or attempting to open a non-existent file. These exceptions must be explicitly caught and handled in the program.
    - `Error` represents internal system errors and resource exhaustion conditions within the Cangjie runtime. Applications should not throw errors of this type. When an internal error occurs, the application should notify the user and terminate safely as soon as possible.

- **Stack Trace** implements a frame-pointer-based stack unwinding mechanism where the `rbp` register stores the base address of the current stack frame, and the `rsp` register stores the stack top pointer. Upon function calls, the address of the previous stack frame is pushed onto the stack for preservation.

- **Loader** supports loading and managing Cangjie code at the package granularity, with reflection capabilities.

- **Object Module** contains Cangjie object metadata, member information, method details, and method tables. Support for the creation, management, invocation, and release of Cangjie objects.

- **FFI** enables function calls and data exchange between the Cangjie and `C/ArkTS`.

- **DFX** provides debugging and tuning capabilities such as log, `CPU` profiling, heap snapshot, and supports runtime state inspection and fault diagnosis.

### Directory Structure

```
/runtime
├─ src                  # Implementation of Cangjie Runtime, including memory management, Cangjie thread management, etc
|   ├─ arch_os          # Hardware platform adaptation code
|   ├─ Base             # Basic function module
|   ├─ CJThread         # Cangjie thread management
|   ├─ Common           # Common module
|   ├─ Concurrency      # Concurrency interfaces
|   ├─ CpuProfiler      # Cangjie CPUProfiler
|   ├─ Demangler        # Cangjie Demangler
|   ├─ Exception        # Exception handling
|   ├─ Heap             # Memory management
|   ├─ Inspector        # DFX Utilities
|   ├─ Loader           # Cangjie Loader
|   ├─ Mutator          # Handling mutator state when GC
|   ├─ ObjectModel      # Cangjie object model
|   ├─ os               # Software platform adaptation code
|   ├─ Signal           # Signal management
|   ├─ StackMap         # Stack metadata analysis module
|   ├─ Sync             # Implementation of Synchronization
|   ├─ UnwindStack      # Stack unwinding
|   ├─ Utils            # General Utility Classes
└─ build                # Compile build tools, scripts, etc
```

### Constraints

Building the Cangjie runtime is supported on Ubuntu/MacOS (x86_64, aarch64) environments. For more details on environment and tool dependencies, please refer to the [Build Dependency Tools](https://gitcode.com/Cangjie/cangjie_build/blob/dev/docs/env_zh.md).

### Compilation & Build

#### Build Preparation

Before building, you need to set up the compilation environment according to the target output. For details, please refer to the [Cangjie SDK Integration and Build Guide](https://gitcode.com/Cangjie/cangjie_build).

##### Download the source code:

``` shell
$ git clone https://gitcode.com/Cangjie/cangjie_runtime.git;
```

#### Build Steps

For standalone builds, please run the `build.py` script, which supports three functions: build, install, and clean.

##### Build Command

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

##### Install Command
The `install` command can install the compiled output to the desired location. There is an optional parameter:

- `--prefix <value>` specifies the installation path for build outputs. If not provided, outputs will be installed to the path specified by the `build` command. Otherwise, they will be installed to the path specified by this parameter.

Example:

``` shell
$ python3 build.py install
```

##### Clean Command
The `clean` command can be executed to remove all build outputs and intermediate files.

Example:

``` shell
$ python3 build.py clean
```

#### Build Output
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

### Usage

The standalone build outputs must be used together with the `cjc` compiler and the standard library.
For integration details, please refer to the [Cangjie SDK Integration and Build Guide](https://gitcode.com/Cangjie/cangjie_build).

## Cangjie Programming Language Library

### Introduction

The Cangjie Programming Language Standard Library (std) is a library that comes bundled with the Cangjie SDK by default. The standard library pre-defines a set of functions, classes, structures, etc., aimed at providing common functionalities and tools to help developers write programs more quickly and efficiently.

The Cangjie Standard Library has three key characteristics and goals:

- Convenience: The standard library is distributed with the compiler and toolchain, requiring no additional downloads from users, making it ready to use right out of the box.
- Universal Functionality: The standard library provides the most commonly used library capabilities for developers, aiming to solve most basic problems.
- Quality Benchmark: The standard library strives to set an example and benchmark for other Cangjie libraries in terms of performance, code style, etc.


For a detailed introduction and usage of the standard library, please refer to the [official standard library documentation](https://cangjie-lang.cn/docs?url=%2F1.0.0%2Flibs%2Fstd%2Fstd_module_overview.html).

![](std/figures/cangjie_std.png)

### Directory

The main directories are as follows:

```
std/libs/std
├── argopt                  # Command line argument string parsing
├── ast                     # Syntax parser
├── binary                  # Provides interfaces for endian conversion of basic data types and binary byte arrays, as well as endian reversal interfaces
├── collection              # Implementation of common data structures, definition of relevant abstract interfaces, and common function features in collection types
├── console                 # Provides methods for interacting with standard input, standard output, and standard error
├── convert                 # Provides Convert series functions for converting from strings to specific types and formatting capabilities
├── core                    # Core package of the standard library
├── crypto                  # Symmetric encryption/decryption and common digest algorithm capabilities
├── database                # Cangjie database access capabilities
├── deriving                # Provides a set of macros to automatically generate interface implementations
├── env                     # Provides information and functionality related to the current process
├── fs                      # File library
├── io                      # Provides the ability for programs to exchange data with external devices
├── math                    # Math library
├── net                     # Network communication
├── objectpool              # Object caching
├── overflow                # Overflow handling
├── posix                   # POSIX system interface adaptation
├── process                 # Process library
├── random                  # Provides the ability to generate pseudo-random numbers
├── ref                     # Provides weak reference capabilities
├── reflect                 # Reflection functionality
├── regex                   # Regular expression library
├── runtime                 # Runtime interaction
├── sort                    # Sorting
├── sync                    # Concurrent programming
├── time                    # Time library
├── unicode                 # Character processing
└── unittest                # For writing unit test code for Cangjie projects
```

### Constraints

Building the Cangjie runtime is supported on Ubuntu/MacOS (x86_64, aarch64) environments. For more details on environment and tool dependencies, please refer to the [Build Dependency Tools](https://gitcode.com/Cangjie/cangjie_build/blob/dev/docs/env_zh.md).

### Compilation and Building

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

#### Usage Instructions

The standard library build artifacts need to be used with the cjc compiler and runtime, etc. For specific integration methods, please see the [Cangjie Programming Language Standard Library API](./std/doc/libs/summary_cjnative_EN.md).

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

#### Integration Build Guide

For integration building, please refer to the [Cangjie SDK Integration Build Guide](https://gitcode.com/Cangjie/cangjie_build/blob/dev/README_zh.md).

## Repositories Involved

[cangjie_compiler](https://gitcode.com/Cangjie/cangjie_compiler)

[cangjie_runtime](https://gitcode.com/Cangjie/cangjie_runtime)

[cangjie_tools](https://gitcode.com/Cangjie/cangjie_tools)

[cangjie_stdx](https://gitcode.com/Cangjie/cangjie_stdx)

[cangjie_docs](https://gitcode.com/Cangjie/cangjie_docs)

[cangjie_build](https://gitcode.com/Cangjie/cangjie_build)

[cangjie_test](https://gitcode.com/Cangjie/cangjie_test)

## Open Source License
This project is licensed under [Apache-2.0 with Runtime Library Exception](./LICENSE). Please enjoy and participate in open source freely.

## Contribution Guide

Welcome all developers to contribute code, documentation, and more. For specific contribution processes and methods, please refer to the [Contribution Guide](https://gitcode.com/openharmony/docs/blob/master/en/contribute/contribution-guide.md).
