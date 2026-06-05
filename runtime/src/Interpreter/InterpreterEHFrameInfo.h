// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#ifndef MRT_INTERPRETER_EH_FRAMEINFO_H
#define MRT_INTERPRETER_EH_FRAMEINFO_H

#ifdef INTERPRETER_ENABLED

#include "Exception/EhFrameInfo.h"
#include "Common/StackType.h"

namespace MapleRuntime {

class InterpreterEHFrameInfo : public IEHFrameInfo, public FrameInfo {
public:

    InterpreterEHFrameInfo(const FrameInfo& info, uintptr_t landingPad): FrameInfo(info), landingPad(landingPad)
    {
    }

    // forbid copying, objects are accessed through unique_ptr
    InterpreterEHFrameInfo(const InterpreterEHFrameInfo&) = delete;
    InterpreterEHFrameInfo& operator=(const InterpreterEHFrameInfo&) = delete;

    ~InterpreterEHFrameInfo() override = default;

    bool IsCatchException() const override
    {
        // Interpreted frames alawys catch exception, allowing interpreter to search for catch block for this method.
        // Transition stubs are not catch points.
        return !IsTransitionStubFrame();
    }

    uint64_t GetTTypeIndex() const override
    {
        return 0;
    }

    uintptr_t GetLandingPad() const override
    {
        return landingPad;
    }

    void RestoreToCallerContext(CalleeSavedRegisterContext& context, uint32_t adjustedSize = 0) const override
    {
        // this method should not be called because interpreted frame always catches exception
        LOG(RTLOG_FATAL, "IntepreterEHFrameInfo::RestoreToCallerContext should not be called\n");
    }

    const uint32_t* GetIP() const override
    {
        return mFrame.GetIP();
    }

    FrameAddress* GetFA() const override
    {
        return mFrame.GetFA();
    }

    MachineFrame GetMachineFrame() const override
    {
        return mFrame;
    }

    const CString GetFunctionName() const override
    {
        return FrameInfo::GetFuncName();
    }

private:
    bool IsTransitionStubFrame() const
    {
        return mFrame.IsC2IStubFrame() || mFrame.IsI2IFrame() || mFrame.IsI2NFrame();
    }

    uintptr_t landingPad;
};

} // namespace MapleRuntime

#endif // INTERPRETER_ENABLED
#endif // MRT_INTERPRETER_EH_FRAMEINFO_H
