# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

cmake_minimum_required(VERSION 3.16.5)
project(cangjie)
# add path for custom CMake modules and add cmake modules
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules")
include(AddCangjieSource)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CJNATIVE_BACKEND "cjnative")

if(NOT CMAKE_INCLUDE_SYSTEM_FLAG_CXX)
    set(CXX_SYSTEM_INCLUDE_CONFIGURATION_FLAG /experimental:external /external:W0)
    set(CMAKE_INCLUDE_SYSTEM_FLAG_CXX /external:I)
endif()

if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    message(STATUS "No build type selected, default to Debug")
    set(CMAKE_BUILD_TYPE
        "Debug"
        CACHE STRING "Build type (default Debug)" FORCE)
endif()

string(TOLOWER "${CMAKE_BUILD_TYPE}" runtime_build_mode)
set(target_system_name ${CMAKE_SYSTEM_NAME})
if(OHOS)
    set(target_system_name "linux_ohos")
endif()
string(TOLOWER "${target_system_name}_${runtime_build_mode}_${CMAKE_SYSTEM_PROCESSOR}" dir1)
string(TOLOWER "${target_system_name}_${CMAKE_SYSTEM_PROCESSOR}_${CJNATIVE_BACKEND}" dir2)

set(CANGJIE_RUNTIME_OUTPUT_PATH "")
foreach(lib_path ${CANGJIE_TARGET_LIB})
    file(GLOB MATCHING_RUNTIME_FILES "${lib_path}/common/${dir1}/lib/${dir2}/*cangjie-aio*")
    if(MATCHING_RUNTIME_FILES)
        set(CANGJIE_RUNTIME_OUTPUT_PATH ${lib_path})
        break()
    endif()
endforeach()

set(RUNTIME_COMMON_LIB_DIR ${CANGJIE_RUNTIME_OUTPUT_PATH}/common/${dir1}/lib/${dir2} CACHE STRING "runtime common path lib")

string(TOUPPER "${CMAKE_BUILD_TYPE}" uppercase_CMAKE_BUILD_TYPE)

if(CMAKE_BUILD_TYPE AND NOT ("${uppercase_CMAKE_BUILD_TYPE}" MATCHES "^(DEBUG|RELEASE|RELWITHDEBINFO|MINSIZEREL)$"))
    message(FATAL_ERROR "Invalid value for CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")
endif()

if(NOT DEFINED CANGJIE_PCRE2_SOURCE_DIR)
    set(CANGJIE_PCRE2_SOURCE_DIR ${CMAKE_SOURCE_DIR}/third_party/pcre2-10.44-h1)
endif()
set(BOUNDSCHECK ${CMAKE_SOURCE_DIR}/third_party/boundscheck-v1.1.16)
# Provide secure functions.
if(NOT EXISTS ${BOUNDSCHECK})
    set(REPOSITORY_PATH https://gitee.com/openharmony/third_party_bounds_checking_function.git)
    message(STATUS "Set boundscheck REPOSITORY_PATH: ${REPOSITORY_PATH}")
    execute_process(
        COMMAND git clone --branch OpenHarmony-v6.0-Beta1 ${REPOSITORY_PATH} ${BOUNDSCHECK}
    )
endif()
file(COPY ${CMAKE_MODULE_PATH}/BoundsCheck.cmake DESTINATION ${BOUNDSCHECK}/)
file(RENAME ${BOUNDSCHECK}/BoundsCheck.cmake ${BOUNDSCHECK}/CMakeLists.txt)


set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_SKIP_INSTALL_ALL_DEPENDENCY TRUE)

option(CANGJIE_DOWNLOAD_DEPS "Download binary of llvm, dopra, runtime, jet" ON)

option(CANGJIE_CODEGEN_CJNATIVE_BACKEND "Build a version for CJNATIVE backend" ON)
option(CANGJIE_ENABLE_CCACHE "Build cangjie with ccache" OFF)
option(CANGJIE_SKIP_FIND_OPENSSL "Do not look for OpenSSL package, OpenSSL library will be searched by linker" OFF)
message(STATUS "Build type for the current project: ${CMAKE_BUILD_TYPE}")

if(CANGJIE_ENABLE_CCACHE
   OR CMAKE_BUILD_TYPE MATCHES Debug
   OR CMAKE_BUILD_TYPE MATCHES RelWithDebInfo)
    include(cmake/optional/CangjieCCache.cmake)
endif()

