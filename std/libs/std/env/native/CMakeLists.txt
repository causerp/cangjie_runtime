# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

file(GLOB env_ffi_src ./*.c)
set(libname cangjie-std-envFFI)

add_library(${libname}-objs OBJECT ${env_ffi_src})
target_compile_options(${libname}-objs PRIVATE ${CMAKE_C_COVERAGE_FLAGS})
if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
    add_and_combine_static_lib(
        TARGET ${libname}
        OUTPUT_NAME lib${libname}.a
        LIBRARIES
            $<TARGET_OBJECTS:${libname}-objs>
            $<TARGET_OBJECTS:cangjie-std-processFFI-objs>
        DEPENDS ${libname}-objs cangjie-std-processFFI )
        
    string(TOLOWER ${TARGET_TRIPLE_DIRECTORY_PREFIX} output_lib_dir)
    set(CJNATIVE_BACKEND "cjnative")
    install(FILES ${CMAKE_BINARY_DIR}/lib/lib${libname}.a DESTINATION lib/${output_lib_dir}_${CJNATIVE_BACKEND}${SANITIZER_SUBPATH})
endif()
