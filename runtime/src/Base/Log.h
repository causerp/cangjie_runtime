// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_BASE_LOG_H
#define MRT_BASE_LOG_H

#include <atomic>
#include <climits>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <mutex>

#include "Base/CString.h"
#include "Base/Macros.h"
#include "Cangjie.h"
#if defined(__OHOS__) && (__OHOS__ == 1)
#include "hitrace/trace.h"
#endif

namespace MapleRuntime {
#define LOG(level, format...) ::MapleRuntime::Logger::GetLogger().FormatLog(level, true, format)
#define FLOG(level, format...) ::MapleRuntime::Logger::GetLogger().FormatLog(level, false, format)

#if defined(__OHOS__) && (__OHOS__ == 1)
    /**
     * Sample code: \n
     * Synchronous timeslice trace event: \n
     *     OHOS_HITRACE_START("hitraceTest"); \n
     *     OHOS_HITRACE_FINISH();\n
     * Output: \n
     *     <...>-1668    (-------) [003] ....   135.059377: tracing_mark_write: B|1668|H:hitraceTest \n
     *     <...>-1668    (-------) [003] ....   135.059415: tracing_mark_write: E|1668| \n
     * Asynchronous timeslice trace event: \n
     *     OHOS_HITRACE_START_ASYNC("hitraceTest", 123); \n
     *     OHOS_HITRACE_FINISH_ASYNC("hitraceTest", 123); \n
     * Output: \n
     *     <...>-2477    (-------) [001] ....   396.427165: tracing_mark_write: S|2477|H:hitraceTest 123 \n
     *     <...>-2477    (-------) [001] ....   396.427196: tracing_mark_write: F|2477|H:hitraceTest 123 \n
     * Integer value trace event: \n
     *     OHOS_HITRACE_COUNT("hitraceTest", 500); \n
     * Output: \n
     *     <...>-2638    (-------) [002] ....   458.904382: tracing_mark_write: C|2638|H:hitraceTest 500 \n
     */
    #define OHOS_HITRACE_START(name)                    OH_HiTrace_StartTrace(name)
    #define OHOS_HITRACE_FINISH()                       OH_HiTrace_FinishTrace()
    #define OHOS_HITRACE_START_ASYNC(name, taskId)      OH_HiTrace_StartAsyncTrace(name, static_cast<int32_t>(taskId))
    #define OHOS_HITRACE_FINISH_ASYNC(name, taskId)     OH_HiTrace_FinishAsyncTrace(name, static_cast<int32_t>(taskId))
    #define OHOS_HITRACE_COUNT(name, count)             OH_HiTrace_CountTrace(name, count)
#else
    #define OHOS_HITRACE_START(name)
    #define OHOS_HITRACE_FINISH()
    #define OHOS_HITRACE_START_ASYNC(name, taskId)
    #define OHOS_HITRACE_FINISH_ASYNC(name, taskId)
    #define OHOS_HITRACE_COUNT(name, count)
#endif

#define OHOS_HITRACE_CJTHREAD_NEW                           "CJTHREAD_CJThreadNew READY"
#define OHOS_HITRACE_CJTHREAD_EXEC                          "CJTHREAD_CJThreadExecute RUNNING"
#define OHOS_HITRACE_CJTHREAD_PARK                          "CJTHREAD_CJThreadPark PENDING"
#define OHOS_HITRACE_CJTHREAD_EXIT                          "CJTHREAD_CJThreadExit IDLE"
#define OHOS_HITRACE_CJTHREAD_SETNAME                       "CJTHREAD_CJThreadSetName "

class ScopedEntryHiTrace {
public:
    explicit ScopedEntryHiTrace(CString name)
    {
        (void)name;
        OHOS_HITRACE_START(name.Str());
    }

    ~ScopedEntryHiTrace()
    {
        OHOS_HITRACE_FINISH();
    }
};

class ScopedEntryAsyncHiTrace {
public:
    explicit ScopedEntryAsyncHiTrace(CString n, int32_t id, const char *arg = nullptr)
        : name(n), taskId(id), extraArg(arg)
    {
        (void)name;
        (void)taskId;
        (void)extraArg;
        if (extraArg != nullptr && *extraArg != '\0') {
            name = name.Append(extraArg);
        }
        OHOS_HITRACE_START_ASYNC(name.Str(), static_cast<int32_t>(taskId));
    }

