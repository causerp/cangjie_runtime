# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

set(SRC_LIST
    "CjFileLoader.cpp"
)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../)
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../../)
add_library(CjFileLoader STATIC ${SRC_LIST})