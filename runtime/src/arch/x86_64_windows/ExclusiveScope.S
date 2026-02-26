// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

// ==============================================================================
// ExclusiveScope stub implementation for Windows x86_64
// ==============================================================================
//
// ExclusiveScope is not supported on Windows platform.
// This file provides stub symbols to allow compilation and linking.
// If these functions are called at runtime, they will return NULL immediately.

    .text
    
// Stub implementation for CJ_MCC_ExclusiveScope
    .global CJ_MCC_ExclusiveScope
    .def CJ_MCC_ExclusiveScope; .scl 2; .type 32; .endef
CJ_MCC_ExclusiveScope:
    xor     %rax, %rax
    ret

// Stub symbol for unwindPCForExclusiveStub
    .global unwindPCForExclusiveStub
    .def unwindPCForExclusiveStub; .scl 2; .type 32; .endef
unwindPCForExclusiveStub:
    xor     %rax, %rax
    ret

// Stub implementation for ExecuteExclusiveCangjieStub
    .global ExecuteExclusiveCangjieStub
    .def ExecuteExclusiveCangjieStub; .scl 2; .type 32; .endef
ExecuteExclusiveCangjieStub:
    xor     %rax, %rax
    ret

// Stub symbol for unwindPCForExclusiveStubFull
    .global unwindPCForExclusiveStubFull
    .def unwindPCForExclusiveStubFull; .scl 2; .type 32; .endef
unwindPCForExclusiveStubFull:
    xor     %rax, %rax
    ret
