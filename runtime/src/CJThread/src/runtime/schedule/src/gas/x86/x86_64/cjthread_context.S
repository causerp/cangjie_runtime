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
 * r11 is the temp register.
 */
.macro ContextSave context
    /* Save general registers */
    /* Note: In this case, the rsp is changed after the push rip. Therefore, rsp needs to be
     * moved back by eight bytes.
     */
    leaq 8(%rsp), %r11
    movq %r11, CONTEXT_RSP(\context)
    movq %rbp, CONTEXT_RBP(\context)
    movq %rbx, CONTEXT_RBX(\context)
    /* Note: The address (%rsp) is not directly stored in the rip register. This address refers
     * to the next instruction when the call mcall is invoked. When the call command is executed,
     * a push action is performed to store the return value.
     */
    movq (%rsp), %r11
    movq %r11, CONTEXT_RIP(\context)
    movq %r12, CONTEXT_R12(\context)
    movq %r13, CONTEXT_R13(\context)
    movq %r14, CONTEXT_R14(\context)
    movq %r15, CONTEXT_R15(\context)

#ifndef SCHEDULE_SOFT_FLOAT
    stmxcsr CONTEXT_MXCSR(\context)     /* save mxcsr */
    fstcw CONTEXT_FPU_CW(\context)      /* stores floating-point control words */
#endif

#ifdef MRT_WINDOWS
    movq %rdi, CONTEXT_RDI(\context)
    movq %rsi, CONTEXT_RSI(\context)
    movdqu %xmm6, CONTEXT_XMM6(\context)
    movdqu %xmm7, CONTEXT_XMM7(\context)
    movdqu %xmm8, CONTEXT_XMM8(\context)
    movdqu %xmm9, CONTEXT_XMM9(\context)
    movdqu %xmm10, CONTEXT_XMM10(\context)
    movdqu %xmm11, CONTEXT_XMM11(\context)
    movdqu %xmm12, CONTEXT_XMM12(\context)
    movdqu %xmm13, CONTEXT_XMM13(\context)
    movdqu %xmm14, CONTEXT_XMM14(\context)
    movdqu %xmm15, CONTEXT_XMM15(\context)

    movq %gs:0x10, %r11
    movq %r11, CONTEXT_GS_STACK_LOW(\context)
    movq %gs:0x08, %r11
    movq %r11, CONTEXT_GS_STACK_HIGH(\context)
    movq %gs:0x1478, %r11
    movq %r11, CONTEXT_GS_STACK_DEALOCATION(\context)
#endif
.endm


/* macro: Resume the context, context is context pointer
 * r11 is the temp register.
 * For windows, r10 is also the temp register.
 */
.macro ContextResume context
    /* resume general registers */
    movq CONTEXT_RSP(\context), %rsp
    movq CONTEXT_RBP(\context), %rbp
    movq CONTEXT_RBX(\context), %rbx
    movq CONTEXT_RIP(\context), %r11
    movq CONTEXT_R12(\context), %r12
    movq CONTEXT_R13(\context), %r13
    movq CONTEXT_R14(\context), %r14
    movq CONTEXT_R15(\context), %r15

#ifndef SCHEDULE_SOFT_FLOAT
    ldmxcsr CONTEXT_MXCSR(\context)
    fldcw CONTEXT_FPU_CW(\context)      /* resume floating-point control words */
#endif

#ifdef MRT_WINDOWS
    movq CONTEXT_RDI(\context), %rdi
    movq CONTEXT_RSI(\context), %rsi
    movdqu CONTEXT_XMM6(\context), %xmm6
    movdqu CONTEXT_XMM7(\context), %xmm7
    movdqu CONTEXT_XMM8(\context), %xmm8
    movdqu CONTEXT_XMM9(\context), %xmm9
    movdqu CONTEXT_XMM10(\context), %xmm10
    movdqu CONTEXT_XMM11(\context), %xmm11
    movdqu CONTEXT_XMM12(\context), %xmm12
    movdqu CONTEXT_XMM13(\context), %xmm13
    movdqu CONTEXT_XMM14(\context), %xmm14
    movdqu CONTEXT_XMM15(\context), %xmm15

    movq CONTEXT_GS_STACK_LOW(\context), %r10
    movq %r10, %gs:0x10
    movq CONTEXT_GS_STACK_HIGH(\context), %r10
    movq %r10, %gs:0x08
    movq CONTEXT_GS_STACK_DEALOCATION(\context), %r10
    movq %r10, %gs:0x1478
