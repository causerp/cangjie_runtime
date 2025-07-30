// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#ifndef CANGJIERUNTIME_ASANINTERFACE_H
#define CANGJIERUNTIME_ASANINTERFACE_H

#include <csignal>
#include <cstddef>

#include "Cangjie.h"

#define SANITIZER_NAME "GwpAddressSanitizer"
#define SANITIZER_SHORTEN_NAME "gwpasan"

namespace MapleRuntime {
namespace Sanitizer {
void SetupGwpAsanAsNeeded();
void HandleGwpAsanSigsegv(int sig, const siginfo_t* info);
} // namespace Sanitizer
} // namespace MapleRuntime

#endif // CANGJIERUNTIME_ASANINTERFACE_H
