// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_LOG_MANAGER_H
#define MRT_LOG_MANAGER_H

namespace MapleRuntime {
// manager of logging and tracing facilities
class LogManager {
public:
    LogManager();
    ~LogManager() = default;

    // Runtime module lifetime interfaces
    void Init();
    void Fini();
};
} // namespace MapleRuntime

#endif // MRT_LOG_MANAGER_H
