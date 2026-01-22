// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#define CJTHREAD_THREAD_OFFSET      0x10
#define CJTHREAD_CONTEXT_OFFSET     0x18

#define CONTEXT_RSP                 0x00
#define CONTEXT_RBP                 0x08
#define CONTEXT_RBX                 0x10
#define CONTEXT_RIP                 0x18
#define CONTEXT_R12                 0x20
#define CONTEXT_R13                 0x28
#define CONTEXT_R14                 0x30
#define CONTEXT_R15                 0x38
#define CONTEXT_MXCSR               0x40
#define CONTEXT_FPU_CW              0x44

#define THREAD_CONTEXT_OFFSET       0x78
#define ExclusiveScopeFrameSize     (8 * 22)


// ==============================================================================
// CJ_MCC_ExclusiveScope: from cjthread switch OS thread and exclusive this thread
// ==============================================================================
//
//   void* CJ_MCC_ExclusiveScope(void* executeClosure, void* closurePtr)
//                                    rdi              rsi
//
//
// 1. call MCC_NewExclusiveCJThread to creat exclusive cjthread
// 2. switch to OS thread
// 3. call ExclusiveExecutor to execute closure
// 4. switch to normal cjthread

    .text
    .align 2
    .global CJ_MCC_ExclusiveScope
    .type CJ_MCC_ExclusiveScope, @function
CJ_MCC_ExclusiveScope:
    .cfi_startproc
    
    pushq   %rbp
    .cfi_def_cfa_offset 16
    .cfi_offset %rbp, -16
    movq    %rsp, %rbp
    .cfi_def_cfa_register %rbp
    subq    $ExclusiveScopeFrameSize, %rsp

    movq    %r15, -8(%rbp)
    movq    %r14, -16(%rbp)
    movq    %r13, -24(%rbp)
    movq    %r12, -32(%rbp)
    movq    %rbx, -40(%rbp)
    .cfi_rel_offset %rbx, -40
    .cfi_rel_offset %r12, -32
    .cfi_rel_offset %r13, -24
    .cfi_rel_offset %r14, -16
    .cfi_rel_offset %r15, -8

    movq    %rdi, -48(%rbp)     // executeClosure
    movq    %rsi, -56(%rbp)     // closurePtr


    // get oldCJThread thread oldProcessor
    callq   CJ_CJThreadGetHandle
    testq   %rax, %rax
    jz      .L_exc_no_cjthread
    movq    %rax, -80(%rbp)     // oldCJThread

    // thread = oldCJThread->thread
    movq    CJTHREAD_THREAD_OFFSET(%rax), %r12
    testq   %r12, %r12
    jz      .L_exc_no_thread
    movq    %r12, -88(%rbp)     // thread

    // Save original processor (thread->processor) before it's modified
    // thread->processor is at offset 0x38 in Thread struct
    movq    0x38(%r12), %r11
    movq    %r11, -168(%rbp)    // oldProcessor

    // MCC_NewExclusiveCJThread(executeClosure, closurePtr, futureTi)
    //                              rdi           rsi        rdx
    movq    -48(%rbp), %rdi     // executeClosure
    movq    -56(%rbp), %rsi     // closurePtr
    movq    -64(%rbp), %rdx     // futureTi
    callq   MCC_NewExclusiveCJThread@PLT
    
    testq   %rax, %rax
    jz      .L_exc_create_failed
    movq    %rax, -160(%rbp)    // newCJThread

    movq    %rbp,  %rsi                  // rsi = fa (frame address)
    call    .L_exc_get_pc
.L_exc_get_pc:
    .global unwindPCForExclusiveStub