#endif

    jmp *%r11  /* jump to the cjthread */
.endm

/* reset the context of cjthread0 */
.macro Context0Reset context
    /* Restore the sp that always points to the bottom of the cjthread0 stack. The stack of
     * cjthread0 has been switched. rbp does not need to be restored here because func opens
     * the stack by itself.
     */
    movq CONTEXT_RSP(\context), %rsp

#ifndef SCHEDULE_SOFT_FLOAT
    ldmxcsr CONTEXT_MXCSR(\context)
    fldcw CONTEXT_FPU_CW(\context)
#endif
.endm

/* Rebind dstCJThread and thread, unbind the origin curCJThread from thread */
.macro CJThreadRebind curCJThread, dstCJThread, thread, g_cjthread
    movq $0x0, CJTHREAD_THREAD_OFFSET(\curCJThread)          /* curCJThread->thread = nullptr */
    movq \thread, CJTHREAD_THREAD_OFFSET(\dstCJThread)       /* dstCJThread->thread = thread */
    movq \dstCJThread, THREAD_CJTHREAD_OFFSET(\thread)       /* thread->cjthread = dstCJThread */
    movq \dstCJThread,(\g_cjthread)                          /* g_cjthread = dstCJThread */
.endm

#ifdef MRT_WINDOWS
/* Go to cjthread0 and run the func function.
 * sp points to cjthread0 and pc points to func.
 * void CJThreadMcall(void *func,&g_cjthread);
 *                       rcx           rdx
 */
.global CJThreadMcall
CJThreadMcall:

    /* rcx is cjthread, rdx is &g_cjthread, r8 is context, r9 is func */
    movq %rcx,%r9
    movq (%rdx), %rcx                /* load g_cjthread, cjthread = g_cjthread */
    leaq CJTHREAD_CONTEXT_OFFSET(%rcx), %r8
    /* save current context, r8 points to cjthread.context */
    ContextSave %r8

    /* rcx is cjthread, r8 is thread, r10 is cjthread0 */
    movq CJTHREAD_THREAD_OFFSET(%rcx), %r8    /* thread = cjthread->thread */
    movq THREAD_CJTHREAD0_OFFSET(%r8), %r10   /* cjthread0 = thread->cjthread0 */
    /* Rebind cjthread0 and thread, unbind the origin cjthread from thread */
    CJThreadRebind %rcx, %r10, %r8, %rdx

    /* switch to the context of cjthread0, r8 is the pointer of &cjthread0->context */
    leaq CJTHREAD_CONTEXT_OFFSET(%r10), %r8
    Context0Reset %r8

    jmp *%r9                       /* jump to execute func */
#else
/* Go to cjthread0 and run the func function.
 * sp points to cjthread0 and pc points to func.
 * void CJThreadMcall(void *func,&g_cjthread);
 *                       rdi           rsi
 */
#ifdef MRT_MACOS
.global _CJ_CJThreadMcall
_CJ_CJThreadMcall:
#else
.global CJThreadMcall
CJThreadMcall:
#endif

    /* rdi is cjthread, rsi is &g_cjthread, rdx is context, r9 is func */
    movq %rdi,%r9
    movq (%rsi), %rdi                /* load g_cjthread, cjthread = g_cjthread */
    leaq CJTHREAD_CONTEXT_OFFSET(%rdi), %rdx
    /* save current context, rdx points to cjthread.context */
    ContextSave %rdx

    /* rdi is cjthread, rdx is thread, rcx is cjthread0 */
    movq CJTHREAD_THREAD_OFFSET(%rdi), %rdx    /* thread = cjthread->thread */
    movq THREAD_CJTHREAD0_OFFSET(%rdx), %rcx   /* cjthread0 = thread->cjthread0 */
    /* Rebind cjthread0 and thread, unbind the origin cjthread from thread */
    CJThreadRebind %rdi, %rcx, %rdx, %rsi

    /* switch to context of cjthread0, rdx is the pointer of &cjthread0->context */
    leaq CJTHREAD_CONTEXT_OFFSET(%rcx), %rdx
    Context0Reset %rdx

    jmp *%r9                       /* jump to execute func */

