// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "Collector/Collector.h"

#include "Heap/Heap.h"
#include "Mutator/Mutator.h"

namespace MapleRuntime {
namespace {
const char* const COLLECTOR_NAME[] = { "No Collector", "Proxy Collector", "Regional-Copying Collector",
                                       "Smooth Collector", "Young Collector", "Mixed Collector" };
}

const char* Collector::GetGCPhaseName(GCPhase phase)
{
    static const char* phaseNames[] = {
        "undefined phase",          // 0
        "idle phase",               // 1
        "finish phase",             // 2
        "reclaim satb phase",       // 3
        "stub phase",               // 4
        "stub phase",               // 5
        "stub phase",               // 6
        "stub phase",               // 7
        "init phase",               // 8
        "enum phase",               // 9
        "trace phase",              // 10
        "clear satb phase",         // 11
        "post trace phase",         // 12
        "preforward phase",         // 13
        "forward phase",            // 14
        "generation idle phase",    // 15
        "generation enum phase",    // 16
        "generation trace phase",   // 17
        "generation reclaim satb phase", // 18
        "generation preforward phase", // 19
        "generation forward phase", // 20
        "generation post trace phase", // 21
    };
    if (phase >= sizeof(phaseNames) / sizeof(phaseNames[0])) {
        return "unknown phase";
    }
    return phaseNames[phase];
}

Collector::Collector() {}

const char* Collector::GetCollectorName() const { return COLLECTOR_NAME[collectorType]; }

void Collector::RequestGC(GCReason reason, bool async) { RequestGCInternal(reason, async); }
bool Collector::IsTargetAddress(const BaseObject* obj) const
{
    return Heap::IsHeapAddress(obj);
}
} // namespace MapleRuntime.
