// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_GCREQUEST_H
#define MRT_GCREQUEST_H

#include <cstdint>
#include <limits>

#include "Base/Globals.h"

namespace MapleRuntime {
// Minimum time between async GC (heuristic, native).
constexpr uint64_t MIN_ASYNC_GC_INTERVAL_NS = MapleRuntime::SECOND_TO_NANO_SECOND;
constexpr uint64_t LONG_MIN_HEU_GC_INTERVAL_NS = 200 * MapleRuntime::MILLI_SECOND_TO_NANO_SECOND;

// Used by Collector::RequestGC.
// It tells why GC is triggered.
//
// sync: Caller of Collector::RequestGC will wait until GC completes.
// async: Collector::RequestGC returns immediately and caller continues to run.
enum GCReason : uint32_t {
    GC_REASON_USER = 0,    // Triggered by user explicitly.
    GC_REASON_OOM,         // Out of memory. Failed to allocate object.
    GC_REASON_BACKUP,      // backup gc is triggered if no other reason triggers gc for a long time.
    GC_REASON_HEU,         // Statistics show it is worth doing GC. Does not have to be immediate.
    GC_REASON_NATIVE,      // Native-Allocation-Registry shows it's worth doing GC.
    GC_REASON_HEU_SYNC,    // Just wait one gc request to reduce heap fragmentation.
    GC_REASON_NATIVE_SYNC, // Just wait one gc request to reduce native heap consumption.
    GC_REASON_FORCE,       // force gc is triggered when runtime triggers gc actively.
    GC_REASON_MAX,
    GC_REASON_INVALID = std::numeric_limits<uint32_t>::max(),
};

struct GCRequest {
    const GCReason reason;
    const char* name; // Human-readable names of GC reasons.

    const bool isSync;
    const bool isConcurrent;

    uint64_t minIntervelNs;
    uint64_t prevRequestTime;

    inline bool IsFrequentGC() const;
    inline bool IsFrequentAsyncGC() const;
    inline bool IsFrequentHeuristicGC() const;
    bool ShouldBeIgnored() const;

    bool IsSyncGC() const { return isSync; }

    void SetMinInterval(const uint64_t intervalNs) { minIntervelNs = intervalNs; }
    void SetPrevRequestTime(uint64_t timestamp) { prevRequestTime = timestamp; }
};

// Defined in gcRequest.cpp
extern GCRequest g_gcRequests[];
} // namespace MapleRuntime
#endif // MRT_GCREQUEST_H
