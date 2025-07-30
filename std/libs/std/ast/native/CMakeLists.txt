# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

# Generate cpp code for ast using flatc with cpp backend.
set(SCHEMA_SRC ${CMAKE_CURRENT_SOURCE_DIR}/../../../../schema/NodeFormat.fbs)
get_filename_component(FILENAME ${SCHEMA_SRC} NAME_WE)
set(FLATC_EXECUTABLE "${CMAKE_BINARY_DIR}/bin/flatc")
set(FLATBUFFER_SRC ${CMAKE_CURRENT_SOURCE_DIR}/../../../../third_party/flatbuffers)

# Generate cangjie code for ast using flatc with cangjie backend.
set(FLATC_CPP_OUTPUT "${CMAKE_BINARY_DIR}/include/flatbuffers/${FILENAME}_generated.h")
add_custom_command(
    OUTPUT ${FLATC_CPP_OUTPUT}
    COMMAND ${FLATC_EXECUTABLE} ARGS --no-warnings -c -o "${CMAKE_BINARY_DIR}/include/flatbuffers" ${SCHEMA_SRC}
    DEPENDS flatbuffers ${SCHEMA_SRC} # flatc defined in flatbuffers project: add_executable(flatc..)
    COMMENT "generate cpp file using flatc"
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

set(FLATC_CJ_OUTPUT "${CMAKE_BINARY_DIR}/${FILENAME}_generated.cj")
set(FLATBUFFER_DEPEND_CJ_DIR ${FLATBUFFER_SRC}/cangjie)

add_custom_command(
    OUTPUT ${FLATC_CJ_OUTPUT}
    COMMAND ${FLATC_EXECUTABLE} ARGS --no-warnings --cangjie -o "${CMAKE_BINARY_DIR}" ${SCHEMA_SRC}
    DEPENDS flatbuffers ${SCHEMA_SRC} # flatc defined in flatbuffers project: add_executable(flatc..)

    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${FLATBUFFER_DEPEND_CJ_DIR}/table.cj
            ${CMAKE_SOURCE_DIR}/libs/std/ast/
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${FLATBUFFER_DEPEND_CJ_DIR}/flatbuffer_object.cj
            ${CMAKE_SOURCE_DIR}/libs/std/ast/
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${FLATBUFFER_DEPEND_CJ_DIR}/decode.cj
            ${CMAKE_SOURCE_DIR}/libs/std/ast/
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_BINARY_DIR}/${FILENAME}_generated.cj
        ${CMAKE_SOURCE_DIR}/libs/std/ast/${FILENAME}_generated.cj
    COMMENT "Copy cangjie library files to libs")

add_custom_target(FLATC_OUTPUTS ALL DEPENDS ${FLATC_CJ_OUTPUT} ${FLATC_CPP_OUTPUT})

file(GLOB ast_ffi_src
    ./ast_api.cpp)
set(libname cangjie-std-astFFI) 
add_library(${libname} STATIC ${ast_ffi_src})
set_target_properties(${libname} PROPERTIES COMPILE_FLAGS "-fPIC")
add_dependencies(${libname} FLATC_OUTPUTS)

set(CANGJIE_INC_DIR)
set(AST_SUPPORT_LIB_DIR)
# using CANGJIE_HOME or cangjie source directory
if(DEFINED ENV{CANGJIE_HOME})
    string(TOLOWER ${TARGET_TRIPLE_DIRECTORY_PREFIX}_${CJNATIVE_BACKEND} output_cj_lib_dir)
    set(AST_SUPPORT_LIB_DIR $ENV{CANGJIE_HOME}/lib/${output_cj_lib_dir})
    set(CANGJIE_INC_DIR $ENV{CANGJIE_HOME}/include)
    if(NOT EXISTS "${CANGJIE_INC_DIR}/cangjie")
        # using local cangjie source
        set(CANGJIE_INC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../../../../include)
        if(NOT EXISTS "${CANGJIE_INC_DIR}/cangjie")
            message(FATAL_ERROR "NOT FOUND CANGJIE HEADERS")
        endif()
    endif()
else()
    message(FATAL_ERROR "NOT FOUND CJC")
endif()

target_compile_options(${libname} PRIVATE ${CMAKE_C_COVERAGE_FLAGS})
target_include_directories(${libname} PRIVATE ${CANGJIE_INC_DIR} ${CMAKE_BINARY_DIR}/include)

# install for dynamic and static lib
install_cangjie_library_ffi(${libname})