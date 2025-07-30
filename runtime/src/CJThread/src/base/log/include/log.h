// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_CJTHREAD_LOG_H
#define MRT_CJTHREAD_LOG_H

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <stdarg.h>
#include "schedule_rename.h"
#include "Cangjie.h"

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif

#ifndef VOSFILENAME
#define VOSFILENAME  __FILE__
#endif

/**
 * @brief Hook function for writing log.
 */
typedef void (*LogFunc)(const char *message);

/**
 * @brief log level.
 */
enum ThreadLogLevel {
    LOG_LEVEL_DEBUG   = RTLogLevel::RTLOG_DEBUG,
    LOG_LEVEL_INFO    = RTLogLevel::RTLOG_INFO,
    LOG_LEVEL_WARNING = RTLogLevel::RTLOG_WARNING,
    LOG_LEVEL_ERROR   = RTLogLevel::RTLOG_ERROR,
    LOG_LEVEL_FATAL   = RTLogLevel::RTLOG_FATAL,
};

/**
 * @brief Function for recording debug log.
 * @param  errorCode    [IN]  error code
 * @param  fmt          [IN]  log format
 * @param  args         [IN]  args
 */
#define LOG_DEBUG(errorCode, fmt, args...) \
    do { \
        LogWrite(ThreadLogLevel::LOG_LEVEL_DEBUG, (errorCode), VOSFILENAME, __LINE__, fmt, ##args); \
    } while (0)

/**
 * @brief Function for recording info log.
 * @param  errorCode    [IN]  error code
 * @param  fmt          [IN]  log format
 * @param  args         [IN]  args
 */
#define LOG_INFO(errorCode, fmt, args...) \
    do { \
        LogWrite(ThreadLogLevel::LOG_LEVEL_INFO, (errorCode), VOSFILENAME, __LINE__, fmt, ##args); \
    } while (0)

/**
 * @brief Function for recording warning log.
 * @param  errorCode    [IN]  error code
 * @param  fmt          [IN]  log format
 * @param  args         [IN]  args
 */
#define LOG_WARN(errorCode, fmt, args...) \
    do { \
        LogWrite(ThreadLogLevel::LOG_LEVEL_WARNING, (errorCode), VOSFILENAME, __LINE__, fmt, ##args); \
    } while (0)

/**
 * @brief Function for recording error log.
 * @param  errorCode    [IN]  error code
 * @param  fmt          [IN]  log format
 * @param  args         [IN]  args
 */
#define LOG_ERROR(errorCode, fmt, args...) \
    do { \
        LogWrite(ThreadLogLevel::LOG_LEVEL_ERROR, (errorCode), VOSFILENAME, __LINE__, fmt, ##args); \
    } while (0)

/**
 * @brief Function for recording fatal log.
 * @param  errorCode    [IN]  error code
 * @param  fmt          [IN]  log format
 * @param  args         [IN]  args
 */
#define LOG_FATAL(errorCode, fmt, args...) \
    do { \
        LogWrite(ThreadLogLevel::LOG_LEVEL_FATAL, (errorCode), VOSFILENAME, __LINE__, fmt, ##args); \
    } while (0)

/**
 * @brief Write log information to the file.
 * @attention
 * @param  level        [IN]  level
 * @param  errorCode    [IN]  error code
 * @param  fileName     [IN]  file
 * @param  line         [IN]  line
 * @param  fmt          [IN]  format
 * @retval void
 */
void LogWrite(ThreadLogLevel level,
              unsigned int errorCode,
              const char *fileName,
              unsigned short line,
              const char *fmt,
              ...);

/**
 * @brief Registering the Log Hook Function. If func is nullptr, use printf to write log.
 * @param  func   [IN]  hook function for writing log
 * @param  enable [IN]  whether enable cjthread log
 * @param  lebel  [IN]  log level
 */
void LogRegister(LogFunc func, bool enable, int level);

/**
 * @brief Check whether info level logs are recorded.
 */
bool LogInfoWritable(void);

#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif
#endif /* MRT_CJTHREAD_LOG_H */