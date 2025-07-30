// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_ATOMIC_SPINLOCK_H
#define MRT_ATOMIC_SPINLOCK_H
#include <atomic>
#include "Base/Macros.h"

namespace MapleRuntime {
class AtomicSpinLock {
public:
    AtomicSpinLock() {}
    ~AtomicSpinLock() = default;

    void Lock()
    {
        while (state.test_and_set(std::memory_order_acquire)) {}
    }

    void Unlock() { state.clear(std::memory_order_release); }

    bool TryLock() { return (state.test_and_set(std::memory_order_acquire) == false); }

private:
    std::atomic_flag state = ATOMIC_FLAG_INIT;

    DISABLE_CLASS_COPY_AND_ASSIGN(AtomicSpinLock);
};
} // namespace MapleRuntime

#endif // MRT_ATOMIC_SPINLOCK_H
