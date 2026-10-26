// Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#include "MixedRegionManager.h"
#include "GenerationalGC/GenerationAllocBuffer.h"
#include "Collector/CopyCollector.h"
#include "Collector/TracingCollector.h"
#include "GenerationalGC/RememberSet.h"
#include "Heap/Heap.h"
#include "HeapWork.h"
#include "GcThreadPool.h"
#include "ObjectModel/RefField.inline.h"
#include <set>
#include <utility>
#include <unistd.h>

namespace MapleRuntime {

namespace {
class CollectMixedLargeGarbageTask : public HeapWork {
public:
    CollectMixedLargeGarbageTask(MixedRegionManager& manager, RegionList* regions,
                                 std::atomic<size_t>& garbageSize)
        : regionManager(manager), tmpRegions(regions), totalGarbageSize(garbageSize) {}

    void Execute(size_t) override
    {
        size_t garbageSize = 0;
        RegionInfo* region = tmpRegions->GetHeadRegion();
        while (region != nullptr) {
            RegionInfo* next = region->GetNextRegion();
            if (!region->IsSurvivedObject(0)) {
                tmpRegions->RemoveRegionNoLock(region);
                if (region->GetRegionSize() > RegionInfo::LARGE_OBJECT_RELEASE_THRESHOLD) {
                    garbageSize += regionManager.ReleaseRegion(region);
                } else {
                    garbageSize += regionManager.CollectRegion(region);
                }
            } else {
                if (region->IsPromoted()) {
                    tmpRegions->RemoveRegionNoLock(region);
                    regionManager.PromoteRegionInPlace(region);
                }
                region->ResetMarkBit();
            }
            region = next;
        }
        totalGarbageSize.fetch_add(garbageSize, std::memory_order_relaxed);
        regionManager.MergeOldLargeRegionList(*tmpRegions);
        delete tmpRegions;
    }

private:
    MixedRegionManager& regionManager;
    RegionList* tmpRegions;
    std::atomic<size_t>& totalGarbageSize;
};
} // namespace

void MixedRegionManager::DumpRegionStats(const char* msg, bool dumpToError) const
{
    RegionManager::DumpRegionStats(msg, dumpToError);

    auto dumpListStats = [dumpToError](const char* name, const RegionList& list, bool dumpFreeSlotSize) {
        size_t regions = list.GetRegionCount();
        size_t units = list.GetUnitCount();
        size_t size = units * RegionInfo::UNIT_SIZE;
        size_t allocated = list.GetAllocatedSize();
        if (dumpFreeSlotSize) {
            size_t freeSlotSize = GetFreeSlotTotalSize(list);
            const char* format = "\t%s %zu: %zu units (%zu B, alloc %zu, free slot %zu)";
            VLOG(REPORT, format, name, regions, units, size, allocated, freeSlotSize);
            if (dumpToError) {
                LOG(RTLOG_ERROR, format, name, regions, units, size, allocated, freeSlotSize);
            }
            return;
        }
        const char* format = "\t%s %zu: %zu units (%zu B, alloc %zu)";
        VLOG(REPORT, format, name, regions, units, size, allocated);
        if (dumpToError) {
            LOG(RTLOG_ERROR, format, name, regions, units, size, allocated);
        }
    };

    dumpListStats("sweepable young regions", sweepableYoungRegionList, false);
    dumpListStats("sweepable old regions", sweepableOldRegionList, false);
    dumpListStats("swept young regions", sweptYoungRegionList, true);
    dumpListStats("swept old regions", sweptOldRegionList, true);
    dumpListStats("old regions", oldRegionList, false);
    dumpListStats("old from regions", oldFromRegionList, false);
    dumpListStats("ghost old from regions", ghostOldFromRegionList, false);
    dumpListStats("discretely forwarding regions", discreteForwardingRegionList, false);
    dumpListStats("ghost promote regions", ghostPromoteRegionList, false);
}

size_t MixedRegionManager::ClassifyYoungRegions()
{
    size_t forwardBytes = 0;
    size_t floatingGarbage = 0;
    size_t oldFromBytes = fromRegionList.GetUnitCount() * RegionInfo::UNIT_SIZE;
    double exempt = exemptedRegionThreshold;
    auto visitor = [this, exempt, &floatingGarbage, &forwardBytes](RegionInfo* fromRegion) {
        long rawPtrCnt = fromRegion->GetRawPointerObjectCount();
        if (fromRegion->GetRegionSize() != GetThreadLocalRegionSize()) {
            RemoveRegionLocked(&fromRegionList, fromRegion);
            fromRegion->SetPromotedFlag(1);
            discreteForwardingRegionList.PrependRegion(fromRegion, RegionInfo::RegionType::FROM_PROMOTE_REGION);
            return;
        }
        if (rawPtrCnt == 0 && fromRegion->IsPromoted()) {
            RemoveRegionLocked(&fromRegionList, fromRegion);
            discreteForwardingRegionList.PrependRegion(fromRegion, RegionInfo::RegionType::FROM_PROMOTE_REGION);
            return;
        }
        size_t threshold = static_cast<size_t>(exempt * fromRegion->GetRegionSize());
        size_t liveBytes = fromRegion->GetLiveByteCount();
        if (liveBytes > threshold || rawPtrCnt > 0) { // ignore this region
            RegionInfo* del = fromRegion;
            DLOG(REGION, "region %p @[0x%zx+%zu, 0x%zx) exempted by forwarding: %zu units, %u live bytes", del,
                del->GetRegionStart(), del->GetRegionAllocatedSize(), del->GetRegionEnd(),
                del->GetUnitCount(), del->GetLiveByteCount());

            CHECK(del->IsFromRegion());
            RemoveRegionLocked(&fromRegionList, del);
            del->ClearGhostRegionBit();
            sweepableYoungRegionList.PrependRegion(del, RegionInfo::RegionType::SWEEP_REGION);
            floatingGarbage += (del->GetRegionSize() - del->GetLiveByteCount());
        } else {
            forwardBytes += liveBytes;
        }
    };
    fromRegionList.VisitAllRegions(visitor);

    auto promoteSweepVisitor = [this](RegionInfo* region) {
        long rawPtrCnt = region->GetRawPointerObjectCount();
        region->ClearGhostRegionBit();
        // If the region route kind is sweepable region, it may lead to promotion infomation deleted
        // when the region is rebuilt as free region.
        region->ClearFreeSlotList();
        if (rawPtrCnt == 0 && region->IsPromoted()) {
            RemoveRegionLocked(&sweepableYoungRegionList, region);
            recentFullRegionList.PrependRegion(region, RegionInfo::RegionType::RECENT_FULL_REGION);
        }
    };
    sweepableYoungRegionList.VisitAllRegions(promoteSweepVisitor);

    size_t newFromBytes = fromRegionList.GetUnitCount() * RegionInfo::UNIT_SIZE;
    size_t sweepableBytes = sweepableYoungRegionList.GetUnitCount() * RegionInfo::UNIT_SIZE;
    size_t promoteBytes = discreteForwardingRegionList.GetUnitCount() * RegionInfo::UNIT_SIZE;
    VLOG(REPORT, "select %zu B from %zu B to be region forwarded, %zu will be sweep, %zu will be object moved",
         forwardBytes, oldFromBytes, sweepableBytes, promoteBytes);
    return newFromBytes - forwardBytes;
}

namespace {
constexpr size_t FORWARD_REGION_BATCH_SIZE = 10;

std::set<RegionInfo*> TakeForwardRegionBatch(RegionList& regionList, RegionInfo::RegionType regionType)
{
    std::set<RegionInfo*> regions;
    std::lock_guard<std::mutex> lock(regionList.GetListMutex());
    for (size_t i = 0; i < FORWARD_REGION_BATCH_SIZE; ++i) {
        RegionInfo* region = regionList.TakeHeadRegionNoLock();
        if (region == nullptr) {
            break;
        }
        region->SetRegionType(regionType);
        regions.insert(region);
    }
    return regions;
}
} // namespace

class ForwardFromSpaceTask : public HeapWork {
public:
    ForwardFromSpaceTask(RegionManager& mgr, std::set<RegionInfo*>&& regions)
        : regionManager(mgr), regions(std::move(regions)) {}

