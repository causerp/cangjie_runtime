// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_SCHMON_H
#define MRT_SCHMON_H

#include "netpoll.h"
#include "processor.h"

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif

/**
 * @brief 0x100A0000 The input schmon parameter is invalid.
 */
#define ERRNO_SCHMON_ARG_INVALID ((MID_SCHMON) | 0x000)

/**
 * @brief 0x100A0001 schmon init failed
 */
#define ERRNO_SCHMON_INIT_FAILED ((MID_SCHMON) | 0x001)

/**
 * @brief start schedule monitor.
 * @param  handle           [IN]  scheduler
 * @retval 0 or error
 */
int SchmonStart(ScheduleHandle handle);

/**
 * @brief Preempts the specified processor.
 * @param  processor        [IN]  processor to be preempted
 */
void SchmonPreemptRunning(struct Processor *processor);

#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif
#endif /* MRT_SCHMON_H */
