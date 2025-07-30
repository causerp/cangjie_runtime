// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_TIME_UTILS_H
#define MRT_TIME_UTILS_H

#include <cinttypes>

#include "Base/CString.h"
#include "Base/Log.h"
#include "Base/Macros.h"

namespace MapleRuntime {
namespace TimeUtil {
// returns the monotonic time since epoch starting point in milliseconds
uint64_t MilliSeconds();

// returns the monotonic time since epoch starting point in nanoseconds
MRT_EXPORT uint64_t NanoSeconds();

// returns the monotonic time since epoch starting point in microseconds
uint64_t MicroSeconds() noexcept;

// sleep for the given count of nanoseconds
void SleepForNano(uint64_t ns);

#if defined(MRT_DEBUG) && (MRT_DEBUG == 1)
// returns the current date in ISO yyymmdd.hhmmss format
CString GetDigitDate();
#endif

// returns the current date in ISO yyyy-mm-dd hh:mm::ss.ms format
MRT_EXPORT CString GetTimestamp();
} // namespace TimeUtil
} // namespace MapleRuntime
#endif // MRT_TIME_UTILS_H
