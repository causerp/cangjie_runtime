// Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information


#ifndef MRT_YOUNGCOLLECTOR_H
#define MRT_YOUNGCOLLECTOR_H

#include "WCollector/WCollector.h"
#include "Allocator/MixedRegionSpace/MixedRegionSpace.h"
#include "Heap/GcThreadPool.h"
#include "Heap/HeapWork.h"
#include "RememberSet.h"

namespace MapleRuntime {

class YoungCollector : public WCollector {
public:
    explicit YoungCollector(Allocator& allocator, CollectorResources& resources)
        : WCollector(allocator, resources)
    {
        collectorType = CollectorType::YOUNG_COLLECTOR;
    }

    ~YoungCollector() override = default;

    void DoGarbageCollection() override;
    void TraceHeap() override;
    void ForwardFromSpace() override;
    void EnumAllCommonRoots(GCThreadPool* threadPool, RootSet& rootSet) override;
    void EnumRefFieldRoot(RefField<>& ref, RootSet& rootSet) const override;
    void EnumAndTagRawRoot(ObjectRef& ref, RootSet& rootSet) const override;
    RefField<> GetAndTryTagRefField(BaseObject* target) const override;
    void CopyObject(const BaseObject& fromObj, BaseObject& toObj, size_t size) const override;
    BaseObject* TryForwardObject(BaseObject* fromVersion) override;
    BaseObject* FindToVersion(BaseObject* obj) const override;
    bool MarkObject(BaseObject* obj) const override;
    bool IsTargetAddress(const BaseObject* obj) const override { return IsYoungHeapAddress(obj); }
    bool TryUpdateRefField(BaseObject* obj, RefField<>& field, BaseObject*& newRef) const override;
    bool TryForwardRefField(BaseObject* obj, RefField<>& field, BaseObject*& newRef) const override;

protected:
    GCPhase GetPostGarbageCollectionPhase() const override
    {
        return GCPhase::GC_PHASE_GENERATION_RECLAIM_SATB_NODE;
    }
    virtual void ResetForwardingData();
    virtual void ClearDeadObjectRSetSlots() {}
    void PostTrace() override;
    void ProcessFinalizers() override;
    void RefineFromSpace() override;
    virtual void ConcurrentSweep();
    virtual bool IsTargetRegion(const RegionInfo* region) const { return !region->IsOldRegion(); }
    void Preforward() override;
    virtual void AssembleCandidates()
    {
        reinterpret_cast<MixedRegionSpace&>(theAllocator).AssembleYoungCandidates();
    }
    bool ShouldPromote(uint8_t age) const;
    void TagPromoteRegion(RegionInfo* regionInfo) const;
    void UpdateGCStats() override;
    size_t GetPacingThreshold() override
    {
        return static_cast<GenerationalGCStats&>(GetGCStats()).GetYoungThreshold();
    }

private:
    static constexpr uint8_t OLD_AGE = 3;
    bool IsYoungHeapAddress(const BaseObject* obj) const;
    virtual void EnumRememberedRoots(RootSet& rootSet) const;
};

} // namespace MapleRuntime

#endif // MRT_YOUNGCOLLECTOR_H
