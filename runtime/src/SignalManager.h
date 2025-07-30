// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_SIGNAL_MANAGER_H
#define MRT_SIGNAL_MANAGER_H

#include <vector>

#include "Base/Macros.h"
#include "Common/PagePool.h"
#include "Signal/SignalHandler.h"
#include "Signal/SignalStack.h"

// Manage the signal handling of the runtime.
// Currently, the runtime relies on signal to provide functionality for:
// using SIGSEGV for per-thread trapping (preempt check/safepoint and others)

namespace MapleRuntime {
struct ThreadLocalData;

class SignalManager {
public:
    SignalManager() = default;
    ~SignalManager()
    {
        if (extraStack != nullptr) {
            PagePool::Instance().ReturnPage(static_cast<uint8_t*>(extraStack), extraStackSize);
        }
    }

    // Initialize the signal manager
    void Init();
    // Fini the signal manager
    void Fini();

    static void AddHandlerToSignalStack(int signal, SignalAction* sa);
    static void RemoveHandlerFromSignalStack(int signal, bool (*fn)(int, siginfo_t*, void*));

    static const char* GetSignalName(uint8_t idx)
    {
        constexpr uint8_t maxSigNum = 31;
        if (idx > maxSigNum || idx == 0) {
            return "wrong signal";
        }
        const char* signalNameArr[] = { "SIGHUP",  "SIGINT",    "SIGQUIT", "SIGILL",    "SIGTRAP", "SIGABRT",
                                        "SIGBUS",  "SIGFPE",    "SIGKILL", "SIGUSR1",   "SIGSEGV", "SIGUSR2",
                                        "SIGPIPE", "SIGALRM",   "SIGTERM", "SIGSTKFLT", "SIGCHLD", "SIGCONT",
                                        "SIGSTOP", "SIGTSTP",   "SIGTTIN", "SIGTTOU",   "SIGURG",  "SIGXCPU",
                                        "SIGXFSZ", "SIGVTALRM", "SIGPROF", "SIGWINCH",  "SIGIO",   "SIGPWR",
                                        "SIGSYS" };
        return signalNameArr[idx - 1];
    }

private:
    // Block some ignored signals
    void BlockSignals();
    // install sigsegv signal handlers
    void InstallSegvHandler();
    // install unexpected signal handlers
    void InstallUnexpectedSignalHandlers();
    void InstallSIGUSR1Handlers() const;
    static bool HandleUnexpectedSIGUSR1(int sig, siginfo_t *info, void *context);
    static bool HandleUnexpectedSigsegv(int sig, siginfo_t* info, void* context);
    static bool HandleUnexpectedSignal(int sig, siginfo_t* info, void* context);
    DISABLE_CLASS_COPY_AND_ASSIGN(SignalManager);

    // a list of sigsegv signal handlers
    std::vector<SignalHandler*> segvHandlers;
    void* extraStack{ nullptr };
    uint32_t extraStackSize{ 0 };
};
} // namespace MapleRuntime
#endif // MRT_SIGNAL_MANAGER_H
