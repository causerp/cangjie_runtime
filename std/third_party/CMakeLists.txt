# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

include(ExternalProject)

find_program(SSH_EXECUTABLE ssh)
# Don't check known_host to get rid of interactive operations in cmake
if(CMAKE_HOST_WIN32)
    set(GIT_ARGS "ssh.variant=ssh")
else()
    set(GIT_ARGS "core.sshCommand=${SSH_EXECUTABLE}\\ -o\\ StrictHostKeyChecking=no" "ssh.variant=ssh")
endif()

set(GCC_TOOLCHAIN_FLAG "")
if(MINGW)
    # There will be lots of warnings when compiling backend with MinGW toolchain, temporarily suppress them.
    set(GCC_TOOLCHAIN_FLAG "${GCC_TOOLCHAIN_FLAG} -w")
endif()
if(BUILD_GCC_TOOLCHAIN)
    message(STATUS "Set GCC toolchain: ${BUILD_GCC_TOOLCHAIN}")
    set(GCC_TOOLCHAIN_FLAG "${GCC_TOOLCHAIN_FLAG} --gcc-toolchain=\"${BUILD_GCC_TOOLCHAIN}\"")
endif()

# Handle third-party dependencies
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/")

include(Flatbuffer)

if(NOT EXISTS ${CANGJIE_PCRE2_SOURCE_DIR})
    set(REPOSITORY_PATH https://gitee.com/openharmony/third_party_pcre2.git)
    message(STATUS "Set pcre2 REPOSITORY_PATH: ${REPOSITORY_PATH}")
    execute_process(
        COMMAND git clone --branch OpenHarmony-v6.0-Beta1 ${REPOSITORY_PATH} ${CANGJIE_PCRE2_SOURCE_DIR}
    )
endif()
include(Pcre2)
