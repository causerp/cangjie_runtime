// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "HeapManager.h"

#include "Heap/Heap.h"

namespace MapleRuntime {
HeapManager::HeapManager() {}

MAddress HeapManager::Allocate(size_t allocSize, AllocType allocType)
{
    return Heap::GetHeap().Allocate(allocSize, allocType);
}

void HeapManager::Init(const HeapParam& param) { Heap::GetHeap().Init(param); }

void HeapManager::Fini() { Heap::GetHeap().Fini(); }
} // namespace MapleRuntime