#ifdef MRT_LINUX
    .type CJThreadMcall,@function
    .size CJThreadMcall,.-CJThreadMcall
#endif

#endif


#ifdef MRT_WINDOWS
/* Go to cjthread0 and execute the func function. Unlike the mcall function, this interface
 * does not save the context of the current cjthread. Currently, this API is used only for
 * cjthread_exit.
 * void CJThreadMcallNosave(void *func,&g_cjthread)
 *                                 rcx          rdx
 */
.global CJThreadMcallNosave
CJThreadMcallNosave:

    /* rcx is cjthread,rsi is &g_cjthread,r8 is thread,r10 is cjthread0 */
    movq %rcx, %r9                              /* cjthread = g_cjthread */
    movq (%rdx), %rcx
    movq CJTHREAD_THREAD_OFFSET(%rcx), %r8    /* thread = cjthread->thread */
    movq THREAD_CJTHREAD0_OFFSET(%r8), %r10   /* cjthread0 = thread->cjthread0 */
    /* Rebind cjthread0 and thread, unbind the origin cjthread from thread */
    CJThreadRebind %rcx, %r10, %r8, %rdx

    leaq CJTHREAD_CONTEXT_OFFSET(%r10), %r8
    Context0Reset %r8

    jmp *%r9
#else
/* Go to cjthread0 and execute the func function. Unlike the mcall function, this interface
 * does not save the context of the current cjthread. Currently, this API is used only for
 * cjthread_exit.
 * void CJThreadMcallNosave(void *func,&g_cjthread)
 *                                rdi          rsi
 */
#ifdef MRT_MACOS
.global _CJ_CJThreadMcallNosave
_CJ_CJThreadMcallNosave:
#else
.global CJThreadMcallNosave
CJThreadMcallNosave:
#endif

    /* rdi is cjthread,rsi is &g_cjthread,rdx is thread,rcx is cjthread0 */
    movq %rdi, %r9                              /* cjthread = g_cjthread */
    movq (%rsi), %rdi
    movq CJTHREAD_THREAD_OFFSET(%rdi), %rdx    /* thread = cjthread->thread */
    movq THREAD_CJTHREAD0_OFFSET(%rdx), %rcx   /* cjthread0 = thread->cjthread0 */
    /* Rebind cjthread0 and thread, unbind the origin cjthread from thread */
    CJThreadRebind %rdi, %rcx, %rdx, %rsi

    leaq CJTHREAD_CONTEXT_OFFSET(%rcx), %rdx
    Context0Reset %rdx

    jmp *%r9

#ifdef MRT_LINUX
    .type CJThreadMcallNosave,@function
    .size CJThreadMcallNosave,.-CJThreadMcallNosave
#endif

#endif


#ifdef MRT_WINDOWS
/* This interface is used to switch to user cjthread in cjthread0, so there is no need to
 * save the current context.
 * void CJThreadExecute(void *nextCJThread, &g_cjthread);
 *                               rcx                rdx
 */
.global CJThreadExecute
CJThreadExecute:

    /* rcx is nextCJThread,rdx is &g_cjthread,r9 is thread, r8 is cjthread0 */
    movq (%rdx), %r8                            /* cjthread0 = g_cjthread */
    movq CJTHREAD_THREAD_OFFSET(%r8), %r9      /* thread = cjthread0->thread */

    /* Rebind cjthread and thread */
    CJThreadRebind %r8, %rcx, %r9, %rdx

    leaq CJTHREAD_CONTEXT_OFFSET(%rcx), %r9   /* r9 is cjthread->context */
    ContextResume %r9
#else
/* This interface is used to switch to user cjthread in cjthread0, so there is no need to
 * save the current context.
 * void CJThreadExecute(void *nextCJThread, &g_cjthread);
 *                               rdi                rsi
 */
#ifdef MRT_MACOS
.global _CJ_CJThreadExecute
_CJ_CJThreadExecute:
#else
.global CJThreadExecute
CJThreadExecute:
#endif

    /* rdi is nextCJThread,rsi is &g_cjthread, rdx is thread, rcx is cjthread0 */
    movq (%rsi), %rcx                           /* cjthread0 = g_cjthread */
    movq CJTHREAD_THREAD_OFFSET(%rcx), %rdx    /* thread = cjthread0->thread */

    /* Rebind cjthread and thread */
    CJThreadRebind %rcx, %rdi, %rdx, %rsi

    leaq CJTHREAD_CONTEXT_OFFSET(%rdi), %rdx   /* rdx is cjthread->context */
    ContextResume %rdx

