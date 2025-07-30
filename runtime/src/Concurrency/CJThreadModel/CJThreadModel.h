// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_CJTHREAD_MODEL_H
#define MRT_CJTHREAD_MODEL_H

#include <list>
#include <mutex>
#include <sys/types.h>
#include <unistd.h>

#include "Concurrency/ConcurrencyModel.h"
#include "Mutator/Mutator.h"
#include "RuntimeConfig.h"

namespace MapleRuntime {
class CJThreadModel : public ConcurrencyModel {
public:
    CJThreadModel() = default;
    ~CJThreadModel() override = default;

    void Init(const ConcurrencyParam param, ScheduleType type) override;
    void VisitGCRoots(RootVisitor* visitorHandle) override;
    void* GetThreadScheduler() const override { return scheduler; }
    size_t GetReservedStackSize() const override { return reservedStackSize; }
    bool GetStackGuardCheckFlag() const override { return stackGuardCheck; }
};
} // namespace MapleRuntime
#endif // MRT_CJTHREAD_MODEL_H
