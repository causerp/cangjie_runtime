# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${BOUNDSCHECK_INCLUDE})
if (WINDOWS_FLAG MATCHES 1)
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/os/Windows)
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/Mutator)
endif()

if (BUILD_RUNTIME)
    add_subdirectory(Base)
    add_subdirectory(Common)
    add_subdirectory(Concurrency)
    add_subdirectory(Demangler)
    add_subdirectory(Loader)
    add_subdirectory(Inspector)
    add_subdirectory(Exception)
    add_subdirectory(Heap)
    add_subdirectory(Mutator)
    add_subdirectory(ObjectModel)
    add_subdirectory(UnwindStack)
    add_subdirectory(Sync)
    add_subdirectory(CpuProfiler)
    if (WINDOWS_FLAG MATCHES 0)
        add_subdirectory(Signal)
    endif()
    if(SANITIZER_SUPPORT_FLAG OR GWPASAN_SUPPORT_FLAG)
        add_subdirectory(Sanitizer)
    endif()

    # set(CMAKE_C_FLAGS "-O2 -fPIC -std=c99")
    # set(CMAKE_ASM_FLAGS "-O2 -fPIC -std=gnu++14")

    if ((CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64") AND (MACOS_FLAG MATCHES 1))
    set(SRC_LIST
        "CompilerCalls.cpp"
        "ExceptionManager.cpp"
        "StackManager.cpp"
        "HeapManager.cpp"
        "LoaderManager.cpp"
        "SignalManager.cpp"
        "TypeInfoManager.cpp"
        "LogManager.cpp"
        "CangjieRuntime.cpp"
        "CjScheduler.cpp"
        "CjTimer.cpp"
        "CangjieRuntimeApi.cpp"
        "arch_os/x86_64_macos/N2CStub.S"
        "arch_os/x86_64_macos/C2NStub.S"
        "arch_os/x86_64_macos/CalleeSavedStub.S"
        "arch_os/x86_64_macos/StackGrowStub.S"
        "arch_os/x86_64_macos/HandleSafepointStub.S"
        "os/Linux/Loader.cpp"
        "os/Linux/Path.cpp"
    )
elseif ((CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64") AND (WINDOWS_FLAG MATCHES 0))
    set(SRC_LIST
        "CompilerCalls.cpp"
        "ExceptionManager.cpp"
        "StackManager.cpp"
        "HeapManager.cpp"
        "LoaderManager.cpp"
        "SignalManager.cpp"
        "TypeInfoManager.cpp"
        "LogManager.cpp"
        "CangjieRuntime.cpp"
        "CjScheduler.cpp"
        "CjTimer.cpp"
        "CangjieRuntimeApi.cpp"
        "arch_os/x86_64_linux/N2CStub.S"
        "arch_os/x86_64_linux/C2NStub.S"
        "arch_os/x86_64_linux/CalleeSavedStub.S"
        "arch_os/x86_64_linux/StackGrowStub.S"
        "arch_os/x86_64_linux/HandleSafepointStub.S"
        "os/Linux/Loader.cpp"
        "os/Linux/Path.cpp"
    )
elseif ((CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64") AND (MACOS_FLAG MATCHES 1))
    set(SRC_LIST
        "CompilerCalls.cpp"
        "ExceptionManager.cpp"
        "StackManager.cpp"
        "HeapManager.cpp"
        "LoaderManager.cpp"
        "SignalManager.cpp"
        "TypeInfoManager.cpp"
        "LogManager.cpp"
        "CangjieRuntime.cpp"
        "CjScheduler.cpp"
        "CjTimer.cpp"
        "CangjieRuntimeApi.cpp"
        "arch_os/aarch64_macos/N2CStub.S"
        "arch_os/aarch64_macos/C2NStub.S"
        "arch_os/aarch64_macos/CalleeSavedStub.S"
        "arch_os/aarch64_macos/StackGrowStub.S"
        "arch_os/aarch64_macos/HandleSafepointStub.S"
        "os/Linux/Loader.cpp"
        "os/Linux/Path.cpp"
    )
elseif ((CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64") AND (WINDOWS_FLAG MATCHES 0))
    set(SRC_LIST
        "CompilerCalls.cpp"
        "ExceptionManager.cpp"
        "StackManager.cpp"
        "HeapManager.cpp"
        "LoaderManager.cpp"
        "SignalManager.cpp"
        "TypeInfoManager.cpp"
        "LogManager.cpp"
        "CangjieRuntime.cpp"
        "CjScheduler.cpp"
        "CjTimer.cpp"
        "CangjieRuntimeApi.cpp"
        "arch_os/aarch64_linux/N2CStub.S"
        "arch_os/aarch64_linux/C2NStub.S"
        "arch_os/aarch64_linux/CalleeSavedStub.S"
        "arch_os/aarch64_linux/StackGrowStub.S"
        "arch_os/aarch64_linux/HandleSafepointStub.S"
        "os/Linux/Loader.cpp"
        "os/Linux/Path.cpp"
    )
elseif (WINDOWS_FLAG MATCHES 1)
    set(SRC_LIST
        "CompilerCalls.cpp"
        "ExceptionManager.cpp"
        "StackManager.cpp"
        "HeapManager.cpp"
        "LoaderManager.cpp"
        "LogManager.cpp"
        "TypeInfoManager.cpp"
        "CangjieRuntime.cpp"
        "CjScheduler.cpp"
        "CjTimer.cpp"
        "CangjieRuntimeApi.cpp"
        "arch_os/x86_64_windows/N2CStub.S"
        "arch_os/x86_64_windows/C2NStub.S"
        "arch_os/x86_64_windows/CalleeSavedStub.S"
        "arch_os/x86_64_windows/GetContext.S"
        "arch_os/x86_64_windows/HandleSafepointStub.S"
        "arch_os/x86_64_windows/ThrowStackOverflowStub.S"
        "arch_os/x86_64_windows/StackGrowStub.S"
        "os/Windows/Loader.cpp"
        "os/Windows/Path.cpp"
        "os/Windows/UnwindWin.cpp"
        "os/Windows/WinModuleManager.cpp"
    )
endif()
    add_library(runtime STATIC ${SRC_LIST})
    add_library(cangjie-runtime SHARED ${SRC_LIST})

elseif (BUILD_DEMANGLE)
    add_subdirectory(Demangler)
endif() # BUILD_RUNTIME
