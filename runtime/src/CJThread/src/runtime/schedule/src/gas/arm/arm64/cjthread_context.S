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

/* macro: save current context, context is context pointer.
 * x17 is the temp register.
 */
.macro ContextSave context
    stp x18, x19, [\context, #CONTEXT_X18]
    stp x20, x21, [\context, #CONTEXT_X20]
    stp x22, x23, [\context, #CONTEXT_X22]
    stp x24, x25, [\context, #CONTEXT_X24]
    stp x26, x27, [\context, #CONTEXT_X26]
    stp x28, x29, [\context, #CONTEXT_X28]
    stp x30, x30, [\context, #CONTEXT_X30_LR]
    /* save sp */
    mov x17, sp
    str x17, [\context, #CONTEXT_SP]

#ifndef SCHEDULE_SOFT_FLOAT
    /* save float registers */
    stp d8, d9, [\context, #CONTEXT_D8]
    stp d10, d11, [\context, #CONTEXT_D10]
    stp d12, d13, [\context, #CONTEXT_D12]
    stp d14, d15, [\context, #CONTEXT_D14]
    /* save the float control register */
    mrs x17, fpcr
    str x17, [\context, #CONTEXT_FPCR]
#endif

.endm

/* macro: save current context, context is context pointer.
 * x17 and x3 are the temp register.
 */
.macro ContextResume context
    /* resume the general registers */
    ldp x18, x19, [\context, #CONTEXT_X18]
    ldp x20, x21, [\context, #CONTEXT_X20]
    ldp x22, x23, [\context, #CONTEXT_X22]
    ldp x24, x25, [\context, #CONTEXT_X24]
    ldp x26, x27, [\context, #CONTEXT_X26]
    ldp x28, x29, [\context, #CONTEXT_X28]
    ldp x30, x3, [\context, #CONTEXT_X30_LR]    /* x3 temporarily stores pc to be restored. */

    /* resume sp */
    ldr x17, [\context, #CONTEXT_SP]
    mov sp, x17

#ifndef SCHEDULE_SOFT_FLOAT
    /* resume float context */
    ldr x17, [\context, #CONTEXT_FPCR]
    msr fpcr, x17
    /* resume float registers */
    ldp d8, d9, [\context, #CONTEXT_D8]
    ldp d10, d11, [\context, #CONTEXT_D10]
    ldp d12, d13, [\context, #CONTEXT_D12]
    ldp d14, d15, [\context, #CONTEXT_D14]
#endif

    br x3                                       /* jump tp pc */
.endm

/* reset cjthread0 context */
.macro Context0Reset context
    /* Read sp pointer of cjthread0. Note that after cjthread0 is initialized, the SP stored in
     * the structure should not be modified. Some general purpose registers do not need to be
     * restored when restoring to the context of cjthread0.
     */
    ldr x17, [\context, #CONTEXT_SP]
    mov sp, x17

    /* set lr register to 0 */
    mov x30, xzr

#ifndef SCHEDULE_SOFT_FLOAT
    /* Only the float context is restored. Float registers are not restored. */
    ldr x17, [\context, #CONTEXT_FPCR]
    msr fpcr, x17
#endif

.endm

/* Rebind the cjthread to the thread */
.macro CJThreadRebind curCJThread, dstCJThread, thread, g_cjthread
    str xzr, [\curCJThread, #CJTHREAD_THREAD_OFFSET]             /* curCJThread->thread = nullptr */
    str \thread, [\dstCJThread, #CJTHREAD_THREAD_OFFSET]         /* dstCJThread->thread = thread */
    str \dstCJThread, [\thread, #THREAD_CJTHREAD_OFFSET]         /* thread->cjthread = dstCJThread */
    str \dstCJThread, [\g_cjthread]                              /* g_cjthread = dstCJThread */
.endm


/* Go to cjthread0 and run the func function.
 * sp points to cjthread0 and pc points to func.
 * void CJThreadMcall(void *func,&g_cjthread);
 *                       x0           x1
 */
#ifdef MRT_MACOS
.global _CJ_CJThreadMcall
_CJ_CJThreadMcall:
#else
.global CJThreadMcall
CJThreadMcall:
#endif

    /* x0 is cjthread, x1 is &g_cjthread, x2 is &context, x3 is func */
    mov x3, x0
    ldr x0, [x1]                                /* load g_cjthread, cjthread = g_cjthread */

    /* save current context, x2 is cjthread.context */
    add x2, x0, #CJTHREAD_CONTEXT_OFFSET
    ContextSave x2

    /* x0 is cjthread，x1 is &g_cjthread，x4 is thread，x5 is cjthread0 */
    ldr x4, [x0, #CJTHREAD_THREAD_OFFSET]      /* thread = cjthread->thread */
    ldr x5, [x4, #THREAD_CJTHREAD0_OFFSET]     /* cjthread0 = thread->cjthread0 */
    /* rebind cjthread0 and thread, unbind the origin cjthread from thread */
    CJThreadRebind x0, x5, x4, x1

    /* switch to cjthread0 context, x2 is the pointer of &cjthread0->context */
    add x2, x5, #CJTHREAD_CONTEXT_OFFSET
    Context0Reset x2

    /* Direct redirection without saving the return address. The address of the
     * context that needs to be restored is stored in context_lr.
     */
    br x3

#ifdef MRT_LINUX
    .type CJThreadMcall,@function
    .size CJThreadMcall,.-CJThreadMcall
#endif

/* Go to cjthread0 and execute the func function. Unlike the mcall function, this interface
 * does not save the context of the current cjthread. Currently, this API is used only for
 * cjthread_exit.
 * void CJThreadMcallNosave(void *func,&g_cjthread)
 *                                x0          x1
 */
 #ifdef MRT_MACOS
.global _CJ_CJThreadMcallNosave
_CJ_CJThreadMcallNosave:
#else
.global CJThreadMcallNosave
CJThreadMcallNosave:
#endif

    /* x0 is cjthread, x1 is &g_cjthread, x3 is func */
    mov x3, x0
    ldr x0, [x1]                    /* load g_cjthread, cjthread = g_cjthread */

    /* x0 is cjthread, x1 is &g_cjthread, x4 is thread, x5 is cjthread0 */
    ldr x4, [x0, #CJTHREAD_THREAD_OFFSET]      /* thread = cjthread->thread */
    ldr x5, [x4, #THREAD_CJTHREAD0_OFFSET]     /* cjthread0 = thread->cjthread0 */
    /* rebind cjthread0 and thread, unbind the origin cjthread from thread */
    CJThreadRebind x0, x5, x4, x1

    /* switch to cjthread0 context, x2 is the pointer of &cjthread0->context */
    add x2, x5, #CJTHREAD_CONTEXT_OFFSET
    Context0Reset x2

    /* Direct redirection without saving the return address. The address of the
     * context that needs to be restored is stored in context_lr.
     */
    br x3

#ifdef MRT_LINUX
    .type CJThreadMcallNosave,@function
    .size CJThreadMcallNosave,.-CJThreadMcallNosave
#endif

/* This interface is used to switch to user cjthread in cjthread0, so there is no need
 * to save the current context.
 * void CJThreadExecute(void *nextCJThread, &g_cjthread);
 *                               x0                x1
 */
 #ifdef MRT_MACOS
.global _CJ_CJThreadExecute
_CJ_CJThreadExecute:
#else
.global CJThreadExecute
CJThreadExecute:
#endif

    ldr x5, [x1]                    /* load g_cjthread, cjthread0 = g_cjthread */

    /* x0 is cjthread, x1 is &g_cjthread, x4 is thread, x5 is cjthread0 */
    ldr x4, [x5, #CJTHREAD_THREAD_OFFSET]      /* thread = cjthread0->thread */
    CJThreadRebind x5, x0, x4, x1

    add x2, x0, #CJTHREAD_CONTEXT_OFFSET       /* x2 = &cjthread->context */
    ContextResume x2

#ifdef MRT_LINUX
    .type CJThreadExecute,@function
    .size CJThreadExecute,.-CJThreadExecute
#endif

#ifdef __OHOS__
/* This interface is used to save the sp value of the UI thread when a user executes the
 * cjthread of spawn(Main) in the UI thread.
 */
 #ifdef MRT_MACOS
.global _CJ_SingleCJThreadStoreSP
_CJ_SingleCJThreadStoreSP:
#else
.global SingleCJThreadStoreSP
SingleCJThreadStoreSP:
#endif
    stp  x29, x30, [sp, #-16]!
    mov x0, sp
    add x0, x0, #16
    bl  StoreNativeSPForUIThread
    ldp x29, x30, [sp], #16
    ret
#ifdef MRT_LINUX
    .type SingleCJThreadStoreSP,@function
    .size SingleCJThreadStoreSP,.-SingleCJThreadStoreSP
#endif
#endif

/*
 * void CJThreadContextInit(struct CJThreadContext *context, void *func, char *stackBaseAddr)                                        x0                 x1                  x2
 */
 #ifdef MRT_MACOS
.global _CJ_CJThreadContextInit
_CJ_CJThreadContextInit:
#else
.global CJThreadContextInit
CJThreadContextInit:
#endif

    str x1, [x0, #CONTEXT_PC]       /* Store the address that is about to be redirected */
    str x2, [x0, #CONTEXT_SP]       /* Initialize the stack address. */

#ifndef SCHEDULE_SOFT_FLOAT
    mrs x4, fpcr
    str x4, [x0, #CONTEXT_FPCR]
#endif

    ret

#ifdef MRT_LINUX
    .type CJThreadContextInit,@function
    .size CJThreadContextInit,.-CJThreadContextInit
#endif

/* Obtains the current context.
 * void CJThreadContextGet(struct CJThreadContext *context);
 *                                              x0
 */
#ifdef MRT_MACOS
.global _CJ_CJThreadContextGet
_CJ_CJThreadContextGet:
#else
.global CJThreadContextGet
CJThreadContextGet:
#endif

    ContextSave x0
    ret

#ifdef MRT_LINUX
    .type CJThreadContextGet,@function
    .size CJThreadContextGet,.-CJThreadContextGet
#endif

#ifdef MRT_MACOS
.global _CJ_CJThreadContextSet
_CJ_CJThreadContextSet:
#else
.global CJThreadContextSet
CJThreadContextSet:
#endif

    ContextResume x0

#ifdef MRT_LINUX
    .type CJThreadContextSet,@function
    .size CJThreadContextSet,.-CJThreadContextSet
#endif
