# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

# The OHOS toolchains put -flto into CMAKE_C_FLAGS/CMAKE_CXX_FLAGS, so the compiler emits LLVM
# bitcode instead of ELF objects. These objects are archived into libcangjie-aio.a, which is
# released as-is and is further merged into libcangjie-std-net.a / libcangjie-std-netFFI.a. A
# static library has no link step (it is only archived by llvm-ar), so the bitcode ends up inside
# the released archives: binutils cannot read such members, and the released SDK becomes pinned
# to one exact LLVM version. -ffat-lto-objects is not supported by the OHOS toolchain, so -fno-lto
# is the only way to get real object files. -fsanitize=cfi requires -flto and has to be turned off
# together with it; CFI was not enforced for these objects anyway, because neither the stdlib link
# nor cjc passes -fsanitize=cfi at link time. -mbranch-protection is unaffected and PAC is still
# emitted. OS_VER is set to "ohos" by exactly the three OHOS toolchain files.
if(OS_VER STREQUAL "ohos")
    add_compile_options(-fno-lto -fno-sanitize=cfi)
endif()

add_subdirectory(schdfd)
add_subdirectory(sock)
add_subdirectory(tcpsock)
add_subdirectory(udpsock)
add_subdirectory(rawsock)
if(${OS} STREQUAL "linux" OR ${OS} STREQUAL "macos" OR ${OS} STREQUAL "ios")
add_subdirectory(domainsock)
endif()
