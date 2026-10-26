// Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information


#include "YoungCollector.h"
#include "Allocator/MixedRegionSpace/MixedRegionSpace.h"
#include "Heap/GcThreadPool.h"
#include "Heap/HeapWork.h"
#include "GenerationConstants.h"
#include "RememberSet.h"

namespace MapleRuntime {
void YoungCollector::TraceHeap()
{
    WorkStack workStack = NewWorkStack();
    WorkStack foreignStack = NewWorkStack();
    AssembleCandidates();

    {
        MRT_PHASE_TIMER("enum roots & update old pointers within");
        TransitionToGCPhase(GCPhase::GC_PHASE_GENERATION_ENUM, true);
        DoEnumeration(workStack, foreignStack);
    }

    {
        MRT_PHASE_TIMER("trace live objects & update old pointers in ref-fields");
        markedObjectCount.store(0, std::memory_order_relaxed);
        TransitionToGCPhase(GCPhase::GC_PHASE_GENERATION_TRACE, true);
        reinterpret_cast<RegionSpace&>(theAllocator).PrepareTrace();
        DoTracing(workStack, foreignStack);

        ProcessFinalizers();
    }
}

void YoungCollector::ProcessFinalizers()
{
    std::function<bool(BaseObject*)> finalizable = [this](BaseObject* obj) {
        RegionInfo* region = RegionInfo::GetRegionInfoAt(reinterpret_cast<uintptr_t>(obj));
        return !IsMarkedObject(obj) && !region->IsOldRegion();
    };
    FinalizerProcessor& fp = collectorResources.GetFinalizerProcessor();
    fp.EnqueueFinalizables(finalizable, snapshotFinalizerNum);
    fp.Notify();
}

void YoungCollector::Preforward()
{
    ScopedEntryTrace trace("CJRT_GC_PREFORWARD");
    MRT_PHASE_TIMER("Preforward");
    {
        ScopedLightSync scopedLightSync("Preforward", true, GCPhase::GC_PHASE_GENERATION_PREFORWARD);
    }

    GCThreadPool* threadPool = GetThreadPool();
    MRT_ASSERT(threadPool != nullptr, "thread pool is null");
    // forward and fix cj future objects
    threadPool->AddWork(new (std::nothrow) LambdaWork([this](size_t) { PreforwardConcurrencyModelRoots(); }));

    // forward and fix finalizer roots.
    threadPool->AddWork(new (std::nothrow) LambdaWork([this](size_t) { PreforwardFinalizerProcessorRoots(); }));
    threadPool->AddWork(new (std::nothrow) LambdaWork([this](size_t) { PreforwardAllExportFromRoots(); }));
    threadPool->AddWork(new (std::nothrow) LambdaWork([this](size_t) { PreforwardDiscoveredExternObjects(); }));
    threadPool->AddWork(new (std::nothrow) LambdaWork([this](size_t) { PreforwardAllResurrectExportFromObjects(); }));
    threadPool->Start();
    threadPool->WaitFinish();
}
void YoungCollector::DoGarbageCollection()
{
    TraceHeap();
    PostTrace();
    ConcurrentSweep();
    Preforward();

    ForwardFromSpace();

    TransitionToGCPhase(GCPhase::GC_PHASE_GENERATION_IDLE, true);
    MergeResurrectExportObjects();
    PostResolveCycleTask();
    FlipTagID();
    ForwardDataManager::GetForwardDataManager().SetTagID(currentTagID);

    CollectSmallSpace();
    ForwardDataManager::GetForwardDataManager().UnbindPreviousLiveInfo();
}

void YoungCollector::EnumRefFieldRoot(RefField<>& field, RootSet& rootSet) const
{
    RefField<> oldField(field);
    // if field is already tagged currently, it is also already enumerated.
    if (IsCurrentPointer(oldField)) {
        rootSet.push_back(oldField.GetTargetObject());
        return;
    }

    BaseObject* latest = nullptr;
    bool isOldPtr = IsOldPointer(oldField);
    if (isOldPtr) {
        BaseObject* targetObj = oldField.GetTargetObject();
        latest = FindLatestVersion(targetObj);
    } else {
        latest = oldField.GetTargetObject();
    }

    // The target could be null or non-heap for some static variable. Check the
    // heap range only once, then use its region to determine whether Young GC
    // should trace it.
    if (!Heap::IsHeapAddress(latest)) {
        DLOG(ENUM, "skip invalid young field ref %p: %#zx -> %p", &field, oldField.GetFieldValue(), latest);
        return;
    }
    RegionInfo* latestRegion = RegionInfo::GetRegionInfoAt(reinterpret_cast<MAddress>(latest));
    bool isTargetAddress = IsTargetRegion(latestRegion);
    // If the pointer is old pointer, we must fix it in case of it's a promoted object in last gc.
    if (!isTargetAddress && !isOldPtr) {
        return;
    }

    CHECK_DETAIL(latest->IsValidObject(), "Enum static root %p(%p) encounters invalid object", latest, &field);
    RefField<> newField = GetAndTryTagRefField(latest);
    if (oldField.GetFieldValue() == newField.GetFieldValue()) {
        DLOG(ENUM, "enum young static ref@%p: %#zx -> %p<%p>(%zu)", &field, oldField.GetFieldValue(), latest,
             latest->GetTypeInfo(), latest->GetSize());
    } else if (field.CompareExchange(oldField.GetFieldValue(), newField.GetFieldValue())) {
        DLOG(ENUM, "enum young static ref@%p: %#zx=>%#zx -> %p<%p>(%zu)", &field, oldField.GetFieldValue(),
             newField.GetFieldValue(), latest, latest->GetTypeInfo(), latest->GetSize());
    } else {
        DLOG(ENUM, "enum young static ref@%p: %#zx -> %p<%p>(%zu)", &field, oldField.GetFieldValue(), latest,
             latest->GetTypeInfo(), latest->GetSize());
    }
    if (isTargetAddress) {
        rootSet.push_back(latest);
    }
}

void YoungCollector::EnumAndTagRawRoot(ObjectRef& ref, RootSet& rootSet) const
{
    RefField<>& refField = reinterpret_cast<RefField<>&>(ref);
    RefField<> oldField(refField);
    CHECK_DETAIL(!IsOldPointer(oldField), "EnumAndTagRawRoot failed: Invalid root: %zx", oldField.GetFieldValue());
    if (IsCurrentPointer(oldField)) {
        rootSet.push_back(oldField.GetTargetObject());
        DLOG(ENUM, "[YOUNG] enum raw root @%p: %#zx %p(%zu)", &ref, oldField.GetFieldValue(),
             oldField.GetTargetObject());
        return;
    }
    BaseObject* root = oldField.GetTargetObject();
    if (IsTargetAddress(root)) {
        CHECK_DETAIL(root->IsValidObject(), "Enum and tag runtime root %p(%p) encounters invalid object", root, &ref);
        RefField<> newField = GetAndTryTagRefField(root);
        if (oldField.GetFieldValue() == newField.GetFieldValue()) {
            DLOG(ENUM, "[YOUNG] enum young raw root @%p: %p(%zu)", &ref, root, root->GetSize());
        } else if (refField.CompareExchange(oldField.GetFieldValue(), newField.GetFieldValue())) {
            DLOG(ENUM, "[YOUNG] enum young static ref@%p: %#zx=>%#zx -> %p<%p>(%zu)", &refField,
                 oldField.GetFieldValue(), newField.GetFieldValue(), root, root->GetTypeInfo(), root->GetSize());
        } else {
            DLOG(ENUM, "[YOUNG] enum young static ref@%p: %#zx -> %p<%p>(%zu)", &refField, oldField.GetFieldValue(),
                 root, root->GetTypeInfo(), root->GetSize());
        }
        rootSet.push_back(root);
    } else {
        DLOG(ENUM, "[YOUNG] skip young invalid ref@%p: %#zx -> %p", &refField, oldField.GetFieldValue(), root);
    }
}

RefField<> YoungCollector::GetAndTryTagRefField(BaseObject* target) const
{
    if (IsFromObject(target)) {
        return RefField<>(target, 1, currentTagID);
    } else {
        return RefField<>(target);
    }
}

bool YoungCollector::IsYoungHeapAddress(const BaseObject* obj) const
{
    if (Heap::IsHeapAddress(obj)) {
        auto regionInfo = RegionInfo::GetRegionInfoAt(reinterpret_cast<uintptr_t>(obj));
        return !regionInfo->IsOldRegion();
    }
    return false;
}

bool YoungCollector::MarkObject(BaseObject* obj) const
{
    if (!IsTargetAddress(obj)) {
        DLOG(TRACE, "[YOUNG] trace skip non-target object %p", obj);
        return true;
    }

    RegionInfo* region = RegionInfo::GetRegionInfoAt(reinterpret_cast<MAddress>(obj));
    size_t objectSize = obj->GetSize();
    bool marked = region->MarkObject(obj, objectSize);
    if (!marked) {
        region->AddLiveByteCount(objectSize);
        uint8_t age = region->IncObjectAge(obj);
        if (!region->IsOldRegion() && ShouldPromote(age)) {
            DLOG(PROMOTE, "[YOUNG] found a long liveness object %p to be promoted", obj);
            TagPromoteRegion(region);
        }
        DLOG(TRACE, "[YOUNG] mark obj %p<%p>(%zu) in region %p(%u)@%#zx, live %u", obj, obj->GetTypeInfo(), objectSize,
             region, region->GetRegionType(), region->GetRegionStart(), region->GetLiveByteCount());
    }
    return marked;
}

void YoungCollector::CopyObject(const BaseObject& fromObj, BaseObject& toObj, size_t size) const
{
    RegionInfo* fromRegion = RegionInfo::GetRegionInfoAt(reinterpret_cast<MAddress>(&fromObj));
    uint8_t age = fromRegion->GetObjectAge(&fromObj);
    CopyCollector::CopyObject(fromObj, toObj, size);

    RegionInfo* toRegion = RegionInfo::GetRegionInfoAt(reinterpret_cast<MAddress>(&toObj));
    if (age != 0 || toRegion->GetAgeBitmap() != nullptr) {
        toRegion->SetObjectAge(&toObj, age);
    }
}

BaseObject* YoungCollector::TryForwardObject(BaseObject* fromVersion)
{
    RegionInfo* fromRegion = RegionInfo::GetGhostFromRegionAt(reinterpret_cast<uintptr_t>(fromVersion));

    if (fromRegion == nullptr) {
        DLOG(FORWARD, "object %p is not in from region", fromVersion);
        return nullptr;
    }
    if (!fromRegion->IsPromoted0()) {
        return WCollector::TryForwardObject(fromVersion, fromRegion);
    }

    MixedRegionSpace& space = static_cast<MixedRegionSpace&>(theAllocator);
    MixedRegionManager& manager = MixedRegionSpace::CastDown(space.GetRegionManager());
    return manager.PromoteObject(fromVersion, fromRegion);
}

BaseObject* YoungCollector::FindToVersion(BaseObject* obj) const
{
    RegionInfo* fromRegion = RegionInfo::GetGhostFromRegionAt(reinterpret_cast<uintptr_t>(obj));
    if (fromRegion == nullptr) {
        return nullptr;
    }
    if (!fromRegion->IsPromoted0()) {
        return WCollector::FindToVersion(obj, fromRegion);
    }
    // This may be optimized, since we can ensure that the region is promoted in most situations.
    MixedRegionSpace& space = static_cast<MixedRegionSpace&>(theAllocator);
    MixedRegionManager& manager = MixedRegionSpace::CastDown(space.GetRegionManager());
    manager.RoutePromoteRegion(fromRegion);

    ObjectForwardingTable* fwdTable = fromRegion->GetForwardingTable();
    if (fwdTable == nullptr) {
        return nullptr;
    }
    return fwdTable->GetRoute(obj);
}

bool YoungCollector::ShouldPromote(uint8_t age) const
{
    return age >= OLD_AGE;
}

void YoungCollector::EnumRememberedRoots(RootSet& rootSet) const
{
    RememberSet::Instance().VisitRememberedSlots([this, &rootSet](uintptr_t slotAddr) {
        RefField<>* field = reinterpret_cast<RefField<>*>(slotAddr);
        DLOG(ENUM, "[generation] scan remember set root %p(%p)", field, field->GetTargetObject());
        EnumRefFieldRoot(*field, rootSet);
    });
}

void YoungCollector::EnumAllCommonRoots(GCThreadPool* threadPool, RootSet& rootSet)
{
    TracingCollector::EnumAllCommonRoots(threadPool, rootSet);
    EnumRememberedRoots(rootSet);
}

void YoungCollector::ForwardFromSpace()
{
    ScopedEntryTrace trace("CJRT_GC_FORWARD");
    MRT_PHASE_TIMER("ForwardFromRegions");
    TransitionToGCPhase(GCPhase::GC_PHASE_GENERATION_FORWARD, true);
    MixedRegionSpace& space = static_cast<MixedRegionSpace&>(theAllocator);
    space.ForwardFromSpace(GetThreadPool());
}

void YoungCollector::TagPromoteRegion(RegionInfo* regionInfo) const
{
    regionInfo->SetPromotedFlag(1);
}

void YoungCollector::UpdateGCStats()
{
    GenerationalGCStats& stats = static_cast<GenerationalGCStats&>(GetGCStats());
    stats.Dump();
    MixedRegionSpace& space = static_cast<MixedRegionSpace&>(theAllocator);
    MixedRegionManager& manager = MixedRegionSpace::CastDown(space.GetRegionManager());
    const size_t maxCapacity = theAllocator.GetMaxCapacity();
    const size_t youngCapacity = std::min(maxCapacity / YOUNG_GEN_CAPACITY_DIVISOR, YOUNG_GEN_MAX_SIZE);
    const size_t maxThreshold = youngCapacity * MAX_YOUNG_THRESHOLD_NUM / MAX_YOUNG_THRESHOLD_DEN;
    const size_t used = manager.GetYoungUsedSize();
    const size_t predicted = static_cast<size_t>(stats.RefreshAllocationSpeed(TimeUtil::NanoSeconds()) *
        PREDICT_WINDOW_MS * TimeUtil::MilliSeconds());
    const size_t headroom = maxThreshold > used ? maxThreshold - used : 0;
    const size_t oldThreshold = stats.GetYoungThreshold();
    stats.SetYoungThreshold(used + std::min(predicted, headroom));
    VLOG(REPORT, "young used size %zu, update young threshold %zu -> %zu", used, oldThreshold,
         stats.GetYoungThreshold());
}

void YoungCollector::RefineFromSpace()
{
    MRT_PHASE_TIMER("Refine from space");
    GCStats& stats = GetGCStats();
    MixedRegionSpace& space = static_cast<MixedRegionSpace&>(theAllocator);
    stats.smallGarbageSize = space.ClassifyCandidateRegions();
}

void YoungCollector::ResetForwardingData()
{
    MRT_PHASE_TIMER("Reset forwarding data");
    fwdTable.PrepareForwardTable(false);
}

void YoungCollector::PostTrace()
{
    MRT_PHASE_TIMER("PostTrace");
    TransitionToGCPhase(GC_PHASE_GENERATION_POST_TRACE, true);
    RegionSpace& space = reinterpret_cast<RegionSpace&>(theAllocator);
    space.GetRegionManager().HandleTraceRegions();
    // clear weakRef List, set the referent as null
    WeakRefBuffer::Instance().ClearWeakRefBuffer();
    // clear satb buffer when gc finish tracing.
    SatbBuffer::Instance().ClearBuffer();
    // reclaim large objects immediately after tracing is done.
    PrepareCycleRef();

    RefineFromSpace();
    CollectPinnedGarbage();
    ClearDeadObjectRSetSlots();
    ResetForwardingData();
    // We want to move old age large object to old space, so it should be invoked after preparing from space.
    CollectLargeGarbage();
}

class SweepTask : public HeapWork {
public:
    SweepTask(RegionList* sweepable, RegionList& swept, RegionManager& mgr)
        : sweepableYoungRegionList(sweepable), sweptYoungRegionList(swept), regionManager(mgr) {}

