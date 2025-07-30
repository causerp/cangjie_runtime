// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef RUNTIME_CONTEXT_OFFSET_H
#define RUNTIME_CONTEXT_OFFSET_H

#include "offset_macro.h"

#define CONTEXT_RSP 0x0
#define CONTEXT_RBP 0x8
#define CONTEXT_RBX 0x10
#define CONTEXT_RIP 0x18
#define CONTEXT_R12 0x20
#define CONTEXT_R13 0x28
#define CONTEXT_R14 0x30
#define CONTEXT_R15 0x38
#define CONTEXT_MXCSR 0x40
#define CONTEXT_FPU_CW 0x44

#ifdef MRT_WINDOWS
#define CONTEXT_RDI 0x48
#define CONTEXT_RSI 0x50
#define CONTEXT_XMM6 0x58
#define CONTEXT_XMM7 0x68
#define CONTEXT_XMM8 0x78
#define CONTEXT_XMM9 0x88
#define CONTEXT_XMM10 0x98
#define CONTEXT_XMM11 0xA8
#define CONTEXT_XMM12 0xB8
#define CONTEXT_XMM13 0xC8
#define CONTEXT_XMM14 0xD8
#define CONTEXT_XMM15 0xE8
#define CONTEXT_GS_STACK_LOW 0xF8
#define CONTEXT_GS_STACK_HIGH 0x100
#define CONTEXT_GS_STACK_DEALOCATION 0x108
#endif

#endif // RUNTIME_CONTEXT_OFFSET_H
