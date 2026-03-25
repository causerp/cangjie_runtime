// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#define I2NStubFrameSize (8 * 30)
#define CALLEE_ADDR %r8
#define THREAD_LOCAL_DATA %r9

// Frame layout (offsets from rbp):
//   rbp - 8:    rdi (arg1)
//   rbp - 16:   rsi (arg2)
//   rbp - 24:   rdx (arg3)
//   rbp - 32:   rcx (arg4)
//   rbp - 40:   CALLEE_ADDR (r8, arg5)
//   rbp - 48:   THREAD_LOCAL_DATA (r9, arg6)
//   rbp - 56:   rax (varargs vector register count)
//   (8 bytes padding for xmm alignment)
//   rbp - 80:   xmm0 (16 bytes)
//   rbp - 96:   xmm1 (16 bytes)
//   rbp - 112:  xmm2 (16 bytes)
//   rbp - 128:  xmm3 (16 bytes)
//   rbp - 144:  xmm4 (16 bytes)
//   rbp - 160:  xmm5 (16 bytes)
//   rbp - 176:  xmm6 (16 bytes)
//   rbp - 192:  xmm7 (16 bytes)
//   rbp - 200:  rax (return value)
//   rbp - 208:  rdx (return value)
//   rbp - 224:  xmm0 (return value, 16 bytes)
//   rbp - 240:  xmm1 (return value, 16 bytes)

    .text
    .align 2
    .global CJ_MCC_I2NStub
    .type CJ_MCC_I2NStub, @function
CJ_MCC_I2NStub:
    .cfi_startproc
    pushq   %rbp
    .cfi_def_cfa_offset 16
    .cfi_offset %rbp, -16
    movq    %rsp, %rbp
    .cfi_def_cfa_register %rbp
    subq    $I2NStubFrameSize, %rsp

    // Save integer argument registers
    movq    %rdi, -8(%rbp)
    movq    %rsi, -16(%rbp)
    movq    %rdx, -24(%rbp)
    movq    %rcx, -32(%rbp)
    movq    CALLEE_ADDR, -40(%rbp)
    movq    THREAD_LOCAL_DATA, -48(%rbp)
    movq    %rax, -56(%rbp)

    // Save floating-point argument registers
    movapd  %xmm0, -80(%rbp)
    movapd  %xmm1, -96(%rbp)
    movapd  %xmm2, -112(%rbp)
    movapd  %xmm3, -128(%rbp)
    movapd  %xmm4, -144(%rbp)
    movapd  %xmm5, -160(%rbp)
    movapd  %xmm6, -176(%rbp)
    movapd  %xmm7, -192(%rbp)

    // SaveC2NContext(pc, fa, threadLocalData)
    call    .L_current_pc
.L_current_pc:
    popq    %rdi
    movq    %rbp, %rsi
    movq    -48(%rbp), %rdx
    callq   MRT_SaveC2NContext@PLT

    // EnterSaferegion(false)
    movq    $0, %rdi
    callq   MRT_EnterSaferegion@PLT

    // Restore argument registers
    movq    -8(%rbp), %rdi
    movq    -16(%rbp), %rsi
    movq    -24(%rbp), %rdx
    movq    -32(%rbp), %rcx
    movq    -56(%rbp), %rax

    // Restore floating-point argument registers
    movapd  -80(%rbp), %xmm0
    movapd  -96(%rbp), %xmm1
    movapd  -112(%rbp), %xmm2
    movapd  -128(%rbp), %xmm3
    movapd  -144(%rbp), %xmm4
    movapd  -160(%rbp), %xmm5
    movapd  -176(%rbp), %xmm6
    movapd  -192(%rbp), %xmm7

    // Call callee
    movq    -40(%rbp), %r10
    callq   *%r10

    // Save return values
    movq    %rax, -200(%rbp)
    movq    %rdx, -208(%rbp)
    movapd  %xmm0, -224(%rbp)
    movapd  %xmm1, -240(%rbp)

    // LeaveSaferegion()
    callq   MRT_LeaveSaferegion@PLT

    // DeleteC2NContext(threadLocalData)
    movq    -48(%rbp), %rdi
    callq   MRT_DeleteC2NContext@PLT

    // ThrowPendingException(nullptr)
    movq    $0, %rdi
    callq   MRT_ThrowPendingException@PLT

    // Restore return values.
    movq    -200(%rbp), %rax
    movq    -208(%rbp), %rdx
    movapd  -224(%rbp), %xmm0
    movapd  -240(%rbp), %xmm1

    movq    %rbp, %rsp
    popq    %rbp
    .cfi_def_cfa %rsp, 8
    retq
    .cfi_endproc
    .size CJ_MCC_I2NStub, .-CJ_MCC_I2NStub

    .global CJ_MCC_I2NStubEnd
    .type CJ_MCC_I2NStubEnd, @function
CJ_MCC_I2NStubEnd:
    nop
    .size CJ_MCC_I2NStubEnd, .-CJ_MCC_I2NStubEnd
