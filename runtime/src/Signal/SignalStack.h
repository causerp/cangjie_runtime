// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_SIGNAL_STACK_H
#define MRT_SIGNAL_STACK_H

#include <csignal>

#include "Base/Log.h"
#include "Base/LogFile.h"

#ifdef __APPLE__
#define _NSIG NSIG
using sighandler_t = sig_t;
#endif

namespace MapleRuntime {

constexpr uint64_t SIGNAL_STACK_ALLOW_NORETURN = 0x1UL;

class SignalStack {
public:
    SignalStack() noexcept : isMark(false) {}

    bool IsMarked() { return isMark; }

    void MarkSig(int signal)
    {
        if (!isMark) {
            Register(signal);
            isMark = true;
        }
    }

    void Register(int signal);

    struct sigaction GetAction();
    void SetAction(const struct sigaction* newAction);

    void AddHandler(SignalAction* sa);
    void RemoveHandler(bool (*fn)(int, siginfo_t*, void*));

    static void Handler(int signal, siginfo_t* siginfo, void*);
    static void HandlerImpl(void* args);
    static void InitializeSignalStack();
    static SignalStack* GetStacks() { return stacks; }
    struct sigaction sigAction;
private:
    bool isMark;
    
    std::vector<SignalAction> handlerStack;
#ifdef __APPLE__
    static SignalStack stacks[NSIG];
#else
    static SignalStack stacks[_NSIG];
#endif
};
} // namespace MapleRuntime
#endif // MRT_SIGNAL_STACK_H