if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
    add_compile_definitions(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
endif()

if(OHOS)
    # This is a CMake bug until 3.22, where MINGW is wrongly set
    # when targeting other platforms on a Windows machine with a MinGW toolchain.
    # See more at CMake issue tracker #22647.
    set(MINGW 0)
endif()

if(NOT TRIPLE)
    string(TOLOWER "${CMAKE_SYSTEM_PROCESSOR}-${target_system_name}-gnu" TRIPLE)
endif()

if(MINGW)
    set(TRIPLE x86_64-w64-mingw32)
endif()

if(NOT TARGET_TRIPLE_DIRECTORY_PREFIX)
    string(REPLACE "-" "_" TARGET_TRIPLE_DIRECTORY_PREFIX "${target_system_name}_${CMAKE_SYSTEM_PROCESSOR}")
    string(TOLOWER "${TARGET_TRIPLE_DIRECTORY_PREFIX}" TARGET_TRIPLE_DIRECTORY_PREFIX)
endif()

if(CMAKE_CROSSCOMPILING)
    message(STATUS "CROSS COMPILING libs from ${CMAKE_HOST_SYSTEM_PROCESSOR}-${CMAKE_HOST_SYSTEM_NAME} to ${TRIPLE}")
endif()

include(SetupAr)

message(STATUS "Building with target=${TRIPLE}")

if(DARWIN)
    include(ReadDarwinSDKInfo)
    set(CMAKE_OSX_DEPLOYMENT_TARGET 12.0.0)
endif()

if(NOT (CMAKE_BUILD_TYPE MATCHES Debug))
    add_definitions(-DNDEBUG)
endif()

if(CMAKE_BUILD_TYPE MATCHES Release)
    add_definitions(-DRELEASE)
endif()

# BUILD_GCC_TOOLCHAIN specifies toolchain for cjc, stdlib and BE at the same time, which means
# that it is used for both targets for HOST (e.g. cjc, llc) and targets for TARGET
# (e.g. stdlib, runtime). In the case that we need to build a cjc for a host which is not a target,
# we must build cjc and stdlib separately for specifying different toolchains for them.
if(BUILD_GCC_TOOLCHAIN AND (CMAKE_C_COMPILER_ID STREQUAL "Clang" OR (CMAKE_CXX_COMPILER_ID STREQUAL "Clang"))
)# It is clang that takes --gcc-toolchain options.
    message(STATUS "Add compile option for clang, --gcc-toolchain=${BUILD_GCC_TOOLCHAIN}")
    add_compile_options(--gcc-toolchain=${BUILD_GCC_TOOLCHAIN})
    add_link_options(--gcc-toolchain=${BUILD_GCC_TOOLCHAIN})
endif()

foreach(libpath ${CANGJIE_TARGET_LIB})
    add_link_options("-L${libpath}")
endforeach()

add_compile_options(${CXX_SYSTEM_INCLUDE_CONFIGURATION_FLAG})

include_directories($ENV{CANGJIE_HOME}/include)

if(WIN32)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/lib)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/lib)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/bin)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/lib)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/lib)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/bin)
endif()
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

if(NOT CANGJIE_SKIP_FIND_OPENSSL)
    include(PrepareOpenSSL)
else()
    # OpenSSL library wil be searched by the linker at build time
    set(OPENSSL_CRYPTO_LINK_OPTIONS -lcrypto)
    set(OPENSSL_SSL_LINK_OPTIONS -lssl -lcrypto)
endif()

string(TOLOWER "${target_system_name}" TARGET_OS)
add_compile_definitions(__${TARGET_OS}__)

if(NOT DEFINED CANGJIE_ZLIB_SOURCE_DIR)
    set(CANGJIE_ZLIB_SOURCE_DIR ${CMAKE_SOURCE_DIR}/third_party/zlib)
endif()

add_subdirectory(third_party)
add_subdirectory(schema)

add_subdirectory(libs)


if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
    add_subdirectory(third_party/boundscheck-v1.1.16)
    install(
        TARGETS boundscheck
        RUNTIME
            DESTINATION
            runtime/lib/${TARGET_TRIPLE_DIRECTORY_PREFIX}_${CJNATIVE_BACKEND}${SANITIZER_SUBPATH} # RUNTIME includes DLLs. This takes effect on Windows.
        LIBRARY
            DESTINATION
            lib/${TARGET_TRIPLE_DIRECTORY_PREFIX}_${CJNATIVE_BACKEND}${SANITIZER_SUBPATH} # LIBRARY includes shared libraries except DLLs.
    )
    install(TARGETS boundscheck-static DESTINATION lib/${TARGET_TRIPLE_DIRECTORY_PREFIX}_${CJNATIVE_BACKEND}${SANITIZER_SUBPATH})
endif()
