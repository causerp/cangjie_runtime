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
#include "rawsock.h"

#ifdef __cplusplus
extern "C" {
#endif

int RawsockDisconnect(SignedSocket connFd)
{
    struct sockaddr_storage peerAddr;
    socklen_t peerLen = sizeof(struct sockaddr);
    int ret;
    SchdpollEventType type = SHCDPOLL_WRITE;
 
    ret = memset_s(&peerAddr, sizeof(struct sockaddr_storage), 0, sizeof(struct sockaddr_storage));
    if (ret != 0) {
        return ret;
    }
    peerAddr.ss_family = AF_UNSPEC;
    ret = SchdfdLock(connFd, type);
    if (ret != 0) {
        return ret;
    }
    ret = RawsockConnect(connFd, reinterpret_cast<const struct sockaddr *>(&peerAddr), peerLen, -1);
    bool allowedErr = (errno == EAFNOSUPPORT || errno == ENOENT);
    if (ret != 0 && !allowedErr) {
        LOG_ERROR(ret, "RawsockConnect failed");
        SchdfdUnlock(connFd, type);
        return ret;
    }
    SchdfdUnlock(connFd, type);
    return 0;
}

#ifdef __cplusplus
}
#endif