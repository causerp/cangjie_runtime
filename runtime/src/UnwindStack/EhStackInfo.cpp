// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#include "EhStackInfo.h"

#include <stack>

#include "Common/StackType.h"
#include "Interpreter/Options.h"

namespace MapleRuntime {
void EHStackInfo::FillInStackTrace()
{
    UnwindContext uwContext;
    // Top unwind context can only be runtime or Cangjie context.
    CheckTopUnwindContextAndInit(uwContext);
    DLOG(INTERPRETER, "EHStackInfo::FillInStackTrace, top frame type: %d, name: %s", uwContext.frameInfo.GetFrameType(),
        uwContext.frameInfo.GetFuncName().Str());

    while (!uwContext.frameInfo.mFrame.IsAnchorFrame(anchorFA)) {
        AnalyseAndSetFrameType(uwContext);
        if (n2cCount == 1) {
            return;
        }

        stack.emplace_back(uwContext.frameInfo);
        DLOG(INTERPRETER, "  Added frame to EH stack info, frame type: %d, name: %s",
            uwContext.frameInfo.GetFrameType(), uwContext.frameInfo.GetFuncName().Str());

        UnwindContext caller;
        lastFrameType = uwContext.frameInfo.GetFrameType();
#ifndef _WIN64
        if (uwContext.UnwindToCallerContext(caller) == false) {
#else
        if (uwContext.UnwindToCallerContext(caller, uwCtxStatus) == false) {
#endif
            return;
        }
        uwContext = caller;
    }
}
} // namespace MapleRuntime
