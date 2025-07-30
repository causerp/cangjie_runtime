// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_ALLOC_BUFFER_MANAGER
#define MRT_ALLOC_BUFFER_MANAGER

#include <atomic>
#include <functional>
#include <unordered_set>

#include "AllocBuffer.h"
#include "Base/AtomicSpinLock.h"
#include "Common/PageAllocator.h"
#include "Common/RunType.h"
namespace MapleRuntime {
using AllocBufferVisitor = std::function<void(AllocBuffer& buffer)>;
class AllocBufferManager {
public:
    using AllocBuffersSet = std::unordered_set<AllocBuffer*, std::hash<AllocBuffer*>, std::equal_to<AllocBuffer*>,
                                               StdContainerAllocator<AllocBuffer*, ALLOCATOR>>;
    using HungryBuffers = AllocBuffersSet;
    AllocBufferManager() {}
    ~AllocBufferManager()
    {
        for (auto* buffer : allocBuffers) {
            if (buffer != nullptr) {
                delete buffer;
            }
        }
        allocBuffers.clear();
    };

    void RegisterAllocBuffer(AllocBuffer& buffer)
    {
        allocBufferLock.Lock();
        allocBuffers.insert(&buffer);
        allocBufferLock.Unlock();
    }

    void VisitAllocBuffers(const AllocBufferVisitor& visitor)
    {
        allocBufferLock.Lock();
        for (auto* buffer : allocBuffers) {
            visitor(*buffer);
        }
        allocBufferLock.Unlock();
    }

    void AddHungryBuffer(AllocBuffer& buffer)
    {
        std::lock_guard<std::mutex> lg(hungryBuffersLock);
        hungryBuffers.insert(&buffer);
    }
    void SwapHungryBuffers(HungryBuffers& getBufferSet)
    {
        std::lock_guard<std::mutex> lg(hungryBuffersLock);
        hungryBuffers.swap(getBufferSet);
    }

private:
    AllocBuffersSet allocBuffers;
    HungryBuffers hungryBuffers;
    std::mutex hungryBuffersLock;
    AtomicSpinLock allocBufferLock;
};
} // namespace MapleRuntime
#endif // MRT_ALLOC_BUFFER_MANAGER