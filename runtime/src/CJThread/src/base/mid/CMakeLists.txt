# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

add_library(mid INTERFACE)

target_include_directories(mid INTERFACE include)

file(COPY include/schedule_rename.h DESTINATION ${PROJECT_SOURCE_DIR}/../../output/temp/include/)
file(COPY include/schedule_rename_part2.h DESTINATION ${PROJECT_SOURCE_DIR}/../../output/temp/include/)
file(COPY include/mid.h DESTINATION ${PROJECT_SOURCE_DIR}/../../output/temp/include/)