# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

# Toolchain
set(CMAKE_SYSTEM_NAME Linux)
string(TOLOWER "${CMAKE_HOST_SYSTEM_NAME}" cmake_host_system_name)
set(ANDROID_ROOT "$ENV{ANDROID_ROOT}")
set(ANDROID_ARCH "$ENV{ANDROID_ARCH}")
set(ANDROID_OS "linux")
set(ANDROID_TARGET_API "$ENV{ANDROID_TARGET_API}")
set(CMAKE_C_COMPILER "${ANDROID_ROOT}/llvm/prebuilt/${cmake_host_system_name}-x86_64/bin/${ANDROID_ARCH}-${ANDROID_OS}-${ANDROID_TARGET_API}-clang")
set(CMAKE_ASM_COMPILER "${ANDROID_ROOT}/llvm/prebuilt/${cmake_host_system_name}-x86_64/bin/${ANDROID_ARCH}-${ANDROID_OS}-${ANDROID_TARGET_API}-clang")
set(CMAKE_CXX_COMPILER "${ANDROID_ROOT}/llvm/prebuilt/${cmake_host_system_name}-x86_64/bin/${ANDROID_ARCH}-${ANDROID_OS}-${ANDROID_TARGET_API}-clang++")
set(CMAKE_AR "${ANDROID_ROOT}/llvm/prebuilt/${cmake_host_system_name}-x86_64/bin/llvm-ar")
set(CMAKE_RANLIB "${ANDROID_ROOT}/llvm/prebuilt/${cmake_host_system_name}-x86_64/bin/llvm-ranlib")

set(OS "linux")
set(CPU_FAMILY "arm")
set(CPU_CORE "arm64")
set(PLATFORM_NAME "ANDROID_arm64_cangjie")
# The compile flags for common
set(CMAKE_C_FLAGS
    "-Wall \
    -Wextra \
    -Wformat=2 \
    -Wpointer-arith \
    -Wdate-time \
    -Wfloat-equal \
    -Wswitch-default \
    -Wshadow \
    -Wvla \
    -Wunused \
    -Wundef \
    -Wcast-qual \
    -Wstrict-prototypes \
    -m64 \
    -std=c11 \
    -fno-strict-aliasing \
    -fno-omit-frame-pointer \
    -fgnu89-inline \
    -fsigned-char \
    -fno-common \
    -fno-exceptions \
    -fno-rtti \
    -fstack-protector-strong \
    -Wframe-larger-than=10240 \
    -fPIC \
    -pipe"
)

set(CMAKE_CXX_FLAGS
    "-Wall \
    -Wextra \
    -Wformat=2 \
    -Wpointer-arith \
    -Wdate-time \
    -Wfloat-equal \
    -Wswitch-default \
    -Wshadow \
    -Wvla \
    -Wunused \
    -Wundef \
    -Wcast-qual \
    -Woverloaded-virtual \
    -Wnon-virtual-dtor \
    -Wdelete-non-virtual-dtor \
    -m64 \
    -std=gnu++14 \
    -fno-strict-aliasing \
    -fno-omit-frame-pointer \
    -fsigned-char \
    -fno-common \
    -fno-exceptions \
    -fno-rtti \
    -fstack-protector-strong \
    -Wframe-larger-than=10240 \
    -fPIC \
    -pipe"
)

add_compile_definitions(
    "_LARGEFILE_SOURCE"
    "_FILE_OFFSET_BITS=64"
    "MRT_HARDWARE_PLATFORM=MRT_ARM"
    "VOS_WORDSIZE=64"
    "__WORDSIZE=64"
    "TLS_COMMON_DYNAMIC"
    "CANGJIE"
    "AARCH64_LINUX_GNU"
    "MRT_LINUX"
    "__ANDROID__"
)

# The link flags
set(CMAKE_SHARED_LINKER_FLAGS
    "-Wl,-Bsymbolic \
    -Wl,--no-undefined \
    -rdynamic \
    -lboundscheck \
    -Wl,-z,noexecstack \
    -Wl,-z,relro \
    -Wl,-z,now"
)

# The ar flags
set(CMAKE_C_CREATE_STATIC_LIBRARY "<CMAKE_AR> rcD <TARGET> <OBJECTS>")
