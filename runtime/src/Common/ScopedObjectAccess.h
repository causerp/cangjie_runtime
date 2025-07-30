// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_SCOPED_SAFEREGION_H
#define MRT_SCOPED_SAFEREGION_H

#include "Mutator/Mutator.inline.h"

namespace MapleRuntime {
// Scoped guard for saferegion.
class ScopedEnterSaferegion {
public:
    ScopedEnterSaferegion() = delete;
    explicit ScopedEnterSaferegion(bool onlyForMutator = false)
    {
        Mutator* mutator = Mutator::GetMutator();
        ThreadType threadType = ThreadLocal::GetThreadType();
        if (onlyForMutator &&
            (threadType == ThreadType::FP_THREAD || threadType == ThreadType::GC_THREAD)) {
            stateChanged = false;
        } else {
            stateChanged = (mutator != nullptr) ? mutator->EnterSaferegion(true) : false;
        }
    }

    ~ScopedEnterSaferegion()
    {
        if (LIKELY(stateChanged)) {
            Mutator* mutator = Mutator::GetMutator(); // state changed, mutator must be not null
            (void)mutator->LeaveSaferegion();
        }
    }

private:
    bool stateChanged;
};

class ScopedObjectAccess {
public:
    ScopedObjectAccess() : mutator(*Mutator::GetMutator()), leavedSafeRegion(mutator.LeaveSaferegion()) {}

    ~ScopedObjectAccess()
    {
        if (LIKELY(leavedSafeRegion)) {
            // qemu use c++ thread local, it has issue with some cases for ZRT annotation, if reload again
            // fail on O3 and pass on O0 if load mutator again, not figureout why yet
            (void)mutator.EnterSaferegion(false);
        }
    }

private:
    Mutator& mutator;
    bool leavedSafeRegion;
};
} // namespace MapleRuntime

#endif // MRT_SCOPED_SAFEREGION_H
