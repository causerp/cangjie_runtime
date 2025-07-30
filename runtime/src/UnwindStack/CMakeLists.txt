# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

set(SRC_LIST
    "StackInfo.cpp"
    "EhStackInfo.cpp"
    "GcStackInfo.cpp"
    "StackGrowStackInfo.cpp"
    "PrintStackInfo.cpp"
    "PrintSignalStackInfo.cpp"
    "MachineFrame.cpp"
    "UnwindContext.cpp"
    "UnwindCApi.cpp"
    "FrameInfo.cpp"
    "MangleNameHelper.cpp"
    "StackMetadataHelper.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/../Demangler/Demangler.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/../Demangler/DeCompression.cpp"
)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../Heap)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../Demangler)
add_library(UnwindStack STATIC ${SRC_LIST})
