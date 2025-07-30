// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include <libgen.h>
#include "securec.h"
#include "log.h"

#ifdef __cplusplus
extern "C" {
#endif

const int LOG_BUF_SIZE = 1024;

LogFunc g_logFunc = nullptr;

// Log Enable is from MRT_LOG_CJTHREAD. Default value is false.
bool g_logEnable = false;

// Log level is from MRT_LOG_LEVEL. Default value is error.
int g_logLevel = ThreadLogLevel::LOG_LEVEL_ERROR;

bool LogInfoWritable(void)
{
    return g_logLevel >= ThreadLogLevel::LOG_LEVEL_INFO;
}

const char *ErrorLeverString(ThreadLogLevel error)
{
    switch (error) {
        case ThreadLogLevel::LOG_LEVEL_DEBUG:
            return "D";
        case ThreadLogLevel::LOG_LEVEL_INFO:
            return "I";
        case ThreadLogLevel::LOG_LEVEL_WARNING:
            return "W";
        case ThreadLogLevel::LOG_LEVEL_ERROR:
            return "E";
        case ThreadLogLevel::LOG_LEVEL_FATAL:
            return "F";
        default:
            return "U";
    }
    return "U";
}

void LogWrite(ThreadLogLevel level,
              unsigned int errorCode,
              const char *fileName,
              unsigned short line,
              const char *fmt,
              ...)
{
    if (!g_logEnable || level < g_logLevel) {
        return;
    }
    va_list alist;
    char output[LOG_BUF_SIZE];
    int ret;
    int len;
    LogFunc func;

#ifdef MRT_WINDOWS
    fileName = strdup(fileName);
#endif
    ret = snprintf_s(output, LOG_BUF_SIZE, LOG_BUF_SIZE - 1,
        "%s File=%s:%u Error=0x%x ",
        ErrorLeverString(level), basename(const_cast<char *>(fileName)), line, errorCode);
    if (ret < 0) {
        printf("LogWrite failed: %d\n", errno);
        return;
    }
    len = ret;
#ifdef MRT_WINDOWS
    free((void *)fileName);
#endif

    va_start(alist, fmt);
    ret = vsnprintf_s(output + len, LOG_BUF_SIZE - len, LOG_BUF_SIZE - len - 1, fmt, alist);
    va_end(alist);
    if (ret < 0) {
        printf("LogWrite failed: %d\n", errno);
        printf("%s\r\n", output);
        return;
    }

    func = g_logFunc;
    if (func != nullptr) {
        func(output);
    } else {
        printf("%s\r\n", output);
    }

    if (level == ThreadLogLevel::LOG_LEVEL_FATAL) {
        abort();
    }
}

void LogRegister(LogFunc logFunc, bool enable, int level)
{
    g_logFunc = logFunc;
    g_logEnable = enable;
    g_logLevel = level;
}

#ifdef __cplusplus
}
#endif