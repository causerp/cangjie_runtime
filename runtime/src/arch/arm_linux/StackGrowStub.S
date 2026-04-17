// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#define cfi_adjust_cfa_offset(off)	.cfi_adjust_cfa_offset off
#define cfi_rel_offset(reg, off)	.cfi_rel_offset reg, off
#define cfi_restore(reg)		.cfi_restore reg
#define cfi_def_cfa_register(reg)	.cfi_def_cfa_register reg

#define SignalStubFrameSize           (0xD0)

// for arm32, do stack check and try to throw StackOverFlow Expection.

    .text
    .align 2
    .global CJ_MCC_StackGrowStub
    .type CJ_MCC_StackGrowStub, %function
CJ_MCC_StackGrowStub:
    .cfi_startproc
    sub  sp, sp, # SignalStubFrameSize
    cfi_adjust_cfa_offset (SignalStubFrameSize)
    str  r1, [sp, #0]
    cfi_rel_offset (r1, 0)
    str  r2, [sp, #4]
    cfi_rel_offset (r2, 4)
    str  r3, [sp, #8]
    cfi_rel_offset (r3, 8)
    str  r12, [sp, #12]
    cfi_rel_offset (r12, 12)
    str  lr, [sp, #16]
    cfi_rel_offset (lr, 16)
    vstr d0, [sp, #20]
    cfi_rel_offset (d0, 20)
    vstr d1, [sp, #28]
    cfi_rel_offset (d1, 28)
    vstr d2, [sp, #36]
    cfi_rel_offset (d2, 36)
    vstr d3, [sp, #44]
    cfi_rel_offset (d3, 44)
    vstr d4, [sp, #52]
    cfi_rel_offset (d4, 52)
    vstr d5, [sp, #60]
    cfi_rel_offset (d5, 60)
    vstr d6, [sp, #68]
    cfi_rel_offset (d6, 68)
    vstr d7, [sp, #76]
    cfi_rel_offset (d7, 76)
    vstr d16, [sp, #84]
    cfi_rel_offset (d16, 84)
    vstr d17, [sp, #92]
    cfi_rel_offset (d17, 92)
    vstr d18, [sp, #100]
    cfi_rel_offset (d18, 100)
    vstr d19, [sp, #108]
    cfi_rel_offset (d19, 108)
    vstr d20, [sp, #116]
    cfi_rel_offset (d20, 116)
    vstr d21, [sp, #124]
    cfi_rel_offset (d21, 124)
    vstr d22, [sp, #132]
    cfi_rel_offset (d22, 132)
    vstr d23, [sp, #140]
    cfi_rel_offset (d23, 140)
    vstr d24, [sp, #148]
    cfi_rel_offset (d24, 148)
    vstr d25, [sp, #156]
    cfi_rel_offset (d25, 156)
    vstr d26, [sp, #164]
    cfi_rel_offset (d26, 164)
    vstr d27, [sp, #172]
    cfi_rel_offset (d27, 172)
    vstr d28, [sp, #180]
    cfi_rel_offset (d28, 180)
    vstr d29, [sp, #188]
    cfi_rel_offset (d29, 188)
    vstr d30, [sp, #196]
    cfi_rel_offset (d30, 196)
    vstr d31, [sp, #204]
    cfi_rel_offset (d31, 204)

    mov  r0, sp
    mov  r1, #0
    mov  r2, lr
    bl  MRT_StackGrow
    .global unwindPCForStackGrowStub
unwindPCForStackGrowStub:
    vldr d31, [sp, #204]
    cfi_restore(d31)
    vldr d30, [sp, #196]
    cfi_restore(d30)
    vldr d29, [sp, #188]
    cfi_restore(d29)
    vldr d28, [sp, #180]
    cfi_restore(d28)
    vldr d27, [sp, #172]
    cfi_restore(d27)
    vldr d26, [sp, #164]
    cfi_restore(d26)
    vldr d25, [sp, #156]
    cfi_restore(d25)
    vldr d24, [sp, #148]
    cfi_restore(d24)
    vldr d23, [sp, #140]
    cfi_restore(d23)
    vldr d22, [sp, #132]
    cfi_restore(d22)
    vldr d21, [sp, #124]
    cfi_restore(d21)
    vldr d20, [sp, #116]
    cfi_restore(d20)
    vldr d19, [sp, #108]
    cfi_restore(d19)
    vldr d18, [sp, #100]
    cfi_restore(d18)
    vldr d17, [sp, #92]
    cfi_restore(d17)
    vldr d16, [sp, #84]
    cfi_restore(d16)
    vldr d7, [sp, #76]
    cfi_restore(d7)
    vldr d6, [sp, #68]
    cfi_restore(d6)
    vldr d5, [sp, #60]
    cfi_restore(d5)
    vldr d4, [sp, #52]
    cfi_restore(d4)
    vldr d3, [sp, #44]
    cfi_restore(d3)
    vldr d2, [sp, #36]
    cfi_restore(d2)
    vldr d1, [sp, #28]
    cfi_restore(d1)
    vldr d0, [sp, #20]
    cfi_restore(d0)
    ldr  lr, [sp, #16]
    cfi_restore(lr)
    ldr  r12, [sp, #12]
    cfi_restore(r12)
    ldr  r3, [sp, #8]
    cfi_restore(r3)
    ldr  r2, [sp, #4]
    cfi_restore(r2)
    ldr  r1, [sp, #0]
    cfi_restore(r1)
    add  sp, sp, # SignalStubFrameSize
    cfi_adjust_cfa_offset (-SignalStubFrameSize)
    bx  lr
    .cfi_endproc
    .size CJ_MCC_StackGrowStub, .-CJ_MCC_StackGrowStub