unwindPCForExclusiveStub:
    pop     %rdi
    mov     %r15, %rdx
    callq   MRT_SaveC2NContext@PLT

    movq    $0, %rdi
    callq   MRT_EnterSaferegion@PLT
    movq    %rax, -96(%rbp)     // enterSafe


    movq    %rsp, -104(%rbp)

    // ==================== save cjthread context ====================
    movq    -80(%rbp), %rax         // oldCJThread
    leaq    CJTHREAD_CONTEXT_OFFSET(%rax), %r14

    leaq    8(%rsp), %r11
    movq    %r11, CONTEXT_RSP(%r14)
    movq    %rbp, CONTEXT_RBP(%r14)
    movq    %rbx, CONTEXT_RBX(%r14)
    movq    (%rsp), %r11
    movq    %r11, CONTEXT_RIP(%r14)
    movq    %r12, CONTEXT_R12(%r14)
    movq    %r13, CONTEXT_R13(%r14)
    movq    -16(%rbp), %r11
    movq    %r11, CONTEXT_R14(%r14)
    movq    -8(%rbp), %r11
    movq    %r11, CONTEXT_R15(%r14)
    stmxcsr CONTEXT_MXCSR(%r14)
    fstcw   CONTEXT_FPU_CW(%r14)

    // ==================== switch to OS thread ====================
    movq    -88(%rbp), %r12             // thread
    leaq    THREAD_CONTEXT_OFFSET(%r12), %r15
    
    movq    CONTEXT_RSP(%r15), %rsp
    ldmxcsr CONTEXT_MXCSR(%r15)
    fldcw   CONTEXT_FPU_CW(%r15)

    subq    $128, %rsp
    andq    $-16, %rsp

    // ExclusiveExecutor(thread, newCJThread)
    //                     rdi      rsi
    movq    -88(%rbp), %rdi
    movq    -160(%rbp), %rsi
    callq   ExclusiveExecutor@PLT

    movq    %rax, %r13
    movapd  %xmm0, -128(%rbp)
    movapd  %xmm1, -144(%rbp)

    // ==================== switch back to cjthread stack ====================
    movq    -104(%rbp), %rsp

    // ExclusiveRestore(oldCJThread, thread, newCJThread, oldProcessor)
    //                     rdi         rsi      rdx         rcx
    movq    -80(%rbp), %rdi
    movq    -88(%rbp), %rsi
    movq    -160(%rbp), %rdx
    movq    -168(%rbp), %rcx    // oldProcessor
    callq   ExclusiveRestore@PLT

    // ==================== continue ====================
    movq    %r13, -112(%rbp)

    // ==================== LeaveSaferegion ====================
    movq    -96(%rbp), %rax
    cmpq    $0, %rax
    je      .L_exc_skip_leave
    callq   MRT_LeaveSaferegion@PLT
    callq   MRT_GetThreadLocalData@PLT
    movq    %rax, %r13
.L_exc_skip_leave:

    movq    %r13, %rdi
    callq   MRT_DeleteC2NContext@PLT

    movq    -112(%rbp), %rax
    movapd  -128(%rbp), %xmm0
    movapd  -144(%rbp), %xmm1

    jmp     .L_exc_cleanup

// ==================== exception ====================
.L_exc_create_failed:
.L_exc_no_cjthread:
.L_exc_no_thread:
    xorq    %rax, %rax

.L_exc_cleanup:
    movq    -8(%rbp),  %r15
    movq    -16(%rbp), %r14
    movq    -24(%rbp), %r13
    movq    -32(%rbp), %r12
    movq    -40(%rbp), %rbx

    addq    $ExclusiveScopeFrameSize, %rsp
    popq    %rbp
    .cfi_def_cfa %rsp, 8
    retq

    .cfi_endproc
    .size CJ_MCC_ExclusiveScope, .-CJ_MCC_ExclusiveScope


//   void* ExecuteExclusiveCangjieStub(void* sret, void* arg1, void* closureObj, void* executeClosure, void* threadData)
//                                     rdi         rsi         rdx             rcx                 r8
//
// Update r15 with threadData before executing closure

    .text
    .align 2
    .global   ExecuteExclusiveCangjieStub
    .type     ExecuteExclusiveCangjieStub, @function
ExecuteExclusiveCangjieStub:
    .cfi_startproc
    pushq   %rbp
    .cfi_def_cfa_offset 16
    .cfi_offset %rbp, -16
    movq    %rsp, %rbp
    .cfi_def_cfa_register %rbp
    subq    $96, %rsp

    movq    %r15, -8(%rbp)
    movq    %r14, -16(%rbp)
    movq    %r13, -24(%rbp)
    movq    %r12, -32(%rbp)
    movq    %rbx, -40(%rbp)
    .cfi_rel_offset %rbx, -40
    .cfi_rel_offset %r12, -32
    .cfi_rel_offset %r13, -24
    .cfi_rel_offset %r14, -16
    .cfi_rel_offset %r15, -8

    // Save arguments directly to the slots used for closure call
    movq    %rdi, -48(%rbp)     // sret
    movq    %rdx, -56(%rbp)     // closureObj (remap to arg1 slot)
    movq    %rcx, -64(%rbp)     // executeClosure (remap to arg2 slot)
    movq    %r8,  -80(%rbp)     // threadData

    // Update r15 with new ThreadLocalData from r8
    movq    %r8, %r15

    // SaveTopManagedContext
    movq    %rbp, %rdi
    callq   MRT_SaveTopManagedContextToN2CStub@PLT

    movq    -48(%rbp), %rdi
    movq    -56(%rbp), %rdx

    // get func from executeClosure
    movq    -64(%rbp), %r11
    movq    8(%r11),   %r11

    callq   *%r11
    .global unwindPCForExclusiveStubFull
unwindPCForExclusiveStubFull:

    // RestoreTopManagedContext
    movq    %rbp, %rdi
    callq   MRT_RestoreTopManagedContextFromN2CStub@PLT

    movq    -8(%rbp),  %r15
    movq    -16(%rbp), %r14
    movq    -24(%rbp), %r13
    movq    -32(%rbp), %r12
    movq    -40(%rbp), %rbx

    addq    $96, %rsp
    popq    %rbp
    .cfi_def_cfa %rsp, 8
    retq
    .cfi_endproc
    .size ExecuteExclusiveCangjieStub, .-ExecuteExclusiveCangjieStub