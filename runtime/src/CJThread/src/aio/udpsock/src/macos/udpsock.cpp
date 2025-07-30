// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include <unistd.h>
#include "log.h"
#include "schdfd_impl.h"
#include "udpsock.h"

#ifdef __cplusplus
extern "C" {
#endif

int UdpsockDisconnect(SignedSocket connFd)
{
    struct sockaddr_storage peerAddr;
    socklen_t peerLen = sizeof(struct sockaddr);
    int ret = 0;

    ret = memset_s(&peerAddr, sizeof(struct sockaddr_storage), 0, sizeof(struct sockaddr_storage));
    if (ret != 0) {
        return ret;
    }
    peerAddr.ss_family = AF_UNSPEC;

    ret = UdpsockConnect(connFd, reinterpret_cast<const struct sockaddr *>(&peerAddr), peerLen);
    if (ret != 0 && errno != EAFNOSUPPORT) {
        LOG_ERROR(ret, "UdpsockConnect failed");
        return ret;
    }
    return 0;
}

int UdpsockDisconnectForIPv6(SignedSocket connFd)
{
    struct sockaddr_in6 peerAddr;
    socklen_t peerLen = sizeof(struct sockaddr_in6);
    int ret = 0;

    ret = memset_s(&peerAddr, sizeof(struct sockaddr_in6), 0, sizeof(struct sockaddr_in6));
    if (ret != 0) {
        return ret;
    }
    peerAddr.sin6_family = AF_UNSPEC;

    ret = UdpsockConnect(connFd, reinterpret_cast<const struct sockaddr *>(&peerAddr), peerLen);
    if (ret != 0 && errno != EAFNOSUPPORT) {
        LOG_ERROR(ret, "UdpsockConnect failed");
        return ret;
    }
    return 0;
}

#ifdef __cplusplus
}
#endif