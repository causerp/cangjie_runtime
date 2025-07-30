// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_SIGNAL_SIGNALUTILS_H
#define MRT_SIGNAL_SIGNALUTILS_H

#include <csignal>

#include "Base/CString.h"
#include "Base/Types.h"
#include "Base/Log.h"
#include "ucontext.h"

namespace MapleRuntime {
#if defined(MRT_DEBUG) && (MRT_DEBUG == 1)
const char* SignalCodeName(int sig, int code);
FixedCString PrintSignalInfo(const siginfo_t& info);
#endif
// Archtecture dependent
Uptr GetPCFromUContext(const ucontext_t& context);
Uptr GetFAFromUContext(const ucontext_t& context);
} // namespace MapleRuntime

#endif // MRT_SIGNAL_SIGNALUTILS_H
