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
#define THREAD_PROCESSOR_OFFSET     0x38
#define ExclusiveScopeFrameSize     (8 * 22)

// Debug function to print thread context info
    .text
    .global ExclusiveScopeDebugInfo
ExclusiveScopeDebugInfo:
    .seh_proc ExclusiveScopeDebugInfo
    pushq   %rbp
    .seh_pushreg %rbp
    movq    %rsp, %rbp
    .seh_setframe %rbp, 0
    subq    $64, %rsp
    .seh_stackalloc 64
    .seh_endprologue
    
    // Get cjthread
    callq   CJ_CJThreadGetHandle
    testq   %rax, %rax
    jz      .L_debug_no_cjthread
    
    movq    %rax, %rbx              // save cjthread
    
    // Get thread
    movq    CJTHREAD_THREAD_OFFSET(%rax), %r12
    testq   %r12, %r12
    jz      .L_debug_no_thread
    
    // Get thread->context.rsp
    leaq    THREAD_CONTEXT_OFFSET(%r12), %r13
    movq    CONTEXT_RSP(%r13), %r14
    
    // Print values (placeholder - would need actual printf)
    // For now, just set breakpoint here and inspect registers
    // r12 = thread pointer
    // r13 = &thread->context
    // r14 = thread->context.rsp
    
    movq    %rbp, %rsp
    popq    %rbp
    ret
    
.L_debug_no_cjthread:
    movq    %rbp, %rsp
    popq    %rbp
    ret
    
.L_debug_no_thread:
    movq    %rbp, %rsp
    popq    %rbp
    ret
    .seh_endproc

// ==============================================================================
// CJ_MCC_ExclusiveScope: Switch from cjthread to OS thread for exclusive execution
// ==============================================================================
//
//   void* CJ_MCC_ExclusiveScope(void* executeClosure, void* closurePtr)
//                                    rcx              rdx

    .text
    .p2align 4, 0x90
    .def CJ_MCC_ExclusiveScope
    .scl 2
    .type 32
    .endef
    .global CJ_MCC_ExclusiveScope
CJ_MCC_ExclusiveScope:
    .seh_proc CJ_MCC_ExclusiveScope
    
    pushq   %rbp
    .seh_pushreg %rbp
    movq    %rsp, %rbp
    .seh_setframe %rbp, 0
    subq    $ExclusiveScopeFrameSize, %rsp
    .seh_stackalloc ExclusiveScopeFrameSize
    .seh_endprologue
    
    // Save callee-saved registers
    movq    %r15, -8(%rbp)
    movq    %r14, -16(%rbp)
    movq    %r13, -24(%rbp)
    movq    %r12, -32(%rbp)
    movq    %rbx, -40(%rbp)
    
    // Save arguments
    movq    %rcx, -48(%rbp)     // executeClosure
    movq    %rdx, -56(%rbp)     // closurePtr
    movq    %r15, -64(%rbp)     // original ThreadLocalData*
    
    // Get oldCJThread and thread
    callq   CJ_CJThreadGetHandle
    testq   %rax, %rax
    jz      .L_exc_no_cjthread
    movq    %rax, -80(%rbp)     // oldCJThread
    
    // thread = oldCJThread->thread
    movq    CJTHREAD_THREAD_OFFSET(%rax), %r12
    testq   %r12, %r12
    jz      .L_exc_no_thread
    movq    %r12, -88(%rbp)     // thread
    
    // Save original processor
    movq    THREAD_PROCESSOR_OFFSET(%r12), %r11
    movq    %r11, -168(%rbp)    // oldProcessor
    
    // MCC_NewExclusiveCJThread(executeClosure, closurePtr, futureTi)
    //                              rcx           rdx        r8
    movq    -48(%rbp), %rcx     // executeClosure
    movq    -56(%rbp), %rdx     // closurePtr
    movq    $0, %r8             // futureTi = 0
    callq   MCC_NewExclusiveCJThread
    testq   %rax, %rax
    jz      .L_exc_create_failed
    movq    %rax, -160(%rbp)    // newCJThread
    
    // Save C2N context with proper unwind stub location
    // This technique ensures unwindPCForExclusiveStub points to the correct PC
    movq    %rbp, %rdx                   // frame address
    // Get the current pc address through the following two assembly instructions.
    call    .L_exc_get_pc_win
