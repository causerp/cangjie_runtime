// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef RUNTIME_OFFSET_MACRO_H
#define RUNTIME_OFFSET_MACRO_H

/* Offset of the context field in the cjthread structure */
#define CJTHREAD_CONTEXT_OFFSET 0x18

/* Offset of the thread field in the cjthread structure */
#define CJTHREAD_THREAD_OFFSET 0x10

/* Offset of the CJTHREAD field in the thread structure */
#define THREAD_CJTHREAD_OFFSET 0x10

/* Offset of the CJTHREAD0 field in the thread structure */
#define THREAD_CJTHREAD0_OFFSET 0x18

/* ARM32 offset of the context field in the cjthread structure */
#define ARM32_CJTHREAD_CONTEXT_OFFSET 0x10

/* ARM32 offset of the thread field in the cjthread structure */
#define ARM32_CJTHREAD_THREAD_OFFSET 0x8

/* ARM32 offset of the CJTHREAD field in the thread structure */
#define ARM32_THREAD_CJTHREAD_OFFSET 0x8

/* ARM32 offset of the CJTHREAD0 field in the thread structure */
#define ARM32_THREAD_CJTHREAD0_OFFSET 0xc

#endif // RUNTIME_OFFSET_MACRO_H