    ~ScopedEntryAsyncHiTrace()
    {
        OHOS_HITRACE_FINISH_ASYNC(name.Str(), static_cast<int32_t>(taskId));
    }
private:
    CString name;
    int32_t taskId;
    const char *extraArg = nullptr;
};

#define CHECK(x) \
    do { \
        if (UNLIKELY(!(x))) { \
            ::MapleRuntime::Logger::GetLogger().FormatLog(RTLOG_FATAL, true, "Check failed: %s", #x); \
        } \
    } while (false)

#define CHECK_IN_SIG(x) \
    do { \
        if (UNLIKELY(!(x))) { \
            ::MapleRuntime::Logger::GetLogger().FormatLog(RTLOG_FATAL, false, "Check failed: %s", #x); \
        } \
    } while (false)

#define CHECK_DETAIL(x, format...) \
    do { \
        if (UNLIKELY(!(x))) { \
            ::MapleRuntime::Logger::GetLogger().FormatLog(RTLOG_FAIL, true, "Check failed: %s", #x); \
            ::MapleRuntime::Logger::GetLogger().FormatLog(RTLOG_FATAL, true, format); \
        } \
    } while (false)

#define CHECK_E(x, format...) \
    do { \
        if (x) { \
            ::MapleRuntime::Logger::GetLogger().FormatLog(RTLOG_ERROR, true, format); \
        } \
    } while (false)

#define CHECK_OP(LHS, RHS, OP) \
    do { \
        for (auto _values = ::MapleRuntime::CreateValueHolder(LHS, RHS); \
             UNLIKELY(!(_values.GetLHS() OP _values.GetRHS()));) { \
            Logger::GetLogger().FormatLog(RTLOG_FATAL, true, "Check failed: %s %s %s (%s=%s, %s=%s)", #LHS, #OP, #RHS, \
                                          #LHS, _values.GetLHS(), #RHS, _values.GetRHS()); \
        } \
    } while (false)

#define CHECK_EQ(x, y) CHECK_OP(x, y, ==)
#define CHECK_NE(x, y) CHECK_OP(x, y, !=)

#define CHECK_PTHREAD_CALL(call, args, what) \
    do { \
        int rc = call args; \
        if (rc != 0) { \
            errno = rc; \
            ::MapleRuntime::Logger::GetLogger().FormatLog(RTLOG_FATAL, true, "%s failed for %s reason %s return %d", \
                                                          #call, (what), strerror(errno), errno); \
        } \
    } while (false)

#define CHECK_SIGNAL_CALL(call, args, what) \
    do { \
        int rc = call args; \
        if (rc != 0) { \
            ::MapleRuntime::Logger::GetLogger().FormatLog(RTLOG_FATAL, true, "%s failed for %s reason %s return %d", \
                                                          #call, (what), strerror(errno), errno); \
        } \
    } while (false)

#define CHECK_FWRITE_CALL(call, args, check) \
    do { \
        size_t rc = call args; \
        if (rc != (check)) { \
            ::MapleRuntime::Logger::GetLogger().FormatLog(RTLOG_ERROR, true, "%s failed", #call); \
        } \
    } while (false)

#if defined(MRT_DEBUG) && (MRT_DEBUG == 1)
constexpr bool ENABLE_DEBUG_CHECKS = true;
#else
constexpr bool ENABLE_DEBUG_CHECKS = false;
#endif

#define DCHECK_D(x, y) \
    if (::MapleRuntime::ENABLE_DEBUG_CHECKS) \
    CHECK_DETAIL(x, y)
#define DCHECK(x) \
    if (::MapleRuntime::ENABLE_DEBUG_CHECKS) \
    CHECK(x)
#define DCHECK_NE(x, y) \
    if (::MapleRuntime::ENABLE_DEBUG_CHECKS) \
    CHECK_NE(x, y)

template<typename LHS, typename RHS>
class ValueHolder {
public:
    constexpr ValueHolder(LHS l, RHS r) : lhs(l), rhs(r) {}
    ~ValueHolder() = default;

    LHS GetLHS() { return lhs; }

    RHS GetRHS() { return rhs; }
private:
    LHS lhs;
    RHS rhs;
};

template<typename LHS, typename RHS>
ValueHolder<LHS, RHS> CreateValueHolder(LHS lhs, RHS rhs)
{
    return ValueHolder<LHS, RHS>(lhs, rhs);
}

#if (defined(__OHOS__) && (__OHOS__ == 1)) || (defined(_WIN64)) || defined(__APPLE__)
using LogHandle = void (*)(const char* msg);
#endif

constexpr size_t DEFAULT_MAX_FILE_SIZE = 10 * 1024 * 1024;
constexpr size_t LOG_BUFFER_SIZE = 1024;

class Logger {
public:
    Logger();
    ~Logger()
    {
        if (fd != nullptr) {
            fflush(fd);
            fclose(fd);
        }
    }

    MRT_EXPORT static Logger& GetLogger() noexcept;
    bool InitLog();
    MRT_EXPORT void FormatLog(RTLogLevel level, bool notInSigHandler, const char* format, ...) noexcept;
    RTLogLevel GetMinimumLogLevel() const;
    void SetMinimumLogLevel(RTLogLevel level);
    static bool MaybeRotate(size_t curPos, size_t maxSize, FILE* file);
    static size_t GetLogFileSize();
    static void GetLogPath(const char* env, CString& logPath);
    bool CheckLogLevel(RTLogLevel level);
#if  (defined(_WIN64)) || defined(__APPLE__)
    MRT_EXPORT static void RegisterLogHandle(LogHandle handle);
    static void InvokeLogHandle(const char* msg);
#endif
private:
    FILE* fd = nullptr;
    RTLogLevel minimumLogLevel;
    size_t maxFileSize;
    std::recursive_mutex logMutex;
    CString filePath = nullptr;
    size_t curPosLocation = 0;
};
} // namespace MapleRuntime

#endif // MRT_BASE_LOG_H
