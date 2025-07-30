// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#ifndef MRT_NETPOLL_H
#define MRT_NETPOLL_H

#include <pthread.h>
#include <winsock2.h>
#include <windows.h>
#include "netpoll_common.h"

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif

typedef HANDLE FdHandle;

typedef void *NetpollFd;

/**
 * @brief netpoll metaData
 */
struct NetpollMetaData {
    HANDLE epfd;
};

/**
 * @brief netpoll exit
 * @param  npfd         [IN]  netpoll handle, point to NetpollMetaData
 */
void NetpollExit(NetpollFd npfd);

/**
 * @brief netpoll create
 * @retval #netpoll handle
 * @retval #NULL
 */
NetpollFd NetpollCreate(void);

/**
 * @brief Add the fd to be monitored to the netpoll.
 * @param  npfd         [IN]  netpoll handle
 * @param  fd           [IN]  fd
 * @param  data         [IN]  unuse for IOCP
 * @param  events       [IN]  unuse for IOCP
 * @retval #0
 * @retval #error
 */
int NetpollAdd(NetpollFd npfd, HANDLE fd, void *data, unsigned int events);

/**
 * @brief Delete the monitored fd from the netpoll.
 * @param  npfd         [IN]  netpoll handle
 * @param  fd           [IN]  fd
 * @retval #0
 * @retval #error
 */
int NetpollDel(NetpollFd npfd, HANDLE fd);

/**
 * @brief Access netpoll to obtain ready events.
 * @param  npfd         [IN]  netpoll handle
 * @param  entries      [IN]  IOCP event cache array
 * @param  maxentries   [IN]  Cache Array Size
 * @param  timeoutms    [IN]  timeout, in ms，0 indicates immediate response, 0xffffff indicates infinite waiting.
 * @retval #>=0 Number of ready events
 * @retval #-1
 */
int NetpollWait(NetpollFd npfd, OVERLAPPED_ENTRY *entries, int maxentries, DWORD timeoutms);

#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif
#endif /* MRT_NETPOLL_H */