#ifdef MRT_LINUX
    .type CJThreadExecute,@function
    .size CJThreadExecute,.-CJThreadExecute
#endif

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
    movq %rsp, %rdi
    callq  StoreNativeSPForUIThread
#ifdef MRT_LINUX
    .type SingleCJThreadStoreSP,@function
    .size SingleCJThreadStoreSP,.-SingleCJThreadStoreSP
#endif
#endif

#ifdef MRT_WINDOWS
/*
 * void CJThreadContextInit(struct CJThreadContext *context, void *func, char *stackBaseAddr)
 *                                                 rcx                rdx               r8
 */
.global CJThreadContextInit
CJThreadContextInit:
    /* rcx is context */
    movq %rdx, CONTEXT_RIP(%rcx)    /* context->rip = (uintptr_t)func; */
    /* In x86_64, there is a push rbp instruction at the beginning of all functions. The stack
     * address must be 16-byte aligned after push. Therefore, the stack address must be 8-byte
     * aligned. By default, the value of stackBaseAddr is 16-byte aligned. In x86_64, the
     * called function copies parameters to the end of the call stack of the calling function,
     * adjacent to the return address. Therefore, at least four parameters are reserved.
     */
    sub $0x28, %r8
    movq $0, (%r8)
    movq %r8, CONTEXT_RSP(%rcx)    /* context->rsp = (uintptr_t)stackBaseAddr - 40; */

#ifndef SCHEDULE_SOFT_FLOAT
    stmxcsr CONTEXT_MXCSR(%rcx)
    fstcw CONTEXT_FPU_CW(%rcx)
#endif
    ret
#else
/*
 * void CJThreadContextInit(struct CJThreadContext *context, void *func, char *stackBaseAddr)
 *                                                 rdi                rsi               rdx
 */
#ifdef MRT_MACOS
.global _CJ_CJThreadContextInit
_CJ_CJThreadContextInit:
#else
.global CJThreadContextInit
CJThreadContextInit:
#endif

    /* rdi is context */
    movq %rsi, CONTEXT_RIP(%rdi)    /* context->rip = (uintptr_t)func; */
    sub $0x8, %rdx
    movq $0x0, (%rdx)
    movq %rdx, CONTEXT_RSP(%rdi)    /* context->rsp = (uintptr_t)stackBaseAddr - 8; */

#ifndef SCHEDULE_SOFT_FLOAT
    stmxcsr CONTEXT_MXCSR(%rdi)
    fstcw CONTEXT_FPU_CW(%rdi)
#endif
    ret

#ifdef MRT_LINUX
    .type CJThreadContextInit,@function
    .size CJThreadContextInit,.-CJThreadContextInit
#endif

#endif


#ifdef MRT_WINDOWS
/* Obtains the current context.
 * void CJThreadContextGet(struct CJThreadContext *context);
 *                                              rcx
 */
.global CJThreadContextGet
CJThreadContextGet:
    ContextSave %rcx
    ret
#else
#ifdef MRT_MACOS
.global _CJ_CJThreadContextGet
_CJ_CJThreadContextGet:
#else
.global CJThreadContextGet
CJThreadContextGet:
#endif
    ContextSave %rdi
    ret

#ifdef MRT_LINUX
    .type CJThreadContextGet,@function
    .size CJThreadContextGet,.-CJThreadContextGet
#endif

#endif


#ifdef MRT_WINDOWS
/* Jump to the specified context.
 * void CJThreadContextSet(struct CJThreadContext *context);
 *                                              rcx
*/
.global CJThreadContextSet
CJThreadContextSet:
    ContextResume %rcx
#else
#ifdef MRT_MACOS
.global _CJ_CJThreadContextSet
_CJ_CJThreadContextSet:
#else
.global CJThreadContextSet
CJThreadContextSet:
#endif
    ContextResume %rdi

#ifdef MRT_LINUX
    .type CJThreadContextSet,@function
    .size CJThreadContextSet,.-CJThreadContextSet
#endif

#endif
