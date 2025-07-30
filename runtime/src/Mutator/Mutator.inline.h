// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_MUTATOR_INLINE_H
#define MRT_MUTATOR_INLINE_H

#include "MutatorManager.h"

namespace MapleRuntime {
inline void Mutator::DoEnterSaferegion()
{
    // set current mutator in saferegion.
    SetInSaferegion(SAFE_REGION_TRUE);
}

inline bool Mutator::EnterSaferegion(bool updateUnwindContext) noexcept
{
    if (LIKELY(!InSaferegion())) {
        // When the status is risky, no update is required. Because
        // valid information is already stored in the context.
        if (updateUnwindContext && uwContext.GetUnwindContextStatus() != UnwindContextStatus::RISKY) {
            UpdateUnwindContext();
        }
        DoEnterSaferegion();
        return true;
    }
    return false;
}

inline bool Mutator::LeaveSaferegion() noexcept
{
    if (LIKELY(InSaferegion())) {
        DoLeaveSaferegion();
        return true;
    }
    return false;
}

// Ensure that mutator phase is changed only once by mutator itself or GC
__attribute__((always_inline)) inline bool Mutator::TransitionGCPhase(bool bySelf)
{
    do {
        GCPhaseTransitionState state = transitionState.load();
        // If this mutator phase transition has finished, just return
        if (state == FINISH_TRANSITION) {
            bool result = mutatorPhase.load() == Heap::GetHeap().GetGCPhase();
            if (!bySelf && !result) { // why check bySelf?
                LOG(RTLOG_FATAL, "gc transition mutator %p (phase %u) to gc phase %u failed",
                    this, mutatorPhase.load(), Heap::GetHeap().GetGCPhase());
            }
            return result;
        }

        // If this mutator is executing phase transition by other thread, mutator should wait but GC just return
        if (state == IN_TRANSITION) {
            if (bySelf) {
                WaitForPhaseTransition();
                return true;
            } else {
                return false;
            }
        }

        if (!bySelf && state == NO_TRANSITION) {
            return true;
        }

        // Current thread set atomic variable to ensure atomicity of phase transition
        CHECK(state == NEED_TRANSITION);
        if (transitionState.compare_exchange_weak(state, IN_TRANSITION)) {
            TransitionToGCPhaseExclusive(Heap::GetHeap().GetGCPhase());
            transitionState.store(FINISH_TRANSITION, std::memory_order_release);
            return true;
        }
    } while (true);
}

// Ensure that mutator is changed only once by mutator itself or Profile
__attribute__((always_inline)) inline bool Mutator::TransitionToCpuProfile(bool bySelf)
{
    do {
        CpuProfileState state = cpuProfileState.load();
        // If this mutator profile has finished, just return
        if (state == FINISH_CPUPROFILE) {
            return true;
        }
        // If this mutator is executing profile by other thread, mutator should wait but profile just return
        if (state == IN_CPUPROFILING) {
            if (bySelf) {
                WaitForCpuProfiling();
                return true;
            } else {
                return false;
            }
        }
        if (!bySelf && state == NO_CPUPROFILE) {
            return true;
        }
        // Current thread set atomic variable to ensure atomicity of phase transition
        CHECK(state == NEED_CPUPROFILE);
        if (cpuProfileState.compare_exchange_weak(state, IN_CPUPROFILING)) {
            TransitionToCpuProfileExclusive();
            cpuProfileState.store(FINISH_CPUPROFILE, std::memory_order_release);
            return true;
        }
    } while (true);
}
} // namespace MapleRuntime

#endif // MRT_MUTATOR_INLINE_H
