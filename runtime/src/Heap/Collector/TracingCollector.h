// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_COLLECTOR_TRACING_H
#define MRT_COLLECTOR_TRACING_H

#include <cstdint>
#include <map>

#include "Collector.h"
#include "CollectorResources.h"
#include "Common/MarkWorkStack.h"
#include "Heap/Allocator/RegionSpace.h"
#include "Heap/Collector/ForwardDataManager.h"
#include "Mutator/MutatorManager.h"

// set 1 to enable concurrent mark test.
#define MRT_TEST_CONCURRENT_MARK (false)

namespace MapleRuntime {
// number of nanoseconds in a microsecond.
constexpr uint64_t NS_PER_US = 1000;
constexpr uint64_t NS_PER_S = 1000000000;

// prefetch distance for mark.
#define MACRO_MARK_PREFETCH_DISTANCE 16    // this macro is used for check when pre-compiling.
constexpr int MARK_PREFETCH_DISTANCE = 16; // when it is changed, remember to change MACRO_MARK_PREFETCH_DISTANCE.

// Small queue implementation, for prefetching.
#define MRT_MAX_PREFETCH_QUEUE_SIZE_LOG 5UL
#define MRT_MAX_PREFETCH_QUEUE_SIZE (1UL << MRT_MAX_PREFETCH_QUEUE_SIZE_LOG)
#if MRT_MAX_PREFETCH_QUEUE_SIZE <= MACRO_MARK_PREFETCH_DISTANCE
#error Prefetch queue size must be strictly greater than prefetch distance.
#endif

class PrefetchQueue {
public:
    explicit PrefetchQueue(size_t d) : elems{ nullptr }, distance(d), tail(0), head(0) {}
    ~PrefetchQueue() {}
    inline void Add(BaseObject* objaddr)
    {
        size_t t = tail;
        elems[t] = objaddr;
        tail = (t + 1) & (MRT_MAX_PREFETCH_QUEUE_SIZE - 1UL);

        __builtin_prefetch(reinterpret_cast<void*>(objaddr), 0, PREFETCH_LOCALITY);
    }

    inline BaseObject* Remove()
    {
        size_t h = head;
        BaseObject* objaddr = elems[h];
        head = (h + 1) & (MRT_MAX_PREFETCH_QUEUE_SIZE - 1UL);

        return objaddr;
    }

    inline size_t Length() const { return (tail - head) & (MRT_MAX_PREFETCH_QUEUE_SIZE - 1UL); }

    inline bool Empty() const { return head == tail; }

    inline bool Full() const { return Length() == distance; }

private:
    static constexpr int PREFETCH_LOCALITY = 3;
    BaseObject* elems[MRT_MAX_PREFETCH_QUEUE_SIZE];
    size_t distance;
    size_t tail;
    size_t head;
}; // PrefetchQueue

// For managing gc roots
class StaticRootTable {
public:
    struct StaticRootArray {
        RefField<>* content[0];
    };

    StaticRootTable() { totalRootsCount = 0; }
    ~StaticRootTable() = default;
    void RegisterRoots(StaticRootArray* addr, U32 size);
    void UnregisterRoots(StaticRootArray* addr, U32 size);
    void VisitRoots(const RefFieldVisitor& visitor);

private:
    std::mutex gcRootsLock;                         // lock gcRootsBuckets
    std::map<StaticRootArray*, U32> gcRootsBuckets; // record gc roots entry of CFile
    USize totalRootsCount;
};

class MarkingWork;
class ConcurrentMarkingWork;

class TracingCollector : public Collector {
    friend MarkingWork;
    friend ConcurrentMarkingWork;

public:
    explicit TracingCollector(Allocator& allocator, CollectorResources& resources)
        : Collector(), theAllocator(allocator), collectorResources(resources)
    {}

    ~TracingCollector() override = default;
    virtual void PreGarbageCollection(bool isConcurrent);
    virtual void PostGarbageCollection(uint64_t gcIndex);

    static void VisitStackRoots(const RootVisitor& visitor, RegSlotsMap& regSlotsMap, const FrameInfo& frame,
                                Mutator& mutator);

    static void VisitHeapReferencesOnStack(const RootVisitor& rootVisitor, const DerivedPtrVisitor& derivedPtrVisitor,
                                           RegSlotsMap& regSlotsMap, const FrameInfo& frame, Mutator& mutator);

    static void RecordStubCalleeSaved(RegSlotsMap& regSlotsMap, Uptr fp);
    static void RecordStubAllRegister(RegSlotsMap& regSlotsMap, Uptr fp);
    // Types, so that we don't confuse root sets and working stack.
    // The policy is: we simply `push_back` into root set,
    // but we use Enqueue to add into work stack.
    using RootSet = MarkStack<BaseObject*>;
    using WorkStack = MarkStack<BaseObject*>;
    using WorkStackBuf = MarkStackBuf<BaseObject*>;

    void Init() override;
    void Fini() override;

#if defined(MRT_DEBUG) && (MRT_DEBUG == 1)
    void DumpRoots(LogType logType);
    void DumpHeap(const CString& tag);
    void DumpBeforeGC()
    {
        if (ENABLE_LOG(FRAGMENT)) {
            if (MutatorManager::Instance().WorldStopped()) {
                DumpHeap("before_gc");
            } else {
                ScopedStopTheWorld stw("dump before gc");
                DumpHeap("before_gc");
            }
        }
    }

    void DumpAfterGC()
    {
        if (ENABLE_LOG(FRAGMENT)) {
            if (MutatorManager::Instance().WorldStopped()) {
                DumpHeap("after_gc");
            } else {
                ScopedStopTheWorld stw("dump after gc");
                DumpHeap("after_gc");
            }
        }
    }
#endif

