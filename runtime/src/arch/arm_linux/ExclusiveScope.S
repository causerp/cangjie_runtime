// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#define cfi_adjust_cfa_offset(off)      .cfi_adjust_cfa_offset off
#define cfi_rel_offset(reg, off)        .cfi_rel_offset reg, off
#define cfi_restore(reg)                .cfi_restore reg
#define cfi_def_cfa_register(reg)       .cfi_def_cfa_register reg

// CJThread structure offsets for ARM32
#define CJTHREAD_THREAD_OFFSET      0x08
#define CJTHREAD_CONTEXT_OFFSET     0x10

// CJThreadContext structure offsets for ARM32
#define CONTEXT_R4                  0x00
#define CONTEXT_R5                  0x04
#define CONTEXT_R6                  0x08
#define CONTEXT_R7                  0x0c
#define CONTEXT_R8                  0x10
#define CONTEXT_R9                  0x14
#define CONTEXT_R10                 0x18
#define CONTEXT_R11FP               0x1c
#define CONTEXT_R13SP               0x20
#define CONTEXT_R14LR               0x24
#define CONTEXT_R15PC               0x28
#define CONTEXT_ARM32_D8            0x2c
#define CONTEXT_ARM32_D9            0x34
#define CONTEXT_ARM32_D10           0x3c
#define CONTEXT_ARM32_D11           0x44
#define CONTEXT_ARM32_D12           0x4c
#define CONTEXT_ARM32_D13           0x54
#define CONTEXT_ARM32_D14           0x5c
#define CONTEXT_ARM32_D15           0x64
#define CONTEXT_FPSCR               0x6c

#define THREAD_PROCESSOR_OFFSET     0x1c
#define ExclusiveScopeFrameSize     144

// ==============================================================================
// CJ_MCC_ExclusiveScope: Switch from cjthread to OS thread for exclusive execution
// ==============================================================================
//
//   void* CJ_MCC_ExclusiveScope(void* executeClosure, void* closurePtr)
//                                    r0              r1
//
// 1. Create exclusive cjthread
// 2. Switch to OS thread
// 3. Execute closure
// 4. Switch back to cjthread
//
// Frame layout (ExclusiveScopeFrameSize = 144 = 0x90):
//   0x00  r11 (fp)
//   0x04  lr
//   0x08  N2CSlotData: pc     (reserved for MRT_SaveC2NContext)
//   0x0c  N2CSlotData: fa     (reserved for MRT_SaveC2NContext)
//   0x10  N2CSlotData: status (reserved for MRT_SaveC2NContext)
//   0x14  r4  (callee-saved)
//   0x18  r5  (callee-saved)
//   0x1c  r6  (callee-saved)
//   0x20  r7  (callee-saved)
//   0x24  r8  (callee-saved)
//   0x28  r9  (callee-saved)
//   0x2c  r10 (callee-saved)
//   0x30  d8
//   0x38  d9
//   0x40  d10
//   0x48  d11
//   0x50  d12
//   0x58  d13
//   0x60  d14
//   0x68  d15
//   0x70  newCJThread
//   0x74  oldCJThread
//   0x78  thread
//   0x7c  oldProcessor
//   0x80  enterSafe
//   0x84  saved sp

    .text
    .align 2
    .global CJ_MCC_ExclusiveScope
    .type CJ_MCC_ExclusiveScope, %function
