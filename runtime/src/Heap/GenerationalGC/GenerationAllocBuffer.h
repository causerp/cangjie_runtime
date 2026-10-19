// Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#ifndef MRT_GENERATION_ALLOC_BUFFER_H
#define MRT_GENERATION_ALLOC_BUFFER_H

#include "Allocator/AllocBuffer.h"
#include "Allocator/MixedRegionSpace/MixedRegionManager.h"

namespace MapleRuntime {

class GenerationAllocBuffer : public AllocBuffer {
public:
    GenerationAllocBuffer() = default;
    ~GenerationAllocBuffer();

    static GenerationAllocBuffer* GetGenerationAllocBuffer();
    MAddress AllocateYoungOnNewRegion(MixedRegionManager &manager, size_t totalSize);
    MAddress AllocateYoungOnSlot(MixedRegionManager& manager, size_t totalSize);
    MAddress AllocateYoung(size_t totalSize);
    MAddress AllocateOld(size_t totalSize);
    MAddress AllocateOldOnSlot(MixedRegionManager& manager, size_t totalSize);
    MAddress AllocateOldOnNewRegion(MixedRegionManager& manager, size_t totalSize);
    size_t CacheGarbageRegion(MixedRegionManager& manager, RegionInfo* region);

    RegionInfo* TakeOldAllocRegion()
    {
        RegionInfo* r = oldAllocRegion;
        oldAllocRegion = RegionInfo::NullRegion();
        return r;
    }

    void MoveOldSlotRegionCacheTo(RegionList& target)
    {
        target.MergeRegionList(oldSlotRegionCache, RegionInfo::RegionType::SWEEP_REGION);
    }
private:
    static constexpr size_t SLOT_REGION_CACHE_LIMIT = 3;
    static constexpr size_t GC_GARBAGE_CACHE_LIMIT = 2 * MB;
    static constexpr size_t MUTATOR_GARBAGE_CACHE_LIMIT = 2 * MB;
    void FlushSlotRegionCaches(MixedRegionManager& manager);
    void FlushGarbageRegionCache(MixedRegionManager& manager);
    RegionInfo* TakeGarbageRegion(MixedRegionManager& manager, size_t totalSize);
    RegionInfo* oldAllocRegion = RegionInfo::NullRegion();
    RegionList youngSlotRegionCache{"young slot region cache"};
    RegionList oldSlotRegionCache{"old slot region cache"};
    RegionList garbageRegionCache{"garbage region cache"};
};

} // namespace MapleRuntime

#endif // MRT_GENERATION_ALLOC_BUFFER_H
