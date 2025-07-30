// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "TimeUtils.h"

#include <array>
#include <chrono>
#include <ctime>
#include <iomanip>
#include <thread>

#include "Base/Macros.h"
#include "securec.h"

namespace MapleRuntime {
namespace TimeUtil {
using Sec = std::chrono::seconds;
using Ms = std::chrono::milliseconds;
using Us = std::chrono::microseconds;
using Ns = std::chrono::nanoseconds;

template<typename TimeUnit>
uint64_t ClockTime(clockid_t clock)
{
    struct timespec time = { 0, 0 };
    clock_gettime(clock, &time);
    auto duration = Sec{ time.tv_sec } + Ns{ time.tv_nsec };
    return std::chrono::duration_cast<TimeUnit>(duration).count();
}

uint64_t NanoSeconds() { return ClockTime<Ns>(CLOCK_MONOTONIC); }

uint64_t MilliSeconds() { return ClockTime<Ms>(CLOCK_MONOTONIC); }

uint64_t MicroSeconds() noexcept { return ClockTime<Us>(CLOCK_MONOTONIC); }

void SleepForNano(uint64_t ns) { std::this_thread::sleep_for(std::chrono::nanoseconds(ns)); }

#if defined(MRT_DEBUG) && (MRT_DEBUG == 1)
// yyyy-mm-dd hh:mm::ss format
static inline CString GetDate(const char* format)
{
    std::time_t time = std::time(0);
    std::tm* now = std::localtime(&time);
    if (UNLIKELY(now == nullptr)) {
        return CString();
    }

    std::array<char, 100> buffer; // the array's length is 100
    if (std::strftime(buffer.data(), buffer.size(), format, now)) {
        return CString(buffer.data());
    }
    return CString();
}

// yyymmdd.hhmmss format
CString GetDigitDate()
{
    CString date = GetDate("%Y%m%d_%H%M%S");
    return !date.IsEmpty() ? date : "19700101.000000";
}
#endif

CString GetTimestamp()
{
    // yyyy-mm-dd hh:mm::ss.ms format
    std::chrono::system_clock::time_point now = std::chrono::system_clock::now();
    std::chrono::microseconds us = std::chrono::duration_cast<std::chrono::microseconds>(now.time_since_epoch());
    constexpr size_t microSecondsPerSecond = 1000000;
    auto rem = us.count() % microSecondsPerSecond;

    time_t time = std::chrono::system_clock::to_time_t(now);
    struct tm tm;
#ifdef _WIN64
    (void)localtime_s(&tm, &time);
#else
    (void)localtime_r(&time, &tm);
#endif

    constexpr size_t bufSize = 64;
    char buf[bufSize];
    constexpr int epochYears = 1900;
    (void)sprintf_s(buf, sizeof(buf), "%04d-%02d-%02d %02d:%02d:%02d.%06zu", tm.tm_year + epochYears,
                    tm.tm_mon + 1, tm.tm_mday, tm.tm_hour, tm.tm_min, tm.tm_sec, rem);
    return CString(buf);
}
} // namespace TimeUtil
} // end namespace MapleRuntime
