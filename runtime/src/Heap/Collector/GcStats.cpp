// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "GcStats.h"

#include "Base/LogFile.h"
#include "GenerationalGC/GenerationConstants.h"
#include "Heap/Heap.h"

namespace MapleRuntime {
size_t g_gcCount = 0;
uint64_t g_gcTotalTimeUs = 0;
size_t g_gcCollectedTotalBytes = 0;

uint64_t GCStats::prevGcStartTime = TimeUtil::NanoSeconds() - LONG_MIN_HEU_GC_INTERVAL_NS;
uint64_t GCStats::prevGcFinishTime = TimeUtil::NanoSeconds() - LONG_MIN_HEU_GC_INTERVAL_NS;

void GCStats::Init()
{
    isConcurrentMark = false;
    async = false;
    gcStartTime = TimeUtil::NanoSeconds();
    gcEndTime = TimeUtil::NanoSeconds();
    collectedObjects = 0;
    collectedBytes = 0;

    fromSpaceSize = 0;
    smallGarbageSize = 0;

    pinnedSpaceSize = 0;
    pinnedGarbageSize = 0;

    largeSpaceSize = 0;
    largeGarbageSize = 0;

    liveBytesBeforeGC = 0;
    liveBytesAfterGC = 0;

    garbageRatio = 0.0;
    collectionRate = 0.0;

    // 20 MB:set 20 MB as intial value
    heapThreshold = std::min(CangjieRuntime::GetGCParam().gcThreshold, 20 * MB);
    // 0.2:set 20% heap size as intial value
    heapThreshold = std::min(static_cast<size_t>(Heap::GetHeap().GetMaxCapacity() * 0.2), heapThreshold);
}

void GenerationalGCStats::Init()
{
    GCStats::Init();
    youngThreshold = std::min(INITIAL_YOUNG_THRESHOLD, CangjieRuntime::GetGCParam().gcThreshold);
    const size_t maxCapacity = Heap::GetHeap().GetMaxCapacity();
    const size_t youngCapacity = std::min(maxCapacity / YOUNG_GEN_CAPACITY_DIVISOR,
                                          YOUNG_CAPACITY_FOR_MIXED_MAX);
    const size_t minMixedThreshold = youngCapacity * MIN_MIXED_THRESHOLD_NUM / MIN_MIXED_THRESHOLD_DEN;
    mixedThreshold = std::max(maxCapacity / MIN_MIXED_THRESHOLD_HEAP_DIVISOR, minMixedThreshold);
    allocationBytes.store(0, std::memory_order_relaxed);
    allocationStartTime.store(TimeUtil::NanoSeconds(), std::memory_order_relaxed);
    allocationSpeed = 0.0;
}

void GenerationalGCStats::RecordAllocation(size_t bytes)
{
    allocationBytes.fetch_add(bytes, std::memory_order_relaxed);
}

double GenerationalGCStats::RefreshAllocationSpeed(uint64_t timestamp)
{
    uint64_t start = allocationStartTime.load(std::memory_order_relaxed);
    uint64_t elapsed = timestamp - start;
    size_t bytes = allocationBytes.exchange(0, std::memory_order_relaxed);
    if (elapsed != 0) {
        allocationSpeed = static_cast<double>(bytes) / static_cast<double>(elapsed);
    }
    allocationStartTime.store(timestamp, std::memory_order_relaxed);
    return allocationSpeed;
}

double GenerationalGCStats::GetAllocationSpeed() const
{
    return allocationSpeed;
}

void GCStats::Dump() const
{
    // Print a summary of the last GC.
    size_t liveSize = Heap::GetHeap().GetAllocatedSize();
    size_t heapSize = Heap::GetHeap().GetUsedPageSize();
    double utilization = (heapSize == 0) ? 0 : (static_cast<double>(liveSize) / heapSize) * 100; // 100 for percentage.

    // Do not change this GC log format.
    // Output one line statistic info after each gc task,
    // include the gc type, collected objects and current heap utilization, etc.
    // display to std-output. take care to modify.
    LOG(RTLOG_INFO,
        "GC for %s: %s collected objects: %zu->%s, %.2f%% utilization (%zu->%s/%zu->%s), "
        "total GC time: %llu->%s",
        g_gcRequests[reason].name, (async ? "async:" : "sync:"),
        collectedBytes, PrettyOrderInfo(collectedBytes, "B").Str(),
        utilization, liveSize, PrettyOrderInfo(liveSize, "B").Str(),
        heapSize, PrettyOrderInfo(heapSize, "B").Str(),
        gcEndTime - gcStartTime, PrettyOrderMathNano(gcEndTime - gcStartTime, "s").Str());

    VLOG(REPORT, "allocated size: %s, heap size: %s, heap utilization: %.2f%%", Pretty(liveSize).Str(),
         Pretty(heapSize).Str(), utilization);
}
} // namespace MapleRuntime
