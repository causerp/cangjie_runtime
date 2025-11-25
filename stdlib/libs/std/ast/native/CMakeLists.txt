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

if(IOS)
    get_directory_property(SRC_COMPILE_OPTIONS COMPILE_OPTIONS)
    list(REMOVE_ITEM SRC_COMPILE_OPTIONS "--target=${TRIPLE}")
    set_directory_properties(PROPERTIES COMPILE_OPTIONS "${SRC_COMPILE_OPTIONS}")
    add_compile_options(--target=${CXX_COMPATIABLE_TRIPLE})
endif()

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
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${FLATBUFFER_DEPEND_CJ_DIR}/builder.cj
            ${CMAKE_SOURCE_DIR}/libs/std/ast/
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${FLATBUFFER_DEPEND_CJ_DIR}/constants.cj
            ${CMAKE_SOURCE_DIR}/libs/std/ast/
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${FLATBUFFER_DEPEND_CJ_DIR}/exception.cj
            ${CMAKE_SOURCE_DIR}/libs/std/ast/flatc_exception.cj
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_BINARY_DIR}/${FILENAME}_generated.cj
        ${CMAKE_SOURCE_DIR}/libs/std/ast/${FILENAME}_generated.cj
    COMMENT "Copy cangjie library files to libs")

add_custom_target(FLATC_OUTPUTS ALL DEPENDS ${FLATC_CJ_OUTPUT} ${FLATC_CPP_OUTPUT})

file(GLOB ast_ffi_src
    ./ast_api.cpp)
set(libname cangjie-std-astFFI) 
add_library(${libname}-objs OBJECT ${ast_ffi_src})
set_target_properties(${libname}-objs PROPERTIES COMPILE_FLAGS "-fPIC")
add_dependencies(${libname}-objs FLATC_OUTPUTS)

set(CANGJIE_INC_DIR)
set(AST_SUPPORT_LIB_DIR)
# using CANGJIE_HOME or cangjie source directory
if(DEFINED ENV{CANGJIE_HOME})
    string(TOLOWER ${TARGET_TRIPLE_DIRECTORY_PREFIX}_${CJNATIVE_BACKEND} output_cj_lib_dir)
    set(AST_SUPPORT_LIB_DIR $ENV{CANGJIE_HOME}/lib/${output_cj_lib_dir})
    set(CANGJIE_INC_DIR $ENV{CANGJIE_HOME}/include)
    if(NOT EXISTS "${CANGJIE_INC_DIR}/cangjie")
        # using local cangjie source
        set(CANGJIE_INC_DIR ~/dev/cangjie/cangjie/include)
        if(NOT EXISTS "${CANGJIE_INC_DIR}/cangjie")
            message(FATAL_ERROR "NOT FOUND CANGJIE HEADERS")
        endif()
    endif()
else()
    message(FATAL_ERROR "NOT FOUND CJC")
endif()

target_compile_options(${libname}-objs PRIVATE ${CMAKE_C_COVERAGE_FLAGS})
if(CANGJIE_BUILD_STDLIB_WITH_COVERAGE)
    target_compile_options(${libname}-objs PUBLIC "-fno-exceptions")
    target_compile_definitions(${libname}-objs PRIVATE CANGJIE_ENABLE_GCOV)
endif()
target_include_directories(${libname}-objs PRIVATE ${CANGJIE_INC_DIR} ${CMAKE_BINARY_DIR}/include)

set(TARGET_AR ar)
if(MINGW OR DARWIN)
    set(TARGET_AR ${CMAKE_AR})
elseif(CMAKE_CROSSCOMPILING)
    if(IOS)
        set(TARGET_AR ${CANGJIE_TARGET_TOOLCHAIN}/ar)
    elseif(${CMAKE_C_COMPILER_ID} STREQUAL "Clang")
        set(TARGET_AR ${CANGJIE_TARGET_TOOLCHAIN}/llvm-ar)
    else()
        set(TARGET_AR ${CANGJIE_TARGET_TOOLCHAIN}/${TRIPLE}-ar)
    endif()
endif()

set(AST_FFI_LIB ${CMAKE_BINARY_DIR}/lib${libname}.a)

# add ast_api.obj to ast-support.a, because the same-named files will be overwritten when decompressing ast-suppor.a.
add_custom_command(
    OUTPUT ${AST_FFI_LIB}
    COMMAND ${CMAKE_COMMAND} -E copy 
        $ENV{CANGJIE_HOME}/lib/${output_cj_lib_dir}/libcangjie-ast-support.a
        ${AST_FFI_LIB}
    COMMAND ${TARGET_AR} q ${AST_FFI_LIB} $<TARGET_OBJECTS:${libname}-objs>
    DEPENDS ${libname}-objs
)

add_custom_target(AST_SUPPORT ALL DEPENDS ${AST_FFI_LIB})

# install for static lib
install_ast_library_ffi(${AST_FFI_LIB})
