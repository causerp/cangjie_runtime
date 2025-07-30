// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef CANGJIERUNTIME_CJTHREADRECORDER_H
#define CANGJIERUNTIME_CJTHREADRECORDER_H

#include <cstdint>
#include <map>

#include "Base/Log.h"
#include "Base/LogFile.h"
#include "Base/RwLock.h"

namespace MapleRuntime {

template<typename T>
class CJThreadRecorder {
public:
    CJThreadRecorder() = default;

    void CreateThread(void* thread, T data)
    {
        lock.LockWrite();
        map[thread] = data;
        lock.UnlockWrite();
    }

    T GetDataFromThread(void* thread)
    {
        lock.LockRead();
        auto it = map.find(thread);
        if (it == map.end()) {
            lock.UnlockRead();
            return T();
        }
        T result = it->second;
        lock.UnlockRead();
        return result;
    }

    T DeleteThread(void* thread)
    {
        lock.LockWrite();
        auto it = map.find(thread);
        if (it == map.end()) {
            lock.UnlockWrite();
            return T();
        }
        T result = it->second;
        map.erase(it);
        lock.UnlockWrite();
        return result;
    }

    template<typename Res>
    void Traverse(std::function<bool(void*, T, Res*)> func, Res* result)
    {
        lock.LockRead();
        for (auto kv : this->map) {
            if (func(kv.first, kv.second, result)) {
                lock.UnlockRead();
                return;
            }
        }
        lock.UnlockRead();
    }

private:
    std::map<void*, T> map;
    RwLock lock;
};
}
#endif // CANGJIERUNTIME_CJTHREADRECORDER_H
