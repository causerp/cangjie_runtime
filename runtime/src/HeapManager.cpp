// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "HeapManager.h"

#include "Heap/Allocator/LocalObjectAllocator.h"
#include "Heap/Allocator/RegionSpace.h"
#include "Heap/Heap.h"
#include "Mutator/Mutator.h"

namespace MapleRuntime {
RegionSpace* HeapManager::regionSpace = nullptr;
LocalObjectAllocator* HeapManager::localObjectAllocator = nullptr;

HeapManager::HeapManager() {}

MAddress HeapManager::Allocate(size_t allocSize, AllocType allocType)
{
    return Heap::GetHeap().Allocate(allocSize, allocType);
}

MAddress HeapManager::AllocateLocal(size_t allocSize)
{
    CHECK_DETAIL(regionSpace != nullptr && localObjectAllocator != nullptr,
                 "local object allocator is not initialized");
    Mutator* mutator = Mutator::GetMutator();
    if (UNLIKELY(mutator == nullptr)) {
        LOG(RTLOG_ERROR, "alloc local object failed because mutator is null");
        return 0;
    }

    size_t size = RegionSpace::ToAllocSize(allocSize);
    MAddress internalAddr = localObjectAllocator->Allocate(*mutator, size);
    if (UNLIKELY(internalAddr == 0)) {
        return regionSpace->Allocate(allocSize, AllocType::LOCAL_OBJECT);
    }
    return internalAddr + RegionSpace::HEADER_SIZE;
}

void HeapManager::Init(const HeapParam& param)
{
    Heap::GetHeap().Init(param);
    regionSpace = &reinterpret_cast<RegionSpace&>(Heap::GetHeap().GetAllocator());
    localObjectAllocator = &regionSpace->GetLocalObjectAllocator();
}

void HeapManager::Fini()
{
    localObjectAllocator = nullptr;
    regionSpace = nullptr;
    Heap::GetHeap().Fini();
}
} // namespace MapleRuntime
