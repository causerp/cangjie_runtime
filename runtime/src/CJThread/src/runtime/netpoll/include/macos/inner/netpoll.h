// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_NETPOLL_H
#define MRT_NETPOLL_H

#include <pthread.h>
#include "netpoll_common.h"
#include "macro_def.h"

#define MSPERSECOND 1000
#define NSPERMS 1000000

struct NetpollMetaData {
    int kqfd;
};

typedef int FdHandle;
 
typedef void* NetpollFd;
 
NetpollFd NetpollCreate(void);
int NetpollAdd(NetpollFd npfd, int fd, void* data, unsigned int events);
int NetpollDel(NetpollFd npfd, int fd, unsigned int events);
int NetpollWait(NetpollFd npfd, struct kevent* events, int maxevents, int timeoutms);
void NetpollExit(NetpollFd npfd);

#endif /* MRT_NETPOLL_H */
