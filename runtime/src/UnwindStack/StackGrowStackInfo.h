// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_SE_STACKINFO_H
#define MRT_SE_STACKINFO_H

#include "Base/LogFile.h"
#include "StackInfo.h"
#include "StackMap/StackMapTypeDef.h"

namespace MapleRuntime {
class StackGrowStackInfo : public StackInfo {
public:
    explicit StackGrowStackInfo(const UnwindContext* context = nullptr) : StackInfo(context)
    {
#if defined(MRT_DEBUG) && (MRT_DEBUG == 1)
        DLOG(UNWIND, "SE Stack Info");
        DLOG(UNWIND, "TopContext : %x", context);
        if (context != nullptr) {
            DLOG(UNWIND, "Top Context ip : %x Top Context fa : %x", context->frameInfo.mFrame.GetIP(),
                 context->frameInfo.mFrame.GetFA());
        }
#endif
    }

    ~StackGrowStackInfo() override = default;
    void FillInStackTrace() override;
    void RecordStackPtrs(const StackPtrVisitor& traceAndFixPtrVisitor,
                         const StackPtrVisitor& fixPtrVisitor,
                         const DerivedPtrVisitor& derivedPtrVisitor,
                         Mutator& mutator);
    void RecordStackPtrsImpl(const StackPtrVisitor& traceAndFixPtrVisitor,
                             const StackPtrVisitor& fixPtrVisitor,
                             const DerivedPtrVisitor& derivedPtrVisitor,
                             RegSlotsMap& regSlotsMap,
                             const FrameInfo& frame, Mutator& mutator);
};
} // namespace MapleRuntime
#endif // MRT_SE_STACKINFO_H
