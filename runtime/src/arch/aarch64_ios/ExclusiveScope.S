// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// ==============================================================================
// ExclusiveScope stub implementation for iOS aarch64
// ==============================================================================
//
// ExclusiveScope is not supported on iOS platform.
// This file provides stub symbols to allow compilation and linking.
// If these functions are called at runtime, they will return NULL immediately.

    .text
    .align 2
    
// Stub implementation for CJ_MCC_ExclusiveScope
    .global _CJ_MCC_ExclusiveScope
_CJ_MCC_ExclusiveScope:
    mov     x0, #0
    ret

// Stub symbol for unwindPCForExclusiveStub
    .global _unwindPCForExclusiveStub
_unwindPCForExclusiveStub:
    mov     x0, #0
    ret

// Stub implementation for ExecuteExclusiveCangjieStub
    .global _ExecuteExclusiveCangjieStub
_ExecuteExclusiveCangjieStub:
    mov     x0, #0
    ret

// Stub symbol for unwindPCForExclusiveStubFull
    .global _unwindPCForExclusiveStubFull
_unwindPCForExclusiveStubFull:
    mov     x0, #0
    ret
