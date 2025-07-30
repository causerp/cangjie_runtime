// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "PrintSignalStackInfo.h"

#include "Common/StackType.h"

namespace MapleRuntime {
void PrintSignalStackInfo::FillInStackTrace()
{
    UnwindContext uwContext;
    // Top unwind context can only be runtime or Cangjie context.
    CheckTopUnwindContextAndInit(uwContext);
    while (!uwContext.frameInfo.mFrame.IsAnchorFrame(anchorFA)) {
        AnalyseAndSetFrameType(uwContext);
        if (uwContext.frameInfo.GetFrameType() == FrameType::C2N_STUB && lastFrameType == FrameType::N2C_STUB) {
            // Check whether out-of-bounds array occurs. If the value is about to exceed the limit,
            // increase the value of Index by 1 to print prompt information using comments.
            if (stackIndex >= MAX_SIGNAL_STACK_SIZE) {
                stackIndex++;
                break;
            }
            signalStack[stackIndex++] = SigHandlerFrameinfo(MachineFrame(), FrameType::NATIVE);
        }
        if (stackIndex >= MAX_SIGNAL_STACK_SIZE) {
            stackIndex++;
            break;
        }
        signalStack[stackIndex++] = uwContext.frameInfo;

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

void PrintSignalStackInfo::PrintStackTrace() const
{
    uint16_t stackSize;
    bool longStackFlag = false;

    if (stackIndex < MAX_SIGNAL_STACK_SIZE) {
        stackSize = stackIndex;
    } else {
        stackSize = MAX_SIGNAL_STACK_SIZE;
        longStackFlag = true;
    }
    for (size_t i = 0; i < stackSize; ++i) {
        signalStack[i].PrintFrameInfo(i);
    }
    if (longStackFlag) {
        FLOG(RTLOG_ERROR, "      ...");
    }
}
} // namespace MapleRuntime
