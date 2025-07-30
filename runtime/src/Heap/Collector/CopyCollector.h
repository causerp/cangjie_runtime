// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_COPY_COLLECTOR_H
#define MRT_COPY_COLLECTOR_H

#include "Allocator/RegionSpace.h"
#include "Common/StateWord.h"
#include "TracingCollector.h"

namespace MapleRuntime {
class CopyCollector : public TracingCollector {
public:
    explicit CopyCollector(Allocator& allocator, CollectorResources& resources) : TracingCollector(allocator, resources)
    {
        collectorType = CollectorType::COPY_COLLECTOR;
    }
    ~CopyCollector() override = default;

    MRT_EXPORT void RunGarbageCollection(uint64_t gcIndex, GCReason reason) override;
    void CopyObject(const BaseObject& fromObj, BaseObject& toObj, size_t size) const;
    void PostGarbageCollection(uint64_t gcIndex) override;

protected:
    virtual BaseObject* ForwardObjectExclusive(BaseObject* obj) = 0;
    virtual void ForwardFromSpace();
    virtual void RefineFromSpace();

    virtual void DoGarbageCollection() = 0;

private:
};
} // namespace MapleRuntime
#endif // MRT_COPY_COLLECTOR_H
