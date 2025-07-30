# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

if ((CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64") AND (MACOS_FLAG MATCHES 1))
    set(SRC_LIST
        "SignalStack.cpp"
        "SignalUtils.cpp"
    )
elseif ((CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64") AND (WINDOWS_FLAG MATCHES 0))
    set(SRC_LIST
        "SignalStack.cpp"
        "SignalUtils.cpp"
    )
elseif ((CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64") AND (MACOS_FLAG MATCHES 1))
    set(SRC_LIST
        "SignalStack.cpp"
        "SignalUtils.cpp"
    )
elseif ((CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64") AND (WINDOWS_FLAG MATCHES 0))
    set(SRC_LIST
        "SignalStack.cpp"
        "SignalUtils.cpp"
    )
elseif (WINDOWS_FLAG MATCHES 1)
    set(SRC_LIST
        "SignalUtils.cpp"
    )
endif()

add_library(Signal STATIC ${SRC_LIST})
