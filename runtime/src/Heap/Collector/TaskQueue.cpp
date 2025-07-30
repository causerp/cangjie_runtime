// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "TaskQueue.h"

#include "CollectorProxy.h"
#ifdef COV_SIGNALHANDLE
extern "C" void __gcov_flush(void);
#endif
namespace MapleRuntime {

bool GCExecutor::Execute(void* owner)
{
    MRT_ASSERT(owner != nullptr, "task queue owner ptr should not be null!");
    CollectorProxy* collectorProxy = reinterpret_cast<CollectorProxy*>(owner);

    switch (taskType) {
        case GCTask::TaskType::TASK_TYPE_TERMINATE_GC: {
            return false;
        }
        case GCTask::TaskType::TASK_TYPE_TIMEOUT_GC: {
            uint64_t curTime = TimeUtil::NanoSeconds();
            if ((curTime - GCStats::GetPrevGCStartTime()) > CangjieRuntime::GetGCParam().backupGCInterval) {
                GCStats::SetPrevGCStartTime(curTime);
                collectorProxy->RunGarbageCollection(GCTask::ASYNC_TASK_INDEX, GC_REASON_BACKUP);
                GCStats::SetPrevGCFinishTime(TimeUtil::NanoSeconds());
            }
            break;
        }
        case GCTask::TaskType::TASK_TYPE_INVOKE_GC: {
            GCStats::SetPrevGCStartTime(TimeUtil::NanoSeconds());
            collectorProxy->RunGarbageCollection(taskIndex, gcReason);
            GCStats::SetPrevGCFinishTime(TimeUtil::NanoSeconds());
            break;
        }
        case GCTask::TaskType::TASK_TYPE_DUMP_HEAP: {
            CjHeapData* cjHeapData = new CjHeapData();
            if (cjHeapData != nullptr) {
                cjHeapData->DumpHeap();
                delete cjHeapData;
            } else {
                LOG(RTLOG_ERROR, "cjHeapData Init Failed");
            }
#ifdef COV_SIGNALHANDLE
            __gcov_flush();
#endif
            break;
        }
        case GCTask::TaskType::TASK_TYPE_DUMP_HEAP_IDE: {
#if defined(__OHOS__) && (__OHOS__ == 1)
            CjHeapDataForIDE* heapSnapshotJSONSerializer = new CjHeapDataForIDE();
            if (heapSnapshotJSONSerializer != nullptr) {
                heapSnapshotJSONSerializer->Serialize();
                delete heapSnapshotJSONSerializer;
            } else {
                LOG(RTLOG_ERROR, "heapSnapshotJSONSerializer Init Failed");
            }
            break;
#endif
        }

        case GCTask::TaskType::TASK_TYPE_DUMP_HEAP_OOM: {
            CjHeapData* cjHeapData = new CjHeapData(true);
            if (cjHeapData != nullptr) {
                cjHeapData->DumpHeap();
                delete cjHeapData;
            } else {
                LOG(RTLOG_ERROR, "cjHeapData Init Failed");
            }
#ifdef COV_SIGNALHANDLE
            __gcov_flush();
#endif
            break;
        }
        default:
            LOG(RTLOG_ERROR, "[GC] Error task type: %u ignored!", static_cast<uint32_t>(taskType));
            break;
    }
    return true;
}
} // namespace MapleRuntime