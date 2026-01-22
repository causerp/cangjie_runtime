// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#define cfi_adjust_cfa_offset(off)      .cfi_adjust_cfa_offset off
#define cfi_rel_offset(reg, off)        .cfi_rel_offset reg, off
#define cfi_restore(reg)                .cfi_restore reg
#define cfi_def_cfa_register(reg)       .cfi_def_cfa_register reg

// CJThread structure offsets
#define CJTHREAD_THREAD_OFFSET      0x10
#define CJTHREAD_CONTEXT_OFFSET     0x18

// CJThreadContext structure offsets for aarch64
#define CONTEXT_X18                 0x00
#define CONTEXT_X19                 0x08
#define CONTEXT_X20                 0x10
#define CONTEXT_X21                 0x18
#define CONTEXT_X22                 0x20
#define CONTEXT_X23                 0x28
#define CONTEXT_X24                 0x30
#define CONTEXT_X25                 0x38
#define CONTEXT_X26                 0x40
#define CONTEXT_X27                 0x48
#define CONTEXT_X28                 0x50
#define CONTEXT_X29_FP              0x58
#define CONTEXT_X30_LR              0x60
#define CONTEXT_PC                  0x68
#define CONTEXT_SP                  0x70
#define CONTEXT_D8                  0x78
#define CONTEXT_D9                  0x80
#define CONTEXT_D10                 0x88
#define CONTEXT_D11                 0x90
#define CONTEXT_D12                 0x98
#define CONTEXT_D13                 0xa0
#define CONTEXT_D14                 0xa8
#define CONTEXT_D15                 0xb0
#define CONTEXT_FPCR                0xb8

// Thread structure offset to context
#define THREAD_CONTEXT_OFFSET       0x78
#define THREAD_PROCESSOR_OFFSET     0x38
#define ExclusiveScopeFrameSize     (16 * 16)

// ==============================================================================
// CJ_MCC_ExclusiveScope: Switch from cjthread to OS thread for exclusive execution
// ==============================================================================
//
//   void* CJ_MCC_ExclusiveScope(void* executeClosure, void* closurePtr)
//                                    x0              x1
//
// 1. Create exclusive cjthread
// 2. Switch to OS thread
// 3. Execute closure
// 4. Switch back to cjthread

    .text
    .align 2
    .global CJ_MCC_ExclusiveScope
    .type CJ_MCC_ExclusiveScope, @function
CJ_MCC_ExclusiveScope:
    .cfi_startproc
#if defined(ENABLE_BACKWARD_PTRAUTH_CFI)
    paciasp
