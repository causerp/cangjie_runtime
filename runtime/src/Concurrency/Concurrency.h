// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_CONCURRENCY_H
#define MRT_CONCURRENCY_H

#include <list>
#include <mutex>
#include <sys/types.h>
#include <unistd.h>

#include "ConcurrencyModel.h"
#include "CJThreadModel/CJThreadModel.h"
#include "Mutator/Mutator.h"
#include "RuntimeConfig.h"

namespace MapleRuntime {
class Concurrency : public ConcurrencyModel {
public:
    Concurrency() = default;
    ~Concurrency() override
    {
        if (concurrencyModel != nullptr) {
            delete concurrencyModel;
            concurrencyModel = nullptr;
        }
    }

    void Init(const ConcurrencyParam param, ScheduleType type = SCHEDULE_DEFAULT) override;

    void VisitGCRoots(RootVisitor* visitorHandle) override { concurrencyModel->VisitGCRoots(visitorHandle); }

    void* GetThreadScheduler() const override { return concurrencyModel->GetThreadScheduler(); }
    size_t GetReservedStackSize() const override { return concurrencyModel->GetReservedStackSize(); }
    bool GetStackGuardCheckFlag() const override { return concurrencyModel->GetStackGuardCheckFlag(); }

    uint32_t GetProcessorNum() const override { return processorNum; }

private:
    ConcurrencyModel* concurrencyModel = nullptr;
    uint32_t processorNum = 1;
};
} // namespace MapleRuntime
#endif // MRT_CONCURRENCY_H
