# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

set(process_ffi_src)

if(NOT WIN32)
    list(APPEND process_ffi_src process_ffi_unix.c)
    if(DARWIN)
        list(APPEND process_ffi_src process_impl_macos.c)
    else()
        list(APPEND process_ffi_src process_impl_linux.c)
    endif()
else()
    list(APPEND process_ffi_src process_ffi_win.c)
endif()

set(libname cangjie-std-processFFI)

add_library(${libname}-objs OBJECT ${process_ffi_src})
target_compile_options(${libname}-objs PRIVATE ${CMAKE_C_COVERAGE_FLAGS})
add_library(${libname} STATIC $<TARGET_OBJECTS:${libname}-objs>)
install_cangjie_library_ffi(${libname})