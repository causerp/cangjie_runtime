// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// ==============================================================================
// ExclusiveScope stub implementation for Linux ARM 32-bit
// ==============================================================================
//
// TODO: ExclusiveScope is not yet supported on ARM 32-bit platform.

    .text
    .align 2
    
// Stub implementation for CJ_MCC_ExclusiveScope
    .global CJ_MCC_ExclusiveScope
    .type CJ_MCC_ExclusiveScope, %function
CJ_MCC_ExclusiveScope:
    mov     r0, #0
    bx      lr

// Stub symbol for unwindPCForExclusiveStub
    .global unwindPCForExclusiveStub
    .type unwindPCForExclusiveStub, %function
unwindPCForExclusiveStub:
    mov     r0, #0
    bx      lr

// Stub implementation for ExecuteExclusiveCangjieStub
    .global ExecuteExclusiveCangjieStub
    .type ExecuteExclusiveCangjieStub, %function
ExecuteExclusiveCangjieStub:
    mov     r0, #0
    bx      lr

// Stub symbol for unwindPCForExclusiveStubFull
    .global unwindPCForExclusiveStubFull
    .type unwindPCForExclusiveStubFull, %function
unwindPCForExclusiveStubFull:
    mov     r0, #0
    bx      lr
