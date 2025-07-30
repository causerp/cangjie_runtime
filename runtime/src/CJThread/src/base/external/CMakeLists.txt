# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

set(SRC_LIST)
aux_source_directory(src SRC_LIST)

add_library(external OBJECT ${SRC_LIST})

target_include_directories(external PUBLIC include)

file(COPY include/external.h DESTINATION ${PROJECT_SOURCE_DIR}/../../output/temp/include/)