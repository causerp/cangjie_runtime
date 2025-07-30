// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_COLLECTOR_RESOURCES_H
#define MRT_COLLECTOR_RESOURCES_H

#include "Base/Macros.h"
#include "FinalizerProcessor.h"
#include "Heap/Collector/TaskQueue.h"
#include "Heap/GcThreadPool.h"
#include "Inspector/CjHeapData.h"
#include "TaskQueue.h"

namespace MapleRuntime {
class CollectorProxy;
// CollectorResources provides the resources that a functional collector need,
// such as gc thread/threadPool, gc task queue...
class CollectorResources {
public:
    // the collector thread entry routine.
    MRT_EXPORT static void* GCMainThreadEntry(void* arg);

    // a collectorResources without a collector entity is functionless
    explicit CollectorResources(CollectorProxy& proxy) : collectorProxy(proxy) {}
    ATTR_NO_INLINE virtual ~CollectorResources() = default;

    void Init();
    void Fini();
    void StopGCWork();
    void RequestGC(GCReason reason, bool async);
    void WaitForGCFinish();
    // gc main loop
    void RunTaskLoop();
    // Notify that GC has finished.
    // Must be called by gc thread only
    void NotifyGCFinished(uint64_t gcIndex);
    int32_t GetGCThreadCount(const bool isConcurrent) const;

    GCThreadPool* GetThreadPool() const { return gcThreadPool; }

    bool IsHeapMarked() const { return isHeapMarked; }

    void SetHeapMarked(bool value) { isHeapMarked = value; }

    bool IsGcStarted() const { return isGcStarted.load(std::memory_order_relaxed); }

    void SetGcStarted(bool val) { isGcStarted.store(val, std::memory_order_relaxed); }

    bool IsGCActive() const { return Heap::GetHeap().IsGCEnabled() && isGCActive.load(std::memory_order_relaxed); }

    FinalizerProcessor& GetFinalizerProcessor() { return finalizerProcessor; }

    void BroadcastGCCompletion();
    GCStats& GetGCStats() { return gcStats; }
    void RequestHeapDump(GCTask::TaskType gcTask);

private:
    void StartGCThreads();
    void TerminateGCTask();
    void StopGCThreads();
    // Notify the GC thread to start GC, and doesn't wait.
    // Called by mutator.
    // reason: The reason for this GC.
    void RequestAsyncGC(GCReason reason);
    void RequestGCAndWait(GCReason reason);
    void PostIgnoredGcRequest(GCReason reason);

    // the thread pool for parallel tracing.
    GCThreadPool* gcThreadPool = nullptr;
    int32_t gcThreadCount = 1;
    TaskQueue<GCExecutor>* taskQueue = nullptr;

    // the collector thread handle.
    pthread_t gcMainThread = 0;
    std::atomic<pid_t> gcTid{ 0 };
    std::atomic<bool> gcThreadRunning = { false };
    // finishedGcIndex records the currently finished gcIndex
    // may be read by mutator but only be written by gc thread sequentially
    std::atomic<uint64_t> finishedGcIndex = { 0 };
    // protect condition_variable gcFinishedCondVar's status.
    std::mutex gcFinishedCondMutex;
    // notified when GC finished, requires gcFinishedCondMutex
    std::condition_variable gcFinishedCondVar;

    // Indicate whether GC is already started.
    // NOTE: When GC finishes, it clears isGcStarted, must be over-written only by gc thread.
    std::atomic<bool> isGcStarted = { false };

    // a switch to disable gc for hotupdate.
    std::atomic<bool> isGCActive = { true };

    // only gc thread can access it, so we don't use atomic type
    bool isHeapMarked = false;
    // Represent the number of returned raw pointer
    std::atomic<int> criticalNum{ 0 };
    int gcWorking = 0;
#if defined(_WIN64) || defined(__APPLE__)
    std::condition_variable gcWorkingCV;
    std::mutex gcWorkingMtx;
    __attribute__((always_inline)) inline void WaitUntilGCDone()
    {
        std::unique_lock<std::mutex> gcWorkingLck(gcWorkingMtx);
        gcWorkingCV.wait(gcWorkingLck);
    }

    __attribute__((always_inline)) inline void WakeWhenGCDone()
    {
        std::unique_lock<std::mutex> gcWorkingLck(gcWorkingMtx);
        gcWorkingCV.notify_all();
    }
#endif
    CollectorProxy& collectorProxy;
    FinalizerProcessor finalizerProcessor;
    GCStats gcStats;
};
} // namespace MapleRuntime
#endif // MRT_COLLECTOR_RESOURCES_H
