// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#define cfi_adjust_cfa_offset(off)	.cfi_adjust_cfa_offset off
#define cfi_rel_offset(reg, off)	.cfi_rel_offset reg, off
#define cfi_restore(reg)		.cfi_restore reg
#define cfi_def_cfa_register(reg)	.cfi_def_cfa_register reg

// This signal handler stub relies on MRT_PrepareToHandleSignal to put continuation pc in x17.
// Continuation pc describes the control flow after signal handling completes.

    .text
    .align 2
    .global CJ_MCC_StackGrowStub
    .type CJ_MCC_StackGrowStub, %function
CJ_MCC_StackGrowStub:
    .cfi_startproc
    sub  sp, sp, #8
    str  r11, [sp]
    str  lr, [sp, #4]
    cfi_adjust_cfa_offset (8)
    cfi_rel_offset (r11, 0)
    cfi_rel_offset (lr, 4)

    // unsupport for arm32
    bl  MRT_StackGrow
    .global unwindPCForStackGrowStub
unwindPCForStackGrowStub:
    ldr  r11, [sp]
    ldr  lr, [sp, #4]
    cfi_restore(r11)
    cfi_restore(lr)
    bx  lr
    .cfi_endproc
    .size CJ_MCC_StackGrowStub, .-CJ_MCC_StackGrowStub
