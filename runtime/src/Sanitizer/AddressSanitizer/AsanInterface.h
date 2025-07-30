// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef CANGJIERUNTIME_ASANINTERFACE_H
#define CANGJIERUNTIME_ASANINTERFACE_H

#include <cstdint>
#include <cstddef>

#define SANITIZER_NAME "AddressSanitizer"
#define SANITIZER_SHORTEN_NAME "asan"

namespace MapleRuntime {
namespace Sanitizer {
void AsanStartSwitchThreadContext(void* oldThread, void* newThread);
void AsanEndSwitchThreadContext(void* newThread);

// this should be inserted before ProcessorSchedule and after CJThreadContextGet
void AsanEnterCJThread(void* thread);
// this should be inserted before CJThreadContextSet
void AsanExitCJThread(void* thread);

void OnHeapMadvise(void* addr, size_t size);
} // namespace Sanitizer
} // namespace MapleRuntime
#endif // CANGJIERUNTIME_ASANINTERFACE_H
