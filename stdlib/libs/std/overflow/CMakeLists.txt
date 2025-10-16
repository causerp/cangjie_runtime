# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
# This source file is part of the Cangjie project, licensed under Apache-2.0
# with Runtime Library Exception.
#
# See https://cangjie-lang.cn/pages/LICENSE for license information.

set(CANGJIE_OVERFLOW_SRCS
    throwing_op.cj
    saturating_op.cj
    wrapping_op.cj
    checked_op.cj
    carrying_op.cj)
if(CANGJIE_CODEGEN_CJNATIVE_BACKEND)
    set(CJNATIVE_OVERFLOW_SRCS
        ${CANGJIE_OVERFLOW_SRCS} checked_op_cjnative.cj
        CACHE INTERNAL "")
endif()