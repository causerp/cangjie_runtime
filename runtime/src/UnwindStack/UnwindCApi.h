// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_UNWIND_API_H
#define MRT_UNWIND_API_H

#include "Common/StackType.h"

namespace MapleRuntime {
struct ThreadLocalData;
extern "C" MRT_EXPORT void MRT_RestoreTopManagedContextFromN2CStub(FrameAddress* fa);
extern "C" MRT_EXPORT void MRT_SaveTopManagedContextToN2CStub(FrameAddress* fa);
extern "C" MRT_EXPORT void MRT_SaveC2NContext(const uint32_t* pc, void* fa, ThreadLocalData* tlData);
extern "C" MRT_EXPORT void MRT_DeleteC2NContext(ThreadLocalData* tlData);
extern "C" MRT_EXPORT void MRT_UpdateUwContext(const uint32_t* pc, void* fa, UnwindContextStatus status,
                                               ThreadLocalData* tlData);
extern "C" MRT_EXPORT bool MRT_C2N_Enter(const uint32_t* pc, void* fa, ThreadLocalData* tlData);
extern "C" MRT_EXPORT ThreadLocalData* MRT_C2N_Leave(bool safeState, unsigned long long stackTop);
#ifdef __OHOS__
extern "C" MRT_EXPORT unsigned long long MRT_UpdateStackTop(unsigned long long stackTop);
#endif
} // namespace MapleRuntime
#endif // MRT_UNWIND_API_H
