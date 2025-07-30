// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include <unistd.h>
#include "log.h"
#include "sock_impl.h"
#include "schdfd_impl.h"
#include "securec.h"
#include "domainsock.h"

#ifdef __cplusplus
extern "C" {
#endif

int DomainsockDisconnect(SignedSocket connFd)
{
    struct sockaddr_storage peerAddr;
    SchdpollEventType type = SHCDPOLL_WRITE;
    socklen_t peerLen = sizeof(struct sockaddr_storage);
    socklen_t optLen = static_cast<socklen_t>(sizeof(int));
    int ret;
    int opt;
    if (getsockopt(connFd, SOL_SOCKET, SO_TYPE, &opt, &optLen) == -1) {
        ret = errno;
        LOG_ERROR(ret, "getsockopt failed, fd: %d", connFd);
        return ret;
    }
    // Only domain sockets for byte streams can perform a disconnect operation.
    if (opt != SOCK_DGRAM) {
        LOG_ERROR(ERRNO_SOCK_ARG_INVALID, "unix socket type isn't SOCK_DGRAM, fd: %d", connFd);
        return ERRNO_SOCK_ARG_INVALID;
    }
    ret = memset_s(&peerAddr, sizeof(struct sockaddr_storage), 0, sizeof(struct sockaddr_storage));
    if (ret != 0) {
        return ret;
    }
    peerAddr.ss_family = AF_UNSPEC;
    ret = SchdfdLock(connFd, type);
    if (ret != 0) {
        return ret;
    }
    ret = DomainsockConnect(connFd, reinterpret_cast<const struct sockaddr *>(&peerAddr), peerLen, -1);
    if (ret != 0) {
        LOG_ERROR(ret, "DomainsockConnect failed");
        SchdfdUnlock(connFd, type);
        return ret;
    }
    SchdfdUnlock(connFd, type);
    return 0;
}

#ifdef __cplusplus
}
#endif