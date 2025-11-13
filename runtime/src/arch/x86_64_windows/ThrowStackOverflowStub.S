// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

    .def    CJ_MCC_ThrowStackOverflowError;
    .scl    2;
    .type   32;
    .endef
    .globl  CJ_MCC_ThrowStackOverflowError            # -- Begin function CJ_MCC_ThrowStackOverflowError
    .p2align    4, 0x90
CJ_MCC_ThrowStackOverflowError:                   # @CJ_MCC_ThrowStackOverflowError
.seh_proc CJ_MCC_ThrowStackOverflowError
# %bb.0:
    pushq   %rbp
    .seh_pushreg %rbp
    movq    %rsp, %rbp
    .seh_setframe %rbp, 0
    .seh_endprologue
    callq  MCC_ThrowStackOverflowError
    popq    %rbp
    retq
    .seh_endproc
