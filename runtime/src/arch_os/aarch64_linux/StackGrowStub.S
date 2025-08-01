// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#define cfi_adjust_cfa_offset(off)	.cfi_adjust_cfa_offset off
#define cfi_rel_offset(reg, off)	.cfi_rel_offset reg, off
#define cfi_restore(reg)		.cfi_restore reg
#define cfi_def_cfa_register(reg)	.cfi_def_cfa_register reg

#define SignalStubFrameSize           (0x310)

// This signal handler stub relies on MRT_PrepareToHandleSignal to put continuation pc in x17.
// Continuation pc describes the control flow after signal handling completes.

    .text
    .align 2
    .global CJ_MCC_StackGrowStub
    .type CJ_MCC_StackGrowStub, %function
CJ_MCC_StackGrowStub:
    .cfi_startproc
    .cfi_return_column x30
    sub  sp, sp, # SignalStubFrameSize
    cfi_adjust_cfa_offset (SignalStubFrameSize)
    stp  x29, x30, [sp]
    cfi_rel_offset (x29, 0)
    cfi_rel_offset (x30, 8)

    mov  x29, sp
    cfi_def_cfa_register (x29)

    // save all non callee-saved registers which may be contaminated by calling
    // the real signal handler.
    stp  x0, x1, [sp, #0x10]
    cfi_rel_offset (x0, 0x10)
    cfi_rel_offset (x1, 0x18)

    stp  x2, x3, [sp, #0x20]
    cfi_rel_offset (x2, 0x20)
    cfi_rel_offset (x3, 0x28)

    stp  x4, x5, [sp, #0x30]
    cfi_rel_offset (x4, 0x30)
    cfi_rel_offset (x5, 0x38)

    stp  x6, x7, [sp, #0x40]
    cfi_rel_offset (x6, 0x40)
    cfi_rel_offset (x7, 0x48)

    stp  x8, x9, [sp, #0x50]
    cfi_rel_offset (x8, 0x50)
    cfi_rel_offset (x9, 0x58)

    stp  x10, x11, [sp, #0x60]
    cfi_rel_offset (x10, 0x60)
    cfi_rel_offset (x11, 0x68)

    stp  x12, x13, [sp, #0x70]
    cfi_rel_offset (x12, 0x70)
    cfi_rel_offset (x13, 0x78)

    stp  x14, x15, [sp, #0x80]
    cfi_rel_offset (x14, 0x80)
    cfi_rel_offset (x15, 0x88)

    stp  x16, x17, [sp, #0x90]
    cfi_rel_offset (x16, 0x90)
    cfi_rel_offset (x17, 0x98)

    stp  x18, x19, [sp, #0xa0]
    cfi_rel_offset (x18, 0xa0)
    cfi_rel_offset (x19, 0xa8)

    stp  x20, x21, [sp, 0xb0]
    cfi_rel_offset (x20, 0xb0)
    cfi_rel_offset (x21, 0xb8)

    stp  x22, x23, [sp, 0xc0]
    cfi_rel_offset (x22, 0xc0)
    cfi_rel_offset (x23, 0xc8)

    stp  x24, x25, [sp, 0xd0]
    cfi_rel_offset (x24, 0xd0)
    cfi_rel_offset (x25, 0xd8)

    stp  x26, x27, [sp, 0xe0]
    cfi_rel_offset (x26, 0xe0)
    cfi_rel_offset (x27, 0xe8)

    stp  x28, x29, [sp, 0xf0]
    cfi_rel_offset (x28, 0xf0)
    cfi_rel_offset (x29, 0xf8)

    mrs  x30, nzcv
    str  x30, [sp, 0x100]

    stp   q0,  q1, [sp, #0x110]
    stp   q2,  q3, [sp, #0x130]
    stp   q4,  q5, [sp, #0x150]
    stp   q6,  q7, [sp, #0x170]
    stp   q8,  q9, [sp, #0x190]
    stp  q10, q11, [sp, #0x1b0]
    stp  q12, q13, [sp, #0x1d0]
    stp  q14, q15, [sp, #0x1f0]
    stp  q16, q17, [sp, #0x210]
    stp  q18, q19, [sp, #0x230]
    stp  q20, q21, [sp, #0x250]
    stp  q22, q23, [sp, #0x270]
    stp  q24, q25, [sp, #0x290]
    stp  q26, q27, [sp, #0x2b0]
    stp  q28, q29, [sp, #0x2d0]
    stp  q30, q31, [sp, #0x2f0]

    mov  x1, x29
    mov  x2, #1
    adr  x0, #32 // x0 is addr of unwindPCForSignalHandlerStub
    mov  x3, x28
    bl MRT_UpdateUwContext

    mov x0, x29
    ldr x1, [sp]
    ldur x1, [sp, #0x58] // get adjustedSize
    ldr x2, [sp, #0x8]
    bl  MRT_StackGrow
    .global unwindPCForStackGrowStub
unwindPCForStackGrowStub:

    add x29, x29, x0
    add sp, sp, x0
    bl  MRT_FreeOldStack

    bl MRT_GetThreadLocalData
    str  x0, [sp, #0xf0]

    bl MRT_DeleteC2NContext

.L_noexception:
    ldp   q0,  q1, [sp, #0x110]
    ldp   q2,  q3, [sp, #0x130]
    ldp   q4,  q5, [sp, #0x150]
    ldp   q6,  q7, [sp, #0x170]
    ldp   q8,  q9, [sp, #0x190]
    ldp  q10, q11, [sp, #0x1b0]
    ldp  q12, q13, [sp, #0x1d0]
    ldp  q14, q15, [sp, #0x1f0]
    ldp  q16, q17, [sp, #0x210]
    ldp  q18, q19, [sp, #0x230]
    ldp  q20, q21, [sp, #0x250]
    ldp  q22, q23, [sp, #0x270]
    ldp  q24, q25, [sp, #0x290]
    ldp  q26, q27, [sp, #0x2b0]
    ldp  q28, q29, [sp, #0x2d0]
    ldp  q30, q31, [sp, #0x2f0]

    ldp  x0, x1, [sp, #0x10]
    cfi_restore (x0)
    cfi_restore (x1)

    ldp  x2, x3, [sp, #0x20]
    cfi_restore (x2)
    cfi_restore (x3)

    ldp  x4, x5, [sp, #0x30]
    cfi_restore (x4)
    cfi_restore (x5)

    ldp  x6, x7, [sp, #0x40]
    cfi_restore (x6)
    cfi_restore (x7)

    ldp  x8, x9, [sp, #0x50]
    cfi_restore (x8)
    cfi_restore (x9)

    ldp  x10, x11, [sp, #0x60]
    cfi_restore (x10)
    cfi_restore (x11)

    ldp  x12, x13, [sp, #0x70]
    cfi_restore (x12)
    cfi_restore (x13)

    ldp  x14, x15, [sp, #0x80]
    cfi_restore (x14)
    cfi_restore (x15)

    ldp  x16, x17, [sp, #0x90]
    cfi_restore (x16)
    cfi_restore (x30)

    ldp  x18, x19, [sp, #0xa0]
    cfi_restore (x18)
    cfi_restore (x19)
    ldp  x20, x21, [sp, #0xb0]
    cfi_restore (x20)
    cfi_restore (x21)
    ldp  x22, x23, [sp, #0xc0]
    cfi_restore (x22)
    cfi_restore (x23)
    ldp  x24, x25, [sp, #0xd0]
    cfi_restore (x24)
    cfi_restore (x25)
    ldp  x26, x27, [sp, #0xe0]
    cfi_restore (x26)
    cfi_restore (x27)
    ldp  x28, x29, [sp, #0xf0]
    cfi_restore (x28)
    cfi_restore (x29)
    ldr  x30, [sp, #0x100]
    msr  nzcv, x30

    ldp  x29, x30, [sp]
    cfi_restore (x29)
    cfi_restore (x30)

    add  sp, sp, # SignalStubFrameSize
    cfi_adjust_cfa_offset (-SignalStubFrameSize)

    ret
    .cfi_endproc
    .size CJ_MCC_StackGrowStub, .-CJ_MCC_StackGrowStub
