// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#define cfi_adjust_cfa_offset(off)      .cfi_adjust_cfa_offset off
#define cfi_rel_offset(reg, off)        .cfi_rel_offset reg, off
#define cfi_restore(reg)                .cfi_restore reg
#define cfi_def_cfa_register(reg)       .cfi_def_cfa_register reg

#define I2NStubFrameSize                (8 * 24)

// Frame layout after
//     stp x29, x30, [sp, #-I2NStubFrameSize]!
//     mov x29, sp
//
//                  | ...                       |
//                  | caller frame              |
//                  | saved x30                 |
//                  | caller-saved x29          |
//   stub x29 -->   | stub-saved x29 (prev fp)  | [x29 + 0x00]
//                  | saved x30                 | [x29 + 0x08]
//                  | saved x28                 | [x29 + 0x10]
//                  | callee (x4) / ret x8      | [x29 + 0x18]
//                  | arg0 (x0) / ret x0        | [x29 + 0x20]
//                  | arg1 (x1) / ret x1        | [x29 + 0x28]
//                  | arg2 (x2) / ret x2        | [x29 + 0x30]
//                  | arg3 (x3) / ret x3        | [x29 + 0x38]
//                  | q0 save area / ret d0-d3  | [x29 + 0x40]
//                  | q1 save area              |
//                  | q2 save area              | [x29 + 0x60]
//                  | q3 save area              |
//                  | q4 save area              | [x29 + 0x80]
//                  | q5 save area              |
//                  | q6 save area              | [x29 + 0xA0]
//                  | q7 save area              |
//   stub sp -->    | ...                       |

    .text
    .align 2
    .global CJ_MCC_I2NStub
    .type CJ_MCC_I2NStub, @function
CJ_MCC_I2NStub:
    .cfi_startproc
#if defined(ENABLE_BACKWARD_PTRAUTH_CFI)
    paciasp
#endif
    stp  x29, x30, [sp, #-I2NStubFrameSize]!
    cfi_adjust_cfa_offset (I2NStubFrameSize)
    cfi_rel_offset (x29, 0)
    cfi_rel_offset (x30, 8)
    mov  x29, sp
    cfi_def_cfa_register (x29)

    str  x28, [sp, #0x10]
    cfi_rel_offset (x28, 0x10)

    // Save integer argument registers.
    str  x4, [sp, #0x18]
    stp  x0, x1, [sp, #0x20]
    stp  x2, x3, [sp, #0x30]

    // Save floating-point argument registers.
    stp  q0, q1, [sp, #0x40]
    stp  q2, q3, [sp, #0x60]
    stp  q4, q5, [sp, #0x80]
    stp  q6, q7, [sp, #0xA0]

    // Keep thread-local data in x28 for transition calls.
    mov  x28, x5

    // SaveC2NContext(pc, fa, threadLocalData).
    mov  x1, x29
    adr  x0, .L_unwind_pc
.L_unwind_pc:
    mov  x2, x28
    bl   MRT_SaveC2NContext

    // EnterSaferegion(false).
    mov  x0, #0
    bl   MRT_EnterSaferegion

    // Restore argument registers.
    ldp  x0, x1, [sp, #0x20]
    ldp  x2, x3, [sp, #0x30]

    // Restore floating-point argument registers.
    ldp  q0, q1, [sp, #0x40]
    ldp  q2, q3, [sp, #0x60]
    ldp  q4, q5, [sp, #0x80]
    ldp  q6, q7, [sp, #0xA0]

    // Call callee.
    ldr  x9, [sp, #0x18]
    blr  x9

    // Save potential return values.
    stp  x0, x1, [sp, #0x20]
    stp  x2, x3, [sp, #0x30]
    str  x8, [sp, #0x18]
    stp  d0, d1, [sp, #0x40]
    stp  d2, d3, [sp, #0x50]

    // LeaveSaferegion().
    bl   MRT_LeaveSaferegion

    // DeleteC2NContext(threadLocalData). x28 carries current thread-local data.
    mov  x0, x28
    bl   MRT_DeleteC2NContext

    // ThrowPendingException(nullptr).
    mov  x0, #0
    bl   MRT_ThrowPendingException

    // Restore return values.
    ldp  x0, x1, [sp, #0x20]
    ldp  x2, x3, [sp, #0x30]
    ldr  x8, [sp, #0x18]
    ldp  d0, d1, [sp, #0x40]
    ldp  d2, d3, [sp, #0x50]

    ldr  x28, [sp, #0x10]
    cfi_restore (x28)
    ldp  x29, x30, [sp], #I2NStubFrameSize
    cfi_adjust_cfa_offset (-I2NStubFrameSize)
    cfi_restore (x29)
    cfi_restore (x30)
#if defined(ENABLE_BACKWARD_PTRAUTH_CFI)
    autiasp
#endif
    ret
    .cfi_endproc
    .size CJ_MCC_I2NStub, .-CJ_MCC_I2NStub

    .global CJ_MCC_I2NStubEnd
    .type CJ_MCC_I2NStubEnd, @function
CJ_MCC_I2NStubEnd:
    nop
    .size CJ_MCC_I2NStubEnd, .-CJ_MCC_I2NStubEnd