CJ_MCC_ExclusiveScope:
    .cfi_startproc

    sub     sp, sp, #ExclusiveScopeFrameSize
    str     r11, [sp]
    str     lr, [sp, #0x04]
    cfi_adjust_cfa_offset(ExclusiveScopeFrameSize)
    cfi_rel_offset(r11, 0)
    cfi_rel_offset(lr, 4)
    mov     r11, sp
    cfi_def_cfa_register(r11)

    // Save callee-saved registers (starts at 0x14, leaving 0x08-0x13 for N2CSlotData)
    str     r4, [r11, #0x14]
    cfi_rel_offset(r4, 0x14)
    str     r5, [r11, #0x18]
    cfi_rel_offset(r5, 0x18)
    str     r6, [r11, #0x1c]
    cfi_rel_offset(r6, 0x1c)
    str     r7, [r11, #0x20]
    cfi_rel_offset(r7, 0x20)
    str     r8, [r11, #0x24]
    cfi_rel_offset(r8, 0x24)
    str     r9, [r11, #0x28]
    cfi_rel_offset(r9, 0x28)
    str     r10, [r11, #0x2c]
    cfi_rel_offset(r10, 0x2c)

    // Save VFP callee-saved registers
    vstr    d8, [r11, #0x30]
    vstr    d9, [r11, #0x38]
    vstr    d10, [r11, #0x40]
    vstr    d11, [r11, #0x48]
    vstr    d12, [r11, #0x50]
    vstr    d13, [r11, #0x58]
    vstr    d14, [r11, #0x60]
    vstr    d15, [r11, #0x68]

    mov     r4, r0                      // executeClosure
    mov     r5, r1                      // closurePtr

    // get oldCJThread, thread, oldProcessor
    bl      CJ_CJThreadGetHandle
    cmp     r0, #0
    beq     .L_exc_no_cjthread
    str     r0, [r11, #0x74]            // oldCJThread

    ldr     r1, [r0, #CJTHREAD_THREAD_OFFSET]
    cmp     r1, #0
    beq     .L_exc_no_thread
    str     r1, [r11, #0x78]            // thread

    // Save oldProcessor before it is modified by ExclusiveExecutor
    // thread->processor is at offset THREAD_PROCESSOR_OFFSET (0x1c)
    ldr     r2, [r1, #THREAD_PROCESSOR_OFFSET]
    str     r2, [r11, #0x7c]            // oldProcessor

    // Create new exclusive cjthread
    mov     r0, r4                      // executeClosure
    mov     r1, r5                      // closurePtr
    mov     r2, #0                      // futureTi = 0
    bl      MCC_NewExclusiveCJThread
    cmp     r0, #0
    beq     .L_exc_create_failed
    str     r0, [r11, #0x70]            // newCJThread

    // Save C2N context (unwindPCForExclusiveStub must be before MRT_SaveC2NContext)
    // First get ThreadLocalData
    bl      MRT_GetThreadLocalData
    mov     r10, r0                     // save TLD in r10

    .global unwindPCForExclusiveStub
unwindPCForExclusiveStub:
    adr     r0, unwindPCForExclusiveStub
    mov     r1, r11
    mov     r2, r10
    bl      MRT_SaveC2NContext

    mov     r0, #0
    bl      MRT_EnterSaferegion
    str     r0, [r11, #0x80]            // enterSafe
    str     sp, [r11, #0x84]            // saved sp

    // Save cjthread context
    ldr     r6, [r11, #0x74]            // oldCJThread
    ldr     r7, [r11, #0x78]            // thread
    add     r8, r6, #CJTHREAD_CONTEXT_OFFSET

    str     r4, [r8, #CONTEXT_R4]
    str     r5, [r8, #CONTEXT_R5]
    str     r6, [r8, #CONTEXT_R6]
    str     r7, [r8, #CONTEXT_R7]
    str     r8, [r8, #CONTEXT_R8]
    str     r9, [r8, #CONTEXT_R9]
    str     r10, [r8, #CONTEXT_R10]
    str     r11, [r8, #CONTEXT_R11FP]
    str     sp, [r8, #CONTEXT_R13SP]
    str     lr, [r8, #CONTEXT_R14LR]
    adr     r0, .L_exc_return_point
    str     r0, [r8, #CONTEXT_R15PC]

    vstr    d8, [r8, #CONTEXT_ARM32_D8]
    vstr    d9, [r8, #CONTEXT_ARM32_D9]
    vstr    d10, [r8, #CONTEXT_ARM32_D10]
    vstr    d11, [r8, #CONTEXT_ARM32_D11]
    vstr    d12, [r8, #CONTEXT_ARM32_D12]
    vstr    d13, [r8, #CONTEXT_ARM32_D13]
    vstr    d14, [r8, #CONTEXT_ARM32_D14]
    vstr    d15, [r8, #CONTEXT_ARM32_D15]
    vmrs    r0, fpscr
    str     r0, [r8, #CONTEXT_FPSCR]

    // Nested exclusive scope is already on OS thread stack.
    // Switching sp again to thread->context.sp may clobber current frames.
    ldr     r0, [r11, #0x74]            // oldCJThread
    bl      IsExclusiveCJThread
    cmp     r0, #0
    bne     .L_exc_skip_stack_switch

    // Switch to OS thread
    mov     r0, r7                      // arg0 = thread pointer
    bl      ExclusiveGetThreadContext   // returns void* = &thread->context
    cmp     r0, #0
    beq     .L_exc_skip_stack_switch
    mov     r9, r0                      // r9 = &thread->context
    ldr     r0, [r9, #CONTEXT_R13SP]

    // Validate saved stack pointer before switching.
    // If invalid (NULL / high-bit set / too small), skip stack switch.
    cmp     r0, #0
    beq     .L_exc_skip_stack_switch
    tst     r0, #0x80000000
    bne     .L_exc_skip_stack_switch
    cmp     r0, #0x1000
    blt     .L_exc_skip_stack_switch

    mov     sp, r0
    ldr     r0, [r9, #CONTEXT_FPSCR]
    vmsr    fpscr, r0

    sub     sp, sp, #64
    bic     sp, sp, #0x7

    // Execute closure
    ldr     r0, [r11, #0x78]            // thread
    ldr     r1, [r11, #0x70]            // newCJThread
    bl      ExclusiveExecutor
    b       .L_exc_after_executor

.L_exc_skip_stack_switch:
    // Already on OS thread stack, execute directly without switching sp.
    ldr     r0, [r11, #0x78]            // thread
    ldr     r1, [r11, #0x70]            // newCJThread
    bl      ExclusiveExecutor

.L_exc_after_executor:

    // Restore to original stack frame (still on current function's stack)
    ldr     r0, [r11, #0x84]            // saved sp
    mov     sp, r0

    // Call ExclusiveRestore to complete the restoration
    // ExclusiveRestore(oldCJThread, thread, newCJThread, oldProcessor)
    //                     r0          r1       r2           r3
    ldr     r0, [r11, #0x74]            // oldCJThread
    ldr     r1, [r11, #0x78]            // thread
    ldr     r2, [r11, #0x70]            // newCJThread
    ldr     r3, [r11, #0x7c]            // oldProcessor
    bl      ExclusiveRestore

    // After ExclusiveRestore, continue cleanup

.L_exc_return_point:
    ldr     r0, [r11, #0x84]
    mov     sp, r0

    ldr     r0, [r11, #0x80]            // enterSafe
    cmp     r0, #0
    beq     .L_exc_skip_leave
    bl      MRT_LeaveSaferegion
    bl      MRT_GetThreadLocalData
    mov     r4, r0
    b       .L_exc_do_delete

.L_exc_skip_leave:
    bl      MRT_GetThreadLocalData
    mov     r4, r0

.L_exc_do_delete:
    mov     r0, r4
    bl      MRT_DeleteC2NContext
    mov     r0, #0
    b       .L_exc_cleanup

.L_exc_create_failed:
.L_exc_no_cjthread:
.L_exc_no_thread:
    mov     r0, #0

.L_exc_cleanup:
    // Restore VFP callee-saved registers
    vldr    d8, [r11, #0x30]
    vldr    d9, [r11, #0x38]
    vldr    d10, [r11, #0x40]
    vldr    d11, [r11, #0x48]
    vldr    d12, [r11, #0x50]
    vldr    d13, [r11, #0x58]
    vldr    d14, [r11, #0x60]
    vldr    d15, [r11, #0x68]

    // Restore callee-saved registers
    ldr     r4, [r11, #0x14]
    cfi_restore(r4)
    ldr     r5, [r11, #0x18]
    cfi_restore(r5)
    ldr     r6, [r11, #0x1c]
    cfi_restore(r6)
    ldr     r7, [r11, #0x20]
    cfi_restore(r7)
    ldr     r8, [r11, #0x24]
    cfi_restore(r8)
    ldr     r9, [r11, #0x28]
    cfi_restore(r9)
    ldr     r10, [r11, #0x2c]
    cfi_restore(r10)

    ldr     r11, [sp]
    ldr     lr, [sp, #0x04]
    add     sp, sp, #ExclusiveScopeFrameSize
    cfi_adjust_cfa_offset(-ExclusiveScopeFrameSize)
    cfi_restore(r11)
    cfi_restore(lr)

    bx      lr

    .cfi_endproc
    .size CJ_MCC_ExclusiveScope, .-CJ_MCC_ExclusiveScope


// ==============================================================================
// ExecuteExclusiveCangjieStub: Execute Cangjie closure with new ThreadLocalData
// ==============================================================================
//
//   void* ExecuteExclusiveCangjieStub(void* sret, void* arg1, void* closureObj,
//                                     void* executeClosure, void* threadData)
//                                      r0        r1           r2
//                                      r3        [sp+0]
//
// Execute closure: load function pointer from executeClosure+8, call func(sret, closureObj)
//
// Frame layout (StubFrameSize = 64 = 0x40):
//   0x00  r11 (fp)
//   0x04  lr
//   0x08  N2CSlotData: pc     (reserved for MRT_SaveTopManagedContextToN2CStub)
//   0x0c  N2CSlotData: fa     (reserved for MRT_SaveTopManagedContextToN2CStub)
//   0x10  N2CSlotData: status (reserved for MRT_SaveTopManagedContextToN2CStub)
//   0x14  r4  (callee-saved)
//   0x18  r5  (callee-saved)
//   0x1c  r6  (callee-saved)
//   0x20  r10 (callee-saved)
//   0x24  sret (r0)
//   0x28  arg1 (r1)
//   0x2c  closureObj (r2)
//   0x30  executeClosure (r3)
//   0x34  original sp (for aligned stack restore)

#define StubFrameSize 64

    .text
    .align 2
    .global ExecuteExclusiveCangjieStub
    .type ExecuteExclusiveCangjieStub, %function
ExecuteExclusiveCangjieStub:
    .cfi_startproc

    // Ensure 16-byte stack alignment before calling closure.
    mov     r12, sp
    tst     sp, #0x0f
    it      ne
    subne   sp, sp, #8

    sub     sp, sp, #StubFrameSize
    str     r11, [sp]
    str     lr, [sp, #0x04]
    cfi_adjust_cfa_offset(StubFrameSize)
    cfi_rel_offset(r11, 0)
    cfi_rel_offset(lr, 4)
    mov     r11, sp
    cfi_def_cfa_register(r11)

    str     r4, [r11, #0x14]
    cfi_rel_offset(r4, 0x14)
    str     r5, [r11, #0x18]
    cfi_rel_offset(r5, 0x18)
    str     r6, [r11, #0x1c]
    cfi_rel_offset(r6, 0x1c)
    str     r10, [r11, #0x20]
    cfi_rel_offset(r10, 0x20)

    // Save call arguments across runtime calls
    str     r0, [r11, #0x24]            // sret
    str     r1, [r11, #0x28]            // arg1
    str     r2, [r11, #0x2c]            // closureObj
    str     r3, [r11, #0x30]            // executeClosure
    str     r12, [r11, #0x34]            // original sp before alignment

    // Save context for N2C
    mov     r0, r11
    bl      MRT_SaveTopManagedContextToN2CStub

    // Reload call arguments (may be updated by GC)
    ldr     r4, [r11, #0x24]            // sret
    ldr     r5, [r11, #0x28]            // arg1
    ldr     r6, [r11, #0x2c]            // closureObj
    ldr     r3, [r11, #0x30]            // executeClosure (must be in r3)

    // Call closure: func(sret, arg1, closureObj)
    mov     r0, r4                      // arg0 = sret
    mov     r1, r5                      // arg1 = arg1
    mov     r2, r6                      // arg2 = arg1
    ldr     r12, [r3, #8]               // load function pointer from executeClosure+8
    mov     r3, r5
    blx     r12

    .global unwindPCForExclusiveStubFull
unwindPCForExclusiveStubFull:
    mov     r4, r0                      // save return value

    mov     r0, r11
    bl      MRT_RestoreTopManagedContextFromN2CStub

    mov     r0, r4                      // restore return value

    ldr     r4, [r11, #0x14]
    cfi_restore(r4)
    ldr     r5, [r11, #0x18]
    cfi_restore(r5)
    ldr     r6, [r11, #0x1c]
    cfi_restore(r6)
    ldr     r10, [r11, #0x20]
    cfi_restore(r10)

    ldr     r12, [r11, #0x34]
    ldr     r11, [sp]
    ldr     lr, [sp, #0x04]
    mov     sp, r12
    cfi_def_cfa_register(sp)
    cfi_restore(r11)
    cfi_restore(lr)

    bx      lr

    .cfi_endproc
    .size ExecuteExclusiveCangjieStub, .-ExecuteExclusiveCangjieStub
