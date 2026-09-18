// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#ifndef MRT_LOCAL_OBJECT_ALLOCATOR_H
#define MRT_LOCAL_OBJECT_ALLOCATOR_H

#include <cstddef>

#include "Common/BaseObject.h"
#include "Common/TypeDef.h"

namespace MapleRuntime {
struct FrameAddress;
class Mutator;
class RegionInfo;
class RegionManager;

// Abstracts local object allocation from the backing storage.
// A local region is a lifetime boundary. A backend may allocate one or more
// non-contiguous backing blocks/arenas inside the same local region, and
// EndRegion must reclaim all allocations made since the matching StartRegion.
class LocalObjectAllocator {
public:
    static LocalObjectAllocator* InitLocalObjectAllocator(RegionManager& regionManager);

    virtual ~LocalObjectAllocator() = default;

    // Starts a local allocation region for the mutator. The backend owns any
    // region metadata it stores in Mutator.
    virtual bool StartRegion(Mutator& mutator, FrameAddress* ownerFA) = 0;

    // Ends the current local allocation region and releases all local objects
    // allocated in that region.
    virtual void EndRegion(Mutator& mutator, FrameAddress* ownerFA) = 0;

    // Ends all local allocation regions owned by a managed frame during exception unwind.
    virtual void EndRegionsForFrame(Mutator& mutator, FrameAddress* ownerFA) = 0;

    // Allocates an object payload block in the current local region. Returns 0 on
    // allocation failure.
    virtual MAddress Allocate(Mutator& mutator, size_t size) = 0;

    // Returns bytes occupied by live local objects in the tracing heap address
    // space. Native-backed local objects return 0. This value is used only for
    // heap-capacity/GC allocation decisions and is not part of tracing-heap live bytes.
    virtual size_t GetHeapAllocatedBytes() const = 0;

    // Returns bytes handed out to live local objects across all mutators,
    // regardless of the backing storage. This is the value reported by the
    // memory info API (getAllocatedLocalObjectSize) and is not part of
    // getAllocatedHeapSize.
    virtual size_t GetAllocatedObjectBytes() const = 0;

    // Registers an object whose finalizer should run before the current local
    // region is reclaimed.
    virtual void AddFinalizer(Mutator& mutator, BaseObject* obj) = 0;

    // Finalizes and removes a registered object when the compiler determines
    // that its local live range has ended.
    virtual void RemoveFinalizer(Mutator& mutator, BaseObject* obj) = 0;

    // Registers a local object that contains references to heap objects.
    virtual void AddLocalRoot(Mutator& mutator, BaseObject* obj) = 0;

    // Visits heap reference fields reachable from local allocator owned local objects.
    virtual void VisitLocalObjectRefFields(Mutator& mutator, const RootVisitor& visitor) = 0;

    // Releases all per-mutator resources (regions, caches, metadata) when the
    // mutator is destroyed or reset. Regions still alive at this point (e.g.
    // abnormal thread exit) are reclaimed without running finalizers, because
    // running user code during teardown can re-enter the runtime.
    virtual void OnMutatorExit(Mutator& mutator) = 0;
};
} // namespace MapleRuntime

#endif // MRT_LOCAL_OBJECT_ALLOCATOR_H
