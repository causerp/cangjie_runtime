// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// context include all callee saved register
// stack need to be 16-byte aligned, so we should use (8 * even numbers)
#define ContextSize (8 * 30)

// This assembly function is only used in exception handling.
// It is easier to maintain the stack structure and register status by using assembly.
// Used to restore the callee saved register and frame pointer layer by layer.
// Finally, jump to the landingpad of catch pointer.
    .def     RestoreContextForEH;
    .scl    2;
    .type   32;
    .endef
    .globl RestoreContextForEH
    .p2align    4, 0x90
RestoreContextForEH:
.seh_proc RestoreContextForEH
    // Current rsp point to the top managed method.
    movq    %rsp, %rcx
    subq    $ContextSize, %rsp

    // Save all callee saved register to stack as the layout of context struct.
    movq    %rbx, (%rsp)
    movq    %rsi, 8(%rsp)
    movq    %rdi, 16(%rsp)
    movq    %r12, 24(%rsp)
    movq    %r13, 32(%rsp)
    movq    %r14, 40(%rsp)
    movq    %r15, 48(%rsp)
    movapd  %xmm6, 64(%rsp)
    movapd  %xmm7, 80(%rsp)
    movapd  %xmm8, 96(%rsp)
    movapd  %xmm9, 112(%rsp)
    movapd  %xmm10, 128(%rsp)
    movapd  %xmm11, 144(%rsp)
    movapd  %xmm12, 160(%rsp)
    movapd  %xmm13, 176(%rsp)
    movapd  %xmm14, 192(%rsp)
    movapd  %xmm15, 208(%rsp)
    movq    %rbp, 224(%rsp)
    movq    %rcx, 232(%rsp)

    // Current rsp point to the context struct address.
    movq    %rsp, %rcx
    callq   MRT_RestoreContext

    // Restore all callee saved register.
    movq    (%rsp), %rbx
    movq    8(%rsp), %rsi
    movq    16(%rsp), %rdi
    movq    24(%rsp), %r12
    movq    32(%rsp), %r13
    movq    40(%rsp), %r14
    movq    48(%rsp), %r15
    movapd  64(%rsp), %xmm6
    movapd  80(%rsp), %xmm7
    movapd  96(%rsp), %xmm8
    movapd  112(%rsp), %xmm9
    movapd  128(%rsp), %xmm10
    movapd  144(%rsp), %xmm11
    movapd  160(%rsp), %xmm12
    movapd  176(%rsp), %xmm13
    movapd  192(%rsp), %xmm14
    movapd  208(%rsp), %xmm15
    movq    224(%rsp), %rbp
    movq    232(%rsp), %rsp

    // jump to landingpad.
    jmpq   *%rax
    .seh_endproc
