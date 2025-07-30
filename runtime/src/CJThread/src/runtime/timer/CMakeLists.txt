# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

set(SRC_LIST)
aux_source_directory(src SRC_LIST)

add_library(timer OBJECT ${SRC_LIST})

target_link_libraries(timer PUBLIC schedule)

target_include_directories(timer PUBLIC include)
target_include_directories(timer PUBLIC include/inner)

file(COPY include/timer.h DESTINATION ${PROJECT_SOURCE_DIR}/../../output/temp/include/)