    ~SweepTask() override = default;

    void Execute(size_t) override
    {
        RegionInfo* region = sweepableYoungRegionList->TakeHeadRegionNoLock();
        while (region != nullptr) {
            RegionInfo* next = sweepableYoungRegionList->TakeHeadRegionNoLock();
            if (region->GetLiveByteCount() == 0) {
                regionManager.CollectRegion(region);
                region = next;
                continue;
            }
            region->SweepRegion();
            region->ClearLiveInfo();
            sweptYoungRegionList.PrependRegion(region, RegionInfo::RegionType::SWEEP_REGION);
            region = next;
        }
        delete sweepableYoungRegionList;
    }

private:
    RegionList* sweepableYoungRegionList;
    RegionList& sweptYoungRegionList;
    RegionManager& regionManager;
};

void YoungCollector::ConcurrentSweep()
{
    GCThreadPool* threadPool = GetThreadPool();
    if (threadPool == nullptr) {
        return;
    }
    MixedRegionSpace& space = static_cast<MixedRegionSpace&>(theAllocator);
    MixedRegionManager& manager = MixedRegionSpace::CastDown(space.GetRegionManager());
    threadPool->Start();
    constexpr size_t regionsPerTask = 10;
    while (true) {
        RegionList* local = new (std::nothrow) RegionList("young sweep task regions");
        CHECK_DETAIL(local != nullptr, "failed to allocate young sweep task list");
        if (!manager.GetSweepableRegionList().SplitByRegionCount(*local, regionsPerTask)) {
            delete local;
            break;
        }
        HeapWork* task = new (std::nothrow) SweepTask(local, manager.GetSweptRegionList(), manager);
        CHECK_DETAIL(task != nullptr, "failed to allocate young sweep task");
        threadPool->AddWork(task);
    }
}

bool YoungCollector::TryUpdateRefField(BaseObject* obj, RefField<>& field, BaseObject*& newRef) const
{
    RefField<> oldRef(field);
    BaseObject* fromObj = oldRef.GetTargetObject();
    if (!Heap::IsHeapAddress(fromObj)) {
        return WCollector::TryUpdateRefField(obj, field, newRef);
    }
    RegionInfo* region = RegionInfo::GetGhostFromRegionAt(reinterpret_cast<uintptr_t>(fromObj));

    if (region == nullptr || (region->IsGhostFromRegion() && !region->IsPromoted0())) {
        return WCollector::TryUpdateRefField(obj, field, newRef);
    }
    ObjectForwardingTable* fwdTable = region->GetForwardingTable();
    if (fwdTable != nullptr) {
        BaseObject* newObj = fwdTable->GetRoute(fromObj);
        if (newObj != nullptr) {
            RefField<> newField(newObj);
            if (field.CompareExchange(oldRef.GetFieldValue(), newField.GetFieldValue())) {
                newRef = newObj;
                return true;
            }
        }
    }

    return false;
}

bool YoungCollector::TryForwardRefField(BaseObject* obj, RefField<>& field, BaseObject*& newRef) const
{
    RefField<> oldRef(field);
    BaseObject* fromObj = oldRef.GetTargetObject();
    if (!Heap::IsHeapAddress(fromObj)) {
        return WCollector::TryForwardRefField(obj, field, newRef);
    }
    RegionInfo* region = RegionInfo::GetGhostFromRegionAt(reinterpret_cast<uintptr_t>(fromObj));
    if (region == nullptr || (region->IsGhostFromRegion() && !region->IsPromoted0())) {
        return WCollector::TryForwardRefField(obj, field, newRef);
    }
    MixedRegionSpace& space = static_cast<MixedRegionSpace&>(theAllocator);
    MixedRegionManager& manager = MixedRegionSpace::CastDown(space.GetRegionManager());
    BaseObject* newObj = manager.PromoteObject(fromObj, region);
    if (newObj != nullptr) {
        RefField<> newField(newObj);
        if (field.CompareExchange(oldRef.GetFieldValue(), newField.GetFieldValue())) {
            newRef = newObj;
            return true;
        }
    }

    return false;
}
} // namespace MapleRuntime
