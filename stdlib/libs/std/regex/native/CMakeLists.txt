# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

include(ExtractArchive)

include_directories(${CMAKE_BINARY_DIR}/include/pcre2/include)

set(libname cangjie-std-regexFFI)
set(PCRE2_OBJS_DIR ${CMAKE_CURRENT_BINARY_DIR}/temp)
file(MAKE_DIRECTORY ${PCRE2_OBJS_DIR})
extract_archive(
    FROM ${CMAKE_BINARY_DIR}/third_party/pcre2/lib/libpcre2-8.a
    TO ${PCRE2_OBJS_DIR})
file(GLOB PCRE2_OBJS ${PCRE2_OBJS_DIR}/*.o ${PCRE2_OBJS_DIR}/*.obj)
add_library(${libname}-objs OBJECT ./regex_match.c)
target_compile_options(${libname}-objs PRIVATE ${CMAKE_C_COVERAGE_FLAGS})
add_library(${libname} STATIC $<TARGET_OBJECTS:${libname}-objs> ${PCRE2_OBJS})
install_cangjie_library_ffi(${libname})

set(_libname cangjie-std-regexFFIwithoutPCRE2)
add_library(${_libname}-objs OBJECT ./regex_match.c)
target_compile_options(${_libname}-objs PRIVATE ${CMAKE_C_COVERAGE_FLAGS})
add_library(${_libname} STATIC $<TARGET_OBJECTS:${libname}-objs>)
target_link_directories(${_libname} PRIVATE ${CMAKE_BINARY_DIR}/third_party/pcre2/lib)
