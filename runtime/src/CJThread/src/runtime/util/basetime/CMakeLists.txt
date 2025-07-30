# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

include_directories(include)
include_directories(include/inner)

set(SRC_LIST)
aux_source_directory(src SRC_LIST)

add_library(basetime OBJECT ${SRC_LIST})

target_include_directories(basetime PUBLIC include)

target_link_libraries(basetime PUBLIC mid)
