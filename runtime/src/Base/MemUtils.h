// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_MEM_UTILS_H
#define MRT_MEM_UTILS_H

namespace MapleRuntime {
// memset_s wrapper for the situation that memset size is greater than SECUREC_MEM_MAX_LEN(2GB).
void MemorySet(uintptr_t dest, size_t destMax, int c, size_t count);
// memcpy_s wrapper for the situation that memcpy size is greater than SECUREC_MEM_MAX_LEN(2GB).
void MemoryCopy(uintptr_t dest, size_t destMax, const uintptr_t src, size_t count);
#if defined(ENABLE_BACKWARD_PTRAUTH_CFI) || defined(ENABLE_FORWARD_PTRAUTH_CFI)
__attribute__((always_inline))uintptr_t PtrauthStripInstPointer(uintptr_t ptr);
__attribute__((always_inline))uintptr_t PtrauthAuthWithInstAkey(uintptr_t ptr, uintptr_t mod);
__attribute__((always_inline))uintptr_t PtrauthSignWithInstAkey(uintptr_t ptr, uintptr_t mod);
#endif
} // namespace MapleRuntime
#endif // MRT_MEM_UTILS_H