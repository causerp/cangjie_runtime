// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

    .def    GetContextWin64;
    .scl    2;
    .type   32;
    .endef
    .globl  GetContextWin64            # -- Begin function GetContextWin64
    .p2align    4, 0x90
GetContextWin64:                   # @GetContextWin64
.seh_proc GetContextWin64
# %bb.0:
    pushq   %rbp
    .seh_pushreg %rbp
    movq    %rsp, %rbp
    .seh_setframe %rbp, 0
    .seh_endprologue
    movq    8(%rbp), %rax
    movq    %rax, (%rcx)
    leaq    16(%rsp), %rax
    movq    %rax, (%rdx)
    popq    %rbp
    retq
    .seh_endproc