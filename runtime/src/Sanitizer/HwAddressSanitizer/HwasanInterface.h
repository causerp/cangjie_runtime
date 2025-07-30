// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef CANGJIERUNTIME_HWASANINTERFACE_H
#define CANGJIERUNTIME_HWASANINTERFACE_H

#include <cstdint>
#include <cstddef>

#define SANITIZER_NAME "Hardware-assisted AddressSanitizer"
#define SANITIZER_SHORTEN_NAME "hwasan"

namespace MapleRuntime {
namespace Sanitizer {
uintptr_t UntagAddr(uintptr_t taggedAddr);
void UntagMemory(void* addr, size_t size);
} // namespace Sanitizer
} // namespace MapleRuntime

#endif // CANGJIERUNTIME_HWASANINTERFACE_H
