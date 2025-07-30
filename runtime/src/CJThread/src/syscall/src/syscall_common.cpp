// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include <cstdio>
#include "mrt_syscall.h"
#include "syscall_impl.h"
#ifdef MRT_WINDOWS
#include <ws2tcpip.h>
#else
#include <cstdarg>
#include <fcntl.h>
#include <unistd.h>
#endif  /* MRT_WINDOWS */

#ifdef __cplusplus
extern "C" {
#endif

int SyscallClose(int fd)
{
    int res;
    SyscallEnter();
    res = close(fd);
    SyscallExit();
    return res;
}

/* The caller ensures the legality of the path on their own. */
int SyscallOpen(const char *filename, int flags, unsigned short mode)
{
    int ret;
    SyscallEnter();
    ret = open(filename, flags, mode);
    SyscallExit();
    return ret;
}

int SyscallRead(int fd, void *buf, size_t count)
{
    int res;
    SyscallEnter();
    res = read(fd, buf, count);
    SyscallExit();
    return res;
}

int SyscallWrite(int fd, const void *buf, size_t count)
{
    int res;
    SyscallEnter();
    res = write(fd, buf, count);
    SyscallExit();
    return res;
}

unsigned int SyscallSleep(unsigned int seconds)
{
    unsigned int res;
    SyscallEnter();
    res = sleep(seconds);
    SyscallExit();
    return res;
}

int SyscallUsleep(unsigned int usecs)
{
    int res;
    SyscallEnter();
    res = usleep(usecs);
    SyscallExit();
    return res;
}

int SyscallGetaddrinfo(const char *node, const char *service, const struct addrinfo *hints,
                       struct addrinfo **res)
{
    int ret;
    SyscallEnter();
    ret = getaddrinfo(node, service, hints, res);
    SyscallExit();
    return ret;
}

int SyscallGetnameinfo(const struct sockaddr *sa, socklen_t salen, char *host, socklen_t hostlen,
                       char *serv, socklen_t servlen, int flags)
{
    int ret;
    SyscallEnter();
    ret = getnameinfo(sa, salen, host, hostlen, serv, servlen, flags);
    SyscallExit();
    return ret;
}

void SyscallFreeaddrinfo(struct addrinfo *res)
{
    freeaddrinfo(res);
}

#ifdef __cplusplus
}
#endif