    ~ForwardFromSpaceTask() override = default;

    void Execute(size_t) override
    {
        for (RegionInfo* region : regions) {
            regionManager.ForwardRegion(region);
        }
    }

private:
    RegionManager& regionManager;
    std::set<RegionInfo*> regions;
};

class PromoteRegionsTask : public HeapWork {
public:
    PromoteRegionsTask(MixedRegionManager& mgr, std::set<RegionInfo*>&& regions)
        : mixedManager(mgr), regions(std::move(regions)) {}

    ~PromoteRegionsTask() override = default;

    void Execute(size_t) override
    {
        for (RegionInfo* region : regions) {
            mixedManager.PromoteRegion(region);
        }
    }

private:
    MixedRegionManager& mixedManager;
    std::set<RegionInfo*> regions;
};

bool MixedRegionManager::RoutePromoteRegion(RegionInfo* fromRegion)
{
    do {
        RegionInfo::RouteState oldState = fromRegion->GetRouteState();
        if (oldState == RegionInfo::RouteState::PROMOTED) {
            return true;
        }
        if (oldState == RegionInfo::RouteState::HALF_PROMOTED) {
            return false;
        }
        if (oldState == RegionInfo::RouteState::ROUTED || oldState == RegionInfo::RouteState::COMPACTED) {
            LOG(RTLOG_FATAL, "promote a wrong from region");
        }
        if (oldState == RegionInfo::RouteState::ROUTING) {
            sched_yield();
            continue;
        }
        if (fromRegion->TryLockRouting(oldState)) {
            auto ret = PromoteRegionImpl(fromRegion);
            if (ret) {
                fromRegion->SetRouteState(RegionInfo::RouteState::PROMOTED);
            } else {
                fromRegion->SetRouteState(RegionInfo::RouteState::HALF_PROMOTED);
            }
            return ret;
        }
    } while (true);
}

void MixedRegionManager::PromoteRegion(RegionInfo* fromRegion)
{
    if (RoutePromoteRegion(fromRegion)) {
        DLOG(PROMOTE, "collect promoted region %p: [%p, %p)", fromRegion, fromRegion->GetRegionStart(),
             fromRegion->GetRegionEnd());
        CollectRegion(fromRegion);
    } else {
        DLOG(PROMOTE, "reactivate promoted region %p: [%p, %p)", fromRegion, fromRegion->GetRegionStart(),
             fromRegion->GetRegionEnd());
        recentFullRegionList.PrependRegion(fromRegion, RegionInfo::RegionType::RECENT_FULL_REGION);
    }
}

void MixedRegionManager::PromoteRegionInPlace(RegionInfo* region)
{
    CHECK(region != nullptr);
    CHECK(region->IsPromoted());

    region->SetOldRegionFlag(1);
    region->VisitAllObjects([region](BaseObject* object) {
        object->ForEachRefField([region](RefField<>& field) {
            RefField<> current(field);
            BaseObject* target = current.GetTargetObject();
            if (!Heap::IsHeapAddress(target)) {
                return true;
            }

            RegionInfo* targetRegion = nullptr;
            bool isOld = false;
            if (current.IsTagged()) {
                targetRegion = RegionInfo::GetGhostFromRegionAt(target);
                if (targetRegion != nullptr) {
                    isOld = targetRegion->IsOld0();
                } else {
                    targetRegion = RegionInfo::GetRegionInfoAt(target);
                    isOld = targetRegion->IsOldRegion();
                }
            } else {
                targetRegion = RegionInfo::GetRegionInfoAt(target);
                isOld = targetRegion->IsOldRegion();
            }
            if (!isOld) {
                RememberSet::Instance().Record(region, reinterpret_cast<uintptr_t>(&field));
            }
            return true;
        });
    });
    region->SetUnitRole(RegionInfo::UnitRole::SMALL_SIZED_UNITS);
    oldRegionList.PrependRegion(region, RegionInfo::RegionType::SWEEP_REGION);
}

size_t MixedRegionManager::CollectRegion(RegionInfo* region)
{
    DLOG(REGION, "collect region %p@[%#zx+%zu, %#zx) type %u", region, region->GetRegionStart(),
         region->GetLiveByteCount(), region->GetRegionEnd(), region->GetRegionType());
    region->LockWriteRegion();
    size_t collectedSize = region->IsLargeRegion() ? region->GetRegionSize()
                                                    : region->GetRegionSize() - region->GetLiveByteCount();
    region->SetRegionType(RegionInfo::RegionType::FREE_REGION);
    region->UnlockWriteRegion();
    GenerationAllocBuffer* buffer = GenerationAllocBuffer::GetGenerationAllocBuffer();
    buffer->CacheGarbageRegion(*this, region);
    return collectedSize;
}

size_t MixedRegionManager::CollectLargeGarbage()
{
    constexpr size_t regionsPerTask = 10;
    std::atomic<size_t> garbageSize{0};
    GCThreadPool* threadPool = Heap::GetHeap().GetCollectorResources().GetThreadPool();
    while (true) {
        RegionList* tmpRegions = new (std::nothrow) RegionList("old large regions task");
        CHECK_DETAIL(tmpRegions != nullptr, "failed to allocate old large regions task list");
        if (!largeRegionList.SplitByRegionCount(*tmpRegions, regionsPerTask)) {
            delete tmpRegions;
            break;
        }
        HeapWork* task = new (std::nothrow) CollectMixedLargeGarbageTask(*this, tmpRegions, garbageSize);
        CHECK_DETAIL(task != nullptr, "failed to allocate old large region collection task");
        if (threadPool == nullptr) {
            task->Execute(0);
            delete task;
        } else {
            threadPool->AddWork(task);
        }
    }
    if (threadPool != nullptr) {
        threadPool->Start();
        threadPool->WaitFinish();
    }

    recentLargeRegionList.VisitAllRegions([](RegionInfo* region) { region->ResetMarkBit(); });
    return garbageSize.load(std::memory_order_relaxed);
}

bool MixedRegionManager::PromoteRegionImpl(RegionInfo* fromRegion)
{
    CHECK(fromRegion->IsRoutingState());
    DLOG(PROMOTE, "promote region %p [%p, %p]", fromRegion, fromRegion->GetRegionStart(), fromRegion->GetRegionEnd());
    CopyCollector& collector = reinterpret_cast<CopyCollector&>(Heap::GetHeap().GetCollector());
    ObjectForwardingTable* fwdTable = fromRegion->GetForwardingTable();
    if (fwdTable == nullptr) {
        fwdTable = new ObjectForwardingTable();
        fromRegion->SetForwardingTable(fwdTable);
    }
    bool promoteAll = true;
    fromRegion->VisitLiveObjectsUntilFalse([fromRegion, &collector, &fwdTable, &promoteAll](BaseObject* currentObj) {
        StateWord oldWord = currentObj->GetStateWord();
        if (currentObj->IsForwarded()) {
            CHECK(fwdTable->GetRoute(currentObj) != nullptr);
            return true;
        }
        while (!currentObj->TryLockObject(oldWord)) {
            (void)sched_yield();
            continue;
        }
        uint8_t age = fromRegion->GetObjectAge(currentObj);
        GenerationAllocBuffer* buffer = GenerationAllocBuffer::GetGenerationAllocBuffer();
        size_t allocSize = RegionSpace::GetAllocSize(*currentObj);
        bool needPromote = age >= PROMOTE_AGE;
        MAddress toAddress = needPromote ? buffer->AllocateOld(allocSize) : buffer->AllocateYoung(allocSize);
        if (toAddress == 0) {
            BaseObject* toObj = currentObj;
            toObj->SetStateCode(ObjectState::NORMAL);
            fwdTable->SetForwardingAddr(currentObj, toObj);
            promoteAll = false;
            DLOG(PROMOTE, "promote obj %p<%p>(%zu) to self %p", currentObj, currentObj->GetTypeInfo(), allocSize,
                toObj);
            return true;
        }
        BaseObject* toObj = reinterpret_cast<BaseObject*>(toAddress);
        DLOG(PROMOTE, "promote obj %p<%p>(%zu) to %s %p", currentObj, currentObj->GetTypeInfo(), allocSize,
             needPromote ? "to old" : "to young", toObj);
        collector.CopyObject(*currentObj, *toObj, allocSize);
        toObj->SetStateCode(ObjectState::NORMAL);
        if (needPromote) {
            RegionInfo* sourceRegion = RegionInfo::GetRegionInfoAt(reinterpret_cast<MAddress>(toObj));
            toObj->ForEachRefField([sourceRegion](RefField<>& field) {
                RefField<> tmp(field);
                BaseObject* target = field.GetTargetObject();
                if (!Heap::IsHeapAddress(target)) {
                    return true;
                }
                bool isTagged = tmp.IsTagged();
                RegionInfo* refRegion = nullptr;
                bool isOld = false;
                if (isTagged) {
                    refRegion = RegionInfo::GetGhostFromRegionAt(target);
                    if (refRegion != nullptr) {
                        isOld = refRegion->IsOld0();
                    } else {
                        refRegion = RegionInfo::GetRegionInfoAt(target);
                        isOld = refRegion->IsOldRegion();
                    }
                } else {
                    refRegion = RegionInfo::GetRegionInfoAt(target);
                    isOld = refRegion->IsOldRegion();
                }
                // The object that is being promoted in current gc is also recorded, since we need to fix its pointer.
                if (!isOld) {
                    RememberSet::Instance().Record(sourceRegion, reinterpret_cast<uintptr_t>(&field));
                }
                return true;
            });
        }
        currentObj->SetStateCode(ObjectState::FORWARDED);
        fwdTable->SetForwardingAddr(currentObj, toObj);
        return true;
    });
    if (!promoteAll) {
        fromRegion->SetRegionType(RegionInfo::RegionType::RECENT_FULL_REGION);
    }
    return promoteAll;
}

void MixedRegionManager::ForwardFromSpace(GCThreadPool* threadPool)
{
    if (threadPool == nullptr) {
        ForwardFromRegions();
        while (true) {
            RegionInfo* region = discreteForwardingRegionList.TakeHeadRegion(RegionInfo::RegionType::LONE_FROM_REGION);
            if (region == nullptr) {
                break;
            }
            PromoteRegion(region);
        }
        return;
    }
    threadPool->Start();
    while (true) {
        std::set<RegionInfo*> regions = TakeForwardRegionBatch(fromRegionList,
                                                                RegionInfo::RegionType::LONE_FROM_REGION);
        if (regions.empty()) {
            break;
        }
        HeapWork* task = new (std::nothrow) ForwardFromSpaceTask(*this, std::move(regions));
        CHECK_DETAIL(task != nullptr, "failed to allocate forward region task");
        threadPool->AddWork(task);
    }
    while (true) {
        std::set<RegionInfo*> regions = TakeForwardRegionBatch(discreteForwardingRegionList,
                                                                RegionInfo::RegionType::LONE_FROM_REGION);
        if (regions.empty()) {
            break;
        }
        HeapWork* task = new (std::nothrow) PromoteRegionsTask(*this, std::move(regions));
        CHECK_DETAIL(task != nullptr, "failed to allocate promote region task");
        threadPool->AddWork(task);
    }
    threadPool->WaitFinish();

    Heap::GetHeap().GetAllocator().VisitAllocBuffers([this](AllocBuffer& buffer) {
        RegionInfo* oldRegion = static_cast<GenerationAllocBuffer&>(buffer).TakeOldAllocRegion();
        if (oldRegion != nullptr && oldRegion != RegionInfo::NullRegion()) {
            RemoveThreadLocalRegion(oldRegion);
            EnlistOldRegionList(oldRegion);
            oldRegion = RegionInfo::NullRegion();
        }
        static_cast<GenerationAllocBuffer&>(buffer).MoveOldSlotRegionCacheTo(sweptOldRegionList);
    });
}

bool MixedRegionManager::IsYoungSpaceHeavy() const
{
    return true;
}

BaseObject* MixedRegionManager::PromoteObject(BaseObject* fromObj, RegionInfo* fromRegion)
{
    CHECK(fromRegion->IsPromoted0());
    RoutePromoteRegion(fromRegion);
    ObjectForwardingTable* fwdTable = fromRegion->GetForwardingTable();
    return fwdTable->GetRoute(fromObj);
}

} // namespace MapleRuntime
