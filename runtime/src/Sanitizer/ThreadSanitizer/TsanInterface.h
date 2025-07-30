// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef CANGJIERUNTIME_TSANINTERFACE_H
#define CANGJIERUNTIME_TSANINTERFACE_H

#include <cstddef>

#include "TsanAtomicWrapper.h"

#define SANITIZER_NAME "ThreadSanitizer"
#define SANITIZER_SHORTEN_NAME "tsan"

namespace MapleRuntime {
namespace Sanitizer {
enum class ReleaseType {
    K_RELEASE,
    K_RELEASE_ACQUIRE,
    K_RELEASE_MERGE,
};

void TsanInitialize();
void TsanFinalize();
void TsanFuncEntry(const void* pc);
void TsanFuncExit();
void TsanFuncRestoreContext(const void* pc);

// Used for cangjie runtime to avoid false positive race detection on runtime objects.
void TsanAcquire();
void TsanRelease(ReleaseType rm);

void TsanAcquire(const void* addr);
void TsanRelease(const void* addr, ReleaseType rm);

void TsanFixShadow(const void* from, const void* to, size_t size);
void TsanAllocObject(const void* addr, size_t size);
void TsanFree(void* addr, size_t size);

void TsanWriteMemory(const void* addr, size_t size);
void TsanReadMemory(const void* addr, size_t size);
void TsanWriteMemoryRange(const void* addr, size_t size);
void TsanReadMemoryRange(const void* addr, size_t size);
void TsanCleanShadow(const void* addr, size_t size);

void TsanNewRaceProc(void* processor);
void TsanNewRaceState(void* cjthread, void* parent, const void* pc);
void TsanDeleteRaceState(void* thread);

template<typename T>
inline T TsanAtomicLoad(const T* addr, int order)
{
    return TsanAtomicWrapper<T, sizeof(T)>::Load(addr, order);
}

template<typename T>
inline void TsanAtomicStore(T* addr, T val, int order)
{
    return TsanAtomicWrapper<T, sizeof(T)>::Store(addr, val, order);
}

template<typename T>
inline T TsanAtomicFetchAdd(T* addr, T val, int order)
{
    return TsanAtomicWrapper<T, sizeof(T)>::FetchAdd(addr, val, order);
}

template<typename T>
inline T TsanAtomicFetchSub(T* addr, T val, int order)
{
    return TsanAtomicWrapper<T, sizeof(T)>::FetchSub(addr, val, order);
}

template<typename T>
inline T TsanAtomicFetchAnd(T* addr, T val, int order)
{
    return TsanAtomicWrapper<T, sizeof(T)>::FetchAnd(addr, val, order);
}

template<typename T>
inline T TsanAtomicFetchOr(T* addr, T val, int order)
{
    return TsanAtomicWrapper<T, sizeof(T)>::FetchOr(addr, val, order);
}

template<typename T>
inline T TsanAtomicFetchXor(T* addr, T val, int order)
{
    return TsanAtomicWrapper<T, sizeof(T)>::FetchXor(addr, val, order);
}

template<typename T>
inline T TsanAtomicFetchNand(T* addr, T val, int order)
{
    return TsanAtomicWrapper<T, sizeof(T)>::FetchNand(addr, val, order);
}

template<typename T>
inline T TsanAtomicExchange(T* addr, T val, int order)
{
    return TsanAtomicWrapper<T, sizeof(T)>::Exchange(addr, val, order);
}

template<typename T>
inline T TsanAtomicCompareExchange(T* addr, T expectVal, T newVal, int order, int forder)
{
    return TsanAtomicWrapper<T, sizeof(T)>::CompareExchange(addr, expectVal, newVal, order, forder);
}
} // namespace Sanitizer
} // namespace MapleRuntime
#endif // CANGJIERUNTIME_TSANINTERFACE_H
