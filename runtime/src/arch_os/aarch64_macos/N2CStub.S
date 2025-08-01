// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#define cfi_adjust_cfa_offset(off)      .cfi_adjust_cfa_offset off
#define cfi_rel_offset(reg, off)        .cfi_rel_offset reg, off
#define cfi_restore(reg)                .cfi_restore reg
#define cfi_def_cfa_register(reg)       .cfi_def_cfa_register reg

////////////////////////////////////////////////////////////////////////////////
// MCC_N2CStub simply forwards arguments passed by runtime, i.e., arguments for compiled method are passed
// according to C/C++ calling convention, which usually means efficiency.
////////////////////////////////////////////////////////////////////////////////

#define StubFrameContextSize          (8 * 38)
#define StubCalleeSaveAreaSize        (8 * 10)
#define FuncAddrAndCpStacksizeOffset  (8 * 2)
#define SafeStateOffset               (8 * 8)

// R means runtime, while C means compiled method. XX indicates the return type of this method.

// On execution of "bl MCC_N2CStub", the frame layout of stack(growing downwards) looks like:
// x0~x7: hold the first 8 arguments arg0~arg7 if existed
// x30: return address of "bl MCC_N2CStub"
// funcAddr and cpStackSize are saved on the stack
// all on-stack arguments are addressable by SP as the frame layout shows.
//                 | ...          |
//                 | x30          | lr for the caller of MCC_N2CStub
// caller fp  -->  | x29          |
//                 | ...          |
//                 | arg11        |
//                 | arg10        |
//                 | arg9         |
//                 | arg8         |
//                 | cpStackSize  |
// caller sp  -->  | funcAddr     |

// the frame layout of stack(growing downwards) after MCC_N2CStub frame is built looks like:
//                 | ...          |
//                 | x30          | lr for the caller of MCC_N2CStub
// caller fp  -->  | x29          |
//                 | ...          |
//                 | arg11        |
//                 | arg10        |
//                 | arg9         |
// caller sp  -->  | arg8         |
// callee saved    | q7(high)     | <== MCC_N2CStub frame starts from here
//                 | q7(low)      |
//                 | q6(high)     |
//                 | q6(low)      |
//                 | q5(high)     |
//                 | q5(low)      |
//                 | q4(high)     |
//                 | q4(low)      |
//                 | q3(high)     |
//                 | q3(low)      |
//                 | q2(high)     |
//                 | q2(low)      |
//                 | q1(high)     |
//                 | q1(low)      |
//                 | q0(high)     |
//                 | q0(low)      |
//                 | x9           |
//                 | x8           |
//                 | x28          |
//                 | x27          |
//                 | x26          |
//                 | x25          |
//                 | x24          |
//                 | x23          |
//                 | x22          |
//                 | x21          |
//                 | x20          |
// callee saved    | x19          |
//                 | null         |
//                 | entersafe    |
// unwind context  | direct call  | directly invoke callee method
//                 | shadowframe  | the information of caller frame which is interpreted
//                 | UC Status    | unwind context status of caller frame
//                 | Context LR   | LR of unwind context frame
//                 | Context FP   | FP of unwind context frame
// unwind context  | Context PC   | PC of unwind context frame
//                 | x30          |
//   stub fp  -->  | x29 callerfp |
//                 | ...          | <== copy caller Stack start here
//                 | arg11        |
//                 | arg10        |
//                 | arg9         |
//   stub sp  -->  | arg8         | <== MCC_N2CStub frame ends at here

    .text
    .align 2
    .global _CJ_MCC_N2CStub