.L_exc_get_pc_win:
    .global unwindPCForExclusiveStub
unwindPCForExclusiveStub:
    pop     %rcx                         // PC (return address)
    movq    %r15, %r8                    // r15 (ThreadLocalData)
    callq   MRT_SaveC2NContext
    
    // Enter saferegion
    movq    $0, %rcx
    callq   MRT_EnterSaferegion
    movq    %rax, -96(%rbp)     // save return value
    
    // Save current stack pointer before switch
    movq    %rsp, -104(%rbp)
    
    // Save oldCJThread context
    movq    -80(%rbp), %rax     // oldCJThread
    leaq    CJTHREAD_CONTEXT_OFFSET(%rax), %r14
    
    leaq    8(%rsp), %r11
    movq    %r11, CONTEXT_RSP(%r14)
    movq    %rbp, CONTEXT_RBP(%r14)
    movq    %rbx, CONTEXT_RBX(%r14)
    movq    (%rsp), %r11        // return address
    movq    %r11, CONTEXT_RIP(%r14)
    movq    %r12, CONTEXT_R12(%r14)
    movq    %r13, CONTEXT_R13(%r14)
    movq    -16(%rbp), %r11     // restore r14
    movq    %r11, CONTEXT_R14(%r14)
    movq    -8(%rbp), %r11      // restore r15
    movq    %r11, CONTEXT_R15(%r14)
    stmxcsr CONTEXT_MXCSR(%r14)
    fnstcw  CONTEXT_FPU_CW(%r14)
    
    // Check if already on OS thread stack (nested exclusive scope).
    // If so, skip stack switch to avoid clobbering current frames.
    movq    -80(%rbp), %rcx     // oldCJThread
    callq   IsExclusiveCJThread
    testl   %eax, %eax
    jnz     .L_exc_no_os_stack

    // Load parameters into registers BEFORE switching stack
    movq    -88(%rbp), %r12     // thread
    
    // Check if thread->context.rsp is valid
    leaq    THREAD_CONTEXT_OFFSET(%r12), %r15
    movq    CONTEXT_RSP(%r15), %rax
    testq   %rax, %rax
    jz      .L_exc_no_os_stack  // rsp is 0, don't switch stacks
    
    // Switch to OS thread stack
    movq    %rax, %rsp
    ldmxcsr CONTEXT_MXCSR(%r15)
    fldcw   CONTEXT_FPU_CW(%r15)
    
    // Align stack
    subq    $128, %rsp
    andq    $-16, %rsp
    subq    $32, %rsp           // shadow space
    
    // Execute closure: ExclusiveExecutor(thread, newCJThread)
    // Load parameters from stack frame (not registers, as they may be clobbered)
    movq    -88(%rbp), %rcx     // thread
    movq    -160(%rbp), %rdx    // newCJThread
    callq   ExclusiveExecutor
    
    // Save return values
    movq    %rax, %r13
    movapd  %xmm0, -128(%rbp)
    movapd  %xmm1, -144(%rbp)
    
    // Switch back to cjthread stack
    movq    -104(%rbp), %rsp
    
    // ExclusiveRestore(oldCJThread, thread, newCJThread, oldProcessor)
    // Load all parameters from stack frame
    movq    -80(%rbp), %rcx     // oldCJThread
    movq    -88(%rbp), %rdx     // thread
    movq    -160(%rbp), %r8     // newCJThread
    movq    -168(%rbp), %r9     // oldProcessor
    callq   ExclusiveRestore
    
    // Save return values to stack
    movq    %r13, -112(%rbp)
    // xmm0/xmm1 already saved to -128(%rbp)/-144(%rbp)
    jmp     .L_exc_continue

