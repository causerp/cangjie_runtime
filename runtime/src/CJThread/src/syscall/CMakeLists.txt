# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

set(SRC_LIST)
aux_source_directory(src SRC_LIST)

add_library(syscall OBJECT ${SRC_LIST})

target_link_libraries(syscall PUBLIC schedule)

target_include_directories(syscall PUBLIC include)
target_include_directories(syscall PUBLIC include/inner)
target_include_directories(syscall PUBLIC include/${OS})

file(GLOB ADDITIONAL_SRC_FILES
        src/${OS}/${CPU_FAMILY}/${CPU_CORE}/*.s
        src/${OS}/${CPU_FAMILY}/${CPU_CORE}/*.S
        src/${OS}/*.cpp
        )

target_sources(syscall PRIVATE ${ADDITIONAL_SRC_FILES})

file(COPY include/mrt_syscall_common.h DESTINATION ${PROJECT_SOURCE_DIR}/../../output/temp/include/)
file(COPY include/${OS}/mrt_syscall.h DESTINATION ${PROJECT_SOURCE_DIR}/../../output/temp/include/)