#endif
    stp     x29, x30, [sp, #-ExclusiveScopeFrameSize]!
    cfi_adjust_cfa_offset(ExclusiveScopeFrameSize)
    cfi_rel_offset(x29, 0)
    cfi_rel_offset(x30, 8)
    mov     x29, sp
    cfi_def_cfa_register(x29)

    // Save callee-saved registers (GC scans from x29+0x20)
    stp     x19, x20, [x29, #0x20]
    cfi_rel_offset(x19, 0x20)
    cfi_rel_offset(x20, 0x28)
    stp     x21, x22, [x29, #0x30]
    cfi_rel_offset(x21, 0x30)
    cfi_rel_offset(x22, 0x38)
    stp     x23, x24, [x29, #0x40]
    cfi_rel_offset(x23, 0x40)
    cfi_rel_offset(x24, 0x48)
    stp     x25, x26, [x29, #0x50]
    cfi_rel_offset(x25, 0x50)
    cfi_rel_offset(x26, 0x58)
    stp     x27, x28, [x29, #0x60]
    cfi_rel_offset(x27, 0x60)
    cfi_rel_offset(x28, 0x68)

    stp     d8, d9, [x29, #0x70]
    stp     d10, d11, [x29, #0x80]
    stp     d12, d13, [x29, #0x90]
    stp     d14, d15, [x29, #0xa0]

    mov     x19, x0                     // executeClosure
    mov     x20, x1                     // closurePtr

    // get oldCJThread, thread, oldProcessor
    bl      CJ_CJThreadGetHandle
    cbz     x0, .L_exc_no_cjthread
    str     x0, [x29, #0xe8]            // oldCJThread

    ldr     x1, [x0, #CJTHREAD_THREAD_OFFSET]
    cbz     x1, .L_exc_no_thread
    str     x1, [x29, #0xf0]            // thread

    // Save oldProcessor before it's modified by ExclusiveExecutor
    // thread->processor is at offset THREAD_PROCESSOR_OFFSET (0x38)
    ldr     x2, [x1, #THREAD_PROCESSOR_OFFSET]
    str     x2, [x29, #0xf8]            // oldProcessor

    // Create new exclusive cjthread
    mov     x0, x19
    mov     x1, x20
    mov     x2, xzr                     // futureTi = 0
    bl      MCC_NewExclusiveCJThread
    cbz     x0, .L_exc_create_failed
    str     x0, [x29, #0xe0]            // newCJThread

    // Save C2N context (unwindPCForExclusiveStub must be before MRT_SaveC2NContext)
    .global unwindPCForExclusiveStub
unwindPCForExclusiveStub:
    adr     x0, unwindPCForExclusiveStub
    mov     x1, x29
    mov     x2, x28
    bl      MRT_SaveC2NContext

    mov     x0, #0
    bl      MRT_EnterSaferegion
    str     x0, [x29, #0xc0]            // enterSafe
    mov     x0, sp
    str     x0, [x29, #0xc8]            // saved sp

    // Save cjthread context
    ldr     x22, [x29, #0xe8]           // oldCJThread
    ldr     x23, [x29, #0xf0]           // thread
    add     x26, x22, #CJTHREAD_CONTEXT_OFFSET

    str     x18, [x26, #CONTEXT_X18]
    str     x19, [x26, #CONTEXT_X19]
    str     x20, [x26, #CONTEXT_X20]
    str     x21, [x26, #CONTEXT_X21]
    str     x22, [x26, #CONTEXT_X22]
    str     x23, [x26, #CONTEXT_X23]
    str     x24, [x26, #CONTEXT_X24]
    str     x25, [x26, #CONTEXT_X25]
    str     x26, [x26, #CONTEXT_X26]
    str     x27, [x26, #CONTEXT_X27]
    str     x28, [x26, #CONTEXT_X28]
    str     x29, [x26, #CONTEXT_X29_FP]
    str     x30, [x26, #CONTEXT_X30_LR]
    adr     x0, .L_exc_return_point
    str     x0, [x26, #CONTEXT_PC]
    mov     x0, sp
    str     x0, [x26, #CONTEXT_SP]

    str     d8,  [x26, #CONTEXT_D8]
    str     d9,  [x26, #CONTEXT_D9]
    str     d10, [x26, #CONTEXT_D10]
    str     d11, [x26, #CONTEXT_D11]
    str     d12, [x26, #CONTEXT_D12]
    str     d13, [x26, #CONTEXT_D13]
    str     d14, [x26, #CONTEXT_D14]
    str     d15, [x26, #CONTEXT_D15]
    mrs     x0, fpcr
    str     w0, [x26, #CONTEXT_FPCR]

    // Switch to OS thread
    add     x27, x23, #THREAD_CONTEXT_OFFSET
    ldr     x0, [x27, #CONTEXT_SP]
    mov     sp, x0
    ldr     w0, [x27, #CONTEXT_FPCR]
    msr     fpcr, x0

    sub     sp, sp, #128
    mov     x0, sp
    bic     x0, x0, #0xF
    mov     sp, x0

    // Execute closure
    ldr     x0, [x29, #0xf0]            // thread
    ldr     x1, [x29, #0xe0]            // newCJThread
    bl      ExclusiveExecutor

    // Restore to original stack frame (still on current function's stack)
    ldr     x0, [x29, #0xc8]            // saved sp
    mov     sp, x0

    // Call ExclusiveRestore to complete the restoration
    // Important: Call on current stack, not oldCJThread's saved stack
    // ExclusiveRestore(oldCJThread, thread, newCJThread, oldProcessor)
    //                     x0          x1       x2           x3
    ldr     x0, [x29, #0xe8]            // oldCJThread
    ldr     x1, [x29, #0xf0]            // thread
    ldr     x2, [x29, #0xe0]            // newCJThread
    ldr     x3, [x29, #0xf8]            // oldProcessor
    bl      ExclusiveRestore

    // After ExclusiveRestore, continue cleanup

.L_exc_return_point:
    ldr     x0, [x29, #0xc8]
    mov     sp, x0

    ldr     x0, [x29, #0xc0]            // enterSafe
    cbz     x0, .L_exc_skip_leave
    bl      MRT_LeaveSaferegion
    bl      MRT_GetThreadLocalData
    mov     x19, x0
    b       .L_exc_do_delete

.L_exc_skip_leave:
    mov     x19, x28

.L_exc_do_delete:
    mov     x0, x19
    bl      MRT_DeleteC2NContext
    mov     x0, xzr
    b       .L_exc_cleanup

.L_exc_create_failed:
.L_exc_no_cjthread:
.L_exc_no_thread:
    mov     x0, xzr

.L_exc_cleanup:
    ldp     d8, d9, [x29, #0x70]
    ldp     d10, d11, [x29, #0x80]
    ldp     d12, d13, [x29, #0x90]
    ldp     d14, d15, [x29, #0xa0]

    ldp     x19, x20, [x29, #0x20]
    cfi_restore(x19)
    cfi_restore(x20)
    ldp     x21, x22, [x29, #0x30]
    cfi_restore(x21)
    cfi_restore(x22)
    ldp     x23, x24, [x29, #0x40]
    cfi_restore(x23)
    cfi_restore(x24)
    ldp     x25, x26, [x29, #0x50]
    cfi_restore(x25)
    cfi_restore(x26)
    ldp     x27, x28, [x29, #0x60]
    cfi_restore(x27)
    cfi_restore(x28)

    ldp     x29, x30, [sp], #ExclusiveScopeFrameSize
    cfi_adjust_cfa_offset(-ExclusiveScopeFrameSize)
    cfi_restore(x29)
    cfi_restore(x30)

#if defined(ENABLE_BACKWARD_PTRAUTH_CFI)
    autiasp
#endif
    ret

    .cfi_endproc
    .size CJ_MCC_ExclusiveScope, .-CJ_MCC_ExclusiveScope


// ==============================================================================
// ExecuteExclusiveCangjieStub: Execute Cangjie closure with new ThreadLocalData
// ==============================================================================
//
//   void* ExecuteExclusiveCangjieStub(void* closureObj, void* arg1, void* executeClosure,
//                                void* threadData, void* sret)
//                                 x0            x1        x2
//                                 x3            x4
//
// Update x28 with threadData before executing closure, sret in x8

    .text
    .align 2
    .global ExecuteExclusiveCangjieStub
    .type ExecuteExclusiveCangjieStub, @function
ExecuteExclusiveCangjieStub:
    .cfi_startproc
#if defined(ENABLE_BACKWARD_PTRAUTH_CFI)
    paciasp
#endif
    stp     x29, x30, [sp, #-96]!
    cfi_adjust_cfa_offset(96)
    cfi_rel_offset(x29, 0)
    cfi_rel_offset(x30, 8)
    mov     x29, sp
    cfi_def_cfa_register(x29)

    stp     x19, x20, [sp, #0x10]
    cfi_rel_offset(x19, 0x10)
    cfi_rel_offset(x20, 0x18)
    stp     x27, x28, [sp, #0x20]
    cfi_rel_offset(x27, 0x20)
    cfi_rel_offset(x28, 0x28)

    // Save object references to stack for GC scanning
    str     x0, [sp, #0x30]     // closureObj
    str     x2, [sp, #0x38]     // executeClosure
    str     x4, [sp, #0x40]     // sret

    mov     x28, x3
    mov     x0, x29
    bl      MRT_SaveTopManagedContextToN2CStub

    // Reload references (may be updated by GC)
    ldr     x19, [sp, #0x30]
    ldr     x20, [sp, #0x38]
    ldr     x21, [sp, #0x40]

    mov     x8, x21
    mov     x0, x21
    mov     x1, x19
    ldr     x9, [x20, #8]
    blr     x9

    .global unwindPCForExclusiveStubFull
unwindPCForExclusiveStubFull:
    mov     x19, x0
    mov     x0, x29
    bl      MRT_RestoreTopManagedContextFromN2CStub
    mov     x0, x19

    ldp     x19, x20, [sp, #0x10]
    cfi_restore(x19)
    cfi_restore(x20)
    ldp     x27, x28, [sp, #0x20]
    cfi_restore(x27)
    cfi_restore(x28)

    ldp     x29, x30, [sp], #96
    cfi_adjust_cfa_offset(-96)
    cfi_restore(x29)
    cfi_restore(x30)

#if defined(ENABLE_BACKWARD_PTRAUTH_CFI)
    autiasp
#endif
    ret

    .cfi_endproc
    .size ExecuteExclusiveCangjieStub, .-ExecuteExclusiveCangjieStub