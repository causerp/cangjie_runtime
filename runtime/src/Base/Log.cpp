// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "Log.h"

#include <sys/stat.h>
#include <unistd.h>

#include "Base/CString.h"
#include "Base/Globals.h"
#include "Base/ImmortalWrapper.h"
#include "Base/SysCall.h"
#include "Base/TimeUtils.h"
#include "os/Path.h"
#include "securec.h"
#include "Base/LogFile.h"
namespace MapleRuntime {
static ImmortalWrapper<Logger> g_loggerInstance;

Logger& Logger::GetLogger() noexcept { return *g_loggerInstance; }

#if defined(_WIN64) || defined(__APPLE__)
static LogHandle g_logHandle = nullptr;
void Logger::RegisterLogHandle(LogHandle handle)
{
    if (handle == nullptr) {
        PRINT_ERROR("logHandle is nullptr\n");
    }
    g_logHandle = handle;
}

void Logger::InvokeLogHandle(const char* msg)
{
    if (g_logHandle != nullptr) {
        g_logHandle(msg);
    } else {
        PRINT_INFO("%s\n", msg);
    }
}
#endif

size_t Logger::GetLogFileSize()
{
    auto env = std::getenv("MRT_LOG_FILE_SIZE");
    if (env == nullptr) {
        return DEFAULT_MAX_FILE_SIZE;
    }
    size_t size = CString::ParseSizeFromEnv(env) * KB;
    if (size != 0) {
        return size;
    } else {
        LOG(RTLOG_ERROR,
            "Unsupported MRT_LOG_FILE_SIZE parameter. The unit must be added when configuring, "
            "it supports 'kb', 'mb', 'gb'. \n");
    }
    return DEFAULT_MAX_FILE_SIZE;
}

bool IsHaveCommandInjection(const CString& logPath)
{
#if defined(_WIN64)
    std::vector<const char*> injectionChar = { "|", ";", "&", "$", ">", "<", "`", "!", "\n" };
#else
    std::vector<const char*> injectionChar = { "|", ";", "&", "$", ">", "<", "`", "\\", "!", "\n" };
#endif
    for (size_t i = 0; i < injectionChar.size(); ++i) {
        if (strstr(logPath.Str(), injectionChar[i]) != nullptr) {
            return true;
        }
    }
    return false;
}

void Logger::GetLogPath(const char* env, CString& logPath)
{
    const char* envPath = ::getenv(env);
    if (envPath == nullptr) {
        return;
    }
    CString s = CString(envPath).RemoveBlankSpace();
    envPath = s.Str();
    if (strlen(envPath) < 2 || (strlen(envPath) >= PATH_MAX)) { // 2 is path minimum size
        LOG(RTLOG_ERROR, "Unsupported %s parameter. The length should be in [2, 4096).\n", env);
        return;
    }
#if defined(_WIN64)
    const char* separator = "\\";
#else
    const char* separator = "/";
#endif
    logPath = CString();
    int pos = CString(envPath).RFind(separator);
    if (pos < 0) {
        LOG(RTLOG_ERROR, "%s is not a valid path . Please check again.\n", env);
        return;
    }

    char pathBuf[PATH_MAX + 1] = { 0x00 };
    if (pos != (strlen(envPath) - 1)) {
        // path ends with name (could be a directory or a file)
        CString path = CString(envPath).SubStr(0, pos + 1);
        CString name = CString(envPath).SubStr(pos + 1);
        if ((!name.IsEmpty()) && Os::Path::GetRealPath(path.Str(), pathBuf)) {
            logPath = CString(pathBuf);
            if (logPath.RFind(separator) != (logPath.Length() - 1)) {
                logPath.Append(separator);
            }
            logPath.Append(name);
        }
    } else {
        // path ends with '/' (must be directory)
        if (Os::Path::GetRealPath(envPath, pathBuf)) {
            logPath = CString(pathBuf);
        }
    }

    if (IsHaveCommandInjection(logPath)) {
        LOG(RTLOG_ERROR, "Unsupported %s parameter. %s has command injection risk.\n", env, env);
        return;
    }
    if (logPath.IsEmpty()) {
        LOG(RTLOG_ERROR, "Unsupported %s parameter. %s is empty.\n", env, env);
    }
}

Logger::Logger()
{
    maxFileSize = GetLogFileSize();

    GetLogPath("MRT_LOG_PATH", filePath);
    minimumLogLevel = RTLOG_ERROR;
}

bool Logger::InitLog()
{
    FILE* newFd = fopen(filePath.Str(), "w");
    if (newFd == nullptr) {
        PRINT_ERROR("open log file %s failed. msg: %s\n", filePath.Str(), strerror(errno));
        filePath = CString();
        return false;
    }
    fd = newFd;
    curPosLocation = 0;
    return true;
}

RTLogLevel Logger::GetMinimumLogLevel() const { return minimumLogLevel; }

void Logger::SetMinimumLogLevel(RTLogLevel level)
{
    if (level < minimumLogLevel) {
        minimumLogLevel = level;
    }
}

bool Logger::MaybeRotate(size_t curPos, size_t maxSize, FILE* file)
{
    if (curPos < maxSize) {
        return false;
    }
    fflush(file);
    (void)ftruncate(fileno(file), ftell(file));
    rewind(file);
    return true;
}

const char LOG_LEVEL[] = { 'V', 'D', 'I', 'I', 'W', 'E', 'F', 'F' };
const uint64_t ERROR_MSG_SIZE = 128;

void WriteStr(int fd, const char* str, bool notInSigHandler)
{
    if (notInSigHandler) {
        if (fd >= STDERR_FILENO) {
            PRINT_ERROR("%s", str);
        } else {
            PRINT_INFO("%s", str);
        }
    } else {
        if (write(fd, str, strlen(str)) == -1) {
            return;
        }
    }
}

#if (defined(__OHOS__) && (__OHOS__ == 1))
bool Logger::CheckLogLevel(RTLogLevel level)
{
    if ((level == RTLOG_DEBUG) && level < GetMinimumLogLevel()) {
        return false;
    }
    if ((!filePath.IsEmpty()) && fd == nullptr) {
        std::lock_guard<std::recursive_mutex> lock(logMutex);
        if (fd == nullptr && (!InitLog())) {
            if (level == RTLOG_FATAL) {
                std::abort();
            }
            return false;
        }
    }
    return true;
}
#else
bool Logger::CheckLogLevel(RTLogLevel level)
{
    if (level < GetMinimumLogLevel()) {
        return false;
    }
    if ((!filePath.IsEmpty()) && fd == nullptr) {
        std::lock_guard<std::recursive_mutex> lock(logMutex);
        if (fd == nullptr && (!InitLog())) {
            if (level == RTLOG_FATAL) {
                std::abort();
            }
            return false;
        }
    }
    return true;
}
#endif

void Logger::FormatLog(RTLogLevel level, bool notInSigHandler, const char* format, ...) noexcept
{
    if (!CheckLogLevel(level)) {
        return;
    }
    char buf[LOG_BUFFER_SIZE];
    int index;
    if (notInSigHandler) {
        index = sprintf_s(buf, sizeof(buf), "%s %d %c ", TimeUtil::GetTimestamp().Str(), MapleRuntime::GetTid(),
                          LOG_LEVEL[level]);
    } else {
        index = sprintf_s(buf, sizeof(buf), "%d %c ", MapleRuntime::GetTid(), LOG_LEVEL[level]);
    }

    va_list args;
    va_start(args, format);
    int ret = vsprintf_s(buf + index, sizeof(buf) - index, format, args);
    if (ret == -1) {
        char errMsg[ERROR_MSG_SIZE];
        (void)sprintf_s(errMsg, ERROR_MSG_SIZE, "FormatLog vsprintf_s failed. msg: %s\n", strerror(errno));
        WriteStr(STDOUT_FILENO, errMsg, notInSigHandler);
        return;
    }
    index += ret;
    va_end(args);
#if (defined(__OHOS__) && (__OHOS__ == 1))
    switch (level) {
        case RTLOG_ERROR: {
            printf("%s\n", buf); // Print error messages to the terminal
            PRINT_ERROR("%{public}s\n", buf);
            break;
        }
        case RTLOG_FAIL:
        case RTLOG_FATAL:
            PRINT_FATAL("%{public}s\n", buf);
            break;
        case RTLOG_DEBUG:
            PRINT_DEBUG("%{public}s\n", buf);
            break;
        case RTLOG_WARNING:
            PRINT_WARN("%{public}s\n", buf);
            break;
        case RTLOG_REPORT:
            VLOG(REPORT, "%{public}s\n", buf)
        default:
            PRINT_INFO("%{public}s\n", buf);
    }
#else
    if (filePath.IsEmpty()) {
        std::lock_guard<std::recursive_mutex> lock(logMutex);
        PRINT_FATAL_IF(sprintf_s(buf, LOG_BUFFER_SIZE, "%s\n", buf) == -1, "FormatLog sprintf_s failed.\n");
        if (level >= RTLOG_ERROR) {
            WriteStr(STDERR_FILENO, buf, notInSigHandler);
        } else {
            WriteStr(STDOUT_FILENO, buf, notInSigHandler);
        }
    } else {
        std::lock_guard<std::recursive_mutex> lock(logMutex);
        int err;
        PRINT_FATAL_IF(sprintf_s(buf, LOG_BUFFER_SIZE, "%s\n", buf) == -1, "FormatLog sprintf_s failed.\n");
        if (notInSigHandler) {
            err = fprintf(fd, "%s", buf);
        } else {
            err = write(reinterpret_cast<uint64_t>(fd), buf, strlen(buf));
        }
        if ((err - 1) != index) { // 1 = '\n'
            char errMsg[ERROR_MSG_SIZE];
            PRINT_FATAL_IF(sprintf_s(errMsg, ERROR_MSG_SIZE, "FormatLog fprintf failed. msg: %s\n",
                strerror(errno)) == -1, "FormatLog sprintf_s failed.\n");
            WriteStr(STDERR_FILENO, errMsg, notInSigHandler);
        } else {
            curPosLocation += index;
            if (MaybeRotate(curPosLocation, maxFileSize, fd)) {
                curPosLocation = 0;
            }
        }
        if (level == RTLOG_REPORT) {
            VLOG(REPORT, "%{public}s\n", buf);
        }
        if (level == RTLOG_FATAL || level == RTLOG_ERROR) {
            fflush(fd);
        }
    }
#endif
    if (level == RTLOG_FATAL) {
        std::abort();
    }
}
} // namespace MapleRuntime
