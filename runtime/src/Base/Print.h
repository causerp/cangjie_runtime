// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef PRINT_H
#define PRINT_H
#if (defined(__OHOS__) && (__OHOS__ == 1))
#include "hilog/log.h"


#ifdef LOG_DOMAIN
#undef LOG_DOMAIN
#endif
#ifdef LOG_TAG
#undef LOG_TAG
#endif

#define BASE_DOMAIN 0
#define LOG_DOMAIN (BASE_DOMAIN + 8)
#define LOG_TAG "CANGJIE-RUNTIME"
#endif
namespace MapleRuntime {
#if defined(__OHOS__) && (__OHOS__ == 1)
#define PRINT_INFO(...)                                           \
if (OH_LOG_IsLoggable(LOG_DOMAIN, LOG_TAG, LOG_INFO)) {       \
    OH_LOG_INFO(LOG_APP, ##__VA_ARGS__);                    \
}

#define PRINT_ERROR(...)                                           \
if (OH_LOG_IsLoggable(LOG_DOMAIN, LOG_TAG, LOG_ERROR)) {       \
    OH_LOG_ERROR(LOG_APP, __VA_ARGS__);                    \
}
#define PRINT_FATAL(...)                                           \
if (OH_LOG_IsLoggable(LOG_DOMAIN, LOG_TAG, LOG_FATAL)) {       \
    OH_LOG_FATAL(LOG_APP, __VA_ARGS__);                    \
}
#define PRINT_DEBUG(...)                                           \
if (OH_LOG_IsLoggable(LOG_DOMAIN, LOG_TAG, LOG_DEBUG)) {       \
    OH_LOG_DEBUG(LOG_APP, __VA_ARGS__);                    \
}
#define PRINT_WARN(...)                                           \
if (OH_LOG_IsLoggable(LOG_DOMAIN, LOG_TAG, LOG_WARN)) {       \
    OH_LOG_WARN(LOG_APP, __VA_ARGS__);                    \
}

#define PRINT_FATAL_IF(conf, ...) \
    do { \
        if (conf) { \
            if (OH_LOG_IsLoggable(LOG_DOMAIN, LOG_TAG, LOG_FATAL)) {       \
                OH_LOG_FATAL(LOG_APP, __VA_ARGS__);                    \
            } \
        } \
    } while (0)

#define PRINT_ERROR_RETURN_IF(conf, retValue, ...) \
    do { \
        if (conf) { \
            if (OH_LOG_IsLoggable(LOG_DOMAIN, LOG_TAG, LOG_ERROR)) {       \
                OH_LOG_ERROR(LOG_APP, __VA_ARGS__);                    \
            } \
            return retValue; \
        } \
    } while (0)

#else

#define PRINT_INFO(format...) fprintf(stdout, format)

#define PRINT_ERROR(format...) fprintf(stderr, format)
#define PRINT_ERROR_RETURN_IF(conf, retValue, format...) \
    do { \
        if (conf) { \
            PRINT_ERROR(format); \
            return retValue; \
        } \
    } while (0)


#define PRINT_FATAL(format...) \
    do { \
        fprintf(stderr, format); \
        std::abort(); \
    } while (0)

#define PRINT_FATAL_IF(conf, format...) \
    do { \
        if (conf) { \
            PRINT_FATAL(format); \
        } \
    } while (0)

#endif
}

#endif