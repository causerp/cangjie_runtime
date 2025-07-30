// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_STACK_MANAGER_H
#define MRT_STACK_MANAGER_H

#include <map>

#include "Common/StackType.h"
#include "Common/TypeDef.h"
#include "StackMap/StackMap.h"
#include "UnwindStack/StackInfo.h"

namespace MapleRuntime {
class StackManager {
public:
    StackManager();
    ~StackManager() = default;

    // runtime required lifecycle interfaces
    void Init();
    void Fini() const;

    static uint64_t rtStartAddr;
    static uint64_t rtEndAddr;
    static uint64_t coreSoStartAddr;
    static uint64_t coreSoEndAddr;
    static uint64_t cjcSoStartAddr;
    static uint64_t cjcSoEndAddr;
    static uint64_t traceSoStartAddr;
    static uint64_t traceSoEndAddr;

    // debug interface for runtime to get all stack trace.
    static void PrintStackTrace(UnwindContext* unContext = nullptr);

    static void PrintSignalStackTrace(UnwindContext* unContext, uintptr_t pc, uintptr_t fa);

    static void PrintStackTraceForCpuProfile(UnwindContext* unContext, unsigned long long int cjThreadId);

    static void RecordLiteFrameInfos(std::vector<uint64_t>& liteFrameInfos, size_t steps = STACK_UNWIND_STEP_MAX);

    static void GetStackTraceByLiteFrameInfos(const std::vector<uint64_t>& liteFrameInfos,
                                              std::vector<StackTraceElement>& stackTrace);

    static void GetStackTraceByLiteFrameInfo(const uint64_t ip, const uint64_t pc, const uint64_t fa,
                                             StackTraceElement& ste);

    // visit GC roots of current managed thread for tracing GC.
    static void VisitStackRoots(const UnwindContext& topFrame, const RootVisitor& func, Mutator& mutator);
    static void VisitHeapReferencesOnStack(const UnwindContext& topFrame, const RootVisitor& rootVisitor,
                                           const DerivedPtrVisitor& derivedPtrVisitor, Mutator& mutator);

    static void VisitStackPtrMap(const UnwindContext& topFrame, const StackPtrVisitor& traceAndFixPtrVisitor,
                                 const StackPtrVisitor& fixPtrVisitor, const DerivedPtrVisitor& derivedPtrVisitor,
                                 Mutator& mutator);

    static void InitStackGrowConfig();
#if defined(MRT_DEBUG) && (MRT_DEBUG == 1)
    static std::vector<FrameInfo> GetCurrentStack(StackMode mode);
#endif

    static bool IsRuntimeFrame(Uptr pc);
    friend class MachineFrame;

private:
    // Initialize the so load address defined below.
    void InitAddressScope();
};

void InitAddressScopeForCJthreadTrace();

} // namespace MapleRuntime

#endif // MRT_STACK_MANAGER_H
