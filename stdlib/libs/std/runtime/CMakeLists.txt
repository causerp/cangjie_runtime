# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

add_subdirectory(native)

set(CANGJIE_RUNTIME_SRCS
    runtime_gc.cj
    runtime_memoryInfo.cj
    runtime_threadInfo.cj
    runtime_processorInfo.cj
    )
if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
    set(CJNATIVE_RUNTIME_SRCS
        ${CANGJIE_RUNTIME_SRCS}
        CACHE INTERNAL "")
endif()
