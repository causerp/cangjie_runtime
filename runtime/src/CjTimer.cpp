// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "CjTimer.h"

#include "Base/Panic.h"
#include "CjScheduler.h"
#include "timer.h"
#include "schedule.h"

namespace MapleRuntime {
#ifdef __cplusplus
extern "C" {
#endif
void MRT_Sleep(int64_t ns)
{
    if (ns <= 0) {
        CJThreadTryResched();
        return;
    }
    TimerSleep(ns);
}
#ifdef __cplusplus
};
#endif
} // namespace MapleRuntime
