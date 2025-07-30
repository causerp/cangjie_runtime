// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#ifndef MRT_SEMA_IMPL_H
#define MRT_SEMA_IMPL_H

#include <stdio.h>
#include "sema.h"
#include "waitqueue_impl.h"

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif

/**
 * @brief sema internal structure
 */
struct SemaInner {
    struct Waitqueue queue;
    std::atomic<unsigned int> semaVal;
};

#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif
#endif /* MRT_SEMA_IMPL_H */