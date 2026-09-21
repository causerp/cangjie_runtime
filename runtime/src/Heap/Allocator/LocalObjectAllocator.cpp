// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#include "Allocator/LocalObjectAllocator.h"

#include "Allocator/Allocator.h"
#include "Allocator/RegionInfo.h"
#include "Allocator/RegionManager.h"
#include "Base/Globals.h"
#include "Base/Log.h"
#include "Common/NativeAllocator.h"
#include "ExceptionManager.inline.h"
#include "Heap/Heap.h"
#include "Mutator/MutatorManager.h"
#include "Mutator/Mutator.h"
#include "ObjectModel/MObject.h"

#include <algorithm>
#include <atomic>
#include <cstdint>
#include <functional>
#include <limits>
#include <mutex>
#include <new>
#include <unordered_set>
#include <vector>

namespace MapleRuntime {
class LocalObjectRootRegistry {
public:
    // NOTE(localmode): replace std::function with a lightweight function_ref/template when this path is hot.
    using LocalObjectChecker = std::function<bool(BaseObject*)>;

    void AddFinalizer(BaseObject* obj);
    bool RunFinalizer(Mutator& mutator, BaseObject* obj);
    void AddLocalRoot(BaseObject* obj);
    void VisitLocalObjectRefFields(const RootVisitor& visitor, const LocalObjectChecker& isLocalObject,
                                   std::unordered_set<BaseObject*>& visited) const;
    bool RunPendingFinalizers(Mutator& mutator);

private:
    enum class FinalizerState : uint8_t {
        PENDING,
        RUNNING,
        DONE,
    };

    struct FinalizerEntry {
        BaseObject* obj;
        FinalizerState state;
    };

    void VisitOneLocalObject(BaseObject* obj, const RootVisitor& visitor, const LocalObjectChecker& isLocalObject,
                             std::unordered_set<BaseObject*>& visited) const;
    bool RunFinalizerAt(Mutator& mutator, size_t idx);

    // DONE entries retain the object identity to reject accidental re-registration,
    // but are not visited as roots and can be compacted if churn becomes measurable.
    std::vector<FinalizerEntry> finalizers;
    std::vector<BaseObject*> localRoots;
};

// Heap-backed local allocator. It preserves the current local region
// implementation while hiding RegionInfo stack manipulation behind
// LocalObjectAllocator.
class HeapLocalObjectAllocator final : public LocalObjectAllocator {
public:
    explicit HeapLocalObjectAllocator(RegionManager& regionManager) : regionManager(regionManager) {}
    ~HeapLocalObjectAllocator() override = default;

    bool StartRegion(Mutator& mutator, FrameAddress* ownerFA) override;
    void EndRegion(Mutator& mutator, FrameAddress* ownerFA) override;
    void EndRegionsForFrame(Mutator& mutator, FrameAddress* ownerFA) override;
    MAddress Allocate(Mutator& mutator, size_t size) override;
    size_t GetHeapAllocatedBytes() const override
    {
        return heapAllocatedBytes.load(std::memory_order_relaxed);
    }
    size_t GetAllocatedObjectBytes() const override
    {
        return heapAllocatedBytes.load(std::memory_order_relaxed);
    }
    void AddFinalizer(Mutator& mutator, BaseObject* obj) override;
    void RemoveFinalizer(Mutator& mutator, BaseObject* obj) override;
    void AddLocalRoot(Mutator& mutator, BaseObject* obj) override;
    void VisitLocalObjectRefFields(Mutator& mutator, const RootVisitor& visitor) override;
    void OnMutatorExit(Mutator& mutator) override;

private:
    struct LocalHeapFirstBlock;

    struct LocalHeapBlock {
        LocalHeapBlock(RegionInfo* region, LocalHeapBlock* prev, LocalHeapFirstBlock* firstBlock)
            : region(region), prev(prev), firstBlock(firstBlock) {}

        RegionInfo* region;
        LocalHeapBlock* prev;
        size_t allocatedBytes = 0;
        LocalHeapFirstBlock* firstBlock;
    };

    struct LocalHeapFirstBlock final : LocalHeapBlock {
        LocalHeapFirstBlock(RegionInfo* region, LocalHeapBlock* prev, FrameAddress* ownerFA)
            : LocalHeapBlock(region, prev, this), ownerFA(ownerFA) {}

        FrameAddress* ownerFA;
        LocalObjectRootRegistry rootRegistry;
    };

    LocalHeapBlock* GetBlockStackTop(const Mutator& mutator) const;
    void SetBlockStackTop(Mutator& mutator, LocalHeapBlock* block);
    bool PushBlock(Mutator& mutator, RegionInfo* region, bool firstOfRegion, FrameAddress* ownerFA);
    LocalHeapBlock* PopRegionBlocks(Mutator& mutator, FrameAddress* ownerFA);
    LocalHeapBlock* FindBlockOfObject(Mutator& mutator, BaseObject* obj);
    void RunLocalFinalizers(Mutator& mutator, FrameAddress* ownerFA);
    void RecordAllocation(LocalHeapBlock& block, size_t size);
    void RecordReclamation(const LocalHeapBlock& block);

    RegionManager& regionManager;
    std::atomic<size_t> heapAllocatedBytes = { 0 };
};

// Native-backed local allocator. It allocates one or more native arenas for
// each local region and identifies local objects by walking live region ranges.
// GC treats native local objects as scan sources and only visits heap reference
// fields reachable from them.
class NativeLocalObjectAllocator final : public LocalObjectAllocator {
public:
    NativeLocalObjectAllocator() = default;
    ~NativeLocalObjectAllocator() override = default;

