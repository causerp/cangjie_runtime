// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_CONCURRENCY_MODEL_H
#define MRT_CONCURRENCY_MODEL_H

#include <cstdint>
#include <list>
#include <mutex>
#include <sys/types.h>
#include <unistd.h>

#include "Mutator/Mutator.h"
#include "RuntimeConfig.h"
#include "CjScheduler.h"

namespace MapleRuntime {
/**
 * Data structure to save arguments when creating a thread.
 * There are three types of thread to be created.
 * 1. create the main thread;
 * 2. create a thread with a future;
 * 3. create a thread without a future,
 *    where a closure structure `{void *fnGeneric, void *fnInst, captured_var1, ..., captured_varN}` will be saved.
 */
using LWTData = struct {
    void* execute; // Execute function (from Cangjie) of the thread;
                   // It may be `Future.execute` or `executeClosure`
    void* fn;  // Function pointer of closure when create a thread without a future object
    void* obj; // Pointer of a Cangjie object;
               // future or env of closure
    void* threadObject;   // Cangjie class Thread in std/core
};
struct ConcurrencyTask; // Task depends on the implementation of ConcurrencyModel

// ConcurrencyModel is an abstraction for runtime to implement concurrency.
class ConcurrencyModel {
public:
    // Get thread-local mutator according to concurrency model
    static Mutator* GetMutator();
    static void SetMutator(Mutator* mutator);

    ConcurrencyModel() = default;
    virtual ~ConcurrencyModel() = default;

    virtual void Init(const ConcurrencyParam, ScheduleType) {}
    virtual void Fini() {}
    virtual void VisitGCRoots(RootVisitor* visitorHandle) = 0;
    virtual void* GetThreadScheduler() const
    {
        std::abort();
    }
    virtual size_t GetReservedStackSize() const { std::abort(); }
    virtual bool GetStackGuardCheckFlag() const { std::abort(); }
    virtual uint32_t GetProcessorNum() const { return 1; };

protected:
    void* scheduler{ nullptr };
    size_t reservedStackSize{ 0 };
    bool stackGuardCheck{ false };
};
} // namespace MapleRuntime
#endif // MRT_CONCURRENCY_MODEL_H
