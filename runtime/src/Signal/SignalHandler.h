// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_SIGNAL_HANDLER_H
#define MRT_SIGNAL_HANDLER_H

#include <csignal>

namespace MapleRuntime {
// Make it a C-friendly interface
using ActionFunc = bool (*)(int sig, siginfo_t* siginfo, void* context);

// Not sure we need other information: action-function actually does the
// the check internally
// Every client that want to handle signal should derive from this,
// and the client should explicitly setup this field
struct SignalHandler {
    SignalHandler() : action(nullptr) {}
    virtual ~SignalHandler() { action = nullptr; };
    ActionFunc action; // make it looks like a function.
};
} // namespace MapleRuntime
#endif // MRT_SIGNAL_HANDLER_H