    bool ShouldIgnoreRequest(GCRequest& request) override { return request.ShouldBeIgnored(); }

    // live but not resurrected object.
    bool IsMarkedObject(const BaseObject* obj) const { return RegionSpace::IsMarkedObject(obj); }

    // live or resurrected object.
    inline bool IsSurvivedObject(const BaseObject* obj) const
    {
        return RegionSpace::IsMarkedObject(obj) || RegionSpace::IsResurrectedObject(obj);
    }

    virtual bool MarkObject(BaseObject* obj) const
    {
        bool marked = RegionSpace::MarkObject(obj);
        if (!marked) {
            reinterpret_cast<RegionSpace&>(theAllocator).CountLiveObject(obj);
            if (!fixReferences && RegionInfo::GetRegionInfoAt(reinterpret_cast<MAddress>(obj))->IsFromRegion()) {
                DLOG(TRACE, "marking tag w-obj %p<cls %p>+%zu", obj, obj->GetTypeInfo(), obj->GetSize());
            }
        }
        return marked;
    }

    virtual void EnumRefFieldRoot(RefField<>& ref, RootSet& rootSet) const {};
    virtual void TraceObjectRefFields(BaseObject* obj, WorkStack& workStack) { std::abort(); }
    virtual BaseObject* GetAndTryTagObj(BaseObject* obj, RefField<>& field) { std::abort(); }
    inline bool IsResurrectedObject(const BaseObject* obj) const { return RegionSpace::IsResurrectedObject(obj); }

    virtual bool ResurrectObject(BaseObject* obj)
    {
        bool resurrected = RegionSpace::ResurrentObject(obj);
        if (!resurrected) {
            reinterpret_cast<RegionSpace&>(theAllocator).CountLiveObject(obj);
            if (!fixReferences && RegionInfo::GetRegionInfoAt(reinterpret_cast<MAddress>(obj))->IsFromRegion()) {
                VLOG(REPORT, "resurrection tag w-obj %p<cls %p>+%zu", obj, obj->GetTypeInfo(), obj->GetSize());
            }
        }
        return resurrected;
    }

    Allocator& GetAllocator() const { return theAllocator; }

    bool IsHeapMarked() const { return collectorResources.IsHeapMarked(); }

    void SetHeapMarked(bool value) { collectorResources.SetHeapMarked(value); }

    void SetGcStarted(bool val) { collectorResources.SetGcStarted(val); }

    void RunGarbageCollection(uint64_t, GCReason) override = 0;

    void TransitionToGCPhase(const GCPhase phase, const bool)
    {
        MutatorManager::Instance().TransitionAllMutatorsToGCPhase(phase);
    }

    GCStats& GetGCStats() override { return collectorResources.GetGCStats(); }

    virtual void UpdateGCStats();
    virtual uint16_t GetCurrentTagID() { std::abort(); }

    static const size_t MAX_MARKING_WORK_SIZE;
    static const size_t MIN_MARKING_WORK_SIZE;

protected:
    void RequestGCInternal(GCReason reason, bool async) override { collectorResources.RequestGC(reason, async); }

    Allocator& theAllocator;

    // A collectorResources provides the resources that the tracing collector need,
    // such as gc thread/threadPool, gc task queue.
    // Also provides the resource access interfaces, such as invokeGC, waitGC.
    // This resource should be singleton and shared for multi-collectors
    CollectorResources& collectorResources;

    U32 snapshotFinalizerNum = 0;

    // reason for current GC.
    GCReason gcReason = GC_REASON_USER;

    // indicate whether to fix references (including global roots and reference fields).
    // this member field is useful for optimizing concurrent copying gc.
    bool fixReferences = false;

    std::atomic<size_t> markedObjectCount = { 0 };

    void ResetBitmap(bool heapMarked)
    {
        // if heap is marked and tracing result will be used during next gc, we should not reset liveInfo.
    }

    int32_t GetGCThreadCount(const bool isConcurrent) const
    {
        return collectorResources.GetGCThreadCount(isConcurrent);
    }

    inline WorkStack NewWorkStack() const
    {
        WorkStack workStack = WorkStack();
        return workStack;
    }

    inline void SetGCReason(const GCReason reason) { gcReason = reason; }

    GCThreadPool* GetThreadPool() const { return collectorResources.GetThreadPool(); }
    // enum all roots.
    void EnumAllRoots(GCThreadPool* threadPool, RootSet& rootSet);

    // let finalizerProcessor process finalizers, and mark resurrected if in stw gc
    virtual void ProcessFinalizers() {}
    // designed to mark resurrected finalizer, should not be call in stw gc
    virtual void DoResurrection(WorkStack& workStack);

    void MergeMutatorRoots(WorkStack& workStack);
    void DoEnumeration(WorkStack& workStack);
    void DoTracing(WorkStack& workStack);
    bool MarkSatbBuffer(WorkStack& workStack);

    // concurrent marking.
    void TracingImpl(WorkStack& workStack, bool parallel);

    bool AddConcurrentTracingWork(RootSet& rs);
    virtual void EnumAndTagRawRoot(ObjectRef& root, RootSet& rootSet) const { std::abort(); }

private:
    void ConcurrentReMark(WorkStack& remarkStack, bool parallel);
    void EnumMutatorRoot(ObjectPtr& obj, RootSet& rootSet) const;
    void EnumConcurrencyModelRoots(RootSet& rootSet) const;
    void EnumStaticRoots(RootSet& rootSet) const;
    void EnumFinalizerProcessorRoots(RootSet& rootSet) const;

    void VisitStaticRoots(const RefFieldVisitor& visitor) const;
    void VisitFinalizerRoots(const RootVisitor& visitor) const;
};
} // namespace MapleRuntime
#endif // MRT_COLLECTOR_TRACING_H
