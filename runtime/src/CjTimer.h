// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_CJ_TIMER_H
#define MRT_CJ_TIMER_H
#include <cstdint>

#include "Base/Globals.h"

namespace MapleRuntime {
#ifdef __cplusplus
extern "C" {
#endif
// Make the current Task sleep to a specified time, the input parameter is nanosecond.
MRT_EXPORT void MRT_Sleep(int64_t ns);
#ifdef __cplusplus
};
#endif
} // namespace MapleRuntime
#endif // MRT_CJ_TIMER_H
