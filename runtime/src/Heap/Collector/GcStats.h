// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_STATS_H
#define MRT_STATS_H

#include <algorithm>
#include <atomic>
#include <list>
#include <memory>

#include "Base/ImmortalWrapper.h"
#include "Base/Panic.h"
#include "GcRequest.h"

namespace MapleRuntime {
// statistics for previous gc.
class GCStats {
public:
    GCStats() = default;
    virtual ~GCStats() = default;

    void Init();

    size_t GetThreshold() const { return heapThreshold; }
    virtual void RecordAllocation(size_t) {}
    virtual double RefreshAllocationSpeed(uint64_t) { return 0.0; }
    void Dump() const;

    static uint64_t GetPrevGCStartTime() { return prevGcStartTime; }

    static void SetPrevGCStartTime(uint64_t timestamp) { prevGcStartTime = timestamp; }

    static uint64_t GetPrevGCFinishTime() { return prevGcFinishTime; }

    static void SetPrevGCFinishTime(uint64_t timestamp) { prevGcFinishTime = timestamp; }

    static uint64_t prevGcStartTime;
    static uint64_t prevGcFinishTime;

    GCReason reason;
    bool isConcurrentMark;
    bool async;

    uint64_t gcStartTime;
    uint64_t gcEndTime;

    size_t liveBytesBeforeGC;
    size_t liveBytesAfterGC;

    size_t fromSpaceSize;
    size_t smallGarbageSize;

    size_t pinnedSpaceSize;
    size_t pinnedGarbageSize;

    size_t largeSpaceSize;
    size_t largeGarbageSize;

    size_t collectedBytes;
    size_t collectedObjects;

    double garbageRatio;
    double collectionRate; // bytes per nano-second

    size_t heapThreshold;
};

class GenerationalGCStats : public GCStats {
public:
    void Init();

    size_t GetYoungThreshold() const { return youngThreshold.load(std::memory_order_relaxed); }
    size_t GetMixedThreshold() const { return mixedThreshold.load(std::memory_order_relaxed); }

    void RecordAllocation(size_t bytes) override;
    double RefreshAllocationSpeed(uint64_t timestamp) override;
    double GetAllocationSpeed() const;
    void SetYoungThreshold(size_t threshold) { youngThreshold.store(threshold, std::memory_order_relaxed); }
    void SetMixedThreshold(size_t threshold) { mixedThreshold.store(threshold, std::memory_order_relaxed); }

private:
    std::atomic<size_t> youngThreshold{ 0 };
    std::atomic<size_t> mixedThreshold{ 0 };
    std::atomic<size_t> allocationBytes{ 0 };
    std::atomic<uint64_t> allocationStartTime{ 0 };
    double allocationSpeed = 0.0;
};
extern size_t g_gcCount;
extern uint64_t g_gcTotalTimeUs;
extern size_t g_gcCollectedTotalBytes;
} // namespace MapleRuntime
#endif // MRT_STATS_H
