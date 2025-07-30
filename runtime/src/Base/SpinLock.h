// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_SPINLOCK_H
#define MRT_SPINLOCK_H
#include <pthread.h>

#include "Base/Macros.h"

namespace MapleRuntime {
class SpinLock {
public:
    // Create a Mutex that is not held by anybody.
    SpinLock() { pthread_spin_init(&spinlock, 0); }

    ~SpinLock() { pthread_spin_destroy(&spinlock); }

    void Lock() { pthread_spin_lock(&spinlock); }

    void Unlock() { pthread_spin_unlock(&spinlock); }

    bool TryLock() { return pthread_spin_trylock(&spinlock) == 0; }

private:
    pthread_spinlock_t spinlock;
    DISABLE_CLASS_COPY_AND_ASSIGN(SpinLock);
};

class ScopedEnterSpinLock {
public:
    explicit ScopedEnterSpinLock(SpinLock& lock) : spinLock(lock) { spinLock.Lock(); }
    ~ScopedEnterSpinLock() { spinLock.Unlock(); }
private:
    SpinLock& spinLock;
};
} // namespace MapleRuntime
#endif // MRT_SPINLOCK_H
