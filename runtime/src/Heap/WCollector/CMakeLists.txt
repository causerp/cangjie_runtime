# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

set(SRC_LIST
    "IdleBarrier.cpp"
    "EnumBarrier.cpp"
    "TraceBarrier.cpp"
    "PostTraceBarrier.cpp"
    "PreforwardBarrier.cpp"
    "ForwardBarrier.cpp"
    "WCollector.cpp"
)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/..)
add_library(WCollector STATIC ${SRC_LIST})