    bool StartRegion(Mutator& mutator, FrameAddress* ownerFA) override;
    void EndRegion(Mutator& mutator, FrameAddress* ownerFA) override;
    void EndRegionsForFrame(Mutator& mutator, FrameAddress* ownerFA) override;
    MAddress Allocate(Mutator& mutator, size_t size) override;
    size_t GetHeapAllocatedBytes() const override { return 0; }
    size_t GetAllocatedObjectBytes() const override;
    void AddFinalizer(Mutator& mutator, BaseObject* obj) override;
    void RemoveFinalizer(Mutator& mutator, BaseObject* obj) override;
    void AddLocalRoot(Mutator& mutator, BaseObject* obj) override;
    void VisitLocalObjectRefFields(Mutator& mutator, const RootVisitor& visitor) override;
    void OnMutatorExit(Mutator& mutator) override;

private:
    struct LocalNativeFirstRegion;
    struct NativeMutatorLocalData;

    // Upper bound of detached default-sized region memory blocks kept per
    // mutator for reuse. Cached blocks are detached from the live region chain.
    static constexpr size_t nativeLocalRegionCacheCapacity = 8;

    struct LocalNativeRegion {
        LocalNativeRegion(MAddress base, size_t size, LocalNativeRegion* prev, LocalNativeFirstRegion* firstRegion)
            : base(base), cursor(base), end(base + size), size(size), prev(prev), firstRegion(firstRegion) {}
        MAddress base;
        MAddress cursor;
        MAddress end;
        size_t size;
        LocalNativeRegion* prev;
        MAddress largeObjectStart = 0;
        LocalNativeFirstRegion* firstRegion;
    };

    struct NativeMutatorLocalData {
        LocalNativeRegion* stackTop = nullptr;
        // Detached default-sized region memory blocks, reused by AllocateRegion
        // to avoid NativeAlloc/NativeFree churn. Accessed only by the owner
        // mutator thread. Blocks are freed for real when the cache overflows
        // and all at once on mutator exit.
        void* regionCache[nativeLocalRegionCacheCapacity] = {};
        size_t regionCacheCount = 0;
    };

    struct LocalNativeFirstRegion final : LocalNativeRegion {
        LocalNativeFirstRegion(MAddress base, size_t size, LocalNativeRegion* prev, FrameAddress* ownerFA,
                               NativeMutatorLocalData* ownerData)
            : LocalNativeRegion(base, size, prev, this), ownerFA(ownerFA), ownerData(ownerData) {}

        FrameAddress* ownerFA;
        NativeMutatorLocalData* ownerData;
        LocalObjectRootRegistry rootRegistry;
    };

    NativeMutatorLocalData* GetMutatorData(const Mutator& mutator) const;
    NativeMutatorLocalData* CreateMutatorData(Mutator& mutator);
    void* PopCachedRegionMemory(NativeMutatorLocalData& data);
    void PushCachedRegionMemory(NativeMutatorLocalData& data, void* memory);
    void FreeRegionCache(NativeMutatorLocalData& data);
    LocalNativeRegion* GetRegionStackTop(const Mutator& mutator) const;
    void SetRegionStackTop(Mutator& mutator, LocalNativeRegion* region);
    LocalNativeRegion* AllocateRegion(Mutator& mutator, size_t minSize, LocalNativeRegion* prev, bool firstOfRegion,
                                      FrameAddress* ownerFA);
    void FreeRegion(LocalNativeRegion* region);
    MAddress TryAllocateInRegion(LocalNativeRegion& region, size_t size);
    LocalNativeRegion* PopRegionChain(Mutator& mutator, FrameAddress* ownerFA);
    LocalNativeRegion* FindRegionOfObject(Mutator& mutator, BaseObject* obj);
    ALWAYS_INLINE LocalNativeRegion* FindRegionByAddress(LocalNativeRegion* top, MAddress addr) const
    {
        while (top != nullptr) {
            // Regions belonging to one local function share firstRegion and
            // occupy one contiguous segment in the stack-linked region chain.
            LocalNativeRegion* first = top->firstRegion;
            for (LocalNativeRegion* region = top;; region = region->prev) {
                if (IsAddressInRegion(addr, *region)) {
                    return region;
                }
                if (region == first) {
                    break;
                }
            }
            top = first->prev;
        }
        return nullptr;
    }
    bool IsAddressInRegion(MAddress addr, const LocalNativeRegion& region) const;
    void RegisterObject(MAddress obj, LocalNativeRegion& region);
    void RunLocalFinalizers(Mutator& mutator, FrameAddress* ownerFA);

