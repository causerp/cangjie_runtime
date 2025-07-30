// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "UnwindCApi.h"

#include "Mutator/Mutator.inline.h"
#ifdef _WIN64
#include "UnwindWin.h"
#endif
#if defined(__x86_64__)
extern uintptr_t unwindPCForC2NStub;
#endif

namespace MapleRuntime {
extern "C" void MRT_RestoreTopManagedContextFromN2CStub(FrameAddress* fa)
{
    UnwindContext& uwContext = Mutator::GetMutator()->GetUnwindContext();
    N2CSlotData* slotData = N2CFrame::GetSlotData(fa);
    uwContext.frameInfo.mFrame.SetIP(slotData->pc);
    uwContext.frameInfo.mFrame.SetFA(slotData->fa);
    uwContext.SetUnwindContextStatus(slotData->status);
}

extern "C" void MRT_SaveTopManagedContextToN2CStub(FrameAddress* fa)
{
    UnwindContext& uwContext = Mutator::GetMutator()->GetUnwindContext();
    N2CSlotData* slotData = N2CFrame::GetSlotData(fa);
    slotData->pc = uwContext.frameInfo.mFrame.GetIP();
    slotData->fa = uwContext.frameInfo.mFrame.GetFA();
    // By default, all caller functions that pass through N2CStub are risky types
    // and need to use the data on the slot to unwind.
    slotData->status = uwContext.GetUnwindContextStatus();
    uwContext.GoIntoManagedCode();
}

extern "C" void MRT_SaveC2NContext(const uint32_t* pc, void* fa, ThreadLocalData* tlData)
{
    UnwindContext& uwContext = tlData->mutator->GetUnwindContext();
    uwContext.GoIntoNativeCode(pc, fa);
}

extern "C" void MRT_DeleteC2NContext(ThreadLocalData* tlData)
{
    if (UNLIKELY(tlData == nullptr)) {
        return;
    }
    Mutator* mutator = tlData->mutator;
    if (UNLIKELY(mutator == nullptr)) {
        return;
    }
    UnwindContext& uwContext = mutator->GetUnwindContext();
    uwContext.GoIntoManagedCode();
}

extern "C" void MRT_UpdateUwContext(const uint32_t* pc, void* fa, UnwindContextStatus status, ThreadLocalData* tlData)
{
    UnwindContext& uwContext = tlData->mutator->GetUnwindContext();
    uwContext.frameInfo.mFrame.SetIP(pc);
    uwContext.frameInfo.mFrame.SetFA(reinterpret_cast<FrameAddress*>(fa));
    uwContext.SetUnwindContextStatus(status);
}

extern "C" void MRT_PreRunManagedCode(Mutator* mutator, int layers, ThreadLocalData* threadData)
{
    if (UNLIKELY(MutatorManager::Instance().SyncTriggered())) {
        mutator->SetSuspensionFlag(Mutator::SuspensionType::SUSPENSION_FOR_SYNC);
        mutator->EnterSaferegion(false);
    }
    mutator->SetManagedContext(true);
    mutator->LeaveSaferegion();
#ifdef _WIN64
    Runtime& runtime = Runtime::Current();
    WinModuleManager& winModuleManager = runtime.GetWinModuleManager();
    Uptr rip = 0;
    Uptr rsp = 0;
    GetContextWin64(&rip, &rsp);
    FrameInfo curFrame = GetCurFrameInfo(winModuleManager, rip, rsp);
    UnwindContextStatus ucs = UnwindContextStatus::UNKNOWN;
    FrameInfo callerFrame = GetCallerFrameInfo(winModuleManager, curFrame.mFrame, ucs);

    UnwindContext& uwContext = Mutator::GetMutator()->GetUnwindContext();
    uwContext.anchorFA = reinterpret_cast<uint32_t*>(callerFrame.mFrame.GetFA());

    for (int i = 0; i < layers; ++i) {
        callerFrame = GetCallerFrameInfo(winModuleManager, callerFrame.mFrame, ucs);
        uwContext.anchorFA = reinterpret_cast<uint32_t*>(callerFrame.mFrame.GetFA());
    }
#else
    UnwindContext& uwContext = mutator->GetUnwindContext();
    // current function fa
    void* fa = __builtin_frame_address(0);
    uwContext.anchorFA = reinterpret_cast<uint32_t*>(reinterpret_cast<FrameAddress*>(fa)->callerFrameAddress);

    for (int i = 0; i < layers; ++i) {
        uwContext.anchorFA =
            reinterpret_cast<uint32_t*>(reinterpret_cast<FrameAddress*>(uwContext.anchorFA)->callerFrameAddress);
    }
#endif
    uwContext.GoIntoManagedCode();
    mutator->SetMutatorPhase(Heap::GetHeap().GetGCPhase());
    mutator->InitStackInfo(threadData);
}
} // namespace MapleRuntime
