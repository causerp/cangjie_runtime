// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// ==============================================================================
// ExclusiveScope stub implementation for macOS x86_64
// ==============================================================================
//
// ExclusiveScope is not supported on macOS platform.
// This file provides stub symbols to allow compilation and linking.
// If these functions are called at runtime, they will return NULL immediately.

    .text
    .align 2
    
// Stub implementation for CJ_MCC_ExclusiveScope
    .global _CJ_MCC_ExclusiveScope
_CJ_MCC_ExclusiveScope:
    xor     %rax, %rax
    ret

// Stub symbol for unwindPCForExclusiveStub
    .global _unwindPCForExclusiveStub
_unwindPCForExclusiveStub:
    xor     %rax, %rax
    ret

// Stub implementation for ExecuteExclusiveCangjieStub
    .global _ExecuteExclusiveCangjieStub
_ExecuteExclusiveCangjieStub:
    xor     %rax, %rax
    ret

// Stub symbol for unwindPCForExclusiveStubFull
    .global _unwindPCForExclusiveStubFull
_unwindPCForExclusiveStubFull:
    xor     %rax, %rax
    ret
