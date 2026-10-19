// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "CollectorProxy.h"

namespace MapleRuntime {
void CollectorProxy::Init()
{
    if (Heap::GetGCMode() == GCMode::GENERATIONAL) {
        youngCollector.Init();
    } else {
        wCollector.Init();
    }

    if (currentCollector == nullptr) {
        currentCollector = Heap::GetGCMode() == GCMode::GENERATIONAL ?
            static_cast<TracingCollector*>(&youngCollector) : static_cast<TracingCollector*>(&wCollector);
    }
}

void CollectorProxy::Fini()
{
    if (Heap::GetGCMode() == GCMode::GENERATIONAL) {
        youngCollector.Fini();
    } else {
        wCollector.Fini();
    }
}

void CollectorProxy::RunGarbageCollection(uint64_t gcIndex, GCReason reason)
{
    if (Heap::GetGCMode() != GCMode::GENERATIONAL) {
        currentCollector = &wCollector;
    } else {
        switch (reason) {
            case GC_REASON_USER:
                currentCollector = &mixedCollector;
                break;
            case GC_REASON_HEU:
                currentCollector = &youngCollector;
                break;
            case GC_REASON_BACKUP:
            case GC_REASON_MIXED:
                currentCollector = &mixedCollector;
                break;
            case GC_REASON_OOM:
            case GC_REASON_FORCE:
                currentCollector = &mixedCollector;
                break;
            default:
                currentCollector = &youngCollector;
                break;
        }
    }
    currentCollector->SetGcStarted(true);
    currentCollector->RunGarbageCollection(gcIndex, reason);
}
} // namespace MapleRuntime