.L_exc_no_os_stack:
    // No valid OS stack - execute on current cjthread stack
    // This happens when ScheduleStart was never called
    movq    -88(%rbp), %rcx     // thread
    movq    -160(%rbp), %rdx    // newCJThread
    subq    $32, %rsp
    callq   ExclusiveExecutor
    addq    $32, %rsp
    
    movq    %rax, -112(%rbp)
    movapd  %xmm0, -128(%rbp)
    movapd  %xmm1, -144(%rbp)
    
    movq    -80(%rbp), %rcx     // oldCJThread
    movq    -88(%rbp), %rdx     // thread
    movq    -160(%rbp), %r8     // newCJThread
    movq    -168(%rbp), %r9     // oldProcessor
    subq    $32, %rsp
    callq   ExclusiveRestore
    addq    $32, %rsp

.L_exc_continue:
    
    // Leave saferegion
    movq    -96(%rbp), %rax
    cmpq    $0, %rax
    je      .L_exc_skip_leave
    callq   MRT_LeaveSaferegion
    callq   MRT_GetThreadLocalData
    movq    %rax, %r13
    jmp     .L_exc_do_delete
.L_exc_skip_leave:
    movq    -64(%rbp), %r13
.L_exc_do_delete:
    // Delete C2N context
    movq    %r13, %rcx
    callq   MRT_DeleteC2NContext
    
    // Restore return values
    movq    -112(%rbp), %rax
    movapd  -128(%rbp), %xmm0
    movapd  -144(%rbp), %xmm1
    
    jmp     .L_exc_cleanup

// Exception paths
.L_exc_create_failed:
.L_exc_no_cjthread:
.L_exc_no_thread:
    xorq    %rax, %rax

.L_exc_cleanup:
    // Restore callee-saved registers
    movq    -8(%rbp), %r15
    movq    -16(%rbp), %r14
    movq    -24(%rbp), %r13
    movq    -32(%rbp), %r12
    movq    -40(%rbp), %rbx
    
    // Restore stack and return
    movq    %rbp, %rsp
    popq    %rbp
    ret
    .seh_endproc

// ==============================================================================
// ExecuteExclusiveCangjieStub
// ==============================================================================
    .global ExecuteExclusiveCangjieStub
ExecuteExclusiveCangjieStub:
    .seh_proc ExecuteExclusiveCangjieStub
    
    pushq   %rbp
    .seh_pushreg %rbp
    movq    %rsp, %rbp
    .seh_setframe %rbp, 0
    subq    $128, %rsp          // 80 bytes locals + 32 bytes shadow space + 16 bytes alignment
    .seh_stackalloc 128
    .seh_endprologue
    
    // Save callee-saved registers
    movq    %r15, -8(%rbp)
    movq    %r14, -16(%rbp)
    movq    %r13, -24(%rbp)
    movq    %r12, -32(%rbp)
    movq    %rbx, -40(%rbp)
    
    // Windows x64: rcx=sret, rdx=arg1, r8=closureObj, r9=executeClosure, stack=[threadData]
    movq    %rcx, -48(%rbp)     // sret
    movq    %r8, -56(%rbp)      // closureObj
    movq    %r9, -64(%rbp)      // executeClosure
    movq    48(%rbp), %rax      // threadData (5th param on stack)
    movq    %rax, -80(%rbp)
    
    // Update r15 with threadData
    movq    %rax, %r15
    
    // SaveTopManagedContext
    movq    %rbp, %rcx
    callq   MRT_SaveTopManagedContextToN2CStub
    
    // Get closure function pointer
    movq    -64(%rbp), %r11     // executeClosure
    movq    8(%r11), %r11       // func = executeClosure->vtable[1]
    
    // Call closure: func(sret, closureObj)
    movq    -48(%rbp), %rcx     // sret
    movq    -56(%rbp), %rdx     // closureObj
    callq   *%r11
    
    .global unwindPCForExclusiveStubFull
unwindPCForExclusiveStubFull:
    // RestoreTopManagedContext
    movq    %rbp, %rcx
    callq   MRT_RestoreTopManagedContextFromN2CStub
    // Restore callee-saved registers
    movq    -8(%rbp), %r15
    movq    -16(%rbp), %r14
    movq    -24(%rbp), %r13
    movq    -32(%rbp), %r12
    movq    -40(%rbp), %rbx
    
    movq    %rbp, %rsp
    popq    %rbp
    ret
    .seh_endproc
