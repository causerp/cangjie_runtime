# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

function(extract_archive)
    set(oneValueArgs FROM TO)
    cmake_parse_arguments(EXTRACT_ARCHIVE "" "${oneValueArgs}" "" ${ARGV})

    set(TARGET_AR ar)
    if(MINGW OR DARWIN)
        set(TARGET_AR ${CMAKE_AR})
    elseif(CMAKE_CROSSCOMPILING)
        if(${CMAKE_C_COMPILER_ID} STREQUAL "Clang")
            set(TARGET_AR ${CANGJIE_TARGET_TOOLCHAIN}/llvm-ar)
        else()
            set(TARGET_AR ${CANGJIE_TARGET_TOOLCHAIN}/${TRIPLE}-ar)
        endif()
    endif()

    file(MAKE_DIRECTORY ${EXTRACT_ARCHIVE_TO})
    execute_process(
        COMMAND ${TARGET_AR} x ${EXTRACT_ARCHIVE_FROM}
        WORKING_DIRECTORY ${EXTRACT_ARCHIVE_TO})
endfunction(extract_archive)
