# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

cmake_minimum_required(VERSION 3.14.1)

set(Python_ADDITIONAL_VERSIONS 3.7)
find_package (Python3 COMPONENTS Interpreter REQUIRED)
if(NOT Python3_FOUND)
    message(FATAL_ERROR
        "Unable to find Python interpreter, required for builds and testing.
        Please install Python or specify the Python3_EXECUTABLE CMake variable.")
endif()
if(${Python3_VERSION} VERSION_LESS 3.7 )
    message(FATAL_ERROR "Python 3.7 or newer is required. Current python version is " ${Python3_VERSION})
endif()

enable_language(ASM)

if (CMAKE_SYSTEM_NAME MATCHES "Linux")
    set(OS_PREFIX "linux")
elseif (CMAKE_SYSTEM_NAME MATCHES "Windows")
    set(OS_PREFIX "windows")
elseif (CMAKE_SYSTEM_NAME MATCHES "Darwin")
    set(OS_PREFIX "macos")
endif ()

IF(CMAKE_HOST_UNIX)
    set(CMAKE_C_COMPILE_OBJECT "<CMAKE_C_COMPILER> <DEFINES> -DVOSFILENAME='\"$(notdir \$(patsubst \"%\",%, $(abspath <SOURCE>)))\"' <INCLUDES> <FLAGS> -o <OBJECT> -c <SOURCE>")
    set(CMAKE_CXX_COMPILE_OBJECT "<CMAKE_CXX_COMPILER> <DEFINES> -DVOSFILENAME='\"$(notdir \$(patsubst \"%\",%, $(abspath <SOURCE>)))\"' <INCLUDES> <FLAGS> -o <OBJECT> -c <SOURCE>")
ELSE()
    set(CMAKE_C_COMPILE_OBJECT "<CMAKE_C_COMPILER> <DEFINES> <INCLUDES> <FLAGS> -o <OBJECT> -c <SOURCE>")
    set(CMAKE_CXX_COMPILE_OBJECT "<CMAKE_CXX_COMPILER> <DEFINES> <INCLUDES> <FLAGS> -o <OBJECT> -c <SOURCE>")
ENDIF()

add_subdirectory(base)
add_subdirectory(runtime)
add_subdirectory(sync)
add_subdirectory(syscall)
add_subdirectory(aio)
add_subdirectory(trace)

set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/../../output/temp/lib)


add_library(cangjie-thread ${LIBTYPE}
$<TARGET_OBJECTS:schedule>
$<TARGET_OBJECTS:log>
$<TARGET_OBJECTS:netpoll>
$<TARGET_OBJECTS:basetime>
$<TARGET_OBJECTS:timer>
$<TARGET_OBJECTS:syscall>
$<TARGET_OBJECTS:waitqueue>
$<TARGET_OBJECTS:sema>
$<TARGET_OBJECTS:external>
)

if(${PLATFORM_NAME} STREQUAL "linux_aarch64_cangjie" OR ${PLATFORM_NAME} STREQUAL "linux_aarch64" OR
    ${PLATFORM_NAME} STREQUAL "linux12_x86_64_cangjie" OR ${PLATFORM_NAME} STREQUAL "linux12_x86_64_fuzz" OR
    ${PLATFORM_NAME} STREQUAL "linux12_x86_64_gcov" OR ${PLATFORM_NAME} STREQUAL "linux12_x86_64")
install(TARGETS cangjie-thread ARCHIVE DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/${TARGET_ARCH})
set(OBJCOPY_PROGRAM objcopy)
 
install(CODE "execute_process(COMMAND ${OBJCOPY_PROGRAM} -D --rename-section .text=.text_thread \
            ${CMAKE_INSTALL_PREFIX}/lib/${TARGET_ARCH}/libcangjie-thread.a)"
        COMPONENT cangjie-thread)
endif()

if(${OS} STREQUAL "linux")
add_library(cangjie-aio ${LIBTYPE}
$<TARGET_OBJECTS:schdfd>
$<TARGET_OBJECTS:sock>
$<TARGET_OBJECTS:tcpsock>
$<TARGET_OBJECTS:domainsock>
$<TARGET_OBJECTS:udpsock>
$<TARGET_OBJECTS:rawsock>
)
elseif(${OS} STREQUAL "windows")
add_library(cangjie-aio ${LIBTYPE}
$<TARGET_OBJECTS:schdfd>
$<TARGET_OBJECTS:sock>
$<TARGET_OBJECTS:tcpsock>
$<TARGET_OBJECTS:udpsock>
$<TARGET_OBJECTS:rawsock>
)
elseif(${OS} STREQUAL "macos")
add_library(cangjie-aio ${LIBTYPE}
$<TARGET_OBJECTS:schdfd>
$<TARGET_OBJECTS:sock>
$<TARGET_OBJECTS:tcpsock>
$<TARGET_OBJECTS:domainsock>
$<TARGET_OBJECTS:udpsock>
$<TARGET_OBJECTS:rawsock>
)
endif()

add_library(cjthread-trace ${LIBTYPE}
$<TARGET_OBJECTS:trace>
)
install(TARGETS cangjie-aio ARCHIVE DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/${TARGET_ARCH})
