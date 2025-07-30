// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "CpuProfiler.h"
#include "Mutator/MutatorManager.h"

namespace MapleRuntime {
CpuProfiler::~CpuProfiler()
{
    TryStopSampling();
}

bool CpuProfiler::StartCpuProfilerForFile()
{
    if (generator.GetIsStart()) {
        LOG(RTLOG_ERROR, "Start CpuProfiler repeatedly.");
        return false;
    }
    generator.SetIsStart(true);

    tid = std::thread(CpuProfiler::SamplingThread, std::ref(generator));
    if (!tid.joinable()) {
        LOG(RTLOG_ERROR, "Failed to create sampling thread.");
        return false;
    }
    return true;
}

bool CpuProfiler::StopCpuProfilerForFile(const int fd)
{
    if (!generator.GetIsStart()) {
        LOG(RTLOG_ERROR, "CpuProfiler is not in profiling");
        return false;
    }
    // Sample data will be dump before sampling thread exit.
    bool ret = generator.OpenFile(fd);
    if (!ret) {
        LOG(RTLOG_ERROR, "Open file failed");
    }
    TryStopSampling();
    return ret;
}

void CpuProfiler::TryStopSampling()
{
    if (!generator.GetIsStart()) {
        return;
    }
    // Set false to break the sampling loop.
    generator.SetIsStart(false);
    if (tid.joinable()) {
        tid.join();
    }
}

void CpuProfiler::SamplingThread(SamplesRecord& generator)
{
    generator.InitProfileInfo();
    uint32_t interval = generator.GetSamplingInterval();
    uint64_t startTime = SamplesRecord::GetMicrosecondsTimeStamp();
    generator.SetThreadStartTime(startTime);
    uint64_t endTime = startTime;
    while (generator.GetIsStart()) {
        startTime = SamplesRecord::GetMicrosecondsTimeStamp();
        int64_t ts = static_cast<int64_t>(interval) - static_cast<int64_t>(startTime - endTime);
        endTime = startTime;
        // when ts > 0, the time interval is less than the sampling interval.
        if (ts > 0) {
            usleep(ts);
            endTime = SamplesRecord::GetMicrosecondsTimeStamp();
        }
        DoSampleStack();
        generator.ParseSampleData(endTime);
        // Save the sampling data to profileInfo.
        generator.DoSingleTask(endTime);
    }
    // Traverse the task queue until all sampling data is saved to profileInfo.
    generator.RunTaskLoop();
    generator.SetSampleStopTime(SamplesRecord::GetMicrosecondsTimeStamp());
    generator.DumpProfileInfo();
    generator.ReleaseProfileInfo();
}

void CpuProfiler::DoSampleStack()
{
    MutatorManager::Instance().TransitionAllMutatorsToCpuProfile();
}
}