// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// context include all callee saved register x19 x20 x21 x22 x23 x24 x25 x26 x27
// x28 and d8 d9 d10 d11 d12 d13 d14 d15 fa sp.
// stack need to be 16-byte aligned, so we should use (8 * even numbers)
#define ContextSize (8 * 28)

// This assembly function is only used in exception handling.
// It is easier to maintain the stack structure and register status by using assembly.
// Used to restore the callee saved register and frame pointer layer by layer.
// Finally, jump to the landingpad of catch pointer.
    .text
    .align 2
    .global   _RestoreContextForEH
_RestoreContextForEH:
    .cfi_startproc
    // Current sp point to the top managed method.
    mov     x1, sp
    sub     sp, sp, #ContextSize
    stp     x29, x1,  [sp, #208]
    .cfi_def_cfa sp, 224
    .cfi_offset  x30, -8
    bl      _MRT_GetTopManagedPC
    ldr     x1,  [sp, #216]
    str     x0,  [sp, #216]

    // Save all callee saved register to stack as the layout of context struct.
    stp     x19, x20, [sp]
    stp     x21, x22, [sp, #16]
    stp     x23, x24, [sp, #32]
    stp     x25, x26, [sp, #48]
    stp     x27, x28, [sp, #64]
    stp     x29, x30, [sp, #80]
    stp     d8,  d9,  [sp, #96]
    stp     d10, d11, [sp, #112]
    stp     d12, d13, [sp, #128]
    stp     d14, d15, [sp, #144]
    str     x1,       [sp, #160]

    // Current sp point to the context struct address.
    mov     x0, sp
    bl      _MRT_RestoreContext

    // Restore all callee saved register.
    ldp     x19, x20, [sp]
    ldp     x21, x22, [sp, #16]
    ldp     x23, x24, [sp, #32]
    ldp     x25, x26, [sp, #48]
    ldp     x27, x28, [sp, #64]
    ldp     x29, x30, [sp, #80]
    ldp     d8,  d9,  [sp, #96]
    ldp     d10, d11, [sp, #112]
    ldp     d12, d13, [sp, #128]
    ldp     d14, d15, [sp, #144]
    ldr     x1,       [sp, #160]
    mov     sp,  x1

    // jump to landingpad.
    br      x0
    .cfi_endproc
