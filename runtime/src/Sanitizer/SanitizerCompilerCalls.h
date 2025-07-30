// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef CANGJIERUNTIME_SANITIZERCOMPILERCALLS_H
#define CANGJIERUNTIME_SANITIZERCOMPILERCALLS_H

#include <cstdint>

#include "Base/Macros.h"

extern "C" {
#ifdef GENERAL_ASAN_SUPPORT_INTERFACE
MRT_EXPORT void CJ_MCC_AsanRead(volatile const void* addr, uintptr_t size);
MRT_EXPORT void CJ_MCC_AsanWrite(volatile const void* addr, uintptr_t size);
MRT_EXPORT void CJ_MCC_AsanHandleNoReturn(const void* rsp);
#endif

#ifdef CANGJIE_TSAN_SUPPORT
MRT_EXPORT void CJ_MCC_TsanWriteMemory(const void* addr, size_t size);
MRT_EXPORT void CJ_MCC_TsanReadMemory(const void* addr, size_t size);
MRT_EXPORT void CJ_MCC_TsanWriteMemoryRange(const void* addr, size_t size);
MRT_EXPORT void CJ_MCC_TsanReadMemoryRange(const void* addr, size_t size);
MRT_EXPORT void* CJ_MCC_TsanGetRaceProc(void);
MRT_EXPORT void* CJ_MCC_TsanGetThreadState(void);
#endif
}

#endif // CANGJIERUNTIME_SANITIZERCOMPILERCALLS_H
