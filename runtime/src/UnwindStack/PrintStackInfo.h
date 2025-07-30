// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_PRINT_STACKINFO_H
#define MRT_PRINT_STACKINFO_H

#include "Base/LogFile.h"
#include "StackInfo.h"

namespace MapleRuntime {
class PrintStackInfo : public StackInfo {
public:
    explicit PrintStackInfo(const UnwindContext* context = nullptr) : StackInfo(context)
    {
#if defined(MRT_DEBUG) && (MRT_DEBUG == 1)
        DLOG(UNWIND, "Print Stack Info");
        DLOG(UNWIND, "TopContext : %x", context);
        if (context != nullptr) {
            DLOG(UNWIND, "Top Context ip : %x Top Context fa : %x", context->frameInfo.mFrame.GetIP(),
                 context->frameInfo.mFrame.GetFA());
        }
#endif
    }

    ~PrintStackInfo() override = default;
    void FillInStackTrace() override;
    virtual void PrintStackTrace() const;
};
} // namespace MapleRuntime
#endif // MRT_PRINT_STACKINFO_H
