# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

set(SRC_LIST)
aux_source_directory(src SRC_LIST)

add_library(schedule OBJECT ${SRC_LIST})

target_link_libraries(schedule PUBLIC queue mid list netpoll basetime external)

target_include_directories(schedule PUBLIC include)
target_include_directories(schedule PUBLIC include/inner)
target_include_directories(schedule PUBLIC include/inner/gas)
target_include_directories(schedule PUBLIC include/inner/gas/${CPU_FAMILY}/${CPU_CORE})

file(GLOB ADDITIONAL_SRC_FILES
        src/gas/${CPU_FAMILY}/${CPU_CORE}/*.s
        src/gas/${CPU_FAMILY}/${CPU_CORE}/*.S
        )
target_sources(schedule PRIVATE ${ADDITIONAL_SRC_FILES})

file(COPY include/schedule.h DESTINATION ${PROJECT_SOURCE_DIR}/../../output/temp/include/)
file(COPY include/inner/gas/${CPU_FAMILY}/${CPU_CORE}/cjthread_context.h DESTINATION ${PROJECT_SOURCE_DIR}/../../output/temp/include/)
