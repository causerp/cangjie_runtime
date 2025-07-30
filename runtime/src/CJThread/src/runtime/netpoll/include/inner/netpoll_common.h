// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_NETPOLL_COMMON_H
#define MRT_NETPOLL_COMMON_H

#include "mid.h"

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif

/**
 * @brief 0x10090000 netpoll repeated initialization
 */
#define ERRNO_NETPOLL_INITED ((MID_NETPOLL) | 0x0000)

/**
 * @brief 0x10090001 netpoll invalid arg
 */
#define ERRNO_NETPOLL_ARG_INVAILD ((MID_NETPOLL) | 0x0001)

/**
 * @brief 0x10090003 netpoll repeated epoll registration
 */
#define ERRNO_NETPOLL_REGISTED ((MID_NETPOLL) | 0x0003)

/**
 * @brief 0x10090004 netpoll is not initialized
 */
#define ERRNO_NETPOLL_UNINIT ((MID_NETPOLL) | 0x0004)

/**
 * @brief create and init NetpollMetaData
 * @retval NetpollMetaData pointer
 * @retval NULL
 */
struct NetpollMetaData *NetpollMetaDataInit(void);

#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif
#endif /* MRT_NETPOLL_COMMON_H */
