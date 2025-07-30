# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

set(SRC_LIST)
aux_source_directory(src SRC_LIST)

add_library(sema OBJECT ${SRC_LIST})

target_include_directories(sema PUBLIC include)
target_include_directories(sema PUBLIC include/inner)

target_link_libraries(sema PUBLIC waitqueue external)

file(COPY include/sema.h DESTINATION ${PROJECT_SOURCE_DIR}/../../output/temp/include/)