# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

set(SRC_LIST)
aux_source_directory(src SRC_LIST)
aux_source_directory(src/${OS} SRC_LIST)

add_library(rawsock OBJECT ${SRC_LIST})

target_include_directories(rawsock PUBLIC include)
target_include_directories(rawsock PUBLIC include/inner)
target_include_directories(rawsock PUBLIC include/inner/${OS})

target_link_libraries(rawsock PUBLIC sock)
