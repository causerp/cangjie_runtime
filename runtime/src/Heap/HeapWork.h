// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_HEAP_WORK_H
#define MRT_HEAP_WORK_H

#include <atomic>
#include <condition_variable>
#include <functional>
#include <mutex>
#include <pthread.h>
#include <queue>
#include <vector>

namespace MapleRuntime {
class HeapWork {
public:
    HeapWork() = default;
    virtual ~HeapWork() = default;
    virtual void Execute(size_t threadId) = 0;
};

class LambdaWork : public HeapWork {
public:
    explicit LambdaWork(const std::function<void(size_t)>& function) : func(function) {}
    ~LambdaWork() = default;
    void Execute(size_t threadId) override { func(threadId); }

private:
    std::function<void(size_t)> func;
};
} // namespace MapleRuntime

#endif // MRT_HEAP_WORK_H
