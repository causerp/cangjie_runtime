// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_CJ_RUNTIME_H
#define MRT_CJ_RUNTIME_H

// Cangjie's Runtime
#include "Common/Runtime.h"
#include "RuntimeConfig.h"
#include "Base/Globals.h"
#include "Base/Log.h"
#include "schedule.h"

#include <unordered_map>
namespace MapleRuntime {
using ConcurrencyModelMap = std::unordered_map<void*, ConcurrencyModel*>;
// other compiler-oriented runtime functions are declared in compilerCalls.h
enum class StackGrowConfig {
    UNDEF = 0,
    STACK_GROW_OFF = 1,
    STACK_GROW_ON = 2,
};

class CangjieRuntime : private Runtime {
public:
    static void CreateAndInit(const RuntimeParam& runtimeParam);
    static void FiniAndDelete();
    void* CreateSubSchedulerAndInit(ScheduleType type = SCHEDULE_UI_THREAD);
    void* CreateSingleThreadScheduler();
    bool CheckSubSchedulerValid(void* scheduler);
    bool FiniSubScheduler(void* scheduler);
    static HeapParam GetHeapParam() { return Runtime::Current().GetRuntimeParam().heapParam; }
    void SetGCThreshold(uint64_t threshold) override
    {
        if (threshold == 0) {
            LOG(RTLOG_ERROR, "The threshold must be greater than 0.\n");
        } else {
            param.gcParam.gcThreshold = threshold * KB;
            LOG(RTLOG_INFO, "gcThreshold is set to %d KB.", threshold);
        }
    }
    static ConcurrencyParam GetConcurrencyParam() { return Runtime::Current().GetRuntimeParam().coParam; }
    static GCParam GetGCParam() { return Runtime::Current().GetRuntimeParam().gcParam; }
    static LogParam GetLogParam() { return Runtime::Current().GetRuntimeParam().logParam; }
    RuntimeParam GetRuntimeParam() const override { return param; }
    void SetCommandLinesArgs(int argc, const char* argv[])
    {
        commandLineArgs = new const char* [argc + 1]();
        size_t cstrLen = 0;
        for (int i = 0; i < argc; ++i) {
            cstrLen = strlen(argv[i]) + 1;
            commandLineArgs[i] = new const char[cstrLen]();
            CHECK_E(memcpy_s(const_cast<char*>(commandLineArgs[i]), cstrLen, argv[i], cstrLen) != EOK, "memcpy_s fail");
        }
    }

    const char** GetCommandLineArgs() { return commandLineArgs; }
    static StackGrowConfig stackGrowConfig;

protected:
    explicit CangjieRuntime(const RuntimeParam& runtimeParam);
    ~CangjieRuntime() override
    {
        if (commandLineArgs) {
            for (int i = 0; commandLineArgs[i]; ++i) {
                delete[] commandLineArgs[i];
            }
            delete[] commandLineArgs;
        }
    }

private:
    void Init();
    void Fini();

    RuntimeParam param;
    const char** commandLineArgs = nullptr;
    ConcurrencyModelMap subModelMap;
    std::mutex mtx;
};
} // namespace MapleRuntime
#endif // MRT_CJ_RUNTIME_H