    // The lock synchronizes mutator-data lifetime with rare all-mutator queries.
    mutable std::mutex activeMutatorDataMtx;
    std::vector<NativeMutatorLocalData*> activeMutatorData;
};

size_t NativeLocalObjectAllocator::GetAllocatedObjectBytes() const
{
    CHECK_DETAIL(MutatorManager::Instance().WorldStopped(),
                 "native local allocated bytes query requires STW");
    size_t total = 0;
    std::lock_guard<std::mutex> lock(activeMutatorDataMtx);
    for (NativeMutatorLocalData* data : activeMutatorData) {
        if (data == nullptr) {
            continue;
        }
        for (LocalNativeRegion* region = data->stackTop; region != nullptr; region = region->prev) {
            MAddress cursor = region->cursor;
            CHECK_DETAIL(cursor >= region->base, "native local region cursor is before base");
            size_t occupiedBytes = cursor - region->base;
            CHECK_DETAIL(total <= std::numeric_limits<size_t>::max() - occupiedBytes,
                         "native local allocated bytes overflow");
            total += occupiedBytes;
        }
    }
    return total;
}

namespace {
constexpr size_t DEFAULT_NATIVE_LOCAL_REGION_SIZE = 4 * KB;

void RunLocalObjectFinalizer(Mutator& mutator, BaseObject* obj)
{
    TypeInfo* classInfo = reinterpret_cast<MObject*>(obj)->GetTypeInfo();
    FuncRef finalizerMethod = classInfo->GetFinalizeMethod();
    CHECK_DETAIL(finalizerMethod != nullptr, "%p has no finalize method", obj);
    void (*finalizer)(BaseObject*, TypeInfo*) = reinterpret_cast<void (*)(BaseObject*, TypeInfo*)>(finalizerMethod);

    bool oldManagedContext = mutator.IsManagedContext();
    mutator.SetManagedContext(true);
    DLOG(FINALIZE, "tid %u finalize local object %p", mutator.GetTid(), obj);
    uintptr_t threadData = MapleRuntime::MRT_GetThreadLocalData();
    ExecuteCangjieStub(obj, obj->GetTypeInfo(), 0, reinterpret_cast<void*>(finalizer),
                       reinterpret_cast<void*>(threadData), 0);
    mutator.SetManagedContext(oldManagedContext);

    if (ExceptionManager::HasFatalException()) {
#if defined(MRT_DEBUG) && (MRT_DEBUG == 1)
        ExceptionManager::DumpException();
#endif
        LOG(RTLOG_FATAL, "FatalException happened in local finalizer");
    }
    ExceptionManager::ClearPendingException();
}
}

void LocalObjectRootRegistry::AddFinalizer(BaseObject* obj)
{
    if (obj == nullptr) {
        return;
    }
    for (const FinalizerEntry& entry : finalizers) {
        if (entry.obj == obj) {
            return;
        }
    }
    finalizers.push_back({ obj, FinalizerState::PENDING });
}

bool LocalObjectRootRegistry::RunFinalizer(Mutator& mutator, BaseObject* obj)
{
    if (obj == nullptr) {
        return false;
    }
    for (size_t idx = 0; idx < finalizers.size(); ++idx) {
        if (finalizers[idx].obj == obj) {
            return RunFinalizerAt(mutator, idx);
        }
    }
    return false;
}

void LocalObjectRootRegistry::AddLocalRoot(BaseObject* obj)
{
    if (obj == nullptr) {
        return;
    }
    for (BaseObject* localRoot : localRoots) {
        if (localRoot == obj) {
            return;
        }
    }
    localRoots.push_back(obj);
}

void LocalObjectRootRegistry::VisitLocalObjectRefFields(const RootVisitor& visitor,
                                                        const LocalObjectChecker& isLocalObject,
                                                        std::unordered_set<BaseObject*>& visited) const
{
    for (BaseObject* localRoot : localRoots) {
        VisitOneLocalObject(localRoot, visitor, isLocalObject, visited);
    }
    for (const FinalizerEntry& entry : finalizers) {
        if (entry.state != FinalizerState::DONE) {
            // RUNNING finalizers remain scan sources while user code executes,
            // so a re-entrant GC can still trace and update their heap fields.
            VisitOneLocalObject(entry.obj, visitor, isLocalObject, visited);
        }
    }
}

void LocalObjectRootRegistry::VisitOneLocalObject(BaseObject* obj, const RootVisitor& visitor,
                                                  const LocalObjectChecker& isLocalObject,
                                                  std::unordered_set<BaseObject*>& visited) const
{
    if (obj == nullptr || !visited.insert(obj).second) {
        return;
    }
    CHECK_DETAIL(isLocalObject(obj), "visit local object ref fields with non-local object %p", obj);
    obj->ForEachRefField([&visitor, &isLocalObject, &visited, this](RefField<>& field) {
        BaseObject* target = field.GetTargetObject();
        if (target == nullptr) {
            return;
        }
        if (isLocalObject(target)) {
            VisitOneLocalObject(target, visitor, isLocalObject, visited);
            return;
        }
        if (Heap::IsHeapAddress(target)) {
            visitor(reinterpret_cast<ObjectRef&>(field));
            return;
        }
        // NOTE(localmode): decide whether raw/native non-heap references are legal in local object fields.
        LOG(RTLOG_FATAL, "local object field references non-heap and non-local object %p", target);
    });
}

bool LocalObjectRootRegistry::RunPendingFinalizers(Mutator& mutator)
{
    bool ranFinalizer = false;
    for (size_t idx = 0; idx < finalizers.size(); ++idx) {
        if (finalizers[idx].state != FinalizerState::PENDING) {
            continue;
        }
        ranFinalizer = RunFinalizerAt(mutator, idx) || ranFinalizer;
    }
    return ranFinalizer;
}

bool LocalObjectRootRegistry::RunFinalizerAt(Mutator& mutator, size_t idx)
{
    CHECK_DETAIL(idx < finalizers.size(), "invalid local finalizer index %zu", idx);
    if (finalizers[idx].state != FinalizerState::PENDING) {
        return false;
    }

    BaseObject* finalizerObj = finalizers[idx].obj;
    finalizers[idx].state = FinalizerState::RUNNING;
    RunLocalObjectFinalizer(mutator, finalizerObj);

    // User code may register more finalizers and reallocate the vector, so use
    // the stable index instead of retaining a reference across the call.
    CHECK_DETAIL(idx < finalizers.size() && finalizers[idx].obj == finalizerObj,
                 "local finalizer registry changed running entry %p", finalizerObj);
    finalizers[idx].state = FinalizerState::DONE;
    return true;
}

LocalObjectAllocator* LocalObjectAllocator::InitLocalObjectAllocator(RegionManager& regionManager)
{
    (void)regionManager;
    // Native local regions are the production implementation. Keep the heap
    // allocator above for comparison and future fallback, but do not select it
    // through an environment variable.
    LocalObjectAllocator* localObjectAllocator = new (std::nothrow) NativeLocalObjectAllocator();
    VLOG(LOCAL_REGION, "use native local object allocator");
    CHECK_DETAIL(localObjectAllocator != nullptr, "new local object allocator failed");
    return localObjectAllocator;
}

bool HeapLocalObjectAllocator::StartRegion(Mutator& mutator, FrameAddress* ownerFA)
{
    RegionInfo* region = regionManager.AllocateLocalModeRegion();
    if (region == nullptr) {
        // todo gc or oom
        VLOG(LOCAL_REGION, "Start local object region failed, region is null");
        return false;
    }
    if (!PushBlock(mutator, region, true, ownerFA)) {
        regionManager.ReclaimLocalModeRegion(region);
        return false;
    }
    VLOG(LOCAL_REGION, "StartLocalRegion: mutator %p, region %p, ownerFA %p, size %zu, stackTop %p", &mutator,
         region, ownerFA, region->GetRegionSize(), GetBlockStackTop(mutator));
    return true;
}

void HeapLocalObjectAllocator::EndRegion(Mutator& mutator, FrameAddress* ownerFA)
{
    RunLocalFinalizers(mutator, ownerFA);
    LocalHeapBlock* headBlock = PopRegionBlocks(mutator, ownerFA);
    while (headBlock != nullptr) {
        LocalHeapBlock* del = headBlock;
        headBlock = headBlock->prev;
        VLOG(LOCAL_REGION, "CollectLocalGarbage: region %p, ownerFA %p", del->region, del->firstBlock->ownerFA);
        RecordReclamation(*del);
        regionManager.ReclaimLocalModeRegion(del->region);
        if (del->firstBlock == del) {
            delete static_cast<LocalHeapFirstBlock*>(del);
        } else {
            delete del;
        }
    }
}

void HeapLocalObjectAllocator::EndRegionsForFrame(Mutator& mutator, FrameAddress* ownerFA)
{
    if (ownerFA == nullptr) {
        return;
    }
    LocalHeapBlock* block = GetBlockStackTop(mutator);
    while (block != nullptr) {
        if (block->firstBlock->ownerFA != ownerFA) {
            return;
        }
        EndRegion(mutator, ownerFA);
        block = GetBlockStackTop(mutator);
    }
}

void HeapLocalObjectAllocator::OnMutatorExit(Mutator& mutator)
{
    // Reclaim blocks still alive (abnormal exit with local regions active).
    // Finalizers are not run here: this is called during thread teardown and
    // running user code would risk re-entering the runtime.
    LocalHeapBlock* block = GetBlockStackTop(mutator);
    while (block != nullptr) {
        LocalHeapBlock* del = block;
        block = block->prev;
        RecordReclamation(*del);
        regionManager.ReclaimLocalModeRegion(del->region);
        if (del->firstBlock == del) {
            delete static_cast<LocalHeapFirstBlock*>(del);
        } else {
            delete del;
        }
    }
    SetBlockStackTop(mutator, nullptr);
}

MAddress HeapLocalObjectAllocator::Allocate(Mutator& mutator, size_t size)
{
    MAddress addr = 0;
    LocalHeapBlock* block = GetBlockStackTop(mutator);
    if (UNLIKELY(block == nullptr)) {
        LOG(RTLOG_ERROR, "alloc heap local object without local object region");
        return 0;
    }

    addr = block->region->Alloc(size);
    if (addr != 0) {
        RecordAllocation(*block, size);
        VLOG(LOCAL_REGION,
             "AllocLocalMode in old region: mutator %p, regoin %p(isFirst %d), "
             "ownerFA %p, size %zu, stackTop %p, obj %p, objSize %zu",
             &mutator, block->region, block->firstBlock == block, block->firstBlock->ownerFA,
             block->region->GetRegionSize(),
             GetBlockStackTop(mutator), addr, size);
        return addr;
    }

    RegionInfo* region = regionManager.AllocateLocalModeRegion(size);
    if (region == nullptr) {
        DLOG(REGION, "cannot take a local mode region from heap");
        return 0;
    }
    if (!PushBlock(mutator, region, false, block->firstBlock->ownerFA)) {
        regionManager.ReclaimLocalModeRegion(region);
        return 0;
    }
    addr = region->Alloc(size);
    CHECK_DETAIL(addr != 0, "alloc local object failed");
    LocalHeapBlock* newBlock = GetBlockStackTop(mutator);
    CHECK_DETAIL(newBlock != nullptr && newBlock->region == region, "invalid local heap block for region %p", region);
    RecordAllocation(*newBlock, size);
    VLOG(LOCAL_REGION,
         "AllocLocalMode in new region: mutator %p, regoin %p(isFirst %d), "
         "ownerFA %p, size %zu, stackTop %p, obj %p, objSize %zu",
         &mutator, region, false, block->firstBlock->ownerFA, region->GetRegionSize(),
         GetBlockStackTop(mutator), addr, size);
    return addr;
}

void HeapLocalObjectAllocator::AddFinalizer(Mutator& mutator, BaseObject* obj)
{
    if (obj == nullptr) {
        return;
    }
    LocalHeapBlock* block = GetBlockStackTop(mutator);
    CHECK_DETAIL(block != nullptr, "add local finalizer without current local region: %p", obj);
    block->firstBlock->rootRegistry.AddFinalizer(obj);
    VLOG(LOCAL_REGION, "AddLocalFinalizer: mutator %p, block %p, obj %p", &mutator, block, obj);
}

void HeapLocalObjectAllocator::RemoveFinalizer(Mutator& mutator, BaseObject* obj)
{
    if (obj == nullptr) {
        return;
    }
    LocalHeapBlock* block = FindBlockOfObject(mutator, obj);
    if (block != nullptr && block->firstBlock->rootRegistry.RunFinalizer(mutator, obj)) {
        VLOG(LOCAL_REGION, "RemoveLocalFinalizer: mutator %p, block %p, obj %p", &mutator, block, obj);
    }
}

void HeapLocalObjectAllocator::AddLocalRoot(Mutator& mutator, BaseObject* obj)
{
    if (obj == nullptr) {
        return;
    }
    LocalHeapBlock* block = FindBlockOfObject(mutator, obj);
    CHECK_DETAIL(block != nullptr, "add local root with non-local object %p", obj);
    block->firstBlock->rootRegistry.AddLocalRoot(obj);
    VLOG(LOCAL_REGION, "AddLocalRoot: mutator %p, block %p, obj %p", &mutator, block, obj);
}

void HeapLocalObjectAllocator::VisitLocalObjectRefFields(Mutator& mutator, const RootVisitor& visitor)
{
    // NOTE(localmode): reuse a per-mutator scratch visited set to avoid allocating during every root visit.
    std::unordered_set<BaseObject*> visited;
    for (LocalHeapBlock* block = GetBlockStackTop(mutator); block != nullptr; block = block->prev) {
        if (block->firstBlock != block) {
            continue;
        }
        block->firstBlock->rootRegistry.VisitLocalObjectRefFields(
            visitor, [this, &mutator](BaseObject* obj) { return FindBlockOfObject(mutator, obj) != nullptr; },
            visited);
    }
}

HeapLocalObjectAllocator::LocalHeapBlock* HeapLocalObjectAllocator::GetBlockStackTop(const Mutator& mutator) const
{
    return reinterpret_cast<LocalHeapBlock*>(mutator.GetLocalObjectAllocatorData());
}

void HeapLocalObjectAllocator::SetBlockStackTop(Mutator& mutator, LocalHeapBlock* block)
{
    mutator.SetLocalObjectAllocatorData(block);
}

bool HeapLocalObjectAllocator::PushBlock(Mutator& mutator, RegionInfo* region, bool firstOfRegion,
                                         FrameAddress* ownerFA)
{
    LocalHeapBlock* prev = GetBlockStackTop(mutator);
    CHECK_DETAIL(firstOfRegion || prev != nullptr, "push non-first local heap block without active region");
    LocalHeapBlock* block = firstOfRegion ? static_cast<LocalHeapBlock*>(
        new (std::nothrow) LocalHeapFirstBlock(region, prev, ownerFA))
        : new (std::nothrow) LocalHeapBlock(region, prev, prev->firstBlock);
    if (block == nullptr) {
        VLOG(LOCAL_REGION, "push local heap block failed, region %p", region);
        return false;
    }
    SetBlockStackTop(mutator, block);
    return true;
}

HeapLocalObjectAllocator::LocalHeapBlock* HeapLocalObjectAllocator::PopRegionBlocks(
    Mutator& mutator, FrameAddress* ownerFA)
{
    LocalHeapBlock* curr = GetBlockStackTop(mutator);
    if (curr != nullptr && ownerFA != nullptr && curr->firstBlock->ownerFA != ownerFA) {
        LOG(RTLOG_FATAL, "end local heap region with mismatched frame: top ownerFA %p, target ownerFA %p",
            curr->firstBlock->ownerFA, ownerFA);
    }
    LocalHeapBlock* ret = curr;
    while (curr != nullptr) {
        LocalHeapBlock* prev = curr->prev;
        if (ownerFA != nullptr && curr->firstBlock->ownerFA != ownerFA) {
            LOG(RTLOG_FATAL, "local heap region crosses frame boundary: block ownerFA %p, target ownerFA %p",
                curr->firstBlock->ownerFA, ownerFA);
        }
        if (curr->firstBlock == curr) {
            SetBlockStackTop(mutator, prev);
            curr->prev = nullptr;
            break;
        }
        curr = prev;
    }
    return ret;
}

HeapLocalObjectAllocator::LocalHeapBlock* HeapLocalObjectAllocator::FindBlockOfObject(Mutator& mutator,
                                                                                      BaseObject* obj)
{
    if (obj == nullptr || !Heap::IsHeapAddress(obj)) {
        return nullptr;
    }
    RegionInfo* region = RegionInfo::GetRegionInfoAt(reinterpret_cast<MAddress>(obj));
    if (!region->IsLocalModeRegion()) {
        return nullptr;
    }
    for (LocalHeapBlock* block = GetBlockStackTop(mutator); block != nullptr; block = block->prev) {
        if (block->region == region) {
            return block;
        }
    }
    return nullptr;
}

void HeapLocalObjectAllocator::RunLocalFinalizers(Mutator& mutator, FrameAddress* ownerFA)
{
    LocalHeapBlock* block = GetBlockStackTop(mutator);
    if (block == nullptr) {
        return;
    }
    if (ownerFA != nullptr && block->firstBlock->ownerFA != ownerFA) {
        LOG(RTLOG_FATAL, "run local heap finalizers with mismatched frame: block ownerFA %p, target ownerFA %p",
            block->firstBlock->ownerFA, ownerFA);
    }
    while (block->firstBlock->rootRegistry.RunPendingFinalizers(mutator)) {
    }
}

void HeapLocalObjectAllocator::RecordAllocation(LocalHeapBlock& block, size_t size)
{
    CHECK_DETAIL(block.allocatedBytes <= std::numeric_limits<size_t>::max() - size,
                 "local heap block allocated bytes overflow");
    block.allocatedBytes += size;
    (void)heapAllocatedBytes.fetch_add(size, std::memory_order_relaxed);
}

void HeapLocalObjectAllocator::RecordReclamation(const LocalHeapBlock& block)
{
    size_t oldSize = heapAllocatedBytes.fetch_sub(block.allocatedBytes, std::memory_order_relaxed);
    CHECK_DETAIL(oldSize >= block.allocatedBytes,
                 "local heap allocated bytes underflow: old %zu, reclaimed %zu", oldSize, block.allocatedBytes);
}

bool NativeLocalObjectAllocator::StartRegion(Mutator& mutator, FrameAddress* ownerFA)
{
    LocalNativeRegion* region =
        AllocateRegion(mutator, DEFAULT_NATIVE_LOCAL_REGION_SIZE, GetRegionStackTop(mutator), true, ownerFA);
    if (region == nullptr) {
        VLOG(LOCAL_REGION, "Start native local object region failed");
        return false;
    }
    SetRegionStackTop(mutator, region);
    VLOG(LOCAL_REGION, "StartNativeLocalRegion: mutator %p, region %p, ownerFA %p, base %p, size %zu", &mutator,
         region, ownerFA, reinterpret_cast<void*>(region->base), region->size);
    return true;
}

void NativeLocalObjectAllocator::EndRegion(Mutator& mutator, FrameAddress* ownerFA)
{
    VLOG(LOCAL_REGION, "EndNativeLocalRegion: mutator %p, ownerFA %p", &mutator, ownerFA);
    LocalNativeRegion* currentRegion = GetRegionStackTop(mutator);
    if (currentRegion == nullptr) {
        LOG(RTLOG_WARNING, "end native local region without active region: mutator %p ownerFA %p", &mutator, ownerFA);
        return;
    }

    // Exception unwinding can be re-entered while a local finalizer is running.
    // In that case the EH frame being unwound may not own the current region.
    // Do not run finalizers or pop another frame's region in this situation.
    if (ownerFA != nullptr && currentRegion->firstRegion->ownerFA != ownerFA) {
        LOG(RTLOG_WARNING,
            "skip native local region end for mismatched frame: region ownerFA %p, target ownerFA %p",
            currentRegion->firstRegion->ownerFA, ownerFA);
        return;
    }
    RunLocalFinalizers(mutator, ownerFA);
    LocalNativeRegion* headRegion = PopRegionChain(mutator, ownerFA);
    if (headRegion == nullptr) {
        return;
    }
    while (headRegion != nullptr) {
        LocalNativeRegion* del = headRegion;
        headRegion = headRegion->prev;
        FreeRegion(del);
    }
}

void NativeLocalObjectAllocator::EndRegionsForFrame(Mutator& mutator, FrameAddress* ownerFA)
{
    if (ownerFA == nullptr) {
        return;
    }
    LocalNativeRegion* region = GetRegionStackTop(mutator);
    while (region != nullptr) {
        if (region->firstRegion->ownerFA != ownerFA) {
            return;
        }
        EndRegion(mutator, ownerFA);
        region = GetRegionStackTop(mutator);
    }
}

MAddress NativeLocalObjectAllocator::Allocate(Mutator& mutator, size_t size)
{
    LocalNativeRegion* region = GetRegionStackTop(mutator);
    if (UNLIKELY(region == nullptr)) {
        LOG(RTLOG_ERROR, "alloc native local object without local object region");
        return 0;
    }

    MAddress addr = TryAllocateInRegion(*region, size);
    if (addr == 0) {
        region = AllocateRegion(mutator, size, region, false, region->firstRegion->ownerFA);
        if (region == nullptr) {
            DLOG(REGION, "cannot allocate native local object region");
            return 0;
        }
        SetRegionStackTop(mutator, region);
        addr = TryAllocateInRegion(*region, size);
    }

    CHECK_DETAIL(addr != 0, "alloc native local object failed");
    RegisterObject(addr, *region);
    VLOG(LOCAL_REGION, "AllocNativeLocalObject: mutator %p, region %p(isFirst %d), ownerFA %p, obj %p, objSize %zu",
         &mutator, region, region->firstRegion == region, region->firstRegion->ownerFA,
         reinterpret_cast<void*>(addr), size);
    return addr;
}

void NativeLocalObjectAllocator::AddFinalizer(Mutator& mutator, BaseObject* obj)
{
    if (obj == nullptr) {
        return;
    }
    LocalNativeRegion* region = GetRegionStackTop(mutator);
    CHECK_DETAIL(region != nullptr, "add native local finalizer without current local region: %p", obj);
    region->firstRegion->rootRegistry.AddFinalizer(obj);
    VLOG(LOCAL_REGION, "AddNativeLocalFinalizer: mutator %p, region %p, obj %p", &mutator, region, obj);
}

void NativeLocalObjectAllocator::RemoveFinalizer(Mutator& mutator, BaseObject* obj)
{
    if (obj == nullptr) {
        return;
    }
    LocalNativeRegion* region = FindRegionOfObject(mutator, obj);
    if (region != nullptr && region->firstRegion->rootRegistry.RunFinalizer(mutator, obj)) {
        VLOG(LOCAL_REGION, "RemoveNativeLocalFinalizer: mutator %p, region %p, obj %p", &mutator, region, obj);
    }
}

void NativeLocalObjectAllocator::AddLocalRoot(Mutator& mutator, BaseObject* obj)
{
    if (obj == nullptr) {
        return;
    }
    LocalNativeRegion* region = FindRegionOfObject(mutator, obj);
    CHECK_DETAIL(region != nullptr, "add native local root with non-local object %p", obj);
    region->firstRegion->rootRegistry.AddLocalRoot(obj);
    VLOG(LOCAL_REGION, "AddNativeLocalRoot: mutator %p, region %p, obj %p", &mutator, region, obj);
}

void NativeLocalObjectAllocator::VisitLocalObjectRefFields(Mutator& mutator, const RootVisitor& visitor)
{
    // NOTE(localmode): reuse a per-mutator scratch visited set to avoid allocating during every root visit.
    std::unordered_set<BaseObject*> visited;
    for (LocalNativeRegion* region = GetRegionStackTop(mutator); region != nullptr; region = region->prev) {
        if (region->firstRegion != region) {
            continue;
        }
        region->firstRegion->rootRegistry.VisitLocalObjectRefFields(
            visitor, [this, &mutator](BaseObject* obj) { return FindRegionOfObject(mutator, obj) != nullptr; },
            visited);
    }
}

NativeLocalObjectAllocator::LocalNativeRegion* NativeLocalObjectAllocator::GetRegionStackTop(
    const Mutator& mutator) const
{
    NativeMutatorLocalData* data = GetMutatorData(mutator);
    return data == nullptr ? nullptr : data->stackTop;
}

void NativeLocalObjectAllocator::SetRegionStackTop(Mutator& mutator, LocalNativeRegion* region)
{
    NativeMutatorLocalData* data = GetMutatorData(mutator);
    if (region != nullptr) {
        CHECK_DETAIL(data != nullptr, "set native local region stack without mutator data");
    }
    if (data != nullptr) {
        data->stackTop = region;
    }
}

NativeLocalObjectAllocator::NativeMutatorLocalData* NativeLocalObjectAllocator::GetMutatorData(
    const Mutator& mutator) const
{
    return static_cast<NativeMutatorLocalData*>(mutator.GetLocalObjectAllocatorData());
}

NativeLocalObjectAllocator::NativeMutatorLocalData* NativeLocalObjectAllocator::CreateMutatorData(Mutator& mutator)
{
    NativeMutatorLocalData* data = GetMutatorData(mutator);
    if (data != nullptr) {
        return data;
    }
    data = new (std::nothrow) NativeMutatorLocalData();
    CHECK_DETAIL(data != nullptr, "new native local mutator data failed");
    mutator.SetLocalObjectAllocatorData(data);
    std::lock_guard<std::mutex> lock(activeMutatorDataMtx);
    activeMutatorData.push_back(data);
    return data;
}

void* NativeLocalObjectAllocator::PopCachedRegionMemory(NativeMutatorLocalData& data)
{
    if (data.regionCacheCount == 0) {
        return nullptr;
    }
    return data.regionCache[--data.regionCacheCount];
}

void NativeLocalObjectAllocator::PushCachedRegionMemory(NativeMutatorLocalData& data, void* memory)
{
    if (data.regionCacheCount < nativeLocalRegionCacheCapacity) {
        data.regionCache[data.regionCacheCount++] = memory;
        return;
    }
    // Cache full: release the memory for real instead of growing without bound.
    NativeAllocator::NativeFree(memory, DEFAULT_NATIVE_LOCAL_REGION_SIZE);
}

void NativeLocalObjectAllocator::FreeRegionCache(NativeMutatorLocalData& data)
{
    for (size_t i = 0; i < data.regionCacheCount; ++i) {
        NativeAllocator::NativeFree(data.regionCache[i], DEFAULT_NATIVE_LOCAL_REGION_SIZE);
    }
    data.regionCacheCount = 0;
}

void NativeLocalObjectAllocator::OnMutatorExit(Mutator& mutator)
{
    NativeMutatorLocalData* data = GetMutatorData(mutator);
    if (data == nullptr) {
        return;
    }
    // Reclaim regions still alive (abnormal exit with local regions active).
    // Finalizers are not run here: this is called during thread teardown and
    // running user code would risk re-entering the runtime.
    LocalNativeRegion* region = nullptr;
    region = data->stackTop;
    data->stackTop = nullptr;
    while (region != nullptr) {
        LocalNativeRegion* next = region->prev;
        FreeRegion(region);
        region = next;
    }
    FreeRegionCache(*data);
    {
        std::lock_guard<std::mutex> lock(activeMutatorDataMtx);
        auto it = std::find(activeMutatorData.begin(), activeMutatorData.end(), data);
        if (it != activeMutatorData.end()) {
            *it = activeMutatorData.back();
            activeMutatorData.pop_back();
        }
    }
    mutator.SetLocalObjectAllocatorData(nullptr);
    delete data;
}

NativeLocalObjectAllocator::LocalNativeRegion* NativeLocalObjectAllocator::AllocateRegion(
    Mutator& mutator, size_t minSize, LocalNativeRegion* prev, bool firstOfRegion, FrameAddress* ownerFA)
{
    size_t regionSize = std::max(DEFAULT_NATIVE_LOCAL_REGION_SIZE, RoundUp<size_t>(minSize, Allocator::ALLOC_ALIGN));
    CHECK_DETAIL(firstOfRegion || prev != nullptr, "allocate non-first native local region without active region");
    NativeMutatorLocalData* ownerData = CreateMutatorData(mutator);
    void* memory = nullptr;
    if (regionSize == DEFAULT_NATIVE_LOCAL_REGION_SIZE) {
        memory = PopCachedRegionMemory(*ownerData);
    }
    if (memory == nullptr) {
        memory = NativeAllocator::NativeAlloc(regionSize);
        if (memory == nullptr) {
            return nullptr;
        }
    }
    MAddress base = reinterpret_cast<MAddress>(memory);
    LocalNativeRegion* region = firstOfRegion
        ? static_cast<LocalNativeRegion*>(
              new (std::nothrow) LocalNativeFirstRegion(base, regionSize, prev, ownerFA, ownerData))
        : new (std::nothrow) LocalNativeRegion(base, regionSize, prev, prev->firstRegion);
    if (region == nullptr) {
        if (regionSize == DEFAULT_NATIVE_LOCAL_REGION_SIZE) {
            PushCachedRegionMemory(*ownerData, memory);
        } else {
            NativeAllocator::NativeFree(memory, regionSize);
        }
        return nullptr;
    }
    return region;
}

void NativeLocalObjectAllocator::FreeRegion(LocalNativeRegion* region)
{
    CHECK_DETAIL(region != nullptr, "free null native local region");
    if (region->size == DEFAULT_NATIVE_LOCAL_REGION_SIZE) {
        // Default-sized memory goes back to the owner's cache for reuse; it is
        // fully released on cache overflow or at mutator exit.
        PushCachedRegionMemory(*region->firstRegion->ownerData, reinterpret_cast<void*>(region->base));
    } else {
        NativeAllocator::NativeFree(reinterpret_cast<void*>(region->base), region->size);
    }
    if (region->firstRegion == region) {
        delete static_cast<LocalNativeFirstRegion*>(region);
    } else {
        delete region;
    }
}

MAddress NativeLocalObjectAllocator::TryAllocateInRegion(LocalNativeRegion& region, size_t size)
{
    size_t allocSize = RoundUp<size_t>(size, Allocator::ALLOC_ALIGN);
    MAddress cursor = region.cursor;
    MAddress objAddr = RoundUp<MAddress>(cursor, Allocator::ALLOC_ALIGN);
    if (objAddr > region.end) {
        return 0;
    }
    if (allocSize > region.end - objAddr) {
        return 0;
    }
    region.cursor = objAddr + allocSize;
    return objAddr;
}

NativeLocalObjectAllocator::LocalNativeRegion* NativeLocalObjectAllocator::PopRegionChain(
    Mutator& mutator, FrameAddress* ownerFA)
{
    NativeMutatorLocalData* data = GetMutatorData(mutator);
    if (data == nullptr) {
        return nullptr;
    }
    LocalNativeRegion* curr = data->stackTop;
    if (curr != nullptr && ownerFA != nullptr && curr->firstRegion->ownerFA != ownerFA) {
        LOG(RTLOG_WARNING, "skip native local region pop with mismatched frame: top ownerFA %p, target ownerFA %p",
            curr->firstRegion->ownerFA, ownerFA);
        return nullptr;
    }
    LocalNativeRegion* ret = curr;
    while (curr != nullptr) {
        LocalNativeRegion* prev = curr->prev;
        if (ownerFA != nullptr && curr->firstRegion->ownerFA != ownerFA) {
            LOG(RTLOG_WARNING, "skip native local region pop across frame boundary: region ownerFA %p, target ownerFA "
                "%p", curr->firstRegion->ownerFA, ownerFA);
            return nullptr;
        }
        if (curr->firstRegion == curr) {
            data->stackTop = prev;
            curr->prev = nullptr;
            break;
        }
        curr = prev;
    }
    return ret;
}

NativeLocalObjectAllocator::LocalNativeRegion* NativeLocalObjectAllocator::FindRegionOfObject(Mutator& mutator,
                                                                                              BaseObject* obj)
{
    MAddress addr = reinterpret_cast<MAddress>(obj);
    NativeMutatorLocalData* data = GetMutatorData(mutator);
    if (data == nullptr) {
        return nullptr;
    }
    return FindRegionByAddress(data->stackTop, addr);
}

bool NativeLocalObjectAllocator::IsAddressInRegion(MAddress addr, const LocalNativeRegion& region) const
{
    if (region.size == DEFAULT_NATIVE_LOCAL_REGION_SIZE) {
        return addr >= region.base && addr < region.end;
    }
    // A large native region contains exactly one object.
    return addr == region.largeObjectStart;
}

void NativeLocalObjectAllocator::RegisterObject(MAddress obj, LocalNativeRegion& region)
{
    if (region.size == DEFAULT_NATIVE_LOCAL_REGION_SIZE) {
        return;
    }
    CHECK_DETAIL(region.largeObjectStart == 0, "large native local region contains multiple objects");
    region.largeObjectStart = obj;
}

void NativeLocalObjectAllocator::RunLocalFinalizers(Mutator& mutator, FrameAddress* ownerFA)
{
    LocalNativeRegion* region = GetRegionStackTop(mutator);
    if (region == nullptr) {
        return;
    }
    if (ownerFA != nullptr && region->firstRegion->ownerFA != ownerFA) {
        LOG(RTLOG_WARNING, "skip native local finalizers with mismatched frame: region ownerFA %p, target ownerFA %p",
            region->firstRegion->ownerFA, ownerFA);
        return;
    }
    while (region->firstRegion->rootRegistry.RunPendingFinalizers(mutator)) {
    }
}
} // namespace MapleRuntime
