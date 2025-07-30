// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_CJ_SCHEDULER_H
#define MRT_CJ_SCHEDULER_H

#include "Base/Globals.h"
#include "sema.h"
#include "waitqueue.h"

namespace MapleRuntime {
#ifdef __cplusplus
extern "C" {
#endif
struct UnitType {
    uint8_t* placeholder;
    // Declare 32-byte align to ensure c++ generate same function definition as cangjie IR in both x86 and arm64.
} __attribute__((aligned(32)));

void* MCC_NewCJThread(void* execute, void* future, void* scheduler);
void* MCC_NewCJThreadNoReturn(void* executeClosure, void* closurePtr, void* scheduler, void* futureTi);
void MRT_CjRuntimeInit();
void MRT_SetCommandLineArgs(int argc, const char* argv[]);
const char** MRT_GetCommandLineArgs();
void MRT_CjRuntimeStart(void* execute);
int MRT_NewWaitQueue(void* waitQueuePtr);
bool MRT_SuspendWithTimeout(void* wq, const WqCallbackFunc callBack, void* callBackObj, int64_t timeOut);
void MRT_ResumeOne(void* wq, const WqCallbackFunc callBack, void* callBackObj);
void MRT_ResumeAll(void* wq, const WqCallbackFunc callBack, void* callBackObj);

int MRT_NewSem(void* semPtr);
void MRT_SemAcquire(void* sem, bool isPushToHead);
void MRT_SemRelease(void* sem);
int64_t MRT_GetCurrentThreadID();

#ifdef __cplusplus
};
#endif
} // namespace MapleRuntime

#endif // MRT_CJ_SCHEDULER_H