_CJ_MCC_N2CStub:

    // x10 = cpStackSize, x9 = calleeAddr
    ldp  x9, x10, [sp]
    add  sp, sp, #FuncAddrAndCpStacksizeOffset

    .cfi_startproc
    add  x30, x30, #2
    stp  x29, x30, [sp, #-StubFrameContextSize]!
    cfi_adjust_cfa_offset (StubFrameContextSize)
    cfi_rel_offset (x29, 0)
    cfi_rel_offset (x30, 8)

    // save all used callee-saved registers.
    stp  x19, x20, [sp, #StubCalleeSaveAreaSize]
    cfi_rel_offset (x19, StubCalleeSaveAreaSize)
    cfi_rel_offset (x20, StubCalleeSaveAreaSize+8)

    stp  x21, x22, [sp, #StubCalleeSaveAreaSize+0x10]
    cfi_rel_offset (x21, StubCalleeSaveAreaSize+0x10)
    cfi_rel_offset (x22, StubCalleeSaveAreaSize+0x18)

    stp  x23, x24, [sp, #StubCalleeSaveAreaSize+0x20]
    cfi_rel_offset (x23, StubCalleeSaveAreaSize+0x20)
    cfi_rel_offset (x24, StubCalleeSaveAreaSize+0x28)

    stp  x25, x26, [sp, #StubCalleeSaveAreaSize+0x30]
    cfi_rel_offset (x25, StubCalleeSaveAreaSize+0x30)
    cfi_rel_offset (x26, StubCalleeSaveAreaSize+0x38)

    stp  x27, x28, [sp, #StubCalleeSaveAreaSize+0x40]
    cfi_rel_offset (x27, StubCalleeSaveAreaSize+0x40)
    cfi_rel_offset (x28, StubCalleeSaveAreaSize+0x48)

    stp  x8, x9, [sp, #StubCalleeSaveAreaSize+0x50]
    cfi_rel_offset (x8, StubCalleeSaveAreaSize+0x50)
    cfi_rel_offset (x9, StubCalleeSaveAreaSize+0x58)

    stp  q0, q1, [sp, #StubCalleeSaveAreaSize+0x60]
    cfi_rel_offset (q0, StubCalleeSaveAreaSize+0x60)
    cfi_rel_offset (q1, StubCalleeSaveAreaSize+0x70)

    stp  q2, q3, [sp, #StubCalleeSaveAreaSize+0x80]
    cfi_rel_offset (q2, StubCalleeSaveAreaSize+0x80)
    cfi_rel_offset (q3, StubCalleeSaveAreaSize+0x90)

    stp  q4, q5, [sp, #StubCalleeSaveAreaSize+0xa0]
    cfi_rel_offset (q4, StubCalleeSaveAreaSize+0xa0)
    cfi_rel_offset (q5, StubCalleeSaveAreaSize+0xb0)

    stp  q6, q7, [sp, #StubCalleeSaveAreaSize+0xc0]
    cfi_rel_offset (q6, StubCalleeSaveAreaSize+0xc0)
    cfi_rel_offset (q7, StubCalleeSaveAreaSize+0xd0)

    mov  x20, x0 // the entry point of method
    mov  x21, x1
    mov  x22, x2
    mov  x23, x3
    mov  x24, x4
    mov  x25, x5
    mov  x26, x6
    mov  x27, x7

    // x28 <- previous sp
    add  x28, sp, #StubFrameContextSize

    // x19 <- previous sp + cpStackSize
    add  x19, x28, x10

    mov  x29, sp
    cfi_def_cfa_register (x29)

    bl _MRT_TryNewAndRunCJThread
    str  x0, [sp, #SafeStateOffset+0x8]
  
    // mutator mustn't be in safe region before setting context.
    bl _MRT_LeaveSaferegion
    str  x0, [sp, #SafeStateOffset]

    // frame info: tls -> stub
    mov  x0, x29
    bl _MRT_SaveTopManagedContextToN2CStub
    mov  x0, #0x0
    bl   _MRT_SetStackGrow

    bl _MRT_GetThreadLocalData

    ldp  x8, x9, [sp, #StubCalleeSaveAreaSize+0x50]
    cfi_restore (x8)
    cfi_restore (x9)

    ldp  q0, q1, [sp, #StubCalleeSaveAreaSize+0x60]
    cfi_restore (q0)
    cfi_restore (q1)

    ldp  q2, q3, [sp, #StubCalleeSaveAreaSize+0x80]
    cfi_restore (q2)
    cfi_restore (q3)

    ldp  q4, q5, [sp, #StubCalleeSaveAreaSize+0xa0]
    cfi_restore (q4)
    cfi_restore (q5)

    ldp  q6, q7, [sp, #StubCalleeSaveAreaSize+0xc0]
    cfi_restore (q6)
    cfi_restore (q7)

    sub  x10, x19, x28
    // copy arg8, arg9, arg10, ... (if existed)
.L_copy:
    cmp x19, x28
    ble .L_copy_end
    ldp x1, x2, [x19, #-16]!
    // SP is always 16 byte-aligned.
    stp x1, x2, [sp,  #-16]!
    b .L_copy
.L_copy_end:
    mov  x19, x10
    mov  x28, x0

    // prepare arguments for invoking target method
    mov  x0, x20
    mov  x1, x21
    mov  x2, x22
    mov  x3, x23
    mov  x4, x24
    mov  x5, x25
    mov  x6, x26
    mov  x7, x27
    blr  x9
    .global _unwindPCForN2CStub
_unwindPCForN2CStub:

    // Restore the value od rsp before copy arg8, arg9, arg10...
    add  sp, sp, x19

    // keep potential return value
    mov  x21, x0
    mov  x22, x1
    mov  x23, x2
    mov  x24, x3
    mov  x25, x8
    stp  d0, d1, [sp, #StubCalleeSaveAreaSize+0x60]
    cfi_rel_offset (d0, StubCalleeSaveAreaSize+0x60)
    cfi_rel_offset (d1, StubCalleeSaveAreaSize+0x68)

    stp  d2, d3, [sp, #StubCalleeSaveAreaSize+0x70]
    cfi_rel_offset (d2, StubCalleeSaveAreaSize+0x70)
    cfi_rel_offset (d3, StubCalleeSaveAreaSize+0x78)

    mov  x0, #0x1
    bl   _MRT_SetStackGrow

    mov  x0, x29
    bl _MRT_RestoreTopManagedContextFromN2CStub
    ldr x0, [x29, #SafeStateOffset+0x8]
    cmp x0,  #0
    beq .L_no_need_end
    bl _MRT_EndCJThread
    cmp x0,  #1
    beq .L_none_enter
.L_no_need_end:
    ldr x0, [x29, #SafeStateOffset]
    cmp  x0, #0
    beq .L_none_enter
    mov  x0, #0
    bl _MRT_EnterSaferegion
.L_none_enter:

    /* set potential return value */
    mov  x0, x21
    mov  x1, x22
    mov  x2, x23
    mov  x3, x24
    mov  x8, x25

    ldp  d0, d1, [sp, #StubCalleeSaveAreaSize+0x60]
    cfi_restore (d0)
    cfi_restore (d1)

    ldp  d2, d3, [sp, #StubCalleeSaveAreaSize+0x70]
    cfi_restore (d2)
    cfi_restore (d3)

    mov  sp, x29
    cfi_def_cfa_register (sp)

    // restore all used callee-saved registers.
    ldp  x19, x20, [sp, #StubCalleeSaveAreaSize]
    cfi_restore (x19)
    cfi_restore (x20)
    ldp  x21, x22, [sp, #StubCalleeSaveAreaSize+0x10]
    cfi_restore (x21)
    cfi_restore (x22)
    ldp  x23, x24, [sp, #StubCalleeSaveAreaSize+0x20]
    cfi_restore (x23)
    cfi_restore (x24)
    ldp  x25, x26, [sp, #StubCalleeSaveAreaSize+0x30]
    cfi_restore (x25)
    cfi_restore (x26)
    ldp  x27, x28, [sp, #StubCalleeSaveAreaSize+0x40]
    cfi_restore (x27)
    cfi_restore (x28)

    ldp  x29, x30, [sp], #StubFrameContextSize
    cfi_adjust_cfa_offset (-StubFrameContextSize)
    cfi_restore (x29)
    cfi_restore (x30)
    sub  x30, x30, #2
    ret
    .cfi_endproc

.text
.align 2
.global  _ExecuteCangjieStub
_ExecuteCangjieStub:
    .cfi_startproc
    stp x28, x30, [sp, #-16]!
    mov x28, x4
    mov x8,  x5
    blr x3
    ldp x28, x30, [sp], #16
    ret
    .cfi_endproc

.text
.align 2
.global  _ApplyCangjieMethodStub
.global  _ApplyCangjieMethodStubFloat32
.global  _ApplyCangjieMethodStubFloat64
_ApplyCangjieMethodStub:
_ApplyCangjieMethodStubFloat32:
_ApplyCangjieMethodStubFloat64:
    .cfi_startproc

    stp  x29, x30, [sp, #-StubFrameContextSize]!
    cfi_adjust_cfa_offset (StubFrameContextSize)
    cfi_rel_offset (x29, 0)
    cfi_rel_offset (x30, 8)

    // save all used callee-saved registers.
    stp  x19, x20, [sp, #StubCalleeSaveAreaSize]
    cfi_rel_offset (x19, StubCalleeSaveAreaSize)
    cfi_rel_offset (x20, StubCalleeSaveAreaSize+8)

    stp  x21, x22, [sp, #StubCalleeSaveAreaSize+0x10]
    cfi_rel_offset (x21, StubCalleeSaveAreaSize+0x10)
    cfi_rel_offset (x22, StubCalleeSaveAreaSize+0x18)

    stp  x23, x24, [sp, #StubCalleeSaveAreaSize+0x20]
    cfi_rel_offset (x23, StubCalleeSaveAreaSize+0x20)
    cfi_rel_offset (x24, StubCalleeSaveAreaSize+0x28)

    stp  x25, x26, [sp, #StubCalleeSaveAreaSize+0x30]
    cfi_rel_offset (x25, StubCalleeSaveAreaSize+0x30)
    cfi_rel_offset (x26, StubCalleeSaveAreaSize+0x38)

    stp  x27, x28, [sp, #StubCalleeSaveAreaSize+0x40]
    cfi_rel_offset (x27, StubCalleeSaveAreaSize+0x40)
    cfi_rel_offset (x28, StubCalleeSaveAreaSize+0x48)

    stp  x8, x9, [sp, #StubCalleeSaveAreaSize+0x50]
    cfi_rel_offset (x8, StubCalleeSaveAreaSize+0x50)
    cfi_rel_offset (x9, StubCalleeSaveAreaSize+0x58)

    stp  q0, q1, [sp, #StubCalleeSaveAreaSize+0x60]
    cfi_rel_offset (q0, StubCalleeSaveAreaSize+0x60)
    cfi_rel_offset (q1, StubCalleeSaveAreaSize+0x70)

    stp  q2, q3, [sp, #StubCalleeSaveAreaSize+0x80]
    cfi_rel_offset (q2, StubCalleeSaveAreaSize+0x80)
    cfi_rel_offset (q3, StubCalleeSaveAreaSize+0x90)

    stp  q4, q5, [sp, #StubCalleeSaveAreaSize+0xa0]
    cfi_rel_offset (q4, StubCalleeSaveAreaSize+0xa0)
    cfi_rel_offset (q5, StubCalleeSaveAreaSize+0xb0)

    stp  q6, q7, [sp, #StubCalleeSaveAreaSize+0xc0]
    cfi_rel_offset (q6, StubCalleeSaveAreaSize+0xc0)
    cfi_rel_offset (q7, StubCalleeSaveAreaSize+0xd0)

    mov  x29, sp
    cfi_def_cfa_register (x29)

    mov  x20, x0 // save args
    mov  x21, x1 // stackSize
    mov  x22, x2 // save func
    mov  x23, x3 // threadData
    mov  x8,  x4 // sret

    // x28 <- previous sp
    add  x28, sp, #StubFrameContextSize

    // x19 <- previous sp + cpStackSize
    add  x19, x28, x10

    // copy parameter to stack
    // size align to 16 byte.
    add  x21, x21, #(16 - 1)
    and  x21, x21, #0xFFFFFFFFFFFFFFF0

    mov x0, x20
    add x0, x0, #128 // (8 + 8) * 8

    mov x1, x20
    add x1, x1, #128 // (8 + 8) * 8
    add x1, x1, x21

.L_copy_args:
    cmp x1, x0
    ble .L_copy_args_end
    sub x1, x1, #16
    ldp x2, x3, [x1]
    // SP is always 16 byte-aligned.
    stp x2, x3, [sp,  #-16]!
    b .L_copy_args
.L_copy_args_end:

    // mov dst, src
    // prepare arguments for invoking target method
    ldp x0, x1, [x20]
    ldp x2, x3, [x20, #16]
    ldp x4, x5, [x20, #32]
    ldp x6, x7, [x20, #48]

    add x20, x20, #64
    ldp d0, d1, [x20]
    ldp d2, d3, [x20, #16]
    ldp d4, d5, [x20, #32]
    ldp d6, d7, [x20, #48]

    mov x28, x23
    // threadData
    blr x22


    // keep potential return value
    mov  x21, x0
    mov  x22, x1
    mov  x23, x2
    mov  x24, x3
    mov  x25, x8
    stp  d0, d1, [sp, #StubCalleeSaveAreaSize+0x60]
    cfi_rel_offset (d0, StubCalleeSaveAreaSize+0x60)
    cfi_rel_offset (d1, StubCalleeSaveAreaSize+0x68)

    stp  d2, d3, [sp, #StubCalleeSaveAreaSize+0x70]
    cfi_rel_offset (d2, StubCalleeSaveAreaSize+0x70)
    cfi_rel_offset (d3, StubCalleeSaveAreaSize+0x78)

    /* set potential return value */
    mov  x0, x21
    mov  x1, x22
    mov  x2, x23
    mov  x3, x24
    mov  x8, x25

    ldp  d0, d1, [sp, #StubCalleeSaveAreaSize+0x60]
    cfi_restore (d0)
    cfi_restore (d1)

    ldp  d2, d3, [sp, #StubCalleeSaveAreaSize+0x70]
    cfi_restore (d2)
    cfi_restore (d3)

    // restoring the SP Value. the stack which extended for invoking c method is useless now.
    mov  sp,  x29
    cfi_def_cfa_register (sp)

    // restore all used callee-saved registers.
    ldp  x19, x20, [sp, #StubCalleeSaveAreaSize]
    cfi_restore (x19)
    cfi_restore (x20)
    ldp  x21, x22, [sp, #StubCalleeSaveAreaSize+0x10]
    cfi_restore (x21)
    cfi_restore (x22)
    ldp  x23, x24, [sp, #StubCalleeSaveAreaSize+0x20]
    cfi_restore (x23)
    cfi_restore (x24)
    ldp  x25, x26, [sp, #StubCalleeSaveAreaSize+0x30]
    cfi_restore (x25)
    cfi_restore (x26)
    ldp  x27, x28, [sp, #StubCalleeSaveAreaSize+0x40]
    cfi_restore (x27)
    cfi_restore (x28)

    ldp  x29, x30, [sp], #StubFrameContextSize
    cfi_adjust_cfa_offset (-StubFrameContextSize)
    cfi_restore (x29)
    cfi_restore (x30)
    ret
    .cfi_endproc

    .p2align 4, 0x90
    .globl ___cj_personality_v0$
___cj_personality_v0$:
Lfunc_begina:
    .cfi_startproc
    stp x29, x30, [sp, #-16]
    .cfi_def_cfa_offset 16
    .cfi_offset %rbp, -16
    mov x29, sp
    .cfi_def_cfa_register %rbp
    mov x0, #0
    ldp x29, x30, [sp], #16
    ret
Lfunc_enda:
    .cfi_endproc

    .p2align 4, 0x90
    .globl l___cj_personality_v0$
l___cj_personality_v0$:
Lfunc_beginb:
    .cfi_startproc
    stp x29, x30, [sp, #-16]
    .cfi_def_cfa_offset 16
    .cfi_offset %rbp, -16
    mov x29, sp
    .cfi_def_cfa_register %rbp
    mov x0, #0
    ldp x29, x30, [sp], #16
    ret
Lfunc_endb:
    .cfi_endproc