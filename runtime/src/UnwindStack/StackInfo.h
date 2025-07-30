// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_STACKINFO_H
#define MRT_STACKINFO_H

#include <vector>

#include "Common/BaseObject.h"
#include "Common/StackType.h"

namespace MapleRuntime {
class Mutator;
class StackInfo {
public:
    explicit StackInfo(const UnwindContext* context = nullptr)
        : n2cCount(0), lastFrameType(FrameType::UNKNOWN), topContext(context), isReliableN2CStub(false)
    {
        if (context == nullptr) {
            anchorFA = GetAnchorFAFromMutatorContext();
        } else {
            anchorFA = context->anchorFA;
        }
        constexpr int presetStackLength = 32;
        stack.reserve(presetStackLength);
    }

    virtual ~StackInfo()
    {
        topContext = nullptr;
        anchorFA = nullptr;
    }

    // Check whether topContext is empty, if it is empty, initialize it.
    void CheckTopUnwindContextAndInit(UnwindContext& uwContext);

    bool IsN2CContext(const UnwindContext& uwContext) const;

    // Confirm a frameType of context.
    void AnalyseAndSetFrameType(UnwindContext& uwContext);

    std::vector<FrameInfo>& GetStack() { return stack; }

    // Function PC and startpc form one pair in liteFrameInfos
    // pc1 func1start pc2 func2start pc3 func3start ...
    void ExtractLiteFrameInfoFromStack(std::vector<uint64_t>& liteFrameInfos,
                                       size_t steps = STACK_UNWIND_STEP_MAX) const;

    static void GetStackTraceByLiteFrameInfos(const std::vector<uint64_t>& liteFrameInfos,
                                              std::vector<StackTraceElement>& stackTrace);
    static void GetStackTraceByLiteFrameInfo(const uint64_t ip, const uint64_t pc, const uint64_t fa,
                                             StackTraceElement& ste);
    virtual void FillInStackTrace() = 0;

    static const int NEED_FILTED_FLAG;

protected:
    // frame info stack vector
    std::vector<FrameInfo> stack;

    // native to cj counts
    uint32_t n2cCount;

    // Bottom fa mark
    uint32_t* anchorFA = nullptr;

    // callee frame type
    FrameType lastFrameType;
#ifdef _WIN64
    // Import UnwindContextStatus of Unwinding, it is different from status in the uwContext.
    UnwindContextStatus uwCtxStatus;
#endif

private:
    uint32_t* GetAnchorFAFromMutatorContext() const;
    // The top context can be passed in. If it is empty, it means to
    // unwind stack from the current state
    const UnwindContext* topContext;
    // n2cstub status
    bool isReliableN2CStub;
};

// Get current context frame info and fill to FrameInfo struct object.
#define MRT_UNW_GETCALLERFRAME(frame) \
    do { \
        void* ip = __builtin_return_address(0); \
        void* fa = __builtin_frame_address(0); \
        FrameAddress* thisFrame = reinterpret_cast<FrameAddress*>(fa); \
        (frame).mFrame.SetIP(reinterpret_cast<uint32_t*>(ip)); \
        (frame).mFrame.SetFA(thisFrame->callerFrameAddress); \
    } while (0)
} // namespace MapleRuntime
#endif // MRT_STACKINFO_H
