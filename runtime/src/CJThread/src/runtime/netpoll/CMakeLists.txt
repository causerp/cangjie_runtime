# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

set(SRC_LIST)
aux_source_directory(src SRC_LIST)
aux_source_directory(src/${OS_PREFIX} SRC_LIST)

add_library(netpoll OBJECT ${SRC_LIST})

target_include_directories(netpoll PUBLIC include/inner)
target_include_directories(netpoll PUBLIC include/${OS_PREFIX}/inner)

target_link_libraries(netpoll PUBLIC log mid)
