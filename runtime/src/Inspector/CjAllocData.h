// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_CJ_ALLOC_DATA_H
#define MRT_CJ_ALLOC_DATA_H
#include "UnwindStack/GcStackInfo.h"
#include "CjHeapData.h"
#include "HeapSnapshotJsonSerializer.h"
namespace MapleRuntime {
struct TraceFunctionInfo {
    CString functionName;
    CString scriptName;
    CString url = "";
    int32_t line;
    int32_t column = -1;
};

struct TraceNodeField {
    int32_t id = 0; // Unique ID
    int32_t functionInfoIndex;
    int32_t selfSize;
    std::vector<TraceNodeField*> children;
};

struct Sample {
    int32_t size;
    int32_t nodeId;
    int32_t orinal;
};

class CjAllocData {
public:
    static CjAllocData* GetCjAllocData();
    static void SetCjAllocData();
    TraceNodeField* FindNode(const FrameAddress*, const char*);
    int32_t FindKey(const FrameAddress*, const char*);
    void DeleteCjAllocData();
    bool IsRecording() { return recording.load();};
    void SetRecording(bool isRecording) { recording.store(isRecording, std::memory_order_release);};
    void DeleteAllNode(TraceNodeField* node);
    void SerializeCjAllocData();
    void SerializeSamples();
    void SerializeCallFrames();
    void SerializeStats();
    void SerializeFunctionInfo(int32_t idx);
    void SerializeEachFrame(TraceNodeField* node);
    void InitAllocParam();
    void InitRoot();
    void RecordAllocNodes(const TypeInfo* klass, MSize size);
    int32_t SetNodeID() { return ++traceNodeID;};
    friend class AllocStackInfo;
private:
    std::unordered_map<int32_t, TraceNodeField*> traceNodeMap;
    TraceNodeField* traceNodeHead; // ROOT node
    std::vector<Sample*> samples;
    std::vector<TraceFunctionInfo*> traceFunctionInfo;
    int32_t sampSize;
    int32_t allocSize;
    int32_t traceNodeID = 0;
    StreamWriter* writer = nullptr;
    std::atomic<bool> recording{false};
    std::mutex sharedMtx;
};

class AllocStackInfo : public GCStackInfo {
public:
    int32_t ProcessTraceInfo(FrameInfo &frame);
    void ProcessTraceNode(TraceNodeField* head, MSize allocSize);
    void ProcessStackTrace(MSize size);
private:
    std::stack<FrameInfo* > frames;
};
 
} // namespace MapleRuntime
#endif