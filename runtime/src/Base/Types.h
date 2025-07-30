// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_BASE_TYPES_H
#define MRT_BASE_TYPES_H

#include <cstddef>
#include <cstdint>
#if defined(__linux__) || defined(__APPLE__)
#include <sys/types.h>
#elif defined(hongmeng)
#include <unistd.h>
#endif

// general types (for unmanaged world)
namespace MapleRuntime {
using U1 = uint8_t;
using I1 = int8_t;
using U8 = uint8_t;
using I8 = int8_t;
using U16 = uint16_t;
using I16 = int16_t;
using U32 = uint32_t;
using I32 = int32_t;
using U64 = uint64_t;
using I64 = int64_t;

using F16 = uint16_t;
using F32 = float;
using F64 = double;
// platform dependent types

// a more general set of pointer type
#if defined(__APPLE__)
    using Uptr = uint64_t;
#else
    using Uptr = uintptr_t;
#endif
using Sptr = intptr_t;

// these're related: used for field declaration and parameter.
using Size = ssize_t;
using USize = size_t;
using Index = size_t;
using Offset = size_t;

} // namespace MapleRuntime

#endif // MRT_BASE_TYPES_H
