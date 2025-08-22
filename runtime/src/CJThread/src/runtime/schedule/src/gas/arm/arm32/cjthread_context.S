// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#include "context_offset.h"
#include "schedule_rename.h"

.text
/* align Specifies the byte alignment of the instruction. Note that the semantics of this
 * statement are different in ARM and x86. Arm indicates that the statement is aligned to
 * the nth power of 2. In x86, n-byte alignment is used. If the call or jmp destination is
 * at an odd numbered address, an additional clock cycle may be required. Note: align can
 * only ensure that the start address of a function is aligned, but cannot ensure that each
 * instruction is aligned.
 */

.align 2

.macro ContextSave context
    str r4, [\context, #CONTEXT_R4]
    str r5, [\context, #CONTEXT_R5]
    str r6, [\context, #CONTEXT_R6]
    str r7, [\context, #CONTEXT_R7]
    str r8, [\context, #CONTEXT_R8]
    str r9, [\context, #CONTEXT_R9]
    str r10, [\context, #CONTEXT_R10]
    str r11, [\context, #CONTEXT_R11FP]
    str sp, [\context, #CONTEXT_R13SP]
    str lr, [\context, #CONTEXT_R14LR]
    str lr, [\context, #CONTEXT_R15PC]

#ifndef SCHEDULE_SOFT_FLOAT
    vstr  d8, [\context, #CONTEXT_ARM32_D8]
    vstr  d9, [\context, #CONTEXT_ARM32_D9]
    vstr  d10, [\context, #CONTEXT_ARM32_D10]
    vstr  d11, [\context, #CONTEXT_ARM32_D11]
    vstr  d12, [\context, #CONTEXT_ARM32_D12]
    vstr  d13, [\context, #CONTEXT_ARM32_D13]
    vstr  d14, [\context, #CONTEXT_ARM32_D14]
    vstr  d15, [\context, #CONTEXT_ARM32_D15]

    vmrs r12, fpscr
    str r12, [\context, #CONTEXT_FPSCR]
#endif
.endm

.macro ContextResume context
    ldr r4, [\context, #CONTEXT_R4]
    ldr r5, [\context, #CONTEXT_R5]
    ldr r6, [\context, #CONTEXT_R6]
    ldr r7, [\context, #CONTEXT_R7]
    ldr r8, [\context, #CONTEXT_R8]
    ldr r9, [\context, #CONTEXT_R9]
    ldr r10, [\context, #CONTEXT_R10]
    ldr r11, [\context, #CONTEXT_R11FP]
    ldr lr, [\context, #CONTEXT_R14LR]
    ldr r3, [\context, #CONTEXT_R15PC]

    ldr sp, [\context, #CONTEXT_R13SP]

#ifndef SCHEDULE_SOFT_FLOAT
    ldr r12, [\context, #CONTEXT_FPSCR]
    vmsr fpscr, r12

    vldr d8, [\context, #CONTEXT_ARM32_D8]
    vldr d9, [\context, #CONTEXT_ARM32_D9]
    vldr d10, [\context, #CONTEXT_ARM32_D10]
    vldr d11, [\context, #CONTEXT_ARM32_D11]
    vldr d12, [\context, #CONTEXT_ARM32_D12]
    vldr d13, [\context, #CONTEXT_ARM32_D13]
    vldr d14, [\context, #CONTEXT_ARM32_D14]
    vldr d15, [\context, #CONTEXT_ARM32_D15]
#endif

    bx r3
.endm

.macro Context0Reset context
    ldr sp, [\context, #CONTEXT_R13SP]

    mov lr, #0

#ifndef SCHEDULE_SOFT_FLOAT
    ldr r12, [\context, #CONTEXT_FPSCR]
    vmsr fpscr, r12
#endif
.endm

/* Rebind the cjthread to the thread */
.macro CJThreadRebind curCJThread, dstCJThread, thread, g_cjthread
    push {r9}
    mov r9, #0
    str r9, [\curCJThread, #ARM32_CJTHREAD_THREAD_OFFSET]             /* curCJThread->thread = nullptr */
    str \thread, [\dstCJThread, #ARM32_CJTHREAD_THREAD_OFFSET]         /* dstCJThread->thread = thread */
    str \dstCJThread, [\thread, #ARM32_THREAD_CJTHREAD_OFFSET]         /* thread->cjthread = dstCJThread */
    str \dstCJThread, [\g_cjthread]                                    /* g_cjthread = dstCJThread */
    pop {r9}
.endm

/* Go to cjthread0 and run the func function.
 * sp points to cjthread0 and pc points to func.
 * void CJThreadMcall(void *func,&g_cjthread);
 */
.global CJThreadMcall
CJThreadMcall:
    mov r3, r0
    ldr r0, [r1]
    add r2, r0, #ARM32_CJTHREAD_CONTEXT_OFFSET
    ContextSave r2

    push {r4}
    ldr r4, [r0, #ARM32_CJTHREAD_THREAD_OFFSET]    /* thread = cjthread-> thread*/
    ldr r12, [r4, #ARM32_THREAD_CJTHREAD0_OFFSET]    /*  cjthread0 = thread->cjthread0 */
    CJThreadRebind r0, r12, r4, r1
    pop {r4}

    add r2, r12, #ARM32_CJTHREAD_CONTEXT_OFFSET
    Context0Reset r2

    bx r3

    .type CJThreadMcall,%function
    .size CJThreadMcall,.-CJThreadMcall

/* Go to cjthread0 and execute the func function. Unlike the mcall function, this interface
 * does not save the context of the current cjthread. Currently, this API is used only for
 * cjthread_exit.
 * void CJThreadMcallNosave(void *func,&g_cjthread)
 */
.global CJThreadMcallNosave
CJThreadMcallNosave:
    mov r3, r0
    ldr r0, [r1]

    ldr r2, [r0, #ARM32_CJTHREAD_THREAD_OFFSET]
    ldr r12, [r2, #ARM32_THREAD_CJTHREAD0_OFFSET]
    CJThreadRebind r0, r12, r2, r1

    add r2, r12, #ARM32_CJTHREAD_CONTEXT_OFFSET
    Context0Reset r2

    bx r3

    .type CJThreadMcallNosave,%function
    .size CJThreadMcallNosave,.-CJThreadMcallNosave

.global CJ_CJThreadExecute
CJ_CJThreadExecute:
    ldr r12, [r1]
    ldr r3, [r12, #ARM32_CJTHREAD_THREAD_OFFSET]
    CJThreadRebind r12, r0, r3, r1

    add r2, r0, #ARM32_CJTHREAD_CONTEXT_OFFSET
    ContextResume r2

    .type CJThreadExecute,%function
    .size CJThreadExecute,.-CJThreadExecute

#ifdef __OHOS__
/* This interface is used to save the sp value of the UI thread when a user executes the
 * cjthread of spawn(Main) in the UI thread.
 */
.global SingleCJThreadStoreSP
SingleCJThreadStoreSP:
    push {r11, lr}

    mov r0, sp
    add r0, r0, #8
    bl StoreNativeSPForUIThread
    pop {r11, pc}

    .type SingleCJThreadStoreSP,%function
    .size SingleCJThreadStoreSP,.-SingleCJThreadStoreSP

#endif

/*
 * void CJThreadContextInit(struct CJThreadContext *context, void *func, char *stackBaseAddr)
 */
.global CJThreadContextInit
CJThreadContextInit:
    str r1, [r0, #CONTEXT_R15PC]
    str r2, [r0, #CONTEXT_R13SP]

#ifndef SCHEDULE_SOFT_FLOAT
    vmrs r3, fpscr
    str r3, [r0, #CONTEXT_FPSCR]
#endif
    bx lr
    .type CJThreadContextInit,%function
    .size CJThreadContextInit,.-CJThreadContextInit

/* Obtains the current context.
 * void CJThreadContextGet(struct CJThreadContext *context);
 */
.global CJThreadContextGet
CJThreadContextGet:
    ContextSave r0
    bx lr

    .type CJThreadContextGet,%function
    .size CJThreadContextGet,.-CJThreadContextGet

/* Set the current context.
 * void CJThreadContextSet(struct CJThreadContext *context);
 */
.global CJThreadContextSet
CJThreadContextSet:
    ContextResume r0

    .type CJThreadContextSet,%function
    .size CJThreadContextSet,.-CJThreadContextSet