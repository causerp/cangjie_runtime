# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
    file(
        GLOB
        net_ffi_src
        utils.c
        socket_buffer.c)
endif()

set(libname cangjie-std-netFFI)
add_library(${libname}-objs OBJECT ${net_ffi_src})
target_compile_options(${libname}-objs PRIVATE ${CMAKE_C_COVERAGE_FLAGS})

string(TOLOWER ${TARGET_TRIPLE_DIRECTORY_PREFIX}_${CJNATIVE_BACKEND} output_cj_lib_dir)

if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
    set(CJNATIVE_BACKEND "cjnative")
    include(AddAndCombineStaticLib)
    add_and_combine_static_lib(
        TARGET ${libname}
        OUTPUT_NAME lib${libname}.a
        LIBRARIES
            $<TARGET_OBJECTS:${libname}-objs>
            ${RUNTIME_COMMON_LIB_DIR}/libcangjie-aio.a
        DEPENDS ${libname}-objs)
    string(TOLOWER ${TARGET_TRIPLE_DIRECTORY_PREFIX} output_lib_dir)
    install(FILES ${CMAKE_BINARY_DIR}/lib/lib${libname}.a DESTINATION lib/${output_lib_dir}_${CJNATIVE_BACKEND}${SANITIZER_SUBPATH})
endif()
