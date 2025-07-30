// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_CPU_PROFILER_H
#define MRT_CPU_PROFILER_H

#include <thread>
#include "SamplesRecord.h"

namespace MapleRuntime {
class CpuProfiler {
public:
    static CpuProfiler& GetInstance()
    {
        static CpuProfiler instance;
        return instance;
    }
    bool StartCpuProfilerForFile();
    bool StopCpuProfilerForFile(const int fd);
    SamplesRecord& GetGenerator() { return generator; }
    void TryStopSampling();

private:
    CpuProfiler() {}
    ~CpuProfiler();
    static void SamplingThread(SamplesRecord& generator);
    static void DoSampleStack();
    SamplesRecord generator;
    std::thread tid;
};
} // namespace MapleRuntime
#endif // MRT_CPU_PROFILER_H