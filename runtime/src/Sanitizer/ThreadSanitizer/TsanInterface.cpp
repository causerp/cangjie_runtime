// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "TsanInterface.h"

#include "Base/Log.h"
#include "CJThreadRecorder.h"
#include "Sanitizer/SanitizerCompilerCalls.h"
#include "Sanitizer/SanitizerMacros.h"
#include "Sanitizer/SanitizerSymbols.h"
#include "schedule.h"

namespace MapleRuntime {
namespace Sanitizer {
using namespace std;
using RaceStateHandle = void*;
using RaceProcHandle = void*;

static void* g_tsanRuntimeSync = nullptr;
static bool g_initialized = false;
static CJThreadRecorder<RaceProcHandle> g_procState{};

void TsanInitialize()
{
    void* cjthread = CJThreadGetHandle();
    CHECK_DETAIL(cjthread != nullptr, "init cjthread is null.");
    CJThreadSetSanitizerContext(cjthread, REAL(__tsan_init)());
    g_initialized = true;
}

void TsanFinalize()
{
    REAL(__tsan_fini)();
}

void OnHeapAllocated(void* addr, size_t size)
{
    REAL(__tsan_init_shadow)(addr, size);
}

void OnHeapDeallocated(void*, size_t) {}

void TsanFree(void* addr, size_t size)
{
    REAL(__tsan_free)(__builtin_return_address(0), addr, size);
}

static inline RaceStateHandle CJThreadGetCurRaceState()
{
    void* cjthread = CJThreadGetHandle();
    if (cjthread == nullptr) {
        return nullptr;
    }
    return CJThreadGetSanitizerContext(cjthread);
}

void TsanAcquire()
{
    REAL(__tsan_acquire)(CJThreadGetCurRaceState(), &g_tsanRuntimeSync);
}

void TsanRelease(ReleaseType rm)
{
    TsanRelease(&g_tsanRuntimeSync, rm);
}

void TsanAcquire(const void* addr)
{
    REAL(__tsan_acquire)(CJThreadGetCurRaceState(), addr);
}

void TsanRelease(const void* addr, ReleaseType rm)
{
    RaceStateHandle rs = CJThreadGetCurRaceState();
    switch (rm) {
        case ReleaseType::K_RELEASE:
            REAL(__tsan_release)(rs, addr);
            break;
        case ReleaseType::K_RELEASE_MERGE:
            REAL(__tsan_release_merge)(rs, addr);
            break;
        case ReleaseType::K_RELEASE_ACQUIRE:
            REAL(__tsan_release_acquire)(rs, addr);
            break;
    }
}

void TsanFixShadow(const void* from, const void* to, size_t size)
{
    REAL(__tsan_fix_shadow)(from, to, size);
}

void TsanAllocObject(const void* addr, size_t size)
{
    void* pc = __builtin_return_address(0);
    REAL(__tsan_alloc)(pc, addr, size);
}

void TsanFuncEntry(const void* pc)
{
    REAL(__tsan_func_entry)(pc);
}

void TsanFuncExit()
{
    REAL(__tsan_func_exit)();
}

void TsanFuncRestoreContext(const void* pc)
{
    REAL(__tsan_func_restore_context)(pc);
}

void TsanWriteMemory(const void* addr, size_t size)
{
    REAL(__tsan_write)(__builtin_return_address(0), addr, size);
}

void TsanReadMemory(const void* addr, size_t size)
{
    REAL(__tsan_read)(__builtin_return_address(0), addr, size);
}

void TsanWriteMemoryRange(const void* addr, size_t size)
{
    REAL(__tsan_write_range)(__builtin_return_address(0), addr, size);
}

void TsanReadMemoryRange(const void* addr, size_t size)
{
    REAL(__tsan_read_range)(__builtin_return_address(0), addr, size);
}

void TsanCleanShadow(const void* addr, size_t size)
{
    REAL(__tsan_clean_shadow)(addr, size);
}

void TsanNewRaceState(void* cjthread, void* parent, const void* pc)
{
    if (parent == nullptr) {
        return;
    }

    RaceStateHandle pRaceState = CJThreadGetSanitizerContext(parent);
    if (pRaceState) {
        CJThreadSetSanitizerContext(cjthread, REAL(__tsan_state_create)(pRaceState, pc));
    }
}

void TsanDeleteRaceState(void* thread)
{
    REAL(__tsan_state_delete)(CJThreadGetSanitizerContext(thread));
    CJThreadSetSanitizerContext(thread, nullptr);
}

void TsanNewRaceProc(void* processor)
{
    g_procState.CreateThread(processor, REAL(__tsan_proc_create)());
}

extern "C" {
MRT_EXPORT void* CJ_MCC_TsanGetRaceProc(void)
{
    if (g_initialized) {
        void* processor = ProcessorGetHandle();
        return g_procState.GetDataFromThread(processor);
    } else {
        return nullptr;
    }
}

MRT_EXPORT void* CJ_MCC_TsanGetThreadState(void)
{
    if (g_initialized) {
        return CJThreadGetCurRaceState();
    } else {
        return nullptr;
    }
}

MRT_EXPORT void CJ_MCC_TsanWriteMemory(const void* addr, size_t size)
{
    REAL(__tsan_write)(__builtin_return_address(0), addr, size);
}

MRT_EXPORT void CJ_MCC_TsanReadMemory(const void* addr, size_t size)
{
    REAL(__tsan_read)(__builtin_return_address(0), addr, size);
}

MRT_EXPORT void CJ_MCC_TsanWriteMemoryRange(const void* addr, size_t size)
{
    REAL(__tsan_write_range)(__builtin_return_address(0), addr, size);
}

MRT_EXPORT void CJ_MCC_TsanReadMemoryRange(const void* addr, size_t size)
{
    REAL(__tsan_read_range)(__builtin_return_address(0), addr, size);
}
}
} // namespace Sanitizer
} // namespace MapleRuntime