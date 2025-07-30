// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_COLLECTOR_PLATFORM_H
#define MRT_COLLECTOR_PLATFORM_H
namespace MapleRuntime {
class CollectorPlatform {
public:
    CollectorPlatform();
    virtual ~CollectorPlatform() = default;

private:
    virtual void InitAfterFork() {}
};
} // namespace MapleRuntime
#endif // MRT_COLLECTOR_PLATFORM_H