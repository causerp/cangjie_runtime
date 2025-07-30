# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

message(STATUS "Configuring pcre2 library...")

set(PCRE2_BUILD_DIR ${CMAKE_BINARY_DIR}/third_party/pcre2-build)
set(PCRE2_INSTALL_DIR ${CMAKE_BINARY_DIR}/third_party/pcre2)
file(MAKE_DIRECTORY ${PCRE2_BUILD_DIR})

set(BUILD_TYPE ${CMAKE_BUILD_TYPE})

if(CANGJIE_HWASAN_SUPPORT OR CANGJIE_ENABLE_HWASAN)
    set(CUSTOM_WARNING_SETTINGS "${CUSTOM_WARNING_SETTINGS} -fsanitize=hwaddress -fno-omit-frame-pointer -fno-emulated-tls")
endif()

if (BUILD_TYPE STREQUAL "Debug")
    unset(BUILD_TYPE)
endif()

execute_process(
    COMMAND
        ${CMAKE_COMMAND}
        -G Ninja
        -DCANGJIE_TARGET_TOOLCHAIN=${CANGJIE_TARGET_TOOLCHAIN}
        -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
        -DCMAKE_SYSROOT=${CANGJIE_TARGET_SYSROOT}
        -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON
        -DCMAKE_INSTALL_LIBDIR=lib
        -DCMAKE_OSX_DEPLOYMENT_TARGET=12.0.0
        -DCMAKE_BUILD_TYPE=${BUILD_TYPE}
        -DCMAKE_SHARED_LINKER_FLAGS=${CMAKE_SHARED_LINKER_FLAGS}
        -DCMAKE_C_FLAGS=${CMAKE_C_FLAGS}
        -DCUSTOM_WARNING_SETTINGS=${CUSTOM_WARNING_SETTINGS}
        -DPCRE2_STATIC_PIC=ON
        -DBUILD_SHARED_LIBS=ON
        -DPCRE2_BUILD_PCRE2GREP=OFF
        -DPCRE2_BUILD_TESTS=OFF
        -DCMAKE_INSTALL_PREFIX=${PCRE2_INSTALL_DIR}
        ${CANGJIE_PCRE2_SOURCE_DIR}/pcre2
    WORKING_DIRECTORY ${PCRE2_BUILD_DIR}
    RESULT_VARIABLE config_result
    OUTPUT_VARIABLE config_stdout
    ERROR_VARIABLE config_stderr)
if(NOT ${config_result} STREQUAL "0")
    message(STATUS "${config_stdout}")
    message(STATUS "${config_stderr}")
    message(FATAL_ERROR "Configuring pcre2 Failed!")
endif()
 
message(STATUS "Building pcre2 libraries...")
execute_process(
    COMMAND ${CMAKE_COMMAND} --build .
    WORKING_DIRECTORY ${PCRE2_BUILD_DIR}
    RESULT_VARIABLE build_result
    OUTPUT_VARIABLE build_stdout
    ERROR_VARIABLE build_stderr)
if(NOT ${build_result} STREQUAL "0")
    message(STATUS "${config_stdout}")
    message(STATUS "${config_stderr}")
    message(STATUS "${build_stdout}")
    message(STATUS "${build_stderr}")
    message(FATAL_ERROR "Building pcre2 Failed!")
endif()

file(MAKE_DIRECTORY ${PCRE2_BUILD_DIR}/CMakeFiles/CMakeRelink.dir)
file(GLOB PCRE_POSIX_FILES ${PCRE2_BUILD_DIR}/libpcre2-posix.so*)
foreach(file ${PCRE_POSIX_FILES})
  file(COPY ${file} DESTINATION ${PCRE2_BUILD_DIR}/CMakeFiles/CMakeRelink.dir)
endforeach()
 
message(STATUS "Installing pcre2 headers and libraries to Cangjie library source...")
execute_process(
    COMMAND ${CMAKE_COMMAND} --install .
    WORKING_DIRECTORY ${PCRE2_BUILD_DIR}
    RESULT_VARIABLE install_result
    OUTPUT_VARIABLE install_stdout
    ERROR_VARIABLE install_stderr)
if(NOT ${install_result} STREQUAL "0")
    message(STATUS "${config_stdout}")
    message(STATUS "${config_stderr}")
    message(STATUS "${build_stdout}")
    message(STATUS "${build_stderr}")
    message(STATUS "${install_stdout}")
    message(STATUS "${install_stderr}")
    message(FATAL_ERROR "Installing pcre2 Failed!")
endif()

file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/include/pcre2/include)
file(COPY ${CMAKE_BINARY_DIR}/third_party/pcre2/include/pcre2.h DESTINATION ${CMAKE_BINARY_DIR}/include/pcre2/include)