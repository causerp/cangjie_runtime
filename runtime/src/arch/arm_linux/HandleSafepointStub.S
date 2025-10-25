// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#define cfi_adjust_cfa_offset(off)      .cfi_adjust_cfa_offset off
#define cfi_rel_offset(reg, off)        .cfi_rel_offset reg, off
#define cfi_restore(reg)                .cfi_restore reg
#define cfi_def_cfa_register(reg)       .cfi_def_cfa_register reg

#define StubFrameContextSize      (4 * 12)
#define StubCalleeSaveAreaSize    (4 * 4)

// caller sp  -->  | arg7         |
//                 | null         |
// callee saved    | r10          |
//                 | r9           |
//                 | r8           |
//                 | r7           |
//                 | r6           |
//                 | r5           |
// callee saved    | r4           |
//                 | lr           |
//   stub fp  -->  | caller fp    |
//                 |  ...         |
//                 | arg10        |
//                 | arg9         |
//                 | arg8         |
//   stub sp  -->  | arg7         |

   .text
   .align 2
   .global CJ_MCC_HandleSafepoint
   .type CJ_MCC_HandleSafepoint, %function
CJ_MCC_HandleSafepoint:
   .cfi_startproc

    sub  sp, sp, #StubFrameContextSize
    str  r11, [sp]
    str  lr, [sp, #4]
    cfi_adjust_cfa_offset (StubFrameContextSize)
    cfi_rel_offset (r11, 0)
    cfi_rel_offset (lr, 4)

    mov  r11, sp
    cfi_def_cfa_register (r11)

    // save all used callee-saved registers.
    str  r4, [sp, #StubCalleeSaveAreaSize]
    str  r5, [sp, #StubCalleeSaveAreaSize+4]
    str  r6, [sp, #StubCalleeSaveAreaSize+8]
    str  r7, [sp, #StubCalleeSaveAreaSize+12]
    str  r8, [sp, #StubCalleeSaveAreaSize+16]
    str  r9, [sp, #StubCalleeSaveAreaSize+20]
    str  r10, [sp, #StubCalleeSaveAreaSize+24]
    cfi_rel_offset(r4, StubCalleeSaveAreaSize)
    cfi_rel_offset(r5, StubCalleeSaveAreaSize+4)
    cfi_rel_offset(r6, StubCalleeSaveAreaSize+8)
    cfi_rel_offset(r7, StubCalleeSaveAreaSize+12)
    cfi_rel_offset(r8, StubCalleeSaveAreaSize+16)
    cfi_rel_offset(r9, StubCalleeSaveAreaSize+20)
    cfi_rel_offset(r10, StubCalleeSaveAreaSize+24)

    bl   MRT_GetThreadLocalData
    mov  r4, r0
    mov  r3, r0
    mov  r2, #3
    mov  r1, r11
    adr  r0, unwindPCForSafepointHandlerStub
    bl   MRT_UpdateUwContext

    mov  r0, r4
    bl HandleSafepointForArm
    .global unwindPCForSafepointHandlerStub
unwindPCForSafepointHandlerStub:
    bl   MRT_GetThreadLocalData
    bl   MRT_DeleteC2NContext

    // restore all used callee-saved registers.
    ldr  r4, [sp, #StubCalleeSaveAreaSize]
    ldr  r5, [sp, #StubCalleeSaveAreaSize+4]
    ldr  r6, [sp, #StubCalleeSaveAreaSize+8]
    ldr  r7, [sp, #StubCalleeSaveAreaSize+12]
    ldr  r8, [sp, #StubCalleeSaveAreaSize+16]
    ldr  r9, [sp, #StubCalleeSaveAreaSize+20]
    ldr  r10, [sp, #StubCalleeSaveAreaSize+24]
    cfi_restore(r4)
    cfi_restore(r5)
    cfi_restore(r6)
    cfi_restore(r7)
    cfi_restore(r8)
    cfi_restore(r9)
    cfi_restore(r10)

    ldr  r11, [sp]
    ldr  lr, [sp, #4]
    add  sp, sp, #StubFrameContextSize
    cfi_adjust_cfa_offset (-StubFrameContextSize)
    cfi_restore(r11)
    cfi_restore(lr)

    bx   lr

   .global unwindPCForSafepointStubEnd
unwindPCForSafepointStubEnd:
   .cfi_endproc
   .size CJ_MCC_HandleSafepoint, .-CJ_MCC_HandleSafepoint