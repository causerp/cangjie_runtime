// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef CANGJIERUNTIME_SANITIZERINTERFACE_H
#define CANGJIERUNTIME_SANITIZERINTERFACE_H

#include <cstdint>

#include "Base/Macros.h"
#include "Common/TypeDef.h"
#include "SanitizerMacros.h"

#ifdef CANGJIE_ASAN_SUPPORT
#include "Sanitizer/AddressSanitizer/AsanInterface.h"
#endif // CANGJIE_ASAN_SUPPORT

#ifdef CANGJIE_TSAN_SUPPORT
#include "Sanitizer/ThreadSanitizer/TsanInterface.h"
#endif // CANGJIE_TSAN_SUPPORT

#ifdef CANGJIE_HWASAN_SUPPORT
#include "Sanitizer/HwAddressSanitizer/HwasanInterface.h"
#endif // CANGJIE_HWASAN_SUPPORT

#ifdef CANGJIE_GWPASAN_SUPPORT
#include "Sanitizer/GwpAddressSanitizer/GwpAsanInterface.h"
#endif

#ifndef SANITIZER_NAME
#error "sanitizer name not defined, please check corresponding sanitizer interface header."
#endif

#ifndef SANITIZER_SHORTEN_NAME
#error "sanitizer shorten name not defined, please check corresponding sanitizer interface header."
#endif

namespace MapleRuntime {
namespace Sanitizer {
// general callbacks
void OnHeapAllocated(void* addr, size_t size);
void OnHeapDeallocated(void* addr, size_t size);

#if defined(GENERAL_ASAN_SUPPORT_INTERFACE) || defined(CANGJIE_GWPASAN_SUPPORT)
void* ArrayAcquireMemoryRegion(ArrayRef array, void* addr, size_t size);
void* ArrayReleaseMemoryRegion(ArrayRef array, void* alias, size_t size);
#endif

#ifdef GENERAL_ASAN_SUPPORT_INTERFACE
void AsanRead(volatile const void* addr, uintptr_t size);
void AsanWrite(volatile const void* addr, uintptr_t size);

void HandleNoReturn(uint64_t from, uint64_t to);
#endif
} // namespace Sanitizer
} // namespace MapleRuntime

#endif // CANGJIERUNTIME_SANITIZERINTERFACE_H
