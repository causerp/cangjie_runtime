# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.


add_subdirectory(native)


if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
    set(ENV_SRCS
        env.cj
        native.cj
        env_exception.cj
        console_reader.cj
        console_writer.cj
        CACHE INTERNAL "")
endif()
