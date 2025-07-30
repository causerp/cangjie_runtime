// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_COLLECTOR_PROXY_H
#define MRT_COLLECTOR_PROXY_H

#include "Base/Macros.h"
#include "Collector.h"
#include "CollectorResources.h"
#include "WCollector/WCollector.h"

namespace MapleRuntime {
// CollectorProxy is a special kind of collector, it is derived from Base class Collector, thus behaves like a real
// collector. However, it actually manages a set of collectors implemented yet, and delegate garbage-collecting to
// one of these collectors.
// CollectorProxy should inherit collector interfaces, but no datas
class CollectorProxy : public Collector {
public:
    explicit CollectorProxy(Allocator& allocator, CollectorResources& resources) : wCollector(allocator, resources)
    {
        collectorType = CollectorType::PROXY_COLLECTOR;
    }

    ~CollectorProxy() override = default;

    void Init() override;
    void Fini() override;

    GCPhase GetGCPhase() const override { return currentCollector->GetGCPhase(); }

    void SetGCPhase(const GCPhase phase) override { currentCollector->SetGCPhase(phase); }

    // dispatch garbage collection to the right collector
    MRT_EXPORT void RunGarbageCollection(uint64_t gcIndex, GCReason reason) override;

    bool ShouldIgnoreRequest(GCRequest& request) override { return currentCollector->ShouldIgnoreRequest(request); }

    TracingCollector& GetCurrentCollector() const { return *currentCollector; }

    BaseObject* FindToVersion(BaseObject* obj) const override { return currentCollector->FindToVersion(obj); }

    bool IsOldPointer(RefField<>& ref) const override { return currentCollector->IsOldPointer(ref); }
    bool IsCurrentPointer(RefField<>& ref) const override { return currentCollector->IsCurrentPointer(ref); }
    bool IsFromObject(BaseObject* obj) const override { return currentCollector->IsFromObject(obj); }
    bool IsGhostFromObject(BaseObject* obj) const override { return currentCollector->IsGhostFromObject(obj); }
    bool IsUnmovableFromObject(BaseObject* obj) const override { return currentCollector->IsUnmovableFromObject(obj); }

    void AddRawPointerObject(BaseObject* obj) override { return currentCollector->AddRawPointerObject(obj); }
    void RemoveRawPointerObject(BaseObject* obj) override { return currentCollector->RemoveRawPointerObject(obj); }

    BaseObject* ForwardObject(BaseObject* obj) override { return currentCollector->ForwardObject(obj); }

    bool TryUpdateRefField(BaseObject* obj, RefField<>& field, BaseObject*& toVersion) const override
    {
        return currentCollector->TryUpdateRefField(obj, field, toVersion);
    }

    bool TryForwardRefField(BaseObject* obj, RefField<>& field, BaseObject*& toVersion) const override
    {
        return currentCollector->TryForwardRefField(obj, field, toVersion);
    }

    bool TryUntagRefField(BaseObject* obj, RefField<>& field, BaseObject*& target) const override
    {
        return currentCollector->TryUntagRefField(obj, field, target);
    }

    RefField<> GetAndTryTagRefField(BaseObject* obj) const override
    {
        return currentCollector->GetAndTryTagRefField(obj);
    }

private:
    // supported collector set
    TracingCollector* currentCollector = nullptr;
    WCollector wCollector;
};
} // namespace MapleRuntime

#endif // MRT_COLLECTOR_PROXY_H
