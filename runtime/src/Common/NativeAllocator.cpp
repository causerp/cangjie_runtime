// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "NativeAllocator.h"
#include "Mutator/ThreadLocal.h"

namespace MapleRuntime {
void* NativeAllocator::NativeAlloc(size_t bytes)
{
    if (bytes > MAX_BYTES) {
        return PagePool::Instance().GetPage(bytes);
    }
    MapleRuntime::ThreadLocalData* tlData = MapleRuntime::ThreadLocal::GetThreadLocalData();
    if (tlData->threadCache == nullptr) {
        tlData->threadCache = new (std::nothrow) ThreadCache();
        CHECK_DETAIL(tlData->threadCache != nullptr, "new alloc threadCache failed");
    }
    return reinterpret_cast<ThreadCache*>(tlData->threadCache)->Allocate(bytes);
}

void NativeAllocator::NativeFree(void* ptr, size_t bytes)
{
    if (bytes > MAX_BYTES) {
        PagePool::Instance().ReturnPage(reinterpret_cast<uint8_t*>(ptr), bytes);
        return;
    }
    MapleRuntime::ThreadLocalData* tlData = MapleRuntime::ThreadLocal::GetThreadLocalData();
    if (tlData->threadCache == nullptr) {
        tlData->threadCache = new (std::nothrow) ThreadCache();
        CHECK_DETAIL(tlData->threadCache != nullptr, "new alloc threadCache failed");
    }
    reinterpret_cast<ThreadCache*>(tlData->threadCache)->Deallocate(ptr, bytes);
}
}