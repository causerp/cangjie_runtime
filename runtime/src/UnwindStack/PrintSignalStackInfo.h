// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_PRINT_SIGNALSTACKINFO_H
#define MRT_PRINT_SIGNALSTACKINFO_H

#include "Base/LogFile.h"
#include "PrintStackInfo.h"

namespace MapleRuntime {
class PrintSignalStackInfo : public PrintStackInfo {
public:
    explicit PrintSignalStackInfo(const UnwindContext* context = nullptr) : PrintStackInfo(context), stackIndex(0) {}

    ~PrintSignalStackInfo() override = default;
    void FillInStackTrace() override;
    void PrintStackTrace() const override;
    SigHandlerFrameinfo* GetSignalStack() { return signalStack; }
    uint16_t GetStackIndex() const { return stackIndex; }
    void SetStackIndex(uint8_t i) { stackIndex = i; }

private:
    constexpr static uint8_t MAX_SIGNAL_STACK_SIZE = 32;
    SigHandlerFrameinfo signalStack[MAX_SIGNAL_STACK_SIZE];
    uint16_t stackIndex;
};
} // namespace MapleRuntime
#endif // MRT_PRINT_SIGNALSTACKINFO_H
