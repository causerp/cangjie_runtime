// Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#ifndef MRT_MIXED_REGION_SPACE_H
#define MRT_MIXED_REGION_SPACE_H

#include "Allocator/RegionSpace.h"
#include "Common/ScopedObjectAccess.h"
#include "Collector/CollectorResources.h"
#include "GenerationalGC/GenerationAllocBuffer.h"
#include "GenerationalGC/GenerationConstants.h"
#include "Heap.h"
#include "Heap/GcThreadPool.h"
#include "MixedRegionManager.h"
#include "Mutator/MutatorManager.h"

#include <algorithm>

namespace MapleRuntime {

class MixedRegionSpace : public RegionSpace {
public:
    MixedRegionSpace() : RegionSpace(CreateMixedRegionManager()) {}
    ~MixedRegionSpace() override = default;
    static RegionManager* CreateMixedRegionManager()
    {
        RegionManager* regionManager = new (std::nothrow) MixedRegionManager();
        CHECK_DETAIL(regionManager != nullptr, "CANGJIE RUNTIME create region manager failed");
        return regionManager;
    }
    static MixedRegionManager& CastDown(RegionManager& manager)
    {
        return static_cast<MixedRegionManager&>(manager);
    }
    static MixedRegionSpace& CastDown(RegionSpace& regionSpace)
    {
        return static_cast<MixedRegionSpace&>(regionSpace);
    }
    static MixedRegionSpace& CastDown(Allocator& regionSpace)
    {
        return static_cast<MixedRegionSpace&>(regionSpace);
    }

    void AssembleYoungCandidates()
    {
        CastDown(GetRegionManager()).AssembleYoungRegions();
        GetRegionManager().AssemblePinnedGarbageCandidates(false);
        GetRegionManager().AssembleLargeGarbageCandidates();
    }
    void AssembleMixedCandidates()
    {
        CastDown(GetRegionManager()).AssembleMixedRegions();
        GetRegionManager().AssemblePinnedGarbageCandidates(false);
        GetRegionManager().AssembleLargeGarbageCandidates();
    }
    size_t ClassifyCandidateRegions()
    {
        return CastDown(GetRegionManager()).ClassifyYoungRegions();
    }
    void ForwardFromSpace(GCThreadPool* threadPool) override
    {
        CastDown(GetRegionManager()).ForwardFromSpace(threadPool);
    }

    void FeedHungryBuffers() override {}

    size_t CollectLargeGarbage() override
    {
        MRT_PHASE_TIMER("Collect large garbage");
        return CastDown(GetRegionManager()).CollectLargeGarbage();
    }

    MAddress TryAllocateOnce(size_t allocSize, AllocType allocType) override
    {
        constexpr size_t assistBaseInterval = 16 * KB;
        thread_local size_t allocationBalance = 0;
        Heap& heap = Heap::GetHeap();
        if (!IsGcThread() && heap.IsGcStarted()) {
            allocationBalance += allocSize;
            RegionManager& manager = GetRegionManager();
            const size_t gcStartAllocated = heap.GetCollector().GetGCStats().liveBytesBeforeGC;
            const size_t assistBytes = manager.GetMutatorAssistRegionBytes();
            const size_t assistBudget = std::min(
                std::max(gcStartAllocated / ASSIST_BUDGET_ALLOC_DIVISOR, ASSIST_BUDGET_MIN), ASSIST_BUDGET_MAX);
            bool shouldAssist = false;
            if (gcStartAllocated != 0) {
                if (assistBytes >= assistBudget) {
                    shouldAssist = true;
                } else {
                    const size_t effectiveAssistBytes = std::min(assistBytes, assistBudget);
                    const size_t dynamicInterval = std::max<size_t>(
                        assistBaseInterval / ASSIST_MIN_INTERVAL_DIVISOR,
                        assistBaseInterval - (assistBaseInterval * effectiveAssistBytes / assistBudget));
                    shouldAssist = allocationBalance >= dynamicInterval;
                }
            }
            if (shouldAssist) {
                allocationBalance = 0;
                GCThreadPool* threadPool = heap.GetCollectorResources().GetThreadPool();
                if (threadPool != nullptr) {
                    (void)threadPool->TryExecuteOneTask(static_cast<size_t>(GetTid()));
                }
            }
        } else {
            allocationBalance = 0;
        }
        if (allocType == AllocType::MOVEABLE_OBJECT && allocSize < GetRegionManager().GetLargeObjectThreshold()) {
            AllocBuffer* allocBuffer = AllocBuffer::GetOrCreateAllocBuffer();
            return static_cast<GenerationAllocBuffer*>(allocBuffer)->AllocateYoung(allocSize);
        }
        return RegionSpace::TryAllocateOnce(allocSize, allocType);
    }
};

} // namespace MapleRuntime

#endif // MRT_MIXED_REGION_SPACE_H
