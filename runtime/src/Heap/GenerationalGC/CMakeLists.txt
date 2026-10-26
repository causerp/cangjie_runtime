# Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information

set(SRC_LIST
    "YoungCollector.cpp"
    "MixedCollector.cpp"
    "RememberSet.cpp"
    "RSetUpdateBarrier.cpp"
    "GenerationEnumBarrier.cpp"
    "GenerationTraceBarrier.cpp"
    "GenerationIdleBarrier.cpp"
    "GenerationPostTraceBarrier.cpp"
    "GenerationPreforwardBarrier.cpp"
    "GenerationForwardBarrier.cpp"
    "GenerationAllocBuffer.cpp"
)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/..)
add_library(GenerationalGC STATIC ${SRC_LIST})
