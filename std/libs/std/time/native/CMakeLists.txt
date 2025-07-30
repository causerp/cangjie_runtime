# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
    file(
        GLOB
        time_ffi_src
        ./time.c
        ./time_common.c)
endif()

set(libname cangjie-std-timeFFI)

add_library(${libname}-objs OBJECT ${time_ffi_src})
target_compile_options(${libname}-objs PRIVATE ${CMAKE_C_COVERAGE_FLAGS})
add_library(${libname} STATIC $<TARGET_OBJECTS:${libname}-objs>)
install_cangjie_library_ffi(${libname})
