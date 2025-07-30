// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_HEAP_H
#define MRT_HEAP_H

#include <cstdlib>
#include <functional>

#include "Barrier/Barrier.h"
#include "Base/ImmortalWrapper.h"
#include "Collector/Collector.h"
#include "Common/BaseObject.h"
#include "RuntimeConfig.h"

#include <unordered_set>
namespace MapleRuntime {
class Allocator;
class AllocBuffer;
class FinalizerProcessor;
class CollectorResources;


class Heap {
public:
    static Heap& GetHeap();
    static Barrier& GetBarrier() { return **currentBarrierPtr; }

    // concurrent gc uses barrier to access heap.
    static bool UseBarrier() { return *currentBarrierPtr != stwBarrierPtr; }

    virtual void Init(const HeapParam& vmHeapParam) = 0;
    virtual void Fini() = 0;
    virtual bool IsSurvivedObject(const BaseObject*) const = 0;
    bool IsGarbage(const BaseObject* obj) const { return !IsSurvivedObject(obj); }

    virtual bool IsGcStarted() const = 0;
    virtual void WaitForGCFinish() = 0;

    virtual bool IsGCEnabled() const = 0;
    virtual void EnableGC(bool val) = 0;

    virtual MAddress Allocate(size_t size, AllocType allocType) = 0;

    virtual Collector& GetCollector() = 0;
    virtual Allocator& GetAllocator() = 0;
    /* to avoid misunderstanding, variant types of heap size are defined as followed:
     * |------------------------------ max capacity ---------------------------------|
     * |------------------------------ current capacity ------------------------|
     * |------------------------------ committed size -----------------------|
     * |------------------------------ used size -------------------------|
     * |------------------------------ allocated size -------------|
     * |------------------------------ net size ------------|
     * so that inequality size <= capacity <= max capacity always holds.
     */
    virtual size_t GetMaxCapacity() const = 0;

    // or current capacity: a continuous address space to help heap management such as GC.
    virtual size_t GetCurrentCapacity() const = 0;

    // already used by allocator, including memory block cached for speeding up allocation.
    // we measure it in OS page granularity because physical memory is occupied by page.
    virtual size_t GetUsedPageSize() const = 0;

    // total memory allocated for each allocation request, including memory fragment for alignment or padding.
    virtual size_t GetAllocatedSize() const = 0;

    virtual MAddress GetStartAddress() const = 0;
    virtual MAddress GetSpaceEndAddress() const = 0;

    // IsHeapAddress is a range-based check, used to quickly identify heap address,
    // assuming non-heap address never falls into this address range.
    static bool IsHeapAddress(MAddress addr) { return (addr >= heapStartAddr) && (addr < heapCurrentEnd); }

    static bool IsHeapAddress(const void* addr) { return IsHeapAddress(reinterpret_cast<MAddress>(addr)); }

    virtual void InstallBarrier(const GCPhase) = 0;

    virtual GCPhase GetGCPhase() const = 0;

    virtual void SetGCPhase(const GCPhase phase) = 0;

    virtual bool ForEachObj(const std::function<void(BaseObject*)>&, bool safe) const = 0;

    virtual void RegisterStaticRoots(Uptr, U32) = 0;

    virtual void UnregisterStaticRoots(Uptr, U32) = 0;

    virtual void VisitStaticRoots(const RefFieldVisitor& visitor) = 0;

    virtual ssize_t GetHeapPhysicalMemorySize() const = 0;

    virtual FinalizerProcessor& GetFinalizerProcessor() = 0;

    virtual CollectorResources& GetCollectorResources() = 0;

    virtual void RegisterAllocBuffer(AllocBuffer& buffer) = 0;

    virtual void StopGCWork() = 0;

    static void OnHeapCreated(MAddress startAddr)
    {
        heapStartAddr = startAddr;
        heapCurrentEnd = 0;
    }

    static void OnHeapExtended(MAddress newEnd) { heapCurrentEnd = newEnd; }

    virtual ~Heap() {}
    static Barrier** currentBarrierPtr; // record ptr for fast access
    static Barrier* stwBarrierPtr;      // record nonGC barrier
    static MAddress heapStartAddr;
    static MAddress heapCurrentEnd;
};
} // namespace MapleRuntime
#endif // MRT_HEAP_MANAGER_H
