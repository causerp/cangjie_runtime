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
set(CPU_FAMILY "x86")
set(CPU_CORE "x86_64")
set(PLATFORM_NAME "ANDROID_x86_64_cangjie")
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
    -m64 \
    -fno-strict-aliasing \
    -fno-omit-frame-pointer \
    -fgnu89-inline \
    -fsigned-char \
    -fno-common \
    -fno-exceptions \
    -fno-rtti \
    -fstack-protector-strong \
    -fPIC"
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
    -m64 \
    -fno-strict-aliasing \
    -fno-omit-frame-pointer \
    -fsigned-char \
    -fno-common \
    -fno-exceptions \
    -fno-rtti \
    -fstack-protector-strong \
    -fPIC"
)

add_compile_definitions(
    "_LARGEFILE_SOURCE"
    "_FILE_OFFSET_BITS=64"
    "VOS_OS_VER=VOS_LINUX"
    "VOS_HARDWARE_PLATFORM=VOS_X86"
    "MRT_HARDWARE_PLATFORM=MRT_X86"
    "VOS_CPU_TYPE=VOS_ARM"
    "VOS_WORDSIZE=64"
    "__WORDSIZE=64"
    "VOS_BYTE_ORDER=VOS_LITTLE_ENDIAN"
    "USE___THREAD"
    "$<$<CONFIG:Debug>:VOS_BUILD_DEBUG=1>"
    "$<$<CONFIG:Release>:VOS_BUILD_RELEASE=1>"
    "TLS_COMMON_DYNAMIC"
    "CANGJIE"
    "MRT_LINUX"
    "__ANDROID__"
)

# The link flags
set(CMAKE_SHARED_LINKER_FLAGS
    "-rdynamic \
    -Wl,-z,noexecstack \
    -Wl,-z,relro \
    -Wl,-z,now"
)

# The ar flags
set(CMAKE_C_CREATE_STATIC_LIBRARY "<CMAKE_AR> rcD <TARGET> <OBJECTS>")