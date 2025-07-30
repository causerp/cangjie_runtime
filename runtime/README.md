# Cangjie Runtime

## Introduction

The Cangjie runtime is one of the core components of the Cangjie Native backend (CJNative), designed with high performance and lightweight as its goals, and provides strong support for the high performance of the Cangjie language in all scenarios. As the fundamental engine for running Cangjie programs, the Cangjie runtime provides basic driving functions such as garbage collection (GC), CJThread, and loader.

![](figures/cangjie_runtime.png)

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

## Directory Structure

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

## Compilation & Build

### Build Preparation

Before building, you need to set up the compilation environment according to the target output. For details, please refer to the [Cangjie SDK Integration and Build Guide](https://gitcode.com/Cangjie/cangjie_build).

#### Download the source code:

``` shell
$ git clone https://gitcode.com/Cangjie/cangjie_runtime.git;
```

### Build Steps

For standalone builds, please run the `build.py` script, which supports three functions: build, install, and clean.

#### Build Command

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

#### Install Command
The `install` command can install the compiled output to the desired location. There is an optional parameter:

- `--prefix <value>` specifies the installation path for build outputs. If not provided, outputs will be installed to the path specified by the `build` command. Otherwise, they will be installed to the path specified by this parameter.

Example:

``` shell
$ python3 build.py install
```

#### Clean Command
The `clean` command can be executed to remove all build outputs and intermediate files.

Example:

``` shell
$ python3 build.py clean
```

### Build Output
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

## Usage

The standalone build outputs must be used together with the `cjc` compiler and the standard library.
For integration details, please refer to the [Cangjie SDK Integration and Build Guide](https://gitcode.com/Cangjie/cangjie_build).

## Repositories Involved

[cangjie_compiler](https://gitcode.com/Cangjie/cangjie_compiler)

[**cangjie_runtime**](https://gitcode.com/Cangjie/cangjie_runtime)

[cangjie_tools](https://gitcode.com/Cangjie/cangjie_tools)

[cangjie_stdx](https://gitcode.com/Cangjie/cangjie_stdx)

[cangjie_docs](https://gitcode.com/Cangjie/cangjie_docs)

[cangjie_build](https://gitcode.com/Cangjie/cangjie_build)

[cangjie_test](https://gitcode.com/Cangjie/cangjie_test)
