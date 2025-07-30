# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

if ((CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64") AND (MACOS_FLAG MATCHES 1))
    set(SRC_LIST
        "Exception.cpp"
        "EhTable.cpp"
        "ExceptionCApi.cpp"
        "${CMAKE_SOURCE_DIR}/src/arch_os/x86_64_macos/RestoreContextForEH.S"
    )
elseif ((CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64") AND (WINDOWS_FLAG MATCHES 0))
    set(SRC_LIST
        "Exception.cpp"
        "EhTable.cpp"
        "ExceptionCApi.cpp"
        "${CMAKE_SOURCE_DIR}/src/arch_os/x86_64_linux/RestoreContextForEH.S"
    )
elseif ((CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64") AND (MACOS_FLAG MATCHES 1))
    set(SRC_LIST
        "Exception.cpp"
        "EhTable.cpp"
        "ExceptionCApi.cpp"
        "${CMAKE_SOURCE_DIR}/src/arch_os/aarch64_macos/RestoreContextForEH.S"
    )
elseif ((CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64") AND (WINDOWS_FLAG MATCHES 0))
    set(SRC_LIST
        "Exception.cpp"
        "EhTable.cpp"
        "ExceptionCApi.cpp"
        "${CMAKE_SOURCE_DIR}/src/arch_os/aarch64_linux/RestoreContextForEH.S"
    )
elseif (WINDOWS_FLAG MATCHES 1)
    set(SRC_LIST
        "Exception.cpp"
        "EhTable.cpp"
        "ExceptionCApi.cpp"
        "${CMAKE_SOURCE_DIR}/src/arch_os/x86_64_windows/RestoreContextForEH.S"
    )
endif()
add_library(Exception STATIC ${SRC_LIST})
